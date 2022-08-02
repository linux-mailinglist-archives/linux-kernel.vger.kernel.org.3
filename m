Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF43958818D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 20:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbiHBSA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 14:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236809AbiHBR7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 13:59:49 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD48501BA
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 10:59:35 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id l19so829273wms.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 10:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dksoanYJoZO8G01KR5WlaEaO1JRamu4a/M2lotcY4Us=;
        b=cJzyb6w6buAT4Si/LRbYnFJOIEuXMT96PIUp3Cza/fREQOsThox0SJ6o43dJ8Pk7Jn
         LfbiSVkviFwvZJBQYr+raawJje3EleuA5fdAPHnphp2Gh1S+bSPoAjazyFNpL/0wjZQW
         mOTBUX6qkVmcZV7JM1FeRCSGNHWmpzJO/bCYb3K7vNQzTFwsx7cf9jAMIsz3SpL6mAE5
         Z8hr56URVZjl1JOV3bZ0qHtEl1yYfNR/kIMtfv42fk1H7agRsFbQ1duZeLMGWewzeqeB
         qiezCxTu4w6G496EFPEw+GTc0UbnK0C1sRsu5WZjzMToAq1sWQQGA/LPMsWMW06ELxj3
         zuKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dksoanYJoZO8G01KR5WlaEaO1JRamu4a/M2lotcY4Us=;
        b=l8UXoIBMB6boLP4aQgXtrn+HOG1cjGE8zZl9gNn+eRKPgLyfgRAEfUwddQB08q+Gi0
         HcZ/vd0nl8Fpte8KqO4p0+MKibtzCKCSsLcGB1cX7upqwW4UJORvfJAj+9ZBSzk/Ic3B
         QsQ4oDT+B0rBQlAmmatnNoO0eyxQqtFLFB9RIAEzgtHppT10CGq2NrkC+gxemGjYzHoB
         naNEDF2JLM3BfbM1tWE8kGE48AeDuqntsn8J3wi0bj3vAFVPAJ1aufCU9eKArGlYyhNu
         a0r7Iqmp7WOKa+F+PViKGVCip/UYzv7qYL+TKnbNJysNCUA9gFLtXiTyCI5dLQfXiN0v
         83fA==
X-Gm-Message-State: ACgBeo2in27NqQbllplC+OdJTcoeGSxCrzWiO417p1KJOvop8N6YO86v
        4RXXQCsU5HbuAhCc4vTk6w6HZw==
X-Google-Smtp-Source: AA6agR557a68A28uaXoSIeKdmvNzbTM0Ny3U/oteTSHz5ZHwIapC+B9nEc6H0RjuhnZ2aK0AhXbE5g==
X-Received: by 2002:a1c:2783:0:b0:3a2:fd82:bf46 with SMTP id n125-20020a1c2783000000b003a2fd82bf46mr382235wmn.29.1659463174307;
        Tue, 02 Aug 2022 10:59:34 -0700 (PDT)
Received: from debian.office.codethink.co.uk ([2405:201:8005:8149:e5c9:c0ac:4d82:e94b])
        by smtp.gmail.com with ESMTPSA id 9-20020a05600c020900b003a3187a2d4csm23318222wmi.22.2022.08.02.10.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 10:59:33 -0700 (PDT)
From:   Sudip Mukherjee <sudip.mukherjee@sifive.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     greentime.hu@sifive.com, jude.onyenegecha@sifive.com,
        william.salmon@sifive.com, adnan.chowdhury@sifive.com,
        ben.dooks@sifive.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jeegar.lakhani@sifive.com,
        Sudip Mukherjee <sudip.mukherjee@sifive.com>
Subject: [PATCH 11/11] spi: dw: initialize dwc-ssi-1.03a controller
Date:   Tue,  2 Aug 2022 18:57:55 +0100
Message-Id: <20220802175755.6530-12-sudip.mukherjee@sifive.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220802175755.6530-1-sudip.mukherjee@sifive.com>
References: <20220802175755.6530-1-sudip.mukherjee@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define the initialization of dwc-ssi-1.03a controller and mark it with
the capability of enhanced SPI supporting dual/quad/octal modes of
transfer.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@sifive.com>
---
 drivers/spi/spi-dw-mmio.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index 26c40ea6dd12..db80e0645172 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -237,6 +237,15 @@ static int dw_spi_canaan_k210_init(struct platform_device *pdev,
 	return 0;
 }
 
+static int dw_spi_hssi_ext_init(struct platform_device *pdev,
+				struct dw_spi_mmio *dwsmmio)
+{
+	dwsmmio->dws.ip = DW_HSSI_ID;
+	dwsmmio->dws.caps = DW_SPI_CAP_EXT_SPI;
+
+	return 0;
+}
+
 static int dw_spi_mmio_probe(struct platform_device *pdev)
 {
 	int (*init_func)(struct platform_device *pdev,
@@ -352,6 +361,7 @@ static const struct of_device_id dw_spi_mmio_of_match[] = {
 	{ .compatible = "intel,thunderbay-ssi", .data = dw_spi_intel_init},
 	{ .compatible = "microchip,sparx5-spi", dw_spi_mscc_sparx5_init},
 	{ .compatible = "canaan,k210-spi", dw_spi_canaan_k210_init},
+	{ .compatible = "snps,dwc-ssi-1.03a", dw_spi_hssi_ext_init},
 	{ /* end of table */}
 };
 MODULE_DEVICE_TABLE(of, dw_spi_mmio_of_match);
-- 
2.30.2

