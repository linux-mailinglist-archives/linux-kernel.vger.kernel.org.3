Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900BB5684AD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 12:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbiGFKG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 06:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbiGFKGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 06:06:48 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6096724F17;
        Wed,  6 Jul 2022 03:06:47 -0700 (PDT)
Received: from localhost (unknown [188.24.177.228])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 16E2C660199B;
        Wed,  6 Jul 2022 11:06:46 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657102006;
        bh=FmxZRY8cqywyghtbXjPA0/ptVzriuh2ktG2Ioln5htI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X6T3kmQ6RZbnGOWq4NKT0yn91BDvbxVGjHHc8LafSVnKs/n4ztddqBQqgb/NSKAMu
         Cen54Xr8Mp9dr4mGnNDOABblL0kE1DPng8MynfvSqtsZMtIPLeQscv0H+z50su8/Tl
         1DSWEF264w7OV1slzSHkzLWNjq4XMpSiTLvnD8SmdtXk0zfG22ZWCWWp1SLGyQavE4
         tNqdWqKrMDBjddiOwJDDa+X2GY5FkMPNwVUg2lMRw7YIx6fb285N8fgLX9FHYF/NGz
         ssoPuhMHChPkhiFKVHiHA/up6T7kKLV/C6NfRINk0ehTIw2Rq7f2vX6PyqGSA6SjSt
         9M5wXbDPENLdA==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Mark Brown <broonie@kernel.org>,
        Sanjay R Mehta <sanju.mehta@amd.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, Anastasios Vacharakis <vacharakis@o2mail.de>,
        cristian.ciocaltea@collabora.com
Subject: [PATCH 2/5] spi: amd: Make use of devm_spi_alloc_master()
Date:   Wed,  6 Jul 2022 13:06:23 +0300
Message-Id: <20220706100626.1234731-3-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220706100626.1234731-1-cristian.ciocaltea@collabora.com>
References: <20220706100626.1234731-1-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of the devm variant of spi_alloc_master() in order to cleanup
and simplify the error handling in the probe function by getting rid
of the goto statements.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/spi/spi-amd.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
index efdcbe6c4c26..3dc17a80c55c 100644
--- a/drivers/spi/spi-amd.c
+++ b/drivers/spi/spi-amd.c
@@ -281,10 +281,10 @@ static int amd_spi_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct spi_master *master;
 	struct amd_spi *amd_spi;
-	int err = 0;
+	int err;
 
 	/* Allocate storage for spi_master and driver private data */
-	master = spi_alloc_master(dev, sizeof(struct amd_spi));
+	master = devm_spi_alloc_master(dev, sizeof(struct amd_spi));
 	if (!master) {
 		dev_err(dev, "Error allocating SPI master\n");
 		return -ENOMEM;
@@ -295,7 +295,7 @@ static int amd_spi_probe(struct platform_device *pdev)
 	if (IS_ERR(amd_spi->io_remap_addr)) {
 		err = PTR_ERR(amd_spi->io_remap_addr);
 		dev_err(dev, "error %d ioremap of SPI registers failed\n", err);
-		goto err_free_master;
+		return err;
 	}
 	dev_dbg(dev, "io_remap_address: %p\n", amd_spi->io_remap_addr);
 
@@ -313,15 +313,8 @@ static int amd_spi_probe(struct platform_device *pdev)
 
 	/* Register the controller with SPI framework */
 	err = devm_spi_register_master(dev, master);
-	if (err) {
+	if (err)
 		dev_err(dev, "error %d registering SPI controller\n", err);
-		goto err_free_master;
-	}
-
-	return 0;
-
-err_free_master:
-	spi_master_put(master);
 
 	return err;
 }
-- 
2.36.1

