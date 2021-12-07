Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B970146B614
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 09:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbhLGIj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 03:39:26 -0500
Received: from mail-eopbgr30078.outbound.protection.outlook.com ([40.107.3.78]:45794
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231997AbhLGIjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 03:39:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eaCga5Wcj7Wlw+/334q+Nh+HHhIoT8wTcYMrhNGzejGFiTe0MR41XlFInodrkxg8lbS2HgW0JtvKjFdp5YD32QB3bBKqdLdRMb/s0j+A0DtFxnPz6T8iVJy5KJuWvCPTveXNN4zU5lRoPDzw5D1oX6tCWP53XqNiplvXVm14AfAKAxhK6PkvvqGYcfHqb4UEaOWFWfBwmyGYOB8I+uhsT7VKSVhgQoTOZESdn65P2KpWiY33R01pSY4Lp/RuXwAW41e1GJ3QVX6P+XWw6yeK4F1ucgUmVOX1l8R5ANTLAIHn0j+EAp2EchXWTra3aujnNtEBAlnKHAghOV3TT49jhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qc4PbYNm6juRpJ8+Y5JTiUfUFXznWsWps6c2eGGFdfM=;
 b=n7mPW/jfyVmGvKJuNlVlAadT9Kclq14tgFpYUwF6IkjKTbdKaY8ocISbhc4CIFAhtCeH4qISESN9bSM+xUxKoS1cQje2uO/65qK0rgOhnMdRnoNeFFH1/TSzi66Vm2LkUe24/tlYo2rV8r8wYy59bQozbHrTyB/eCfBB0mZUBHylJGFcX8dba0d/C+20rUdi+7YvTSxXexPJX2lXCH/Kx5Is14I4iBFDR0Mr0gX6mYnOdEKAqeu2Fc1SjgqgyZecI0h5H9Z8QaDngPJK+z9dlvolwR2OVLGGXC1Lnt3ZDceDLgKL2KX1Qo49YWGfQ8vWu2o50kSQXnSgWfS4iGHS2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qc4PbYNm6juRpJ8+Y5JTiUfUFXznWsWps6c2eGGFdfM=;
 b=RXyQP6lqEZdycZhaLqRgQBpn8NoLH850PGCe+VNXxGrPPt9D2pAVo3cd01LNAPSI3Jft6azpkqTGxXT5xKCY3fz7RLKXrfXGhO88Q2J7QMEJ8UoYctCgsYU7mvCM3YR0ec+a3zYqloVrd99FNwxIHsh4nC04vfMEzencxHrvFFM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8744.eurprd04.prod.outlook.com (2603:10a6:10:2e2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Tue, 7 Dec
 2021 08:35:51 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::82e:6ad2:dd1d:df43]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::82e:6ad2:dd1d:df43%9]) with mapi id 15.20.4755.021; Tue, 7 Dec 2021
 08:35:51 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     catalin.marinas@arm.com, will@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        ping.bai@nxp.com, aisheng.dong@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] arm64: defconfig: enable drivers for booting i.MX8ULP
