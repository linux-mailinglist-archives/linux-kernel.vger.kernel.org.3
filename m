Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7776A46D43F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 14:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234255AbhLHNWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 08:22:31 -0500
Received: from mail-eopbgr80045.outbound.protection.outlook.com ([40.107.8.45]:45795
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234236AbhLHNW3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 08:22:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nj7Ns+W/HbNyQCr92hjApRIe6FHxZdWtDpw9Und0y0jEuyjrXOUX4v3FOBPFX6gYnKdtICHfN0mqqzSuWsWC9tYX2KhZ0JZQdO0gdaRoSpXF0OIsAYU4Cco/4ZRBJAi2VSeZktFfiTQepXF4tRTPtYhaIGGgnwdOMJCVI89qU5UNnqe7vkTnEI2si/nj5Zky/xV/09lCI9z+M2k7wQkZsUo0IK/+8WPe9KgVBmQESCP8Ss3pxniY7zjlm3f03VsDM49RuXJGhSTGI6/pHI/oqNzth10THeSGMt6L8SKVTzr9SzAng2SGTH53k3SF0MFb2mtaZou23nbK+dwhgIlEJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ruscdWmXSmc9/sY8KckXjwuzQCEgosMEl0jEk0wMmdk=;
 b=ANJzxVfmuNueZdVUabV/7JhyZRgehw32vH4d4Id+xQRUdV+/6BkOaILVn+2aRMI6A9B+4E3yAjyB/exxncqf/jtGhdEVnoPxJQNKGFimLcaaeT3yFPD/ZRyJ2XwAtyFc5c6BOKrt8lSCLv2FsvdRHbz1BpfZm8M4wZiUPdH/0D1OvNoegQRvI+kQGCtEoteN8OydCIm8aUuOfbrBaMidqtqvrzReF5JQV4XNCOw8tyCRqrt+wc+QNlgP547BMAMv6iZnulKlhNTsR5BgL/v0ns+YGowl0FEoSmj90BHi8LLKq8fQ9gaxmLVRVYkb9CNyrRFjFnoQqd8M+qohlC5XzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ruscdWmXSmc9/sY8KckXjwuzQCEgosMEl0jEk0wMmdk=;
 b=adyPuZStWgkGehB16+/tDa5tXILDytXB19XfTPWybvdfEUZeBK+Pcz9e4DW96Rae+bjJUnBFwybqVrteJdzzGEmvmHq1T+3G6tP+VJpGMyUJEjy4r/iUmkjAeWVvg9caUIGlpHxw6FxmMEyMEqaTDUB1BIKS+Ln4XUkG0B7ZMtw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Wed, 8 Dec
 2021 13:18:56 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::82e:6ad2:dd1d:df43]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::82e:6ad2:dd1d:df43%9]) with mapi id 15.20.4755.021; Wed, 8 Dec 2021
 13:18:55 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        ping.bai@nxp.com, aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH V2 1/3] dt-bindings: power: imx8ulp: add power domain header file
