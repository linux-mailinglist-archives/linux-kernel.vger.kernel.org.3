Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87F69466278
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 12:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357473AbhLBLk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 06:40:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357401AbhLBLkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 06:40:45 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 726CBC061757
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 03:37:23 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id n85so27613358pfd.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 03:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bSNDgfSnnHSOAxLz//LJ0mPnxALqBXxPZ9zRcv3JEOA=;
        b=OWfUMCs4dJLO7/cdowviPLJyDrwRiTx3iQCaYFZ2spGszC0aIVCHyn2cyAGn1fza5K
         UHULhAjLxPNCSi3h/qZ5PsgJvm3EK6Cs9sNX1khsJeQVlA7usz71H+prEUZ+NQtTG8au
         w3nx+UrQBe/fcOjRy5lGmQ69NtE5stT1PmYr8AJY2SKlE5cQLqkCbdgWP7CtHNwHHVVv
         /FY+2ZzBGhyj1CDbfGX+7VFhlUtXpP1vEjxD95AGy4JCgIyoLfxNxnf26yhyt1EHrTUK
         HL9QG/HA42gt66Ci9wjRU3pSxnNmta35MxLyAJWSkEmEcyGOaC7u7oWwDrTLLT1DHDyn
         VnNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bSNDgfSnnHSOAxLz//LJ0mPnxALqBXxPZ9zRcv3JEOA=;
        b=fZi3zfEC64vTmWHll8bZhXd0aZHMZA3ORqXuUFulu/ykserSwYh+iMMqxFcAfzqFoL
         +gaD6IiQZHDV9QcBTMLPjeskF9CuSNqHa+ZibYGOskN3HeuKkUbKG6D6rM17MN7dp1GK
         1aroDqC7iIEoM0+3qeS4rfOC6CqfOJjdmtp0pvSIyW+iLdYOevMhyjWYNyifXjXMoayc
         By3qcfjo0SPZkdlgW+RSUa4Ro0tg19IbWm3HiLS/46AIPBqSegB6+COJHLBsooZbKZZv
         A4mk5Q9gtF+VbrdQ+TrSPBH1ZILzHiWA/vRcrSAMgkduZUrKB8v3W9HhM9C0FQOvyPo/
         29QA==
X-Gm-Message-State: AOAM533TfrA68XDowtvfrD8VBWEUEtGUeHB5Uh+i2Verjvnc0GRvxJ7i
        fC8xqqawHzizQjJw/SEajYWV
X-Google-Smtp-Source: ABdhPJyszZmXWHMOrMoGCnQ1BnaJuWKuaCpr8XcvVNwko8bdDdqbyVLc1NGMYCQF/yIth9DgqHkV9g==
X-Received: by 2002:a63:a556:: with SMTP id r22mr7069339pgu.587.1638445042795;
        Thu, 02 Dec 2021 03:37:22 -0800 (PST)
Received: from localhost.localdomain ([117.202.184.5])
        by smtp.gmail.com with ESMTPSA id h5sm3602552pfi.46.2021.12.02.03.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 03:37:22 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mhi@lists.linux.dev
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        quic_jhugo@quicinc.com, vinod.koul@linaro.org,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        skananth@codeaurora.org, vpernami@codeaurora.org,
        vbadigan@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 05/20] bus: mhi: ep: Add support for registering MHI endpoint controllers
Date:   Thu,  2 Dec 2021 17:05:37 +0530
Message-Id: <20211202113553.238011-6-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211202113553.238011-1-manivannan.sadhasivam@linaro.org>
References: <20211202113553.238011-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds support for registering MHI endpoint controller drivers
with the MHI endpoint stack. MHI endpoint controller drivers manages
the interaction with the host machines such as x86. They are also the
MHI endpoint bus master in charge of managing the physical link between the
host and endpoint device.

