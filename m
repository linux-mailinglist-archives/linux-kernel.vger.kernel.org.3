Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57C535267A5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 18:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382623AbiEMQyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 12:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382670AbiEMQyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 12:54:04 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69FE57B11
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 09:52:27 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id kq17so17391999ejb.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 09:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KlZ655wjZRJj4mJWbjrP+r9jazGcbcjqjX0zPmHpUq4=;
        b=Ls5t4pqoVKGHgrd6A+s5IkGGCqmLswFOLWmLzqrrdHhayo0QWp89kB5PFE8lvBbqBb
         CsP2kGQpIy4lp19vDS/h/A2x8Mo0xqHAHQPZZKiH3hZB2SVr+wAiMIEmT0wGec94sd1G
         iHS0DpgtbOLcwdN2oxGA3k71Sws7icodZaZsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KlZ655wjZRJj4mJWbjrP+r9jazGcbcjqjX0zPmHpUq4=;
        b=O19T0xwKnHxHhDblOaM3NTQmfPsN3d6bT2vmReB6dTbp0BEPOHxEtrlBLfwtMUO9fr
         kiVEr3OYqMO9/U7UUd64M86sZuwiTKnKppaib+svnMqsA2EKxNpiDCDgi2Qd3PKkQ32X
         +OontHOaic8KfoRB3sqLSdMEvn3xG9ueAyelVBGLm8zWN3+Py3r28K4qKKe0FGn5yUIv
         FeaP6q3Zkv0pXX8oCyNuMe4HrZA42SOI0LDI2G4kZKaudNc8L279MLu0Xy5Rj2J8JeDn
         ybHVq9N7Ok2+DzyA50EcZaKa4QIvZXkVCun2QyUORCeSzymyTrDfjJJssIyvAAzHcASA
         0ZFg==
X-Gm-Message-State: AOAM533zT9WkShtQeKJeR4GJ3F5RxjIcLpLaLO1x/ik1zOBBgRSzNJaT
        8mnFUEItvcze+5KNVWzGP370dSvYFIsH0dkCpTo=
X-Google-Smtp-Source: ABdhPJyT3noJUbIo4B9ghZn0lcUXUJD2TUTKiJQIsWvodwhHeyYGf1ImSUzHCuyL06EIjx01tM0jeA==
X-Received: by 2002:a17:906:4787:b0:6f4:2f25:f9ff with SMTP id cw7-20020a170906478700b006f42f25f9ffmr5304126ejc.116.1652460745959;
        Fri, 13 May 2022 09:52:25 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id em8-20020a170907288800b006f3ef214e34sm912878ejc.154.2022.05.13.09.52.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 May 2022 09:52:25 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id h16so11509985wrb.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 09:52:24 -0700 (PDT)
X-Received: by 2002:a5d:6d0b:0:b0:20c:4ec7:8e84 with SMTP id
 e11-20020a5d6d0b000000b0020c4ec78e84mr4633805wrq.281.1652460744446; Fri, 13
 May 2022 09:52:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220513085455.GB21013@xsang-OptiPlex-9020>
In-Reply-To: <20220513085455.GB21013@xsang-OptiPlex-9020>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 13 May 2022 09:52:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjDE7tWc5k81P41AKw9b13ehrTX8XawgnP-wa6fA57kuA@mail.gmail.com>
Message-ID: <CAHk-=wjDE7tWc5k81P41AKw9b13ehrTX8XawgnP-wa6fA57kuA@mail.gmail.com>
Subject: Re: [x86/uaccess] 9c5743dff4: WARNING:at_arch/x86/mm/extable.c:#ex_handler_fprestore
To:     kernel test robot <oliver.sang@intel.com>,
        Eric Biggers <ebiggers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 1:55 AM kernel test robot <oliver.sang@intel.com> wrote:
>
> FYI, we noticed the following commit (built with gcc-11): commit
> 9c5743dff415 ("x86/uaccess: fix code generation in put_user()")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>
> in testcase: boot
>
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
>
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):

Hmm. It sounds unlikely that _that_ commit caused the problem,
although tweaks to generate different code can obviously always expose
anything..

But considering that the fail:runs thing is 41:52, I suspect it's
something very timing-dependent and who knows how reliable the
bisection has been.

That commit did have some discussion about how to possibly do it more
nicely without the "register asm" thing, but I'm not finding anything
else about it, so I don't think it caused any actual real code
generation problems.

As such, it seems unlikely to then cause this FP state restore issue..

