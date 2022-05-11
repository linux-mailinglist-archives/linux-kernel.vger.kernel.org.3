Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698575227F0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 01:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238797AbiEJX5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 19:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238629AbiEJX5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 19:57:04 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2ED620823C
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 16:57:02 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id l26-20020a25ad5a000000b0064adb7991f6so417096ybe.8
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 16:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=gpc+taySKk3MNhQfkQXGrP1E1S3X7b6iIkkrvK0jjQk=;
        b=FJgoF3XQED/pmTUW/k8/kwQOacCwuY8PajnlvmNo7vPUrW03rQhgNqVylRfk6bt9N5
         +pBo04gYW2XdAwzcMMCR4QrepYsOYrpGeSwGHfZ7I8DbxYFsr4mFLEAh6eXvhioT62Aw
         pinwSZ/tiKIcjJZSco9BfroDbcJ+T0H3sY0aosRWw8hSHMilM7WEzjPRIvqiUwZ7Dm0n
         PAeMkkxoM+scEWgJgxPLA8dmQBCsp20INriwhq4AIBrW0b0Wo8r8cXXtwpDX2WvlaAkd
         xgPmaVvQrnsBAdrf9NuE/bszYtPwceY8NGbj7kqwxnmMUl4DnGiCLCwNEei5oFmBrFYb
         n9cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=gpc+taySKk3MNhQfkQXGrP1E1S3X7b6iIkkrvK0jjQk=;
        b=FSu+aDF+0yTjFtsiA88sT5+nI+6S21XtgSslLGxw+tokdFvApD7p6y3U1F+T6ZfZL3
         ts36bpm568FClYRSvY8ZoL9I12MTsKC0SCum3Mw2R8EPZvzVfQHrRiaB0RwlkwyOePR6
         8qoppjUJeelrnt7b28jqRKaEgtZIsthe14baLpwEwpdcd/BFK6Qi5ki1ZxIHpwhmTTTc
         SVZdNvKa65O/ylUjEK59dr/U0WxFUZSxZHaJ6Hkm1biZSGJtCwTaVP+pPeQNJga79mN7
         Gw3DRzRC9g9w1sValqgcC/oGWNbv8OJq1OxcZEjuidgdqnmtgtiiTupucHHYkC1+6WEU
         JhEA==
X-Gm-Message-State: AOAM530XxgGGjdG0JPw361Rydcjlg90g41IlOq0ghW+Kue4B8L30NzSY
        +K+EmmTGa2coyaQ5QR8cUu4CDxTcnnbhRN0=
X-Google-Smtp-Source: ABdhPJz0zXu4ZAwmDD5a3Zr4zNSeYdSZDCB0YRiRirzMXasBTaC1edOgJ/1mVkJ29siYdT+Menb7z5oDCrlMv70=
X-Received: from tj.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:53a])
 (user=tjmercier job=sendgmr) by 2002:a25:dd01:0:b0:64a:13f1:fd65 with SMTP id
 u1-20020a25dd01000000b0064a13f1fd65mr20129591ybg.609.1652227021979; Tue, 10
 May 2022 16:57:01 -0700 (PDT)
Date:   Tue, 10 May 2022 23:56:46 +0000
In-Reply-To: <20220510235653.933868-1-tjmercier@google.com>
Message-Id: <20220510235653.933868-3-tjmercier@google.com>
Mime-Version: 1.0
References: <20220510235653.933868-1-tjmercier@google.com>
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
Subject: [PATCH v7 2/6] cgroup: gpu: Add a cgroup controller for allocator
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
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

[1]: https://lore.kernel.org/amd-gfx/YCJp%2F%2FkMC7YjVMXv@phenom.ffwll.loca=
l/

Signed-off-by: Hridya Valsaraju <hridya@google.com>
Signed-off-by: T.J. Mercier <tjmercier@google.com>

---
v7 changes
Hide gpucg and gpucg_bucket struct definitions per Michal Koutn=C3=BD.
This means gpucg_register_bucket now returns an internally allocated
struct gpucg_bucket.

