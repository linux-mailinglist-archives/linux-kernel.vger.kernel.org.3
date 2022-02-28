Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED15E4C6CC3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 13:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235092AbiB1MkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 07:40:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbiB1MkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 07:40:02 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2072.outbound.protection.outlook.com [40.107.20.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8994B872;
        Mon, 28 Feb 2022 04:39:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fx/E40KikNVdeQ6nIiTGUzaqtifSeAMx7WFVZ/min4SctTCIr+fwrAky/rIlLGm8V/2mQJMgqxI7VI+NG5UyPp2L7eCsnZ5Js76PioE2UEUWAR+DH0LbkadxS0y++YQK3A+1briAOPyhTk+eeNnpXBsv2o6zlP0LfdQxl1THh+VXgraLFA1awTPtJR5qD+y9cMw7RP3ej9pBJk8a2FHwy4gISCVcOB5QC8cuwd4xTN/YQdoPnhO+QecUbNpsilrJRCxzAuLEZwyb3JgsrU9ge4IEnqRmjn/uI3kRtHgFnZ28Vdeny21kW8rYItP5Xzflu3y64wEc3w9D5J0w8T2FhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pjErVDgzLKob/5s4oNin+d/QKtlhkrovjFnGgkbQHm4=;
 b=UpmuIHPYlUIbXjWVdCZTM5eUYMWOPqFrtT5N4a1PO/ZDqSEPHa+xTpCOlXZMfQYHDaBn8LFJUPD3rDXu52vADGdSy+M0tFb2d16V636Xcup+O1wKR7BujllLDCxfYMh/y2y3rlu0EufHZGsFCam5BrBM9NRt7rEBiREXGsVpmnUiPL3v6bYXqOfW61frmprjApcVtdAVKkW+SVkuDRha8oiFCC1ifQjRTdM8wjlJMPQs3fXdPlPPdzQVaD9E1yd57MACjAOHkOISFusv2Vu/YND8Lhb1AUCNZ9x/Uk87phl04ksSupte9gJ0MjrJd4hN1B27l3JjABvKZFLKp1iaKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pjErVDgzLKob/5s4oNin+d/QKtlhkrovjFnGgkbQHm4=;
 b=RbfxPPdb5Z9FXWRLOMMVVeH0PEgPCnFBWZ4aTRfIosRU8AV5hehhPjhZ1iRtrdkplhAg+tPA5GTvR3r8zSm2gTg42PgkR5WxH85HOsjalt7rCRzt/BhhkgMj+CEcuD+HGNSN60H0swsNcSuKykaa98Z/QrsiVxfhkSYAIaKA+rI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VE1PR04MB6384.eurprd04.prod.outlook.com (2603:10a6:803:126::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Mon, 28 Feb
 2022 12:39:19 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc%4]) with mapi id 15.20.4995.018; Mon, 28 Feb 2022
 12:39:19 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        abel.vesa@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 1/2] clk: imx: add mcore_booted module paratemter
