Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50BC64C1877
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 17:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242763AbiBWQVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 11:21:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242762AbiBWQVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 11:21:48 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60069.outbound.protection.outlook.com [40.107.6.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9EF9C6206;
        Wed, 23 Feb 2022 08:21:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YYlcIGaeCuUDXQYnKeKccTMHSdAevX89tHtvwdSNFVgU/rgz7Yq7pEABifhurv8dNUWsfPXJyIAo30ErfByzOdZfHHp6+fx+yGW/O5rQ6mzBZfIXx+Z7YjjicSoJCZyWbK9iL8U9HtMwBYevv4JRBnqJAqlnXnfuybfr4sAfWJbhCu53How8M/yw+Yq8LhnvxubgXniw3bV5xkUpRr9QEgMvNj7RlQYxV8YD+kmFT+m5B6tkpUQh3W6ThhYJa6HVBL8XAWer9EBWuOnHb8zar5H5zj466E8V/WVVf7aIcY7t6XdGH9Q/8Fuwz8UXYAF8alsmTNaqmyoPlE+FNQe10g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lmylffdE7ICLsXYq7mnD3JZBs6zEm80G7C1Ek+QXQ+4=;
 b=DuOjxv4zr58M2hZBaFHB/xaO33AmLwqdNNbIUizGTGw1G7ldhQHtpHVE7tk2pmysD+z/I4kq2nVT0UdtKZGwvtjIaHEG9asMd+NCR2+GsRBc2zBwWdclCeKRhWQrT7TqnBAudXdrnMtf8yn3FX3ohiV0v4Nabl0kKwuC8otd15KzphTHO4y40dRCCwhRR+SIBhxtGOJfBMeGGDOJ0g/H6wv8i+by0emGkAl+gRV+NWwYBTJDyMnlE/io3N8SYxR3iZK9uNZFYGmj2ZeXUkPCmLJlJZsCR2NVIRQThGOGnquxw8CVkiE8aQJfM8WXDGawf9lhawCRZyi5fOWRKjZDkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lmylffdE7ICLsXYq7mnD3JZBs6zEm80G7C1Ek+QXQ+4=;
 b=FJAbuawVhIbsh5X+r58yyaBO12d8VqkWULGgsDQMbuO9Xl9yC0bZYUe4/WQkWxjT3mmeZVq+hev9FpIgjIMP8r37qwnXMYEcnS6o9jrFgjQf4Ma306ycDKLcZWfZiW8GMwDF8CjMDTOBswKWYfw+bU11NEJU2Gda6DJdMWCIkz0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com (2603:10a6:3:e1::23)
 by PAXPR08MB7264.eurprd08.prod.outlook.com (2603:10a6:102:213::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Wed, 23 Feb
 2022 16:21:07 +0000
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::f9ee:a333:b115:5049]) by HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::f9ee:a333:b115:5049%4]) with mapi id 15.20.4995.027; Wed, 23 Feb 2022
 16:21:07 +0000
