Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9707456A5B5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 16:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235510AbiGGOlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 10:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235982AbiGGOla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 10:41:30 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0EF31DF4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 07:41:29 -0700 (PDT)
Received: from mail-yw1-f174.google.com ([209.85.128.174]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MA7Su-1oJt652ehm-00BbuM for <linux-kernel@vger.kernel.org>; Thu, 07 Jul
 2022 16:41:27 +0200
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-31c86fe1dddso124494707b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 07:41:27 -0700 (PDT)
X-Gm-Message-State: AJIora/2p63JSg5OpuJ6f2F31WNWvTf5mESUM6zvGnmSgrhz64XwHZuW
        ZLqS9fZ13SlJ27vYb39oqom4twlcWV7tyeWPlck=
X-Google-Smtp-Source: AGRyM1ugCMrUPgxLUvxIRQZLC1zdIj2O+Vxq6ia7yT/fLej4bF43FUE/j7cYL5pmPy3Gz3VGYzGIau7ei5jBYmPiCD0=
X-Received: by 2002:a0d:df0f:0:b0:31b:e000:7942 with SMTP id
 i15-20020a0ddf0f000000b0031be0007942mr50077266ywe.320.1657204886416; Thu, 07
 Jul 2022 07:41:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220707110511.52129-1-zhengqi.arch@bytedance.com>
 <20220707110511.52129-3-zhengqi.arch@bytedance.com> <CAK8P3a1-rL391dp33D5r+SgQ+L0u7Neta_-DZoZL=+c1zPtNQg@mail.gmail.com>
 <42bfd82c-b3fb-c942-d6f2-ae5adec90a26@bytedance.com>
In-Reply-To: <42bfd82c-b3fb-c942-d6f2-ae5adec90a26@bytedance.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 7 Jul 2022 16:41:08 +0200
X-Gmail-Original-Message-ID: <CAK8P3a17A1t=qkyToQNVnuVfGPp-7VpFx5qJ-gmpyrkJ3yRXTw@mail.gmail.com>
Message-ID: <CAK8P3a17A1t=qkyToQNVnuVfGPp-7VpFx5qJ-gmpyrkJ3yRXTw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] arm64: support HAVE_IRQ_EXIT_ON_IRQ_STACK
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:lYjdV6iRvmKX6gHHIsoRJjfmbtBpvuRfe0a+FzlTlroi9hWEZZF
 vLvI/I95iGhdYnIR7wRtYdxLCu0vqfz5YeB5OCxi/BAkFgUcNqJmx/Hfp3NkMHXCufR9T6R
 7nwFRS4VUDShHEtGGle9AVwYkW8S3Belopo46QXYBhAWzeDAnGAKCdBLlNqIv8OMVyESlnH
 Z+DTs0lH131ygUrQrZ4vw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:h6omgu/DZns=:RLyckYvvWyeEmv1+hHo7ac
 iFwaeM+arwfyQDYBpnTQoZg0ZrwOKYu5iZWLOseTlb/dGzoEEAIsuuTwhonPzizhl4/SpPgz0
 bDqLjyrxaYXcBgDs3Iu1DYlj8O3y3/Y7Upy1kvcjYV+9bCh6MW/Q13ubp3kErX5bzGpgKRajG
 iT71heKw2HGGgALf5fumyXW8NHiAh+rkt6GQmxrDyPVFgHHBrj3pieuQEaRtSmb8XttTLmynk
 xk2drbfPWh8ALOYjQSnvIqlW3Fb+R621PvFeuZbdyF/coYgclCWp5/tXQKN7cTwD9c7X9U6+9
 PskKSFHRBC3hhxM1bMW8zS/50yV6+39Xk55pwh9D9EVaNUxZb2dVnTMpnBPJ+0uWvya5ajNF0
 /VrbzD0Iqm+8TAZy/5x12u7MgV3IlBiSnQ9BvbYQmVhf34zZGgWNjhKuiqWRypw1lHrqSTkNr
 E+GSVMIScZVReZltMHCLEyFEPA6+A+e9Z1XLsUiVLi1SwLvCPqjswQpmPOhiSJg8HbAh0/SKW
 qwp5LBmi98+zsAjAfCPlpTjGNerW3p0HGDa3uqikqB8EvOmWPAXVEiO9eZxIfAUZ/bak981ZC
 ZaOlkPP0+ZrL4Xzc0B+eOd4+irB6dyrRFE5OBPBp8Bi310XX8IZbg8XnwBeT2fdmsYoB46Rl3
 XxVK2ahlTudVypma7rtYLqNwUfQl9sfshvj3DQ9nx24SxCv9EO4rmS4jjHd9O5GN6+RIsXQmc
 6t1xpWMsc8FbdI4GT13PsCaK2gV0dg/R2yaOV8VouMXFRbxH/IzWZ8qOaGiiOQiQ4uC8fmiGe
 N4sBSR+v4TLqvxNCA44yL36aIV6L4bDnG1XPprd4rkY/56FSWQKhRgXInOgiX99Md7Q9AA6Kw
 e0mqgZPE2uzNJP1DfGRQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 7, 2022 at 3:38 PM Qi Zheng <zhengqi.arch@bytedance.com> wrote:
