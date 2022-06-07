Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 213DB540B28
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 20:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352820AbiFGS1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 14:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351524AbiFGSCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 14:02:07 -0400
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61047153525;
        Tue,  7 Jun 2022 10:44:49 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-2ec42eae76bso184011477b3.10;
        Tue, 07 Jun 2022 10:44:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W+PiNQ7Ke1EDMoHaTdFM09JbhwxFO++lctg5sJwbwR4=;
        b=3vMAA1UaS1/xeAOJAkfgny+2HK4QsPFfmlUIq8LDajMksuObgQ1s+tvWBohiUWfymJ
         F2ByZVwtnWug5x8vuU9cTVE6ZJeL3sNQAeMsTXQvw6fg/7WitgBAm28Jtk8uMRp2MbnY
         wgsluHA6tbwr/Qy/DORBjlLAEal/KpW3j3lRM9Dj7UUZsLOmisDufwAiNoOcAQNkHnUM
         97pz9jPEI0XXl2bJs1pRWqVqA1srd9FNxTuxuwJS3Aw58LCtZK29kP5RxH1HmdXGkWE/
         KZTnT4t34t6uak/fhsk1xESuRGOMgMnQocm9H8o97YSw6OMXal5tKkXK8il9YitHJZ5o
         OHyw==
X-Gm-Message-State: AOAM533n/7Mh5e6S+eXveoxQ9WyedSF786VmoQMzIenOSnyO84KTEzWE
        2AcdHJHDkviKjLcrdbEEk/kMWjb8HCUnOhCGOgo=
X-Google-Smtp-Source: ABdhPJwzutUKNflb7PpXgywg1Uv/bvtdxWRNOeG6nVPsQilGXkeQttAkd8clvXym4gpzSPRzewnvcZZ1/ttEcYpnDSk=
X-Received: by 2002:a05:690c:28b:b0:30c:bcc2:240d with SMTP id
 bf11-20020a05690c028b00b0030cbcc2240dmr34156080ywb.19.1654623888166; Tue, 07
 Jun 2022 10:44:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220606165640.634811-1-dmitry.osipenko@collabora.com>
In-Reply-To: <20220606165640.634811-1-dmitry.osipenko@collabora.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 7 Jun 2022 19:44:37 +0200
Message-ID: <CAJZ5v0icfqdOiPottyc=h6VyagynkbV7-0EqrC+5PZMKV5s6Lg@mail.gmail.com>
Subject: Re: [PATCH v1] kernel/reboot: Fix powering off using a non-syscall
 code paths
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
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