Date:   Mon, 28 Feb 2022 20:41:11 +0800
Message-Id: <20220228124112.3974242-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0033.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::23) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20b3f65f-173a-405e-4bdf-08d9fab75685
X-MS-TrafficTypeDiagnostic: VE1PR04MB6384:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB6384420ED74C3A27D65E738EC9019@VE1PR04MB6384.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5IItSQxjKvpZF7JIyArZqUpiVag5iyWJ2VKh+h9Q2UEtiF46mdJ0Hv1HdnSjGz3D1+CMEiwgDvyaU49gS2hyXNcgcdejPSqnjJ3pImA5AUPcFu0etmT34+sFdrUpzXtHdAvLEUSI7a1gLBjqN+uWXQfJPZ6LDAp3uTI9nqjWwTOlhjYO6SWwCdcKDDzEWrX4NroVIv0nBpIT35yDkNNzjAMgWYDFlgmYPnNqUQJLMCge+qx954OJZr3YDOMJyOE8uG9/49r8oMdfYu3vzvyLS/OSyMIybc+N0/E4mZGLuU9nWJ2yrqBxTinp/2jXIcr9IXT9zuId6gROaTKA25RDTL0+vWJnnSI12G7ANaPvY/MQIAB8hIDtaxL6vkyua/gwKyKPSpFGdl+hC0NJ+PaTqyO2lVkBjbmmG0oVi76cCDmVf74+xe86iuh85P80pk70SsEzZ5NuYHtm1MWlcm9XexsOBiQ/1M8f8wk5IegaHy5MB2eXcT2vmXjHTx8TjiK5Rq31Sn//DmGgpFrDj3/TUFLi1QvLsKceMR9x1IYzfP/VzMureLD4Duq9k2XDSNtxxyxUjhYDLY9upIcQaM34IIYh9LotRr3kl56zY3vUVC4iP56L1lzYBusuXBmji/UuDCy0wJCNCW20rNg8HSkJN8m3oCCn+rUu/feTT8SWoTZdGMaWOOjO4Od+BlumlYrGzDMAJgPp76MVX/cdMhka4g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(52116002)(2616005)(1076003)(6512007)(83380400001)(186003)(26005)(6506007)(6666004)(508600001)(6486002)(66946007)(316002)(8936002)(4326008)(38100700002)(38350700002)(8676002)(66556008)(66476007)(86362001)(2906002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9Jm3eviSlt09b7IHjTPwQ4xJHZv5JowB6P35Js9RRZBBnstsgvY6PS5Hr8Kh?=
 =?us-ascii?Q?A9ZN16EPDu5WZIfD8MdKP9LRRt8Z4neBlocucyPhlbqFxI3L9ekUuRNPlrWr?=
 =?us-ascii?Q?doGA2cFr9OO/8131Ze7uVqTnEqASR7I4GMCvrhvTsypv00/RIReaKi14Bz2f?=
 =?us-ascii?Q?BAJd239fNC+qeglsgbYUkLv1XIa3zR6YPJqWXOs2ZPaFXHYQRWKyEFOn7tyh?=
 =?us-ascii?Q?ZMWIJ+BFViv8aNTC/uuMi2qxxRfG4q/tteE5KQPVBIZRJhGnwJ6c9Ln3Mrtw?=
 =?us-ascii?Q?dckAGnAnbLcqRFcQu9VY1DdQdA/RrLzZ0dSvYSIbz4CkWbonctwH0RcbjjsS?=
 =?us-ascii?Q?yaECCY3H9gCy2knThzgh2VkIY+Ao+s0zsQZesMxzcLBqr+TfFdQ3FsfgaX+f?=
 =?us-ascii?Q?1AWcwmWH2hUUzAB1K1JCa0k24EbPlS7e8MWcieNYw383hv5va2voByt0iAdX?=
 =?us-ascii?Q?xvfa98tOYvbCy77RsIc+7/VOrpuTu6GdmMWPCkToa+PXea3/6zDgoG9b7EKU?=
 =?us-ascii?Q?wvKRhsFQSp3Lg2N4pON1JBtXRuS/DrA3EqL3TlGATpuI6royhysWQLXR44jK?=
 =?us-ascii?Q?7Afxrxs+kBXS3YwFuWekRFhjlcRZ+p9X82cP4buUuSBDGgNfojkYWDItzTO9?=
 =?us-ascii?Q?W715pkEirOCTnIXoZsog0jqI4DnMNRNQGIy7wnxY3wBAenDuBLumRmLjRgU8?=
 =?us-ascii?Q?ucIu/IpK035QSMRdyu3nWecI42fS4s8rDLlzBaRXZ5Orke+/WMS3IMh68N/T?=
 =?us-ascii?Q?ZjgJHZOxu5aetKSrKC26ytd+ENQZpQDN/u28+keqnj4TAbXIpRT5CpbxG/Iq?=
 =?us-ascii?Q?P1Rj6NdDCkK4YEjKg1jyAhR2XrU/bHuB3uCOFQVjAVdVaV58krW1WeMa5o3z?=
 =?us-ascii?Q?lmOkwezr2aOtq/fnqr858lE8onImFmvPeE3lP5/OaRF6iQ7NSGNvBbzcx3Zl?=
 =?us-ascii?Q?D6emRy3BTKp2govHp3LsChk8q3RRC5ZZol2u7kZEQHwEJhBuveeaL0JBGzNX?=
 =?us-ascii?Q?Txh9P3FUkccqcbhHziH11VKDJlGRuZI/48TIYu2nzewJGM7zja7VqFQ9I4Ec?=
 =?us-ascii?Q?5ih1WMdUcRZWaNmxQWwsp7GJj+EXxBUJl2vTORkOShujqxVnkxJUqSeQkLN5?=
 =?us-ascii?Q?uqK426IJbJWGSSv7USYIh7KGtb2u8eZWrZqCx81cvZp1Xrt0Tn7WgHCylz+G?=
 =?us-ascii?Q?ivh/3JN+7ropeOnzN56FKnXkWNZM+rJn5rk6tYW+Zl36TgbsBWsmcS8FijJ1?=
 =?us-ascii?Q?/5glm0wMqqMNDhzxsmxuW7R83QYFgdVvZ1QQzvZUINqbtGbFVp0ph3y5qdtF?=
 =?us-ascii?Q?Eg6shERT4hKopryar2Q3o8bLX2FC6xHn3O0jVfcvNs0VSjOTJLDUW6Phlozt?=
 =?us-ascii?Q?2HO9Iye7Q954AZ+KpgkQAq9l6YHcDbt6eIzS9iGTZSIpEfyj7z/80ox7GDYf?=
 =?us-ascii?Q?u3ridi88YrFz+w08XddKieSck4IHhz+lBqdt4EcfXnadzNAGLUvU5xZtqX9o?=
 =?us-ascii?Q?ySdIYDGY1PYOftP3d80+s6v4CVilOeTfk4N/yPWojUGzjQlGRaztvdnsPla4?=
 =?us-ascii?Q?Jjqo/GfSPgZgsjJuv6uQ4zR05tdNJOd8XySRkOtUBXwLFbe7fKdVWYyUZBey?=
 =?us-ascii?Q?qtDW7dwFbReGkQdzDrP5/rA=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20b3f65f-173a-405e-4bdf-08d9fab75685
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 12:39:19.1233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /cgi7V0sazpwFydQl93ZP3o1Vbr0eM/jRBTOROxTgsMTxhkdMG9J7Ndx6tOFlVELTh/qK7jQcS+whacxGwqceg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6384
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add mcore_booted boot parameter which could simplify AMP clock
management. To i.MX8M, there is CCM(clock control Module) to generate
clock root clock, anatop(analog PLL module) to generate PLL, and CCGR
(clock gating) to gate clocks to peripherals. As below:
  anatop->ccm->ccgr->peripheral

