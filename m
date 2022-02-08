Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E98034AD059
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 05:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346927AbiBHE04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 23:26:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234088AbiBHE0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 23:26:54 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70084.outbound.protection.outlook.com [40.107.7.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F98C0401DC;
        Mon,  7 Feb 2022 20:26:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XF9+dsho7EBDage0BLPsty6KLlfpVfaoOB1uUgbN1VfoDQ93pWzgre/2mDby61t0988+QynY2Li6S8cXO9x9lg7451o4ZYH7SV2BEeIVoWHGZuogs9p5uh0cy9vv8M4j0iY1JnbB3yNS9a9Oe+pVXgEEUN2gGQzdX73yvLJapG4pa8olqDrsHKUQyjSB0K7y0vMMdwxZFTLIruL/0FxRRICIgByEqauBZpSKNdc4sqgwGsBWLtNcij3LYhdDT7BtZmZtHnHOZbt4KHK0afebIdIAP380k7G020aHil31IX6Sg+zRqFLYFjNkwUPRPwkz9+8BamuONvyUfthQAMIe7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HaHd8lD7fvxaJareGyb5km/meuO3dkg/xY7w7oRQwBo=;
 b=GRwyTAD0b2habWODqeItYa7kFHwjawUW0/7ZW5QTDFcz90n3avMHkoyKi7XCSIjWaqDGwiO/KoQwyuafqcTJnrM0OHinUWlyUh5pas3FuKPwKBoEaJDxDCcsP3IWyz4QJPleypo6rbQjEKpvJwLL6jWxnfLBXy2BjvOSrn1knEV17B3+iKfl2r7u0wAB8asLbpM4BgSoem5qNMy+t7AJVYFO7W6P2NDYUdHxxYDEnbBz0Y8hs5pj4MOH+vJ7uR4LU4k7oaQhK7MVPa96uwc+pJpisEwG06RTUNMgU65b13XDuSfTx6ZbX2f8akKRYmP6kEVzvEqU7KpWwcNXtqtusw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HaHd8lD7fvxaJareGyb5km/meuO3dkg/xY7w7oRQwBo=;
 b=UtEHkKWb9vF6devi+qTagb5nROCny8hixMvCyesOwcaCezz61NW8XZ2RmCo95EY1yA4VtAsRVAnTyiIS9mNtjqKToHkkrYJ0O3qWMulY9XJGK5qb+TZglM9l51CEgGFElih5+eLjJOOTd3ELpeRfI9od4dpwT5Pri0m3C6DA4p4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6477.eurprd04.prod.outlook.com (2603:10a6:803:11e::14)
 by AM4PR0401MB2369.eurprd04.prod.outlook.com (2603:10a6:200:53::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19; Tue, 8 Feb
 2022 04:26:48 +0000
Received: from VE1PR04MB6477.eurprd04.prod.outlook.com
 ([fe80::800d:a31e:1d6:9be9]) by VE1PR04MB6477.eurprd04.prod.outlook.com
 ([fe80::800d:a31e:1d6:9be9%5]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 04:26:48 +0000
From:   Changming Huang <jerry.huang@nxp.com>
To:     shawnguo@kernel.org, leoyang.li@nxp.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Changming Huang <jerry.huang@nxp.com>,
        Jianchao Wang <jianchao.wang@nxp.com>
Subject: [PATCH] arm64: dts: fsl-ls1028a: add dspi2 support
Date:   Tue,  8 Feb 2022 12:26:10 +0800
Message-Id: <20220208042610.2026531-1-jerry.huang@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:4:194::16) To VE1PR04MB6477.eurprd04.prod.outlook.com
 (2603:10a6:803:11e::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da57ca69-f25c-4c38-69dc-08d9eabb3899
X-MS-TrafficTypeDiagnostic: AM4PR0401MB2369:EE_
X-Microsoft-Antispam-PRVS: <AM4PR0401MB23697FC68CD1CA7B789BDBDEFE2D9@AM4PR0401MB2369.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hADPdzTL9itEgjeUYGafKHJpS9fz/Y8gRaNRg8WrH/utJoDv1PVudcyuCPyMpzdkGFeQl/BQwJzK3BnYoQoHHk2dVzb5plmVkqQqiEkfWZv2m7MwOQhOgtmOr4jIf98iNXpaRjj0G0tW9IOYC9lFPjzzoA3dwO9YUte6NdNw5uH5UTcVQu34F3P6+KA/1ZeaaKjJSUDW65zE5tRWfyDgLjXvsjtvuZWO7+C7qvJjgxUdGcQfTs5Yu/+K0fZEOpAf00g4D0XvPJAE5bZr/yMijTUd9+Gq2vaqctNlUKsnVmAwpxppXQxlw1Vib7VaOyz254hPErqrDuwy0Vy0wICtbkWztTg+EvJs3DD1vLem+s/Es0XZIwRZnxGH9b+RMySfp8ianKhBkNMpXwHl2v9As3TDi2rpHO573/Hk6VxMDc7uCDnHfFU/BG38rTZR9g/Em5aTD1wh4ePVN9VUeRG1lBMejzEjhsJ1IFmTfk5CrCFNwFc5lze/68A+huOraaG+tVGZXy/Nz1tfLTk1adGgOA47WcErfVp5Kxpzh6Aj8lK4dyOPvvzu8mFWPcC0WXy0y//6CqL6/GRI0qsWTSdYlzcr55H4wdImhgoe1HrQInLLGN8yaOZJoMbMc/gOewAo0TPXdq+8x7OsMtTgZpDJONlsF8GSK6cgQpW7FGOhBAMFWQBLDqdMIGO8xnViCKl/AfXzkXVxa5yTrLmM7lzDcQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6477.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(38350700002)(38100700002)(8936002)(8676002)(4326008)(66946007)(316002)(66556008)(54906003)(66476007)(6486002)(5660300002)(4744005)(6512007)(508600001)(186003)(2906002)(6506007)(2616005)(6666004)(1076003)(52116002)(26005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?As2eT2p0+cFVWB8zomImWcrP0d5ncOYBXMR6VTyvtxr0fYGE36Rk0/nj+tQr?=
 =?us-ascii?Q?gCOUl8O5broNMuxqgXGYkXFY+B0TBwhE+tMorTDE2CsWpxcPcsmnVJnxHxQ7?=
 =?us-ascii?Q?kLP5phMoOMEgRC+8B4CbMCl/AZ5hrXJ+H3DNg1yky6SRswOERnxKQbhDUMW6?=
 =?us-ascii?Q?l0u5OYR1B6Gpxb29XcqDnZ73lAEpppybajcCoNOmO4L1AGvmlS/WO7rA01L0?=
 =?us-ascii?Q?tNs6RmuVk/1dugu6LCo+nXQVwxGkTq3pFA960Uz96AxtZnhy5R3gbjyE6qv8?=
 =?us-ascii?Q?kY5hv0UJVMaxhhnlwc3lzdMqgHostoxKZQlcvfB7XgY+thFOz3yXcZCyH/d1?=
 =?us-ascii?Q?slgDBi8CWKcoEspRKjq3qBj8UybXc05Ya9HbymihdDS0d/Wi9ycchMbhklJD?=
 =?us-ascii?Q?KuYw7vDReI+WhK5QMxeHydY/75+boOuEeaYUc9QCxMrKtt5phL4RV2LOimYg?=
 =?us-ascii?Q?uSoOOaC7+gz4pzYKiVrFSs4qjfS74XdejhWxJayABD6MYLH3+teFCIqOtICL?=
 =?us-ascii?Q?5tm0EyUqyy/hQm+/2O8cLmVmRTFV5mWyWlq4ir1NHY+RjLxL7weBv7ef5Dko?=
 =?us-ascii?Q?ufHxY5A3343QMGZXZBSCDbBbBCnq3HoAlQ/vhJGO9JfjwL+kchn7lq4zkS7a?=
 =?us-ascii?Q?sa7nQJ3abuOmdQT9uXEYhezUXlKmaIEBx0hpoVo+kCHaJ80ODgyygB2sERq6?=
 =?us-ascii?Q?Hj1LmDE6hxNA7C5OB6z8rPP7rTCpc+wE5FUNEujz5xvrLFCOj/1YpqRfya8+?=
 =?us-ascii?Q?lLmNsz37PN7JB0NonrAQjUdquDb339r6qza+CG2WsI0OSME4caLHfur6DLLC?=
 =?us-ascii?Q?5g2NVe1hg7m9WHPU3URBhybzYgGJ221W1H0fuL8kPURHxSxR31rYntAGc3Kn?=
 =?us-ascii?Q?xIl+480sqHWuuPUnCF4nMqD9YtpopMu/iduv+jC2U3y2n1Bxu9+sDI9kGiR6?=
 =?us-ascii?Q?epIr85wWsGOmJSVfNSxFT7RTU5HIIRtO0WDJ1uwhZ0CgOOybQyeKLSToHsQV?=
 =?us-ascii?Q?d2S6c85ZminCbWlLOvmR/BUvYAbVwpQ9QEecEltaesAL4nlm0BAyjxD/6bC9?=
 =?us-ascii?Q?8jlt1xxsRxN+FlXN2TxRjaYNvFKq37+0yMiculNy1gV+1uE/4bgKpqNiIeIB?=
 =?us-ascii?Q?f7a1wsgNSarh66Hrw2TO5ztlHnwvmmD597JDoPOB6VcpovsEtXuWWngBtHuh?=
 =?us-ascii?Q?zhJ1AOMt0q8NJSdwDb9h1XPmfOsD5iRj+QW6iRns33hqsyMMAS9xtmo91DhZ?=
 =?us-ascii?Q?gDlo95H+Wkqa+OEolMVX/wKzV9KR8gEAZTB0BezfTH7WJDqbH04T0LoXmb4T?=
 =?us-ascii?Q?Stm0TLZL6yAFZgQ0JOlax+cyLWqe1DxFaZeShXcDBuaJCyqAPnKl+m7v6U7e?=
 =?us-ascii?Q?6tXSALWC3H4WnvCDKh/pRGWhJnPBnWadgHo25jVketE5sZ4efAANtztQzyvP?=
 =?us-ascii?Q?2XY/iu2ixG1x+VYNpLU8moQEscjffVSLY1woIYPWn/VrBxaNKYwz+bY6qyp7?=
 =?us-ascii?Q?ac+cAeXyYYK9Db74843hIqbBUS9jFs9dBawvJJcrmXVWhU5pjdAyrKs70TJ7?=
 =?us-ascii?Q?KGlTc6NbxJoHDM7u+sfv12CwFgyJaJ/SMPOFQYfEiwqkFBPUivEaQtux6dzH?=
 =?us-ascii?Q?qjPNId7JHxrJwHJeqVBP9cE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da57ca69-f25c-4c38-69dc-08d9eabb3899
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6477.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 04:26:48.2591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SOVKFtdcxIiVytTBa/eaKboDbwTKWuEjzUMwa1LbUA1v+9sahSxaim6DABmvJxLEyWiWe6SWanGT1gvPKyjLcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0401MB2369
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
index 68c31cb8eead..af2c7eb07eaf 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
@@ -93,6 +93,19 @@ simple-audio-card,codec {
 	};
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
 &can0 {
 	status = "okay";
 
-- 
2.25.1

