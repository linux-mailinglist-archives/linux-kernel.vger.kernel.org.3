Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEEC4A85F0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 15:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351116AbiBCONk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 09:13:40 -0500
Received: from mga03.intel.com ([134.134.136.65]:49619 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351048AbiBCON0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 09:13:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643897606; x=1675433606;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FXiOxaOrh0dPih67DbGldZ0HL4So6/uYQNMYCXn+8S4=;
  b=ZBetNqgNgEdBsu2vRJ0UeOgpTXQeTJuMEDLEXiwq41DGRwIT8Sio9Yy4
   ncAbpAXA6H15gPMJ2qqnob2NhXLOSk0NMCWoCDD5ob2jrbGw37mXa65Yg
   qJaMtcae45RbgkjROSzo/8vRxvkXi/oghBaGWfSW1V5jU8NLZjayU7wPp
   hA/xnPSD6gooE+RebC0SylxHegWb5kEGmM/CQlD5Mi6q6xx4TXPidaXbe
   UPUT5m+1KA2OOru48/CJdYpPSK3atnm0fx2KHjGk1LmqPoQpFBWR35y2h
   BwRqp4rkZCxTb0WhC2XDy8xtF9yCOEiw2uYKsztMznFuuctr/YRgH5NrN
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="248102392"
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="248102392"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 06:13:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="699324091"
Received: from silpixa00400294.ir.intel.com ([10.237.222.100])
  by orsmga005.jf.intel.com with ESMTP; 03 Feb 2022 06:13:12 -0800
From:   Wojciech Ziemba <wojciech.ziemba@intel.com>
To:     herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        qat-linux@intel.com, Wojciech Ziemba <wojciech.ziemba@intel.com>,
        Marcinx Malinowski <marcinx.malinowski@intel.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Marco Chiappero <marco.chiappero@intel.com>
Subject: [PATCH 3/3] crypto: qat - enable power management for QAT GEN4
Date:   Thu,  3 Feb 2022 13:54:34 +0000
Message-Id: <20220203135434.584967-4-wojciech.ziemba@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220203135434.584967-1-wojciech.ziemba@intel.com>
References: <20220203135434.584967-1-wojciech.ziemba@intel.com>
MIME-Version: 1.0
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 - Collinstown Industrial Park, Leixlip, County Kildare - Ireland
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for HW QAT Power Management (PM) feature.
This feature is enabled at init time (1) by sending an admin message to
the firmware, targeting the admin AE, that sets the idle time before
the device changes state and (2) by unmasking the PM source of interrupt
in ERRMSK2.

The interrupt handler is extended to handle a PM interrupt which
is triggered by HW when a PM transition occurs. In this case, the
driver responds acknowledging the transaction using the HOST_MSG
mailbox.

Signed-off-by: Wojciech Ziemba <wojciech.ziemba@intel.com>
Co-developed-by: Marcinx Malinowski <marcinx.malinowski@intel.com>
Signed-off-by: Marcinx Malinowski <marcinx.malinowski@intel.com>
Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Reviewed-by: Marco Chiappero <marco.chiappero@intel.com>
---
 .../crypto/qat/qat_4xxx/adf_4xxx_hw_data.c    |  15 +-
 .../crypto/qat/qat_4xxx/adf_4xxx_hw_data.h    |  10 --
 drivers/crypto/qat/qat_common/Makefile        |   1 +
 .../crypto/qat/qat_common/adf_accel_devices.h |   2 +
 drivers/crypto/qat/qat_common/adf_admin.c     |  37 +++++
 .../crypto/qat/qat_common/adf_common_drv.h    |   1 +
 drivers/crypto/qat/qat_common/adf_gen4_pm.c   | 137 ++++++++++++++++++
 drivers/crypto/qat/qat_common/adf_gen4_pm.h   |  44 ++++++
 drivers/crypto/qat/qat_common/adf_init.c      |   6 +
 drivers/crypto/qat/qat_common/adf_isr.c       |  14 ++
 .../qat/qat_common/icp_qat_fw_init_admin.h    |   1 +
 11 files changed, 252 insertions(+), 16 deletions(-)
 create mode 100644 drivers/crypto/qat/qat_common/adf_gen4_pm.c
 create mode 100644 drivers/crypto/qat/qat_common/adf_gen4_pm.h

diff --git a/drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.c b/drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.c
index f801d472819e..889cfaeef0f3 100644
--- a/drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.c
+++ b/drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.c
@@ -6,6 +6,7 @@
 #include <adf_common_drv.h>
 #include <adf_gen4_hw_data.h>
 #include <adf_gen4_pfvf.h>
+#include <adf_gen4_pm.h>
 #include "adf_4xxx_hw_data.h"
 #include "icp_qat_hw.h"
 
@@ -257,18 +258,18 @@ static int adf_init_device(struct adf_accel_dev *accel_dev)
 
 	/* Temporarily mask PM interrupt */
 	csr = ADF_CSR_RD(addr, ADF_GEN4_ERRMSK2);
-	csr |= ADF_4XXX_PM_SOU;
+	csr |= ADF_GEN4_PM_SOU;
 	ADF_CSR_WR(addr, ADF_GEN4_ERRMSK2, csr);
 
 	/* Set DRV_ACTIVE bit to power up the device */
-	ADF_CSR_WR(addr, ADF_4XXX_PM_INTERRUPT, ADF_4XXX_PM_DRV_ACTIVE);
+	ADF_CSR_WR(addr, ADF_GEN4_PM_INTERRUPT, ADF_GEN4_PM_DRV_ACTIVE);
 
 	/* Poll status register to make sure the device is powered up */
 	ret = read_poll_timeout(ADF_CSR_RD, status,
-				status & ADF_4XXX_PM_INIT_STATE,
-				ADF_4XXX_PM_POLL_DELAY_US,
-				ADF_4XXX_PM_POLL_TIMEOUT_US, true, addr,
-				ADF_4XXX_PM_STATUS);
+				status & ADF_GEN4_PM_INIT_STATE,
+				ADF_GEN4_PM_POLL_DELAY_US,
+				ADF_GEN4_PM_POLL_TIMEOUT_US, true, addr,
+				ADF_GEN4_PM_STATUS);
 	if (ret)
 		dev_err(&GET_DEV(accel_dev), "Failed to power up the device\n");
 
