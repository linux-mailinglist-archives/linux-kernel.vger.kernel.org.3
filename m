Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7170C5A218E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 09:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbiHZHQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 03:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244961AbiHZHPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 03:15:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A9F2C13E
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 00:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661498143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bwhOoowHbva4ptYGCZgzKUuRSZPb4vVs2nKILPMgpB4=;
        b=g4TdPPstusJgxSPRKdnWOKOfyAy5qUhuAanI9eFKMcLcYFPiXfgFBEyMfxLzOXOy8FJ+sa
        emnNXtPlxx5p4i9wueWk5+sX+31SiHdeF8r2DfCjCVwuQMh3YI7rqldVgLo/+SiNEuLTVO
        7gJdGWRzNfe4paefGufZADNMW8N7rVQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-653-Q1CaU9zUMKKPigsOAwTvkw-1; Fri, 26 Aug 2022 03:15:40 -0400
X-MC-Unique: Q1CaU9zUMKKPigsOAwTvkw-1
Received: by mail-ed1-f70.google.com with SMTP id w20-20020a05640234d400b00447e6ffefccso658248edc.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 00:15:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=bwhOoowHbva4ptYGCZgzKUuRSZPb4vVs2nKILPMgpB4=;
        b=N7h7u+QNTxkeE0s/Y+SmtyWx8ngRWGBWHZMSlv+4axMpIuMYUC8Wcu2gnDc0dWLx89
         cI28K56B5DO0/7rauXj5EBGKb9cYnyR8FTwpsZmvPW+DlV8bFrkIFC4DS+kLr83n34jE
         k7Xu4MfuS7yjwdaXvMlfDO71niKOULAPWADuz+xmV5NPK/xyAy2DVFSzlW3sMy87khm2
         OuL4hZTBQLIgGJwRKXvZq4dHATtVxVAhrQcFAC80re2/RiwGvA9KBwjYGcg0qCfD7vE+
         pqJLB9x+7PHSztw6Jvo6Cw2D9lqBjjUXiYSu+TmtdbAHWWEYVNSKsWo93Wb8UfpL6JR2
         CQQA==
X-Gm-Message-State: ACgBeo2Bzr0x/JdqXe13/hRcaulM4OVJZl4jZ9InAVwnJ7S7H7A0BNDM
        X10eyrW0y8YURTEVjS83l+2LmnFH1vlenwPhFIR3qeToIlZkVmsd6/GOq6193jJqVBz+RaxvxT2
        vwR5pd4NdomKxnCVV9qEwqkRF
X-Received: by 2002:a17:906:7304:b0:730:c3a8:cd7a with SMTP id di4-20020a170906730400b00730c3a8cd7amr4431315ejc.575.1661498139862;
        Fri, 26 Aug 2022 00:15:39 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4kBsFgUciDpKWBvGtf1SAKEvyDHwSsUrM8XskEED59PlPChb0PQSHxRXvZ3AAiSV7a4KRUQg==
X-Received: by 2002:a17:906:7304:b0:730:c3a8:cd7a with SMTP id di4-20020a170906730400b00730c3a8cd7amr4431310ejc.575.1661498139651;
        Fri, 26 Aug 2022 00:15:39 -0700 (PDT)
Received: from [192.168.0.198] (host-87-8-60-205.retail.telecomitalia.it. [87.8.60.205])
        by smtp.gmail.com with ESMTPSA id r5-20020a17090638c500b0073c0b87ba34sm511422ejd.198.2022.08.26.00.15.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 00:15:39 -0700 (PDT)
Message-ID: <651dbb96-8d6e-53e9-a99f-0bb12f5b2723@redhat.com>
Date:   Fri, 26 Aug 2022 09:15:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH -next] sched/deadline: Add start_new_instance helper
Content-Language: en-US
To:     Shang XiaoJing <shangxiaojing@huawei.com>
References: <20220826031521.13391-1-shangxiaojing@huawei.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, linux-kernel@vger.kernel.org
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <20220826031521.13391-1-shangxiaojing@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/26/22 05:15, Shang XiaoJing wrote:
> Wrap repeated code in helper function start_new_instance, which set
> the deadline and runtiem of input dl_se based on pi_of(dl_se). Note that
                      ^ runtime
> setup_new_dl_entity originally set the deadline and runtime base on
> dl_se, which should equals to pi_of(dl_se) for non-boosted task.
> 
> Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
> ---
>  kernel/sched/deadline.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 4a40a462717c..5e9c28847610 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -770,6 +770,13 @@ static void enqueue_task_dl(struct rq *rq, struct task_struct *p, int flags);
>  static void __dequeue_task_dl(struct rq *rq, struct task_struct *p, int flags);
>  static void check_preempt_curr_dl(struct rq *rq, struct task_struct *p, int flags);

again, this is not a good function name. Maybe, dl_replenish_new_period() ?

> +static inline void start_new_instance(struct sched_dl_entity *dl_se, struct rq *rq)
> +{
> +	/* for non-boosted task, pi_of(dl_se) == dl_se */
> +	dl_se->deadline = rq_clock(rq) + pi_of(dl_se)->dl_deadline;
> +	dl_se->runtime = pi_of(dl_se)->dl_runtime;
> +}
> +

-- Daniel

