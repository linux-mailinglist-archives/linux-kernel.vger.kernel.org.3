Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D40194A4983
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 15:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238997AbiAaOlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 09:41:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236916AbiAaOlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 09:41:09 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8ACC061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 06:41:09 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id o12so27232628lfg.12
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 06:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YTDMLLL9wbIhmayIu01fXxrx4uBIFemwXrq+zvvqr2U=;
        b=ax77L6WROLWBWjZyRjxBD2S90Qc8JR3gPPDnwsNDKYZ+XqnWYWNi/0wjub1MGKDivX
         1bcy/RAJkOlPsVkePVfs2xcYgVbn37CV+l/4Sr9u6R93NWDzayPgrywZeHz/RLhk0iZF
         EJgsZHqUVOYRGhRza9L0JKFLil4bQ/rQ8jtED+aczIeVHo6X7QJdaFRrAeRsmAiMlFpQ
         vZP8A2W2aQGDHFQRoyeM/ldCDBUT+8gVtm9P7VtzGNDYq0xaoqemLbkIdGFAn2hx3H7R
         Vn04XnxKK1NM37KD/ZJi/XEUd8y9wy4qVYQSUl7ndtkrJRN9zLTizkU8KPeONzYFfiCp
         3gYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YTDMLLL9wbIhmayIu01fXxrx4uBIFemwXrq+zvvqr2U=;
        b=yUXj2wAPth8KcftmSgETG1tVhMHUuZc3nmoy9uR7CwiiJnP4x6xuZLMzDJ4C+vV0l+
         Hof7TiSHLnghXW1yFT5HhlrMB8OvPzlkF4BIT5jUtOXisl5UQIAIPYwUkrnstCS0x/wz
         xXB9xlPdJYREzOuu2IDqTB2pcNRZYOECufExniJa1wfL8fVslvCsvfl562MLZiGB+9HX
         lZECL4c4W59Pi3FixCqzjWqIR7V3NMmVKau2UQYx4aIWwHoYfNqTUIdQZQBpxeu0Q2Ql
         y2OOF3t+N99lXD08kCu56dbcx9ln9LmXmIAFGdVUV+EIsOvzzANVOKFCj8TKSCnb1v+J
         x5UA==
X-Gm-Message-State: AOAM531LYa+rohx54f91KN5WHjVYtpWnclbv4MezA42OGzr6QzDYjSmi
        zzc5HY02fTwcuBTti1xCsTg=
X-Google-Smtp-Source: ABdhPJzUixN6LMjgbInq2cdJPPTgt/c+gGvYkyRxjepVyzNznLE0T9ElCf8vFjsYVk3sdhGkpTc/Xw==
X-Received: by 2002:a05:6512:2144:: with SMTP id s4mr13972034lfr.504.1643640067474;
        Mon, 31 Jan 2022 06:41:07 -0800 (PST)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id y32sm3670582lfa.15.2022.01.31.06.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 06:41:06 -0800 (PST)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH v3 1/1] mm/vmalloc: Move draining areas out of caller context
Date:   Mon, 31 Jan 2022 15:40:58 +0100
Message-Id: <20220131144058.35608-1-urezki@gmail.com>
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
v2->v3:
   - Remove the drain_vmap_work_in_progress. Extra queuing
     is expectable under heavy load but it can be disregarded
     because a work will bail out if nothing to be done.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index bdc7222f87d4..5d721542bed7 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -793,6 +793,8 @@ RB_DECLARE_CALLBACKS_MAX(static, free_vmap_area_rb_augment_cb,
 static void purge_vmap_area_lazy(void);
 static BLOCKING_NOTIFIER_HEAD(vmap_notify_list);
 static unsigned long lazy_max_pages(void);
+static void drain_vmap_area_work(struct work_struct *work);
+static DECLARE_WORK(drain_vmap_work, drain_vmap_area_work);
 
 static atomic_long_t nr_vmalloc_pages;
 
@@ -1719,18 +1721,6 @@ static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end)
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
@@ -1742,6 +1732,20 @@ static void purge_vmap_area_lazy(void)
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
+}
+
 /*
  * Free a vmap area, caller ensuring that the area has been unmapped
  * and flush_cache_vunmap had been called for the correct range
@@ -1768,7 +1772,7 @@ static void free_vmap_area_noflush(struct vmap_area *va)
 
 	/* After this point, we may free va at any time */
 	if (unlikely(nr_lazy > lazy_max_pages()))
-		try_purge_vmap_area_lazy();
+		schedule_work(&drain_vmap_work);
 }
 
 /*
-- 
2.30.2

