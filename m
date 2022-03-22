Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF90C4E3BD2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 10:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbiCVJja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 05:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232645AbiCVJjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 05:39:21 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E1397EA0F
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 02:37:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0AE85106F;
        Tue, 22 Mar 2022 02:37:54 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B18B73F66F;
        Tue, 22 Mar 2022 02:37:52 -0700 (PDT)
Message-ID: <8ea80393-866e-9c31-85e9-46d738d24047@arm.com>
Date:   Tue, 22 Mar 2022 10:37:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH v3 7/7] sched/fair: Remove the energy margin in feec()
To:     Vincent Donnefort <vincent.donnefort@arm.com>,
        peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, morten.rasmussen@arm.com,
        chris.redpath@arm.com, qperret@google.com
References: <20220308181957.280354-1-vincent.donnefort@arm.com>
 <20220308181957.280354-8-vincent.donnefort@arm.com>
Content-Language: en-US
In-Reply-To: <20220308181957.280354-8-vincent.donnefort@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2022 19:19, Vincent Donnefort wrote:

[...]

> 1. The energy estimation is not a good absolute value:
> 
> The function, compute_energy() used in feec() is a good estimation for

s/The function, compute_energy()/compute_energy() ... shorter

[...]

> util_avg represents integrates the near history for a CPU usage,

s/util_avg represents integrates/util_avg contains ?

[...]

> 2. The margin handicaps small tasks:
> 
> On a system where the workload is composed mostly of small tasks (which is
> often the case on Android), the overall energy will be high enough to
> create a margin none of those tasks can cross. e.g. On a Pixel4, a small

s/e.g.// ?

[...]

> Without a margin, we could have feared bouncing between CPUs. But running
> LISA's eas_behaviour test coverage on three different platforms (Hikey960,
> RB-5 and DB-845) showed no issue and even fixed previously known failures.

Can you be more specific what those fixes are? I think you mention (some
of) them in the cover letter. It's just that when somebody will read
this patch, once it's in, this information is not there.

You could also add
https://developer.arm.com/tools-and-software/open-source-software/linux-kernel/energy-aware-scheduling/eas-mainline-development
to the cover letter so people can get more information about those EAS
behaviour tests.

[...]

> @@ -6736,7 +6736,6 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>  	struct root_domain *rd = cpu_rq(smp_processor_id())->rd;
>  	int cpu, best_energy_cpu = prev_cpu, target = -1;

Nit-picking: IMHO, best_energy_cpu doesn't have to be initialized
anymore since we only use it now when `best_delta < prev_delta`,
hence best_energy_cpu has to be set at least once.

[...]

> @@ -6851,12 +6849,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>  	}
>  	rcu_read_unlock();
>  
> -	/*
> -	 * Pick the best CPU if prev_cpu cannot be used, or if it saves at
> -	 * least 6% of the energy used by prev_cpu.
> -	 */
> -	if ((prev_delta == ULONG_MAX) ||
> -	    (prev_delta - best_delta) > ((prev_delta + base_energy) >> 4))
> +	if (best_delta < prev_delta)
>  		target = best_energy_cpu;
>  
>  	return target;

Can we now move the `unlock:` before the first rcu_read_unlock()?
All error case have best_delta and prev_delta = ULONG_MAX so we return
`target = -1` or `target = prev_cpu` correctly.

@@ -6960,17 +6960,13 @@ static int find_energy_efficient_cpu(struct
task_struct *p, int prev_cpu)
                        }
                }
        }
+unlock:
        rcu_read_unlock();
         if (best_delta < prev_delta)
                target = best_energy_cpu;
         return target;
-
-unlock:
-       rcu_read_unlock();
-
-       return target;
