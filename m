Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1FF52EFC6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 17:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347853AbiETPzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 11:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351178AbiETPzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 11:55:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A1F17997B
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 08:55:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3F0B8B82A99
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 15:55:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DE32C385A9;
        Fri, 20 May 2022 15:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653062135;
        bh=5pO45moyyIVgVcTWg/RaTI8rK+yUVXoaRbnE2GeHee4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U3mQ39jZabGwP9jqo5q7erJdOcZkln3usEty3tR9OZCjXsCX494lXwcbaYKSVGJto
         GKsuERPs95XEw/Pjvn4ys+Bdw1Mt8wmbREtH8spsTRuepkQyA3Pzp9bClcf05TyOpE
         10oAg7VbHFhpAfIpf9lh/Gk49FVYXlOxfrOz4QrQ15uSOxmA65pZG1lV37V4+cP1GL
         /puH7kl6gHuR8YA9T5e+EJl0zP/rnddpGIMbs0uZ0a/ixmytQ649Vgu7f0A+zRsWcD
         bVvOzx6GvgNh/JmSfjTNiaSmI5gtXPvyVqGjNbjwWWn5F3AY2yUO2Ze7lzgtMyLi5R
         16GinMyO33x6g==
Date:   Fri, 20 May 2022 08:55:33 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Guenter Roeck <linux@roeck-us.net>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Brian Gerst <brgerst@gmail.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH 3/6] x86/entry: Use PUSH_AND_CLEAR_REGS for compat
Message-ID: <20220520155533.qke6e3m2tl5lk6xo@treble>
References: <20220506121431.563656641@infradead.org>
 <20220506121631.293889636@infradead.org>
 <20220519162411.GA4095576@roeck-us.net>
 <20220519170009.GL2578@worktop.programming.kicks-ass.net>
 <20220519171129.enw32izjhxsqc2xm@treble>
 <20220519173538.nywtw2h3y7sqfojn@treble>
 <CAJhGHyC0sztc2_jTT+U1M2+OSNxfNgmaKJyZgySwYqKM06q7hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJhGHyC0sztc2_jTT+U1M2+OSNxfNgmaKJyZgySwYqKM06q7hg@mail.gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 09:11:55AM +0800, Lai Jiangshan wrote:
> On Fri, May 20, 2022 at 1:35 AM Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> >
> > diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
> > index ed2be3615b50..f76e674d22c4 100644
> > --- a/arch/x86/entry/entry_64_compat.S
> > +++ b/arch/x86/entry/entry_64_compat.S
> > @@ -200,7 +200,7 @@ SYM_INNER_LABEL(entry_SYSCALL_compat_safe_stack, SYM_L_GLOBAL)
> >  SYM_INNER_LABEL(entry_SYSCALL_compat_after_hwframe, SYM_L_GLOBAL)
> >         movl    %eax, %eax              /* discard orig_ax high bits */
> >         pushq   %rax                    /* pt_regs->orig_ax */
> > -       PUSH_AND_CLEAR_REGS rax=$-ENOSYS
> > +       PUSH_AND_CLEAR_REGS rcx=%rbp rax=$-ENOSYS
> 
> Some comments need to be here to explain why %rcx is stashed in %rbp.
> 
> The code doing the stash in userspace may be in
> arch/x86/entry/vdso/vdso32/system_call.S (see SYSCALL_SEQUENCE)

I do agree a comment would be good, but looking at that maze, I'm not
sure I'm qualified to give it a proper one ;-)

My best theory is: __kernel_vsyscall() stashes CX in BP before SYSCALL
can overwrite it, because SYSCALL uses CX to stash the return address.
And then PUSH_AND_CLEAR_REGS puts the original CX value back in pt_regs,
because CX is (presumably?) a syscall function argument.

My patch description said that CX must have gotten corrupted in user
space, but that's wrong because __kernel_vsyscall() pushes/pops CX
around the SYSCALL.

But alas it's too late to fix the commit log because it's already been
committed and the tip maintainers are getting pull requests ready for
the merge window.

-- 
Josh
