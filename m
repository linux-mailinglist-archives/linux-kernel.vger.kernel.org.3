Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8CBE58BCFE
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 23:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbiHGVVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 17:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiHGVVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 17:21:01 -0400
Received: from smtp.smtpout.orange.fr (smtp-12.smtpout.orange.fr [80.12.242.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924B8F3C
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 14:21:00 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id KnhdoqJG19qatKnhdouq0Z; Sun, 07 Aug 2022 23:20:58 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 07 Aug 2022 23:20:58 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-mtd@lists.infradead.org
Subject: [PATCH] mtd: rawnand: orion: Use devm_clk_get_optional()
Date:   Sun,  7 Aug 2022 23:20:51 +0200
Message-Id: <a5bde48e3e1165dd65d1d1c1739e03ace1bef5d3.1659907229.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_clk_get_optional() instead of hand writing it.

While at it, use dev_err_probe() to further simplify the code. This is also
less verbose if clk_get() returns -EPROBE_DEFER.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/mtd/nand/raw/orion_nand.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/mtd/nand/raw/orion_nand.c b/drivers/mtd/nand/raw/orion_nand.c
index 2c87c7d89205..1bfecf502216 100644
--- a/drivers/mtd/nand/raw/orion_nand.c
+++ b/drivers/mtd/nand/raw/orion_nand.c
@@ -170,18 +170,11 @@ static int __init orion_nand_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, info);
 
-	/* Not all platforms can gate the clock, so it is not
-	   an error if the clock does not exists. */
-	info->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(info->clk)) {
-		ret = PTR_ERR(info->clk);
-		if (ret == -ENOENT) {
-			info->clk = NULL;
-		} else {
-			dev_err(&pdev->dev, "failed to get clock!\n");
-			return ret;
-		}
-	}
+	/* Not all platforms can gate the clock, so it is optional. */
+	info->clk = devm_clk_get_optional(&pdev->dev, NULL);
+	if (IS_ERR(info->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(info->clk),
+				     "failed to get clock!\n");
 
 	ret = clk_prepare_enable(info->clk);
 	if (ret) {
-- 
2.34.1

