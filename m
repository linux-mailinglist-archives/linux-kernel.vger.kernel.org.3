Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D6750FC7C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 14:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346343AbiDZMIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 08:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346373AbiDZMIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 08:08:46 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E66EB16C;
        Tue, 26 Apr 2022 05:05:35 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="351996298"
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="351996298"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 05:05:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="538655307"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 26 Apr 2022 05:05:35 -0700
Received: from abityuts-desk1.fi.intel.com (abityuts-desk1.fi.intel.com [10.237.72.79])
        by linux.intel.com (Postfix) with ESMTP id 9635558090D;
        Tue, 26 Apr 2022 05:05:32 -0700 (PDT)
Message-ID: <97e7e3f5110702fab727b4df7d53511aef5c60b1.camel@gmail.com>
Subject: Re: [RFC PATCH v3 2/5] cpuidle: Add Cpufreq Active Stats calls
 tracking idle entry/exit
From:   Artem Bityutskiy <dedekind1@gmail.com>
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org
Cc:     dietmar.eggemann@arm.com, viresh.kumar@linaro.org,
        rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, amit.kachhap@gmail.com,
        linux-pm@vger.kernel.org
Date:   Tue, 26 Apr 2022 15:05:31 +0300
In-Reply-To: <20220406220809.22555-3-lukasz.luba@arm.com>
References: <20220406220809.22555-1-lukasz.luba@arm.com>
         <20220406220809.22555-3-lukasz.luba@arm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

On Wed, 2022-04-06 at 23:08 +0100, Lukasz Luba wrote:
> @@ -231,6 +232,8 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct
> cpuidle_driver *drv,
>         trace_cpu_idle(index, dev->cpu);
>         time_start = ns_to_ktime(local_clock());
>  
> +       cpufreq_active_stats_cpu_idle_enter(time_start);
> +
>         stop_critical_timings();
>         if (!(target_state->flags & CPUIDLE_FLAG_RCU_IDLE))
>                 rcu_idle_enter();
> @@ -243,6 +246,8 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct
> cpuidle_driver *drv,
>         time_end = ns_to_ktime(local_clock());
>         trace_cpu_idle(PWR_EVENT_EXIT, dev->cpu);
>  
> +       cpufreq_active_stats_cpu_idle_exit(time_end);
> +

At this point the interrupts are still disabled, and they get enabled later. So
the more code you add here and the longer it executes, the longer you delay the
interrupts. Therefore, you are effectively increasing IRQ latency from idle by
adding more code here.

How much? I do not know, depends on how much code you need to execute. But the
amount of code in functions like this tends to increase over time.

So the risk is that we'll keep making 'cpufreq_active_stats_cpu_idle_exit()',
and (may be unintentionally) increase idle interrupt latency.

This is not ideal.

We use the 'wult' tool (https://github.com/intel/wult) to measure C-states
latency and interrupt latency on Intel platforms, and for fast C-states like
Intel C1, we can see that even the current code between C-state exit and
interrupt re-enabled adds measurable overhead.

I am worried about adding more stuff here.

Please, consider getting the stats after interrupts are re-enabled. You may lose
some "precision" because of that, but it is probably overall better that adding
to idle interrupt latency.

>         /* The cpu is no longer idle or about to enter idle. */
>         sched_idle_set_state(NULL);


