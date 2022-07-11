Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D7256D3F9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 06:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiGKEaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 00:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiGKEaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 00:30:14 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6311901C;
        Sun, 10 Jul 2022 21:30:07 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id h23so6780463ejj.12;
        Sun, 10 Jul 2022 21:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oYyjBapI7Ol5ghwqsEsi6GKvHQk9dNKwshNrm1MBekA=;
        b=RIJjqGzCfNlhD/70v6LwMYa0s/R2xFo5RVDVOx6F1CGLarPal0lwxbPMR9I7PJl6xz
         5TB2wRFgDihYRAH+UAnw3r1i3D3NPgwxRHjA82+3oUGxJSeuO4A+MOl+WY3fWjQNrec0
         wbh8OQsHX3+i9bhcnZmV6aHyjRr2AK7METCWENv71z4a/7VknZibizx3H/VpyacyFNfY
         n5N+VUc/5EirLbiA1Vux++K6ZIdcPhE8myBvnj4BhZPp7c7ubAiErPASUnzKx734rjrO
         IfLpgPXgh32FjWnZ1ZXhhvt9jyxhKU/4NPoc4sJZc+atCbuDKxc2jee7sgo8t4mOosPJ
         FBVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oYyjBapI7Ol5ghwqsEsi6GKvHQk9dNKwshNrm1MBekA=;
        b=ptKVPN7VynepkZUTZNWwcejnGyu5sLe51uGAi/sz7Dfps4zDrt0HyWKa2xAYn7ZLuj
         Lfwkw8sbMnZPbZAjvr0HGzTLbdJznX4uFAl4Lh/NVznZ5Di02TbTBOWKu+F0KENAzEUo
         A4yjDMWRFokFUZDfxHQj7/ptFLlLZ3U1qIRK9v89nUEiBd6SgZh08hN0muCMlx1DZySq
         9wf/WQDT8RtpsaZSlFqHUUjaFnT50KXIceTkZhHp5+lcuYK+zwq+PmKLi03FAzHDVFgu
         0KH58Ruw/GPGmeh2q860LpR9f+bcUyvey+RuWFof7X79rinFyr/E3nZYL5Um8ZQsrG6f
         JhGg==
X-Gm-Message-State: AJIora+VTuivWDZig/8grZrsQJCdMQzrX945NMksV45S0OuPy3SGPQa4
        gB5XxxWO9tUir0KBD8VHPA8=
X-Google-Smtp-Source: AGRyM1tBsjHVOKf2envHi/oecZSomJvRCwVJM9BRJfdwLv3Yi8sUtsE3UkUVCACw5K7DDFClUw/q4Q==
X-Received: by 2002:a17:907:16a2:b0:726:abbc:69bf with SMTP id hc34-20020a17090716a200b00726abbc69bfmr16517666ejc.363.1657513805976;
        Sun, 10 Jul 2022 21:30:05 -0700 (PDT)
Received: from localhost.localdomain (89-39-107-113.hosted-by-worldstream.net. [89.39.107.113])
        by smtp.gmail.com with ESMTPSA id j17-20020a17090623f100b00726298147b1sm2203100ejg.161.2022.07.10.21.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 21:30:05 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] media: i2c: ak7375: Add regulator management
Date:   Mon, 11 Jul 2022 08:28:39 +0400
Message-Id: <20220711042838.213351-4-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220711042838.213351-1-y.oudjana@protonmail.com>
References: <20220711042838.213351-1-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
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
 drivers/media/i2c/ak7375.c | 39 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/media/i2c/ak7375.c b/drivers/media/i2c/ak7375.c
index 40b1a4aa846c..59d5cb00e3ba 100644
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
+ * lack of documentation. 2 ms is added as a safety margin.
+ */
+#define AK7375_POWER_DELAY_US	5000
 
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
@@ -132,6 +148,7 @@ static int ak7375_init_controls(struct ak7375_device *dev_vcm)
 static int ak7375_probe(struct i2c_client *client)
 {
 	struct ak7375_device *ak7375_dev;
+	int i;
 	int ret;
 
 	ak7375_dev = devm_kzalloc(&client->dev, sizeof(*ak7375_dev),
@@ -139,6 +156,17 @@ static int ak7375_probe(struct i2c_client *client)
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
+	usleep_range(AK7375_POWER_DELAY_US, AK7375_POWER_DELAY_US + 10);
+
 	ret = ak7375_i2c_write(ak7375_dev, AK7375_REG_CONT,
 		AK7375_MODE_ACTIVE, 1);
 	if (ret) {
-- 
2.37.0

