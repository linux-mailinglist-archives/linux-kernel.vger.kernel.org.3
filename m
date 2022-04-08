Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2621C4F9716
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 15:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236400AbiDHNoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 09:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbiDHNoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 09:44:02 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0288960CD9
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 06:41:57 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C3C9B113E;
        Fri,  8 Apr 2022 06:41:56 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C3FCE3F5A1;
        Fri,  8 Apr 2022 06:41:55 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        op-tee@lists.trustedfirmware.org,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Balint Dobszay <balint.dobszay@arm.com>
Subject: [PATCH] tee: Add Arm FF-A TEE driver
Date:   Fri,  8 Apr 2022 14:41:44 +0100
Message-Id: <20220408134144.1532704-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Arm FF-A provides mechanism for Linux kernel and modules to
communicate with the secure partitions. This is useful for some
Trusted-OS driver that are kernel resident or modules.

We would also like to avoid adding kernel drivers to communicate with
each and every service provided by these secure partitions. In order to
achieve the same with FF-A, it would be better to provide user-space
interface to access the FF-A functionalities. TEE subsystem seems to be
the best suited to meet those requirements without having to create a
new solution custom to FF-A alone.

All FF-A partitions that user-space access can be associated with this
new FF-A TEE driver and represented by a single TEE device. Though the
various secure services are generally distributed across multiple secure
partitions, all of these can be made accessible through this single FF-A
TEE device.

The minimal functionality needed by the user space application is
implemented, namely:
 - Query all partition IDs for a specific FF-A UUID
 - Sending synchronous message to a partition
 - Share/unshare buffer with the partition

Cc: Jens Wiklander <jens.wiklander@linaro.org>
Cc: Sumit Garg <sumit.garg@linaro.org>
Co-developed-by: Balint Dobszay <balint.dobszay@arm.com>
Signed-off-by: Balint Dobszay <balint.dobszay@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/tee/Kconfig                       |   1 +
 drivers/tee/Makefile                      |   1 +
 drivers/tee/arm_ffa_tee/Kconfig           |  15 +
 drivers/tee/arm_ffa_tee/Makefile          |   6 +
 drivers/tee/arm_ffa_tee/core.c            | 460 ++++++++++++++++++++++
 drivers/tee/arm_ffa_tee/ffa_tee_private.h |  39 ++
 drivers/tee/arm_ffa_tee/shm_pool.c        |  94 +++++
 drivers/tee/arm_ffa_tee/ts_msg.c          | 133 +++++++
 drivers/tee/arm_ffa_tee/ts_msg.h          |  75 ++++
 include/uapi/linux/arm_ffa_tee.h          | 116 ++++++
 include/uapi/linux/tee.h                  |   1 +
 11 files changed, 941 insertions(+)
 create mode 100644 drivers/tee/arm_ffa_tee/Kconfig
 create mode 100644 drivers/tee/arm_ffa_tee/Makefile
 create mode 100644 drivers/tee/arm_ffa_tee/core.c
 create mode 100644 drivers/tee/arm_ffa_tee/ffa_tee_private.h
 create mode 100644 drivers/tee/arm_ffa_tee/shm_pool.c
 create mode 100644 drivers/tee/arm_ffa_tee/ts_msg.c
 create mode 100644 drivers/tee/arm_ffa_tee/ts_msg.h
 create mode 100644 include/uapi/linux/arm_ffa_tee.h

Hi All,

This is the initial version of FF-A TEE driver to get the feedback on the
overall design/approach.

Few TODOs I plan to do before we finalise:
1. Need to decouple the driver from few Trusted Service protocols currently
   implemented. I have WIP, but couldn't get all the tests working(yet to
   figure out whether the issue is in driver or tests themselves). Just
   posting it as is to get initial feedback on other areas.

2. Based on the way FF-A spec changes/discussions, does it make sense to
   make search based on UUID + partitionID instead of just partitionID or
   leave that for userspace.

3. While I definitely want to move the protocol specifics from the driver
   (as mentioned in (1)), do we even try to remove adding UUID of each service
   we would like to use this driver. I haven't thought through that yet,
   but the idea I have is to just have a blocked UUID list which can
   contain UUID for OPTEE and other in-kernel users.
   That may need changes in FF-A bus match but something to consider ?

Regards,
Sudeep

diff --git a/drivers/tee/Kconfig b/drivers/tee/Kconfig
index e99d840c2511..385f46b66bd4 100644
--- a/drivers/tee/Kconfig
+++ b/drivers/tee/Kconfig
@@ -17,6 +17,7 @@ menu "TEE drivers"
 
 source "drivers/tee/optee/Kconfig"
 source "drivers/tee/amdtee/Kconfig"
+source "drivers/tee/arm_ffa_tee/Kconfig"
 endmenu
 
 endif
diff --git a/drivers/tee/Makefile b/drivers/tee/Makefile
index 68da044afbfa..fb7a961665cd 100644
--- a/drivers/tee/Makefile
+++ b/drivers/tee/Makefile
@@ -5,3 +5,4 @@ tee-objs += tee_shm.o
 tee-objs += tee_shm_pool.o
 obj-$(CONFIG_OPTEE) += optee/
 obj-$(CONFIG_AMDTEE) += amdtee/