@@ -354,6 +355,8 @@ void adf_init_hw_data_4xxx(struct adf_hw_device_data *hw_data)
 	hw_data->set_ssm_wdtimer = adf_gen4_set_ssm_wdtimer;
 	hw_data->disable_iov = adf_disable_sriov;
 	hw_data->ring_pair_reset = adf_gen4_ring_pair_reset;
+	hw_data->init_pm = adf_gen4_init_pm;
+	hw_data->handle_pm_interrupt = adf_gen4_handle_pm_interrupt;
 
 	adf_gen4_init_hw_csr_ops(&hw_data->csr_ops);
 	adf_gen4_init_pf_pfvf_ops(&hw_data->pfvf_ops);
diff --git a/drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.h b/drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.h
index 857b93a3c032..1034752845ca 100644
--- a/drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.h
+++ b/drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.h
@@ -49,16 +49,6 @@
 #define ADF_4XXX_ADMINMSGLR_OFFSET	(0x500578)
 #define ADF_4XXX_MAILBOX_BASE_OFFSET	(0x600970)
 
-/* Power management */
-#define ADF_4XXX_PM_POLL_DELAY_US	20
-#define ADF_4XXX_PM_POLL_TIMEOUT_US	USEC_PER_SEC
-#define ADF_4XXX_PM_STATUS		(0x50A00C)
-#define ADF_4XXX_PM_INTERRUPT		(0x50A028)
-#define ADF_4XXX_PM_DRV_ACTIVE		BIT(20)
-#define ADF_4XXX_PM_INIT_STATE		BIT(21)
-/* Power management source in ERRSOU2 and ERRMSK2 */
-#define ADF_4XXX_PM_SOU			BIT(18)
-
 /* Firmware Binaries */
 #define ADF_4XXX_FW		"qat_4xxx.bin"
 #define ADF_4XXX_MMP		"qat_4xxx_mmp.bin"
diff --git a/drivers/crypto/qat/qat_common/Makefile b/drivers/crypto/qat/qat_common/Makefile
index 7e191a42a5c7..f25a6c8edfc7 100644
--- a/drivers/crypto/qat/qat_common/Makefile
+++ b/drivers/crypto/qat/qat_common/Makefile
@@ -12,6 +12,7 @@ intel_qat-objs := adf_cfg.o \
 	adf_hw_arbiter.o \
 	adf_gen2_hw_data.o \
 	adf_gen4_hw_data.o \