From:   Michael Riesch <michael.riesch@wolfvision.net>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Liang Chen <cl@rock-chips.com>
Subject: [PATCH] arm64: dts: rockchip: add the vdd_cpu regulator to rk3568-evb1-v10
Date:   Wed, 23 Feb 2022 17:20:54 +0100
Message-Id: <20220223162054.1626257-1-michael.riesch@wolfvision.net>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0175.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::17) To HE1PR0802MB2426.eurprd08.prod.outlook.com
 (2603:10a6:3:e1::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b0f871a-73ed-4d96-ddec-08d9f6e87ed2
X-MS-TrafficTypeDiagnostic: PAXPR08MB7264:EE_
X-Microsoft-Antispam-PRVS: <PAXPR08MB72645C6CEE2081C2ACF025D5F23C9@PAXPR08MB7264.eurprd08.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WmU1zMw2mhLgk1L3xUADttidESynGoIjDUJIyGEQEoGUDUt7/SSpeID4EgAVVWPsig1cfMT2tEb6PdP+MjA7x1JObET/RcHCODowF2mXY17JZj2fIPWbqf1RKt7yMeo6YfVfhRjWAUyCBJ+3imOeE0IowmVsc/4T/CTPTY/gPJ6g/8AXLs42xpAJaZ4nY67hwIAPktoAfsjeV21gYvShAY+tdpIA/22gHZ1rY1HbMMoWk/0LjduZLzpR4MEWRNMMRSH+C8QlQ3tZbZhMIq1EIFoIfiPkefyUQ0xKrwXyzdrdRznOJdzA3gvPouNnkcDlcBWSDDgHqu8kiwgr/h7peTEnYSNPDk9311q4UudVvKgImmlr/iD96B4Uk/CUjTUFIG3n8JS3Ddn/QJkRvrHnce6FsBxCPA/MKG+VWclIqVciiSh4Hzp8wDnlaCendrQutUw0EAvh78B5VKZIa2J+INiBVpogfhrtx3iGK6pQYHu0b4en5O7ahK6xIxRhPY8UUjUQmPA1Xsin3x9FFSk+CY7Yy+tMrEF7/RjAOPcOGv/CFn3SGB5GRFWVncQ6/P/kIsL6vfEvATHA0oRJN1UhqZIkxHSdmh8m4VkCYNt3OTRERcJ0Bq/H+pVdhSCaX3aXjTE/ouSL2Jr2/xehxfHVwA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0802MB2426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(136003)(376002)(39850400004)(366004)(396003)(346002)(66476007)(66556008)(66946007)(4326008)(83380400001)(86362001)(44832011)(8936002)(316002)(36756003)(2906002)(5660300002)(8676002)(186003)(6486002)(508600001)(6506007)(2616005)(54906003)(1076003)(38100700002)(52116002)(6512007)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tc5tfbHgnR3N+COHHwAMUrT3kRT5OgZveMkvc1gNkhfY9XUTJAr3cgOSo8uo?=
 =?us-ascii?Q?MkshpzQQI+v5ckaIDU49T0/kzs3iUjtcWgGFsRtAbCbR89epYW13jsxiD/li?=
 =?us-ascii?Q?V/Hfcl1vZqWivadF/YmANUGptTbgQynFOzfkzt9LHUsKYcknIzBnqxUV1qY2?=
 =?us-ascii?Q?8ZT5BhMfsMZ84WBvX2PygagN6cV0Mu1KIyYJGazlzGwRgUiiK7PDuMOzAcjJ?=
 =?us-ascii?Q?qq4VPYVPeHEsLhEAGZ7ESi3rCxpCx/S2ORIascCMoNMQhMpBb+Qpooc+o+8b?=
 =?us-ascii?Q?PhJDRBWKrsld56I3WbsxpUjcWo5qi9zbPEVLal8rT0jDa5RQoKIuJvfEzsZ7?=
 =?us-ascii?Q?NMs7c4pN0HFzgeqIsPc0M7qOC5rs9lUHHefcL1FWRZOQW7AnpbRaylc/+bxy?=
 =?us-ascii?Q?Ad8dQAX4gHZq+We7KDISlFQk+YT49LeYPcGHVb42ak4xwP6LiuG768YXw3F3?=
 =?us-ascii?Q?Vi/1mWeaXFWEU4EXfCNd24WginR1rxfbEr2gLwYe3V08L2df9QTAd9p6mvVb?=
 =?us-ascii?Q?ZyeMeracoULtYe7st70YCQ1Ai0J9ZHF7TXrL79xgHCFCgjORE0HOZXldC74E?=
 =?us-ascii?Q?acIofzyCpDD9T09mIX9MBS3NQ1DRIPlllAhySkGDYUJl4AIIDslBJXOmScdU?=
 =?us-ascii?Q?i2IDFWk/qbHIfdYViZE0LWMXaAsaE3Uku0XPCsGKjjuvaAVxBIZcae507yKh?=
 =?us-ascii?Q?fAX4I81kKuVE41j0A2HFhzLn8cLOhfNHqbMd2PHxCishJBUI729xJxxUe1hv?=
 =?us-ascii?Q?pU5eJIiQJnogwsSaYABewdSmUv947iFRrovl2IeE6/fdOgCwTVG6SuuFlnoz?=
 =?us-ascii?Q?L3oyFPZ+gNeYZNnRweFR+hyvUBi313acgI0EnMwvlbyTQXdOncK9KGj0ac71?=
 =?us-ascii?Q?1zhxAVsv7You43UGFRrvwAqrxzxU9XNv9p21HcblPWkf8bB60ymMf03p4E9Z?=
 =?us-ascii?Q?O//7X6FHgbXRBoPSwZgs6BtiywPyDbzLNMSBva6InqK/Pjv+MH+P8gj64bni?=
 =?us-ascii?Q?tnOcM1oc6B7bF1Z2khY1PxE+h8w5nZSMh8dKNFASF38mrJwDSFaafQfAbPTE?=
 =?us-ascii?Q?wdnfeJ7e8NxExPsGeRDAK1ZVmW8mxr+xgL1p5mRC6Ra2uHIAvuZq+H1cB+Ml?=
 =?us-ascii?Q?RBigr7+zHdt6zCjcHwZgiaVdx69MhlqxXvaBwKpsxIxn2jN72uskljBqzX1d?=
 =?us-ascii?Q?qzUO3xLvNVNOuvskrxhONtWCthBUuF7QIOibg2pQKamZjjg7UNe5M0aQbWHk?=
 =?us-ascii?Q?1kazoRzRqdAn3Yv7Xu1QBfzGa6Mok3mnMVKM5GCofnv0wsJapZvHt7eX6U6e?=
 =?us-ascii?Q?Ab7TYX03rD7wRlXiIp0HQNkngEmto/7DhOBgzy+uPrxNrFz6OgWhkS1y5ouQ?=
 =?us-ascii?Q?dy3DAjHyCDIbQwRqJgCS0GiYhUoT8wQM4eGzeEi2twz6Ov9Sx6c4O+yNdTSn?=
 =?us-ascii?Q?H7/bO+7InxzULmZbGfmwYvuujfTJ4mKfEIhTEAZBBGe8JlnUjo2jIg9OFXX2?=
 =?us-ascii?Q?EbwXn3WGYgkRkCmRnwwp7zs/2EOa4KWcQA37FmoRiV0u97V7qWSHM3vNMzxD?=
 =?us-ascii?Q?Io7AtcFQCywp2bCaU3x4IEkIKuf9U7ILCBrcg9OBXJMHQ11VaCBuL6omeT79?=
 =?us-ascii?Q?9jE54VNVMko0co42qhXHrlWIXRnKV8hj9haq3lbsiwwEIlWpiiUgfWGAmb3K?=
 =?us-ascii?Q?z5L580lCmYGAct1640clD0/cUAZnhvrpRoyKBVnXkMiMMwUSMFawvvK5/jiV?=
 =?us-ascii?Q?sff2vLv8NFGnRRiJ6Isgb6hXcaxoi2o=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b0f871a-73ed-4d96-ddec-08d9f6e87ed2
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0802MB2426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 16:21:07.2104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uEL7Jw100moVQgQwfYo0HhTanza1mGxoBcbwXVyfqoYgR72pooc70AC3tJ8o+OKotxbRXfDSIAzLtDplax/OaDLr0q4eHMikTRz8k08/RQc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7264
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TCS4525 voltage regulator provides the vdd_cpu on the Rockchip
RK3568 EVB1. Add the device tree node and connect it to the CPU
nodes.

Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
---
 .../boot/dts/rockchip/rk3568-evb1-v10.dts     | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts b/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
index bb7177ff92ac..a794a0ea5c70 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
@@ -136,6 +136,22 @@ regulator-state-mem {
 	};
 };
 
