Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCD1501A2F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 19:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343654AbiDNRnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 13:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343641AbiDNRmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 13:42:47 -0400
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC96ECBE65;
        Thu, 14 Apr 2022 10:40:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1649958009; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=QiN4AHvK3KnwMN+9cGg1O8lMD4IKOfm1I0x32BBlTfSm0y0umWI95aSaQydzX6o9dWPtzeFd2ctYtnkiP3B3xppjSI75OJhKVxaKtP9j+uIVIq0bHZHJHBCpC/4yOEYLRzC1n3F2PpYGouQV1Fs5smRauHzfsoR+I8Qc9a6LHsw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1649958009; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=0k+Tj9WfzOG3POKIY+KWQEOeUrgIztHXTMPJcor8xWs=; 
        b=O4s71R3Rt+r+wQ9UU7Zzna4m3jMo1P+AoVTGkXOpRyZgOyQbYR1+2PQLcURFzyjHXbnpPUIAA5RfYd0qAea0FT1tLxoL9n9FuY9Kzd19xpZp0gK+FwSK4hSI9w7DSwyzUBNLapoM50k5uOjX70VCiahm/wXylgbcDExJo/bgHR0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1649958009;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Reply-To;
        bh=0k+Tj9WfzOG3POKIY+KWQEOeUrgIztHXTMPJcor8xWs=;
        b=AnRM8nWTwRlK9nCFNwVUNi/ecZuaMZIHArAs0aEQlpwy0/Hkx/s2hAIjAyjU3FWg
        h4orxiXBJCsScMhF1ZuYY9IdGKhrXo6+icAs+HHr572whf346kUVhcJOrTkcHlNavn3
        yeTrlqiPx1fZkGretDJqWVS5wGPyJtBIG8SnXbrc=
Received: from arinc9-PC.localdomain (85.117.236.245 [85.117.236.245]) by mx.zohomail.com
        with SMTPS id 1649958008198477.80974111231285; Thu, 14 Apr 2022 10:40:08 -0700 (PDT)
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
Subject: [PATCH v2 07/14] pinctrl: ralink: add new compatible strings for each pinctrl subdriver
Date:   Thu, 14 Apr 2022 20:39:09 +0300
Message-Id: <20220414173916.5552-8-arinc.unal@arinc9.com>
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

As seen on any other pinctrl subdriver that calls code from a main driver,
each subdriver needs to have a different compatible string. We don't want
the same compatible string to match a different subdriver's pinmux data as
it's not for our SoC.