Move all public function documentation to the cgroup_gpu.h header.

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
 include/linux/cgroup_gpu.h    | 122 ++++++++++++
 include/linux/cgroup_subsys.h |   4 +
 init/Kconfig                  |   7 +
 kernel/cgroup/Makefile        |   1 +
 kernel/cgroup/gpu.c           | 339 ++++++++++++++++++++++++++++++++++
 5 files changed, 473 insertions(+)
 create mode 100644 include/linux/cgroup_gpu.h
 create mode 100644 kernel/cgroup/gpu.c

diff --git a/include/linux/cgroup_gpu.h b/include/linux/cgroup_gpu.h
new file mode 100644
index 000000000000..cb228a16aa1f
--- /dev/null
+++ b/include/linux/cgroup_gpu.h
@@ -0,0 +1,122 @@
+/* SPDX-License-Identifier: MIT
+ * Copyright 2019 Advanced Micro Devices, Inc.
+ * Copyright (C) 2022 Google LLC.
+ */
+#ifndef _CGROUP_GPU_H
+#define _CGROUP_GPU_H
+
+#include <linux/cgroup.h>
+
+#define GPUCG_BUCKET_NAME_MAX_LEN 64
+
+struct gpucg;
+struct gpucg_bucket;
+
+#ifdef CONFIG_CGROUP_GPU
+
+/**
+ * css_to_gpucg - get the corresponding gpucg ref from a cgroup_subsys_sta=
te
+ * @css: the target cgroup_subsys_state
+ *
+ * Returns: gpu cgroup that contains the @css
+ */
+struct gpucg *css_to_gpucg(struct cgroup_subsys_state *css);
+
+/**
+ * gpucg_get - get the gpucg reference that a task belongs to
+ * @task: the target task
+ *
+ * This increases the reference count of the css that the @task belongs to=
.
+ *
+ * Returns: reference to the gpu cgroup the task belongs to.
+ */
+struct gpucg *gpucg_get(struct task_struct *task);
+
+/**
+ * gpucg_put - put a gpucg reference
+ * @gpucg: the target gpucg
+ *
+ * Put a reference obtained via gpucg_get
+ */
+void gpucg_put(struct gpucg *gpucg);
+
+/**
+ * gpucg_parent - find the parent of a gpu cgroup
+ * @cg: the target gpucg
+ *
+ * This does not increase the reference count of the parent cgroup
+ *
+ * Returns: parent gpu cgroup of @cg
+ */
+struct gpucg *gpucg_parent(struct gpucg *cg);
+
+/**
+ * gpucg_charge - charge memory to the specified gpucg and gpucg_bucket.
+ * Caller must hold a reference to @gpucg obtained through gpucg_get(). Th=
e size of the memory is
+ * rounded up to be a multiple of the page size.
+ *
+ * @gpucg: The gpu cgroup to charge the memory to.
+ * @bucket: The bucket to charge the memory to.
+ * @size: The size of memory to charge in bytes.
+ *        This size will be rounded up to the nearest page size.
+ *
+ * Return: returns 0 if the charging is successful and otherwise returns a=
n error code.
+ */
+int gpucg_charge(struct gpucg *gpucg, struct gpucg_bucket *bucket, u64 siz=
e);
+
+/**
+ * gpucg_uncharge - uncharge memory from the specified gpucg and gpucg_buc=
ket.
+ * The caller must hold a reference to @gpucg obtained through gpucg_get()=
.
+ *
+ * @gpucg: The gpu cgroup to uncharge the memory from.
+ * @bucket: The bucket to uncharge the memory from.
+ * @size: The size of memory to uncharge in bytes.
+ *        This size will be rounded up to the nearest page size.
+ */
+void gpucg_uncharge(struct gpucg *gpucg, struct gpucg_bucket *bucket, u64 =
size);
+
+/**
+ * gpucg_register_bucket - Registers a bucket for memory accounting using =
the GPU cgroup controller.
+ *
+ * @name: Pointer to a null-terminated string to denote the name of the bu=
cket. This name should be
+ *        globally unique, and should not exceed @GPUCG_BUCKET_NAME_MAX_LE=
N bytes.
+ *
+ * @bucket must remain valid. @name will be copied.
+ *
+ * Returns a pointer to a newly allocated bucket on success, or an errno c=
ode otherwise. As buckets
+ * cannot be unregistered, this can never be freed.
+ */
+struct gpucg_bucket *gpucg_register_bucket(const char *name);
+#else /* CONFIG_CGROUP_GPU */
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
+static inline struct gpucg_bucket *gpucg_register_bucket(const char *name)=
 {}
