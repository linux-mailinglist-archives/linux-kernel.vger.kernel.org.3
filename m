Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A484C06BF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 02:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236552AbiBWBPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 20:15:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236348AbiBWBPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 20:15:01 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2044.outbound.protection.outlook.com [40.107.21.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88DF237BD7;
        Tue, 22 Feb 2022 17:14:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DfJLSxY/b/q42grkWCs5lRb4gxH475BLXjzlEExFklSkZsogLFiHH0OYVD3cpQedFAcPLnjjecP7cEqm6dBl1Ihlh9f4fne8RnXY0nPS4F3ZHC1YO1ccVs9G7keW3zz8HdVTgnAtR+KI+/bfNMYLxbwrTK2rYQzxKTlBf8yRvkCZ/kTa+mnfLotER6Fo3Y0+0hN15+Ft8JZd0NMBULQSY/6ylmnnVMcyiTaL6RWYko3s0ftX/tIb48RrvxSbxQhnWBmFVqgLIiRKlBYY/Atpx3ElB0OZDPM5sgA5+MTT8dCdV3JvtJzccnMFnmOWJu1vb6XJghUne95yQr2BuLLINw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wBo6xUQstTajzmmzasfrW8BSwcQhXzhAHn0emp2VY/I=;
 b=JfZv1Q0Ig7rx97TE1v/Ie+4W3Ee9rK3XIiKeGDc5F8M9tjH7uk9+HMkVtyuJMcJpKZHQQaMa5gQPjwDB3pXvQdZr+hG8B5pOTIdOhp8ETZvFe1M61uK2RwMnwckXTiGgXlCdo4ToJKHuJcoaKGolQnaYTpz3Jhjq2XvIhIWs9Dw0Z8yrmwN5UQiAlYi0QKoZFS1a2G/qwAG4dkkrI59fYurUnC2kvlCi8xJ74zuPG4Z6coMsMWzTOS1juUlWr/hSKjaK9Dywx59vw58Unp5NnlG4qhFAegnBrEgNeufAADu7zMbIOzo33IVkuIycjNg/WheJzMIP9hhCS9pZHq0Oew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wBo6xUQstTajzmmzasfrW8BSwcQhXzhAHn0emp2VY/I=;
 b=O0Gl6Lnav/FROnNN7Cb/gP+oamTqF8g1cIf0o4zGoVMLRqv7Ut6ZdsjI2u3TSqDr2eVJzqYVsLHPm/HCPIpNqwWEZmYR1FoDhRwAIQ6Q9FcPS95Q/6tkIjxf9zi2rsHnWDPJeYED+5lJKnC/sqaDmgmquf7j6XLHKBNMBll7CiM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8533.eurprd04.prod.outlook.com (2603:10a6:10:2d4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.27; Wed, 23 Feb
 2022 01:14:30 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc%4]) with mapi id 15.20.4995.018; Wed, 23 Feb 2022
 01:14:30 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     sboyd@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, abel.vesa@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 3/5] clk: imx: add i.MX93 composite clk
