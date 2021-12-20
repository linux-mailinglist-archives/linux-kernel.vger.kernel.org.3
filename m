Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 185A847B410
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 20:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233352AbhLTT5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 14:57:50 -0500
Received: from foss.arm.com ([217.140.110.172]:34634 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233433AbhLTT5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 14:57:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 78057D6E;
        Mon, 20 Dec 2021 11:57:40 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 86AFB3F718;
        Mon, 20 Dec 2021 11:57:37 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [PATCH v8 07/11] firmware: arm_scmi: Add atomic mode support to smc transport
Date:   Mon, 20 Dec 2021 19:56:42 +0000
Message-Id: <20211220195646.44498-8-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211220195646.44498-1-cristian.marussi@arm.com>
References: <20211220195646.44498-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a Kernel configuration option to enable SCMI SMC transport atomic
mode operation for selected SCMI transactions and leave it as default
disabled.

Substitute mutex usages with busy-waiting and declare smc transport as
.atomic_enabled if such Kernel configuration option is enabled.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v7 --> v8
- removed ifdeffery, using IS_ENABLED
v5 --> v6
- remove usage of atomic_capable
- removed needless union
- reviewed Kconfig help
v4 --> v5
- removed RFC tag
- add CONFIG_ARM_SCMI_TRANSPORT_SMC_ATOMIC_ENABLE option
- add .atomic_enable support
- make atomic_capable dependent on
  CONFIG_ARM_SCMI_TRANSPORT_SMC_ATOMIC_ENABLE
- make also usage of mutexes vs busy-waiting dependent on
  CONFIG_ARM_SCMI_TRANSPORT_SMC_ATOMIC_ENABLE
---
 drivers/firmware/arm_scmi/Kconfig | 14 ++++++++
 drivers/firmware/arm_scmi/smc.c   | 56 +++++++++++++++++++++++++++----
 2 files changed, 64 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
index 638ecec89ff1..d429326433d1 100644
--- a/drivers/firmware/arm_scmi/Kconfig
+++ b/drivers/firmware/arm_scmi/Kconfig
@@ -78,6 +78,20 @@ config ARM_SCMI_TRANSPORT_SMC
 	  If you want the ARM SCMI PROTOCOL stack to include support for a
 	  transport based on SMC, answer Y.
 
+config ARM_SCMI_TRANSPORT_SMC_ATOMIC_ENABLE
+	bool "Enable atomic mode support for SCMI SMC transport"
+	depends on ARM_SCMI_TRANSPORT_SMC
+	help
+	  Enable support of atomic operation for SCMI SMC based transport.
+
+	  If you want the SCMI SMC based transport to operate in atomic
+	  mode, avoiding any kind of sleeping behaviour for selected
+	  transactions on the TX path, answer Y.
+	  Enabling atomic mode operations allows any SCMI driver using this
+	  transport to optionally ask for atomic SCMI transactions and operate
+	  in atomic context too, at the price of using a number of busy-waiting
+	  primitives all over instead. If unsure say N.
+
 config ARM_SCMI_TRANSPORT_VIRTIO
 	bool "SCMI transport based on VirtIO"
 	depends on VIRTIO=y || VIRTIO=ARM_SCMI_PROTOCOL
diff --git a/drivers/firmware/arm_scmi/smc.c b/drivers/firmware/arm_scmi/smc.c
index df0defd9f8bb..6c7871a40611 100644
--- a/drivers/firmware/arm_scmi/smc.c
+++ b/drivers/firmware/arm_scmi/smc.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/arm-smccc.h>
+#include <linux/atomic.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
@@ -14,6 +15,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
+#include <linux/processor.h>
 #include <linux/slab.h>
 
 #include "common.h"
@@ -23,14 +25,20 @@
  *
  * @cinfo: SCMI channel info
  * @shmem: Transmit/Receive shared memory area
- * @shmem_lock: Lock to protect access to Tx/Rx shared memory area
+ * @shmem_lock: Lock to protect access to Tx/Rx shared memory area.
+ *		Used when NOT operating in atomic mode.
+ * @inflight: Atomic flag to protect access to Tx/Rx shared memory area.
+ *	      Used when operating in atomic mode.
  * @func_id: smc/hvc call function id
  */
 
 struct scmi_smc {
 	struct scmi_chan_info *cinfo;
 	struct scmi_shared_mem __iomem *shmem;
+	/* Protect access to shmem area */
 	struct mutex shmem_lock;
+#define INFLIGHT_NONE	MSG_TOKEN_MAX
+	atomic_t inflight;
 	u32 func_id;
 };
 
@@ -54,6 +62,41 @@ static bool smc_chan_available(struct device *dev, int idx)
 	return true;
 }
 
