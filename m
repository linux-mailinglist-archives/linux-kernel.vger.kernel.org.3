Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1645B4ADC8E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 16:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380155AbiBHPZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 10:25:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380050AbiBHPZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 10:25:34 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7E12FC061576
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 07:25:32 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 494E71FB;
        Tue,  8 Feb 2022 07:25:32 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE3973F73B;
        Tue,  8 Feb 2022 07:25:30 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        virtualization@lists.linux-foundation.org
Cc:     sudeep.holla@arm.com, mst@redhat.com, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, peter.hilber@opensynergy.com,
        igor.skalkin@opensynergy.com, cristian.marussi@arm.com
Subject: [PATCH 1/4] tools/virtio: Miscellaneous build fixes
Date:   Tue,  8 Feb 2022 15:25:17 +0000
Message-Id: <20220208152520.52983-2-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220208152520.52983-1-cristian.marussi@arm.com>
References: <20220208152520.52983-1-cristian.marussi@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 - Fix pthread LDFLAGS in Makefile: use -pthread compile and link switch as
   per man-page; the current -lpthread emits a number of undefined refs:

virtio_ring.o: In function `spin_lock':
tools/virtio/./linux/spinlock.h:16: undefined reference to `pthread_spin_lock'
virtio_ring.o: In function `spin_unlock':
tools/virtio/./linux/spinlock.h:22: undefined reference to `pthread_spin_unlock'
virtio_ring.o: In function `spin_lock':
tools/virtio/./linux/spinlock.h:16: undefined reference to `pthread_spin_lock'
virtio_ring.o: In function `spin_unlock':
tools/virtio/./linux/spinlock.h:22: undefined reference to `pthread_spin_unlock'
virtio_ring.o: In function `spin_lock':
tools/virtio/./linux/spinlock.h:16: undefined reference to `pthread_spin_lock'
virtio_ring.o: In function `spin_unlock':
tools/virtio/./linux/spinlock.h:22: undefined reference to `pthread_spin_unlock'
virtio_ring.o: In function `spin_lock':
tools/virtio/./linux/spinlock.h:16: undefined reference to `pthread_spin_lock'
virtio_ring.o: In function `spin_unlock':
tools/virtio/./linux/spinlock.h:22: undefined reference to `pthread_spin_unlock'

 - Missing drv_to_virtio definition and related includes: a copy of uio.h
   with a helper, using a struct folio reference, removed.

 - Added empty mm_types.h

 - Added mocked moduleparam() definitions.

 - Fixed virtio_test and vringh_test initialization to allow drv_to_virtio
   inline to work properly when invoked from tets code.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 tools/virtio/Makefile            |   2 +-
 tools/virtio/linux/mm_types.h    |   3 +
 tools/virtio/linux/module.h      |   1 +
 tools/virtio/linux/moduleparam.h |   7 +
 tools/virtio/linux/uio.h         | 299 ++++++++++++++++++++++++++++++-
 tools/virtio/linux/virtio.h      |  63 +++++++
 tools/virtio/virtio_test.c       |   3 +
 tools/virtio/vringh_test.c       |   3 +
 8 files changed, 379 insertions(+), 2 deletions(-)
 create mode 100644 tools/virtio/linux/mm_types.h
 create mode 100644 tools/virtio/linux/moduleparam.h

diff --git a/tools/virtio/Makefile b/tools/virtio/Makefile
index 0d7bbe49359d..83b6a522d0d2 100644
--- a/tools/virtio/Makefile
+++ b/tools/virtio/Makefile
@@ -5,7 +5,7 @@ virtio_test: virtio_ring.o virtio_test.o
 vringh_test: vringh_test.o vringh.o virtio_ring.o
 
 CFLAGS += -g -O2 -Werror -Wno-maybe-uninitialized -Wall -I. -I../include/ -I ../../usr/include/ -Wno-pointer-sign -fno-strict-overflow -fno-strict-aliasing -fno-common -MMD -U_FORTIFY_SOURCE -include ../../include/linux/kconfig.h
-LDFLAGS += -lpthread
+LDFLAGS += -pthread
 vpath %.c ../../drivers/virtio ../../drivers/vhost
 mod:
 	${MAKE} -C `pwd`/../.. M=`pwd`/vhost_test V=${V}
