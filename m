Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF2F51F793
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 11:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237790AbiEII7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 04:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236385AbiEII1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 04:27:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E071DA644
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 01:22:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AE09BB80FD4
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 08:22:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35FB9C385A8;
        Mon,  9 May 2022 08:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652084547;
        bh=YQKd4gy5wpQWb8dzdW2lgVjfkMEgktknAKiuL/o1yXU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XZc8/egbbJSf0dQObANiQ8DbYqY4iTRwWvl3lYmuzCgkRc38WfnV1TaQpGkXsiJqY
         uyM8fLORBSMiOfB7f7oq+JO+fZ3XiLL0O1VbSmLpmPEvx6ABpdWjUDe5VbvtxkJ6kY
         9dti7ogZXrQd7w/CZcrXgbWB9/ikiWkqjh9egPSp4IMEn+2bz07Iuy9axOuJbhjlqX
         tsTz27lvUGeH34hUtEC+NsX9g1Ox80yKG7k3G5jsCikXe3/wy3Z/M5xfBgqEXVOFkw
         oVL+3QOCHjioFidnOB3ScdQHl+f/TssQ7+3PdWvt4adZ35CuYTgexvUwObYM7uNP1Z
         ViJ67OKm3fIHg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tal Cohen <talcohen@habana.ai>
Subject: [PATCH 3/3] habanalabs: add support for notification via eventfd
Date:   Mon,  9 May 2022 11:22:18 +0300
Message-Id: <20220509082218.956916-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220509082218.956916-1-ogabbay@kernel.org>
References: <20220509082218.956916-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tal Cohen <talcohen@habana.ai>

The driver will be able to send notification events towards
a user process, using user's registered event file descriptor.
The driver uses the notification mechanism to inform the
user about an occurred event.
A user thread can wait until a notification is received from
the driver.

The driver stores the occurred event until the user reads it,
using HL_INFO_GET_EVENTS - new ioctl opcode in the INFO ioctl.

Gaudi specific implementation includes sending a notification
on a TPC assertion event that is received from f/w.

Signed-off-by: Tal Cohen <talcohen@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c       | 52 +++++++++++++++
 drivers/misc/habanalabs/common/habanalabs.h   | 40 ++++++++----
 .../misc/habanalabs/common/habanalabs_drv.c   |  9 +++
 .../misc/habanalabs/common/habanalabs_ioctl.c | 65 +++++++++++++++++++
 drivers/misc/habanalabs/gaudi/gaudi.c         | 14 +++-
 include/uapi/misc/habanalabs.h                | 15 +++++
 6 files changed, 182 insertions(+), 13 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 15df89b31e1b..315510aaca35 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -285,6 +285,14 @@ static void hpriv_release(struct kref *ref)
 
 	hdev->compute_ctx_in_release = 0;
 
+	/* release the eventfd */
+	if (hpriv->notifier_event.eventfd) {
+		eventfd_ctx_put(hpriv->notifier_event.eventfd);
+		hpriv->notifier_event.eventfd = 0;
+	}
+
+	mutex_destroy(&hpriv->notifier_event.lock);
+
 	kfree(hpriv);
 }
 
@@ -355,6 +363,13 @@ static int hl_device_release_ctrl(struct inode *inode, struct file *filp)
 	list_del(&hpriv->dev_node);
 	mutex_unlock(&hdev->fpriv_ctrl_list_lock);
 out:
+	/* release the eventfd */
+	if (hpriv->notifier_event.eventfd) {
+		eventfd_ctx_put(hpriv->notifier_event.eventfd);
+		hpriv->notifier_event.eventfd = 0;
+	}
+
+	mutex_destroy(&hpriv->notifier_event.lock);
 	put_pid(hpriv->taskpid);
 
 	kfree(hpriv);
@@ -1506,6 +1521,43 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 	return rc;
 }
 
