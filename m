Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F187D5705FB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 16:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbiGKOmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 10:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbiGKOl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 10:41:58 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E8C6D2FE;
        Mon, 11 Jul 2022 07:41:51 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id va17so9261528ejb.0;
        Mon, 11 Jul 2022 07:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OGhZTj5ZWGv/eTym6XOpCg2bZQb8uWXBpna96uNZQLA=;
        b=pLXX7QjLGzJMlrsyc7zv0canr2KOOS+gjDPGHDNPiUiqPlMRg3H4yA4NHLCg28lv6l
         Sw6VhScDmz5ipC5Em63Q1TJiKd8tU9x6HjwogT7UrlSS82yOEaFG3RZoKiD7LOaRvXj0
         uCIV5w1cyStDGjwb6PdYzdvNIRZqej0owWzc2LuP3ZWcw8AppIwEi51Sq7xWtGjrRYrn
         6Snp9U8EZVktyg/0/NRmgiwPdGkW5TcaA8pc/SUHjCE6e28pk99thQB1vBupYy42D5QG
         JZOyjnKRmZhsDo+ltCSjPGU9FOj+tHAWDMOnnhEbFRYsACmXKESkMStoPlw1nHu1qu9J
         FsmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OGhZTj5ZWGv/eTym6XOpCg2bZQb8uWXBpna96uNZQLA=;
        b=k55o1rMeUJfqEDuy/UqFs16XKHhAUoDq8K+x0ctS5uvg2vOR0gY5pdQB6OryUf6Hpi
         H7TW/K3SEwR/UdjXlRgBdsKbQ/Nf/yjeZNWubxfsr7QgnAwO9xGLnZztDjviZWB58hyM
         wA0HdORVOX13+zBCan3/9SgGZzqMMrd2Y0HkLZLNRHIbhxGfix54ofAU+uO2dUKUK3XZ
         f3vfVM8RS1Yns8wgaiIjTV9EnoQ/OC0Kw104FMKM1ZeBeVE+KPa7gDW47Gz9RActT2/6
         IRe0iDe17OIU7xi9JHTtybAb7/4xwijyG68cjlw+ZFFv83LgDKuDsdfXtsvVLe6DJpK0
         Vsfg==
X-Gm-Message-State: AJIora9qulF5omWERkgj9alaHk7dTq9iHOBuLw0KW8JZPo/M2dBXdPQY
        6KxMjm+qmyNvFXEfKPwLK3I/matCtigZL/+D
X-Google-Smtp-Source: AGRyM1vl9kBGEmWp2DTA164KVmbJv1lySwAvttmKioVX7GsaVLslW4UHHcVKMosu7TifmP8HU6Rr+Q==
X-Received: by 2002:a17:907:1361:b0:72b:3554:4f7 with SMTP id yo1-20020a170907136100b0072b355404f7mr13449704ejb.420.1657550509279;
        Mon, 11 Jul 2022 07:41:49 -0700 (PDT)
Received: from localhost.localdomain (89-39-107-113.hosted-by-worldstream.net. [89.39.107.113])
        by smtp.gmail.com with ESMTPSA id cm10-20020a0564020c8a00b00436f3107bdasm4461390edb.38.2022.07.11.07.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 07:41:48 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        Jacopo Mondi <jacopo@jmondi.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] media: i2c: ak7375: Add regulator management
Date:   Mon, 11 Jul 2022 18:40:39 +0400
Message-Id: <20220711144039.232196-4-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220711144039.232196-1-y.oudjana@protonmail.com>
References: <20220711144039.232196-1-y.oudjana@protonmail.com>
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

From: Yassine Oudjana <y.oudjana@protonmail.com>

Make the driver get needed regulators on probe and enable/disable
them on runtime PM callbacks.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
Changes since v1:
  - Reorganize variable declaration
  - Change the power-on delay range to 3000-3500 microseconds.

 drivers/media/i2c/ak7375.c | 39 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/media/i2c/ak7375.c b/drivers/media/i2c/ak7375.c
index 40b1a4aa846c..c2b2542a0056 100644
--- a/drivers/media/i2c/ak7375.c
+++ b/drivers/media/i2c/ak7375.c
@@ -6,6 +6,7 @@
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
+#include <linux/regulator/consumer.h>
 #include <media/v4l2-ctrls.h>
 #include <media/v4l2-device.h>
 
@@ -23,17 +24,32 @@
  */
 #define AK7375_CTRL_STEPS	64
 #define AK7375_CTRL_DELAY_US	1000
+/*
+ * The vcm takes around 3 ms to power on and start taking
+ * I2C messages. This value was found experimentally due to
+ * lack of documentation.
+ */
+#define AK7375_POWER_DELAY_US	3000
 
 #define AK7375_REG_POSITION	0x0
 #define AK7375_REG_CONT		0x2
 #define AK7375_MODE_ACTIVE	0x0
 #define AK7375_MODE_STANDBY	0x40
 
+static const char * const ak7375_supply_names[] = {
+	"vdd",
+	"vio",
+};
+
+#define AK7375_NUM_SUPPLIES ARRAY_SIZE(ak7375_supply_names)
+
 /* ak7375 device structure */
 struct ak7375_device {
 	struct v4l2_ctrl_handler ctrls_vcm;
 	struct v4l2_subdev sd;
 	struct v4l2_ctrl *focus;
+	struct regulator_bulk_data supplies[AK7375_NUM_SUPPLIES];
+
 	/* active or standby mode */
 	bool active;
 };
@@ -133,12 +149,24 @@ static int ak7375_probe(struct i2c_client *client)
 {
 	struct ak7375_device *ak7375_dev;
 	int ret;
+	int i;
 
 	ak7375_dev = devm_kzalloc(&client->dev, sizeof(*ak7375_dev),
 				  GFP_KERNEL);
 	if (!ak7375_dev)
 		return -ENOMEM;
 
+	for (i = 0; i < AK7375_NUM_SUPPLIES; i++)
+		ak7375_dev->supplies[i].supply = ak7375_supply_names[i];
+
+	ret = devm_regulator_bulk_get(&client->dev, AK7375_NUM_SUPPLIES,
+				      ak7375_dev->supplies);
+	if (ret) {
+		dev_err(&client->dev, "Failed to get regulators: %pe",
+			ERR_PTR(ret));
+		return ret;
+	}
+
 	v4l2_i2c_subdev_init(&ak7375_dev->sd, client, &ak7375_ops);
 	ak7375_dev->sd.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
 	ak7375_dev->sd.internal_ops = &ak7375_int_ops;
@@ -210,6 +238,10 @@ static int __maybe_unused ak7375_vcm_suspend(struct device *dev)
 	if (ret)
 		dev_err(dev, "%s I2C failure: %d\n", __func__, ret);
 
+	ret = regulator_bulk_disable(AK7375_NUM_SUPPLIES, ak7375_dev->supplies);
+	if (ret)
+		return ret;
+
 	ak7375_dev->active = false;
 
 	return 0;
@@ -230,6 +262,13 @@ static int __maybe_unused ak7375_vcm_resume(struct device *dev)
 	if (ak7375_dev->active)
 		return 0;
 
+	ret = regulator_bulk_enable(AK7375_NUM_SUPPLIES, ak7375_dev->supplies);
+	if (ret)
+		return ret;
+
+	/* Wait for vcm to become ready */
+	usleep_range(AK7375_POWER_DELAY_US, AK7375_POWER_DELAY_US + 500);
+
 	ret = ak7375_i2c_write(ak7375_dev, AK7375_REG_CONT,
 		AK7375_MODE_ACTIVE, 1);
 	if (ret) {
-- 
2.37.0

