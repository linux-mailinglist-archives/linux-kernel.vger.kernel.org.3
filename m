Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A26153D755
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 16:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237207AbiFDO4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 10:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237111AbiFDO4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 10:56:32 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E462A27C
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 07:56:31 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id y19so21031443ejq.6
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jun 2022 07:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OkZxJ2cbCpkeb5OXZiKnIfcDHtHJrUFww95s/52sWJ0=;
        b=K69wEjVC//qiDh3hGolwibjsDmWfuZtDlhCw1gUM+vgcMHGiTN358z4j6tpkFhWBdS
         aXqvRd4hGKJ6vmZlDQQZNeCFcaJ13O4ivp8glLuoPcVzRdZJrXKP9psgJ1mJI13vN/Oh
         vzjIljf4cattDEz3rvmkFz7EPcP+NiDbFfu4eW5fm58GBNu1ctnj2lJQToCAq2Xj7aDI
         2YX81+CLMOVfWKioJ9+tcdE2KfU80GikvxA7W8A7A5XKUZCJ6Secr4KT1VXcfTQebVCf
         2QzLjjkJsfsgUWpAF063hqarAm55WQnIzXqgXs7hDjzIlDIsB44XthVs0varKLLL3fJB
         yWZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OkZxJ2cbCpkeb5OXZiKnIfcDHtHJrUFww95s/52sWJ0=;
        b=ZepoWFtHoWXSn32sZhWR4TsGVV7nWoCdIzJfxCleqPCSkJt76cKhGtqGas/2mvPZE1
         gVIvHAIBKHZc37kWb7bjnJESFAzPTIRxzbM/RIE5Ti4NNwNF7qkObhjEjz8tEOhuFG6Z
         yPUWNOYfx6hT2H3HWHdsvEZrapnl2gOffmuKJGpV3A7gaW5IJSwkHgKymdcUeMwlPCKD
         0pPcidPT3RDl3iqRg/mXTqDl2KEfSKSJ06z4VTcBdB9bU/jfXJ5Ikz9QTzAo315riYt/
         7lJn2tivDqXQWydlAQBf5GbqAVQLG1vOsuVHJYxqnUOS34gfdKVxFc6qNoqoA58m63H5
         GESA==
X-Gm-Message-State: AOAM533qDvDDEz192mAbUCAAZ0QdEMnU++K8f5t6AyNs3qxLg2R9mRD1
        5LCpyM8tDS9yCPHIOKRs2ccirtUdCoM=
X-Google-Smtp-Source: ABdhPJxSm1iyQxSYlrfS3IQoHmQcacY4V5aG1T8pVfRezCjOqX7S1AYtm5f9/VizTD3iKPA9l5gRCw==
X-Received: by 2002:a17:907:8a1f:b0:6fe:f4fc:750f with SMTP id sc31-20020a1709078a1f00b006fef4fc750fmr13127964ejc.399.1654354590414;
        Sat, 04 Jun 2022 07:56:30 -0700 (PDT)
Received: from fedora.robimarko.hr (cpe-94-253-165-43.zg.cable.xnet.hr. [94.253.165.43])
        by smtp.googlemail.com with ESMTPSA id j15-20020a170906430f00b006f3ef214dc7sm4175960ejm.45.2022.06.04.07.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 07:56:29 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     sravanhome@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH 3/3] regulator: mp5416: add support for MP5496
Date:   Sat,  4 Jun 2022 16:56:24 +0200
Message-Id: <20220604145624.47326-3-robimarko@gmail.com>
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

