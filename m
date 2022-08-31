Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3A6D5A84D8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 19:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbiHaR5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 13:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbiHaR5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 13:57:41 -0400
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8CB26D740D
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 10:57:40 -0700 (PDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 27VHp22H007556;
        Wed, 31 Aug 2022 12:51:02 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 27VHp1O9007550;
        Wed, 31 Aug 2022 12:51:01 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Wed, 31 Aug 2022 12:51:00 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Sathvika Vasireddy <sv@linux.ibm.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "aik@ozlabs.ru" <aik@ozlabs.ru>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "naveen.n.rao@linux.vnet.ibm.com" <naveen.n.rao@linux.vnet.ibm.com>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "chenzhongjin@huawei.com" <chenzhongjin@huawei.com>
Subject: Re: [PATCH v2 16/16] objtool/powerpc: Add --mcount specific implementation
Message-ID: <20220831175100.GS25951@gate.crashing.org>
References: <20220829055223.24767-1-sv@linux.ibm.com> <20220829055223.24767-17-sv@linux.ibm.com> <5da86617-53f1-d899-336a-53fe691e76ae@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5da86617-53f1-d899-336a-53fe691e76ae@csgroup.eu>
User-Agent: Mutt/1.4.2.3i
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 12:50:07PM +0000, Christophe Leroy wrote:
> Le 29/08/2022 à 07:52, Sathvika Vasireddy a écrit :
> > +	opcode = insn >> 26;
> > +
> > +	switch (opcode) {
> > +	case 18: /* bl */
> 
> case 18 is more than 'bl', it includes also 'b'.
> In both cases, the calculation of *immediate is the same.

It also is "ba" and "bla", sometimes written as "b[l][a]".

> It would therefore be more correct to perform the calculation and setup 
> of *immediate outside the 'if ((insn & 3) == 1)', that would avoid 
> unnecessary churn the day we add support for branches without link.
> 
> > +		if ((insn & 3) == 1) {
> > +			*type = INSN_CALL;
> > +			*immediate = insn & 0x3fffffc;
> > +			if (*immediate & 0x2000000)
> > +				*immediate -= 0x4000000;
> > +		}
> > +		break;
> > +	}

Does this handle AA=1 correctly at all?  That is valid both with and
without relocations, just like AA=0.  Same for AA=1 LK=0 btw.

If you only handle AA=0, the code should explicitly test for that.


Segher
