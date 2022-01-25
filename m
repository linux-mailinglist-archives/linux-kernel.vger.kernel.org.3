Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81E2D49B909
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 17:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380371AbiAYQoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 11:44:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1584500AbiAYQja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 11:39:30 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E75EC06173D
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 08:39:29 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id q22so8934631ljh.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 08:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FDpf/tqpMlV9Ib2LRvV4j3vhlXhSgAj3mSGN2d7ZcYY=;
        b=FbkCyN5KWevqIjBzepzV3zujCRXPPi2w+x9Sf9h+1yZiy/ezQGqJB/9ej79Rz2tHmQ
         cpySobBwvJqOilvtiU6wle2CgH+aBeeHmbLPiWaRsjPjnCXD8bRH20XKM6CtDAHBYSm3
         IYukg5lNcTem467DaJZtbq1Ud8hhXDyp3BUJ1PHt3Xn/jk2Bw27IVxJLGYutUaBQgFjr
         yTwdpP/0yv3FR+qonYINVRoVCiTvLB55d9K/VtCiFg6nasKfhPviVUQ7lBfEQh4QRjpv
         wGFss31oaumvdnWDDHdh6I/x9fUPVTpBsqz1QP/o05RvFjcXxzUJtjVe5pvQU1wuenHf
         J+0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FDpf/tqpMlV9Ib2LRvV4j3vhlXhSgAj3mSGN2d7ZcYY=;
        b=ycOnC9P1Idap8ALqXJeyhyMJVjxihBwngMcwn+ECnOmp1w4dOSo6FV8KJGq/28PbDt
         ArezFQQTTGQJpalKW6ad6wVIxqwCeSVD13Zo5+kjErbaoEwP77w9rtsSO6KNkaparzgV
         HD8bZ1h4+2RkqLttaixOOA/ao4x1WM+l8/prA1ihds5E3VdbCm58lQnFeegGFAJPbYov
         GRGWyj1AuAnGB8LXh8MEakgETJl3DmS3qlBwSl1VvbxA0dqT1vd4Xc//b3+CW6GYx50y
         ZFot/FC2QoJv/meYEGxLVTKQzsgFHgqQcFhmGc09rLouEOHRuslGUCBeHxGvxIDruTPi
         DxoQ==
X-Gm-Message-State: AOAM532j9rput0D6GorjzXMdYaSmTQ2H8TqOIM2Y7mDRRmBXF/amaJg3
        E3akU2XVI/wJg3O3igVT2nk=
X-Google-Smtp-Source: ABdhPJwNxbGBBpe9r6A1WHWICesZo5SEMLzazCTOBWAPeAR7cp4CbLSQEB/IDzN4FGMhDmLs415Lrw==
X-Received: by 2002:a2e:8815:: with SMTP id x21mr10229829ljh.392.1643128767612;
        Tue, 25 Jan 2022 08:39:27 -0800 (PST)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id h23sm333898lfv.46.2022.01.25.08.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 08:39:23 -0800 (PST)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH v2 1/1] mm/vmalloc: Move draining areas out of caller context
Date:   Tue, 25 Jan 2022 17:39:12 +0100
Message-Id: <20220125163912.2809-1-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A caller initiates the drain procces from its context once the
drain threshold is reached or passed. There are at least two
drawbacks of doing so:

a) a caller can be a high-prio or RT task. In that case it can
   stuck in doing the actual drain of all lazily freed areas.
   This is not optimal because such tasks usually are latency
   sensitive where the control should be returned back as soon
   as possible in order to drive such workloads in time. See
   96e2db456135 ("mm/vmalloc: rework the drain logic")

b) It is not safe to call vfree() during holding a spinlock due
   to the vmap_purge_lock mutex. The was a report about this from
   Zeal Robot <zealci@zte.com.cn> here:
   https://lore.kernel.org/all/20211222081026.484058-1-chi.minghao@zte.com.cn

Moving the drain to the separate work context addresses those
issues.

v1->v2:
   - Added prefix "_work" to the drain worker function.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index bdc7222f87d4..e5285c9d2e2a 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -793,6 +793,9 @@ RB_DECLARE_CALLBACKS_MAX(static, free_vmap_area_rb_augment_cb,
 static void purge_vmap_area_lazy(void);
 static BLOCKING_NOTIFIER_HEAD(vmap_notify_list);
 static unsigned long lazy_max_pages(void);
+static void drain_vmap_area_work(struct work_struct *work);
+static DECLARE_WORK(drain_vmap_work, drain_vmap_area_work);
+static atomic_t drain_vmap_work_in_progress;
 
 static atomic_long_t nr_vmalloc_pages;
 
@@ -1719,18 +1722,6 @@ static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end)
 	return true;
 }
 
-/*
- * Kick off a purge of the outstanding lazy areas. Don't bother if somebody
- * is already purging.
- */
-static void try_purge_vmap_area_lazy(void)
-{
-	if (mutex_trylock(&vmap_purge_lock)) {
-		__purge_vmap_area_lazy(ULONG_MAX, 0);
-		mutex_unlock(&vmap_purge_lock);
-	}
-}
-
 /*
  * Kick off a purge of the outstanding lazy areas.
  */
@@ -1742,6 +1733,23 @@ static void purge_vmap_area_lazy(void)
 	mutex_unlock(&vmap_purge_lock);
 }
 
+static void drain_vmap_area_work(struct work_struct *work)
+{
+	unsigned long nr_lazy;
+
+	do {
+		mutex_lock(&vmap_purge_lock);
+		__purge_vmap_area_lazy(ULONG_MAX, 0);
+		mutex_unlock(&vmap_purge_lock);
+
+		/* Recheck if further work is required. */
+		nr_lazy = atomic_long_read(&vmap_lazy_nr);
+	} while (nr_lazy > lazy_max_pages());
+
+	/* We are done at this point. */
+	atomic_set(&drain_vmap_work_in_progress, 0);
+}
+
 /*
  * Free a vmap area, caller ensuring that the area has been unmapped
  * and flush_cache_vunmap had been called for the correct range
@@ -1768,7 +1776,8 @@ static void free_vmap_area_noflush(struct vmap_area *va)
 
 	/* After this point, we may free va at any time */
 	if (unlikely(nr_lazy > lazy_max_pages()))
-		try_purge_vmap_area_lazy();
+		if (!atomic_xchg(&drain_vmap_work_in_progress, 1))
+			schedule_work(&drain_vmap_work);
 }
 
 /*
-- 
2.30.2

