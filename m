Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE0D483BF0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 07:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbiADG1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 01:27:03 -0500
Received: from mail-eopbgr130080.outbound.protection.outlook.com ([40.107.13.80]:59213
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231815AbiADG1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 01:27:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gotm6DLdibF9B/VWa+Xio2UU394Ls2ftW7JBk8RKFroYwrJDYoVryICrXpkq7L7+sBdCwZsfoWj+n+1f7/yV4r6utkqhG6JsmixGA76bdnVPh1kH8Zomq3ojvVlK3bBxRUaVfb5Ee93ktbE+eTBueRqRmCrKzZuFAIUpQWEl2+7r9DOzpFAy0ipGfCRm+pvmO9poZTXkgwWvr1bkI09io8ol4ImbwpaX/D65iP+AoVhTNUYYBqaINyge5828kvzMjjT5dxodIB2zmkA7TU+Lv+wq8SRivWdGTQvm0onRcutS4F4VQyZYIzZkl52BaJtDsHCRf9TbA2md5GuHzxBt1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zM8DSqYvb8HXOl/ptbUesMq8Jylq42OOqcfat8UXOZ0=;
 b=Ouf9rj5Os2HM+esXGApvLmTaAhUznSbnLaGzROrcY3jjgG28bycHSnchifwqMbA1NdrCeaLtTmjboPlFlM1peNpZOzNpGSRSEO7RaL7fPySdL6bnaEtmBogqh8nWi9X3RTk+3OtrAm7owNEYJZMASXXH+7vwTAoQIP2PfagP7YctCtLvsA9AXNnwjFfzlDN/5545E+DZeSka1QtUTyhgwrHrYsSnmukTYzHx0VMF2oREvY2aDFFP4sY/2NH6wb6bW+WAEiioivlRAq96LX6dBqdS6JZbrcKoXXlapZAwAL/w+b9oX4pVO+YSZhEJ/CDGiZqU6k4cxNwz40I0SdiKlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zM8DSqYvb8HXOl/ptbUesMq8Jylq42OOqcfat8UXOZ0=;
 b=LBDXPB7pbD1vJ4eeyh3gK0rKEb+XehCxwF674EOzujahTR4ZGE6+JM5534jAf4VjAnxqBTvRoO9H3usA5cPf5qqjHAMEHQhJEw6dTLHzF+dDfC5gNrVHPgFAA/PtkeI29zxHsq0SFLrZy8ga6+MJdNc97G+E+dH5KOoqBWF/fN4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU0PR04MB9298.eurprd04.prod.outlook.com (2603:10a6:10:355::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Tue, 4 Jan
 2022 06:26:54 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8%3]) with mapi id 15.20.4844.015; Tue, 4 Jan 2022
 06:26:54 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     jassisinghbrar@gmail.com, robh+dt@kernel.org, shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 3/7] mailbox: imx: Add support for identifying SCU wakeup source from sysfs
Date:   Tue,  4 Jan 2022 14:25:43 +0800
Message-Id: <20220104062547.2103016-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220104062547.2103016-1-peng.fan@oss.nxp.com>
References: <20220104062547.2103016-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0089.apcprd06.prod.outlook.com
 (2603:1096:3:14::15) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8412531-ac27-48d2-c035-08d9cf4b3381
