Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDEC547531E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 07:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237087AbhLOGrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 01:47:17 -0500
Received: from mail-eopbgr60071.outbound.protection.outlook.com ([40.107.6.71]:54147
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236248AbhLOGrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 01:47:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k97R1urHgURd4WFaAAEmzwtrp3JN6l1RftP0pWPq+Ws2RTZlepyHO/1GtbZ5PCJlk21rOjXaeWRfkDbqTSVOO/S+Fs1QmVZnCFZaDC6PPtXsqL1cVBVH7vXnxUA+cyLo2+GivMW4ZHkoIFNH5t2M4Rl1vQNBlmgY2mwKqTVtYms3faT3C52AgpnC23hMfNT1HJZFz/zlxLFzktCpbWr5IZOKPgal+PMiK3HH13rJa0EAjetgzumphEP5ZkoZfnbxKRliEb4+kdWaHj3Mbp+7HddWPiil3JGdN9rsJ1ITopGnLShc9KFdASbyp+D29sFmTtW/RW5Gh+neFd39C0mpWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D+i0JbIswgY34DvX6k7mtcFQapLxR0IxpBuCgFUQREo=;
 b=AfErYC/Q3rb720w2no8dNhPft+zGJHRxXyqbq8zphtOJFPYEbJylcuzmKKZktgZc8+Wkz9JQ70KzT7jOxOYS0iONqSojsr4fNLm9ZInO4ZsLew9h6rRLcOeaKSUI0KHox4lVgmv+ulc1OnW0B+q8hxfb6NIaWh1C/+JxSn4Yv3awdlvzBffkLkQeVjoNZUcMKaWvxz5Sdbi+gHrFarUOpvr8HQWXy0xzajQjNgmQuf046AWN+jIRoLxC0mem9TR88I4RkfD2R9lTiCiktRO+0UFf4MAXMykhvCH6wxzPmL8QH715VqGQ3gvLuxBIIteHIpA6yPYwTF6gsuKOuC/CXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D+i0JbIswgY34DvX6k7mtcFQapLxR0IxpBuCgFUQREo=;
 b=Gze1vv6mbsRcNMyUSBSprP3KtrxhZ2FcNPsvSwdHrI6Kpe3KF25QuDns71V6CbDRmta0OJfrHQoStRiOId307Tb16ZpnrrWGMQWBaRB/WK3+5wWzgW7KxcNaZL/mweqMnkzfbUBT6n7ZDQZlCy8CRbMHmOFAfbzN1dLkuhCcWdA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8949.eurprd04.prod.outlook.com (2603:10a6:10:2e0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Wed, 15 Dec
 2021 06:47:02 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::82e:6ad2:dd1d:df43]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::82e:6ad2:dd1d:df43%9]) with mapi id 15.20.4755.021; Wed, 15 Dec 2021
 06:47:02 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     catalin.marinas@arm.com, will@kernel.org, rppt@kernel.org
Cc:     akpm@linux-foundation.org, david@redhat.com,
        anshuman.khandual@arm.com, geert+renesas@glider.be,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/2] arm64: mm: support bootparam max_addr
Date:   Wed, 15 Dec 2021 14:45:59 +0800
Message-Id: <20211215064559.2843555-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211215064559.2843555-1-peng.fan@oss.nxp.com>
References: <20211215064559.2843555-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0160.apcprd06.prod.outlook.com
 (2603:1096:1:1e::14) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR06CA0160.apcprd06.prod.outlook.com (2603:1096:1:1e::14) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Wed, 15 Dec 2021 06:46:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8248506b-8a5e-4b05-ccd3-08d9bf96b357
