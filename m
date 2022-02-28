Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F5E4C60CF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 03:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbiB1CIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 21:08:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232419AbiB1CIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 21:08:16 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150083.outbound.protection.outlook.com [40.107.15.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BC79FF5;
        Sun, 27 Feb 2022 18:07:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LidbFeIHcrgy28RLlpfdsW0UApNgH8jfK4yTqDm6PEL23pdcbEtgXZn9A3ewrjlwY/DGp7dnIQ7pz3fgo9gJQeH4oudH+buzN0TISHSS340tbDYTD0tzx1kFwQFzCNodNiFE+iqT0iCa4LWd8+2ZoryuGnWRojOP+yKk5UMB/7L08RwNDt8x1gqaCdDWklD19JKRzV1Tz3ltZ8cBqChAYnTXiRBD/ckT4rjJDZvQ+dbyowKZMrntWXRSCGEYR5eqJf9r/t3t6wX/xUelMZHpDGcsQFSUziJ3wB9QcATuCJV6lY58T32AZ4qeeRNJ6S7uiY45u403KE3c8SFfK/D8Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9g+9CKeQ5Dn+IC8u70Km0ZCWZ0uS43pm4cOJi3IuQdw=;
 b=UuAcLQ/acxx2Ueq9jUECU3YtzgSipztaxwZw880GNSZPC+pGdo5zcyZpMM2v7y1D/BOrSHTar8cRZ8mnHTAB3eZCXa56wsJJr4go1g30n2TCssWDQ4mfqlrfHu4vWGgO7Mvt4jmgFmskn5lpnuRpvVP7ACspeyJrgiR5ryP6+IgXtAeKBUiILmeIn//BYx2Bod6/q/6jnfCek+c36spXZQaak/8BdWsGsCRzLcYgmPl4Im26ozxg6WEpKwBBOfv5IN/3s1IdHOkKH08l6zSzR0axxjNAurfZVQQK9e/PYbYyfrb9fE7/l6u4b0vJF+rT8hgHa0+HydW7/uOPnWHfoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9g+9CKeQ5Dn+IC8u70Km0ZCWZ0uS43pm4cOJi3IuQdw=;
 b=UBz27f4zu5FagAE3UbTvOlsgcQPxSA8l4ZU89IMrbYEjSGRHNW2WVJUA76kyxoTau280nKeFuy5E00FMVUyv+55GPyEKcqgbO2HvN/DUd/QzDogHGM1qOwdk1NjOtnR3bU1VQraX1Fu9zjAjdqT4gBn3Y9wUjiBvsc6y+hdz8HQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8734.eurprd04.prod.outlook.com (2603:10a6:102:21e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Mon, 28 Feb
 2022 02:07:29 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc%4]) with mapi id 15.20.4995.018; Mon, 28 Feb 2022
 02:07:29 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     sboyd@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, abel.vesa@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V6 3/5] clk: imx: add i.MX93 composite clk
Date:   Mon, 28 Feb 2022 10:09:06 +0800
Message-Id: <20220228020908.2810346-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220228020908.2810346-1-peng.fan@oss.nxp.com>
References: <20220228020908.2810346-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0218.apcprd06.prod.outlook.com
 (2603:1096:4:68::26) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f18fccef-8474-4866-e53f-08d9fa5f12e7
