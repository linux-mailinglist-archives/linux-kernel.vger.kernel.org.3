Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3B94CD8B1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 17:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240614AbiCDQMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 11:12:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240558AbiCDQMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 11:12:43 -0500
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130088.outbound.protection.outlook.com [40.107.13.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFAA1C9457;
        Fri,  4 Mar 2022 08:11:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wsp2HwADH3nLx/+DKlsCP0qm5PBVFGeysiKsjzQsbEiuxtlUzA0M0NCi4c+oWtm68Ca9i13s29uZhVCeDEfPv6tFochqdZ18lo7VU4d2nsi9O0noGjgGPhnkpw0Mh8zvS5fDNQc10z18tayidz5qJWX9dFBTlCj3bXrcgBbuUKTgxPBKQE4T6HOZW3NYnZlS64XpzlK+s3HUZ9nDrSIwp1aA8BhzIs65XzVULY7c5eeAlz2N4EJ0xURr3lxuTsvEX56IeoYaGBAdoV2p8rLaEWr6BS9FwA5mQeVj0ERecup00Wz1yUQj0HjuCTo6ODBocxMMMQFKkhLsUCzWGZQF1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LZw1+VtLOQLBFtratwHT1jmRlN9tWZHxciODuakdhR8=;
 b=TTqhgv0MCRUpfFmopSUe8jP0bvJ6Tfo+0SK5r8q5LXArksXa8QxG6kCtM4n+N362IwnmpVZkS2depU3UnkGN7+y8G9jPIpbdsO1kYlpskdUXmiVsrBC2G1Avx1gR2G7wZnbJBJPct9PQcc2iDS3e9yKVY914k9P/tS0tKYn6KumGxS6Fhg7TyyGknyWpcVYMu80QzhyhC/3OX4hYJwUZjMK9JYrAzI4sVdxuYzTdnCpvINuxNbbm/nclDUBoP9+wonpsTCM4AQREprAYW/FhASi5X9lxTW0ARDFtsu0UDzNlfDHy6bISTybXhsUXV43TfMALENGwUxfdjhGR2Jy1Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LZw1+VtLOQLBFtratwHT1jmRlN9tWZHxciODuakdhR8=;
 b=NFd3fwxR04iyZsVodfZ7qSfOgXcNW6bAgEGiSUXK9cJX1QV5PjaOVCUgxJMTO8ZiVzqiBBUgd42tZkYsvt/0QDEMGyuaB9+gvq64IvSyh+uJXHWjQwS+VvAPKCWRpb9mEq6qRbnQ8k6T8bGTc+mTiEkv3bNUDnVpxD+/7/KjLq4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com (2603:10a6:3:e1::23)
 by DB8PR08MB5481.eurprd08.prod.outlook.com (2603:10a6:10:114::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Fri, 4 Mar
 2022 16:11:48 +0000
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::f9ee:a333:b115:5049]) by HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::f9ee:a333:b115:5049%4]) with mapi id 15.20.5017.028; Fri, 4 Mar 2022
 16:11:48 +0000
