Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49F55539FC4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 10:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350979AbiFAIpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 04:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350945AbiFAIpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 04:45:14 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8F1A569721
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 01:45:13 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 290DE23A;
        Wed,  1 Jun 2022 01:45:13 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2A1233F73D;
        Wed,  1 Jun 2022 01:45:11 -0700 (PDT)
Message-ID: <b1c1bfa7-f1ba-8590-65fb-df6b8c0d1168@arm.com>
Date:   Wed, 1 Jun 2022 10:45:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2] sched/fair: static cpumasks for load balance
Content-Language: en-US
To:     Bing Huang <huangbing@kylinos.cn>, peterz@infradead.org
Cc:     brauner@kernel.org, bristot@redhat.com, bsegall@google.com,
        juri.lelli@redhat.com, linux-kernel@vger.kernel.org,
        mgorman@suse.de, mingo@redhat.com, rostedt@goodmis.org,
        vincent.guittot@linaro.org
References: <20220531031255.30966-1-huangbing@kylinos.cn>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20220531031255.30966-1-huangbing@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/05/2022 05:12, Bing Huang wrote:
> The both cpu mask load_balance_mask and select_idle_mask just only used
> in fair.c, but allocation in core.c in CONFIG_CPUMASK_OFFSTACK=y case,
> and global via declare per cpu variations. More or less, it looks wired.
> 
> Signed-off-by: Bing Huang <huangbing@kylinos.cn>
> ---
> 
>  v2: move load_balance_mask and select_idle_mask allocation from
> sched_init() to init_sched_fair_class()

This would align CFS with RT (local_cpu_mask) and DL
(local_cpu_mask_dl).

[...]

> @@ -11841,6 +11841,16 @@ void show_numa_stats(struct task_struct *p, struct seq_file *m)
>  __init void init_sched_fair_class(void)
>  {
>  #ifdef CONFIG_SMP

    `int i` missing for DEBUG_PER_CPU_MAPS/CONFIG_CPUMASK_OFFSTACK case.

> +
> +#ifdef CONFIG_CPUMASK_OFFSTACK
> +	for_each_possible_cpu(i) {
> +		per_cpu(load_balance_mask, i) = (cpumask_var_t)kzalloc_node(
> +			cpumask_size(), GFP_KERNEL, cpu_to_node(i));
> +		per_cpu(select_idle_mask, i) = (cpumask_var_t)kzalloc_node(
> +			cpumask_size(), GFP_KERNEL, cpu_to_node(i));
> +	}
> +#endif
> +

What about:

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 98319b654788..9ef5133c72d6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11811,15 +11811,14 @@ void show_numa_stats(struct task_struct *p, struct seq_file *m)
 __init void init_sched_fair_class(void)
 {
 #ifdef CONFIG_SMP
+       int i;
 
-#ifdef CONFIG_CPUMASK_OFFSTACK
        for_each_possible_cpu(i) {
-               per_cpu(load_balance_mask, i) = (cpumask_var_t)kzalloc_node(
-                       cpumask_size(), GFP_KERNEL, cpu_to_node(i));
-               per_cpu(select_idle_mask, i) = (cpumask_var_t)kzalloc_node(
-                       cpumask_size(), GFP_KERNEL, cpu_to_node(i));
+               zalloc_cpumask_var_node(&per_cpu(load_balance_mask, i),
+                                       GFP_KERNEL, cpu_to_node(i));
+               zalloc_cpumask_var_node(&per_cpu(select_idle_mask, i),
+                                       GFP_KERNEL, cpu_to_node(i));
        }
-#endif

to get rid of the #ifdef ? We do the same for RT (local_cpu_mask) and DL
(local_cpu_mask_dl).

[...]
