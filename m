Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 264054AEFAC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 12:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbiBILKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 06:10:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiBILKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 06:10:43 -0500
Received: from APC01-HK2-obe.outbound.protection.outlook.com (mail-eopbgr1300117.outbound.protection.outlook.com [40.107.130.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315DDE082729;
        Wed,  9 Feb 2022 02:06:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JRbczY/mvlrKYg9ta8OTMkPm20bCNOFBAKlqEtJIs8Fy/sLFbULkV1zUjc+8iMb3DaK/dfU84ucPt7h3eegnGJPFOolwdidPdtj0rmSgZN7JGfJvuo6izpDR9/xFu/V45f7u9hi8VKrVSV8R093zuYLw2eIdOZkvfm5XfbazZwP85d61BccN8w/wMyQDYQhtPj1zYeWwq4xkRVOXopjCqPLrAjGnA9AdlQUHT7ve3CBEcLBcrEpJGRjL9oSn03S3zCvxyglCUhdw6FentGBatt4LHh+svNrx95DNQ6ydJINvBGsfuyBDbW+ZbTU9l0yk/w0nXeB23cHvDiBRE/PMnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V2k30+GyrG3ttOYM3rnEPeCgZ6we0To8b8YKWkm/4t8=;
 b=NYSCt+wkIL+rjjIfUZci0mHS6NaN4FIQ5ZU+YHPottHCI2UpQoN6RFOs76TJB5jjJ1QPF8Jt7Io0iE+UCVbcgM0CTnmi6kuGAyEyZUQoozYCSSrs8egj8JqClEE3UmB6bXNQg/PcLKoc9SqXQpJS/+xcyCtEghOxCwQVwWzI88UPZRpR+1srUTyXeON0iKg4ktZpfGR4ydiW8NqbFTCAc3omZh+2CX4aDZgwJNhfIV0ND8rWZ/mAQ7kzdfGapppiy3vWdtaYw4hjrWhloB07x7mYaN8Ooa9LyRny7WQ6Af9sEBuZuUGOJbCCdEuu7D2pb5dy11jC14QdMjC3PDeotw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quantacorp.onmicrosoft.com; s=selector2-quantacorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2k30+GyrG3ttOYM3rnEPeCgZ6we0To8b8YKWkm/4t8=;
 b=GyO7KAPw9WLYXQQNK7EJ4eXp5sLH/Jg0X7BQAm7DINDzzRkSeu+D1AM0FdsyQdOmT4yTrBwM3Um2vzqzI+u16xDAFwoLa4sS1EYgwtZMvHX1d6hHhpfOodDUMzKVsYZbthrIQZ8LLXxzabUR1cN/yXT8IW1nTqLL9J1th+RYfbs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quantatw.com;
Received: from SG2PR04MB3285.apcprd04.prod.outlook.com (2603:1096:4:6d::18) by
 SG2PR04MB4012.apcprd04.prod.outlook.com (2603:1096:0:d::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.14; Wed, 9 Feb 2022 10:04:29 +0000
Received: from SG2PR04MB3285.apcprd04.prod.outlook.com
 ([fe80::8d13:6b06:f7ea:c084]) by SG2PR04MB3285.apcprd04.prod.outlook.com
 ([fe80::8d13:6b06:f7ea:c084%6]) with mapi id 15.20.4951.018; Wed, 9 Feb 2022
 10:04:29 +0000
From:   Potin Lai <potin.lai@quantatw.com>
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>
Cc:     Patrick Williams <patrick@stwcx.xyz>,
        Allen Wang <Allen_Wang@quantatw.com>,
        Potin Lai <potin.lai@quantatw.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/1] arch: arm: dts: update bletchley dts
Date:   Wed,  9 Feb 2022 18:04:12 +0800
Message-Id: <20220209100413.23714-1-potin.lai@quantatw.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0136.apcprd02.prod.outlook.com
 (2603:1096:202:16::20) To SG2PR04MB3285.apcprd04.prod.outlook.com
 (2603:1096:4:6d::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6e423f8-02b4-4151-b4e7-08d9ebb38fac
X-MS-TrafficTypeDiagnostic: SG2PR04MB4012:EE_
X-Microsoft-Antispam-PRVS: <SG2PR04MB4012E14267462C715B5612E38E2E9@SG2PR04MB4012.apcprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:785;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sjSWX2KFXJXVmEZrxVSXg+ujkUwYXlkdN/6FaD15haVNsLecQ7lhGAgp8Aipeu+xRVkLYOsC9QgRMtPn+rhXpDjUvo2hOvtU1ych64Zdy+i8GZrxVr5f6EZKcaxtgG18eXRbWiP6GutKmLrYNuavdIvERwQMsr52aK1ByDG3yq3dUMTlxTjo0g3CMYRvueZlvxR58rUzpbooyRtCkdvJHKpGH/a6DaTcBu/qh9q3dgd0c3537RT2cAofD3CuwSMPl8x/1HeepDYbg7M2qaglIeubGzz/WUNgADJasWz+lesqmPiopZFv8OQrfxbMKE+fW4yJ8U+hLZu4yivukzrT7UGE0STQo3f6lZ+D4Pri4QvDwYqkpYdCairkPAvfOYv7p0akFjneycAqbF5dNfLp/ZFZDnCfg8gh/MemujDyzshhK2EdS/cvfjrX6TCxBmnQet2pMfNl6KN6XFJkAOWFL9bDQSal03dxn6zCZ8Irle8liZk02X5OrwF/IZhbhXQop/Xfec3I1vRvjoEBjg53UoWiqQFsmu2VA1huaPVWC0VtaImlQnfToTB/0aOpMnI8syKfJhxC2tIpQNZsRxO/YNV6LvlBy5ddF8QVJGRUxKsQxMw37MLJ5541Y8KM/IuhWPddICT33dLSIoD9dz44lB/GcoqBemSSpX8gdpw2+lavP+PlBzQmv5FDB9kKfDNI/pA/4lQjZKzd+MEWkXtnSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR04MB3285.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(2906002)(38100700002)(38350700002)(36756003)(6486002)(26005)(2616005)(316002)(86362001)(66946007)(186003)(110136005)(66556008)(66476007)(1076003)(4326008)(8936002)(8676002)(44832011)(5660300002)(30864003)(15650500001)(508600001)(52116002)(6512007)(6666004)(6506007)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MmzDW2kWy1c6M9Gdm59Yvb2Wsfz5NwJAFb6ZijFmDHxw6ReVN3mjRUlNXQ3Y?=
 =?us-ascii?Q?2QeSUL/dRPThzMwpXAvxAOhr7rR7tr3gmaxqyXS0VCZYoTmV68YIcJSMrqKu?=
 =?us-ascii?Q?J/jm7mooXXeEwu6otyWeBimFe68zT31SB4iZ594lUYpQnT7hImDlkRwCevwj?=
 =?us-ascii?Q?5kP12qIT4tT7Pu+2/AuvlykdmMMcuxzi5j91a5pign8RIWyU/XAWAvuedCv8?=
 =?us-ascii?Q?ySQyvlP+MeaalRWki5Rrcb0OzB+FHYWhXyVcViFbTEPr2YHuGZhQ8x/NoAcR?=
 =?us-ascii?Q?ojzIScQNACaeSbZ5XL2uXi0fQO0G1Uwh3AFY1LAkbDnCs5TDSJ+bw9jLRg+H?=
 =?us-ascii?Q?CtJKFPLE6xOrUqTHr+i+F5l2ODL+oD1nYFTkNk3A76ek1Ye/alKq1XUxaMIm?=
 =?us-ascii?Q?9bXdDt8C8Ywz4DHdViTquyHycgAU2bZNiVcVkgjFPNJS6jK4rVrLInqN7jJ/?=
 =?us-ascii?Q?c0IhtZAsUv8NElcV/IduEd8SCrNoGc9cGQZyLmVKZsV//oLHsA0PZQnJ9u50?=
 =?us-ascii?Q?NxwAp76i4f/oA7wVsG/PVK2Y/5o9i9OTDdqDMOg6yveFD09g/ddCFPOhjKAb?=
 =?us-ascii?Q?+vo5GlMW15eRGXHpXA/ZrNPps5WBL8H2hp4hPCWGensS1YjFvgrA2BwEhtjd?=
 =?us-ascii?Q?3LqFWHlFpyNQz115RlN9aSbJtdOqtaDyrv1pWAaBLWBSckgXYpqUoXyIZ5nT?=
 =?us-ascii?Q?f0wcw7uEnr63Tyfwb+V9KkHiIWEdY9/OeKyrRQMlgJe9lukuD2zK7NUHStZ+?=
 =?us-ascii?Q?1Y1bljJQylKZ0IR6hci2FVvTDneCMrJN3MdcZ/vJSDWQ35elKzDW2MhiCXin?=
 =?us-ascii?Q?5RO+ibSDY5Kkdz04NmwUefCh/syzVywkV24Mu1OrQdDk0RAxuTBE0AVN9tVl?=
 =?us-ascii?Q?Fgpngr0rIKVCAyHFB+RIjWBt+FI+yGUDBNUthrBu4nK70Snm7ezg+8tZWQ2G?=
 =?us-ascii?Q?JlGMAW48AuaxIff04lRtGi17vtvZYc/lLWyzZP1p1zX09mF/5xr04b9FrCoj?=
 =?us-ascii?Q?shgXmtfe1KkQFAm0yI9KQOWmeeS6fQIipI1BkVdDTsCM4j58Q+xnt+Pec3sa?=
 =?us-ascii?Q?2+Ykbe74P1U1ud51odvykyVXujODgqFmrZEqTFxctGp/px91zYT8sy3i6RAL?=
 =?us-ascii?Q?sMBzFPlsxr6aC5gtDKb4R4BuvuYTPQH6KCld1M0Dv88Vk/xnE7OFrj3J90ha?=
 =?us-ascii?Q?CM0a5p3ML1hR13j8Gdl8zFd6KBy4+skOVdb2ve7TNi+JwuB/PCiJ/sv+u1AG?=
 =?us-ascii?Q?QLlqVmmH3fdENz9znK7JwVCG0TPY9d5PMUB255VMQrFOOH+jwGoQtqU6diV5?=
 =?us-ascii?Q?1g/V7YtITTTGPnBb6nLiei10PrvG40zFMX56u4rvOHz99cVbc3sMLrx31vXO?=
 =?us-ascii?Q?Xss1x3TsmC7dGdcU5bzcwK0nLQnz0JudD3w+kPpT/PdnXDsLNa2fqkbrvIRc?=
 =?us-ascii?Q?dMKZ0fXd1lzfnOR7n+zROUB+YaCIsMPlwOTEsVgZ6+gRIpmu0Q94hFRMkiIv?=
 =?us-ascii?Q?Sm8fofTA1hiyzhjFeSrEC6yzj5gGkJt/4JFhtQoVRZDiIYufZQaLW5i10D1Y?=
 =?us-ascii?Q?oGlw0c5w8wjvzp+Br/p5WuR0FXCF/9Rs0/CqvVUU0r536V7MOgX48AkDMsq1?=
 =?us-ascii?Q?GqDL6/x8q5+Sld0fRGEodPU=3D?=
X-OriginatorOrg: quantatw.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6e423f8-02b4-4151-b4e7-08d9ebb38fac
X-MS-Exchange-CrossTenant-AuthSource: SG2PR04MB3285.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 10:04:29.5831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 179b0327-07fc-4973-ac73-8de7313561b2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1mBNbvNeJKW8y4/9Arhyzqrpf6+O4ukQoSzPMgXuGFPtbi1hj7ighRp+kRmTJU5lo0BMcBk6mu3fksgXU1W8uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR04MB4012
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,WEIRD_QUOTING autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

updates:
* seperate leds into multiple groups
* switch sled numbering to 1-based
* disable inchip rtc
* add flash1 in fmc
* switch spi2 pnor using spi-gpio
* update gpio-line-names
* add interrupt pin for each sledx_ioexp
* enable mdio3
* update ADM1278 shunt resistor (300 micro Ohm)
* add INA230 for each sled

Signed-off-by: Potin Lai <potin.lai@quantatw.com>

---
Changes v2 -> v3:
- enable mdio3
- update ADM1278 shunt resistor (300 micro Ohm)
- change sys_log_id default state to off
- add INA230 for each sled

Changes v1 -> v2:
- add interrupt pin for each sledx_ioexp
- remove duplicated i2c1 node
- remove all PCA955X_TYPE_GPIO (default is GPIO)
---
 .../dts/aspeed-bmc-facebook-bletchley.dts     | 362 ++++++++++++------
 1 file changed, 235 insertions(+), 127 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
index f973ea883b97..d0017bca86ad 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
@@ -5,6 +5,8 @@
 #include "aspeed-g6.dtsi"
 #include <dt-bindings/gpio/aspeed-gpio.h>
 #include <dt-bindings/usb/pd.h>
+#include <dt-bindings/leds/leds-pca955x.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	model = "Facebook Bletchley BMC";
@@ -53,113 +55,139 @@
 		// Fixed link
 	};
 
-	leds {
+	front_leds {
 		compatible = "gpio-leds";
-
 		sys_log_id {
-			retain-state-shutdown;
-			default-state = "keep";
-			gpios = <&front_leds 0 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+			gpios = <&pca_front 0 GPIO_ACTIVE_HIGH>;
 		};
+	};
+
+	fan_leds {
+		compatible = "gpio-leds";
 		fan0_blue {
 			retain-state-shutdown;
-			default-state = "on";
-			gpios = <&fan_ioexp 8 GPIO_ACTIVE_HIGH>;
+			default-state = "keep";
+			gpios = <&pca_fan 8 GPIO_ACTIVE_HIGH>;
 		};
 		fan1_blue {
 			retain-state-shutdown;
-			default-state = "on";
-			gpios = <&fan_ioexp 9 GPIO_ACTIVE_HIGH>;
+			default-state = "keep";
+			gpios = <&pca_fan 9 GPIO_ACTIVE_HIGH>;
 		};
 		fan2_blue {
 			retain-state-shutdown;
-			default-state = "on";
-			gpios = <&fan_ioexp 10 GPIO_ACTIVE_HIGH>;
+			default-state = "keep";
+			gpios = <&pca_fan 10 GPIO_ACTIVE_HIGH>;
 		};
 		fan3_blue {
 			retain-state-shutdown;
-			default-state = "on";
-			gpios = <&fan_ioexp 11 GPIO_ACTIVE_HIGH>;
+			default-state = "keep";
+			gpios = <&pca_fan 11 GPIO_ACTIVE_HIGH>;
 		};
 		fan0_amber {
 			retain-state-shutdown;
-			default-state = "off";
-			gpios = <&fan_ioexp 12 GPIO_ACTIVE_HIGH>;
+			default-state = "keep";
+			gpios = <&pca_fan 12 GPIO_ACTIVE_HIGH>;
 		};
 		fan1_amber {
 			retain-state-shutdown;
-			default-state = "off";
-			gpios = <&fan_ioexp 13 GPIO_ACTIVE_HIGH>;
+			default-state = "keep";
+			gpios = <&pca_fan 13 GPIO_ACTIVE_HIGH>;
 		};
 		fan2_amber {
 			retain-state-shutdown;
-			default-state = "off";
-			gpios = <&fan_ioexp 14 GPIO_ACTIVE_HIGH>;
+			default-state = "keep";
+			gpios = <&pca_fan 14 GPIO_ACTIVE_HIGH>;
 		};
 		fan3_amber {
 			retain-state-shutdown;
-			default-state = "off";
-			gpios = <&fan_ioexp 15 GPIO_ACTIVE_HIGH>;
-		};
-		sled0_amber {
-			retain-state-shutdown;
-			default-state = "off";
-			gpios = <&sled0_leds 0 GPIO_ACTIVE_LOW>;
-		};
-		sled0_blue {
-			retain-state-shutdown;
-			default-state = "off";
-			gpios = <&sled0_leds 1 GPIO_ACTIVE_LOW>;
+			default-state = "keep";
+			gpios = <&pca_fan 15 GPIO_ACTIVE_HIGH>;
 		};
+	};
+
+	sled1_leds {
+		compatible = "gpio-leds";
 		sled1_amber {
 			retain-state-shutdown;
-			default-state = "off";
-			gpios = <&sled1_leds 0 GPIO_ACTIVE_LOW>;
+			default-state = "keep";
+			gpios = <&pca_sled1 0 GPIO_ACTIVE_LOW>;
 		};
 		sled1_blue {
 			retain-state-shutdown;
-			default-state = "off";
-			gpios = <&sled1_leds 1 GPIO_ACTIVE_LOW>;
+			default-state = "keep";
+			gpios = <&pca_sled1 1 GPIO_ACTIVE_LOW>;
 		};
+	};
+
+	sled2_leds {
+		compatible = "gpio-leds";
 		sled2_amber {
 			retain-state-shutdown;
-			default-state = "off";
-			gpios = <&sled2_leds 0 GPIO_ACTIVE_LOW>;
+			default-state = "keep";
+			gpios = <&pca_sled2 0 GPIO_ACTIVE_LOW>;
 		};
 		sled2_blue {
 			retain-state-shutdown;
-			default-state = "off";
-			gpios = <&sled2_leds 1 GPIO_ACTIVE_LOW>;
+			default-state = "keep";
+			gpios = <&pca_sled2 1 GPIO_ACTIVE_LOW>;
 		};
+	};
+
+	sled3_leds {
+		compatible = "gpio-leds";
 		sled3_amber {
 			retain-state-shutdown;
-			default-state = "off";
-			gpios = <&sled3_leds 0 GPIO_ACTIVE_LOW>;
+			default-state = "keep";
+			gpios = <&pca_sled3 0 GPIO_ACTIVE_LOW>;
 		};
 		sled3_blue {
 			retain-state-shutdown;
-			default-state = "off";
-			gpios = <&sled3_leds 1 GPIO_ACTIVE_LOW>;
+			default-state = "keep";
+			gpios = <&pca_sled3 1 GPIO_ACTIVE_LOW>;
 		};
+	};
+
+	sled4_leds {
+		compatible = "gpio-leds";
 		sled4_amber {
 			retain-state-shutdown;
-			default-state = "off";
-			gpios = <&sled4_leds 0 GPIO_ACTIVE_LOW>;
+			default-state = "keep";
+			gpios = <&pca_sled4 0 GPIO_ACTIVE_LOW>;
 		};
 		sled4_blue {
 			retain-state-shutdown;
-			default-state = "off";
-			gpios = <&sled4_leds 1 GPIO_ACTIVE_LOW>;
+			default-state = "keep";
+			gpios = <&pca_sled4 1 GPIO_ACTIVE_LOW>;
 		};
+	};
+
+	sled5_leds {
+		compatible = "gpio-leds";
 		sled5_amber {
 			retain-state-shutdown;
-			default-state = "off";
-			gpios = <&sled5_leds 0 GPIO_ACTIVE_LOW>;
+			default-state = "keep";
+			gpios = <&pca_sled5 0 GPIO_ACTIVE_LOW>;
 		};
 		sled5_blue {
 			retain-state-shutdown;
-			default-state = "off";
-			gpios = <&sled5_leds 1 GPIO_ACTIVE_LOW>;
+			default-state = "keep";
+			gpios = <&pca_sled5 1 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	sled6_leds {
+		compatible = "gpio-leds";
+		sled6_amber {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pca_sled6 0 GPIO_ACTIVE_LOW>;
+		};
+		sled6_blue {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pca_sled6 1 GPIO_ACTIVE_LOW>;
 		};
 	};
 };
@@ -178,7 +206,8 @@
 };
 
 &rtc {
-	status = "okay";
+	/* Use nxp,pcf85263 (i2c 6-0051) instead */
+	status = "disabled";
 };
 
 &fmc {
@@ -188,26 +217,48 @@
 		m25p,fast-read;
 		label = "bmc";
 		spi-max-frequency = <50000000>;
+		spi-tx-bus-width = <2>;
+		spi-rx-bus-width = <2>;
 #include "openbmc-flash-layout-128.dtsi"
 	};
+	flash@1 {
+		status = "okay";
+		m25p,fast-read;
+		label = "flash1";
+		spi-max-frequency = <50000000>;
+		spi-tx-bus-width = <2>;
+		spi-rx-bus-width = <2>;
+	};
 };
 
 &spi2 {
 	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_spi2_default>;
+
+	compatible = "spi-gpio";
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	gpio-sck = <&gpio0 ASPEED_GPIO(X, 3) GPIO_ACTIVE_HIGH>;
+	gpio-mosi = <&gpio0 ASPEED_GPIO(X, 4) GPIO_ACTIVE_HIGH>;
+	gpio-miso = <&gpio0 ASPEED_GPIO(X, 5) GPIO_ACTIVE_HIGH>;
+	num-chipselects = <1>;
+	cs-gpios = <&gpio0 ASPEED_GPIO(X, 0) GPIO_ACTIVE_LOW>;
 
 	flash@0 {
 		status = "okay";
 		m25p,fast-read;
 		label = "pnor";
-		spi-max-frequency = <100000000>;
+		spi-max-frequency = <12000000>;
 	};
 };
 
 &i2c0 {
 	status = "okay";
-	/* TODO: Add ADC INA230 */
+	ina230@45 {
+		compatible = "ti,ina230";
+		reg = <0x45>;
+		shunt-resistor = <2000>;
+	};
 
 	mp5023@40 {
 		compatible = "mps,mp5023";
@@ -219,7 +270,7 @@
 		reg = <0x4f>;
 	};
 
-	sled0_ioexp: pca9539@76 {
+	sled1_ioexp: pca9539@76 {
 		compatible = "nxp,pca9539";
 		reg = <0x76>;
 		#address-cells = <1>;
@@ -227,14 +278,19 @@
 		gpio-controller;
 		#gpio-cells = <2>;
 
+		interrupt-parent = <&gpio0>;
+		interrupts = <ASPEED_GPIO(M, 0) IRQ_TYPE_LEVEL_LOW>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+
 		gpio-line-names =
-		"SLED0_MS_DETECT1","SLED0_VBUS_BMC_EN","SLED0_INA230_ALERT","SLED0_P12V_STBY_ALERT",
-		"SLED0_SSD_ALERT","SLED0_MS_DETECT0","SLED0_RST_CCG5","SLED0_FUSB302_INT",
-		"SLED0_MD_STBY_RESET","SLED0_MD_IOEXP_EN_FAULT","SLED0_MD_DIR","SLED0_MD_DECAY",
-		"SLED0_MD_MODE1","SLED0_MD_MODE2","SLED0_MD_MODE3","power-host0";
+		"SLED1_MS_DETECT1","SLED1_VBUS_BMC_EN","SLED1_INA230_ALERT","SLED1_P12V_STBY_ALERT",
+		"SLED1_SSD_ALERT","SLED1_MS_DETECT0","SLED1_RST_CCG5","SLED1_FUSB302_INT",
+		"SLED1_MD_STBY_RESET","SLED1_MD_IOEXP_EN_FAULT","SLED1_MD_DIR","SLED1_MD_DECAY",
+		"SLED1_MD_MODE1","SLED1_MD_MODE2","SLED1_MD_MODE3","power-host1";
 	};
 
-	sled0_leds: pca9552@67 {
+	pca_sled1: pca9552@67 {
 		compatible = "nxp,pca9552";
 		reg = <0x67>;
 		#address-cells = <1>;
@@ -243,13 +299,13 @@
 		#gpio-cells = <2>;
 
 		gpio-line-names =
-		"led-sled0-amber","led-sled0-blue","SLED0_RST_IOEXP","",
+		"led-sled1-amber","led-sled1-blue","SLED1_RST_IOEXP","SLED1_MD_REF_PWM",
 		"","","","",
 		"","","","",
 		"","","","";
 	};
 
-	sled0_fusb302: typec-portc@22 {
+	sled1_fusb302: typec-portc@22 {
 		compatible = "fcs,fusb302";
 		reg = <0x22>;
 
@@ -270,7 +326,11 @@
 
 &i2c1 {
 	status = "okay";
-	/* TODO: Add ADC INA230 */
+	ina230@45 {
+		compatible = "ti,ina230";
+		reg = <0x45>;
+		shunt-resistor = <2000>;
+	};
 
 	mp5023@40 {
 		compatible = "mps,mp5023";
@@ -282,7 +342,7 @@
 		reg = <0x4f>;
 	};
 
-	sled1_ioexp: pca9539@76 {
+	sled2_ioexp: pca9539@76 {
 		compatible = "nxp,pca9539";
 		reg = <0x76>;
 		#address-cells = <1>;
@@ -290,14 +350,19 @@
 		gpio-controller;
 		#gpio-cells = <2>;
 
+		interrupt-parent = <&gpio0>;
+		interrupts = <ASPEED_GPIO(M, 1) IRQ_TYPE_LEVEL_LOW>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+
 		gpio-line-names =
-		"SLED1_MS_DETECT1","SLED1_VBUS_BMC_EN","SLED1_INA230_ALERT","SLED1_P12V_STBY_ALERT",
-		"SLED1_SSD_ALERT","SLED1_MS_DETECT0","SLED1_RST_CCG5","SLED1_FUSB302_INT",
-		"SLED1_MD_STBY_RESET","SLED1_MD_IOEXP_EN_FAULT","SLED1_MD_DIR","SLED1_MD_DECAY",
-		"SLED1_MD_MODE1","SLED1_MD_MODE2","SLED1_MD_MODE3","power-host1";
+		"SLED2_MS_DETECT1","SLED2_VBUS_BMC_EN","SLED2_INA230_ALERT","SLED2_P12V_STBY_ALERT",
+		"SLED2_SSD_ALERT","SLED2_MS_DETECT0","SLED2_RST_CCG5","SLED2_FUSB302_INT",
+		"SLED2_MD_STBY_RESET","SLED2_MD_IOEXP_EN_FAULT","SLED2_MD_DIR","SLED2_MD_DECAY",
+		"SLED2_MD_MODE1","SLED2_MD_MODE2","SLED2_MD_MODE3","power-host2";
 	};
 
-	sled1_leds: pca9552@67 {
+	pca_sled2: pca9552@67 {
 		compatible = "nxp,pca9552";
 		reg = <0x67>;
 		#address-cells = <1>;
@@ -306,13 +371,13 @@
 		#gpio-cells = <2>;
 
 		gpio-line-names =
-		"led-sled1-amber","led-sled1-blue","SLED1_RST_IOEXP","",
+		"led-sled2-amber","led-sled2-blue","SLED2_RST_IOEXP","SLED2_MD_REF_PWM",
 		"","","","",
 		"","","","",
 		"","","","";
 	};
 
-	sled1_fusb302: typec-portc@22 {
+	sled2_fusb302: typec-portc@22 {
 		compatible = "fcs,fusb302";
 		reg = <0x22>;
 
@@ -331,13 +396,13 @@
 	};
 };
 
-&i2c1 {
-	status = "okay";
-};
-
 &i2c2 {
 	status = "okay";
-	/* TODO: Add ADC INA230 */
+	ina230@45 {
+		compatible = "ti,ina230";
+		reg = <0x45>;
+		shunt-resistor = <2000>;
+	};
 
 	mp5023@40 {
 		compatible = "mps,mp5023";
@@ -349,7 +414,7 @@
 		reg = <0x4f>;
 	};
 
-	sled2_ioexp: pca9539@76 {
+	sled3_ioexp: pca9539@76 {
 		compatible = "nxp,pca9539";
 		reg = <0x76>;
 		#address-cells = <1>;
@@ -357,14 +422,19 @@
 		gpio-controller;
 		#gpio-cells = <2>;
 
+		interrupt-parent = <&gpio0>;
+		interrupts = <ASPEED_GPIO(M, 2) IRQ_TYPE_LEVEL_LOW>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+
 		gpio-line-names =
-		"SLED2_MS_DETECT1","SLED2_VBUS_BMC_EN","SLED2_INA230_ALERT","SLED2_P12V_STBY_ALERT",
-		"SLED2_SSD_ALERT","SLED2_MS_DETECT0","SLED2_RST_CCG5","SLED2_FUSB302_INT",
-		"SLED2_MD_STBY_RESET","SLED2_MD_IOEXP_EN_FAULT","SLED2_MD_DIR","SLED2_MD_DECAY",
-		"SLED2_MD_MODE1","SLED2_MD_MODE2","SLED2_MD_MODE3","power-host2";
+		"SLED3_MS_DETECT1","SLED3_VBUS_BMC_EN","SLED3_INA230_ALERT","SLED3_P12V_STBY_ALERT",
+		"SLED3_SSD_ALERT","SLED3_MS_DETECT0","SLED3_RST_CCG5","SLED3_FUSB302_INT",
+		"SLED3_MD_STBY_RESET","SLED3_MD_IOEXP_EN_FAULT","SLED3_MD_DIR","SLED3_MD_DECAY",
+		"SLED3_MD_MODE1","SLED3_MD_MODE2","SLED3_MD_MODE3","power-host3";
 	};
 
-	sled2_leds: pca9552@67 {
+	pca_sled3: pca9552@67 {
 		compatible = "nxp,pca9552";
 		reg = <0x67>;
 		#address-cells = <1>;
@@ -373,13 +443,13 @@
 		#gpio-cells = <2>;
 
 		gpio-line-names =
-		"led-sled2-amber","led-sled2-blue","SLED2_RST_IOEXP","",
+		"led-sled3-amber","led-sled3-blue","SLED3_RST_IOEXP","SLED3_MD_REF_PWM",
 		"","","","",
 		"","","","",
 		"","","","";
 	};
 
-	sled2_fusb302: typec-portc@22 {
+	sled3_fusb302: typec-portc@22 {
 		compatible = "fcs,fusb302";
 		reg = <0x22>;
 
@@ -400,7 +470,11 @@
 
 &i2c3 {
 	status = "okay";
-	/* TODO: Add ADC INA230 */
+	ina230@45 {
+		compatible = "ti,ina230";
+		reg = <0x45>;
+		shunt-resistor = <2000>;
+	};
 
 	mp5023@40 {
 		compatible = "mps,mp5023";
@@ -412,7 +486,7 @@
 		reg = <0x4f>;
 	};
 
-	sled3_ioexp: pca9539@76 {
+	sled4_ioexp: pca9539@76 {
 		compatible = "nxp,pca9539";
 		reg = <0x76>;
 		#address-cells = <1>;
@@ -420,14 +494,19 @@
 		gpio-controller;
 		#gpio-cells = <2>;
 
+		interrupt-parent = <&gpio0>;
+		interrupts = <ASPEED_GPIO(M, 3) IRQ_TYPE_LEVEL_LOW>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+
 		gpio-line-names =
-		"SLED3_MS_DETECT1","SLED3_VBUS_BMC_EN","SLED3_INA230_ALERT","SLED3_P12V_STBY_ALERT",
-		"SLED3_SSD_ALERT","SLED3_MS_DETECT0","SLED3_RST_CCG5","SLED3_FUSB302_INT",
-		"SLED3_MD_STBY_RESET","SLED3_MD_IOEXP_EN_FAULT","SLED3_MD_DIR","SLED3_MD_DECAY",
-		"SLED3_MD_MODE1","SLED3_MD_MODE2","SLED3_MD_MODE3","power-host3";
+		"SLED4_MS_DETECT1","SLED4_VBUS_BMC_EN","SLED4_INA230_ALERT","SLED4_P12V_STBY_ALERT",
+		"SLED4_SSD_ALERT","SLED4_MS_DETECT0","SLED4_RST_CCG5","SLED4_FUSB302_INT",
+		"SLED4_MD_STBY_RESET","SLED4_MD_IOEXP_EN_FAULT","SLED4_MD_DIR","SLED4_MD_DECAY",
+		"SLED4_MD_MODE1","SLED4_MD_MODE2","SLED4_MD_MODE3","power-host4";
 	};
 
-	sled3_leds: pca9552@67 {
+	pca_sled4: pca9552@67 {
 		compatible = "nxp,pca9552";
 		reg = <0x67>;
 		#address-cells = <1>;
@@ -436,13 +515,13 @@
 		#gpio-cells = <2>;
 
 		gpio-line-names =
-		"led-sled3-amber","led-sled3-blue","SLED3_RST_IOEXP","",
+		"led-sled4-amber","led-sled4-blue","SLED4_RST_IOEXP","SLED4_MD_REF_PWM",
 		"","","","",
 		"","","","",
 		"","","","";
 	};
 
-	sled3_fusb302: typec-portc@22 {
+	sled4_fusb302: typec-portc@22 {
 		compatible = "fcs,fusb302";
 		reg = <0x22>;
 
@@ -463,7 +542,11 @@
 
 &i2c4 {
 	status = "okay";
-	/* TODO: Add ADC INA230 */
+	ina230@45 {
+		compatible = "ti,ina230";
+		reg = <0x45>;
+		shunt-resistor = <2000>;
+	};
 
 	mp5023@40 {
 		compatible = "mps,mp5023";
@@ -475,7 +558,7 @@
 		reg = <0x4f>;
 	};
 
-	sled4_ioexp: pca9539@76 {
+	sled5_ioexp: pca9539@76 {
 		compatible = "nxp,pca9539";
 		reg = <0x76>;
 		#address-cells = <1>;
@@ -483,14 +566,19 @@
 		gpio-controller;
 		#gpio-cells = <2>;
 
+		interrupt-parent = <&gpio0>;
+		interrupts = <ASPEED_GPIO(M, 4) IRQ_TYPE_LEVEL_LOW>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+
 		gpio-line-names =
-		"SLED4_MS_DETECT1","SLED4_VBUS_BMC_EN","SLED4_INA230_ALERT","SLED4_P12V_STBY_ALERT",
-		"SLED4_SSD_ALERT","SLED4_MS_DETECT0","SLED4_RST_CCG5","SLED4_FUSB302_INT",
-		"SLED4_MD_STBY_RESET","SLED4_MD_IOEXP_EN_FAULT","SLED4_MD_DIR","SLED4_MD_DECAY",
-		"SLED4_MD_MODE1","SLED4_MD_MODE2","SLED4_MD_MODE3","power-host4";
+		"SLED5_MS_DETECT1","SLED5_VBUS_BMC_EN","SLED5_INA230_ALERT","SLED5_P12V_STBY_ALERT",
+		"SLED5_SSD_ALERT","SLED5_MS_DETECT0","SLED5_RST_CCG5","SLED5_FUSB302_INT",
+		"SLED5_MD_STBY_RESET","SLED5_MD_IOEXP_EN_FAULT","SLED5_MD_DIR","SLED5_MD_DECAY",
+		"SLED5_MD_MODE1","SLED5_MD_MODE2","SLED5_MD_MODE3","power-host5";
 	};
 
-	sled4_leds: pca9552@67 {
+	pca_sled5: pca9552@67 {
 		compatible = "nxp,pca9552";
 		reg = <0x67>;
 		#address-cells = <1>;
@@ -499,13 +587,13 @@
 		#gpio-cells = <2>;
 
 		gpio-line-names =
-		"led-sled4-amber","led-sled4-blue","SLED4_RST_IOEXP","",
+		"led-sled5-amber","led-sled5-blue","SLED5_RST_IOEXP","SLED5_MD_REF_PWM",
 		"","","","",
 		"","","","",
 		"","","","";
 	};
 
-	sled4_fusb302: typec-portc@22 {
+	sled5_fusb302: typec-portc@22 {
 		compatible = "fcs,fusb302";
 		reg = <0x22>;
 
@@ -526,7 +614,11 @@
 
 &i2c5 {
 	status = "okay";
-	/* TODO: Add ADC INA230 */
+	ina230@45 {
+		compatible = "ti,ina230";
+		reg = <0x45>;
+		shunt-resistor = <2000>;
+	};
 
 	mp5023@40 {
 		compatible = "mps,mp5023";
@@ -538,7 +630,7 @@
 		reg = <0x4f>;
 	};
 
-	sled5_ioexp: pca9539@76 {
+	sled6_ioexp: pca9539@76 {
 		compatible = "nxp,pca9539";
 		reg = <0x76>;
 		#address-cells = <1>;
@@ -546,14 +638,19 @@
 		gpio-controller;
 		#gpio-cells = <2>;
 
+		interrupt-parent = <&gpio0>;
+		interrupts = <ASPEED_GPIO(M, 5) IRQ_TYPE_LEVEL_LOW>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+
 		gpio-line-names =
-		"SLED5_MS_DETECT1","SLED5_VBUS_BMC_EN","SLED5_INA230_ALERT","SLED5_P12V_STBY_ALERT",
-		"SLED5_SSD_ALERT","SLED5_MS_DETECT0","SLED5_RST_CCG5","SLED5_FUSB302_INT",
-		"SLED5_MD_STBY_RESET","SLED5_MD_IOEXP_EN_FAULT","SLED5_MD_DIR","SLED5_MD_DECAY",
-		"SLED5_MD_MODE1","SLED5_MD_MODE2","SLED5_MD_MODE3","power-host5";
+		"SLED6_MS_DETECT1","SLED6_VBUS_BMC_EN","SLED6_INA230_ALERT","SLED6_P12V_STBY_ALERT",
+		"SLED6_SSD_ALERT","SLED6_MS_DETECT0","SLED6_RST_CCG5","SLED6_FUSB302_INT",
+		"SLED6_MD_STBY_RESET","SLED6_MD_IOEXP_EN_FAULT","SLED6_MD_DIR","SLED6_MD_DECAY",
+		"SLED6_MD_MODE1","SLED6_MD_MODE2","SLED6_MD_MODE3","power-host6";
 	};
 
-	sled5_leds: pca9552@67 {
+	pca_sled6: pca9552@67 {
 		compatible = "nxp,pca9552";
 		reg = <0x67>;
 		#address-cells = <1>;
@@ -562,13 +659,13 @@
 		#gpio-cells = <2>;
 
 		gpio-line-names =
-		"led-sled5-amber","led-sled5-blue","SLED5_RST_IOEXP","",
+		"led-sled6-amber","led-sled6-blue","SLED6_RST_IOEXP","SLED6_MD_REF_PWM",
 		"","","","",
 		"","","","",
 		"","","","";
 	};
 
-	sled5_fusb302: typec-portc@22 {
+	sled6_fusb302: typec-portc@22 {
 		compatible = "fcs,fusb302";
 		reg = <0x22>;
 
@@ -632,7 +729,7 @@
 		reg = <0x40>;
 	};
 
-	front_leds: pca9552@67 {
+	pca_front: pca9552@67 {
 		compatible = "nxp,pca9552";
 		reg = <0x67>;
 		#address-cells = <1>;
@@ -655,6 +752,7 @@
 	adm1278@11 {
 		compatible = "adi,adm1278";
 		reg = <0x11>;
+		shunt-resistor-micro-ohms = <300>;
 	};
 
 	tmp421@4c {
@@ -667,7 +765,7 @@
 		reg = <0x4d>;
 	};
 
-	fan_ioexp: pca9552@67 {
+	pca_fan: pca9552@67 {
 		compatible = "nxp,pca9552";
 		reg = <0x67>;
 		#address-cells = <1>;
@@ -700,36 +798,38 @@
 	/*D0-D7*/	"","","","","","","","",
 	/*E0-E7*/	"","","","","","","","",
 	/*F0-F7*/	"","","","","","","","",
-	/*G0-G7*/	"","SWITCH_FRU_MUX","","","","","","",
+	/*G0-G7*/	"BSM_FRU_WP","SWITCH_FRU_MUX","","",
+			"PWRGD_P1V05_VDDCORE","PWRGD_P1V5_VDD","","",
 	/*H0-H7*/	"presence-riser1","presence-riser2",
-			"presence-sled0","presence-sled1",
-			"presence-sled2","presence-sled3",
-			"presence-sled4","presence-sled5",
+			"presence-sled1","presence-sled2",
+			"presence-sled3","presence-sled4",
+			"presence-sled5","presence-sled6",
 	/*I0-I7*/	"REV_ID0","","REV_ID1","REV_ID2",
-			"","","","",
+			"","BSM_FLASH_WP_STATUS","BMC_TPM_PRES","",
 	/*J0-J7*/	"","","","","","","","",
 	/*K0-K7*/	"","","","","","","","",
-	/*L0-L7*/	"","","","","","","","",
-	/*M0-M7*/	"ALERT_SLED0","ALERT_SLED1",
-			"ALERT_SLED2","ALERT_SLED3",
-			"ALERT_SLED4","ALERT_SLED5",
+	/*L0-L7*/	"","","","","","BMC_RTC_INT","","",
+	/*M0-M7*/	"ALERT_SLED1","ALERT_SLED2",
+			"ALERT_SLED3","ALERT_SLED4",
+			"ALERT_SLED5","ALERT_SLED6",
 			"P12V_AUX_ALERT1","",
 	/*N0-N7*/	"","","","","","","","",
 	/*O0-O7*/	"","","","",
 			"","BOARD_ID0","BOARD_ID1","BOARD_ID2",
-	/*P0-P7*/	"","","","","","","","",
+	/*P0-P7*/	"","","","","","","","BMC_HEARTBEAT",
 	/*Q0-Q7*/	"","","","","","","","",
 	/*R0-R7*/	"","","","","","","","",
 	/*S0-S7*/	"","","","BAT_DETECT",
 			"BMC_BT_WP0","BMC_BT_WP1","","",
 	/*T0-T7*/	"","","","","","","","",
 	/*U0-U7*/	"","","","","","","","",
-	/*V0-V7*/	"","RST_BMC_MVL","","",
+	/*V0-V7*/	"PWRGD_CNS_PSU","RST_BMC_MVL","","PSU_PRSNT",
 			"USB2_SEL0_A","USB2_SEL1_A",
 			"USB2_SEL0_B","USB2_SEL1_B",
 	/*W0-W7*/	"RST_FRONT_IOEXP","","","","","","","",
 	/*X0-X7*/	"","","","","","","","",
-	/*Y0-Y7*/	"","","BSM_FLASH_LATCH","","","","","",
+	/*Y0-Y7*/	"BMC_SELF_HW_RST","BSM_PRSNT","BSM_FLASH_LATCH","",
+			"","","","",
 	/*Z0-Z7*/	"","","","","","","","";
 };
 
@@ -754,3 +854,11 @@
 		&pinctrl_adc12_default &pinctrl_adc13_default
 		&pinctrl_adc14_default &pinctrl_adc15_default>;
 };
+
+&mdio3 {
+	status = "okay";
+	ethphy0: ethernet-phy@0 {
+		compatible = "ethernet-phy-id002b.09ae";
+		reg = <0>;
+	};
+};
-- 
2.17.1

