Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1883958996D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 10:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239514AbiHDImf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 04:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239515AbiHDIlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 04:41:51 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3DAB6714B
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 01:41:08 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id s5-20020a17090a13c500b001f4da9ffe5fso4566932pjf.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 01:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=2QaqyHfbHLtpliP6PzpyY5kh+sI+NpRD+MBrExwxasE=;
        b=XQdV9/wIxqZlDtL98Dm1oldeJ5OqgRxntlIF+kEYjxekgPEU6xcw40fS56pvhAhIjh
         ung5k6CcRLk5vV+nmVOHPIQT/s+/tf/g3TFMEd/uEXuZ3Ilks9ug5T4YzDFnNmbBqSOs
         IkJERwsDObI0dO2mToe+Qi97mdrmo3/wPZtYAiwUwQvauYBJHLvsf4vEQGvoGfR2vw+C
         sGYpiqtrKgb4MwApdla51Uwc4QpwcSR1SF8baVZLWK/AItCdmGtYtJS9MJcPKnrWfRsM
         j8oUD57/QfFFQFbJgzm0XV6s6VBigXpu13yL399G31RQY/3aT7pwS+xUHh3HkUO08XKZ
         RPCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=2QaqyHfbHLtpliP6PzpyY5kh+sI+NpRD+MBrExwxasE=;
        b=2rIdHVecp/KfiNP5/aElYcohVZiMc2mo7nBy+KyTf7KDPkqyopjcAiHefT7D5xpPvb
         6CVMhVPq3ywLNf9xwZ+RnU4SAWVH3RwHOkHJRUfcic+jqB65szmC9zwV23nQ77ltOJ5l
         rjD7ECTfH9j1ogg4E/8sFjLDoQSE3PvgZD6Aqe0uBa3H4Utc5p6N7IsS/6bpGStdTFuA
         xCQ0+u3CVqGs3SRHKh7eQzW3fBm+xbhq0UomPKY10MMqEg4DfPI21rOfg/7TJr4uyg6L
         Y4Xgq4CnxIBRES38xmAffWacMyLTRtivIH9kYEWYnIHfXv6qg3OwNpwJ9zD8+oaCYy+r
         vk5w==
X-Gm-Message-State: ACgBeo1xtremPGRStHVQ17KV6rMW64E7ShUPigwCufRNZECx+DcND4R4
        RIJj/2zQPoEsY3GDgFgXADs7lRjKZsU=
X-Google-Smtp-Source: AA6agR5bGM+NH+ZIxjElVHsO+022e9ef8Utw5P5HvnbJPQ2hBJUz79XMxY70/3ZvyKTWQPvmwUvsow==
X-Received: by 2002:a17:90b:33d1:b0:1f5:4fc5:3d72 with SMTP id lk17-20020a17090b33d100b001f54fc53d72mr953449pjb.60.1659602468271;
        Thu, 04 Aug 2022 01:41:08 -0700 (PDT)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id l21-20020a17090a599500b001f4d4a1b494sm550103pji.7.2022.08.04.01.41.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Aug 2022 01:41:07 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [RFC PATCH 8/8] workqueue: Move the locking out of maybe_create_worker()
Date:   Thu,  4 Aug 2022 16:41:35 +0800
Message-Id: <20220804084135.92425-9-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20220804084135.92425-1-jiangshanlai@gmail.com>
References: <20220804084135.92425-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

The code is cleaner if the reversed pair of unlock() and lock()
is moved into the caller.

Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 kernel/workqueue.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 0d9844b81482..013ad61e67b9 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -2091,17 +2091,10 @@ static void pool_mayday_timeout(struct timer_list *t)
  * sent to all rescuers with works scheduled on @pool to resolve
  * possible allocation deadlock.
  *
- * LOCKING:
- * raw_spin_lock_irq(pool->lock) which may be released and regrabbed
- * multiple times.  Does GFP_KERNEL allocations.  Called only from
- * manager.
+ * Does GFP_KERNEL allocations.  Called only from manager.
  */
 static void maybe_create_worker(struct worker_pool *pool)
-__releases(&pool->lock)
-__acquires(&pool->lock)
 {
-	raw_spin_unlock_irq(&pool->lock);
-
 	/* if we don't make progress in MAYDAY_INITIAL_TIMEOUT, call for help */
 	mod_timer(&pool->mayday_timer, jiffies + MAYDAY_INITIAL_TIMEOUT);
 
@@ -2116,7 +2109,6 @@ __acquires(&pool->lock)
 	}
 
 	del_timer_sync(&pool->mayday_timer);
-	raw_spin_lock_irq(&pool->lock);
 }
 
 /**
@@ -2147,7 +2139,9 @@ static bool manage_workers(struct worker *worker)
 	pool->flags |= POOL_MANAGER_ACTIVE;
 	pool->manager = worker;
 
+	raw_spin_unlock_irq(&pool->lock);
 	maybe_create_worker(pool);
+	raw_spin_lock_irq(&pool->lock);
 
 	pool->manager = NULL;
 	pool->flags &= ~POOL_MANAGER_ACTIVE;
-- 
2.19.1.6.gb485710b

