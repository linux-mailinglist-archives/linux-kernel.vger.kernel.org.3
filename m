Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D342955E3AB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345849AbiF1Mpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 08:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345476AbiF1Mp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 08:45:26 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16BB205DE;
        Tue, 28 Jun 2022 05:45:24 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id ay16so25533193ejb.6;
        Tue, 28 Jun 2022 05:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X+4C91pBPuruAy2SRc0UhNyMy5LTHEOk4TXkwRVqGsA=;
        b=DSh1qQ0rIGt4CcyCfN6ZANz2B9InOMMi8Y8ooiZhU/J2JSd6dMIR4sTY2nB1Z83mDM
         21c2NAjI9GWt5JSsAxSVz6lHVn7s1LX9G9byRpY03+c/i7jyxysdlN3QmkLwUe3CIsmY
         CRVpalQd5kQUqUp+/w/o1svh2ZcshK7VEC77pWrApzObYapwgR7nxJTEc6s1p8jsIgRl
         qgHk8TPwFpTGUt6ynhNvD5AZ1cfUS4AQRgIKIDe0VtHBy8cn4XLr5Mq59SQJML3tFWny
         howy9kNXIDizrIwmYrQNqtBXM8OMfEFCv7sGq4gCfUbH+ufj/7vjhC2ScSnZlxWZJD12
         ztQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X+4C91pBPuruAy2SRc0UhNyMy5LTHEOk4TXkwRVqGsA=;
        b=A6pXQdV/M9QB0m34tHVS/5glTBWEo0l0q9+FcqX7ZJ7Wv5rzHxjVpo6h5ggJbqhJiE
         +3twkOQdtn41HVIPMI/4X2Z8pH3aqUSeu5CcRgCYSa9N/3zH6LsDi/avhlJzum8JEZPJ
         T4w/NmdRTW6AZhMDKe2Mhqv8cjfj26ZoFM2IUGmtX35ZenjqSys6lydCbKg9xbzSI83G
         P73GdGIYrJUfma4hSdOCDmECgMWN0p1hKTavJkxZKxvvLtZ/ISBLr8HkY7HnwfvZLMSC
         uabZVfI+T7/OeUmXZj1NRVLE+2CX3b93bNMTfDULdh3bZ8xGxzIg/V8dYa2yoFDUdo3e
         J5+Q==
X-Gm-Message-State: AJIora/QgXN4iS1J5d3bOiGYzVb2Wue64MUNmiTa+ZF5n7+/wdeTbfjR
        DT8i+Bl30jtdPZ1dikQXjKA=
X-Google-Smtp-Source: AGRyM1tqzBvDQCUi6RRScG2xpFlt5U6tlV23lkx33B4FpNGHMgJQZEy49e5pO+76w3Lr/SNE+MEY6w==
X-Received: by 2002:a17:906:9b93:b0:722:f3e8:3f5e with SMTP id dd19-20020a1709069b9300b00722f3e83f5emr17953859ejc.65.1656420323128;
        Tue, 28 Jun 2022 05:45:23 -0700 (PDT)
Received: from localhost.localdomain (dynamic-095-114-061-215.95.114.pool.telefonica.de. [95.114.61.215])
        by smtp.googlemail.com with ESMTPSA id f13-20020a170906824d00b00726e108b566sm622871ejx.173.2022.06.28.05.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 05:45:22 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        p.zabel@pengutronix.de
Cc:     linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        vkoul@kernel.org, kishon@ti.com, rtanwar@maxlinear.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v1 7/9] reset: intel: Use syscon_node_to_regmap on legacy SoCs
Date:   Tue, 28 Jun 2022 14:44:39 +0200
Message-Id: <20220628124441.2385023-8-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220628124441.2385023-1-martin.blumenstingl@googlemail.com>
References: <20220628124441.2385023-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Older Lantiq (called "legacy") SoCs the RCU registers have more than
just the reset controller registers. It additionally contains boot
media selection information, up to two USB2 PHYs and configuration for
various other peripherals (such as the PCIe PHY). use
syscon_node_to_regmap() to obtain the regmap on these SoCs.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/reset/Kconfig          |  3 ++-
 drivers/reset/reset-intel-gw.c | 29 +++++++++++++++++++----------
 2 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 68a5ea44612e..fb49c465078f 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -86,7 +86,8 @@ config RESET_INTEL_GW
 	bool "Intel Reset Controller Driver"
 	depends on X86 || LANTIQ || COMPILE_TEST
 	depends on OF && HAS_IOMEM
-	select REGMAP_MMIO
+	select REGMAP_MMIO if X86
+	select MFD_SYSCON if LANTIQ
 	help
 	  This enables the reset controller driver for Intel Gateway SoCs.
 	  Say Y to control the reset signals provided by reset controller.
diff --git a/drivers/reset/reset-intel-gw.c b/drivers/reset/reset-intel-gw.c
index 46ed7a693666..0bf7fe4e77ae 100644
--- a/drivers/reset/reset-intel-gw.c
+++ b/drivers/reset/reset-intel-gw.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/mfd/syscon.h>
 #include <linux/init.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
@@ -170,7 +171,6 @@ static int intel_reset_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	struct device *dev = &pdev->dev;
 	struct intel_reset_data *data;
-	void __iomem *base;
 	u32 rb_id[3];
 	int ret;
 
@@ -182,15 +182,24 @@ static int intel_reset_probe(struct platform_device *pdev)
 	if (!data->soc_data)
 		return -ENODEV;
 
-	base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
-
-	data->regmap = devm_regmap_init_mmio(dev, base,
-					     &intel_rcu_regmap_config);
-	if (IS_ERR(data->regmap)) {
-		dev_err(dev, "regmap initialization failed\n");
-		return PTR_ERR(data->regmap);
+	if (data->soc_data->legacy) {
+		data->regmap = syscon_node_to_regmap(dev->of_node);
+		if (IS_ERR(data->regmap))
+			return dev_err_probe(dev, PTR_ERR(data->regmap),
+					     "Failed to get regmap from syscon node\n");
+	} else {
+		void __iomem *base;
+
+		base = devm_platform_ioremap_resource(pdev, 0);
+		if (IS_ERR(base))
+			return PTR_ERR(base);
+
+		data->regmap = devm_regmap_init_mmio(dev, base,
+						     &intel_rcu_regmap_config);
+		if (IS_ERR(data->regmap)) {
+			dev_err(dev, "regmap initialization failed\n");
+			return PTR_ERR(data->regmap);
+		}
 	}
 
 	ret = device_property_read_u32_array(dev, "intel,global-reset", rb_id,
-- 
2.36.1

