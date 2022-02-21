Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA55E4BDC83
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236038AbiBULzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 06:55:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356976AbiBULzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 06:55:01 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667DA201B6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 03:54:00 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id u1so26596855wrg.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 03:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c1lGEjQZO5Ck7pZjx7sWrafG9PHsL7fLHKREbwRpPTU=;
        b=PHob5dcx3qGf9rtPkzufLzJiQAAzeNVba1OpI9VGNOjQFA2T+4SHT2s//2viN8s5AW
         c5pPqsCeDnvQZO6smxl+n6Kblhx21dz0HNUspX1JQ05KLKMLR6H5xyg3CKknDxsteNBN
         6vB7pnKOVlE8I5MBA/HeV/ATktnRv2TErEnSJE51/EmzWsMJ85MTJpNh3msIeawaJJZm
         aX8t7UQ3wsD0ST9EkXc2ASCrg2mc3b9fTz83xL0CLfQi7E1Xh9BaOwYqLdby0x/vKaBB
         c5SC7HpcYSmpbJOCvZCSadS/kpJuD2qS++WeSuYVbpJh3OzSAHh1Uz7q6VZP975Q+QTX
         IyRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c1lGEjQZO5Ck7pZjx7sWrafG9PHsL7fLHKREbwRpPTU=;
        b=kU8ADB1HLnE7NRjPs1GSw0eJKH1GWQQ+1by1OywrB6acXcmyXeNgrYa+oJWq5PUvlT
         BW5EEzQ+Gn2iM916kDYew3JXB0lL9gcbgnmO2zESUPPxalPibJgSV2RVeF1icUs5j2Te
         T7aS6ZR7zpRItQVv+ZO/X2wwgAD8Q7ftjNKsRRwjh945qSRp+Kmb1rNYCUq17lq3tmdb
         i/L1VQePqN9D45JGJN2AAG9gje9P8DoL4VzMXGNi/javxqDDcz24qTj9DqkzhvGximbm
         Xq8Z5f5pjPoYgyaeXusnKYKY7/ZFB1K4XAETmLPU/vV8EOPlmYfZoEUmRwN1mgkA+ATf
         GI+Q==
X-Gm-Message-State: AOAM532fzMH0XGjS7GprNyNz26b0Ws/hpSR3ED4WVmO2gJue+D/sNbZn
        sUYQkIiuBvMF424AFxS6n9lIPw==
X-Google-Smtp-Source: ABdhPJxMgn4HOwiP0wCV2QrDZ4jST0qN+s/LnZugswmRGPq6cmDfbz+HneX2bUyrki+Qp5xkgOO1gg==
X-Received: by 2002:adf:ce88:0:b0:1e3:1340:52f1 with SMTP id r8-20020adfce88000000b001e3134052f1mr14725050wrn.489.1645444438984;
        Mon, 21 Feb 2022 03:53:58 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id k4-20020a05600c0b4400b0034a0cb4332csm7324345wmr.10.2022.02.21.03.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 03:53:58 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        jglauber@cavium.com
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] crypto: cavium: zip: register algorithm only if hardware is present
Date:   Mon, 21 Feb 2022 11:52:34 +0000
Message-Id: <20220221115234.2544665-1-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On my renesas salavator-X, I saw some cavium driver failing crypto
self-tests.
But salvator does not have such hardware.
This is due to cavium/zip driver registering algorithms even if hardware
is not present.
The solution is to move algorithm registration in the probe function.
This permits also to simplify module init/exit by using
module_pci_driver.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---

WARNING: this is boot tested only on salvator-X to be sure that the
cavium/zip driver no longer registers algorithms.
I do not have any cavium hardware unfortunatly.

 drivers/crypto/cavium/zip/zip_main.c | 83 ++++++++++++----------------
 1 file changed, 35 insertions(+), 48 deletions(-)

diff --git a/drivers/crypto/cavium/zip/zip_main.c b/drivers/crypto/cavium/zip/zip_main.c
index 812b4ac9afd6..dc5b7bf7e1fd 100644
--- a/drivers/crypto/cavium/zip/zip_main.c
+++ b/drivers/crypto/cavium/zip/zip_main.c
@@ -55,6 +55,11 @@ static const struct pci_device_id zip_id_table[] = {
 	{ 0, }
 };
 
