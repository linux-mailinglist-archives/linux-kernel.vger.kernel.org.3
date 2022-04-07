Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6A54F7FEB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 15:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343520AbiDGNEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 09:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245700AbiDGNCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 09:02:30 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1673E994A
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 06:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649336418; x=1680872418;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2HzDU9iJlkMViSTHOB1v0XvsV1lU5Pq9laruzE8ErdM=;
  b=KZzw2tFw30Iayz0Vw8XpsJNWr6BpfqzfbnzeCge/+m9EgvfQLLai/lNw
   a04nhHwXxyIqE9wJgVW0HkZT0slG2lAVU5Z9zwPvdD2Lk7PmmlobYHUbb
   23Ko84UkDVUn3AacGvdkNvEIX9m4Y7/l69AA6VjmNXysEX+t3KkIIc/Zv
   gSBqX7oSvdeMcgFk7sS+THzOACukR3hE3g6M7T91X7Q35q7W6LUctGotg
   3mgmV8lKa5hgHatFrKr64tQmj91L+U2Ry2UmrPyUB+lBNWNLWpNjvVoK1
   XE4ZERx6o+klvsXWK5DuJXMad7uNZrYvo47lRWqI2ZW1UbRnvLDfnMyw7
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10309"; a="248842039"
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="248842039"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 06:00:17 -0700
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="571041147"
Received: from sannilnx.jer.intel.com ([10.12.231.73])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 06:00:12 -0700
From:   Alexander Usyskin <alexander.usyskin@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     Tomas Winkler <tomas.winkler@intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 13/20] mei: extend timeouts on slow devices.
Date:   Thu,  7 Apr 2022 15:58:32 +0300
Message-Id: <20220407125839.1479249-14-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220407125839.1479249-1-alexander.usyskin@intel.com>
References: <20220407125839.1479249-1-alexander.usyskin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parametrize operational timeouts in order
to support slow firmware on some graphic devices.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/bus-fixup.c |  3 +--
 drivers/misc/mei/client.c    | 14 +++++++-------
 drivers/misc/mei/gsc-me.c    |  2 +-
 drivers/misc/mei/hbm.c       | 12 ++++++------
 drivers/misc/mei/hw-me.c     | 30 ++++++++++++++++--------------
 drivers/misc/mei/hw-me.h     |  2 +-
 drivers/misc/mei/hw-txe.c    |  2 +-
 drivers/misc/mei/hw.h        |  5 +++++
 drivers/misc/mei/init.c      | 19 ++++++++++++++++++-
 drivers/misc/mei/main.c      |  2 +-
 drivers/misc/mei/mei_dev.h   | 16 ++++++++++++++++
 drivers/misc/mei/pci-me.c    |  2 +-
 12 files changed, 74 insertions(+), 35 deletions(-)

diff --git a/drivers/misc/mei/bus-fixup.c b/drivers/misc/mei/bus-fixup.c
index 59506ba6fc48..24e91a9ea558 100644
--- a/drivers/misc/mei/bus-fixup.c
+++ b/drivers/misc/mei/bus-fixup.c
@@ -164,7 +164,6 @@ static int mei_osver(struct mei_cl_device *cldev)
 			    sizeof(struct mkhi_fw_ver))
 #define MKHI_FWVER_LEN(__num) (sizeof(struct mkhi_msg_hdr) + \
 			       sizeof(struct mkhi_fw_ver_block) * (__num))