> On 2022/7/7 20:49, Arnd Bergmann wrote:
> > On Thu, Jul 7, 2022 at 1:05 PM Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>           * Restore the SP from the FP, and restore the FP and LR from
> the frame
>           * record.
>           */
> -       mov     sp, x29
> +999:   mov     sp, x29
>          ldp     x29, x30, [sp], #16
>   #ifdef CONFIG_SHADOW_CALL_STACK
>          ldp     scs_sp, xzr, [sp], #16
>
> But this also requires a new parameter in do_interrupt_handler.
>
> I also considered implementing call_on_irq_stack() for nmi and irq
> separately, but later think it's unnecessary.

What I had in mind was something along the lines of

diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index 56cefd33eb8e..432042b91588 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -270,10 +270,7 @@ static void do_interrupt_handler(struct pt_regs *regs,
 {
        struct pt_regs *old_regs = set_irq_regs(regs);

-       if (on_thread_stack())
-               call_on_irq_stack(regs, handler);
-       else
-               handler(regs);
+       handler(regs);

        set_irq_regs(old_regs);
 }
@@ -473,16 +470,31 @@ static void noinstr el1_interrupt(struct pt_regs *regs,
                __el1_irq(regs, handler);
 }

-asmlinkage void noinstr el1h_64_irq_handler(struct pt_regs *regs)
+static void noinstr el1_irq(struct pt_regs *regs)
 {
        el1_interrupt(regs, handle_arch_irq);
 }

-asmlinkage void noinstr el1h_64_fiq_handler(struct pt_regs *regs)
+asmlinkage void noinstr el1h_64_irq_handler(struct pt_regs *regs)
+{
+       if (on_thread_stack())
+               call_on_irq_stack(regs, el1_irq);
+       else
+               el1_irq(regs);
+}
+
+static void noinstr el1_fiq(struct pt_regs *regs)
 {
        el1_interrupt(regs, handle_arch_fiq);
 }

+asmlinkage void noinstr el1h_64_fiq_handler(struct pt_regs *regs)
+{
+        if (on_thread_stack())
+               call_on_irq_stack(regs, el1_fiq);
+       else
+               el1_fiq(regs);
+}
+
 asmlinkage void noinstr el1h_64_error_handler(struct pt_regs *regs)
 {
        unsigned long esr = read_sysreg(esr_el1);
@@ -713,7 +731,7 @@ static void noinstr
__el0_irq_handler_common(struct pt_regs *regs)

 asmlinkage void noinstr el0t_64_irq_handler(struct pt_regs *regs)
 {
-       __el0_irq_handler_common(regs);
+       call_on_irq_stack(regs, __el0_irq_handler_common);
 }

 static void noinstr __el0_fiq_handler_common(struct pt_regs *regs)
@@ -723,7 +741,7 @@ static void noinstr
__el0_fiq_handler_common(struct pt_regs *regs)

 asmlinkage void noinstr el0t_64_fiq_handler(struct pt_regs *regs)
 {
-       __el0_fiq_handler_common(regs);
+       call_on_irq_stack(regs, __el0_fiq_handler_common);
 }

 static void noinstr __el0_error_handler_common(struct pt_regs *regs)
@@ -807,12 +825,12 @@ asmlinkage void noinstr
el0t_32_sync_handler(struct pt_regs *regs)

 asmlinkage void noinstr el0t_32_irq_handler(struct pt_regs *regs)
 {
-       __el0_irq_handler_common(regs);
+       call_on_irq_stack(regs, __el0_irq_handler_common);
 }

 asmlinkage void noinstr el0t_32_fiq_handler(struct pt_regs *regs)
 {
-       __el0_fiq_handler_common(regs);
+       call_on_irq_stack(regs, __el0_fiq_handler_common);
 }

 asmlinkage void noinstr el0t_32_error_handler(struct pt_regs *regs)

Not sure if that works.

        Arnd
