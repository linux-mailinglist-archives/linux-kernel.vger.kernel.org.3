Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB6558C553
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 11:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242207AbiHHJMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 05:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234736AbiHHJMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 05:12:52 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EEACCE30
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 02:12:51 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id l64so8100813pge.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 02:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=G/Xab+mN16kwI2HFsbVg3sMBwvi+PuGpSqbAbS+t4GQ=;
        b=acKmoibMRcnqZJbrp8oZxE/hILv8Ifot3fvC7RnTQHv6lfdopPrFy226CoE5sw/y91
         j/xK62RuIbnm4gsTDY/voIwN/Mfp/Vna5nh3sd+sZgYi8vEMidBMuPTHTqo2zFP7Rdkr
         j6AgGh2wpbh+8SEhDMBAswsAHSHgMKZ590TMRUI6UB3t/N9y2UDIDVHG2rIzxoqhiu8Q
         d/WJWKCmiIkYhJffoazCD+kLj+taP6O8GEPUpyM9Hpfh1CDiOP4A8MJ5ySUgBpKEiC+s
         aRSYr9S0wkEpIuBE5o+TYsSH4DCEjt2hZn8XLjoZvmqZuhncbregSbD3XV4FdbIT9uEw
         MKFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=G/Xab+mN16kwI2HFsbVg3sMBwvi+PuGpSqbAbS+t4GQ=;
        b=Herd5l08OeSq7UQVu30ypnbSpNzYQJrHf4Xdslhknq+626I9EA04EqP7cv7OC1a+cj
         9qfd1OVVtZtFHFozJsZj76h1h6g1fAGH5lgJXYh220z0mvMd4Ahu4XhXQGHuXoUZrCXp
         egUCXH1mgUbw/Y/8UKkVDCEScqG7jPjKESa7j/M9kZQDXO67hkAv4QgXW7moCr6tu03R
         VF6xY96QZjZX7ks/SETnMv3fMMEzM74Uyh14dsJ07IAQPIFD1JU0I4ZxVxsVBS9npr33
         oP8qpRYBBviaO5uuSxuT3flnTsqBxImhfSVbBpHiGQ4IESuVzEMyQrRdRSS0xiaHvL58
         0+5A==
X-Gm-Message-State: ACgBeo0y+AkcrLbc2CvJFdQ/6Iz6wTx4dqxMVkfNW1UqAhC2qv8IHg9v
        Czs9W+/Qsb5B3Sl7R39a/tmO0MT7J1C71w==
X-Google-Smtp-Source: AA6agR71NGwYMntEw+G2HEGd4eXBdRDeAhS4t9c31ectX/E8i3NoMXnyrhsBPaUwN/1Efh4k5/4J5w==
X-Received: by 2002:a05:6a00:1d26:b0:52b:fb6f:e44d with SMTP id a38-20020a056a001d2600b0052bfb6fe44dmr17720076pfx.6.1659949970478;
        Mon, 08 Aug 2022 02:12:50 -0700 (PDT)
Received: from [10.254.250.112] ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id x10-20020aa79aca000000b0052e6d5ee183sm7968859pfp.129.2022.08.08.02.12.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 02:12:49 -0700 (PDT)
Message-ID: <cb20ece8-3053-1b6c-5820-08663e5c1acc@bytedance.com>
Date:   Mon, 8 Aug 2022 17:12:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.0
Subject: Re: [RFC PATCH] psi: introduce PSI UNINTERRUPTIBLE
Content-Language: en-US
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com,
        xuewen.yan@unisoc.com
References: <1659939208-22454-1-git-send-email-zhaoyang.huang@unisoc.com>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <1659939208-22454-1-git-send-email-zhaoyang.huang@unisoc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/8/8 14:13, zhaoyang.huang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> Uninterruptible sleep has not been monitored as an important system status yet.
> Imagin that a set of psi triggers are created for monitoring a special group, while
> get nothing high for none of the pressures, which could be the processes within
> are stock in some given resources and turn to be UN status. Introduce PSI_UN as
> a sub-type among PSI system here.

Hello,

The problem is that not all TASK_UNINTERRUPTIBLE task means stalled on some
shared resource, like many schedule_timeout() paths.

Thanks.

