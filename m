Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A54CF5A801A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 16:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232236AbiHaOZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 10:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbiHaOYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 10:24:46 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2083.outbound.protection.outlook.com [40.107.21.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104B1D83D4;
        Wed, 31 Aug 2022 07:24:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=THsHitbNnn7BJ+FrM3egEiNMiUK3DX5p1OqDxjR+A6h1J/3b+yGRvLRomcItltOZu8oQFNUOeAiuIMqYPlzxXEvZZVEcFO2tuyKWV5goIc5FXUjL3920zXLWZEfLwacaJ56GmSB4/WLUjgmC3GCezF2VVJADlaqR3K5LV1HIHOE7cJ3Nvu5Vdj0Rt7d9WMlBSlHxWqoeIFyWiFibjCplD89Lh6U+2JQCj0G6zNiVB8nFExA+Sanv6mRVJLfCH46ES6Vn/dSh7oPN26gf5ud8vMXNRCLy8p0kT8hgALzayJ7ZBgKVQ93pCZ1QE8VF5oQaWinl3iaIBVPmD22EYQCpSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=77y+gmLGE6dNiFf+vfo1d8H2kH3tu2PmlGeplUWZhpo=;
 b=MXvnuouMXC4ID8A0td7myay60LB5JMb31ncal/AmFbLRUqZlT8OORvdOGNAFqNdMR4YKGebU7NgZ2tZ13khI+it9jBH/5VcxT13RsNoagK6mejkMR5ia6ehuj+SYbZzt6+MFr/AoDh/STdyGtHLk8SKx2kJKHWceJB9ZzpnmvUi3DC4xY9Qux6AXVvAtvm685zpAP8y+OBGWVBJg/e4JKrs7po60LYIIJXdMtDATbFQTvfHvGgNkZi+Tn8dMj98xGmZ5nNV8Ll6TVKEfPLl/tOzAdwI8Ni4WyCQLDCDZuwmK1G3IoDAs9KFk0DPNdJ54HuiGIK/saVeQxX00P1cJBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=77y+gmLGE6dNiFf+vfo1d8H2kH3tu2PmlGeplUWZhpo=;
 b=BbNsdMMHoX+UjvjggLxcjqMOBj0feFZiRS+2+ejaZEGLwm3IrZjL1KeRXZRc2cSACXSZQbnrGPaY3f5k4kHSfGRiuW2zCayQpxxsOOtL9tOKNER0GhWwSDfjd0vg4zHeaCAvCuovPoste+7zdLyU5U/4pLwBNH0Qx/M9GWf9kr4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB7083.eurprd04.prod.outlook.com (2603:10a6:10:121::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.19; Wed, 31 Aug
 2022 14:24:33 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7%5]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 14:24:33 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 4/6] arm64: dts: imx8ulp: add pmu node
