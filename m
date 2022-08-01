Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7274D586381
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 06:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239394AbiHAE2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 00:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238580AbiHAE23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 00:28:29 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C09013E0E
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 21:28:17 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id f11so8680607pgj.7
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 21:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=udDFRX/Zxv8XpR6w6oj8eI1Kuby9UyxSYlMsPVhSx90=;
        b=4CvWm6wUWPIhkVslOOClBwYVsWG4ehAm7PCpN1HNR0wHswd9vKabaskfLF5F2S9ki3
         Q3nt+vF/SP6MhjH7JDIVewtkJfuO1EpPEyFbRdK2gbw8ZhviNJf1T9F39DYfwDT+WFX8
         qkLuHCLEM5d5Q1OuZCg/ZZoaF0VB7YOCNb5SUdZe0HNv8Oj8xaYvAJkZpSmX5ZLfwzJL
         4oykFqPDCVP2lMteOlo/ynczqhKkGUs5NMIm+tT8ZDd6I3HcZ47ZqUrhH3XRpVPIBLZs
         ixaIMJK84QM6UAFLNdBF77r+rimM9cQ9f+guqUpFuOwB+B56PWltea0HxvRXbi9TzEaT
         kK0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=udDFRX/Zxv8XpR6w6oj8eI1Kuby9UyxSYlMsPVhSx90=;
        b=R2kHtT5fWLekHDF7nPPTWqz3DXecuWA1/2fFh65f7VRRxP5b9DM1cVN+SKVTcAVoD6
         q48c+z0lRzfPYn+CNcu1/3F3rHvnQ/pJZjjExx7mD3Ge988/OGWKQATzB5MSOFYnzESP
         0EvuI+2k6gRoUwQvTvsq5zmv007WpAeWLOehBlNyKuZlZqgbNcPLM4vvI+Ukz56eqRX6
         szjopqUcHs6/fY9iui9ajckdr3doXfLFvDqh8UUmgXFvG/hTnx5WGyTrD0I2f1SWh3Nb
         4D22wMi9pfFUgkwhk/mOYT262pVW3HaZ119WoEHTHeC3Y7NKhrZxgEgOMh6ZtmmGE7Xy
         z+Eg==
X-Gm-Message-State: AJIora/R/4jsEy+AmKFms4jwE3cJdo6hdKuoiiyG0NLfp0eAZsF+u9cK
        nGLRMU4KYblkNKjszTl8HWDJTw==
X-Google-Smtp-Source: AGRyM1sWUk4GUtJoZg6ZjANvTTM0kTJ1AA8tbdM1jC4zNYd81f0VkmUfoqud/e1od45z3YsE8tQP+w==
X-Received: by 2002:a63:d244:0:b0:41a:6769:104a with SMTP id t4-20020a63d244000000b0041a6769104amr11583612pgi.525.1659328096766;
        Sun, 31 Jul 2022 21:28:16 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id ot10-20020a17090b3b4a00b001f326ead012sm7012202pjb.37.2022.07.31.21.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jul 2022 21:28:16 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v3 04/10] sched/fair: update comments in enqueue/dequeue_entity()
Date:   Mon,  1 Aug 2022 12:27:39 +0800
Message-Id: <20220801042745.7794-5-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220801042745.7794-1-zhouchengming@bytedance.com>
References: <20220801042745.7794-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When reading the sched_avg related code, I found the comments in
enqueue/dequeue_entity() are not updated with the current code.

We don't add/subtract entity's runnable_avg from cfs_rq->runnable_avg
during enqueue/dequeue_entity(), those are done only for attach/detach.

This patch updates the comments to reflect the current code working.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Acked-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 948b4cd2a024..956aed56ac1e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4434,7 +4434,8 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	/*
 	 * When enqueuing a sched_entity, we must:
 	 *   - Update loads to have both entity and cfs_rq synced with now.
-	 *   - Add its load to cfs_rq->runnable_avg
+	 *   - For group_entity, update its runnable_weight to reflect the new
+	 *     h_nr_running of its group cfs_rq.
 	 *   - For group_entity, update its weight to reflect the new share of
 	 *     its group cfs_rq
 	 *   - Add its new weight to cfs_rq->load.weight
@@ -4519,7 +4520,8 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	/*
 	 * When dequeuing a sched_entity, we must:
 	 *   - Update loads to have both entity and cfs_rq synced with now.
-	 *   - Subtract its load from the cfs_rq->runnable_avg.
+	 *   - For group_entity, update its runnable_weight to reflect the new
+	 *     h_nr_running of its group cfs_rq.
 	 *   - Subtract its previous weight from cfs_rq->load.weight.
 	 *   - For group entity, update its weight to reflect the new share
 	 *     of its group cfs_rq.
-- 
2.36.1

