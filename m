Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6648B517AC6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 01:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233205AbiEBX0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 19:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233465AbiEBXYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 19:24:03 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3AA101F3
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 16:20:29 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2f7ee6bc6ddso147969587b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 16:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=NrggPJMHArjDpiACfFrSoL4HA6BUQAxkGUTXk8B/NZE=;
        b=klQRmcp9xFE8+tM+ysQYL9VDBN4LckYsFDfKZF6Snnhf1CnoJ3jJlFgvX7NQt7eo6S
         KcC3AiU3KPEcIP2frw2OINI7JQNJ2/hc7adBdYXnkO859jyTEE4ySq8yyHA9guBGcQxm
         u8XeCKgIn6S590Gbmy+rL3Kjsxt9rJP7t+DglEIAynfjEyQ7HCilfhlGwdHeEfDDCiYg
         HA6INNUvnK/EIBkwlINeTfOOPYPwtostFdWKFv+5TeKraPvfonxdg/tri7UWw3CZwwq3
         XPeI5eGUkQWU/Wrg4Qp056rK3MvCedrufLOIYkUsB2Av4HZAk8+E52BTXDJmwWPZLu4r
         2ghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NrggPJMHArjDpiACfFrSoL4HA6BUQAxkGUTXk8B/NZE=;
        b=fjEuVyApuVSH4/2eSTUBXSwOq7+GBBVW146UI8zZv7NbF5TpD4Q6Zfvobgjwx11sjn
         6DOfQByD0rKCq+33xAtGvJ/gZcaAAEfYqTr9ZK74uHYgcFVmxJNWFH35cmj2bGQ4tuWt
         jcgpo83RQgT/8mh1aphBNDWD7fgkesYNvpI6BO2W0Vut8HrhKRI9oJX82bd+B3F0aEE7
         C4JflHceBDJWPSCNzvTXnNg+XzRGENk+biTWw2RHnedAyJC3jrOuKhaaN1R4Acf5AMDR
         LDUjmQYvttJJA/h3MzgXTgnnbZjXDO3p2Ti2A0CPP6TfxbodCTnKa20N80KK3YIrCxE2
         lOqA==
X-Gm-Message-State: AOAM533Hf9mtC45KMUHwGDgK4uIDqc8kEtbSLrVtI2XLInBC0k95TCa9
        cS+KHArnbfeyLe2tO1II8571pbME6QuRZaI=
X-Google-Smtp-Source: ABdhPJxh1wMOvcyOegKBWYeQN6t6wvPC4LoQSFqDHaBtzUjfMMM5SUk45ATr7dorykZQsETQAoUcftJ6Qh891KA=
X-Received: from tj.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:53a])
 (user=tjmercier job=sendgmr) by 2002:a25:4047:0:b0:645:d6da:61 with SMTP id
 n68-20020a254047000000b00645d6da0061mr12141638yba.139.1651533613550; Mon, 02
 May 2022 16:20:13 -0700 (PDT)
Date:   Mon,  2 May 2022 23:19:36 +0000
In-Reply-To: <20220502231944.3891435-1-tjmercier@google.com>
Message-Id: <20220502231944.3891435-3-tjmercier@google.com>
Mime-Version: 1.0
References: <20220502231944.3891435-1-tjmercier@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH v6 2/6] cgroup: gpu: Add a cgroup controller for allocator
 attribution of GPU memory
From:   "T.J. Mercier" <tjmercier@google.com>
To:     tjmercier@google.com, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     daniel@ffwll.ch, hridya@google.com, christian.koenig@amd.com,
        jstultz@google.com, tkjos@android.com, cmllamas@google.com,
        surenb@google.com, kaleshsingh@google.com, Kenny.Ho@amd.com,
        mkoutny@suse.com, skhan@linuxfoundation.org,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hridya Valsaraju <hridya@google.com>

The cgroup controller provides accounting for GPU and GPU-related
memory allocations. The memory being accounted can be device memory or
memory allocated from pools dedicated to serve GPU-related tasks.

This patch adds APIs to:
-allow a device to register for memory accounting using the GPU cgroup
controller.
-charge and uncharge allocated memory to a cgroup.