> [ 266.823123][ T1] WARNING: CPU: 0 PID: 1 at arch/x86/mm/extable.c:65 ex_handler_fprestore (??:?)

This is just

    65          WARN_ONCE(1, "Bad FPU state detected at %pB,
reinitializing FPU registers.",
    66                    (void *)instruction_pointer(regs));

which isn't great, in that it implies that there was bad fp state to
restore in the first place.

But that can technically happen when user space does something bad
too, notably when it has used ptrace to change the FP state.

See commit d5c8028b4788 ("x86/fpu: Reinitialize FPU registers if
restoring FPU state fails") for more details.

And *this* part:

> [ 266.879246][ T1] RIP: 0010:copy_kernel_to_fpregs (core.c:?)
> [ 266.880748][ T1] Code: 05 31 84 1e 0b 48 c7 c7 50 47 2b 8c 48 8d 58 01 e8 c1 80 5c 00 b8 ff ff ff ff 48 89 1d 15 84 1e 0b 4c 89 e7 89 c2 48 0f ae 2f <48> c7 c7 58 47 2b 8c e8 60 82 5c 00 48 8b 05 01 84 1e 0b 48 c7 c7
> All code
> ========
>    0:   05 31 84 1e 0b          add    $0xb1e8431,%eax
>    5:   48 c7 c7 50 47 2b 8c    mov    $0xffffffff8c2b4750,%rdi
>    c:   48 8d 58 01             lea    0x1(%rax),%rbx
>   10:   e8 c1 80 5c 00          callq  0x5c80d6
>   15:   b8 ff ff ff ff          mov    $0xffffffff,%eax
>   1a:   48 89 1d 15 84 1e 0b    mov    %rbx,0xb1e8415(%rip)        # 0xb1e8436
>   21:   4c 89 e7                mov    %r12,%rdi
>   24:   89 c2                   mov    %eax,%edx
>   26:   48 0f ae 2f             xrstor64 (%rdi)
>   2a:*  48 c7 c7 58 47 2b 8c    mov    $0xffffffff8c2b4758,%rdi         <-- trapping instruction

Seems to be just the exception stack chain (ie notice how it's
pointing to the instruction after the xrstor64, it's not that the
immediate register move really trapped).

> [ 266.899210][ T1] __fpregs_load_activate (core.c:?)
> [ 266.900418][ T1] copy_fpstate_to_sigframe (??:?)
> [ 266.901947][ T1] get_sigframe+0x196/0x360
> [ 266.903138][ T1] __setup_rt_frame (signal.c:?)
> [ 266.904162][ T1] setup_rt_frame (signal.c:?)
> [ 266.905386][ T1] handle_signal (signal.c:?)
> [ 266.906423][ T1] arch_do_signal (??:?)

.. and it is in the signal handling path when returning to user space. Hmm.

And then again, we have the exception stack entry all the way to user space:

> [  266.914026][    T1] RIP: 0033:0x7f32488b5700
> [ 266.915046][ T1] Code: 76 05 e9 f3 fd ff ff 48 8b 05 3c f7 37 00 64 c7 00 16 00 00 00 83 c8 ff c3 90 41 ba 08 00 00 00 48 63 ff b8 0e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 02 f3 c3 48 8b 15 0f f7 37 00 f7 d8 64 89 02
> All code
> ========
>    0:   76 05                   jbe    0x7
>    2:   e9 f3 fd ff ff          jmpq   0xfffffffffffffdfa
>    7:   48 8b 05 3c f7 37 00    mov    0x37f73c(%rip),%rax        # 0x37f74a
>    e:   64 c7 00 16 00 00 00    movl   $0x16,%fs:(%rax)
>   15:   83 c8 ff                or     $0xffffffff,%eax
>   18:   c3                      retq
>   19:   90                      nop
>   1a:   41 ba 08 00 00 00       mov    $0x8,%r10d
>   20:   48 63 ff                movslq %edi,%rdi
>   23:   b8 0e 00 00 00          mov    $0xe,%eax
>   28:   0f 05                   syscall
>   2a:*  48 3d 00 f0 ff ff       cmp    $0xfffffffffffff000,%rax         <-- trapping instruction

and again, it's just pointing back to after the 'syscall' instruction
that caused this whole chain of events.

Anyway, I *think* that what may be going on is some ptrace thing, but
let's bring in other people. Because I don't think that "x86/uaccess:
fix code generation in put_user()" commit is what triggered this, but
who knows.. The x86 FP code can be very grotty.