Date:   Wed, 23 Feb 2022 09:16:04 +0800
Message-Id: <20220223011606.3282165-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220223011606.3282165-1-peng.fan@oss.nxp.com>
References: <20220223011606.3282165-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:3:17::14) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28fd7a29-02f6-4cb7-e97d-08d9f669d7eb
X-MS-TrafficTypeDiagnostic: DU2PR04MB8533:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DU2PR04MB8533D8B7A86D5D45221A6F81C93C9@DU2PR04MB8533.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qc4k8ymI1a7gpuPt8qHMASb0P8+4l2rJbT4dfbocOR10e+xq65XBE0tys2sjCr6u8uFxJqf36jHqq+otaiJFst7FVenYOlcDLL/uY9dxxQ9zsgnqRMUhp/p79CxBVcMPuG7y5i529hEKww0p5EY50mHUjovnm6UeoteHI+p8apQ3icIxq8DiaYifSCgeQxr1z2jVE9yva3/k7GHR85XNCGb3GWmtnrwPgiWVYadXdO/iBjHhIQWlOmRzErcCfkix3VcDUjQQgBBbPln90xSqd/ZRj/jp523gXcbdgju5W76ohorPQ6dcMqt65MpEPiEJWT6hpyLdhlXbNql0KQu8rbP6eEZpiaT15wKtmJluvInvspVaiJoJu8ct0UI09VY1y21kCP0nnyOkbHiZGAAQGgVBIfD5PUQrLG/nIi9XxuwdcvvbnHRnbegngX14zTJu1CC4iY+NQ60n2t1cAbRSoFHmPLdHZgY8LKW5RLxd1JcO3IF2VzRFMg088v4PK4DSal/jblC+y6lYASmOTxsQmv/iKa8EmYNiHMtK8CfaxK3HxsG3N5V2j4t3/KHSv86dekFJ9ajab/YSp5u4Sw1llQBWX1pCiH8b+3Jpbsy3uqYvw984iD+qxWb3DThjLshQGuf9lRTA09LpcTdHqteE2kncbTBLudzi6yaLtGzibSfHTubjRMNxYIw3hqV0bnawm407evHaVlB4Y77EdfobNg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(26005)(1076003)(2616005)(8936002)(2906002)(6506007)(52116002)(6666004)(7416002)(6512007)(5660300002)(86362001)(38100700002)(38350700002)(83380400001)(66476007)(316002)(4326008)(508600001)(8676002)(6486002)(66946007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tzpf2THj4MOzjxGIGnXU9TtgRpByrelVGFqRL8PiaWkSkSpJ6y6ijHXsI3Q4?=
 =?us-ascii?Q?2zObCz9gtf/ZSV1IxYvEVMx7uyWerOyrvfGMFYrhQH9CPEElX9P3FXNn/tpp?=
 =?us-ascii?Q?LD/2dDQxRwMsmdFT3RWqwQl6xBjoEg5awfCEW2yEAkQ0t87t1xc7oynAqOrP?=
 =?us-ascii?Q?Ml7D4nqJDpEANl/YrEitLoowfMAkRMPb3v+Qwg2Km/pzXm+T+BTZDy90Kw3c?=
 =?us-ascii?Q?fJ80+orgDzUMBLsRgaZaxt6OwcOxM6Idpm8EijH4nuxY7p6Rp5U/liZxs2WA?=
 =?us-ascii?Q?UWFld/Eg9QNSgQBmUGDdd5BBzrxdutje2Bluzt5MF5QStN9Xx6QgmBWkA/7V?=
 =?us-ascii?Q?QfA0lDz2XIVYm7tr1ABX1Z5vKM9shCUpi5RRC7z4UiW0TM1vUng+7xP10qr4?=
 =?us-ascii?Q?/N4t2nzJ1gGaWa2JPdpMb+0GE8FjVDf7Wb6GC/NE4fVM5lCnadtFJDq/wFdj?=
 =?us-ascii?Q?JF4IYQqyb5bjzQOpN3bVitlQklcmG6Vm/q3EJhADky6hyRhuv5mGCIItFi6o?=
 =?us-ascii?Q?rU9kVv9ovmNkRfsWBx/s7admqmKE6L8ESmce9YVal6QWU/9zx7YelGbXlwi6?=
 =?us-ascii?Q?Wo2feHmpMKwNqPWppPH9Ls7DILRE2UJ2Bt2z/s3w9YrCR66/8So2253Gr8QW?=
 =?us-ascii?Q?2zx6PCNjyAhwZgVGfXoLXun4kjVwfOiSF0RscWyVEtQA9jfse3Gzuf+jPkKf?=
 =?us-ascii?Q?QbvT0/kLenCNqtuaHCqRqADL6FI9auJi35ZCd7R7QW/vqTdXln/zPMNOmNR3?=
 =?us-ascii?Q?iA99dJfiHB2Z22UN362CzXcPsmyyNDAtTiSzW8V2fO+xcMwQ5asPKHfcMXRn?=
 =?us-ascii?Q?El0x+UNKp3jS5X4uAUSp/1ecLbDcHEbBmYbbNkQeuWJgXU4VzPqZYjj0v9f5?=
 =?us-ascii?Q?xgkhctTopdA3VvHfF3QjBGrnGa+cPeh/Xnaq+lbF+HqALt5bnsh1x+67fZ/j?=
 =?us-ascii?Q?orL1A5e9l5i8kpndF9KWBv+/nH3lXcnKucDFy/WpwnXxttC6zP8V8Nl7E57D?=
 =?us-ascii?Q?y3oj/J4vG2E1D1ah7gVU2Ee+vDBfjZIL6K848itoDebxr5JsV3qHRgVQyn4L?=
 =?us-ascii?Q?NUlL7wE16UZD50CvNONl9BYX+ozzgnQCJ/fUiVzWpq2LauqtkWKomPX4d9UL?=
 =?us-ascii?Q?wSNZ2lMK+/77pNYl2M5op9F6H7DLsPDSrBKP8UuDl893fOulvZxObWzV8qqX?=
 =?us-ascii?Q?NvD1Iw14uIaUkznwpykjI2dyR1NClefmROAMqbORV09BaQhou+wMP6M/QgLO?=
 =?us-ascii?Q?aB6tEiTGQcueik1YQ8NYT8AHPF1AbKxv4rUNhP6GZ6rQia4u0tFwyhiT/Pi9?=
 =?us-ascii?Q?HJZxptS6qCxc55w7G/L4MuH9lms23fodVNq69J+qvi0H3pu+RXTh2oVUoDbx?=
 =?us-ascii?Q?oPZAeI8JukyKSxOfH6qvcDuwdFB2/1kkNShMF9z01VmW2lzaSwF1CkB4sfAT?=
 =?us-ascii?Q?xHuMZSjN01c4CzwWBhEk5ZIsMgJykLuXRk0MIJWVPrJeLoYRmrWL8WGx0+Ln?=
 =?us-ascii?Q?vErHFdd8bUPVNvsMlbDvmbwt//xYc8FRlDXHl2wBW9FTPoA5a7eIGc8+DkKD?=
 =?us-ascii?Q?OQxJ8gBzxk6pOaB0+jKretnokebne+NZJPJHn/Bfv8W86CUlfzvJ0vE5yTAp?=
 =?us-ascii?Q?hx6Zs5J3TFoZTGJlMWTZZtQ=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28fd7a29-02f6-4cb7-e97d-08d9f669d7eb
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 01:14:30.6072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jla4B04xF5jDt50DHKr5kwxXW1nD6TzzUaY6uS2HUliMwEDF9NL2xO9ex35wtHYvfTlJX0J+MmO+BhN7hJJ1Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8533
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX93 CCM ROOT clock has a mux, gate and divider in one register, here
is to combine all these into one composite clk and simplify clk tree.
i.MX93 CCM is a new IP compared with i.MX8M, so introduce a new file.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/Makefile           |  1 +
 drivers/clk/imx/clk-composite-93.c | 93 ++++++++++++++++++++++++++++++
 drivers/clk/imx/clk.h              |  9 +++
 3 files changed, 103 insertions(+)
 create mode 100644 drivers/clk/imx/clk-composite-93.c

diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index aa8f5204d7e1..36c04922d789 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -4,6 +4,7 @@ mxc-clk-objs += clk.o
 mxc-clk-objs += clk-busy.o
 mxc-clk-objs += clk-composite-7ulp.o
 mxc-clk-objs += clk-composite-8m.o
+mxc-clk-objs += clk-composite-93.o
 mxc-clk-objs += clk-cpu.o
 mxc-clk-objs += clk-divider-gate.o
 mxc-clk-objs += clk-fixup-div.o
diff --git a/drivers/clk/imx/clk-composite-93.c b/drivers/clk/imx/clk-composite-93.c
new file mode 100644
index 000000000000..b44619aa5ca5
--- /dev/null
+++ b/drivers/clk/imx/clk-composite-93.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2021 NXP
+ *
+ * Peng Fan <peng.fan@nxp.com>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/errno.h>
+#include <linux/export.h>
+#include <linux/io.h>
+#include <linux/slab.h>
+
+#include "clk.h"
+
+#define CCM_DIV_SHIFT	0
+#define CCM_DIV_WIDTH	8
+#define CCM_MUX_SHIFT	8
+#define CCM_MUX_MASK	3
+#define CCM_OFF_SHIFT	24
+
+#define AUTHEN_OFFSET	0x30
+#define TZ_NS_SHIFT	9
+#define TZ_NS_MASK	BIT(9)
+
+struct clk_hw *imx93_clk_composite_flags(const char *name, const char * const *parent_names,
+					 int num_parents, void __iomem *reg,
+					 unsigned long flags)
+{
+	struct clk_hw *hw = ERR_PTR(-ENOMEM), *mux_hw;
+	struct clk_hw *div_hw, *gate_hw;
+	struct clk_divider *div = NULL;
+	struct clk_gate *gate = NULL;
+	struct clk_mux *mux = NULL;
+	bool clk_ro = false;
+
+	mux = kzalloc(sizeof(*mux), GFP_KERNEL);
+	if (!mux)
+		goto fail;
+
+	mux_hw = &mux->hw;
+	mux->reg = reg;
+	mux->shift = CCM_MUX_SHIFT;
+	mux->mask = CCM_MUX_MASK;
+	mux->lock = &imx_ccm_lock;
+
+	div = kzalloc(sizeof(*div), GFP_KERNEL);
+	if (!div)
+		goto fail;
+
+	div_hw = &div->hw;
+	div->reg = reg;
+	div->shift = CCM_DIV_SHIFT;
+	div->width = CCM_DIV_WIDTH;
+	div->lock = &imx_ccm_lock;
+	div->flags = CLK_DIVIDER_ROUND_CLOSEST;
+
+	if (!(readl(reg + AUTHEN_OFFSET) & TZ_NS_MASK))
+		clk_ro = true;
+
+	if (clk_ro) {
+		hw = clk_hw_register_composite(NULL, name, parent_names, num_parents,
+					       mux_hw, &clk_mux_ro_ops, div_hw,
+					       &clk_divider_ro_ops, NULL, NULL, flags);
+	} else {
+		gate = kzalloc(sizeof(*gate), GFP_KERNEL);
+		if (!gate)
+			goto fail;
+
+		gate_hw = &gate->hw;
+		gate->reg = reg;
+		gate->bit_idx = CCM_OFF_SHIFT;
+		gate->lock = &imx_ccm_lock;
+		gate->flags = CLK_GATE_SET_TO_DISABLE;
+
+		hw = clk_hw_register_composite(NULL, name, parent_names, num_parents,
+					       mux_hw, &clk_mux_ops, div_hw,
+					       &clk_divider_ops, gate_hw,
+					       &clk_gate_ops, flags | CLK_SET_RATE_NO_REPARENT);
+	}
+
+	if (IS_ERR(hw))
+		goto fail;
+
+	return hw;
+
+fail:
+	kfree(gate);
+	kfree(div);
+	kfree(mux);
+	return ERR_CAST(hw);
+}
+EXPORT_SYMBOL_GPL(imx93_clk_composite_flags);
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 7d220a01de1f..63eb7c53b123 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -419,6 +419,15 @@ struct clk_hw *__imx8m_clk_hw_composite(const char *name,
 			IMX_COMPOSITE_FW_MANAGED, \
 			IMX_COMPOSITE_CLK_FLAGS_CRITICAL_GET_RATE_NO_CACHE)
 
+struct clk_hw *imx93_clk_composite_flags(const char *name,
+					 const char * const *parent_names,
+					 int num_parents,
+					 void __iomem *reg,
+					 unsigned long flags);
+#define imx93_clk_composite(name, parent_names, num_parents, reg) \
+	imx93_clk_composite_flags(name, parent_names, num_parents, reg, \
+				  CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ENABLE)
+
 struct clk_hw *imx_clk_hw_divider_gate(const char *name, const char *parent_name,
 		unsigned long flags, void __iomem *reg, u8 shift, u8 width,
 		u8 clk_divider_flags, const struct clk_div_table *table,
-- 
2.25.1

