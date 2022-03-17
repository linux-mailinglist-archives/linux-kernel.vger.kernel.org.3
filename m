Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AAF04DBCFA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 03:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352692AbiCQCbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 22:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbiCQCbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 22:31:22 -0400
Received: from mail.meizu.com (edge07.meizu.com [112.91.151.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0331D0DA
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 19:30:06 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail11.meizu.com
 (172.16.1.15) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 17 Mar
 2022 10:30:07 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Thu, 17 Mar
 2022 10:30:04 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     <benh@kernel.crashing.org>, <masahiroy@kernel.org>,
        <adobriyan@gmail.com>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        "Haowen Bai" <baihaowen@meizu.com>
Subject: [PATCH] macintosh: macio-adb: Fix warning comparing pointer to 0
Date:   Thu, 17 Mar 2022 10:30:01 +0800
Message-ID: <1647484201-11738-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid pointer type value compared with 0 to make code clear.

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 drivers/macintosh/macio-adb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/macintosh/macio-adb.c b/drivers/macintosh/macio-adb.c
index dc634c2..51afa46 100644
--- a/drivers/macintosh/macio-adb.c
+++ b/drivers/macintosh/macio-adb.c
@@ -97,7 +97,7 @@ int macio_init(void)
 	unsigned int irq;
 
 	adbs = of_find_compatible_node(NULL, "adb", "chrp,adb0");
-	if (adbs == 0)
+	if (!adbs)
 		return -ENXIO;
 
 	if (of_address_to_resource(adbs, 0, &r)) {
@@ -180,7 +180,7 @@ static int macio_send_request(struct adb_request *req, int sync)
 	req->reply_len = 0;
 
 	spin_lock_irqsave(&macio_lock, flags);
-	if (current_req != 0) {
+	if (current_req) {
 		last_req->next = req;
 		last_req = req;
 	} else {
@@ -210,7 +210,7 @@ static irqreturn_t macio_adb_interrupt(int irq, void *arg)
 	spin_lock(&macio_lock);
 	if (in_8(&adb->intr.r) & TAG) {
 		handled = 1;
-		if ((req = current_req) != 0) {
+		req = current_req;
+		if (req) {
 			/* put the current request in */
 			for (i = 0; i < req->nbytes; ++i)
 				out_8(&adb->data[i].r, req->data[i]);
-- 
2.7.4

