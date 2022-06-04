Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31FA653D75E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 16:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237431AbiFDO6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 10:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237298AbiFDO6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 10:58:24 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371192DD4E;
        Sat,  4 Jun 2022 07:58:23 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id n10so21062553ejk.5;
        Sat, 04 Jun 2022 07:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OkZxJ2cbCpkeb5OXZiKnIfcDHtHJrUFww95s/52sWJ0=;
        b=oUvfti/HE4YpYOxMCKBiVDfq30MGveeaaVOfSd7DIY6Y+OR0C7JRY64l9uQJol5XYL
         0oM8XffefkP0J8XjUqzLBvWgDMvheG9B7LD6OPQVKs/Rw6cQjnpz6MuFU1S0DyYJq16S
         ddjrXlVZ/5btBDrfKVaQB6hVNQOfWd1vZCzQjWX0X/TQhQbv+a34w0HV2lTU1Yn+Uffg
         OQM/XbElp7jdOHekitNESGmYOETDWxn3YQQS3gsp7krhKqBhk/D4LLGPmDqv/iIdqfI6
         6Nbftm+fRr/bKp/uOQXSIuC503eFXVo6TxFkRrxxyfTGIDMZmcI+5dSf2c25OEZSiAjD
         O0QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OkZxJ2cbCpkeb5OXZiKnIfcDHtHJrUFww95s/52sWJ0=;
        b=D1MJm73Xgwv6mMhrdDXobW+MOsYLs9jDdbrQIw4nEvXtag171T1/RHbHeYPn86kflM
         lZUcwa2rBl4DUIy72ceT/4hq3YkzrWe86SCsW2NQXJnAXnCIiDkzH9oPowf9yFdZ7xRq
         d07twzgnjfmoCY24+SYrSI5i8YZ2UieocoL0/6N85VP+jLuNv7TynuROP+qOvLuBx9er
         PKdpE6i/ZDK99taDPWlPOKfhOUzjqkZGXUaKFfCwsLX3sXEUlLwIDEN7M68cE2JGj5ej
         oz94zFDpLsv9ovh3d2Agc2G/tXxHKfeceJVXQTw4Ss3LIp4wiybiN3F2IxuDrCMgH5PY
         v7PQ==
X-Gm-Message-State: AOAM532ohiruRScCNbHnNcYGtmOdsHxdyP0JJ3Mjzjzmo3G+V0pnkd2B
        kAENtxBk3ajSAKeXvRFwQeQ=
X-Google-Smtp-Source: ABdhPJzl8no+3llOEBWyJpjGP0Zs0pkakbQnH3LN9UruNQFPYbqCPrcce3zbd+PA2tg8qctjGUHOCg==
X-Received: by 2002:a17:906:dc89:b0:6f4:d3a9:34ed with SMTP id cs9-20020a170906dc8900b006f4d3a934edmr13303592ejc.459.1654354701728;
        Sat, 04 Jun 2022 07:58:21 -0700 (PDT)
Received: from fedora.robimarko.hr (cpe-94-253-165-43.zg.cable.xnet.hr. [94.253.165.43])
        by smtp.googlemail.com with ESMTPSA id lk24-20020a170906cb1800b006fa84a0af2asm4139322ejb.16.2022.06.04.07.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 07:58:21 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     sravanhome@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v2 4/4] regulator: mp5416: add support for MP5496
Date:   Sat,  4 Jun 2022 16:58:16 +0200
Message-Id: <20220604145816.47576-4-robimarko@gmail.com>
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

MP5496 is the updated version of MP5416 with the only difference being
that now all Buck regulators have the same 0.6-2.1875V range with a 12.5mV
step.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 drivers/regulator/mp5416.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/regulator/mp5416.c b/drivers/regulator/mp5416.c
index 011a825570ea..71e20e8d78ac 100644
--- a/drivers/regulator/mp5416.c
+++ b/drivers/regulator/mp5416.c
@@ -175,6 +175,17 @@ static struct regulator_desc mp5416_regulators_desc[MP5416_MAX_REGULATORS] = {
 	MP5416LDO("ldo4", 4, BIT(1)),
 };
 
+static struct regulator_desc mp5496_regulators_desc[MP5416_MAX_REGULATORS] = {
+	MP5416BUCK("buck1", 1, mp5416_I_limits1, MP5416_REG_CTL1, BIT(0), 1),
+	MP5416BUCK("buck2", 2, mp5416_I_limits2, MP5416_REG_CTL1, BIT(1), 1),
+	MP5416BUCK("buck3", 3, mp5416_I_limits1, MP5416_REG_CTL1, BIT(2), 1),
+	MP5416BUCK("buck4", 4, mp5416_I_limits2, MP5416_REG_CTL2, BIT(5), 1),
+	MP5416LDO("ldo1", 1, BIT(4)),
+	MP5416LDO("ldo2", 2, BIT(3)),
+	MP5416LDO("ldo3", 3, BIT(2)),
+	MP5416LDO("ldo4", 4, BIT(1)),
+};
+
 static int mp5416_i2c_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
@@ -212,12 +223,14 @@ static int mp5416_i2c_probe(struct i2c_client *client)
 
 static const struct of_device_id mp5416_of_match[] = {
 	{ .compatible = "mps,mp5416", .data = &mp5416_regulators_desc },
+	{ .compatible = "mps,mp5496", .data = &mp5496_regulators_desc },
 	{},
 };
 MODULE_DEVICE_TABLE(of, mp5416_of_match);
 
 static const struct i2c_device_id mp5416_id[] = {
 	{ "mp5416", },
+	{ "mp5496", },
 	{ },
 };
 MODULE_DEVICE_TABLE(i2c, mp5416_id);
-- 
2.36.1

