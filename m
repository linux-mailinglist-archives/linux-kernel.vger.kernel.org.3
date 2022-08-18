Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B11459801C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 10:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237106AbiHRIbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 04:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbiHRIbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 04:31:38 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955578E442
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 01:31:37 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id e20so377159wri.13
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 01:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:from:to:cc;
        bh=c0TGYDkJPs1gACAg4UicPMz4OKqgRucJiviJCiEW2OM=;
        b=FCNh1Tah0/z64H8Uji7pn92S1Tc7bWmeWU8xtUz0yMAw6//pOViIUYEQVIgIyOeh1s
         plowgNA6aLaOjelDd0ql04QbbjnifRxUxofVPtQqg6lCVbT7dvFQ6OA3KXkPtRWGBwoj
         Jzn329rFvT8rTpvxTVkY/dwP7gFm6hAu/SN0KGrlZYp2yc4vn+G6OTPYiEGJQaMCuqfr
         +hrkkvK+2706/Eyenc1Z/D8CbWKKEXsxEEyX4Anis2MqMjdnp/ME2geONKMt16wWw4th
         ksnMcyVEh8rWbgNjekCEuYgTmM7u9r5qe9mZENpbYXTFlVu9lh/J0h99/B8YG/OCqlV5
         YK6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc;
        bh=c0TGYDkJPs1gACAg4UicPMz4OKqgRucJiviJCiEW2OM=;
        b=dCzqRnhSsrBzSyYZQqJwHabXhJwhXEymKRrhv+A4nBYUcryfGLc0mgQcYAvouKL97q
         YwpXtDrIELzZlTk65U+3s+OTKlgCtChCGXQMKzhyf5s6jG+P3ptYa7blAA+4zOf9HGR3
         Pcq0Z1OgSj3qBbe02ZfDSHgsIQd8xG8/wVjI/LDBDC/BPc3/3Si2rkZQ6JOLUWm4CHGW
         +BQAM1Y/cks90DXhzB5bJhxN9smOKz8ZtRq7eiVqMvXby7U/Do37xgljFQDQbrNBpqqR
         hjig+xIQI/RPwJMzXb3PbjSk/Im/y/JR8xBHkKNT5Tf5yZSkmW+FBtA8E1GOZ8YlvHoC
         oHgQ==
X-Gm-Message-State: ACgBeo1LJsZX7Ii6UrZc6jdhyi2a0WfJuMobd6zQO0Ih2X2xnkRgeNpS
        lqbysfxOkxTgAqzo4gMOfRqm8A==
X-Google-Smtp-Source: AA6agR6xG2ceub/HyJAk8UfLZ3obBRihdl/0bikyPnLGTdYgnnfd+WxaAkj1/pNKuIvP7EVmCg5G6Q==
X-Received: by 2002:a5d:6d46:0:b0:21f:8b7:4c1d with SMTP id k6-20020a5d6d46000000b0021f08b74c1dmr978918wri.455.1660811496091;
        Thu, 18 Aug 2022 01:31:36 -0700 (PDT)
Received: from vingu-book ([2a01:e0a:f:6020:95af:2a2e:3018:6f96])
        by smtp.gmail.com with ESMTPSA id q9-20020adfdfc9000000b0021d221daccfsm742703wrn.78.2022.08.18.01.31.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Aug 2022 01:31:34 -0700 (PDT)
Date:   Thu, 18 Aug 2022 10:31:33 +0200
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     "zhangsong (J)" <zhangsong34@huawei.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] sched/fair: Introduce priority load balance to reduce
 interference from IDLE tasks
Message-ID: <20220818083133.GA536@vingu-book>
References: <20220810015636.3865248-1-zhangsong34@huawei.com>
 <b62804cb-2b60-a534-5096-56785a1940bd@bytedance.com>
 <e2c9eccc-dd86-16e9-c43e-8415f99f413e@huawei.com>
 <13a7a412-5e2e-6ef8-acd6-a761aad66c3a@bytedance.com>
 <6ae319c0-e6ed-4aad-64b8-d3f6cbea688d@huawei.com>
 <CAKfTPtAcEstoqC+9-y9ubaXDSGbfLdMhFboMPn433QNPD114dQ@mail.gmail.com>
 <9a63b371-9940-caee-7fa1-2c230bec0bd1@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9a63b371-9940-caee-7fa1-2c230bec0bd1@bytedance.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeudi 18 août 2022 à 10:46:55 (+0800), Abel Wu a écrit :
> On 8/17/22 8:58 PM, Vincent Guittot Wrote:
> > On Tue, 16 Aug 2022 at 04:53, zhangsong (J) <zhangsong34@huawei.com> wrote:
> > > 
> > > 

...

> > > Yes, this is usually a corner case, but suppose that some non-idle tasks bounds to CPU 1-2
> > > 
> > > and idle tasks bounds to CPU 0-1, so CPU 1 may has many idle tasks and some non-idle
> > > 
> > > tasks while idle tasks on CPU 1 can not be pulled to CPU 2, when trigger load balance if
> > > 
> > > CPU 2 should pull some tasks from CPU 1, the bad result is idle tasks of CPU 1 cannot be
> > > 
> > > migrated and non-idle tasks also cannot be migrated in case of env->loop_max constraint.
> > 
> > env->loop_max adds a break but load_balance will continue with next
> > tasks so it also tries to pull your non idle task at the end after
> > several breaks.
> 
> Loop will be terminated without LBF_NEED_BREAK if exceeds loop_max :)

Argh yes, my brain is not yet back from vacation
I have been confused by loop_max and loop_break being set to the same value 32

Zhang Song, Could you try the patch below ? If it works, I will prepare a
clean patch with all tags



sched/fair: make sure to try to detach at least one movable task

During load balance we try at most env->loop_max time to move a task. But
it can happen that the LRU tasks (ie tail of the cfs_tasks list) can't
be moved to dst_cpu because of affinity. In this case, loop in the list
until we found at least one.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index da388657d5ac..02b7b808e186 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8052,8 +8052,12 @@ static int detach_tasks(struct lb_env *env)
 		p = list_last_entry(tasks, struct task_struct, se.group_node);

 		env->loop++;
-		/* We've more or less seen every task there is, call it quits */
-		if (env->loop > env->loop_max)
+		/*
+		 * We've more or less seen every task there is, call it quits
+		 * unless we haven't found any movable task yet.
+		 */
+		if (env->loop > env->loop_max &&
+		    !(env->flags & LBF_ALL_PINNED))
 			break;

 		/* take a breather every nr_migrate tasks */
@@ -10182,7 +10186,9 @@ static int load_balance(int this_cpu, struct rq *this_rq,

 		if (env.flags & LBF_NEED_BREAK) {
 			env.flags &= ~LBF_NEED_BREAK;
-			goto more_balance;
+			/* Stop if we tried all running tasks */
+			if (env.loop < busiest->nr_running)
+				goto more_balance;
 		}

 		/*
--
2.17.1

> 
> > 
> > > 
> > > This will cause non-idle  tasks cannot achieve  more CPU utilization.
> > 
> > Your problem is not linked to IDLE vs NORMAL tasks but to the large
> > number of pinned tasks that can't migrate on CPU2. You can end with
> > the same behavior without using IDLE tasks but only NORMAL tasks.
> 
> I feel the same thing.
> 
> Best,
> Abel
