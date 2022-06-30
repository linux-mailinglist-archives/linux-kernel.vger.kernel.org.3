Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F272B561BEB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 15:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235629AbiF3NuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 09:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235398AbiF3Nta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 09:49:30 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688352CDF4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 06:48:46 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id k20so5239178edj.13
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 06:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ROC0BgtK/N+kzsuCvrmnTVmfs20tFROFRODZongU+to=;
        b=NaoC0xFuRq2ObQvdXuPj82w4yVCM/A/ZMWn+W0zeWYsDUTYGGbQJdNxBJqYyAbTzCT
         qcFAuggucFIZvrj9SpxMx/AS8vGpx1GzK/cA9mktGtrnKV4DV3CsYHfYhWHkavX5gAbx
         U/Mtc6Q7FM9kqfsf1I9SsvzlZpEq/sgXxdi9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ROC0BgtK/N+kzsuCvrmnTVmfs20tFROFRODZongU+to=;
        b=PjoOhR1Fn0fBs6LOwoAhNXVM12lGARlazaFW4kM5d8SWx73ilcc8BP+h/hASzRk7wa
         iw327P42us9d8NWZfXOP3i539Wm2eSJFdlZu/qZVpiZSmZ7YB3x0cOmQLmMvBE5eqvLP
         cXDQaBkqFGlc4PyBjELBAQXeoKQCOk2IynYznupVb+thj6Z0PEfZ+Aq9Xw8TY9Z7omvQ
         LmnSnMPGynYOm69uYMl0MgKLNvW1kSNe4CFnZ9asohhC0XyllPcWRhqpsSIM+oCU82Wz
         IdEC4dZ3QQBq8U/WiMbRbiWNsg5nwgIcLhTc5tpANLbgODeSIIqhhugGv0eTH30Y4tEE
         6kog==
X-Gm-Message-State: AJIora+9mm5u+7xJYBTRd5d/PC5j48TOlWpftQa+z9svf+jKotkVeVPY
        oonydawWNfJzcBp+tICAvMoq8w==
X-Google-Smtp-Source: AGRyM1s9h/6dn4X3QmybTx+NQeRd1kfhotuKgCuC0FQY7rw9ZwgAgS9szjrVgzUwVvo9Sc+uvVDy0g==
X-Received: by 2002:aa7:d294:0:b0:435:5d12:867f with SMTP id w20-20020aa7d294000000b004355d12867fmr11725808edq.147.1656596925203;
        Thu, 30 Jun 2022 06:48:45 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i.station (net-188-217-58-216.cust.vodafonedsl.it. [188.217.58.216])
        by smtp.gmail.com with ESMTPSA id k5-20020a1709067ac500b006fee526ed72sm9130288ejo.217.2022.06.30.06.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 06:48:44 -0700 (PDT)
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
To:     tommaso.merciai@amarulasolutions.com
Cc:     linuxfancy@googlegroups.com, linux-amarula@amarulasolutions.com,
        quentin.schulz@theobroma-systems.com,
        Jacopo Mondi <jacopo@jmondi.org>,
        Daniel Scally <djrscally@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 4/6] media: ov5693: add support for acpi clock-frequency prop
Date:   Thu, 30 Jun 2022 15:48:33 +0200
Message-Id: <20220630134835.592521-5-tommaso.merciai@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220630134835.592521-1-tommaso.merciai@amarulasolutions.com>
References: <20220630134835.592521-1-tommaso.merciai@amarulasolutions.com>
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