X-MS-TrafficTypeDiagnostic: DU2PR04MB8949:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DU2PR04MB894900AD658A417CFA689BC2C9769@DU2PR04MB8949.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z5Mwm+nZWS/pwzK8O2dt6T7oFEfGlHXn5S20wUxf++UEw1VpBakHwewGA/jrG41NV7hWWM/A7GxFnYvpAXl7M9Ll3k0BuqNQ2DiqT7gElG2pP4sr72MC50fNIEKHFJWqROc/4gugrtPJ/nhzhFaEi215yffTTfCWEVydQioREYlNcmtGHLBvsore8QBMcbuu+t3vZISYTvY2+Gh0VUQa1QeyIofgx/p+nUIHIQdmi/MJnu2iMNdr608yJMx/MRWstt8HuPS2XV4tOzJ9HDjXNsKnzYHaG/puSqqs8s/ynltMUAo07GJ+Xomtqe8aJMNkr97mOql7J9AEbnGC1qVBf02owv87/bzv/N591H7vLJRdgkvXAq+Qpx/W8cWbCqP1Y8z8bU1YPuuxH0wB0QQ2TUyQyqGPwoUBUX70Ae4TMaK6goob3WpeNdB3W99wwwxc0vHIBiw/chmWb3r5B5IZP93TVa3nIuW6wkpFFDMas8qtQLob46DJh8VxX47D2mHJv5RX0jgsV5260G72s/rvO8KC9s5FTsuaaUNf/oplQcbgMLTf2fXnetN5Ee+7PzIZoc7gQY2ln1+0OJqciv8cZQsa7AIDtu32o9wROOO+3XNEVDFCHhrUmQwTyNbDx7AzB9e+FvfjAPQiURyyDvXLBF12Oq3IbiNuai2d0FTTsKV2QhEaOuoeSlvUxIJaPdPn4HPvi7OVh++x2acz7CB0lg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(1076003)(66476007)(38350700002)(8676002)(66556008)(38100700002)(316002)(86362001)(2906002)(508600001)(83380400001)(186003)(66946007)(2616005)(8936002)(4326008)(26005)(6486002)(6506007)(6512007)(956004)(5660300002)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vz8WPrnkzjdzK/Jkdx6qQiNwMug7pxrNha8mvvQfeey+gK2zDaYqBWmzjkry?=
 =?us-ascii?Q?DQs7BX3Iw57s85sLfBhWgzcrociNpfWnuimUKyA5a1ZJBoWCyhJwRhYVI88A?=
 =?us-ascii?Q?hdIbcgmItPCLiuj+q/NIz7CAOgkJrC/REAOR/N7PA3a3E+Lylpt2PmzzhPd/?=
 =?us-ascii?Q?2k+4SiUKCKOBXB5fZrZnrB0EpLLtP1qTvawKi/mK6iKI9mtEJH5ClSbZeNMi?=
 =?us-ascii?Q?DbVejiIgH/wxVajdU07yIpmbQDzpH9ft2OgjvBzee1RGmQ8JK/WQHP2Tr55E?=
 =?us-ascii?Q?OhecVXm+xu9oVIfnNuAbxanD4KuC7ccb7Ro7jqnTnBNn1p85svuyHdij1AMp?=
 =?us-ascii?Q?WWkYnGI/ueAgCmszE1RKJhsqWm/bvjwzHEUEYCfM257rec2MxfZcus5coYtS?=
 =?us-ascii?Q?mODHQAVZ+mni6WMs0vKoM9bnfc2q+mibwv+onBJzSZJ3eewEmmsbUyquBkga?=
 =?us-ascii?Q?WMQEBls/ajF5Tiy16hPj5H8+eRzB28Gnx38CCWhI+GQhRBC6r9WtR6AfNqOf?=
 =?us-ascii?Q?hZjPUN1lq5i9b/L7LxaGv20cUU8PqWHMZbkQQnIGRhGAh2V7QHvzIW2jNDl7?=
 =?us-ascii?Q?VmINSkB6P1ELItAhRxAGi+RFrEks4POPHRzs2CFopSnNUxEoEdPv/WOqY33d?=
 =?us-ascii?Q?S/cBuXjabt646/RS6mHms3u7GI7QsJs/blc5LHT2T1TMAI7ptR7BZCdtqTVA?=
 =?us-ascii?Q?KHLXOJGssYz3SAD8SPLxqkBBHc/PxlYzswezUtAqpdbtaJicx8reFcdBQTes?=
 =?us-ascii?Q?LKh9or2CJ8znR/kw6PzECr4J4js8MA2wuvTOaak1XJ1X/qLedAKPsNTAtwZ0?=
 =?us-ascii?Q?ZaJzrMcIqqA+ws/dXJ2QYG3pNR9vNTImadYAN83UpUhNo4sxn134cyD3JQDg?=
 =?us-ascii?Q?QnJyvdqbfJNQrms89c4XF9BSfnwj518uS7jKVS9zvymXv/+1DG/u+EX/Rr6r?=
 =?us-ascii?Q?LpytyovvqrBHis/4UCjEaACvUBukqljWAupuI/xeMrqDJJVchNrk9NbERw24?=
 =?us-ascii?Q?ZjgFSGkRkMRfu0d9lW83qEwz1KPEZ4+kDpeXKesyeMxpjHUf4H4QpwJHTe9p?=
 =?us-ascii?Q?3+VVBgwTVYbAEGu2gTLOr4/M9OeY63XTgZqeEXjJyVqlyYT4+2siC2j7KIZh?=
 =?us-ascii?Q?DQ3P2qJX+wGRiGKaw26Ft73dgS6O8TcorFXWKHJ2SCo4mLnaaB8kDhC7K6JF?=
 =?us-ascii?Q?WOKSn2yloM2jAO02fmDqfU74iEU2Nz4j4l1aD4BJcSYiIVJyWyX2tlPZngdk?=
 =?us-ascii?Q?1ycBfh4L6dpU5MwkJTSdbYjOqjZ6EG7mm+PPUtBlNu+v4N9qcFwNTTDFOTHY?=
 =?us-ascii?Q?0u2gXBeKUUsC8YE/RgV6OHyUrN7XdoVZUVZi5MtvGVrqMBAbIk7GGH2zZFAg?=
 =?us-ascii?Q?ak2QB8xYAJPNXhAb79ztbs77OY/3yQRJMi81ndcmPX1aGOHNGppjLsWht99q?=
 =?us-ascii?Q?7orv1idVYle9PX/aEEy9gBh1ENbdlGJd5o8jUReHmoFnMBpLaODguFlIlU7W?=
 =?us-ascii?Q?RaUh30LxQh+X5hsh1HI7Qy0fMJoOUBL1kyzEx4ihQgoQayPDN40S9VJJU+5x?=
 =?us-ascii?Q?Z0RZAYYO9GerRkFOFWiDwfbnRlbwp94U9kEnf5HSlK9JOZoZAtl7rkDspTX3?=
 =?us-ascii?Q?ZjB7hA1Y3tEF/HdTvOHVw2Y=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8248506b-8a5e-4b05-ccd3-08d9bf96b357
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2021 06:47:02.7109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZKFdiGD3Vpb6PxKf7Nd/l7xnNSjhQ1FUXxIQLCD5kpXOVEL8DMH8FceMN8KergvX7oPDXcI3TAfsBt3oEgI5VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8949
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

