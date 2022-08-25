Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2B4C5A1069
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 14:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241706AbiHYM2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 08:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241223AbiHYM1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 08:27:43 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E07B2CE5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 05:27:40 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id a4so24445762wrq.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 05:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=OicpysW7udmsv4B07ks66/QAA2RjLzfuKutZRyo1XJE=;
        b=vfLmlICKCQ/ZWNvLSXgoFzeF4gHctCgY+Npj5h2sAzoyAVyTKWIbyhYQF30J/SZoYX
         UxJd0tggPT98340Ffr50EINkMtWMxqk/Qle7dj89A0bp7E1s+jpfS8X91AggWHk7aKPe
         CiXrFz/+ghAf3DXH5+kahul45rCVMiBoOd/QEbXTmUJqpDaV8tu0ZIywZb/hI4dFqwhe
         7H/LlpAp9NIywK6+VY3NsrAK2NBU4VBmbzJ3txZtcoDjb1pVxaIxx9DelShndtFHAaUf
         kNEpNkDsSJ75iCgoiAhvop8CXYRBGVidRoUX28dFKtl9Ht728pNDY40/TyyZ49zqH9tK
         stqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=OicpysW7udmsv4B07ks66/QAA2RjLzfuKutZRyo1XJE=;
        b=TmG97tKhnBWeJTSSx9nqtKX3OC2ltJg89XWv2uQ90lnJyGGLR2kzuNigFrRgL1dr17
         KbxagrRs/lJTxVcumsOSkwUMjM2wHOF0++M55qNHvO147iTJTKr/s0bHz7Y6UenDY2no
         br5VEmld3BGmclNw3t1BH4TT6dZRLP2MGZbTrxa2Lok9tbaVUhY/zWorLmrh33azGhKg
         1Z2oYuIxf8QwdNgmwsENiCIp9HYelOK0pihUwZg+vC28itsMZctD3LP32ShLgdBd1Jbt
         CbGpe+fh9wjqkw6XN9YIroD/ihW65Iy+wSvAymnAJCIJfonv5/kAA0xvh5rFjZ1N0hXe
         K/Sw==
X-Gm-Message-State: ACgBeo0ybTDJl439n9cchYoZj0oj5YxzjGRcc+0rkbWY2NuLeTPgwTLW
        3JNEVsSGxjBv3j5xZIVpuKQxcw==
X-Google-Smtp-Source: AA6agR4LranD4hpHty2xtQQcuuwqnjLOPL6610SQl/HOXmdHnUkyyz9P/+Ee3wX6/IPtf8y1sC+wqg==
X-Received: by 2002:a5d:5402:0:b0:225:3a78:4d2c with SMTP id g2-20020a5d5402000000b002253a784d2cmr2251680wrv.675.1661430458875;
        Thu, 25 Aug 2022 05:27:38 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:55dd:3519:10d3:b07b])
        by smtp.gmail.com with ESMTPSA id c7-20020a05600c0ac700b003a5ee64cc98sm5417809wmr.33.2022.08.25.05.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 05:27:37 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     zhangqiao22@huawei.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 4/4] sched/fair: limit sched slice duration
Date:   Thu, 25 Aug 2022 14:27:26 +0200
Message-Id: <20220825122726.20819-5-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220825122726.20819-1-vincent.guittot@linaro.org>
References: <20220825122726.20819-1-vincent.guittot@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In presence of a lot of small weight tasks like sched_idle tasks, normal
or high weight tasks can see their ideal runtime (sched_slice) to increase
to hundreds ms whereas it normally stays below sysctl_sched_latency.

2 normal tasks running on a CPU will have a max sched_slice of 12ms
(half of the sched_period). This means that they will make progress
every sysctl_sched_latency period.

If we now add 1000 idle tasks on the CPU, the sched_period becomes
3006 ms and the ideal runtime of the normal tasks becomes 609 ms.
It will even become 1500ms if the idle tasks belongs to an idle cgroup.
This means that the scheduler will look for picking another waiting task
after 609ms running time (1500ms respectively). The idle tasks change
significantly the way the 2 normal tasks interleave their running time
slot whereas they should have a small impact.

Such long sched_slice can delay significantly the release of resources
as the tasks can wait hundreds of ms before the next running slot just
because of idle tasks queued on the rq.

Cap the ideal_runtime to sysctl_sched_latency when comparing to the next
waiting task to make sure that tasks will regularly make progress and will
not be significantly impacted by idle/background tasks queued on the rq.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---

While studying the problem, I have also considered to substract
cfs.idle_h_nr_running before computing the sched_slice but we can have
quite similar problem with low weight bormal task/cgroup so I have decided
to keep this solution.

Also, this solution doesn't completly remove the impact of idle tasks
in the scheduling pattern but cap the running slice of a task to a max
value of 2*sysctl_sched_latency.

 kernel/sched/fair.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 260a55ac462f..96fedd0ab5fa 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4599,6 +4599,8 @@ check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
 	if (delta < 0)
 		return;
 
+	ideal_runtime =  min_t(u64, ideal_runtime, sysctl_sched_latency);
+
 	if (delta > ideal_runtime)
 		resched_curr(rq_of(cfs_rq));
 }
-- 
2.17.1

