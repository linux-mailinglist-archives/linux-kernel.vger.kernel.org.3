Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68055474217
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 13:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233899AbhLNMIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 07:08:48 -0500
Received: from mail-db8eur05on2065.outbound.protection.outlook.com ([40.107.20.65]:32737
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233876AbhLNMIp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 07:08:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SOt21APCpi0UVIs1KJalj5IsMv96TIdutmW9AzHcuCvQo/RVMTCIFMquw2884oKRM/fnxGuNcsPO7besv8Ywdtk9M8ROo8QPUU1oKCkGkYgik8d+WCTYOadLu3DqwiUN+rmD8btXDxnPeCe+ib75LW+mpwcAUZVeuuXSVfdOVoA+PB1tHvxrXfJZeUS+5nyfdVZiCwxmPfc4hx9cmOUG/gthS07WWO/UpFCqaW9Dkfab4tMB+Y0f9KA9IZoF2n1NwqUuo7HgZHIABUGQtMTsaNb8ienmj2Zpg5oY+wIT3gCRIjnr1rwWI0f5pf7uj86edodKUHlFCy6Bqbr3u4BJ+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tW4KYmsBPnorxKGGLuezNVvMnx4uaKFZq9efWCeQwic=;
 b=lzAweBS64K8fmVoZ0GoBa7tpDsicivAmEgl30c9FSXiYrp6923AImWHhuuwG0vbuTDSuZK2oPz5PxK+xroHnRcygE3bhoOrZKoox6IQLrE4O26aDwmvlnyW+ByktHB+0WBcW2x6z2SepgtBnBkT9qVqFf7OTVgiXFJWJUEttio/j4/V014kkRviWaECkj8DFgbrGCzmJMwsZcE7o7y/Dy1yj6WzbxEhfRISOfVvOO6xtmp9vht1lc/s6ojtMNGbtfEGR/x0Run/2ZAr/xQiYByPSkthO92+Wj8NwV65+kUNB4YgHAooqEWm42MFba0/eyTo1ZWMoTzmR7o3uJlketA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tW4KYmsBPnorxKGGLuezNVvMnx4uaKFZq9efWCeQwic=;
 b=MZSwKo3Wyv46r5dHtCpTary2H7NexCWCcHo3xNXJ+0+1GgFEIwTGOR1flOdJoTVuF5mJnlVJ0agbxOZMGW/OL8D848wudX1Ou3URPdv9172TN5S0G47ZAal9lxc9qjcK9ilGEUaLrYmurClkOhYH4IznWe0QerwNGKEBhBu4pYE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB9194.eurprd04.prod.outlook.com (2603:10a6:10:2f9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.18; Tue, 14 Dec
 2021 12:08:43 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::82e:6ad2:dd1d:df43]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::82e:6ad2:dd1d:df43%9]) with mapi id 15.20.4755.021; Tue, 14 Dec 2021
 12:08:43 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     daniel.lezcano@linaro.org, tglx@linutronix.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>
Subject: [PATCH 4/5] clocksource/drivers/imx-tpm: add CLOCK_EVT_FEAT_DYNIRQ
Date:   Tue, 14 Dec 2021 20:07:36 +0800
Message-Id: <20211214120737.1611955-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211214120737.1611955-1-peng.fan@oss.nxp.com>
References: <20211214120737.1611955-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0249.apcprd06.prod.outlook.com
 (2603:1096:4:ac::33) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR06CA0249.apcprd06.prod.outlook.com (2603:1096:4:ac::33) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Tue, 14 Dec 2021 12:08:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d1bf4e9-50ef-4693-2fae-08d9befa78db
