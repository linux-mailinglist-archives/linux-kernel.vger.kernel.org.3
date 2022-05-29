Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBCA4537003
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 08:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiE2GcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 02:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiE2GcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 02:32:04 -0400
Received: from smtp.smtpout.orange.fr (smtp01.smtpout.orange.fr [80.12.242.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9B7186DB
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 23:32:01 -0700 (PDT)
Received: from pop-os.home ([90.11.191.102])
        by smtp.orange.fr with ESMTPA
        id vCSxn3NPl3JPEvCSxnMxa6; Sun, 29 May 2022 08:31:59 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 29 May 2022 08:31:59 +0200
X-ME-IP: 90.11.191.102
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Mark Brown <broonie@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-spi@vger.kernel.org
Subject: [PATCH] spi: spi-altera-dfl: Fix an error handling path
Date:   Sun, 29 May 2022 08:31:53 +0200
Message-Id: <0607bb59f4073f86abe5c585d35245aef0b045c6.1653805901.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The spi_alloc_master() call is not undone in all error handling paths.
Moreover, there is no .remove function to release the allocated memory.

In order to fix both this issues, switch to devm_spi_alloc_master().

This allows further simplification of the probe.

Fixes: ba2fc167e944 ("spi: altera: Add DFL bus driver for Altera API Controller")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/spi/spi-altera-dfl.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-altera-dfl.c b/drivers/spi/spi-altera-dfl.c
index ca40923258af..596e181ae136 100644
--- a/drivers/spi/spi-altera-dfl.c
+++ b/drivers/spi/spi-altera-dfl.c
@@ -128,9 +128,9 @@ static int dfl_spi_altera_probe(struct dfl_device *dfl_dev)
 	struct spi_master *master;
 	struct altera_spi *hw;
 	void __iomem *base;
-	int err = -ENODEV;
+	int err;
 
-	master = spi_alloc_master(dev, sizeof(struct altera_spi));
+	master = devm_spi_alloc_master(dev, sizeof(struct altera_spi));
 	if (!master)
 		return -ENOMEM;
 
@@ -159,10 +159,9 @@ static int dfl_spi_altera_probe(struct dfl_device *dfl_dev)
 	altera_spi_init_master(master);
 
 	err = devm_spi_register_master(dev, master);
-	if (err) {
-		dev_err(dev, "%s failed to register spi master %d\n", __func__, err);
-		goto exit;
-	}
+	if (err)
+		return dev_err_probe(dev, err, "%s failed to register spi master\n",
+				     __func__);
 
 	if (dfl_dev->revision == FME_FEATURE_REV_MAX10_SPI_N5010)
 		strscpy(board_info.modalias, "m10-n5010", SPI_NAME_SIZE);
@@ -179,9 +178,6 @@ static int dfl_spi_altera_probe(struct dfl_device *dfl_dev)
 	}
 
 	return 0;
-exit:
-	spi_master_put(master);
-	return err;
 }
 
 static const struct dfl_device_id dfl_spi_altera_ids[] = {
-- 
2.34.1

