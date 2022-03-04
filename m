Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 432E24CCF27
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 08:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238845AbiCDHhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 02:37:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234891AbiCDHhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 02:37:51 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0295192C8F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 23:37:00 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id u10so9690607wra.9
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 23:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0QDpARUPjQVw7yJZDfXexLC7oeaI8zkN2+sGqKTfu/k=;
        b=X9p740h5bXiHbxxM+3aljlfLPoZUpJf+DsWfQs1Hndu7DTv782sK0v+e1iI/s7rKJX
         1YTsRnvWAZgJxo5yJWWI718CxTKsHBj95KaqIo17RgoiDguWwyGDLzTKRwZ99+NZhdgW
         iw0+taDTzNZPjJB9r/74N6itk+4URQdU3SlXip0ZP16CWXATSQDmsTkvxGQ09miGbhQo
         QjZnY3IachQiCs6Y7dNygmKl0+T3+o/iW1nsR/1EVsNPlwZnb6oKWkjf+1RxHE34S5Vh
         /QjcpxxEjx+aNauscgLz++os9TEh8vbQdvbDTnpMtfbC1O5x+k0wngZP40pCbGmRiLwL
         tB+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0QDpARUPjQVw7yJZDfXexLC7oeaI8zkN2+sGqKTfu/k=;
        b=f5TRcQSCK67iyUk1aP25KNBv0cYszWvD8ZpP+AyUOi4rsWsNO5j++pVRQoxKOOCGBS
         MvZNmb4XELrDJdID24tlXvu5isl5ZFLct/uch4/ESKqoM0fvlKL4PxkL+RZ5Xq1bz1ln
         woAYNsiEtgTIrqHgyBMhwvxFM6S2g98B+r+D4y+qE4WjWiXz3dCbIAZgXZgE8xCqUqFs
         ZGwtoajT0uhHqOHgOiXc6WdhPPoTxGBnOHDEOO07vL01jEPgIWf2wqJtIH5vlLW6/3Wn
         hGx77xeqa6R5Vb6ovlBqYb8ojIvoyLgV77uZAVJSCEy483HLleEMTHyxD2EKoDwhUl5D
         6z9g==
X-Gm-Message-State: AOAM532okSgxQ3DZqh5UJDGmPzt8+8IO7YHplCDNzkZA20GFfT/rXcNc
        78+uRkrQvqO0TfftS5hz3/sUiA==
X-Google-Smtp-Source: ABdhPJw9AhNZkPaGQAVDTKf46zsYx95DYB4NtR6FCMra+tI3shjmjieHAP82lTmaoBv61pTMuEVSiA==
X-Received: by 2002:a05:6000:2a7:b0:1f0:b26a:38b with SMTP id l7-20020a05600002a700b001f0b26a038bmr687506wry.23.1646379419286;
        Thu, 03 Mar 2022 23:36:59 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id l12-20020a5d6d8c000000b001efd2c071dbsm4068002wrs.20.2022.03.03.23.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 23:36:58 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, harsha.harsha@xilinx.com,
        herbert@gondor.apana.org.au, kalyani.akula@xilinx.com,
        michal.simek@xilinx.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] crypto: xilinx: prevent probing on non-xilinx hardware
Date:   Fri,  4 Mar 2022 07:36:48 +0000
Message-Id: <20220304073648.972270-1-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The zynqmp-sha driver is always loaded and register its algorithm even on
platform which do not have the proper hardware.
This lead to a stacktrace due to zynqmp-sha3-384 failing its crypto
self tests.
So check if hardware is present via the firmware API call get_version.

While at it, simplify the platform_driver by using module_platform_driver()

Furthermore the driver should depend on ZYNQMP_FIRMWARE since it cannot
work without it.

Fixes: 7ecc3e34474b ("crypto: xilinx - Add Xilinx SHA3 driver")
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/Kconfig             |  2 +-
 drivers/crypto/xilinx/zynqmp-sha.c | 35 +++++++-----------------------
 2 files changed, 9 insertions(+), 28 deletions(-)

diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index 51df3cd9934f..52bb632a91d5 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -822,7 +822,7 @@ config CRYPTO_DEV_ZYNQMP_AES
 
 config CRYPTO_DEV_ZYNQMP_SHA3
 	bool "Support for Xilinx ZynqMP SHA3 hardware accelerator"
-	depends on ARCH_ZYNQMP
+	depends on ZYNQMP_FIRMWARE
 	select CRYPTO_SHA3
 	help
 	  Xilinx ZynqMP has SHA3 engine used for secure hash calculation.
diff --git a/drivers/crypto/xilinx/zynqmp-sha.c b/drivers/crypto/xilinx/zynqmp-sha.c
index 89549f4788ba..43ff170ff1c2 100644
--- a/drivers/crypto/xilinx/zynqmp-sha.c
+++ b/drivers/crypto/xilinx/zynqmp-sha.c
@@ -193,6 +193,13 @@ static int zynqmp_sha_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	int err;
+	u32 v;
+
+	/* Verify the hardware is present */
+	err = zynqmp_pm_get_api_version(&v);
+	if (err)
+		return err;
+
 
 	err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(ZYNQMP_DMA_BIT_MASK));
 	if (err < 0) {
@@ -251,33 +258,7 @@ static struct platform_driver zynqmp_sha_driver = {
 	},
 };
 
-static int __init sha_driver_init(void)
-{
-	struct platform_device *pdev;
-	int ret;
-
-	ret = platform_driver_register(&zynqmp_sha_driver);
-	if (ret)
-		return ret;
-
-	pdev = platform_device_register_simple(zynqmp_sha_driver.driver.name,
-					       0, NULL, 0);
-	if (IS_ERR(pdev)) {
-		ret = PTR_ERR(pdev);
-		platform_driver_unregister(&zynqmp_sha_driver);
-		pr_info("Failed to register ZynqMP SHA3 dvixe %d\n", ret);
-	}
-
-	return ret;
-}
-
-device_initcall(sha_driver_init);
-
-static void __exit sha_driver_exit(void)
-{
-	platform_driver_unregister(&zynqmp_sha_driver);
-}
-
+module_platform_driver(zynqmp_sha_driver);
 MODULE_DESCRIPTION("ZynqMP SHA3 hardware acceleration support.");
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Harsha <harsha.harsha@xilinx.com>");
-- 
2.34.1

