Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F2D4D5D94
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 09:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbiCKIgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 03:36:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiCKIgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 03:36:38 -0500
Received: from mail.meizu.com (edge05.meizu.com [157.122.146.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C271BA14B
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 00:35:34 -0800 (PST)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail12.meizu.com
 (172.16.1.108) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 11 Mar
 2022 16:35:34 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Fri, 11 Mar
 2022 16:35:32 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     <vireshk@kernel.org>, <johan@kernel.org>, <elder@kernel.org>,
        <gregkh@linuxfoundation.org>
CC:     <linux-staging@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        "Haowen Bai" <baihaowen@meizu.com>
Subject: [PATCH] staging: greybus: Fix potential NULL dereference
Date:   Fri, 11 Mar 2022 16:35:30 +0800
Message-ID: <1646987730-7597-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix following coccicheck warning:
drivers/staging/greybus/bootrom.c:301:35-39: ERROR: fw is NULL but dereferenced.

When goto queue_work but dereference Uninitialized fw will trigger a NULL 
dereference.

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 drivers/staging/greybus/bootrom.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/greybus/bootrom.c b/drivers/staging/greybus/bootrom.c
index a8efb86..6f3926b 100644
--- a/drivers/staging/greybus/bootrom.c
+++ b/drivers/staging/greybus/bootrom.c
@@ -252,14 +252,6 @@ static int gb_bootrom_get_firmware(struct gb_operation *op)
 	/* Disable timeouts */
 	gb_bootrom_cancel_timeout(bootrom);
 
-	if (op->request->payload_size != sizeof(*firmware_request)) {
-		dev_err(dev, "%s: Illegal size of get firmware request (%zu %zu)\n",
-			__func__, op->request->payload_size,
-			sizeof(*firmware_request));
-		ret = -EINVAL;
-		goto queue_work;
-	}
-
 	mutex_lock(&bootrom->mutex);
 
 	fw = bootrom->fw;
@@ -269,6 +261,15 @@ static int gb_bootrom_get_firmware(struct gb_operation *op)
 		goto unlock;
 	}
 
+	if (op->request->payload_size != sizeof(*firmware_request)) {
+		dev_err(dev, "%s: Illegal size of get firmware request (%zu %zu)\n",
+			__func__, op->request->payload_size,
+			sizeof(*firmware_request));
+		ret = -EINVAL;
+		mutex_unlock(&bootrom->mutex);
+		goto queue_work;
+	}
+
 	firmware_request = op->request->payload;
 	offset = le32_to_cpu(firmware_request->offset);
 	size = le32_to_cpu(firmware_request->size);
-- 
2.7.4