X-MS-TrafficTypeDiagnostic: DU0PR04MB9298:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DU0PR04MB929882D7D96C869323F15809C94A9@DU0PR04MB9298.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DyiDKgBgBDuwmhgpUbT6gdWyJoRIu58BNEYAZ64GHCwg6AbCT1zD3S8GOf1EpQVnGwBgwt23uCc/h2s78tqZZVz4ZAD6bHiutoNpkrDLa0SOsvtCXoXPxiIVbl7UPdHIQig7WOg3TOvrDK30ov4ci6ZjfihE6odX4qLBb6vNCoaVMT4zmFIV5MRLad7M19KzP+mvxd9Ae+nt2/UV9voKelLDwGzlEiDMixmsDNb/+iPQu/wEYh0Y5CqQJu4PqL3bCisjA4jb9R/PQmJxEVg83rYZd1MRwyF55dVKD+ece+gGsSO/E1SQ3YEr/gehleEpzPMnqdaZnbuG9foRZo1Q/7mhcVP/jgsEJKliojsfHyev/3gNucKChIXdE64uCBC1pqUP3uUkrGwqFbVQysQmRsP//HLwSIQS6pslzvgf+ac0X9m2BPpYWO36jag2I7V9GtU0rt5a8tqTYmRg4BkRKB6TXT+wrKC53APZkoZMXfwnZR9FepksxA0dKA7H6grr2+OA0ED7XxYLxTeGifguiCImGiH8/w3jofUN77MHKo9OdZAr0AayF/P2HM3jH/630qA6dBz/oKp6ZBt23M7U8boqWlUzCySxMPzRpHQXDPyjiRFdJtHgS8+lFAsNdacKTOJysdakFcIP9HdvBsZCVBCg6P80CJC4I2oNZ8OtvIjzzXBnD76sziw0ixOEdeJ2ECvVLa9EdKbHcQt9vpzBWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6512007)(1076003)(6486002)(83380400001)(8676002)(38100700002)(508600001)(6666004)(186003)(6506007)(4326008)(15650500001)(38350700002)(66946007)(66556008)(66476007)(5660300002)(26005)(4744005)(2906002)(52116002)(316002)(2616005)(8936002)(54906003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O6j2AI2gZLi7IbbJH6x/QUGEybQi5vkJ+03FYFMtG99c9LAGIhUug+Ivy9IH?=
 =?us-ascii?Q?I+NdnnejX7iJda6Jyi9dXnoro2GuAPdIlYgaIUWYVMKZItTuxFzLobuujzN1?=
 =?us-ascii?Q?EOYX+J0zVIKxj0wFxR5WLmsSlRP41YpJGF7hYekKkPViNhst/iUn7YpE8F2v?=
 =?us-ascii?Q?BvoATvKrrMaqzmmoH4SqKwOZRAVc/uwkWIY022GRZuL9Dj17ithgPPx7h/mD?=
 =?us-ascii?Q?Zgo083MgDnR3FD6lpMjGaHtacUjo3X705p5KRovN66GwWrZaUdB2KqMXv6jv?=
 =?us-ascii?Q?YXOMQCKiLqKxlJvEcNpKD/cgnwzZScmSjRop3kQ915ju029F8bDPw8sI4ssy?=
 =?us-ascii?Q?wxHCGiPpzJJdq+JPpG18U1zqKNyNJq4Wx5WtYrHhsEjMhu73zGULWofd161V?=
 =?us-ascii?Q?0mVQ2VwwE64899Ya7G1edyzuWIUNsT0Hf58UBTjg6w+OP8xtiFVagVnxYeWO?=
 =?us-ascii?Q?awH0pIe3lOVJaiscIfVNf4yg8OcEld9ZSTyrvGvItjTH5D++pkdHr5T+CIdM?=
 =?us-ascii?Q?3q5zoO5YTm3jba+52LNfDsDBUb63z9FZq8jGOAwuij4L0vXo5TNPO/LT/oZK?=
 =?us-ascii?Q?06Jn7JeN1KB63wAK15J4gScJ2GZtn3KAkyd2UpNWHh0H+WNaLBKiUyzxtUDz?=
 =?us-ascii?Q?aZ2vLlZGO4+YiGPZkqNVvBj8YBFSwfdH5Ie6hWP+mpB9eMKBrrg3SxgVnRsN?=
 =?us-ascii?Q?Yb300ukCwh/XUkm8gy7DY/8s+sVZlVpZk/gtg8YMz9UMNc5GXiOS9DlEoLRw?=
 =?us-ascii?Q?8HNFngY+lLJu00tpVbfZwRywP9M2qjF1RIE02IIdAyHhLg5WvxV0FL/n9miG?=
 =?us-ascii?Q?5q9AvIGGTHODvIbRSiz+odgwR1C0Zs6R5jWQZh7FiSLqFMEmQWn3GcPXVhA/?=
 =?us-ascii?Q?ir9fZE21w+9Z+FpXByPebbjYpLTl27slImCwmZwSSIyAs8fyIQC4cXMslgzS?=
 =?us-ascii?Q?tUmvpymPPlFeL2k0POSDnkAb5264CtQ+qrAqqTSxEKOpnIqQjhj7TCwo6RZb?=
 =?us-ascii?Q?IMZhYIkqj+izlK9Ojf0ESKjab+c53xBYoEtetAoRZML4Pf/MpinCGwYmAs7o?=
 =?us-ascii?Q?x9zkMr05T1pBiMxZx1JfzMoW8HD8sagni9jaU1aNbtTZiDVOFyiDEYvOjBc+?=
 =?us-ascii?Q?16PCUSsytVH+P/z/pG579RPahhf4wVoJ550Ix7iV4eUgX1K1sTz4626Z9tcv?=
 =?us-ascii?Q?QxGNW7sFfwgDlfb6bcq1fDMHgHYmZ5gshoarYgzJnGMotuVFdoLYnSwfKLTP?=
 =?us-ascii?Q?e3uy5cZ/rYiKcY5t+ozupAJyP1vwyo5SZcTMNyhNnWIdMPKG8W6lglwLJB/f?=
 =?us-ascii?Q?OxkhaaSPsWliHosjuRGXLSEN0F9Zhn2WJFyx9oR8J4ZNB8yeA9DvJxSNNscF?=
 =?us-ascii?Q?dPBJF0jd8S+3fgZrjKkPbJU5y0uu2r9DX2HVpPzO0JWmfd+m3GhhTQFn8yXR?=
 =?us-ascii?Q?sXVt06YR/7PWaUXlWIzu4YFhKWJ5MOBK5cQDxipHyC2Dl9qQKqgq9TGSxiiw?=
 =?us-ascii?Q?RrF0+gba1D3E3Ix2TS7SOy0Rr8WM0fm8fbSZakVqH63yWQbzZLUkNl+GiTcP?=
 =?us-ascii?Q?E9NhYQRnP/VFK8bv1mi73ruFK3wWrxFp6I1layU2mVZ637dx+zJ4wcXe6FVj?=
 =?us-ascii?Q?8B/vXgXtpqjjPsdPYOFb+nA=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8412531-ac27-48d2-c035-08d9cf4b3381
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2022 06:26:54.6254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /SHKjQlVc7Zqy2nFWtl8h6lEDU0LJBiYOb/CcCpglE7rdjsY3fHQMwC2TYFnPvYGnFGnqFsQXO2sczGRGgqmsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9298
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>

Record SCU wakeup interrupt in /sys/power/pm_wakeup_irq

Signed-off-by: Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/mailbox/imx-mailbox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index 76d7d399790f..1f44ee11054d 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -337,7 +337,7 @@ static irqreturn_t imx_mu_isr(int irq, void *p)
 	}
 
 	if (priv->suspend)
-		pm_system_wakeup();
+		pm_system_irq_wakeup(priv->irq);
 
 	return IRQ_HANDLED;
 }
-- 
2.25.1

