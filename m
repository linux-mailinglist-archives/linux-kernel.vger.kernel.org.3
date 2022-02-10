Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F22AA4B0B7F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 11:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240347AbiBJKzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 05:55:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240231AbiBJKzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 05:55:31 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B507FF0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 02:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644490532; x=1676026532;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kNx55RY7X0IIBJcH0/hbI5dhEt5+Ybz6eMFNnHsll1c=;
  b=lGNllV4LVTI37ag/0cbn/MP9urenTROGyDFnAbWNFDtoCkgqGnHskRPa
   ZS2s17vu2UBGCqnAMQK0IZmmr+UlaNhWNfggcljne+DuLq82WPhujVzI1
   BwKtg/SAsWcF4I2/cceZ5X38R9FFcn9qrpVfWW7kAvVR0P/DCX1PWj+Dt
   gQF/V98oLiZvzNJjukPR4gklqJi2HdK8UhdqDAVkh1qaoV6pVoaflTGj/
   cVwVgmU3pdPKc4cedy6XJUk93eY8OvRDG6R1zvRZDFNwYLkk5XBetp4P3
   7alMnexn0xfW/SFZRJIX9JZXNVG1uyuBS2q5C00uGZAKgGSMHenMCltt6
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="310202848"
X-IronPort-AV: E=Sophos;i="5.88,358,1635231600"; 
   d="scan'208";a="310202848"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 02:55:32 -0800
X-IronPort-AV: E=Sophos;i="5.88,358,1635231600"; 
   d="scan'208";a="679106849"
Received: from barabano-mobl.ccr.corp.intel.com (HELO pujfalus-desk.ger.corp.intel.com) ([10.252.41.18])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 02:55:29 -0800
From:   Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To:     lgirdwood@gmail.com, broonie@kernel.org,
        pierre-louis.bossart@linux.intel.com,
        ranjani.sridharan@linux.intel.com
Cc:     alsa-devel@alsa-project.org, kai.vehmanen@linux.intel.com,
        daniel.baluta@nxp.com, tiwai@suse.com,
        linux-kernel@vger.kernel.org, fred.oh@linux.intel.com
Subject: [PATCH 3/9] ASoC: SOF: ipc: Read and pass the whole message to handlers for IPC events
Date:   Thu, 10 Feb 2022 12:55:13 +0200
Message-Id: <20220210105519.19795-4-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220210105519.19795-1-peter.ujfalusi@linux.intel.com>
References: <20220210105519.19795-1-peter.ujfalusi@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the parameter list for the firmware initiated message (IPC event)
handler functions to:
handler(struct snd_sof_dev *sdev, void *full_msg);

Allocate memory and read the whole message in snd_sof_ipc_msgs_rx() then
pass the pointer to the function handling the message.
Do this only if we actually have a function which is tasked to process the
given type.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/soc/sof/ipc.c | 85 +++++++++++++++++++++++----------------------
 1 file changed, 44 insertions(+), 41 deletions(-)

diff --git a/sound/soc/sof/ipc.c b/sound/soc/sof/ipc.c
index 16a0d7a059f3..ee56d4fa4053 100644
--- a/sound/soc/sof/ipc.c
+++ b/sound/soc/sof/ipc.c
@@ -18,8 +18,10 @@
 #include "sof-audio.h"
 #include "ops.h"
 
-static void ipc_trace_message(struct snd_sof_dev *sdev, u32 msg_type);
-static void ipc_stream_message(struct snd_sof_dev *sdev, u32 msg_cmd);
+typedef void (*ipc_rx_callback)(struct snd_sof_dev *sdev, void *msg_buf);
+
+static void ipc_trace_message(struct snd_sof_dev *sdev, void *msg_buf);
+static void ipc_stream_message(struct snd_sof_dev *sdev, void *msg_buf);
 
 /*
  * IPC message Tx/Rx message handling.
@@ -477,44 +479,30 @@ void snd_sof_ipc_reply(struct snd_sof_dev *sdev, u32 msg_id)
 }
 EXPORT_SYMBOL(snd_sof_ipc_reply);
 
-static void ipc_comp_notification(struct snd_sof_dev *sdev,
-				  struct sof_ipc_cmd_hdr *hdr)
+static void ipc_comp_notification(struct snd_sof_dev *sdev, void *msg_buf)
 {
+	struct sof_ipc_cmd_hdr *hdr = msg_buf;
 	u32 msg_type = hdr->cmd & SOF_CMD_TYPE_MASK;
-	struct sof_ipc_ctrl_data *cdata;
-	int ret;
 
 	switch (msg_type) {
 	case SOF_IPC_COMP_GET_VALUE:
 	case SOF_IPC_COMP_GET_DATA:
-		cdata = kmalloc(hdr->size, GFP_KERNEL);
-		if (!cdata)
-			return;
-
-		/* read back full message */
-		ret = snd_sof_ipc_msg_data(sdev, NULL, cdata, hdr->size);
-		if (ret < 0) {
-			dev_err(sdev->dev,
-				"error: failed to read component event: %d\n", ret);
-			goto err;
-		}
 		break;
 	default:
 		dev_err(sdev->dev, "error: unhandled component message %#x\n", msg_type);
 		return;
 	}
 
