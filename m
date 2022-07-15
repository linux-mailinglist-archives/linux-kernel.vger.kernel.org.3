Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCE62575DBF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 10:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbiGOIpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 04:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbiGOIpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 04:45:09 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2105.outbound.protection.outlook.com [40.92.52.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460CC814A8;
        Fri, 15 Jul 2022 01:45:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e5Y8Q7vKgo2AfP3FWJ0OZjQN8Xg/d2v2z0inONYLRGep1gLvEfh6V6Q0yGJw6uncQY09JJgmRGq170ajQjPb03MnZZPgW5okdJuczzKblgLA4KXn+X2Uc0aGa9wLud8JAdc4PlddNhvFLWV2jqsDeLXvlwKJUyOjP2PUwaBM0NQubnpwIEJXTkzG+4JwMIyqj7p5WM4echdLArbZ01Q1ISd2xtJiEz3NyytPJtfdaxJR9xr846IvSbZXp1lk50fSxAC47zhs0BvNlnWvxfbMrtW6VJld84UljeWQgldl/DgGSBG286xPQQ7Otq2+NTPq52pJDaxRO9AXEaAd+WUGpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HIRKzaqHjUv0ulWOF4pBuPr9bJ051lzRXkZwZ7OlMvc=;
 b=IIe3WvV9HdMWdYTnGKlI2zGAcAJJTcHsTfkxQnOFIA+zpvTCHEjJxlcztUqhBc3v6l2rC570IxSxPuH4mnCOeYJESyv57LQLvhmvPL9VbRHD66ttMHrapM8ISq+8g2f1JPCkNPO8wJwsWCXC1AfAnY1Nc6KbG2p6jkPTy6X9B5u3cNMCpB7YCJUXO0xebkxOitGMN+VWj20CelcMSenV3Y2w/YZLh2IQ8U2Vu+hNC/9jhRtocQySmoL5o5YcR/ckP/ktfz3KeP/UeQ3MfnwIDmrpuer3wHsx6Pk8gd+vBWj0RppuyP33rgWHGerNqj30ZtbKjRoOrBWuuSwtgoTNBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HIRKzaqHjUv0ulWOF4pBuPr9bJ051lzRXkZwZ7OlMvc=;
 b=gGrET66STQKNqW5Rdu6Wb3KU+ev+bqR/jqn8Bj167bdCYzJTaGys8MmzWvTf0pnmI/Ishugpq/QSViKfzSFKQLVva5kxkqb4rFaAdYBcOBG0Pc0Y0RclvM8hKt1V4E9q2op2vUyhcsDNO1DdrZa+L9ADxwzT4jOkqYMVKNHtSx57g1AvGZqQos0Sul5UGmwo5Fwm06uGDg3QrHEG8ihU0HTVa/LjWcYFLEg7w4Q+YIkMEeNc82S8W+v1+l1UtyIFudHvcHO3lwqtMg2RZU606mhYWfgXHOCKylK/vj5sqVQxipOQrmBNQ5qYRiJwaqWQkrgMKQ800ldUeb7CgTrgBw==
Received: from SG2PR03MB5006.apcprd03.prod.outlook.com (2603:1096:4:df::10) by
 TY2PR03MB3421.apcprd03.prod.outlook.com (2603:1096:404:31::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.10; Fri, 15 Jul 2022 08:45:04 +0000
Received: from SG2PR03MB5006.apcprd03.prod.outlook.com
 ([fe80::b96f:3a3b:5eef:e796]) by SG2PR03MB5006.apcprd03.prod.outlook.com
 ([fe80::b96f:3a3b:5eef:e796%5]) with mapi id 15.20.5458.007; Fri, 15 Jul 2022
 08:45:04 +0000
From:   Jimmy Chen <jinghung.chen3@hotmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, Andy Gross <agross@kernel.org>
Cc:     Alan Huang <alan-huang@quanta.corp-partner.google.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v5 2/3] arm64: dts: qcom: sc7280: Add herobrine-villager-r1
Date:   Fri, 15 Jul 2022 16:44:41 +0800
Message-ID: <SG2PR03MB5006D3E109835FCAD1B01A47CC8B9@SG2PR03MB5006.apcprd03.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220715084442.115021-1-jinghung.chen3@hotmail.com>
References: <20220715084442.115021-1-jinghung.chen3@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [gTKieQ6YplqpgvWBibN0EG0m/7/dZUuk]
X-ClientProxiedBy: TYCP286CA0139.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::7) To SG2PR03MB5006.apcprd03.prod.outlook.com
 (2603:1096:4:df::10)
