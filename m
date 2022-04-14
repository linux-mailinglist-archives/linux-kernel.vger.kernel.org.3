Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB5BB501A31
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 19:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343617AbiDNRnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 13:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343611AbiDNRmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 13:42:45 -0400
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8AB7C6829;
        Thu, 14 Apr 2022 10:40:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1649957993; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=SnHs9kqn+cC05uft/R9ElsEx7TdlePwsczIgteeT4q0fDdiUyfP5ZDpUTYD/pyu5fjM5FozIO3U4q+0EigbEfnY+z4xX5xcTOQNgKmvKHTNl8JHwVNw4tcyLm60Oky3HSqR89MPCDbXzHbk8LQAS/ufLOlESmXeJTGyaRQgOisY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1649957993; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=cs1Rj7B0YCCL7XyUOed90CMuONsGpR5YbMUHqZpLxEo=; 
        b=RKXTbzJIxhZdVR+337z4VS7f1yE0pLYUFl4yKKoQ04Kfy8Ku9Ua3N4ejfqQh787vE34qWMyXhFjQ0IlMIFA1JWvoFQlo0efxmWq1GtM+R3Ykt6/mk6eMALh4L7FhazoH33tf6faahADUczQdLmqIAGGDRKBjkR0v2OU9Dpplcuc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1649957993;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Reply-To;
        bh=cs1Rj7B0YCCL7XyUOed90CMuONsGpR5YbMUHqZpLxEo=;
        b=UAvffek+M6eGU0tE0RGDyzICLk4eHOOKG1WJ5eUQ6mj4i3v5I+O6lFNdKL4EiPxf
        gXOlzgzCn85PcBHtu7T9eTSzfHGNgvUy/mBiKMCX/26w1ZMTN2YXy9MnFnX4M0XASNS
        BoCDyzzg6b+plyS5qy8/jWIPonJgTSyEx/0AmrtA=
Received: from arinc9-PC.localdomain (85.117.236.245 [85.117.236.245]) by mx.zohomail.com
        with SMTPS id 1649957991371587.6404861710015; Thu, 14 Apr 2022 10:39:51 -0700 (PDT)
From:   =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Joe Perches <joe@perches.com>
Cc:     erkin.bozoglu@xeront.com,
        =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: [PATCH v2 03/14] pinctrl: ralink: rename pinmux functions to pinctrl
Date:   Thu, 14 Apr 2022 20:39:05 +0300
Message-Id: <20220414173916.5552-4-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220414173916.5552-1-arinc.unal@arinc9.com>
References: <20220414173916.5552-1-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename pinctrl related functions from "pinmux" to "pinctrl". Change driver
name from "ralink-pinmux" to "ralink-pinctrl".

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 drivers/pinctrl/ralink/pinctrl-mt7620.c | 22 +++++++++++-----------
 drivers/pinctrl/ralink/pinctrl-mt7621.c | 20 ++++++++++----------
 drivers/pinctrl/ralink/pinctrl-ralink.c | 14 +++++++-------
 drivers/pinctrl/ralink/pinctrl-ralink.h |  4 ++--
 drivers/pinctrl/ralink/pinctrl-rt288x.c | 20 ++++++++++----------
 drivers/pinctrl/ralink/pinctrl-rt305x.c | 24 ++++++++++++------------
 drivers/pinctrl/ralink/pinctrl-rt3883.c | 20 ++++++++++----------
 7 files changed, 62 insertions(+), 62 deletions(-)

diff --git a/drivers/pinctrl/ralink/pinctrl-mt7620.c b/drivers/pinctrl/ralink/pinctrl-mt7620.c
index 51b863d85c51..a790f3944314 100644
--- a/drivers/pinctrl/ralink/pinctrl-mt7620.c
+++ b/drivers/pinctrl/ralink/pinctrl-mt7620.c
@@ -362,30 +362,30 @@ static struct ralink_pmx_group mt76x8_pinmux_data[] = {
 	{ 0 }
 };
 
-static int mt7620_pinmux_probe(struct platform_device *pdev)
+static int mt7620_pinctrl_probe(struct platform_device *pdev)
 {
 	if (is_mt76x8())
-		return ralink_pinmux_init(pdev, mt76x8_pinmux_data);
+		return ralink_pinctrl_init(pdev, mt76x8_pinmux_data);
 	else
-		return ralink_pinmux_init(pdev, mt7620a_pinmux_data);
+		return ralink_pinctrl_init(pdev, mt7620a_pinmux_data);
 }
 
