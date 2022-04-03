Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC7D84F08AB
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 12:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356276AbiDCKNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 06:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234350AbiDCKNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 06:13:10 -0400
Received: from smtp.smtpout.orange.fr (smtp07.smtpout.orange.fr [80.12.242.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF3635A93
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 03:11:16 -0700 (PDT)
Received: from pop-os.home ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id axCUnFYCnRGzQaxCUnw7xL; Sun, 03 Apr 2022 12:11:15 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 03 Apr 2022 12:11:15 +0200
X-ME-IP: 90.126.236.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Mark Brown <broonie@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-spi@vger.kernel.org
Subject: [PATCH] spi: mxic: Fix an error handling path in mxic_spi_probe()
Date:   Sun,  3 Apr 2022 12:11:13 +0200
Message-Id: <09c81f751241f6ec0bac7a48d4ec814a742e0d17.1648980664.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If spi_register_master() fails, we must undo a previous
mxic_spi_mem_ecc_probe() call, as already done in the remove function.

Fixes: 00360ebae483 ("spi: mxic: Add support for pipelined ECC operations")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/spi/spi-mxic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-mxic.c b/drivers/spi/spi-mxic.c
index 55c092069301..65be8e085ab8 100644
--- a/drivers/spi/spi-mxic.c
+++ b/drivers/spi/spi-mxic.c
@@ -813,6 +813,7 @@ static int mxic_spi_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(&pdev->dev, "spi_register_master failed\n");
 		pm_runtime_disable(&pdev->dev);
+		mxic_spi_mem_ecc_remove(mxic);
 	}
 
 	return ret;
-- 
2.32.0