+&cpu0 {
+	cpu-supply = <&vdd_cpu>;
+};
+
+&cpu1 {
+	cpu-supply = <&vdd_cpu>;
+};
+
+&cpu2 {
+	cpu-supply = <&vdd_cpu>;
+};
+
+&cpu3 {
+	cpu-supply = <&vdd_cpu>;
+};
+
 &gmac0 {
 	assigned-clocks = <&cru SCLK_GMAC0_RX_TX>, <&cru SCLK_GMAC0>;
 	assigned-clock-parents = <&cru SCLK_GMAC0_RGMII_SPEED>;
@@ -176,6 +192,23 @@ &gpu {
 &i2c0 {
 	status = "okay";
 
+	vdd_cpu: regulator@1c {
+		compatible = "tcs,tcs4525";
+		reg = <0x1c>;
+		fcs,suspend-voltage-selector = <1>;
+		regulator-name = "vdd_cpu";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <800000>;
+		regulator-max-microvolt = <1150000>;
+		regulator-ramp-delay = <2300>;
+		vin-supply = <&vcc5v0_sys>;
+
+		regulator-state-mem {
+			regulator-off-in-suspend;
+		};
+	};
+
 	rk809: pmic@20 {
 		compatible = "rockchip,rk809";
 		reg = <0x20>;
-- 
2.30.2

