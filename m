Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DAE15B0F8E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 23:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbiIGVwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 17:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbiIGVwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 17:52:24 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2ECEBCCC3
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 14:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662587534; x=1694123534;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dRvG10VtMNB3/A/6eeLg1+NYOtF1EAgKjvKJCrsqf3c=;
  b=LdM/nzuliz87k1YttkwjypTM2ykbiLvdHU5NPJCh7oKddPl3kb/rdsRC
   rDQe/WRHV9vF9s25OX8U+6rvfSGdGnvmtXHAwmTOjijXlGPhdIODyR30q
   tc97sm/gbaTRNa3hRG5FbVUWBkwNB1x72duRu9o1Cy7mBR6xwd014yURG
   RUEtOPr5FI4izLkEuGMZxSF5vuXRxchB/Lq1UEqJIMv6zTrG7fNqpA5oP
   c7uN7AGJkyfze5ogo1dYTM2pXepXoXMaAv52hzNOg8YSQY5Q35jnwRYKm
   9rk3wPyHNMz6nT7rihzBf66JtLDRPBsGL0apuqs+tc+5QObcl2uKMwbWQ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="295740367"
X-IronPort-AV: E=Sophos;i="5.93,298,1654585200"; 
   d="scan'208";a="295740367"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 14:52:14 -0700
X-IronPort-AV: E=Sophos;i="5.93,298,1654585200"; 
   d="scan'208";a="790208029"
Received: from twinkler-lnx.jer.intel.com ([10.12.87.143])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 14:52:10 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Subject: [PATCH v9 11/16] mei: gsc: setup gsc extended operational memory
Date:   Thu,  8 Sep 2022 00:51:08 +0300
Message-Id: <20220907215113.1596567-12-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220907215113.1596567-1-tomas.winkler@intel.com>
References: <20220907215113.1596567-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Retrieve extended operational memory physical pointers from the
   auxiliary device info.
2. Setup memory registers.
3. Notify firmware that the memory is ready by sending the memory
   ready command.
4. Disable PXP device if GSC is not in PXP mode.

CC: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Reviewed-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
---
V7:
1. Add kdoc to mei_aux
2. rename pxp_isready() to pxp_is_ready()
V8:
1. Setup default PXP state
2. Add PXP mode kdoc
3. Fix copyright date
V9: Rebase

 drivers/misc/mei/bus-fixup.c  | 70 ++++++++++++++++++++++++++++++++++-
 drivers/misc/mei/gsc-me.c     | 16 ++++++++
 drivers/misc/mei/hw-me-regs.h |  9 ++++-
 drivers/misc/mei/hw-me.c      | 28 +++++++++++++-
 drivers/misc/mei/init.c       |  2 +
 drivers/misc/mei/mei_dev.h    | 17 +++++++++
 include/linux/mei_aux.h       |  3 ++
 7 files changed, 141 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/mei/bus-fixup.c b/drivers/misc/mei/bus-fixup.c
index c4e527803299..79305e4acce2 100644
--- a/drivers/misc/mei/bus-fixup.c
+++ b/drivers/misc/mei/bus-fixup.c
@@ -188,6 +188,19 @@ static int mei_fwver(struct mei_cl_device *cldev)
 	return ret;
 }
 
+static int mei_gfx_memory_ready(struct mei_cl_device *cldev)
+{
+	struct mkhi_gfx_mem_ready req = {0};
+	unsigned int mode = MEI_CL_IO_TX_INTERNAL;
+
+	req.hdr.group_id = MKHI_GROUP_ID_GFX;
+	req.hdr.command = MKHI_GFX_MEMORY_READY_CMD_REQ;
+	req.flags = MKHI_GFX_MEM_READY_PXP_ALLOWED;
+
+	dev_dbg(&cldev->dev, "Sending memory ready command\n");
+	return __mei_cl_send(cldev->cl, (u8 *)&req, sizeof(req), 0, mode);
+}
+
 static void mei_mkhi_fix(struct mei_cl_device *cldev)
 {
 	int ret;
@@ -234,6 +247,39 @@ static void mei_gsc_mkhi_ver(struct mei_cl_device *cldev)
 		dev_err(&cldev->dev, "FW version command failed %d\n", ret);
 	mei_cldev_disable(cldev);
 }
