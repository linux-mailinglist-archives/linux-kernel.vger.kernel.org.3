Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18EDF4EF7AB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 18:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350841AbiDAQVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 12:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353039AbiDAQSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 12:18:31 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E21C160444
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 08:42:49 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id w25so3396938edi.11
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 08:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2QTzX8NPjEsC6DS75wIUIMoC9k1vEC4KyMC77JEhWDI=;
        b=ZwrA4adlvd2jCKD+i2qTWQ+0Q+XRKQFMEpNXkQuuaaIBGVDtcTE5BG6R8bw+4A/T5K
         z7FBj3jQO5clDqB8kO9ADJvJmOe7l3++ImLeqcXCg/Dg1Y2vyF5Exj1duWxm+LRaf/Ar
         sSSDC2il/RbQn4SUibUh9YMUrEOhGnEaX7ppeY4sLFz83nPBDl5/ho8zJRuORN6QST6Y
         EWJWb6OKinyk1m/qH9NF9YLX97cM5Owfa8/c/qNMctYHjXHwEoGzAqR/ymNbvJqUxvrB
         pPFPTmeHZnht3QcelJ7yIF1Z1lZcyWuwlUtnuyUpMJBJ2l7cAGaTiJOzixiONP7t9sbn
         cbAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2QTzX8NPjEsC6DS75wIUIMoC9k1vEC4KyMC77JEhWDI=;
        b=g1DQ+j5E6MSH1YPcbEx+r/y+bncXdsI+UUqvs5xAeSTn5SOrnayqOBE2aKxsasPfGQ
         NQJRDZlQvuV7KWYhTOFPFvlwGa1FMc9k7hIzjM+yO2RAmMI4toWprcCQrmUjQhZz69AD
         HEvx9sui8b6sYajwmb+Z8iIbByhcuaK93IYDeohXRQqSLzIhqGTE4icuj2cQ9jYttHU1
         /3TwPUZ0jSnXGMWK70eSkVDhEc7Qq5RHrQRj6UQd6SzQkIuDWdLH/Yi7SHZtCJavE5tY
         wJtFMw0dMDBHPxGTKMdBx+alhCehvP8e3SP+tW0Da+RyaB6cpgCQ3J5fOjxPIoL4reWh
         JSzA==
X-Gm-Message-State: AOAM531D35WAzbbJnBrflxTRna7W9gk3Jk9Lx2ZxoAbxOhNIWBlLEdvc
        qEhogwh6seDu/heNoEM/T6G69g==
X-Google-Smtp-Source: ABdhPJz4QLYcHdtlV6CyLehrbFSvfS4BABdJhNxxEnOBbddowD6iYsBt3lWTTfhts8yTv0s23ycmog==
X-Received: by 2002:a50:ab16:0:b0:414:39b0:7fc1 with SMTP id s22-20020a50ab16000000b0041439b07fc1mr21423933edc.214.1648827764784;
        Fri, 01 Apr 2022 08:42:44 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id k12-20020aa7c38c000000b0041939d9ccd0sm1300389edq.81.2022.04.01.08.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 08:42:44 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFT PATCH 2/2] regulator: richtek,rt4801: use existing ena_gpiod feature
Date:   Fri,  1 Apr 2022 17:42:37 +0200
Message-Id: <20220401154237.1061331-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220401154237.1061331-1-krzysztof.kozlowski@linaro.org>
References: <20220401154237.1061331-1-krzysztof.kozlowski@linaro.org>
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

The driver duplicated regulator core feature of controlling
regulators with GPIOs (of_parse_cb + ena_gpiod) and created its own
enable-gpios property with multiple GPIOs.

The core already does it. Keep old method for backwards compatibility.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/regulator/rt4801-regulator.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/regulator/rt4801-regulator.c b/drivers/regulator/rt4801-regulator.c
index 7a87788d3f09..9d88b7858a21 100644
--- a/drivers/regulator/rt4801-regulator.c
+++ b/drivers/regulator/rt4801-regulator.c
@@ -34,6 +34,28 @@ struct rt4801_priv {
 	unsigned int volt_sel[DSV_OUT_MAX];
 };
 
+static int rt4801_of_parse_cb(struct device_node *np,
+			      const struct regulator_desc *desc,
+			      struct regulator_config *config)
+{
+	struct rt4801_priv *priv = config->driver_data;
+
+	if (priv->enable_gpios) {
+		dev_warn(priv->dev, "duplicated enable-gpios property\n");
+		return 0;
+	}
+	config->ena_gpiod = fwnode_gpiod_get_index(of_fwnode_handle(np),
+						   "enable-gpios",
+						   0,
+						   GPIOD_OUT_HIGH |
+						   GPIOD_FLAGS_BIT_NONEXCLUSIVE,
+						   "rt4801");
+	if (IS_ERR(config->ena_gpiod))
+		config->ena_gpiod = NULL;
+
+	return 0;
+}
+
 static int rt4801_set_voltage_sel(struct regulator_dev *rdev, unsigned int selector)
 {
 	struct rt4801_priv *priv = rdev_get_drvdata(rdev);
@@ -122,6 +144,7 @@ static const struct regulator_desc rt4801_regulator_descs[] = {
 		.name = "DSVP",
 		.ops = &rt4801_regulator_ops,
 		.of_match = of_match_ptr("DSVP"),
+		.of_parse_cb = rt4801_of_parse_cb,
 		.type = REGULATOR_VOLTAGE,
 		.id = DSV_OUT_POS,
 		.min_uV = MIN_UV,
@@ -135,6 +158,7 @@ static const struct regulator_desc rt4801_regulator_descs[] = {
 		.name = "DSVN",
 		.ops = &rt4801_regulator_ops,
 		.of_match = of_match_ptr("DSVN"),
+		.of_parse_cb = rt4801_of_parse_cb,
 		.type = REGULATOR_VOLTAGE,
 		.id = DSV_OUT_NEG,
 		.min_uV = MIN_UV,
-- 
2.32.0

