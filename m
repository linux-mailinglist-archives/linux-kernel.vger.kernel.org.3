Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8A85ADA65
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 22:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbiIEUtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 16:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiIEUti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 16:49:38 -0400
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EB3D612AB5
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 13:49:36 -0700 (PDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 285Kh2e6003034;
        Mon, 5 Sep 2022 15:43:03 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 285Kh1Aa003033;
        Mon, 5 Sep 2022 15:43:01 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Mon, 5 Sep 2022 15:43:00 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "aik@ozlabs.ru" <aik@ozlabs.ru>,
        "chenzhongjin@huawei.com" <chenzhongjin@huawei.com>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        Sathvika Vasireddy <sv@linux.ibm.com>
Subject: Re: [PATCH v2 16/16] objtool/powerpc: Add --mcount specific implementation
Message-ID: <20220905204300.GC25951@gate.crashing.org>
References: <20220829055223.24767-1-sv@linux.ibm.com> <20220829055223.24767-17-sv@linux.ibm.com> <5da86617-53f1-d899-336a-53fe691e76ae@csgroup.eu> <20220831175100.GS25951@gate.crashing.org> <1662374555.7eoowv9twf.naveen@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1662374555.7eoowv9twf.naveen@linux.ibm.com>
User-Agent: Mutt/1.4.2.3i
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Mon, Sep 05, 2022 at 04:15:07PM +0530, Naveen N. Rao wrote:
> Segher Boessenkool wrote:
> >>> +		if ((insn & 3) == 1) {
> >>> +			*type = INSN_CALL;
> >>> +			*immediate = insn & 0x3fffffc;
> >>> +			if (*immediate & 0x2000000)
> >>> +				*immediate -= 0x4000000;
> >>> +		}
> >>> +		break;
> >>> +	}
> >
> >Does this handle AA=1 correctly at all?  That is valid both with and
> >without relocations, just like AA=0.  Same for AA=1 LK=0 btw.
> >
> >If you only handle AA=0, the code should explicitly test for that.
> 
> The code does test for AA=0 LK=1 with the if statement there?

Yes, but that is not what I said :-)

It may be fine to not *handle* AA=1 at all, but the code should at least
scream bloody murder when it encounters it anyway :-)


Segher
