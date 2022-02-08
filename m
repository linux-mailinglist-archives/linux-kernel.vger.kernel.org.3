Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 655144ADC8F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 16:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380160AbiBHPZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 10:25:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380161AbiBHPZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 10:25:40 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4D560C061577
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 07:25:37 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1CE601FB;
        Tue,  8 Feb 2022 07:25:37 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B2DF13F73B;
        Tue,  8 Feb 2022 07:25:35 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        virtualization@lists.linux-foundation.org
Cc:     sudeep.holla@arm.com, mst@redhat.com, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, peter.hilber@opensynergy.com,
        igor.skalkin@opensynergy.com, cristian.marussi@arm.com
Subject: [PATCH 4/4] tools/virtio: Add virtqueue_use_wrap_counter support
Date:   Tue,  8 Feb 2022 15:25:20 +0000
Message-Id: <20220208152520.52983-5-cristian.marussi@arm.com>
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

Added simplified missing headers for VRING_POLL_* macros and a definition
of virtqueue_use_wrap_counter API.

Add --wrap-counters option to virtio_test to be able to test the new
virtqueue_use_wrap_counter API.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 tools/virtio/linux/bitfield.h | 88 +++++++++++++++++++++++++++++++++++
 tools/virtio/linux/bits.h     | 36 ++++++++++++++
 tools/virtio/linux/virtio.h   | 33 +++++++++++++
 tools/virtio/virtio_test.c    | 35 ++++++++++++--
 4 files changed, 189 insertions(+), 3 deletions(-)
 create mode 100644 tools/virtio/linux/bitfield.h
 create mode 100644 tools/virtio/linux/bits.h

