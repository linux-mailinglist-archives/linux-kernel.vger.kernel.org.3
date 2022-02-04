Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617654A9420
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 07:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245252AbiBDGsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 01:48:22 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:41231 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233514AbiBDGsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 01:48:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643957302; x=1675493302;
  h=from:to:cc:subject:date:message-id;
  bh=Kt8D96RsK5xOLidpkHnApgmeuBtb1rh/8v+/7rQ1d3M=;
  b=kUna3YKbfOjLz7F40RbD46PKTtsUyykEOAqrdTZGXPFXB7YrEsjtgpvl
   mNiFuJBJ6r8Zu0spCmo0PeoKYqh6PWloFz3mhmhFTNqeYPH0++dWFWiEZ
   OGk7JUFAeD+t+rmTdQFB+ufu3+06T4e68pl+At86Axd06qklvDZwuDwFE
   g=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 03 Feb 2022 22:48:22 -0800
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 03 Feb 2022 22:48:05 -0800
X-QCInternal: smtphost
Received: from hu-dikshita-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.110.13])
  by ironmsg02-blr.qualcomm.com with ESMTP; 04 Feb 2022 12:17:58 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 347544)
        id 484CF3BED; Fri,  4 Feb 2022 12:17:57 +0530 (+0530)
From:   Dikshita Agarwal <quic_dikshita@quicinc.com>
To:     hverkuil-cisco@xs4all.nl
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        vgarodia@codeaurora.org,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
Subject: [PATCH] Add check for READ ONLY flag
Date:   Fri,  4 Feb 2022 12:17:48 +0530
Message-Id: <1643957268-6365-1-git-send-email-quic_dikshita@quicinc.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a check for V4L2_CTRL_FLAG_READ_ONLY to avoid request
testing for such controls.
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

