Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA55655CA9F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344175AbiF1JX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 05:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344152AbiF1JXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 05:23:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4667E1EECA
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 02:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656408193;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZQ8PbVRfKtLH2BnQKm5WBZD6aRMJWU7raZsWJy2qDfc=;
        b=bxyIDItE7zdLWCgiVdyKIgEs5TAypVyRHXkS3w0XY00SNXVaEsAvh21z11s9Oml8J6aFsw
        zIdG+XmE6sp7VzvpDyQsDndrRC6JAUKnBTisSQouBv/nvxSX3Rmt/sDTU+Ddz/oMvE4upC
        s5nsZYmoUCw0opBjXuzgNrvkMaOGGVs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-319-9p2IRh4zPbCDIYpVyLlwWQ-1; Tue, 28 Jun 2022 05:23:10 -0400
X-MC-Unique: 9p2IRh4zPbCDIYpVyLlwWQ-1
Received: by mail-wm1-f72.google.com with SMTP id v125-20020a1cac83000000b0039c832fbd02so8602976wme.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 02:23:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZQ8PbVRfKtLH2BnQKm5WBZD6aRMJWU7raZsWJy2qDfc=;
        b=64NMiqqXfVorAWYXDI6gEbY8DUZG+1UMsYXXtj3ccXQLqRF5IkAO4Xb8NIdWhZAe2q
         4guUuKAe/NkPv5KExWksPXNa9vIJ4n3UMdJw3+d689ft00DOuuoxtKLzu3lDQUAN+YZL
         XW/Vv8soj6/kWrAA2SksDwpbW3O+aShiNXCjPS1+hrWRlj1VQVDl3ZBTlYtlF+y/b5B+
         zTNfIb5DJaMH1w+bk1gNi/eUg6Zo5BlpGhWi6ZLu9IknddAIBSQsrqb3aGyWCjNNZ6yz
         zFIS25WMwjUp7ipLMoehGPmoPoBfk/W02n1AK+LjeI3MUWYDhIEaSYyHwZ/00kOk6lxG
         7ogw==
X-Gm-Message-State: AJIora+QAWLGw0dja2NNrBKnTYGg72VmjwP4gYG5U9RsaY7XpsoAwXIe
        oZUdM5LIaz160y9+E7qArHurHPoTrMZasTNnRutQBg8C7uNbegNcoV8QCaYn4F5Ms5hGggDHv96
        SARd/F6eZAw6adrFxIrGys3Or4SNG9Jmp8qpbDeyS9R8oBAD137cgaMKyLL2CdQv99Z9oGwHHDh
        UJ
X-Received: by 2002:adf:e68b:0:b0:21d:1c8d:9891 with SMTP id r11-20020adfe68b000000b0021d1c8d9891mr2922152wrm.37.1656408189370;
        Tue, 28 Jun 2022 02:23:09 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1srDW/+3lydTME/MMivmI4UhbCnrKvSp+Uias0Oz8IX8uy8HiHJgBlQ1o4KdvkvMPijOCyTHA==
X-Received: by 2002:adf:e68b:0:b0:21d:1c8d:9891 with SMTP id r11-20020adfe68b000000b0021d1c8d9891mr2922119wrm.37.1656408189104;
        Tue, 28 Jun 2022 02:23:09 -0700 (PDT)
Received: from vian.redhat.com ([2a0c:5a80:1b12:b300:47b0:25ba:1a2e:72ac])
        by smtp.gmail.com with ESMTPSA id v14-20020a05600c214e00b0039c96b97359sm10021630wml.37.2022.06.28.02.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 02:23:08 -0700 (PDT)
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     linux-kernel@vger.kernel.org, fweisbec@gmail.com
Cc:     bristot@redhat.com, vschneid@redhat.com, cmetcalf@ezchip.com,
        mgorman@suse.de, bsegall@google.com, rostedt@goodmis.org,
        dietmar.eggemann@arm.com, vincent.guittot@linaro.org,
        juri.lelli@redhat.com, peterz@infradead.org, mingo@redhat.com,
        mtosatti@redhat.com, Nicolas Saenz Julienne <nsaenzju@redhat.com>
