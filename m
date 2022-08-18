Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDA55981F1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 13:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244270AbiHRLGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 07:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244261AbiHRLGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 07:06:35 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B270A0633
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 04:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JAOa0ChfVERJUOWkiQMYGLUFzmPebbpTN+VwHYZPi1Q=; b=Ucg1cqy5nlngkHQkEENC9fUkGt
        /zPDGPsdZ38a59wU6mokbUsI+YMD7XqoC8yswH/CGx9l9XLkbz/jpLwBsJk5XKPIb2FMUkPRUFD10
        w6jk19/4MqSRwmCCAmGQdfoaelpmYt2dHVRVGNk6HnpkBFtfvxvzWuZGyE8kwWwONqRxpe/U3PmbK
        M7hawhspHNH9BlwqbxCaiRRIvOXWHkzQeDvzeluR1HNe+rAr1f+u3zElainsoKAWf9466rerbcdaG
        Nea3WAheaxSIKJ7VqziU7eH/8q4tBtHWsRdgDVniiNnUdP7S4fsZJkuKv3vKTpVWB96QoFVD8J6Ai
        fNnriTdw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oOdLt-003Z3d-6q; Thu, 18 Aug 2022 11:06:18 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id BD27B980147; Thu, 18 Aug 2022 13:06:16 +0200 (CEST)
Date:   Thu, 18 Aug 2022 13:06:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Pengfei Xu <pengfei.xu@intel.com>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Su, Heng" <heng.su@intel.com>, linux-kernel@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>, pbonzini@redhat.com,
        x86@kernel.org
Subject: Re: [PATCH] x86/kvm, objtool: Avoid fastop ENDBR from being sealed
Message-ID: <Yv4dKABja9CxqcDS@worktop.programming.kicks-ass.net>
References: <PH0PR11MB4839B4D2FB8B8D8D52A62C7F9A629@PH0PR11MB4839.namprd11.prod.outlook.com>
 <YvzJTxOwmikAlZ6j@worktop.programming.kicks-ass.net>
 <20220818011045.v4baekgxajylqxvh@treble>
 <Yv3qHNGBM2aU2NuA@worktop.programming.kicks-ass.net>
 <Yv3sha0zujQxW1X8@xpf.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yv3sha0zujQxW1X8@xpf.sh.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 03:38:45PM +0800, Pengfei Xu wrote:
>   And this "Missing ENDBR: andw_ax_dx+0x0/0x10 [kvm]" issue was
>   reproduced again after ran syzkaller 5min on ADL-P.

Ha, indeed :/

> > > +/*
> > > + * Create a dummy function pointer reference to prevent objtool from marking
> > > + * the function as needing to be "sealed" (i.e. ENDBR converted to NOP by
> > > + * apply_ibt_endbr()).
> > > + */
> > > +#define IBT_NOSEAL(fname)				\
> > > +	".pushsection .discard.endbr.noseal\n\t"	\
> > > +	_ASM_PTR fname "\n\t"				\
> > > +	".popsection\n\t"
> > > +

objtool/check.c:validate_ibt():

                if (!strncmp(sec->name, ".discard", 8)                  ||
		    ...)
		    continue;

So yeah, that'll just get ignored. So at the very least we need to
special case this section.
