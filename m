Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 316AD58996C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 10:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239502AbiHDImS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 04:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239000AbiHDIlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 04:41:47 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D346613A
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 01:41:06 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id pm17so13299011pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 01:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=UBybgKMsxDd15bCY1F3MJ8sBpGdDmhHWbWdFhTLioM4=;
        b=JyMGyYRPHz0w2mAM6iWbFWwyEfIO8ohR7V3+ADWVkFlblY4mCwDLRoTYMyOp6ERCq9
         4CfqLcUyaVaoxRC5Kh5optSSga1giV+TNyMG0Sl/aE3ZWF3GFtSevZRitiYNdIPpQyAb
         JGZXsypHS4aK6aJT0gf1c6WiL3wGy0mdG+796IF/bMFqJKtYoCM7a5KgFa70UsK9DEr0
         c+8Llqd6y4lqwjGoxiP4e6xyvb1MMTuqMoM/aUxp+lmhll/qo9f1yIfooXWR38EtVO0u
         1cfGdUklQGF6lDuO5r73kC6/iYN8wPzUPvjee89JjLvw5LmV4QUloYS1Ilm7w8IbI33y
         FDzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=UBybgKMsxDd15bCY1F3MJ8sBpGdDmhHWbWdFhTLioM4=;
        b=WYyMmLV9o835/W4G2iWuiIHfz/r+FKEAjCljf8r/JKMp5+Bm7tP8WcNAW7ov3WJ7ZF
         YTK4H9nwbSXTOvHw8r6yuExNl/LAcjtKhL2o2n8OKuUAPBnkXmoDGxsrPqfiVCpIUq/f
         AJp82Bo/oiQVryx3YF3rZqQzAOV7QVnOH7BEv/pde5I8ADfZJc3EFosiUhJq3/CQmrYS
         6rloW90yC78TUuXb/vYSkT3iVTiu99mwgvaWxL+C2BiQSUgbughxoIQyZWRGAglMW8th
         ylmMancwOoQxZd7gjuUo+8l265l88NceI15Bc+U7lg+G7ktpE3+CVWZ+5kBuKObysWtl
         BmFA==
X-Gm-Message-State: ACgBeo3BflJU5pIg6Z1CCbI8W26Xq1zmGQ3umG2y8cBescBNAbfV+zzG
        yTPQif0Vo63pkZVUj506hfZIsZ1dkSA=
X-Google-Smtp-Source: AA6agR7Hddhegxzh+YOOhSjAICNxy7uHcQ+QSzFRfb31XvIr1J7CMsivhFHMlkkgXm4CdcZyYnr1CQ==
X-Received: by 2002:a17:903:189:b0:16f:24e4:1614 with SMTP id z9-20020a170903018900b0016f24e41614mr908929plg.103.1659602465204;
        Thu, 04 Aug 2022 01:41:05 -0700 (PDT)
Received: from localhost ([47.88.5.130])
        by smtp.gmail.com with ESMTPSA id f10-20020a170902860a00b0016d33b8a231sm232594plo.270.2022.08.04.01.41.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Aug 2022 01:41:04 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [RFC PATCH 7/8] workqueue: Remove the outer loop in maybe_create_worker()
Date:   Thu,  4 Aug 2022 16:41:34 +0800
Message-Id: <20220804084135.92425-8-jiangshanlai@gmail.com>
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

worker_thread() always does the recheck after getting the manager role,
so the recheck in the maybe_create_worker() is unneeded and is removed.

A piece of comment for maybe_create_worker() is removed because it is
not true anymore after the recheck is removed.

A piece of comment for manage_workers() is removed because there is
already another piece of comment explaining the same thing which is
more accurate.

Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 kernel/workqueue.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 64dc1833d11a..0d9844b81482 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -2091,9 +2091,6 @@ static void pool_mayday_timeout(struct timer_list *t)
  * sent to all rescuers with works scheduled on @pool to resolve
  * possible allocation deadlock.
  *
- * On return, need_to_create_worker() is guaranteed to be %false and
- * may_start_working() %true.
- *
  * LOCKING:
  * raw_spin_lock_irq(pool->lock) which may be released and regrabbed
  * multiple times.  Does GFP_KERNEL allocations.  Called only from
@@ -2103,7 +2100,6 @@ static void maybe_create_worker(struct worker_pool *pool)
 __releases(&pool->lock)
 __acquires(&pool->lock)
 {
-restart:
 	raw_spin_unlock_irq(&pool->lock);
 
 	/* if we don't make progress in MAYDAY_INITIAL_TIMEOUT, call for help */
@@ -2121,13 +2117,6 @@ __acquires(&pool->lock)
 
 	del_timer_sync(&pool->mayday_timer);
 	raw_spin_lock_irq(&pool->lock);
-	/*
-	 * This is necessary even after a new worker was just successfully
-	 * created as @pool->lock was dropped and the new worker might have
-	 * already become busy.
-	 */
-	if (need_to_create_worker(pool))
-		goto restart;
 }
 
 /**
@@ -2138,10 +2127,6 @@ __acquires(&pool->lock)
  * to.  At any given time, there can be only zero or one manager per
  * pool.  The exclusion is handled automatically by this function.
  *
- * The caller can safely start processing works on false return.  On
- * true return, it's guaranteed that need_to_create_worker() is false
- * and may_start_working() is true.
- *
  * CONTEXT:
  * raw_spin_lock_irq(pool->lock) which may be released and regrabbed
  * multiple times.  Does GFP_KERNEL allocations.
-- 
2.19.1.6.gb485710b

