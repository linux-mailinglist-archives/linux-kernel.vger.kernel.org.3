Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD73569D59
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 10:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235296AbiGGIU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 04:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234787AbiGGIUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 04:20:09 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4502753D26
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 01:19:10 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id g1so14530204edb.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 01:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OU+/1ZARQ0jB8FL93NzkGXB/S1O4C4RObHnGZSJfcBg=;
        b=hDYBAi/KxfZ6QNL5Pb28EkaMQOuXGX6vXQUxNep3Lxuvr1zkL47zEzDo9g+BLMDEyR
         KsVVEhduLHEYSVSUqPjD2hxNCVhT85zZS2w+okI/Jjd9mFMoqs7h0ltcyaoGBJU2sPfm
         72Rg1sn1NX8jwXqc0OURFV+VlW73lpHamrL1puC2b96Y9zOpqPu5uRihVHkb7khAr/tM
         dJEzge5m38P4G39bx79GMi7SdEWDH+sL5pg9JQc6mUP3sh56mOdzITWqu9GEJfJ7Y47d
         qDz4Gxvu2BocRDWfMHg7hmzqSV0CaeFYgrTXRgdxAEUh2bNQ3aWLRpyS5ZneawOsiKwj
         vAXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OU+/1ZARQ0jB8FL93NzkGXB/S1O4C4RObHnGZSJfcBg=;
        b=Dun6EpXPBiyHs1vwppcoQi3O5lLrA/DylMBT2szbtQbXyUFEAtlQ6fpvNuR+Rzeugf
         yd47rQV0YVG621tbFJESkkxPkmZtmAFtKteAiiDFtzGE2haMEZlf/zQaRuZJfrnI9cgs
         Zl0xIfvhYaUcCpgSGgBipyH199tam9Cp+ruNYS6n+241NFd973BMLQSTJl6E6eXtTqE6
         LwM+YLa8EtEciIH6zHlrh8fyXxS6sHLQHEd/7HhB4lltxeoo/hLaG2wx6okySi2OIchy
         GLCblgt5cHEj6D2p0srDsCXontJt+AZwaY6x74KqqA2eW4yhlQBZ/SXAeGNuGKONYYxW
         yeig==
X-Gm-Message-State: AJIora+jYWdBj98PkfDhy6XrQ3rSq26LxvYikK0pUBFx8ejzAKVKhspW
        4dpFw6CFv+nYiuy7yORMP4LZb4Ct5XrZmZgl
X-Google-Smtp-Source: AGRyM1uOLQ2GGBTRfiYr9s2R1dVzJksKvREtmhZEntCZCPs2sSnNJpSErtb7fKpMFY4oWn4LXS6w9g==
X-Received: by 2002:a05:6402:239f:b0:43a:92a7:84e with SMTP id j31-20020a056402239f00b0043a92a7084emr5422416eda.293.1657181948280;
        Thu, 07 Jul 2022 01:19:08 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id f13-20020a170906824d00b00726e108b566sm12871779ejx.173.2022.07.07.01.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 01:19:07 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Laxman Dewangan <ldewangan@nvidia.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>
Subject: [PATCH v4 3/4] regulator: output-supply: Add devicetree support
Date:   Thu,  7 Jul 2022 10:18:25 +0200
Message-Id: <20220707081826.953449-4-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220707081826.953449-1-Naresh.Solanki@9elements.com>
References: <20220707081826.953449-1-Naresh.Solanki@9elements.com>
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

From: Laxman Dewangan <ldewangan@nvidia.com>

Add DT support of the regulator driver output-supply.
The supply names for this driver is provided through DT properties
so that proper regulator(s) handle can be acquired.

Board DT can configure the output-supply driver to
* set regulator name
* turn on at boot time
* specific regulator handles that needs to be controlled by the driver.

Post boot facilitate control of regulator(s) from sysfs.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 drivers/regulator/userspace-consumer.c | 47 ++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/regulator/userspace-consumer.c b/drivers/regulator/userspace-consumer.c
index 8ca28664776e..b424a0ddf582 100644
--- a/drivers/regulator/userspace-consumer.c
+++ b/drivers/regulator/userspace-consumer.c
@@ -18,6 +18,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/regulator/userspace-consumer.h>
 #include <linux/slab.h>
+#include <linux/of.h>
 
 struct userspace_consumer_data {
 	const char *name;
@@ -100,6 +101,40 @@ static const struct attribute_group attr_group = {
 	.attrs	= attributes,
 };
 
+static struct regulator_userspace_consumer_data *get_pdata_from_dt_node(
+		struct platform_device *pdev)
+{
+	struct regulator_userspace_consumer_data *pdata;
+	struct device_node *np = pdev->dev.of_node;
+	struct property *prop;
+	const char *supply;
+	int num_supplies;
+	int count = 0;
+
+	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return ERR_PTR(-ENOMEM);
+
+	pdata->name = of_get_property(np, "regulator-name", NULL);
+	pdata->init_on = of_property_read_bool(np, "regulator-boot-on");
+	num_supplies = of_property_count_strings(np, "regulator-supplies");
+	if (num_supplies < 0) {
+		dev_err(&pdev->dev,
+			"could not parse property regulator-supplies\n");
+		return ERR_PTR(-EINVAL);
+	}
+	pdata->num_supplies = num_supplies;
+	pdata->supplies = devm_kzalloc(&pdev->dev, num_supplies *
+				sizeof(*pdata->supplies), GFP_KERNEL);
+	if (!pdata->supplies)
+		return ERR_PTR(-ENOMEM);
+
+	of_property_for_each_string(np, "regulator-supplies", prop, supply)
+		pdata->supplies[count++].supply = supply;
+
+	return pdata;
+}
+
 static int regulator_userspace_consumer_probe(struct platform_device *pdev)
 {
 	struct regulator_userspace_consumer_data *pdata;
@@ -107,6 +142,11 @@ static int regulator_userspace_consumer_probe(struct platform_device *pdev)
 	int ret;
 
 	pdata = dev_get_platdata(&pdev->dev);
+	if (!pdata && pdev->dev.of_node) {
+		pdata = get_pdata_from_dt_node(pdev);
+		if (IS_ERR(pdata))
+			return PTR_ERR(pdata);
+	}
 	if (!pdata)
 		return -EINVAL;
 
@@ -166,11 +206,18 @@ static int regulator_userspace_consumer_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id regulator_userspace_consumer_of_match[] = {
+	{ .compatible = "9elements,output-supply", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, regulator_userspace_consumer_of_match);
+
 static struct platform_driver regulator_userspace_consumer_driver = {
 	.probe		= regulator_userspace_consumer_probe,
 	.remove		= regulator_userspace_consumer_remove,
 	.driver		= {
 		.name		= "reg-userspace-consumer",
+		.of_match_table = regulator_userspace_consumer_of_match,
 	},
 };
 
-- 
2.35.3

