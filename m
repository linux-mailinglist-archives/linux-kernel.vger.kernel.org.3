Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9B0947A56F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 08:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234421AbhLTHif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 02:38:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232225AbhLTHie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 02:38:34 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944EBC061574
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 23:38:34 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id v25so3558029pge.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 23:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=kz9CGPu+qcyNzfgsh0eLlnl2PhsMfFh4FqJwuDDdwjY=;
        b=aP4aAClcYaYdvX32umHD67g+4wneIP6wkSfT5Cq1s2ApcHUBNw7bqttgpY64MEEe2z
         5hbWKLWD7/05v4sPZz+dcvfSW841gnE492OFIT6WUJcnldyvZFItiIhI4CI6OoJCSDGu
         iDEEqZnruca/gYWcivOGh3fn4rdQ4rNsRuwvUs/pxTZoo6sLc6Ftp1sO/XPGFdhBfrHi
         VOyB4PF9MQcjgjPA83m5zUigNpaJuYP5aiMKLR8jGepcwiQAepv6+ts2GwhbNK5t4GeT
         5uPvDSF35ffg2lx4ydLJDEU97ZY3Rp2ebUheWveuxWx3woATQrtgUOpFtT3uO39YfJr+
         nfQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kz9CGPu+qcyNzfgsh0eLlnl2PhsMfFh4FqJwuDDdwjY=;
        b=3QOY7qYpM3UWZUwbvgM56PpJaOl6Y08kyuXOh3u0batNNYiUBSmMiCINfuR489lSQ0
         Ha8cl4SWJA824a+s8gtuU5svPsinboSObHl/FJmVx2ry4MTDj2s8Eb6t6z5lyqFpd7Og
         uCZ9y/jI7/ndV/5IXRToIideFmGUR3fhktfz8B2Zi5pFJp5+xbXPTFUeDdcP8/AzTrgC
         KlFZZ+ygN71grYoQnlmXrQvfN38m6omxhtI2Y3LtT4HejmF0pNSduSAsKOm3sNUSZqF2
         +zaZ9SRtlruEPpuPOGnhwCEysnrnC3HAfIAaz9lTSVjRSpqp1lq5A3ajGbqBY6/TAFmn
         VdfQ==
X-Gm-Message-State: AOAM532igtRue9w8mTwNnTfOBJkaYNfrO1LUyE54STijTaHHW7KVwMsm
        dGmD9ErLzgQY4kEopPgT1SE7jg==
X-Google-Smtp-Source: ABdhPJyOIciwHIKNCAyy7yxAoC2Vn55Rnkci/LcIm3ekwVjMK296xLzbG+9dP8tLhS4lsV9OY5x8sQ==
X-Received: by 2002:a05:6a00:1946:b0:492:64f1:61b5 with SMTP id s6-20020a056a00194600b0049264f161b5mr14926149pfk.52.1639985914115;
        Sun, 19 Dec 2021 23:38:34 -0800 (PST)
Received: from [10.255.173.206] ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id mu2sm5301805pjb.43.2021.12.19.23.38.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Dec 2021 23:38:33 -0800 (PST)
Message-ID: <c27af938-5f96-f153-63b5-df7e2d3f2e3e@bytedance.com>
Date:   Mon, 20 Dec 2021 15:38:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH] sched/cpuacct: fix percpu time accounting
Content-Language: en-US
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com
Cc:     rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        Xuan Lu <luxuan.windniw@bytedance.com>,
        Minye Zhu <zhuminye@bytedance.com>,
        Qiang Wang <wangqiang.wq.frank@bytedance.com>
References: <20211208073836.70619-1-zhouchengming@bytedance.com>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20211208073836.70619-1-zhouchengming@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping guys. Any comments or suggestions?

On 2021/12/8 3:38 下午, Chengming Zhou wrote:
> The usage percpu data is the CPU time consumed on each CPU by all tasks
> in this cgroup (including tasks lower in the hierarchy). When cpuacct_charge
> called from other CPUs, we should use the CPU of task, not this CPU.
> 
> e.g.
>     cpuacct_charge+1
>     update_curr+332
>     enqueue_entity+70
>     enqueue_task_fair+169
>     activate_task+57
>     attach_task+46
>     load_balance+1512
>     run_rebalance_domains+451
>     __do_softirq+282
>     sysvec_apic_timer_interrupt+159
>     asm_sysvec_apic_timer_interrupt+18
>     native_safe_halt+11
>     default_idle+10
>     default_enter_idle+45
>     cpuidle_enter_state+130
>     cpuidle_enter+47
>     do_idle+489
>     cpu_startup_entry+25
>     start_secondary+261
>     secondary_startup_64_no_verify+176
> 
> Reported-by: Xuan Lu <luxuan.windniw@bytedance.com>
> Reported-by: Minye Zhu <zhuminye@bytedance.com>
> Co-developed-by: Qiang Wang <wangqiang.wq.frank@bytedance.com>
> Signed-off-by: Qiang Wang <wangqiang.wq.frank@bytedance.com>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  kernel/sched/cpuacct.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/cpuacct.c b/kernel/sched/cpuacct.c
> index 893eece65bfd..aab51c88bd34 100644
> --- a/kernel/sched/cpuacct.c
> +++ b/kernel/sched/cpuacct.c
> @@ -341,6 +341,7 @@ void cpuacct_charge(struct task_struct *tsk, u64 cputime)
>  	struct cpuacct *ca;
>  	int index = CPUACCT_STAT_SYSTEM;
>  	struct pt_regs *regs = get_irq_regs() ? : task_pt_regs(tsk);
> +	unsigned int cpu = task_cpu(tsk);
>  
>  	if (regs && user_mode(regs))
>  		index = CPUACCT_STAT_USER;
> @@ -348,7 +349,7 @@ void cpuacct_charge(struct task_struct *tsk, u64 cputime)
>  	rcu_read_lock();
>  
>  	for (ca = task_ca(tsk); ca; ca = parent_ca(ca))
> -		__this_cpu_add(ca->cpuusage->usages[index], cputime);
> +		per_cpu_ptr(ca->cpuusage, cpu)->usages[index] += cputime;
>  
>  	rcu_read_unlock();
>  }