X-Microsoft-Original-Message-ID: <20220715164428.v5.2.If645d262f4893c8839e80134c1d477c00c4631c1@changeid>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6548d85e-ddf1-4378-4e7f-08da663e4fed
X-MS-TrafficTypeDiagnostic: TY2PR03MB3421:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GxzRNidMKY0d6WhCOkFHtUxIlLiSfkj9w3hhBfDjBs2+kZW82ARv8ZkJUjYJavno4U2+PL+J8ksZryOsw8oOhRkjhwlQAMEGAlrzjHndK6R4jKLmreHLnXAdiOSQybhOwTJVmutO9u6Ewt+rGBsZSou+yM872l8Me+UeqFqwHcL7p6oQrAFp8rzvH9pAyaCGl4Ry7oj7KwdnfU1lReaIgoSoYogNgCyvwh+likjifOU19woEHhi4sfBmTGzKDaVIaL98MAD4TwJi2K+Bxwj6+FgEu9ENwidoGxIN62OQqAz2deeDHcM6oSPxNZhkbML/NG1zwDB3J5hER13594A2Er/tRitrRD+wr+k6JuV7bEBI/ysa6J7mNu/qWRSIrB6TK/XGfERHV795q+JKKAeYUtG2ZhH7DLWerqYxnWFtDtcP5OoINyp3K3ZbzG41pqcavpFGCguH/gHjcTPQMTQ4yB5Jsf1snx2+UnUCKLc55MIZMHhxSuR4OiivnRXiwU6HuWD8oGfu8adc1atyWni/O884PL1pkE+uhj9tr591vmfp5jSiBUHDNR9iznjloZe91Z2CPtDhhyHsaegrDvkz+KDQlZtq6rQ12xk1swTgIOEd28ehGUfFwDhx1ZLzstwJLPbLbDlSUZ4+2HVSLWe0hzsvj+edzrZdO7ZVWPSWDrmT2ysE/OAONBwrulAFgfZVt+F27/ynwV64sKHcGv26Sw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FpW/niVj+Z1wlmIzPTJ5sflzjOhnKnfhKd5BPNvkffUB722/MVRceWD48wQj?=
 =?us-ascii?Q?o8wHVB/upW55dqJzj3T0GPWhKcXPhk8tfZu5+ZIi6Eror1nOfgBrx9jBn5le?=
 =?us-ascii?Q?IAtu/Mx3fDiLfDL0Agna+LAvbqmo5rOPnodmuMa6P3kDpJ6zWnjbmC1bCP4l?=
 =?us-ascii?Q?dW03X6B+R8Vd3uoM54Halg4O2CuGSk66j3IPLCYY5kWzYm3RCgxwrTmnxl4f?=
 =?us-ascii?Q?sS5nxM9T7Folotf6yCcLZkKXCfkyvfqMYHBLh8e66WLaNjL4Rm2135bUourk?=
 =?us-ascii?Q?HhwSAmIDT8QGZfqD6hFuUqkH52F9CA3yThzGAqgxnlhXKTriOkG7es8f3z1k?=
 =?us-ascii?Q?e9C0p1u6RqHTwGZf5dKj+xQP+TUzkZx08fSdDA06ArNo3K+/r3gJY3Maa6KP?=
 =?us-ascii?Q?VeGZrLcJYwzAtJiHU6VPpXMu+LVo7Et7kuvoPZDUfTg0QXDWZb+1QStgKV4O?=
 =?us-ascii?Q?b65WDMwJM3ski1IXDzAoD1rYmxYcY/bvqL+EfZUAPLDMgX7X9B9FXtndtOJC?=
 =?us-ascii?Q?ERSOlo4hpLIdLt4/56p+dxkz52PrG9v7AzxSSMy9KzhjGD9vefpgJMRB87A5?=
 =?us-ascii?Q?Y+dFmgX0IqVEy3iZjOZbQ9s0WxPDP9n0jjetK5QniLKp+rw8wYPNPbviLZrH?=
 =?us-ascii?Q?UODdJ/d07jnTLBt1Q/SXjPa4UY/FDqW1rQRccbKIA/aSXrQ7CCLr73ZBxSVk?=
 =?us-ascii?Q?++WkeFv3TNnMFNkaV4oz7vtosNSC0FKxLdNhH2W9rJjxzgq4SPXiZT6wOdfY?=
 =?us-ascii?Q?zGifHgc3DPg2/xXwo4RIcE6yBY+PapNA9fTO4vquH2kO81sFNO3ORvI4D4tX?=
 =?us-ascii?Q?qRHayNIDJcKs23p0eukQi8ANiQJ5Ea3wdXGmQhwevt62WnSPr2mGkGoJWDHk?=
 =?us-ascii?Q?PPwM+XchcsRzLbmLDZEUKBdrqgSBb3uDqBGB1YXHiQV9a+MB2JbcL/vk3eS5?=
 =?us-ascii?Q?H3qfKoaLy2ZOW1+hMDI7S5QFxQxhqM6Y7q8/n3TvyeN+C9j4jYLwBVD+ggxt?=
 =?us-ascii?Q?m0+CFw6gycZWIwwT2yMLBN2t2xWp2bPfSqb+cMh6/tpIphtQue8XNarsN+rp?=
 =?us-ascii?Q?146dM17SkSZ/BeFY3iqUzYwLc86fVEovUoxaT5BV8tgAbfNUAzzMPbdGAh4p?=
 =?us-ascii?Q?eAkgMkN7joDfHFyQhW33VEt2EWR8v8TCjbBq0IOXqdNHr0NMF6LRN0RXlDRZ?=
 =?us-ascii?Q?aMkfBiuAPogGdZiD6N22uRgWNbDMUvY+Z2EB19716hZXXqN4IUDVQCAFeCVJ?=
 =?us-ascii?Q?e96e4yiZV7IhHpVvgoUVYMnBn1WssErJyqQ40xIwdb09Lzu0PkHSQLzSG7oC?=
 =?us-ascii?Q?jfI=3D?=
