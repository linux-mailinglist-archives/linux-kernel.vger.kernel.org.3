Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 056414838DE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 23:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbiACWtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 17:49:17 -0500
Received: from mail-eopbgr30081.outbound.protection.outlook.com ([40.107.3.81]:56531
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229876AbiACWtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 17:49:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gOpp0yICmE90YVQ4BMoE6s7lKbOJ8SYe0kDSnNkpRDHphYRCU2HQhema7FxymnDX/k/EA/JsiW9m7Y3r3TUaTwDypMa/PQfR+K9PPzBzkzJNRSioDFadmvxpvJ7KbEoaOAQsUqq861tQgywkS+YjKbrvpiAPnbbfXKDwHSo8muboi9HvWBL+C5yFnw16t9DSebfWY/vS+dujJVuaIjYzl3sUgKQ69cS14aUKbVOwmNxUR9Sber7Ijbqf1hrkWq+VMMULh7KjhzA54GhbuE0BiXi1A0CM/UjN6YGtxnfZWTgU/Anz+TsJQlCtgJ2mp1UMq2R8U1t6X5tz87bJKox0oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L4m9UZ5IHj8RUDaqF8elB3rBN0lc+sal8pXRPI458VU=;
 b=O2R2Kr3vhg4TxVwsNmPgJS4oEpSWm9OtNUJx1C6GZITp+p9GfyfBhY5asTVTKpyEPY8kY6KvWHw3QSsuB4ULVOa4+RxY0Mgsr1JpBOwZbc2bYR5RLOCd8fQbahS55a6+XfxiipnHKqBx5GU/Ad+w9ub9pgtGHJf7jxgr76kpc6cn9QwWC/Qv8128BFz4m3E15o6opK7ZmlCJ2MNMA8ictsV+ubbM7Co1QS96ljcCSRQemqwlo7AbM8fQVBdHj+cAuDJK3Gb+3kFscnJCQvc2CWAioMUhuYg/vyUdOAQIM4+JGYmoNksI7LWkMUZEPfs3/uRnYJQG0pePBRVC40SmEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L4m9UZ5IHj8RUDaqF8elB3rBN0lc+sal8pXRPI458VU=;
 b=HrtDHNLNJouJrYTa8c88tIZYODfuV4CCiGcNpqt0886nBzh+TjREr3x4M4MQe7fHVGlCF2MJUnBcuUpFN2sYu14fVnzocx04rIxdJGxf4EBw7c4WqMHEtkqboQWPGpbIuLJP4x4q7yaRsJRJFeMH+1EMGkSIinPjzJ/2w8p9QLc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by VI1PR04MB5856.eurprd04.prod.outlook.com (2603:10a6:803:eb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Mon, 3 Jan
 2022 22:49:13 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::4c4c:f2b2:addb:841]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::4c4c:f2b2:addb:841%6]) with mapi id 15.20.4844.016; Mon, 3 Jan 2022
 22:49:13 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Rob Herring <robh@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] arm64: dts: imx8qm: Add SCU RTC node
Date:   Tue,  4 Jan 2022 00:49:00 +0200
Message-Id: <20220103224900.1439756-1-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR09CA0056.eurprd09.prod.outlook.com
 (2603:10a6:802:28::24) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c63e18a3-bb23-40ec-42be-08d9cf0b4367