> 
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
>  include/linux/psi_types.h | 11 ++++++++---
>  kernel/sched/psi.c        | 10 ++++++++++
>  kernel/sched/stats.h      |  6 +++++-
>  3 files changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
> index c7fe7c0..8cc1979 100644
> --- a/include/linux/psi_types.h
> +++ b/include/linux/psi_types.h
> @@ -15,6 +15,7 @@ enum psi_task_count {
>  	NR_IOWAIT,
>  	NR_MEMSTALL,
>  	NR_RUNNING,
> +	NR_UNINTERRUPTIBLE,
>  	/*
>  	 * This can't have values other than 0 or 1 and could be
>  	 * implemented as a bit flag. But for now we still have room
> @@ -32,7 +33,7 @@ enum psi_task_count {
>  	 * threads and memstall ones.
>  	 */
>  	NR_MEMSTALL_RUNNING,
> -	NR_PSI_TASK_COUNTS = 5,
> +	NR_PSI_TASK_COUNTS = 6,
>  };
>  
>  /* Task state bitmasks */
> @@ -41,13 +42,15 @@ enum psi_task_count {
>  #define TSK_RUNNING	(1 << NR_RUNNING)
>  #define TSK_ONCPU	(1 << NR_ONCPU)
>  #define TSK_MEMSTALL_RUNNING	(1 << NR_MEMSTALL_RUNNING)
> +#define TSK_UNINTERRUPTIBLE	(1 << NR_UNINTERRUPTIBLE)
>  
>  /* Resources that workloads could be stalled on */
>  enum psi_res {
>  	PSI_IO,
>  	PSI_MEM,
>  	PSI_CPU,
> -	NR_PSI_RESOURCES = 3,
> +	PSI_UN,
> +	NR_PSI_RESOURCES = 4,
>  };
>  
>  /*
> @@ -63,9 +66,11 @@ enum psi_states {
>  	PSI_MEM_FULL,
>  	PSI_CPU_SOME,
>  	PSI_CPU_FULL,
> +	PSI_UN_SOME,
> +	PSI_UN_FULL,
>  	/* Only per-CPU, to weigh the CPU in the global average: */
>  	PSI_NONIDLE,
> -	NR_PSI_STATES = 7,
> +	NR_PSI_STATES = 9,
>  };
>  
>  enum psi_aggregators {
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index a337f3e..a37b4a4 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -231,6 +231,10 @@ static bool test_state(unsigned int *tasks, enum psi_states state)
>  		return unlikely(tasks[NR_RUNNING] > tasks[NR_ONCPU]);
>  	case PSI_CPU_FULL:
>  		return unlikely(tasks[NR_RUNNING] && !tasks[NR_ONCPU]);
> +	case PSI_UN_SOME:
> +		return unlikely(tasks[NR_UNINTERRUPTIBLE]);
> +	case PSI_UN_FULL:
> +		return unlikely(tasks[NR_UNINTERRUPTIBLE] && !tasks[NR_RUNNING]);
>  	case PSI_NONIDLE:
>  		return tasks[NR_IOWAIT] || tasks[NR_MEMSTALL] ||
>  			tasks[NR_RUNNING];
> @@ -683,6 +687,12 @@ static void record_times(struct psi_group_cpu *groupc, u64 now)
>  			groupc->times[PSI_CPU_FULL] += delta;
>  	}
>  
> +	if (groupc->state_mask & (1 << PSI_UN_SOME)) {
> +		groupc->times[PSI_UN_SOME] += delta;
> +		if (groupc->state_mask & (1 << PSI_UN_FULL))
> +			groupc->times[PSI_UN_FULL] += delta;
> +	}
> +
>  	if (groupc->state_mask & (1 << PSI_NONIDLE))
>  		groupc->times[PSI_NONIDLE] += delta;
>  }
> diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
> index baa839c..bf98829 100644
> --- a/kernel/sched/stats.h
> +++ b/kernel/sched/stats.h
> @@ -132,6 +132,7 @@ static inline void psi_enqueue(struct task_struct *p, bool wakeup)
>  		if (p->in_iowait)
>  			clear |= TSK_IOWAIT;
>  	}
> +	clear |= TSK_UNINTERRUPTIBLE;
>  
>  	psi_task_change(p, clear, set);
>  }
> @@ -139,6 +140,7 @@ static inline void psi_enqueue(struct task_struct *p, bool wakeup)
>  static inline void psi_dequeue(struct task_struct *p, bool sleep)
>  {
>  	int clear = TSK_RUNNING;
> +	int set = 0;
>  
>  	if (static_branch_likely(&psi_disabled))
>  		return;
> @@ -154,8 +156,10 @@ static inline void psi_dequeue(struct task_struct *p, bool sleep)
>  
>  	if (p->in_memstall)
>  		clear |= (TSK_MEMSTALL | TSK_MEMSTALL_RUNNING);
> +	if (READ_ONCE(p->__state) & TASK_UNINTERRUPTIBLE)
> +		set = TSK_UNINTERRUPTIBLE;
>  
> -	psi_task_change(p, clear, 0);
> +	psi_task_change(p, clear, set);
>  }
>  
>  static inline void psi_ttwu_dequeue(struct task_struct *p)
