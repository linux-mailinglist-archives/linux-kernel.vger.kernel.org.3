Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0D5D4725D6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 10:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234990AbhLMJqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 04:46:38 -0500
Received: from mail-eopbgr1300132.outbound.protection.outlook.com ([40.107.130.132]:10560
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235757AbhLMJmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 04:42:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XLD0RcJl1d7YU7YXVHFsmFZYeSLHvSo92DMQOpyPoccN/NbeFibhtSNby+bnGr5GDh6SqLj82MFrBTo3aTwbgB9tvBa4WGs9QJWVQ7jFDsqTs5UbCW9+s9vbLgJ+ouLDEjreeBzI8mb2VXmhiOtmtpZ4JvezAOPCHPK1CGSSgVJABGeiTXHN1rsEYLv3RbM64tRuZjW8Q0QA+pFTWPuro6+JdmmtdKMaznhvBHfgFxBlxEsOwWIfp2+s4kA9NM0geDH8l3CPdotjzQr3v6NxVCNXm6IrJ72mS8OubDRFQYiLaxgxufScird55MI5Hef6ng2kQBVzJSX5gdqoCpmK4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0l03FuRuXi2etRCWGNiYP9j3US71XeqfgbWYzFG2Wsg=;
 b=XHuu26ia7SeDNtJ4r/Wwx5IhKwkHkyfnI7Z2SGVceeWHN8qX582aGMW2N0hRSccvlPUe+MPjTiJ//j3LMe30aSd6a4CBPIEaGshO7f/RYPTaXPFWCX/LOQdZQq+SKy8qPlrZRsHc1cPd8mQWgMhWEyUmwLFRVHeTv4bKlvbnXScwa9jN15E7x3aycEVMoxm0nBoknZf9OQtmU/1IHI+MPq1pnggpphCF/rdL5ReSiL3Qh77TJ2lGN0KzPkgF0R0cX0RjdKm8TZqQZVg3tF2ow9ERxOmZzPEZzKI0iTaVP6JSC0dG6OCVfGix9Nd30zCBE1Y/HNMEjbG3y8J2zFMZLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0l03FuRuXi2etRCWGNiYP9j3US71XeqfgbWYzFG2Wsg=;
 b=IDytbaH07aqJyFCCfTaZaQfejHTYhyI+c/7uRhXGnQhmkpq5Vh+yZ0PVdJCX+9Nzelu7KMkyPc1dAzqYm6eo5tH7RjR7ll11dUO/0ZYyxeYlDB/VZSMyrQlymSrFT7gfXTleCXnfdsDfWLfsqdPMlpvsvx0bBZAbSl07zD5sXls=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB3179.apcprd06.prod.outlook.com (2603:1096:100:3a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Mon, 13 Dec
 2021 09:42:13 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::a0cf:a0e2:ee48:a396]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::a0cf:a0e2:ee48:a396%4]) with mapi id 15.20.4778.017; Mon, 13 Dec 2021
 09:42:13 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Russell King <linux@armlinux.org.uk>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] arm: mach-at91: add missing of_node_put
Date:   Mon, 13 Dec 2021 01:41:56 -0800
Message-Id: <1639388520-63567-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0108.apcprd03.prod.outlook.com
 (2603:1096:203:b0::24) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5f8283a-9fb6-4d10-0d13-08d9be1cd72d
