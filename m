Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C78614D517F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 20:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245456AbiCJSfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 13:35:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbiCJSfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 13:35:40 -0500
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001E419BE7D;
        Thu, 10 Mar 2022 10:34:38 -0800 (PST)
Received: by mail-yb1-f175.google.com with SMTP id l2so12627885ybe.8;
        Thu, 10 Mar 2022 10:34:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CKn4UlhzcUis8Bod+pO2Kn++YD/HSd7Iu7VmYfBTVZM=;
        b=xgQMxkw5Ep7ub7g8g3Ru4hcxT9Q7fXpAsGnqZY3bdPl4cFKAzf6+BKzg8B5vgCIDa4
         q5pX57WVf77GiEOAQ573sTtSWeLwFH9TfAk30GOiM2QZBUX2yFF6qFOZnyMKlgRsx4Bu
         8AkUtfGmNKsThBrVza/1p/4a/fEFMTghb3z1rdn8lSBQYGGUU0xZWWUY50he/2Qzy/kr
         OpR5jfRcjzWX+eOE69xSHAX+eYSzbX6mrsXnUSREEYgMseMHHsjji7dQUHT4mSnDzrTK
         8Y8F+0WA6cEUHtxWYmTH3WlsLBxK+sudnFtlQGwArktBuADceX97g8SFdiTwKi9sS0Jy
         XzbQ==
X-Gm-Message-State: AOAM532AaXKb9mIXkqfaPFzDOmpeJVszYRkUvJymUbS0urpkwG5sHp+b
        XC6gmtjeVBU5N25QncRlRuhxgW+iJzVC/NijCmKi3Bxp
X-Google-Smtp-Source: ABdhPJwHLUi+wpcAaHInVE7qN7vZrvuzV2+E/wEOsJ/PA6SH67oZUEn+KQ0Li+yPzZfnqptU8X6gQzO93F1w18bomXw=
X-Received: by 2002:a25:fe10:0:b0:625:262f:e792 with SMTP id
 k16-20020a25fe10000000b00625262fe792mr4844677ybe.365.1646937278267; Thu, 10
 Mar 2022 10:34:38 -0800 (PST)
MIME-Version: 1.0
References: <20220309223431.26560-1-chang.seok.bae@intel.com> <20220309223431.26560-3-chang.seok.bae@intel.com>
In-Reply-To: <20220309223431.26560-3-chang.seok.bae@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 10 Mar 2022 19:34:27 +0100
Message-ID: <CAJZ5v0g2ZU8PY8QkGD1Nb6VH37pm=ho8ZYa3h3UBRWDoH+xqnQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] intel_idle: Add a new flag to initialize the AMX state
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 9, 2022 at 11:42 PM Chang S. Bae <chang.seok.bae@intel.com> wrote:
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
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
> Changes from v1:
> * Simplify the code with a new flag (Rui).
> * Rebase on Artem's patches for SPR intel_idle.
> * Massage the changelog.
>
> Dependency on the new C-state table for SPR:
> https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?h=linux-next&id=9edf3c0ffef0ec1bed8300315852b5c6a0997130
> ---
>  drivers/idle/intel_idle.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index 1c7c25909e54..6ecbeffdf785 100644
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
> @@ -99,6 +100,11 @@ static unsigned int mwait_substates __initdata;
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
> @@ -136,6 +142,9 @@ static __cpuidle int intel_idle(struct cpuidle_device *dev,
>         if (state->flags & CPUIDLE_FLAG_IRQ_ENABLE)
>                 local_irq_enable();
>
> +       if (state->flags & CPUIDLE_FLAG_INIT_XSTATE)
> +               fpu_idle_fpregs();
> +
>         mwait_idle_with_hints(eax, ecx);
>
>         return index;
> @@ -156,8 +165,12 @@ static __cpuidle int intel_idle(struct cpuidle_device *dev,
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
> @@ -792,7 +805,8 @@ static struct cpuidle_state spr_cstates[] __initdata = {
>         {
>                 .name = "C6",
>                 .desc = "MWAIT 0x20",
> -               .flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED,
> +               .flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED | \

Why is the backslash at the end of the line needed?

> +                                          CPUIDLE_FLAG_INIT_XSTATE,
>                 .exit_latency = 290,
>                 .target_residency = 800,
>                 .enter = &intel_idle,
> --
