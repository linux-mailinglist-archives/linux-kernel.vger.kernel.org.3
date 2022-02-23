Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D2D4C0CB8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 07:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238491AbiBWGnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 01:43:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238454AbiBWGnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 01:43:00 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2072.outbound.protection.outlook.com [40.107.22.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB9D6D96A;
        Tue, 22 Feb 2022 22:42:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kvT8PDUY3Be0PRqWNi1EA/WW3nSZEueUpK+9G1kMyI/ly1nSBcwmHM+EX8Sc1o25tT3+luRnvPqgVlbJSZrhbJA22vdrMokVZaHRHIPrG2WJjpciM36jD2Jl1L6k5KLxS6Z4Xnh0hQn7NctFA+WiSoUSQqjjYHGktYZacxXwym3T4kWaPBHp3G8QTjCBmgz/FQO85AXylBCM5I0f+q2gXsA79sZL8zsx1jSeuOICYO2V3iKmDYq5/YnLkiZMyX2GQKY5TtFpkRLp5CIkqOWk/fSUDmuzZt5+7iCfrMD/7QR6KoGqFOS5JVEMj/+2YAJsJHwiKqUFqyJsUvnEM0mrBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I6y8KZvIgHATGmIYBESOoyPwOXzllnjzAU06kYu0hNk=;
 b=i8c9vTThdbPpspYMYnPVZlKFdOJ7qz+a2IXHapkF32QZ+3DzsGo45bKTc42VoZbx/Sf7j1airNWRSunesCIDapbsb5t8uMjEiRS5beqzosCVcs4ULkHlPVT7EuO76EYO1XsXHcPiBdNDTiaKxrbwD3KDns5LpNDlY1br+nZXOYRIYpQzvjGjXY7bscTyRVqBQcE3D8ydeKo6fiVUojys3KwzYB9macPgHPYQ5xiUgD+QZXCPvhsIzSbGBqfZmAJgPn0WnhdXh+E2l6/7BDZwXm+JL2tKNftny/x/FMFotiqo9BE3Zz6zHdfPBODcbVpq5lxHPqkxyyw/lqr+Knrgrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I6y8KZvIgHATGmIYBESOoyPwOXzllnjzAU06kYu0hNk=;
 b=NNvY9VUaWD/Fz4AmxSaH7YxPc2QzT14vQL8yNX3PPkvbXcn9YdHK8rUiBXOMgwv7Rp8JxDSoRfD9FWzDSQPY17ldyousEJlP3GyihAkd4GW3+np0TjrgiAOF/bpKJTN37A5j2Q5xYphvt9xIn+goiaYnNKjv7av0Xd4+ZGwPf0g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR04MB5542.eurprd04.prod.outlook.com (2603:10a6:20b:2c::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.26; Wed, 23 Feb
 2022 06:42:26 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc%4]) with mapi id 15.20.4995.018; Wed, 23 Feb 2022
 06:42:26 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     sboyd@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, abel.vesa@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 4/5] clk: imx: support fracn gppll
Date:   Wed, 23 Feb 2022 14:43:57 +0800
Message-Id: <20220223064358.4097307-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220223064358.4097307-1-peng.fan@oss.nxp.com>
References: <20220223064358.4097307-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0110.apcprd06.prod.outlook.com
 (2603:1096:1:1d::12) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2382218f-7654-4d32-c520-08d9f697a7a9
