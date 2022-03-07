Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 500804D00F0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 15:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243135AbiCGORd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 09:17:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243085AbiCGORQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 09:17:16 -0500
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF22F8EB5A;
        Mon,  7 Mar 2022 06:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1646662581;
  x=1678198581;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S1wiQhSXl03OwHvB8odQNz0Ply4j8QcaKLui++yLhe4=;
  b=BPr/K5LvQuwJe6dclwyrqoCcn98LxWG5AQhQj83NAh03hECgRO3FVtJW
   7FEXhunP/z2DDHsdPhY7vivqWaiCFQ77dWw/LNoLplkkr0r2twUt4TtJH
   NzYQFP2cZcOKHhRTf/PgzH1wvawShrDglGYu0oYOK3hJ+XS/O1m0wf/c5
   Pvwbt+1nSEy76qxe0QLjrfVQRSnGs5QdMsctrv8rjhE0OIujpjJrpZRSt
   yd70BDHIO5YBUAgTXTbCAuIwGftF7mIdVx/yIyqqf354cOWMuhpLdfu4v
   gsfcFFDIjqusgCCVtTn60rQYwmmTkMPpeD2bjlIguD9s5hBmmrMAf9nru
   g==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <vigneshr@ti.com>, <richard@nod.at>, <miquel.raynal@bootlin.com>,
        <joern@lazybastard.org>
CC:     <kernel@axis.com>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <frowand.list@gmail.com>, <krzysztof.kozlowski@canonical.com>,
        <robh+dt@kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: [PATCH 4/4] mtd: phram: Allow cached mappings
Date:   Mon, 7 Mar 2022 15:15:49 +0100
Message-ID: <20220307141549.2732179-5-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220307141549.2732179-1-vincent.whitchurch@axis.com>
References: <20220307141549.2732179-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently phram always uses ioremap(), but this is unnecessary when
normal memory is used.  If the reserved-memory node does not specify the
no-map property, indicating it should be mapped as system RAM and
ioremap() cannot be used on it, use a cached mapping using
memremap(MEMREMAP_WB) instead.

On one of my systems this improves read performance by ~70%.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/mtd/devices/phram.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/devices/phram.c b/drivers/mtd/devices/phram.c
index 6dfe9401a3c5..ac2679f9031a 100644
--- a/drivers/mtd/devices/phram.c
+++ b/drivers/mtd/devices/phram.c
@@ -34,6 +34,7 @@
 struct phram_mtd_list {
 	struct mtd_info mtd;
 	struct list_head list;
+	bool cached;
 };
 
 static LIST_HEAD(phram_list);
@@ -96,6 +97,7 @@ static int register_device(struct platform_device *pdev, const char *name,
 			   phys_addr_t start, size_t len, uint32_t erasesize)
 {
 	struct device_node *np = pdev ? pdev->dev.of_node : NULL;
+	bool cached = np ? !of_property_read_bool(np, "no-map") : false;
 	struct phram_mtd_list *new;
 	int ret = -ENOMEM;
 
@@ -103,8 +105,13 @@ static int register_device(struct platform_device *pdev, const char *name,
 	if (!new)
 		goto out0;
 
+	new->cached = cached;
+
 	ret = -EIO;
-	new->mtd.priv = ioremap(start, len);
+	if (cached)
+		new->mtd.priv = memremap(start, len, MEMREMAP_WB);
+	else
+		new->mtd.priv = ioremap(start, len);
 	if (!new->mtd.priv) {
 		pr_err("ioremap failed\n");
 		goto out1;
@@ -140,7 +147,7 @@ static int register_device(struct platform_device *pdev, const char *name,
 	return 0;
 
 out2:
-	iounmap(new->mtd.priv);
+	cached ? memunmap(new->mtd.priv) : iounmap(new->mtd.priv);
 out1:
 	kfree(new);
 out0:
@@ -362,7 +369,7 @@ static int phram_remove(struct platform_device *pdev)
 	struct phram_mtd_list *phram = platform_get_drvdata(pdev);
 
 	mtd_device_unregister(&phram->mtd);
-	iounmap(phram->mtd.priv);
+	phram->cached ? memunmap(phram->mtd.priv) : iounmap(phram->mtd.priv);
 	kfree(phram);
 
 	return 0;
-- 
2.34.1

