Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1184572103
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 18:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234114AbiGLQet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 12:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234388AbiGLQeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 12:34:18 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B702872B
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 09:34:17 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id d16so11915019wrv.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 09:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ROC0BgtK/N+kzsuCvrmnTVmfs20tFROFRODZongU+to=;
        b=Zi2SdcL80G94C/94H/uEC9y0GdYUa3JuEkF2g+Zy55afvsfTlrtr9z33l7F+Na0VW1
         2/AkZLTW+AN0e7TslzOclqC8DKUq/a3ACJyCllQfCMOYuBn+9O9bYcGGfoR7gp5AzqA1
         inH6YvuknSOg8CklzFQZ5XUTpLWldzjetjOtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ROC0BgtK/N+kzsuCvrmnTVmfs20tFROFRODZongU+to=;
        b=jAsIrS6FvgonB48SUAvv7OYAg2juoTrhuZTqzzA7+j/S/Iy1xvvBKMwbjAEXuILTCn
         JHain3TjH0tuOxHUw+HOe4VCXbhQkCA0MrD/2Ezwz2pEnoqCQB6MqXwDNIoT/3dS4BvC
         +ujqXLhxH7M7bP0N9Gvlhh0vDc/PVWLgiS72oqJDpBRFS6AOevRrelqK4WnQH18Wi7y2
         tySi0J+wRtX1QtrOTrd0fZrrd0KKXMsGv7fyce1gSfZLQ1Ie5oif6gqP3T50SKGELwa9
         wAuwXffNFaNLwaDjQ4ERMA9RymCIdtP5Q4BUMaqnBG+ee/Fz6/E0CcN0oqQa1LYhgpZp
         q9Rw==
X-Gm-Message-State: AJIora8TH6lLxJsEmGpfwMOmn0MI6YO9QDTQNEy8RceHZPz9yqlYXLbg
        B8eS9hyBBRXmNWidNS6QJnir+g==
X-Google-Smtp-Source: AGRyM1tnzV07IJXA3cVLN0Ve2xjeFMFieXv4fsSLQkxF158BaSiHY5fymewJYa2Lc+WZqQoOJSLevA==
X-Received: by 2002:adf:e0c9:0:b0:21b:8271:2348 with SMTP id m9-20020adfe0c9000000b0021b82712348mr21782133wri.222.1657643655627;
        Tue, 12 Jul 2022 09:34:15 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i.station (net-188-217-53-214.cust.vodafonedsl.it. [188.217.53.214])
        by smtp.gmail.com with ESMTPSA id j16-20020a5d6050000000b0021db2dcd0aasm2321052wrt.108.2022.07.12.09.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 09:34:15 -0700 (PDT)
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
To:     tommaso.merciai@amarulasolutions.com
Cc:     linuxfancy@googlegroups.com, linux-amarula@amarulasolutions.com,
        quentin.schulz@theobroma-systems.com,
        Jacopo Mondi <jacopo@jmondi.org>,
        Daniel Scally <djrscally@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 4/6] media: ov5693: add support for acpi clock-frequency prop
Date:   Tue, 12 Jul 2022 18:33:47 +0200
Message-Id: <20220712163349.1308540-5-tommaso.merciai@amarulasolutions.com>
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

Add support for ACPI-based platforms that specify the clock frequency by
using the "clock-frequency" property instead of specifying a clock
provider reference

Signed-off-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>
---
Changes since v2:
 - Fix commit body as suggested by Sakari, Jacopo
 - Add details to commit body as suggested by Jacopo
 - Move ov5693_check_hwcfg into ov5693_hwcfg
 - Fix xvclk_rate position as suggested by Jacopo
 - Use devm_clk_get_optional instead of devm_clk_get as suggested Jacopo

Changes since v3:
 - Fix commit body as suggested by Jacopo
 - Add reviewed-by tags, suggested by Jacopo, Krzysztof

Changes since v4:
 - Remove wrong Sakari reviewed-by tag, suggested by Krzysztof, Sakari
 - Revert ov5693_check_hwcfg function changes. Keep clk init on probe function
as suggested by Sakari
 - Fix commit body
 - Fix commit msg

 drivers/media/i2c/ov5693.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/media/i2c/ov5693.c b/drivers/media/i2c/ov5693.c
index d2adc5513a21..701468267f20 100644
--- a/drivers/media/i2c/ov5693.c
+++ b/drivers/media/i2c/ov5693.c
@@ -1408,13 +1408,25 @@ static int ov5693_probe(struct i2c_client *client)
 
 	v4l2_i2c_subdev_init(&ov5693->sd, client, &ov5693_ops);
 
-	ov5693->xvclk = devm_clk_get(&client->dev, "xvclk");
-	if (IS_ERR(ov5693->xvclk)) {
-		dev_err(&client->dev, "Error getting clock\n");
-		return PTR_ERR(ov5693->xvclk);
+	ov5693->xvclk = devm_clk_get_optional(&client->dev, "xvclk");
+	if (IS_ERR(ov5693->xvclk))
+		return dev_err_probe(&client->dev, PTR_ERR(ov5693->xvclk),
+				     "failed to get xvclk: %ld\n",
+				     PTR_ERR(ov5693->xvclk));
+
+	if (ov5693->xvclk) {
+		xvclk_rate = clk_get_rate(ov5693->xvclk);
+	} else {
+		ret = fwnode_property_read_u32(dev_fwnode(&client->dev),
+				     "clock-frequency",
+				     &xvclk_rate);
+
+		if (ret) {
+			dev_err(&client->dev, "can't get clock frequency");
+			return ret;
+		}
 	}
 
-	xvclk_rate = clk_get_rate(ov5693->xvclk);
 	if (xvclk_rate != OV5693_XVCLK_FREQ)
 		dev_warn(&client->dev, "Found clk freq %u, expected %u\n",
 			 xvclk_rate, OV5693_XVCLK_FREQ);
-- 
2.25.1