X-MS-TrafficTypeDiagnostic: AM6PR04MB5542:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB5542B49B37871C3578426557C93C9@AM6PR04MB5542.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gRE8r/9cTqeqT9TGGWCY6rKPTqDJd43IdQikZ1KED7ljkoJwxIPYWT8pTY1R3z0VCNLH6wrQ9L1XROqncOzf4jfKZc+d1BcpYo/f86SWR6tBHzr31/aIjk7RlaVcS/tT4+liw7x3m9YHt0KE+VBxzmXCic395G3Q5i3J9c84HQLE0dT/f4YV2LpR6ORmmlCrHycporEunpWjkUyjUJulelOK+qw3OAnwPFA0jgI80xnQ9nuAB/6seECjRhLql8438RH8BVXSZfcvg1jTcw7daiZSVzaa1luLEFScgiU+0Ayp/uzajoUEYgp9cOQdMfQbhcgffBsMBjfm6JCwFmGuEfnrrN1RPoe2sL1ZexwLQzDSuCVKEdSlduIITGU6Vpi4Mvb1h55OBjWFGORaD4WvSN+OXtJFNuRHWIqqQA+SIIUUlWF6zTlv9uqd1WaAhzFaXrBh+U9ANp0Nl5bAoXxNxklGCUEX40pUMoynIi9FQpypfzNYeOjkZfUDDmpkB+JX07Dvw65YnKikcVQoFWJnnMKrJ9AmYHCQ93FkdKJVdGwkJo5LgZp/F+R0AKvniwCraDv5tBKtvD7G6G0IXXBtzFzOd38ChwQLm8If/7j/ypnJBezMukViGP6NEqFAvBc9+oqFvIJbaNATaOUYo8jHDmaRcTxr6Y1WDhuAe1QRetZpDH6svLNpVmrrK1g+4+U+wx1sAU/wXQ/zcKzyyCVu0eCdHarxypCmMuf7p0mlGS9syxR3eTSqaPlTpjfu1YfT8s/ZQDhIeRKxu/uZig/T9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(5660300002)(6486002)(2906002)(86362001)(316002)(83380400001)(8936002)(7416002)(66476007)(66556008)(6666004)(30864003)(1076003)(52116002)(38100700002)(4326008)(26005)(186003)(2616005)(6512007)(6506007)(66946007)(38350700002)(8676002)(56820400005)(54580400013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YktYYy9RRnJXdFVaY0VZbjhtYmcvSjVNTkhROVlGajJHSTB5ZCsyM0RXak94?=
 =?utf-8?B?US9VbmZiQUhOMDAvcmI4ZlZud3FNQkdkbTNpMkwyZkVXZjFJSTZlQWkzVG1X?=
 =?utf-8?B?aUxCQ3JBM2lxMCtnd25yZFpjMDBPd0RLTDl6R1JlZTF3NFh4bTRYZkYvcUx6?=
 =?utf-8?B?UVRlaXFLa1Z5TXk3WEJnS3A4blJvKzNrclkwOWNrNWdIZkMvaDM0UzVlRXE0?=
 =?utf-8?B?RHBUL0pUU0Q2TlI3bFI4UG11blQ1RS9TZldoTUh6Mk1tWVB2TlNYVXQ5RFE1?=
 =?utf-8?B?aktaSjZTczc5a3pER1pld1dWZEFyTDBEcU8rWElQRnpxb3BOdUVHUGhZUFF3?=
 =?utf-8?B?V0pkVTZFQ3RkYlMyNVhRbUp6eGdEcmdyT1lscEp3NEdhWU0wTFVIVENEclZT?=
 =?utf-8?B?eFpaNXVJQkRGY1J4dDI3TldnUS91MERqb1MraUppckNvRG5pY3lPY204b2Rw?=
 =?utf-8?B?eERYaVNKZnppSDhXMVZ0bWlVV3VDcG81N3BieFNpaittRklHUHhPUUIxaHBt?=
 =?utf-8?B?WFVXNVRKb3diaUJGLzd1VjdHUXZoYjdKajh6T3FkaTNxdTFtT1Y2M2hieS9D?=
 =?utf-8?B?b2VmWFA0OUhWMml2enh1eCtFbVBYVHQvR1JmL2s1d2c0L3BFM01ZTTduWWc2?=
 =?utf-8?B?V3RUaUlnWFNyc2kxNzQ4ZEZLRnJUQXp5MUJxb25ESUFBeU55RmxoMzA3cjBn?=
 =?utf-8?B?ZlVuaFcxMHY5OFpOS01VcjFYcUQ1SlpQWVhYMzdSUVNHdFJGVU8wK0t3Rkk0?=
 =?utf-8?B?K1I1MUIrUWR1OW9LQlkxZkg0SksveWFJdGJkSDNVSkYzYlFMOS9OWTdzZlcw?=
 =?utf-8?B?S0UvTDlYYk4wUWVsbjBOaEJZYWZJTG5HZUdSZ0ZCaEpmZmhLNUhVd3hTZjg0?=
 =?utf-8?B?TnB6Wm5hUE01ZWVjVnF2UDl0VEJBd1E1V2RGQUsrY0t1K09JYkt2V0Qwdk1U?=
 =?utf-8?B?TXBDWVVWNEZSangrRDhwazNVWmI3NW9qd0EwL1lrNjczTXVaZlRXdG9WTkZL?=
 =?utf-8?B?b2hHM09mVHE2TUxuN1pXbCthN3VzWE82WTNCeTQzUlRMdHN1TW5hWGFhTUdV?=
 =?utf-8?B?cVJOSE9vdllNYVpYN2Exd0RXVDQ5bkhFelczSVJUY0p2eElxMEZFdlVUUUFM?=
 =?utf-8?B?aGxrdnFyVzluTFVnWEpJY0w0WFNiMjJ2REM3Y2toOVZmVkdhOE1ZQlFMOGU5?=
 =?utf-8?B?RHF3amQxdElTTHUxOGR2SnBjc1MydFZQME9KTW10KytpTW5aZW1LaXdZOTZZ?=
 =?utf-8?B?Ynk5bGVMSjQ0eWdaUVhQeS9sUStnc2lYOC84Z25jb0ZUemxScUtqVEY5UXFX?=
 =?utf-8?B?dW44Q2hZZVVFMXhMZXZPRklLMjlVeWs3S0N3ZGthUktuUitleWt2WTBUQ0ZT?=
 =?utf-8?B?TjN0MG9zWlY0cXlFcWdydDBhQ2JPdHJHU09JWVQvK0RLSFVidVhLU05zNy9o?=
 =?utf-8?B?S2ZSVm91UmhLbFhpeHVnNzhrTjUvUXFVVkdMQm1HeHVqN3dZWERVM3R3TFVW?=
 =?utf-8?B?T1dtT0ZNVWMyZ1pTa1dTNlpzbDFRRitmNlVHVjlPRTJmUTdpQlMvR0dyWlJO?=
 =?utf-8?B?d3BmdmEvYTk0QkYycG00ZWVKRmhHQ0FmNTBYRkpKME9Qb0pRT2dOYk94Zm8v?=
 =?utf-8?B?cU81M0Jlb0w3R0htVk5IWExDbzlZSjd2WC9WN0dGOXZtdW56YUNSQ1N6TzM3?=
 =?utf-8?B?SVcxTk41QzE5N21QRkpEWTBUSXRtc21UWElxSGZDS0o0ZTMvdmwrUXB0Zmlk?=
 =?utf-8?B?Ymw2REhOajZDZE1yNjM5aS8rMllzVVkwaEtKQnJlVUtXVXcrSHQ3MW9ac1ho?=
 =?utf-8?B?TUVZSEFFWVU0a001bEhHdzdsSElPOGMxM2xIWXN5aUgyRk1saTJsZS9qZ29h?=
 =?utf-8?B?YTN0S0dydmhYcjJCZWNzY0tyWFNFc01EMU9zSnk1VHB6ZHV1dkxjMHhIUTY0?=
 =?utf-8?B?eHh4dk1Dbmlsd0REQThwS05oZzNVN21GQmQ3RnZiSGJueWhHTmpsRzFIL3Iw?=
 =?utf-8?B?cDZJV1BBZlhTYnYwb3RBSlJBVC9GeTQ0eW1kY1NHWUlFeEFlY0lFczBmMVFM?=
 =?utf-8?B?ZDNOMjRnazh4eGlScGwvQmRzaUdVTzQ0RXNNd0JORmJTRkplUHgwWW9hOEc2?=
 =?utf-8?B?OGxYQTZ5TUcvK2VJckM1elRFbUxaZ3NNUS9nUytzL0x5UjlFSWN5YXNXOWEw?=
 =?utf-8?Q?GoEuprHuBGFIrRzvoeR8cVE=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2382218f-7654-4d32-c520-08d9f697a7a9
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 06:42:26.5551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SMShWcEhIE1VJwO/MrsH/jHE5eOtIWO953KdeCPJmwQyBbiB9XIMPbTciD+PHBjom5gjqx4y2vkXOf7ZPD6TRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5542
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        SUSP_UTF8_WORD_COMBO,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

This PLL module is a Fractional-N synthesizer,
supporting 30-bit numerator and denominator. Numerator is a signed
number. It has feature to adjust fractional portion of feedback
divider dynamically. This fracn gppll is used in i.MX93.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/Makefile          |   1 +
 drivers/clk/imx/clk-fracn-gppll.c | 328 ++++++++++++++++++++++++++++++
 drivers/clk/imx/clk.h             |  21 ++
 3 files changed, 350 insertions(+)
 create mode 100644 drivers/clk/imx/clk-fracn-gppll.c

diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index 36c04922d789..60c8a4bb7574 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -5,6 +5,7 @@ mxc-clk-objs += clk-busy.o
 mxc-clk-objs += clk-composite-7ulp.o
 mxc-clk-objs += clk-composite-8m.o
 mxc-clk-objs += clk-composite-93.o
+mxc-clk-objs += clk-fracn-gppll.o
 mxc-clk-objs += clk-cpu.o
 mxc-clk-objs += clk-divider-gate.o
 mxc-clk-objs += clk-fixup-div.o
diff --git a/drivers/clk/imx/clk-fracn-gppll.c b/drivers/clk/imx/clk-fracn-gppll.c
new file mode 100644
index 000000000000..6c9946a4bdb7
--- /dev/null
+++ b/drivers/clk/imx/clk-fracn-gppll.c
@@ -0,0 +1,328 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2021 NXP
+ */
+
+#include <linux/bits.h>
+#include <linux/clk-provider.h>
+#include <linux/err.h>
+#include <linux/export.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/slab.h>
+#include <linux/jiffies.h>
+
+#include "clk.h"
+
+#define PLL_CTRL		0x0
+#define CLKMUX_BYPASS		BIT(2)
+#define CLKMUX_EN		BIT(1)
+#define POWERUP_MASK		BIT(0)
+
+#define PLL_ANA_PRG		0x10
+#define PLL_SPREAD_SPECTRUM	0x30
+
+#define PLL_NUMERATOR		0x40
+#define PLL_MFN_MASK		GENMASK(31, 2)
+#define PLL_MFN_SHIFT		2
+
+#define PLL_DENOMINATOR		0x50
+#define PLL_MFD_MASK		GENMASK(29, 0)
+
+#define PLL_DIV			0x60
+#define PLL_MFI_MASK		GENMASK(24, 16)
+#define PLL_MFI_SHIFT		16
+#define PLL_RDIV_MASK		GENMASK(15, 13)
+#define PLL_RDIV_SHIFT		13
+#define PLL_ODIV_MASK		GENMASK(7, 0)
+
+#define PLL_DFS_CTRL(x)		(0x70 + (x) * 0x10)
+
+#define PLL_STATUS		0xF0
+#define LOCK_STATUS		BIT(0)
+
+#define DFS_STATUS		0xF4
+
+#define LOCK_TIMEOUT_US		200
+
+#define PLL_FRACN_GP(_rate, _mfi, _mfn, _mfd, _rdiv, _odiv)	\
+	{							\
+		.rate	=	(_rate),			\
+		.mfi	=	(_mfi),				\
+		.mfn	=	(_mfn),				\
+		.mfd	=	(_mfd),				\
+		.rdiv	=	(_rdiv),			\
+		.odiv	=	(_odiv),			\
+	}
+
+struct clk_fracn_gppll {
+	struct clk_hw			hw;
+	void __iomem			*base;
+	const struct imx_fracn_gppll_rate_table *rate_table;
+	int rate_count;
+};
+
+#define to_clk_fracn_gppll(_hw) container_of(_hw, struct clk_fracn_gppll, hw)
+
+/*
+ * Fvco = 𝐹𝑟𝑒𝑓∙(𝑀𝐹𝐼+𝑀𝐹𝑁/𝑀𝐹𝐷)
+ * Fout = Fvco / (rdiv * odiv)
+ */
+static const struct imx_fracn_gppll_rate_table fracn_tbl[] = {
+	PLL_FRACN_GP(650000000U, 81, 0, 0, 0, 3),
+	PLL_FRACN_GP(594000000U, 198, 0, 0, 0, 8),
+	PLL_FRACN_GP(560000000U, 70, 0, 0, 0, 3),
+	PLL_FRACN_GP(400000000U, 50, 0, 0, 0, 3),
+	PLL_FRACN_GP(393216000U, 81, 92, 100, 0, 5)
+};
+
+struct imx_fracn_gppll_clk imx_fracn_gppll = {
+	.rate_table = fracn_tbl,
+	.rate_count = ARRAY_SIZE(fracn_tbl),
+};
+EXPORT_SYMBOL_GPL(imx_fracn_gppll);
+
+static const struct imx_fracn_gppll_rate_table *
+imx_get_pll_settings(struct clk_fracn_gppll *pll, unsigned long rate)
+{
+	const struct imx_fracn_gppll_rate_table *rate_table = pll->rate_table;
+	int i;
+
+	for (i = 0; i < pll->rate_count; i++)
+		if (rate == rate_table[i].rate)
+			return &rate_table[i];
+
+	return NULL;
+}
+
+static long clk_fracn_gppll_round_rate(struct clk_hw *hw, unsigned long rate,
+				       unsigned long *prate)
+{
+	struct clk_fracn_gppll *pll = to_clk_fracn_gppll(hw);
+	const struct imx_fracn_gppll_rate_table *rate_table = pll->rate_table;
+	int i;
+
+	/* Assumming rate_table is in descending order */
+	for (i = 0; i < pll->rate_count; i++)
+		if (rate >= rate_table[i].rate)
+			return rate_table[i].rate;
+
+	if (i == pll->rate_count)
+		pr_err("Not able to round rate for %s: %lu\n", clk_hw_get_name(hw), rate);
+
+	/* return minimum supported value */
+	return rate_table[i - 1].rate;
+}
+
+static unsigned long clk_fracn_gppll_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
+{
+	struct clk_fracn_gppll *pll = to_clk_fracn_gppll(hw);
+	const struct imx_fracn_gppll_rate_table *rate_table = pll->rate_table;
+	u32 pll_numerator, pll_denominator, pll_div;
+	u32 mfi, mfn, mfd, rdiv, odiv;
+	u64 fvco = parent_rate;
+	long rate = 0;
+	int i;
+
+	pll_numerator = readl_relaxed(pll->base + PLL_NUMERATOR);
+	mfn = (pll_numerator & PLL_MFN_MASK) >> PLL_MFN_SHIFT;
+
+	pll_denominator = readl_relaxed(pll->base + PLL_DENOMINATOR);
+	mfd = pll_denominator & PLL_MFD_MASK;
+
+	pll_div = readl_relaxed(pll->base + PLL_DIV);
+	mfi = (pll_div & PLL_MFI_MASK) >> PLL_MFI_SHIFT;
+
+	rdiv = (pll_div & PLL_RDIV_MASK) >> PLL_RDIV_SHIFT;
+	rdiv = rdiv + 1;
+	odiv = pll_div & PLL_ODIV_MASK;
+	switch (odiv) {
+	case 0:
+		odiv = 2;
+		break;
+	case 1:
+		odiv = 3;
+		break;
+	default:
+		break;
+	}
+
+	/*
+	 * Sometimes, the recalculated rate has deviation due to
+	 * the frac part. So find the accurate pll rate from the table
+	 * first, if no match rate in the table, use the rate calculated
+	 * from the equation below.
+	 */
+	for (i = 0; i < pll->rate_count; i++) {
+		if (rate_table[i].mfn == mfn && rate_table[i].mfi == mfi &&
+		    rate_table[i].mfd == mfd && rate_table[i].rdiv == rdiv &&
+		    rate_table[i].odiv == odiv)
+			rate = rate_table[i].rate;
+	}
+
+	/* Fvco = 𝐹𝑟𝑒𝑓∙(𝑀𝐹𝐼+𝑀𝐹𝑁/𝑀𝐹𝐷) */
+	fvco = fvco * mfi + fvco * mfn / mfd;
+
+	do_div(fvco, rdiv * odiv);
+
+	return rate ? (unsigned long) rate : (unsigned long)fvco;
+}
+
+static int clk_fracn_gppll_wait_lock(struct clk_fracn_gppll *pll)
+{
+	u32 val;
+
+	return readl_poll_timeout(pll->base + PLL_STATUS, val,
+				  val & LOCK_STATUS, 0, LOCK_TIMEOUT_US);
+}
+
+static int clk_fracn_gppll_set_rate(struct clk_hw *hw, unsigned long drate,
+				    unsigned long prate)
+{
+	struct clk_fracn_gppll *pll = to_clk_fracn_gppll(hw);
+	const struct imx_fracn_gppll_rate_table *rate;
+	u32 tmp, pll_div, ana_mfn;
+	int ret;
+
+	rate = imx_get_pll_settings(pll, drate);
+	if (!rate) {
+		pr_err("%s: Invalid rate : %lu for pll clk %s\n", __func__,
+			drate, clk_hw_get_name(hw));
+		return -EINVAL;
+	}
+
+	/* Disable output */
+	tmp = readl_relaxed(pll->base + PLL_CTRL);
+	tmp &= ~CLKMUX_EN;
+	writel_relaxed(tmp, pll->base + PLL_CTRL);
+
+	/* Power Down */
+	tmp &= ~POWERUP_MASK;
+	writel_relaxed(tmp, pll->base + PLL_CTRL);
+
+	/* Disable BYPASS */
+	tmp &= ~CLKMUX_BYPASS;
+	writel_relaxed(tmp, pll->base + PLL_CTRL);
+
+	pll_div = (rate->rdiv << PLL_RDIV_SHIFT) | rate->odiv | (rate->mfi << PLL_MFI_SHIFT);
+	writel_relaxed(pll_div, pll->base + PLL_DIV);
+	writel_relaxed(rate->mfd, pll->base + PLL_DENOMINATOR);
+	writel_relaxed(rate->mfn << PLL_MFN_SHIFT, pll->base + PLL_NUMERATOR);
+
+	/* Wait for 5us according to fracn mode pll doc */
+	udelay(5);
+
+	/* Enable Powerup */
+	tmp |= POWERUP_MASK;
+	writel_relaxed(tmp, pll->base + PLL_CTRL);
+
+	/* Wait Lock*/
+	ret = clk_fracn_gppll_wait_lock(pll);
+	if (ret)
+		return ret;
+
+	/* Enable output */
+	tmp |= CLKMUX_EN;
+	writel_relaxed(tmp, pll->base + PLL_CTRL);
+
+	ana_mfn = (readl_relaxed(pll->base + PLL_STATUS) & PLL_MFN_MASK) >> PLL_MFN_SHIFT;
+
+	WARN(ana_mfn != rate->mfn, "ana_mfn != rate->mfn\n");
+
+	return 0;
+}
+
+static int clk_fracn_gppll_prepare(struct clk_hw *hw)
+{
+	struct clk_fracn_gppll *pll = to_clk_fracn_gppll(hw);
+	u32 val;
+	int ret;
+
+	val = readl_relaxed(pll->base + PLL_CTRL);
+	if (val & POWERUP_MASK)
+		return 0;
+
+	val |= CLKMUX_BYPASS;
+	writel_relaxed(val, pll->base + PLL_CTRL);
+
+	val |= POWERUP_MASK;
+	writel_relaxed(val, pll->base + PLL_CTRL);
+
+	val |= CLKMUX_EN;
+	writel_relaxed(val, pll->base + PLL_CTRL);
+
+	ret = clk_fracn_gppll_wait_lock(pll);
+	if (ret)
+		return ret;
+
+	val &= ~CLKMUX_BYPASS;
+	writel_relaxed(val, pll->base + PLL_CTRL);
+
+	return 0;
+}
+
+static int clk_fracn_gppll_is_prepared(struct clk_hw *hw)
+{
+	struct clk_fracn_gppll *pll = to_clk_fracn_gppll(hw);
+	u32 val;
+
+	val = readl_relaxed(pll->base + PLL_CTRL);
+
+	return (val & POWERUP_MASK) ? 1 : 0;
+}
+
+static void clk_fracn_gppll_unprepare(struct clk_hw *hw)
+{
+	struct clk_fracn_gppll *pll = to_clk_fracn_gppll(hw);
+	u32 val;
+
+	val = readl_relaxed(pll->base + PLL_CTRL);
+	val &= ~POWERUP_MASK;
+	writel_relaxed(val, pll->base + PLL_CTRL);
+}
+
+static const struct clk_ops clk_fracn_gppll_ops = {
+	.prepare	= clk_fracn_gppll_prepare,
+	.unprepare	= clk_fracn_gppll_unprepare,
+	.is_prepared	= clk_fracn_gppll_is_prepared,
+	.recalc_rate	= clk_fracn_gppll_recalc_rate,
+	.round_rate	= clk_fracn_gppll_round_rate,
+	.set_rate	= clk_fracn_gppll_set_rate,
+};
+
+struct clk_hw *imx_clk_fracn_gppll(const char *name, const char *parent_name, void __iomem *base,
+				   const struct imx_fracn_gppll_clk *pll_clk)
+{
+	struct clk_fracn_gppll *pll;
+	struct clk_hw *hw;
+	struct clk_init_data init;
+	int ret;
+	u32 val;
+
+	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
+	if (!pll)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.flags = pll_clk->flags;
+	init.parent_names = &parent_name;
+	init.num_parents = 1;
+	init.ops = &clk_fracn_gppll_ops;
+
+	pll->base = base;
+	pll->hw.init = &init;
+	pll->rate_table = pll_clk->rate_table;
+	pll->rate_count = pll_clk->rate_count;
+
+	hw = &pll->hw;
+
+	ret = clk_hw_register(NULL, hw);
+	if (ret) {
+		pr_err("%s: failed to register pll %s %d\n", __func__, name, ret);
+		kfree(pll);
+		return ERR_PTR(ret);
+	}
+
+	return hw;
+}
+EXPORT_SYMBOL_GPL(imx_clk_fracn_gppll);
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 63eb7c53b123..a7cbbcd1a3f4 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -72,6 +72,27 @@ extern struct imx_pll14xx_clk imx_1416x_pll;
 extern struct imx_pll14xx_clk imx_1443x_pll;
 extern struct imx_pll14xx_clk imx_1443x_dram_pll;
 
+/* NOTE: Rate table should be kept sorted in descending order. */
+struct imx_fracn_gppll_rate_table {
+	unsigned int rate;
+	unsigned int mfi;
+	unsigned int mfn;
+	unsigned int mfd;
+	unsigned int rdiv;
+	unsigned int odiv;
+};
+
+struct imx_fracn_gppll_clk {
+	const struct imx_fracn_gppll_rate_table *rate_table;
+	int rate_count;
+	int flags;
+};
+
+struct clk_hw *imx_clk_fracn_gppll(const char *name, const char *parent_name, void __iomem *base,
+				   const struct imx_fracn_gppll_clk *pll_clk);
+
+extern struct imx_fracn_gppll_clk imx_fracn_gppll;
+
 #define imx_clk_cpu(name, parent_name, div, mux, pll, step) \
 	to_clk(imx_clk_hw_cpu(name, parent_name, div, mux, pll, step))
 
-- 
2.25.1

