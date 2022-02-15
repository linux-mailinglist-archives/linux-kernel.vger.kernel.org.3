Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC5E4B7370
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239256AbiBOQcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 11:32:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241592AbiBOQcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 11:32:23 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2132.outbound.protection.outlook.com [40.107.255.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59BC8AE64;
        Tue, 15 Feb 2022 08:32:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZdO/iexzD14ZSNbAg0BrdO5T4fo60C6JmHyMNxRm3x0uGtYjVbUHAqN5e4NSfrkzVBWlNXF8U2su4Zq8cOQwl3h19Vo0GaFMaLtib3fz2deOgvue9ewxk/N0va/l2HZy4yywA0tnPnXgOqX3Lt6VpPai8soRbWGobZnquQEXikiiub23GWr/oSCbIku0fV49/lZ5MQjNpaEJI9cNRCoGHz9lMaM/dTDzSLV1mB63fpEm0b2CCqklar+XcBI3wT9WLWG8i6X6U8IylPTKIBfjBwQ6k5t08pOS6myt26eIxJNWqIKqq59Q9UtSkNroFwN/cAQ0wZK2CW5TivN4XpJNpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MY9BMTBY8a80s7pTnJUAqJAf1OLmuwuClp7ELSUttTI=;
 b=iW/HkgQyVr+HgTtPf+0yrvtBzjrJRfyUJkKDYLJm7hNNMwGbEhDdk33aWT3o4yYVhON4C7aMnZKPvEQsE54vaBDSgaLP/Ut66wqlijAPfbKciS95mDAgHis1f9O+l3tfLwm1DEZaK9iLBa37H4pO6mYNNiC6xuPFJW7FdR8oiyrfqkW47QzEG1juAcHwxwFzY/tQzxFlGBVeBMyf17f2eRBy92T+qehNQn9xFOKb7WTF4LRkc/JrORzHRHXzhEXO9e3C24ojCFDOpnKBQ9o6OeRTuF4azUgfF/RmdcXDQuroBXPfNYW28mT5mIIoZCTfXWllnUwxdF254L6lg61VSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quantacorp.onmicrosoft.com; s=selector2-quantacorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MY9BMTBY8a80s7pTnJUAqJAf1OLmuwuClp7ELSUttTI=;
 b=ypSh4rpCcxCAsQWLSXNnVm/jWWL+RwnGnzgJF6fumkr3WS7OgPLj35XEW+vOkC33p1HcFTRQogfL75kZitKBEeAgOgnvhrUg3I6FvBwA0dcAfQOH3sufJyYzugJfNwqMDeOzPumEktp+lfyvYHjBdrAko6Ri05ufAwJ3umbJed0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quantatw.com;
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com (2603:1096:203:89::17)
 by SI2PR04MB4602.apcprd04.prod.outlook.com (2603:1096:4:130::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Tue, 15 Feb
 2022 16:32:07 +0000
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::ec21:c033:761d:3e03]) by HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::ec21:c033:761d:3e03%4]) with mapi id 15.20.4975.018; Tue, 15 Feb 2022
 16:32:07 +0000
