Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F43507ABC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 22:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345150AbiDSUNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 16:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236200AbiDSUN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 16:13:29 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5683EB9E
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 13:10:46 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id e194so14405646iof.11
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 13:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xy72vbVLGcLXHwzAazq9kOTgmNrIZnaiAvJsWfbG98A=;
        b=yVKzq4L1BdioeLxoRlvJGvKbTQ/QSHZePO4l3VJhJlu8/ztbLwHekfdHxVw8A3z6KY
         iB8pjlxwDqQLtl5asXV0eJXBkmrAD67Pbl9fhgbyeJ36pfSiEfVLlc5568bEhwKSeMi0
         wYWnx9UBS1jKTIVJOZLCW9fE1vfNkziaTz7aY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xy72vbVLGcLXHwzAazq9kOTgmNrIZnaiAvJsWfbG98A=;
        b=uoV+pyTr5kKeELt1pPM8GcIKKXP2Pec1jdoYle1fTv2TNpnJthaWJp9uoJisAlFJIl
         VUCCmxUxQYtBJRWCxIrT6iRkHsEaOFGEBMPxG1HywF0375T71W0ctaBgfVmKbkDJ4UKs
         p0RTJJpVLKtirK7XiCc7gRnTuZ5cwpCLcDTdAFu1t1ZbEd0bg2naX8IhgJ/RnIsBBG39
         jv+/Y16eGQ6xPvqCSH5h52xzs+jYqJlF/O3Z5mcENzjhOvgfbba2kV65EeFDD6hAetw1
         YZ+zSw58Pzj7TfQxZ3jCgdhSg05pB6IhFhaLVXSd2TPG+BHL2ERXaKX96s407A31tkZT
         /0Xg==
X-Gm-Message-State: AOAM5317GnwY+pU9i08EEtwOVFFwqyL6FaEvwyu1ycVJoJ52anK1ue7J
        WFLZMk+QLdc2E1q9UL4JWuch+/qI2qr/QMiFvQr5N1UIuFvulg==
X-Google-Smtp-Source: ABdhPJwxzPCGWapE0i9RHBg2PrlUr2LIJyNPu4GvkU3NrTK+ZlXRqwHS6vGRBsoa8tBbnFU4KBQX6hCBA8p/L0Q4sT4=
X-Received: by 2002:a05:6638:1612:b0:328:673b:d467 with SMTP id
 x18-20020a056638161200b00328673bd467mr8030900jas.180.1650399045652; Tue, 19
 Apr 2022 13:10:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220419200823.2790490-1-joel@joelfernandes.org>
In-Reply-To: <20220419200823.2790490-1-joel@joelfernandes.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 19 Apr 2022 16:10:33 -0400
Message-ID: <CAEXW_YS7cdrfP58Qvbt_WS2QRNkV=wVrwY6iTWmEH5qBxyStxQ@mail.gmail.com>
Subject: Re: [PATCH v4 rcu/dev] rcu/nocb: Add an option to offload all CPUs on boot
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu <rcu@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        Vineeth Pillai <vineethrp@gmail.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 4:08 PM Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
>
> From: Joel Fernandes <joel@joelfernandes.org>
>
> On systems with CONFIG_RCU_NOCB_CPU=y, there is no default mask provided
> which ends up not offloading any CPU. This patch removes a dependency
> from the bootloader having to know about RCU and about how to provide
> the mask.
>
> With the new option enabled, all CPUs will be offloaded on boot unless
> rcu_nocbs= or rcu_nohz_full= kernel parameters provide a CPU list.
>
> Signed-off-by: Joel Fernandes <joel@joelfernandes.org>

Oops, forgot to add Reviewed-by tags:
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Reviewed-by: Kalesh Singh <kaleshsingh@google.com>

Paul, would you mind doing so, so I don't have to resend? Apologies.

Thanks,

Joel


