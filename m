Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6784D08A6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 21:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236412AbiCGUm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 15:42:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbiCGUmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 15:42:25 -0500
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EFF87CDE5
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 12:41:30 -0800 (PST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3186C20021F;
        Mon,  7 Mar 2022 21:41:29 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id EE2ED202391;
        Mon,  7 Mar 2022 21:41:28 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.142])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 599E540591;
        Mon,  7 Mar 2022 13:41:28 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] memory: fsl_ifc: populate child nodes of buses and mfd devices
Date:   Mon,  7 Mar 2022 14:41:18 -0600
Message-Id: <20220307204118.19093-1-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 98f1323959b8 was trying to replace the "simple-bus" compatible
with explicit bus populate in the driver.  But of_platform_populate()
only populates child nodes of ifc without populating child buses and
child mfd devices residing under ifc.  Change it to
of_platform_default_populate() to fix the problem.

Fixes: 98f1323959b8 ("memory: fsl_ifc: populate child devices without relying on simple-bus")

Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 drivers/memory/fsl_ifc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/memory/fsl_ifc.c b/drivers/memory/fsl_ifc.c
index 6e6de52bb82d..1604de863d41 100644
--- a/drivers/memory/fsl_ifc.c
+++ b/drivers/memory/fsl_ifc.c
@@ -290,8 +290,7 @@ static int fsl_ifc_ctrl_probe(struct platform_device *dev)
 	}
 
 	/* legacy dts may still use "simple-bus" compatible */
-	ret = of_platform_populate(dev->dev.of_node, NULL, NULL,
-					&dev->dev);
+	ret = of_platform_default_populate(dev->dev.of_node, NULL, &dev->dev);
 	if (ret)
 		goto err_free_nandirq;
 
-- 
2.25.1