+static void zip_debugfs_init(void);
+static void zip_debugfs_exit(void);
+static int zip_register_compression_device(void);
+static void zip_unregister_compression_device(void);
+
 void zip_reg_write(u64 val, u64 __iomem *addr)
 {
 	writeq(val, addr);
@@ -235,6 +240,15 @@ static int zip_init_hw(struct zip_device *zip)
 	return 0;
 }
 
+static void zip_reset(struct zip_device *zip)
+{
+	union zip_cmd_ctl cmd_ctl;
+
+	cmd_ctl.u_reg64 = 0x0ull;
+	cmd_ctl.s.reset = 1;  /* Forces ZIP cores to do reset */
+	zip_reg_write(cmd_ctl.u_reg64, (zip->reg_base + ZIP_CMD_CTL));
+}
+
 static int zip_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	struct device *dev = &pdev->dev;
@@ -282,8 +296,21 @@ static int zip_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (err)
 		goto err_release_regions;
 
+	/* Register with the Kernel Crypto Interface */
+	err = zip_register_compression_device();
+	if (err < 0) {
+		zip_err("ZIP: Kernel Crypto Registration failed\n");
+		goto err_register;
+	}
+
+	/* comp-decomp statistics are handled with debugfs interface */
+	zip_debugfs_init();
+
 	return 0;
 
+err_register:
+	zip_reset(zip);
+
 err_release_regions:
 	if (zip->reg_base)
 		iounmap(zip->reg_base);
@@ -305,16 +332,17 @@ static int zip_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 static void zip_remove(struct pci_dev *pdev)
 {
 	struct zip_device *zip = pci_get_drvdata(pdev);
-	union zip_cmd_ctl cmd_ctl;
 	int q = 0;
 
 	if (!zip)
 		return;
 
+	zip_debugfs_exit();
+
+	zip_unregister_compression_device();
+
 	if (zip->reg_base) {
-		cmd_ctl.u_reg64 = 0x0ull;
-		cmd_ctl.s.reset = 1;  /* Forces ZIP cores to do reset */
-		zip_reg_write(cmd_ctl.u_reg64, (zip->reg_base + ZIP_CMD_CTL));
+		zip_reset(zip);
 		iounmap(zip->reg_base);
 	}
 
@@ -585,7 +613,7 @@ DEFINE_SHOW_ATTRIBUTE(zip_regs);
 /* Root directory for thunderx_zip debugfs entry */
 static struct dentry *zip_debugfs_root;
 
-static void __init zip_debugfs_init(void)
+static void zip_debugfs_init(void)
 {
 	if (!debugfs_initialized())
 		return;
@@ -604,7 +632,7 @@ static void __init zip_debugfs_init(void)
 
 }
 
-static void __exit zip_debugfs_exit(void)
+static void zip_debugfs_exit(void)
 {
 	debugfs_remove_recursive(zip_debugfs_root);
 }
@@ -615,48 +643,7 @@ static void __exit zip_debugfs_exit(void) { }
 #endif
 /* debugfs - end */
 
-static int __init zip_init_module(void)
-{
-	int ret;
-
-	zip_msg("%s\n", DRV_NAME);
-
-	ret = pci_register_driver(&zip_driver);
-	if (ret < 0) {
-		zip_err("ZIP: pci_register_driver() failed\n");
-		return ret;
-	}
-
-	/* Register with the Kernel Crypto Interface */
-	ret = zip_register_compression_device();
-	if (ret < 0) {
-		zip_err("ZIP: Kernel Crypto Registration failed\n");
-		goto err_pci_unregister;
-	}
-
-	/* comp-decomp statistics are handled with debugfs interface */
-	zip_debugfs_init();
-
-	return ret;
-
-err_pci_unregister:
-	pci_unregister_driver(&zip_driver);
-	return ret;
-}
-
-static void __exit zip_cleanup_module(void)
-{
-	zip_debugfs_exit();
-
-	/* Unregister from the kernel crypto interface */
-	zip_unregister_compression_device();
-
-	/* Unregister this driver for pci zip devices */
-	pci_unregister_driver(&zip_driver);
-}
-
-module_init(zip_init_module);
-module_exit(zip_cleanup_module);
+module_pci_driver(zip_driver);
 
 MODULE_AUTHOR("Cavium Inc");
 MODULE_DESCRIPTION("Cavium Inc ThunderX ZIP Driver");
-- 
2.34.1

