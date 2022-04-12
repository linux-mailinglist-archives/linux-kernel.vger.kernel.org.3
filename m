Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F154FE271
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 15:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348251AbiDLNZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 09:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356037AbiDLNY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 09:24:57 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF4D3C4A9;
        Tue, 12 Apr 2022 06:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649769334; x=1681305334;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=Q7iWkEWIdBwMq/H4dYnh9ITsKreitgfNDb9VSXaQlow=;
  b=jtZRV8iHyNOlgV62DiohSsfe5aNnLJCCqSwgXJbBSeMmSCXPecB2g24e
   LfYIQ8JC47RFkDkOXtjn3bSGGal/av59Zu3EQImKnT5zEX1Qois7E5TWt
   Do0WBIMBJAADkpZn/hjz+ucJjKM02DScr5PTS5Gdi85O7QdP76MoawcgF
   8=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 12 Apr 2022 06:15:34 -0700
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 06:15:33 -0700
Received: from hu-vgarodia-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 12 Apr 2022 06:15:31 -0700
From:   Vikash Garodia <quic_vgarodia@quicinc.com>
To:     <linux-media@vger.kernel.org>, <stanimir.varbanov@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <quic_vgarodia@quicinc.com>
Subject: [PATCH v2 2/2] media: venus: vdec: ensure venus is powered on during stream off
Date:   Tue, 12 Apr 2022 18:45:11 +0530
Message-ID: <1649769311-22622-3-git-send-email-quic_vgarodia@quicinc.com>
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

Video decoder driver auto-suspends the hardware if there is no
exchange of command or response for certain amount of time.
In auto suspended state, it becomes mandatory to power on the
hardware before requesting it to process a command. The fix
ensures the hardware is powered on during stop streaming.

Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
Acked-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/media/platform/qcom/venus/vdec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index 91da3f5..4ac1132 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -1200,6 +1200,8 @@ static void vdec_stop_streaming(struct vb2_queue *q)
 	struct venus_inst *inst = vb2_get_drv_priv(q);
 	int ret = -EINVAL;
 
+	vdec_pm_get_put(inst);
+
 	mutex_lock(&inst->lock);
 
 	if (q->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

