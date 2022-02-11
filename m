Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2176A4B1B93
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 02:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347061AbiBKBoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 20:44:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346982AbiBKBoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 20:44:21 -0500
Received: from APC01-HK2-obe.outbound.protection.outlook.com (mail-eopbgr1300100.outbound.protection.outlook.com [40.107.130.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5EA5F9D;
        Thu, 10 Feb 2022 17:44:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nNJtwIe2JHpi79FQ5OG7cm8fkiwLuoY4Tsqs5bynw6CvlAYb0u2+8JQYAiM52PDGUPPxshcY8SjqCYFK6BM1UieACn7AVTyybdx0Ic7FV+sruXMQqMYVtJvsb6qGTMXkdTE45lljGl2jvkuslXjA9OqxGd23edsYr8KO1SGnFDjtRsJKM7d4o1eZmmw2EtZhe+o+QXTrlFJCldrlxcMfpQkFBpvirLHWPUSDTL3yQMfMdF0IlVhNICdcaZWJ2kT90ai29UqdIRgOhJzPFI+RcnWsdO3iaOUOcoWC5K3WzQkIoGwUu0nwk8q3NMK9wvJh7qgEZ39zvM2VT+hsIq/6pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QRvFQ7lCwiX8nBe9hFQbKw9ddkl0U+5j90hDCU8eHCU=;
 b=HiOw3oS6XFRFOfhTLLEUR1Nx9XKqa22MZI2MWhXfyAzfl4XhlGUGiboD+xdv13GaqG3xDCp0NZd7I4g2MLz0sl7eEioH/lwoEohvsgsbAIewOvMEHc4xkMJ2wlWfrljHXpdTieL5tiip0tqtSEPuKjZWjc1kZEE+0mCFalxwDlQVQXD+OrnUjBY42K8TyIp9uqTW4rDLIbgaoNWY/SjJJ26Z6TwGfZoBV1b/8mr6PGuqrQ3aoZMqz5X04D+NRCIdunNYL3gg6OLoSbaTjtdt/iHkE9PSLnrzMjcPraRTFWIikv6Fem3/DkRiMXnhUgyn7jPuqvW3iuBv1D6KKDbtow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quantacorp.onmicrosoft.com; s=selector2-quantacorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QRvFQ7lCwiX8nBe9hFQbKw9ddkl0U+5j90hDCU8eHCU=;
 b=1CLXHPVLbhKH67TFtOtMPf7sM2OJQjPMs/dfqZfVYQ7NNoflpXC7lWl3Y9fu1+P4CnVDCo6zoi4WetZmbRKUI6WfqeY0+CvOep3e6+5elGK3MvqxcXfEECFPjTba8HZpL1At6nhQmiYFjs+B1AtGEPopuVBYSpxVfNT37N/Gnh8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quantatw.com;
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com (2603:1096:203:89::17)
 by SG2PR04MB3577.apcprd04.prod.outlook.com (2603:1096:4:9e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Fri, 11 Feb
 2022 01:44:17 +0000
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::8160:1a0:97e1:9e53]) by HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::8160:1a0:97e1:9e53%3]) with mapi id 15.20.4951.019; Fri, 11 Feb 2022
 01:44:16 +0000
