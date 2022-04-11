Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2FC54FB71A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 11:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344284AbiDKJOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 05:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344279AbiDKJOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 05:14:48 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130080.outbound.protection.outlook.com [40.107.13.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCF73FBC3;
        Mon, 11 Apr 2022 02:12:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eEujw2/xhGm15bVNMH6VpxaWFHWJtHrVi9npBzQtVXfbpjUc0DJBYdyNMaVyBgpFfLA6QBTNmpRJyFnRLc21YVAK9CHjvE3SHHnPzryBPB0xLZD/vbxaw9oWGgNPExfhpSe77HB3E7+e12sK5Giy7dybfx5xq2t0TWQlC0ZqBHVNDrL6ZJVl/nPqRi4l0T/K32g5bN3xUdFu9UK2+IEYL9plAt/nMcdYCZ3DIkkebCXbTuE4c/6OX71SgwYAa6PzDd2kfZFPVVaPSAcV69k3QsYkP7hf5bn8QZu5+ULHgHSxI1P9ULuQ2PMlxdCfF6PtBBTOjM4Lz5pdTeTN0ebacQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ayU00ONamsuGVWob2lfQB9U52TnoxaA1a3+zCH7oqHc=;
 b=Dzs3wDFclazgb7Z/FIiAByKmxQb2zFWzoau+uVq9Lmu4vYjFYcaBI5q2IifIc68jOwFr0Nha6fWLX7X0VsqTix9GUDmrTbEk8TDyfWJYxc23ULcfJbJbLmJDksqwVt76/WrUv0QGgcg7GgOz86+37cjlFP64difd48h6voZ0UyvR1sELdyTfNUtPPxbOugTyspr9L4MOfa4OolurZsZgpUtkkW/F3cz7fTX0HvBtrWUbcBvE0VV87+O3ROdCOTP6v1Mc7GYv/XHZWm8YO606M74UVqJkGbL/YzwNv0qX+N0AYbXcx+CEekX1Z3ybPb0XBTptGUe2SjkXtCzSkIDOfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ayU00ONamsuGVWob2lfQB9U52TnoxaA1a3+zCH7oqHc=;
 b=P9WBNJ7G1KU8D8XJDbavQX2QW9wY9rSIxf/xK/qMRCLzW8ua4X/lciGLaoDvFC/vGwdWuLkpboqs1g/awGY+skI0S0KBHP/l2NXQ31Lq9VDnzSsv1TeMc3xAND22fpQ0Yuv25+MwmALGlZN37jlLJOfi0unN7xRniqXEmH6HOSM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6477.eurprd04.prod.outlook.com (2603:10a6:803:11e::14)
 by DB7PR04MB3962.eurprd04.prod.outlook.com (2603:10a6:5:1a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 09:12:32 +0000
Received: from VE1PR04MB6477.eurprd04.prod.outlook.com
 ([fe80::60ad:e5ec:cdfd:1b01]) by VE1PR04MB6477.eurprd04.prod.outlook.com
 ([fe80::60ad:e5ec:cdfd:1b01%3]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 09:12:32 +0000
From:   Changming Huang <jerry.huang@nxp.com>
To:     shawnguo@kernel.org, leoyang.li@nxp.com, robh+dt@kernel.org,
        krzk+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Changming Huang <jerry.huang@nxp.com>,
        Jianchao Wang <jianchao.wang@nxp.com>
Subject: [PATCH v2] arm64: dts: fsl-ls1028a: add dspi2 support
Date:   Mon, 11 Apr 2022 17:11:57 +0800
Message-Id: <20220411091157.1965623-1-jerry.huang@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR0302CA0033.eurprd03.prod.outlook.com
 (2603:10a6:205:2::46) To VE1PR04MB6477.eurprd04.prod.outlook.com
 (2603:10a6:803:11e::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47e089f4-a1bc-4e5f-9a5a-08da1b9b68be
X-MS-TrafficTypeDiagnostic: DB7PR04MB3962:EE_
X-Microsoft-Antispam-PRVS: <DB7PR04MB3962B15FA6D039BBFE94BC27FEEA9@DB7PR04MB3962.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cxg5L0KwM7HvrcWoUCXbscp+ds1qyyKMyBVVbqSnur/nlnUGTr4npEKofgHf6pqZkpiEkGC/ryE+ZAnkhXs8a0y9zT9W55aUMHW4Cy13TG64ZVeHdGRS97TNdzzvAWen+3Hjm+JYNbGmlTl4Lwstahp9cjGy2bgXD3qFXjQjFZU28NXxQIdITcCy+I5h4wXMhuKr3j0UdJ9utdPAZ0NhIFuRPYvq2iGOMPFmRmuuf0eN7O6zNpAAZogNlvoC9mLbXR87cRXo5QUkW1OowKZVY2doNX0QGvlc9n8uD4xu9B/7OMsvf/GdPfaZqz8tqVIuoqx6CT4oSZTLdGI7FnhPBXoZg6qnE+2l5TOw0rOt/X7KygN4+8aYbPScGnsYJFnQzaRAc21LkhrHs0Utyvnhjb2Gn/r8FIaqRjDAro4ntmhzyaZIrcPLVMsAgHE0tD+xm9Z7A+Adbq3Fye4tNF6ZfD46rGQtSJ1bXjTSBPK8mA8BdN84AQRkPUM6IKnUDcOkrXUDss2PmFjoMSwJt2wFcQVtL86xJ0zu7DpCsKRvQ07w+ZPz/f6Yawlxsky/iq3+62NRSj9V/mR7RWjFq4SJDmO0u1uR2rUbQp4XjJWMtCmAJqM154ciz44P405Y6IUFpq7C0lUytgWD8FN9EGRVBSwv5UsjbXB9IdQ2arvFi7GKNLZlCAIx7T4/B0CQkSGVHded8BeN6dFwfzPrndWevA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6477.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(6486002)(6666004)(54906003)(2616005)(36756003)(4744005)(4326008)(8676002)(66556008)(66946007)(38350700002)(186003)(38100700002)(8936002)(86362001)(66476007)(5660300002)(316002)(6512007)(26005)(52116002)(6506007)(1076003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tvo26X5k8fpkn57PBfPczKSX/oy0EW686uE1ZIA3kFKfKkCEnxtFMLmMvBH4?=
 =?us-ascii?Q?X4b8I4azGkS5s3IQXO/P6m80C8rlyn8DUlWVjWM2YtBcAJVtVKImG61zVj/q?=
 =?us-ascii?Q?So4iDG9yGEyJUXn4SoHhJMvLfexjmfkkA5RIvcL+xXpwzDUuSJ19YLpDLOcy?=
 =?us-ascii?Q?Rjo0dZa2gcTFscZu1xl64qVi5GYMJEUUbs2DeKi1HpzG8zUcplLjmQjXIe2D?=
 =?us-ascii?Q?ehLE2f/cOAeseyCxHfGAILIqH5xe4H/lGl3mKlXi/L+c1riVKnBmvaGS2J0Q?=
 =?us-ascii?Q?fSSp2itdAFONp2TOtzfd6xFgm4xXrZ85Pi5VFK2N7XAV3JJgqF+vCgh4wB1t?=
 =?us-ascii?Q?NRSVQBwgU2TVuoCO/QKV/SDaMnyEu3S8tehBT0tqZUbG+shssaatyL7/5o4c?=
 =?us-ascii?Q?GVY7CSqAxelU5uRLYW0my5yNCrJAgQNP/PIYmakiwWeqDO/CU8PsE/X2+lnH?=
 =?us-ascii?Q?ZFMVopUujfF4QhF98e136V0EJYYxKApeh3XS//DqKD8EIX9ljZNJU2vJubja?=
 =?us-ascii?Q?A9+jXZx2NCXUb745QuDFZo718EjP/on7AWbF1V8Egzit4J9fcqQtsr2ZHSie?=
 =?us-ascii?Q?wznJCMj5kf9SGYR5lSqztm9qpryARIl3KIgoMrP1bsmBhiY1bHWHiXZ5RtkB?=
 =?us-ascii?Q?40Mk0OdClifl/LP/XihclDWSuY61Ny0i+Kh8foISHTJdkryy5KZszey9PXY4?=
 =?us-ascii?Q?bYlWfgxiA2vrZqrIQ/+gPK/e8q96Y9cixZ340smEOooe7I9wY5ZC2lC+ILG9?=
 =?us-ascii?Q?zPONcngstT/zrgzp669vI5c9/JhbRRbio8Jk6GLyh5YfAuGOoHhz8LpnafPP?=
 =?us-ascii?Q?vXYLcFvAwaet4cNFXz/SgragHAHtTqeiSO37UTOxVxoBVNgviD178Tacl8bv?=
 =?us-ascii?Q?0bizOZgeA1uATz45ZdckUZRW9pCIefkTzDmFL4RBXAufwjF+kwc2ZcewPjH4?=
 =?us-ascii?Q?f+HI+7/XgR6KjZ+oGeg6FkEb6qDwBnwZnoG3Y3LzZEkyTz1bCXlydgfJ5XNS?=
 =?us-ascii?Q?WiaH9JrN5iODN1hDUNHMaNgYB1Y+JN21E8gL6hPKqeX0pIQz3OdaPtq2xRL0?=
 =?us-ascii?Q?3Sr0rQuN5GJMJZHd29RV622KaFQBu/e6q3JLFruxMSCHfxnNQt4xvA5dOZkd?=
 =?us-ascii?Q?GgxpWN2R90uXHx9wkwBG29/R9axsSRZb98SH742xdTN6IYi4AF5bKEDGqZvV?=
 =?us-ascii?Q?1vrs1B7QrHBteHiWsglnV/5zs6Hfuc5y1U7UKF5RUuBia3x6HhqY3HFO2YG4?=
 =?us-ascii?Q?TOwCDpehG43eu1N3VRtRnv/zda3XpbkOOkALuzE4+6ZUpnQpYxROQcXZywol?=
 =?us-ascii?Q?sCZeTxMUmbAnFjJ8823BDZtLHizWix3dRd90hrWs9ePRve7atidBKGMgShoa?=
 =?us-ascii?Q?sllc0pAyYz1lIWlX8a5mutOk1XNTidygQAvuYLtuO1qUE5EW9j0fHKjC2Nje?=
 =?us-ascii?Q?wF89sIxakhl6Qg1vzQhcsa1Egwm9MR0Ymfk4cZEJ6K03xhO2cer6B9AmVgRb?=
 =?us-ascii?Q?s7gJ1hjemkWq+NUnqTDMjUFzIvF96Qn8MKRTqJ/wzMYYDaaEscU/gz5ZTjVI?=
 =?us-ascii?Q?ApJvWUj9W/ecUksyKWAnEi/74VEsaAsaACVJDFS6mWLeh78yfHi+ncAk5ePg?=
 =?us-ascii?Q?DvHjAxofLj7NfP9OiaJlw8iEJpqFuz3sdqhkrjSdtHUFx5zJ6kgiASm0IUwO?=
 =?us-ascii?Q?NI1eHBhcGmeSz/RSBpJezpHdWB/x7XKnLeuRFvQ0VDE8kTtITtYZ9z5SoQT0?=
 =?us-ascii?Q?d27ufJvBRg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47e089f4-a1bc-4e5f-9a5a-08da1b9b68be
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6477.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 09:12:32.1142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u4JK2X+M02UoJnQ9hRQuWsEIkH9FQyV1UP2x5eYAH0BhqM605zhCBnBD/q6Li1hHZKU6voXjFQrSo1OR1PB/kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB3962
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable MikroBUS SPI port.

Signed-off-by: Jianchao Wang <jianchao.wang@nxp.com>
Signed-off-by: Changming Huang <jerry.huang@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
index 68c31cb8eead..6d0508d5abd0 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
@@ -117,6 +117,19 @@ &duart1 {
 	status = "okay";
 };
 
+&dspi2 {
+	bus-num = <2>;
+	status = "okay";
+
+	mikrobus@0 {
+		compatible = "semtech,sx1301";
+		reg = <0>;
+		spi-max-frequency = <2000000>;
+		fsl,spi-cs-sck-delay = <1000000>;
+		fsl,spi-sck-cs-delay = <50>;
+	};
+};
+
 &enetc_mdio_pf3 {
 	sgmii_phy0: ethernet-phy@2 {
 		reg = <0x2>;
-- 
2.25.1