-static const struct of_device_id mt7620_pinmux_match[] = {
+static const struct of_device_id mt7620_pinctrl_match[] = {
 	{ .compatible = "ralink,rt2880-pinmux" },
 	{}
 };
-MODULE_DEVICE_TABLE(of, mt7620_pinmux_match);
+MODULE_DEVICE_TABLE(of, mt7620_pinctrl_match);
 
-static struct platform_driver mt7620_pinmux_driver = {
-	.probe = mt7620_pinmux_probe,
+static struct platform_driver mt7620_pinctrl_driver = {
+	.probe = mt7620_pinctrl_probe,
 	.driver = {
 		.name = "rt2880-pinmux",
-		.of_match_table = mt7620_pinmux_match,
+		.of_match_table = mt7620_pinctrl_match,
 	},
 };
 
-static int __init mt7620_pinmux_init(void)
+static int __init mt7620_pinctrl_init(void)
 {
-	return platform_driver_register(&mt7620_pinmux_driver);
+	return platform_driver_register(&mt7620_pinctrl_driver);
 }
-core_initcall_sync(mt7620_pinmux_init);
+core_initcall_sync(mt7620_pinctrl_init);
diff --git a/drivers/pinctrl/ralink/pinctrl-mt7621.c b/drivers/pinctrl/ralink/pinctrl-mt7621.c
index 14b89cb43d4c..bad4f1a8cf3f 100644
--- a/drivers/pinctrl/ralink/pinctrl-mt7621.c
+++ b/drivers/pinctrl/ralink/pinctrl-mt7621.c
@@ -90,27 +90,27 @@ static struct ralink_pmx_group mt7621_pinmux_data[] = {
 	{ 0 }
 };
 
-static int mt7621_pinmux_probe(struct platform_device *pdev)
+static int mt7621_pinctrl_probe(struct platform_device *pdev)
 {
-	return ralink_pinmux_init(pdev, mt7621_pinmux_data);
+	return ralink_pinctrl_init(pdev, mt7621_pinmux_data);
 }
 
-static const struct of_device_id mt7621_pinmux_match[] = {
+static const struct of_device_id mt7621_pinctrl_match[] = {
 	{ .compatible = "ralink,rt2880-pinmux" },
 	{}
 };
-MODULE_DEVICE_TABLE(of, mt7621_pinmux_match);
+MODULE_DEVICE_TABLE(of, mt7621_pinctrl_match);
 
-static struct platform_driver mt7621_pinmux_driver = {
-	.probe = mt7621_pinmux_probe,
+static struct platform_driver mt7621_pinctrl_driver = {
+	.probe = mt7621_pinctrl_probe,
 	.driver = {
 		.name = "rt2880-pinmux",
-		.of_match_table = mt7621_pinmux_match,
+		.of_match_table = mt7621_pinctrl_match,
 	},
 };
 
-static int __init mt7621_pinmux_init(void)
+static int __init mt7621_pinctrl_init(void)
 {
-	return platform_driver_register(&mt7621_pinmux_driver);
+	return platform_driver_register(&mt7621_pinctrl_driver);
 }
-core_initcall_sync(mt7621_pinmux_init);
+core_initcall_sync(mt7621_pinctrl_init);
diff --git a/drivers/pinctrl/ralink/pinctrl-ralink.c b/drivers/pinctrl/ralink/pinctrl-ralink.c
index 841f23f55c95..63429a287434 100644
--- a/drivers/pinctrl/ralink/pinctrl-ralink.c
+++ b/drivers/pinctrl/ralink/pinctrl-ralink.c
@@ -182,7 +182,7 @@ static const struct pinmux_ops ralink_pmx_group_ops = {
 
 static struct pinctrl_desc ralink_pctrl_desc = {
 	.owner		= THIS_MODULE,
-	.name		= "ralink-pinmux",
+	.name		= "ralink-pinctrl",
 	.pctlops	= &ralink_pctrl_ops,
 	.pmxops		= &ralink_pmx_group_ops,
 };
@@ -191,7 +191,7 @@ static struct ralink_pmx_func gpio_func = {
 	.name = "gpio",
 };
 
-static int ralink_pinmux_index(struct ralink_priv *p)
+static int ralink_pinctrl_index(struct ralink_priv *p)
 {
 	struct ralink_pmx_group *mux = p->groups;
 	int i, j, c = 0;
@@ -248,7 +248,7 @@ static int ralink_pinmux_index(struct ralink_priv *p)
 	return 0;
 }
 
-static int ralink_pinmux_pins(struct ralink_priv *p)
+static int ralink_pinctrl_pins(struct ralink_priv *p)
 {
 	int i, j;
 
@@ -311,8 +311,8 @@ static int ralink_pinmux_pins(struct ralink_priv *p)
 	return 0;
 }
 
-int ralink_pinmux_init(struct platform_device *pdev,
-		       struct ralink_pmx_group *data)
+int ralink_pinctrl_init(struct platform_device *pdev,
+			struct ralink_pmx_group *data)
 {
 	struct ralink_priv *p;
 	struct pinctrl_dev *dev;
@@ -332,13 +332,13 @@ int ralink_pinmux_init(struct platform_device *pdev,
 	platform_set_drvdata(pdev, p);
 
 	/* init the device */
-	err = ralink_pinmux_index(p);
+	err = ralink_pinctrl_index(p);
 	if (err) {
 		dev_err(&pdev->dev, "failed to load index\n");
 		return err;
 	}
 
-	err = ralink_pinmux_pins(p);
+	err = ralink_pinctrl_pins(p);
 	if (err) {
 		dev_err(&pdev->dev, "failed to load pins\n");
 		return err;
diff --git a/drivers/pinctrl/ralink/pinctrl-ralink.h b/drivers/pinctrl/ralink/pinctrl-ralink.h
index 134969409585..e6037be1e153 100644
--- a/drivers/pinctrl/ralink/pinctrl-ralink.h
+++ b/drivers/pinctrl/ralink/pinctrl-ralink.h
@@ -47,7 +47,7 @@ struct ralink_pmx_group {
 	int func_count;
 };
 
-int ralink_pinmux_init(struct platform_device *pdev,
-		       struct ralink_pmx_group *data);
+int ralink_pinctrl_init(struct platform_device *pdev,
+			struct ralink_pmx_group *data);
 
 #endif
diff --git a/drivers/pinctrl/ralink/pinctrl-rt288x.c b/drivers/pinctrl/ralink/pinctrl-rt288x.c
index 40c45140ff8a..db5c09ed5601 100644
--- a/drivers/pinctrl/ralink/pinctrl-rt288x.c
+++ b/drivers/pinctrl/ralink/pinctrl-rt288x.c
@@ -34,27 +34,27 @@ static struct ralink_pmx_group rt2880_pinmux_data_act[] = {
 	{ 0 }
 };
 
-static int rt288x_pinmux_probe(struct platform_device *pdev)
+static int rt288x_pinctrl_probe(struct platform_device *pdev)
 {
-	return ralink_pinmux_init(pdev, rt2880_pinmux_data_act);
+	return ralink_pinctrl_init(pdev, rt2880_pinmux_data_act);
 }
 
-static const struct of_device_id rt288x_pinmux_match[] = {
+static const struct of_device_id rt288x_pinctrl_match[] = {
 	{ .compatible = "ralink,rt2880-pinmux" },
 	{}
 };
-MODULE_DEVICE_TABLE(of, rt288x_pinmux_match);
+MODULE_DEVICE_TABLE(of, rt288x_pinctrl_match);
 
-static struct platform_driver rt288x_pinmux_driver = {
-	.probe = rt288x_pinmux_probe,
+static struct platform_driver rt288x_pinctrl_driver = {
+	.probe = rt288x_pinctrl_probe,
 	.driver = {
 		.name = "rt2880-pinmux",
-		.of_match_table = rt288x_pinmux_match,
+		.of_match_table = rt288x_pinctrl_match,
 	},
 };
 
-static int __init rt288x_pinmux_init(void)
+static int __init rt288x_pinctrl_init(void)
 {
-	return platform_driver_register(&rt288x_pinmux_driver);
+	return platform_driver_register(&rt288x_pinctrl_driver);
 }
-core_initcall_sync(rt288x_pinmux_init);
+core_initcall_sync(rt288x_pinctrl_init);
diff --git a/drivers/pinctrl/ralink/pinctrl-rt305x.c b/drivers/pinctrl/ralink/pinctrl-rt305x.c
index 25527ca1ccaa..b4765ca27cac 100644
--- a/drivers/pinctrl/ralink/pinctrl-rt305x.c
+++ b/drivers/pinctrl/ralink/pinctrl-rt305x.c
@@ -104,34 +104,34 @@ static struct ralink_pmx_group rt5350_pinmux_data[] = {
 	{ 0 }
 };
 
-static int rt305x_pinmux_probe(struct platform_device *pdev)
+static int rt305x_pinctrl_probe(struct platform_device *pdev)
 {
 	if (soc_is_rt5350())
-		return ralink_pinmux_init(pdev, rt5350_pinmux_data);
+		return ralink_pinctrl_init(pdev, rt5350_pinmux_data);
 	else if (soc_is_rt305x() || soc_is_rt3350())
-		return ralink_pinmux_init(pdev, rt3050_pinmux_data);
+		return ralink_pinctrl_init(pdev, rt3050_pinmux_data);
 	else if (soc_is_rt3352())
-		return ralink_pinmux_init(pdev, rt3352_pinmux_data);
+		return ralink_pinctrl_init(pdev, rt3352_pinmux_data);
 	else
 		return -EINVAL;
 }
 
-static const struct of_device_id rt305x_pinmux_match[] = {
+static const struct of_device_id rt305x_pinctrl_match[] = {
 	{ .compatible = "ralink,rt2880-pinmux" },
 	{}
 };
-MODULE_DEVICE_TABLE(of, rt305x_pinmux_match);
+MODULE_DEVICE_TABLE(of, rt305x_pinctrl_match);
 
-static struct platform_driver rt305x_pinmux_driver = {
-	.probe = rt305x_pinmux_probe,
+static struct platform_driver rt305x_pinctrl_driver = {
+	.probe = rt305x_pinctrl_probe,
 	.driver = {
 		.name = "rt2880-pinmux",
-		.of_match_table = rt305x_pinmux_match,
+		.of_match_table = rt305x_pinctrl_match,
 	},
 };
 
-static int __init rt305x_pinmux_init(void)
+static int __init rt305x_pinctrl_init(void)
 {
-	return platform_driver_register(&rt305x_pinmux_driver);
+	return platform_driver_register(&rt305x_pinctrl_driver);
 }
-core_initcall_sync(rt305x_pinmux_init);
+core_initcall_sync(rt305x_pinctrl_init);
diff --git a/drivers/pinctrl/ralink/pinctrl-rt3883.c b/drivers/pinctrl/ralink/pinctrl-rt3883.c
index 0b8674dbe188..b2e8151de226 100644
--- a/drivers/pinctrl/ralink/pinctrl-rt3883.c
+++ b/drivers/pinctrl/ralink/pinctrl-rt3883.c
@@ -81,27 +81,27 @@ static struct ralink_pmx_group rt3883_pinmux_data[] = {
 	{ 0 }
 };
 
-static int rt3883_pinmux_probe(struct platform_device *pdev)
+static int rt3883_pinctrl_probe(struct platform_device *pdev)
 {
-	return ralink_pinmux_init(pdev, rt3883_pinmux_data);
+	return ralink_pinctrl_init(pdev, rt3883_pinmux_data);
 }
 
-static const struct of_device_id rt3883_pinmux_match[] = {
+static const struct of_device_id rt3883_pinctrl_match[] = {
 	{ .compatible = "ralink,rt2880-pinmux" },
 	{}
 };
-MODULE_DEVICE_TABLE(of, rt3883_pinmux_match);
+MODULE_DEVICE_TABLE(of, rt3883_pinctrl_match);
 
-static struct platform_driver rt3883_pinmux_driver = {
-	.probe = rt3883_pinmux_probe,
+static struct platform_driver rt3883_pinctrl_driver = {
+	.probe = rt3883_pinctrl_probe,
 	.driver = {
 		.name = "rt2880-pinmux",
-		.of_match_table = rt3883_pinmux_match,
+		.of_match_table = rt3883_pinctrl_match,
 	},
 };
 
-static int __init rt3883_pinmux_init(void)
+static int __init rt3883_pinctrl_init(void)
 {
-	return platform_driver_register(&rt3883_pinmux_driver);
+	return platform_driver_register(&rt3883_pinctrl_driver);
 }
-core_initcall_sync(rt3883_pinmux_init);
+core_initcall_sync(rt3883_pinctrl_init);
-- 
2.25.1

