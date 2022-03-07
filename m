Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82EE24D0198
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 15:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243328AbiCGOkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 09:40:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiCGOkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 09:40:40 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8518765D38
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 06:39:46 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id z30so18536114ybi.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 06:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qxDxqcUxUgfTZXL3W1PtB8IV3aXrMPJv6j/2tRBi/VA=;
        b=JJcwQJlIoBwpExHekBsAx66ZFRUkhyk6AY2/X7uB/wiACCq7QvNZkBmYs+rMvXFeuI
         zPLR0jaM9e70cUtpo3Rf995w+Ck0XO1Ikt0S6pEx0miTuJeNGfxoAgpHw6mAM+qhdvM9
         hTDM1SmBcCWzzozJhbXl4FZs6Vd6NcILmoYISDGPhvWAOy+THDEhjvHXl5aLcTIkVEZB
         FUeEU8CeLiQl3hTT9DZ26H1ZrrfwqHxjWQljZHoy02zdHdNWDeIZEUY+yqFQX5QrcSnL
         qO7YC4spWLmzdrPgK2F50zC0UCmX8LINRfXVDei30S+5t94G8ZDjcU10rLAA1DMfY3mA
         SLeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qxDxqcUxUgfTZXL3W1PtB8IV3aXrMPJv6j/2tRBi/VA=;
        b=IsnRfVvosF6BuVQGZicAU97gzPjekJZJ1Qkt/Xp0yhGp0O9SPmnNU3PgJfTES43lVC
         kfQp6MpfH+0Rfl5P5HuwWV3J2NwBm9ehPEi5/Kp1E880KZqYEczJE+UIjeS7Ji8UIkmX
         HOnZ/qg0a69LNJKg5cVwGU1jyk7AtfpRr7Y9wp5GNaKzpu1XmCSLgYfZ7Ujw6ct1eXY9
         MeaLY4pwsGf85rc+w7iteFj3O8lqd74lGJnENuopiqwKAFogIkVLrbDdCkjf5fHYbTdE
         NdFV3X7rMB+NFoC9rg/PZWvMy8NzSYhBg8rAqlOpxImz2tBC+S5o8fsqdPvQ/5ZPs/25
         WGRA==
X-Gm-Message-State: AOAM531smLEiAaUegBUGq/R90Vtko8qzcuJaGnjlqm7Mj1CLSeOHou2M
        OzuTR56BFxXuKBQ+3UhEXLhXyKu4//fVPYei4gI=
X-Google-Smtp-Source: ABdhPJyCARw9APGUVw7JwAEP+2YYc2XIMgklqX7fEXM2ceND0AYm+S9gdx7kbLiiXtRLwPbvvC4Ez47XAyeQ0OMw8Oo=
X-Received: by 2002:a5b:1c5:0:b0:628:d711:7245 with SMTP id
 f5-20020a5b01c5000000b00628d7117245mr8074654ybp.376.1646663985759; Mon, 07
 Mar 2022 06:39:45 -0800 (PST)
MIME-Version: 1.0
References: <20220303035434.20471-1-jiangshanlai@gmail.com>
 <20220303035434.20471-3-jiangshanlai@gmail.com> <YiB1kC7rzwoIQiL4@hirez.programming.kicks-ass.net>
