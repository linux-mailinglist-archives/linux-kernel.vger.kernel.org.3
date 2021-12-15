Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED1347531C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 07:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236057AbhLOGrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 01:47:10 -0500
Received: from mail-eopbgr60071.outbound.protection.outlook.com ([40.107.6.71]:54147
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235974AbhLOGrJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 01:47:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NZG0EKiPRasF+QuVUTsmUn2ezVVQBrthL+AsijGV8BAT883rMici21HGWxDrwnbt40sWgI8wp2pSn6SojBIidL7yIY5CB2XjvCbnaATb74n8gkj0Obne+ih+3F3xNASjAjwRmKvT/W7YrBPX7T6EL3C0tXNVQNewGWE+3n8fYcV0W+xIrFwFkVQAxuCNILYkek9cgXStmPOzGOmmVWZErFasXOGUFcGrlGNxb1cp96Rm9PrKcoAKkPiNrzyaQwM+KgXM/oDOctzaU1Z8kuPuIpk6JH2oWJ8liYrDGi1eXowUIvS0UDw2WIMdI9ylB3pz704ML4sHduk63QdxexgVuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e9MJTkF+byezs2Dq6qUcgdH27g1xk0GoHGPFirp5sAA=;
 b=kdhY6N6awP1zqc3nPvPglnuYMLKsyBcvoUoX2m06og5EU5WCzTLLu13wgv4jeiEF6Om5MqiT87+3m69FbTfQAWWe4js+3ysx/c1xksCeMiPWpZQG5eZEyfKOlQYEXt67roMFfCky6/FV9l24IM5/IAOHU2Gl8pWVZ/ROWFHzsci962oRi9kA1g84kSQY8Jj0nQX3YEzZhycuaRDRT8Py7xMVmsllEGD+2rdsMyr4xs9YMAVtXgQGtrD5dfyWvHKm6CqM2/iIZmWYajwuGjqERi3H3vRwjRm2FzO2IcHxWTRYu+t/UYjpkEY8s8C+YBok/tsAaWu6Kgro0/M5pmJC1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e9MJTkF+byezs2Dq6qUcgdH27g1xk0GoHGPFirp5sAA=;
 b=GTsDWZ1CpB2b1K7hoY9WWZD3sAIESP2B0CfyeBvKqsVAt5BEgmfcoZmkHsPDGybb47fNGffN+ghlpfcsQpcF16x4XmENYW/lftyaTwwM+rJ2egbJcGC3k1VqCz0CCRN+FDfzaaps1R/YjJFKlPDue98aWAVrMgEXHCq6T40XgAU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8949.eurprd04.prod.outlook.com (2603:10a6:10:2e0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Wed, 15 Dec
 2021 06:46:58 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::82e:6ad2:dd1d:df43]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::82e:6ad2:dd1d:df43%9]) with mapi id 15.20.4755.021; Wed, 15 Dec 2021
 06:46:58 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     catalin.marinas@arm.com, will@kernel.org, rppt@kernel.org
Cc:     akpm@linux-foundation.org, david@redhat.com,
        anshuman.khandual@arm.com, geert+renesas@glider.be,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/2] arm64: mm: apply __ro_after_init to memory_limit
Date:   Wed, 15 Dec 2021 14:45:58 +0800
Message-Id: <20211215064559.2843555-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0160.apcprd06.prod.outlook.com
 (2603:1096:1:1e::14) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR06CA0160.apcprd06.prod.outlook.com (2603:1096:1:1e::14) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Wed, 15 Dec 2021 06:46:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a86da78-7d12-433e-94fa-08d9bf96b08a