From:   Michael Riesch <michael.riesch@wolfvision.net>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Levin Du <djw@t-chip.com.cn>, Tianling Shen <cnsztl@gmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Alex Bee <knaerzche@gmail.com>, Liang Chen <cl@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>
Subject: [PATCH 3/3] arm64: dts: rockchip: enable vop2 and hdmi tx on rock-3a
Date:   Fri,  4 Mar 2022 17:11:30 +0100
Message-Id: <20220304161130.34977-4-michael.riesch@wolfvision.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220304161130.34977-1-michael.riesch@wolfvision.net>
References: <20220304161130.34977-1-michael.riesch@wolfvision.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0016.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::26) To HE1PR0802MB2426.eurprd08.prod.outlook.com
 (2603:10a6:3:e1::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b80ed30e-e6dd-4c22-45ac-08d9fdf9afae
X-MS-TrafficTypeDiagnostic: DB8PR08MB5481:EE_
X-Microsoft-Antispam-PRVS: <DB8PR08MB5481AD8403853D46CD5274B4F2059@DB8PR08MB5481.eurprd08.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l3Dc8EpPBzidiMJRgvj8IVfik9hwzFKQw4QgYYSI4d5QJph5a6Z0PmDgGYhnde4tx6uwwdGX25VBCu7pifyegML6Cvv1pLRAkAZ5Gp1shaabFwoeRqPfYaneHCs5SPkJEJ9NBjd+EHag/4BUaoFuEJ7lVYK0tuynU5rGfaLCAthEn7Zk8e4Zj90k6L2OB4tblw+2FXrvDKDwYMdcUfX2oTTMTeFb+LC3wtbTYbdK1xwxqEFxK0koFnImfXJHPkJ5/GU2ky9a3UkAG7iPhuoDgJYufX6NsnH/1LXIwy7x5eiKUQGNp8abc929Vrf61LvsuTJL8sfIWi0WltU6Hb+KOf65r00toSjs3XwCgSIrodj9dymSrS+GGVLXYw3xx1GaWYJE2Ac6Wy78tD1Cltyu6Dig5YcKiQ3H5qrs4gDVK7wFwQxSDxt+Tc/ERGG4J4mbt6hDgfywq4sOS8r7wDZIO/dLvEDim+9qff+I90eMJLmO77YivxagknvAHW8Ke/N06RQuOYvcNu9Aa7sfM2WebbjoGhO5ph0HFKoOvaCcgggaZcMLVji/PoX7006cLqa3CL2FYtKeHUq+E7RBSug3DzFcEPYyXBu6FvLoljSnkznlmoQOLDxhmrRdD/rFjBJQfiMIbkBoJe/vh1OrnlnOMA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0802MB2426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(346002)(376002)(39840400004)(366004)(136003)(396003)(5660300002)(4326008)(38100700002)(8676002)(66476007)(7416002)(86362001)(66556008)(44832011)(6486002)(2616005)(508600001)(186003)(316002)(1076003)(107886003)(66946007)(6512007)(54906003)(36756003)(83380400001)(6666004)(52116002)(6506007)(2906002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?49L4MmB0kzW2lkJ/gUlavAIyfa47ikKqw+KtUJkPRBaOmKiUhQAUIhnwr+ZS?=
 =?us-ascii?Q?U7xKhCTVBrDkNMxarN5SzMFgVax7kLDfVYb4dufAlAez66KOXUvx6B4/pB00?=
 =?us-ascii?Q?7+9hgyOnU2lSe70vayAj/Obw+rxfpXmnaBwe19Ein/yUPZmL8OivJT4LLgOe?=
 =?us-ascii?Q?PZaOlKkFWFlmCL3QzIeXzVpYej3Pz43vgcWUe2BCy6dUf2t5VnPrKFG5EW1t?=
 =?us-ascii?Q?SWZvQovOQ7QpStnALQ2ypwZSDdoyPA07cjiv4CIEr4H2iejjBYC2m2KLpQ64?=
 =?us-ascii?Q?FJB9IiezSnGLh6reWe9yztdb8SmMz2oKR7wQeJaNE6Ci66AxtF9PNAAlTI5e?=
 =?us-ascii?Q?HXqqYAueBtQEpOequar/V5vfwpxXBMVqbGF5qnbdsyOUCacGKEYSgqSDmwoe?=
 =?us-ascii?Q?izAuHu1qb9p4J4RxrOn2UdOCPM46HeRC0bHsjj0/ndZyZmhOP/a9kYdGYBzy?=
 =?us-ascii?Q?9cWE737jHIhikkevnZK3h5lb7iF57H2HNeuaFZcUeLV4QVjwPssA12CsJPoz?=
 =?us-ascii?Q?qxh0cJmCw2yOzfIgk8ef2/D/pvDU27gNakIZDIjJqDOd25ob9+z2O4JjFaQS?=
 =?us-ascii?Q?UlaVsBTJX4IFHU9R0GfBlR3/9fgaKnknt9clQn0LdmHKa9duR14EFZz8avAK?=
 =?us-ascii?Q?/EOcEr73Xdiy9RIibl31ouVunMQaWiTRlIDL4ij/fdXKyWTNdcyU0ilAyDhh?=
 =?us-ascii?Q?0YTl6GfDkLJelUnBxxiD3NCayr6dbjRC2xLBis/ExLvya6QvDWAsv+H9uCM/?=
 =?us-ascii?Q?SMDf7ZzfLRPkTvrTKdw/UKuH/MgZsNxKGsNSLdE+i/WWNWftxGzzRRPCV97N?=
 =?us-ascii?Q?koGoNmAV19eDDFilQd76r7HVlD0SqeKLhz/qO+DJPpGFvS3S73Ax/0UcIdfm?=
 =?us-ascii?Q?HameAfaWhCQO7o1LkST0smy7wlxUi0BJKItzobK5pv0W25zA2gaCApYfI+OE?=
 =?us-ascii?Q?pFkI7MBSoZTbHMKB1fgKphxaLSOx7ygN1JhllFGdrPUrtTBH9QRMM8f03gQP?=
 =?us-ascii?Q?cLUgx1i+DznvvbbEUigfzxwyivkqqClJQ5owyoDcT/ETQXhRSzX7kgXZjE/N?=
 =?us-ascii?Q?DFnoSUOuCNWBp6Szqn0x87ueVv9TvJZezOhMfFPU7ImyxsAldYhvYHyRXTnE?=
 =?us-ascii?Q?NDmAKB2g/xT6QNq9FOW0QLNhxQmS2ip2BZp1DMYGDQcpfRbiV683WEdky/hX?=
 =?us-ascii?Q?ONpBdS19VdrPgDEKvyLneh3HYkB0YpXDO9BxMv5H1cA8Q0p7meIIHNqGP06M?=
 =?us-ascii?Q?5WwisR1muw6bl7iFvw0DZVxZmloW2TMX2wh/ms/OdEYRjxG8ic6LMxJXzOy5?=
 =?us-ascii?Q?IkX7m7chGyPHo3qbB0nJsVALeDN95zRFnn3O6jWueVbt3Ar/+VPEBg0HqD38?=
 =?us-ascii?Q?8FeCh7Mzi3I8QNpyxbRU+0geu3dbYKM7FqqbSo95R1g/8ZN0zUfwQ0m+pygu?=
 =?us-ascii?Q?wRE8dgLmo5gBYVWat+MCv6XZPp2jkAoMS53atG+MQ8Qt+bnWrY4imus/B6am?=
 =?us-ascii?Q?lWXIIQu15kGebBb5BKGXWYdEfzJX3Ma7EEw+0tTQVSPHq2bWe1HJk90IfNnB?=
 =?us-ascii?Q?KIWHUgMw9WAvUSS/SVWRhb8qO5hm0qdVYH+AmpOkWe7EwUXzSdzme9TnTn1/?=
 =?us-ascii?Q?1IPfBfYfrT3wH3DqGI9z1CXCW76gPnqgeD6zip+fGNM8qJDtHq0cAJvGVtiA?=
 =?us-ascii?Q?4IdGqFdOGmFjpLxFzmsJDUYazD8/IN/DTseluDF3ky9wFwKhzrUzQw0QqOHS?=
 =?us-ascii?Q?LpqApjLX/qofCaoac1m9xODlfr/ibJI=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: b80ed30e-e6dd-4c22-45ac-08d9fdf9afae
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0802MB2426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 16:11:48.7003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EIfkrwTNEznw8gR++ApRg5Uzk5e0dK8TAI98DEB20LSNflOKfiLr10MXyrneIrcC2L/wJ1X2XdfFv+PxXTBUMIDHZJNlYeAHknMsiiGLn28=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5481
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the RK356x Video Output Processor (VOP) 2 on the Radxa
ROCK3 Model A.

Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
---
 .../boot/dts/rockchip/rk3568-rock-3a.dts      | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
index 18d2d8e5e693..e568ce377055 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
@@ -4,6 +4,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/pinctrl/rockchip.h>
+#include <dt-bindings/soc/rockchip,vop2.h>
 #include "rk3568.dtsi"
 
 / {
@@ -20,6 +21,17 @@ chosen: chosen {
 		stdout-path = "serial2:1500000n8";
 	};
 
+	hdmi-con {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_con_in: endpoint {
+				remote-endpoint = <&hdmi_out_con>;
+			};
+		};
+	};
+
 	leds {
 		compatible = "gpio-leds";
 
@@ -134,6 +146,24 @@ &gpu {
 	status = "okay";
 };
 
+&hdmi {
+	avdd-0v9-supply = <&vdda0v9_image>;
+	avdd-1v8-supply = <&vcca1v8_image>;
+	status = "okay";
+};
+
+&hdmi_in {
+	hdmi_in_vp0: endpoint {
+		remote-endpoint = <&vp0_out_hdmi>;
+	};
+};
+
+&hdmi_out {
+	hdmi_out_con: endpoint {
+		remote-endpoint = <&hdmi_con_in>;
+	};
+};
+
 &i2c0 {
 	status = "okay";
 
@@ -499,3 +529,20 @@ &usb2phy1_otg {
 	phy-supply = <&vcc5v0_usb_host>;
 	status = "okay";
 };
+
+&vop {
+	assigned-clocks = <&cru DCLK_VOP0>, <&cru DCLK_VOP1>;
+	assigned-clock-parents = <&pmucru PLL_HPLL>, <&cru PLL_VPLL>;
+	status = "okay";
+};
+
+&vop_mmu {
+	status = "okay";
+};
+
+&vp0 {
+	vp0_out_hdmi: endpoint@ROCKCHIP_VOP2_EP_HDMI0 {
+		reg = <ROCKCHIP_VOP2_EP_HDMI0>;
+		remote-endpoint = <&hdmi_in_vp0>;
+	};
+};
-- 
2.30.2

