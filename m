Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBD1F58DAFB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 17:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244874AbiHIPU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 11:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244855AbiHIPUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 11:20:33 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF37363DF
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 08:20:25 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id k6-20020a05600c1c8600b003a54ecc62f6so2227748wms.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 08:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=Ls4lqjgx1p+SGOqqpZ5RhMqVskyV8lsav7dO9gMbm3A=;
        b=VcMuiqgtWqmMKuBM8iolKvB5doGcT7vzUu5x4rt+07/AZNvNc6PIct6rPvHixoU1Ne
         fasNlYL4YxPA6oe+m/i89Sj1U9AeaHZJZYmMr3UelQwPWTwj/hwAC1oxa+81tHfeOVn7
         xkxwREDO/HQvtD8VEpNZ5y95w3NXdb7cx4yhbW3/tOpfK2WW5ZrBW45umeF62YJca7Ar
         Euu1YKmvFZ4tQttgaNoo29JNRELNjLIzEmwrJvC9KKVUpYzGqBg/nahPZ9LUgMTX3Zlo
         rNovmpH9UDh3RjeBfuU04disdHvgvB5Qx5GJYN/Qn3y165PJduqUZtcyezvgGAy59uFm
         DsYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=Ls4lqjgx1p+SGOqqpZ5RhMqVskyV8lsav7dO9gMbm3A=;
        b=Kgvub6eTDlwo3TCvLX6VRKMjFKASx1I5C6uiJPBdp7ijaBxCgVK7annHyIYayHcOvj
         yxYm2KY5QaGcGAN+5aUF7BgHvimvuMIU3zSOV91Nddk+IncU9fB0LbuxMojlPXtaqJMC
         Xxj3VL56EtI+3C9wjr4U8PNJ08V9Ff1htDij5x8YS4umFklwf7c8ZLKTc6hOoJnqlm5f
         x5dUzNquKCGpML+zlce/mK4h9vepzTLnGhDwuyBj/59bIr8vS3dBRLU6SbzjQWzvJFAO
         50lYH6wdynJHtxR2hAF2y2HgY2LXV8hFNfmeCtgVdyJhQ8U/G81p7bPLHDid6Pt17D5V
         4YtA==
X-Gm-Message-State: ACgBeo3Gnc58BygwkwGovrBwz0YKBqipOWrEDCkqxDs+DjRmIpygyxqO
        R9hszvTtrZX+dAGO65G/AI4gfw==
X-Google-Smtp-Source: AA6agR6q1GkF0jJvDFraMZ4ng6K/jQqngRGNxCAShS8DUJA8TSuXEhbFRK+Z+O7p4fPUZJXHr4DBjg==
X-Received: by 2002:a05:600c:3caa:b0:3a0:18e4:781b with SMTP id bg42-20020a05600c3caa00b003a018e4781bmr16424183wmb.199.1660058424094;
        Tue, 09 Aug 2022 08:20:24 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:982:cbb0:a7b2:d90d:221:7fec])
        by smtp.gmail.com with ESMTPSA id r3-20020a05600c424300b003a53de38c0dsm8279390wmm.14.2022.08.09.08.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 08:20:23 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     broonie@kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Da Xue <da@libre.computer>
