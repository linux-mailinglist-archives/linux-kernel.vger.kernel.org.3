Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 156D455D958
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236531AbiF0PFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 11:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237623AbiF0PFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 11:05:06 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467F617592
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 08:05:04 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id l68so574458wml.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 08:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AtZ/cIs6lq2eirM771Yk+JBARQCD5B0BoigyCmO2Az8=;
        b=cYYMdAf40LUhOh7aaAKdxOLc6v6PoFzaMIr+tICiSbNkwVafTgkoUcfaoSzLta9hmH
         rWYQYcRTFxjvADGbSecgiSpKYbzd7Nrkz4aYfCCVN6oDub9+Vg3QVJjsBeWUjSdu7agP
         bd+4EHj4NQqUPn45kXSfmUA32xlIEwvmq3Jds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AtZ/cIs6lq2eirM771Yk+JBARQCD5B0BoigyCmO2Az8=;
        b=OsZk9oROveiYN+s2VGQuevXD4ioaVBRn4/vCsZnlZ9SzqL1t8yGCAmepcGPza3E/9L
         zEi2UpS6hAU4kQ93r6TxnS7dVV88WLdoKhuSxvYm5zqJWDsjPFK9meoktIH/9cGofold
         ubDiGdrJ7eeXVIQ9SpQSx2X2+DHT0w+Twj75bu76gRDKN3uhRxmA1V2bDj9KVBjlWeHz
         QsJVpWu9xfe/LLgRaGoJyrSlv9oB6yp6zXRceUEi/LO96cirL9nxTWumiSnLnWCsmn5Z
         YzBxa6owvGZksFRcoMRZrk5dHYEMD/fKE8Hdwl5WxvOtb1P7bbNlGhP31RloTChbTbKM
         nqtQ==
X-Gm-Message-State: AJIora+vqByCMroP9Wno2vP4gC4c2bwHIQ+oPHgqfcnVub3cnZo06hqA
        j6FMMM8k75YiypHJSAkOKIhfcQ==
X-Google-Smtp-Source: AGRyM1vJbFEzPVvR33i2qVveTyf/wUdKYArUHghQcAkmLddHCcDSR6go3aK+gcQnU374q+pmCYj+1w==
X-Received: by 2002:a05:600c:4f54:b0:3a0:4a5b:2692 with SMTP id m20-20020a05600c4f5400b003a04a5b2692mr6413740wmq.109.1656342302744;
        Mon, 27 Jun 2022 08:05:02 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i.station (net-188-217-58-216.cust.vodafonedsl.it. [188.217.58.216])
        by smtp.gmail.com with ESMTPSA id d18-20020adfe852000000b0021ba3d1f2a0sm10581250wrn.48.2022.06.27.08.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 08:05:02 -0700 (PDT)
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Cc:     linuxfancy@googlegroups.com, linux-amarula@amarulasolutions.com,
        quentin.schulz@theobroma-systems.com,
        Tommaso Merciai <tommaso.merciai@amarulasolutions.com>,
        Daniel Scally <djrscally@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/7] media: ov5693: move hw cfg functions into ov5693_check_hwcfg
Date:   Mon, 27 Jun 2022 17:04:50 +0200
Message-Id: <20220627150453.220292-5-tommaso.merciai@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220627150453.220292-1-tommaso.merciai@amarulasolutions.com>
References: <20220627150453.220292-1-tommaso.merciai@amarulasolutions.com>
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

Move hw configuration functions into ov5693_check_hwcfg. This is done to
separe the code that handle the hw cfg from probe in a clean way

Signed-off-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
---
 drivers/media/i2c/ov5693.c | 53 +++++++++++++++++++++++---------------
 1 file changed, 32 insertions(+), 21 deletions(-)

diff --git a/drivers/media/i2c/ov5693.c b/drivers/media/i2c/ov5693.c
index d2adc5513a21..d5a934ace597 100644
--- a/drivers/media/i2c/ov5693.c
+++ b/drivers/media/i2c/ov5693.c
@@ -1348,6 +1348,38 @@ static int ov5693_check_hwcfg(struct ov5693_device *ov5693)
 	struct fwnode_handle *endpoint;
 	unsigned int i;
 	int ret;
+	u32 xvclk_rate;
+
+	ov5693->xvclk = devm_clk_get(ov5693->dev, "xvclk");
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
 
 	endpoint = fwnode_graph_get_next_endpoint(fwnode, NULL);
 	if (!endpoint)
@@ -1390,7 +1422,6 @@ static int ov5693_check_hwcfg(struct ov5693_device *ov5693)
 static int ov5693_probe(struct i2c_client *client)
 {
 	struct ov5693_device *ov5693;
-	u32 xvclk_rate;
 	int ret = 0;
 
 	ov5693 = devm_kzalloc(&client->dev, sizeof(*ov5693), GFP_KERNEL);
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