Date:   Wed, 31 Aug 2022 22:25:50 +0800
Message-Id: <20220831142552.43393-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220831142552.43393-1-peng.fan@oss.nxp.com>
References: <20220831142552.43393-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0021.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb665ab2-31d4-4458-1d8c-08da8b5c85dd
X-MS-TrafficTypeDiagnostic: DB8PR04MB7083:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y+MLte6CnQSfGtULpA/nBtBBnpoiCTwJ+aFkZHQxRkm2CqL9Z5cKKywMJLq0iFz98oL54YaU79g59XwJRLXx2B9bm9orcymtOblV+IHXgqKhC3t+mPTLjYgYn84Jt+Sa+H3RIGX4f2tdmV97IsgcRsSuvgHfPV2sOcxr28njeKTNy+KGGA4JsZBXg9V6UA1MRZK4fbiUbQGvIL/yk5UkoY4iNzyrzhAqZyvQZwLvlyn0mQCE+uJgSQ7IutsUJO+oYX7i3XoP3wQVZqnbmWylRq88Regt4iBFtrJMZuGgUb3mYte3cZljgn9bdCb2QhdBjN+Ddc2BjzvIRJNH6JdI0h+Oagbh82tFDCCqR/J9/QI7EbbiuxEtVjlx8p+rx/FMwl+oUvU2HrnaoWwnN6JlxuO8/NfsST0v0U4GaSv5cvoeJ3Bp1QTjKtdwrsLwEPYe9/uPGZWDH8YOgdx2CLwrN7+Ef0kxQftilq5pssCHTRl/wIlH74HbCie9lbbSZ5FDy79FP6OK4srLEqj9kQvcBVKrUOQVKSjgiwDH+u8KGYMKmSCRwIa7WV0gOr5tbMRTHyB3FDgYXfFyx0Nos1XKwh+TuDAnDY7bAWXTbG+tH4AMJoMAJVVmKtI2PfC4VREFELHP548mibLTXvmThoOE7YrMDJF9Lcv3bWx5uUuNXrtd+axS7011T3I0GkRHpu5Zv12Zd2eqTskdQKbakP52mT1X6sJb8Y0Xe3xrOpPEqlV7nh6zVqDUAmQWTDUooDUfmMiUTYi1na4AVSnWkpNvSq+KwK1vnyAVF7C7d33RV4Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(346002)(136003)(366004)(396003)(86362001)(5660300002)(2906002)(66946007)(66556008)(4744005)(66476007)(38100700002)(38350700002)(8936002)(316002)(8676002)(4326008)(26005)(52116002)(1076003)(6512007)(2616005)(6666004)(6486002)(186003)(478600001)(41300700001)(6506007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/EKi18NcuTdisQ8TZ5HTyGyX3lshWV2/M1Kd4rup+szGMrHG67iq/hsImavw?=
 =?us-ascii?Q?obnXLeNpousHEz4nq1g0AlPzP7sg5lOD3hO6dptCmelmyZXTvZTwkRAWhF/B?=
 =?us-ascii?Q?z+WWtLXBnNTWzqE0LIyRCFF5HasIw/nEwBzIN9XI14N998GkhyW4p+8OQVmD?=
 =?us-ascii?Q?8tmBEMAWTBjmXpQOsVNhW8Fl7q9+nbJgZfwl0jOXRizffemJ0XfxseglIm/T?=
 =?us-ascii?Q?GDi4A8wgu0hlU9beiJAmpg3XJhyQLF9r6ZYD/OMAatY0uAr4fAmyRwzHJBDb?=
 =?us-ascii?Q?U4caOO+exNjLLUWRgjsE7p5G1qDOuh1eNA3bsPUzeTfFNMeRWutknTcbgCNy?=
 =?us-ascii?Q?POf5iQGEz8jtLzSIDrxCQRGWPPYYtyS1iibZz02lRF7DT3XIIM3P1Jitrl7B?=
 =?us-ascii?Q?57Ib3Vl8f9zYD9pfdmK6rFxPicgSxtwvSXnQNP0Abckql+t2EyhKPbc6ev3N?=
 =?us-ascii?Q?66g0Hkj0wj7Mb4SXq+cKZyaCmk4eShtbq6XXC9h5WYFyPHG6uHQW8zDncOo/?=
 =?us-ascii?Q?2IQIaETE7FcybQ3r5tekcYOAoqP8a+SNaPmOIeFHItPQsavxz29b0TGQXo5A?=
 =?us-ascii?Q?fiiO9qLOVHhc/CGO/LAIGW3TrCZ91zIN1BUFQB3hZQekPUIFLHpH11kxzg/m?=
 =?us-ascii?Q?rTNNpax78qJrX50WtxizlCpYprnJYsntNk57KpYvE0xmuEARNZEMxdVrkZlf?=
 =?us-ascii?Q?OOu/RoB/ifcr7tVirzWd3qgRwjB/nj8uc+zxc2z/F7KMsZirgDLmQGu0YqGt?=
 =?us-ascii?Q?TDcioYizMJO+kJWrNd2g2+LHJK/DEsp6d52X0Qve2M5qod7sOYonKINXdcJf?=
 =?us-ascii?Q?422q0ambV7eDGre0WNsFw7ehqDAH7RGBDRIMsKflOYDVo0cMEYwJf6zLD0I/?=
 =?us-ascii?Q?PiJuitJ4kvndJxuHVAJPs4EhuonmLzUuDPabATDsdcitLqx4B7e36z52OavU?=
 =?us-ascii?Q?ietqr5jPwM6krRf8+k79oJ4uK5oZPZkeJlcDIEmrUGB2/QNnK5veZw8VE1Lj?=
 =?us-ascii?Q?E0Egcs2tbiqss9bWvLKIFZPkSvH+VZi5I7geNVGz+ZieEwEBfowoK5MiAPNG?=
 =?us-ascii?Q?Ix7hI3R2VhP6Hz/lKpTkWvX0RmCoCsgz6vHJJ+rNSTA+O68j1dar4o3uodcF?=
 =?us-ascii?Q?0CK/amkW4bRlYnWgCthhmNV6zUytRfk/9AyMP48QM2bLHJaaowc1V4eW3jRF?=
 =?us-ascii?Q?17p2X3ojgBPby8zNwHExQxSYQE5s4KH0iihLm+T/CAwld8A2FkXOSCoc38/O?=
 =?us-ascii?Q?or1nhXfO0Rk4CLJh7PrNadRQsVye8nAqSv3mpGIElgeCnnKpPVl+O5DAl0XB?=
 =?us-ascii?Q?d9CxQZdEl9ul3Nt/YiqXkRN4lzUEh2DYGWqMtyNK9cnxqMY513FQxQ6MhK6/?=
 =?us-ascii?Q?mYb/DskP2a1K3VDbLQSjOgO+VLkTPFmMc9qaeg7yYQx/bhwytfEgIHc1vnAK?=
 =?us-ascii?Q?ZDBT+Zr2P5My+aYckd0CiIBNBYBWTPvMKRYZWNm0H6toiNXGyiocIHzVTOPI?=
 =?us-ascii?Q?7Ig1HWS3vCvx+u9zy4i+UGVpHVVe6soMNTtZ1Ms+Mdcx/qFN5WrAqQVPzefN?=
 =?us-ascii?Q?8gkcg/uRA4ZL2KSla1qUJpPWpI2fy/im7gcCXjMN?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb665ab2-31d4-4458-1d8c-08da8b5c85dd
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 14:24:32.8877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1+vicCBar0o7At1b0S5OwWtegtBUklUzqGpsiXBTK5tJIcz9IJQsUSP2DQZKCW4HN1ldIhSy6D5V3OFiOpYfdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7083
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX8ULP pmu node

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
index 88bb30384024..abec8ad4a8de 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
@@ -63,6 +63,14 @@ gic: interrupt-controller@2d400000 {
 		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
+	pmu {
+		compatible = "arm,cortex-a35-pmu";
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_PPI 7
+			     (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
+		interrupt-affinity = <&A35_0>, <&A35_1>;
+	};
+
 	psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
-- 
2.37.1