-#define MKHI_RCV_TIMEOUT 500 /* receive timeout in msec */
 static int mei_fwver(struct mei_cl_device *cldev)
 {
 	char buf[MKHI_FWVER_BUF_LEN];
@@ -187,7 +186,7 @@ static int mei_fwver(struct mei_cl_device *cldev)
 
 	ret = 0;
 	bytes_recv = __mei_cl_recv(cldev->cl, buf, sizeof(buf), NULL, 0,
-				   MKHI_RCV_TIMEOUT);
+				   cldev->bus->timeouts.mkhi_recv);
 	if (bytes_recv < 0 || (size_t)bytes_recv < MKHI_FWVER_LEN(1)) {
 		/*
 		 * Should be at least one version block,
diff --git a/drivers/misc/mei/client.c b/drivers/misc/mei/client.c
index 31264ab2eb13..e7a16d9b2241 100644
--- a/drivers/misc/mei/client.c
+++ b/drivers/misc/mei/client.c
@@ -870,7 +870,7 @@ static int mei_cl_send_disconnect(struct mei_cl *cl, struct mei_cl_cb *cb)
 	}
 
 	list_move_tail(&cb->list, &dev->ctrl_rd_list);
-	cl->timer_count = MEI_CONNECT_TIMEOUT;
+	cl->timer_count = dev->timeouts.connect;
 	mei_schedule_stall_timer(dev);
 
 	return 0;
@@ -945,7 +945,7 @@ static int __mei_cl_disconnect(struct mei_cl *cl)
 	wait_event_timeout(cl->wait,
 			   cl->state == MEI_FILE_DISCONNECT_REPLY ||
 			   cl->state == MEI_FILE_DISCONNECTED,
-			   mei_secs_to_jiffies(MEI_CL_CONNECT_TIMEOUT));
+			   dev->timeouts.cl_connect);
 	mutex_lock(&dev->device_lock);
 
 	rets = cl->status;
@@ -1065,7 +1065,7 @@ static int mei_cl_send_connect(struct mei_cl *cl, struct mei_cl_cb *cb)
 	}
 
 	list_move_tail(&cb->list, &dev->ctrl_rd_list);
-	cl->timer_count = MEI_CONNECT_TIMEOUT;
+	cl->timer_count = dev->timeouts.connect;
 	mei_schedule_stall_timer(dev);
 	return 0;
 }
@@ -1164,7 +1164,7 @@ int mei_cl_connect(struct mei_cl *cl, struct mei_me_client *me_cl,
 			 cl->state == MEI_FILE_DISCONNECTED ||
 			 cl->state == MEI_FILE_DISCONNECT_REQUIRED ||
 			 cl->state == MEI_FILE_DISCONNECT_REPLY),
-			mei_secs_to_jiffies(MEI_CL_CONNECT_TIMEOUT));
+			dev->timeouts.cl_connect);
 	mutex_lock(&dev->device_lock);
 
 	if (!mei_cl_is_connected(cl)) {
@@ -1562,7 +1562,7 @@ int mei_cl_notify_request(struct mei_cl *cl,
 			   cl->notify_en == request ||
 			   cl->status ||
 			   !mei_cl_is_connected(cl),
-			   mei_secs_to_jiffies(MEI_CL_CONNECT_TIMEOUT));
+			   dev->timeouts.cl_connect);
 	mutex_lock(&dev->device_lock);
 
 	if (cl->notify_en != request && !cl->status)
@@ -2336,7 +2336,7 @@ int mei_cl_dma_alloc_and_map(struct mei_cl *cl, const struct file *fp,
 	mutex_unlock(&dev->device_lock);
 	wait_event_timeout(cl->wait,
 			   cl->dma_mapped || cl->status,
-			   mei_secs_to_jiffies(MEI_CL_CONNECT_TIMEOUT));
+			   dev->timeouts.cl_connect);
 	mutex_lock(&dev->device_lock);
 
 	if (!cl->dma_mapped && !cl->status)
@@ -2415,7 +2415,7 @@ int mei_cl_dma_unmap(struct mei_cl *cl, const struct file *fp)
 	mutex_unlock(&dev->device_lock);
 	wait_event_timeout(cl->wait,
 			   !cl->dma_mapped || cl->status,
-			   mei_secs_to_jiffies(MEI_CL_CONNECT_TIMEOUT));
+			   dev->timeouts.cl_connect);
 	mutex_lock(&dev->device_lock);
 
 	if (cl->dma_mapped && !cl->status)
diff --git a/drivers/misc/mei/gsc-me.c b/drivers/misc/mei/gsc-me.c
index 6f262ddfd25a..38d035ae2904 100644
--- a/drivers/misc/mei/gsc-me.c
+++ b/drivers/misc/mei/gsc-me.c
@@ -48,7 +48,7 @@ static int mei_gsc_probe(struct auxiliary_device *aux_dev,
 
 	device = &aux_dev->dev;
 
-	dev = mei_me_dev_init(device, cfg);
+	dev = mei_me_dev_init(device, cfg, adev->slow_fw);
 	if (IS_ERR(dev)) {
 		ret = PTR_ERR(dev);
 		goto err;
diff --git a/drivers/misc/mei/hbm.c b/drivers/misc/mei/hbm.c
index cebcca6d6d3e..4ff4dbfd07c0 100644
--- a/drivers/misc/mei/hbm.c
+++ b/drivers/misc/mei/hbm.c
@@ -232,7 +232,7 @@ int mei_hbm_start_wait(struct mei_device *dev)
 	mutex_unlock(&dev->device_lock);
 	ret = wait_event_timeout(dev->wait_hbm_start,
 			dev->hbm_state != MEI_HBM_STARTING,
-			mei_secs_to_jiffies(MEI_HBM_TIMEOUT));
+			dev->timeouts.hbm);
 	mutex_lock(&dev->device_lock);
 
 	if (ret == 0 && (dev->hbm_state <= MEI_HBM_STARTING)) {
@@ -275,7 +275,7 @@ int mei_hbm_start_req(struct mei_device *dev)
 	}
 
 	dev->hbm_state = MEI_HBM_STARTING;
-	dev->init_clients_timer = MEI_CLIENTS_INIT_TIMEOUT;
+	dev->init_clients_timer = dev->timeouts.client_init;
 	mei_schedule_stall_timer(dev);
 	return 0;
 }
@@ -316,7 +316,7 @@ static int mei_hbm_dma_setup_req(struct mei_device *dev)
 	}
 
 	dev->hbm_state = MEI_HBM_DR_SETUP;
-	dev->init_clients_timer = MEI_CLIENTS_INIT_TIMEOUT;
+	dev->init_clients_timer = dev->timeouts.client_init;
 	mei_schedule_stall_timer(dev);
 	return 0;
 }
@@ -351,7 +351,7 @@ static int mei_hbm_capabilities_req(struct mei_device *dev)
 	}
 
 	dev->hbm_state = MEI_HBM_CAP_SETUP;
-	dev->init_clients_timer = MEI_CLIENTS_INIT_TIMEOUT;
+	dev->init_clients_timer = dev->timeouts.client_init;
 	mei_schedule_stall_timer(dev);
 	return 0;
 }
@@ -385,7 +385,7 @@ static int mei_hbm_enum_clients_req(struct mei_device *dev)
 		return ret;
 	}
 	dev->hbm_state = MEI_HBM_ENUM_CLIENTS;
-	dev->init_clients_timer = MEI_CLIENTS_INIT_TIMEOUT;
+	dev->init_clients_timer = dev->timeouts.client_init;
 	mei_schedule_stall_timer(dev);
 	return 0;
 }
@@ -751,7 +751,7 @@ static int mei_hbm_prop_req(struct mei_device *dev, unsigned long start_idx)
 		return ret;
 	}
 
-	dev->init_clients_timer = MEI_CLIENTS_INIT_TIMEOUT;
+	dev->init_clients_timer = dev->timeouts.client_init;
 	mei_schedule_stall_timer(dev);
 
 	return 0;
diff --git a/drivers/misc/mei/hw-me.c b/drivers/misc/mei/hw-me.c
index 959b3329af60..93d8b6dcedda 100644
--- a/drivers/misc/mei/hw-me.c
+++ b/drivers/misc/mei/hw-me.c
@@ -445,7 +445,7 @@ static int mei_me_hw_ready_wait(struct mei_device *dev)
 	mutex_unlock(&dev->device_lock);
 	wait_event_timeout(dev->wait_hw_ready,
 			dev->recvd_hw_ready,
-			mei_secs_to_jiffies(MEI_HW_READY_TIMEOUT));
+			dev->timeouts.hw_ready);
 	mutex_lock(&dev->device_lock);
 	if (!dev->recvd_hw_ready) {
 		dev_err(dev->dev, "wait hw ready failed\n");
@@ -707,7 +707,6 @@ static void mei_me_pg_unset(struct mei_device *dev)
 static int mei_me_pg_legacy_enter_sync(struct mei_device *dev)
 {
 	struct mei_me_hw *hw = to_me_hw(dev);
-	unsigned long timeout = mei_secs_to_jiffies(MEI_PGI_TIMEOUT);
 	int ret;
 
 	dev->pg_event = MEI_PG_EVENT_WAIT;
@@ -718,7 +717,8 @@ static int mei_me_pg_legacy_enter_sync(struct mei_device *dev)
 
 	mutex_unlock(&dev->device_lock);
 	wait_event_timeout(dev->wait_pg,
-		dev->pg_event == MEI_PG_EVENT_RECEIVED, timeout);
+		dev->pg_event == MEI_PG_EVENT_RECEIVED,
+		dev->timeouts.pgi);
 	mutex_lock(&dev->device_lock);
 
 	if (dev->pg_event == MEI_PG_EVENT_RECEIVED) {
@@ -744,7 +744,6 @@ static int mei_me_pg_legacy_enter_sync(struct mei_device *dev)
 static int mei_me_pg_legacy_exit_sync(struct mei_device *dev)
 {
 	struct mei_me_hw *hw = to_me_hw(dev);
-	unsigned long timeout = mei_secs_to_jiffies(MEI_PGI_TIMEOUT);
 	int ret;
 
 	if (dev->pg_event == MEI_PG_EVENT_RECEIVED)
@@ -756,7 +755,8 @@ static int mei_me_pg_legacy_exit_sync(struct mei_device *dev)
 
 	mutex_unlock(&dev->device_lock);
 	wait_event_timeout(dev->wait_pg,
-		dev->pg_event == MEI_PG_EVENT_RECEIVED, timeout);
+		dev->pg_event == MEI_PG_EVENT_RECEIVED,
+		dev->timeouts.pgi);
 	mutex_lock(&dev->device_lock);
 
 reply:
@@ -772,7 +772,8 @@ static int mei_me_pg_legacy_exit_sync(struct mei_device *dev)
 
 	mutex_unlock(&dev->device_lock);
 	wait_event_timeout(dev->wait_pg,
-		dev->pg_event == MEI_PG_EVENT_INTR_RECEIVED, timeout);
+		dev->pg_event == MEI_PG_EVENT_INTR_RECEIVED,
+		dev->timeouts.pgi);
 	mutex_lock(&dev->device_lock);
 
 	if (dev->pg_event == MEI_PG_EVENT_INTR_RECEIVED)
@@ -887,8 +888,6 @@ static u32 mei_me_d0i3_unset(struct mei_device *dev)
 static int mei_me_d0i3_enter_sync(struct mei_device *dev)
 {
 	struct mei_me_hw *hw = to_me_hw(dev);
-	unsigned long d0i3_timeout = mei_secs_to_jiffies(MEI_D0I3_TIMEOUT);
-	unsigned long pgi_timeout = mei_secs_to_jiffies(MEI_PGI_TIMEOUT);
 	int ret;
 	u32 reg;
 
@@ -910,7 +909,8 @@ static int mei_me_d0i3_enter_sync(struct mei_device *dev)
 
 	mutex_unlock(&dev->device_lock);
 	wait_event_timeout(dev->wait_pg,
-		dev->pg_event == MEI_PG_EVENT_RECEIVED, pgi_timeout);
+		dev->pg_event == MEI_PG_EVENT_RECEIVED,
+		dev->timeouts.pgi);
 	mutex_lock(&dev->device_lock);
 
 	if (dev->pg_event != MEI_PG_EVENT_RECEIVED) {
@@ -930,7 +930,8 @@ static int mei_me_d0i3_enter_sync(struct mei_device *dev)
 
 	mutex_unlock(&dev->device_lock);
 	wait_event_timeout(dev->wait_pg,
-		dev->pg_event == MEI_PG_EVENT_INTR_RECEIVED, d0i3_timeout);
+		dev->pg_event == MEI_PG_EVENT_INTR_RECEIVED,
+		dev->timeouts.d0i3);
 	mutex_lock(&dev->device_lock);
 
 	if (dev->pg_event != MEI_PG_EVENT_INTR_RECEIVED) {
@@ -990,7 +991,6 @@ static int mei_me_d0i3_enter(struct mei_device *dev)
 static int mei_me_d0i3_exit_sync(struct mei_device *dev)
 {
 	struct mei_me_hw *hw = to_me_hw(dev);
-	unsigned long timeout = mei_secs_to_jiffies(MEI_D0I3_TIMEOUT);
 	int ret;
 	u32 reg;
 
@@ -1013,7 +1013,8 @@ static int mei_me_d0i3_exit_sync(struct mei_device *dev)
 
 	mutex_unlock(&dev->device_lock);
 	wait_event_timeout(dev->wait_pg,
-		dev->pg_event == MEI_PG_EVENT_INTR_RECEIVED, timeout);
+		dev->pg_event == MEI_PG_EVENT_INTR_RECEIVED,
+		dev->timeouts.pgi);
 	mutex_lock(&dev->device_lock);
 
 	if (dev->pg_event != MEI_PG_EVENT_INTR_RECEIVED) {
@@ -1684,11 +1685,12 @@ EXPORT_SYMBOL_GPL(mei_me_get_cfg);
  *
  * @parent: device associated with physical device (pci/platform)
  * @cfg: per device generation config
+ * @slow_fw: configure longer timeouts as FW is slow
  *
  * Return: The mei_device pointer on success, NULL on failure.
  */
 struct mei_device *mei_me_dev_init(struct device *parent,
-				   const struct mei_cfg *cfg)
+				   const struct mei_cfg *cfg, bool slow_fw)
 {
 	struct mei_device *dev;
 	struct mei_me_hw *hw;
@@ -1703,7 +1705,7 @@ struct mei_device *mei_me_dev_init(struct device *parent,
 	for (i = 0; i < DMA_DSCR_NUM; i++)
 		dev->dr_dscr[i].size = cfg->dma_size[i];
 
-	mei_device_init(dev, parent, &mei_me_hw_ops);
+	mei_device_init(dev, parent, slow_fw, &mei_me_hw_ops);
 	hw->cfg = cfg;
 
 	dev->fw_f_fw_ver_supported = cfg->fw_ver_supported;
diff --git a/drivers/misc/mei/hw-me.h b/drivers/misc/mei/hw-me.h
index ca09274ac299..0e9d90808bcf 100644
--- a/drivers/misc/mei/hw-me.h
+++ b/drivers/misc/mei/hw-me.h
@@ -131,7 +131,7 @@ enum mei_cfg_idx {
 const struct mei_cfg *mei_me_get_cfg(kernel_ulong_t idx);
 
 struct mei_device *mei_me_dev_init(struct device *parent,
-				   const struct mei_cfg *cfg);
+				   const struct mei_cfg *cfg, bool slow_fw);
 
 int mei_me_pg_enter_sync(struct mei_device *dev);
 int mei_me_pg_exit_sync(struct mei_device *dev);
diff --git a/drivers/misc/mei/hw-txe.c b/drivers/misc/mei/hw-txe.c
index 00652c137cc7..fccfa806bd63 100644
--- a/drivers/misc/mei/hw-txe.c
+++ b/drivers/misc/mei/hw-txe.c
@@ -1201,7 +1201,7 @@ struct mei_device *mei_txe_dev_init(struct pci_dev *pdev)
 	if (!dev)
 		return NULL;
 
-	mei_device_init(dev, &pdev->dev, &mei_txe_hw_ops);
+	mei_device_init(dev, &pdev->dev, false, &mei_txe_hw_ops);
 
 	hw = to_txe_hw(dev);
 
diff --git a/drivers/misc/mei/hw.h b/drivers/misc/mei/hw.h
index b46077b17114..9381e5c13b4f 100644
--- a/drivers/misc/mei/hw.h
+++ b/drivers/misc/mei/hw.h
@@ -16,11 +16,16 @@
 #define MEI_CONNECT_TIMEOUT         3  /* HPS: at least 2 seconds */
 
 #define MEI_CL_CONNECT_TIMEOUT     15  /* HPS: Client Connect Timeout */
+#define MEI_CL_CONNECT_TIMEOUT_SLOW 30 /* HPS: Client Connect Timeout, slow FW */
 #define MEI_CLIENTS_INIT_TIMEOUT   15  /* HPS: Clients Enumeration Timeout */
 
 #define MEI_PGI_TIMEOUT             1  /* PG Isolation time response 1 sec */
 #define MEI_D0I3_TIMEOUT            5  /* D0i3 set/unset max response time */
 #define MEI_HBM_TIMEOUT             1  /* 1 second */
+#define MEI_HBM_TIMEOUT_SLOW        5  /* 5 second, slow FW */
+
+#define MKHI_RCV_TIMEOUT 500 /* receive timeout in msec */
+#define MKHI_RCV_TIMEOUT_SLOW 10000 /* receive timeout in msec, slow FW */
 
 /*
  * FW page size for DMA allocations
diff --git a/drivers/misc/mei/init.c b/drivers/misc/mei/init.c
index 5bb6ba662cc0..ce030a882d0c 100644
--- a/drivers/misc/mei/init.c
+++ b/drivers/misc/mei/init.c
@@ -359,14 +359,16 @@ bool mei_write_is_idle(struct mei_device *dev)
 EXPORT_SYMBOL_GPL(mei_write_is_idle);
 
 /**
- * mei_device_init  -- initialize mei_device structure
+ * mei_device_init - initialize mei_device structure
  *
  * @dev: the mei device
  * @device: the device structure
+ * @slow_fw: configure longer timeouts as FW is slow
  * @hw_ops: hw operations
  */
 void mei_device_init(struct mei_device *dev,
 		     struct device *device,
+		     bool slow_fw,
 		     const struct mei_hw_ops *hw_ops)
 {
 	/* setup our list array */
@@ -404,6 +406,21 @@ void mei_device_init(struct mei_device *dev,
 	dev->pg_event = MEI_PG_EVENT_IDLE;
 	dev->ops      = hw_ops;
 	dev->dev      = device;
+
+	dev->timeouts.hw_ready = mei_secs_to_jiffies(MEI_HW_READY_TIMEOUT);
+	dev->timeouts.connect = MEI_CONNECT_TIMEOUT;
+	dev->timeouts.client_init = MEI_CLIENTS_INIT_TIMEOUT;
+	dev->timeouts.pgi = mei_secs_to_jiffies(MEI_PGI_TIMEOUT);
+	dev->timeouts.d0i3 = mei_secs_to_jiffies(MEI_D0I3_TIMEOUT);
+	if (slow_fw) {
+		dev->timeouts.cl_connect = mei_secs_to_jiffies(MEI_CL_CONNECT_TIMEOUT_SLOW);
+		dev->timeouts.hbm = mei_secs_to_jiffies(MEI_HBM_TIMEOUT_SLOW);
+		dev->timeouts.mkhi_recv = msecs_to_jiffies(MKHI_RCV_TIMEOUT_SLOW);
+	} else {
+		dev->timeouts.cl_connect = mei_secs_to_jiffies(MEI_CL_CONNECT_TIMEOUT);
+		dev->timeouts.hbm = mei_secs_to_jiffies(MEI_HBM_TIMEOUT);
+		dev->timeouts.mkhi_recv = msecs_to_jiffies(MKHI_RCV_TIMEOUT);
+	}
 }
 EXPORT_SYMBOL_GPL(mei_device_init);
 
diff --git a/drivers/misc/mei/main.c b/drivers/misc/mei/main.c
index 786f7c8f7f61..261939b945ef 100644
--- a/drivers/misc/mei/main.c
+++ b/drivers/misc/mei/main.c
@@ -571,7 +571,7 @@ static int mei_ioctl_connect_vtag(struct file *file,
 				    cl->state == MEI_FILE_DISCONNECTED ||
 				    cl->state == MEI_FILE_DISCONNECT_REQUIRED ||
 				    cl->state == MEI_FILE_DISCONNECT_REPLY),
-				   mei_secs_to_jiffies(MEI_CL_CONNECT_TIMEOUT));
+				   dev->timeouts.cl_connect);
 		mutex_lock(&dev->device_lock);
 	}
 
