Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F08A506060
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 01:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235988AbiDSAAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235925AbiDSAAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:00:34 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE4629CA7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 16:57:54 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id t13so21732149pgn.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 16:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6DTfyGY4J+aCud1WtrxDpmeZLZK9HwCoRH/ZKq7p0NY=;
        b=MpJYZqhS/4wevygKpX5CVGmCIl7fpr/siGQ+44MFb9SHbahqi50UNuu5Rol1xchxjN
         aNky1Oy1UkUOLUOAKwBTb4JXgAuRru33uEuY9kTeCdLaZUZb+MnwrkYEU8FnELc4oqPm
         kAB/WHOilbj00EbxBKW+LNOdSwg57Zh+qtJ3480IneLi31Upq7YzBEx6d94gCDrUZYKM
         KuV0Sw/+ZPbympbXikCSy0hv5RuOsnx68DVBFKiPSTurvh/MZ7m5xiOw3GO1QpG7I+7T
         vbP4VmXtR027F0y7rPZnFWIR+5ixC0BQktvD6wNpz+rFr+oe2hV2Rxr7LEH2iuZLdkva
         d5EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6DTfyGY4J+aCud1WtrxDpmeZLZK9HwCoRH/ZKq7p0NY=;
        b=6ptKvEtA4EVuRK1zrEJCSIjEHMV/mXD2kcq5zTdbs1Uhfrh+L+jm12g0tmiinl4FvR
         BeF0Sg2sCejDjTEAFTzV8UF23oHEsAA8Ads0LikrBQ+Y09B0iHNEy2Vs1NLKexzVMbgq
         G7+fQEYXATliOibt7H6c6TZqTRbH1zNq9Q18/h1EVFb6dmXyX87TtSQqheL7xJ5ZgZ2D
         +7K2Q0U7gBy6SZvOb2RA3HtWEAz0yeqpL+mInNFw5QLckj6ruylB/GYte1NTtjiZbVso
         Gkl9IIDbeY8qRa598EY77hVmbcDvzoJEeQzGve0Ok/gopAxrapTvLamybmvLTqTA31FK
         9pvA==
X-Gm-Message-State: AOAM531LEZh4hT16sdvKVRn6F1d8uI7N/JOy+gKIVEl9659pO5cN/R3K
        Q2ZdOb5gKzdlSPdehwvs4dB6pA==
X-Google-Smtp-Source: ABdhPJwGbAEcmZ3Ri9bRNtcMxJHs0CrJhc9Y8lGnJ3QNwvBq4WwRrkz1+U7Kith1lRipZxV8xB3qEw==
X-Received: by 2002:a63:6e04:0:b0:398:409:2928 with SMTP id j4-20020a636e04000000b0039804092928mr12229537pgc.250.1650326273031;
        Mon, 18 Apr 2022 16:57:53 -0700 (PDT)
Received: from google.com ([2620:15c:211:200:e2b4:e46f:41ee:4499])
        by smtp.gmail.com with ESMTPSA id bc11-20020a656d8b000000b0039cc4dbb295sm13381698pgb.60.2022.04.18.16.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 16:57:52 -0700 (PDT)
Date:   Mon, 18 Apr 2022 16:57:46 -0700
From:   Kalesh Singh <kaleshsingh@google.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        rushikesh.s.kadam@intel.com, vineethrp@gmail.com, urezki@gmail.com
Subject: Re: [PATCH v4] rcu/nocb: Add an option to offload all CPUs on boot
Message-ID: <Yl36+skjQn26Mg43@google.com>
References: <20220418175403.2553842-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220418175403.2553842-1-joel@joelfernandes.org>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022 at 05:54:03PM +0000, Joel Fernandes (Google) wrote:
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

Hi Joel,

You can add Reviewed-by: Kalesh Singh <kaleshsingh@google.com>

Thanks,
Kalesh

