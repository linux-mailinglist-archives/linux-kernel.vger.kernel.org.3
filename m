Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F26104AF5C7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 16:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236326AbiBIPxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 10:53:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbiBIPxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 10:53:30 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2052.outbound.protection.outlook.com [40.107.22.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C92C05CB88;
        Wed,  9 Feb 2022 07:53:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kxs2WnXP0Jd8hLv5CT0IDnbNvkipAIs2Fy7p1mvemAjvLKSKyAVxEDzkWR1SW24gvGOti/HAiA0+XDwqsTa0asZCJzh2vh3h3jPj0zh5dZCqDBCEIigfSCkIpbtEXqcTs8SpKvOtrGmQZw+clLBk3wbUr4wkFyoiiGnTXYbkuknxrFirFQYqRVeMGFSxNyEfaUyzAYbs/FdJNGoE9GdmR/D8qdTUdtr8OybKo/tK5LlsibNtAQiDWkTrZu8LUpYk9BgiPNGjtoWy/9VrSlh5FclR1Yy6w7QEsc/9AwmfZGM27wtp8Vf1PpK1s1Nah73XVW3vTPDDcNhbt8mKEo+SZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CY1A2RQQpvYRg5oOVvI6Q45nN4IcVe31Ec3kbZhbqzc=;
 b=NjcP+asD24zzj5X1mtPZtZpirH+3JQFTNUDC/nT70ELiF9AoZy68BJC5TWSmm53Faratv/jzJhHDRUsgRsRMiUUwgk2A7KQ+YWQZ979GRpX7liqimfUsrMQXJ/gseYzgXBon5DM/+vkMJFv/Tr+QuKC4JGVkeUROdkgWL3UEDk/Qb2ZILskQi37tQveGtFqxGFKquaTaBOSQpGji1Wy8zS8Nl4hpGwQeAwaLAtkZLG4/BewmYB3xx6nzcZ2zSUT1iwFBPsG+zHFCq6eUZrBrDNMVmKOuxPkjKAykE6P3/34SBgkwgseWELhILJ4QZ2jZezIUXwOMfuKWKAIggYa04w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=KoCoConnector.onmicrosoft.com; s=selector2-KoCoConnector-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CY1A2RQQpvYRg5oOVvI6Q45nN4IcVe31Ec3kbZhbqzc=;
 b=BD8f33sLJpIJp6g0AGN/L7Tx3RmvSwS3UNFFD9WlzHqN7LEyXdX4Zopr1NUlF5KLGLWXWvB8nD5VM3xRFt49o7wGolWOOkeUJ/1FnH/yxqwUwZN2TTmPLJX8ypUPsQzr4DMfMMhDnjpFaJ0MUHLNlCrX0jBTo2u7SmdTA1SPM3k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kococonnector.com;
Received: from AM9PR09MB4884.eurprd09.prod.outlook.com (2603:10a6:20b:281::9)
 by HE1PR0902MB1852.eurprd09.prod.outlook.com (2603:10a6:3:ee::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Wed, 9 Feb
 2022 15:53:30 +0000
Received: from AM9PR09MB4884.eurprd09.prod.outlook.com
 ([fe80::3c7a:2af6:3623:4c3d]) by AM9PR09MB4884.eurprd09.prod.outlook.com
 ([fe80::3c7a:2af6:3623:4c3d%7]) with mapi id 15.20.4975.011; Wed, 9 Feb 2022
 15:53:30 +0000
From:   Oliver Graute <oliver.graute@kococonnector.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     Oliver Graute <oliver.graute@kococonnector.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] arm64: dts: imx8qm: Add watchdog node
Date:   Wed,  9 Feb 2022 16:47:13 +0100
Message-Id: <20220209154713.17850-1-oliver.graute@kococonnector.com>
X-Mailer: git-send-email 2.17.1
X-Patchwork-Bot: notify
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0195.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::32) To AM9PR09MB4884.eurprd09.prod.outlook.com
 (2603:10a6:20b:281::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93d6946e-45c5-4698-b85a-08d9ebe45154
X-MS-TrafficTypeDiagnostic: HE1PR0902MB1852:EE_
X-Microsoft-Antispam-PRVS: <HE1PR0902MB18528714B8473284BFC6F9ADEB2E9@HE1PR0902MB1852.eurprd09.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3JyMkUmKrYSKH+ZieVXT+tiKEy0q/eg3J1j2BLBWXUrY2NrBKNi9VDVbpMOek5gbUBKl/0Aw0yMkgxdub92pIhj+XtlUwoLfQJ7JYQiInCQcQo/N9D4nDAc4YJzgmFZ+KTdphnUHHrvH/hSEnxO/DadP5ZiAspAF8DvPP4Caw6eobh7K2GYeMrKMYIiURX7KhnlvQ2xZlS4r7qkCYc9IZaV89aqI1gWVewNe0N6MHK0LPQDD5xB6tzeRss1LFNwvKgVE6d7XDwl/gOSRJ1xT1JZa0EAhe1F94rw4+nHpol7VwmpGBHbmmaLq0/diEcqJZdoncqdCa1qft5grK9d49NMLEz3v3uNxBL5BQ4erbWTVsBae7D1hOo8gc86HncW4+HaDwM0VyOK6hyoDYDiXOM8s8/g0d9R6BwzGEbxVgw1DRp0EUPriNESJ1Uac5FHbrq1RlElFBH7/L1ARm8A3RQqxPpj7e+jfEeHcRmGLIBnq7VxV3pZc6hMbsBmHVX25/Sr5+xzhjmzsLreKPdNcH7NriN139SfoohTbdWtYAtglUu49NJou2cPJG0TUuZFUAvm3vdB8W6RJMiU0bt9ApelA39NFYnra4M/FMVmRhzQMFZAKPB26uYURDlBae/9K469kTCt8odfPgKnw0prqzkK+ORiKgJAU79SOzCdcRy5okAb6dslqsnrZjk/Zjx79kbL3lmKG7xP+nh8hBpVnpbbXnT2/MrhtCua74ldgMVc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR09MB4884.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(396003)(136003)(366004)(39840400004)(376002)(346002)(38100700002)(54906003)(52116002)(6512007)(6666004)(6506007)(6486002)(38350700002)(316002)(110136005)(26005)(8676002)(1076003)(66556008)(4744005)(5660300002)(7416002)(508600001)(66476007)(44832011)(36756003)(4326008)(8936002)(66946007)(186003)(86362001)(2906002)(2616005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5jXNx6/xrDiUlzKemEx1xqtA9y5QpRvfkKTAc9pHXq4k7jB2OiWBs60Wbeg9?=
 =?us-ascii?Q?LKcb2PO1LTuW/h99L6SOcmRUDgjmJ2e/0moz08c80TsZttC9+Dg2JeyiOn6K?=
 =?us-ascii?Q?q9WwGeqMVGYuUW5LG4T2zXh/YlUFjje74vyg27LVFttdxkd0GKRJELZH9Yym?=
 =?us-ascii?Q?/7BIjxiEQRhxrrLsFFYh7fyUmBd4wK4qZn57/Aw+qH1A9Iy68sHGseeBgtq/?=
 =?us-ascii?Q?sQDr+yyJepgLxWfqG2w5+z/lIWyytjDRevzGxWKfUlypmbkL4ztJB+yJNN9a?=
 =?us-ascii?Q?KdtAVHl9yVbMrW2CyFvxkI8r/ywyuLxdjpIVm41iDfU9DDJJBf5fdk4h8JkK?=
 =?us-ascii?Q?ApsV/GXM63gqyHj7ard/LtIW11v1Lhq7UlC9pD7b33SQhCH4oM8A+3m5oPRo?=
 =?us-ascii?Q?XOWCvfpK4BHC+VhI7odAv7uyCIsiA0BFvBs4OxqGZQsmsxuf80HCm8Dk8Obx?=
 =?us-ascii?Q?xjOCpthVOvP6MC6z6IuRxLNQi4nYqvVeAiNZPwu42MKbjADaknGsei8mXiT+?=
 =?us-ascii?Q?CTz7d4cyMlRO7Rve2aS9IPrdTAoyHEC9LKl1aNHhk5dVpipbjZfIs8MLlaSx?=
 =?us-ascii?Q?oIDrrnPyNwlNmRf5P7h4SiMgxHgrEHV7oIPGw771odw84PSZEtNR8dAc/taL?=
 =?us-ascii?Q?uQdeOkQVwN5UW3t2IuNb4Wi4U7vlkoIP6OA5NOU6yJ6XnHOsEbS8P92pvBN/?=
 =?us-ascii?Q?h/J6NMgqcxLp4g9FGqPiKXzqPHzFTnHplwYlbrQSWWy133EBI+KrrhHbEfu3?=
 =?us-ascii?Q?GCAXYJuDy+DaOFxQXsIAVkx/NPi81PDyUfppCjFguePQZv2FnUbyjU+swNIi?=
 =?us-ascii?Q?GWLIkPtgId9bFyJ+2rtzxN3ZxedlNkqNqda86MF0giM+C6Am3dJVCjbtYk4V?=
 =?us-ascii?Q?F+Q0PI8FGYXwCw1LIPnb9wJyCIhchpd5s6/y00npKTJ+YO1odX2BhWNb2pfq?=
 =?us-ascii?Q?afY2PZ9MmS7mxu5NMHVwflOH9MHz7QOuN19Ehd0bdJlo2I7W8mxXYWuhzUWD?=
 =?us-ascii?Q?sXpzcrAS83hDlPPtis7d6554o9MMZwiF0jzNRki/+xaXr/0qhiuMWPKxKdAV?=
 =?us-ascii?Q?UB+yo+wdZVYDOh9SqmyhrT0c/jrCCvlF4NCDJ3rkX/ZKMpvxSN0ol2Sd7zjZ?=
 =?us-ascii?Q?pi3imjNXp2ghClIXzPToFuPp4v2zK1OcfKuw6h6VrFiOIurE5+1f2t7i2JIx?=
 =?us-ascii?Q?+qYZpXf8Tp53fq2Z+vKl5l0WmeXb/LxLtYVCGGXLF0MWV8x7bccxR7Xz8I4p?=
 =?us-ascii?Q?K+SAkYLVGhop9XhaXiLRPfM62CY/UqUeZ106GEVt535g225UU83MkMA0sITH?=
 =?us-ascii?Q?7Au/3q8jxBOCe6yXJQnzqUrUxXvPbp2sOWJOKeVYmDu5vUccQnWRBOai06EM?=
 =?us-ascii?Q?E/14x0X3e1S+Oeo0SWyf5/UR1DNUSXx+Q1RxCdqk50QhRvGfzuoGnYvNsZGs?=
 =?us-ascii?Q?lODb/+oK8CxR5/yTmrZXvAyrxDv0FjJzbeUPLSg8x3cakvhFN+nXipAxvm9m?=
 =?us-ascii?Q?4HCczxD1s3dprvAqp+ws4yAaAroc8Hcpog7sXosVcRjYLQiFNobxzVfb09BE?=
 =?us-ascii?Q?VIpIrQ9bA7Vk6o579BS81JYe1hMNrOpR4olqvA9+io5m8tUArwl6cLgrxxJL?=
 =?us-ascii?Q?knVG/0h3SDQ8C4QqGhqeuh3lBRUyEf+4Y7is8P25sUFGcUZBWMVFlfHkHbu5?=
 =?us-ascii?Q?CV/t+A=3D=3D?=
X-OriginatorOrg: kococonnector.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93d6946e-45c5-4698-b85a-08d9ebe45154
X-MS-Exchange-CrossTenant-AuthSource: AM9PR09MB4884.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 15:53:30.0006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 59845429-0644-4099-bd7e-17fba65a2f2b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0PfBZGnYx+T15TVbgmdkcJcRdzT1wWzLiPlIQfwXln8ySyaBaOExMPrr2+41tmXkO1LU9TpAw5q5e06Zj1TtjdErsMxMUabWHz37rUTFY04=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0902MB1852
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the watchdog on imx8qm

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>

Signed-off-by: Oliver Graute <oliver.graute@kococonnector.com>
---
need to enable CONFIG_IMX_SC_WDT

 arch/arm64/boot/dts/freescale/imx8qm.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm.dtsi b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
index 87a4c3ec8861..b822f95f9baf 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
@@ -169,6 +169,11 @@
 
 	};
 
+	watchdog {
+		compatible = "fsl,imx8qm-sc-wdt", "fsl,imx-sc-wdt";
+		timeout-sec = <60>;
+	};
+
 	/* sorted in register address */
 	#include "imx8-ss-img.dtsi"
 	#include "imx8-ss-dma.dtsi"
-- 
2.17.1