Date:   Wed,  8 Dec 2021 21:17:53 +0800
Message-Id: <20211208131755.1799041-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211208131755.1799041-1-peng.fan@oss.nxp.com>
References: <20211208131755.1799041-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR0302CA0008.apcprd03.prod.outlook.com
 (2603:1096:3:2::18) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR0302CA0008.apcprd03.prod.outlook.com (2603:1096:3:2::18) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Wed, 8 Dec 2021 13:18:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8fa03b1a-633a-47e7-4593-08d9ba4d494d
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DU0PR04MB9496B8D41A1CD90CB6C53A63C96F9@DU0PR04MB9496.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:243;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HeoMCDI9Pbp2s0DAv2DNo690zrHgQNJl/Yded2iNyX/q5VwyDRRWFqR1a7ENaQCujHZ8pm7uSrrHJfzbKTVT7DodLiPRSDx79wAne9jacLZ0Ks8NlexxTEcnFceV9vgCksGKA3bY/Ya63xa9UnpwWIUUu7xttwXIM3/zqsA6phildI6mcHb+19SBNkT3vjap835uK4svQD9fyJUyUqKolmUHPCbyKEknFWioaEtOAMCKvTrclxIX0gN3f7VasfHLUgxvWI1kGLNSR4rjPIlR+BGaiIJuAIJYYPRDYWGd6XiB11ibFH7u8gFRfmxyB2Sto/KceqhjOPghmFl9z5O1nLC2WfwgygFgea0ReyptJwHKnl8qV0tI8KjhD+5sh3h96QaeOfFuu2311BxZF9OC/ez2SerDjuYC5Eatzc6dWrqcF+hLQ9VBcyS0qdvoyNjf10eJn6z/pAouA7C5Fc2G/CGYfbjbTaqnRQsd34Asvg71BcAycj8RXd2UwpwEKfBqaJk/mV4NXO65M5YekKHWZDbiewO2NK1BSBCvH0PFIIfv4dCpM9upNriFyzszz2AEnta4PozA8ie8dzTHgMr8RNoHSVljyTu4HZIVGu9374WP43W+P+vABa65M772sbpQZC1A1WwVXx33SoieuW+sWsSTNkRDpkiPNObav/bNwUQ1URUVRue6Kwt4BBwk5TgeomFiQCCSdiyFMTnuouQ4Bt9hY8U3oY5xmTCZNeJqixk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(26005)(52116002)(6506007)(6512007)(66476007)(6486002)(5660300002)(66946007)(66556008)(86362001)(8676002)(4326008)(8936002)(1076003)(956004)(316002)(2616005)(2906002)(38350700002)(38100700002)(54906003)(508600001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EpF7qkPP6gn6XoUJOzUEMgF8WQevxkuIJ+RCuJJss+Jt7ckDA9Pdkyv9+2Va?=
 =?us-ascii?Q?X4JErqdLXPhw99AHc1uFKtURr017yFa1gqgxF6XtkrhvbiU8OiwWRu+o5/Hd?=
 =?us-ascii?Q?SkujwcgmqlRwx4XKY8fz/46D0nG1Q5HMyMxOmomIJUwEyjKStaa0nyvmxtdm?=
 =?us-ascii?Q?sxGruOdk0kv4FXcQOqCryZ+ZQtvQLSEP4MjyUfgAzo0vs37P5Ra02wYBKrbC?=
 =?us-ascii?Q?kQ2M2W5WwR5cS4Qe8A12Zk6d6nZLwwY/3FlFS+cpGOKfggKVbxxn7DP9eYBA?=
 =?us-ascii?Q?N8zkaN3P4DHJGaxhxF1SS3Qn2VHY1P11mmGxWEG3vbZwUWNBPAOVxdqNyqw6?=
 =?us-ascii?Q?FmWKjuaEH6mWFXIFJ8AyvEdfF81ozgKtCS9kO/JecQfKozKyzF4bjy33ODO8?=
 =?us-ascii?Q?0slToIcU8FYEceeBXMErWoTJNjYkyjblp83RrVwuXgj0601hJoK+052iDAEx?=
 =?us-ascii?Q?ftf8NaPQmNe7h2fouaN5IsF6dk4FanoKNe7ugXzZCd8800HGXILwZs7gUpBP?=
 =?us-ascii?Q?h8hSk8EennVgM2GBDX34SWr9vNyaC0usffpl/ElbnOUIzIb8hYS35O6EoaWX?=
 =?us-ascii?Q?7mfhxogqbuJBKzmY6FUtIyi6Y2LpHPifO4dMo3Auv/npCO+jcWDuDSjOwkev?=
 =?us-ascii?Q?TlbrEerE8tOyv8VTpRege2FCmZf5JdxxDgtzefNzfNE4+J8f1hVlyzM3IbI0?=
 =?us-ascii?Q?8WCQDN2nYrjxi+xoIVaz7ImZJkiSj/kpnjregEIVJBp35VqAj725t19HKKHa?=
 =?us-ascii?Q?iPtisM4/WY+GbPMGEjN4mAJMarEHx2KgjewQzlzkSF9dzfQY2rInvXhE2mni?=
 =?us-ascii?Q?RD/43W9OQAyvMI2vQRHACSFwdMFU5S0Zb1RtX5SdDAh82FprvAjaejl7LD/b?=
 =?us-ascii?Q?FmzIfT1mNpNhgJhTnUBd574j3qiUNcXWqex7dUT0ZAHYIC2ZmN1Gzu4O2NQO?=
 =?us-ascii?Q?mjsYufQIwVEkgyPjXTk/MeXyjQYFCan4D4e4IBXBBtVXBv/lhZwchbvnG1sA?=
 =?us-ascii?Q?wH46+/BwtvT1pIctuYaMwXhkoSWihr4SjdTTVZRTGUujvveaoSMMzh1dCnG8?=
 =?us-ascii?Q?3VFdFvBYH/qK9KGnuNMh7TYkpRIpjGsuO/RnrgT5p3t5Ni6zvaxajmU2Nep5?=
 =?us-ascii?Q?H53bWhqepsTM1BGXnckEqkXJ3oBeU8TK2kX+hWyRQFHLbboa0bQHRgpAtejO?=
 =?us-ascii?Q?Q8+eTps1sS1aGWy73yeY2ZPuTyNEafLDXMh+/mELmaMZ6IKd/iVxs10wVE5Z?=
 =?us-ascii?Q?Oy6FQ4oU4bLH0kKzaajtryeRitQ1utCQaheGNUrZCqwNBHQ5tLsN7D8W+LHM?=
 =?us-ascii?Q?0fwdszjD014Y0rQCZkevMlc8mrhu/kb7Qk4KjJSuNR8myfl9ODR0OD9x8tri?=
 =?us-ascii?Q?7q1RKjePodYHYU9/y1GxMIuJbsDlzsfHtAQu4xQbTzWmQhQxoOQbEeuZsI2U?=
 =?us-ascii?Q?8Wsfd6OS76Nt1KtfjjanYN9b1udllL4XoG90L+tm9cIWMSKvfa0cBq+zmRmb?=
 =?us-ascii?Q?UiRj1ehrtSb1B0qC2kKm+iamystz8irJr2QF8uU7GlJwgtfOQheTte/dW/yj?=
 =?us-ascii?Q?cOgrib61f30ebKvt0OCbYFCe3oyj8p0QlXovoMBoXogLatXy7TAslTOILYzW?=
 =?us-ascii?Q?AEn44RfJ7YFKsZB8xWStDMM=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fa03b1a-633a-47e7-4593-08d9ba4d494d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 13:18:55.8040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: klglX7RYoJG3f4mE1FectvCJ8i6QTuxz/ela2+R1iVTBwyvY88CFqN1/eOXksufsoQAeiYm27cwvaR6XnrQcHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9496
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX8ULP power domain header file

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 include/dt-bindings/power/imx8ulp-power.h | 26 +++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 include/dt-bindings/power/imx8ulp-power.h

diff --git a/include/dt-bindings/power/imx8ulp-power.h b/include/dt-bindings/power/imx8ulp-power.h
new file mode 100644
index 000000000000..a556b2e96df1
--- /dev/null
+++ b/include/dt-bindings/power/imx8ulp-power.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
+/*
+ *  Copyright 2021 NXP
+ */
+
+#ifndef __DT_BINDINGS_IMX8ULP_POWER_H__
+#define __DT_BINDINGS_IMX8ULP_POWER_H__
+
+#define IMX8ULP_PD_DMA1		0
+#define IMX8ULP_PD_FLEXSPI2	1
+#define IMX8ULP_PD_USB0		2
+#define IMX8ULP_PD_USDHC0	3
+#define IMX8ULP_PD_USDHC1	4
+#define IMX8ULP_PD_USDHC2_USB1	5
+#define IMX8ULP_PD_DCNANO	6
+#define IMX8ULP_PD_EPDC		7
+#define IMX8ULP_PD_DMA2		8
+#define IMX8ULP_PD_GPU2D	9
+#define IMX8ULP_PD_GPU3D	10
+#define IMX8ULP_PD_HIFI4	11
+#define IMX8ULP_PD_ISI		12
+#define IMX8ULP_PD_MIPI_CSI	13
+#define IMX8ULP_PD_MIPI_DSI	14
+#define IMX8ULP_PD_PXP		15
+
+#endif
-- 
2.25.1