> ---
> v4: mostly style related fixes.
> v3 is back to v1 but with a config option defaulting to 'n'.
> v2 was forcing the option to override no_cbs=
> 
>  Documentation/admin-guide/kernel-parameters.txt |  6 ++++++
>  kernel/rcu/Kconfig                              | 13 +++++++++++++
>  kernel/rcu/tree_nocb.h                          | 15 ++++++++++++++-
>  3 files changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index f5a27f067db9..4beb15ccac1a 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3506,6 +3506,9 @@
>  			just as if they had also been called out in the
>  			rcu_nocbs= boot parameter.
>  
> +			Note that this argument takes precedence over
> +			the CONFIG_RCU_NOCB_CPU_DEFAULT_ALL option.
> +
>  	noiotrap	[SH] Disables trapped I/O port accesses.
>  
>  	noirqdebug	[X86-32] Disables the code which attempts to detect and
> @@ -4398,6 +4401,9 @@
>  			no-callback mode from boot but the mode may be
>  			toggled at runtime via cpusets.
>  
> +			Note that this argument takes precedence over
> +			the CONFIG_RCU_NOCB_CPU_DEFAULT_ALL option.
> +
>  	rcu_nocb_poll	[KNL]
>  			Rather than requiring that offloaded CPUs
>  			(specified by rcu_nocbs= above) explicitly
> diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> index bf8e341e75b4..746a668bf81d 100644
> --- a/kernel/rcu/Kconfig
> +++ b/kernel/rcu/Kconfig
> @@ -223,6 +223,19 @@ config RCU_NOCB_CPU
>  	  Say Y here if you need reduced OS jitter, despite added overhead.
>  	  Say N here if you are unsure.
>  
> +config RCU_NOCB_CPU_DEFAULT_ALL
> +	bool "Offload RCU callback processing from all CPUs by default"
> +	depends on RCU_NOCB_CPU
> +	default n
> +	help
> +	  Use this option to offload callback processing from all CPUs
> +	  by default, in the absence of the rcu_nocbs or nohz_full boot
> +	  parameter. This also avoids the need to use any boot parameters
> +	  to achieve the effect of offloading all CPUs on boot.
> +
> +	  Say Y here if you want offload all CPUs by default on boot.
> +	  Say N here if you are unsure.
> +
>  config TASKS_TRACE_RCU_READ_MB
>  	bool "Tasks Trace RCU readers use memory barriers in user and idle"
>  	depends on RCU_EXPERT
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index eeafb546a7a0..f648f773600a 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -1166,11 +1166,21 @@ void __init rcu_init_nohz(void)
>  {
>  	int cpu;
>  	bool need_rcu_nocb_mask = false;
> +	bool offload_all = false;
>  	struct rcu_data *rdp;
>  
> +#if defined(CONFIG_RCU_NOCB_CPU_DEFAULT_ALL)
> +	if (!rcu_nocb_is_setup) {
> +		need_rcu_nocb_mask = true;
> +		offload_all = true;
> +	}
> +#endif
> +
>  #if defined(CONFIG_NO_HZ_FULL)
> -	if (tick_nohz_full_running && cpumask_weight(tick_nohz_full_mask))
> +	if (tick_nohz_full_running && cpumask_weight(tick_nohz_full_mask)) {
>  		need_rcu_nocb_mask = true;
> +		offload_all = false; /* NO_HZ_FULL has its own mask. */
> +	}
>  #endif /* #if defined(CONFIG_NO_HZ_FULL) */
>  
>  	if (need_rcu_nocb_mask) {
> @@ -1191,6 +1201,9 @@ void __init rcu_init_nohz(void)
>  		cpumask_or(rcu_nocb_mask, rcu_nocb_mask, tick_nohz_full_mask);
>  #endif /* #if defined(CONFIG_NO_HZ_FULL) */
>  
> +	if (offload_all)
> +		cpumask_setall(rcu_nocb_mask);
> +
>  	if (!cpumask_subset(rcu_nocb_mask, cpu_possible_mask)) {
>  		pr_info("\tNote: kernel parameter 'rcu_nocbs=', 'nohz_full', or 'isolcpus=' contains nonexistent CPUs.\n");
>  		cpumask_and(rcu_nocb_mask, cpu_possible_mask,
> -- 
> 2.36.0.rc0.470.gd361397f0d-goog
> 
> 