+#endif /* CONFIG_CGROUP_GPU */
+#endif /* _CGROUP_GPU_H */
diff --git a/include/linux/cgroup_subsys.h b/include/linux/cgroup_subsys.h
index 445235487230..46a2a7b93c41 100644
--- a/include/linux/cgroup_subsys.h
+++ b/include/linux/cgroup_subsys.h
@@ -65,6 +65,10 @@ SUBSYS(rdma)
 SUBSYS(misc)
 #endif
=20
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
=20
 	See Documentation/admin-guide/cgroup-v1/blkio-controller.rst for more inf=
ormation.
=20
+config CGROUP_GPU
+	bool "GPU controller (EXPERIMENTAL)"
+	select PAGE_COUNTER
+	help
+	  Provides accounting and limit setting for memory allocations by the GPU=
 and
+	  GPU-related subsystems.
+
 config CGROUP_WRITEBACK
 	bool
 	depends on MEMCG && BLK_CGROUP
diff --git a/kernel/cgroup/Makefile b/kernel/cgroup/Makefile
index 12f8457ad1f9..be95a5a532fc 100644
--- a/kernel/cgroup/Makefile
+++ b/kernel/cgroup/Makefile
@@ -7,3 +7,4 @@ obj-$(CONFIG_CGROUP_RDMA) +=3D rdma.o
 obj-$(CONFIG_CPUSETS) +=3D cpuset.o
 obj-$(CONFIG_CGROUP_MISC) +=3D misc.o
 obj-$(CONFIG_CGROUP_DEBUG) +=3D debug.o
