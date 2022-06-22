Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2840D5542A5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 08:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238552AbiFVGTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 02:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350028AbiFVGSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 02:18:53 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150055.outbound.protection.outlook.com [40.107.15.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35AF5DE1;
        Tue, 21 Jun 2022 23:18:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K76qgDslL4XTW5DgM4+0LRa3LGI3LKvb7O/vaoLHieU4fqh7iUZI1uaU3Uc+EiGQha8Y5xM5FM10V7jz+QnMjIte7zVfjG6ZvOEr26JZeW5ilJNcPmLYxuU0sux3bPLcEH85lLulFxga00jL4Ju7OSpRELTYTNSBnZq3L4dpLzeYNK5+jfP068x7zwm5Dlt+RmYS/09PoBELbyRc6jKLHVFhTHS3NhB2rnX+CFVXskcNVts2bk7K9J/ZM502RsMBHWZ9uQXZoIZpbzIb6L/yPnJ2Gvm+v1tPCA3ZWZy5hrG0EivSXH4KJVrQCKlcJhaq51Y1E8lF6C89pxwT0SuD8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gz8xaWycSEc+yUv62OGEkWgKdTuIcjoTv3C5N0S8TjY=;
 b=D7JaWQ41MrDPoGrcp0Ghm1yQCheh0P2XKfpyBHcyLDQFup8+OWjsFHuqpVjCESdrDLbDeZ/pWO52GsVankmav4m/gYXPDYCj+nMRN+WGtrlR8wcjKM2yUBwbzQaCwSwAP0XbJNPUZbVTwiDsgpMCFyW+ugvtWBJ1laYODkR5WzgvJfSlfkjxvOFwcU2myjISoWwm5rC++TaZuguP6gWSCCYipxs0qAg4ERq3aiIh/thelOmrHlHOwOw5lRjEB2o5S/6JWGqR5StrcZocuWbwuVykwHXqXWJ+8AHu8Ol5i8sjf1Q/2A7DmzYmXCYP28dj5ubZQ/6oZmghEp/W62F6Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gz8xaWycSEc+yUv62OGEkWgKdTuIcjoTv3C5N0S8TjY=;
 b=Sw1EVy7JvFviWSkfUDZuU7roAXKG9Qv8VjGGJk8LPkcZXF1Y05HHDV4AwqKylmAwmSgxY+9m52km0iopLoV3KbKD1v7LMzuZynG3bfZ1N/TgwO2BuJVVhGZmM0HsTDPJHsRas7Nj3QrosulO7DIoPRf8b/vMbu2JnoombF35asc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU0PR04MB9252.eurprd04.prod.outlook.com (2603:10a6:10:353::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.22; Wed, 22 Jun
 2022 06:18:49 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::71af:d414:52be:d531]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::71af:d414:52be:d531%6]) with mapi id 15.20.5353.022; Wed, 22 Jun 2022
 06:18:49 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     festevam@gmail.com, linux-imx@nxp.com, hvilleneuve@dimonoff.com,
        l.stach@pengutronix.de, abbaraju.manojsai@amarulasolutions.com,
        jagan@amarulasolutions.com, matteo.lisi@engicam.com,
        tharvey@gateworks.com, t.remmet@phytec.de,
        u.kleine-koenig@pengutronix.de, t.remmet@phytec.deh,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] arm64: dts: imx8mp: drop dmas property for uart console
