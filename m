Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546FE59F59F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 10:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235327AbiHXIrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 04:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236032AbiHXIrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 04:47:17 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9991576774;
        Wed, 24 Aug 2022 01:47:12 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id t11-20020a17090a510b00b001fac77e9d1fso866383pjh.5;
        Wed, 24 Aug 2022 01:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=b0pFRD9mxsl5hLkCSSmCXF0GcEO6O2awge1yX4YVaF4=;
        b=SOLflBybMwio6q8GHZvwygFWgzzjrD1KPz+r/P/K41dSQao64LkUBUa6UgX805ebBQ
         CcziSxbt0RJOHTKopzshNmTEVkS4kRNn2I3ugHiov46rl2Do8B/vZEXEJ0g3XUNxVc4H
         EdTGAHH3NyBVLo0mr2SQv05gf9L8QpcmU2x9H+5gdoueEGlDEc0RDZ+5P+aEoY+7B3op
         NIPfB71oBVoL4nH5K1VpZ3DP656Bqrlnmx0WUI80rGDdIngOioNTE5PQztip23grNJah
         EYjb7Er3tYTB58cQJc9VMJvwJvRjZRJA7KhCNsmZWYe4ikc+ZDGOgN7YOuF3/yEs0tMn
         hZjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=b0pFRD9mxsl5hLkCSSmCXF0GcEO6O2awge1yX4YVaF4=;
        b=O1UQrTLp+3dl0B0lV40WLcTyz+yuAIE7yHZcMB/p7twXgGRLeSbS4BPeyT6zG3NOzQ
         2/mIaw9p7kmZdWjNRdFWOwyGNCQMI+AdRazBkjoaDUwSzTEw3JmSSSujrPtFHuQxAz63
         D7JGd978DXBzBHZEv98dN78WA1ev1suGByy1dZTjhvAKlv+GKB0aZT0RpJWjfZxUG2qi
         OdIT02gu5sy68dVtZkUiiIwGoWoeWOeha/lnsNqcTQqz6tz2zXKdFOtMT6wcMhdqDg9/
         +zhUgTc2k9RWSzgE/vzsXAgVXd4/aPdmfHDEbGoSlC99v1YFtjiJBK8tjlC2OjSJqVkD
         4tpQ==
X-Gm-Message-State: ACgBeo3MOmYF2t+vLHeLMOT+oZgkGt/ULWi6YtR9DBvoaLbMYpA5DWax
        dhcfZpocIEDJP5aesgloIlI=
X-Google-Smtp-Source: AA6agR4ypUSmHZtzPUHD71LSSvgseKlYqI0HlA/qj9L2Jk95oVVKTaVHmS98hQRv267EDiYEyPhkIg==
X-Received: by 2002:a17:902:cecc:b0:172:e225:291 with SMTP id d12-20020a170902cecc00b00172e2250291mr14732700plg.96.1661330831594;
        Wed, 24 Aug 2022 01:47:11 -0700 (PDT)
Received: from ubuntu18.mioffice.cn ([2408:8607:1b00:7:9e7b:efff:fe41:a22a])
        by smtp.gmail.com with ESMTPSA id j1-20020a170902da8100b0016be596c8afsm12097599plx.282.2022.08.24.01.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 01:47:10 -0700 (PDT)
From:   Jiaming Li <lijiamingsofine@gmail.com>
To:     avri.altman@wdc.com, alim.akhtar@samsung.com, jejb@linux.ibm.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        lijiaming3 <lijiaming3@xiaomi.com>
Subject: [PATCH] scsi: ufs: ufsfbo: Introduce File Based Optimization feature
Date:   Wed, 24 Aug 2022 16:46:33 +0800
Message-Id: <20220824084633.14428-1-lijiamingsofine@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: lijiaming3 <lijiaming3@xiaomi.com>

Implement File Based Optimization initialization and add sysfs
interface.

Stoage devices have a long lifespan. Device performance over its
lifespan is not constant and may deteriorate over time

This feature describes a method to improve the performance regression.
The host needs to provide File System information to storage device
first. Based on that information device analyzes the file system data
and provides the host the level of performance regression. The host
then may instruct the device to execute optimization procedure to
improve the regression level.

Signed-off-by: lijiaming3 <lijiaming3@xiaomi.com>
---
 arch/arm64/configs/defconfig |    1 +
 drivers/scsi/ufs/Kconfig     |    9 +
 drivers/scsi/ufs/Makefile    |    1 +
 drivers/scsi/ufs/ufs.h       |   13 +
 drivers/scsi/ufs/ufsfbo.c    | 1007 ++++++++++++++++++++++++++++++++++
 drivers/scsi/ufs/ufsfbo.h    |  143 +++++
 drivers/scsi/ufs/ufshcd.c    |   15 +
 drivers/scsi/ufs/ufshcd.h    |    7 +-
 8 files changed, 1195 insertions(+), 1 deletion(-)
 create mode 100644 drivers/scsi/ufs/ufsfbo.c
 create mode 100644 drivers/scsi/ufs/ufsfbo.h

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 4972a81d40d6..1363c237b6f3 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -289,6 +289,7 @@ CONFIG_SCSI_UFSHCD_PLATFORM=y
 CONFIG_SCSI_UFS_QCOM=m
 CONFIG_SCSI_UFS_HISI=y
 CONFIG_SCSI_UFS_EXYNOS=y
+CONFIG_SCSI_UFS_FBO=y
 CONFIG_ATA=y
 CONFIG_SATA_AHCI=y
 CONFIG_SATA_AHCI_PLATFORM=y
diff --git a/drivers/scsi/ufs/Kconfig b/drivers/scsi/ufs/Kconfig
index 432df76e6318..57b0e8b14543 100644
--- a/drivers/scsi/ufs/Kconfig
+++ b/drivers/scsi/ufs/Kconfig
@@ -199,3 +199,12 @@ config SCSI_UFS_FAULT_INJECTION
 	help
 	  Enable fault injection support in the UFS driver. This makes it easier
 	  to test the UFS error handler and abort handler.
+
+config SCSI_UFS_FBO
+	bool "Support UFS File-based Optimization"
+	depends on SCSI_UFSHCD
+	help
+	 The UFS FBO feature improves Sequential read performance. The Host can
+	 send the LBA to device. The device will return a fragmented state. It
+	 is up to the host to decide whether to defrag. After defragment,
+	 Sequential read performance is improved
\ No newline at end of file
diff --git a/drivers/scsi/ufs/Makefile b/drivers/scsi/ufs/Makefile
index c407da9b5171..956be0738263 100644
--- a/drivers/scsi/ufs/Makefile
+++ b/drivers/scsi/ufs/Makefile
@@ -9,6 +9,7 @@ ufshcd-core-$(CONFIG_DEBUG_FS)		+= ufs-debugfs.o
 ufshcd-core-$(CONFIG_SCSI_UFS_BSG)	+= ufs_bsg.o
 ufshcd-core-$(CONFIG_SCSI_UFS_CRYPTO)	+= ufshcd-crypto.o
 ufshcd-core-$(CONFIG_SCSI_UFS_HPB)	+= ufshpb.o
+ufshcd-core-$(CONFIG_SCSI_UFS_FBO)	+= ufsfbo.o
 ufshcd-core-$(CONFIG_SCSI_UFS_FAULT_INJECTION) += ufs-fault-injection.o
 
 obj-$(CONFIG_SCSI_UFS_DWC_TC_PCI) += tc-dwc-g210-pci.o ufshcd-dwc.o tc-dwc-g210.o
