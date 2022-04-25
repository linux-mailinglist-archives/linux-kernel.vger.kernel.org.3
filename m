Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF8C50E82C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 20:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244392AbiDYS3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 14:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244324AbiDYS2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 14:28:52 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689201C934
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 11:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=raon6o1n2mWAMe09D4AjzbTlxdVFMk7knVRfcBrirjw=; b=XzODElLFHv2MgHG5ZGA5rwAIKN
        x45c8tSttFYYTis22HEHnA9ut1gGTeclIhrkED7AEvkervnt0yhj71keWjg0VyK1Mz0auOELsLoFg
        hdjRHt87hx9Rx3BM9cDaSR2ssxbgM0CozixTxhILycgIM3Rze8wn5PCsDUAQNpL2h2+3Bp5BvDKII
        EKkNizXQf2WvrattrZ+BEzm3n5ggOLbGgd/JRN9pGF8r7wqsDspB/v1nrxbXJldUmirr2uaJEvPB0
        5sP974nMuZF9ITGRP/fSR9dEJRP/zHrAZUPdc+VbTpWA4fFGDotUVxUwfJ7dWVzlJDIXpO4SQRLtd
        pmF+Ik6A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nj3OM-008b8W-QF; Mon, 25 Apr 2022 18:24:59 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id A522C980C21; Mon, 25 Apr 2022 20:24:56 +0200 (CEST)
Date:   Mon, 25 Apr 2022 20:24:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Stephen Zhang <starzhangzsd@gmail.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, laijs@linux.alibaba.com,
        lihuafei1@huawei.com, fenghua.yu@intel.com,
        chang.seok.bae@intel.com, zhangshida@kylinos.cn,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/traps: add CONFIG_BUG to the use of __warn()
Message-ID: <20220425182456.GL2731@worktop.programming.kicks-ass.net>
References: <20220425055935.458583-1-starzhangzsd@gmail.com>
 <7558ae3d-a1fa-6c11-cccd-ad0f65cde25b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7558ae3d-a1fa-6c11-cccd-ad0f65cde25b@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 09:05:17AM -0700, Dave Hansen wrote:
> On 4/24/22 22:59, Stephen Zhang wrote:
> > --- a/arch/x86/kernel/traps.c
> > +++ b/arch/x86/kernel/traps.c
> > @@ -246,7 +246,9 @@ DEFINE_IDTENTRY_ERRORCODE(exc_control_protection)
> >  	pr_err("Missing ENDBR: %pS\n", (void *)instruction_pointer(regs));
> >  	if (!ibt_fatal) {
> >  		printk(KERN_DEFAULT CUT_HERE);
> > +#ifdef CONFIG_BUG
> >  		__warn(__FILE__, __LINE__, (void *)regs->ip, TAINT_WARN, regs, NULL);
> > +#endif
> 
> This really should be done with an #ifdef'd stub in in bug.h, not an
> #ifdef at every call site.  I assume there was a good reason for not
> using the normal WARN*() macros.

I think the idea was to have the pr_err() unconditional, and if you have
the fancy crap on also print a full backtrace or something.

But yeah, a few stubs in bug.h ought to make this go away too.