+obj-$(CONFIG_CGROUP_GPU) +=3D gpu.o
diff --git a/kernel/cgroup/gpu.c b/kernel/cgroup/gpu.c
new file mode 100644
index 000000000000..ad16ea15d427
--- /dev/null
+++ b/kernel/cgroup/gpu.c
@@ -0,0 +1,339 @@
+// SPDX-License-Identifier: MIT
+// Copyright 2019 Advanced Micro Devices, Inc.
+// Copyright (C) 2022 Google LLC.
+
+#include <linux/cgroup.h>
+#include <linux/cgroup_gpu.h>
+#include <linux/err.h>
+#include <linux/gfp.h>
+#include <linux/list.h>
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
+ * of buckets registered for memory accounting using the GPU cgroup contro=
ller.
+ */
+static DEFINE_MUTEX(gpucg_mutex);
+static LIST_HEAD(gpucg_buckets);
+
+/* The GPU cgroup controller data structure */
+struct gpucg {
+	struct cgroup_subsys_state css;
+
+	/* list of all resource pools that belong to this cgroup */
+	struct list_head rpools;
+};
+
+/* A named entity representing bucket of tracked memory. */
+struct gpucg_bucket {
+	/* list of various resource pools in various cgroups that the bucket is p=
art of */
+	struct list_head rpools;
+
+	/* list of all buckets registered for GPU cgroup accounting */
+	struct list_head bucket_node;
+
+	/* string to be used as identifier for accounting and limit setting */
+	const char *name;
+};
+
+struct gpucg_resource_pool {
+	/* The bucket whose resource usage is tracked by this resource pool */
+	struct gpucg_bucket *bucket;
+
+	/* list of all resource pools for the cgroup */
+	struct list_head cg_node;
+
+	/* list maintained by the gpucg_bucket to keep track of its resource pool=
s */
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
+	struct gpucg *gpucg =3D css_to_gpucg(css);
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
+	gpucg =3D kzalloc(sizeof(struct gpucg), GFP_KERNEL);
+	if (!gpucg)
+		return ERR_PTR(-ENOMEM);
+
+	parent =3D css_to_gpucg(parent_css);
+	if (!parent)
+		root_gpucg =3D gpucg;
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
+		if (rpool->bucket =3D=3D bucket)
+			return rpool;
+
+	return NULL;
+}
+
+static struct gpucg_resource_pool *cg_rpool_init(struct gpucg *cg,
+						 struct gpucg_bucket *bucket)
+{
+	struct gpucg_resource_pool *rpool =3D kzalloc(sizeof(*rpool),
+							GFP_KERNEL);
+	if (!rpool)
+		return ERR_PTR(-ENOMEM);
+
+	rpool->bucket =3D bucket;
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
+ * get_cg_rpool_locked - find the resource pool for the specified bucket a=
nd
+ * specified cgroup. If the resource pool does not exist for the cg, it is
+ * created in a hierarchical manner in the cgroup and its ancestor cgroups=
 who
+ * do not already have a resource pool entry for the bucket.
+ *
+ * @cg: The cgroup to find the resource pool for.
+ * @bucket: The bucket associated with the returned resource pool.
+ *
+ * Return: return resource pool entry corresponding to the specified bucke=
t in
+ * the specified cgroup (hierarchically creating them if not existing alre=
ady).
+ *
+ */
+static struct gpucg_resource_pool *
+cg_rpool_get_locked(struct gpucg *cg, struct gpucg_bucket *bucket)
+{
+	struct gpucg *parent_cg, *p, *stop_cg;
+	struct gpucg_resource_pool *rpool, *tmp_rpool;
+	struct gpucg_resource_pool *parent_rpool =3D NULL, *leaf_rpool =3D NULL;
+
+	rpool =3D cg_rpool_find_locked(cg, bucket);
+	if (rpool)
+		return rpool;
+
+	stop_cg =3D cg;
+	do {
+		rpool =3D cg_rpool_init(stop_cg, bucket);
+		if (IS_ERR(rpool))
+			goto err;
+
+		if (!leaf_rpool)
+			leaf_rpool =3D rpool;
+
+		stop_cg =3D gpucg_parent(stop_cg);
+		if (!stop_cg)
+			break;
+
+		rpool =3D cg_rpool_find_locked(stop_cg, bucket);
+	} while (!rpool);
+
+	/*
+	 * Re-initialize page counters of all rpools created in this invocation
+	 * to enable hierarchical charging.
+	 * stop_cg is the first ancestor cg who already had a resource pool for
+	 * the bucket. It can also be NULL if no ancestors had a pre-existing
+	 * resource pool for the bucket before this invocation.
+	 */
+	rpool =3D leaf_rpool;
+	for (p =3D cg; p !=3D stop_cg; p =3D parent_cg) {
+		parent_cg =3D gpucg_parent(p);
+		if (!parent_cg)
+			break;
+		parent_rpool =3D cg_rpool_find_locked(parent_cg, bucket);
+		page_counter_init(&rpool->total, &parent_rpool->total);
+
+		rpool =3D parent_rpool;
+	}
+
+	return leaf_rpool;
+err:
+	for (p =3D cg; p !=3D stop_cg; p =3D gpucg_parent(p)) {
+		tmp_rpool =3D cg_rpool_find_locked(p, bucket);
+		free_cg_rpool_locked(tmp_rpool);
+	}
+	return rpool;
+}
+
+struct gpucg *css_to_gpucg(struct cgroup_subsys_state *css)
+{
+	return css ? container_of(css, struct gpucg, css) : NULL;
+}
+
+struct gpucg *gpucg_get(struct task_struct *task)
+{
+	if (!cgroup_subsys_enabled(gpu_cgrp_subsys))
+		return NULL;
+	return css_to_gpucg(task_get_css(task, gpu_cgrp_id));
+}
+
+void gpucg_put(struct gpucg *gpucg)
+{
+	if (gpucg)
+		css_put(&gpucg->css);
+}
+
+struct gpucg *gpucg_parent(struct gpucg *cg)
+{
+	return css_to_gpucg(cg->css.parent);
+}
+
+int gpucg_charge(struct gpucg *gpucg, struct gpucg_bucket *bucket, u64 siz=
e)
+{
+	struct page_counter *counter;
+	u64 nr_pages;
+	struct gpucg_resource_pool *rp;
+	int ret =3D 0;
+
+	nr_pages =3D PAGE_ALIGN(size) >> PAGE_SHIFT;
+
+	mutex_lock(&gpucg_mutex);
+	rp =3D cg_rpool_get_locked(gpucg, bucket);
+	/*
+	 * Continue to hold gpucg_mutex because we use it to block charges while =
transfers are in
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
+		ret =3D -ENOMEM;
+	mutex_unlock(&gpucg_mutex);
+
+	return ret;
+}
+
+void gpucg_uncharge(struct gpucg *gpucg, struct gpucg_bucket *bucket, u64 =
size)
+{
+	u64 nr_pages;
+	struct gpucg_resource_pool *rp;
+
+	mutex_lock(&gpucg_mutex);
+	rp =3D cg_rpool_find_locked(gpucg, bucket);
+	/*
+	 * gpucg_mutex can be unlocked here, rp will stay valid until gpucg is fr=
eed and there are
+	 * active refs on gpucg. Uncharges are fine while transfers are in progre=
ss since there is
+	 * no potential to exceed a limit while uncharging and transferring.
+	 */
+	mutex_unlock(&gpucg_mutex);
+
+	if (unlikely(!rp)) {
+		pr_err("Resource pool not found, incorrect charge/uncharge ordering?\n")=
;
+		return;
+	}
+
+	nr_pages =3D PAGE_ALIGN(size) >> PAGE_SHIFT;
+	page_counter_uncharge(&rp->total, nr_pages);
+	css_put(&gpucg->css);
+}
+
+struct gpucg_bucket *gpucg_register_bucket(const char *name)
+{
+	struct gpucg_bucket *bucket, *b;
+
+	if (!name)
+		return ERR_PTR(-EINVAL);
+
+	if (strlen(name) >=3D GPUCG_BUCKET_NAME_MAX_LEN)
+		return ERR_PTR(-ENAMETOOLONG);
+
+	bucket =3D kzalloc(sizeof(struct gpucg_bucket), GFP_KERNEL);
+	if (!bucket)
+		return ERR_PTR(-ENOMEM);
+
+	INIT_LIST_HEAD(&bucket->bucket_node);
+	INIT_LIST_HEAD(&bucket->rpools);
+	bucket->name =3D kstrdup_const(name, GFP_KERNEL);
+
+	mutex_lock(&gpucg_mutex);
+	list_for_each_entry(b, &gpucg_buckets, bucket_node) {
+		if (strncmp(b->name, bucket->name, GPUCG_BUCKET_NAME_MAX_LEN) =3D=3D 0) =
{
+			mutex_unlock(&gpucg_mutex);
+			kfree_const(bucket->name);
+			kfree(bucket);
+			return ERR_PTR(-EEXIST);
+		}
+	}
+	list_add_tail(&bucket->bucket_node, &gpucg_buckets);
+	mutex_unlock(&gpucg_mutex);
+
+	return bucket;
+}
+
+static int gpucg_resource_show(struct seq_file *sf, void *v)
+{
+	struct gpucg_resource_pool *rpool;
+	struct gpucg *cg =3D css_to_gpucg(seq_css(sf));
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
+struct cftype files[] =3D {
+	{
+		.name =3D "memory.current",
+		.seq_show =3D gpucg_resource_show,
+	},
+	{ }     /* terminate */
+};
+
+struct cgroup_subsys gpu_cgrp_subsys =3D {
+	.css_alloc      =3D gpucg_css_alloc,
+	.css_free       =3D gpucg_css_free,
+	.early_init     =3D false,
+	.legacy_cftypes =3D files,
+	.dfl_cftypes    =3D files,
+};
--=20
2.36.0.512.ge40c2bad7a-goog