X-MS-TrafficTypeDiagnostic: VI1PR04MB5856:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB585696C8763ED746D5C2DABCF6499@VI1PR04MB5856.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HIlgawNG/2tQO4QDCNHQh/C0eYELZrJIaQUYDex7Y9FGtuQT9i1peTmj0K01s2ghHL3B4injvuhHi01pCFwPadGD1JM+dvp/DA1pEau97zGMKarUs9oHy7kKfSr027u3CXo8bNZrtHXJhNJqPuRaZh8yi+dGQmCtU5LDHO7jjiEK24Axp0UZ/KQsbDp7IrZJgmn/90+oKFWAsaspCPkwuiDEFnoCQ2M9+R7idzcVP05jMMHfuCIfw6SKNzFuBlQedhdd1lMxeEePauJhYCoe/5jqusWHETgF1ntrYKA+fQxgjfKMtlFgJHJFxcAI4SNc/zE1BNBWLSMJv/1tSMiPVu5O5SG6dDadbAxZQs+NSJuGEdD/Cdm3nw6w5LuIlbAl1QZ1Hc6OqMN60X9GS6U0fuuUYRz885ozfn5sPzMA4vDDrxoOcoAxQ6BhMLeBSl8FCq2ZWIXnDcFDHHVP/EFnyHgc/FdrRomwPIvPRvHdh51bfc3qxx6FTPQysaNbZooO8TB9neNo8JlXu/zFLMrR8g5Izf0PdElY9eNh9mGmxzoYcFybIwklqRiSHyjoEhfbK6cQnu71vGxJId4Q9vAnI8TTxNWdeuUOo2rZAUCokZY9u3MmFbqTrAP5hRmeEyr8ZKzT8rfklK31PZP/Hgp9yU9nIo1ilodDHv86Q+7+ArQt7AXnli754FJTtrGvks5zM9HqiU4mjgonE1j7M8XxSKEdEhkkw3CP6YQq7wVdTDc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(26005)(6512007)(186003)(44832011)(38350700002)(54906003)(52116002)(6506007)(2616005)(36756003)(5660300002)(86362001)(4744005)(6486002)(6666004)(8936002)(66556008)(8676002)(66946007)(1076003)(38100700002)(316002)(110136005)(508600001)(4326008)(66476007)(2906002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jgKB53XwPe7oq6eGpcM4Gi421nGOPn5MpqeRjrG/sduY6uY3smTQdbpt/iXK?=
 =?us-ascii?Q?yFRczXQh8gSfzv6HfLd/HTMDZB3j4wnLtwe6k6Q8vwUpzV1GYwwAVXK87phb?=
 =?us-ascii?Q?xWWIknq6JZhNLv1q9bMKl3icJEdDmarg2+k2nq+ta+A3OjECfGaxuQqoM3ig?=
 =?us-ascii?Q?cJP29zDyFWO8r5IMZPtN424iBwai++Cr0HtQZ0021oApe6nsHlmCaC/vfGcN?=
 =?us-ascii?Q?znI/TMR+wbVm+9j4y3oE6yj9sc/92Et9+03h39Pj3my3Ym6C3TQuhOKh9v9I?=
 =?us-ascii?Q?Xzwikixe6E5nVxR5sOPvlYy6vbUsvvgoQcjgHLdNi49R8mzyus05hXdruXys?=
 =?us-ascii?Q?azsE+C2BvkUFk4q0JiEXfYY89aCVo3N5uLUvM/o3pcGpd4gdFFGzoHwOlsvF?=
 =?us-ascii?Q?BxReDJCbeMRxhhkpaC5uLIQU5oYFt5UOSN6LPuRtDdyMV6T25kMxP6Sg89ix?=
 =?us-ascii?Q?ujAKXj0MhukQA0G+QQQbIOdsXYBKANoXDYzPOR3zTWpjezJxoU8TZCJUgs0V?=
 =?us-ascii?Q?xdaugUIMZCyujvpQuIYub1nTHIK7LZkvyp7jjLO6kaa72zROCxCPR2gKbFn2?=
 =?us-ascii?Q?vWWP2brZUUlS7cbyUHi5TTTeevSBVKV4mRInhVvgFmnErlWcRhmfrwEFpqBI?=
 =?us-ascii?Q?uRVB+X3ym0luk5Y7EE+bBchJsk+IwLTt6cMiMgNudP+Vm8HrJAYEQ6S0m1Ch?=
 =?us-ascii?Q?OSmSK25NYGRn5R7zx0cHB8cJhmQsLhODoE6sShSUhiSCtyRKytGooiLlzDOK?=
 =?us-ascii?Q?hrgMCxzYtQwzq08JNAOadCnjYeo+CetXiMIr3/rS083Ab1aamdyen3dliH0t?=
 =?us-ascii?Q?Kvi1Hr8wcCbUKWNe7zUz99R5AVtapdoTBIYhNHzLrh6ioK/wE1tPPVfssrub?=
 =?us-ascii?Q?VD6x5akB1GnKb8DKTeERyunKycCm9v6qhgcplg81Qy/B3UFc4KaMFj/vywvc?=
 =?us-ascii?Q?WWulFccPpr64vDNsf7QvTL3RjYDXkuMk9WHbNxXkiEUkiNIRK2V9O2lVrR/q?=
 =?us-ascii?Q?BxqugBewqDeZU00OHKvbdfKJ+ITtk56+suO/r8t4LOuUmlI5GeDzW+FnBVL/?=
 =?us-ascii?Q?Yi3buZA3zT+htiz5pkBSFcc7Wc4b9b7422vBIh39jd1zVJwyu+XSJleijXf6?=
 =?us-ascii?Q?T/pc/zz//aXD6LDYSMnLvTyE17zFT8kG3hich4nyRBV3tnBcvnsN+PpB8qjN?=
 =?us-ascii?Q?wfKFHApV96TYV9uMFsrfI2AKSX236/34AiHILPyRzqDgHLaF+5wAVHfCZKBF?=
 =?us-ascii?Q?MLQrMP8ks5riDa7Vo57GZ3WdXH5XunMZu06Wn96CK2v55EWh8Qtj21xtIuVI?=
 =?us-ascii?Q?lXt4FEJleuSuifNsqYIqRs1PjlCMhP1WgRCVRDk9gtH6jBPmFrKbzIOlLjX1?=
 =?us-ascii?Q?VhR6I1pA+JI5fLPLN+fPowkGgdrU4tIWvi+q+xGeo+Cd3tBss/gNhJ5MR7xl?=
 =?us-ascii?Q?bARn3AyVefmHsqRiQAUP2R1U5Mj7v3GNKjV0c0hb6b9PnJWZaa0L4GxjcyGD?=
 =?us-ascii?Q?c6RCgMNapzeoPgN1tdLrWJ08unlIAIQ+bc95exr3GtqiLT3wJCKx83Yzkiw0?=
 =?us-ascii?Q?TEpnAKzZGLwr+XQN/BB+MC+sWwm3CZv4OrgE2jQopOT5Y6ncepQDPKtChi2v?=
 =?us-ascii?Q?oAf5AHjyzQKProRZqUBKI80=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c63e18a3-bb23-40ec-42be-08d9cf0b4367
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2022 22:49:13.4445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l4vWkRp7lpTF1ksf74/xkuTbpONjHTPmCesjcpWlhoZqpIKIeAs5NGJINf25pJb4EdBSd4aGScGXhVwR9DMWIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5856
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SCU RTC node to support SC RTC driver.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---

Changes since v1:
 * switched to fsl,imx8qxp-sc-rtc compatible and dropped dt-bindings
   and rtc driver patches

 arch/arm64/boot/dts/freescale/imx8qm.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm.dtsi b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
index 4a7c017b5f31..ac43315a470c 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
@@ -201,6 +201,9 @@ iomuxc: pinctrl {
 			compatible = "fsl,imx8qm-iomuxc";
 		};
 
+		rtc: rtc {
+			compatible = "fsl,imx8qxp-sc-rtc";
+		};
 	};
 
 	/* sorted in register address */
-- 
2.31.1