Linux handles the clock management and the auxiliary core is under
control of Linux. Although there is per hardware domain control for CCGR
and CCM, auxiliary core normally only use CCGR hardware domain control
to avoid linux gate off the clk to peripherals and leave CCM ana anatop
to Linux.

Per NXP hardware design, because CCGR already support gate to
peripherals, and clk root gate power leakage is negligible. So
when in AMP case, we could not register the clk root gate.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 Switch to use module parameter, tested on i.MX8MP-EVK

 drivers/clk/imx/clk-imx8mm.c | 2 ++
 drivers/clk/imx/clk-imx8mn.c | 2 ++
 drivers/clk/imx/clk-imx8mp.c | 2 ++
 drivers/clk/imx/clk-imx8mq.c | 2 ++
 drivers/clk/imx/clk.c        | 3 +++
 drivers/clk/imx/clk.h        | 1 +
 6 files changed, 12 insertions(+)

diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
index e8cbe181ec06..a452fd1bb891 100644
--- a/drivers/clk/imx/clk-imx8mm.c
+++ b/drivers/clk/imx/clk-imx8mm.c
@@ -639,6 +639,8 @@ static struct platform_driver imx8mm_clk_driver = {
 	},
 };
 module_platform_driver(imx8mm_clk_driver);
+module_param(mcore_booted, bool, S_IRUGO);
+MODULE_PARM_DESC(mcore_booted, "See Cortex-M core is booted or not");
 
 MODULE_AUTHOR("Bai Ping <ping.bai@nxp.com>");
 MODULE_DESCRIPTION("NXP i.MX8MM clock driver");
diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
index 92fcbab4f5be..dc69b7464b3d 100644
--- a/drivers/clk/imx/clk-imx8mn.c
+++ b/drivers/clk/imx/clk-imx8mn.c
@@ -594,6 +594,8 @@ static struct platform_driver imx8mn_clk_driver = {
 	},
 };
 module_platform_driver(imx8mn_clk_driver);
+module_param(mcore_booted, bool, S_IRUGO);
+MODULE_PARM_DESC(mcore_booted, "See Cortex-M core is booted or not");
 
 MODULE_AUTHOR("Anson Huang <Anson.Huang@nxp.com>");
 MODULE_DESCRIPTION("NXP i.MX8MN clock driver");
diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
index 18f5b7c3ca9d..250e45d9f844 100644
--- a/drivers/clk/imx/clk-imx8mp.c
+++ b/drivers/clk/imx/clk-imx8mp.c
@@ -721,6 +721,8 @@ static struct platform_driver imx8mp_clk_driver = {
 	},
 };
 module_platform_driver(imx8mp_clk_driver);
+module_param(mcore_booted, bool, S_IRUGO);
+MODULE_PARM_DESC(mcore_booted, "See Cortex-M core is booted or not");
 
 MODULE_AUTHOR("Anson Huang <Anson.Huang@nxp.com>");
 MODULE_DESCRIPTION("NXP i.MX8MP clock driver");
diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
index 83cc2b1c3294..33897b56130d 100644
--- a/drivers/clk/imx/clk-imx8mq.c
+++ b/drivers/clk/imx/clk-imx8mq.c
@@ -632,6 +632,8 @@ static struct platform_driver imx8mq_clk_driver = {
 	},
 };
 module_platform_driver(imx8mq_clk_driver);
+module_param(mcore_booted, bool, S_IRUGO);
+MODULE_PARM_DESC(mcore_booted, "See Cortex-M core is booted or not");
 
 MODULE_AUTHOR("Abel Vesa <abel.vesa@nxp.com>");
 MODULE_DESCRIPTION("NXP i.MX8MQ clock driver");
diff --git a/drivers/clk/imx/clk.c b/drivers/clk/imx/clk.c
index 7cc669934253..4bd6ad060eea 100644
--- a/drivers/clk/imx/clk.c
+++ b/drivers/clk/imx/clk.c
@@ -17,6 +17,9 @@
 DEFINE_SPINLOCK(imx_ccm_lock);
 EXPORT_SYMBOL_GPL(imx_ccm_lock);
 
+bool mcore_booted;
+EXPORT_SYMBOL_GPL(mcore_booted);
+
 void imx_unregister_clocks(struct clk *clks[], unsigned int count)
 {
 	unsigned int i;
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index a7cbbcd1a3f4..5061a06468df 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -7,6 +7,7 @@
 #include <linux/clk-provider.h>
 
 extern spinlock_t imx_ccm_lock;
+extern bool mcore_booted;
 
 void imx_check_clocks(struct clk *clks[], unsigned int count);
 void imx_check_clk_hws(struct clk_hw *clks[], unsigned int count);
-- 
2.25.1

