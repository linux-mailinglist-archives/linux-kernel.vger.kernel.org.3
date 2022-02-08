Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA3894AD987
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 14:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350712AbiBHNUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 08:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245690AbiBHMmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 07:42:45 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF99AC03FEC0;
        Tue,  8 Feb 2022 04:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=qti.qualcomm.com; i=@qti.qualcomm.com; q=dns/txt;
  s=qcdkim; t=1644324165; x=1675860165;
  h=from:to:cc:subject:date:message-id;
  bh=2RhWuRylgy7FQta6UTPTHtX3kQLdhFq81B4ywAgmIdE=;
  b=JZ6o8zMW0F/HcmLR4UjHYicVC+1lIscZLIaRmyIGZ6FGRwy8P/4HlyGd
   USwlz+07J7Ks+0ZaTxmLhl94bq0KXlosOEw1LrqzerKa0ZdrLh5p/vTjc
   2P3cROPLjQgKdNXwK7sDn1oWDz/q2j5gQaVmq+K601+43Nuew7UEfS9pb
   g=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 08 Feb 2022 04:42:44 -0800
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 08 Feb 2022 04:42:43 -0800
X-QCInternal: smtphost
Received: from hu-dikshita-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.110.13])
  by ironmsg02-blr.qualcomm.com with ESMTP; 08 Feb 2022 18:12:34 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 347544)
        id 54F624567; Tue,  8 Feb 2022 18:12:33 +0530 (+0530)
From:   Dikshita Agarwal <dikshita@qti.qualcomm.com>
To:     hverkuil-cisco@xs4all.nl
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        vgarodia@codeaurora.org,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>
Subject: [PATCH v2] Add check for READ ONLY flag
Date:   Tue,  8 Feb 2022 18:12:21 +0530
Message-Id: <1644324141-27180-1-git-send-email-dikshita@qti.qualcomm.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dikshita Agarwal <quic_dikshita@quicinc.com>

Add a check for V4L2_CTRL_FLAG_READ_ONLY to avoid request
testing for such controls.

Signed-off-by: Dikshita Agarwal <dikshita@qti.qualcomm.com>
---
 utils/v4l2-compliance/v4l2-test-buffers.cpp | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/utils/v4l2-compliance/v4l2-test-buffers.cpp b/utils/v4l2-compliance/v4l2-test-buffers.cpp
index fa8c37c..b8de7af 100644
--- a/utils/v4l2-compliance/v4l2-test-buffers.cpp
+++ b/utils/v4l2-compliance/v4l2-test-buffers.cpp
@@ -2032,7 +2032,8 @@ int testRequests(struct node *node, bool test_streaming)
 		if (qctrl.type != V4L2_CTRL_TYPE_INTEGER &&
 		    qctrl.type != V4L2_CTRL_TYPE_BOOLEAN)
 			continue;
-		if (qctrl.flags & V4L2_CTRL_FLAG_WRITE_ONLY)
+		if (qctrl.flags & V4L2_CTRL_FLAG_WRITE_ONLY ||
+		    qctrl.flags & V4L2_CTRL_FLAG_READ_ONLY)
 			continue;
 		if (is_vivid && V4L2_CTRL_ID2WHICH(qctrl.id) == V4L2_CTRL_CLASS_VIVID)
 			continue;
-- 
2.7.4

