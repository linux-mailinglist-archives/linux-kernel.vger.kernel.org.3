Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2B952CD87
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 09:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235013AbiESHve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 03:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234835AbiESHvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 03:51:24 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C57119F8D
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 00:51:22 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id n6so2418607wms.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 00:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y+ISkJJI9HCW17NlesxzBupNaP4V8jkoqAfbXb7t54A=;
        b=dREwkqgKbJcNkT4OpxUCSJ1C74fSrihd0J9vLyVOet25pVR5iPyFF8hTN3QM4a+r3o
         BNuSBy69DQ/7zM4mbgx99xel+ieqL0YC0k7TVBL8rTUDLnkSGzOqWALua50C71KEe1Io
         bsA7MVpd4ooPN4kyvUmdB7w2tU38UXDklN6WE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y+ISkJJI9HCW17NlesxzBupNaP4V8jkoqAfbXb7t54A=;
        b=DGTgCKfg2ZhsR4nJSLhDfu1ajtTvazgaR2mRWhZ/cVM76XA7Wyrh9aFAV/BlHMhcw5
         UHobt1zY6IW+UyCqOXi/J2RAsH5uOm30BCyYREdFiCE7ogxByrUv6Wcv0RqPfPwf6Ig9
         O0aDFfxrjPTymbH9AYIsQOXPLMFKKmkNorBhX6VHDcVAcCWBmAYDZzUV60llH/pZsWx4
         gE+a7e8JcwAAWj5MPaOlHkILFk0jM8eD+D1UaXH5N2BnpbRkq3HwgDeIqqMvvGJzYaiD
         OfquyYT3zi7uAl3wM7cIq5KIpSKm7n4IKOIMlLf1qBWMTZwadU1/94Bu/Nq/xxlR2AAT
         ZXBg==
X-Gm-Message-State: AOAM533VkiT9IYCaRvOEmV76GBz69gcqlqoWT0o0qITRipeOki3lkiW9
        lNZPf5yf7M7DrvakuqPiUZkgdA==
X-Google-Smtp-Source: ABdhPJw3dvOjmAskMDKniHO1BYRz/JQySEd78D75Y7BTzerqXlZMXSWD4MNuMl7n1UYo6tXqfedHAA==
X-Received: by 2002:a7b:c2a9:0:b0:397:9a4:f66b with SMTP id c9-20020a7bc2a9000000b0039709a4f66bmr2629692wmk.128.1652946681000;
        Thu, 19 May 2022 00:51:21 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i.station (net-188-217-53-154.cust.vodafonedsl.it. [188.217.53.154])
        by smtp.gmail.com with ESMTPSA id c6-20020a05600c4a0600b003942a244ebfsm3370254wmp.4.2022.05.19.00.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 00:51:20 -0700 (PDT)
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Cc:     tommaso.merciai@amarulasolutions.com, linuxfancy@googlegroups.com,
        linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] media: i2c: ov5695: use regulator_bulk_enable/regulator_bulk disable instead of for loop
Date:   Thu, 19 May 2022 09:51:14 +0200
Message-Id: <20220519075117.1003520-2-tommaso.merciai@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220519075117.1003520-1-tommaso.merciai@amarulasolutions.com>
References: <20220519075117.1003520-1-tommaso.merciai@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable regulator using regulator_bulk_enable/regulatore_bulk_disable
function in __ov5695_power_on/__ov5695_power_off function instead of for loop.
This reduce code size and make things more clear

Signed-off-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Co-Developed-by: Michael Trimarchi <michael@amarulasolutions.com>
---
 drivers/media/i2c/ov5695.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/drivers/media/i2c/ov5695.c b/drivers/media/i2c/ov5695.c
index 439385938a51..880b586e55fe 100644
--- a/drivers/media/i2c/ov5695.c
+++ b/drivers/media/i2c/ov5695.c
@@ -972,7 +972,7 @@ static int ov5695_s_stream(struct v4l2_subdev *sd, int on)
 
 static int __ov5695_power_on(struct ov5695 *ov5695)
 {
-	int i, ret;
+	int ret;
 	struct device *dev = &ov5695->client->dev;
 
 	ret = clk_prepare_enable(ov5695->xvclk);
@@ -987,13 +987,10 @@ static int __ov5695_power_on(struct ov5695 *ov5695)
 	 * The hardware requires the regulators to be powered on in order,
 	 * so enable them one by one.
 	 */
-	for (i = 0; i < OV5695_NUM_SUPPLIES; i++) {
-		ret = regulator_enable(ov5695->supplies[i].consumer);
-		if (ret) {
-			dev_err(dev, "Failed to enable %s: %d\n",
-				ov5695->supplies[i].supply, ret);
-			goto disable_reg_clk;
-		}
+	ret = regulator_bulk_enable(ARRAY_SIZE(ov5695->supplies), ov5695->supplies);
+	if (ret) {
+		dev_err(dev, "Failed to enable regulators %d\n", ret);
+		goto disable_reg_clk;
 	}
 
 	gpiod_set_value_cansleep(ov5695->reset_gpio, 0);
@@ -1003,8 +1000,7 @@ static int __ov5695_power_on(struct ov5695 *ov5695)
 	return 0;
 
 disable_reg_clk:
-	for (--i; i >= 0; i--)
-		regulator_disable(ov5695->supplies[i].consumer);
+	regulator_bulk_disable(ARRAY_SIZE(ov5695->supplies), ov5695->supplies);
 	clk_disable_unprepare(ov5695->xvclk);
 
 	return ret;
@@ -1012,8 +1008,6 @@ static int __ov5695_power_on(struct ov5695 *ov5695)
 
 static void __ov5695_power_off(struct ov5695 *ov5695)
 {
-	struct device *dev = &ov5695->client->dev;
-	int i, ret;
 
 	clk_disable_unprepare(ov5695->xvclk);
 	gpiod_set_value_cansleep(ov5695->reset_gpio, 1);
@@ -1022,12 +1016,7 @@ static void __ov5695_power_off(struct ov5695 *ov5695)
 	 * The hardware requires the regulators to be powered off in order,
 	 * so disable them one by one.
 	 */
-	for (i = OV5695_NUM_SUPPLIES - 1; i >= 0; i--) {
-		ret = regulator_disable(ov5695->supplies[i].consumer);
-		if (ret)
-			dev_err(dev, "Failed to disable %s: %d\n",
-				ov5695->supplies[i].supply, ret);
-	}
+	regulator_bulk_disable(ARRAY_SIZE(ov5695->supplies), ov5695->supplies);
 }
 
 static int __maybe_unused ov5695_runtime_resume(struct device *dev)
-- 
2.25.1