+static void hl_notifier_event_send(struct hl_notifier_event *notifier_event, u64 event)
+{
+	mutex_lock(&notifier_event->lock);
+	notifier_event->events_mask |= event;
+	if (notifier_event->eventfd)
+		eventfd_signal(notifier_event->eventfd, 1);
+
+	mutex_unlock(&notifier_event->lock);
+}
+
+/*
+ * hl_notifier_event_send_all - notify all user processes via eventfd
+ *
+ * @hdev: pointer to habanalabs device structure
+ * @event: the occurred event
+ * Returns 0 for success or an error on failure.
+ */
+void hl_notifier_event_send_all(struct hl_device *hdev, u64 event)
+{
+	struct hl_fpriv	*hpriv;
+
+	mutex_lock(&hdev->fpriv_list_lock);
+
+	list_for_each_entry(hpriv, &hdev->fpriv_list, dev_node)
+		hl_notifier_event_send(&hpriv->notifier_event, event);
+
+	mutex_unlock(&hdev->fpriv_list_lock);
+
+	/* control device */
+	mutex_lock(&hdev->fpriv_ctrl_list_lock);
+
+	list_for_each_entry(hpriv, &hdev->fpriv_ctrl_list, dev_node)
+		hl_notifier_event_send(&hpriv->notifier_event, event);
+
+	mutex_unlock(&hdev->fpriv_ctrl_list_lock);
+}
+
 /*
  * hl_device_init - main initialization function for habanalabs device
  *
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 918e8a04acab..8977ec67dba7 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -21,6 +21,7 @@
 #include <linux/hashtable.h>
 #include <linux/debugfs.h>
 #include <linux/rwsem.h>
+#include <linux/eventfd.h>
 #include <linux/bitfield.h>
 #include <linux/genalloc.h>
 #include <linux/sched/signal.h>
@@ -1932,6 +1933,18 @@ struct hl_debug_params {
 	bool enable;
 };
 
+/**
+ * struct hl_notifier_event - holds the notifier data structure
+ * @eventfd: the event file descriptor to raise the notifications
+ * @lock: mutex lock to protect the notifier data flows
+ * @events_mask: indicates the bitmap events
+ */
+struct hl_notifier_event {
+	struct eventfd_ctx	*eventfd;
+	struct mutex		lock;
+	u64			events_mask;
+};
+
 /*
  * FILE PRIVATE STRUCTURE
  */