-	snd_sof_control_notify(sdev, cdata);
-
-err:
-	kfree(cdata);
+	snd_sof_control_notify(sdev, msg_buf);
 }
 
 /* DSP firmware has sent host a message  */
 void snd_sof_ipc_msgs_rx(struct snd_sof_dev *sdev)
 {
+	ipc_rx_callback rx_callback = NULL;
 	struct sof_ipc_cmd_hdr hdr;
-	u32 cmd, type;
+	void *msg_buf;
+	u32 cmd;
 	int err;
 
 	/* read back header */
@@ -523,10 +511,15 @@ void snd_sof_ipc_msgs_rx(struct snd_sof_dev *sdev)
 		dev_warn(sdev->dev, "failed to read IPC header: %d\n", err);
 		return;
 	}
+
+	if (hdr.size < sizeof(hdr)) {
+		dev_err(sdev->dev, "The received message size is invalid\n");
+		return;
+	}
+
 	ipc_log_header(sdev->dev, "ipc rx", hdr.cmd);
 
 	cmd = hdr.cmd & SOF_GLB_TYPE_MASK;
-	type = hdr.cmd & SOF_CMD_TYPE_MASK;
 
 	/* check message type */
 	switch (cmd) {
@@ -551,20 +544,35 @@ void snd_sof_ipc_msgs_rx(struct snd_sof_dev *sdev)
 	case SOF_IPC_GLB_PM_MSG:
 		break;
 	case SOF_IPC_GLB_COMP_MSG:
-		ipc_comp_notification(sdev, &hdr);
+		rx_callback = ipc_comp_notification;
 		break;
 	case SOF_IPC_GLB_STREAM_MSG:
-		/* need to pass msg id into the function */
-		ipc_stream_message(sdev, hdr.cmd);
+		rx_callback = ipc_stream_message;
 		break;
 	case SOF_IPC_GLB_TRACE_MSG:
-		ipc_trace_message(sdev, type);
+		rx_callback = ipc_trace_message;
 		break;
 	default:
-		dev_err(sdev->dev, "error: unknown DSP message 0x%x\n", cmd);
+		dev_err(sdev->dev, "%s: Unknown DSP message: 0x%x\n", __func__, cmd);
 		break;
 	}
 
+	if (rx_callback) {
+		/* read the full message as we have rx handler for it */
+		msg_buf = kmalloc(hdr.size, GFP_KERNEL);
+		if (!msg_buf)
+			return;
+
+		err = snd_sof_ipc_msg_data(sdev, NULL, msg_buf, hdr.size);
+		if (err < 0)
+			dev_err(sdev->dev, "%s: Failed to read message: %d\n",
+				__func__, err);
+		else
+			rx_callback(sdev, msg_buf);
+
+		kfree(msg_buf);
+	}
+
 	ipc_log_header(sdev->dev, "ipc rx done", hdr.cmd);
 }
 EXPORT_SYMBOL(snd_sof_ipc_msgs_rx);
@@ -573,19 +581,14 @@ EXPORT_SYMBOL(snd_sof_ipc_msgs_rx);
  * IPC trace mechanism.
  */
 
-static void ipc_trace_message(struct snd_sof_dev *sdev, u32 msg_type)
+static void ipc_trace_message(struct snd_sof_dev *sdev, void *msg_buf)
 {
-	struct sof_ipc_dma_trace_posn posn;
-	int ret;
+	struct sof_ipc_cmd_hdr *hdr = msg_buf;
+	u32 msg_type = hdr->cmd & SOF_CMD_TYPE_MASK;
 
 	switch (msg_type) {
 	case SOF_IPC_TRACE_DMA_POSITION:
-		/* read back full message */
-		ret = snd_sof_ipc_msg_data(sdev, NULL, &posn, sizeof(posn));
-		if (ret < 0)
-			dev_warn(sdev->dev, "failed to read trace position: %d\n", ret);
-		else
-			snd_sof_trace_update_pos(sdev, &posn);
+		snd_sof_trace_update_pos(sdev, msg_buf);
 		break;
 	default:
 		dev_err(sdev->dev, "error: unhandled trace message %#x\n", msg_type);
@@ -667,11 +670,11 @@ static void ipc_xrun(struct snd_sof_dev *sdev, u32 msg_id)
 }
 
 /* stream notifications from DSP FW */
-static void ipc_stream_message(struct snd_sof_dev *sdev, u32 msg_cmd)
+static void ipc_stream_message(struct snd_sof_dev *sdev, void *msg_buf)
 {
-	/* get msg cmd type and msd id */
-	u32 msg_type = msg_cmd & SOF_CMD_TYPE_MASK;
-	u32 msg_id = SOF_IPC_MESSAGE_ID(msg_cmd);
+	struct sof_ipc_cmd_hdr *hdr = msg_buf;
+	u32 msg_type = hdr->cmd & SOF_CMD_TYPE_MASK;
+	u32 msg_id = SOF_IPC_MESSAGE_ID(hdr->cmd);
 
 	switch (msg_type) {
 	case SOF_IPC_STREAM_POSITION:
-- 
2.35.1

