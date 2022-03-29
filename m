Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0C94EB2DF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 19:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240294AbiC2Roc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 13:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233032AbiC2Rob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 13:44:31 -0400
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A07241B41;
        Tue, 29 Mar 2022 10:42:46 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-2e6ceb45174so152116737b3.8;
        Tue, 29 Mar 2022 10:42:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AJXMMgvpvdXkeVHlSYm/0JRtdhSL15VbRYdhQ9gVfCg=;
        b=LloscU5gnTaweuy2xhexeLJvsE/0jLAOXMuv+WP64uMeqWgCyk6DF9WEQZSESIlIEz
         5EvJPQtraWZExyiM/pAH5W2CpviGIg0N74edPBwbFCM2PHVydbuIpIRoaSBuRf9is04c
         Yydxl4dmtmKtzoCjTk8a2emXW+L93dxTIEvaVK6uyD+WVkh/PKDRuodetdZGlIYSG8Ts
         PE8D5Mook2UbQt7pHkv1EXVjZc0evEvjQXUIkXAlPgN2d9YALCAoXdoeGaDsKXehKHHH
         BJq7S/FGXiWhwbTKtpmLqOMBKZjcpE0Z2U5TpP8S39a34wlVdeZAhmPy3GnMD7VeG8zP
         JYfQ==
X-Gm-Message-State: AOAM530HANUdnDU6KHCPFu4mbqHWjgVLIvydcvQ0+vvT93x9iXhpSU1U
        veq7O+1aYdMkPd8/Mt3i0xsjDeNJArVxLFTRazg=
X-Google-Smtp-Source: ABdhPJyZlDnEpwReCMzcOAElpRHV+WsJfUfWYH4Ci5dPdO5TT7zL122F3R2ywvBUaIMAOORIrQORAFpYmAt1X+5glbk=
X-Received: by 2002:a81:bc5:0:b0:2e6:dcfe:bfcb with SMTP id
 188-20020a810bc5000000b002e6dcfebfcbmr28263841ywl.19.1648575765728; Tue, 29
 Mar 2022 10:42:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220325022219.829-1-chang.seok.bae@intel.com> <20220325022219.829-4-chang.seok.bae@intel.com>
In-Reply-To: <20220325022219.829-4-chang.seok.bae@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 29 Mar 2022 19:42:34 +0200
Message-ID: <CAJZ5v0iysvXEs-+L0PuBj1RH+ByGPNotOSgT21TYnUuiwK+hSQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] intel_idle: Add a new flag to initialize the AMX state
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2022 at 3:30 AM Chang S. Bae <chang.seok.bae@intel.com> wrote:
>
> The non-initialized AMX state can be the cause of C-state demotion from C6
> to C1E. This low-power idle state may improve power savings and thus result
> in a higher available turbo frequency budget.
>
> This behavior is implementation-specific. Initialize the state for the C6
> entrance of Sapphire Rapids as needed.
>
> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> Tested-by : Zhang Rui <rui.zhang@intel.com>
> Cc: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pm@vger.kernel.org

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

and I'm expecting this to be routed along with the rest of the series.

> ---
> Changes from v2:
> * Remove an unnecessary backslash (Rafael Wysocki).
>
> Changes from v1:
> * Simplify the code with a new flag (Rui).
> * Rebase on Artem's patches for SPR intel_idle.
> * Massage the changelog.
> ---
>  drivers/idle/intel_idle.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index b7640cfe0020..d35790890a3f 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -54,6 +54,7 @@
>  #include <asm/intel-family.h>
>  #include <asm/mwait.h>
>  #include <asm/msr.h>
> +#include <asm/fpu/api.h>
>
>  #define INTEL_IDLE_VERSION "0.5.1"
>
> @@ -100,6 +101,11 @@ static unsigned int mwait_substates __initdata;
>   */
>  #define CPUIDLE_FLAG_ALWAYS_ENABLE     BIT(15)
>
> +/*
> + * Initialize large xstate for the C6-state entrance.
> + */
> +#define CPUIDLE_FLAG_INIT_XSTATE       BIT(16)
> +
>  /*
>   * MWAIT takes an 8-bit "hint" in EAX "suggesting"
>   * the C-state (top nibble) and sub-state (bottom nibble)
> @@ -134,6 +140,9 @@ static __cpuidle int intel_idle(struct cpuidle_device *dev,
>         if (state->flags & CPUIDLE_FLAG_IRQ_ENABLE)
>                 local_irq_enable();
>
> +       if (state->flags & CPUIDLE_FLAG_INIT_XSTATE)
> +               fpu_idle_fpregs();
> +
>         mwait_idle_with_hints(eax, ecx);
>
>         return index;
> @@ -154,8 +163,12 @@ static __cpuidle int intel_idle(struct cpuidle_device *dev,
>  static __cpuidle int intel_idle_s2idle(struct cpuidle_device *dev,
>                                        struct cpuidle_driver *drv, int index)
>  {
> -       unsigned long eax = flg2MWAIT(drv->states[index].flags);
>         unsigned long ecx = 1; /* break on interrupt flag */
> +       struct cpuidle_state *state = &drv->states[index];
> +       unsigned long eax = flg2MWAIT(state->flags);
> +
> +       if (state->flags & CPUIDLE_FLAG_INIT_XSTATE)
> +               fpu_idle_fpregs();
>
>         mwait_idle_with_hints(eax, ecx);
>
> @@ -790,7 +803,8 @@ static struct cpuidle_state spr_cstates[] __initdata = {
>         {
>                 .name = "C6",
>                 .desc = "MWAIT 0x20",
> -               .flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED,
> +               .flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED |
> +                                          CPUIDLE_FLAG_INIT_XSTATE,
>                 .exit_latency = 290,
>                 .target_residency = 800,
>                 .enter = &intel_idle,
> --
> 2.17.1
>
