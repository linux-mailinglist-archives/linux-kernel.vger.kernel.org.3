Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA4D5684A9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 12:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbiGFKGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 06:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbiGFKGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 06:06:45 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD44125281;
        Wed,  6 Jul 2022 03:06:44 -0700 (PDT)
Received: from localhost (unknown [188.24.177.228])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 97DDF66019A7;
        Wed,  6 Jul 2022 11:06:43 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657102003;
        bh=E67xkUkVcw1cpepE9DKG7WA5Ipv1XTkU98A1bQ6zDEs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lKWZaw/DnC2rAPjdELFrvSZ+ubc/0j0QXdgVxj6QaTs92/0ZtnbzDLVzK2Hh9FbHl
         CnCJFCEKySJGgmZUOncZPTNnWQdSCxZAiTRI9PYh37FrSZBGAjA079HkMgv75pX02Y
         9itounrN2+zNjy+Hosu65IMa5JHkGpy2IKGno5FhYgsNvLizlrkdEubrZmkfzJ8upm
         PQiXsu1oDJ02iKrgKJwcWnbtblwjm5+S+n3JcCqhxgrVRDYY3oA3BVhSxgpYs1QQvN
         xW8IO+TrrTOLTjpA90sVcUeoB4ozBQCfte19y5zK2M4ruVKLuHx/qmJRDkcsdkrami
         tx/VTkU6+hdQw==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Mark Brown <broonie@kernel.org>,
        Sanjay R Mehta <sanju.mehta@amd.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, Anastasios Vacharakis <vacharakis@o2mail.de>,
        cristian.ciocaltea@collabora.com
Subject: [PATCH 1/5] spi: amd: Limit max transfer and message size
Date:   Wed,  6 Jul 2022 13:06:22 +0300
Message-Id: <20220706100626.1234731-2-cristian.ciocaltea@collabora.com>
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

Enabling the SPI CS35L41 audio codec driver for Steam Deck [1]
revealed a problem with the current AMD SPI controller driver
implementation, consisting of an unrecoverable system hang.

The issue can be prevented if we ensure the max transfer size
and the max message size do not exceed the FIFO buffer size.

According to the implementation of the downstream driver, the
AMD SPI controller is not able to handle more than 70 bytes per
transfer, which corresponds to the size of the FIFO buffer.

Hence, let's fix this by setting the SPI limits mentioned above.

[1] https://lore.kernel.org/r/20220621213819.262537-1-cristian.ciocaltea@collabora.com

Reported-by: Anastasios Vacharakis <vacharakis@o2mail.de>
Fixes: bbb336f39efc ("spi: spi-amd: Add AMD SPI controller driver support")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/spi/spi-amd.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
index cba6a4486c24..efdcbe6c4c26 100644
--- a/drivers/spi/spi-amd.c
+++ b/drivers/spi/spi-amd.c
@@ -33,6 +33,7 @@
 #define AMD_SPI_RX_COUNT_REG	0x4B
 #define AMD_SPI_STATUS_REG	0x4C
 
+#define AMD_SPI_FIFO_SIZE	70
 #define AMD_SPI_MEM_SIZE	200
 
 /* M_CMD OP codes for SPI */
@@ -270,6 +271,11 @@ static int amd_spi_master_transfer(struct spi_master *master,
 	return 0;
 }
 
+static size_t amd_spi_max_transfer_size(struct spi_device *spi)
+{
+	return AMD_SPI_FIFO_SIZE;
+}
+
 static int amd_spi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -302,6 +308,8 @@ static int amd_spi_probe(struct platform_device *pdev)
 	master->flags = SPI_MASTER_HALF_DUPLEX;
 	master->setup = amd_spi_master_setup;
 	master->transfer_one_message = amd_spi_master_transfer;
+	master->max_transfer_size = amd_spi_max_transfer_size;
+	master->max_message_size = amd_spi_max_transfer_size;
 
 	/* Register the controller with SPI framework */
 	err = devm_spi_register_master(dev, master);
-- 
2.36.1