> ---
> v4: Rebased on rcu/dev, fixed conflict with Frederick's patch changing
>     location of nocb_is_setup variable.
>
>  Documentation/admin-guide/kernel-parameters.txt |  6 ++++++
>  kernel/rcu/Kconfig                              | 13 +++++++++++++
>  kernel/rcu/tree_nocb.h                          | 13 +++++++++++++
>  3 files changed, 32 insertions(+)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 789ef586009b..1e82ecb7a649 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3572,6 +3572,9 @@
>                         just as if they had also been called out in the
>                         rcu_nocbs= boot parameter.
>
> +                       Note that this argument takes precedence over
> +                       the CONFIG_RCU_NOCB_CPU_DEFAULT_ALL option.
> +
>         noiotrap        [SH] Disables trapped I/O port accesses.
>
>         noirqdebug      [X86-32] Disables the code which attempts to detect and
> @@ -4475,6 +4478,9 @@
>                         no-callback mode from boot but the mode may be
>                         toggled at runtime via cpusets.
>
> +                       Note that this argument takes precedence over
> +                       the CONFIG_RCU_NOCB_CPU_DEFAULT_ALL option.
> +
>         rcu_nocb_poll   [KNL]
>                         Rather than requiring that offloaded CPUs
>                         (specified by rcu_nocbs= above) explicitly
> diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> index 1c630e573548..27aab870ae4c 100644
> --- a/kernel/rcu/Kconfig
> +++ b/kernel/rcu/Kconfig
> @@ -262,6 +262,19 @@ config RCU_NOCB_CPU
>           Say Y here if you need reduced OS jitter, despite added overhead.
>           Say N here if you are unsure.
>
> +config RCU_NOCB_CPU_DEFAULT_ALL
> +       bool "Offload RCU callback processing from all CPUs by default"
> +       depends on RCU_NOCB_CPU
> +       default n
> +       help
> +         Use this option to offload callback processing from all CPUs
> +         by default, in the absence of the rcu_nocbs or nohz_full boot
> +         parameter. This also avoids the need to use any boot parameters
> +         to achieve the effect of offloading all CPUs on boot.
> +
> +         Say Y here if you want offload all CPUs by default on boot.
> +         Say N here if you are unsure.
> +
>  config TASKS_TRACE_RCU_READ_MB
>         bool "Tasks Trace RCU readers use memory barriers in user and idle"
>         depends on RCU_EXPERT && TASKS_TRACE_RCU
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index 4cf9a29bba79..9f29f25a0cbc 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -1197,11 +1197,21 @@ void __init rcu_init_nohz(void)
>  {
>         int cpu;
>         bool need_rcu_nocb_mask = false;
> +       bool offload_all = false;
>         struct rcu_data *rdp;
>
> +#if defined(CONFIG_RCU_NOCB_CPU_DEFAULT_ALL)
> +       if (!rcu_state.nocb_is_setup) {
> +               need_rcu_nocb_mask = true;
> +               offload_all = true;
> +       }
> +#endif /* #if defined(CONFIG_RCU_NOCB_CPU_DEFAULT_ALL) */
> +
>  #if defined(CONFIG_NO_HZ_FULL)
>         if (tick_nohz_full_running && !cpumask_empty(tick_nohz_full_mask))
>                 need_rcu_nocb_mask = true;
> +               offload_all = false; /* NO_HZ_FULL has its own mask. */
> +       }
>  #endif /* #if defined(CONFIG_NO_HZ_FULL) */
>
>         if (need_rcu_nocb_mask) {
> @@ -1222,6 +1232,9 @@ void __init rcu_init_nohz(void)
>                 cpumask_or(rcu_nocb_mask, rcu_nocb_mask, tick_nohz_full_mask);
>  #endif /* #if defined(CONFIG_NO_HZ_FULL) */
>
> +       if (offload_all)
> +               cpumask_setall(rcu_nocb_mask);
> +
>         if (!cpumask_subset(rcu_nocb_mask, cpu_possible_mask)) {
>                 pr_info("\tNote: kernel parameter 'rcu_nocbs=', 'nohz_full', or 'isolcpus=' contains nonexistent CPUs.\n");
>                 cpumask_and(rcu_nocb_mask, cpu_possible_mask,
> --
> 2.36.0.rc0.470.gd361397f0d-goog
>