Date:   Wed, 22 Jun 2022 14:20:27 +0800
Message-Id: <20220622062027.994614-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0166.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::22) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2711d2e4-6be1-446e-3e81-08da54171231
X-MS-TrafficTypeDiagnostic: DU0PR04MB9252:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Antispam-PRVS: <DU0PR04MB925200B79866602B1F6E95ABC9B29@DU0PR04MB9252.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e99/CqQzm09g/3hcQ5dC/sLzlwNk+ZXaQy9BTVMaiqiDTKQ5zRqjgA8hpL/BdbtUvb54e2vvuy3jkghI9EcqZEUqPb84hTugqFGH7Tk2fLySojrWhLDR3bZuWL9nmJUOl8zpNU3PCMn6AnZQKe50V58j3R0QkBbPpc2JjEdgQNf/+MICfGs8umy0y5FBPygwXsmkiUzESx34Fp4VsN7d0/Ng16xo7v9Rpz9ZuE3QkWPJzYy6drsxrUWB2cSJK6hxuoTZSlIY7b7+J0b0OPJagT9mKRI7IvxgdXrHCiE0kJX5UpAc+rXrcOIJ8l96wE+WFOt3MPh6lSqpEHxNzbB+9tKSehq5+Btn2e8ldd+OP3q1KfJJuYQyADwGdTrlpcMuLb6SPg3xkTfQ9Dge+nQlXOMqZGWy7wBeIOi+X3uxkizynnhpxcWfeL4cczzqmUbSgCsrV/EqsagNfIlSlpXAMT4o/WRDaQ34+HeRY7Dk2y4dcTpfxu6XuOoG9CQjUUb/gjGe4zChL89dXzA4l4MA0lt3zGDnMp1yNNBDx2joV2144allW1TJCzCqi6uOEeU5/8I8hLgC3b5mkjpyfu7de0zzurw0nLmDfilONRpDH/qHDF7LgsRo/tDaz81rtRuUqe89Le3Hf8Xcamm9gRGwdoRRg2TQy7GQpLILKvZecPNqcfV3L+SsO+G6coeQGZdN/e2/S/71aGdKtY3lU43SQlco12bMgUa0itLSaDu8rh8VI4ggUR82DnfVk0ncHEHGpBdID/PuFK/P9WT1uo64gbU/rulBEIdUgriA1Cr+AJk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(376002)(366004)(346002)(136003)(4326008)(478600001)(86362001)(8676002)(66556008)(7416002)(66476007)(6486002)(66946007)(6666004)(316002)(186003)(83380400001)(38100700002)(1076003)(6512007)(6506007)(26005)(52116002)(41300700001)(2616005)(2906002)(8936002)(5660300002)(38350700002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mdL9CEpFymNurAUmIk+tSXVNSXsXGwHt5YwgF6qrSg/0AXfav55ptpDp+U2L?=
 =?us-ascii?Q?QKjsZxF8/kDA2Sheac3Xoqxr180Z1SxeatHP7zsrd5OffrB9aZhpvWyxw4Q0?=
 =?us-ascii?Q?oq1epAuHYjo+U2vW0Ld+cK5fUUeUdq+HJRy3hTBtBc6DVvPH7UFliJZNfRY9?=
 =?us-ascii?Q?fdtcPPLXoGo42nEKHfdZg6gU6qrnvnl9+7nIyeZf/YRCB/uNcSbTJd0u9VRM?=
 =?us-ascii?Q?jLtL0kiy8SD6JQrWBwLIkkolSv2jwr3rIPk6QdIoL7OBQIlYcL1M/dZbojZM?=
 =?us-ascii?Q?aoZEgaUt8exMUqdF9JFUm1xLC9WsUT3ES+6K93tBzcXRgfJgi+OPbivmklKP?=
 =?us-ascii?Q?uUDHSkw4nHPgFwvuzGgKnX/lKjcUNayEPyv9Ew2iV0e7gqXdOAfJd7vfF0kE?=
 =?us-ascii?Q?34XSuvDqv8pPTB4ZgFicsD8SXfmazqEvLQDuOPr1KDm9RM23ZbjhbVBq47A6?=
 =?us-ascii?Q?dBKJYOW+nl+Ma0sgfLoYmuc0NZSlE2zwyjoHWdV9rm4CGq1blIRQPqyYO4Lq?=
 =?us-ascii?Q?jLOGqZOBwf62g0k6R5f8/jo62F89T0GSIrdTH7uC3fUyLZnudvxWAPv6DI1c?=
 =?us-ascii?Q?VK5a4T2o4Z3MC/rsWeP3xMIoe5OCOqEGUEbOee9y/Qm/tx8pL3n/ER5rDz2D?=
 =?us-ascii?Q?E7044c+ku2gVTnRUqlm4amzM/AFA2B2kEeM96yUQTYWl0UTDFy7vb+QSCP35?=
 =?us-ascii?Q?YIgA6IxRIHAt9i7jWzBliVd9lbPdYUY2xjgw2gapzupl0FRCzh6coGj4HjCx?=
 =?us-ascii?Q?5pC+CUq7W/u+wpw5jH/sRl543/FMUIb9k0DViCLyCILodSA8cHd0EKlgchW7?=
 =?us-ascii?Q?j5AvkYcmyRGUd1pY6XkoPKXciKUyC5tJkaghmdZzXudKYYdnzBm5DXxd8F12?=
 =?us-ascii?Q?a//yIyLxdt0Uh/HuR64VlNR7VTMujTtUOdufCS66L9w7A8iIA5z2J/+/x5Vu?=
 =?us-ascii?Q?ddBS7cCshdVqmZHI82eViWPupiwZJKUtXEs5ef0Imb2pIByBrsFq4Lb5F5Qq?=
 =?us-ascii?Q?zwmTE39whOvvOdtVRGvOII5qM32hVRXHZ5ow+BajdQG+Fafg1ZYha3axF6tE?=
 =?us-ascii?Q?MNyhKXPoKAl91fXmWBHDbDuZLCgQH6HizBMaXpEyCtIGsl2LlsrwFZQMRReC?=
 =?us-ascii?Q?NaeuCfTywfYN+SNZ55fhxJTaSWyVTGW26abxKWODdxUkoXrusfBIrQOF7SN3?=
 =?us-ascii?Q?9rhkd4OeGyU/xFM1z369SUaJE70ejRsW3IoKx58pS6wGN8BHyCb/sH+d/nag?=
 =?us-ascii?Q?lxxpjKjr0LZmVEkMVpb7ogRe91C/u0OzZ/OdoZOvMq3jbdOXyz8pPpv2/TsO?=
 =?us-ascii?Q?sjGwWHSc8IXvN/VoHtwqdsa2iu7UnHWkERty0WMSi2zGrsXepm23X98b7UVY?=
 =?us-ascii?Q?ngHnwlfslnJZ45FkbNOC9z5fdWCNUHiOGpdPoWWWgF40UOFHnnvcMD/GD22t?=
 =?us-ascii?Q?8XAjWVMJxdfC92gg1O5i80C5yu2aoU6cxRUSE7xWpDX9fGzRH+XIpXTY2x0K?=
 =?us-ascii?Q?yDIdO8hXgQ2vJiBck7PomAxnK/r6BbzmNh6Gu8FgC1lc1aqCZqCsEEiiRki/?=
 =?us-ascii?Q?CuB3smjTsBuInpFk1q7lEbpdMJa0Zr068QHLOverHYY3CPgEBTpok2aGmO47?=
 =?us-ascii?Q?sdWLig2M7BTDqKsJDPMCSKiBb7ekZVbD862Lv1wqr47wohGO8MLGJtzSyOfa?=
 =?us-ascii?Q?KQRlXybU4AP6caCqjztIWKghU8RtOF3615NAr+yadbbKspIcacR3OYbGdpCk?=
 =?us-ascii?Q?Dsvktm+k1g=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2711d2e4-6be1-446e-3e81-08da54171231
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 06:18:49.4263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c7lacO2GsG+EkS7fTMT8vLeBeomaUiNhZ6K7E7encM8k4jbX1Mt49lOCQyQ1kMGm7RRzjQT7y+X4NPiEjHApCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9252
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Commit 71066545b48e4("driver core: Set fw_devlink.strict=1 by default")
default set fw_devlink to true. This has a side effect to i.MX uart
console. The sdma will make the i.MX8MP uart driver defer probe for some
time (~10s with i.MX8MP-EVK board) until sdma ready, because sdma is a
supplier with property dmas set in device tree node.

Since this uart is for console, we need log printed out as soon as
possible, so remove the dmas property for the uart console node.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V1:
 The upper set fw_devlink.strict=1 patch is in linux-next tree.

 arch/arm64/boot/dts/freescale/imx8mp-evk.dts                  | 2 ++
 arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp-edimm2.2.dts | 2 ++
 arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts  | 2 ++
 arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts        | 2 ++
 4 files changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index fb11c03bc8b1..3fdb38bc0069 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -359,6 +359,8 @@ &uart2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart2>;
 	status = "okay";
+	/delete-property/ dmas;
+	/delete-property/ dma-names;
 };
 
 &usb3_phy1 {
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp-edimm2.2.dts b/arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp-edimm2.2.dts
index dd703b6a5e17..fb2b44e94482 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp-edimm2.2.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp-edimm2.2.dts
@@ -69,6 +69,8 @@ &uart2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart2>;
 	status = "okay";
+	/delete-property/ dmas;
+	/delete-property/ dma-names;
 };
 
 &usb3_phy0 {
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
index 6aa720bafe28..68a478151292 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
@@ -99,6 +99,8 @@ &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1>;
 	status = "okay";
+	/delete-property/ dmas;
+	/delete-property/ dma-names;
 };
 
 /* SD-Card */
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
index 521215520a0f..f90c1ac2791c 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
@@ -554,6 +554,8 @@ &uart2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart2>;
 	status = "okay";
+	/delete-property/ dmas;
+	/delete-property/ dma-names;
 };
 
 &uart4 {
-- 
2.25.1

