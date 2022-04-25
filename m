Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC0A850E193
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 15:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239190AbiDYN2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 09:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235491AbiDYN2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 09:28:36 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1EB3B28F
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 06:25:30 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-2f7ca2ce255so48535537b3.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 06:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yca3xmixVHHmgbrnSSzF4WQGMIJjftZCU3Ude+yzL3A=;
        b=VAh4U6EgDSbjHS1tm0LmhAb7SLC0cTmUcD3X72IhHzmnOU/rX1cmcEvXonR2eMfm/p
         n2jjHXdh8KEyEEIkAZA9g/A/6wy44MIruOP5Q45A0rDe7w7O+kZWNaEY7Os+HMrBmA0I
         zlen3tQnO1lTLKS+afM4HZkkaRev+yiAX2m6idPQUAx7lcfKkdwq12LlY1TSCB2G67Lg
         GapA+lfo6y/794QnPnQLa6ATVPG4Cku1VE0uEsDeFXbLGRNG9W0lpgSh0JTKPM+jMqTh
         sIRodoef8ew8e5+YJzYuVhb7ck3TGEPsz35UIpFbzVFWvNg5wdej7NkIE/ADjrIfImqO
         oj1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yca3xmixVHHmgbrnSSzF4WQGMIJjftZCU3Ude+yzL3A=;
        b=B0r4ANK7a3ymKYDz73Bn73x3dHZUXjMM6ogCMvVQIs3Dz0ixX99xmEKJFuKQK9dJ1m
         HsaxRrvMG9e5SG5exGpxjOtCbozj0IVV0ND14zJFWrDboCKpEiERlSBdSt3Eh0P7pX6P
         sjb+8hhEcS7xOoQQiwgewmmUe9yS44lHzPK83A51Qb/Fxj9RIKG5ipclW3RoKIr8t8e+
         TA13BwalHoIqkYd6bHWkHzKQSYcY+kA2E1u4NZ21Tbex1GawlG7yWAu6uLszH0ihCXBZ
         kbFDr9lmdB0B3GUS9e7Z0HAu3zhRov8ATQNc4G+1u8lD8LaQiOa6cKn/NqHgZW3Yh+pq
         qFRA==
X-Gm-Message-State: AOAM532v6pE8ljAU7vR1oBCi0zRudA+KLnyQ2HqIRTyvn2r96mLvKJgj
        unEng/bNp/IvLOhflpYj++LAKi++pQCGcZkA19YgNN+1Ol4=
X-Google-Smtp-Source: ABdhPJylWM7iw22LFeRiqNwHfwEP8QEUUfaG+kO3AJmewryjt+YTorUpKYTVIiWiLutTohh1GRDigWBF+G6W12zMPAc=
X-Received: by 2002:a0d:cb41:0:b0:2f7:d205:9c99 with SMTP id
 n62-20020a0dcb41000000b002f7d2059c99mr8111565ywd.417.1650893129651; Mon, 25
 Apr 2022 06:25:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220412121541.4595-1-jiangshanlai@gmail.com> <20220412121541.4595-8-jiangshanlai@gmail.com>
 <877d7d31fq.ffs@tglx>
In-Reply-To: <877d7d31fq.ffs@tglx>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Mon, 25 Apr 2022 21:25:18 +0800
Message-ID: <CAJhGHyAuu6RN-uFsu8XocFLewX1M=c7e+K948meobndXV5PLYQ@mail.gmail.com>
Subject: Re: [PATCH V5 7/7] x86/entry: Use idtentry macro for entry_INT80_compat
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <jroedel@suse.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 6:24 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Tue, Apr 12 2022 at 20:15, Lai Jiangshan wrote:
> > From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> >
> > entry_INT80_compat is identical to idtentry macro except a special
> > handling for %rax in the prolog.
>
> Seriously?
>
> > -     pushq   %rsi                    /* pt_regs->si */
> > -     xorl    %esi, %esi              /* nospec   si */
>
> esi is not cleared in CLEAR_REGS. So much for identical.
>
>

Hello, Thomas

Thank you for the review.

They (the old entry_INT80_compat() and the new using the macro
idtentry) are not identical in ASM code.

The macro idtentry pushes %rsi to the entry stack and then copies
it from the entry stack to the kernel stack and then switches
the stack.

The original entry_INT80_compat() is much more straightforward
and efficient.  It switches the stack as soon as possible and
then pushes %rsi directly onto the kernel stack.

So they are different in this aspect.

I compared the macro idtentry and the original entry_INT80_compat(),
to check if the macro idtentry has all the behaviors that the INT80
thing has and check if what the macro idtentry has but the INT80
thing doesn't is a No-op (like the handling of bad IRET).

In my view, the checks don't fail my expectations except for
regs->ax and regs->orig_ax.

As for CLEAR_REGS, I also have reviewed it many times.  To me, it
equals clearing all registers although it doesn't clear ax, sp,
di, si.  In the comments, it says

   The lower registers are likely clobbered well before they could
   be put to use in a speculative execution gadget.

When using CLEAR_REGS for the INT80 thing, the %rsi will be cleared
explicitly when syscall_enter_from_user_mode() which has 2 arguments
is called.

"identical" is overstated. I will change the changelog to say their
behaviors are almost similar and the final result are the same when
the macro idtentry has the prolog.

Thanks
Lai
