Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE40256049F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 17:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234269AbiF2PaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 11:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234247AbiF2P3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 11:29:51 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B1735AAE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 08:29:49 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id d2so21598293ejy.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 08:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tAxDi2Wkl/35VdNLO85QV0zkWLjv9bTpycYmTXdG8/c=;
        b=Vu/XBGFDNdJlKBD6wvxg3TB3dSW4JFkrhIViX7Abdpgmv9018Ce4xqUNvNYV980N6/
         F7+kMqMsvf57b+zktexwgYQeEjOFcIdxWiDoiXG7ogpXTk9I5EvPpG6SjlOodnU6+yg6
         OCWOaPtZhbjcIpgExw0y60M7bTevlNocZiom0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tAxDi2Wkl/35VdNLO85QV0zkWLjv9bTpycYmTXdG8/c=;
        b=xzlymdgTf6OL5tTlHdYT21pthMhPZxbZBf97QJNNAwT5D1FVJjg2+AVCK87DHXUN0m
         iTk73sH8KtuogJlDKjzMtzm5k3vtu364m14d5p4sgr2vw063f1R8sSs0piXvpdTb96eQ
         jqsZcTDwZ6yrPXWoqQJ4G5l08nGaTfMXppOaWBt4C+xYFaU4DOclM6u+kNUFNWh1qvE3
         j+GL+MEuAaNxntB2cE0DpvmbM9rQ+6U0NSSyOGqhMdiB5g+jbX3z0WsmCm8GDTW8ZXzM
         sDlgs7t/ovbgT2cXsnhLQ7rOEg0CT35kZA5xiHamrfwXqPFqPRqCyjwqxgeLuUcSjmjq
         nu3w==
X-Gm-Message-State: AJIora+BhyI4rVApFrPbeeZ/mvvptdxEyvOOsJLPfpHi2NIgjk6XPy1p
        16gUnWrGR6Gr4RfEbY8o3Dmdeg==
X-Google-Smtp-Source: AGRyM1ugYE074ctuuAmCkt6BZo4n6xyfhSk8+c819JgTB3O+bnFZ1X2dXHAPF0o2Bra1Smg+f86BkQ==
X-Received: by 2002:a17:906:7303:b0:722:f008:2970 with SMTP id di3-20020a170906730300b00722f0082970mr3780343ejc.491.1656516587641;
        Wed, 29 Jun 2022 08:29:47 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i.station (net-188-217-58-216.cust.vodafonedsl.it. [188.217.58.216])
        by smtp.gmail.com with ESMTPSA id h1-20020a1709063c0100b006feec47dae9sm7821853ejg.157.2022.06.29.08.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 08:29:47 -0700 (PDT)
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
To:     tommaso.merciai@amarulasolutions.com
Cc:     linuxfancy@googlegroups.com, linux-amarula@amarulasolutions.com,
        quentin.schulz@theobroma-systems.com,
        Daniel Scally <djrscally@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/6] media: ov5693: move hw cfg functions into ov5693_hwcfg
Date:   Wed, 29 Jun 2022 17:29:31 +0200
Message-Id: <20220629152933.422990-5-tommaso.merciai@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220629152933.422990-1-tommaso.merciai@amarulasolutions.com>
References: <20220629152933.422990-1-tommaso.merciai@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move hw configuration functions into ov5693_hwcfg. This is done to
separate the code that handle the hw cfg from probe in a clean way.
Add also support to get clock from "clock-frequency" fwnode in
ov5675_hwcfg function

Signed-off-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
---
Changes since v2:
 - Fix commit body as suggested by Sakari, Jacopo
 - Add details to commit body as suggested Jacopo
 - Move ov5693_check_hwcfg into ov5693_hwcfg
 - Fix xvclk_rate position as suggested Jacopo

 drivers/media/i2c/ov5693.c | 57 +++++++++++++++++++++++---------------
 1 file changed, 34 insertions(+), 23 deletions(-)

diff --git a/drivers/media/i2c/ov5693.c b/drivers/media/i2c/ov5693.c
index d2adc5513a21..3c805a5a5181 100644
--- a/drivers/media/i2c/ov5693.c
+++ b/drivers/media/i2c/ov5693.c
@@ -1339,16 +1339,48 @@ static int ov5693_get_regulators(struct ov5693_device *ov5693)
 				       ov5693->supplies);
 }
 
