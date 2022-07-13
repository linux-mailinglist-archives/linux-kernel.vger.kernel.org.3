Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C35785739A9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 17:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236842AbiGMPFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 11:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236775AbiGMPF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 11:05:28 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB3F422D9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 08:05:17 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id i204-20020a1c3bd5000000b003a2fa488efdso1046712wma.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 08:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ROC0BgtK/N+kzsuCvrmnTVmfs20tFROFRODZongU+to=;
        b=Pi5HkNDEePtwLENMxhS57celmg+tdd/mSPqrqoqtqKqgFR47zmJL43321HVoJsC1wh
         2Ud7XZDrDnroE7O/HvJ1dACw+i1hu1/QPVKbng4G4R2fl4M27TBuUik/krIn28kowmyq
         RxPEwPE1Z2f1MhfozV+mXVDeTPKpjt9zECO7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ROC0BgtK/N+kzsuCvrmnTVmfs20tFROFRODZongU+to=;
        b=L6Coa/ju2dvo/K05Gp0Z/FVBHGTVls2iWRllTjICNXBGsjGo1kPBZjepKjxKjly0+/
         uSOcGsgnGpP6zMALHRD/f6S0MTpkAjo2qoQaiDmb0OtZ77USK3yjbQZRopZ3R7tvOn8Z
         i82lov3Y/OCfFil5Jo/bLOMoeM6lsu0tD05WyO/xKNKTNlPTl6E7lY0bbBvei77k8fYD
         YiYAOkojPppV4ooiBznORwg32BByyaIoz6K+DWDaG2C2MKEjo3HBjDsTDNUJ5PZY4KLb
         cGHiv8zs+S+CO5sJgKymbR9fhq7KUBbEXstO41A8MUjn3WNRBNGWDDRgFNo2BXzoR+zW
         4JUw==
X-Gm-Message-State: AJIora/w4ADLF3q/eoh15eeElefG7ZQKpzr6f9+0Hl2mjyKBBj4lhWK6
        fBBDwNfIDcO4MwIuwvqEvUfv/Q==
X-Google-Smtp-Source: AGRyM1uDpBa2YqrIh4DfrwnpIykVgeyNgM9u34R9X0eMAUH4W9M6X2Y9ZFxHZ4e6GiheLd84Xvyhaw==
X-Received: by 2002:a05:600c:a187:b0:3a2:eb3e:f1d4 with SMTP id id7-20020a05600ca18700b003a2eb3ef1d4mr10115330wmb.174.1657724715931;
        Wed, 13 Jul 2022 08:05:15 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i.station (net-188-217-51-7.cust.vodafonedsl.it. [188.217.51.7])
        by smtp.gmail.com with ESMTPSA id f17-20020a05600c4e9100b003a2d87aea57sm1465537wmq.10.2022.07.13.08.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 08:05:15 -0700 (PDT)
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
To:     tommaso.merciai@amarulasolutions.com
Cc:     linuxfancy@googlegroups.com, linux-amarula@amarulasolutions.com,
        quentin.schulz@theobroma-systems.com,
        Jacopo Mondi <jacopo@jmondi.org>,
        Daniel Scally <djrscally@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 4/6] media: ov5693: add support for acpi clock-frequency prop
Date:   Wed, 13 Jul 2022 17:05:04 +0200
Message-Id: <20220713150506.2085214-5-tommaso.merciai@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220713150506.2085214-1-tommaso.merciai@amarulasolutions.com>
References: <20220713150506.2085214-1-tommaso.merciai@amarulasolutions.com>
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

