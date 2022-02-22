Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09AB84C0292
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 20:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235345AbiBVT7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 14:59:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbiBVT65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 14:58:57 -0500
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D6781DE2D8;
        Tue, 22 Feb 2022 11:58:30 -0800 (PST)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1nMbIs-0006bB-00; Tue, 22 Feb 2022 20:58:30 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 9ABD8C26B8; Tue, 22 Feb 2022 20:58:06 +0100 (CET)
Date:   Tue, 22 Feb 2022 20:58:06 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-mips <linux-mips@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MIPS: Handle address errors for accesses above CPU max
 virtual user address
Message-ID: <20220222195806.GA17107@alpha.franken.de>
References: <20220222155345.138861-1-tsbogend@alpha.franken.de>
 <CAK8P3a0QV7y_gFv=VHGKVWjXyYmFFZRrXj3m52d21Fyydib4NQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0QV7y_gFv=VHGKVWjXyYmFFZRrXj3m52d21Fyydib4NQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 06:04:07PM +0100, Arnd Bergmann wrote:
> On Tue, Feb 22, 2022 at 4:53 PM Thomas Bogendoerfer
> <tsbogend@alpha.franken.de> wrote:
> >
> > Address errors have always been treated as unaliged accesses and handled
> > as such. But address errors are also issued for illegal accesses like
> > user to kernel space or accesses outside of implemented spaces. This
> > change implements Linux exception handling for accesses to the illegal
> > space above the CPU implemented maximum virtual user address and the
> > MIPS 64bit architecture maximum. With this we can now use a fixed value
> > for the maximum task size on every MIPS CPU and get a more optimized
> > access_ok().
> >
> > Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> 
> Thank you for addressing this. Should I add this patch to my series
> ahead of "mips: use simpler access_ok()"? That way I can keep it all
> in my asm-generic tree as a series for 5.18.

yes please add it to your series.

> >  arch/mips/kernel/unaligned.c | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >
> > diff --git a/arch/mips/kernel/unaligned.c b/arch/mips/kernel/unaligned.c
> > index df4b708c04a9..7b5aba5df02e 100644
> > --- a/arch/mips/kernel/unaligned.c
> > +++ b/arch/mips/kernel/unaligned.c
> > @@ -1480,6 +1480,23 @@ asmlinkage void do_ade(struct pt_regs *regs)
> >         prev_state = exception_enter();
> >         perf_sw_event(PERF_COUNT_SW_ALIGNMENT_FAULTS,
> >                         1, regs, regs->cp0_badvaddr);
> > +
> > +#ifdef CONFIG_64BIT
> > +       /*
> > +        * check, if we are hitting space between CPU implemented maximum
> > +        * virtual user address and 64bit maximum virtual user address
> > +        * and do exception handling to get EFAULTs for get_user/put_user
> > +        */
> > +       if ((regs->cp0_badvaddr >= (1UL << cpu_vmbits)) &&
> > +           (regs->cp0_badvaddr < XKSSEG)) {
> 
> It might be clearer to use TASK_SIZE_MAX here instead of XKSSEG,
> to match the check in access_ok(). If you like, I can change that while
> applying.

I had TASK_SIZE_MAX in an intermediate version, but decided to go with XKSSEG,
because it's what this check is about. It's about checking what the MIPS
architecture defined.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
