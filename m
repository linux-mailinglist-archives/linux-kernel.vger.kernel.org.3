Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1FA4DBD2C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 03:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358515AbiCQCmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 22:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358517AbiCQCmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 22:42:04 -0400
Received: from mail.meizu.com (unknown [14.29.68.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F318320F5A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 19:40:40 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail04.meizu.com
 (172.16.1.16) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 17 Mar
 2022 10:40:40 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Thu, 17 Mar
 2022 10:40:38 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     <benh@kernel.crashing.org>, <masahiroy@kernel.org>,
        <adobriyan@gmail.com>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        "Haowen Bai" <baihaowen@meizu.com>
Subject: [PATCH] macintosh: via-cuda: Fix warning comparing pointer to 0
Date:   Thu, 17 Mar 2022 10:40:37 +0800
Message-ID: <1647484837-14352-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid pointer type value compared with 0 to make code clear.

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 drivers/macintosh/via-cuda.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/macintosh/via-cuda.c b/drivers/macintosh/via-cuda.c
index cd267392..05a3cd9 100644
--- a/drivers/macintosh/via-cuda.c
+++ b/drivers/macintosh/via-cuda.c
@@ -236,10 +236,10 @@ int __init find_via_cuda(void)
     const u32 *reg;
     int err;
 
-    if (vias != 0)
+    if (vias)
 	return 1;
     vias = of_find_node_by_name(NULL, "via-cuda");
-    if (vias == 0)
+    if (!vias)
 	return 0;
 
     reg = of_get_property(vias, "reg", NULL);
@@ -517,7 +517,7 @@ cuda_write(struct adb_request *req)
     req->reply_len = 0;
 
     spin_lock_irqsave(&cuda_lock, flags);
-    if (current_req != 0) {
+    if (current_req) {
 	last_req->next = req;
 	last_req = req;
     } else {
-- 
2.7.4