The endpoint controller driver encloses all information about the
underlying physical bus like PCIe. The registration process involves
parsing the channel configuration and allocating an MHI EP device.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/Kconfig       |   1 +
 drivers/bus/mhi/Makefile      |   3 +
 drivers/bus/mhi/ep/Kconfig    |  10 ++
 drivers/bus/mhi/ep/Makefile   |   2 +
 drivers/bus/mhi/ep/internal.h | 158 +++++++++++++++++++++++
 drivers/bus/mhi/ep/main.c     | 231 ++++++++++++++++++++++++++++++++++
 include/linux/mhi_ep.h        | 140 +++++++++++++++++++++
 7 files changed, 545 insertions(+)
 create mode 100644 drivers/bus/mhi/ep/Kconfig
 create mode 100644 drivers/bus/mhi/ep/Makefile
 create mode 100644 drivers/bus/mhi/ep/internal.h
 create mode 100644 drivers/bus/mhi/ep/main.c
 create mode 100644 include/linux/mhi_ep.h

diff --git a/drivers/bus/mhi/Kconfig b/drivers/bus/mhi/Kconfig
index 4748df7f9cd5..b39a11e6c624 100644
--- a/drivers/bus/mhi/Kconfig
+++ b/drivers/bus/mhi/Kconfig
@@ -6,3 +6,4 @@
 #
 
 source "drivers/bus/mhi/host/Kconfig"
+source "drivers/bus/mhi/ep/Kconfig"
diff --git a/drivers/bus/mhi/Makefile b/drivers/bus/mhi/Makefile
index 5f5708a249f5..46981331b38f 100644
--- a/drivers/bus/mhi/Makefile
+++ b/drivers/bus/mhi/Makefile
@@ -1,2 +1,5 @@
 # Host MHI stack
 obj-y += host/