diff --git a/tools/virtio/linux/mm_types.h b/tools/virtio/linux/mm_types.h
new file mode 100644
index 000000000000..3f3b5a471a1e
--- /dev/null
+++ b/tools/virtio/linux/mm_types.h
@@ -0,0 +1,3 @@
+#ifndef LINUX_MM_TYPES_H
+#endif
+
diff --git a/tools/virtio/linux/module.h b/tools/virtio/linux/module.h
index 9dfa96fea2b2..c81dcfe4bbfe 100644
--- a/tools/virtio/linux/module.h
+++ b/tools/virtio/linux/module.h
@@ -1,5 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #include <linux/export.h>
+#include <linux/moduleparam.h>
 
 #define MODULE_LICENSE(__MODULE_LICENSE_value) \
 	static __attribute__((unused)) const char *__MODULE_LICENSE_name = \
diff --git a/tools/virtio/linux/moduleparam.h b/tools/virtio/linux/moduleparam.h
new file mode 100644
index 000000000000..e1b14a39ddd3
--- /dev/null
+++ b/tools/virtio/linux/moduleparam.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_MODULE_PARAMS_H
+#define _LINUX_MODULE_PARAMS_H
+
+#define module_param(name, type, perm)
+
+#endif /* _LINUX_MODULE_PARAMS_H */
diff --git a/tools/virtio/linux/uio.h b/tools/virtio/linux/uio.h
index cd20f0ba3081..b2fba0288409 100644
--- a/tools/virtio/linux/uio.h
+++ b/tools/virtio/linux/uio.h
@@ -1,3 +1,300 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef __LINUX_UIO_H
+#define __LINUX_UIO_H
+
 #include <linux/kernel.h>
