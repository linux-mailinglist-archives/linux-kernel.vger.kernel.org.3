Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D374FE29B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 15:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355796AbiDLNZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 09:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356031AbiDLNY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 09:24:57 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE243134D;
        Tue, 12 Apr 2022 06:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649769330; x=1681305330;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=rdlamBty3xnTdbqFu5TFXF+lmSyntbHoVwqIuXriL1c=;
  b=Ze0Bd0ON/Yj4dzaBOa35/HHDk89SfDa8vmDk1pCRHXE1TPXj4oMba3G0
   MNA4NaP939ZcvXAISk64LHQl70/ndQpP7oWfvVofqy+40mMEmFi1XLZIX
   L6dYkBBClDQhUwcUc3FOvIMp/+0/hOtYX9EaP1qMPxz9LmoWXF/S4GVxP
   I=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 12 Apr 2022 06:15:30 -0700
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 06:15:29 -0700
Received: from hu-vgarodia-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 12 Apr 2022 06:15:28 -0700
From:   Vikash Garodia <quic_vgarodia@quicinc.com>
To:     <linux-media@vger.kernel.org>, <stanimir.varbanov@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <quic_vgarodia@quicinc.com>
Subject: [PATCH v2 1/2] media: venus: do not queue internal buffers from previous sequence
Date:   Tue, 12 Apr 2022 18:45:10 +0530
Message-ID: <1649769311-22622-2-git-send-email-quic_vgarodia@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1649769311-22622-1-git-send-email-quic_vgarodia@quicinc.com>
References: <1649769311-22622-1-git-send-email-quic_vgarodia@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During reconfig (DRC) event from firmware, it is not guaranteed that
all the DPB(internal) buffers would be released by the firmware. Some
buffers might be released gradually while processing frames from the
new sequence. These buffers now stay idle in the dpblist.
In subsequent call to queue the DPBs to firmware, these idle buffers
should not be queued. The fix identifies those buffers and free them.

Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
Acked-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/media/platform/qcom/venus/helpers.c | 34 +++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
index 0bca95d..fa01edd 100644
--- a/drivers/media/platform/qcom/venus/helpers.c
+++ b/drivers/media/platform/qcom/venus/helpers.c
@@ -90,12 +90,28 @@ bool venus_helper_check_codec(struct venus_inst *inst, u32 v4l2_pixfmt)
 }
 EXPORT_SYMBOL_GPL(venus_helper_check_codec);
 
+static void free_dpb_buf(struct venus_inst *inst, struct intbuf *buf)
+{
+	ida_free(&inst->dpb_ids, buf->dpb_out_tag);
+
+	list_del_init(&buf->list);
+	dma_free_attrs(inst->core->dev, buf->size, buf->va, buf->da,
+		       buf->attrs);
+	kfree(buf);
+}
+
 int venus_helper_queue_dpb_bufs(struct venus_inst *inst)
 {
-	struct intbuf *buf;
+	struct intbuf *buf, *next;
+	unsigned int dpb_size = 0;
 	int ret = 0;
 
-	list_for_each_entry(buf, &inst->dpbbufs, list) {
+	if (inst->dpb_buftype == HFI_BUFFER_OUTPUT)
+		dpb_size = inst->output_buf_size;
+	else if (inst->dpb_buftype == HFI_BUFFER_OUTPUT2)
+		dpb_size = inst->output2_buf_size;
+
+	list_for_each_entry_safe(buf, next, &inst->dpbbufs, list) {
 		struct hfi_frame_data fdata;
 
 		memset(&fdata, 0, sizeof(fdata));
@@ -106,6 +122,12 @@ int venus_helper_queue_dpb_bufs(struct venus_inst *inst)
 		if (buf->owned_by == FIRMWARE)
 			continue;
 
+		/* free buffer from previous sequence which was released later */
+		if (dpb_size > buf->size) {
+			free_dpb_buf(inst, buf);
+			continue;
+		}
+
 		fdata.clnt_data = buf->dpb_out_tag;
 
 		ret = hfi_session_process_buf(inst, &fdata);
@@ -127,13 +149,7 @@ int venus_helper_free_dpb_bufs(struct venus_inst *inst)
 	list_for_each_entry_safe(buf, n, &inst->dpbbufs, list) {
 		if (buf->owned_by == FIRMWARE)
 			continue;
-
-		ida_free(&inst->dpb_ids, buf->dpb_out_tag);
-
-		list_del_init(&buf->list);
-		dma_free_attrs(inst->core->dev, buf->size, buf->va, buf->da,
-			       buf->attrs);
-		kfree(buf);
+		free_dpb_buf(inst, buf);
 	}
 
 	if (list_empty(&inst->dpbbufs))
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