+	adf_gen4_pm.o \
 	qat_crypto.o \
 	qat_algs.o \
 	qat_asym_algs.o \
diff --git a/drivers/crypto/qat/qat_common/adf_accel_devices.h b/drivers/crypto/qat/qat_common/adf_accel_devices.h
index 2d4cd7c7cf33..f1c5a6ac7d95 100644
--- a/drivers/crypto/qat/qat_common/adf_accel_devices.h
+++ b/drivers/crypto/qat/qat_common/adf_accel_devices.h
@@ -184,6 +184,8 @@ struct adf_hw_device_data {
 	void (*exit_arb)(struct adf_accel_dev *accel_dev);
 	const u32 *(*get_arb_mapping)(void);
 	int (*init_device)(struct adf_accel_dev *accel_dev);
+	int (*init_pm)(struct adf_accel_dev *accel_dev);
+	bool (*handle_pm_interrupt)(struct adf_accel_dev *accel_dev);
 	void (*disable_iov)(struct adf_accel_dev *accel_dev);
 	void (*configure_iov_threads)(struct adf_accel_dev *accel_dev,
 				      bool enable);
diff --git a/drivers/crypto/qat/qat_common/adf_admin.c b/drivers/crypto/qat/qat_common/adf_admin.c
index 498eb6f690e3..3b6184c35081 100644
--- a/drivers/crypto/qat/qat_common/adf_admin.c
+++ b/drivers/crypto/qat/qat_common/adf_admin.c
@@ -251,6 +251,43 @@ int adf_send_admin_init(struct adf_accel_dev *accel_dev)
 }
 EXPORT_SYMBOL_GPL(adf_send_admin_init);
 