Date:   Tue,  7 Dec 2021 16:34:57 +0800
Message-Id: <20211207083457.2932511-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::19)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SGAP274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.14 via Frontend Transport; Tue, 7 Dec 2021 08:35:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8b2fd85-09ca-4cc3-b49f-08d9b95c9334
X-MS-TrafficTypeDiagnostic: DU2PR04MB8744:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DU2PR04MB874432DD51CB8B3ADD0404F5C96E9@DU2PR04MB8744.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:386;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fWu3jOKlpeozYGgXq+ip3ZHaJtaT2r1b+KIlalEsaEqwvHUoKcqZf438ylXvJh1vnERO1sQz0um6whQ2Tg5GH9w2pbYQPXcbiOywfmcf7eVKKhRSfIXIK7gS2cMKDHKvAauX2EL79ahTLci2qj66sKga0EL1QybE2d++KqEblGQRy5jQ3KY/Gw7vO6iV63InFaNLgtrLQI24ux1VoiE5ihVWDASnWGOoPE0AnvCeBXF05tERtKLHqd9Yv0VKmfUQrnQBV8O9YpCuo6RdJRNyE5sEpHIfpiTDigOLUNN4Hq4KZKCmfwmVzNKB9vHo+zGPWKQkAEJNdQ67o19VYNKPjYw43CtsqXbm1+c9dTLjcEXS5SnRW4p6g7w8iRR3B/cnVsVXzL5j+JRj12LK47jyp/MHymy1hJEHlhsOFn/moaV2yitKNw3AHgBQLMzIBssq9cvE75tLKfdQZaPZWevHcZgX4mNQ7kGzL3PpREu7VGH4m2FM76ev0kf2XDEsa+Lkn07Sx3j37y9EaWHn7GibUF/DwjR4Sa19jzIQi/mI77SFGCh7cq5YpKCRRQITiL5Ul9ReWkkr4C0TVYp63ab0sJd59lITkpm2mIO036iXE97kewCtWgANDBcHJSsqr2/xP+Ei/Uxq8rwRbe5kGwKaxYRl5ZPJLsRr4G1ViVU+uPsQs4MksGvKnyy8fXVyavmkO2Vmjn6QoqvAAOpd859+eA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(6486002)(38100700002)(38350700002)(66946007)(6512007)(508600001)(4744005)(5660300002)(1076003)(26005)(8676002)(8936002)(186003)(956004)(6506007)(2616005)(2906002)(316002)(6666004)(86362001)(66476007)(66556008)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/EM6fTQc7ltA+TUL0QV+4K/fO51WnWk17BR2z16Q/H2eVisBiiu5ysRJaZat?=
 =?us-ascii?Q?wTsFvXwA+XVVHBtceIudzcWKkALrhC0/yF1Jz1ERCzMs4MpFCkOmhdgy7wJ4?=
 =?us-ascii?Q?lTW1y6wY8qlHHVhLCCmxOpro/twYu9fqK5Aq5PPN/xAmhRX9Gi/SuN5o3BQJ?=
 =?us-ascii?Q?zJv0XaN8xf40q3MwwQzTCWBsHxLRf9tbEM9XLvgEpSNtkVK4+OpvztcXczsK?=
 =?us-ascii?Q?6/G1SJQ//8L/nwE2kRjTNKcbR3G9h2MkWGAi3R6mzJe3txb0JmLEdqm42dW7?=
 =?us-ascii?Q?09jztqjXhK80SeKlAbr7SFdOADCcU9XMDNJGGmMKGRMN6lCLeJIUS6YMxlLa?=
 =?us-ascii?Q?GpVtJqRTZpiQhx+o3xG0ZwcjwxNpcNd4AD8VnJE88O9hLWFVJyjpkFrixuTj?=
 =?us-ascii?Q?wWzaEND4lZZn0GBm6E3zDJelqopDeuJZw+U7ELWw9HuDeSuemSXyB5K6g/mC?=
 =?us-ascii?Q?n76KOASdhvE482PRlWfMPC0dNzkp47Tnkkii9tjBVqV7lC8cskwsida09xrW?=
 =?us-ascii?Q?A2XmIIfLYgOFyFzwpECheb6vApH+fjoHpD4i+Fy4Rb9knEnUXKS+G2OrFzC9?=
 =?us-ascii?Q?OwW5frzh2fD6R9TJSmT53VhGv5ggXSOiYwexGDusmSVEjM8frLUYmq/J2W5Q?=
 =?us-ascii?Q?StNEgAihD7OkdIrOh56V/fIc2y37ZyViqf3fVTCyEjXD9SzPd2ybqIh2uAX3?=
 =?us-ascii?Q?XDpHPePbgo3A/ypQXDFjY/VJbqu8X+sb/x8Lqt8qcCKh3FVb+/I+2TWWfT3r?=
 =?us-ascii?Q?p/mIhUedGRZWTUxH7uyAjdfbgFSLm2mRirJ9VegmEdFmidE+SEJ/787ytoXG?=
 =?us-ascii?Q?T855/wtrXEKIDATYvXR7lrH0df3nqDl3ILVMO+daCKJ4tP6DZ4odS/9LDMIH?=
 =?us-ascii?Q?tf2TY8AuS6tkSsERFVcHRmnzQ5v+GlrdCCl+jwpnXxs/GSIFAww8XgAuDtbW?=
 =?us-ascii?Q?pem0rfF3oCrgQMuKZNl7RmFgx04LZY5GEyEvwKsc/5qmDA9nndsnBLdign9V?=
 =?us-ascii?Q?yIMltgUdbj4J4DTFTy2tM+qY7AAIRQm3wObDjly75sSu2FaQs9EzbsaYYb6h?=
 =?us-ascii?Q?KAaZhHplEuikmtVBLdC+8Ob/xDAP/RxD16uAS2sJMBmWNdxIMuEck9KeXY8V?=
 =?us-ascii?Q?V4l7r3lcwWKRQJiuqWeo1cOAvKcSseosl//TEsnL5tKQl3hl+h2mYjRJOR64?=
 =?us-ascii?Q?nuWkjO51NnqnRxk4+BBvSdPrz0itwxWE2SBf3hC4JWlTfIGLEq2Jrk4k4qnA?=
 =?us-ascii?Q?/5uNodX4jkKmlV+Zo0gmGl6tV1hA011RmD6zDGdxP7KOSxFPLzJ2hGTh+/CI?=
 =?us-ascii?Q?kBokDENITJhVR/OiMuTABG86yEj4MT+8YMwEToGvkTkEXk053AUPheZjqQWr?=
 =?us-ascii?Q?v8/kavUTq5zaZQftIIdo3CKhBMVKt+v0jGS3+slpqX9Wj2kGeSGqdWEEIMva?=
 =?us-ascii?Q?8QF82YFMVNqqfdpE/UwP1owQHdEiNRfvfLfOfaKwiplOW2iKtxa+6a1AwFMA?=
 =?us-ascii?Q?tOcgJ8lCgi+cdS17nbItXJk8MmkMEMFFTJ+pllqmb2CgZDTqtWk/UOXaFo8u?=
 =?us-ascii?Q?PBtZzwBEaMeXdCVuP1lI07JUWI5NghcNRoqe3giJxdvZsSzmhxJ4QlTByPJP?=
 =?us-ascii?Q?DMbfPGdH/QBLmwQpn24qQ7E=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8b2fd85-09ca-4cc3-b49f-08d9b95c9334
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 08:35:51.2398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XVIyVBsZ7sMcj6+T+/G34m6IzI4YWN4N26KaCPjEZPGhKKCluVXAWRnVrKN6QBRk/4klg+G94jdQ8TY8mEjNvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8744
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Select i.MX8ULP CLK and PINCTRL driver to make it boot.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 7135eff90327..7461b609eb94 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -507,6 +507,7 @@ CONFIG_PINCTRL_IMX8MQ=y
 CONFIG_PINCTRL_IMX8QM=y
 CONFIG_PINCTRL_IMX8QXP=y
 CONFIG_PINCTRL_IMX8DXL=y
+CONFIG_PINCTRL_IMX8ULP=y
 CONFIG_PINCTRL_MSM=y
 CONFIG_PINCTRL_IPQ8074=y
 CONFIG_PINCTRL_IPQ6018=y
@@ -987,6 +988,7 @@ CONFIG_CLK_IMX8MN=y
 CONFIG_CLK_IMX8MP=y
 CONFIG_CLK_IMX8MQ=y
 CONFIG_CLK_IMX8QXP=y
+CONFIG_CLK_IMX8ULP=y
 CONFIG_TI_SCI_CLK=y
 CONFIG_COMMON_CLK_QCOM=y
 CONFIG_QCOM_A53PLL=y
-- 
2.25.1