+#include <linux/thread_info.h>
+#include <linux/mm_types.h>
+#include <uapi/linux/uio.h>
+
+struct page;
+struct pipe_inode_info;
+
+struct kvec {
+	void *iov_base; /* and that should *never* hold a userland pointer */
+	size_t iov_len;
+};
+
+enum iter_type {
+	/* iter types */
+	ITER_IOVEC,
+	ITER_KVEC,
+	ITER_BVEC,
+	ITER_PIPE,
+	ITER_XARRAY,
+	ITER_DISCARD,
+};
+
+struct iov_iter_state {
+	size_t iov_offset;
+	size_t count;
+	unsigned long nr_segs;
+};
+
+struct iov_iter {
+	u8 iter_type;
+	bool nofault;
+	bool data_source;
+	size_t iov_offset;
+	size_t count;
+	union {
+		const struct iovec *iov;
+		const struct kvec *kvec;
+		const struct bio_vec *bvec;
+		struct xarray *xarray;
+		struct pipe_inode_info *pipe;
+	};
+	union {
+		unsigned long nr_segs;
+		struct {
+			unsigned int head;
+			unsigned int start_head;
+		};
+		loff_t xarray_start;
+	};
+};
+
+static inline enum iter_type iov_iter_type(const struct iov_iter *i)
+{
+	return i->iter_type;
+}
+
+static inline void iov_iter_save_state(struct iov_iter *iter,
+				       struct iov_iter_state *state)
+{
+	state->iov_offset = iter->iov_offset;
+	state->count = iter->count;
+	state->nr_segs = iter->nr_segs;
+}
+
+static inline bool iter_is_iovec(const struct iov_iter *i)
+{
+	return iov_iter_type(i) == ITER_IOVEC;
+}
+
+static inline bool iov_iter_is_kvec(const struct iov_iter *i)
+{
+	return iov_iter_type(i) == ITER_KVEC;
+}
+
+static inline bool iov_iter_is_bvec(const struct iov_iter *i)
+{
+	return iov_iter_type(i) == ITER_BVEC;
+}
+
+static inline bool iov_iter_is_pipe(const struct iov_iter *i)
+{
+	return iov_iter_type(i) == ITER_PIPE;
+}
+
+static inline bool iov_iter_is_discard(const struct iov_iter *i)
+{
+	return iov_iter_type(i) == ITER_DISCARD;
+}
+
+static inline bool iov_iter_is_xarray(const struct iov_iter *i)
+{
+	return iov_iter_type(i) == ITER_XARRAY;
+}
+
+static inline unsigned char iov_iter_rw(const struct iov_iter *i)
+{
+	return i->data_source ? WRITE : READ;
+}
+
+/*
+ * Total number of bytes covered by an iovec.
+ *
+ * NOTE that it is not safe to use this function until all the iovec's
+ * segment lengths have been validated.  Because the individual lengths can
+ * overflow a size_t when added together.
+ */
+static inline size_t iov_length(const struct iovec *iov, unsigned long nr_segs)
+{
+	unsigned long seg;
+	size_t ret = 0;
+
+	for (seg = 0; seg < nr_segs; seg++)
+		ret += iov[seg].iov_len;
+	return ret;
+}
+
+static inline struct iovec iov_iter_iovec(const struct iov_iter *iter)
+{
+	return (struct iovec) {
+		.iov_base = iter->iov->iov_base + iter->iov_offset,
+		.iov_len = min(iter->count,
+			       iter->iov->iov_len - iter->iov_offset),
+	};
+}
+
+size_t copy_page_from_iter_atomic(struct page *page, unsigned offset,
+				  size_t bytes, struct iov_iter *i);
+void iov_iter_advance(struct iov_iter *i, size_t bytes);
+void iov_iter_revert(struct iov_iter *i, size_t bytes);
+size_t fault_in_iov_iter_readable(const struct iov_iter *i, size_t bytes);
+size_t fault_in_iov_iter_writeable(const struct iov_iter *i, size_t bytes);
+size_t iov_iter_single_seg_count(const struct iov_iter *i);
+size_t copy_page_to_iter(struct page *page, size_t offset, size_t bytes,
+			 struct iov_iter *i);
+size_t copy_page_from_iter(struct page *page, size_t offset, size_t bytes,
+			 struct iov_iter *i);
+
+size_t _copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i);
+size_t _copy_from_iter(void *addr, size_t bytes, struct iov_iter *i);
+size_t _copy_from_iter_nocache(void *addr, size_t bytes, struct iov_iter *i);
+
+static __always_inline __must_check
+size_t copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
+{
+	if (unlikely(!check_copy_size(addr, bytes, true)))
+		return 0;
+	else
+		return _copy_to_iter(addr, bytes, i);
+}
+
+static __always_inline __must_check
+size_t copy_from_iter(void *addr, size_t bytes, struct iov_iter *i)
+{
+	if (unlikely(!check_copy_size(addr, bytes, false)))
+		return 0;
+	else
+		return _copy_from_iter(addr, bytes, i);
+}
+
+static __always_inline __must_check
+bool copy_from_iter_full(void *addr, size_t bytes, struct iov_iter *i)
+{
+	size_t copied = copy_from_iter(addr, bytes, i);
+	if (likely(copied == bytes))
+		return true;
+	iov_iter_revert(i, copied);
+	return false;
+}
+
+static __always_inline __must_check
+size_t copy_from_iter_nocache(void *addr, size_t bytes, struct iov_iter *i)
+{
+	if (unlikely(!check_copy_size(addr, bytes, false)))
+		return 0;
+	else
+		return _copy_from_iter_nocache(addr, bytes, i);
+}
+
+static __always_inline __must_check
+bool copy_from_iter_full_nocache(void *addr, size_t bytes, struct iov_iter *i)
+{
+	size_t copied = copy_from_iter_nocache(addr, bytes, i);
+	if (likely(copied == bytes))
+		return true;
+	iov_iter_revert(i, copied);
+	return false;
+}
+
+#ifdef CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE
+/*
+ * Note, users like pmem that depend on the stricter semantics of
+ * _copy_from_iter_flushcache() than _copy_from_iter_nocache() must check for
+ * IS_ENABLED(CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE) before assuming that the
+ * destination is flushed from the cache on return.
+ */
+size_t _copy_from_iter_flushcache(void *addr, size_t bytes, struct iov_iter *i);
+#else
+#define _copy_from_iter_flushcache _copy_from_iter_nocache
+#endif
+
+#ifdef CONFIG_ARCH_HAS_COPY_MC
+size_t _copy_mc_to_iter(const void *addr, size_t bytes, struct iov_iter *i);
+#else
+#define _copy_mc_to_iter _copy_to_iter
+#endif
+
+size_t iov_iter_zero(size_t bytes, struct iov_iter *);
+unsigned long iov_iter_alignment(const struct iov_iter *i);
+unsigned long iov_iter_gap_alignment(const struct iov_iter *i);
+void iov_iter_init(struct iov_iter *i, unsigned int direction, const struct iovec *iov,
+			unsigned long nr_segs, size_t count);
+void iov_iter_kvec(struct iov_iter *i, unsigned int direction, const struct kvec *kvec,
+			unsigned long nr_segs, size_t count);
+void iov_iter_bvec(struct iov_iter *i, unsigned int direction, const struct bio_vec *bvec,
+			unsigned long nr_segs, size_t count);
+void iov_iter_pipe(struct iov_iter *i, unsigned int direction, struct pipe_inode_info *pipe,
+			size_t count);
+void iov_iter_discard(struct iov_iter *i, unsigned int direction, size_t count);
+void iov_iter_xarray(struct iov_iter *i, unsigned int direction, struct xarray *xarray,
+		     loff_t start, size_t count);
+ssize_t iov_iter_get_pages(struct iov_iter *i, struct page **pages,
+			size_t maxsize, unsigned maxpages, size_t *start);
+ssize_t iov_iter_get_pages_alloc(struct iov_iter *i, struct page ***pages,
+			size_t maxsize, size_t *start);
+int iov_iter_npages(const struct iov_iter *i, int maxpages);
+void iov_iter_restore(struct iov_iter *i, struct iov_iter_state *state);
+
+const void *dup_iter(struct iov_iter *new, struct iov_iter *old, gfp_t flags);
+
+static inline size_t iov_iter_count(const struct iov_iter *i)
+{
+	return i->count;
+}
+
+/*
+ * Cap the iov_iter by given limit; note that the second argument is
+ * *not* the new size - it's upper limit for such.  Passing it a value
+ * greater than the amount of data in iov_iter is fine - it'll just do
+ * nothing in that case.
+ */
+static inline void iov_iter_truncate(struct iov_iter *i, u64 count)
+{
+	/*
+	 * count doesn't have to fit in size_t - comparison extends both
+	 * operands to u64 here and any value that would be truncated by
+	 * conversion in assignement is by definition greater than all
+	 * values of size_t, including old i->count.
+	 */
+	if (i->count > count)
+		i->count = count;
+}
+
+/*
+ * reexpand a previously truncated iterator; count must be no more than how much
+ * we had shrunk it.
+ */
+static inline void iov_iter_reexpand(struct iov_iter *i, size_t count)
+{
+	i->count = count;
+}
+
+struct csum_state {
+	__wsum csum;
+	size_t off;
+};
+
+size_t csum_and_copy_to_iter(const void *addr, size_t bytes, void *csstate, struct iov_iter *i);
+size_t csum_and_copy_from_iter(void *addr, size_t bytes, __wsum *csum, struct iov_iter *i);
+
+static __always_inline __must_check
+bool csum_and_copy_from_iter_full(void *addr, size_t bytes,
+				  __wsum *csum, struct iov_iter *i)
+{
+	size_t copied = csum_and_copy_from_iter(addr, bytes, csum, i);
+	if (likely(copied == bytes))
+		return true;
+	iov_iter_revert(i, copied);
+	return false;
+}
+size_t hash_and_copy_to_iter(const void *addr, size_t bytes, void *hashp,
+		struct iov_iter *i);
+
+struct iovec *iovec_from_user(const struct iovec __user *uvector,
+		unsigned long nr_segs, unsigned long fast_segs,
+		struct iovec *fast_iov, bool compat);
+ssize_t import_iovec(int type, const struct iovec __user *uvec,
+		 unsigned nr_segs, unsigned fast_segs, struct iovec **iovp,
+		 struct iov_iter *i);
+ssize_t __import_iovec(int type, const struct iovec __user *uvec,
+		 unsigned nr_segs, unsigned fast_segs, struct iovec **iovp,
+		 struct iov_iter *i, bool compat);
+int import_single_range(int type, void __user *buf, size_t len,
+		 struct iovec *iov, struct iov_iter *i);
 
