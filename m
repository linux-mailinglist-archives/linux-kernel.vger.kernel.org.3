Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6829958B578
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 14:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbiHFM2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 08:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbiHFM2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 08:28:11 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976DC1408C
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 05:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659788871; x=1691324871;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bsHTh1or5oUlcUiLU0Rwr68aJ84RgrbD6+nBhXY2h2Q=;
  b=TFyYbG1eCfKaD5xIDfODTSSk4mBhurS/83NThnEHNs32q5eDq9aSYJWY
   R4T4vv5ke+/36K5+sNk5wT5rDQjS0lrOpzfWeQvXtMWEXtNHtSc6OEiAp
   xJVmAnWnmjDuCiif4yBx8p2pNCR7rjGQVXvu+P8s/dWMdYC9AU91hipd7
   iBplEcCukAZXO28V2B2RKhH1WFKHgK9PmTBG+Oqv97M/DPvm71+zP3Q7/
   Ui3MvZ5jBfwSJP8kGB4f7PjPXUyGHCg5EAoFceDfLW8EJHmgMRFrb8sh/
   dt+9toclqcTX7KZxw70HiME0YueSRRg724eduwy/TM+eAIvzuLIk5py5M
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="289121906"
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="289121906"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2022 05:27:51 -0700
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="632329127"
Received: from twinkler-lnx.jer.intel.com ([10.12.87.143])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2022 05:27:47 -0700
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
Subject: [PATCH v7 11/15] mei: gsc: setup gsc extended operational memory
Date:   Sat,  6 Aug 2022 15:26:32 +0300
Message-Id: <20220806122636.43068-12-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220806122636.43068-1-tomas.winkler@intel.com>
References: <20220806122636.43068-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

V7:
1. Add kdoc to mei_aux
2. rename pxp_isready() to pxp_is_ready()

CC: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 drivers/misc/mei/bus-fixup.c  | 70 ++++++++++++++++++++++++++++++++++-
 drivers/misc/mei/gsc-me.c     | 16 ++++++++
 drivers/misc/mei/hw-me-regs.h |  7 ++++
 drivers/misc/mei/hw-me.c      | 28 +++++++++++++-
 drivers/misc/mei/mei_dev.h    | 10 +++++
 include/linux/mei_aux.h       |  3 ++
 6 files changed, 131 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/mei/bus-fixup.c b/drivers/misc/mei/bus-fixup.c
index 811c94ebf250..b350cc8d500c 100644
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
index 15e8e2b322b1..8049f288f74c 100644
--- a/drivers/misc/mei/hw-me-regs.h
+++ b/drivers/misc/mei/hw-me-regs.h
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
index 6a8e8f3cea7e..c86d6018bc20 100644
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
diff --git a/drivers/misc/mei/mei_dev.h b/drivers/misc/mei/mei_dev.h
index 16f59b3a45fc..7c508bca9a00 100644
--- a/drivers/misc/mei/mei_dev.h
+++ b/drivers/misc/mei/mei_dev.h
@@ -62,6 +62,14 @@ enum mei_dev_state {
 	MEI_DEV_POWER_UP
 };
 
+/* MEI PXP mode state */
+enum mei_dev_pxp_mode {
+	MEI_DEV_PXP_DEFAULT = 0,
+	MEI_DEV_PXP_INIT    = 1,
+	MEI_DEV_PXP_SETUP   = 2,
+	MEI_DEV_PXP_READY   = 3,
+};
+
 const char *mei_dev_state_str(int state);
 
 enum mei_file_transaction_states {
@@ -454,6 +462,7 @@ struct mei_dev_timeouts {
  * @reset_count : number of consecutive resets
  * @dev_state   : device state
  * @hbm_state   : state of host bus message protocol
+ * @pxp_mode    : PXP device mode
  * @init_clients_timer : HBM init handshake timeout
  *
  * @pg_event    : power gating event
@@ -537,6 +546,7 @@ struct mei_device {
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
2.37.1