-static int ov5693_check_hwcfg(struct ov5693_device *ov5693)
+static int ov5693_hwcfg(struct ov5693_device *ov5693)
 {
 	struct fwnode_handle *fwnode = dev_fwnode(ov5693->dev);
 	struct v4l2_fwnode_endpoint bus_cfg = {
 		.bus_type = V4L2_MBUS_CSI2_DPHY,
 	};
 	struct fwnode_handle *endpoint;
+	u32 xvclk_rate;
 	unsigned int i;
 	int ret;
 
+	ov5693->xvclk = devm_clk_get_optional(ov5693->dev, "xvclk");
+	if (IS_ERR(ov5693->xvclk))
+		return dev_err_probe(ov5693->dev, PTR_ERR(ov5693->xvclk),
+				     "failed to get xvclk: %ld\n",
+				     PTR_ERR(ov5693->xvclk));
+
+	if (ov5693->xvclk) {
+		xvclk_rate = clk_get_rate(ov5693->xvclk);
+	} else {
+		ret = fwnode_property_read_u32(fwnode, "clock-frequency",
+					       &xvclk_rate);
+
+		if (ret) {
+			dev_err(ov5693->dev, "can't get clock frequency");
+			return ret;
+		}
+	}
+
+	if (xvclk_rate != OV5693_XVCLK_FREQ)
+		dev_warn(ov5693->dev, "Found clk freq %u, expected %u\n",
+			 xvclk_rate, OV5693_XVCLK_FREQ);
+
+	ret = ov5693_configure_gpios(ov5693);
+	if (ret)
+		return ret;
+
+	ret = ov5693_get_regulators(ov5693);
+	if (ret)
+		return dev_err_probe(ov5693->dev, ret,
+				     "Error fetching regulators\n");
+
 	endpoint = fwnode_graph_get_next_endpoint(fwnode, NULL);
 	if (!endpoint)
 		return -EPROBE_DEFER; /* Could be provided by cio2-bridge */
@@ -1390,7 +1422,6 @@ static int ov5693_check_hwcfg(struct ov5693_device *ov5693)
 static int ov5693_probe(struct i2c_client *client)
 {
 	struct ov5693_device *ov5693;
-	u32 xvclk_rate;
 	int ret = 0;
 
 	ov5693 = devm_kzalloc(&client->dev, sizeof(*ov5693), GFP_KERNEL);
@@ -1400,7 +1431,7 @@ static int ov5693_probe(struct i2c_client *client)
 	ov5693->client = client;
 	ov5693->dev = &client->dev;
 
-	ret = ov5693_check_hwcfg(ov5693);
+	ret = ov5693_hwcfg(ov5693);
 	if (ret)
 		return ret;
 
@@ -1408,26 +1439,6 @@ static int ov5693_probe(struct i2c_client *client)
 
 	v4l2_i2c_subdev_init(&ov5693->sd, client, &ov5693_ops);
 
-	ov5693->xvclk = devm_clk_get(&client->dev, "xvclk");
-	if (IS_ERR(ov5693->xvclk)) {
-		dev_err(&client->dev, "Error getting clock\n");
-		return PTR_ERR(ov5693->xvclk);
-	}
-
-	xvclk_rate = clk_get_rate(ov5693->xvclk);
-	if (xvclk_rate != OV5693_XVCLK_FREQ)
-		dev_warn(&client->dev, "Found clk freq %u, expected %u\n",
-			 xvclk_rate, OV5693_XVCLK_FREQ);
-
-	ret = ov5693_configure_gpios(ov5693);
-	if (ret)
-		return ret;
-
-	ret = ov5693_get_regulators(ov5693);
-	if (ret)
-		return dev_err_probe(&client->dev, ret,
-				     "Error fetching regulators\n");
-
 	ov5693->sd.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
 	ov5693->pad.flags = MEDIA_PAD_FL_SOURCE;
 	ov5693->sd.entity.function = MEDIA_ENT_F_CAM_SENSOR;
-- 
2.25.1

