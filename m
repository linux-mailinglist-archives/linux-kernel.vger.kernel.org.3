Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4B153F823
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 10:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238163AbiFGI1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 04:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbiFGI1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 04:27:48 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 00B842C673
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 01:27:46 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 839CB143D;
        Tue,  7 Jun 2022 01:27:46 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7D36A3F73B;
        Tue,  7 Jun 2022 01:27:44 -0700 (PDT)
Message-ID: <c183ab0d-24db-3191-bfd1-a390162cd53c@arm.com>
Date:   Tue, 7 Jun 2022 10:27:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3] sched/fair: static cpumasks for load balance
Content-Language: en-US
To:     Bing Huang <huangbing@kylinos.cn>, peterz@infradead.org
Cc:     brauner@kernel.org, bristot@redhat.com, bsegall@google.com,
        juri.lelli@redhat.com, linux-kernel@vger.kernel.org,
        mgorman@suse.de, mingo@redhat.com, rostedt@goodmis.org,
        vincent.guittot@linaro.org
References: <20220602030135.398697-1-huangbing@kylinos.cn>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20220602030135.398697-1-huangbing@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/06/2022 05:01, Bing Huang wrote:
> The both cpu mask load_balance_mask and select_idle_mask just only used
> in fair.c, but allocation in core.c in CONFIG_CPUMASK_OFFSTACK=y case,
> and global via declare per cpu variations. More or less, it looks wired.

Maybe you can change this into:

sched/fair: Make per-cpu cpumasks static

load_balance_mask and select_idle_mask are only used in fair.c. Make
them static and move their allocation into init_sched_fair_class().

Replace kzalloc_node() with zalloc_cpumask_var_node() to get rid of the
CONFIG_CPUMASK_OFFSTACK #ifdef and to align with per-cpu cpumask
allocation for RT (local_cpu_mask in init_sched_rt_class()) and DL
class (local_cpu_mask_dl in init_sched_dl_class()).

> Co-developed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

You can remove the `Co-developed-by`. I was just reviewing the patch and
gave suggestions.

[...]

> @@ -11841,6 +11841,15 @@ void show_numa_stats(struct task_struct *p, struct seq_file *m)
>  __init void init_sched_fair_class(void)
>  {
>  #ifdef CONFIG_SMP
> +	int i;
> +
> +	for_each_possible_cpu(i) {
> +		zalloc_cpumask_var_node(&per_cpu(load_balance_mask, i),
> +								GFP_KERNEL, cpu_to_node(i));
> +		zalloc_cpumask_var_node(&per_cpu(select_idle_mask, i),
> +								GFP_KERNEL, cpu_to_node(i));

@@ -11815,9 +11815,9 @@ __init void init_sched_fair_class(void)
 
        for_each_possible_cpu(i) {
                zalloc_cpumask_var_node(&per_cpu(load_balance_mask, i),
-                                                               GFP_KERNEL, cpu_to_node(i));
+                                       GFP_KERNEL, cpu_to_node(i));
                zalloc_cpumask_var_node(&per_cpu(select_idle_mask, i),
-                                                               GFP_KERNEL, cpu_to_node(i));
+                                       GFP_KERNEL, cpu_to_node(i));
        }

[...]

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
