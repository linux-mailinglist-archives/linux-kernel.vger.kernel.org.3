Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D06570894
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 18:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbiGKQzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 12:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiGKQyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 12:54:55 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF863247B
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 09:54:54 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id r1so4918279plo.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 09:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=E2FmQyfed+Q8TGkvCvVr0OnqvKCecvaPeA8klR27MsI=;
        b=Cvef8bWu/4/doJVmPp3ynM4dQ68bM/1Uv5FQJ2remURFB3tL4Z+f/IifQELxQinkIk
         M8yQ3InLvKdlpdj67/z8nZUKZyD6VDdadCEnit9YiCzue6eKwfzALVt2dEQ2jqqB1ZcY
         mkzz2RV/kQQ7/rHwPrdOT8EZM8FInFSwTklkEEqAzUoe6l5+kQ8VggrMzHyVg2pFxs1N
         nset0elw/YB5IFeXpA6kCTwaHHzhDCoVJMlkDmyz2baewRLhGY7ZzabyRw+fNPix6F9k
         WIufOya3XiSzI0J1EglAzmJaZe4n8hsZ+VVTqy6zWeyjgLwM8cpQ+uzmsCyXyZE3ld4L
         uENQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=E2FmQyfed+Q8TGkvCvVr0OnqvKCecvaPeA8klR27MsI=;
        b=qeTdDZbKcsMY/d9IzygoAhR7v0ZkUpJtxobb4SWbc4ZBlcCVGWb2pyMlr/IxkdEu2n
         zm0TFSc8rP1itlWzScT2V8Tw8bpJOVBsyD3hK9SlnkB4dJHoSogNN4YAqEo8YxlUijW0
         AiCynXRDC/JmpKnrvMV85Hr1Kdu8C3/iaCT177wBcL+EtxEu9cTfxaHQGqewMv/6KrrJ
         w9cXFJNG2G0de7mt2KWm5QOgTvzyM7d0GMUwlli1HInxodwcqMIO4nOfytOFZr5KbHMM
         L/wZY6eaEhjDBctKaQhin5FkbnYqZNodDxc560QHLAUOkXTlbplGotty0ZsT4BjEQZ26
         Fb8Q==
X-Gm-Message-State: AJIora9wKeb9bYDiTB4qACPt4SQKndi1hzC7jRwhyluZJ6VTvJeM79Xw
        Ky9N9ga7rVdQ2wTxny3oYChT4w==
X-Google-Smtp-Source: AGRyM1tlD4GA3cwUsjuiN4TiUfgy2omu6KihsC5Y5zsFy2C0OZzBBQJZOjMP5x1P+lJj1vaarM/Tog==
X-Received: by 2002:a17:90b:1e0e:b0:1ef:97f9:dfb5 with SMTP id pg14-20020a17090b1e0e00b001ef97f9dfb5mr18858898pjb.217.1657558494367;
        Mon, 11 Jul 2022 09:54:54 -0700 (PDT)
Received: from [10.255.242.206] ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id e20-20020aa79814000000b00528c7ac7f27sm4975736pfl.81.2022.07.11.09.54.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 09:54:53 -0700 (PDT)
Message-ID: <b74c3ab0-3509-8483-170b-852b079c4c60@bytedance.com>
Date:   Tue, 12 Jul 2022 00:54:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.0.1
Subject: Re: [PATCH 8/8] sched/fair: delete superfluous SKIP_AGE_LOAD
Content-Language: en-US
To:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org
References: <20220709151353.32883-1-zhouchengming@bytedance.com>
 <20220709151353.32883-9-zhouchengming@bytedance.com>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20220709151353.32883-9-zhouchengming@bytedance.com>
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

