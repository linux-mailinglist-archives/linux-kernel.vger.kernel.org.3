Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F64B572110
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 18:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233842AbiGLQfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 12:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234384AbiGLQeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 12:34:18 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C253627CE7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 09:34:13 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id r14so11975679wrg.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 09:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ctpa/T2vVk1WErHGmcuqVVZ1P5/ZM5PQkEWqW8vXr7A=;
        b=CylXyQDI7NjZJJjGahP8/G+x1mwQdZyXU1fYlhjC5I+uzbIwEhCLjmEc+xJOEXf7Bc
         tRW4CZ/BQCYEKwyTayBWm+c1YPePeednwnGU4AOuP9vhrJZzEB5u1OsyscE8sn2LuV8N
         NcjprcgH3b8zWb+wimWqIP+Bpf7qFEm1gyCvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ctpa/T2vVk1WErHGmcuqVVZ1P5/ZM5PQkEWqW8vXr7A=;
        b=IhZ4xHw3ZL7XTSNVc4Q5DpA0dUD37ZWIN0xuMU9SYMypt6Ar7jbugIGUCPtPaMUxkv
         KEWzZrQ7jY3qgcrICaunE8DQzuADE9C5MIWy5aKhKnOewdN6eIlbQABAUVmFlJEpdjwi
         0/YltuDmzgFP5/DSK5JswBqCqK3E8Nv/yNj9HtehBv6vyvNwQFt9HDm7IbYa26N3YADY
         RVId7ZJlT/6CrgvTyYKjWIKMCSOG0jXOwUNCxXOB2AMkYfRy4KiweO79mtujE5DasQPI
         Ojtmb1rx8yBBztP6yACt8KsUddPiRtUl3IMecm7UsgkiDqQ3lWuvpBBdx9l9o6F6FWdA
         9ndQ==
X-Gm-Message-State: AJIora9Pk4XptZxHKRF3i0bAXmFCjVL2ZyJV/2Ho3JQp7M2gm1/qX9Jg
        1lgvLFPHaD7HUimEgJgUcCMnCg==
X-Google-Smtp-Source: AGRyM1u29k4IN2wgzOHnCdDeUpOtAD+K54m2KKU/q6uYaGIMJ+4h1Ier0c3zwV+m+j7TaLoaY4k7qQ==
X-Received: by 2002:a5d:584e:0:b0:21c:ea0c:3734 with SMTP id i14-20020a5d584e000000b0021cea0c3734mr22283780wrf.420.1657643651827;
        Tue, 12 Jul 2022 09:34:11 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i.station (net-188-217-53-214.cust.vodafonedsl.it. [188.217.53.214])
        by smtp.gmail.com with ESMTPSA id j16-20020a5d6050000000b0021db2dcd0aasm2321052wrt.108.2022.07.12.09.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 09:34:11 -0700 (PDT)
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
To:     tommaso.merciai@amarulasolutions.com
Cc:     linuxfancy@googlegroups.com, linux-amarula@amarulasolutions.com,
        quentin.schulz@theobroma-systems.com,
        Jacopo Mondi <jacopo@jmondi.org>,
        Daniel Scally <djrscally@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/6] media: ov5693: rename clk into xvclk
Date:   Tue, 12 Jul 2022 18:33:46 +0200
Message-Id: <20220712163349.1308540-4-tommaso.merciai@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220712163349.1308540-1-tommaso.merciai@amarulasolutions.com>
References: <20220712163349.1308540-1-tommaso.merciai@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename clk pdata pointer into xvclk (system clock input).
Same for clk_rate into xvclk_rate. This is more explicit

Signed-off-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>
---
Changes since v3:
 - Add reviewed-by tag, suggested by Jacopo, Krzysztof

 drivers/media/i2c/ov5693.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/media/i2c/ov5693.c b/drivers/media/i2c/ov5693.c
index 9e84468d920e..d2adc5513a21 100644
--- a/drivers/media/i2c/ov5693.c
+++ b/drivers/media/i2c/ov5693.c
@@ -157,7 +157,7 @@ struct ov5693_device {
 	struct gpio_desc *reset;
 	struct gpio_desc *powerdown;
 	struct regulator_bulk_data supplies[OV5693_NUM_SUPPLIES];
-	struct clk *clk;
+	struct clk *xvclk;
 
 	struct ov5693_mode {
 		struct v4l2_rect crop;
@@ -794,7 +794,7 @@ static void ov5693_sensor_powerdown(struct ov5693_device *ov5693)
 
 	regulator_bulk_disable(OV5693_NUM_SUPPLIES, ov5693->supplies);
 
-	clk_disable_unprepare(ov5693->clk);
+	clk_disable_unprepare(ov5693->xvclk);
 }
 
 static int ov5693_sensor_powerup(struct ov5693_device *ov5693)
@@ -804,7 +804,7 @@ static int ov5693_sensor_powerup(struct ov5693_device *ov5693)
 	gpiod_set_value_cansleep(ov5693->reset, 1);
 	gpiod_set_value_cansleep(ov5693->powerdown, 1);
 
-	ret = clk_prepare_enable(ov5693->clk);
+	ret = clk_prepare_enable(ov5693->xvclk);
 	if (ret) {
 		dev_err(ov5693->dev, "Failed to enable clk\n");
 		goto fail_power;
@@ -1390,7 +1390,7 @@ static int ov5693_check_hwcfg(struct ov5693_device *ov5693)
 static int ov5693_probe(struct i2c_client *client)
 {
 	struct ov5693_device *ov5693;
-	u32 clk_rate;
+	u32 xvclk_rate;
 	int ret = 0;
 
 	ov5693 = devm_kzalloc(&client->dev, sizeof(*ov5693), GFP_KERNEL);
@@ -1408,16 +1408,16 @@ static int ov5693_probe(struct i2c_client *client)
 
 	v4l2_i2c_subdev_init(&ov5693->sd, client, &ov5693_ops);
 
-	ov5693->clk = devm_clk_get(&client->dev, "xvclk");
-	if (IS_ERR(ov5693->clk)) {
+	ov5693->xvclk = devm_clk_get(&client->dev, "xvclk");
+	if (IS_ERR(ov5693->xvclk)) {
 		dev_err(&client->dev, "Error getting clock\n");
-		return PTR_ERR(ov5693->clk);
+		return PTR_ERR(ov5693->xvclk);
 	}
 
-	clk_rate = clk_get_rate(ov5693->clk);
-	if (clk_rate != OV5693_XVCLK_FREQ)
+	xvclk_rate = clk_get_rate(ov5693->xvclk);
+	if (xvclk_rate != OV5693_XVCLK_FREQ)
 		dev_warn(&client->dev, "Found clk freq %u, expected %u\n",
-			 clk_rate, OV5693_XVCLK_FREQ);
+			 xvclk_rate, OV5693_XVCLK_FREQ);
 
 	ret = ov5693_configure_gpios(ov5693);
 	if (ret)
-- 
2.25.1

