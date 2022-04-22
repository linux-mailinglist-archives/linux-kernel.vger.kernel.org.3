Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6CD50B400
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 11:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445978AbiDVJ2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 05:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445980AbiDVJ2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 05:28:47 -0400
Received: from mail.meizu.com (edge07.meizu.com [112.91.151.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F4C506D4;
        Fri, 22 Apr 2022 02:25:53 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail11.meizu.com
 (172.16.1.15) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 22 Apr
 2022 17:25:47 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Fri, 22 Apr
 2022 17:25:45 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC:     Haowen Bai <baihaowen@meizu.com>, <linux-input@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] Input: Remove duplicated condition
Date:   Fri, 22 Apr 2022 17:25:43 +0800
Message-ID: <1650619544-3741-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the duplicated condition, and make code clear.

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 drivers/input/mouse/hgpk.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/input/mouse/hgpk.c b/drivers/input/mouse/hgpk.c
index 4dc441309aac..7c6b669b687f 100644
--- a/drivers/input/mouse/hgpk.c
+++ b/drivers/input/mouse/hgpk.c
@@ -611,9 +611,7 @@ static int hgpk_reset_device(struct psmouse *psmouse, bool recalibrate)
 
 		/* send the recalibrate request */
 		if (ps2_command(ps2dev, NULL, 0xf5) ||
-		    ps2_command(ps2dev, NULL, 0xf5) ||
-		    ps2_command(ps2dev, NULL, 0xe6) ||
-		    ps2_command(ps2dev, NULL, 0xf5)) {
+		    ps2_command(ps2dev, NULL, 0xe6)) {
 			return -1;
 		}
 
@@ -728,7 +726,6 @@ static int hgpk_toggle_powersave(struct psmouse *psmouse, int enable)
 		psmouse_dbg(psmouse, "Powering off touchpad.\n");
 
 		if (ps2_command(ps2dev, NULL, 0xec) ||
-		    ps2_command(ps2dev, NULL, 0xec) ||
 		    ps2_command(ps2dev, NULL, 0xea)) {
 			return -1;
 		}
-- 
2.7.4