+/**
+ * adf_init_admin_pm() - Function sends PM init message to FW
+ * @accel_dev: Pointer to acceleration device.
+ * @idle_delay: QAT HW idle time before power gating is initiated.
+ *		000 - 64us
+ *		001 - 128us
+ *		010 - 256us
+ *		011 - 512us
+ *		100 - 1ms
+ *		101 - 2ms
+ *		110 - 4ms
+ *		111 - 8ms
+ *
+ * Function sends to the FW the admin init message for the PM state
+ * configuration.
+ *
+ * Return: 0 on success, error code otherwise.
+ */
+int adf_init_admin_pm(struct adf_accel_dev *accel_dev, u32 idle_delay)
+{
+	struct adf_hw_device_data *hw_data = accel_dev->hw_device;
+	struct icp_qat_fw_init_admin_resp resp = {0};
+	struct icp_qat_fw_init_admin_req req = {0};
+	u32 ae_mask = hw_data->admin_ae_mask;
+
+	if (!accel_dev->admin) {
+		dev_err(&GET_DEV(accel_dev), "adf_admin is not available\n");
+		return -EFAULT;
+	}
+
+	req.cmd_id = ICP_QAT_FW_PM_STATE_CONFIG;
+	req.idle_filter = idle_delay;
+
+	return adf_send_admin(accel_dev, &req, &resp, ae_mask);
+}
+EXPORT_SYMBOL_GPL(adf_init_admin_pm);
+
 int adf_init_admin_comms(struct adf_accel_dev *accel_dev)
 {
 	struct adf_admin_comms *admin;
diff --git a/drivers/crypto/qat/qat_common/adf_common_drv.h b/drivers/crypto/qat/qat_common/adf_common_drv.h
index 077549176879..e8c9b77c0d66 100644
--- a/drivers/crypto/qat/qat_common/adf_common_drv.h
+++ b/drivers/crypto/qat/qat_common/adf_common_drv.h
@@ -102,6 +102,7 @@ void adf_exit_aer(void);
 int adf_init_admin_comms(struct adf_accel_dev *accel_dev);
 void adf_exit_admin_comms(struct adf_accel_dev *accel_dev);
 int adf_send_admin_init(struct adf_accel_dev *accel_dev);
+int adf_init_admin_pm(struct adf_accel_dev *accel_dev, u32 idle_delay);
 int adf_init_arb(struct adf_accel_dev *accel_dev);
 void adf_exit_arb(struct adf_accel_dev *accel_dev);
 void adf_update_ring_arb(struct adf_etr_ring_data *ring);
diff --git a/drivers/crypto/qat/qat_common/adf_gen4_pm.c b/drivers/crypto/qat/qat_common/adf_gen4_pm.c
new file mode 100644
index 000000000000..16b0396fe457
--- /dev/null
+++ b/drivers/crypto/qat/qat_common/adf_gen4_pm.c
@@ -0,0 +1,137 @@
+// SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only)
+/* Copyright(c) 2022 Intel Corporation */
+#include <linux/bitfield.h>
+#include <linux/iopoll.h>
+#include "adf_accel_devices.h"
+#include "adf_common_drv.h"
+#include "adf_gen4_pm.h"
+#include "adf_cfg_strings.h"
+#include "icp_qat_fw_init_admin.h"
+#include "adf_gen4_hw_data.h"
+#include "adf_cfg.h"
+
+enum qat_pm_host_msg {
+	PM_NO_CHANGE = 0,
+	PM_SET_MIN,
+};
+
+struct adf_gen4_pm_data {
+	struct work_struct pm_irq_work;
+	struct adf_accel_dev *accel_dev;
+	u32 pm_int_sts;
+};
+
+static int send_host_msg(struct adf_accel_dev *accel_dev)
+{
+	void __iomem *pmisc = adf_get_pmisc_base(accel_dev);
+	u32 msg;
+
+	msg = ADF_CSR_RD(pmisc, ADF_GEN4_PM_HOST_MSG);
+	if (msg & ADF_GEN4_PM_MSG_PENDING)
+		return -EBUSY;
+
+	/* Send HOST_MSG */
+	msg = FIELD_PREP(ADF_GEN4_PM_MSG_PAYLOAD_BIT_MASK, PM_SET_MIN);
+	msg |= ADF_GEN4_PM_MSG_PENDING;
+	ADF_CSR_WR(pmisc, ADF_GEN4_PM_HOST_MSG, msg);
+
+	/* Poll status register to make sure the HOST_MSG has been processed */
+	return read_poll_timeout(ADF_CSR_RD, msg,
+				!(msg & ADF_GEN4_PM_MSG_PENDING),
+				ADF_GEN4_PM_MSG_POLL_DELAY_US,
+				ADF_GEN4_PM_POLL_TIMEOUT_US, true, pmisc,
+				ADF_GEN4_PM_HOST_MSG);
+}
+
+static void pm_bh_handler(struct work_struct *work)
+{
+	struct adf_gen4_pm_data *pm_data =
+		container_of(work, struct adf_gen4_pm_data, pm_irq_work);
+	struct adf_accel_dev *accel_dev = pm_data->accel_dev;
+	void __iomem *pmisc = adf_get_pmisc_base(accel_dev);
+	u32 pm_int_sts = pm_data->pm_int_sts;
+	u32 val;
+
+	/* PM Idle interrupt */
+	if (pm_int_sts & ADF_GEN4_PM_IDLE_STS) {
+		/* Issue host message to FW */
+		if (send_host_msg(accel_dev))
+			dev_warn_ratelimited(&GET_DEV(accel_dev),
+					     "Failed to send host msg to FW\n");
+	}
+
+	/* Clear interrupt status */
+	ADF_CSR_WR(pmisc, ADF_GEN4_PM_INTERRUPT, pm_int_sts);
+
+	/* Reenable PM interrupt */
+	val = ADF_CSR_RD(pmisc, ADF_GEN4_ERRMSK2);
+	val &= ~ADF_GEN4_PM_SOU;
+	ADF_CSR_WR(pmisc, ADF_GEN4_ERRMSK2, val);
+
+	kfree(pm_data);
+}
+
+bool adf_gen4_handle_pm_interrupt(struct adf_accel_dev *accel_dev)
+{
+	void __iomem *pmisc = adf_get_pmisc_base(accel_dev);
+	struct adf_gen4_pm_data *pm_data = NULL;
+	u32 errsou2;
+	u32 errmsk2;
+	u32 val;
+
+	/* Only handle the interrupt triggered by PM */
+	errmsk2 = ADF_CSR_RD(pmisc, ADF_GEN4_ERRMSK2);
+	if (errmsk2 & ADF_GEN4_PM_SOU)
+		return false;
+
+	errsou2 = ADF_CSR_RD(pmisc, ADF_GEN4_ERRSOU2);
+	if (!(errsou2 & ADF_GEN4_PM_SOU))
+		return false;
+
+	/* Disable interrupt */
+	val = ADF_CSR_RD(pmisc, ADF_GEN4_ERRMSK2);
+	val |= ADF_GEN4_PM_SOU;
+	ADF_CSR_WR(pmisc, ADF_GEN4_ERRMSK2, val);
+
+	val = ADF_CSR_RD(pmisc, ADF_GEN4_PM_INTERRUPT);
+
+	pm_data = kzalloc(sizeof(*pm_data), GFP_ATOMIC);
+	if (!pm_data)
+		return false;
+
+	pm_data->pm_int_sts = val;
+	pm_data->accel_dev = accel_dev;
+
+	INIT_WORK(&pm_data->pm_irq_work, pm_bh_handler);
+	adf_misc_wq_queue_work(&pm_data->pm_irq_work);
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(adf_gen4_handle_pm_interrupt);
+
+int adf_gen4_init_pm(struct adf_accel_dev *accel_dev)
+{
+	void __iomem *pmisc = adf_get_pmisc_base(accel_dev);
+	int ret;
+	u32 val;
+
+	ret = adf_init_admin_pm(accel_dev, ADF_GEN4_PM_DEFAULT_IDLE_FILTER);
+	if (ret)
+		return ret;
+
+	/* Enable PM Interrupt */
+	val = ADF_CSR_RD(pmisc, ADF_GEN4_ERRMSK2);
+	val &= ~ADF_GEN4_PM_SOU;
+	ADF_CSR_WR(pmisc, ADF_GEN4_ERRMSK2, val);
+
+	/* Enable default PM interrupts: IDLE, THROTTLE */
+	val = ADF_CSR_RD(pmisc, ADF_GEN4_PM_INTERRUPT);
+	val |= ADF_GEN4_PM_INT_EN_DEFAULT;
+
+	/* Clear interrupt status */
+	val |= ADF_GEN4_PM_INT_STS_MASK;
+	ADF_CSR_WR(pmisc, ADF_GEN4_PM_INTERRUPT, val);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(adf_gen4_init_pm);
diff --git a/drivers/crypto/qat/qat_common/adf_gen4_pm.h b/drivers/crypto/qat/qat_common/adf_gen4_pm.h
new file mode 100644
index 000000000000..44beb4ae0d68
--- /dev/null
+++ b/drivers/crypto/qat/qat_common/adf_gen4_pm.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only) */
+/* Copyright(c) 2022 Intel Corporation */
+#ifndef ADF_GEN4_PM_H
+#define ADF_GEN4_PM_H
+
+#include "adf_accel_devices.h"
+
+/* Power management registers */
+#define ADF_GEN4_PM_HOST_MSG (0x50A01C)
+
+/* Power management */
+#define ADF_GEN4_PM_POLL_DELAY_US	20
+#define ADF_GEN4_PM_POLL_TIMEOUT_US	USEC_PER_SEC
+#define ADF_GEN4_PM_MSG_POLL_DELAY_US	(10 * USEC_PER_MSEC)
+#define ADF_GEN4_PM_STATUS		(0x50A00C)
+#define ADF_GEN4_PM_INTERRUPT		(0x50A028)
+
+/* Power management source in ERRSOU2 and ERRMSK2 */
+#define ADF_GEN4_PM_SOU			BIT(18)
+
+#define ADF_GEN4_PM_IDLE_INT_EN		BIT(18)
+#define ADF_GEN4_PM_THROTTLE_INT_EN	BIT(19)
+#define ADF_GEN4_PM_DRV_ACTIVE		BIT(20)
+#define ADF_GEN4_PM_INIT_STATE		BIT(21)
+#define ADF_GEN4_PM_INT_EN_DEFAULT	(ADF_GEN4_PM_IDLE_INT_EN | \
+					ADF_GEN4_PM_THROTTLE_INT_EN)
+
+#define ADF_GEN4_PM_THR_STS	BIT(0)
+#define ADF_GEN4_PM_IDLE_STS	BIT(1)
+#define ADF_GEN4_PM_FW_INT_STS	BIT(2)
+#define ADF_GEN4_PM_INT_STS_MASK (ADF_GEN4_PM_THR_STS | \
+				 ADF_GEN4_PM_IDLE_STS | \
+				 ADF_GEN4_PM_FW_INT_STS)
+
+#define ADF_GEN4_PM_MSG_PENDING			BIT(0)
+#define ADF_GEN4_PM_MSG_PAYLOAD_BIT_MASK	GENMASK(28, 1)
+
+#define ADF_GEN4_PM_DEFAULT_IDLE_FILTER		(0x0)
+#define ADF_GEN4_PM_MAX_IDLE_FILTER		(0x7)
+
+int adf_gen4_init_pm(struct adf_accel_dev *accel_dev);
+bool adf_gen4_handle_pm_interrupt(struct adf_accel_dev *accel_dev);
+
+#endif
diff --git a/drivers/crypto/qat/qat_common/adf_init.c b/drivers/crypto/qat/qat_common/adf_init.c
index 2edc63c6b6ca..0545e1854032 100644
--- a/drivers/crypto/qat/qat_common/adf_init.c
+++ b/drivers/crypto/qat/qat_common/adf_init.c
@@ -181,6 +181,12 @@ int adf_dev_start(struct adf_accel_dev *accel_dev)
 	if (hw_data->set_ssm_wdtimer)
 		hw_data->set_ssm_wdtimer(accel_dev);
 