X-OriginatorOrg: sct-15-20-4734-24-msonline-outlook-c0b75.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 6548d85e-ddf1-4378-4e7f-08da663e4fed
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB5006.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 08:45:04.3335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR03MB3421
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds sc7280-herobrine-villager-r1.dts for villager device tree files.
Herobrine-r1 is exactly the same as -r0 except that it uses a
different audio solution (it uses the same one as the CRD).

Signed-off-by: Jimmy Chen <jinghung.chen3@hotmail.com>
---

Changes in v5:
-Revise rev0+ to rev0
-Add -r1 line to the Makefile

Changes in v4:
-Add this patch

 arch/arm64/boot/dts/qcom/Makefile                  |  1 +
 .../boot/dts/qcom/sc7280-herobrine-villager-r0.dts |  4 ++--
 .../boot/dts/qcom/sc7280-herobrine-villager-r1.dts | 14 ++++++++++++++
 3 files changed, 17 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 9e2a13d75f9de..7e6a4d7ef3266 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -103,6 +103,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-r1-lte.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-crd.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-herobrine-r1.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-villager-r0.dtb
+dtb-$(CONFIG_ARCG_QCOM)	+= sc7280-herobrine-villager-r1.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-idp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-idp2.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-crd-r3.dtb
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0.dts
index 2cacafd8faa8d..cbd8a2d1ef2a7 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0.dts
@@ -10,8 +10,8 @@
 #include "sc7280-herobrine.dtsi"
 
 / {
-	model = "Google Villager (rev0+)";
-	compatible = "google,villager", "qcom,sc7280";
+	model = "Google Villager (rev0)";
+	compatible = "google,villager-rev0", "qcom,sc7280";
 };
 
 /*
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1.dts
new file mode 100644
index 0000000000000..c03b3ae4de506
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Villager board device tree source
+ *
+ * Copyright 2022 Google LLC.
+ */
+
+#include "sc7280-herobrine-villager-r0.dts"
+#include "sc7280-herobrine-audio-wcd9385.dtsi"
+
+/ {
+	model = "Google Villager (rev1+)";
+	compatible = "google,villager", "qcom,sc7280";
+};
-- 
2.25.1

