Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE44474216
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 13:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233874AbhLNMIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 07:08:44 -0500
Received: from mail-db8eur05on2069.outbound.protection.outlook.com ([40.107.20.69]:45377
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233839AbhLNMIl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 07:08:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iExCJB/UaU6srWupuHUyAN+66aYUIzhvi5xqxa+osLyQ/52/smeiKqhx0XsWLf/y2QBf9rcRG0vRQaXJObxkag4QPHigWcj0kRjun7DXUg+FJ5tSxIxLxCKv4ji5umSHYgh9yD8sU4jcTPQDdKsvLbvpwLVzW6tsX7kRLm2CvwAgUFQYT+1DupzgsKOJ9nXxzl34OjscS2Xs1ZHTADpgTf5twPySqhxsNsjypZzeKuFtYVoYnTmbeIxXROrTsyAGUpIK3Pr6pbSY3+VFXyPDbCMuuMv6baQhc8CocS+4uQFWJBc2Wc/zPCl+wI4ydx2OAIxZG2+AuB6UTIa/VhAZEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uhj1nc+/cobNZ/o1gqIL74FTzy+vfmrBKIw8VoDXlD4=;
 b=JExuMK7CRNZB3rbOcMijW6MqDPaL3mPkZVtsZgMql/9f9lZTVY+ei4WkkhjGykRH4rSuOtLmzFNOy0uRIKLmsKGMzBnf+gSqJwKE117j2c6dpvxYQwqGGaiBLBosDr7OWnB/YvV5GOu3NgzJdNcrfWVeG/5+nOM98v0W6ZOKagAXi2XDtwgdEmuGOAAcgBJftcQv0k9DmteB4lrDOusqZoTNZL5F1TC/UzOwfpupOArS20jNwqiXKBga1+dalSZnSyMLl5AK5S/ylq8GX49MA0lDEUY3xRmS6WSjR2wWV1z2vuuYLSI2n3TI5IPILCsMJ/lMrwnNI6Ha+YFmsgNUkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uhj1nc+/cobNZ/o1gqIL74FTzy+vfmrBKIw8VoDXlD4=;
 b=dtcTQYHldvykwLDSrGuN9pg0KnvNhqjPE3/T7EOzfuQ3ynkkWD8PxuhKUbcyq4a4pJ73jxjx8GMm6pON2/emjt9kGbBwNvVWPiqOsTG8bmuaAG4XB3SOSpc313tz8avvexMxd1Uye4lHF5RZ4oyQUSUWy0K4gvNn+YhWHM/+UWk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB9194.eurprd04.prod.outlook.com (2603:10a6:10:2f9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.18; Tue, 14 Dec
 2021 12:08:39 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::82e:6ad2:dd1d:df43]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::82e:6ad2:dd1d:df43%9]) with mapi id 15.20.4755.021; Tue, 14 Dec 2021
 12:08:39 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     daniel.lezcano@linaro.org, tglx@linutronix.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 3/5] clocksource/drivers/imx-tpm: mark two variable with __ro_after_init
