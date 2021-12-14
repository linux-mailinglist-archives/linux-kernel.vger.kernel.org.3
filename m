Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0E34742C1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 13:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234044AbhLNMjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 07:39:52 -0500
Received: from mail-db8eur05on2044.outbound.protection.outlook.com ([40.107.20.44]:17185
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232252AbhLNMjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 07:39:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Me7qltGDlTnrAlrxJcnWZi/C5/pgnktlMKzPPHT5y7xpv2OTf7RBsqRS5iHbiKrs4EzxIqzw0EidJVpXjYtf3HNRbThEB3KjaMzQ49SOb9QJdyOKWaQKXroA7wJay+rndU3f1KjoRqHzKT/VVmpU+tpGiH699QeUUa3+QWiQybCd2VKA4dqBEXU3dTF9Z6nqL5Eo30oNI10DhESg5Uw2Lt5RpgH3//EYOaydQk+BUm9siTPf5oZveXRD3tvZdx5Xzg27c70ZQ+/KeeqsLsMDrJOob6W6lUQa/yp5WwA1YU25DsXf6XGwnCI+Tsr67GFuojeeDI+LRZRMhkhq42Ogeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EP/OFIsRuOA8EEkQH+3MPyUgRyjX3zFom4wsnTqBeDA=;
 b=j2QsirkAFi5UxPV4xFAnQc8dbbwItqh3TsKu9xMMSgrzpusKRq1pDe212OndhG2i4VJotBl2yEOuJ4vJR00RiicUCytTGVNQB20IUiXKLlBLmzNmvsNIRH6gsoBIR+Ds+pJXfmZDB4/oUpqteUXHpA0Fmi1WGX5ULfr1ObFpPtouadmHMmHbFfyqBP4OeYarEQledqX9XSo0EkrlRjrlXsaHt2KEQAHQyQmfehDKxJow6uvY9XHyOBQjcFltNjAUu3I1l+eX5I1aQy1F4Ufs0A52kZ/L5WGSYPPP7lV3qUrHeRydlZ7sGQzaB6g53qn4zhqm8KhN3wkdhdw72rDK0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EP/OFIsRuOA8EEkQH+3MPyUgRyjX3zFom4wsnTqBeDA=;
 b=kAEpM47ZTUf2uDPoftWRJIesPAN4hnu1PF7IcMDt9BZIwg+XOW1siUaBYS7rx0w/u8hI6+g5PnEPfnchGwvTGzXVri7CL5ND4Gf672C6H6ZQY8WHIRuJMODbSxnvgeWA5IkdCLs7ryDTs3cPJS6Gm02jZ/7Nsqx09t9wcvvYe9o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8870.eurprd04.prod.outlook.com (2603:10a6:10:2e1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Tue, 14 Dec
 2021 12:39:48 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::82e:6ad2:dd1d:df43]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::82e:6ad2:dd1d:df43%9]) with mapi id 15.20.4755.021; Tue, 14 Dec 2021
 12:39:48 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        marex@denx.de, p.zabel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] arm: mach-imx: mark some variables with __ro_after_init
