Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B10587F61
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 17:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237403AbiHBPwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 11:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237467AbiHBPvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 11:51:53 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DAB83CBE7;
        Tue,  2 Aug 2022 08:51:43 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id q7-20020a17090a7a8700b001f300db8677so15753988pjf.5;
        Tue, 02 Aug 2022 08:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Le752qOQHMV5YKNomZZhvKAccL9F4fI/bs+OgheaM0E=;
        b=ZNmkoFJQCUZt/2K96EzfkPzt9hq2E2EaSqg5Iw2fag3s0eYQQMl++JyuKjbMEiSDF5
         nIHWuSk1zkzgQmlVeTromJairAKWW1CiLdtYFo9LSsi66uYoD9Oiq35ycvhOYrqdiNn4
         US2PAzSSj3mjIrO585M5l5pkEIrd9DEiewZ8hn7SxBh0DJueyu2+w4rPwRRH1COp1AGC
         yl2nX3cVFnmYta09Sdp0KeoCr7G/C+6cVMY5Z4/R+ljdwmRGQfisKAuLJm6sORDzTwW1
         67G/r6ywbgOz7sv1sso5TdI6BJaqhfdfozKHr7O4cVXyLoNwRr7KQ6U99AOBJQnL1Mu6
         C3Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Le752qOQHMV5YKNomZZhvKAccL9F4fI/bs+OgheaM0E=;
        b=1LHnYP+bBEMF9tEJClnTmKZmAxzEUoAObQSDom8Vb3w6HRadBcnmHexVvszyhcE4en
         QapUEFVNzI4cCNoFQ0v1u5nE8oHWB6d/tQWLvp3EGawjPIF55K71Qb+hDn8Z3UFrvjjH
         kHQhmqAg6PjWjcT8K7kK0OswAQMGnKdq7yva31hH2LZTPlsEAPUleUL6BMauDWAWq4Id
         y5mWwohEd8kD3VLc++Ix2T9C7ynRYJI6JJQ5xIr8OoYzxqh38qjiGKTdk7oAtdRPIxzY
         hUfBhhWjmJbnGQj1BZCdIHdE78MG2/WEdn6lSitn7p/G0ai4oKNkwJi79quR9hxGDNUZ
         bS6g==
X-Gm-Message-State: ACgBeo0Ywxx5B3K4p4BjR45KTuWVEpj8t771bR2j+6pGWel5kk92LkjC
        19f7IlfqBKudyFDXaJ7nZdMAVdEOc3w=
X-Google-Smtp-Source: AA6agR5ifOOl6novGltLYp/+Nqhh+R7D/QWeM2OiTe0tVonfWJscREiz+fHcPxqwBLzSs5IbjVsN8g==
X-Received: by 2002:a17:90b:4d8e:b0:1f3:160e:1a5c with SMTP id oj14-20020a17090b4d8e00b001f3160e1a5cmr155031pjb.10.1659455502353;
        Tue, 02 Aug 2022 08:51:42 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id a15-20020a170902710f00b0016d9468bb20sm11920276pll.129.2022.08.02.08.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 08:51:41 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 09/15] drm/gem: Add LRU/shrinker helper
Date:   Tue,  2 Aug 2022 08:51:42 -0700
Message-Id: <20220802155152.1727594-10-robdclark@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220802155152.1727594-1-robdclark@gmail.com>
References: <20220802155152.1727594-1-robdclark@gmail.com>
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

From: Rob Clark <robdclark@chromium.org>

Add a simple LRU helper to assist with driver's shrinker implementation.
It handles tracking the number of backing pages associated with a given
LRU, and provides a helper to implement shrinker_scan.

A driver can use multiple LRU instances to track objects in various
states, for example a dontneed LRU for purgeable objects, a willneed LRU
for evictable objects, and an unpinned LRU for objects without backing
pages.

All LRUs that the object can be moved between must share a single lock.

v2: lockdep_assert_held() instead of WARN_ON(!mutex_is_locked())
v3: make drm_gem_lru_move_tail_locked() static until there is a user

Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/drm_gem.c | 170 ++++++++++++++++++++++++++++++++++++++
 include/drm/drm_gem.h     |  55 ++++++++++++
 2 files changed, 225 insertions(+)

diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index eb0c2d041f13..556714c10472 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -165,6 +165,7 @@ void drm_gem_private_object_init(struct drm_device *dev,
 		obj->resv = &obj->_resv;
 
 	drm_vma_node_reset(&obj->vma_node);
+	INIT_LIST_HEAD(&obj->lru_node);
 }
 EXPORT_SYMBOL(drm_gem_private_object_init);
 