On 2022/7/9 23:13, Chengming Zhou wrote:
> All three attach_entity_cfs_rq() types:
> 
> 1. task migrate CPU
> 2. task migrate cgroup
> 3. task switched to fair
> 
> have its sched_avg last_update_time reset to 0 when
> attach_entity_cfs_rq() -> update_load_avg(), so it makes
> no difference whether SKIP_AGE_LOAD is set or not.
> 
> This patch delete the superfluous SKIP_AGE_LOAD, and the unused
> feature ATTACH_AGE_LOAD together.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  kernel/sched/fair.c     | 18 ++++++------------
>  kernel/sched/features.h |  1 -
>  2 files changed, 6 insertions(+), 13 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index b0bde895ba96..b91643a2143e 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3956,9 +3956,8 @@ static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
>   * Optional action to be done while updating the load average
>   */
>  #define UPDATE_TG	0x1
> -#define SKIP_AGE_LOAD	0x2
> -#define DO_ATTACH	0x4
> -#define DO_DETACH	0x8
> +#define DO_ATTACH	0x2
> +#define DO_DETACH	0x4
>  
>  /* Update task and its cfs_rq load average */
>  static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
> @@ -3970,7 +3969,7 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
>  	 * Track task load average for carrying it to new CPU after migrated, and
>  	 * track group sched_entity load average for task_h_load calc in migration
>  	 */
> -	if (se->avg.last_update_time && !(flags & SKIP_AGE_LOAD))
> +	if (se->avg.last_update_time)
>  		__update_load_avg_se(now, cfs_rq, se);
>  
>  	decayed  = update_cfs_rq_load_avg(now, cfs_rq);
> @@ -4253,7 +4252,6 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
>  }
>  
>  #define UPDATE_TG	0x0
> -#define SKIP_AGE_LOAD	0x0
>  #define DO_ATTACH	0x0
>  #define DO_DETACH	0x0
>  
> @@ -11484,9 +11482,7 @@ static void detach_entity_cfs_rq(struct sched_entity *se)
>  	struct cfs_rq *cfs_rq = cfs_rq_of(se);
>  
>  	/* Catch up with the cfs_rq and remove our load when we leave */
> -	update_load_avg(cfs_rq, se, 0);
> -	detach_entity_load_avg(cfs_rq, se);
> -	update_tg_load_avg(cfs_rq);
> +	update_load_avg(cfs_rq, se, UPDATE_TG | DO_DETACH);
>  	propagate_entity_cfs_rq(se);
>  }
>  
> @@ -11494,10 +11490,8 @@ static void attach_entity_cfs_rq(struct sched_entity *se)
>  {
>  	struct cfs_rq *cfs_rq = cfs_rq_of(se);
>  
> -	/* Synchronize entity with its cfs_rq */
> -	update_load_avg(cfs_rq, se, sched_feat(ATTACH_AGE_LOAD) ? 0 : SKIP_AGE_LOAD);
> -	attach_entity_load_avg(cfs_rq, se);
> -	update_tg_load_avg(cfs_rq);
> +	/* Synchronize entity with its cfs_rq and attach our load */
> +	update_load_avg(cfs_rq, se, UPDATE_TG | DO_ATTACH);
>  	propagate_entity_cfs_rq(se);
>  }

Looks like I order this change wrong, this change should be put before patch5-6.

Because this change will check last_update_time before attach_entity_load_avg()
in update_load_avg(), instead of unconditional attach_entity_load_avg() here.


Problem case: switch to fair class

p->sched_class = fair_class;  --> p.se->avg.last_update_time = 0
if (queued)
  enqueue_task(p);
    ...
      enqueue_entity()
        update_load_avg(UPDATE_TG | DO_ATTACH)
          if (!se->avg.last_update_time && (flags & DO_ATTACH))  --> true
            attach_entity_load_avg()  --> attached, will set last_update_time
check_class_changed()
  switched_from() (!fair)
  switched_to()   (fair)
    switched_to_fair()
      attach_entity_load_avg()  --> unconditional attach again!


If we use unconditional attach_entity_load_avg() in switched_to_fair(), the
above twice attach problem will happen, see details in commit 7dc603c9028e

In this patch, we also use update_load_avg(UPDATE_TG | DO_ATTACH) in
switched_to_fair(), so no twice attach problem will happen since we check
last_update_time in update_load_avg().

Thanks.

>  
> diff --git a/kernel/sched/features.h b/kernel/sched/features.h
> index ee7f23c76bd3..fb92431d496f 100644
> --- a/kernel/sched/features.h
> +++ b/kernel/sched/features.h
> @@ -85,7 +85,6 @@ SCHED_FEAT(RT_PUSH_IPI, true)
>  
>  SCHED_FEAT(RT_RUNTIME_SHARE, false)
>  SCHED_FEAT(LB_MIN, false)
> -SCHED_FEAT(ATTACH_AGE_LOAD, true)
>  
>  SCHED_FEAT(WA_IDLE, true)
>  SCHED_FEAT(WA_WEIGHT, true)