There is a "mem=[x]" boot parameter, but when there is a whole reserved
by secure TEE, the continuous DRAM area is split with two memblocks.

For example, DRAM area [0x40000000, 0xffffffff], when TEE uses
[0x50000000, 0x51000000), the memblock will be split into
[0x40000000, 0x50000000) and [0x51000000, 0xffffffff].

If pass "mem=1024MB", the actually max addr will be 0x81000000.
However if need the max addr be 0x80000000, mem=1008MB should be used.

There also might be multiple other holes that no visible to Linux, when
we wanna to limit the max addr usable by Linux, using "max_addr=[X]" is
much easier than "mem=[X]"

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/mm/init.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index db63cc885771..3364b5e7a7fe 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -173,6 +173,7 @@ int pfn_is_map_memory(unsigned long pfn)
 EXPORT_SYMBOL(pfn_is_map_memory);
 
 static phys_addr_t memory_limit __ro_after_init = PHYS_ADDR_MAX;
+static phys_addr_t max_addr __ro_after_init = PHYS_ADDR_MAX;
 
 /*
  * Limit the memory size that was specified via FDT.
@@ -189,6 +190,18 @@ static int __init early_mem(char *p)
 }
 early_param("mem", early_mem);
 
+static int __init set_max_addr(char *p)
+{
+	if (!p)
+		return 1;
+
+	max_addr = memparse(p, &p) & PAGE_MASK;
+	pr_notice("Memory max addr set to 0x%llx\n", max_addr);
+
+	return 0;
+}
+early_param("max_addr", set_max_addr);
+
 void __init arm64_memblock_init(void)
 {
 	s64 linear_region_size = PAGE_END - _PAGE_OFFSET(vabits_actual);
@@ -253,6 +266,9 @@ void __init arm64_memblock_init(void)
 		memblock_add(__pa_symbol(_text), (u64)(_end - _text));
 	}
 
+	if (max_addr != PHYS_ADDR_MAX)
+		memblock_cap_memory_range(0, max_addr);
+
 	if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && phys_initrd_size) {
 		/*
 		 * Add back the memory we just removed if it results in the
@@ -427,4 +443,9 @@ void dump_mem_limit(void)
 	} else {
 		pr_emerg("Memory Limit: none\n");
 	}
+
+	if (max_addr != PHYS_ADDR_MAX)
+		pr_emerg("Max addr: 0x%llx\n", max_addr);
+	else
+		pr_emerg("Max addr: none\n");
 }
-- 
2.25.1