@@ -951,6 +952,7 @@ drm_gem_object_release(struct drm_gem_object *obj)
 
 	dma_resv_fini(&obj->_resv);
 	drm_gem_free_mmap_offset(obj);
+	drm_gem_lru_remove(obj);
 }
 EXPORT_SYMBOL(drm_gem_object_release);
 
@@ -1274,3 +1276,171 @@ drm_gem_unlock_reservations(struct drm_gem_object **objs, int count,
 	ww_acquire_fini(acquire_ctx);
 }
 EXPORT_SYMBOL(drm_gem_unlock_reservations);
+
+/**
+ * drm_gem_lru_init - initialize a LRU
+ *
+ * @lru: The LRU to initialize
+ * @lock: The lock protecting the LRU
+ */
+void
+drm_gem_lru_init(struct drm_gem_lru *lru, struct mutex *lock)
+{
+	lru->lock = lock;
+	lru->count = 0;
+	INIT_LIST_HEAD(&lru->list);
+}
+EXPORT_SYMBOL(drm_gem_lru_init);
+
+static void
+drm_gem_lru_remove_locked(struct drm_gem_object *obj)
+{
+	obj->lru->count -= obj->size >> PAGE_SHIFT;
+	WARN_ON(obj->lru->count < 0);
+	list_del(&obj->lru_node);
+	obj->lru = NULL;
+}
+
+/**
+ * drm_gem_lru_remove - remove object from whatever LRU it is in
+ *
+ * If the object is currently in any LRU, remove it.
+ *
+ * @obj: The GEM object to remove from current LRU
+ */
+void
+drm_gem_lru_remove(struct drm_gem_object *obj)
+{
+	struct drm_gem_lru *lru = obj->lru;
+
+	if (!lru)
+		return;
+
+	mutex_lock(lru->lock);
+	drm_gem_lru_remove_locked(obj);
+	mutex_unlock(lru->lock);
+}
+EXPORT_SYMBOL(drm_gem_lru_remove);
+
+static void
+drm_gem_lru_move_tail_locked(struct drm_gem_lru *lru, struct drm_gem_object *obj)
+{
+	lockdep_assert_held_once(lru->lock);
+
+	if (obj->lru)
+		drm_gem_lru_remove_locked(obj);
+
+	lru->count += obj->size >> PAGE_SHIFT;
+	list_add_tail(&obj->lru_node, &lru->list);
+	obj->lru = lru;
+}
+
+/**
+ * drm_gem_lru_move_tail - move the object to the tail of the LRU
+ *
+ * If the object is already in this LRU it will be moved to the
+ * tail.  Otherwise it will be removed from whichever other LRU
+ * it is in (if any) and moved into this LRU.
+ *
+ * @lru: The LRU to move the object into.
+ * @obj: The GEM object to move into this LRU
+ */
+void
+drm_gem_lru_move_tail(struct drm_gem_lru *lru, struct drm_gem_object *obj)
+{
+	mutex_lock(lru->lock);
+	drm_gem_lru_move_tail_locked(lru, obj);
+	mutex_unlock(lru->lock);
+}
+EXPORT_SYMBOL(drm_gem_lru_move_tail);
+
+/**
+ * drm_gem_lru_scan - helper to implement shrinker.scan_objects
+ *
+ * If the shrink callback succeeds, it is expected that the driver
+ * move the object out of this LRU.
+ *
+ * If the LRU possibly contain active buffers, it is the responsibility
+ * of the shrink callback to check for this (ie. dma_resv_test_signaled())
+ * or if necessary block until the buffer becomes idle.
+ *
+ * @lru: The LRU to scan
+ * @nr_to_scan: The number of pages to try to reclaim
+ * @shrink: Callback to try to shrink/reclaim the object.
+ */
+unsigned long
+drm_gem_lru_scan(struct drm_gem_lru *lru, unsigned nr_to_scan,
+		 bool (*shrink)(struct drm_gem_object *obj))
+{
+	struct drm_gem_lru still_in_lru;
+	struct drm_gem_object *obj;
+	unsigned freed = 0;
+
+	drm_gem_lru_init(&still_in_lru, lru->lock);
+
+	mutex_lock(lru->lock);
+
+	while (freed < nr_to_scan) {
+		obj = list_first_entry_or_null(&lru->list, typeof(*obj), lru_node);
+
+		if (!obj)
+			break;
+
+		drm_gem_lru_move_tail_locked(&still_in_lru, obj);
+
+		/*
+		 * If it's in the process of being freed, gem_object->free()
+		 * may be blocked on lock waiting to remove it.  So just
+		 * skip it.
+		 */
+		if (!kref_get_unless_zero(&obj->refcount))
+			continue;
+
+		/*
+		 * Now that we own a reference, we can drop the lock for the
+		 * rest of the loop body, to reduce contention with other
+		 * code paths that need the LRU lock
+		 */
+		mutex_unlock(lru->lock);
+
+		/*
+		 * Note that this still needs to be trylock, since we can
+		 * hit shrinker in response to trying to get backing pages
+		 * for this obj (ie. while it's lock is already held)
+		 */
+		if (!dma_resv_trylock(obj->resv))
+			goto tail;
+
+		if (shrink(obj)) {
+			freed += obj->size >> PAGE_SHIFT;
+
+			/*
+			 * If we succeeded in releasing the object's backing
+			 * pages, we expect the driver to have moved the object
+			 * out of this LRU
+			 */
+			WARN_ON(obj->lru == &still_in_lru);
+			WARN_ON(obj->lru == lru);
+		}
+
+		dma_resv_unlock(obj->resv);
+
+tail:
+		drm_gem_object_put(obj);
+		mutex_lock(lru->lock);
+	}
+
+	/*
+	 * Move objects we've skipped over out of the temporary still_in_lru
+	 * back into this LRU
+	 */
+	list_for_each_entry (obj, &still_in_lru.list, lru_node)
+		obj->lru = lru;
+	list_splice_tail(&still_in_lru.list, &lru->list);
+	lru->count += still_in_lru.count;
+
+	mutex_unlock(lru->lock);
+
+	return freed;
+}
+EXPORT_SYMBOL(drm_gem_lru_scan);
diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
index 87cffc9efa85..f28a48a6f846 100644
--- a/include/drm/drm_gem.h
+++ b/include/drm/drm_gem.h
@@ -174,6 +174,41 @@ struct drm_gem_object_funcs {
 	const struct vm_operations_struct *vm_ops;
 };
 