From:   Potin Lai <potin.lai@quantatw.com>
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>
Cc:     Patrick Williams <patrick@stwcx.xyz>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Potin Lai <potin.lai@quantatw.com>
Subject: [PATCH 06/10] arch: arm: dts: bletchley: add interrupt support for sled io expander
Date:   Fri, 11 Feb 2022 09:43:43 +0800
Message-Id: <20220211014347.24841-7-potin.lai@quantatw.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220211014347.24841-1-potin.lai@quantatw.com>
References: <20220211014347.24841-1-potin.lai@quantatw.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0143.apcprd02.prod.outlook.com
 (2603:1096:202:16::27) To HK0PR04MB3282.apcprd04.prod.outlook.com
 (2603:1096:203:89::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ba8de40-460c-4dfc-a45a-08d9ed00030b
X-MS-TrafficTypeDiagnostic: SG2PR04MB3577:EE_
X-Microsoft-Antispam-PRVS: <SG2PR04MB35772F1EEB0E4EE5135C874B8E309@SG2PR04MB3577.apcprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m+l0PoCkOk1VBlxP6dDg7Ho4BljOywYhekUWsmQsn7tSlWHvP+qZp30ytQJK0HaPHsN+7hK2IyDhsOC5jynHtWBJCfB2U49akmwe0VoNuNqMQ0EultXHS5z1lA1Ug2pfuAqzcUApXqrfiIT2X3zMCttM1pUQRyMN7pBMioLrW00P/yDdKoZLzj0U15gfPLbZAtbg1J5VhV0rckMKdpx2wZozCwkLPruKnU/Ttdv1cd62X+7Hn7meBRRoqUvbW0CtWbHqLPpXyvwqpatEMOR/pTFh92PMfjsmQax3YW4sKQMgAc1xuek4rUQlG4+hq0pSP/Zh4aS1dCp6m/QqlBGPuashvU1e0ue+xbil4NJ75XcHr18pa46KjGOmQagPe/HSqTvg77/rjC9Pa5wOihen5UsHW+Vp6evWLQy3Sn8JHA+Qz7wI9FBhPSI1D0uQ3HQ1tXf7Gibvv4uuonmu9+yM+VsgyuCNJOKVFxXUZ4ztvg5roF6EY+hceVpigrA51KljUAtRsyiiscozLpW7k9XCsIw/QfFySLnfUbtBJrn5TDjmBO1uUXHGsJox66hgN6Gcjs4eHLrecBscHP5PXumILwf693400UZ8qvScSTB7s2Vx6m8AVMCZdR+BXbL8XL1P2eDbCZAF7IzgLtwTeKmRf4xTp7iT00xqlgJwFh5u5jZPIbFuu/J/Dzw+Tbvob1BHG3nVT9Yj3JfoW8Qqe36obQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR04MB3282.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(110136005)(107886003)(86362001)(54906003)(8936002)(8676002)(66476007)(66556008)(316002)(66946007)(186003)(38350700002)(2906002)(2616005)(1076003)(38100700002)(6486002)(508600001)(26005)(6506007)(6512007)(52116002)(44832011)(83380400001)(6666004)(36756003)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AxIdwInohMXMZZwP+WX7eC+jcE7/3DIbslZRj9tFnQQ+FfvTdYC8O65WQg4D?=
 =?us-ascii?Q?aPaWZz80wNlkKbHKtY59T2M2TBp3qxUB35FDnD328NfDFHKxBSbTu6GO/W0C?=
 =?us-ascii?Q?yX9u9fOpgu81xG9tfRR+ZM0zbmH3eLB++ATLxWTnK0T25U2MFAM1TFG8O0Tq?=
 =?us-ascii?Q?oQe7NlMSi5i+P6Q04pE+7zwU3ZNCgFBoivOL/1Xb2+MtWQg4kLx620zJy3yQ?=
 =?us-ascii?Q?pQA1TcRw1z3dIqj0Det2WlqZjGkaWkRonfyl1mpekBlBghEN49XUzV/h1z3X?=
 =?us-ascii?Q?t9J+HxZyBk/6C08hBdXwtoJeBv0f0OCBYDYLTjQ1TeajFi67WV2gAXVwCcAd?=
 =?us-ascii?Q?l6vLiknQ/qTdNbSz4U5MfDRBx0uD0d9rESIcuDzvQZZ7oCwzuc6Y/fjw0rj/?=
 =?us-ascii?Q?r8pCtbsYyWwIj4pSdoHO7wdK3je9RE6Y7IgmsMWVtwet7jY3nxYy7eQ6nHnp?=
 =?us-ascii?Q?6h6g7SqDXbB208j0DRetS4wb/w18uMuhHuDO1poDsA49ZoREfor9VMoGGgkh?=
 =?us-ascii?Q?VGyc/tFPwAYIc0KEF3OKddMeaWnpBU7kRG8vEyrTOgwS+Yqbbryc5481qBsI?=
 =?us-ascii?Q?zrucvTuoQdFgzSinHHztvpaYTwgQ0OYBviYFbUQUSjqt48U3zaazdQ9Yq5wr?=
 =?us-ascii?Q?+I/XTFDU7sAZI0Rq22mBoj6r5Ldow7bxU6t/J0GN6VCU5gdxhxpPS63r/JX+?=
 =?us-ascii?Q?A6zBwKx8nd5mKAjLg9ehKIf4HZkW3t93XhUF8v0nuucpnUZ39bdrCnB7Kf99?=
 =?us-ascii?Q?nwBX8aYwmYcqLGJaNayyhSMaZPqP2G0L4SEotXzMBOPGZdYRLvNFrHpKVF58?=
 =?us-ascii?Q?EqydzDY6wZOGeuAg1IYQpCzBknfvHowZ6AvRy1enfaRAoLjOHS28jXpGLpdt?=
 =?us-ascii?Q?MsQ7ENOk1n1RKfnwid7CgQkxG29CSKLh4STfXkFsXtrrIqaVgSPHfB0HQ6kP?=
 =?us-ascii?Q?2tACYSyiUEB1fsZ3ljzyYs3bTglxfvRFJIS9D6oA3mFd6XLjzJ5Xbni0Nzcy?=
 =?us-ascii?Q?G7IJE5gDxZcBPZIJroC/hrUxGWERBbUR/2fkZ1YCK9q80UbI+AdpSBavGBc/?=
 =?us-ascii?Q?O9WGZ/jEMn3AN+vkc35dBiod9laYt5gDqPyFbwahMHhSBVHKmwyCuEpU1Gk3?=
 =?us-ascii?Q?+jJNZgMD7PSNDGiSQaGLJhT7fnYskalY+IM2OBVHhKqAc9xhMsI8xL0DIPG5?=
 =?us-ascii?Q?kmGWxExFEAyOR4bUx7xzjyj5ClzOe2T16FkSB3EPawAp4elqxExBL5CUQoTu?=
 =?us-ascii?Q?yaW/zUyaGg0HCVCzEze3wyoAddIXSk+Cs7xNl93h9v7mPIWi94DXW+XNv4gB?=
 =?us-ascii?Q?rlPfSc2NOZRKGUpN355hg8LkHEyqM+r4XuNDTe+pfp+LbzmyDzgfLsk0nIO6?=
 =?us-ascii?Q?PSL+9WiVteoN9fcbn8ye6++um0mDl7STzlu0OrUXL1aYt67bDeYjoyPcgtOq?=
 =?us-ascii?Q?flcbSV1uoBM4ano3OWcNH6lL8fT10cGWwYybamN3afxnTd27CawEf7jPlY2R?=
 =?us-ascii?Q?FsOzfWoScQjHeO6zK/kn5ajR/qZP3OhIcBrk92uq6/NDXBuMsH65/LhJKOA+?=
 =?us-ascii?Q?RvW2nYapmdm5EJ5RSo773ptXejCY91zB+2HHLf815oh7feajmXGwr4HIlgsS?=
 =?us-ascii?Q?14lH5cv0ZH/OEUOsr1gy7Po=3D?=
X-OriginatorOrg: quantatw.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ba8de40-460c-4dfc-a45a-08d9ed00030b
X-MS-Exchange-CrossTenant-AuthSource: HK0PR04MB3282.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 01:44:15.7450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 179b0327-07fc-4973-ac73-8de7313561b2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CBRCSZazJlA6KUH/0Fv9zTqTJL0nIxCnT/c5OAdaCltmIEsaGYE40eyBhHBtHoUKMw4rIL751ZBnkt4xlKeOow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR04MB3577
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable interrupt support for all sledx_ioexp, so userspace can monitor
gpio from io expander by interrupt

Signed-off-by: Potin Lai <potin.lai@quantatw.com>
---
 .../dts/aspeed-bmc-facebook-bletchley.dts     | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
index 3c54e4a892c9..8afaa8f52c38 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
@@ -6,6 +6,7 @@
 #include <dt-bindings/gpio/aspeed-gpio.h>
 #include <dt-bindings/usb/pd.h>
 #include <dt-bindings/leds/leds-pca955x.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	model = "Facebook Bletchley BMC";
@@ -268,6 +269,9 @@
 		gpio-controller;
 		#gpio-cells = <2>;
 
+		interrupt-parent = <&gpio0>;
+		interrupts = <ASPEED_GPIO(M, 0) IRQ_TYPE_LEVEL_LOW>;
+
 		gpio-line-names =
 		"SLED1_MS_DETECT1","SLED1_VBUS_BMC_EN","SLED1_INA230_ALERT","SLED1_P12V_STBY_ALERT",
 		"SLED1_SSD_ALERT","SLED1_MS_DETECT0","SLED1_RST_CCG5","SLED1_FUSB302_INT",
@@ -331,6 +335,9 @@
 		gpio-controller;
 		#gpio-cells = <2>;
 
+		interrupt-parent = <&gpio0>;
+		interrupts = <ASPEED_GPIO(M, 1) IRQ_TYPE_LEVEL_LOW>;
+
 		gpio-line-names =
 		"SLED2_MS_DETECT1","SLED2_VBUS_BMC_EN","SLED2_INA230_ALERT","SLED2_P12V_STBY_ALERT",
 		"SLED2_SSD_ALERT","SLED2_MS_DETECT0","SLED2_RST_CCG5","SLED2_FUSB302_INT",
@@ -398,6 +405,9 @@
 		gpio-controller;
 		#gpio-cells = <2>;
 
+		interrupt-parent = <&gpio0>;
+		interrupts = <ASPEED_GPIO(M, 2) IRQ_TYPE_LEVEL_LOW>;
+
 		gpio-line-names =
 		"SLED3_MS_DETECT1","SLED3_VBUS_BMC_EN","SLED3_INA230_ALERT","SLED3_P12V_STBY_ALERT",
 		"SLED3_SSD_ALERT","SLED3_MS_DETECT0","SLED3_RST_CCG5","SLED3_FUSB302_INT",
@@ -461,6 +471,9 @@
 		gpio-controller;
 		#gpio-cells = <2>;
 
+		interrupt-parent = <&gpio0>;
+		interrupts = <ASPEED_GPIO(M, 3) IRQ_TYPE_LEVEL_LOW>;
+
 		gpio-line-names =
 		"SLED4_MS_DETECT1","SLED4_VBUS_BMC_EN","SLED4_INA230_ALERT","SLED4_P12V_STBY_ALERT",
 		"SLED4_SSD_ALERT","SLED4_MS_DETECT0","SLED4_RST_CCG5","SLED4_FUSB302_INT",
@@ -524,6 +537,9 @@
 		gpio-controller;
 		#gpio-cells = <2>;
 
+		interrupt-parent = <&gpio0>;
+		interrupts = <ASPEED_GPIO(M, 4) IRQ_TYPE_LEVEL_LOW>;
+
 		gpio-line-names =
 		"SLED5_MS_DETECT1","SLED5_VBUS_BMC_EN","SLED5_INA230_ALERT","SLED5_P12V_STBY_ALERT",
 		"SLED5_SSD_ALERT","SLED5_MS_DETECT0","SLED5_RST_CCG5","SLED5_FUSB302_INT",
@@ -587,6 +603,9 @@
 		gpio-controller;
 		#gpio-cells = <2>;
 
+		interrupt-parent = <&gpio0>;
+		interrupts = <ASPEED_GPIO(M, 5) IRQ_TYPE_LEVEL_LOW>;
+
 		gpio-line-names =
 		"SLED6_MS_DETECT1","SLED6_VBUS_BMC_EN","SLED6_INA230_ALERT","SLED6_P12V_STBY_ALERT",
 		"SLED6_SSD_ALERT","SLED6_MS_DETECT0","SLED6_RST_CCG5","SLED6_FUSB302_INT",
-- 
2.17.1