Subject: [PATCH] spi: meson-spicc: save pow2 datarate between messages
Date:   Tue,  9 Aug 2022 17:20:19 +0200
Message-Id: <20220809152019.461741-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1960; h=from:subject; bh=aW4Zdb2GhTYOX+8LyYNg05IkphRj4KSUnH50R2AElMo=; b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBi8nsrlLBCQ+QvH7Kx2FKrKGQhp/Kr5WdZF01i7kEC vp4OO8WJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCYvJ7KwAKCRB33NvayMhJ0UwID/ 9qkNF3gbvLrcr2s0wBGyr39E3A/imA5qSI/K1sL6+DmYpLVqXRJVGfiB/sPnNq2hY1TyJ8mFLSlxJy sL2RIL8mdMSdMIigyhh4JBTPZjiuLlJl5Rz0YpMN69YPXEy0DerAAIPWw9ontBt1qfqX+DywN38l1d PSbDrME1W4SMyusp7acnrNmMAio6bLMlXKc0FYLt7l9O25aLbye62v+DfolVdwT9FjQGby/9YkHJyA Gey1L1b04LlE9Nf6njPdUppsUUV5sFQo+hk5tEWBN4EXI2Loe2qutrmFz3fpgcuv10L3ptS8vYKYT+ 2EK2ZFCrLMpQHuM3+wdbqVyRk/omnZBlXYPxDSC2lVnx8SQWGkUEU81zopR96O0iRbYkCt71cEbDPB QxjkAlkQVfxJWKrPTlfi0zC7TD6DvbjxgMLViBazFa0YPmPFCXapCaN4oC+2wlC9g6YS5Rd4g8CVSB xTjtZZQaw8XtgcOTj2cEoLLLFAE3NCB64VKDoynw8Uf9UJVkhaCdpix692MjXjWOLIi+0Ya3NRxVlz 4dR7V8puOxh7ADFMqVidX9V52euNsrig4eSwWcA4y5fO0KT48CR+s9an2D+GbTP/aEN5Zi2i1UQh2H jB6dVEE1/zBOMUfyQa9v8MeSIgUHl2NY30cXpb4LZLAOdqiLe5QQ3HkXUZeA==
X-Developer-Key: i=narmstrong@baylibre.com; a=openpgp; fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the end of a message, the HW gets a reset in meson_spicc_unprepare_transfer(),
this resets the SPICC_CONREG register and notably the value set by the
Common Clock Framework.

This saves the datarate dividor value between message to keep the last
set value by the Common Clock Framework.

This didn't appear before commit 3e0cf4d3fc29 ("spi: meson-spicc: add a linear clock divider support")
because we recalculated and wrote the rate for each xfer.

Fixes: 3e0cf4d3fc29 ("spi: meson-spicc: add a linear clock divider support")
Reported-by: Da Xue <da@libre.computer>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/spi/spi-meson-spicc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-meson-spicc.c b/drivers/spi/spi-meson-spicc.c
index 0bc7daa7afc8..e58686e28439 100644
--- a/drivers/spi/spi-meson-spicc.c
+++ b/drivers/spi/spi-meson-spicc.c
@@ -166,6 +166,7 @@ struct meson_spicc_device {
 	unsigned long			tx_remain;
 	unsigned long			rx_remain;
 	unsigned long			xfer_remain;
+	unsigned int			pow2_datarate;
 };
 
 static void meson_spicc_oen_enable(struct meson_spicc_device *spicc)
@@ -458,7 +459,8 @@ static int meson_spicc_prepare_message(struct spi_master *master,
 	/* Select CS */
 	conf |= FIELD_PREP(SPICC_CS_MASK, spi->chip_select);
 
-	/* Default Clock rate core/4 */
+	/* Saved pow2 Clock rate */
+	conf |= FIELD_PREP(SPICC_DATARATE_MASK, spicc->pow2_datarate);
 
 	/* Default 8bit word */
 	conf |= FIELD_PREP(SPICC_BITLENGTH_MASK, 8 - 1);
@@ -480,6 +482,10 @@ static int meson_spicc_unprepare_transfer(struct spi_master *master)
 	/* Disable all IRQs */
 	writel(0, spicc->base + SPICC_INTREG);
 
+	/* Save last pow2 datarate before HW reset */
+	spicc->pow2_datarate = FIELD_GET(SPICC_DATARATE_MASK,
+					 readl_relaxed(spicc->base + SPICC_CONREG));
+
 	device_reset_optional(&spicc->pdev->dev);
 
 	return 0;
-- 
2.25.1

