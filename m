Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E29D504ABB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 03:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235744AbiDRB7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 21:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbiDRB7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 21:59:44 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7EF18397;
        Sun, 17 Apr 2022 18:57:06 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id s70so3568393qke.8;
        Sun, 17 Apr 2022 18:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x6skCzjnPnfmaS7HpmFApF1dSN6+QpLWVgexcP1E8vQ=;
        b=Gp4O0bN2vCo+5nkLdlS2Bx/PD+7K7u0tRutLBkwTlr8udDd9nOP9Tyt4TAu0+zge0a
         y8XAbrcZJssNfj/+1UdeCddGXWcnYlCT1zxhwXDsUk1kLYX4U9w1T63Gh7Lo1uWz5ass
         azHU/KB1oDmC/K7nMiO2/1FwP9XUy6Rt7Nhd7BL7jHSlNjCtJBvjGK2tsjyghRZtc/kH
         TU6ADYsjFyy0+Nq4+4NgTQXpK3ZI37a1I3kDUNxZv67tpl2xGLAQJns9XgHZT6GmesCK
         iN7VqZ6PaS+5rTXl1AVmJNAjU0M4+boZwrSC3Ath7d7vnImjDmr7j+NQ6/NgUtRsZHrH
         GX9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x6skCzjnPnfmaS7HpmFApF1dSN6+QpLWVgexcP1E8vQ=;
        b=khFA9fWlSzh0/1loN/OHAIrRgUkExA1eGbGqfHWrHfhtlxICk6Cp+5R1+RNMwBIsvG
         qFYF2apyMXzjPSE8F3VQy4WRZFVYKc6p5FdvoFwUdaJMlgg5zH+PxEezkn1wa6kA4yux
         9VxcfXXKosbbQh1Nf0xOVwBixhEEWx8CkV4h4nU76uXznViEigNXBPPIUOsZ+RQnsRDq
         li+f6iHNyxuGdvteKKFc02iaJjrnivfKu53s+rX2O8adHvtzQRIoD3kGSFxGPcVWyzrq
         t9zOXsZ+t2mut9xpUk+r0CzcCqJNRJfRLxnHCODnPCD2uNi0NNxPl6B61v5BTcR6bQ6g
         c/fA==
X-Gm-Message-State: AOAM532xsNNYCyARMJSH7wQ8vl30VBInRG2xXq7g6RMZKSj1rHdQeM5m
        C9Ox0OoLKRV5AHmOozE2kDY=
X-Google-Smtp-Source: ABdhPJx768t4koiQGIMbqKbqc3sIQ8bjo19VJUdpyYcW9FuUBCH2Mn1+obKzgl4c+BGVG2Yo8tbzDw==
X-Received: by 2002:a37:bf04:0:b0:69e:6243:f141 with SMTP id p4-20020a37bf04000000b0069e6243f141mr5340443qkf.229.1650247025944;
        Sun, 17 Apr 2022 18:57:05 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id c79-20020ae9ed52000000b0069e9bfecd6esm994205qkg.98.2022.04.17.18.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 18:57:05 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     daniele.alessandrelli@intel.com, herbert@gondor.apana.org.au,
        davem@davemloft.net
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lv Ruyi <lv.ruyi@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] crypto: Make use of the helper function devm_platform_ioremap_resource()
Date:   Mon, 18 Apr 2022 01:57:00 +0000
Message-Id: <20220418015700.2556801-1-lv.ruyi@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

From: Lv Ruyi <lv.ruyi@zte.com.cn>

Use the devm_platform_ioremap_resource() helper instead of calling
platform_get_resource() and devm_ioremap_resource() separately.Make the
code simpler without functional changes.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
---
 drivers/crypto/keembay/keembay-ocs-aes-core.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/crypto/keembay/keembay-ocs-aes-core.c b/drivers/crypto/keembay/keembay-ocs-aes-core.c
index e2a39fdaf623..9953f5590ac4 100644
--- a/drivers/crypto/keembay/keembay-ocs-aes-core.c
+++ b/drivers/crypto/keembay/keembay-ocs-aes-core.c
@@ -1598,7 +1598,6 @@ static int kmb_ocs_aes_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct ocs_aes_dev *aes_dev;
-	struct resource *aes_mem;
 	int rc;
 
 	aes_dev = devm_kzalloc(dev, sizeof(*aes_dev), GFP_KERNEL);
@@ -1616,13 +1615,7 @@ static int kmb_ocs_aes_probe(struct platform_device *pdev)
 	}
 
 	/* Get base register address. */
-	aes_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!aes_mem) {
-		dev_err(dev, "Could not retrieve io mem resource\n");
-		return -ENODEV;
-	}
-
-	aes_dev->base_reg = devm_ioremap_resource(&pdev->dev, aes_mem);
+	aes_dev->base_reg = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(aes_dev->base_reg))
 		return PTR_ERR(aes_dev->base_reg);
 
-- 
2.25.1