-#include "../../../include/linux/uio.h"
+#endif
diff --git a/tools/virtio/linux/virtio.h b/tools/virtio/linux/virtio.h
index 363b98228301..9021187a66d9 100644
--- a/tools/virtio/linux/virtio.h
+++ b/tools/virtio/linux/virtio.h
@@ -5,8 +5,47 @@
 #include <linux/kernel.h>
 #include <linux/spinlock.h>
 
+typedef struct pm_message {
+	int event;
+} pm_message_t;
+
+enum probe_type {
+	PROBE_DEFAULT_STRATEGY,
+	PROBE_PREFER_ASYNCHRONOUS,
+	PROBE_FORCE_SYNCHRONOUS,
+};
+
+struct device_driver {
+	const char	*name;
+	void		*bus;
+
+	void		*owner;
+	const char	*mod_name;	/* used for built-in modules */
+
+	bool suppress_bind_attrs;	/* disables bind/unbind via sysfs */
+	enum probe_type probe_type;
+
+	const void	*of_match_table;
+	const void	*acpi_match_table;
+
+	int (*probe)(void *dev);
+	void (*sync_state)(void *dev);
+	int (*remove)(void *dev);
+	void (*shutdown)(void *dev);
+	int (*suspend)(void *dev, pm_message_t state);
+	int (*resume)(void *dev);
+	const void	**groups;
+	const void	**dev_groups;
+
+	const void	*pm;
+	void (*coredump)(void *dev);
+
+	struct driver_private *p;
+};
+
 struct device {
 	void *parent;
+	struct device_driver *driver;
 };
 
 struct virtio_device {
@@ -26,6 +65,25 @@ struct virtqueue {
 	void *priv;
 };
 
+struct virtio_driver {
+	struct device_driver driver;
+	const struct virtio_device_id *id_table;
+	const unsigned int *feature_table;
+	unsigned int feature_table_size;
+	const unsigned int *feature_table_legacy;
+	unsigned int feature_table_size_legacy;
+	bool suppress_used_validation;
+	int (*validate)(struct virtio_device *dev);
+	int (*probe)(struct virtio_device *dev);
+	void (*scan)(struct virtio_device *dev);
+	void (*remove)(struct virtio_device *dev);
+	void (*config_changed)(struct virtio_device *dev);
+#ifdef CONFIG_PM
+	int (*freeze)(struct virtio_device *dev);
+	int (*restore)(struct virtio_device *dev);
+#endif
+};
+
 /* Interfaces exported by virtio_ring. */
 int virtqueue_add_sgs(struct virtqueue *vq,
 		      struct scatterlist *sgs[],
@@ -66,4 +124,9 @@ struct virtqueue *vring_new_virtqueue(unsigned int index,
 				      const char *name);
 void vring_del_virtqueue(struct virtqueue *vq);
 
+static inline struct virtio_driver *drv_to_virtio(struct device_driver *drv)
+{
+	return container_of(drv, struct virtio_driver, driver);
+}
+
 #endif
diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
index cb3f29c09aff..d882075c097f 100644
--- a/tools/virtio/virtio_test.c
+++ b/tools/virtio/virtio_test.c
@@ -36,6 +36,7 @@ struct vq_info {
 };
 
 struct vdev_info {
+	struct virtio_driver vdriver;
 	struct virtio_device vdev;
 	int control;
 	struct pollfd fds[1];
@@ -128,6 +129,8 @@ static void vdev_info_init(struct vdev_info* dev, unsigned long long features)
 {
 	int r;
 	memset(dev, 0, sizeof *dev);
+	dev->vdriver.suppress_used_validation = false;
+	dev->vdev.dev.driver = &dev->vdriver.driver;
 	dev->vdev.features = features;
 	INIT_LIST_HEAD(&dev->vdev.vqs);
 	dev->buf_size = 1024;
diff --git a/tools/virtio/vringh_test.c b/tools/virtio/vringh_test.c
index fa87b58bd5fa..dbecfbbcbe54 100644
--- a/tools/virtio/vringh_test.c
+++ b/tools/virtio/vringh_test.c
@@ -437,6 +437,7 @@ static int parallel_test(u64 features,
 
 int main(int argc, char *argv[])
 {
+	struct virtio_driver vdriver;
 	struct virtio_device vdev;
 	struct virtqueue *vq;
 	struct vringh vrh;
@@ -453,6 +454,8 @@ int main(int argc, char *argv[])
 	bool fast_vringh = false, parallel = false;
 
 	getrange = getrange_iov;
+	vdriver.suppress_used_validation = false;
+	vdev.dev.driver = &vdriver.driver;
 	vdev.features = 0;
 	INIT_LIST_HEAD(&vdev.vqs);
 
-- 
2.17.1