X-MS-TrafficTypeDiagnostic: PAXPR04MB8734:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <PAXPR04MB87343820C6918D0CE0EC69EEC9019@PAXPR04MB8734.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AXSOg+LcU0tdxtJWV50Fvh0C9sBaGX+5IoihRZyw8NGqu0JHLdEzRi94us63JpJO+LCTnRfZ6tl45Op6nSmLEy9/vIh9cfPYQMZCJKaEgg//fLIpXmQ0qydKd/X5BpRjlmp9OMk9LWM1j8OuEjOrFlR9bSbFxFnADuIkPX2NdS5aqA7GQVYKSeghU/PXduT2UNRhZ+bVrq49EvRACcS7YHXZq6BzXAeFo8QN+hc6DbhnRAR6wA7UBejw+nqqx6A8eg7gNOZWLRjvkJEDvmCZRvYCojdRtFaLdFz8ZvtX+PrVt6lgiZXAh3Zej3UqMvUs6vsagMRXIayWKc3GQL+iqy2jqaRC1de1Vlu4Myqn52WJF+GNkQTFm/5ORsakboTYoOjedUIs6Oz2RP46iZVVMPspIv8IILN5BZLRcMp10U4WPkEI2HHFdVxOKU3+3/NPfPa58t7C2OYTJByqKkpIdsw4xbqIFKN11pbErxS36ob87awOE2bIQFqi3KcRD5Xb8W1nDGtSOs2uWWG4IuFIJ9hAujCd4eBDmI5UjjtEZTpDped6rHxLfiWxFOWSbgcIfA5amRU91zX8WJXm/nmRvC1ZIuqXhtXtTnq/hJDhIYfmqazp4sLlh8/aILr2kuDyYtOHu1rYWNWBbGrtc93S7IlPr6zn1pxR089/xSApw2fYYC8dMXd0qU9yCAh6hyNhuRCmv956aZTBdsnRpoZSLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(5660300002)(66946007)(7416002)(66556008)(1076003)(86362001)(83380400001)(4326008)(8936002)(508600001)(186003)(26005)(6486002)(6506007)(52116002)(8676002)(6666004)(38100700002)(38350700002)(316002)(2906002)(66476007)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SrUgPSWi9TNwDQTmXNip0xy7YBTlYW5CYgx58w+H2kPRb0GErSQ3fF58fHOt?=
 =?us-ascii?Q?CqpNZBDo6OpqgjfTYU7f0krRt+v+G2DveSL0e+aM6whr+oQgEfYmu1NueCWh?=
 =?us-ascii?Q?bsTBIPlRFQqUrm3nI3ZSxIer6/Ht0ZjhH3PIOCZ5auAotN+EkDs9GkVi+yRK?=
 =?us-ascii?Q?+/P1eVNkvUSl89NuTIZ3SfReig1M+UbUksrpAgAfJ2UkldxkgbePrivh9Zu4?=
 =?us-ascii?Q?LfUFQpQAZ1OrVShM5B2WP6lbC7/qIE3Z8G4P4xNv4RDRmHVtcchO/dkH+Lpk?=
 =?us-ascii?Q?ddzizE/S+TzavB2v8IGeY6OD9LBkvKeTpnLilHed9W3okS4b6ib0aOs3s9dw?=
 =?us-ascii?Q?HmqaHyiQIwMggNzBdBXAPHRCyZ1oSR9nwOrTeFSLmEh2b5ei5cWGruC/aMvg?=
 =?us-ascii?Q?BX/oE3GLynlL8ZC57UiK8gBKa5dE8Nwr2DO5NKEaqOZ+LRlNmWC7hhm76Hbo?=
 =?us-ascii?Q?CA/VEpVHQaiORde932LRajwgZ7YK/8tkwV0y9PUtlHIXlJWfSPjnLXCTij7K?=
 =?us-ascii?Q?SvcXlGRZIXZ9CfkkaC7n/Vf+Gh1afIVDygeoUmZFB66oDqlQ1YParfOFXVAg?=
 =?us-ascii?Q?yfUXLghGQKWt3SsK9yRzwf99SHueqhfdxQzJ/fwqWEzdUJ1IiBozttpe30Fx?=
 =?us-ascii?Q?kwOL+Ud/+DI9NTzawzjxFnSVvEzzItGSM0BwfReC2FPVuZDarBRmlQ+wj5Zz?=
 =?us-ascii?Q?2q8BeTPfy0wDkvUUukymkhF7xB5a51ehDsocFDymLJ9oHXqMXZhzuwAR3wcI?=
 =?us-ascii?Q?W3vpC7J10esqXMfr9LEqVIWmU1giHAg18qRyWQnxr2lj4mWWabejQd3qmKlA?=
 =?us-ascii?Q?GxA8T2rJ/bghF3ez7BL++LwIWro2vwvir4TK6H2uBqoOKJDX1xY5f7ElM8S0?=
 =?us-ascii?Q?kLSakRAqyat1DRJdWdoyk3rmqjNH1uk2XP098Rlm8tljh1zNDopkMMTN1ynC?=
 =?us-ascii?Q?Q5c/jvR1XvN4ur91QMivu96pYGXrCNQKGKfPBW/NzL1ssYMwab1D8fBxZsTI?=
 =?us-ascii?Q?E2T5ZHuyoTq52/ndLXbw4gFBDtcDcit1QZYoKNMFTpOM5N/VOJuYZ4XpZ0A2?=
 =?us-ascii?Q?XHftnwrQzFE1m8wGzgdTPXHByCGwf8IDyg/e0qUMz4OUNLFBD3c0s/+T3prG?=
 =?us-ascii?Q?B2kJBeg1ckBh84iMMOC9qmIwWOSf3hepOcHnRuljGABcdG0B17lzkA9J5ZHs?=
 =?us-ascii?Q?bt6080d8mYJRagVMAAW0pFY8f6W9KPRID1sLMMPNOlQXOb90etoKlm85MeBZ?=
 =?us-ascii?Q?W+Ny5IQbBsnVm9MT38GTudwpa13xlcuSfKKGuAYNbJ4vWXg1einqiFbCB+Ff?=
 =?us-ascii?Q?1lNtwWQeaAsizeb4K1OMhM75DsimlJxmA7gLVh/zCO0v3sqTuS93mas/vJnY?=
 =?us-ascii?Q?tm/l2ggNsYka1sZt1xMaAQMv0D5Lhtsp4x4qAU/M171m4jhA9ujr2KtoVpZT?=
 =?us-ascii?Q?IlLJozM1MTQ2NuelyYrF+AQwZ11qqQ3LxWBq9Cl49p4rjsBGfdYtuZF6utc0?=
 =?us-ascii?Q?+W9tRohjMn0zfvlkYX8TwZRxTdOYB9BWdsEH261mZEBALpK0/A0Pjm2w4Ajv?=
 =?us-ascii?Q?oVLsaAyFNbH0avvSn2CJID2yVKv5vyHZKYS7tx206I3Ew6hnzUDrRtgicTlI?=
 =?us-ascii?Q?g+D4wCv4yfbokI4GsYldJx4=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f18fccef-8474-4866-e53f-08d9fa5f12e7
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 02:07:29.7234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /7RZY8rRikj6B7SdhxzAZ20q+Gdg1JhPfpc/AN7EFVbahxe3fXXoVOIkapk9KyK6UN43CGHpnwXyFDMglvrRJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8734
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

Reviewed-by: Abel Vesa <abel.vesa@nxp.com>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
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