+
+# Endpoint MHI stack
+obj-y += ep/
diff --git a/drivers/bus/mhi/ep/Kconfig b/drivers/bus/mhi/ep/Kconfig
new file mode 100644
index 000000000000..229c71397b30
--- /dev/null
+++ b/drivers/bus/mhi/ep/Kconfig
@@ -0,0 +1,10 @@
+config MHI_BUS_EP
+	tristate "Modem Host Interface (MHI) bus Endpoint implementation"
+	help
+	  Bus driver for MHI protocol. Modem Host Interface (MHI) is a
+	  communication protocol used by the host processors to control
+	  and communicate with modem devices over a high speed peripheral
+	  bus or shared memory.
+
+	  MHI_BUS_EP implements the MHI protocol for the endpoint devices
+	  like SDX55 modem connected to the host machine over PCIe.
diff --git a/drivers/bus/mhi/ep/Makefile b/drivers/bus/mhi/ep/Makefile
new file mode 100644
index 000000000000..64e29252b608
--- /dev/null
+++ b/drivers/bus/mhi/ep/Makefile
@@ -0,0 +1,2 @@
+obj-$(CONFIG_MHI_BUS_EP) += mhi_ep.o
+mhi_ep-y := main.o
diff --git a/drivers/bus/mhi/ep/internal.h b/drivers/bus/mhi/ep/internal.h
new file mode 100644
index 000000000000..7b164daf4332
--- /dev/null
+++ b/drivers/bus/mhi/ep/internal.h
@@ -0,0 +1,158 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2021, Linaro Ltd.
+ *
+ */
+
+#ifndef _MHI_EP_INTERNAL_
+#define _MHI_EP_INTERNAL_
+
+#include <linux/bitfield.h>
+
+#include "../common.h"
+
+extern struct bus_type mhi_ep_bus_type;
+
+/* MHI register definitions */
+#define MHIREGLEN				0x100
+#define MHIVER					0x108
+#define MHICFG					0x110
+#define CHDBOFF					0x118
+#define ERDBOFF					0x120
+#define BHIOFF					0x128
+#define DEBUGOFF				0x130
+#define MHICTRL					0x138
+#define MHISTATUS				0x148
+#define CCABAP_LOWER				0x158
+#define CCABAP_HIGHER				0x15c
+#define ECABAP_LOWER				0x160
+#define ECABAP_HIGHER				0x164
+#define CRCBAP_LOWER				0x168
+#define CRCBAP_HIGHER				0x16c
+#define CRDB_LOWER				0x170
+#define CRDB_HIGHER				0x174
+#define MHICTRLBASE_LOWER			0x180
+#define MHICTRLBASE_HIGHER			0x184
+#define MHICTRLLIMIT_LOWER			0x188
+#define MHICTRLLIMIT_HIGHER			0x18c
+#define MHIDATABASE_LOWER			0x198
+#define MHIDATABASE_HIGHER			0x19c
+#define MHIDATALIMIT_LOWER			0x1a0
+#define MHIDATALIMIT_HIGHER			0x1a4
+#define CHDB_LOWER_n(n)				(0x400 + 0x8 * (n))
+#define CHDB_HIGHER_n(n)			(0x404 + 0x8 * (n))
+#define ERDB_LOWER_n(n)				(0x800 + 0x8 * (n))
+#define ERDB_HIGHER_n(n)			(0x804 + 0x8 * (n))
+#define BHI_INTVEC				0x220
+#define BHI_EXECENV				0x228
+#define BHI_IMGTXDB				0x218
+
+#define MHI_CTRL_INT_STATUS_A7			0x4
+#define MHI_CTRL_INT_STATUS_A7_MSK		BIT(0)
+#define MHI_CTRL_INT_STATUS_CRDB_MSK		BIT(1)
+#define MHI_CHDB_INT_STATUS_A7_n(n)		(0x28 + 0x4 * (n))
+#define MHI_ERDB_INT_STATUS_A7_n(n)		(0x38 + 0x4 * (n))
+
+#define MHI_CTRL_INT_CLEAR_A7			0x4c
+#define MHI_CTRL_INT_MMIO_WR_CLEAR		BIT(2)
+#define MHI_CTRL_INT_CRDB_CLEAR			BIT(1)
+#define MHI_CTRL_INT_CRDB_MHICTRL_CLEAR		BIT(0)
+
+#define MHI_CHDB_INT_CLEAR_A7_n(n)		(0x70 + 0x4 * (n))
+#define MHI_CHDB_INT_CLEAR_A7_n_CLEAR_ALL	GENMASK(31, 0)
+#define MHI_ERDB_INT_CLEAR_A7_n(n)		(0x80 + 0x4 * (n))
+#define MHI_ERDB_INT_CLEAR_A7_n_CLEAR_ALL	GENMASK(31, 0)
+
+#define MHI_CTRL_INT_MASK_A7			0x94
+#define MHI_CTRL_INT_MASK_A7_MASK_MASK		GENMASK(1, 0)
+#define MHI_CTRL_MHICTRL_MASK			BIT(0)
+#define MHI_CTRL_MHICTRL_SHFT			0
+#define MHI_CTRL_CRDB_MASK			BIT(1)
+#define MHI_CTRL_CRDB_SHFT			1
+
+#define MHI_CHDB_INT_MASK_A7_n(n)		(0xb8 + 0x4 * (n))
+#define MHI_CHDB_INT_MASK_A7_n_EN_ALL		GENMASK(31, 0)
+#define MHI_ERDB_INT_MASK_A7_n(n)		(0xc8 + 0x4 * (n))
+#define MHI_ERDB_INT_MASK_A7_n_EN_ALL		GENMASK(31, 0)
+
+#define NR_OF_CMD_RINGS				1
+#define MHI_MASK_ROWS_CH_EV_DB			4
+#define MHI_MASK_CH_EV_LEN			32
+
+/* Generic context */
+struct mhi_generic_ctx {
+	__u32 reserved0;
+	__u32 reserved1;
+	__u32 reserved2;
+
+	__u64 rbase __packed __aligned(4);
+	__u64 rlen __packed __aligned(4);
+	__u64 rp __packed __aligned(4);
+	__u64 wp __packed __aligned(4);
+};
+
+enum mhi_ep_ring_state {
+	RING_STATE_UINT = 0,
+	RING_STATE_IDLE,
+};
+
+enum mhi_ep_ring_type {
+	RING_TYPE_CMD = 0,
+	RING_TYPE_ER,
+	RING_TYPE_CH,
+	RING_TYPE_INVALID,
+};
+
+struct mhi_ep_ring_element {
+	u64 ptr;
+	u32 dword[2];
+};
+
+/* Transfer ring element type */
+union mhi_ep_ring_ctx {
+	struct mhi_cmd_ctxt cmd;
+	struct mhi_event_ctxt ev;
+	struct mhi_chan_ctxt ch;
+	struct mhi_generic_ctx generic;
+};
+
+struct mhi_ep_ring {
+	struct list_head list;
+	struct mhi_ep_cntrl *mhi_cntrl;
+	int (*ring_cb)(struct mhi_ep_ring *ring, struct mhi_ep_ring_element *el);
+	union mhi_ep_ring_ctx *ring_ctx;
+	struct mhi_ep_ring_element *ring_cache;
+	enum mhi_ep_ring_type type;
+	enum mhi_ep_ring_state state;
+	size_t rd_offset;
+	size_t wr_offset;
+	size_t ring_size;
+	u32 db_offset_h;
+	u32 db_offset_l;
+	u32 ch_id;
+};
+
+struct mhi_ep_cmd {
+	struct mhi_ep_ring ring;
+};
+
+struct mhi_ep_event {
+	struct mhi_ep_ring ring;
+};
+
+struct mhi_ep_chan {
+	char *name;
+	struct mhi_ep_device *mhi_dev;
+	struct mhi_ep_ring ring;
+	struct mutex lock;
+	void (*xfer_cb)(struct mhi_ep_device *mhi_dev, struct mhi_result *result);
+	enum mhi_ch_state state;
+	enum dma_data_direction dir;
+	u64 tre_loc;
+	u32 tre_size;
+	u32 tre_bytes_left;
+	u32 chan;
+	bool skip_td;
+};
+
+#endif
diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
new file mode 100644
index 000000000000..db664360c8ab
--- /dev/null
+++ b/drivers/bus/mhi/ep/main.c
@@ -0,0 +1,231 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * MHI Bus Endpoint stack
+ *
+ * Copyright (C) 2021 Linaro Ltd.
+ * Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/delay.h>
+#include <linux/dma-direction.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/mhi_ep.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include "internal.h"
+
+static DEFINE_IDA(mhi_ep_cntrl_ida);
+
+static void mhi_ep_release_device(struct device *dev)
+{
+	struct mhi_ep_device *mhi_dev = to_mhi_ep_device(dev);
+
+	/*
+	 * We need to set the mhi_chan->mhi_dev to NULL here since the MHI
+	 * devices for the channels will only get created if the mhi_dev
+	 * associated with it is NULL.
+	 */
+	if (mhi_dev->ul_chan)
+		mhi_dev->ul_chan->mhi_dev = NULL;
+
+	if (mhi_dev->dl_chan)
+		mhi_dev->dl_chan->mhi_dev = NULL;
+
+	kfree(mhi_dev);
+}
+
+static struct mhi_ep_device *mhi_ep_alloc_device(struct mhi_ep_cntrl *mhi_cntrl)
+{
+	struct mhi_ep_device *mhi_dev;
+	struct device *dev;
+
+	mhi_dev = kzalloc(sizeof(*mhi_dev), GFP_KERNEL);
+	if (!mhi_dev)
+		return ERR_PTR(-ENOMEM);
+
+	dev = &mhi_dev->dev;
+	device_initialize(dev);
+	dev->bus = &mhi_ep_bus_type;
+	dev->release = mhi_ep_release_device;
+
+	if (mhi_cntrl->mhi_dev) {
+		/* for MHI client devices, parent is the MHI controller device */
+		dev->parent = &mhi_cntrl->mhi_dev->dev;
+	} else {
+		/* for MHI controller device, parent is the bus device (e.g. PCI EPF) */
+		dev->parent = mhi_cntrl->cntrl_dev;
+	}
+
+	mhi_dev->mhi_cntrl = mhi_cntrl;
+
+	return mhi_dev;
+}
+
+static int parse_ch_cfg(struct mhi_ep_cntrl *mhi_cntrl,
+			const struct mhi_ep_cntrl_config *config)
+{
+	const struct mhi_ep_channel_config *ch_cfg;
+	struct device *dev = mhi_cntrl->cntrl_dev;
+	u32 chan, i;
+	int ret = -EINVAL;
+
+	mhi_cntrl->max_chan = config->max_channels;
+
+	/*
+	 * Allocate max_channels supported by the MHI endpoint and populate
+	 * only the defined channels
+	 */
+	mhi_cntrl->mhi_chan = kcalloc(mhi_cntrl->max_chan, sizeof(*mhi_cntrl->mhi_chan),
+				      GFP_KERNEL);
+	if (!mhi_cntrl->mhi_chan)
+		return -ENOMEM;
+
+	for (i = 0; i < config->num_channels; i++) {
+		struct mhi_ep_chan *mhi_chan;
+
+		ch_cfg = &config->ch_cfg[i];
+
+		chan = ch_cfg->num;
+		if (chan >= mhi_cntrl->max_chan) {
+			dev_err(dev, "Channel %d not available\n", chan);
+			goto error_chan_cfg;
+		}
+
+		mhi_chan = &mhi_cntrl->mhi_chan[chan];
+		mhi_chan->name = ch_cfg->name;
+		mhi_chan->chan = chan;
+		mhi_chan->dir = ch_cfg->dir;
+		mutex_init(&mhi_chan->lock);
+
+		/* Bi-directional and direction less channels are not supported */
+		if (mhi_chan->dir == DMA_BIDIRECTIONAL || mhi_chan->dir == DMA_NONE) {
+			dev_err(dev, "Invalid channel configuration\n");
+			goto error_chan_cfg;
+		}
+	}
+
+	return 0;
+
+error_chan_cfg:
+	kfree(mhi_cntrl->mhi_chan);
+
+	return ret;
+}
+
+/*
+ * Allocate channel and command rings here. Event rings will be allocated
+ * in mhi_ep_power_up() as the config comes from the host.
+ */
+int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
+				const struct mhi_ep_cntrl_config *config)
+{
+	struct mhi_ep_device *mhi_dev;
+	int ret;
+
+	if (!mhi_cntrl || !mhi_cntrl->cntrl_dev)
+		return -EINVAL;
+
+	ret = parse_ch_cfg(mhi_cntrl, config);
+	if (ret)
+		return ret;
+
+	mhi_cntrl->mhi_cmd = kcalloc(NR_OF_CMD_RINGS, sizeof(*mhi_cntrl->mhi_cmd), GFP_KERNEL);
+	if (!mhi_cntrl->mhi_cmd) {
+		ret = -ENOMEM;
+		goto err_free_ch;
+	}
+
+	/* Set controller index */
+	mhi_cntrl->index = ida_alloc(&mhi_ep_cntrl_ida, GFP_KERNEL);
+	if (mhi_cntrl->index < 0) {
+		ret = mhi_cntrl->index;
+		goto err_free_cmd;
+	}
+
+	/* Allocate the controller device */
+	mhi_dev = mhi_ep_alloc_device(mhi_cntrl);
+	if (IS_ERR(mhi_dev)) {
+		dev_err(mhi_cntrl->cntrl_dev, "Failed to allocate controller device\n");
+		ret = PTR_ERR(mhi_dev);
+		goto err_ida_free;
+	}
+
+	mhi_dev->dev_type = MHI_DEVICE_CONTROLLER;
+	dev_set_name(&mhi_dev->dev, "mhi_ep%d", mhi_cntrl->index);
+	mhi_dev->name = dev_name(&mhi_dev->dev);
+
+	ret = device_add(&mhi_dev->dev);
+	if (ret)
+		goto err_release_dev;
+
+	mhi_cntrl->mhi_dev = mhi_dev;
+
+	dev_dbg(&mhi_dev->dev, "MHI EP Controller registered\n");
+
+	return 0;
+
+err_release_dev:
+	put_device(&mhi_dev->dev);
+err_ida_free:
+	ida_free(&mhi_ep_cntrl_ida, mhi_cntrl->index);
+err_free_cmd:
+	kfree(mhi_cntrl->mhi_cmd);
+err_free_ch:
+	kfree(mhi_cntrl->mhi_chan);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mhi_ep_register_controller);
+
+void mhi_ep_unregister_controller(struct mhi_ep_cntrl *mhi_cntrl)
+{
+	struct mhi_ep_device *mhi_dev = mhi_cntrl->mhi_dev;
+
+	kfree(mhi_cntrl->mhi_cmd);
+	kfree(mhi_cntrl->mhi_chan);
+
+	device_del(&mhi_dev->dev);
+	put_device(&mhi_dev->dev);
+
+	ida_free(&mhi_ep_cntrl_ida, mhi_cntrl->index);
+}
+EXPORT_SYMBOL_GPL(mhi_ep_unregister_controller);
+
+static int mhi_ep_match(struct device *dev, struct device_driver *drv)
+{
+	struct mhi_ep_device *mhi_dev = to_mhi_ep_device(dev);
+
+	/*
+	 * If the device is a controller type then there is no client driver
+	 * associated with it
+	 */
+	if (mhi_dev->dev_type == MHI_DEVICE_CONTROLLER)
+		return 0;
+
+	return 0;
+};
+
+struct bus_type mhi_ep_bus_type = {
+	.name = "mhi_ep",
+	.dev_name = "mhi_ep",
+	.match = mhi_ep_match,
+};
+
+static int __init mhi_ep_init(void)
+{
+	return bus_register(&mhi_ep_bus_type);
+}
+
+static void __exit mhi_ep_exit(void)
+{
+	bus_unregister(&mhi_ep_bus_type);
+}
+
+postcore_initcall(mhi_ep_init);
+module_exit(mhi_ep_exit);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("MHI Bus Endpoint stack");
+MODULE_AUTHOR("Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>");
diff --git a/include/linux/mhi_ep.h b/include/linux/mhi_ep.h
new file mode 100644
index 000000000000..14fd40af8974
--- /dev/null
+++ b/include/linux/mhi_ep.h
@@ -0,0 +1,140 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2021, Linaro Ltd.
+ *
+ */
+#ifndef _MHI_EP_H_
+#define _MHI_EP_H_
+
+#include <linux/dma-direction.h>
+#include <linux/mhi.h>
+
+#define MHI_EP_DEFAULT_MTU 0x4000
+
+/**
+ * struct mhi_ep_channel_config - Channel configuration structure for controller
+ * @name: The name of this channel
+ * @num: The number assigned to this channel
+ * @num_elements: The number of elements that can be queued to this channel
+ * @dir: Direction that data may flow on this channel
+ */
+struct mhi_ep_channel_config {
+	char *name;
+	u32 num;
+	u32 num_elements;
+	enum dma_data_direction dir;
+};
+
+/**
+ * struct mhi_ep_cntrl_config - MHI Endpoint controller configuration
+ * @max_channels: Maximum number of channels supported
+ * @num_channels: Number of channels defined in @ch_cfg
+ * @ch_cfg: Array of defined channels
+ * @mhi_version: MHI spec version supported by the controller
+ */
+struct mhi_ep_cntrl_config {
+	u32 max_channels;
+	u32 num_channels;
+	const struct mhi_ep_channel_config *ch_cfg;
+	u32 mhi_version;
+};
+
+/**
+ * struct mhi_ep_db_info - MHI Endpoint doorbell info
+ * @mask: Mask of the doorbell interrupt
+ * @status: Status of the doorbell interrupt
+ */
+struct mhi_ep_db_info {
+	u32 mask;
+	u32 status;
+};
+
+/**
+ * struct mhi_ep_cntrl - MHI Endpoint controller structure
+ * @cntrl_dev: Pointer to the struct device of physical bus acting as the MHI
+ *             Endpoint controller
+ * @mhi_dev: MHI Endpoint device instance for the controller
+ * @mmio: MMIO region containing the MHI registers
+ * @mhi_chan: Points to the channel configuration table
+ * @mhi_event: Points to the event ring configurations table
+ * @mhi_cmd: Points to the command ring configurations table
+ * @sm: MHI Endpoint state machine
+ * @raise_irq: CB function for raising IRQ to the host
+ * @alloc_addr: CB function for allocating memory in endpoint for storing host context
+ * @map_addr: CB function for mapping host context to endpoint
+ * @free_addr: CB function to free the allocated memory in endpoint for storing host context
+ * @unmap_addr: CB function to unmap the host context in endpoint
+ * @mhi_state: MHI Endpoint state
+ * @max_chan: Maximum channels supported by the endpoint controller
+ * @index: MHI Endpoint controller index
+ */
+struct mhi_ep_cntrl {
+	struct device *cntrl_dev;
+	struct mhi_ep_device *mhi_dev;
+	void __iomem *mmio;
+
+	struct mhi_ep_chan *mhi_chan;
+	struct mhi_ep_event *mhi_event;
+	struct mhi_ep_cmd *mhi_cmd;
+	struct mhi_ep_sm *sm;
+
+	void (*raise_irq)(struct mhi_ep_cntrl *mhi_cntrl);
+	void __iomem *(*alloc_addr)(struct mhi_ep_cntrl *mhi_cntrl,
+				  phys_addr_t *phys_addr, size_t size);
+	int (*map_addr)(struct mhi_ep_cntrl *mhi_cntrl,
+			phys_addr_t phys_addr, u64 pci_addr, size_t size);
+	void (*free_addr)(struct mhi_ep_cntrl *mhi_cntrl,
+			  phys_addr_t phys_addr, void __iomem *virt_addr, size_t size);
+	void (*unmap_addr)(struct mhi_ep_cntrl *mhi_cntrl,
+			   phys_addr_t phys_addr);
+
+	enum mhi_state mhi_state;
+
+	u32 max_chan;
+	int index;
+};
+
+/**
+ * struct mhi_ep_device - Structure representing an MHI Endpoint device that binds
+ *                     to channels or is associated with controllers
+ * @dev: Driver model device node for the MHI Endpoint device
+ * @mhi_cntrl: Controller the device belongs to
+ * @id: Pointer to MHI Endpoint device ID struct
+ * @name: Name of the associated MHI Endpoint device
+ * @ul_chan: UL channel for the device
+ * @dl_chan: DL channel for the device
+ * @dev_type: MHI device type
+ * @ul_chan_id: Channel id for UL transfer
+ * @dl_chan_id: Channel id for DL transfer
+ */
+struct mhi_ep_device {
+	struct device dev;
+	struct mhi_ep_cntrl *mhi_cntrl;
+	const struct mhi_device_id *id;
+	const char *name;
+	struct mhi_ep_chan *ul_chan;
+	struct mhi_ep_chan *dl_chan;
+	enum mhi_device_type dev_type;
+	int ul_chan_id;
+	int dl_chan_id;
+};
+
+#define to_mhi_ep_device(dev) container_of(dev, struct mhi_ep_device, dev)
+
+/**
+ * mhi_ep_register_controller - Register MHI Endpoint controller
+ * @mhi_cntrl: MHI Endpoint controller to register
+ * @config: Configuration to use for the controller
+ *
+ * Return: 0 if controller registrations succeeds, a negative error code otherwise.
+ */
+int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
+			       const struct mhi_ep_cntrl_config *config);
+
+/**
+ * mhi_ep_unregister_controller - Unregister MHI Endpoint controller
+ * @mhi_cntrl: MHI Endpoint controller to unregister
+ */
+void mhi_ep_unregister_controller(struct mhi_ep_cntrl *mhi_cntrl);
+
+#endif
-- 
2.25.1