+
+static void mei_gsc_mkhi_fix_ver(struct mei_cl_device *cldev)
+{
+	int ret;
+
+	/* No need to enable the client if nothing is needed from it */
+	if (!cldev->bus->fw_f_fw_ver_supported &&
+	    cldev->bus->pxp_mode != MEI_DEV_PXP_INIT)
+		return;
+
+	ret = mei_cldev_enable(cldev);
+	if (ret)
+		return;
+
+	if (cldev->bus->pxp_mode == MEI_DEV_PXP_INIT) {
+		ret = mei_gfx_memory_ready(cldev);
+		if (ret < 0)
+			dev_err(&cldev->dev, "memory ready command failed %d\n", ret);
+		else
+			dev_dbg(&cldev->dev, "memory ready command sent\n");
+		/* we go to reset after that */
+		cldev->bus->pxp_mode = MEI_DEV_PXP_SETUP;
+		goto out;
+	}
+
+	ret = mei_fwver(cldev);
+	if (ret < 0)
+		dev_err(&cldev->dev, "FW version command failed %d\n",
+			ret);
+out:
+	mei_cldev_disable(cldev);
+}
+
 /**
  * mei_wd - wd client on the bus, change protocol version
  *   as the API has changed.
@@ -473,6 +519,26 @@ static void vt_support(struct mei_cl_device *cldev)
 		cldev->do_match = 1;
 }
 
+/**
+ * pxp_is_ready - enable bus client if pxp is ready
+ *
+ * @cldev: me clients device
+ */
+static void pxp_is_ready(struct mei_cl_device *cldev)
+{
+	struct mei_device *bus = cldev->bus;
+
+	switch (bus->pxp_mode) {
+	case MEI_DEV_PXP_READY:
+	case MEI_DEV_PXP_DEFAULT:
+		cldev->do_match = 1;
+	break;
+	default:
+		cldev->do_match = 0;
+	break;
+	}
+}
+
 #define MEI_FIXUP(_uuid, _hook) { _uuid, _hook }
 
 static struct mei_fixup {
@@ -486,10 +552,10 @@ static struct mei_fixup {
 	MEI_FIXUP(MEI_UUID_WD, mei_wd),
 	MEI_FIXUP(MEI_UUID_MKHIF_FIX, mei_mkhi_fix),
 	MEI_FIXUP(MEI_UUID_IGSC_MKHI, mei_gsc_mkhi_ver),
-	MEI_FIXUP(MEI_UUID_IGSC_MKHI_FIX, mei_gsc_mkhi_ver),
+	MEI_FIXUP(MEI_UUID_IGSC_MKHI_FIX, mei_gsc_mkhi_fix_ver),
 	MEI_FIXUP(MEI_UUID_HDCP, whitelist),
 	MEI_FIXUP(MEI_UUID_ANY, vt_support),
-	MEI_FIXUP(MEI_UUID_PAVP, whitelist),
+	MEI_FIXUP(MEI_UUID_PAVP, pxp_is_ready),
 };
 
 /**
diff --git a/drivers/misc/mei/gsc-me.c b/drivers/misc/mei/gsc-me.c
index bfa6154b93e2..6b22726aed55 100644
--- a/drivers/misc/mei/gsc-me.c
+++ b/drivers/misc/mei/gsc-me.c
@@ -32,6 +32,17 @@ static int mei_gsc_read_hfs(const struct mei_device *dev, int where, u32 *val)
 	return 0;
 }
 
+static void mei_gsc_set_ext_op_mem(const struct mei_me_hw *hw, struct resource *mem)
+{
+	u32 low = lower_32_bits(mem->start);
+	u32 hi  = upper_32_bits(mem->start);
+	u32 limit = (resource_size(mem) / SZ_4K) | GSC_EXT_OP_MEM_VALID;
+
+	iowrite32(low, hw->mem_addr + H_GSC_EXT_OP_MEM_BASE_ADDR_LO_REG);
+	iowrite32(hi, hw->mem_addr + H_GSC_EXT_OP_MEM_BASE_ADDR_HI_REG);
+	iowrite32(limit, hw->mem_addr + H_GSC_EXT_OP_MEM_LIMIT_REG);
+}
+
 static int mei_gsc_probe(struct auxiliary_device *aux_dev,
 			 const struct auxiliary_device_id *aux_dev_id)
 {
@@ -67,6 +78,11 @@ static int mei_gsc_probe(struct auxiliary_device *aux_dev,
 
 	dev_set_drvdata(device, dev);
 
+	if (adev->ext_op_mem.start) {
+		mei_gsc_set_ext_op_mem(hw, &adev->ext_op_mem);
+		dev->pxp_mode = MEI_DEV_PXP_INIT;
+	}
+
 	/* use polling */
 	if (mei_me_hw_use_polling(hw)) {
 		mei_disable_interrupts(dev);
diff --git a/drivers/misc/mei/hw-me-regs.h b/drivers/misc/mei/hw-me-regs.h
index 15e8e2b322b1..99966cd3e7d8 100644
--- a/drivers/misc/mei/hw-me-regs.h
+++ b/drivers/misc/mei/hw-me-regs.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (c) 2003-2019, Intel Corporation. All rights reserved.
+ * Copyright (c) 2003-2022, Intel Corporation. All rights reserved.
  * Intel Management Engine Interface (Intel MEI) Linux driver
  */
 #ifndef _MEI_HW_MEI_REGS_H_
@@ -127,6 +127,8 @@
 #  define PCI_CFG_HFS_3_FW_SKU_SPS   0x00000060
 #define PCI_CFG_HFS_4         0x64
 #define PCI_CFG_HFS_5         0x68
+#  define GSC_CFG_HFS_5_BOOT_TYPE_MSK      0x00000003
+#  define GSC_CFG_HFS_5_BOOT_TYPE_PXP               3
 #define PCI_CFG_HFS_6         0x6C
 
 /* MEI registers */
@@ -143,6 +145,11 @@
 /* H_D0I3C - D0I3 Control  */
 #define H_D0I3C    0x800
 
+#define H_GSC_EXT_OP_MEM_BASE_ADDR_LO_REG 0x100
+#define H_GSC_EXT_OP_MEM_BASE_ADDR_HI_REG 0x104
+#define H_GSC_EXT_OP_MEM_LIMIT_REG        0x108
+#define GSC_EXT_OP_MEM_VALID              BIT(31)
+
 /* register bits of H_CSR (Host Control Status register) */
 /* Host Circular Buffer Depth - maximum number of 32-bit entries in CB */
 #define H_CBD             0xFF000000
diff --git a/drivers/misc/mei/hw-me.c b/drivers/misc/mei/hw-me.c
index 8f1c5ff24688..9e2f781c6ed5 100644
--- a/drivers/misc/mei/hw-me.c
+++ b/drivers/misc/mei/hw-me.c
@@ -433,6 +433,29 @@ static bool mei_me_hw_is_resetting(struct mei_device *dev)
 	return (mecsr & ME_RST_HRA) == ME_RST_HRA;
 }
 
+/**
+ * mei_gsc_pxp_check - check for gsc firmware entering pxp mode
+ *
+ * @dev: the device structure
+ */
+static void mei_gsc_pxp_check(struct mei_device *dev)
+{
+	struct mei_me_hw *hw = to_me_hw(dev);
+	u32 fwsts5 = 0;
+
+	if (dev->pxp_mode == MEI_DEV_PXP_DEFAULT)
+		return;
+
+	hw->read_fws(dev, PCI_CFG_HFS_5, &fwsts5);
+	trace_mei_pci_cfg_read(dev->dev, "PCI_CFG_HFS_5", PCI_CFG_HFS_5, fwsts5);
+	if ((fwsts5 & GSC_CFG_HFS_5_BOOT_TYPE_MSK) == GSC_CFG_HFS_5_BOOT_TYPE_PXP) {
+		dev_dbg(dev->dev, "pxp mode is ready 0x%08x\n", fwsts5);
+		dev->pxp_mode = MEI_DEV_PXP_READY;
+	} else {
+		dev_dbg(dev->dev, "pxp mode is not ready 0x%08x\n", fwsts5);
+	}
+}
+
 /**
  * mei_me_hw_ready_wait - wait until the me(hw) has turned ready
  *  or timeout is reached
@@ -452,6 +475,8 @@ static int mei_me_hw_ready_wait(struct mei_device *dev)
 		return -ETIME;
 	}
 
+	mei_gsc_pxp_check(dev);
+
 	mei_me_hw_reset_release(dev);
 	dev->recvd_hw_ready = false;
 	return 0;
@@ -1270,7 +1295,8 @@ irqreturn_t mei_me_irq_thread_handler(int irq, void *dev_id)
 
 	/* check if ME wants a reset */
 	if (!mei_hw_is_ready(dev) && dev->dev_state != MEI_DEV_RESETTING) {
-		dev_warn(dev->dev, "FW not ready: resetting.\n");
+		dev_warn(dev->dev, "FW not ready: resetting: dev_state = %d pxp = %d\n",
+			 dev->dev_state, dev->pxp_mode);
 		if (dev->dev_state == MEI_DEV_POWERING_DOWN ||
 		    dev->dev_state == MEI_DEV_POWER_DOWN)
 			mei_cl_all_disconnect(dev);
diff --git a/drivers/misc/mei/init.c b/drivers/misc/mei/init.c
index 5473b1fa6fff..1b4d5d7870b9 100644
--- a/drivers/misc/mei/init.c
+++ b/drivers/misc/mei/init.c
@@ -397,6 +397,8 @@ void mei_device_init(struct mei_device *dev,
 	bitmap_zero(dev->host_clients_map, MEI_CLIENTS_MAX);
 	dev->open_handle_count = 0;
 
+	dev->pxp_mode = MEI_DEV_PXP_DEFAULT;
+
 	/*
 	 * Reserving the first client ID
 	 * 0: Reserved for MEI Bus Message communications
diff --git a/drivers/misc/mei/mei_dev.h b/drivers/misc/mei/mei_dev.h
index babbb0944b7f..6bb3e1ba9ded 100644
--- a/drivers/misc/mei/mei_dev.h
+++ b/drivers/misc/mei/mei_dev.h
@@ -62,6 +62,21 @@ enum mei_dev_state {
 	MEI_DEV_POWER_UP
 };
 
+/**
+ * enum mei_dev_pxp_mode - MEI PXP mode state
+ *
+ * @MEI_DEV_PXP_DEFAULT: PCH based device, no initailization required
+ * @MEI_DEV_PXP_INIT:    device requires initialization, send setup message to firmware
+ * @MEI_DEV_PXP_SETUP:   device is in setup stage, waiting for firmware repsonse
+ * @MEI_DEV_PXP_READY:   device initialized
+ */
+enum mei_dev_pxp_mode {
+	MEI_DEV_PXP_DEFAULT = 0,
+	MEI_DEV_PXP_INIT    = 1,
+	MEI_DEV_PXP_SETUP   = 2,
+	MEI_DEV_PXP_READY   = 3,
+};
+
 const char *mei_dev_state_str(int state);
 
 enum mei_file_transaction_states {
@@ -454,6 +469,7 @@ struct mei_dev_timeouts {
  * @reset_count : number of consecutive resets
  * @dev_state   : device state
  * @hbm_state   : state of host bus message protocol
+ * @pxp_mode    : PXP device mode
  * @init_clients_timer : HBM init handshake timeout
  *
  * @pg_event    : power gating event
@@ -537,6 +553,7 @@ struct mei_device {
 	unsigned long reset_count;
 	enum mei_dev_state dev_state;
 	enum mei_hbm_state hbm_state;
+	enum mei_dev_pxp_mode pxp_mode;
 	u16 init_clients_timer;
 
 	/*
diff --git a/include/linux/mei_aux.h b/include/linux/mei_aux.h
index 4894d8bf4159..506912ad363b 100644
--- a/include/linux/mei_aux.h
+++ b/include/linux/mei_aux.h
@@ -12,6 +12,8 @@
  * @aux_dev: - auxiliary device object
  * @irq: interrupt driving the mei auxiliary device
  * @bar: mmio resource bar reserved to mei auxiliary device
+ * @ext_op_mem: resource for extend operational memory
+ *              used in graphics PXP mode.
  * @slow_firmware: The device has slow underlying firmware.
  *                 Such firmware will require to use larger operation timeouts.
  */
@@ -19,6 +21,7 @@ struct mei_aux_device {
 	struct auxiliary_device aux_dev;
 	int irq;
 	struct resource bar;
+	struct resource ext_op_mem;
 	bool slow_firmware;
 };
 
-- 
2.37.2