X-MS-TrafficTypeDiagnostic: SL2PR06MB3179:EE_
X-Microsoft-Antispam-PRVS: <SL2PR06MB3179CDBA875C06EF3BEB498EBD749@SL2PR06MB3179.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HfBZSxqL0JPj8KU+9Ybl9BCMaGa9px5AGuPWNQF4asRXcSkpWHyenWV/W/mzF0SWyxnqFxVP6hm+EXglqg0zrdNIV/3uNP9FEr7MhCi0g6bz1vCKA3+fIL+kMUjWwIOaEivxjmPxwV94wKbthPQfj8ouHlg+VL/GRof0xcfZMzAm2J6u3a69VQC2/CkwHLQagmZ9ohrWZEOpgCUG3ShsqKXMzFFJFBSynOL2G9y3rVSjdRhqV5LhhuDoUwslfDEqbSm5194Gg+FJr3VsuFVh+XXHdy5z1Yg9idiuxRuVy/+8SVCAggLxruoOrHi3P6UsDUvhd0rxwv13c6W/eutHYyQf3cC8znLzu7LjTG492pTDUoLNlkMsH84seKbVmK1bYctBB3yuipnFNenVsglrkBUxcV9cDSmWyypXuvzzRvMO9Pu9WPviNjFTEzm/ushg8zefpoeQhg5Nv3nA5hzyumqAKN/6phk9hvRhgZSV7S2UmnS5wwY9HTnjZz9K5iRL8XAvY0R2F2wuUt7/wES+Cvrh5DSgvO2V1Lpe9u2CoAVsWo6OfFvpMHVxZfqxeWg0wxAcYNg6C+VGxVTKAtjWJRMrzkHCYsjnwPiwvrbWmDBZgrxesgMgERZ2SLbTrorB3rjXi6Gm064fzk1o/UqBVoiJ5grWqEvVONK/zfDOcWdRHKJhrqLVL+zCR7pNXtqEX5vTolPwicg7EPT5ABROaw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(107886003)(6512007)(38350700002)(2906002)(110136005)(66556008)(66476007)(186003)(36756003)(86362001)(316002)(6486002)(5660300002)(8676002)(66946007)(508600001)(8936002)(2616005)(4326008)(83380400001)(52116002)(26005)(6666004)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?89HBHqy8TzHHyFapEnepMxYqJtHtYgh2sis34gz+DOlcz5QYNColRDiLG1Fo?=
 =?us-ascii?Q?oo5v57UX61F2ET89ohUI+zXicpxXTXN7E1W4QDSRT7a7CJIIOXIUMlKPLEEd?=
 =?us-ascii?Q?hIPo657UspnAEwpPYAySWvZi6Nmg6AdoIkl2wRQ3hoq3cOoXTBi7FmzDhoTO?=
 =?us-ascii?Q?V+VtqvGTsLCuor8zwxS/C4NegNPEC6i0U004iZ9gu3oHBh/9Otij4r37y7Au?=
 =?us-ascii?Q?Pjul/Kg4vATj7haKje2/HTB+f/qgy0S5q0FQhwRqjabkONBRUXVIF5ZgLFgC?=
 =?us-ascii?Q?mVw4TeODzGM9PmomtOZB6Ix/MNm4MZ9W6PG3hEkLzBDlaEl9l+d+NkxGpZM+?=
 =?us-ascii?Q?D1U1BGsEhzSsjz9s49ONCvwGFs7Hi97kQfzEctmS36XsfdtGJcGz86JioECQ?=
 =?us-ascii?Q?7wuT5VjJVooaMtXee8l4nXW3L3uxLvgludTFGfAwUPYJOgp+QqNp+Gu9BSg1?=
 =?us-ascii?Q?B/4fw9orrI/frpUbqJ0YKsCl1wx5Y1iYwhnpy/jWNASq/CTQmKm4KdvvKXRf?=
 =?us-ascii?Q?Tac30X6eKJlwe9GrL1Jx0F52ZVRGEzjMUoQEe6ybL3n5Vti9o2hmO/292lUz?=
 =?us-ascii?Q?oaL+rDnrRLRCehS6XCqkQflto34jvYhTW616fj+6kJMjrDuBRmHguW6hZIML?=
 =?us-ascii?Q?eGbHA7OkEEZUHzjLehW0L3k2QIUZb7aCPr8xvRuBTyF+sMkazhBotZDxmqEH?=
 =?us-ascii?Q?s3PFJllfl+Mx2mUiSodr+WLTeXp5b/jLEofd752J27p/wiEo8/spUFD96K/e?=
 =?us-ascii?Q?jG0ngEuYkOSMK7ti1aDFDxoIQWhtZDByATjmSCBTwF9Lb3PemwBrMUZrWLV+?=
 =?us-ascii?Q?9sXz0DR+wT8H/LrQJRLGTfZ/iAgcaQmQdjIpeW0i38+wT4v9vyRfLCs7mX/l?=
 =?us-ascii?Q?zi2vQenZKEu6L3qo7bMKYxXlb1r4T1iBy2LiAQsaCZDVTCOdP2mLZwoynVxl?=
 =?us-ascii?Q?r7/UtubcrIq/6PJkeDWaVgvc9ht7fNxxwSyCWRKCY8jEHMspPyU28Y2p5nCd?=
 =?us-ascii?Q?4tkncs9uYJmNwAIaauT4KixOE47AkZQmxXiqaW3QaWpZlvbksuDLPGlRtY3h?=
 =?us-ascii?Q?sUhAbiAqUSgojCl1ifdHGa5qENhETjbn30ZwcIWkQ7zTUtwrI8q+JW3T1Z2o?=
 =?us-ascii?Q?oJ0ODUg4S+k9+4rX0gerxdAJRC+ElvfjUjxNam3IVGB3UpN33WUDGl2vnbwA?=
 =?us-ascii?Q?qJyoop7xOYmi7hU+pbWxabkwJjtDjWsuSjrMFeqFKSEhcgduU5MAbyFlZxNK?=
 =?us-ascii?Q?c5bMNwSGVoctF+Hw826wSm89TuXxVHt8rC4gAhcolanrWDZr9ATEis0OYBV4?=
 =?us-ascii?Q?uc5XNJNcgUXfJVHwiyouUOtAMt9dHdXuHKe4Nt8r09C/S4RDcF/LzXUiwW9M?=
 =?us-ascii?Q?2CRxTQCAu8modGUWJxgBv36UJaP95W1UJRPANuaKiWuLSkIvcWrbivkvz61k?=
 =?us-ascii?Q?2N4TUpuvtej4c+nA82szc88PyMt5r2VF6iLEoRT54tsjk/K+zodxV06EY3DQ?=
 =?us-ascii?Q?LGSmSPZtuqadTlEisStGeKgICKTkBYbpdaPfzo4sTLWYUyTL8HjIuJErrrBy?=
 =?us-ascii?Q?WmIXcqZRJbYQ1gq+ERchmcdKFNt83iVBbmCrBxCA+UiB1TfWIfkQ8jkzskR7?=
 =?us-ascii?Q?epM3K70P/TC71T+pM0+ZnxE=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5f8283a-9fb6-4d10-0d13-08d9be1cd72d
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 09:42:13.0799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qCtBsUWwPd3EUf2Vk81359UkPs+SlaNDUBfRW5x0DVFlP4xOlOd54QVqYgs3g2NQTVUTAFD44Jdt0xtSjPTZgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR06MB3179
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Qing <wangqing@vivo.com>

Fix following coccicheck warning:
WARNING: Function "for_each_matching_node_and_match" 
should have of_node_put() before return.

Early exits from for_each_matching_node_and_match should decrement the
node reference counter.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 arch/arm/mach-at91/pm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 8711d68..ca313fe
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -644,6 +644,7 @@ static __init int at91_dt_ramc(bool phy_mandatory)
 		soc_pm.data.ramc[idx] = of_iomap(np, 0);
 		if (!soc_pm.data.ramc[idx]) {
 			pr_err("unable to map ramc[%d] cpu registers\n", idx);
+			of_node_put(np);
 			ret = -ENOMEM;
 			goto unmap_ramc;
 		}
@@ -669,6 +670,7 @@ static __init int at91_dt_ramc(bool phy_mandatory)
 		soc_pm.data.ramc_phy = of_iomap(np, 0);
 		if (!soc_pm.data.ramc_phy) {
 			pr_err("unable to map ramc phy cpu registers\n");
+			of_node_put(np);
 			ret = -ENOMEM;
 			goto unmap_ramc;
 		}
-- 
2.7.4