diff --git a/drivers/misc/mei/mei_dev.h b/drivers/misc/mei/mei_dev.h
index 694f866f87ef..16f59b3a45fc 100644
--- a/drivers/misc/mei/mei_dev.h
+++ b/drivers/misc/mei/mei_dev.h
@@ -415,6 +415,17 @@ struct mei_fw_version {
 
 #define MEI_MAX_FW_VER_BLOCKS 3
 
+struct mei_dev_timeouts {
+	unsigned long hw_ready; /* Timeout on ready message, in jiffies */
+	int connect; /* HPS: at least 2 seconds, in seconds */
+	unsigned long cl_connect; /* HPS: Client Connect Timeout, in jiffies */
+	int client_init; /* HPS: Clients Enumeration Timeout, in seconds */
+	unsigned long pgi; /* PG Isolation time response, in jiffies */
+	unsigned int d0i3; /* D0i3 set/unset max response time, in jiffies */
+	unsigned long hbm; /* HBM operation timeout, in jiffies */
+	unsigned long mkhi_recv; /* receive timeout, in jiffies */
+};
+
 /**
  * struct mei_device -  MEI private device struct
  *
@@ -480,6 +491,8 @@ struct mei_fw_version {
  * @allow_fixed_address: allow user space to connect a fixed client
  * @override_fixed_address: force allow fixed address behavior
  *
+ * @timeouts: actual timeout values
+ *
  * @reset_work  : work item for the device reset
  * @bus_rescan_work : work item for the bus rescan
  *
@@ -568,6 +581,8 @@ struct mei_device {
 	bool allow_fixed_address;
 	bool override_fixed_address;
 
+	struct mei_dev_timeouts timeouts;
+
 	struct work_struct reset_work;
 	struct work_struct bus_rescan_work;
 
@@ -632,6 +647,7 @@ static inline u32 mei_slots2data(int slots)
  */
 void mei_device_init(struct mei_device *dev,
 		     struct device *device,
+		     bool slow_fw,
 		     const struct mei_hw_ops *hw_ops);
 int mei_reset(struct mei_device *dev);
 int mei_start(struct mei_device *dev);
diff --git a/drivers/misc/mei/pci-me.c b/drivers/misc/mei/pci-me.c
index 33e58821e478..0288784f8ffd 100644
--- a/drivers/misc/mei/pci-me.c
+++ b/drivers/misc/mei/pci-me.c
@@ -201,7 +201,7 @@ static int mei_me_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 
 	/* allocates and initializes the mei dev structure */
-	dev = mei_me_dev_init(&pdev->dev, cfg);
+	dev = mei_me_dev_init(&pdev->dev, cfg, false);
 	if (!dev) {
 		err = -ENOMEM;
 		goto end;
-- 
2.32.0

