Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 999D34FE783
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 19:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358574AbiDLR6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 13:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358566AbiDLR6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 13:58:32 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ECC256772
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 10:56:14 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id n8so17477604plh.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 10:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=duMLjXXSp+3x3Vpexq1XWCVJ2W30Z5wERCDm4MvZ+H8=;
        b=BoilKWjYH8gYAOhLmSP2CxTyaMJiMb/5pRbF/tYkSr6SBBc3Pi3l9VCak5rrH6QX/U
         neZ1UBww70+jRcoXs2wKH6USZVu7X3cIwhBsutf3bQpnnqkw23RPRuXwEDCaSenoJ9B5
         rTRqn12FEgp0kI9ec1JqwXvYdmS5AW9dt31GbwvSvzMNgJ8wqhVSuo+4u6lA9+IkjrEH
         ubQ2L+RyzCed10YQ/TcsUzrzFKitNpPji47y+wlsqid0AiSF+j1mbF+6lsvlas03TMyJ
         ljmdTCQ+Kk5PNZZ/OvmhdLlydumHAbyPORqXtsvo9OJn6tozEZSrKoVqEkziEQjaHgxa
         76KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=duMLjXXSp+3x3Vpexq1XWCVJ2W30Z5wERCDm4MvZ+H8=;
        b=FlkO2UETSASJGvO11rSoCuCcA2xjKwph/IrFUICVrx0H0Kfhklv1iMr4arD1FAgWjy
         SjDJBHD/4ulOpoCO1zgIFAlaxzy9BIa1x1+lb9zPYyqzuJ3NhLtKhS2Dbf32vCriPjxH
         wr6yiEm8rXMwIX74klHrT9yIHmscluTX1arvmxLFtroUS2+NAhYqSz6qFQMNRyQFRvUw
         k6AIjFYYqqLPkfIUwHtYTJ5Llxc7CUnc0rZ+iFwVkKxZnY76XM0lE6tr7RZ15NDegxYr
         kwHIZJFILkminJzzVpso1RYG5SdQfS+NBKDMsYR4Vu09wWZRsEvzBKcnWs999Y6WFB8b
         zovQ==
X-Gm-Message-State: AOAM5322XswjFnhAnk31bbFd0lzND9RsJAfvZpVDuBMEkgmQCIleXTTO
        Fu87uh/lrQNj2kPTVAElJvuSZA==
X-Google-Smtp-Source: ABdhPJxozl9RkEaFgOG4PqxTXu2LLqvqP8w0SfI/ucfJvtq+uM8dSIjl8EHkl6YytFvAR3lBOR5VJA==
X-Received: by 2002:a17:902:e54b:b0:158:2df3:9ced with SMTP id n11-20020a170902e54b00b001582df39cedmr20132359plf.4.1649786174108;
        Tue, 12 Apr 2022 10:56:14 -0700 (PDT)
Received: from [10.254.90.123] ([139.177.225.252])
        by smtp.gmail.com with ESMTPSA id f19-20020a056a00229300b004fb157f136asm40427774pfe.153.2022.04.12.10.56.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 10:56:13 -0700 (PDT)
Message-ID: <801da029-6bbe-2a0c-7de0-afffc3d5de02@bytedance.com>
Date:   Wed, 13 Apr 2022 01:56:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [RFC v2 2/2] sched/fair: introduce sched-idle balance
Content-Language: en-US
To:     Josh Don <joshdon@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Abel Wu <wuyun.abel@bytedance.com>
References: <20220409135104.3733193-1-wuyun.abel@bytedance.com>
 <20220409135104.3733193-3-wuyun.abel@bytedance.com>
 <CABk29NvE=Fmgo4xqQLfy-K8j0hNS-+ppGdYt37yDUnRJiqjZ5w@mail.gmail.com>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <CABk29NvE=Fmgo4xqQLfy-K8j0hNS-+ppGdYt37yDUnRJiqjZ5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Josh,

On 4/12/22 9:59 AM, Josh Don Wrote:
> Hi Abel,
> 
>>
>> +static inline bool cfs_rq_busy(struct rq *rq)
>> +{
>> +       return rq->cfs.h_nr_running - rq->cfs.idle_h_nr_running == 1;
>> +}
>> +
>> +static inline bool need_pull_cfs_task(struct rq *rq)
>> +{
>> +       return rq->cfs.h_nr_running == rq->cfs.idle_h_nr_running;
>> +}
> 
> Note that this will also return true if there are 0 tasks, which I
> don't think is the semantics you intend for its use in
> rebalance_domains() below.

I intended covering the idle balance. My last v1 patchset wanted to
ignore the idle balance because of the high cpu wakeup latency, but
after some benchmarking, that seems not necessary.

