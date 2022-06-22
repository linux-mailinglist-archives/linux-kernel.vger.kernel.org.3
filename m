Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB47554C1E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 16:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355402AbiFVOEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 10:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345399AbiFVOEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 10:04:11 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C8EF58D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 07:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=3ENuE7ZIyq9YkE5vwMgxUVDePxbUMaFRu0H/WNcpiNg=; b=uIvvUh8unc6lyoAZCEJKRvG+L8
        +fNcE3us301CT1YpI0qhy6qah/kSoll3KuQ5q5Y/c9BgAfgBDoEvxJw1CQivqHijv0lreIpg1cRaP
        2xCXm0sWnW7rL/8jrpHHErn7yU0oVbeGodMTb9M8wXagY+onNXF77/feKw2bBnR9Gs7jc3czW03a4
        snKOJsRVIOlfTzd8ZFAXcVBQH/p7+8mS8kQ4SMLe3vC6DxroSRSrwJlUFU3QsRAFuUHfzOSEUvI2N
        AHeCEURQSw//43zTmdzSUoMMilz9B9RFRB0IpqQ0kwBLrOYTk/kvi3SDYEjVf8fZi7Evq0V896ifa
        szoAjKuQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:32984)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1o40xi-0003fA-AW; Wed, 22 Jun 2022 15:04:05 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1o40xh-0007U0-0L; Wed, 22 Jun 2022 15:04:05 +0100
Date:   Wed, 22 Jun 2022 15:04:04 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Tony Lindgren <tony@atomide.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] ARM: spectre-v2: fix smp_processor_id() warning
Message-ID: <YrMhVAev9wMAA8tl@shell.armlinux.org.uk>
References: <795c9463-452e-bf64-1cc0-c318ccecb1da@I-love.SAKURA.ne.jp>
 <e5bdea6c767d3a8260360afaddab5f7c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5bdea6c767d3a8260360afaddab5f7c@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 02:50:15PM +0100, Marc Zyngier wrote:
> On 2022-06-22 07:49, Tetsuo Handa wrote:
> > syzbot complains smp_processor_id() from harden_branch_predictor()
> >  from page fault path [1]. Explicitly disable preemption and use
> > raw_smp_processor_id().
> > 
> > Link: https://syzkaller.appspot.com/bug?extid=a7ee43e564223f195c84 [1]
> > Reported-by: syzbot
> > <syzbot+a7ee43e564223f195c84@syzkaller.appspotmail.com>
> > Fixes: f5fe12b1eaee220c ("ARM: spectre-v2: harden user aborts in kernel
> > space")
> > Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> > ---
> > This patch is completely untested.
> > 
> >  arch/arm/include/asm/system_misc.h | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm/include/asm/system_misc.h
> > b/arch/arm/include/asm/system_misc.h
> > index 98b37340376b..a92446769acd 100644
> > --- a/arch/arm/include/asm/system_misc.h
> > +++ b/arch/arm/include/asm/system_misc.h
> > @@ -20,8 +20,11 @@ typedef void (*harden_branch_predictor_fn_t)(void);
> >  DECLARE_PER_CPU(harden_branch_predictor_fn_t,
> > harden_branch_predictor_fn);
> >  static inline void harden_branch_predictor(void)
> >  {
> > -	harden_branch_predictor_fn_t fn = per_cpu(harden_branch_predictor_fn,
> > -						  smp_processor_id());
> > +	harden_branch_predictor_fn_t fn;
> > +
> > +	preempt_disable_notrace();
> > +	fn = per_cpu(harden_branch_predictor_fn, raw_smp_processor_id());
> > +	preempt_enable_no_resched_notrace();
> >  	if (fn)
> >  		fn();
> >  }
> 
> I don't think that's required.
> 
> harden_branch_predictor() is always called on the fault path,
> from __do_user_fault(), and that's always non-preemptible.
> 
> My hunch is that we're missing some tracking that indicates
> to the kernel that we're already non-preemptible by virtue
> of being in an exception handler.
> 
> Russell, what do you think?

There is one path that we can hit this while we're preemptible - a
page fault (handled via do_page_fault) at an address in kernel space
triggered by user space (e.g. userspace trying to access vmalloc or
module space). 

I suppose, since we know that's never going to be fixed up, we could
detect that the address >= TASK_SIZE and we're entering from usespace
before enabling interrupts, and do the hardening early in that path.
We'd need to move the other cases where we call the hardening as well.

The down side is more tests in the page fault fast-path... so there
will be a performance penalty to be paid just to shut up this warning -
a warning that is "userspace is trying to do real bad stuff" that
basically means userspace is trying to run an exploit...

Which makes me think... having the loud complaint from the kernel there
is actually a good thing, it makes people sit up and notice that
something is wrong.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