In-Reply-To: <YiB1kC7rzwoIQiL4@hirez.programming.kicks-ass.net>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Mon, 7 Mar 2022 22:39:33 +0800
Message-ID: <CAJhGHyBh3Ley20+_c=jxrxCq+h1OzTshw+QnEVawiTFOUkSx=A@mail.gmail.com>
Subject: Re: [PATCH V2 2/7] x86/entry: Switch the stack after error_entry() returns
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 3, 2022 at 4:00 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Mar 03, 2022 at 11:54:29AM +0800, Lai Jiangshan wrote:
> > From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> >
> > error_entry() calls sync_regs() to settle/copy the pt_regs and switches
> > the stack directly after sync_regs().  But error_entry() itself is also
> > a function call, the switching has to handle the return address of it
> > together, which causes the work complicated and tangly.
> >
> > Switching to the stack after error_entry() makes the code simpler and
> > intuitive.
> >
> > Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> > ---
> >  arch/x86/entry/entry_64.S | 16 ++++++----------
> >  1 file changed, 6 insertions(+), 10 deletions(-)
> >
> > diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> > index 24846284eda5..a51cad2b7fff 100644
> > --- a/arch/x86/entry/entry_64.S
> > +++ b/arch/x86/entry/entry_64.S
> > @@ -323,6 +323,8 @@ SYM_CODE_END(ret_from_fork)
> >  .macro idtentry_body cfunc has_error_code:req
> >
> >       call    error_entry
> > +     movq    %rax, %rsp                      /* switch stack settled by sync_regs() */
> > +     ENCODE_FRAME_POINTER
> >       UNWIND_HINT_REGS
> >
> >       movq    %rsp, %rdi                      /* pt_regs pointer into 1st argument*/
> > @@ -980,14 +982,10 @@ SYM_CODE_START_LOCAL(error_entry)
> >       /* We have user CR3.  Change to kernel CR3. */
> >       SWITCH_TO_KERNEL_CR3 scratch_reg=%rax
> >
> > +     leaq    8(%rsp), %rdi                   /* arg0 = pt_regs pointer */
> >  .Lerror_entry_from_usermode_after_swapgs:
> >       /* Put us onto the real thread stack. */
> > -     popq    %r12                            /* save return addr in %12 */
> > -     movq    %rsp, %rdi                      /* arg0 = pt_regs pointer */
> >       call    sync_regs
> > -     movq    %rax, %rsp                      /* switch stack */
> > -     ENCODE_FRAME_POINTER
> > -     pushq   %r12
> >       RET
> >
> >       /*
> > @@ -1019,6 +1017,7 @@ SYM_CODE_START_LOCAL(error_entry)
> >        */
> >  .Lerror_entry_done_lfence:
> >       FENCE_SWAPGS_KERNEL_ENTRY
> > +     leaq    8(%rsp), %rax                   /* return pt_regs pointer */
> >       RET
> >
> >  .Lbstep_iret:
> > @@ -1039,12 +1038,9 @@ SYM_CODE_START_LOCAL(error_entry)
> >        * Pretend that the exception came from user mode: set up pt_regs
> >        * as if we faulted immediately after IRET.
> >        */
> > -     popq    %r12                            /* save return addr in %12 */
> > -     movq    %rsp, %rdi                      /* arg0 = pt_regs pointer */
> > +     leaq    8(%rsp), %rdi                   /* arg0 = pt_regs pointer */
> >       call    fixup_bad_iret
> > -     mov     %rax, %rsp
> > -     ENCODE_FRAME_POINTER
> > -     pushq   %r12
> > +     mov     %rax, %rdi
> >       jmp     .Lerror_entry_from_usermode_after_swapgs
> >  SYM_CODE_END(error_entry)
>
> I can't seem to follow; perhaps I need more wake-up-juice?
>
> Suppose we have .Lerror_bad_iret, then the code flow is something like:
>
>
>         old                                             new
>
> .Lerror_bad_iret
>                                 SWAWPGS business
>
>         popq    %r12                                    leaq    8(%rsp), %rsi
>         movq    %rsp, %rdi
>         call    fixup_bad_iret                          call    fixup_bad_iret
>         mov     %rax, %rsp                              mov     %rax, %rdi
>         ENCODE_FRAME_POINTER
>         pushq   %r12
>
>                 jmp     .Lerror_entry_from_usermode_after_swapgs
>
> .Lerror_entry_from_usermode_after_swapgs
>         pop     %r12
>         movq    %rsp, %rdi
>         call    sync_regs                               call    sync_regs
>         mov     %rax, %rsp
>         ENCODE_FRAME_POINTER
>         push    %r12
>         RET                                             RET
>
>
> The thing that appears to me is that syn_regs is called one stack switch
> short. This isn't mentioned in the Changelog nor in the comments. Why is
> this OK?
>
>

I has not been confident enough with the meaning of "short" or
"call short" in my understanding of English.

So I tried hard to find the semantic difference between the code
before and after the patch.

The logic are the same:
  1) feed fixup_bad_iret() with the pt_regs pushed by ASM code
  2) fixup_bad_iret() moves the partial pt_regs up
  3) feed sync_regs() with the pt_regs returned by fixup_bad_iret()
  4) sync_regs() copies the whole pt_regs to kernel stack if needed
  5) after error_entry(), it is in kernel stack with the pt_regs

Differences:
  Old code switches to copied pt_regs immediately twice in
  error_entry() while new code switches to the copied pt_regs only
  once after error_entry() returns.
  It is correct since sync_regs() doesn't need to be called close
  to the pt_regs it handles.  And this is the point of this
  patch which switches stack once only.

  Old code stashes the return-address of error_entry() in a scratch
  register and new code doesn't stash it.
  It relies on the fact that fixup_bad_iret() and sync_regs() don't
  corrupt the return-address of error_entry().  But even the old code
  also relies on the fact that fixup_bad_iret() and sync_regs() don't
  corrupt the return-address of themselves.  They are the same reliance.

The code had been tested with my additial tracing code in kernel and
the x86 selftest code which includes all kinds of cases for bad iret.
(tools/testing/selftests/x86/sigreturn.c)
