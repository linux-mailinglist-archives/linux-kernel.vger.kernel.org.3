Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7BCE53D75F
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 16:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237536AbiFDO6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 10:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237295AbiFDO6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 10:58:23 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7C42DAA8;
        Sat,  4 Jun 2022 07:58:22 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id n28so13509150edb.9;
        Sat, 04 Jun 2022 07:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G3WUTrS43xMubXSeHvPTm76AC1maAo3b+eXYxXwFcfQ=;
        b=jfWNtouFZ1OdY3NvPQz0NMrnBGSYG5fhzi1ni/vjpvF+yBhDoWURnDJ0ZxzMb5SthB
         OB08N4QhWZI4AOf1pJq/WchIYX95LtdsU+6XpmcszVaHQrWg2i2GTNMqxi2kIFZE97al
         iK3e7DxiUdUNMFnBCN5VhrdPoEZJWWWo0yIpriD8gkBlZQyLfPpY0ZF3H+LiB/Dl3InP
         oxnGur1I4EG/niuS1rcTCaNFDxbZ1Gn6U3QwV28PeHMzocqB13orEx69astuwQbdK0yK
         k/1OynLhLD1D0ezhNr9IaEJqmkw2XdvWpzMgtoH5yG4a+Y3cW8mkPh8hbQo/sEtDrdeQ
         lNbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G3WUTrS43xMubXSeHvPTm76AC1maAo3b+eXYxXwFcfQ=;
        b=eyNZqRwFN5K1JzsZV9Z86AN6DjHGgu8RWSTHL45UtUR3sLq9dVBq8QIt6wDAl43nQd
         qyhoAiBDyzXB4FhFca0w/HTiGUTqXL+GEPdX7ukn4noN6fHc7Nwka8WOMlRLEteYY2O6
         ZuqcX2DtS8hdSeCmCh8vN1pp7BNcpEPrcQknXBxmrsaEYqYQpK9YmyvrRVlv0nyvHWNq
         6iw7tgOLrcpbakGwrHCM8I3uPa+DeAgzWRkhwJeFQxIlA8c1PvMKrO8bmWL5I7ONMA92
         lk3gpUYuY8zZvT3q0ucmDImATV2ZcX+VdPiskz97BYY//AwHc+MhaqS9bMxEBGM99G/C
         eS/g==
X-Gm-Message-State: AOAM5331gKzj6nouSPh5Vt8z6fN/FRzMK+JfzwA57b05yLBosJTLaLvy
        kwo1FohaU2r4lWp0AdWVzhA=
X-Google-Smtp-Source: ABdhPJxEHAwkE8lsY+J7sJpZsGafoQsAGpo8dKcyAWzBnaX4xABKrBwd6SzaNqMf9QkgzR+lNU7iaA==
X-Received: by 2002:a05:6402:50ce:b0:42e:2208:bd8c with SMTP id h14-20020a05640250ce00b0042e2208bd8cmr11993997edb.216.1654354700754;
        Sat, 04 Jun 2022 07:58:20 -0700 (PDT)
Received: from fedora.robimarko.hr (cpe-94-253-165-43.zg.cable.xnet.hr. [94.253.165.43])
        by smtp.googlemail.com with ESMTPSA id lk24-20020a170906cb1800b006fa84a0af2asm4139322ejb.16.2022.06.04.07.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 07:58:20 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     sravanhome@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v2 3/4] regulator: mp5416: use OF match data
Date:   Sat,  4 Jun 2022 16:58:15 +0200
Message-Id: <20220604145816.47576-3-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220604145816.47576-1-robimarko@gmail.com>
References: <20220604145816.47576-1-robimarko@gmail.com>
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

