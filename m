Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0D84A7781
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 19:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345634AbiBBSHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 13:07:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbiBBSHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 13:07:02 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB5EC061714;
        Wed,  2 Feb 2022 10:07:01 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id ka4so65813ejc.11;
        Wed, 02 Feb 2022 10:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oqTmB0axPVxCTS0sxTTWZlHegO1uPd5y6swwpolQnGc=;
        b=P8jc1aWcY/XL+b7QzCSCota0C9bBW2ksXIMnw3cZizHXrVzdVkJ/aBQ2bgRjJEBIsP
         zQJXucoZaRzhET2d54m1slInWOrbdUBRpnpzTmAwCQczXA/tIWPn1QjFN0a/JvkeAznJ
         JhDTRsLIy9iYhrWyn1su135zmHPebTBtfcgQCSsBQZDwwYa+RL5Um0be+zCu+6pHhDQ+
         giez63aK7Zx4J/VcBcKawe41fSwRrtKX45K50VRbY+Tjj+IF+VSHwp6qUiimZ22OA+Gy
         ny4LvBrGHgvXkGhl71jx9IxF2rBUzJHmkJvfknmfdNpbdex2buTEOGxdg+G5gDQ7e3as
         2ZsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oqTmB0axPVxCTS0sxTTWZlHegO1uPd5y6swwpolQnGc=;
        b=q4lWvhqL1IWzlqksWc2O0MvgVB+CGYXwz3BuxaeR2W38XhMeWLG2LHfApqSgqnN2yP
         W1L8AFNNqPG32ivwgM9pC4h7j+i6CT2NMAW/QGPPdocich7XYkI4g/3JYlYwvzNHKUg7
         uD9w0IgJIvixEbShXcaSvfaeHT7e9cz19WIqwt0KWRKJA1QoU5xl+GwdMjdca75Gv5gQ
         skpLdv2milkPWVhcOrJe9S3XYUxJLkF7U+ZonoSA3msD34fB4sKdI2R7xHp1zRMAo1+G
         2NCSIq/Cbhf+7186JcqHrYeHZ3zxM8WNPM/VxxALhYyJV3drtFvJwDqjOP8m9/wQDEvy
         w5pg==
X-Gm-Message-State: AOAM530NI8AJV3koFzdIyEdTz2/3qC3PwBgLMrxykcaJEoP1oUFrGsO5
        2v4xSH7TfGnfXyQCQujlsms=
X-Google-Smtp-Source: ABdhPJw/vxEGYkblydj48bZS2rASRw0MuODJxDJoFc58voLMjHalgIzxCNmfpPlt/b9B/RBgN2Exww==
X-Received: by 2002:a17:907:2ce4:: with SMTP id hz4mr18280325ejc.261.1643825220235;
        Wed, 02 Feb 2022 10:07:00 -0800 (PST)
Received: from localhost.localdomain (p4fd5939b.dip0.t-ipconnect.de. [79.213.147.155])
        by smtp.gmail.com with ESMTPSA id ee37sm3223005edb.106.2022.02.02.10.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 10:06:59 -0800 (PST)
From:   Bean Huo <huobean@gmail.com>
To:     ulf.hansson@linaro.org, eugen.hristev@microchip.com,
        adrian.hunter@intel.com, nicolas.ferre@microchip.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     beanhuo@micron.com
Subject: [PATCH 1/5] mmc: wmt-sdmmc: Use of_device_get_match_data() helper
Date:   Wed,  2 Feb 2022 19:06:44 +0100
Message-Id: <20220202180648.1252154-2-huobean@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220202180648.1252154-1-huobean@gmail.com>
References: <20220202180648.1252154-1-huobean@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

Only the device data is needed, not the whole struct of_device_id.
Use of_device_get_match_data() instead of open coding of of_match_device().

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 drivers/mmc/host/wmt-sdmmc.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/wmt-sdmmc.c b/drivers/mmc/host/wmt-sdmmc.c
index cf10949fb0ac..163ac9df8cca 100644
--- a/drivers/mmc/host/wmt-sdmmc.c
+++ b/drivers/mmc/host/wmt-sdmmc.c
@@ -751,19 +751,16 @@ static int wmt_mci_probe(struct platform_device *pdev)
 	struct mmc_host *mmc;
 	struct wmt_mci_priv *priv;
 	struct device_node *np = pdev->dev.of_node;
-	const struct of_device_id *of_id =
-		of_match_device(wmt_mci_dt_ids, &pdev->dev);
 	const struct wmt_mci_caps *wmt_caps;
 	int ret;
 	int regular_irq, dma_irq;
 
-	if (!of_id || !of_id->data) {
+	wmt_caps = of_device_get_match_data(&pdev->dev);
+	if (!wmt_caps) {
 		dev_err(&pdev->dev, "Controller capabilities data missing\n");
 		return -EFAULT;
 	}
 
-	wmt_caps = of_id->data;
-
 	if (!np) {
 		dev_err(&pdev->dev, "Missing SDMMC description in devicetree\n");
 		return -EFAULT;
-- 
2.25.1

