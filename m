Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB58A5684B3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 12:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbiGFKG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 06:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbiGFKGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 06:06:50 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15B125287;
        Wed,  6 Jul 2022 03:06:49 -0700 (PDT)
Received: from localhost (unknown [188.24.177.228])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 86F2F66019AB;
        Wed,  6 Jul 2022 11:06:48 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657102008;
        bh=gvIHZ0H7Q8LwPXB1Gy+8YPWBSTNwl9kEIMKaZUZmZKo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n/rjwqGoKWfoDBQ4eb5lDTrVYeT2/wlrVznFjAdEtOJjKvgdkkNIYZJbqk8x+AGvF
         BeBBYRL7n+oPHJdwEziklhji2xoG2HcIo2WxVp5bKj9h7IFXMhvuLH3kTgzwaloi8x
         ZVp/5ET0x7kXT0E6nhgnQxlNd1LlgykT586dtXMswf/YIyejyhva2vXSR0Er7pf+uy
         7qDLEoYUxXz5iEe/FGvgH5dZMntLoZObFnSSHH4JKmXKrPKsXeFWqV7DOtx5GQz6h1
         VO5TPVS7vLXA8NGhu64iRfaXWq35gDSWKcrAirl7nLTdz4/DRp3UXTtX423wKgj0Ty
         PHRRJagJf1AYQ==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Mark Brown <broonie@kernel.org>,
        Sanjay R Mehta <sanju.mehta@amd.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, Anastasios Vacharakis <vacharakis@o2mail.de>,
        cristian.ciocaltea@collabora.com
Subject: [PATCH 3/5] spi: amd: Make use of dev_err_probe()
Date:   Wed,  6 Jul 2022 13:06:24 +0300
Message-Id: <20220706100626.1234731-4-cristian.ciocaltea@collabora.com>
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

Simplify the error handling in probe function by switching from
dev_err() to dev_err_probe().

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/spi/spi-amd.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
index 3dc17a80c55c..1aa19a02a7b6 100644
--- a/drivers/spi/spi-amd.c
+++ b/drivers/spi/spi-amd.c
@@ -285,18 +285,15 @@ static int amd_spi_probe(struct platform_device *pdev)
 
 	/* Allocate storage for spi_master and driver private data */
 	master = devm_spi_alloc_master(dev, sizeof(struct amd_spi));
-	if (!master) {
-		dev_err(dev, "Error allocating SPI master\n");
-		return -ENOMEM;
-	}
+	if (!master)
+		return dev_err_probe(dev, -ENOMEM, "Error allocating SPI master\n");
 
 	amd_spi = spi_master_get_devdata(master);
 	amd_spi->io_remap_addr = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(amd_spi->io_remap_addr)) {
-		err = PTR_ERR(amd_spi->io_remap_addr);
-		dev_err(dev, "error %d ioremap of SPI registers failed\n", err);
-		return err;
-	}
+	if (IS_ERR(amd_spi->io_remap_addr))
+		return dev_err_probe(dev, PTR_ERR(amd_spi->io_remap_addr),
+				     "ioremap of SPI registers failed\n");
+
 	dev_dbg(dev, "io_remap_address: %p\n", amd_spi->io_remap_addr);
 
 	amd_spi->version = (enum amd_spi_versions) device_get_match_data(dev);
@@ -314,9 +311,9 @@ static int amd_spi_probe(struct platform_device *pdev)
 	/* Register the controller with SPI framework */
 	err = devm_spi_register_master(dev, master);
 	if (err)
-		dev_err(dev, "error %d registering SPI controller\n", err);
+		return dev_err_probe(dev, err, "error registering SPI controller\n");
 
-	return err;
+	return 0;
 }
 
 #ifdef CONFIG_ACPI
-- 
2.36.1

