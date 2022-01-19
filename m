Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8622E493C00
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 15:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355237AbiASOg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 09:36:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241536AbiASOfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 09:35:51 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481C4C061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 06:35:51 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id x22so10108527lfd.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 06:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2gtcKcgtvmZFmg0VIhIPJVczT0Y4Ko4N7yPLo6FJsaU=;
        b=lzZKq0uGA2c6dIndnc5wdhXHfoLCK5xKfp7ly5jNT707FGENvzPiJH/ewDeGhdVa4b
         JxnKFpFUPub/KjBvWghZnhI3DUxcyKZhpUvLtdKjxHLH91XCaNmP5isZyXDGmjumuH6B
         DZdNUZKHKC6kx5AHZwio+dQZTJllETvQaumz5FoyqmFpmX8i7y4BEGqp1Gm/uKsD9e//
         wxvTGwVOE8IijpHKBsNBzobvUDmE0JNV7McdWTIbLBjS5gSnvsu4eHwcgWMJ8R0nS2T4
         DuUfThUpIUEETRsosEmwM/ETJeHL+TkP/uLOsKsYVK5BjEamBjyNcmaq4Ov1jM2abrhh
         kKIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2gtcKcgtvmZFmg0VIhIPJVczT0Y4Ko4N7yPLo6FJsaU=;
        b=A0qRFWn9BFt/RqTmHbK7L8aZrt1LkKQDP/8nFu1EaD2M/VjgCjkHq12M5uLSXtJCWK
         S15On9QWYzgKrMoOoU/X0Bd2CM7t2Par9NMSE9TRGt0y6UOEPOuYUtL/lfF6z3ZKwWHQ
         KYyLD9/C5fMV7GaYQ+PnJ/a1fqvrc1kzJhtveVEYeeaZOZcMkbGX2LT84l704tV4pcJz
         1pZGIfcjYhINT6hqP9es7YY3GrrZxju+NVc55fssFTSnN9m92ZMekoPhvQWrjhJRHn/w
         6KWUjI3ElpW3QbPy9N3r0Ts4TwIPEAQ3b7DvSj7ZzhpYo2T9G8tlodAX2jQGf9jlXUaf
         ZVaQ==
X-Gm-Message-State: AOAM532XlUS05iUdrmJ6KoEEqcSGqnXB1RZfvco2lyQZTv72iUQ8DoJs
        KIaruV9jHRiCs6iXgDkzPLc=
X-Google-Smtp-Source: ABdhPJw5YZzp+Q846wPrtgIOdcgHDx7WVgT8XVUuQKHegy1zOKH6J7u/8aiSSyZp4jd/+1ihhYC3UA==
X-Received: by 2002:a2e:96c5:: with SMTP id d5mr3490755ljj.527.1642602949660;
        Wed, 19 Jan 2022 06:35:49 -0800 (PST)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id z13sm179943lfr.183.2022.01.19.06.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 06:35:49 -0800 (PST)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH 1/3] mm/vmalloc: Move draining areas out of caller context
Date:   Wed, 19 Jan 2022 15:35:38 +0100
Message-Id: <20220119143540.601149-1-urezki@gmail.com>
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

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index bdc7222f87d4..ed0f9eaa61a9 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -793,6 +793,9 @@ RB_DECLARE_CALLBACKS_MAX(static, free_vmap_area_rb_augment_cb,
 static void purge_vmap_area_lazy(void);
 static BLOCKING_NOTIFIER_HEAD(vmap_notify_list);
 static unsigned long lazy_max_pages(void);
+static void drain_vmap_area(struct work_struct *work);
+static DECLARE_WORK(drain_vmap_area_work, drain_vmap_area);
+static atomic_t drain_vmap_area_work_in_progress;
 
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
 
+static void drain_vmap_area(struct work_struct *work)
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
+	atomic_set(&drain_vmap_area_work_in_progress, 0);
+}
+
 /*
  * Free a vmap area, caller ensuring that the area has been unmapped
  * and flush_cache_vunmap had been called for the correct range
@@ -1768,7 +1776,8 @@ static void free_vmap_area_noflush(struct vmap_area *va)
 
 	/* After this point, we may free va at any time */
 	if (unlikely(nr_lazy > lazy_max_pages()))
-		try_purge_vmap_area_lazy();
+		if (!atomic_xchg(&drain_vmap_area_work_in_progress, 1))
+			schedule_work(&drain_vmap_area_work);
 }
 
 /*
-- 
2.30.2