When the cgroup controller is enabled, it would expose information about
the memory allocated by each device(registered for GPU cgroup memory
accounting) for each cgroup.

The API/UAPI can be extended to set per-device/total allocation limits
in the future.

The cgroup controller has been named following the discussion in [1].

[1]: https://lore.kernel.org/amd-gfx/YCJp%2F%2FkMC7YjVMXv@phenom.ffwll.local/

Signed-off-by: Hridya Valsaraju <hridya@google.com>
Signed-off-by: T.J. Mercier <tjmercier@google.com>

---
v5 changes
Support all strings for gpucg_register_device instead of just string
literals.

Enforce globally unique gpucg_bucket names.

Constrain gpucg_bucket name lengths to 64 bytes.

Obtain just a single css refcount instead of nr_pages for each
charge.

Rename:
gpucg_try_charge -> gpucg_charge
find_cg_rpool_locked -> cg_rpool_find_locked
init_cg_rpool -> cg_rpool_init
get_cg_rpool_locked -> cg_rpool_get_locked
"gpu cgroup controller" -> "GPU controller"
gpucg_device -> gpucg_bucket
usage -> size

v4 changes
Adjust gpucg_try_charge critical section for future charge transfer
functionality.

v3 changes
Use more common dual author commit message format per John Stultz.

v2 changes
Fix incorrect Kconfig help section indentation per Randy Dunlap.
---
 include/linux/cgroup_gpu.h    | 123 +++++++++++++
 include/linux/cgroup_subsys.h |   4 +
 init/Kconfig                  |   7 +
 kernel/cgroup/Makefile        |   1 +
 kernel/cgroup/gpu.c           | 324 ++++++++++++++++++++++++++++++++++
 5 files changed, 459 insertions(+)
 create mode 100644 include/linux/cgroup_gpu.h
 create mode 100644 kernel/cgroup/gpu.c