+	/* Initialize Power Management */
+	if (hw_data->init_pm && hw_data->init_pm(accel_dev)) {
+		dev_err(&GET_DEV(accel_dev), "Failed to configure Power Management\n");
+		return -EFAULT;
+	}
+
 	list_for_each(list_itr, &service_table) {
 		service = list_entry(list_itr, struct service_hndl, list);
 		if (service->event_hld(accel_dev, ADF_EVENT_START)) {
diff --git a/drivers/crypto/qat/qat_common/adf_isr.c b/drivers/crypto/qat/qat_common/adf_isr.c
index 803b89ba9670..dfebc3634be7 100644
--- a/drivers/crypto/qat/qat_common/adf_isr.c
+++ b/drivers/crypto/qat/qat_common/adf_isr.c
@@ -86,6 +86,17 @@ static void adf_disable_vf2pf_interrupts_irq(struct adf_accel_dev *accel_dev,
 	spin_unlock(&accel_dev->pf.vf2pf_ints_lock);
 }
 
+static bool adf_handle_pm_int(struct adf_accel_dev *accel_dev)
+{
+	struct adf_hw_device_data *hw_data = accel_dev->hw_device;
+
+	if (hw_data->handle_pm_interrupt &&
+	    hw_data->handle_pm_interrupt(accel_dev))
+		return true;
+
+	return false;
+}
+
 static bool adf_handle_vf2pf_int(struct adf_accel_dev *accel_dev)
 {
 	void __iomem *pmisc_addr = adf_get_pmisc_base(accel_dev);
@@ -134,6 +145,9 @@ static irqreturn_t adf_msix_isr_ae(int irq, void *dev_ptr)
 		return IRQ_HANDLED;
 #endif /* CONFIG_PCI_IOV */
 
+	if (adf_handle_pm_int(accel_dev))
+		return IRQ_HANDLED;
+
 	dev_dbg(&GET_DEV(accel_dev), "qat_dev%d spurious AE interrupt\n",
 		accel_dev->accel_id);
 
diff --git a/drivers/crypto/qat/qat_common/icp_qat_fw_init_admin.h b/drivers/crypto/qat/qat_common/icp_qat_fw_init_admin.h
index afe59a7684ac..56cb827f93ea 100644
--- a/drivers/crypto/qat/qat_common/icp_qat_fw_init_admin.h
+++ b/drivers/crypto/qat/qat_common/icp_qat_fw_init_admin.h
@@ -16,6 +16,7 @@ enum icp_qat_fw_init_admin_cmd_id {
 	ICP_QAT_FW_HEARTBEAT_SYNC = 7,
 	ICP_QAT_FW_HEARTBEAT_GET = 8,
 	ICP_QAT_FW_COMP_CAPABILITY_GET = 9,
+	ICP_QAT_FW_PM_STATE_CONFIG = 128,
 };
 
 enum icp_qat_fw_init_admin_resp_status {
-- 
2.29.2

--------------------------------------------------------------
Intel Research and Development Ireland Limited
Registered in Ireland
Registered Office: Collinstown Industrial Park, Leixlip, County Kildare
Registered Number: 308263


This e-mail and any attachments may contain confidential material for the sole
use of the intended recipient(s). Any review or distribution by others is
strictly prohibited. If you are not the intended recipient, please contact the
sender and delete all copies.

