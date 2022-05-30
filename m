Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7294A538615
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 18:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241720AbiE3QYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 12:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241825AbiE3QYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 12:24:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E521B980B4
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 09:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653927850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c51AIok/qwJiPHR0blC8qWUmAJd+ZhA5KSNEkPpkepM=;
        b=RgrKCUzMqzpxY04NGvX1xx72WF7wePNbRG6y4SaFojc/FbRPHWO0rW812/5TAdVqohB41A
        jEmG/J+ulmTOROxXo95uEaCO7q9yuMBBUmi1s3EVQ/PJP9e1t1y/G6jxIt/qJto7riuRUC
        ba3GyW2FzNPTb3WIWwoIKZpRXydZPTM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-486-7OdMNw05OSKfMIEncxA8ZA-1; Mon, 30 May 2022 12:24:08 -0400
X-MC-Unique: 7OdMNw05OSKfMIEncxA8ZA-1
Received: by mail-wr1-f69.google.com with SMTP id bv12-20020a0560001f0c00b0020e359b3852so1660088wrb.14
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 09:24:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=c51AIok/qwJiPHR0blC8qWUmAJd+ZhA5KSNEkPpkepM=;
        b=ZQ6WkM/5ZPSCb8TNQPlWVDqkIIrRnROxQezFAKFGcdcDSpcM5vf9Jks/u8M4ln/zTN
         7qXNh56Nxb9IwQ9Lt5QRsVOtP3axyQR4xzGuamQjqdPBLduvGOnHxvqBRdkwCBZd8BgS
         uXh25k2ZZ0dPW32AuIpUaYHI9x0zqN+1qkJANT1nnvLPKDFNh+yKO5Pw5+TkUD92fcet
         BTBv6eDNGfrZMAHkaIYYxCBc8bPOxaCTWKZH3yQL0pJxqQxB2tyM1gFlan3tlZ9c8tgz
         uwNEk+lIwW4LFiaL5m3yiZdgjoOJqSR0jjRiLswvo5UP3hCHNhDS1+gMVNRCVKdT5cIt
         z8aw==
X-Gm-Message-State: AOAM53122MqmWdDr1uWq9hKGFXXrWNDJwLnzayX7/4DkgbndVU+orb5Z
        aRRnu8d//sgTLC96EVoTQh4rwhJxvrvxi8mOgVlWz0mGXYd2BcKr8DUFHbLWVIwStqpJsHEIqGB
        buuWjQuKn01qnzlUHE9p9kBn6b4gqYW+HBUSXFW6GPNP7UfuEnUDDVxjqWu31g5B5baoZdNuKa9
        L1
X-Received: by 2002:a5d:6dd1:0:b0:210:7a1:cda0 with SMTP id d17-20020a5d6dd1000000b0021007a1cda0mr18680270wrz.570.1653927847397;
        Mon, 30 May 2022 09:24:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy4LyWcDXBw/1y8ErZsQrrcFmUeOOWeEdDjJjGs5Cw8r/JnDZF53lhn1G6g0YbhRUeUopFGvw==
X-Received: by 2002:a5d:6dd1:0:b0:210:7a1:cda0 with SMTP id d17-20020a5d6dd1000000b0021007a1cda0mr18680245wrz.570.1653927847122;
        Mon, 30 May 2022 09:24:07 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id r4-20020a1c2b04000000b003973c4bb19bsm10694681wmr.16.2022.05.30.09.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 09:24:06 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Tianchen Ding <dtcccc@linux.alibaba.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched: Queue task on wakelist in the same llc if the
 wakee cpu is idle
In-Reply-To: <20220527090544.527411-1-dtcccc@linux.alibaba.com>
References: <20220527090544.527411-1-dtcccc@linux.alibaba.com>
Date:   Mon, 30 May 2022 17:24:05 +0100
Message-ID: <xhsmhleuj7zve.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/05/22 17:05, Tianchen Ding wrote:
> The main idea of wakelist is to avoid cache bouncing. However,
> commit 518cd6234178 ("sched: Only queue remote wakeups when
> crossing cache boundaries") disabled queuing tasks on wakelist when
> the cpus share llc. This is because, at that time, the scheduler must
> send IPIs to do ttwu_queue_wakelist. Nowadays, ttwu_queue_wakelist also
> supports TIF_POLLING, so this is not a problem now when the wakee cpu is
> in idle polling.

[...]

> Our patch has improvement on schbench, hackbench
> and Pipe-based Context Switching of unixbench
> when there exists idle cpus,
> and no obvious regression on other tests of unixbench.
> This can help improve rt in scenes where wakeup happens frequently.
>
> Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>

This feels a bit like a generalization of

  2ebb17717550 ("sched/core: Offload wakee task activation if it the wakee is descheduling")

Given rq->curr is updated before prev->on_cpu is cleared, the waker
executing ttwu_queue_cond() can observe:

  p->on_rq=0
  p->on_cpu=1
  rq->curr=swapper/x (aka idle task)

So your addition of available_idle_cpu() in ttwu_queue_cond() (sort of)
matches that when invoked via:

        if (smp_load_acquire(&p->on_cpu) &&
            ttwu_queue_wakelist(p, task_cpu(p), wake_flags | WF_ON_CPU))
                goto unlock;

but it also affects

        ttwu_queue(p, cpu, wake_flags);

at the tail end of try_to_wake_up().

With all that in mind, I'm curious whether your patch is functionaly close
to the below. 

---
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 66c4e5922fe1..ffd43264722a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3836,7 +3836,7 @@ static inline bool ttwu_queue_cond(int cpu, int wake_flags)
 	 * the soon-to-be-idle CPU as the current CPU is likely busy.
 	 * nr_running is checked to avoid unnecessary task stacking.
 	 */
-	if ((wake_flags & WF_ON_CPU) && cpu_rq(cpu)->nr_running <= 1)
+	if (cpu_rq(cpu)->nr_running <= 1)
 		return true;
 
 	return false;

