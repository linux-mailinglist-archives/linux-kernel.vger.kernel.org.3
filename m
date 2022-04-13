Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA2B64FFCC3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 19:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237270AbiDMRdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 13:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237375AbiDMRci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 13:32:38 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89EE33E8A
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 10:30:14 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id v12so2538847plv.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 10:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=k+1F1BK24M8XYd/qvy1LopQknDKifZ5M5gq7u6f7UpI=;
        b=ZFOmJ38w9arDOS/D4rfYmDYRE9P+wrX5wAcf1/wOrlFZfll+hxltobnX3ZMBNfKdZS
         yFb8ngxrD9vFH8Kwk8UpkQl2FyXtGQJv3UMtc8V8bHRcoiu5d8G0EXVThaMf3s3w5nlI
         mHl3TgDvGzbfUL4lCOTygRZLFt23NhPVaKMxIuCq9BmgXnpKsDKCp/V+l1UW8iVcTdt4
         ADiJJgMmHSaDnVtPw19h8koRb3koF05f1qQFHM4FjZMwhTItUWpLix0rtBfxQllJih0M
         n2agdFFox07q5HA/Cv7PCW0jxsNWvsmGYiAfV1YDMxgGt02cpOyDGRjIepMdkbtq35xJ
         G1pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=k+1F1BK24M8XYd/qvy1LopQknDKifZ5M5gq7u6f7UpI=;
        b=vBPcNxoA1S8WpdLFiZ6cNX9S8Gb0oaz7kveDqS2IzdRQ5PmUfQUKl0GuqdnjFq9T0Z
         5NILT9DbWYs5nxjt6gyVD5jVR3rgdNKB8HMj5G6fZtoXMay0U0Imw6Fx9urAD06adxzF
         coDSNscn4wXCk/dfQbJsWl/5J8U9lc5qBB8tOMKweZ5Y8WbZ9+g4QXRTrjnBirVSm7cj
         k2zgK38ygUcyBDZq73hoUhvwbo0mcHRVeaLSaMRI02S5TUwDH6c45o9CcAjRlfU3rCPD
         19MeP0MWwFi2WNLQrrS+Wnvw5jCTUox9VZ9MYiTFAvwbXjTDiQ5ICnbvSuk7qfsKyzGk
         ge2Q==
X-Gm-Message-State: AOAM5332SJVcjWY171uZ/ap/I6TG1lmVS7cLE1ZNOyyj/0qYUX+WsS9C
        7q/EvF1J0suN5GiN28Vw6qFmpQ==
X-Google-Smtp-Source: ABdhPJxy3MI2Zpe95RcrsusFY5U+Jzrd9oZOI++7WYP33FFsGADJouGaNnS+bjJbYXM/Ya1bXtc4Yg==
X-Received: by 2002:a17:903:288:b0:156:a6b5:80d4 with SMTP id j8-20020a170903028800b00156a6b580d4mr44866815plr.98.1649871014244;
        Wed, 13 Apr 2022 10:30:14 -0700 (PDT)
Received: from bsegall-linux.svl.corp.google.com.localhost ([2620:15c:2cd:202:cff3:602:21d5:44bb])
        by smtp.gmail.com with ESMTPSA id y15-20020a17090a1f4f00b001c7ecaf9e13sm3668543pjy.35.2022.04.13.10.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 10:30:12 -0700 (PDT)
From:   Benjamin Segall <bsegall@google.com>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, bristot@redhat.com,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        songmuchun@bytedance.com, zhengqi.arch@bytedance.com
Subject: Re: [PATCH] sched/fair: update tg->load_avg and se->load in
 throttle_cfs_rq()
References: <20220413041627.41521-1-zhouchengming@bytedance.com>
Date:   Wed, 13 Apr 2022 10:30:10 -0700
In-Reply-To: <20220413041627.41521-1-zhouchengming@bytedance.com> (Chengming
        Zhou's message of "Wed, 13 Apr 2022 12:16:27 +0800")
Message-ID: <xm26h76wvql9.fsf@bsegall-linux.svl.corp.google.com>
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

> We use update_load_avg(cfs_rq, se, 0) in throttle_cfs_rq(), so the
> cfs_rq->tg_load_avg_contrib and task_group->load_avg won't be updated
> even when the cfs_rq's load_avg has changed.
>
> And we also don't call update_cfs_group(se), so the se->load won't
> be updated too.
>
> Change to use update_load_avg(cfs_rq, se, UPDATE_TG) and add
> update_cfs_group(se) in throttle_cfs_rq(), like we do in
> dequeue_task_fair().

Hmm, this does look more correct; Vincent, was having this not do
UPDATE_TG deliberate, or an accident that we all missed when checking?

It looks like the unthrottle_cfs_rq side got UPDATE_TG added later in
the two-loops pass, but not the throttle_cfs_rq side.

Also unthrottle_cfs_rq I'm guessing could still use update_cfs_group(se)


>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  kernel/sched/fair.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d4bd299d67ab..b37dc1db7be7 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4936,8 +4936,9 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
>  		if (!se->on_rq)
>  			goto done;
>  
> -		update_load_avg(qcfs_rq, se, 0);
> +		update_load_avg(qcfs_rq, se, UPDATE_TG);
>  		se_update_runnable(se);
> +		update_cfs_group(se);
>  
>  		if (cfs_rq_is_idle(group_cfs_rq(se)))
>  			idle_task_delta = cfs_rq->h_nr_running;
