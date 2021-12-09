Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E30E46E852
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 13:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236171AbhLIMYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 07:24:35 -0500
Received: from mail-sgaapc01on2113.outbound.protection.outlook.com ([40.107.215.113]:6946
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232290AbhLIMYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 07:24:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z2uwZpnnUMbNM7AyrSk8hcpHUF3KucQ5O04M72nHIcl99q1V6enmzV+Jadx+/w/Sn76iaxRgx5iEj7+l92arICsboq9FU88ki0Dj6A1u8VcIjQ0lH4yFPk2Oswe8FVEWpUMYM+D+8gsUvX+hHvKpZPWUhKnMBqCb1nSieDjLxRt5NuzzsNqlWtBqw4o/cb/t8RrQa1kXAu8xLQzWBDQIZVx4DRWcWSFliiaD4OI1u0+n+v0KGq8yHwvFQ+lX4fBqGrnUFPVXGqbzz503ly6W2SrnrUoMQrdhYPGxScT55UQnkuyjCcg9NWE/55M08LVJNfTy/2cEv4XUR1Yg2T/vfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/UfAuFizNvv1mSumDWzLm91U8kUftMNn4Q5S0+azZtk=;
 b=I+wcGoQehqlNstsEtg+5EpBR/NJy83L8zKWl2DW7fSIi7HJIgX0birkcF+aLvO1uDX9aa00eg3qgPw0OGvF+BK0QNRw9fTSxEBSA4U2+qAzTLueOuRqLP1KBYct4cLI+iDqNWG0ndPYpOwBazpLVIbpjS4SDPUBOZG8a93QAAzUkNN1XlQeuQmimOvlGWUjdtdd6uMhIKb1aPfkemBawgdSUcCw91KLZJMgNEcZEUQt/EUEHO/94P3kCwpNzPD8s2XWKukEqZzNZSUY987+oK8X8cUxrAfYOKnupCGHWCmLsST5VmBHyxiL6XeJwvuemQ0bTBckc0c2DquplLq1fTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/UfAuFizNvv1mSumDWzLm91U8kUftMNn4Q5S0+azZtk=;
 b=g9pD8OV1hi8ppCwObYyMrmDwlX0/M9pQ3Rlj6JHITrChlnb4U+vh3oXbmLwooccb/V8y2bjbDPiCBGlAxnZJCG4gXLICTO3UwnRgRl+O2xEWyKDP/2BBuXvL53M1wUrLkExSHRM/EMfAwyH9jO6llOl0PRMewUiPCSamEflvxlo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB3180.apcprd06.prod.outlook.com (2603:1096:100:34::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Thu, 9 Dec
 2021 12:20:57 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::a0cf:a0e2:ee48:a396]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::a0cf:a0e2:ee48:a396%4]) with mapi id 15.20.4755.023; Thu, 9 Dec 2021
 12:20:57 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     John Crispin <john@phrozen.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] mips: ralink: add missing of_node_put() call in ill_acc_of_setup()
Date:   Thu,  9 Dec 2021 04:20:49 -0800
Message-Id: <1639052449-23322-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0060.apcprd04.prod.outlook.com
 (2603:1096:202:14::28) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