Therefore, add new compatible strings for each pinctrl subdriver. Change
driver name on all subdrivers accordingly.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 drivers/pinctrl/ralink/pinctrl-mt7620.c | 4 ++--
 drivers/pinctrl/ralink/pinctrl-mt7621.c | 4 ++--
 drivers/pinctrl/ralink/pinctrl-rt2880.c | 4 ++--
 drivers/pinctrl/ralink/pinctrl-rt305x.c | 4 ++--
 drivers/pinctrl/ralink/pinctrl-rt3883.c | 4 ++--
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/pinctrl/ralink/pinctrl-mt7620.c b/drivers/pinctrl/ralink/pinctrl-mt7620.c
index fde269c68a7b..22ff16eff02f 100644
--- a/drivers/pinctrl/ralink/pinctrl-mt7620.c
+++ b/drivers/pinctrl/ralink/pinctrl-mt7620.c
@@ -371,7 +371,7 @@ static int mt7620_pinctrl_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id mt7620_pinctrl_match[] = {
-	{ .compatible = "ralink,rt2880-pinmux" },
+	{ .compatible = "ralink,mt7620-pinctrl" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, mt7620_pinctrl_match);
@@ -379,7 +379,7 @@ MODULE_DEVICE_TABLE(of, mt7620_pinctrl_match);
 static struct platform_driver mt7620_pinctrl_driver = {
 	.probe = mt7620_pinctrl_probe,
 	.driver = {
-		.name = "rt2880-pinmux",
+		.name = "mt7620-pinctrl",
 		.of_match_table = mt7620_pinctrl_match,
 	},
 };
diff --git a/drivers/pinctrl/ralink/pinctrl-mt7621.c b/drivers/pinctrl/ralink/pinctrl-mt7621.c
index 1470250ca3b7..b47968f40e0c 100644
--- a/drivers/pinctrl/ralink/pinctrl-mt7621.c
+++ b/drivers/pinctrl/ralink/pinctrl-mt7621.c
@@ -96,7 +96,7 @@ static int mt7621_pinctrl_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id mt7621_pinctrl_match[] = {
-	{ .compatible = "ralink,rt2880-pinmux" },
+	{ .compatible = "ralink,mt7621-pinctrl" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, mt7621_pinctrl_match);
@@ -104,7 +104,7 @@ MODULE_DEVICE_TABLE(of, mt7621_pinctrl_match);
 static struct platform_driver mt7621_pinctrl_driver = {
 	.probe = mt7621_pinctrl_probe,
 	.driver = {
-		.name = "rt2880-pinmux",
+		.name = "mt7621-pinctrl",
 		.of_match_table = mt7621_pinctrl_match,
 	},
 };
diff --git a/drivers/pinctrl/ralink/pinctrl-rt2880.c b/drivers/pinctrl/ralink/pinctrl-rt2880.c
index 9c5e828af43a..811e12df1133 100644
--- a/drivers/pinctrl/ralink/pinctrl-rt2880.c
+++ b/drivers/pinctrl/ralink/pinctrl-rt2880.c
@@ -40,7 +40,7 @@ static int rt2880_pinctrl_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id rt2880_pinctrl_match[] = {
-	{ .compatible = "ralink,rt2880-pinmux" },
+	{ .compatible = "ralink,rt2880-pinctrl" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, rt2880_pinctrl_match);
@@ -48,7 +48,7 @@ MODULE_DEVICE_TABLE(of, rt2880_pinctrl_match);
 static struct platform_driver rt2880_pinctrl_driver = {
 	.probe = rt2880_pinctrl_probe,
 	.driver = {
-		.name = "rt2880-pinmux",
+		.name = "rt2880-pinctrl",
 		.of_match_table = rt2880_pinctrl_match,
 	},
 };
diff --git a/drivers/pinctrl/ralink/pinctrl-rt305x.c b/drivers/pinctrl/ralink/pinctrl-rt305x.c
index b4765ca27cac..5b204b7ca1f3 100644
--- a/drivers/pinctrl/ralink/pinctrl-rt305x.c
+++ b/drivers/pinctrl/ralink/pinctrl-rt305x.c
@@ -117,7 +117,7 @@ static int rt305x_pinctrl_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id rt305x_pinctrl_match[] = {
-	{ .compatible = "ralink,rt2880-pinmux" },
+	{ .compatible = "ralink,rt305x-pinctrl" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, rt305x_pinctrl_match);
@@ -125,7 +125,7 @@ MODULE_DEVICE_TABLE(of, rt305x_pinctrl_match);
 static struct platform_driver rt305x_pinctrl_driver = {
 	.probe = rt305x_pinctrl_probe,
 	.driver = {
-		.name = "rt2880-pinmux",
+		.name = "rt305x-pinctrl",
 		.of_match_table = rt305x_pinctrl_match,
 	},
 };
diff --git a/drivers/pinctrl/ralink/pinctrl-rt3883.c b/drivers/pinctrl/ralink/pinctrl-rt3883.c
index b2e8151de226..44a66c3d2d2a 100644
--- a/drivers/pinctrl/ralink/pinctrl-rt3883.c
+++ b/drivers/pinctrl/ralink/pinctrl-rt3883.c
@@ -87,7 +87,7 @@ static int rt3883_pinctrl_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id rt3883_pinctrl_match[] = {
-	{ .compatible = "ralink,rt2880-pinmux" },
+	{ .compatible = "ralink,rt3883-pinctrl" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, rt3883_pinctrl_match);
@@ -95,7 +95,7 @@ MODULE_DEVICE_TABLE(of, rt3883_pinctrl_match);
 static struct platform_driver rt3883_pinctrl_driver = {
 	.probe = rt3883_pinctrl_probe,
 	.driver = {
-		.name = "rt2880-pinmux",
+		.name = "rt3883-pinctrl",
 		.of_match_table = rt3883_pinctrl_match,
 	},
 };
-- 
2.25.1

