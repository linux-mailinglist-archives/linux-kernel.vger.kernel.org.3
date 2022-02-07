Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 284F64AC023
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 14:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388962AbiBGNuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 08:50:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385062AbiBGNo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 08:44:26 -0500
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6FBC043181
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 05:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1644241464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G46bKhyGsLqBXvzjvUDZOd+JIKI3euswC2lrBnSLXtc=;
        b=bYTcVAOTCXTkvaKdH+XQBa/6npE7Cpgbf02AUH+OJHk+lWKx0IcgSdVKvpDzFByfTL7WhS
        Y/pfxF/GAxTNrqF0RYjT3p4FoJOSIfcj6R5vOSGm7gNZnxgVLNh3Il261uea3pOfdvk/Ed
        27ttUhVMir8vDF9kMi0/F3evO/LRShk=
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur03lp2059.outbound.protection.outlook.com [104.47.10.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-12-pB7FPQf7PaGiFq7XV_FiIw-1; Mon, 07 Feb 2022 14:25:02 +0100
X-MC-Unique: pB7FPQf7PaGiFq7XV_FiIw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YCLF8CRo10nVvhhMB51N62ytufD4fUlwgl3LghxCU0gQ4lvDiEHrzneR5O29V3PAx6BL1L6ZhAl9+ypEfWyrsDENVCk/XAUr2T4MbwAavWDzovLtJRdtnbE9Z8SphtsPxVwalOTTpAGbWlzI6MrlOz4iKw5JZsKc+WKNAgiMlzcyNQ8b0gNYM647roV2dUYKiKoFAPQt60hlni4fyv0TBEbnAy16fXUVmNpuaCIFgY7qhAZBSoXDvl+MW/IPh1eonMSgSLCKaNHNm/Gx095L/YXqWBtZeC8mGCjsK83+1PM6aKrptvO/v7fQ79ojVQqWNG57zTVs/zqenytIn8NT1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SrKyVDQL9hZHHmYdICoP+NIBJ2pOvqWAZPGLBjw5zcQ=;
 b=K6NRiYo2WWrl1xKJqFJDsLl0RVrnrT2/ENm+0YCZjvDzJv8NRuAA6OWUbV+S+IAwAYEm6gQVNwIaqMRKooi1KSIN0T4h7kCfQDAA9EtvFNLtt2nTN5cGp3OqwShlxSb9vKo9X/QDOYnHzR6aNcdj0Gi5omfXc7k4TjY56V4cK3dT0WQSjkJrRX2M6Svw6YvEkOUAhSx1ELn1A7oXur1VLKCf3EppaTX1LUEEYS3OuDn0CVsKq1gy/DQtgDQjsYL8c0mYaJaI50ZJm8NykD2NvvKJJdZRNQutWtE2pwvKxo47eoXsGMF+baKkIQ/ZPbjDICdmYe4BiDmur9pkj5DWdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by PA4PR04MB9248.eurprd04.prod.outlook.com (2603:10a6:102:2a3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Mon, 7 Feb
 2022 13:25:01 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::e14a:7928:ecd6:f233]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::e14a:7928:ecd6:f233%4]) with mapi id 15.20.4951.018; Mon, 7 Feb 2022
 13:25:01 +0000
From:   Chester Lin <clin@suse.com>
To:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Matthias Brugger <mbrugger@suse.com>, s32@nxp.com,
        Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>
CC:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Radu Nicolae Pirea <radu-nicolae.pirea@oss.nxp.com>,
        "Ivan T . Ivanov" <iivanov@suse.de>,
        "Lee, Chun-Yi" <jlee@suse.com>, Chester Lin <clin@suse.com>