diff --git a/tools/virtio/linux/bitfield.h b/tools/virtio/linux/bitfield.h
new file mode 100644
index 000000000000..43421844eecc
--- /dev/null
+++ b/tools/virtio/linux/bitfield.h
@@ -0,0 +1,88 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _LINUX_BITFIELD_H
+#define _LINUX_BITFIELD_H
+
+#include <asm/byteorder.h>
+
+/*
+ * Bitfield access macros
+ *
+ * FIELD_{GET,PREP} macros take as first parameter shifted mask
+ * from which they extract the base mask and shift amount.
+ * Mask must be a compilation time constant.
+ *
+ * Example:
+ *
+ *  #define REG_FIELD_A  GENMASK(6, 0)
+ *  #define REG_FIELD_B  BIT(7)
+ *  #define REG_FIELD_C  GENMASK(15, 8)
+ *  #define REG_FIELD_D  GENMASK(31, 16)
+ *
+ * Get:
+ *  a = FIELD_GET(REG_FIELD_A, reg);
+ *  b = FIELD_GET(REG_FIELD_B, reg);
+ *
+ * Set:
+ *  reg = FIELD_PREP(REG_FIELD_A, 1) |
+ *	  FIELD_PREP(REG_FIELD_B, 0) |
+ *	  FIELD_PREP(REG_FIELD_C, c) |
+ *	  FIELD_PREP(REG_FIELD_D, 0x40);
+ *
+ * Modify:
+ *  reg &= ~REG_FIELD_C;
+ *  reg |= FIELD_PREP(REG_FIELD_C, c);
+ */
+
+#define __bf_shf(x) (__builtin_ffsll(x) - 1)
+
+/**
+ * FIELD_MAX() - produce the maximum value representable by a field
+ * @_mask: shifted mask defining the field's length and position
+ *
+ * FIELD_MAX() returns the maximum value that can be held in the field
+ * specified by @_mask.
+ */
+#define FIELD_MAX(_mask)						\
+	({								\
+		(typeof(_mask))((_mask) >> __bf_shf(_mask));		\
+	})
+
+/**
+ * FIELD_FIT() - check if value fits in the field
+ * @_mask: shifted mask defining the field's length and position
+ * @_val:  value to test against the field
+ *
+ * Return: true if @_val can fit inside @_mask, false if @_val is too big.
+ */
+#define FIELD_FIT(_mask, _val)						\
+	({								\
+		!((((typeof(_mask))_val) << __bf_shf(_mask)) & ~(_mask)); \
+	})
+
+/**
+ * FIELD_PREP() - prepare a bitfield element
+ * @_mask: shifted mask defining the field's length and position
+ * @_val:  value to put in the field
+ *
+ * FIELD_PREP() masks and shifts up the value.  The result should
+ * be combined with other fields of the bitfield using logical OR.
+ */
+#define FIELD_PREP(_mask, _val)						\
+	({								\
+		((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask);	\
+	})
+
+/**
+ * FIELD_GET() - extract a bitfield element
+ * @_mask: shifted mask defining the field's length and position
+ * @_reg:  value of entire bitfield
+ *
+ * FIELD_GET() extracts the field specified by @_mask from the
+ * bitfield passed in as @_reg by masking and shifting it down.
+ */
+#define FIELD_GET(_mask, _reg)						\
+	({								\
+		(typeof(_mask))(((_reg) & (_mask)) >> __bf_shf(_mask));	\
+	})
+
+#endif
diff --git a/tools/virtio/linux/bits.h b/tools/virtio/linux/bits.h
new file mode 100644
index 000000000000..16f8fe32b0b3
--- /dev/null
+++ b/tools/virtio/linux/bits.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_BITS_H
+#define __LINUX_BITS_H
+
+#include <linux/const.h>
+#include <vdso/bits.h>
+#include <asm/bitsperlong.h>
+
+#define BIT_ULL(nr)		(ULL(1) << (nr))
+#define BIT_MASK(nr)		(UL(1) << ((nr) % BITS_PER_LONG))
+#define BIT_WORD(nr)		((nr) / BITS_PER_LONG)
+#define BIT_ULL_MASK(nr)	(ULL(1) << ((nr) % BITS_PER_LONG_LONG))
+#define BIT_ULL_WORD(nr)	((nr) / BITS_PER_LONG_LONG)
+#define BITS_PER_BYTE		8
+
+/*
+ * Create a contiguous bitmask starting at bit position @l and ending at
+ * position @h. For example
+ * GENMASK_ULL(39, 21) gives us the 64bit vector 0x000000ffffe00000.
+ */
+
+#define GENMASK_INPUT_CHECK(h, l) 0
+
+#define __GENMASK(h, l) \
+	(((~UL(0)) - (UL(1) << (l)) + 1) & \
+	 (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
+#define GENMASK(h, l) \
+	(GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
+
+#define __GENMASK_ULL(h, l) \
+	(((~ULL(0)) - (ULL(1) << (l)) + 1) & \
+	 (~ULL(0) >> (BITS_PER_LONG_LONG - 1 - (h))))
+#define GENMASK_ULL(h, l) \
+	(GENMASK_INPUT_CHECK(h, l) + __GENMASK_ULL(h, l))
+
+#endif	/* __LINUX_BITS_H */
diff --git a/tools/virtio/linux/virtio.h b/tools/virtio/linux/virtio.h
index 9021187a66d9..0556e093f223 100644
--- a/tools/virtio/linux/virtio.h
+++ b/tools/virtio/linux/virtio.h
@@ -5,6 +5,8 @@
 #include <linux/kernel.h>
 #include <linux/spinlock.h>
 
+#define VIRTIO_CONFIG_S_DRIVER	2
+
 typedef struct pm_message {
 	int event;
 } pm_message_t;
@@ -48,9 +50,12 @@ struct device {
 	struct device_driver *driver;
 };
 
+struct virtio_config_ops;
+
 struct virtio_device {
 	struct device dev;
 	u64 features;
+	const struct virtio_config_ops *config;
 	struct list_head vqs;
 	spinlock_t vqs_list_lock;
 };
@@ -65,6 +70,32 @@ struct virtqueue {
 	void *priv;
 };
 
+struct virtio_config_ops {
+	void (*enable_cbs)(struct virtio_device *vdev);
+	void (*get)(struct virtio_device *vdev, unsigned int offset,
+		    void *buf, unsigned int len);
+	void (*set)(struct virtio_device *vdev, unsigned int offset,
+		    const void *buf, unsigned int len);
+	u32 (*generation)(struct virtio_device *vdev);
+	u8 (*get_status)(struct virtio_device *vdev);
+	void (*set_status)(struct virtio_device *vdev, u8 status);
+	void (*reset)(struct virtio_device *vdev);
+	int (*find_vqs)(struct virtio_device *vdev, unsigned int nvqs,
+			struct virtqueue *vqs[], void *callbacks[],
+			const char * const names[], const bool *ctx,
+			void *desc);
+	void (*del_vqs)(struct virtio_device *vdev);
+	u64 (*get_features)(struct virtio_device *vdev);
+	int (*finalize_features)(struct virtio_device *vdev);
+	const char *(*bus_name)(struct virtio_device *vdev);
+	int (*set_vq_affinity)(struct virtqueue *vq,
+			       const void *cpu_mask);
+	const void *(*get_vq_affinity)(struct virtio_device *vdev,
+			int index);
+	bool (*get_shm_region)(struct virtio_device *vdev,
+			       void *region, u8 id);
+};
+
 struct virtio_driver {
 	struct device_driver driver;
 	const struct virtio_device_id *id_table;
@@ -111,6 +142,8 @@ void virtqueue_disable_cb(struct virtqueue *vq);
 bool virtqueue_enable_cb(struct virtqueue *vq);
 bool virtqueue_enable_cb_delayed(struct virtqueue *vq);
 
+int virtqueue_use_wrap_counter(struct virtqueue *vq);
+
 void *virtqueue_detach_unused_buf(struct virtqueue *vq);
 struct virtqueue *vring_new_virtqueue(unsigned int index,
 				      unsigned int num,
diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
index d9cb3d22d52f..deccd44e4739 100644
--- a/tools/virtio/virtio_test.c
+++ b/tools/virtio/virtio_test.c
@@ -21,6 +21,8 @@
 
 #define RANDOM_BATCH -1
 
+static u8 virtio_test_device_status;
+
 /* Unused */
 void *__kmalloc_fake, *__kfree_ignore_start, *__kfree_ignore_end;
 
@@ -109,7 +111,7 @@ static void vq_reset(struct vq_info *info, int num, struct virtio_device *vdev)
 	info->vq->priv = info;
 }
 
-static void vq_info_add(struct vdev_info *dev, int num)
+static void vq_info_add(struct vdev_info *dev, int num, bool use_wrap_counters)
 {
 	struct vq_info *info = &dev->vqs[dev->nvqs];
 	int r;
@@ -119,12 +121,25 @@ static void vq_info_add(struct vdev_info *dev, int num)
 	r = posix_memalign(&info->ring, 4096, vring_size(num, 4096));
 	assert(r >= 0);
 	vq_reset(info, num, &dev->vdev);
+	if (use_wrap_counters) {
+		r = virtqueue_use_wrap_counter(info->vq);
+		assert(r == 0);
+	}
 	vhost_vq_setup(dev, info);
 	dev->fds[info->idx].fd = info->call;
 	dev->fds[info->idx].events = POLLIN;
 	dev->nvqs++;
 }
 
+static u8 virtio_test_get_status(struct virtio_device *vdev)
+{
+	return virtio_test_device_status;
+}
+
+struct virtio_config_ops virtio_config_ops = {
+	.get_status = virtio_test_get_status,
+};
+
 static void vdev_info_init(struct vdev_info* dev, unsigned long long features)
 {
 	int r;
@@ -132,6 +147,8 @@ static void vdev_info_init(struct vdev_info* dev, unsigned long long features)
 	dev->vdriver.suppress_used_validation = false;
 	dev->vdev.dev.driver = &dev->vdriver.driver;
 	dev->vdev.features = features;
+	virtio_test_device_status = VIRTIO_CONFIG_S_DRIVER;
+	dev->vdev.config = &virtio_config_ops;
 	INIT_LIST_HEAD(&dev->vdev.vqs);
 	spin_lock_init(&dev->vdev.vqs_list_lock);
 	dev->buf_size = 1024;
@@ -316,6 +333,14 @@ const struct option longopts[] = {
 		.name = "no-delayed-interrupt",
 		.val = 'd',
 	},
+	{
+		.name = "wrap-counters",
+		.val = 'W',
+	},
+	{
+		.name = "no-wrap-counters",
+		.val = 'w',
+	},
 	{
 		.name = "batch",
 		.val = 'b',
@@ -337,6 +362,7 @@ static void help(void)
 		" [--no-event-idx]"
 		" [--no-virtio-1]"
 		" [--delayed-interrupt]"
+		" [--wrap-counters]"
 		" [--batch=random/N]"
 		" [--reset=N]"
 		"\n");
@@ -349,7 +375,7 @@ int main(int argc, char **argv)
 		(1ULL << VIRTIO_RING_F_EVENT_IDX) | (1ULL << VIRTIO_F_VERSION_1);
 	long batch = 1, reset = 0;
 	int o;
-	bool delayed = false;
+	bool delayed = false, use_wrap_counters = false;
 
 	for (;;) {
 		o = getopt_long(argc, argv, optstring, longopts, NULL);
@@ -374,6 +400,9 @@ int main(int argc, char **argv)
 		case 'D':
 			delayed = true;
 			break;
+		case 'W':
+			use_wrap_counters = true;
+			break;
 		case 'b':
 			if (0 == strcmp(optarg, "random")) {
 				batch = RANDOM_BATCH;
@@ -400,7 +429,7 @@ int main(int argc, char **argv)
 
 done:
 	vdev_info_init(&dev, features);
-	vq_info_add(&dev, 256);
+	vq_info_add(&dev, 256, use_wrap_counters);
 	run_test(&dev, &dev.vqs[0], delayed, batch, reset, 0x100000);
 	return 0;
 }
-- 
2.17.1

