Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4387053D754
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 16:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237135AbiFDO4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 10:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237062AbiFDO4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 10:56:32 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F4C2A27D
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 07:56:31 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id v1so10343738ejg.13
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jun 2022 07:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G3WUTrS43xMubXSeHvPTm76AC1maAo3b+eXYxXwFcfQ=;
        b=jloc82wAQJM3TSmUzs78AHHg/prjbv0h2DLeouEbBXpNKqUDREzivFwwyfs4UlOKUt
         kaQhejrrjA66RGFK+8MiA4fLqQ43niyXX9JY1C/EeZECyRRv2CfDMrxe2ey5WOJGMOAh
         oY0Xeb3ZGZ+G8WKNkbCZgnsF2SNA8VL7yNlqM+xJBB2p5Qwk1IcfIXiKxvhA+4HxoU+L
         u4OE2dX3VbtwJs0ISGDFO179GnkX3oCVKLrf+4bn7abBRAy5HjO1f8S5lTpyOKfh2gnF
         JV3hSmFRvEWXKyO41bxqEOz06tGf4yEfqnoLrC+qnyLkXT+gIMUPjsTnZBEhx3Yk+mxP
         9C9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G3WUTrS43xMubXSeHvPTm76AC1maAo3b+eXYxXwFcfQ=;
        b=ysJpI2U+lPxgpj443UBh/EERPPK+NZrfmZaZ2Q68x0BvyXlOWDwDccQfl4/Zj+eCRZ
         Bwcq1Zol+mtF+k3i5P+2XLkGuPKfQYnVHTRoyj84B1DGqdQGCJlqqvfpEX78uG7vQGB3
         vX/aVtUH1DdncmdffrvcZCSby7dU3Pb3cMCQVgLenLT4KzyGriQX5j9Et+/Ic8qBCm+h
         zz4Cm4saVNMmPrPk/0iUHXk8IJHQTqMpX5g6SYUFUd+K7cpc4XrE5skZcKzpKJn9EQLQ
         VTpnPKhQQYPgkHZsOx4HgjwceYjYb/+6p5ZI/YN3W5BsE3hFmnz/FIXRxbi2A2qoWrXR
         zxIg==
X-Gm-Message-State: AOAM531UUPQri7rb3Bydg6lFRkYvobK/7J2cQirkVoSPVTYdSJt5cQGs
        awQfZM/+f5fjgqhlRciahp0=
X-Google-Smtp-Source: ABdhPJx9M7QOOKoE02TR/iy4NXK8rP/7iH2B+pCuwuebsCmzRsmxQEyiDmSpC+EVRmvAGroyTem0Jw==
X-Received: by 2002:a17:907:1689:b0:6fe:fcf4:128e with SMTP id hc9-20020a170907168900b006fefcf4128emr13784254ejc.446.1654354589521;
        Sat, 04 Jun 2022 07:56:29 -0700 (PDT)
Received: from fedora.robimarko.hr (cpe-94-253-165-43.zg.cable.xnet.hr. [94.253.165.43])
        by smtp.googlemail.com with ESMTPSA id j15-20020a170906430f00b006f3ef214dc7sm4175960ejm.45.2022.06.04.07.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 07:56:29 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     sravanhome@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH 2/3] regulator: mp5416: use OF match data
Date:   Sat,  4 Jun 2022 16:56:23 +0200
Message-Id: <20220604145624.47326-2-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220604145624.47326-1-robimarko@gmail.com>
References: <20220604145624.47326-1-robimarko@gmail.com>
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

In preparation for adding support for MP5496 which slightly differs from
MP5416 convert the driver to use OF match data instead of always using the
MP5416 regulator_desc for regulator registration.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 drivers/regulator/mp5416.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/mp5416.c b/drivers/regulator/mp5416.c
index d8245080df03..011a825570ea 100644
--- a/drivers/regulator/mp5416.c
+++ b/drivers/regulator/mp5416.c
@@ -11,6 +11,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/regulator/driver.h>
@@ -178,6 +179,7 @@ static int mp5416_i2c_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
 	struct regulator_config config = { NULL, };
+	static const struct regulator_desc *desc;
 	struct regulator_dev *rdev;
 	struct regmap *regmap;
 	int i;
@@ -188,12 +190,16 @@ static int mp5416_i2c_probe(struct i2c_client *client)
 		return PTR_ERR(regmap);
 	}
 
+	desc = of_device_get_match_data(dev);
+	if (!desc)
+		return -ENODEV;
+
 	config.dev = dev;
 	config.regmap = regmap;
 
 	for (i = 0; i < MP5416_MAX_REGULATORS; i++) {
 		rdev = devm_regulator_register(dev,
-					       &mp5416_regulators_desc[i],
+					       &desc[i],
 					       &config);
 		if (IS_ERR(rdev)) {
 			dev_err(dev, "Failed to register regulator!\n");
@@ -205,7 +211,7 @@ static int mp5416_i2c_probe(struct i2c_client *client)
 }
 
 static const struct of_device_id mp5416_of_match[] = {
-	{ .compatible = "mps,mp5416" },
+	{ .compatible = "mps,mp5416", .data = &mp5416_regulators_desc },
 	{},
 };
 MODULE_DEVICE_TABLE(of, mp5416_of_match);
-- 
2.36.1