Date:   Tue, 14 Dec 2021 20:38:57 +0800
Message-Id: <20211214123857.1669025-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0166.apcprd06.prod.outlook.com
 (2603:1096:1:1e::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR06CA0166.apcprd06.prod.outlook.com (2603:1096:1:1e::20) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Tue, 14 Dec 2021 12:39:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d8c8dbc-d993-429e-1f0c-08d9befed0aa
X-MS-TrafficTypeDiagnostic: DU2PR04MB8870:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DU2PR04MB8870F1E89ACDE1B43A3A36DFC9759@DU2PR04MB8870.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gUxBoI6tJMZKqyNLbpnPIv9bbW0Aj+dRsQEqAnxvKX5qEBw4leHDnOy0siYUyoV3CRLSQDrURRRUhB9y/Fnc2CW3E6fLDKOtI4JXxUY4jinGWBDseVa88sKonp0yMRCquqMDEcfQP9qYIF85kT0YVv0geMrmg6qswju7OHJi26kIuvS0ytl5W+EWZhYFjYXrV4Zv/wNPXqTmB9w5SXA5h5IEO0FQ2SeFrGRYK3F5jzFRDZnTr4efesflrSIOuJdPAUO6xOn+zlwSSPuRLWkf4/PRAPt9ef3wgPM4bRpJJHFFhkhFvWHuZ2IkLi2hWE7/8QXT3ou5Y8iXBDvY+Yns6x45GuXHQ4XiT+c9Rl/QrtL4fYnGSJPtiS83oNOGCarsYGmLgDsJofBA1YeYU48jnR1fg3vr07zixSAN2WUMzPMbE8J+vObKcH2xLZbrIxUAMLLmcg5oDlXSVdOsVAUtTRof9vJbOuX/3CUo8UAseyZTUOHwfvBC19cZxL6HndWIh3W6ZcweKzYkCDtO8k8HYcs1S8y2pHSj8ryvcTrhr4d3uJm9wBlew+G795iexAtJSha80AslymjSPpgbmDXIeEsnlI29o9wUD9WszAsJXjNPofdLAqfTLlUEDsnX4cEQjIqsI8gIkviEY36+pROyylkmMADmmRbDY/v+5IcxuNTVpiz44MXky1NmpD+SfoZMVMZAgCO2StiPCwjGh8+5Qw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(956004)(8936002)(2616005)(6486002)(316002)(1076003)(38350700002)(38100700002)(6512007)(8676002)(6506007)(508600001)(83380400001)(86362001)(6666004)(66556008)(66476007)(26005)(66946007)(5660300002)(52116002)(186003)(4326008)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?59P+geIAIf3JzU8KRzdCGx79IhFIsqj7rIVTzEZXIOZAL+gBU0XKAb0q0O+5?=
 =?us-ascii?Q?lB/8hrBrj0EUfQULlt6ro5LXUur2KzUu4Z2i4oAxtl3VwY/RtkDHnAAlyDLo?=
 =?us-ascii?Q?wp98o7rDGJLAWisgIAvvJug2OKahpuN47geqiHDCMy1+GXXEM0nQk6hh+5ys?=
 =?us-ascii?Q?7AkNMIjZDqEbIuG0KSaEkG0Heq/nxo/7diKii3HO7VRDT222/cl5FoYo3Jo+?=
 =?us-ascii?Q?GGPKBe2cxPT6QB0fvywJGhZfA9aasXHoroDEbW66FJP/LHnFEMMiAjsrUYCw?=
 =?us-ascii?Q?rr5qMXFaooVgteXEkEC2rDNs4pp/dz1LAvMpc+a7ZZigJgW6ydhncdngenKD?=
 =?us-ascii?Q?/FOkqcJ8jLqZeiViHhhIFsJVhjjP7GNDrRDtiCCYj3B8gvO79TSxp+467fme?=
 =?us-ascii?Q?O5/gEEnvoXzuZGcWCYVjJ+qgwGBuQMuieIJoy+WoN1lOoOFVFVq7SRR8ZOdD?=
 =?us-ascii?Q?EzI2LbIkR+xQO71JqwikE1Qg7kKVa/iREj1KyYrFR7ypA9BDdjR2YqPlW+3e?=
 =?us-ascii?Q?2dTPdJ0K9POC5EbZFn8q121zfebAZ8YTASfrb/GaM4IQ9iCpet5z/C3QYcPd?=
 =?us-ascii?Q?503jV62uhymB73vDVQ/cHTU21c/JgFx/iDxxdn5kibIU7LtIVIX/sh1b5eQE?=
 =?us-ascii?Q?5RWlcwgSP7zayBNVhcsobJUISNTPKDhiT9RjaEaUQyXKQ/c+jeV8TF4FSJcQ?=
 =?us-ascii?Q?4OJe/+LBmI3Q38KYZ1kRp9SVPCcNkjbTOPJbeEFLgopprufedj4VUJvVhhB8?=
 =?us-ascii?Q?TnDTaUvhwjpmc+agPTbQoMXQ9EQPfcxJTYfzFZY5RjUwf53tqBolzgnkg3zi?=
 =?us-ascii?Q?VdwUkc//q5vKXq3eD2rHHTxEH7O/vdfKLcgWJkmwVPj4n47XRIMXMlhsFkza?=
 =?us-ascii?Q?Q8jQuQVNNp6bS7uxMN7psTTSucU9H99lflR29FAr9+u+WOEchpiLo9xl/Y+i?=
 =?us-ascii?Q?1GY1N4f1NlC+NLxTTkWMY23bS2FLTtTURKDKJp9IG7qfCiJyJuzXNSn5Uyio?=
 =?us-ascii?Q?7bGxto3cwzWWEhuPPNgyDOfEKYuXUzoymGEbAI2gUAiaD65XAxeqrc38y1RA?=
 =?us-ascii?Q?4xSQJBpm7G9qvS8TrcDzT0UHW6i3JzxU57hIUfCt0mnlqr5KjL0vj/2wXN9T?=
 =?us-ascii?Q?mdOsclucna/brQPpjG93o6E9oav3ifZdoPspXPZ6sEBas6Mi27CHbtfXbZit?=
 =?us-ascii?Q?0y2jWuaEReL7/37LOfAbrjTawy6R97prE0Az7Dk9pxrAkiNImo2aincrLdtY?=
 =?us-ascii?Q?4e8g3CJT6eh7mgIuIOJG5so7DA1DgA23qZLPQYPIZ0CFEFMxpceWIurN2Af5?=
 =?us-ascii?Q?yFrYNZEsU4t07JoD2jAzflH+rWT8lKPkmZiGkaHLEqI4P9a07S5eglX5Mue3?=
 =?us-ascii?Q?1hQR6G7mOi/UEwBNY8xbSvA/5vxmD3xTiQg1/NvB75WupOom/LKYI6fiMSn9?=
 =?us-ascii?Q?zHjFKpQ2K55/uk9zBL+o3nB1qSpqf7Yd8XDuGPDgyv4De6pSnOnxuQRrW+6Q?=
 =?us-ascii?Q?ePM1EXSNDN9FZcGZIugOECK3WzYEFwnY1B8/ZMC3icHjdU+Ym7FLUQjSTwH/?=
 =?us-ascii?Q?5Gl6Ilf5i457xquiqqwrAglR5sI1V23EcGeTAT13b7ODfqNsN4hA2Z5Oevav?=
 =?us-ascii?Q?oJjy1aDqN5gzbRnks83Tnjk=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d8c8dbc-d993-429e-1f0c-08d9befed0aa
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 12:39:48.3895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UIy2wZJkKkaRvg+R+/4YLtWjBT5ff0m2OosS5RznMpSbv4sHAFxyi4aU3SdvTrPMTzy29DFMUoa22wYTF3oTZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8870
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The variables will not be updated after init, so mark them as
__ro_after_init.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V1:
 code inspection, not tested.

 arch/arm/mach-imx/avic.c       |  6 +++---
 arch/arm/mach-imx/gpc.c        |  2 +-
 arch/arm/mach-imx/platsmp.c    |  2 +-
 arch/arm/mach-imx/pm-imx5.c    | 10 +++++-----
 arch/arm/mach-imx/pm-imx6.c    |  6 +++---
 arch/arm/mach-imx/pm-imx7ulp.c |  2 +-
 arch/arm/mach-imx/src.c        |  6 +++---
 arch/arm/mach-imx/system.c     |  6 +++---
 arch/arm/mach-imx/tzic.c       |  4 ++--
 9 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-imx/avic.c b/arch/arm/mach-imx/avic.c
index cf6546ddc7a3..22d1ba76b217 100644
--- a/arch/arm/mach-imx/avic.c
+++ b/arch/arm/mach-imx/avic.c
@@ -44,9 +44,9 @@
 #define MX25_CCM_LPIMR0	0x68
 #define MX25_CCM_LPIMR1	0x6C
 
-static void __iomem *avic_base;
-static void __iomem *mx25_ccm_base;
-static struct irq_domain *domain;
+static void __iomem *avic_base __ro_after_init;
+static void __iomem *mx25_ccm_base __ro_after_init;
+static struct irq_domain *domain __ro_after_init;
 
 #ifdef CONFIG_FIQ
 static int avic_set_irq_fiq(unsigned int hwirq, unsigned int type)
diff --git a/arch/arm/mach-imx/gpc.c b/arch/arm/mach-imx/gpc.c
index ebc4339b8be4..ffa6a3ddcd67 100644
--- a/arch/arm/mach-imx/gpc.c
+++ b/arch/arm/mach-imx/gpc.c
@@ -27,7 +27,7 @@
 #define IMR_NUM			4
 #define GPC_MAX_IRQS		(IMR_NUM * 32)
 
-static void __iomem *gpc_base;
+static void __iomem *gpc_base __ro_after_init;
 static u32 gpc_wake_irqs[IMR_NUM];
 static u32 gpc_saved_imrs[IMR_NUM];
 
diff --git a/arch/arm/mach-imx/platsmp.c b/arch/arm/mach-imx/platsmp.c
index 972639038be5..e50142b68510 100644
--- a/arch/arm/mach-imx/platsmp.c
+++ b/arch/arm/mach-imx/platsmp.c
@@ -18,7 +18,7 @@
 #include "hardware.h"
 
 u32 g_diag_reg;
-static void __iomem *scu_base;
+static void __iomem *scu_base __ro_after_init;
 
 static struct map_desc scu_io_desc __initdata = {
 	/* .virtual and .pfn are run-time assigned */
diff --git a/arch/arm/mach-imx/pm-imx5.c b/arch/arm/mach-imx/pm-imx5.c
index 2e3af2bc7758..dc3f1b8ba47e 100644
--- a/arch/arm/mach-imx/pm-imx5.c
+++ b/arch/arm/mach-imx/pm-imx5.c
@@ -130,11 +130,11 @@ struct imx5_cpu_suspend_info {
 	struct imx5_suspend_io_state io_state[MX5_MAX_SUSPEND_IOSTATE];
 } __aligned(8);
 
-static void __iomem *ccm_base;
-static void __iomem *cortex_base;
-static void __iomem *gpc_base;
-static void __iomem *suspend_ocram_base;
-static void (*imx5_suspend_in_ocram_fn)(void __iomem *ocram_vbase);
+static void __iomem *ccm_base __ro_after_init;
+static void __iomem *cortex_base __ro_after_init;
+static void __iomem *gpc_base __ro_after_init;
+static void __iomem *suspend_ocram_base __ro_after_init;
+static void (*imx5_suspend_in_ocram_fn)(void __iomem *ocram_vbase) __ro_after_init;
 
 /*
  * set cpu low power mode before WFI instruction. This function is called
diff --git a/arch/arm/mach-imx/pm-imx6.c b/arch/arm/mach-imx/pm-imx6.c
index 045b9fdd342d..494cc7293ee4 100644
--- a/arch/arm/mach-imx/pm-imx6.c
+++ b/arch/arm/mach-imx/pm-imx6.c
@@ -60,9 +60,9 @@
 #define MX6Q_SUSPEND_OCRAM_SIZE		0x1000
 #define MX6_MAX_MMDC_IO_NUM		33
 
-static void __iomem *ccm_base;
-static void __iomem *suspend_ocram_base;
-static void (*imx6_suspend_in_ocram_fn)(void __iomem *ocram_vbase);
+static void __iomem *ccm_base __ro_after_init;
+static void __iomem *suspend_ocram_base __ro_after_init;
+static void (*imx6_suspend_in_ocram_fn)(void __iomem *ocram_vbase) __ro_after_init;
 
 /*
  * suspend ocram space layout:
diff --git a/arch/arm/mach-imx/pm-imx7ulp.c b/arch/arm/mach-imx/pm-imx7ulp.c
index 2e756d8191fa..13c920ce0f61 100644
--- a/arch/arm/mach-imx/pm-imx7ulp.c
+++ b/arch/arm/mach-imx/pm-imx7ulp.c
@@ -25,7 +25,7 @@
 #define BM_PMCTRL_RUNM		(3 << BP_PMCTRL_RUNM)
 #define BM_PMCTRL_STOPM		(7 << BP_PMCTRL_STOPM)
 
-static void __iomem *smc1_base;
+static void __iomem *smc1_base __ro_after_init;
 
 int imx7ulp_set_lpm(enum ulp_cpu_pwr_mode mode)
 {
diff --git a/arch/arm/mach-imx/src.c b/arch/arm/mach-imx/src.c
index 59a8e8cc4469..679448905031 100644
--- a/arch/arm/mach-imx/src.c
+++ b/arch/arm/mach-imx/src.c
@@ -36,10 +36,10 @@
 #define GPC_PGC_C1			0x840
 #define BM_CPU_PGC_SW_PDN_PUP_REQ_CORE1_A7	0x2
 
-static void __iomem *src_base;
+static void __iomem *src_base __ro_after_init;
 static DEFINE_SPINLOCK(scr_lock);
-static bool gpr_v2;
-static void __iomem *gpc_base;
+static bool gpr_v2 __ro_after_init;
+static void __iomem *gpc_base __ro_after_init;
 
 static const int sw_reset_bits[5] = {
 	BP_SRC_SCR_SW_GPU_RST,
diff --git a/arch/arm/mach-imx/system.c b/arch/arm/mach-imx/system.c
index e88ca027129d..67f02a055db0 100644
--- a/arch/arm/mach-imx/system.c
+++ b/arch/arm/mach-imx/system.c
@@ -23,9 +23,9 @@
 #include "common.h"
 #include "hardware.h"
 
-static void __iomem *wdog_base;
-static struct clk *wdog_clk;
-static int wcr_enable = (1 << 2);
+static void __iomem *wdog_base __ro_after_init;
+static struct clk *wdog_clk __ro_after_init;
+static int wcr_enable __ro_after_init = (1 << 2);
 
 /*
  * Reset the system. It is called by machine_restart().
diff --git a/arch/arm/mach-imx/tzic.c b/arch/arm/mach-imx/tzic.c
index 8b3d98d288d9..227837638a21 100644
--- a/arch/arm/mach-imx/tzic.c
+++ b/arch/arm/mach-imx/tzic.c
@@ -43,8 +43,8 @@
 #define TZIC_SWINT	0x0F00	/* Software Interrupt Rigger Register */
 #define TZIC_ID0	0x0FD0	/* Indentification Register 0 */
 
-static void __iomem *tzic_base;
-static struct irq_domain *domain;
+static void __iomem *tzic_base __ro_after_init;
+static struct irq_domain *domain __ro_after_init;
 
 #define TZIC_NUM_IRQS 128
 
-- 
2.25.1