X-MS-TrafficTypeDiagnostic: DU2PR04MB8949:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DU2PR04MB89495A0991E9E7C8734F77B2C9769@DU2PR04MB8949.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:854;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 70wOOXljI5HUKbdJDt2VAU8V3hP834yGk5HvDpMK4ygkVgcL03iYa6M8iZeSCPrCN0QmFQfo/oK82WVwmNehF5nFh/Du8kzSr5HQgFR04Gpd842L7j5oNtZwbKvacL1HzP+FdF8A/iCy7D7pXI6DFg/G1xghoynZ7wXEV60yGCA+FSn8A4cSggu6tGgN6n3QI8F1TogMiqLZQzvrOpVconT9bx/zQFEQnoMuTpUq1nWgxpqDZUnx3StLqi2sATvli8V6YYZX+WQsLve9ApsiWdxAMEaZqTHy7jTRC4Jd5QCWrSkHuNLuiAZ2C7xvfUHBk0QYvNySywQ8aBMCJtEiRuOBDWSHNnP8vlIDv17vjZt5oFLAFk7eVU+kT7M7C7tWrhEnGrlAzI0guqBuE2CjHgjjsISjQPGomBPOLgTSC8qAo56QF+B8Rb3kZUbeP9xAB28Abol49a7DcAsoKxd2h43oon4qxrBrXm08RVdCkESKPDyKF0cSMHqhq74Q9tury4DzsXDQNU6ubppvUJEdTesW5AR8j+565ASdDAkXu3ZlbNqe1y/68IVm93HjvLNHw+N8VCe0nu+HoR8pOUuNzYGJIm1ovamHd9JlYcY8dFtPutptuJDaoTef3X9FaKR4RYKvKbBJvaiS2SGvyIkjWW/fY+KUh+Smj0dt5664zmSvWDu9MfC0kgW0F6MDeCUJH5hWiZvSfQu+ZmaT7KftJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4744005)(1076003)(66476007)(38350700002)(8676002)(66556008)(38100700002)(316002)(86362001)(2906002)(508600001)(83380400001)(186003)(66946007)(2616005)(8936002)(4326008)(26005)(6486002)(6506007)(6512007)(956004)(5660300002)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?coMyQf4DOTXUPuPdaGPufqe8aXL6Crwn98gGsStAmYq523hU8iAurGno4QYT?=
 =?us-ascii?Q?GO0hoRRpX1YcyAGjc9Bz5WrdOsXn25k5fGjmsvcGdtROVQKpPso8Pvdysr6z?=
 =?us-ascii?Q?iXa63LejmmaNa+b7CXSOPbBK5lyyGUkkU2vowUJMR30b22Z9GoFkEfTIxibl?=
 =?us-ascii?Q?XKMIR4eAc73jgChW8VZgKrAKUEp93XOAYW+O6gv/Et7XWtrULRyvLaDxindw?=
 =?us-ascii?Q?ZDKslBdzLQgskSE+FaxtEQAjzUmqBKh/aWDQIai5qLyHJNyje9LwVyFnDxP6?=
 =?us-ascii?Q?BHTS37fnwnH6gE4p/QQAg5SA9ROnuLdaaQ83cCSNEHH0Ez9H3lfhwGHDw38N?=
 =?us-ascii?Q?Rxcb520WQTMAJBA6qwe5dyEd0h2rMGzH/crtXqUE5XXEW1fwSqTRIP9US6s4?=
 =?us-ascii?Q?IQSRN7zm3/A9khonlCvArengSX63otN/xZcocbP0xMUeTEpYM8K+YJuOAmSc?=
 =?us-ascii?Q?ImKwwlgaBE+zkmKiBLCe7Lof9PigzIikQJKkuZ9tHqk81XMTt0zGOC6ZgN9R?=
 =?us-ascii?Q?WHRt11tvMJCqT7+EhTPASXq5KFNQxwWOe7FBURQMbU3NXi25Yn5lLhqHFGic?=
 =?us-ascii?Q?LunRwnaino/kEGDOm93FUkFtZNmp+Xm9HKGk2MzRBDMETfz9GB/G7vUU/JXS?=
 =?us-ascii?Q?9uiQOaHxxrE3T3NAerCA968As0ZPAngQBxqQQvylAHuHiq8+rHKqSm9xxY4h?=
 =?us-ascii?Q?CSZnStdg1acwIvpg3AQ6wHEuaMwzUkxQUxe+HnAVkhOS6IDlmDK1H8zlaL71?=
 =?us-ascii?Q?vLic6RctwNZqd8ojaJorFXgh+cZ2D4V+g5tX3rm2jKbVoX1sA9g6FHn3BMxd?=
 =?us-ascii?Q?4d44/0DinrlE+0obg1jHFORSoneNzACkDpIS7B32z1M81zciYKLNV6O6gyhn?=
 =?us-ascii?Q?TpOjhFjn/x1l5koBlkMqz2BbTeAEooaDDzeUo84zQYL3wtkpEYpCLWji45Xg?=
 =?us-ascii?Q?6PKE0e7/9aCO5ILGVk+YzqCUf5/oMBCJuQGam6Ce+rnsiCZOQNoj09UJ8r08?=
 =?us-ascii?Q?i2MY9egMy1/et4ndKWlA8KcUms/ihqx7dJyZ7uMBx85gQztDee1zxEQtKkSt?=
 =?us-ascii?Q?KxoAS4BlSka8tRnuKWGhWCzQu/E1kCFA7AJC82CApWdb2Jdn564KTDRCFCBx?=
 =?us-ascii?Q?MOYDJb+qgz7KlJAkExqJoxj8NG4PuQ89CZOPPoOoFx5btmIV9YW4fA6CRW/o?=
 =?us-ascii?Q?lXLNjXcaPvNzfLA4VpWb5vPDIxzyiyHqIc+i7yEx7uHitH/67onAMMulldAw?=
 =?us-ascii?Q?6hugpciiFecSF2iFxkeHy8LOF5Rcqfrq0v4Pbxidbsqh+jQW631ozNE2/FSw?=
 =?us-ascii?Q?/9hoyv+TqJBpxsO4gHogcwDssp33sJgVj+UeF3i2QttOAuvBSn60cGo8PjCu?=
 =?us-ascii?Q?COWONm6C1KrF9NW6Qt84f/h2P+CQETLAGonC/eQ6hqMJ/aRq+Er3YKCpHXHa?=
 =?us-ascii?Q?CFk0n4oTUbD4yefnHichfv8Z7Af1FfoPE8xNz2qasWbMzkpl3Vd8RZNYz0Mw?=
 =?us-ascii?Q?r6D0HR/p8SRyATc27JL/UK+Pi0hfi8w5iiekDqGLQ2DNfzjeHT9XXhJ5ol9c?=
 =?us-ascii?Q?5KFs45NCTqgkodW/9Aa+tQjbf3VntCK7pFF4Kr1fi2j83EbdAcWxMbkqy9tQ?=
 =?us-ascii?Q?I1EbJqnA2vQsitIwTaszGy8=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a86da78-7d12-433e-94fa-08d9bf96b08a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2021 06:46:58.1699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5VTgAVyWQCG4/GgkGOJ6932FC7jpETqToklqvRjmPQRHCJxpTjXsbu0ES/qhv7UoPwekhfPLQivRuN+XE+VINw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8949
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

This variable is only set during initialization, so mark with
__ro_after_init.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/mm/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index a8834434af99..db63cc885771 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -172,7 +172,7 @@ int pfn_is_map_memory(unsigned long pfn)
 }
 EXPORT_SYMBOL(pfn_is_map_memory);
 
-static phys_addr_t memory_limit = PHYS_ADDR_MAX;
+static phys_addr_t memory_limit __ro_after_init = PHYS_ADDR_MAX;
 
 /*
  * Limit the memory size that was specified via FDT.
-- 
2.25.1