X-MS-TrafficTypeDiagnostic: DU2PR04MB9194:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DU2PR04MB9194CF4BC81003E5571C0B5DC9759@DU2PR04MB9194.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SqHhgwbnaBTPWnRhyhqT1gzapNkc22toiRgyS+ASlPRcu+TnBi4ubMNU1ylhWlx9Gt0nBJQ67AnApB63muUjbuLLwvAGjIVEZBUEQtbuRFDK9Eo1qUmeTpNCBEeaEEawRRUuVzSy4RPgYYvRS9DKPgXO2b5uOxfNH5Wpsbr9U1OieoYB3j99HX6exdmk2Ns1D7nBrkz15MY0dbXE1MvTlTN9DxyFvY+fFe9oq1bSF4669jt25pw5p6SLHqOFsuAzuvId6kb6XIJXrvgoFNC0Qs6II3feh5+lvMMvIr4XmYN9sWj1D130bYNAIx0tJfmCjzMqWMVmQCVwjNvxFADQCQpMkiBpGBtBMZrI2qsu3SkdDJtYLpYdXHgvWiDunHUE5lnmU56t/ZE0oYfGw6LaLrcKrHobyhbqiN3BDx42S7wDayg0OhWzs0O1Wmww1xk1bPV6gcR3FysHmRO/umA8hIkE1ycbQRz0YPJw8tpA/XqP/awbF1ttTlVy3eIBAb54y05PF3/3LR56DfkDWVxyxjr+t7VMZS3FlGnocktodoltmKeLy+ADVCd8ofgIR+2sYtuws67+ff5kyCT7q3pDyi/JnL4AYY7xvP//wUjQE7zhLkepaz/amAFxDpDHIpfJiCJCnUkYiSINTLfuntIojkQPpbMX8udZQTsSv/r5U/0HAlYPP40p+9k4OmjcxvK4YxyeX5BSDEpjogG7VI4cyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(52116002)(6512007)(956004)(2616005)(66476007)(6666004)(1076003)(508600001)(5660300002)(316002)(38350700002)(38100700002)(66946007)(54906003)(6486002)(2906002)(66556008)(26005)(83380400001)(8936002)(8676002)(4326008)(6506007)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VN8UdpZ+HMlVie69hCHgzdzGJ0S2WBomDAqH3yTfEbL9gLcYgWtN2uSQDLGF?=
 =?us-ascii?Q?w76LamW4A6IfTebJwRXi1boPFiSlDWG2jCYTvek7y8WAs95TNUZQ6uQro1bD?=
 =?us-ascii?Q?IUmepY3IzozPEB6WlsEr7QwKH89bmtpooI5r3i44+m//ma5rCcNAq8xA6tA5?=
 =?us-ascii?Q?0o1uGXBjoB52xmGKuVIVZGANgj3kMKLSzk+kLwFPWXc0TVAme4Lnx3fYrkXK?=
 =?us-ascii?Q?AfyzkPIGWMAyb+Jxo3iFOSQcfRupMfoVgwj0lhp2RCGyRmdsMgB0PJGyv8UN?=
 =?us-ascii?Q?elFU81Z0TjC3vNlktuYmqDVPcWuDi91m6v/yIs1tn0njm/RBg0AZTetdPY2M?=
 =?us-ascii?Q?iV86gWPJPBxpnifGFxFJjzOMAXby0ceEkDOrNnj37vr7KpPOC3OQ4mraA1XG?=
 =?us-ascii?Q?3fM9EYgkaN1bZtnVEJZbmJuoJyQlnyNSuqx6jg6FVkeu/9zDbglka0w7h+ZT?=
 =?us-ascii?Q?7IIUUSjRIWK/PwHnlEBj4t+I9YADaRO4burzcUxekVGzvuxISC5I5ZD1FSx8?=
 =?us-ascii?Q?QzLou4xo4O7D9TMLTqZkZY2UqKdGTqWpAlVGaZcAMZJunrdYZvJNtddrfF0f?=
 =?us-ascii?Q?1IHK/CnKleH1bDnlOEv9RFXrPynvpXNz54F97InmV2TCWKAaZHuMp7nLOhwu?=
 =?us-ascii?Q?JCF6kUIsw/Mqbqu5xRq3j5+EsAHLe9Umrk1gyCMXiv208jGudX7pQADJ2rYF?=
 =?us-ascii?Q?cqx/EeG+naw1mC+iJ/qcZ5ceLX7pyn4NEDWZmIRvusfwr/S9mWU+dOHWkCtH?=
 =?us-ascii?Q?g6HaJ+9OwOwWIchDpkgsgXvsbOjtOL2WErUaw7nPt8T37u2vF3A6CJrI4IDH?=
 =?us-ascii?Q?MpRGY85klFSBAonIUpT8hvarDyKFJCChMDkDbSc2pRQLIcg3Q0OU7S2HfuvN?=
 =?us-ascii?Q?dHc5MobS47HWqt7sPOk2QpBV9JZBVw8yrBIYr+2RCMNTGNJfOxn8uA18H/UR?=
 =?us-ascii?Q?wE7S48redYTNdeYeA+A1ag7fh9A1d+2vNEVUsUma0jlKzWMCK+fU5nIFm3Mp?=
 =?us-ascii?Q?ai5mUggtWYKRuMbnh+O7Z5j/iXBWQW04fPtc27tLiNSVyAH9rpShHH5Ce7FN?=
 =?us-ascii?Q?mUiVS4Osir4Nk0rba3ODSkcqqrHtM4LIuAFHUHyFzheZ8QO0OSSYsbftKVhp?=
 =?us-ascii?Q?uZ5Pyls6/MYy5eBARwPfHcVjedEwMjalgpv7oOYEvdq9iij1It4RUam75fQk?=
 =?us-ascii?Q?UnID8xBr3NIfjomnKwoBFKbpjtqKBUUhWZ+OD92PAVawAoKMunELWP+1l1Pb?=
 =?us-ascii?Q?ccPyV5njmf3OgJS/5f79m0WbWxUOJYBLSGzCy5U7mr2jv/OCrS0MwNJVym2o?=
 =?us-ascii?Q?9o/YjQVTBBxgumw3FUuOqGdtI8s6TTIvtzLT3KIbBcf3ZKa6Aoii/a+e/xOv?=
 =?us-ascii?Q?WTdtLvuL0cqXsP2QdziOw9I4fZiXxEXGrL02rpSNEcDUSh5u5U+SS0zKRU+e?=
 =?us-ascii?Q?NUx+M8NvOTdn8yUJz+MdkwZYi8isV10oytpq29SR7qROe65vXp0ytXqEmFFz?=
 =?us-ascii?Q?oI4A7T9VPPAuu2LgEwmA6tAu/vymJIhypfmBuBmkGgGcMsq+Q5C+/Xc/Acbm?=
 =?us-ascii?Q?AdG8k5W9nTCmDjFM0pMJdHY1Uj5KuVm6qa6witkX4E1Mk+9TukLoFLL98nx4?=
 =?us-ascii?Q?PUGPjOd6Thdx+puSDBnnUTY=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d1bf4e9-50ef-4693-2fae-08d9befa78db
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 12:08:43.1872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QAgE34zxmECdORsCRDka2k3TWmoqIjJ85971kZiIp+G0zB85qcV5sJXDyp/Rx9NCz60yGnutKNRVxLoEZjCjcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9194
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add CLOCK_EVT_FEAT_DYNIRQ to allow the IRQ could be runtime set affinity
to the cores that needs wake up, otherwise saying core0 has to send
IPI to wakeup core1. With CLOCK_EVT_FEAT_DYNIRQ set, when broadcast
timer could wake up the cores, IPI is not needed.

Acked-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clocksource/timer-imx-tpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-imx-tpm.c b/drivers/clocksource/timer-imx-tpm.c
index 3afd9b0a668a..578fe162fd99 100644
--- a/drivers/clocksource/timer-imx-tpm.c
+++ b/drivers/clocksource/timer-imx-tpm.c
@@ -129,7 +129,7 @@ static struct timer_of to_tpm = {
 	.clkevt = {
 		.name			= "i.MX7ULP TPM Timer",
 		.rating			= 200,
-		.features		= CLOCK_EVT_FEAT_ONESHOT,
+		.features		= CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_DYNIRQ,
 		.set_state_shutdown	= tpm_set_state_shutdown,
 		.set_state_oneshot	= tpm_set_state_oneshot,
 		.set_next_event		= tpm_set_next_event,
-- 
2.25.1

