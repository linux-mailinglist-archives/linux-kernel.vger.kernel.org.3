Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5DF5504E4
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 14:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236121AbiFRMwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 08:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236061AbiFRMwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 08:52:35 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EDDB417E23
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 05:52:33 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B43C5113E;
        Sat, 18 Jun 2022 05:52:33 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.35.139])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1F5253F792;
        Sat, 18 Jun 2022 05:52:28 -0700 (PDT)
Date:   Sat, 18 Jun 2022 13:52:24 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Tong Tiangen <tongtiangen@huawei.com>
Cc:     James Morse <james.morse@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Kefeng Wang <wangkefeng.wang@huawei.com>,
        Xie XiuQi <xiexiuqi@huawei.com>,
        Guohanjun <guohanjun@huawei.com>
Subject: Re: [PATCH -next v5 6/8] arm64: add support for machine check error
 safe
Message-ID: <Yq3KiDN87pd6mg+m@FVFF77S0Q05N>
References: <20220528065056.1034168-1-tongtiangen@huawei.com>
 <20220528065056.1034168-7-tongtiangen@huawei.com>
 <YqxBd9GfUHLWZWoh@FVFF77S0Q05N>
 <4aa8b109-c79b-8da0-db89-85ca128f1049@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4aa8b109-c79b-8da0-db89-85ca128f1049@huawei.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 18, 2022 at 05:18:55PM +0800, Tong Tiangen wrote:
> 在 2022/6/17 16:55, Mark Rutland 写道:
> > On Sat, May 28, 2022 at 06:50:54AM +0000, Tong Tiangen wrote:
> > > +static bool arm64_do_kernel_sea(unsigned long addr, unsigned int esr,
> > > +				     struct pt_regs *regs, int sig, int code)
> > > +{
> > > +	if (!IS_ENABLED(CONFIG_ARCH_HAS_COPY_MC))
> > > +		return false;
> > > +
> > > +	if (user_mode(regs) || !current->mm)
> > > +		return false;
> > 
> > What's the `!current->mm` check for?
> 
> At first, I considered that only user processes have the opportunity to
> recover when they trigger memory error.
> 
> But it seems that this restriction is unreasonable. When the kernel thread
> triggers memory error, it can also be recovered. for instance:
> 
> https://lore.kernel.org/linux-mm/20220527190731.322722-1-jiaqiyan@google.com/
> 
> And i think if(!current->mm) shoud be added below:
> 
> if(!current->mm) {
> 	set_thread_esr(0, esr);
> 	arm64_force_sig_fault(...);
> }
> return true;

Why does 'current->mm' have anything to do with this, though?

There can be kernel threads with `current->mm` set in unusual circumstances
(and there's a lot of kernel code out there which handles that wrong), so if
you want to treat user tasks differently, we should be doing something like
checking PF_KTHREAD, or adding something like an is_user_task() helper.

[...]

> > > +
> > > +	if (apei_claim_sea(regs) < 0)
> > > +		return false;
> > > +
> > > +	if (!fixup_exception_mc(regs))
> > > +		return false;
> > 
> > I thought we still wanted to signal the task in this case? Or do you expect to
> > add that into `fixup_exception_mc()` ?
> 
> Yeah, here return false and will signal to task in do_sea() ->
> arm64_notify_die().

I mean when we do the fixup.

I thought the idea was to apply the fixup (to stop the kernel from crashing),
but still to deliver a fatal signal to the user task since we can't do what the
user task asked us to.

> > > +
> > > +	set_thread_esr(0, esr);
> > 
> > Why are we not setting the address? Is that deliberate, or an oversight?
> 
> Here set fault_address to 0, i refer to the logic of arm64_notify_die().
> 
> void arm64_notify_die(...)
> {
>          if (user_mode(regs)) {
>                  WARN_ON(regs != current_pt_regs());
>                  current->thread.fault_address = 0;
>                  current->thread.fault_code = err;
> 
>                  arm64_force_sig_fault(signo, sicode, far, str);
>          } else {
>                  die(str, regs, err);
>          }
> }
> 
> I don't know exactly why and do you know why arm64_notify_die() did this? :)

To be honest, I don't know, and that looks equally suspicious to me.

Looking at the git history, that was added in commit:

  9141300a5884b57c ("arm64: Provide read/write fault information in compat signal handlers")

... so maybe Catalin recalls why.

Perhaps the assumption is just that this will be fatal and so unimportant? ...
but in that case the same logic would apply to the ESR value, so it's not clear
to me.

Mark.