diff --git a/drivers/scsi/ufs/ufs.h b/drivers/scsi/ufs/ufs.h
index 8c6b38b1b142..b750ce3f7de9 100644
--- a/drivers/scsi/ufs/ufs.h
+++ b/drivers/scsi/ufs/ufs.h
@@ -170,6 +170,7 @@ enum desc_idn {
 	QUERY_DESC_IDN_GEOMETRY		= 0x7,
 	QUERY_DESC_IDN_POWER		= 0x8,
 	QUERY_DESC_IDN_HEALTH           = 0x9,
+	QUERY_DESC_IDN_FBO          = 0xA,
 	QUERY_DESC_IDN_MAX,
 };
 
@@ -310,6 +311,17 @@ enum health_desc_param {
 	HEALTH_DESC_PARAM_LIFE_TIME_EST_B	= 0x4,
 };
 
+/* FBO descriptor parameters offsets in bytes */
+enum fbo_desc_param {
+	FBO_DESC_PARAM_LEN	= 0x0,
+	FBO_DESC_PARAM_VERSION	= 0x1,
+	FBO_DESC_PARAM_REC_LBA_RANGE_SIZE	= 0x3,
+	FBO_DESC_PARAM_MAX_LBA_RANGE_SIZE	= 0x7,
+	FBO_DESC_PARAM_MIN_LBA_RANGE_SIZE	= 0xB,
+	FBO_DESC_PARAM_MAX_LBA_RANGE_CONUT	= 0xF,
+	FBO_DESC_PARAM_MAX_LBA_RANGE_ALIGNMENT	= 0x10,
+};
+
 /* WriteBooster buffer mode */
 enum {
 	WB_BUF_MODE_LU_DEDICATED	= 0x0,
@@ -340,6 +352,7 @@ enum {
 enum {
 	UFS_DEV_HPB_SUPPORT		= BIT(7),
 	UFS_DEV_WRITE_BOOSTER_SUP	= BIT(8),
+	UFS_DEV_FBO_SUP			= BIT(17),
 };
 #define UFS_DEV_HPB_SUPPORT_VERSION		0x310
 
diff --git a/drivers/scsi/ufs/ufsfbo.c b/drivers/scsi/ufs/ufsfbo.c
new file mode 100644
index 000000000000..bc8fba152c6e
--- /dev/null
+++ b/drivers/scsi/ufs/ufsfbo.c
@@ -0,0 +1,1007 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Universal Flash Storage File-based Optimization
+ *
+ * Copyright (C) 2022 Xiaomi Mobile Software Co., Ltd
+ *
+ * Authors:
+ *		lijiaming <lijiaming3@xiaomi.com>
+ */
+
+#include <linux/pm_runtime.h>
+#include "ufsfbo.h"
+#include "ufshcd.h"
+#include "ufs.h"
+#include "ufs-qcom.h"
+
+static int ufsfbo_create_sysfs(struct ufsfbo_dev *fbo);
+
+static int ufsfbo_read_desc(struct ufs_hba *hba, u8 desc_id, u8 desc_index,
+			u8 selector, u8 *desc_buf, u32 size)
+{
+	int ret = 0;
+
+	ufshcd_rpm_get_sync(hba);
+
+	ret = ufshcd_query_descriptor_retry(hba, UPIU_QUERY_OPCODE_READ_DESC,
+					    desc_id, desc_index,
+					    selector,
+					    desc_buf, &size);
+
+	if (ret)
+		FBO_ERR_MSG("read desc [0x%.2X] failed. (%d)", desc_id, ret);
+
+	pm_runtime_put_noidle(&hba->sdev_ufs_device->sdev_gendev);
+	return ret;
+}
+
+static int ufsfbo_query_attr(struct ufs_hba *hba, enum query_opcode opcode, u8 idn,
+			u8 idx, u8 selector, u32 *attr_val)
+{
+	int ret = 0;
+
+	ufshcd_rpm_get_sync(hba);
+
+	ret = ufshcd_query_attr_retry(hba, opcode, idn, idx,
+				      selector, attr_val);
+	if (ret)
+		FBO_ERR_MSG("query attr [0x%.2X] failed. opcode(%d) (%d)", idn, opcode, ret);
+
+	pm_runtime_put_noidle(&hba->sdev_ufs_device->sdev_gendev);
+	return ret;
+}
+
+int ufsfbo_is_not_present(struct ufsfbo_dev *fbo)
+{
+	enum UFSFBO_STATE cur_state = ufsfbo_get_state(fbo->hba);
+
+	if (cur_state != FBO_PRESENT) {
+		FBO_INFO_MSG(fbo, "fbo_state != fbo_PRESENT (%d)", cur_state);
+		return -ENODEV;
+	}
+	return 0;
+}
+
+inline int ufsfbo_get_state(struct ufs_hba *hba)
+{
+	return atomic_read(&hba->fbo.fbo_state);
+}
+
+inline void ufsfbo_set_state(struct ufs_hba *hba, int state)
+{
+	atomic_set(&hba->fbo.fbo_state, state);
+}
+
+int ufsfbo_operation_control(struct ufsfbo_dev *fbo, int *val)
+{
+	int ret = 0;
+	struct ufs_hba *hba = fbo->hba;
+
+	ret = ufsfbo_query_attr(hba, UPIU_QUERY_OPCODE_WRITE_ATTR,
+			(enum attr_idn)QUERY_ATTR_IDN_FBO_CONTROL, 0, 0, val);
+	if (ret)
+		FBO_ERR_MSG("query fbo control attr failed. ret(%d)", ret);
+	return ret;
+}
+
+static void ufsfbo_scsi_unblock_requests(struct ufs_hba *hba)
+{
+	if (atomic_dec_and_test(&hba->scsi_block_reqs_cnt))
+		scsi_unblock_requests(hba->host);
+}
+
+static void ufsfbo_scsi_block_requests(struct ufs_hba *hba)
+{
+	if (atomic_inc_return(&hba->scsi_block_reqs_cnt) == 1)
+		scsi_block_requests(hba->host);
+}
+
+static int ufsfbo_wait_for_doorbell_clr(struct ufs_hba *hba,
+					u64 wait_timeout_us)
+{
+	unsigned long flags;
+	int ret = 0;
+	u32 tm_doorbell;
+	u32 tr_doorbell;
+	bool timeout = false, do_last_check = false;
+	ktime_t start;
+
+	ufshcd_hold(hba, false);
+	spin_lock_irqsave(hba->host->host_lock, flags);
+	/*
+	 * Wait for all the outstanding tasks/transfer requests.
+	 * Verify by checking the doorbell registers are clear.
+	 */
+	start = ktime_get();
+	do {
+		if (hba->ufshcd_state != UFSHCD_STATE_OPERATIONAL) {
+			ret = -EBUSY;
+			goto out;
+		}
+		tm_doorbell = ufshcd_readl(hba, REG_UTP_TASK_REQ_DOOR_BELL);
+		tr_doorbell = ufshcd_readl(hba, REG_UTP_TRANSFER_REQ_DOOR_BELL);
+		if (!tm_doorbell && !tr_doorbell) {
+			timeout = false;
+			break;
+		} else if (do_last_check) {
+			break;
+		}
+		spin_unlock_irqrestore(hba->host->host_lock, flags);
+		schedule();
+		if (ktime_to_us(ktime_sub(ktime_get(), start)) >
+		    wait_timeout_us) {
+			timeout = true;
+			/*
+			 * We might have scheduled out for long time so make
+			 * sure to check if doorbells are cleared by this time
+			 * or not.
+			 */
+			do_last_check = true;
+		}
+		spin_lock_irqsave(hba->host->host_lock, flags);
+	} while (tm_doorbell || tr_doorbell);
+	if (timeout) {
+		dev_err(hba->dev,
+			"%s: timedout waiting for doorbell to clear (tm=0x%x, tr=0x%x)\n",
+			__func__, tm_doorbell, tr_doorbell);
+		ret = -EBUSY;
+	}
+out:
+	spin_unlock_irqrestore(hba->host->host_lock, flags);
+	ufshcd_release(hba);
+	return ret;
+}
+
+void ufsfbo_auto_hibern8_enable(struct ufsfbo_dev *fbo,
+				       unsigned int val)
+{
+	struct ufs_hba *hba = fbo->hba;
+	unsigned long flags;
+	u32 reg;
+
+	val = !!val;
+	/* Update auto hibern8 timer value if supported */
+	if (!ufshcd_is_auto_hibern8_supported(hba))
+		return;
+	ufshcd_rpm_get_sync(hba);
+	ufshcd_hold(hba, false);
+	down_write(&hba->clk_scaling_lock);
+	ufsfbo_scsi_block_requests(hba);
+	/* wait for all the outstanding requests to finish */
+	ufsfbo_wait_for_doorbell_clr(hba, U64_MAX);
+	spin_lock_irqsave(hba->host->host_lock, flags);
+	reg = ufshcd_readl(hba, REG_AUTO_HIBERNATE_IDLE_TIMER);
+
+	if (val ^ (reg != 0)) {
+		if (val) {
+			hba->ahit = fbo->ahit;
+		} else {
+			/*
+			 * Store current ahit value.
+			 * We don't know who set the ahit value to different
+			 * from the initial value
+			 */
+			fbo->ahit = reg;
+			hba->ahit = 0;
+		}
+		ufshcd_writel(hba, hba->ahit, REG_AUTO_HIBERNATE_IDLE_TIMER);
+		/* Make sure the timer gets applied before further operations */
+		mb();
+
+		fbo->is_auto_enabled = val;
+		reg = ufshcd_readl(hba, REG_AUTO_HIBERNATE_IDLE_TIMER);
+	} else {
+		FBO_INFO_MSG(fbo, "is_auto_enabled:%d. so it does not changed",
+			 fbo->is_auto_enabled);
+	}
+	spin_unlock_irqrestore(hba->host->host_lock, flags);
+	ufsfbo_scsi_unblock_requests(hba);
+	up_write(&hba->clk_scaling_lock);
+	ufshcd_release(hba);
+	pm_runtime_put_noidle(&hba->sdev_ufs_device->sdev_gendev);
+}
+
+void ufsfbo_block_enter_suspend(struct ufsfbo_dev *fbo)
+{
+	struct ufs_hba *hba = fbo->hba;
+	unsigned long flags;
+
+	if (unlikely(fbo->block_suspend))
+		return;
+	fbo->block_suspend = true;
+	ufshcd_rpm_get_sync(hba);
+	ufshcd_hold(hba, false);
+	spin_lock_irqsave(hba->host->host_lock, flags);
+	FBO_INFO_MSG(fbo, "power.usage_count:%d,clk_gating.active_reqs:%d",
+		  atomic_read(&hba->dev->power.usage_count),
+		  hba->clk_gating.active_reqs);
+	spin_unlock_irqrestore(hba->host->host_lock, flags);
+}
+
+void ufsfbo_allow_enter_suspend(struct ufsfbo_dev *fbo)
+{
+	struct ufs_hba *hba = fbo->hba;
+	unsigned long flags;
+
+	if (unlikely(!fbo->block_suspend))
+		return;
+	fbo->block_suspend = false;
+	ufshcd_release(hba);
+	pm_runtime_put_noidle(&hba->sdev_ufs_device->sdev_gendev);
+	spin_lock_irqsave(hba->host->host_lock, flags);
+	FBO_INFO_MSG(fbo, "power.usage_count:%d,clk_gating.active_reqs:%d",
+		  atomic_read(&hba->dev->power.usage_count),
+		  hba->clk_gating.active_reqs);
+	spin_unlock_irqrestore(hba->host->host_lock, flags);
+}
+
+int ufsfbo_get_exe_level(struct ufsfbo_dev *fbo, int *frag_exe_level)
+{
+	int ret = 0;
+	struct ufs_hba *hba = fbo->hba;
+
+	ret = ufsfbo_query_attr(hba, UPIU_QUERY_OPCODE_READ_ATTR,
+			(enum attr_idn)QUERY_ATTR_IDN_FBO_LEVEL_EXE, 0, 0, frag_exe_level);
+	if (ret)
+		FBO_ERR_MSG("get_exe_level failed, ret(%d)", ret);
+	return ret;
+}
+
+int ufsfbo_set_exe_level(struct ufsfbo_dev *fbo, int *frag_exe_level)
+{
+	int ret = 0;
+	struct ufs_hba *hba = fbo->hba;
+
+	ret = ufsfbo_query_attr(hba, UPIU_QUERY_OPCODE_WRITE_ATTR,
+			(enum attr_idn)QUERY_ATTR_IDN_FBO_LEVEL_EXE, 0, 0, frag_exe_level);
+	if (ret)
+		FBO_ERR_MSG("set_exe_level failed, ret(%d)", ret);
+	return ret;
+}
+
+int ufsfbo_get_fbo_prog_state(struct ufsfbo_dev *fbo, int *prog_state)
+{
+	struct ufs_hba *hba = fbo->hba;
+	int ret = 0, attr = -1;
+
+	ret = ufsfbo_query_attr(hba, UPIU_QUERY_OPCODE_READ_ATTR,
+			(enum attr_idn)QUERY_ATTR_IDN_FBO_PROG_STATE, 0, 0, &attr);
+	if (ret) {
+		FBO_ERR_MSG("get fbo_prog_state failed, ret(%d)", ret);
+		return ret;
+	}
+	switch (attr) {
+	case 0x0:
+		*prog_state = FBO_PROG_IDLE;
+		break;
+	case 0x1:
+		*prog_state = FBO_PROG_ON_GOING;
+		break;
+	case 0x2:
+		*prog_state = FBO_PROG_ANALYSIS_COMPLETE;
+		break;
+	case 0x3:
+		*prog_state = FBO_PROG_OPTIMIZATION_COMPLETE;
+		break;
+	case 0xff:
+		*prog_state = FBO_PROG_INTERNAL_ERR;
+		break;
+	default:
+		FBO_INFO_MSG(fbo, "fbo unknown prog state attr(%d)", attr);
+		ret = -1;
+		break;
+	}
+	return ret;
+}
+
+int ufsfbo_read_frag_level(struct ufsfbo_dev *fbo, char *buf)
+{
+	int ret = 0;
+	uint8_t cdb[16];
+	struct ufs_hba *hba = fbo->hba;
+	struct scsi_sense_hdr sshdr = {};
+	struct scsi_device *sdev = fbo->sdev_ufs_lu;
+	unsigned long flags = 0;
+	int para_len = 0;
+
+	if (!fbo->fbo_lba_count)
+		FBO_ERR_MSG("invalid lba range count:%d", fbo->fbo_lba_count);
+	para_len = FBO_HEADER_SIZE + FBO_BODY_HEADER_SIZE +
+		fbo->fbo_lba_count * FBO_BODY_ENTRY_SIZE;
+
+	spin_lock_irqsave(hba->host->host_lock, flags);
+	ret = scsi_device_get(sdev);
+	if (!ret && !scsi_device_online(sdev)) {
+		ret = -ENODEV;
+		scsi_device_put(sdev);
+	}
+	spin_unlock_irqrestore(hba->host->host_lock, flags);
+
+	if (ret) {
+		FBO_ERR_MSG("get device fail");
+		return ret;
+	}
+	hba->host->eh_noresume = 1;
+	cdb[0] = READ_BUFFER;
+	cdb[1] = FBO_READ_LBA_RANGE_MODE;
+	cdb[2] = FBO_READ_LBA_RANGE_BUF_ID;
+	put_unaligned_be24(para_len, cdb + 6);
+
+	ret = scsi_execute(sdev, cdb, DMA_FROM_DEVICE, buf, para_len, NULL,
+			&sshdr, msecs_to_jiffies(15000), 0, 0, RQF_PM, NULL);
+	if (ret)
+		FBO_ERR_MSG("Read Buffer failed,sense key:0x%x;asc:0x%x;ascq:0x%x",
+			(int)sshdr.sense_key, (int)sshdr.asc, (int)sshdr.ascq);
+	scsi_device_put(sdev);
+	hba->host->eh_noresume = 0;
+
+	return ret;
+}
+
+int ufsfbo_init_lba_buffer(struct ufsfbo_dev *fbo, const char *buf, char *lba_buf)
+{
+	int ret = 0;
+	char *buf_ptr;
+	char *lba;
+	u64 lba_value_pre, lba_value_post;
+	int len_index = 1, lba_index = FBO_HEADER_SIZE + FBO_BODY_HEADER_SIZE;
+
+	buf_ptr = kzalloc(strlen(buf) + 1, GFP_KERNEL);
+	if (!buf_ptr) {
+		FBO_ERR_MSG("alloc buffer fail");
+		ret = -ENOMEM;
+		return ret;
+	}
+	memcpy(buf_ptr, buf, strlen(buf) + 1);
+
+	/*create lba range buf send for device*/
+	lba_buf[5] = fbo->fbo_lba_count; //lba range count
+	lba_buf[6] = fbo->fbo_wholefile; //calculate whole file
+
+	while ((lba = strsep(&buf_ptr, ",")) != NULL) {
+		ret = kstrtou64(lba, 16, &lba_value_pre);
+		if (ret) {
+			FBO_ERR_MSG("invalid lba range value");
+			ret = -ENODEV;
+			goto out;
+		}
+		if (len_index % 2) {
+			lba_value_post = lba_value_pre;
+			put_unaligned_be32(lba_value_pre, lba_buf + lba_index);
+		} else {
+			if (lba_value_pre < lba_value_post) {
+				ret = -ENODEV;
+				FBO_ERR_MSG("invalid lba range length");
+				goto out;
+			}
+			lba_value_pre = lba_value_pre - lba_value_post + 1;
+			put_unaligned_be24(lba_value_pre, lba_buf + lba_index + 4);
+			lba_index += FBO_BODY_ENTRY_SIZE;
+		}
+		len_index++;
+	}
+out:
+	kfree(buf_ptr);
+	return ret;
+}
+
+int ufsfbo_lba_list_write(struct ufsfbo_dev *fbo, const char *buf)
+{
+	int ret = 0;
+	struct ufs_hba *hba = fbo->hba;
+	struct scsi_device *sdev = fbo->sdev_ufs_lu;
+	struct scsi_sense_hdr sshdr = {};
+	char *lba_buf;
+	unsigned long flags = 0;
+	unsigned char cdb[10] = {0};
+	int para_len = FBO_HEADER_SIZE + FBO_BODY_HEADER_SIZE +
+			fbo->fbo_lba_count * FBO_BODY_ENTRY_SIZE;
+	lba_buf = kzalloc(FBO_LBA_RANGE_LENGTH, GFP_KERNEL);
+	if (!lba_buf) {
+		FBO_ERR_MSG("Alloc lba_buf fail");
+		ret = -ENOMEM;
+		return ret;
+	}
+	ret = ufsfbo_init_lba_buffer(fbo, buf, lba_buf);
+	if (ret) {
+		FBO_ERR_MSG("init lba_buf fail");
+		goto out;
+	}
+
+	spin_lock_irqsave(hba->host->host_lock, flags);
+	ret = scsi_device_get(sdev);
+	if (!ret && !scsi_device_online(sdev)) {
+		ret = -ENODEV;
+		scsi_device_put(sdev);
+	}
+	spin_unlock_irqrestore(hba->host->host_lock, flags);
+
+	if (ret) {
+		FBO_ERR_MSG("get device fail");
+		goto out;
+	}
+
+	hba->host->eh_noresume = 1;
+
+	cdb[0] = WRITE_BUFFER;
+	cdb[1] = FBO_WRITE_LBA_RANGE_MODE;
+	cdb[2] = FBO_WRITE_LBA_RANGE_BUF_ID;
+	put_unaligned_be24(para_len, cdb + 6);
+
+	ret = scsi_execute(sdev, cdb, DMA_TO_DEVICE, lba_buf, para_len, NULL,
+			&sshdr, msecs_to_jiffies(15000), 0, 0, RQF_PM, NULL);
+	if (ret)
+		/*check sense key*/
+		FBO_ERR_MSG("Write Buffer failed,sense key:0x%x;asc:0x%x;ascq:0x%x",
+			(int)sshdr.sense_key, (int)sshdr.asc, (int)sshdr.ascq);
+	scsi_device_put(sdev);
+
+	hba->host->eh_noresume = 0;
+out:
+	kfree(lba_buf);
+	return ret;
+}
+
+int ufsfbo_get_fbo_desc_info(struct ufsfbo_dev *fbo)
+{
+	int ret;
+	u8 *desc_buf;
+	struct ufs_hba *hba = fbo->hba;
+
+	desc_buf = kmalloc(QUERY_DESC_MAX_SIZE, GFP_KERNEL);
+	if (!desc_buf) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	ret = ufsfbo_read_desc(hba, QUERY_DESC_IDN_FBO, 0, 0,
+			desc_buf, QUERY_DESC_MAX_SIZE);
+	if (ret) {
+		FBO_ERR_MSG("Failed reading FBO Desc. ret(%d)", ret);
+		goto out;
+	}
+	fbo->fbo_version = get_unaligned_be16(desc_buf + FBO_DESC_PARAM_VERSION);
+	fbo->fbo_rec_lrs = get_unaligned_be32(desc_buf + FBO_DESC_PARAM_REC_LBA_RANGE_SIZE);
+	fbo->fbo_max_lrs = get_unaligned_be32(desc_buf + FBO_DESC_PARAM_MAX_LBA_RANGE_SIZE);
+	fbo->fbo_min_lrs = get_unaligned_be32(desc_buf + FBO_DESC_PARAM_MIN_LBA_RANGE_SIZE);
+	fbo->fbo_max_lrc = desc_buf[FBO_DESC_PARAM_MAX_LBA_RANGE_CONUT];
+	fbo->fbo_lra = get_unaligned_be16(desc_buf + FBO_DESC_PARAM_MAX_LBA_RANGE_ALIGNMENT);
+out:
+	kfree(desc_buf);
+	return ret;
+}
+
+int ufsfbo_get_fbo_support_state(struct ufsfbo_dev *fbo)
+{
+	struct ufs_hba *hba = fbo->hba;
+	struct ufs_dev_info *dev_info = &hba->dev_info;
+	u32 ext_ufs_feature;
+	u8 *desc_buf;
+	int ret;
+
+	desc_buf = kmalloc(QUERY_DESC_MAX_SIZE, GFP_KERNEL);
+	if (!desc_buf) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	if (dev_info->wspecversion <= 0x0310) {
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
+	ret = ufsfbo_read_desc(hba, QUERY_DESC_IDN_DEVICE, 0, 0,
+			desc_buf, QUERY_DESC_MAX_SIZE);
+	if (ret) {
+		FBO_ERR_MSG("Failed reading Device Desc. ret(%d)", ret);
+		goto out;
+	}
+	ext_ufs_feature = get_unaligned_be32(desc_buf + DEVICE_DESC_PARAM_EXT_UFS_FEATURE_SUP);
+	if (!(ext_ufs_feature & UFS_DEV_FBO_SUP)) {
+		ret = -EOPNOTSUPP;
+		FBO_INFO_MSG(fbo, "dExtendedUFSFeaturesSupport: FBO not support");
+		goto out;
+	}
+	fbo->fbo_support = 1;
+	FBO_INFO_MSG(fbo, "dExtendedUFSFeaturesSupport: FBO support");
+out:
+	kfree(desc_buf);
+	return ret;
+}
+
+void ufsfbo_init(struct ufs_hba *hba)
+{
+	struct ufsfbo_dev *fbo;
+	int ret = 0;
+
+	fbo = &hba->fbo;
+	fbo->hba = hba;
+
+	ret = ufsfbo_get_fbo_support_state(fbo);
+	if (ret) {
+		FBO_ERR_MSG("NOT Support FBO. ret(%d)", ret);
+		return;
+	}
+	ret = ufsfbo_get_fbo_desc_info(fbo);
+	if (ret) {
+		FBO_ERR_MSG("Failed getting fbo info. ret(%d)", ret);
+		return;
+	}
+	fbo->fbo_debug = false;
+	fbo->block_suspend = false;
+
+	if (ufshcd_is_auto_hibern8_supported(fbo->hba))
+		fbo->is_auto_enabled = true;
+
+	ret = ufsfbo_create_sysfs(fbo);
+	if (ret) {
+		FBO_ERR_MSG("sysfs init fail, disabled fbo driver");
+		kfree(fbo);
+		ufsfbo_set_state(hba, FBO_FAILED);
+		return;
+	}
+	FBO_INFO_MSG(fbo, "FBO Init and create sysfs finished");
+	ufsfbo_set_state(hba, FBO_PRESENT);
+}
+
+void ufsfbo_remove_sysfs(struct ufsfbo_dev *fbo)
+{
+	int ret;
+
+	ret = kobject_uevent(&fbo->kobj, KOBJ_REMOVE);
+	FBO_INFO_MSG(fbo, "kobject removed (%d)", ret);
+	kobject_del(&fbo->kobj);
+}
+
+void ufsfbo_remove(struct ufs_hba *hba)
+{
+	struct ufsfbo_dev *fbo;
+	enum UFSFBO_STATE cur_state;
+
+	fbo = &hba->fbo;
+	fbo->hba = hba;
+	cur_state = ufsfbo_get_state(fbo->hba);
+	if (cur_state == FBO_PRESENT) {
+		FBO_INFO_MSG(fbo, "start FBO Release");
+		ufsfbo_set_state(hba, FBO_FAILED);
+		mutex_lock(&fbo->sysfs_lock);
+		ufsfbo_remove_sysfs(fbo);
+		mutex_unlock(&fbo->sysfs_lock);
+	}
+}
+
+static ssize_t ufsfbo_sysfs_show_fbo_support(struct ufsfbo_dev *fbo, char *buf)
+{
+	FBO_INFO_MSG(fbo, "fbo_support (%d)", fbo->fbo_support);
+	return sysfs_emit(buf, "%d\n", fbo->fbo_support);
+}
+
+static ssize_t ufsfbo_sysfs_show_fbo_version(struct ufsfbo_dev *fbo, char *buf)
+{
+	FBO_INFO_MSG(fbo, "fbo_version (%04x)", fbo->fbo_version);
+	return sysfs_emit(buf, "%04x\n", fbo->fbo_version);
+}
+
+static ssize_t ufsfbo_sysfs_show_fbo_rec_lrs(struct ufsfbo_dev *fbo, char *buf)
+{
+	FBO_INFO_MSG(fbo, "fbo_rec_lrs (%d)", fbo->fbo_rec_lrs);
+	return sysfs_emit(buf, "%d\n", fbo->fbo_rec_lrs);
+}
+
+static ssize_t ufsfbo_sysfs_show_fbo_max_lrs(struct ufsfbo_dev *fbo, char *buf)
+{
+	FBO_INFO_MSG(fbo, "fbo_max_lrs (%d)", fbo->fbo_max_lrs);
+	return sysfs_emit(buf, "%d\n", fbo->fbo_max_lrs);
+}
+
+static ssize_t ufsfbo_sysfs_show_fbo_min_lrs(struct ufsfbo_dev *fbo, char *buf)
+{
+	FBO_INFO_MSG(fbo, "fbo_min_lrs (%d)", fbo->fbo_min_lrs);
+	return sysfs_emit(buf, "%d\n", fbo->fbo_min_lrs);
+}
+
+static ssize_t ufsfbo_sysfs_show_fbo_max_lrc(struct ufsfbo_dev *fbo, char *buf)
+{
+	FBO_INFO_MSG(fbo, "fbo_max_lrc (%d)", fbo->fbo_max_lrc);
+	return sysfs_emit(buf, "%d\n", fbo->fbo_max_lrc);
+}
+
+static ssize_t ufsfbo_sysfs_show_fbo_lra(struct ufsfbo_dev *fbo, char *buf)
+{
+	FBO_INFO_MSG(fbo, "fbo_lra (%d)", fbo->fbo_lra);
+	return sysfs_emit(buf, "%d\n", fbo->fbo_lra);
+}
+
+static ssize_t ufsfbo_sysfs_show_fbo_prog_state(struct ufsfbo_dev *fbo, char *buf)
+{
+	int ret, fbo_prog_state;
+
+	ufsfbo_block_enter_suspend(fbo);
+	ufsfbo_auto_hibern8_enable(fbo, 0);
+
+	ret = ufsfbo_get_fbo_prog_state(fbo, &fbo_prog_state);
+
+	ufsfbo_auto_hibern8_enable(fbo, 1);
+	ufsfbo_allow_enter_suspend(fbo);
+	if (ret) {
+		FBO_ERR_MSG("get fbo_prog_state failed");
+		return -EINVAL;
+	}
+	return sysfs_emit(buf, "%d\n", fbo_prog_state);
+}
+
+static ssize_t ufsfbo_sysfs_show_fbo_get_lr_frag_level(struct ufsfbo_dev *fbo,
+						  char *buf)
+{
+	int i, ret, count = 0;
+	int vaild_body_size = 0;
+	char *fbo_read_buffer;
+
+	fbo_read_buffer = kzalloc(FBO_MAX_BODY_SIZE, GFP_KERNEL);
+	if (!fbo_read_buffer) {
+		ret = -ENOMEM;
+		return ret;
+	}
+
+	ufsfbo_block_enter_suspend(fbo);
+	ufsfbo_auto_hibern8_enable(fbo, 0);
+
+	ret = ufsfbo_read_frag_level(fbo, fbo_read_buffer);
+
+	ufsfbo_auto_hibern8_enable(fbo, 1);
+	ufsfbo_allow_enter_suspend(fbo);
+	if (ret) {
+		FBO_ERR_MSG("get lba range level failed");
+		goto out;
+	}
+	vaild_body_size = FBO_BODY_HEADER_SIZE + (fbo->fbo_lba_count * FBO_BODY_ENTRY_SIZE);
+	for (i = 0; i < vaild_body_size; i++) {
+		count += snprintf(buf + count, PAGE_SIZE - count,
+				"%02x  ", fbo_read_buffer[i + FBO_HEADER_SIZE]);
+		if (!((i + 1) % 8))
+			count += snprintf(buf + count, PAGE_SIZE - count, "\n");
+	}
+out:
+	kfree(fbo_read_buffer);
+	return count;
+}
+
+static ssize_t ufsfbo_sysfs_show_fbo_wholefile_enable(struct ufsfbo_dev *fbo,
+						  char *buf)
+{
+	return sysfs_emit(buf, "whole file flag: %d\n", fbo->fbo_wholefile);
+}
+
+static ssize_t ufsfbo_sysfs_store_fbo_wholefile_enable(struct ufsfbo_dev *fbo,
+						   const char *buf,
+						   size_t count)
+{
+	bool val;
+
+	if (kstrtobool(buf, &val)) {
+		FBO_ERR_MSG("convert bool type fail from char * type");
+		return -EINVAL;
+	}
+	fbo->fbo_wholefile = val;
+	return count;
+}
+
+static ssize_t ufsfbo_sysfs_show_fbo_exe_threshold(struct ufsfbo_dev *fbo,
+						  char *buf)
+{
+	int frag_exe_level, ret;
+
+	ret = ufsfbo_get_exe_level(fbo, &frag_exe_level);
+	if (ret) {
+		FBO_ERR_MSG("get execute threshold failed");
+		return -EINVAL;
+	}
+	return sysfs_emit(buf, "%d\n", frag_exe_level);
+}
+
+static ssize_t ufsfbo_sysfs_store_fbo_exe_threshold(struct ufsfbo_dev *fbo,
+						   const char *buf,
+						   size_t count)
+{
+	unsigned long val;
+	int ret = 0, fbo_prog_state;
+
+	if (kstrtoul(buf, 0, &val))
+		return -EINVAL;
+
+	if (val < 0 || val > 10) {
+		FBO_ERR_MSG("fbo_exe_threshold set error, illegal value");
+		return -EINVAL;
+	}
+	ret = ufsfbo_get_fbo_prog_state(fbo, &fbo_prog_state);
+	if (ret) {
+		FBO_ERR_MSG("get fbo prog state failed");
+		return -EINVAL;
+	}
+	if (fbo_prog_state == FBO_PROG_IDLE || fbo_prog_state == FBO_PROG_ANALYSIS_COMPLETE ||
+		fbo_prog_state == FBO_PROG_OPTIMIZATION_COMPLETE) {
+		ret = ufsfbo_set_exe_level(fbo, (int *)&val);
+		if (ret) {
+			FBO_ERR_MSG("get execute level failed");
+			return -EINVAL;
+		}
+		FBO_INFO_MSG(fbo, "fbo_set_exe_threshold %ld", val);
+	} else {
+		FBO_ERR_MSG("fbo_exe_threshold set error, illegal fbo prog state");
+		return -EINVAL;
+	}
+	return count;
+}
+
+static ssize_t ufsfbo_sysfs_show_debug(struct ufsfbo_dev *fbo, char *buf)
+{
+	FBO_INFO_MSG(fbo, "Debug:%d", fbo->fbo_debug);
+	return sysfs_emit(buf, "%d\n", fbo->fbo_debug);
+}
+
+static ssize_t ufsfbo_sysfs_store_debug(struct ufsfbo_dev *fbo, const char *buf,
+					size_t count)
+{
+	unsigned long val;
+
+	if (kstrtoul(buf, 0, &val))
+		return -EINVAL;
+	if (val != 0 && val != 1)
+		return -EINVAL;
+	fbo->fbo_debug = val ? true : false;
+	FBO_INFO_MSG(fbo, "Debug:%d", fbo->fbo_debug);
+	return count;
+}
+
+static ssize_t ufsfbo_sysfs_show_block_suspend(struct ufsfbo_dev *fbo,
+					       char *buf)
+{
+	FBO_INFO_MSG(fbo, "Block suspend:%d", fbo->block_suspend);
+	return sysfs_emit(buf, "%d\n", fbo->block_suspend);
+}
+
+static ssize_t ufsfbo_sysfs_store_block_suspend(struct ufsfbo_dev *fbo,
+						const char *buf, size_t count)
+{
+	unsigned long val;
+
+	if (kstrtoul(buf, 0, &val))
+		return -EINVAL;
+	if (val != 0 && val != 1)
+		return -EINVAL;
+	FBO_INFO_MSG(fbo, "fbo_block_suspend %lu", val);
+	if (val == fbo->block_suspend)
+		return count;
+	if (val)
+		ufsfbo_block_enter_suspend(fbo);
+	else
+		ufsfbo_allow_enter_suspend(fbo);
+	fbo->block_suspend = val ? true : false;
+	return count;
+}
+
+static ssize_t ufsfbo_sysfs_show_auto_hibern8_enable(struct ufsfbo_dev *fbo,
+						     char *buf)
+{
+	FBO_INFO_MSG(fbo, "HCI auto hibern8 %d", fbo->is_auto_enabled);
+	return sysfs_emit(buf, "%d\n", fbo->is_auto_enabled);
+}
+
+static ssize_t ufsfbo_sysfs_store_auto_hibern8_enable(struct ufsfbo_dev *fbo,
+						      const char *buf,
+						      size_t count)
+{
+	unsigned long val;
+
+	if (kstrtoul(buf, 0, &val))
+		return -EINVAL;
+	if (val != 0 && val != 1)
+		return -EINVAL;
+	ufsfbo_auto_hibern8_enable(fbo, val);
+	return count;
+}
+
+static ssize_t ufsfbo_sysfs_store_fbo_operation_control(struct ufsfbo_dev *fbo,
+						      const char *buf,
+						      size_t count)
+{
+	int ret = 0;
+	unsigned long val;
+
+	if (kstrtoul(buf, 0, &val))
+		return -EINVAL;
+
+	ufsfbo_block_enter_suspend(fbo);
+	ufsfbo_auto_hibern8_enable(fbo, 0);
+
+	ret = ufsfbo_operation_control(fbo, (int *)&val);
+
+	ufsfbo_auto_hibern8_enable(fbo, 1);
+	ufsfbo_allow_enter_suspend(fbo);
+	if (ret) {
+		FBO_ERR_MSG("enable frag level check failed");
+		return -EINVAL;
+	}
+	return count;
+}
+
+static int ufsfbo_check_lr_list_buf(struct ufsfbo_dev *fbo, const char *buf)
+{
+	char *arg;
+	int len = 0;
+
+	if (!buf) {
+		FBO_ERR_MSG("invalid fbo write buf input, please try again");
+		return -EINVAL;
+	}
+
+	arg = strstr(buf, ",");
+	if (arg == NULL || buf[strlen(buf) - 1] == ',') {
+		FBO_ERR_MSG("invalid lba range, please input lba range separated by ','");
+		return -EINVAL;
+	}
+
+	while (arg != NULL) {
+		len++;
+		arg += 1;
+		arg = strstr(arg, ",");
+	}
+	if (len%2) {
+		len++;
+		FBO_INFO_MSG(fbo, "valid lba range count");
+	} else {
+		FBO_ERR_MSG("invalid lba range count, please input again");
+		return -EINVAL;
+	}
+	fbo->fbo_lba_count = len/2;
+	return 0;
+}
+
+static ssize_t ufsfbo_sysfs_store_fbo_send_lr_list(struct ufsfbo_dev *fbo,
+						      const char *buf,
+						      size_t count)
+{
+	int ret = 0, fbo_prog_state = 0;
+
+	ret = ufsfbo_check_lr_list_buf(fbo, buf);
+	if (ret) {
+		FBO_ERR_MSG("L-range list check fail");
+		return -EINVAL;
+	}
+
+	ret = ufsfbo_get_fbo_prog_state(fbo, &fbo_prog_state);
+	if (ret) {
+		FBO_ERR_MSG("invalid fbo_prog_state");
+		return -EINVAL;
+	}
+
+	if (fbo_prog_state == FBO_PROG_IDLE) {
+		ufsfbo_block_enter_suspend(fbo);
+		ufsfbo_auto_hibern8_enable(fbo, 0);
+		FBO_INFO_MSG(fbo, "send fbo lba range begin, power mode:%d",
+				fbo->hba->curr_dev_pwr_mode);
+		ret = ufsfbo_lba_list_write(fbo, buf);
+		ufsfbo_auto_hibern8_enable(fbo, 1);
+		ufsfbo_allow_enter_suspend(fbo);
+		if (ret) {
+			FBO_ERR_MSG("send lba range failed");
+			return -EINVAL;
+		}
+	} else {
+		FBO_ERR_MSG("invalid defrag or level check ops");
+	}
+
+	return count;
+}
+
+/* SYSFS DEFINE */
+#define define_sysfs_ro(_name) __ATTR(_name, 0444,			\
+				      ufsfbo_sysfs_show_##_name, NULL)
+#define define_sysfs_wo(_name) __ATTR(_name, 0200,			\
+				       NULL, ufsfbo_sysfs_store_##_name)
+#define define_sysfs_rw(_name) __ATTR(_name, 0644,			\
+				      ufsfbo_sysfs_show_##_name,	\
+				      ufsfbo_sysfs_store_##_name)
+static struct ufsfbo_sysfs_entry ufsfbo_sysfs_entries[] = {
+	define_sysfs_ro(fbo_rec_lrs),
+	define_sysfs_ro(fbo_max_lrs),
+	define_sysfs_ro(fbo_min_lrs),
+	define_sysfs_ro(fbo_max_lrc),
+	define_sysfs_ro(fbo_lra),
+	define_sysfs_ro(fbo_prog_state),
+	define_sysfs_ro(fbo_get_lr_frag_level),
+	define_sysfs_ro(fbo_support),
+	define_sysfs_ro(fbo_version),
+	define_sysfs_wo(fbo_operation_control),
+	define_sysfs_wo(fbo_send_lr_list),
+	define_sysfs_rw(fbo_exe_threshold),
+	define_sysfs_rw(fbo_wholefile_enable),
+	/* debug */
+	define_sysfs_rw(debug),
+	/* Attribute (RAW) */
+	define_sysfs_rw(block_suspend),
+	define_sysfs_rw(auto_hibern8_enable),
+	__ATTR_NULL
+};
+
+static ssize_t ufsfbo_attr_show(struct kobject *kobj, struct attribute *attr,
+				char *page)
+{
+	struct ufsfbo_sysfs_entry *entry;
+	struct ufsfbo_dev *fbo;
+	ssize_t error;
+
+	entry = container_of(attr, struct ufsfbo_sysfs_entry, attr);
+	if (!entry->show)
+		return -EIO;
+	fbo = container_of(kobj, struct ufsfbo_dev, kobj);
+	if (ufsfbo_is_not_present(fbo))
+		return -ENODEV;
+	mutex_lock(&fbo->sysfs_lock);
+	error = entry->show(fbo, page);
+	mutex_unlock(&fbo->sysfs_lock);
+	return error;
+}
+
+static ssize_t ufsfbo_attr_store(struct kobject *kobj, struct attribute *attr,
+				 const char *page, size_t length)
+{
+	struct ufsfbo_sysfs_entry *entry;
+	struct ufsfbo_dev *fbo;
+	ssize_t error;
+
+	entry = container_of(attr, struct ufsfbo_sysfs_entry, attr);
+	if (!entry->store)
+		return -EIO;
+	fbo = container_of(kobj, struct ufsfbo_dev, kobj);
+	if (ufsfbo_is_not_present(fbo))
+		return -ENODEV;
+	mutex_lock(&fbo->sysfs_lock);
+	error = entry->store(fbo, page, length);
+	mutex_unlock(&fbo->sysfs_lock);
+	return error;
+}
+
+static const struct sysfs_ops ufsfbo_sysfs_ops = {
+	.show = ufsfbo_attr_show,
+	.store = ufsfbo_attr_store,
+};
+
+static struct kobj_type ufsfbo_ktype = {
+	.sysfs_ops = &ufsfbo_sysfs_ops,
+	.release = NULL,
+};
+
+static int ufsfbo_create_sysfs(struct ufsfbo_dev *fbo)
+{
+	int err;
+	struct ufsfbo_sysfs_entry *entry;
+	struct device *dev = fbo->hba->dev;
+
+	fbo->sysfs_entries = ufsfbo_sysfs_entries;
+
+	kobject_init(&fbo->kobj, &ufsfbo_ktype);
+	mutex_init(&fbo->sysfs_lock);
+	FBO_INFO_MSG(fbo, "creates sysfs %p dev->kobj %p",
+		 &fbo->kobj, &dev->kobj);
+	err = kobject_add(&fbo->kobj, kobject_get(&dev->kobj), "ufsfbo");
+	if (!err) {
+		for (entry = fbo->sysfs_entries; entry->attr.name != NULL;
+		     entry++) {
+			FBO_INFO_MSG(fbo, "sysfs attr creates: %s",
+				 entry->attr.name);
+			err = sysfs_create_file(&fbo->kobj, &entry->attr);
+			if (err) {
+				FBO_ERR_MSG("create entry(%s) failed",
+					entry->attr.name);
+				goto kobj_del;
+			}
+		}
+		kobject_uevent(&fbo->kobj, KOBJ_ADD);
+	} else {
+		FBO_ERR_MSG("kobject_add failed");
+	}
+	return err;
+kobj_del:
+	err = kobject_uevent(&fbo->kobj, KOBJ_REMOVE);
+	FBO_INFO_MSG(fbo, "kobject removed (%d)", err);
+	kobject_del(&fbo->kobj);
+	return -EINVAL;
+}
diff --git a/drivers/scsi/ufs/ufsfbo.h b/drivers/scsi/ufs/ufsfbo.h
new file mode 100644
index 000000000000..c2549032815e
--- /dev/null
+++ b/drivers/scsi/ufs/ufsfbo.h
@@ -0,0 +1,143 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Universal Flash Storage File-based Optimization
+ *
+ * Copyright (C) 2022 Xiaomi Mobile Software Co., Ltd
+ *
+ * Authors:
+ *		lijiaming <lijiaming3@xiaomi.com>
+ */
+
+#ifndef _UFSFBO_H_
+#define _UFSFBO_H_
+#include <linux/interrupt.h>
+#include <linux/sysfs.h>
+#include <linux/blktrace_api.h>
+#include <linux/blkdev.h>
+#include <linux/bitfield.h>
+#include <linux/ktime.h>
+#include <scsi/scsi_cmnd.h>
+#include <scsi/scsi_device.h>
+#include <linux/types.h>
+#include <asm/unaligned.h>
+#include "../../../block/blk.h"
+
+#define FBO_INFO_MSG(fbo, msg, args...)	do { \
+		if (fbo->fbo_debug) \
+			pr_info("[info]%s:%d:" msg "\n", __func__, __LINE__, ##args); \
+	} while (0)
+
+#define FBO_ERR_MSG(msg, args...) \
+	pr_err("[err]%s:%d:" msg "\n", __func__, __LINE__, ##args)
+
+#define FBO_WARN_MSG(msg, args...) \
+	pr_warn("[warn]%s:%d:" msg "\n", __func__, __LINE__, ##args)
+
+#define FBO_LBA_RANGE_LENGTH (4*1024)
+/* UFSFBO CMD Format */
+#define FBO_READ_LBA_RANGE_MODE 0x02
+#define FBO_READ_LBA_RANGE_BUF_ID 0x02
+#define FBO_READ_LBA_RANGE_BUF_OFFSET 0x00
+#define FBO_WRITE_LBA_RANGE_MODE 0x02
+#define FBO_WRITE_LBA_RANGE_BUF_ID 0x01
+#define FBO_WRITE_LBA_RANGE_BUF_OFFSET 0x00
+#define FBO_HEADER_SIZE 4
+#define FBO_BODY_HEADER_SIZE 8
+#define FBO_BODY_ENTRY_SIZE 8
+#define FBO_MAX_BODY_SIZE 1024
+
+/* UFSFBO Query IDN */
+#define QUERY_ATTR_IDN_FBO_CONTROL 0x31
+#define QUERY_ATTR_IDN_FBO_LEVEL_EXE 0X32
+#define QUERY_ATTR_IDN_FBO_PROG_STATE 0x33
+
+enum UFSFBO_STATE {
+	FBO_NEED_INIT	= 0,
+	FBO_PRESENT	= 1,
+	FBO_FAILED	= -2,
+	FBO_RESET	= -3,
+};
+
+enum FBO_PROG_STATE {
+	FBO_PROG_IDLE	= 0x0,
+	FBO_PROG_ON_GOING	= 0x1,
+	FBO_PROG_ANALYSIS_COMPLETE	= 0x2,
+	FBO_PROG_OPTIMIZATION_COMPLETE	= 0x3,
+	FBO_PROG_INTERNAL_ERR	= 0xff,
+};
+
+enum {
+	FBO_AH8_DISABLE	= 0,
+	FBO_AH8_ENABLE	= 1,
+};
+
+/**
+ * struct ufsfbo_dev - FBO related structure
+ * @hba: Host Bus Adapter structure
+ * @sdev_ufs_lu: Store SCSI device pointer
+ * @ahit: Store ahit value
+ * @is_auto_enabled: HCI auto H8 state
+ * @block_suspend: Indicate Block Enter Suspend state
+ * @fbo_state: FBO Driver state
+ * @kobj: Kobject
+ * @sysfs_lock: Mutex Sysfs
+ * @sysfs_entries: Sysfs Entries
+ * @fbo_lba_count: Record The Count Of LBA
+ * @fbo_support: Indicate FBO Support State
+ * @fbo_version: FBO Version
+ * @fbo_rec_lrs: Recommended LBA Range Size In Bytes
+ * @fbo_max_lrs: The Max LBA Range Size To Be Used By The Host
+ * @fbo_min_lrs: The Min LBA Range Size To Be Used By The Host
+ * @fbo_max_lrc: The Max Number Of LBA Ranges Supported By Read/Write Buffer Cmd
+ * @fbo_lra: Alignment Requirement. 0 Means No Align Requirement
+ * @fbo_debug: Open More Debug Log
+ * @fbo_wholefile: Indicate Analyze Wholefile
+ */
+struct ufsfbo_dev {
+	struct ufs_hba *hba;
+	struct scsi_device *sdev_ufs_lu;
+	u32 ahit;
+	bool is_auto_enabled;
+	bool block_suspend;
+	atomic_t fbo_state;
+	/* for sysfs */
+	struct kobject kobj;
+	struct mutex sysfs_lock;
+	struct ufsfbo_sysfs_entry *sysfs_entries;
+	int fbo_lba_count;
+	u8  fbo_support;
+	u16 fbo_version;
+	u32 fbo_rec_lrs;
+	u32 fbo_max_lrs;
+	u32 fbo_min_lrs;
+	int fbo_max_lrc;
+	int fbo_lra;
+	bool fbo_debug;
+	bool fbo_wholefile;
+};
+
+struct ufsfbo_sysfs_entry {
+	struct attribute attr;
+	ssize_t (*show)(struct ufsfbo_dev *fbo, char *buf);
+	ssize_t (*store)(struct ufsfbo_dev *fbo, const char *buf, size_t count);
+};
+
+int ufsfbo_get_fbo_prog_state(struct ufsfbo_dev *fbo, int *prog_state);
+int ufsfbo_operation_control(struct ufsfbo_dev *fbo, int *val);
+int ufsfbo_get_exe_level(struct ufsfbo_dev *fbo, int *frag_exe_level);
+int ufsfbo_set_exe_level(struct ufsfbo_dev *fbo, int *frag_exe_level);
+int ufsfbo_lba_list_write(struct ufsfbo_dev *fbo, const char *buf);
+int ufsfbo_read_frag_level(struct ufsfbo_dev *fbo, char *buf);
+int ufsfbo_get_fbo_desc_info(struct ufsfbo_dev *fbo);
+int ufsfbo_get_fbo_support_state(struct ufsfbo_dev *fbo);
+int ufsfbo_get_state(struct ufs_hba *hba);
+void ufsfbo_set_state(struct ufs_hba *hba, int state);
+void ufsfbo_init(struct ufs_hba *hba);
+void ufsfbo_reset(struct ufs_hba *hba);
+void ufsfbo_reset_host(struct ufs_hba *hba);
+void ufsfbo_remove(struct ufs_hba *hba);
+int ufsfbo_is_not_present(struct ufsfbo_dev *fbo);
+void ufsfbo_block_enter_suspend(struct ufsfbo_dev *fbo);
+void ufsfbo_allow_enter_suspend(struct ufsfbo_dev *fbo);
+void ufsfbo_auto_hibern8_enable(struct ufsfbo_dev *fbo, unsigned int val);
+#endif /* _UFSFBO_H_ */
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 2f6468f22b48..9c377c514e17 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -4956,6 +4956,14 @@ static void ufshcd_hpb_configure(struct ufs_hba *hba, struct scsi_device *sdev)
 	ufshpb_init_hpb_lu(hba, sdev);
 }
 
+static void ufshcd_fbo_configure(struct ufs_hba *hba, struct scsi_device *sdev)
+{
+#ifdef CONFIG_SCSI_UFS_FBO
+	if (sdev->lun == 0)
+		hba->fbo.sdev_ufs_lu = sdev;
+#endif
+}
+
 /**
  * ufshcd_slave_configure - adjust SCSI device configurations
  * @sdev: pointer to SCSI device
@@ -4986,6 +4994,7 @@ static int ufshcd_slave_configure(struct scsi_device *sdev)
 	sdev->silence_suspend = 1;
 
 	ufshcd_crypto_setup_rq_keyslot_manager(hba, q);
+	ufshcd_fbo_configure(hba, sdev);
 
 	return 0;
 }
@@ -8005,6 +8014,9 @@ static void ufshcd_async_scan(void *data, async_cookie_t cookie)
 
 	/* Probe and add UFS logical units  */
 	ret = ufshcd_add_lus(hba);
+#ifdef CONFIG_SCSI_UFS_FBO
+	ufsfbo_init(hba);
+#endif
 out:
 	/*
 	 * If we failed to initialize the device or the device is not
@@ -9257,6 +9269,9 @@ void ufshcd_remove(struct ufs_hba *hba)
 	if (hba->sdev_ufs_device)
 		ufshcd_rpm_get_sync(hba);
 	ufs_bsg_remove(hba);
+#if defined(SCSI_CONFIG_FBO)
+	ufsfbo_remove(hba);
+#endif
 	ufshpb_remove(hba);
 	ufs_sysfs_remove_nodes(hba->dev);
 	blk_cleanup_queue(hba->tmf_queue);
diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
index d470a52ff24c..06bdea1673a1 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -47,7 +47,9 @@
 #include "ufs.h"
 #include "ufs_quirks.h"
 #include "ufshci.h"
-
+#ifdef CONFIG_SCSI_UFS_FBO
+#include "ufsfbo.h"
+#endif
 #define UFSHCD "ufshcd"
 #define UFSHCD_DRIVER_VERSION "0.2"
 
@@ -916,6 +918,9 @@ struct ufs_hba {
 	struct dentry *debugfs_root;
 	struct delayed_work debugfs_ee_work;
 	u32 debugfs_ee_rate_limit_ms;
+#endif
+#ifdef CONFIG_SCSI_UFS_FBO
+	struct ufsfbo_dev fbo;
 #endif
 	u32 luns_avail;
 	bool complete_put;
-- 
2.37.1