diff --git a/include/linux/cgroup_gpu.h b/include/linux/cgroup_gpu.h
new file mode 100644
index 000000000000..4dfe633d6ec7
--- /dev/null
+++ b/include/linux/cgroup_gpu.h
@@ -0,0 +1,123 @@
+/* SPDX-License-Identifier: MIT
+ * Copyright 2019 Advanced Micro Devices, Inc.
+ * Copyright (C) 2022 Google LLC.
+ */
+#ifndef _CGROUP_GPU_H
+#define _CGROUP_GPU_H
+
+#include <linux/cgroup.h>
+#include <linux/list.h>
+
+#define GPUCG_BUCKET_NAME_MAX_LEN 64
+
+#ifdef CONFIG_CGROUP_GPU
+ /* The GPU cgroup controller data structure */
+struct gpucg {
+	struct cgroup_subsys_state css;
+
+	/* list of all resource pools that belong to this cgroup */
+	struct list_head rpools;
+};
+
+/* A named entity representing bucket of tracked memory. */
+struct gpucg_bucket {
+	/* list of various resource pools in various cgroups that the bucket is part of */
+	struct list_head rpools;
+
+	/* list of all buckets registered for GPU cgroup accounting */
+	struct list_head bucket_node;
+
+	/* string to be used as identifier for accounting and limit setting */
+	const char *name;
+};
+
+/**
+ * css_to_gpucg - get the corresponding gpucg ref from a cgroup_subsys_state
+ * @css: the target cgroup_subsys_state
+ *
+ * Returns: gpu cgroup that contains the @css
+ */
+static inline struct gpucg *css_to_gpucg(struct cgroup_subsys_state *css)
+{
+	return css ? container_of(css, struct gpucg, css) : NULL;
+}
+
+/**
+ * gpucg_get - get the gpucg reference that a task belongs to
+ * @task: the target task
+ *
+ * This increases the reference count of the css that the @task belongs to.
+ *
+ * Returns: reference to the gpu cgroup the task belongs to.
+ */
+static inline struct gpucg *gpucg_get(struct task_struct *task)
+{
+	if (!cgroup_subsys_enabled(gpu_cgrp_subsys))
+		return NULL;
+	return css_to_gpucg(task_get_css(task, gpu_cgrp_id));
+}
+
+/**
+ * gpucg_put - put a gpucg reference
+ * @gpucg: the target gpucg
+ *
+ * Put a reference obtained via gpucg_get
+ */
+static inline void gpucg_put(struct gpucg *gpucg)
+{
+	if (gpucg)
+		css_put(&gpucg->css);
+}
+
+/**
+ * gpucg_parent - find the parent of a gpu cgroup
+ * @cg: the target gpucg
+ *
+ * This does not increase the reference count of the parent cgroup
+ *
+ * Returns: parent gpu cgroup of @cg
+ */
+static inline struct gpucg *gpucg_parent(struct gpucg *cg)
+{
+	return css_to_gpucg(cg->css.parent);
+}
+
+int gpucg_charge(struct gpucg *gpucg, struct gpucg_bucket *bucket, u64 size);
+void gpucg_uncharge(struct gpucg *gpucg, struct gpucg_bucket *bucket, u64 size);
+int gpucg_register_bucket(struct gpucg_bucket *bucket, const char *name);
+#else /* CONFIG_CGROUP_GPU */
+
+struct gpucg;
+struct gpucg_bucket;
+
+static inline struct gpucg *css_to_gpucg(struct cgroup_subsys_state *css)
+{
+	return NULL;
+}
+
+static inline struct gpucg *gpucg_get(struct task_struct *task)
+{
+	return NULL;
+}
+
+static inline void gpucg_put(struct gpucg *gpucg) {}
+
+static inline struct gpucg *gpucg_parent(struct gpucg *cg)
+{
+	return NULL;
+}
+
+static inline int gpucg_charge(struct gpucg *gpucg,
+			       struct gpucg_bucket *bucket,
+			       u64 size)
+{
+	return 0;
+}
+
+static inline void gpucg_uncharge(struct gpucg *gpucg,
+				  struct gpucg_bucket *bucket,
+				  u64 size) {}
+
+static inline int gpucg_register_bucket(struct gpucg_bucket *bucket, const char *name) {}
+#endif /* CONFIG_CGROUP_GPU */
+#endif /* _CGROUP_GPU_H */
diff --git a/include/linux/cgroup_subsys.h b/include/linux/cgroup_subsys.h
index 445235487230..46a2a7b93c41 100644
--- a/include/linux/cgroup_subsys.h
+++ b/include/linux/cgroup_subsys.h
@@ -65,6 +65,10 @@ SUBSYS(rdma)
 SUBSYS(misc)
 #endif
 
+#if IS_ENABLED(CONFIG_CGROUP_GPU)
+SUBSYS(gpu)
+#endif
+
 /*
  * The following subsystems are not supported on the default hierarchy.
  */
diff --git a/init/Kconfig b/init/Kconfig
index ddcbefe535e9..2e00a190e170 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -984,6 +984,13 @@ config BLK_CGROUP
 
 	See Documentation/admin-guide/cgroup-v1/blkio-controller.rst for more information.
 
+config CGROUP_GPU
+	bool "GPU controller (EXPERIMENTAL)"
+	select PAGE_COUNTER
+	help
+	  Provides accounting and limit setting for memory allocations by the GPU and
+	  GPU-related subsystems.
+
 config CGROUP_WRITEBACK
 	bool
 	depends on MEMCG && BLK_CGROUP
diff --git a/kernel/cgroup/Makefile b/kernel/cgroup/Makefile
index 12f8457ad1f9..be95a5a532fc 100644
--- a/kernel/cgroup/Makefile
+++ b/kernel/cgroup/Makefile
@@ -7,3 +7,4 @@ obj-$(CONFIG_CGROUP_RDMA) += rdma.o
 obj-$(CONFIG_CPUSETS) += cpuset.o
 obj-$(CONFIG_CGROUP_MISC) += misc.o
 obj-$(CONFIG_CGROUP_DEBUG) += debug.o