+obj-$(CONFIG_ARM_FFA_TEE) += arm_ffa_tee/
diff --git a/drivers/tee/arm_ffa_tee/Kconfig b/drivers/tee/arm_ffa_tee/Kconfig
new file mode 100644
index 000000000000..52e3051c48e0
--- /dev/null
+++ b/drivers/tee/arm_ffa_tee/Kconfig
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# Arm FF-A Trusted Execution Environment Configuration
+config ARM_FFA_TEE
+	tristate "ARM FFA TEE"
+	depends on MMU
+	depends on ARM_FFA_TRANSPORT
+	default ARM_FFA_TRANSPORT
+	help
+	  This implements the Trusted Execution Environment (TEE) driver
+	  based on ARM FF-A.
+
+	  This driver provides user space access to Trusted/Secure services.
+	  The implementation extends the TEE subsystem using FF-A compliant
+	  messaging between the normal/non-secure and trusted/secure worlds.
+
diff --git a/drivers/tee/arm_ffa_tee/Makefile b/drivers/tee/arm_ffa_tee/Makefile
new file mode 100644
index 000000000000..e49c6a5927fe
--- /dev/null
+++ b/drivers/tee/arm_ffa_tee/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_ARM_FFA_TEE) += arm-ffa-tee.o
+arm-ffa-tee-objs += core.o
+arm-ffa-tee-objs += shm_pool.o
+arm-ffa-tee-objs += ts_msg.o
diff --git a/drivers/tee/arm_ffa_tee/core.c b/drivers/tee/arm_ffa_tee/core.c
new file mode 100644
index 000000000000..87150d7cd7a7
--- /dev/null
+++ b/drivers/tee/arm_ffa_tee/core.c
@@ -0,0 +1,460 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022, Arm Limited
+ *
+ * This module implements a TEE driver to enable user space applications to
+ * invoke services deployed in FF-A Secure Partitions.
+ */
+
+#include <linux/arm_ffa.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/scatterlist.h>
+#include <linux/slab.h>
+#include <linux/stat.h>
+#include <linux/tee_drv.h>
+#include <linux/types.h>
+#include <linux/uaccess.h>
+#include <uapi/linux/arm_ffa_tee.h>
+
+#include "ffa_tee_private.h"
+#include "ts_msg.h"
+
+struct ffa_dev_list {
+	struct ffa_device *ffa_dev;
+	const struct ffa_dev_ops *ffa_ops;
+	struct list_head list_node;
+};
+
+static LIST_HEAD(ffa_devs);
+/* Protection for the entire list */
+static DEFINE_MUTEX(ffatee_list_mutex);
+
+static struct ffa_dev_list *ffa_tee_get_bound_dev(u16 part_id)
+{
+	struct ffa_dev_list *tdev, *dev = NULL;
+
+	mutex_lock(&ffatee_list_mutex);
+	list_for_each_entry(tdev, &ffa_devs, list_node) {
+		if (tdev->ffa_dev->vm_id == part_id) {
+			dev = tdev;
+			break;
+		}
+	}
+	mutex_unlock(&ffatee_list_mutex);
+
+	return dev;
+}
+
+static void ffa_tee_get_version(struct tee_device *teedev __always_unused,
+				struct tee_ioctl_version_data *vers)
+{
+	struct tee_ioctl_version_data v = {
+		.impl_id = TEE_IMPL_ID_FFATEE,
+		.impl_caps = 0,
+		.gen_caps = 0,
+	};
+
+	*vers = v;
+}
+
+static int ffa_tee_open(struct tee_context *ctx)
+{
+	struct ffa_tee_context_data *ctxdata;
+
+	ctxdata = kzalloc(sizeof(*ctxdata), GFP_KERNEL);
+	if (!ctxdata)
+		return -ENOMEM;
+	ctx->data = ctxdata;
+
+	return 0;
+}
+
+static void ffa_tee_release(struct tee_context *ctx)
+{
+	struct ffa_tee_context_data *ctxdata = ctx->data;
+
+	kfree(ctxdata);
+	ctx->data = NULL;
+}
+
+static int ffa_tee_open_session(struct tee_context *ctx,
+				struct tee_ioctl_open_session_arg *arg,
+				struct tee_param *param)
+{
+	struct ffa_tee_context_data *ctxdata = ctx->data;
+	struct ffa_dev_list *dev;
+	u16 part_id;
+
+	/*
+	 * If any of these is set, it means a session is already open in this
+	 * context. Return an error because only a single session per context is
+	 * allowed, see arm_ffa_tee.h for details.
+	 */
+	if (ctxdata->ffa_dev || ctxdata->ffa_ops)
+		return -EBUSY;
+
+	if (arg->num_params != 1)
+		return -EINVAL;
+
+	part_id = lower_16_bits(param[0].u.value.a);
+
+	dev = ffa_tee_get_bound_dev(part_id);
+	if (!dev)
+		return -ENODEV;
+
+	ctxdata->ffa_dev = dev->ffa_dev;
+	ctxdata->ffa_ops = dev->ffa_ops;
+
+	return 0;
+}
+
+static int ffa_tee_close_session(struct tee_context *ctx,
+				 u32 session __always_unused)
+{
+	struct ffa_tee_context_data *ctxdata = ctx->data;
+
+	ctxdata->ffa_dev = NULL;
+	ctxdata->ffa_ops = NULL;
+
+	return 0;
+}
+
+static int ffa_tee_list_part(struct tee_context *ctx __always_unused,
+			     struct tee_ioctl_invoke_arg *arg,
+			     struct tee_param *param)
+{
+	const struct ffa_dev_list *dev = NULL;
+	u8 uuid_buf[UUID_SIZE] = {};
+	uuid_t uuid;
+	u16 __user *ubuf;
+	size_t ubuf_max_cnt, cnt = 0;
+	u16 part_id;
+
+	if (arg->num_params != 2)
+		return -EINVAL;
+
+	memcpy(&uuid_buf[0], &param[0].u.value.a, 8);
+	memcpy(&uuid_buf[8], &param[0].u.value.b, 8);
+	import_uuid(&uuid, uuid_buf);
+
+	ubuf = u64_to_user_ptr(param[1].u.value.a);
+	ubuf_max_cnt = (size_t)param[1].u.value.b;
+
+	if (!ubuf || !ubuf_max_cnt || !IS_ALIGNED((uintptr_t)ubuf, sizeof(u16)))
+		return -EINVAL;
+
+	/*
+	 * Copy partition IDs to user space buffer until the buffer is full or
+	 * all IDs have been copied.
+	 */
+	mutex_lock(&ffatee_list_mutex);
+	list_for_each_entry(dev, &ffa_devs, list_node) {
+		if (uuid_equal(&uuid, &dev->ffa_dev->uuid)) {
+			part_id = lower_16_bits(dev->ffa_dev->vm_id);
+			if (put_user(part_id, ubuf)) {
+				mutex_unlock(&ffatee_list_mutex);
+				return -EFAULT;
+			}
+
+			ubuf++;
+			cnt++;
+
+			if (cnt >= ubuf_max_cnt) {
+				/* Buffer too short, there might be more IDs */
+				param[1].u.value.b = 1;
+				goto out;
+			}
+		}
+	}
+	/* No more IDs, buffer was long enough */
+	param[1].u.value.b = 0;
+
+out:
+	param[1].u.value.a = cnt;
+	mutex_unlock(&ffatee_list_mutex);
+	return 0;
+}
+
+static int ffa_tee_invoke_func(struct tee_context *ctx,
+			       struct tee_ioctl_invoke_arg *arg,
+			       struct tee_param *param)
+{
+	struct ffa_tee_context_data *ctxdata = ctx->data;
+	int rc;
+
+	switch (arg->func) {
+	case CMD_GET_PARTITION_LIST:
+		rc = ffa_tee_list_part(ctx, arg, param);
+		break;
+	case CMD_SEND_MSG:
+		/* Check that a session has been opened */
+		if (!ctxdata->ffa_dev || !ctxdata->ffa_ops)
+			return -EINVAL;
+
+		if (is_ts_protocol(&ctxdata->ffa_dev->uuid)) {
+			rc = ts_msg_sync_send_recv(ctx, arg, param);
+		} else {
+			pr_err("%s protocol not implemented for UUID: %pUb\n",
+			       __func__, &ctxdata->ffa_dev->uuid);
+			rc = -EINVAL;
+		}
+		break;
+	default:
+		rc = -EINVAL;
+		break;
+	}
+
+	return rc;
+}
+
+static int ffa_tee_cancel_req(struct tee_context *ctx __always_unused,
+			      u32 cancel_id __always_unused,
+			      u32 session __always_unused)
+{
+	return -EINVAL;
+}
+
+int ffa_tee_shm_register(struct tee_context *ctx, struct tee_shm *shm,
+			 struct page **pages, size_t num_pages,
+			 unsigned long start __always_unused)
+{
+	struct ffa_tee_context_data *ctxdata = ctx->data;
+	struct ffa_mem_region_attributes mem_attr = {
+		.attrs = FFA_MEM_RW,
+		.flag = 0,
+	};
+	struct ffa_mem_ops_args args = {
+		.attrs = &mem_attr,
+		.flags = 0,
+		.nattrs = 1,
+		.use_txbuf = true,
+	};
+	struct sg_table sgt;
+	int rc;
+
+	/* Check that a session has been opened */
+	if (!ctxdata->ffa_dev || !ctxdata->ffa_ops)
+		return -EINVAL;
+
+	mem_attr.receiver = ctxdata->ffa_dev->vm_id;
+
+	rc = sg_alloc_table_from_pages(&sgt, pages, num_pages, 0,
+				       num_pages * PAGE_SIZE, GFP_KERNEL);
+	if (rc)
+		return rc;
+
+	args.sg = sgt.sgl;
+	rc = ctxdata->ffa_ops->memory_share(ctxdata->ffa_dev, &args);
+	sg_free_table(&sgt);
+	if (rc)
+		return rc;
+
+	shm->sec_world_id = args.g_handle;
+
+	if (is_ts_protocol(&ctxdata->ffa_dev->uuid)) {
+		rc = ts_msg_shm_share(ctx, shm);
+	} else {
+		pr_err("%s: protocol not implemented for UUID: %pUb\n",
+		       __func__, &ctxdata->ffa_dev->uuid);
+		rc = -EINVAL;
+	}
+
+	if (rc)
+		ctxdata->ffa_ops->memory_reclaim(shm->sec_world_id, 0);
+
+	return rc;
+}
+
+int ffa_tee_shm_unregister(struct tee_context *ctx, struct tee_shm *shm)
+{
+	struct ffa_tee_context_data *ctxdata = ctx->data;
+	int rc;
+
+	/* Check that a session has been opened */
+	if (!ctxdata->ffa_dev || !ctxdata->ffa_ops)
+		return -EINVAL;
+
+	if (is_ts_protocol(&ctxdata->ffa_dev->uuid)) {
+		rc = ts_msg_shm_reclaim(ctx, shm);
+	} else {
+		pr_err("%s: protocol not implemented for UUID: %pUb\n",
+		       __func__, &ctxdata->ffa_dev->uuid);
+		rc = -EINVAL;
+	}
+
+	if (rc)
+		return rc;
+
+	rc = ctxdata->ffa_ops->memory_reclaim(shm->sec_world_id, 0);
+
+	return rc;
+}
+
+static const struct tee_driver_ops ffa_tee_ops = {
+	.get_version = ffa_tee_get_version,
+	.open = ffa_tee_open,
+	.release = ffa_tee_release,
+	.open_session = ffa_tee_open_session,
+	.close_session = ffa_tee_close_session,
+	.invoke_func = ffa_tee_invoke_func,
+	.cancel_req = ffa_tee_cancel_req,
+	.shm_register = ffa_tee_shm_register,
+	.shm_unregister = ffa_tee_shm_unregister,
+};
+
+static const struct tee_desc ffa_tee_desc = {
+	.name = "ffa-tee-client",
+	.ops = &ffa_tee_ops,
+	.owner = THIS_MODULE,
+};
+
+static struct ffa_tee *ffa_tee;
+
+static void ffa_tee_deinit_common(void)
+{
+	tee_device_unregister(ffa_tee->teedev);
+	if (ffa_tee->pool)
+		tee_shm_pool_free(ffa_tee->pool);
+	kfree(ffa_tee);
+}
+
+static int ffa_tee_init(void)
+{
+	int rc;
+
+	ffa_tee = kzalloc(sizeof(*ffa_tee), GFP_KERNEL);
+	if (!ffa_tee)
+		return -ENOMEM;
+
+	ffa_tee->pool = ffa_tee_create_shm_pool();
+	if (IS_ERR(ffa_tee->pool)) {
+		rc = PTR_ERR(ffa_tee->pool);
+		ffa_tee->pool = NULL;
+		goto err;
+	}
+
+	ffa_tee->teedev = tee_device_alloc(&ffa_tee_desc, NULL, ffa_tee->pool,
+					   ffa_tee);
+	if (IS_ERR(ffa_tee->teedev)) {
+		rc = PTR_ERR(ffa_tee->teedev);
+		ffa_tee->teedev = NULL;
+		goto err;
+	}
+
+	rc = tee_device_register(ffa_tee->teedev);
+	if (rc)
+		goto err;
+
+	return 0;
+
+err:
+	ffa_tee_deinit_common();
+	return rc;
+}
+
+static void ffa_tee_deinit(void)
+{
+	if (ffa_tee)
+		ffa_tee_deinit_common();
+}
+
+/* FF-A client driver initialization */
+static int ffa_tee_probe(struct ffa_device *ffa_dev)
+{
+	struct ffa_dev_list *dev;
+
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+	if (!dev)
+		return -ENOMEM;
+
+	dev->ffa_dev = ffa_dev;
+	dev->ffa_ops = ffa_dev_ops_get(ffa_dev);
+
+	/* Trusted Services SPs use 32-bit direct messaging */
+	if (is_ts_protocol(&ffa_dev->uuid))
+		dev->ffa_ops->mode_32bit_set(ffa_dev);
+
+	mutex_lock(&ffatee_list_mutex);
+	list_add(&dev->list_node, &ffa_devs);
+	mutex_unlock(&ffatee_list_mutex);
+
+	return 0;
+}
+
+static void ffa_tee_remove(struct ffa_device *ffa_dev)
+{
+	struct ffa_dev_list *dev, *dev_tmp;
+
+	mutex_lock(&ffatee_list_mutex);
+	list_for_each_entry_safe(dev, dev_tmp, &ffa_devs, list_node) {
+		if (dev->ffa_dev == ffa_dev) {
+			list_del(&dev->list_node);
+			kfree(dev);
+		}
+	}
+	mutex_unlock(&ffatee_list_mutex);
+}
+
+static const struct ffa_device_id ffa_tee_device_ids[] = {
+	/* TS RPC protocol UUID: bdcd76d7-825e-4751-963b-86d4f84943ac */
+	{ TS_RPC_UUID },
+	/* PSA Crypto SP UUID: d9df52d5-16a2-4bb2-9aa4-d26d3b84e8c0 */
+	{ PSA_CRYPTO_SP_UUID },
+	/* PSA ITS SP UUID: dc1eef48-b17a-4ccf-ac8b-dfcff7711b14 */
+	{ PSA_ITS_SP_UUID },
+	/* PSA PS SP UUID: 751bf801-3dde-4768-a514-0f10aeed1790 */
+	{ PSA_PS_SP_UUID },
+	/* PSA Attestation SP UUID: a1baf155-8876-4695-8f7c-54955e8db974 */
+	{ PSA_IAT_SP_UUID },
+	{}
+};
+
+static struct ffa_driver ffa_tee_driver = {
+	.name = "arm_ffa_tee",
+	.probe = ffa_tee_probe,
+	.remove = ffa_tee_remove,
+	.id_table = ffa_tee_device_ids,
+};
+
+static int __init ffa_tee_mod_init(void)
+{
+	int rc;
+
+	if (!IS_REACHABLE(CONFIG_TEE) ||
+	    !IS_REACHABLE(CONFIG_ARM_FFA_TRANSPORT))
+		return -EOPNOTSUPP;
+
+	rc = ffa_register(&ffa_tee_driver);
+	if (rc)
+		return rc;
+
+	rc = ffa_tee_init();
+	if (rc)
+		ffa_unregister(&ffa_tee_driver);
+
+	return rc;
+}
+module_init(ffa_tee_mod_init)
+
+static void __exit ffa_tee_mod_exit(void)
+{
+	if (IS_REACHABLE(CONFIG_TEE))
+		ffa_tee_deinit();
+
+	if (IS_REACHABLE(CONFIG_ARM_FFA_TRANSPORT))
+		ffa_unregister(&ffa_tee_driver);
+}
+module_exit(ffa_tee_mod_exit)
+
+MODULE_ALIAS("arm-ffa-tee");
+MODULE_AUTHOR("Balint Dobszay <balint.dobszay@arm.com>");
+MODULE_AUTHOR("Sudeep Holla <sudeep.holla@arm.com>");
+MODULE_DESCRIPTION("Arm FF-A TEE driver");
+MODULE_LICENSE("GPL");
+MODULE_VERSION("1.0.0");
diff --git a/drivers/tee/arm_ffa_tee/ffa_tee_private.h b/drivers/tee/arm_ffa_tee/ffa_tee_private.h
new file mode 100644
index 000000000000..e37fe51adb8d
--- /dev/null
+++ b/drivers/tee/arm_ffa_tee/ffa_tee_private.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022, Arm Limited
+ */
+
+#ifndef FFA_TEE_PRIVATE_H
+#define FFA_TEE_PRIVATE_H
+
+#include <linux/arm_ffa.h>
+#include <linux/tee_drv.h>
+
+/**
+ * struct ffa_tee - Main struct describing this TEE driver
+ * @teedev	TEE device allocated and registered by the driver
+ * @pool	Dynamic shared memory pool for the TEE device
+ */
+struct ffa_tee {
+	struct tee_device *teedev;
+	struct tee_shm_pool *pool;
+};
+
+/**
+ * struct ffa_tee_context_data - Context information
+ * @ffa_dev	FF-A device selected for this context
+ * @ffa_ops	FF-A operations of the device
+ */
+struct ffa_tee_context_data {
+	struct ffa_device *ffa_dev;
+	const struct ffa_dev_ops *ffa_ops;
+};
+
+int ffa_tee_shm_register(struct tee_context *ctx, struct tee_shm *shm,
+			 struct page **pages, size_t num_pages,
+			 unsigned long start);
+int ffa_tee_shm_unregister(struct tee_context *ctx, struct tee_shm *shm);
+
+struct tee_shm_pool *ffa_tee_create_shm_pool(void);
+
+#endif /* FFA_TEE_PRIVATE_H */
diff --git a/drivers/tee/arm_ffa_tee/shm_pool.c b/drivers/tee/arm_ffa_tee/shm_pool.c
new file mode 100644
index 000000000000..7c3a20ea07d3
--- /dev/null
+++ b/drivers/tee/arm_ffa_tee/shm_pool.c
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022, Arm Limited
+ */
+
+#include <linux/arm_ffa.h>
+#include <linux/device.h>
+#include <linux/dma-buf.h>
+#include <linux/genalloc.h>
+#include <linux/slab.h>
+#include <linux/tee_drv.h>
+
+#include "ffa_tee_private.h"
+
+/*
+ * This file implements a dynamic shared memory pool. It's used by the TEE
+ * subsystem to allocate kernel memory to be shared with the SWd as part of the
+ * TEE_IOC_SHM_ALLOC call.
+ */
+
+static int pool_op_alloc(struct tee_shm_pool *pool __always_unused,
+			 struct tee_shm *shm, size_t size, size_t align)
+{
+	unsigned int order, nr_pages, i;
+	struct page *page, **pages;
+	int rc;
+
+	if (size == 0)
+		return -EINVAL;
+
+	order = get_order(size);
+	nr_pages = 1 << order;
+
+	page = alloc_pages(GFP_KERNEL | __GFP_ZERO, order);
+	if (!page)
+		return -ENOMEM;
+
+	shm->kaddr = page_address(page);
+	shm->paddr = page_to_phys(page);
+	shm->size = PAGE_SIZE << order;
+
+	pages = kcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);
+	if (!pages) {
+		rc = -ENOMEM;
+		goto err;
+	}
+
+	for (i = 0; i < nr_pages; i++)
+		pages[i] = page + i;
+
+	shm->flags |= TEE_SHM_DYNAMIC;
+	rc = ffa_tee_shm_register(shm->ctx, shm, pages, nr_pages,
+				  (unsigned long)shm->kaddr);
+	kfree(pages);
+	if (rc)
+		goto err;
+
+	return 0;
+
+err:
+	__free_pages(page, order);
+	return rc;
+}
+
+static void pool_op_free(struct tee_shm_pool *pool __always_unused,
+			 struct tee_shm *shm)
+{
+	ffa_tee_shm_unregister(shm->ctx, shm);
+	free_pages((unsigned long)shm->kaddr, get_order(shm->size));
+	shm->kaddr = NULL;
+}
+
+static void pool_op_destroy_pool(struct tee_shm_pool *pool)
+{
+	kfree(pool);
+}
+
+static const struct tee_shm_pool_ops pool_ops = {
+	.alloc = pool_op_alloc,
+	.free = pool_op_free,
+	.destroy_pool = pool_op_destroy_pool,
+};
+
+struct tee_shm_pool *ffa_tee_create_shm_pool(void)
+{
+	struct tee_shm_pool *pool = kzalloc(sizeof(*pool), GFP_KERNEL);
+
+	if (!pool)
+		return ERR_PTR(-ENOMEM);
+
+	pool->ops = &pool_ops;
+
+	return pool;
+}
diff --git a/drivers/tee/arm_ffa_tee/ts_msg.c b/drivers/tee/arm_ffa_tee/ts_msg.c
new file mode 100644
index 000000000000..c8f8e6292cd6
--- /dev/null
+++ b/drivers/tee/arm_ffa_tee/ts_msg.c
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022, Arm Limited
+ */
+
+#include <linux/arm_ffa.h>
+#include <linux/kernel.h>
+#include <linux/tee_drv.h>
+#include <linux/types.h>
+#include <linux/uuid.h>
+
+#include "ffa_tee_private.h"
+#include "ts_msg.h"
+
+/*
+ * This file implements the message sending and shared memory handling callbacks
+ * using the Trusted Services RPC protocol.
+ */
+
+bool is_ts_protocol(uuid_t *uuid)
+{
+	return (uuid_equal(uuid, &TS_RPC_UUID) ||
+		uuid_equal(uuid, &PSA_CRYPTO_SP_UUID) ||
+		uuid_equal(uuid, &PSA_ITS_SP_UUID) ||
+		uuid_equal(uuid, &PSA_PS_SP_UUID) ||
+		uuid_equal(uuid, &PSA_IAT_SP_UUID));
+}
+
+static void arg_list_to_ffa_data(const u32 *args,
+				 struct ffa_send_direct_data *data)
+{
+	data->data0 = args[0];
+	data->data1 = args[1];
+	data->data2 = args[2];
+	data->data3 = args[3];
+	data->data4 = args[4];
+}
+
+static void arg_list_from_ffa_data(const struct ffa_send_direct_data *data,
+				   u32 *args)
+{
+	args[0] = lower_32_bits(data->data0);
+	args[1] = lower_32_bits(data->data1);
+	args[2] = lower_32_bits(data->data2);
+	args[3] = lower_32_bits(data->data3);
+	args[4] = lower_32_bits(data->data4);
+}
+
+int ts_msg_sync_send_recv(struct tee_context *ctx,
+			  struct tee_ioctl_invoke_arg *arg,
+			  struct tee_param *param)
+{
+	struct ffa_tee_context_data *ctxdata = ctx->data;
+	struct ffa_send_direct_data data;
+	u16 iface, opcode;
+	u32 args[5] = {};
+	int rc;
+
+	if (arg->num_params != 1)
+		return -EINVAL;
+
+	iface = upper_16_bits(param[0].u.value.a);
+	opcode = lower_16_bits(param[0].u.value.a);
+
+	args[TS_MSG_IFACE_ID_OPCODE] = TS_MSG_ADD_IFACE_OPCODE(iface, opcode);
+	args[TS_MSG_REQ_DATA_LEN] = param[0].u.value.b;
+	args[TS_MSG_ENCODING] = param[0].u.value.c;
+	args[TS_MSG_CALLER_ID] = 0;
+
+	arg_list_to_ffa_data(args, &data);
+	rc = ctxdata->ffa_ops->sync_send_receive(ctxdata->ffa_dev, &data);
+	if (rc)
+		return rc;
+	arg_list_from_ffa_data(&data, args);
+
+	param[0].u.value.a = args[TS_MSG_RESP_DATA_LEN];
+	param[0].u.value.b = (u64)args[TS_MSG_RESP_RPC_STATUS] << 32;
+	param[0].u.value.b |= args[TS_MSG_RESP_OP_STATUS];
+	param[0].u.value.c = 0;
+
+	return 0;
+}
+
+int ts_msg_shm_share(struct tee_context *ctx, struct tee_shm *shm)
+{
+	struct ffa_tee_context_data *ctxdata = ctx->data;
+	struct ffa_send_direct_data data;
+	u32 args[5] = {};
+	int rc;
+
+	args[TS_MSG_IFACE_ID_OPCODE] =
+		TS_MSG_ADD_IFACE_OPCODE(TS_MSG_MGMT_IFACE_ID, TS_MSG_OPCODE_SHARE_MEM);
+	args[TS_MSG_SHARE_MEM_HANDLE_LSW] = lower_32_bits(shm->sec_world_id);
+	args[TS_MSG_SHARE_MEM_HANDLE_MSW] = upper_32_bits(shm->sec_world_id);
+	args[TS_MSG_SHARE_MEM_SIZE] = shm->size;
+
+	arg_list_to_ffa_data(args, &data);
+	rc = ctxdata->ffa_ops->sync_send_receive(ctxdata->ffa_dev, &data);
+	if (rc)
+		return rc;
+	arg_list_from_ffa_data(&data, args);
+
+	/* Management call response only sets RPC status field */
+	if (args[TS_MSG_RESP_RPC_STATUS] != 0)
+		return (int)args[TS_MSG_RESP_RPC_STATUS];
+
+	return 0;
+}
+
+int ts_msg_shm_reclaim(struct tee_context *ctx, struct tee_shm *shm)
+{
+	struct ffa_tee_context_data *ctxdata = ctx->data;
+	struct ffa_send_direct_data data;
+	u32 args[5] = {};
+	int rc;
+
+	args[TS_MSG_IFACE_ID_OPCODE] =
+		TS_MSG_ADD_IFACE_OPCODE(TS_MSG_MGMT_IFACE_ID, TS_MSG_OPCODE_UNSHARE_MEM);
+	args[TS_MSG_SHARE_MEM_HANDLE_LSW] = lower_32_bits(shm->sec_world_id);
+	args[TS_MSG_SHARE_MEM_HANDLE_MSW] = upper_32_bits(shm->sec_world_id);
+
+	arg_list_to_ffa_data(args, &data);
+	rc = ctxdata->ffa_ops->sync_send_receive(ctxdata->ffa_dev, &data);
+	if (rc)
+		return rc;
+	arg_list_from_ffa_data(&data, args);
+
+	/* Management call response only sets RPC status field */
+	if (args[TS_MSG_RESP_RPC_STATUS] != 0)
+		return (int)args[TS_MSG_RESP_RPC_STATUS];
+
+	return 0;
+}
diff --git a/drivers/tee/arm_ffa_tee/ts_msg.h b/drivers/tee/arm_ffa_tee/ts_msg.h
new file mode 100644
index 000000000000..de5c9218a790
--- /dev/null
+++ b/drivers/tee/arm_ffa_tee/ts_msg.h
@@ -0,0 +1,75 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022, Arm Limited
+ */
+
+#ifndef TS_MSG_H
+#define TS_MSG_H
+
+/*
+ * Defines convention for use of FF-A direct call arguments by Trusted Services.
+ */
+
+/* UUID of this protocol */
+#define TS_RPC_UUID UUID_INIT(0xbdcd76d7, 0x825e, 0x4751, \
+			      0x96, 0x3b, 0x86, 0xd4, 0xf8, 0x49, 0x43, 0xac)
+
+/* Macros for parameters carried in a single register */
+#define TS_MSG_ADD_IFACE_OPCODE(i, o)	(((i) << 16) | ((o) & 0xffff))
+#define TS_MSG_EXTRACT_IFACE(reg)	((reg) >> 16)
+#define TS_MSG_EXTRACT_OPCODE(reg)	((reg) & 0xffff)
+
+/*
+ * If SPs are built with FF-A Routing Extension enabled, this should be 1.
+ * Otherwise it should be 0.
+ */
+#define FFARE_OFFSET	(1)
+
+/* Common req & resp arg offests */
+#define TS_MSG_IFACE_ID_OPCODE		(0 + FFARE_OFFSET)
+
+/* Req arg offsets */
+#define TS_MSG_REQ_DATA_LEN		(1 + FFARE_OFFSET)
+#define TS_MSG_CALLER_ID		(2 + FFARE_OFFSET)
+#define TS_MSG_ENCODING			(3 + FFARE_OFFSET)
+
+/* Resp arg offsets */
+#define TS_MSG_RESP_DATA_LEN		(1 + FFARE_OFFSET)
+#define TS_MSG_RESP_RPC_STATUS		(2 + FFARE_OFFSET)
+#define TS_MSG_RESP_OP_STATUS		(3 + FFARE_OFFSET)
+
+/* Share/unshare buffer offsets */
+#define TS_MSG_SHARE_MEM_HANDLE_LSW	(1 + FFARE_OFFSET)
+#define TS_MSG_SHARE_MEM_HANDLE_MSW	(2 + FFARE_OFFSET)
+#define TS_MSG_SHARE_MEM_SIZE		(3 + FFARE_OFFSET)
+
+/* Interface ID for the FF-A based RPC layer for management operations */
+#define TS_MSG_MGMT_IFACE_ID		(0x1000)
+
+/* Common opcodes used by the FF-A based RPC layer for management operations */
+#define TS_MSG_OPCODE_SHARE_MEM		(0)
+#define TS_MSG_OPCODE_UNSHARE_MEM	(1)
+
+/*
+ * Currently all PSA SPs use the same protocol, but have dedicated UUIDs instead
+ * of using the common protocol UUID. All UUIDs listed here should be treated as
+ * having the same protocol. These will be removed later when the rest of the
+ * components are updated.
+ */
+#define PSA_CRYPTO_SP_UUID UUID_INIT(0xd9df52d5, 0x16a2, 0x4bb2, \
+				0x9a, 0xa4, 0xd2, 0x6d, 0x3b, 0x84, 0xe8, 0xc0)
+#define PSA_ITS_SP_UUID UUID_INIT(0xdc1eef48, 0xb17a, 0x4ccf, \
+				0xac, 0x8b, 0xdf, 0xcf, 0xf7, 0x71, 0x1b, 0x14)
+#define PSA_PS_SP_UUID UUID_INIT(0x751bf801, 0x3dde, 0x4768, \
+				0xa5, 0x14, 0x0f, 0x10, 0xae, 0xed, 0x17, 0x90)
+#define PSA_IAT_SP_UUID UUID_INIT(0xa1baf155, 0x8876, 0x4695, \
+				0x8f, 0x7c, 0x54, 0x95, 0x5e, 0x8d, 0xb9, 0x74)
+
+bool is_ts_protocol(uuid_t *uuid);
+int ts_msg_sync_send_recv(struct tee_context *ctx,
+			  struct tee_ioctl_invoke_arg *arg,
+			  struct tee_param *param);
+int ts_msg_shm_share(struct tee_context *ctx, struct tee_shm *shm);
+int ts_msg_shm_reclaim(struct tee_context *ctx, struct tee_shm *shm);
+
+#endif /* TS_MSG_H */
diff --git a/include/uapi/linux/arm_ffa_tee.h b/include/uapi/linux/arm_ffa_tee.h
new file mode 100644
index 000000000000..c2ce1360a190
--- /dev/null
+++ b/include/uapi/linux/arm_ffa_tee.h
@@ -0,0 +1,116 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2020-2021, Arm Limited
+ */
+
+#ifndef ARM_FFA_TEE_H
+#define ARM_FFA_TEE_H
+
+#include <linux/types.h>
+
+/*
+ * Some of the TEE ioctl calls don't have a parameter where the destination
+ * partition ID could be passed. To workaround this, first the partition ID has
+ * to be set in the context. This can be done using the open session ioctl.
+ * Currently this call doesn't invoke the SWd, i.e. there is no "real" session
+ * opened that should be registered in the SWd. It's only used to store the
+ * destination partition ID so subsequent calls can use it.
+ *
+ * Prior to calling open session, only one type of call is allowed:
+ * CMD_GET_PARTITION_LIST, because this doesn't invoke the SWd.
+ *
+ * For TEE_IOC_OPEN_SESSION. In tee_ioctl_open_session_arg:
+ * - num_params is 1,
+ * - rest of the fields is empty.
+ *
+ * Parameter encoding:
+ * param[0]:
+ * - attr: TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT
+ * - a: destination partition ID (u16)
+ * - b: 0
+ * - c: 0
+ */
+
+/*
+ * This command is for querying the list of partitions with a matching UUID.
+ *
+ * This is not the same as a generic FF-A discovery call. The PARTITION_INFO_GET
+ * call is done by the FF-A driver and only the devices compatible with this
+ * driver (i.e. listed in this module's .id_table) are bound to this driver.
+ * This command searches the list of these bound devices looking for matching
+ * UUIDs and writes the corresponding partition IDs into the supplied buffer.
+ * It can (should) be called before TEE_IOC_OPEN_SESSION, to find the desired
+ * destination partition ID.
+ *
+ * Use with TEE_IOC_INVOKE. In tee_ioctl_invoke_arg:
+ * - func is CMD_GET_PARTITION_LIST,
+ * - num_params is 2,
+ * - rest of the fields is empty.
+ *
+ * Parameter encoding:
+ * param[0]:
+ * - attr: TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT
+ * - a: first 8 bytes of the FF-A UUID (big-endian)
+ * - b: last 8 bytes of the FF-A UUID (big-endian)
+ * - c: 0
+ *
+ * param[1]:
+ * - attr: TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT
+ * - a: address of partition ID list (array of u16)
+ * - b: max number of partition IDs in list (number of elements in array)
+ * - c: 0
+ *
+ * Return parameter encoding:
+ * param[0]: input only
+ *
+ * param[1]:
+ * - a: number of IDs returned in the list
+ * - b: 0 if all possible IDs are returned
+ *      1 if there might be more (buffer was too short)
+ * - c: 0
+ */
+#define CMD_GET_PARTITION_LIST	(1)
+
+/*
+ * This command is for sending a message to a Secure Partition.
+ *
+ * The parameter encoding and implementation of this command depends on the ABI
+ * implemented by the SP (i.e. how it interprets the arguments of an FF-A direct
+ * request message). Currently the only implementation available in the driver
+ * is the Trusted Services RPC protocol, but other protocols can be added in the
+ * future.
+ * The following description is specific to the Trusted Services RPC protocol.
+ *
+ * Use with TEE_IOC_INVOKE. In tee_ioctl_invoke_arg:
+ * - func is CMD_SEND_MSG,
+ * - num_params is 1,
+ * - rest of the fields is empty.
+ *
+ * Parameter encoding:
+ * param[0]:
+ * - attr: TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT
+ * - a: interface ID | opcode
+ * - b: request length
+ * - c: encoding
+ *
+ * Return parameter encoding:
+ * param[0]:
+ * - a: response length
+ * - b: RPC status | operation status
+ * - c: 0
+ */
+#define CMD_SEND_MSG	(2)
+
+#define CMD_SEND_MSG_PARAM_A(iface, opcode) ((__u64)(		\
+	(((__u32)(iface) & (__u32)0x0000ffffUL) << 16) |	\
+	((__u32)(opcode) & (__u32)0x0000ffffUL)))
+#define CMD_SEND_MSG_PARAM_B(req_len) ((__u32)(req_len))
+#define CMD_SEND_MSG_PARAM_C(encoding) ((__u32)(encoding))
+
+#define CMD_SEND_MSG_RESP_LEN(param_a) ((__u32)(param_a))
+#define CMD_SEND_MSG_RPC_STATUS(param_b) \
+	((__s32)(((param_b) >> 32) & (__u32)0xffffffffUL))
+#define CMD_SEND_MSG_OP_STATUS(param_b) \
+	((__s32)((param_b) & (__u32)0xffffffffUL))
+
+#endif /* ARM_FFA_TEE_H */
diff --git a/include/uapi/linux/tee.h b/include/uapi/linux/tee.h
index 25a6c534beb1..4455a5b1a923 100644
--- a/include/uapi/linux/tee.h
+++ b/include/uapi/linux/tee.h
@@ -60,6 +60,7 @@
  */
 #define TEE_IMPL_ID_OPTEE	1
 #define TEE_IMPL_ID_AMDTEE	2
+#define TEE_IMPL_ID_FFATEE	3
 
 /*
  * OP-TEE specific capabilities
-- 
2.35.1