Date:   Tue, 14 Dec 2021 20:07:35 +0800
Message-Id: <20211214120737.1611955-4-peng.fan@oss.nxp.com>
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
Received: from localhost.localdomain (119.31.174.66) by SG2PR06CA0249.apcprd06.prod.outlook.com (2603:1096:4:ac::33) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Tue, 14 Dec 2021 12:08:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57f28b34-bb79-4ebf-725e-08d9befa76aa
X-MS-TrafficTypeDiagnostic: DU2PR04MB9194:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DU2PR04MB91948953BD70FE4D487138B9C9759@DU2PR04MB9194.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:843;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CIucR3RpIEdVY5WmHXwZ0xfkwvnZJLj3cper2WHpc2oi8D8ELuJIbOomKqipc5HD5f1tzq6bjqJ+Drs5ICyiox8yDhRMgRAlxdulqcn2Cyp1pkfjSK6dREOfEn2bff6Qx6kB722a3wYusWMjOCNpCLterLl71ZPYxSPNMleXZzu22xiVFn+8xszCkIdVLbY2Zr7pXHMzdEbu5eY9MdKqrFdicPoBcsBpNEtkE/P8E/c3Y8E8nImrSztzcIWrf58LviegeKwLhOlgCVZ4YPr5NMGjFgFApfjTJ38qMQBtIqaBGL/1pIg0YrUIHY0Caa8fi/wXeLHmxSMu2QKIA7uxgNeDUmb4gVCwSDN+llTBcQPGIrkwdxThdKeeXpEZ8UDGb171M0/tHk/BDtVfpeokyf95mtPNFc2OhhNNelCdhCCopViSLUz5rBMgxjnOrQRQSdOXuR/J4e3RCoud2V5URYUOLawgBPY5ooJovfPUt3QytUNXGbVk72YyZG48IxKfvIKDZpcIWBZbEcCyRIAoP3uZoDk6N9MDZ1VuDkhgPjB0MKQrmM8G5US21lWBntducOv5tQY1DLWsTkYmudJn8nUKBbw1MmtHc2SX9VdAfY4m9J5XLFjpiUfDK0JUXmi6gE73SFO6bAYq6woRpRF6NxW1MXCR9OzxVJR5yeGUxHpkru0D5snEc6qfjnz+SiH1Kmp+h8f/0qjweWZ8VOrmEQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(52116002)(6512007)(956004)(2616005)(66476007)(1076003)(508600001)(4744005)(5660300002)(316002)(38350700002)(38100700002)(66946007)(6486002)(2906002)(66556008)(26005)(83380400001)(8936002)(8676002)(4326008)(6506007)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uUY6PdwHaloacGIJ0/vRiOFQkfDjMZt88U5DnzpL79zI5nz1/XM21rt8RSpz?=
 =?us-ascii?Q?RkQeqIBMuLsYlwi9nWuvW2FVY+2MpcYuGFsOX3QEHzBo6KyapkORjF29u18q?=
 =?us-ascii?Q?1IU5lkQfmWB1lX9c4h7AIQBwAJwlYl1VR76RXUs2MAoM4gdJnk26AG4AFDeU?=
 =?us-ascii?Q?+67KogUTwnjXrrC5RKAdzL6GwwI6OSnygXwDedqw2NeEgn8QdWspqa41kxEO?=
 =?us-ascii?Q?zqpnpjVjvwTL/jS2mjtitJ6qgHKbZtKfSj/UMCqyE/ZTRniSFSoxBZCjnqun?=
 =?us-ascii?Q?3h5+f5cjC97RdvuY3uOJQUkQ0p+hGJXJMrkligxGAsCddVAkOdBvTaMK+p38?=
 =?us-ascii?Q?aR+L2rGOAC6dztZn/n7WFA+5rp757D9oAEntvwK/0oS0j9BQJ9+gn0GVl3AW?=
 =?us-ascii?Q?yrpEz4qNv3/MzBMeBRl3D+czED6qq4U51kel0PM+pJ9JvmzxWHj5gpoeXy/j?=
 =?us-ascii?Q?y+ZyilRtXLYImQT3k9exLXoa9qEWqK0XZkJoZovcrHFPOpW3TALcyCv5YnRI?=
 =?us-ascii?Q?ypPlLx9fnNcN11XNny6xxjd5I2Md+JH76wyMT/wvQ5ti9KF7pxtfvK+5kD/3?=
 =?us-ascii?Q?wNWznlB07MicAkkJjBWbdp7C4+WDmsP/TdfSMyC6wqbF++LBt8dJb82KVeER?=
 =?us-ascii?Q?v7V/ZhFCfHCu2pIuIcWoDf+uY7pIpgdUQ/hn+OCnbADemwOkGG3ZA2qWg3Zh?=
 =?us-ascii?Q?i/XDNApGUUQ9HmpDm61yqRsq9AxPsaWPPr2UTmRcD65b887UJLV/v69ypcDr?=
 =?us-ascii?Q?XCqs+bqvm9l/jA3Em7oWLy6RetMlHaVRPciY7nL1AebXnr4HvJ6BMUBP5hnc?=
 =?us-ascii?Q?/QRHtsq1swzBl2hWOjlDZD6S3aCJf61R+XuaxQJL8HpY0C7rv7p4jnlWpaY7?=
 =?us-ascii?Q?+JSfTppaWwFopWFixmmIYe49fYJ5zkK5CAbx+Rn527uRGYRay6ImKJDcSaJT?=
 =?us-ascii?Q?Z99aVmjDyFj7Hzy/1y7nt5M159ElzsdYwHkTNqGGbFb/YiFhSAxPsA1IlHUk?=
 =?us-ascii?Q?v4Yr4OTVk0bn5Qmj7wjuQE+5/71346mw7KUh8tzJUXQIb0q0XopKpJJWnqzv?=
 =?us-ascii?Q?jFbrVm+6BBEn5sX19LHA06BgFzonbyt6nw3wDC2DDzVjzDY1Fftja75CbL6A?=
 =?us-ascii?Q?KWMr8Q9Ie17Uw30TiEr6cOZL4ZOuZ+uxE38NWLQt8wniYpM8MfVOPKFm/siu?=
 =?us-ascii?Q?A2qh1/E7QjSjP0r8u86oZn3AjWyhq+d3z9KlUWzBu4yKAQvnXon2gIDNir+u?=
 =?us-ascii?Q?66NqXJPc5nWaOrdUMun7EdLb9nSkiJg2QB9f12LibV1C1jxyynj1NEHWTaDc?=
 =?us-ascii?Q?kt65bIzTuVYH0/OPW4lDg2aeZDpaVyrREi2B7vCpFxkRX/1J03wHE0Uun8aa?=
 =?us-ascii?Q?IfT9jKercN18bPSXo6E2NzSeDRi/f5mWmcTe3/C6UhysGthzDcUTXmL49kB5?=
 =?us-ascii?Q?qyOPl5WFdUkOxsW1TXpowEwpVV718Zr20SYHSz77ETNMaytpKp0np3Z4B+uf?=
 =?us-ascii?Q?YMk+6P/SdpF1DcQ5b0PXBpClZuxtvOlvOvp30kaqfqfth2AMvsz6G9RMjnbh?=
 =?us-ascii?Q?m+I1e8v+Zf8I1hBn7ki1D/PPkHcEqARUsqb/99KjGcIfIq8Q7pCDdnMn6gmF?=
 =?us-ascii?Q?pa0Ej/EERhnzaG4illwh1c8=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57f28b34-bb79-4ebf-725e-08d9befa76aa
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 12:08:39.4616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ouXv4AInAx5/LU9FpRbt5/cyx4c3AmrXURJGBR6M/kKYRybh+Qq3xA1YXNw/z0I+O611v95gxVthbw8JhEYdkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9194
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

counter_width and timer_base will not be updated after init, so mark
as __ro_after_init.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clocksource/timer-imx-tpm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/timer-imx-tpm.c b/drivers/clocksource/timer-imx-tpm.c
index 2c0b0d4eba9e..3afd9b0a668a 100644
--- a/drivers/clocksource/timer-imx-tpm.c
+++ b/drivers/clocksource/timer-imx-tpm.c
@@ -32,8 +32,8 @@
 #define TPM_C0SC_CHF_MASK		(0x1 << 7)
 #define TPM_C0V				0x24
 
-static int counter_width;
-static void __iomem *timer_base;
+static int counter_width __ro_after_init;
+static void __iomem *timer_base __ro_after_init;
 
 static inline void tpm_timer_disable(void)
 {
-- 
2.25.1