+obj-$(CONFIG_CGROUP_GPU) += gpu.o
diff --git a/kernel/cgroup/gpu.c b/kernel/cgroup/gpu.c
new file mode 100644
index 000000000000..34d0a5b85834
--- /dev/null
+++ b/kernel/cgroup/gpu.c
@@ -0,0 +1,324 @@
+// SPDX-License-Identifier: MIT
+// Copyright 2019 Advanced Micro Devices, Inc.
+// Copyright (C) 2022 Google LLC.
+
+#include <linux/cgroup.h>
+#include <linux/cgroup_gpu.h>
+#include <linux/err.h>
+#include <linux/gfp.h>
+#include <linux/mm.h>
+#include <linux/page_counter.h>
+#include <linux/seq_file.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+
+static struct gpucg *root_gpucg __read_mostly;
+
+/*
+ * Protects list of resource pools maintained on per cgroup basis and list
+ * of buckets registered for memory accounting using the GPU cgroup controller.
+ */
+static DEFINE_MUTEX(gpucg_mutex);
+static LIST_HEAD(gpucg_buckets);
+
+struct gpucg_resource_pool {
+	/* The bucket whose resource usage is tracked by this resource pool */
+	struct gpucg_bucket *bucket;
+
+	/* list of all resource pools for the cgroup */
+	struct list_head cg_node;
+
+	/* list maintained by the gpucg_bucket to keep track of its resource pools */
+	struct list_head bucket_node;
+
+	/* tracks memory usage of the resource pool */
+	struct page_counter total;
+};
+
+static void free_cg_rpool_locked(struct gpucg_resource_pool *rpool)
+{
+	lockdep_assert_held(&gpucg_mutex);
+
+	list_del(&rpool->cg_node);
+	list_del(&rpool->bucket_node);
+	kfree(rpool);
+}
+
+static void gpucg_css_free(struct cgroup_subsys_state *css)
+{
+	struct gpucg_resource_pool *rpool, *tmp;
+	struct gpucg *gpucg = css_to_gpucg(css);
+
+	// delete all resource pools
+	mutex_lock(&gpucg_mutex);
+	list_for_each_entry_safe(rpool, tmp, &gpucg->rpools, cg_node)
+		free_cg_rpool_locked(rpool);
+	mutex_unlock(&gpucg_mutex);
+
+	kfree(gpucg);
+}
+
+static struct cgroup_subsys_state *
+gpucg_css_alloc(struct cgroup_subsys_state *parent_css)
+{
+	struct gpucg *gpucg, *parent;
+
+	gpucg = kzalloc(sizeof(struct gpucg), GFP_KERNEL);
+	if (!gpucg)
+		return ERR_PTR(-ENOMEM);
+
+	parent = css_to_gpucg(parent_css);
+	if (!parent)
+		root_gpucg = gpucg;
+
+	INIT_LIST_HEAD(&gpucg->rpools);
+
+	return &gpucg->css;
+}
+
+static struct gpucg_resource_pool *cg_rpool_find_locked(
+	struct gpucg *cg,
+	struct gpucg_bucket *bucket)
+{
+	struct gpucg_resource_pool *rpool;
+
+	lockdep_assert_held(&gpucg_mutex);
+
+	list_for_each_entry(rpool, &cg->rpools, cg_node)
+		if (rpool->bucket == bucket)
+			return rpool;
+
+	return NULL;
+}
+
+static struct gpucg_resource_pool *cg_rpool_init(struct gpucg *cg,
+						 struct gpucg_bucket *bucket)
+{
+	struct gpucg_resource_pool *rpool = kzalloc(sizeof(*rpool),
+							GFP_KERNEL);
+	if (!rpool)
+		return ERR_PTR(-ENOMEM);
+
+	rpool->bucket = bucket;
+
+	page_counter_init(&rpool->total, NULL);
+	INIT_LIST_HEAD(&rpool->cg_node);
+	INIT_LIST_HEAD(&rpool->bucket_node);
+	list_add_tail(&rpool->cg_node, &cg->rpools);
+	list_add_tail(&rpool->bucket_node, &bucket->rpools);
+
+	return rpool;
+}
+
+/**
+ * get_cg_rpool_locked - find the resource pool for the specified bucket and
+ * specified cgroup. If the resource pool does not exist for the cg, it is
+ * created in a hierarchical manner in the cgroup and its ancestor cgroups who
+ * do not already have a resource pool entry for the bucket.
+ *
+ * @cg: The cgroup to find the resource pool for.
+ * @bucket: The bucket associated with the returned resource pool.
+ *
+ * Return: return resource pool entry corresponding to the specified bucket in
+ * the specified cgroup (hierarchically creating them if not existing already).
+ *
+ */
+static struct gpucg_resource_pool *
+cg_rpool_get_locked(struct gpucg *cg, struct gpucg_bucket *bucket)
+{
+	struct gpucg *parent_cg, *p, *stop_cg;
+	struct gpucg_resource_pool *rpool, *tmp_rpool;
+	struct gpucg_resource_pool *parent_rpool = NULL, *leaf_rpool = NULL;
+
+	rpool = cg_rpool_find_locked(cg, bucket);
+	if (rpool)
+		return rpool;
+
+	stop_cg = cg;
+	do {
+		rpool = cg_rpool_init(stop_cg, bucket);
+		if (IS_ERR(rpool))
+			goto err;
+
+		if (!leaf_rpool)
+			leaf_rpool = rpool;
+
+		stop_cg = gpucg_parent(stop_cg);
+		if (!stop_cg)
+			break;
+
+		rpool = cg_rpool_find_locked(stop_cg, bucket);
+	} while (!rpool);
+
+	/*
+	 * Re-initialize page counters of all rpools created in this invocation
+	 * to enable hierarchical charging.
+	 * stop_cg is the first ancestor cg who already had a resource pool for
+	 * the bucket. It can also be NULL if no ancestors had a pre-existing
+	 * resource pool for the bucket before this invocation.
+	 */
+	rpool = leaf_rpool;
+	for (p = cg; p != stop_cg; p = parent_cg) {
+		parent_cg = gpucg_parent(p);
+		if (!parent_cg)
+			break;
+		parent_rpool = cg_rpool_find_locked(parent_cg, bucket);
+		page_counter_init(&rpool->total, &parent_rpool->total);
+
+		rpool = parent_rpool;
+	}
+
+	return leaf_rpool;
+err:
+	for (p = cg; p != stop_cg; p = gpucg_parent(p)) {
+		tmp_rpool = cg_rpool_find_locked(p, bucket);
+		free_cg_rpool_locked(tmp_rpool);
+	}
+	return rpool;
+}
+
+/**
+ * gpucg_charge - charge memory to the specified gpucg and gpucg_bucket.
+ * Caller must hold a reference to @gpucg obtained through gpucg_get(). The size
+ * of the memory is rounded up to be a multiple of the page size.
+ *
+ * @gpucg: The gpu cgroup to charge the memory to.
+ * @bucket: The bucket to charge the memory to.
+ * @size: The size of memory to charge in bytes.
+ *        This size will be rounded up to the nearest page size.
+ *
+ * Return: returns 0 if the charging is successful and otherwise returns an
+ * error code.
+ */
+int gpucg_charge(struct gpucg *gpucg, struct gpucg_bucket *bucket, u64 size)
+{
+	struct page_counter *counter;
+	u64 nr_pages;
+	struct gpucg_resource_pool *rp;
+	int ret = 0;
+
+	nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
+
+	mutex_lock(&gpucg_mutex);
+	rp = cg_rpool_get_locked(gpucg, bucket);
+	/*
+	 * Continue to hold gpucg_mutex because we use it to block charges while transfers are in
+	 * progress to avoid potentially exceeding a limit.
+	 */
+	if (IS_ERR(rp)) {
+		mutex_unlock(&gpucg_mutex);
+		return PTR_ERR(rp);
+	}
+
+	if (page_counter_try_charge(&rp->total, nr_pages, &counter))
+		css_get(&gpucg->css);
+	else
+		ret = -ENOMEM;
+	mutex_unlock(&gpucg_mutex);
+
+	return ret;
+}
+
+/**
+ * gpucg_uncharge - uncharge memory from the specified gpucg and gpucg_bucket.
+ * The caller must hold a reference to @gpucg obtained through gpucg_get().
+ *
+ * @gpucg: The gpu cgroup to uncharge the memory from.
+ * @bucket: The bucket to uncharge the memory from.
+ * @size: The size of memory to uncharge in bytes.
+ *        This size will be rounded up to the nearest page size.
+ */
+void gpucg_uncharge(struct gpucg *gpucg, struct gpucg_bucket *bucket, u64 size)
+{
+	u64 nr_pages;
+	struct gpucg_resource_pool *rp;
+
+	mutex_lock(&gpucg_mutex);
+	rp = cg_rpool_find_locked(gpucg, bucket);
+	/*
+	 * gpucg_mutex can be unlocked here, rp will stay valid until gpucg is freed and there are
+	 * active refs on gpucg. Uncharges are fine while transfers are in progress since there is
+	 * no potential to exceed a limit while uncharging and transferring.
+	 */
+	mutex_unlock(&gpucg_mutex);
+
+	if (unlikely(!rp)) {
+		pr_err("Resource pool not found, incorrect charge/uncharge ordering?\n");
+		return;
+	}
+
+	nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
+	page_counter_uncharge(&rp->total, nr_pages);
+	css_put(&gpucg->css);
+}
+
+/**
+ * gpucg_register_bucket - Registers a bucket for memory accounting using the
+ * GPU cgroup controller.
+ *
+ * @bucket: The bucket to register for memory accounting.
+ * @name: Pointer to a null-terminated string to denote the name of the bucket. This name should be
+ *        globally unique, and should not exceed @GPUCG_BUCKET_NAME_MAX_LEN bytes.
+ *
+ * @bucket must remain valid. @name will be copied.
+ *
+ * Returns 0 on success, or a negative errno code otherwise.
+ */
+int gpucg_register_bucket(struct gpucg_bucket *bucket, const char *name)
+{
+	struct gpucg_bucket *b;
+
+	if (!bucket || !name)
+		return -EINVAL;
+
+	if (strlen(name) >= GPUCG_BUCKET_NAME_MAX_LEN)
+		return -ENAMETOOLONG;
+
+	INIT_LIST_HEAD(&bucket->bucket_node);
+	INIT_LIST_HEAD(&bucket->rpools);
+	bucket->name = kstrdup_const(name, GFP_KERNEL);
+
+	mutex_lock(&gpucg_mutex);
+	list_for_each_entry(b, &gpucg_buckets, bucket_node) {
+		if (strncmp(b->name, bucket->name, GPUCG_BUCKET_NAME_MAX_LEN) == 0) {
+			mutex_unlock(&gpucg_mutex);
+			kfree_const(bucket->name);
+			return -EEXIST;
+		}
+	}
+	list_add_tail(&bucket->bucket_node, &gpucg_buckets);
+	mutex_unlock(&gpucg_mutex);
+
+	return 0;
+}
+
+static int gpucg_resource_show(struct seq_file *sf, void *v)
+{
+	struct gpucg_resource_pool *rpool;
+	struct gpucg *cg = css_to_gpucg(seq_css(sf));
+
+	mutex_lock(&gpucg_mutex);
+	list_for_each_entry(rpool, &cg->rpools, cg_node) {
+		seq_printf(sf, "%s %lu\n", rpool->bucket->name,
+			   page_counter_read(&rpool->total) * PAGE_SIZE);
+	}
+	mutex_unlock(&gpucg_mutex);
+
+	return 0;
+}
+
+struct cftype files[] = {
+	{
+		.name = "memory.current",
+		.seq_show = gpucg_resource_show,
+	},
+	{ }     /* terminate */
+};
+
+struct cgroup_subsys gpu_cgrp_subsys = {
+	.css_alloc      = gpucg_css_alloc,
+	.css_free       = gpucg_css_free,
+	.early_init     = false,
+	.legacy_cftypes = files,
+	.dfl_cftypes    = files,
+};
-- 
2.36.0.464.gb9c8b46e94-goog