From:   Potin Lai <potin.lai@quantatw.com>
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>
Cc:     Patrick Williams <patrick@stwcx.xyz>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Potin Lai <potin.lai@quantatw.com>
Subject: [PATCH v3 05/10] ARM: dts: aspeed: bletchley: switch to spi-gpio for spi2
Date:   Wed, 16 Feb 2022 00:31:46 +0800
Message-Id: <20220215163151.32252-6-potin.lai@quantatw.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220215163151.32252-1-potin.lai@quantatw.com>
References: <20220215163151.32252-1-potin.lai@quantatw.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0141.apcprd02.prod.outlook.com
 (2603:1096:202:16::25) To HK0PR04MB3282.apcprd04.prod.outlook.com
 (2603:1096:203:89::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e402f5d-b0ab-4757-35cb-08d9f0a0b522
X-MS-TrafficTypeDiagnostic: SI2PR04MB4602:EE_
X-Microsoft-Antispam-PRVS: <SI2PR04MB4602F7207A3FCBD2AEEDAFF18E349@SI2PR04MB4602.apcprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:418;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BFdFYMZGm1pd4YilJzs6JaBNRced8hsFA63wov0KJArxbBV8XpmlYldGyPHiR7NM+QCquN3pelJnbFPaJQVXuIWPcm3Ko4rWAYF8qSPn9U5uYZnIM7b/aQcY+cAUQQLXjbtoMBTkBp5V4RKEV6XoX9IBxLDdJZiCIEYVlrXMbIsBY3zNm0TBh1mR+/tmaxhf1xt2K9gQVz2VDFogLoBpDPJ0Ri/5MYRY6XUC3lr0eHdpGCPqZn1G5OJCUSbMgQ9ZdwYxAyG3LyVPwaQhhKUlV4aFqm9Bh9p+eW5DpvVstSO4TkiBJYcmaqtySty7qpqM0PBg0IvgjzFy4eZhoY35/pE164p+Toxw1HGgrRxFoDKDfYFfM07F44EMTSZpaFNij0jqbhzv2BV/80J4080DiEK1xzKd4l7PSpVUQbomRLgsAygfkX3BtzkIDa7gP8zAA0uWnfn7Hk0hGQxTd/ma0zB/ptjFxmUv315tFR7czxVLpZxFIrgyNIoGTZuFciPjIZI302JkLXH4XbR9Gvv2WkH1s80pat5Up9Kt7XtwnwM2D9J7ssY3UKYewevyCcV9ZXyA4sED8iAaPoM6qTksTNhlQq8ejQnvNBwkp3+hLUG5OKs5YOQdYxwaP3+JnZsE9rZMY/vUI4YmOheUh8+ZKYEDd3pHnIGlz8vSH+tjB0bfz9qXWefbHxoHCUN+1PrdK8prDp8eVMwhBU0oSvjU1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR04MB3282.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(1076003)(26005)(186003)(2616005)(36756003)(107886003)(6666004)(6506007)(52116002)(6512007)(83380400001)(508600001)(5660300002)(54906003)(110136005)(8936002)(38100700002)(8676002)(44832011)(6486002)(86362001)(66946007)(4326008)(66476007)(66556008)(316002)(2906002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vyPxPdoPsq02Znwj0NiHL+fv2wQnWmimpXaNZ+wDdmweOPMbc432jD6LVnkh?=
 =?us-ascii?Q?+5c7/WRg4vCfGSJvyTbovAw0MIVNQJeIA2RtSS+vOu0EeUdtnnR70mpzWoR4?=
 =?us-ascii?Q?mQecyZxpYkqPIlZsaaxF7Qskc3W7d89uHw6oXmOzhiWOMB9w4EmHEUMwdgEL?=
 =?us-ascii?Q?74BdseStksX8m6LwWqQsvI9yykD4sY1AR70npH3fjfLlOZRhaIP3bI075UN0?=
 =?us-ascii?Q?7oKdS47WkJpw8LAM2IZYfJYaO3o2kJdw8l7dIYWrpgzAjXLB3XyyhqX041QE?=
 =?us-ascii?Q?T0Knjfe+rdWHp9wru3mRRXFr48RgPsfNePQViMvpXxsnXm+moGieuu2ooRF5?=
 =?us-ascii?Q?fn4N4MF3l/BvTX8iPJuZFV+Hs0QFFBLc3xnaDGbrzA+k7ZBgkKON1ygJDr6C?=
 =?us-ascii?Q?WsjeeOZ2f4c/1m2hWRriDuVJM4+/5/Epfj6e7dj+Y12ZOrXkaAgM8ZCh28Gx?=
 =?us-ascii?Q?GviIjXRHnEchH4jF5qVo/JhDt9owQCHQG6DDRnv7ejfdIno6ZV2fDzZSWPov?=
 =?us-ascii?Q?5IwFiwpIprGTxM85xcen4hbuhjyiMoTFoWecr3zfVeWMZXZOFbD6nXZ8J824?=
 =?us-ascii?Q?nfoECFNsQddX466n8gM59uqyddTSZWp1PwSpAiR1N2lMmxQjkD7gWR+kKOIZ?=
 =?us-ascii?Q?0IZJ13ynUMC/STJX+onM4IuRil75GNyxXntQiQGrDXqKlX4oefyUqbuJUHNy?=
 =?us-ascii?Q?962McDdyyVLeYKewcMNZulVRcvPD0u0ik1J1zZZb3xwdFjV4jGWv0iviwU9x?=
 =?us-ascii?Q?QIPVHy8sVmAj5Kgpn/7Fly7cSMnRzzd15zUFphFIb5kTQfS129PXjPN0zGhC?=
 =?us-ascii?Q?pEGvgf3oYLyNmqgWWMqrLw1FysppNTHpKnHUZen/ann/Zg7aGUzzyQR/OfHa?=
 =?us-ascii?Q?EXT4s91YfPeaTqvZBeTuRuzHQ872r3+1TUTyzUgWwT0MxRMAco5xkwOOdjvu?=
 =?us-ascii?Q?Pg2vx73DN1SUV11CSNbfOhuzOMqtIrh+DxycEGoR5m5DMBuGPq03ZYik1bb0?=
 =?us-ascii?Q?9ENfOiHmngb4f1B+/Iaqbc9ZgGaH5qwDcGVMHpBKNZJIpbtHbCTqfyrmcXPp?=
 =?us-ascii?Q?UuiFxmC4xA+CLSapwbBY46YPsLolzf4gJ1kdIlPp2qGbcgOMvoirWc+cb60A?=
 =?us-ascii?Q?7Nnv59fHByR0X2e2/tTWPNI3ICwFzlLr6eCne6y0tp4yd4h5bEvBVMK8YDLj?=
 =?us-ascii?Q?nI1II0Qxl5lLzCal/Cz7ZS0/UqUwAtVli66STT690/1Mu1XGinkAHgaICp9a?=
 =?us-ascii?Q?Ttd4ZKI6STZalAKOvHUvfAuR4awXwlVuXI8T6dE3mNiDlUh+fkXwYl1PQlnJ?=
 =?us-ascii?Q?5CtPwhQmSlOkFWGushgOyn/2go2J1qr9UyHJVgvxkC+Et5DGrA2BYF02gA2R?=
 =?us-ascii?Q?Kjv3NfjmDYh20IleUdohw/2p1IWt3VwfTBxY1SPUs4hYuEO5ygXmsG9ncpAu?=
 =?us-ascii?Q?TQf/ZxKyvNPuDGcGXt92u9cSwmB5W1XZO2iYOjSnM+e2vnBBpyZHycQHajpD?=
 =?us-ascii?Q?xJhNNBlASvL7VkVCo08HSzNwjLWF52gTrpvIhO5Gl7XOo1BXujs7TIpjHzMu?=
 =?us-ascii?Q?zFRzJ2K99Ia5cJuBCvb4/T05Y7TlIfKAoNTlvdG3kTAy5+1H5maq0Nuo9lAW?=
 =?us-ascii?Q?lurnyenWn15mSNWcg72iyYg=3D?=
X-OriginatorOrg: quantatw.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e402f5d-b0ab-4757-35cb-08d9f0a0b522
X-MS-Exchange-CrossTenant-AuthSource: HK0PR04MB3282.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 16:32:07.5081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 179b0327-07fc-4973-ac73-8de7313561b2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bF7DDphtLiWNXp9+xwc1m5QfA0RPbMSN2YlqvHetwek+YzPo7vV+7zubHxegCbpCkPjTsNG5qkzbPH6u5jBpzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR04MB4602
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch spi2 to spi-gpio driver to avoid unstable signal issue with EVT HW
Remove spi2 node and create a new spi2_gpio node

Signed-off-by: Potin Lai <potin.lai@quantatw.com>
---
 .../dts/aspeed-bmc-facebook-bletchley.dts     | 35 +++++++++++--------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
index b01f1e7adb81..08fa4c7b5ed4 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
@@ -32,7 +32,7 @@
 			<&adc1 4>, <&adc1 5>, <&adc1 6>, <&adc1 7>;
 	};
 
-	spi_gpio: spi-gpio {
+	spi1_gpio: spi1-gpio {
 		compatible = "spi-gpio";
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -50,6 +50,26 @@
 		};
 	};
 
+	spi2_gpio: spi2-gpio {
+		compatible = "spi-gpio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		gpio-sck = <&gpio0 ASPEED_GPIO(X, 3) GPIO_ACTIVE_HIGH>;
+		gpio-mosi = <&gpio0 ASPEED_GPIO(X, 4) GPIO_ACTIVE_HIGH>;
+		gpio-miso = <&gpio0 ASPEED_GPIO(X, 5) GPIO_ACTIVE_HIGH>;
+		num-chipselects = <1>;
+		cs-gpios = <&gpio0 ASPEED_GPIO(X, 0) GPIO_ACTIVE_LOW>;
+
+		flash@0 {
+			reg = <0>;
+			compatible = "jedec,spi-nor";
+			m25p,fast-read;
+			label = "pnor";
+			spi-max-frequency = <100000000>;
+		};
+	};
+
 	switchphy: ethernet-phy@0 {
 		// Fixed link
 	};
@@ -225,19 +245,6 @@
 	};
 };
 
-&spi2 {
-	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_spi2_default>;
-
-	flash@0 {
-		status = "okay";
-		m25p,fast-read;
-		label = "pnor";
-		spi-max-frequency = <100000000>;
-	};
-};
-
 &i2c0 {
 	status = "okay";
 	/* TODO: Add ADC INA230 */
-- 
2.17.1