+/**
+ * struct drm_gem_lru - A simple LRU helper
+ *
+ * A helper for tracking GEM objects in a given state, to aid in
+ * driver's shrinker implementation.  Tracks the count of pages
+ * for lockless &shrinker.count_objects, and provides
+ * &drm_gem_lru_scan for driver's &shrinker.scan_objects
+ * implementation.
+ */
+struct drm_gem_lru {
+	/**
+	 * @lock:
+	 *
+	 * Lock protecting movement of GEM objects between LRUs.  All
+	 * LRUs that the object can move between should be protected
+	 * by the same lock.
+	 */
+	struct mutex *lock;
+
+	/**
+	 * @count:
+	 *
+	 * The total number of backing pages of the GEM objects in
+	 * this LRU.
+	 */
+	long count;
+
+	/**
+	 * @list:
+	 *
+	 * The LRU list.
+	 */
+	struct list_head list;
+};
+
 /**
  * struct drm_gem_object - GEM buffer object
  *
@@ -312,6 +347,20 @@ struct drm_gem_object {
 	 *
 	 */
 	const struct drm_gem_object_funcs *funcs;
+
+	/**
+	 * @lru_node:
+	 *
+	 * List node in a &drm_gem_lru.
+	 */
+	struct list_head lru_node;
+
+	/**
+	 * @lru:
+	 *
+	 * The current LRU list that the GEM object is on.
+	 */
+	struct drm_gem_lru *lru;
 };
 
 /**
@@ -420,4 +469,10 @@ void drm_gem_unlock_reservations(struct drm_gem_object **objs, int count,
 int drm_gem_dumb_map_offset(struct drm_file *file, struct drm_device *dev,
 			    u32 handle, u64 *offset);
 
+void drm_gem_lru_init(struct drm_gem_lru *lru, struct mutex *lock);
+void drm_gem_lru_remove(struct drm_gem_object *obj);
+void drm_gem_lru_move_tail(struct drm_gem_lru *lru, struct drm_gem_object *obj);
+unsigned long drm_gem_lru_scan(struct drm_gem_lru *lru, unsigned nr_to_scan,
+			       bool (*shrink)(struct drm_gem_object *obj));
+
 #endif /* __DRM_GEM_H__ */
-- 
2.36.1

