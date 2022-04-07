Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC7694F88FF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 00:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbiDGVDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 17:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbiDGVC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 17:02:59 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28AEE1689DA
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 14:00:58 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 2so6776790pjw.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 14:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=T89PGJOFZzxYWMDwvjRB/Z88pam+GDQn5BMEWkthb7M=;
        b=PYkmmEq+wWwbgsDjy2r0zLqZdWnZzr9RPm3tsi9QgmKZ55ZFGOBL7ismmtci8NnOqA
         QwjzsxsfQZowVyVKLdGzYlep6EtNAIuCCciw4T1gmRbAzgOm1VuluJCQoa2U0r8bhiDw
         7rApu70mhjU/bZ50dve7YTbQxOq+FyCzMq2wSqLE2wBJgRHH1awi+N60bTVDBsrYN0ez
         wvS+BBU41hr2sUr5GY6M2dpTvM9pqlnbw2ZTNIuOHnOQXP4I7CsrM+B9U0sWAfQZyJVt
         3wOxdAEqBsGPYdthDTtIhzxUT4JoIp1GPSbW7f6vv6o8Lmaf4OYyyifXFB7aXsHZxTvA
         lOrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=T89PGJOFZzxYWMDwvjRB/Z88pam+GDQn5BMEWkthb7M=;
        b=S6svlIkBCN7nXaHThZVWjvJRm6GS3kS35/aGEQKebqsTtYKqiP5iVdeq44FQg8s41d
         36blvlq6cHmGMEpP5t8/+WfGdX/TSFjc9s+9p2mbKwx3al2TvabJD4+KuTwPG/Bvs/Ud
         Z1VOrqs5VfSNTTiKpK3Pjb9v5Iz0C9JWg0BlYTg00xDqkzooNlGGYck1Y4o/uLdtsW4U
         /IV4w5Xf8Rw0Wj4sEG46/8/NUw+OedfLWfFZKgqauObxXNUc6slTyFfQCVAIwzxe96HF
         UXsiZGDuQ4O87rXellXE9AjjiBOTXdw4LMmWz8+RcmIec2tg1iZSgUTlEAILGuP9eR85
         DhaA==
X-Gm-Message-State: AOAM5306Pw8sZwcuqyINx93biMPHV/wacNEgRT3PP2N1wfsRWD+WTtox
        69lSEr5OxXlETMbVblTmkPE0Tg==
X-Google-Smtp-Source: ABdhPJxHXJI8ZwUsmQLqz+S7V7nFeavAxKmMZFLLTRBKs1+kp6SUn6toVb+DF/8xo0UvOhDHuAuXmA==
X-Received: by 2002:a17:902:cf08:b0:151:9d28:f46f with SMTP id i8-20020a170902cf0800b001519d28f46fmr15519474plg.53.1649365257397;
        Thu, 07 Apr 2022 14:00:57 -0700 (PDT)
Received: from bsegall-linux.svl.corp.google.com.localhost ([2620:15c:2cd:202:ca7d:71e3:d0a7:79b7])
        by smtp.gmail.com with ESMTPSA id g12-20020a056a001a0c00b004e1307b249csm24027695pfv.69.2022.04.07.14.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 14:00:56 -0700 (PDT)
From:   Benjamin Segall <bsegall@google.com>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, bristot@redhat.com,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        songmuchun@bytedance.com
Subject: Re: [PATCH 2/2] sched/fair: Delete useless condition in
 tg_unthrottle_up()
References: <20220407021729.16655-1-zhouchengming@bytedance.com>
        <20220407021729.16655-2-zhouchengming@bytedance.com>
Date:   Thu, 07 Apr 2022 14:00:54 -0700
In-Reply-To: <20220407021729.16655-2-zhouchengming@bytedance.com> (Chengming
        Zhou's message of "Thu, 7 Apr 2022 10:17:29 +0800")
Message-ID: <xm26pmlsvcah.fsf@bsegall-linux.svl.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chengming Zhou <zhouchengming@bytedance.com> writes:

> Fully decayed cfs_rq is impossible to have queued entities,
> the first condition "!cfs_rq_is_decayed(cfs_rq)" is enough
> to cover.

In particular, cfs_rq->load.weight is part of cfs_rq_is_decayed.

Reviewed-by: Ben Segall <bsegall@google.com>

>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  kernel/sched/fair.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index e6fa5d1141b4..17c13c38b1c2 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4850,7 +4850,7 @@ static int tg_unthrottle_up(struct task_group *tg, void *data)
>  					     cfs_rq->throttled_clock_task;
>  
>  		/* Add cfs_rq with load or one or more already running entities to the list */
> -		if (!cfs_rq_is_decayed(cfs_rq) || cfs_rq->nr_running)
> +		if (!cfs_rq_is_decayed(cfs_rq))
>  			list_add_leaf_cfs_rq(cfs_rq);
>  	}