On Mon, Jun 6, 2022 at 6:57 PM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> There are other methods of powering off machine than the reboot syscall.
> Previously we missed to coved those methods and it created power-off
> regression for some machines, like the PowerPC e500. Fix this problem
> by moving the legacy sys-off handler registration to the latest phase
> of power-off process and making the kernel_can_power_off() to check the
> legacy pm_power_off presence.
>
> Tested-by: Michael Ellerman <mpe@ellerman.id.au> # ppce500
> Reported-by: Michael Ellerman <mpe@ellerman.id.au> # ppce500
> Fixes: da007f171fc9 ("kernel/reboot: Change registration order of legacy power-off handler")
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  kernel/reboot.c | 46 ++++++++++++++++++++++++++--------------------
>  1 file changed, 26 insertions(+), 20 deletions(-)
>
> diff --git a/kernel/reboot.c b/kernel/reboot.c
> index 3b19b123efec..b5a71d1ff603 100644
> --- a/kernel/reboot.c
> +++ b/kernel/reboot.c
> @@ -320,6 +320,7 @@ static struct sys_off_handler platform_sys_off_handler;
>  static struct sys_off_handler *alloc_sys_off_handler(int priority)
>  {
>         struct sys_off_handler *handler;
> +       gfp_t flags;
>
>         /*
>          * Platforms like m68k can't allocate sys_off handler dynamically
> @@ -330,7 +331,12 @@ static struct sys_off_handler *alloc_sys_off_handler(int priority)
>                 if (handler->cb_data)
>                         return ERR_PTR(-EBUSY);
>         } else {
> -               handler = kzalloc(sizeof(*handler), GFP_KERNEL);
> +               if (system_state > SYSTEM_RUNNING)
> +                       flags = GFP_ATOMIC;
> +               else
> +                       flags = GFP_KERNEL;
> +
> +               handler = kzalloc(sizeof(*handler), flags);
>                 if (!handler)
>                         return ERR_PTR(-ENOMEM);
>         }
> @@ -440,7 +446,7 @@ void unregister_sys_off_handler(struct sys_off_handler *handler)
>  {
>         int err;
>
> -       if (!handler)
> +       if (IS_ERR_OR_NULL(handler))
>                 return;
>
>         if (handler->blocking)
> @@ -615,7 +621,23 @@ static void do_kernel_power_off_prepare(void)
>   */
>  void do_kernel_power_off(void)
>  {
> +       struct sys_off_handler *sys_off = NULL;
> +
> +       /*
> +        * Register sys-off handlers for legacy PM callback. This allows
> +        * legacy PM callbacks temporary co-exist with the new sys-off API.
> +        *
> +        * TODO: Remove legacy handlers once all legacy PM users will be
> +        *       switched to the sys-off based APIs.
> +        */
> +       if (pm_power_off)
> +               sys_off = register_sys_off_handler(SYS_OFF_MODE_POWER_OFF,
> +                                                  SYS_OFF_PRIO_DEFAULT,
> +                                                  legacy_pm_power_off, NULL);
> +
>         atomic_notifier_call_chain(&power_off_handler_list, 0, NULL);
> +
> +       unregister_sys_off_handler(sys_off);
>  }
>
>  /**
> @@ -626,7 +648,8 @@ void do_kernel_power_off(void)
>   */
>  bool kernel_can_power_off(void)
>  {
> -       return !atomic_notifier_call_chain_is_empty(&power_off_handler_list);
> +       return !atomic_notifier_call_chain_is_empty(&power_off_handler_list) ||
> +               pm_power_off;
>  }
>  EXPORT_SYMBOL_GPL(kernel_can_power_off);
>
> @@ -661,7 +684,6 @@ SYSCALL_DEFINE4(reboot, int, magic1, int, magic2, unsigned int, cmd,
>                 void __user *, arg)
>  {
>         struct pid_namespace *pid_ns = task_active_pid_ns(current);
> -       struct sys_off_handler *sys_off = NULL;
>         char buffer[256];
>         int ret = 0;
>
> @@ -686,21 +708,6 @@ SYSCALL_DEFINE4(reboot, int, magic1, int, magic2, unsigned int, cmd,
>         if (ret)
>                 return ret;
>
> -       /*
> -        * Register sys-off handlers for legacy PM callback. This allows
> -        * legacy PM callbacks temporary co-exist with the new sys-off API.
> -        *
> -        * TODO: Remove legacy handlers once all legacy PM users will be
> -        *       switched to the sys-off based APIs.
> -        */
> -       if (pm_power_off) {
> -               sys_off = register_sys_off_handler(SYS_OFF_MODE_POWER_OFF,
> -                                                  SYS_OFF_PRIO_DEFAULT,
> -                                                  legacy_pm_power_off, NULL);
> -               if (IS_ERR(sys_off))
> -                       return PTR_ERR(sys_off);
> -       }
> -
>         /* Instead of trying to make the power_off code look like
>          * halt when pm_power_off is not set do it the easy way.
>          */
> @@ -758,7 +765,6 @@ SYSCALL_DEFINE4(reboot, int, magic1, int, magic2, unsigned int, cmd,
>                 break;
>         }
>         mutex_unlock(&system_transition_mutex);
> -       unregister_sys_off_handler(sys_off);
>         return ret;
>  }
>
> --

Applied (with a couple of edits in the changelog), thanks!