Subject: [PATCH] nohz/full, sched/rt: Fix missed tick-reenabling bug in dequeue_task_rt
Date:   Tue, 28 Jun 2022 11:22:59 +0200
Message-Id: <20220628092259.330171-1-nsaenzju@redhat.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dequeue_task_rt() only decrements 'rt_rq->rt_nr_running' after having
called sched_update_tick_dependency() preventing it from re-enabling the
tick on systems that no longer have pending SCHED_RT tasks but have
multiple runnable SCHED_OTHER tasks:

  dequeue_task_rt()
    dequeue_rt_entity()
      dequeue_rt_stack()
        dequeue_top_rt_rq()
	  sub_nr_running()	// decrements rq->nr_running
	    sched_update_tick_dependency()
	      sched_can_stop_tick()	// checks rq->rt.rt_nr_running,
	      ...
        __dequeue_rt_entity()
          dec_rt_tasks()	// decrements rq->rt.rt_nr_running
	  ...

Every other scheduler class performs the operation in the opposite
order, and sched_update_tick_dependency() expects the values to be
updated as such. So avoid the misbehaviour by inverting the order in
which the above operations are performed in the RT scheduler.

Fixes: 76d92ac305f2 ("sched: Migrate sched to use new tick dependency mask model")
Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
---
 kernel/sched/rt.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 8c9ed96648409..55f39c8f42032 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -480,7 +480,7 @@ static inline void rt_queue_push_tasks(struct rq *rq)
 #endif /* CONFIG_SMP */
 
 static void enqueue_top_rt_rq(struct rt_rq *rt_rq);
-static void dequeue_top_rt_rq(struct rt_rq *rt_rq);
+static void dequeue_top_rt_rq(struct rt_rq *rt_rq, unsigned int count);
 
 static inline int on_rt_rq(struct sched_rt_entity *rt_se)
 {
@@ -601,7 +601,7 @@ static void sched_rt_rq_dequeue(struct rt_rq *rt_rq)
 	rt_se = rt_rq->tg->rt_se[cpu];
 
 	if (!rt_se) {
-		dequeue_top_rt_rq(rt_rq);
+		dequeue_top_rt_rq(rt_rq, rt_rq->rt_nr_running);
 		/* Kick cpufreq (see the comment in kernel/sched/sched.h). */
 		cpufreq_update_util(rq_of_rt_rq(rt_rq), 0);
 	}
@@ -687,7 +687,7 @@ static inline void sched_rt_rq_enqueue(struct rt_rq *rt_rq)
 
 static inline void sched_rt_rq_dequeue(struct rt_rq *rt_rq)
 {
-	dequeue_top_rt_rq(rt_rq);
+	dequeue_top_rt_rq(rt_rq, rt_rq->rt_nr_running);
 }
 
 static inline int rt_rq_throttled(struct rt_rq *rt_rq)
@@ -1089,7 +1089,7 @@ static void update_curr_rt(struct rq *rq)
 }
 
 static void
-dequeue_top_rt_rq(struct rt_rq *rt_rq)
+dequeue_top_rt_rq(struct rt_rq *rt_rq, unsigned int count)
 {
 	struct rq *rq = rq_of_rt_rq(rt_rq);
 
@@ -1100,7 +1100,7 @@ dequeue_top_rt_rq(struct rt_rq *rt_rq)
 
 	BUG_ON(!rq->nr_running);
 
-	sub_nr_running(rq, rt_rq->rt_nr_running);
+	sub_nr_running(rq, count);
 	rt_rq->rt_queued = 0;
 
 }
@@ -1486,18 +1486,21 @@ static void __dequeue_rt_entity(struct sched_rt_entity *rt_se, unsigned int flag
 static void dequeue_rt_stack(struct sched_rt_entity *rt_se, unsigned int flags)
 {
 	struct sched_rt_entity *back = NULL;
+	unsigned int rt_nr_running;
 
 	for_each_sched_rt_entity(rt_se) {
 		rt_se->back = back;
 		back = rt_se;
 	}
 
-	dequeue_top_rt_rq(rt_rq_of_se(back));
+	rt_nr_running = rt_rq_of_se(back)->rt_nr_running;
 
 	for (rt_se = back; rt_se; rt_se = rt_se->back) {
 		if (on_rt_rq(rt_se))
 			__dequeue_rt_entity(rt_se, flags);
 	}
+
+	dequeue_top_rt_rq(rt_rq_of_se(back), rt_nr_running);
 }
 
 static void enqueue_rt_entity(struct sched_rt_entity *rt_se, unsigned int flags)
-- 
2.36.1