+static inline void smc_channel_lock_init(struct scmi_smc *scmi_info)
+{
+	if (IS_ENABLED(CONFIG_ARM_SCMI_TRANSPORT_SMC_ATOMIC_ENABLE))
+		atomic_set(&scmi_info->inflight, INFLIGHT_NONE);
+	else
+		mutex_init(&scmi_info->shmem_lock);
+}
+
+static bool smc_xfer_inflight(struct scmi_xfer *xfer, atomic_t *inflight)
+{
+	int ret;
+
+	ret = atomic_cmpxchg(inflight, INFLIGHT_NONE, xfer->hdr.seq);
+
+	return ret == INFLIGHT_NONE;
+}
+
+static inline void
+smc_channel_lock_acquire(struct scmi_smc *scmi_info,
+			 struct scmi_xfer *xfer __maybe_unused)
+{
+	if (IS_ENABLED(CONFIG_ARM_SCMI_TRANSPORT_SMC_ATOMIC_ENABLE))
+		spin_until_cond(smc_xfer_inflight(xfer, &scmi_info->inflight));
+	else
+		mutex_lock(&scmi_info->shmem_lock);
+}
+
+static inline void smc_channel_lock_release(struct scmi_smc *scmi_info)
+{
+	if (IS_ENABLED(CONFIG_ARM_SCMI_TRANSPORT_SMC_ATOMIC_ENABLE))
+		atomic_set(&scmi_info->inflight, INFLIGHT_NONE);
+	else
+		mutex_unlock(&scmi_info->shmem_lock);
+}
+
 static int smc_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
 			  bool tx)
 {
@@ -114,7 +157,7 @@ static int smc_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
 
 	scmi_info->func_id = func_id;
 	scmi_info->cinfo = cinfo;
-	mutex_init(&scmi_info->shmem_lock);
+	smc_channel_lock_init(scmi_info);
 	cinfo->transport_info = scmi_info;
 
 	return 0;
@@ -140,10 +183,10 @@ static int smc_send_message(struct scmi_chan_info *cinfo,
 	struct arm_smccc_res res;
 
 	/*
-	 * Channel lock will be released only once response has been
+	 * Channel will be released only once response has been
 	 * surely fully retrieved, so after .mark_txdone()
 	 */
-	mutex_lock(&scmi_info->shmem_lock);
+	smc_channel_lock_acquire(scmi_info, xfer);
 
 	shmem_tx_prepare(scmi_info->shmem, xfer);
 
@@ -151,7 +194,7 @@ static int smc_send_message(struct scmi_chan_info *cinfo,
 
 	/* Only SMCCC_RET_NOT_SUPPORTED is valid error code */
 	if (res.a0) {
-		mutex_unlock(&scmi_info->shmem_lock);
+		smc_channel_lock_release(scmi_info);
 		return -EOPNOTSUPP;
 	}
 
@@ -170,7 +213,7 @@ static void smc_mark_txdone(struct scmi_chan_info *cinfo, int ret)
 {
 	struct scmi_smc *scmi_info = cinfo->transport_info;
 
-	mutex_unlock(&scmi_info->shmem_lock);
+	smc_channel_lock_release(scmi_info);
 }
 
 static const struct scmi_transport_ops scmi_smc_ops = {
@@ -196,4 +239,5 @@ const struct scmi_desc scmi_smc_desc = {
 	 * from the shared memory area.
 	 */
 	.sync_cmds_completed_on_ret = true,
+	.atomic_enabled = IS_ENABLED(CONFIG_ARM_SCMI_TRANSPORT_SMC_ATOMIC_ENABLE),
 };
-- 
2.17.1