@@ -1943,24 +1956,25 @@ struct hl_debug_params {
  * @taskpid: current process ID.
  * @ctx: current executing context. TODO: remove for multiple ctx per process
  * @ctx_mgr: context manager to handle multiple context for this FD.
- * @cb_mgr: command buffer manager to handle multiple buffers for this FD.
  * @mem_mgr: manager descriptor for memory exportable via mmap
+ * @notifier_event: notifier eventfd towards user process
  * @debugfs_list: list of relevant ASIC debugfs.
  * @dev_node: node in the device list of file private data
  * @refcount: number of related contexts.
  * @restore_phase_mutex: lock for context switch and restore phase.
  */
 struct hl_fpriv {
-	struct hl_device	*hdev;
-	struct file		*filp;
-	struct pid		*taskpid;
-	struct hl_ctx		*ctx;
-	struct hl_ctx_mgr	ctx_mgr;
-	struct hl_mem_mgr	mem_mgr;
-	struct list_head	debugfs_list;
-	struct list_head	dev_node;
-	struct kref		refcount;
-	struct mutex		restore_phase_mutex;
+	struct hl_device		*hdev;
+	struct file			*filp;
+	struct pid			*taskpid;
+	struct hl_ctx			*ctx;
+	struct hl_ctx_mgr		ctx_mgr;
+	struct hl_mem_mgr		mem_mgr;
+	struct hl_notifier_event	notifier_event;
+	struct list_head		debugfs_list;
+	struct list_head		dev_node;
+	struct kref			refcount;
+	struct mutex			restore_phase_mutex;
 };
 
 
@@ -2676,8 +2690,8 @@ struct hl_reset_info {
  * @state_dump_specs: constants and dictionaries needed to dump system state.
  * @multi_cs_completion: array of multi-CS completion.
  * @clk_throttling: holds information about current/previous clock throttling events
- * @reset_info: holds current device reset information.
  * @last_error: holds information about last session in which CS timeout or razwi error occurred.
+ * @reset_info: holds current device reset information.
  * @stream_master_qid_arr: pointer to array with QIDs of master streams.
  * @fw_major_version: major version of current loaded preboot
  * @dram_used_mem: current DRAM memory consumption.
@@ -3071,6 +3085,8 @@ int hl_device_utilization(struct hl_device *hdev, u32 *utilization);
 int hl_build_hwmon_channel_info(struct hl_device *hdev,
 		struct cpucp_sensor *sensors_arr);
 
+void hl_notifier_event_send_all(struct hl_device *hdev, u64 event);
+
 int hl_sysfs_init(struct hl_device *hdev);
 void hl_sysfs_fini(struct hl_device *hdev);
 
diff --git a/drivers/misc/habanalabs/common/habanalabs_drv.c b/drivers/misc/habanalabs/common/habanalabs_drv.c
index 1210de39d661..c97173e9507d 100644
--- a/drivers/misc/habanalabs/common/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/common/habanalabs_drv.c
@@ -134,6 +134,10 @@ int hl_device_open(struct inode *inode, struct file *filp)
 	hpriv->hdev = hdev;
 	filp->private_data = hpriv;
 	hpriv->filp = filp;
+	hpriv->notifier_event.events_mask = 0;
+	hpriv->notifier_event.eventfd = 0;
+
+	mutex_init(&hpriv->notifier_event.lock);
 	mutex_init(&hpriv->restore_phase_mutex);
 	kref_init(&hpriv->refcount);
 	nonseekable_open(inode, filp);
@@ -208,6 +212,7 @@ int hl_device_open(struct inode *inode, struct file *filp)
 	hl_ctx_mgr_fini(hpriv->hdev, &hpriv->ctx_mgr);
 	filp->private_data = NULL;
 	mutex_destroy(&hpriv->restore_phase_mutex);
+	mutex_destroy(&hpriv->notifier_event.lock);
 	put_pid(hpriv->taskpid);
 
 	kfree(hpriv);
@@ -241,6 +246,10 @@ int hl_device_open_ctrl(struct inode *inode, struct file *filp)
 	hpriv->hdev = hdev;
 	filp->private_data = hpriv;
 	hpriv->filp = filp;
+	hpriv->notifier_event.events_mask = 0;
+	hpriv->notifier_event.eventfd = 0;
+
+	mutex_init(&hpriv->notifier_event.lock);
 	nonseekable_open(inode, filp);
 
 	hpriv->taskpid = get_task_pid(current, PIDTYPE_PID);
diff --git a/drivers/misc/habanalabs/common/habanalabs_ioctl.c b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
index bfb5cfe68110..d1ef56a8d3ac 100644
--- a/drivers/misc/habanalabs/common/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
@@ -116,6 +116,25 @@ static int hw_events_info(struct hl_device *hdev, bool aggregate,
 	return copy_to_user(out, arr, min(max_size, size)) ? -EFAULT : 0;
 }
 
+static int events_info(struct hl_fpriv *hpriv, struct hl_info_args *args)
+{
+	int rc;
+	u32 max_size = args->return_size;
+	u64 events_mask;
+	void __user *out = (void __user *) (uintptr_t) args->return_pointer;
+
+	if ((max_size < sizeof(u64)) || (!out))
+		return -EINVAL;
+
+	mutex_lock(&hpriv->notifier_event.lock);
+	events_mask = hpriv->notifier_event.events_mask;
+	hpriv->notifier_event.events_mask = 0;
+	mutex_unlock(&hpriv->notifier_event.lock);
+
+	rc = copy_to_user(out, &events_mask, sizeof(u64));
+	return rc;
+}
+
 static int dram_usage_info(struct hl_fpriv *hpriv, struct hl_info_args *args)
 {
 	struct hl_device *hdev = hpriv->hdev;
@@ -614,6 +633,43 @@ static int dev_mem_alloc_page_sizes_info(struct hl_fpriv *hpriv, struct hl_info_
 	return copy_to_user(out, &info, min_t(size_t, max_size, sizeof(info))) ? -EFAULT : 0;
 }
 
+static int eventfd_register(struct hl_fpriv *hpriv, struct hl_info_args *args)
+{
+	int rc;
+
+	/* check if there is already a registered on that process */
+	mutex_lock(&hpriv->notifier_event.lock);
+	if (hpriv->notifier_event.eventfd) {
+		mutex_unlock(&hpriv->notifier_event.lock);
+		return -EINVAL;
+	}
+
+	hpriv->notifier_event.eventfd = eventfd_ctx_fdget(args->eventfd);
+	if (IS_ERR(hpriv->notifier_event.eventfd)) {
+		rc = PTR_ERR(hpriv->notifier_event.eventfd);
+		hpriv->notifier_event.eventfd = 0;
+		mutex_unlock(&hpriv->notifier_event.lock);
+		return rc;
+	}
+
+	mutex_unlock(&hpriv->notifier_event.lock);
+	return 0;
+}
+
+static int eventfd_unregister(struct hl_fpriv *hpriv, struct hl_info_args *args)
+{
+	mutex_lock(&hpriv->notifier_event.lock);
+	if (!hpriv->notifier_event.eventfd) {
+		mutex_unlock(&hpriv->notifier_event.lock);
+		return -EINVAL;
+	}
+
+	eventfd_ctx_put(hpriv->notifier_event.eventfd);
+	hpriv->notifier_event.eventfd = 0;
+	mutex_unlock(&hpriv->notifier_event.lock);
+	return 0;
+}
+
 static int _hl_info_ioctl(struct hl_fpriv *hpriv, void *data,
 				struct device *dev)
 {
@@ -667,6 +723,9 @@ static int _hl_info_ioctl(struct hl_fpriv *hpriv, void *data,
 	case HL_INFO_DEV_MEM_ALLOC_PAGE_SIZES:
 		return dev_mem_alloc_page_sizes_info(hpriv, args);
 
+	case HL_INFO_GET_EVENTS:
+		return events_info(hpriv, args);
+
 	default:
 		break;
 	}
@@ -717,6 +776,12 @@ static int _hl_info_ioctl(struct hl_fpriv *hpriv, void *data,
 	case HL_INFO_DRAM_PENDING_ROWS:
 		return dram_pending_rows_info(hpriv, args);
 
+	case HL_INFO_REGISTER_EVENTFD:
+		return eventfd_register(hpriv, args);
+
+	case HL_INFO_UNREGISTER_EVENTFD:
+		return eventfd_unregister(hpriv, args);
+
 	default:
 		dev_err(dev, "Invalid request %d\n", args->op);
 		rc = -EINVAL;
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 08cd60300b4f..1c388537de33 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -7879,7 +7879,6 @@ static void gaudi_handle_eqe(struct hl_device *hdev,
 	case GAUDI_EVENT_MMU_PAGE_FAULT:
 	case GAUDI_EVENT_MMU_WR_PERM:
 	case GAUDI_EVENT_RAZWI_OR_ADC:
-	case GAUDI_EVENT_TPC0_QM ... GAUDI_EVENT_TPC7_QM:
 	case GAUDI_EVENT_MME0_QM ... GAUDI_EVENT_MME2_QM:
 	case GAUDI_EVENT_DMA0_QM ... GAUDI_EVENT_DMA7_QM:
 		fallthrough;
@@ -7899,6 +7898,19 @@ static void gaudi_handle_eqe(struct hl_device *hdev,
 		hl_fw_unmask_irq(hdev, event_type);
 		break;
 
+	case GAUDI_EVENT_TPC0_QM ... GAUDI_EVENT_TPC7_QM:
+		gaudi_print_irq_info(hdev, event_type, true);
+		gaudi_handle_qman_err(hdev, event_type);
+		hl_fw_unmask_irq(hdev, event_type);
+
+		/* In TPC QM event, notify on TPC assertion. While there isn't
+		 * a specific event for assertion yet, the FW generates QM event.
+		 * The SW upper layer will inspect an internal mapped area to indicate
+		 * if the event is a tpc assertion or tpc QM.
+		 */
+		hl_notifier_event_send_all(hdev, HL_NOTIFIER_EVENT_TPC_ASSERT);
+		break;
+
 	case GAUDI_EVENT_RAZWI_OR_ADC_SW:
 		gaudi_print_irq_info(hdev, event_type, true);
 		goto reset_device;
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index 3576bf2b4841..52540d5b4fc9 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -349,6 +349,9 @@ enum hl_server_type {
  *                            Razwi initiator.
  *                            Razwi cause, was it a page fault or MMU access error.
  * HL_INFO_DEV_MEM_ALLOC_PAGE_SIZES - Retrieve valid page sizes for device memory allocation
+ * HL_INFO_REGISTER_EVENTFD   - Register eventfd for event notifications.
+ * HL_INFO_UNREGISTER_EVENTFD - Unregister eventfd
+ * HL_INFO_GET_EVENTS         - Retrieve the last occurred events
  */
 #define HL_INFO_HW_IP_INFO			0
 #define HL_INFO_HW_EVENTS			1
@@ -374,6 +377,9 @@ enum hl_server_type {
 #define HL_INFO_CS_TIMEOUT_EVENT		24
 #define HL_INFO_RAZWI_EVENT			25
 #define HL_INFO_DEV_MEM_ALLOC_PAGE_SIZES	26
+#define HL_INFO_REGISTER_EVENTFD		28
+#define HL_INFO_UNREGISTER_EVENTFD		29
+#define HL_INFO_GET_EVENTS			30
 
 #define HL_INFO_VERSION_MAX_LEN			128
 #define HL_INFO_CARD_NAME_MAX_LEN		16
@@ -679,6 +685,7 @@ enum gaudi_dcores {
  * @period_ms: Period value, in milliseconds, for utilization rate in range 100ms - 1000ms in 100 ms
  *             resolution. Currently not in use.
  * @pll_index: Index as defined in hl_<asic type>_pll_index enumeration.
+ * @eventfd: event file descriptor for event notifications.
  * @pad: Padding to 64 bit.
  */
 struct hl_info_args {
@@ -691,6 +698,7 @@ struct hl_info_args {
 		__u32 ctx_id;
 		__u32 period_ms;
 		__u32 pll_index;
+		__u32 eventfd;
 	};
 
 	__u32 pad;
@@ -1390,6 +1398,13 @@ struct hl_debug_args {
 	__u32 ctx_id;
 };
 
+/*
+ * Notifier event values - for the notification mechanism and the HL_INFO_GET_EVENTS command
+ *
+ * HL_NOTIFIER_EVENT_TPC_ASSERT - Indicates TPC assert event
+ */
+#define HL_NOTIFIER_EVENT_TPC_ASSERT  (1 << 0)
+
 /*
  * Various information operations such as:
  * - H/W IP information
-- 
2.25.1