Subject: [RFC PATCH 1/3] dt-bindings: clock: Add s32g2 clock binding
Date:   Mon,  7 Feb 2022 21:24:42 +0800
Message-ID: <20220207132444.3653-2-clin@suse.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220207132444.3653-1-clin@suse.com>
References: <20220207132444.3653-1-clin@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM6PR01CA0037.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:e0::14) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6241138-bba9-480b-003e-08d9ea3d3e41
X-MS-TrafficTypeDiagnostic: PA4PR04MB9248:EE_
X-Microsoft-Antispam-PRVS: <PA4PR04MB92480EC8C2D72BF810166CB8AD2C9@PA4PR04MB9248.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AcDELdibwPI9JEYBqxJgaoRyJZSRGxdlgxolW1AWWnFNLbHSzmWZONvreyzmKRlRZM2yW5IXfE26Apx6TIYk1/C7X9PK95orKiBMeNWs0nt9Q2aV0pfidtZphgU7Od1QuHa6kBFmlSa/jareqD7q7Iglbdi0cewfOW0MTOrDtAaAsvI08W5IYFW27L0PF3xfG0H+LreDcDXSuFj15o0JfVsSMpFFjiTlFvwy1FiaQPG1jcdpJ9mBuOEpWeRd3g/w092fV2G9DrQjsrOZaYpJHJSj69hfksrAuduUdIiWyqkFqQ4UwQJ8iOpWxtD5VQQAfj9Ornx9yS9udZUYvkUDlvAweE1DwAf5UowPhq056HH70MhNZ9L9jrTKcdHw+Ejq9YPxw4AiIRaTLSEsD2C8oftfGXGW3bDs4J6hPxQvdMpJOqNFFb94ebaVKfjqzX/sXdqHUU3CeLm5dyz2Q2xGHxVcso+/DnIxoVueWm4M15svt94wpmkhLtn2uSoQ0/K3NwtuSfNMnnLeUDFrlxUx50YvUtJJYL6JxcSFLzqrRm+6F9WQ6wAUqdHjtrYN4pKS/9cYVV6iRgJ3fUime6izg7ikaNLG8pmnHc9m+r6RRMbLTjLdNPcNZujYFpD8c60LekRqJ0W3FEQHiYyzlqgfHg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6666004)(66556008)(8936002)(66946007)(5660300002)(6512007)(66476007)(4326008)(6506007)(8676002)(83380400001)(6486002)(36756003)(2616005)(1076003)(26005)(86362001)(110136005)(2906002)(54906003)(508600001)(38100700002)(107886003)(316002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?66tT+6ZIOj47HJ5UDlHwS4EVkZfCEwCXgy8oTcW3zH46sJBnFaVICvAml+8j?=
 =?us-ascii?Q?2qEKwFKuqXuKI2xUNSgsSXNqjs2T133BZyJ2pKIPfGaAjxPK5Q/DLZzAPguM?=
 =?us-ascii?Q?sit5qtqCr4spwBTxOAB/ULK7Zsxx+01zD3Gtm54JM6EGH2dPoI+wa/M2oSoR?=
 =?us-ascii?Q?FcDcUY9m1NEgHd/fU5Ro11V7i94hsPsTa+hXX3j6RjhWAmQF62c17YECaayu?=
 =?us-ascii?Q?QgErwNYkFCyaYyH3umZuDJS4ysiqrMWnB4CiiuY/A2NZXbi6KP4tsrW9Sl6Q?=
 =?us-ascii?Q?iST1MKSi8PDzkpMJoy1aKmLcv35jsArpgq4faNNO+Z69iAvF00FmSe9zE55y?=
 =?us-ascii?Q?RdTtZ6DD1ZwmGDHWcHqbNA2Ktr4aWl7UOHgZ45qnKegLwCkbnNce2c2873LR?=
 =?us-ascii?Q?GxagBUVJsoqdpUVbjwiov7pULM0hIgEfHjBhn8DLxAL2A+hsyRQWGrNS1Niw?=
 =?us-ascii?Q?pUbBVAFvlF1mkOhl6sJ5G3eD+sTL7XZGWw4NrCRGwHEFu1suFdg9kJfXV0G7?=
 =?us-ascii?Q?sgu5mIxSH19psEJuWPDo+pD9Ew0PYZde4fpURX+UHH2/d8vIr89t0rZdAdru?=
 =?us-ascii?Q?aBC1XxCVgm3T9MUBYsl/j6dyXiHW8wz2iiFPVA40AG+M3jD3hkQmj4WerW6m?=
 =?us-ascii?Q?yYwr6TOP5V5KUfF0E/x7ekOgpgHsu6Wng1RVQ44gCom/1NmccCOER9nTAI5u?=
 =?us-ascii?Q?UAJjz+g8lKfHLVVtwyyosfYbumEyDfR3JH19oP9NVeHio8ccQCA9f1csQRYV?=
 =?us-ascii?Q?uEfnazoPPsv80nM8ltN6/qr29r/1/KoFbLKOwQh1/+dytZm+zI15kS46SV3q?=
 =?us-ascii?Q?s0ONXe+/by/3QcZ7wCJai7BuxGkqFXBEF1S4UTCw0/PDyrY9/h2ODmtEWJXL?=
 =?us-ascii?Q?ppcBekmyklw+wipqEeaO+yIeb0wrAUodoHqcEtyZQ1VDFLv0tbBpQHZ54Lac?=
 =?us-ascii?Q?7UMlPJJRyte4QiwvhAU0+3M27FidJmhCIR9VmIIAKc2Aa/FYUioMpcbPgs0q?=
 =?us-ascii?Q?YjY26uGId9C/1XEFv2aeBidfP/qxAwgMagN3eik+spPl7Yhmo8hoVhXBTV5x?=
 =?us-ascii?Q?XyWQvaqo9hVIauDhY/IEolBPXjz1UfjurjOQOxXUDSbeMVef6IdA1lR/GoFt?=
 =?us-ascii?Q?eUAeoQY5R91OV42oqqeXxF0tPZVsC8wMhckiVbv2/uGZOExtjD3dx9Kph3LC?=
 =?us-ascii?Q?VNgR+2bZBB9rZMI+/8J5hG44Y2+8CmrIEgAbpw8dbQWay+llsbrDLgxPjuDm?=
 =?us-ascii?Q?1qW2YPOW1FvEajgj6zGrL/a0czj40DWuTbXjYVKmPeMcjRwbZeTsEKd1o9A1?=
 =?us-ascii?Q?PsA7LvpRJnOOBWYW4p44cMCRuLhHCDwb+9S+XvbBZVs9W2F2j3l4yl9+iBoN?=
 =?us-ascii?Q?R1lvPrTxHfd/dY1MdMb0utSXC7fgvNZu4/gkQ/L1y8HLVGrpWtQYmy8VxRiW?=
 =?us-ascii?Q?jnlJoO9wZ0+dtGAVO5NeiLcspslmR0xBmxo5g+/uPlO7EPE36dTAn50w2ttw?=
 =?us-ascii?Q?pwJLcLQqkK38/wWV3wdIwVaTJDb5PenVQbSy7sZBXXmuuiJA08dnAYex/nNJ?=
 =?us-ascii?Q?5OSjxXKsUUAvKfq5W2Q=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6241138-bba9-480b-003e-08d9ea3d3e41
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 13:25:01.1268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OZyppZ99t1zF5Lva901heVAR2qGLgeubVVABLTN7wuki81i/pCeo0p5b1P8QGcFJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9248
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clock binding for S32G based on SCMI Clock Management Protocol (0x14)

Signed-off-by: Chester Lin <clin@suse.com>
---
 include/dt-bindings/clock/s32g2-clock.h | 28 +++++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 include/dt-bindings/clock/s32g2-clock.h

diff --git a/include/dt-bindings/clock/s32g2-clock.h b/include/dt-bindings/=
clock/s32g2-clock.h
new file mode 100644
index 000000000000..6d8606293865
--- /dev/null
+++ b/include/dt-bindings/clock/s32g2-clock.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: BSD-3-Clause */
+/*
+ * Copyright 2020-2022 NXP
+ */
+#ifndef __DT_BINDINGS_SCMI_CLOCK_S32G2_H
+#define __DT_BINDINGS_SCMI_CLOCK_S32G2_H
+
+#define S32G2_SCMI_CLK_BASE_ID		0U
+#define S32G2_SCMI_CLK(N)		((N) + S32G2_SCMI_CLK_BASE_ID)
+
+/* GMAC0 - SGMII */
+#define S32G2_SCMI_CLK_GMAC0_RX_SGMII	S32G2_SCMI_CLK(16)
+#define S32G2_SCMI_CLK_GMAC0_TX_SGMII	S32G2_SCMI_CLK(17)
+/* GMAC0 - RGMII */
+#define S32G2_SCMI_CLK_GMAC0_RX_RGMII	S32G2_SCMI_CLK(19)
+#define S32G2_SCMI_CLK_GMAC0_TX_RGMII	S32G2_SCMI_CLK(20)
+/* GMAC0 - RMII */
+#define S32G2_SCMI_CLK_GMAC0_RX_RMII	S32G2_SCMI_CLK(22)
+#define S32G2_SCMI_CLK_GMAC0_TX_RMII	S32G2_SCMI_CLK(23)
+/* GMAC0 - MII */
+#define S32G2_SCMI_CLK_GMAC0_RX_MII	S32G2_SCMI_CLK(25)
+#define S32G2_SCMI_CLK_GMAC0_TX_MII	S32G2_SCMI_CLK(26)
+#define S32G2_SCMI_CLK_GMAC0_AXI	S32G2_SCMI_CLK(28)
+/* uSDHC */
+#define S32G2_SCMI_CLK_USDHC_AHB	S32G2_SCMI_CLK(35)
+#define S32G2_SCMI_CLK_USDHC_MODULE	S32G2_SCMI_CLK(36)
+#define S32G2_SCMI_CLK_USDHC_CORE	S32G2_SCMI_CLK(37)
+#endif
--=20
2.33.1