Received: from ubuntu.localdomain (218.213.202.189) by HK2PR04CA0060.apcprd04.prod.outlook.com (2603:1096:202:14::28) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Thu, 9 Dec 2021 12:20:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc190b83-1df8-4ff7-6582-08d9bb0e5a99
X-MS-TrafficTypeDiagnostic: SL2PR06MB3180:EE_
X-Microsoft-Antispam-PRVS: <SL2PR06MB31803BDA5312E2B2C421BB4BBD709@SL2PR06MB3180.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bD6VZzD/ACPBSPzOwiFGSs9g5UryaRrJl5DJb7D9BFVfg05SLL5e05v/Ivplk2XQDCLN0CCmbUFoPL/GNoCzGQm0wuRkYcZR5mm7RhD4xUwUEFoJ5st/neBp6CZulQbib2qltT8aC4j6hP0PfmugW4jU9a29Hf2fYLg/4MPuBNCxz/hAD6egpyUZIw+ocB+G4te86U6dIyT+o2gYDYRk1pvThDbGWNGIGiQJlkZUI0AJJ6Yk1HtPy+iKlLlezUOJnYN3xsOPXrue8uz6vC0THufpMvUOEYsxd762Qm1NpkjMmqgEIFwZu0qVv7QgSN3rF0AvczreoF6mO15qnMBYV+IMTBafO+pdiS0SS902oas1D+EXyg+fzoo5sYedtkE9FajhhDaqliAd94r+J0khzwqgGTreteYhjoj8znu2QR8PX1CCWCEc7P5QIcTwrZbnc3kdl/qcf7+0pc1apxbtLtJ/JF1m8EUwSQysSmKvFonFQ3O3ghqiwUExWYIAcDoS8bgDNRRwtUm8gMXgno9l5S04AjQRs2B0JPbwKzA35MSpZPRHa9uFRfLdv7ES6hX/i8Bh2FPJuRL9CcHgzXIh0Sjc3+p7wrO6JA0FaZRt34KFusHxw6dqYPSCCWtlcW+PB/GIhsHKrt7Z7MGtTAFDaU4HuIJi8vd72kGs9J3WUYwzbo9mV27XrtQDg5VeGDjOFuH2X5XNq8JXBhA2KmjJcA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(956004)(107886003)(6666004)(4744005)(110136005)(36756003)(66946007)(6486002)(316002)(2616005)(4326008)(52116002)(6506007)(8936002)(26005)(186003)(508600001)(6512007)(38100700002)(5660300002)(38350700002)(86362001)(2906002)(66476007)(66556008)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uyCV/XIRR6dR8aY9axUvPjH+1GI7T9GvRcC27mPMZRBwMdXZkMSLLFoOCpfT?=
 =?us-ascii?Q?DvnVHLnTGyplCi9e8aSpMHXE8renhfCJ1hDpGjKayUBCGE7wHFmxxOsvpozR?=
 =?us-ascii?Q?puIG/XhCONFIrEGJwiuchmXjmOv1j9Q46oNPr3LHXqnGf8tWWh3l5SZ7JogF?=
 =?us-ascii?Q?uAajdL/9UJ52Rq2ShQIpnh4NtTzBaT+cfKt6Jv9U+EdKClsEOFQm1jIfRmdv?=
 =?us-ascii?Q?54eJrdGy5vwDDKOTUATLsnRw5cW9+uad8Ih2eyyPHcWjBAMQZe9XClhj0FI6?=
 =?us-ascii?Q?DbfDLQl44ZaUQwmmp3LcRe08VBWI2Ei3NetN10xhUqVivvHxDtrUwIe9OKq/?=
 =?us-ascii?Q?M4mNaowHyiAyRgKlz9dIUN2btS5wDN8Qb6PXGn/MT9gfTvugdOy/emfTRsIZ?=
 =?us-ascii?Q?JcZgV/L+hvLcIKCCxLmmhKj4hId+frcaXvBV9AzwsR6ySnlyiUZIjbVbl6GV?=
 =?us-ascii?Q?+p492+TUEnwjSQS14MIIPe13kn9numpZ56nZOzhgjn+z0zB14+CuCk5UyLw0?=
 =?us-ascii?Q?bmbELbO/6KXZr+A3XCfoW14Fk/joN7z9HKcxPKS01rdjKR6XXPn/fOGNsMDI?=
 =?us-ascii?Q?PtEAYyh9FmG4lTkhBErpUD4B1PXE03C8tLtGN2uzaLAKP5xiTLRFfJ43VMXs?=
 =?us-ascii?Q?KRUgSY4/qbcRL8qTI9pPs8nEfE0b36Rffy+Ml64vbIRanNnAAWULA40GRfv8?=
 =?us-ascii?Q?FbcLWcv2j9TC1v+8iYQT+6sm8/Fbh86nXoMygRFHqt8jSrSM4nKnydXxi2m2?=
 =?us-ascii?Q?jVwzpS9tvPGER+1f7bihMrNNOY09BR/wDsXyGmpfzC9oJzyzbvPsFoj38HZo?=
 =?us-ascii?Q?7MypkMMT5ddvXoSZbHcYg94ZtTvEp7ma9Vr0ZnLO/1pFQvxAxeKUDNYfvewU?=
 =?us-ascii?Q?H4lbiZ+qg4FG8/0cG9xgCytl5O8yw1iysBrK3ZeC4kbIHq2X2i9S2zWQied6?=
 =?us-ascii?Q?I9f68m/gtECN8UYwmbLIK1QBiqlIQE93Sw+j141T7aMB68+E+ydMvbanXptf?=
 =?us-ascii?Q?MXXvA3MWM37Mhkg49IhB4/2CTIgvIfC6fos71qwmMvnHxeTl5+bdtRy/xdNl?=
 =?us-ascii?Q?SghQc3XMOZC47bONC3jbeIY0kE9VzT0U5A3jnmPmQ9fdKXj/CDsdC+bSPViW?=
 =?us-ascii?Q?aZ+RvwKv3HNMBv8uCHGjOzBB+7pzrJIXBANpX5/FLdjanpTQMq/qDcIRffwc?=
 =?us-ascii?Q?VM1JAA7omvNlNaJpOeJNPig5obK91p0eyU1qaVDDcYad1/QQhS2QxYS1K1Xv?=
 =?us-ascii?Q?z55G97l30QOic5wlk6T5XV5LB4z3AlO83ylKl//juu9N2cT1l86bVrVFOtMC?=
 =?us-ascii?Q?LUIap1ARPDS2tGyCswAr4Wc4Art0fUFfy//E7dpHQCoVMiRo4S2IeVzWVuet?=
 =?us-ascii?Q?kGa3/4KzT7TvBA2EZfZbddFEQv8XojAnkFg0gkSDBzAoIVguPrSzgc1r8m1a?=
 =?us-ascii?Q?d76Kjao6lwjkgGtZX1Js0xwcAe1Na8a5Wisa016YQz6hviqHuyCDROdEOJKa?=
 =?us-ascii?Q?ON2R4W40CMqx6UbyzUUJIgZ8/UyW/NmMVrsW7X0F8IknmHdXPxcE5e/J4ajQ?=
 =?us-ascii?Q?vszPx/cprFpAZPekcb4qxfdgLnNGkm08k7qVy5h3qiotVOWCA2FG1303FWwS?=
 =?us-ascii?Q?QZB6BboVz/jctCzG0WiiN4A=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc190b83-1df8-4ff7-6582-08d9bb0e5a99
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 12:20:57.5985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NT1xzUHbV8GD1dxsD+30R6gh26XJVxhGwTurKmtHi5E/4Bzvwpxfjcld5we3lJElKpvZoMJ7o0xqArD4tUOvig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR06MB3180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Qing <wangqing@vivo.com>

of_find_compatible_node() takes a reference to the device_node 
which needs to be dropped when done.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 arch/mips/ralink/ill_acc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/ralink/ill_acc.c b/arch/mips/ralink/ill_acc.c
index bdf5380..115a69f
--- a/arch/mips/ralink/ill_acc.c
+++ b/arch/mips/ralink/ill_acc.c
@@ -65,6 +65,7 @@ static int __init ill_acc_of_setup(void)
 	}
 
 	irq = irq_of_parse_and_map(np, 0);
+	of_node_put(np);
 	if (!irq) {
 		dev_err(&pdev->dev, "failed to get irq\n");
 		put_device(&pdev->dev);
-- 
2.7.4