> 
>>   /*
>>    * Use locality-friendly rq->overloaded to cache the status of the rq
>>    * to minimize the heavy cost on LLC shared data.
>> @@ -7837,6 +7867,22 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
>>          if (kthread_is_per_cpu(p))
>>                  return 0;
>>
>> +       if (unlikely(task_h_idle(p))) {
>> +               /*
>> +                * Disregard hierarchically idle tasks during sched-idle
>> +                * load balancing.
>> +                */
>> +               if (env->idle == CPU_SCHED_IDLE)
>> +                       return 0;
>> +       } else if (!static_branch_unlikely(&sched_asym_cpucapacity)) {
>> +               /*
>> +                * It's not gonna help if stacking non-idle tasks on one
>> +                * cpu while leaving some idle.
>> +                */
>> +               if (cfs_rq_busy(env->src_rq) && !need_pull_cfs_task(env->dst_rq))
>> +                       return 0;
> 
> These checks don't involve the task at all, so this kind of check
> should be pushed into the more general load balance function. But, I'm
> not totally clear on the motivation here. If we have cpu A with 1
> non-idle task and 100 idle tasks, and cpu B with 1 non-idle task, we
> should definitely try to load balance some of the idle tasks from A to
> B. idle tasks _do_ get time to run (although little), and this can add
> up and cause antagonism to the non-idle task if there are a lot of
> idle threads.

CPU_SCHED_IDLE means triggered by sched_idle_balance() in which pulls
a non-idle task for the unoccupied cpu from the overloaded ones, so
idle tasks are not the target and should be skipped.

The second part is: if we have cpu A with 1 non-idle task and 100 idle
tasks, and B with >=1 non-idle task, we don't migrate the last non-idle
task on A to B.

> 
>>
>>   /*
>> + * The sched-idle balancing tries to make full use of cpu capacity
>> + * for non-idle tasks by pulling them for the unoccupied cpus from
>> + * the overloaded ones.
>> + *
>> + * Return 1 if pulled successfully, 0 otherwise.
>> + */
>> +static int sched_idle_balance(struct rq *dst_rq)
>> +{
>> +       struct sched_domain *sd;
>> +       struct task_struct *p = NULL;
>> +       int dst_cpu = cpu_of(dst_rq), cpu;
>> +
>> +       sd = rcu_dereference(per_cpu(sd_llc, dst_cpu));
>> +       if (unlikely(!sd))
>> +               return 0;
>> +
>> +       if (!atomic_read(&sd->shared->nr_overloaded))
>> +               return 0;
>> +
>> +       for_each_cpu_wrap(cpu, sdo_mask(sd->shared), dst_cpu + 1) {
>> +               struct rq *rq = cpu_rq(cpu);
>> +               struct rq_flags rf;
>> +               struct lb_env env;
>> +
>> +               if (cpu == dst_cpu || !cfs_rq_overloaded(rq) ||
>> +                   READ_ONCE(rq->sched_idle_balance))
>> +                       continue;
>> +
>> +               WRITE_ONCE(rq->sched_idle_balance, 1);
>> +               rq_lock_irqsave(rq, &rf);
>> +
>> +               env = (struct lb_env) {
>> +                       .sd             = sd,
>> +                       .dst_cpu        = dst_cpu,
>> +                       .dst_rq         = dst_rq,
>> +                       .src_cpu        = cpu,
>> +                       .src_rq         = rq,
>> +                       .idle           = CPU_SCHED_IDLE, /* non-idle only */
>> +                       .flags          = LBF_DST_PINNED, /* pin dst_cpu */
>> +               };
>> +
>> +               update_rq_clock(rq);
>> +               p = detach_one_task(&env);
>> +               if (p)
>> +                       update_overload_status(rq);
>> +
>> +               rq_unlock(rq, &rf);
>> +               WRITE_ONCE(rq->sched_idle_balance, 0);
>> +
>> +               if (p) {
>> +                       attach_one_task(dst_rq, p);
>> +                       local_irq_restore(rf.flags);
>> +                       return 1;
>> +               }
>> +
>> +               local_irq_restore(rf.flags);
>> +       }
>> +
>> +       return 0;
>> +}
> 
> I think this could probably be integrated with the load balancing
> function. Your goal is ignore idle tasks for the purpose of pulling
> from a remote rq. And I think the above isn't exactly what you want
> anyway; detach_tasks/detach_one_task  are just going to iterate the
> task list in order. You want to actually look for the non-idle tasks
> explicitly.

I have tried a simple version like below (and sched_idle_balance() is
not needed anymore):

@@ -10338,6 +10343,7 @@ static void rebalance_domains(struct rq *rq, 
enum cpu_idle_type idle)
  	int continue_balancing = 1;
  	int cpu = rq->cpu;
  	int busy = idle != CPU_IDLE && !sched_idle_cpu(cpu);
+	int prev_busy = busy;
  	unsigned long interval;
  	struct sched_domain *sd;
  	/* Earliest time when we have to do rebalance again */
@@ -10394,6 +10400,9 @@ static void rebalance_domains(struct rq *rq, 
enum cpu_idle_type idle)
  			next_balance = sd->last_balance + interval;
  			update_next_balance = 1;
  		}
+
+		if (!prev_busy && !need_pull_cfs_task(rq))
+			break;
  	}
  	if (need_decay) {
  		/*

But benchmark results are not good enough compared to RFCv2 patchset.
I would dig more deep into this, thanks.

> 
>> @@ -10996,9 +11119,9 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
>>
>>                  if (sd->flags & SD_BALANCE_NEWIDLE) {
>>
>> -                       pulled_task = load_balance(this_cpu, this_rq,
>> -                                                  sd, CPU_NEWLY_IDLE,
>> -                                                  &continue_balancing);
>> +                       pulled_task |= load_balance(this_cpu, this_rq,
>> +                                                   sd, CPU_NEWLY_IDLE,
>> +                                                   &continue_balancing);
> 
> Why |= ?

This is because I changed the behavior of newidle balance a bit. Vanilla
kernel will quit newidle balance once we got task to run on this rq, no
matter the task is non-idle or not. But after this patch, if there are
overloaded cpus in this LLC, we will try harder on balance until we got
non-idle tasks, which means the balancing would be continue even if now
the cpu is sched_idle.

Thanks & BR,
Abel

