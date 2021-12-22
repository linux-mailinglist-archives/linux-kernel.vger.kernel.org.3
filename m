Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4AD247CB71
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 03:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241992AbhLVCzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 21:55:13 -0500
Received: from mail-eopbgr1300114.outbound.protection.outlook.com ([40.107.130.114]:56603
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241974AbhLVCzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 21:55:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LU5KnqRLYR+4poE6C4WJ8vz5IgvQgvoXYP4YC0GBHqomg9c4P7/dYMUUar/9m1L7AkktqTAq3EakL1rrbVgJrMfKD6WcjxEQrIYPpp3l92ycUDKwLa80807e3iM4rnXGLNDQVWfNvlpEjT0wyuFbiIMrNQAmup2g0bXbftI7npxIYEYgkqslfRMdglbM6i2suyXe/kyiQqZ+AxJYgThMBduHcbpuHUO8HcnM7+ZysOfQHD5vILyaXmKxHVeUDXPFCso9awux1NXE3/NOHSogZUQVMBaTnmkQpVZt8sPISqNBDEnnC0M2lVuUxTsOMqY2qhvXDsW/APHuDYB0tiBeqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dnAddFWw4Kt+vasaJkcrY33F+UG4ZCgirvYtLpjaCp4=;
 b=InXX4k5AEZZcSFFhOo0w91uRBJ9FCG5qGQwxYpptPniFUN0mDTL5YJmldn8xepAYjAVW+1dhC2I2cntfD6AaXrwK0hG+Kh6O9HGfcPmZzR99QS/GCoNfOKDLA7wKVfvlfUS5/Js7O4FAhWcwF54MkNqtAgLjVvgILxs2Kl1BTKzyNtYY4pvmIjHXtplqMnPi/WW1hExtUyfeA5KTz8yO7M7aLsE8vJj+5Ycp3yJibpBQHNHdA3hRhkBWL0u2eNtXL2R58L8aT6r05NiH6v2+GdS7h099HF3tIw8ydzeJNLo0WzmzT7fGkzRcnJ4v5PKluNVwyQAJ1Kn3XPZE759gSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dnAddFWw4Kt+vasaJkcrY33F+UG4ZCgirvYtLpjaCp4=;
 b=OCngFr4vAC1a0vT66mLXfSF9GGzJhLk8tFZTIPB3spyv1Sszxvgv2tfW4cWHg/3OzWlYScXueFYszUeTbXPfAQuzqLffs3/dYfmTkVyIjomwgCl+7RHrTjifijS34Es0yvjtznKdqBqL5LmFc5gdLuO+iDIlKFDvdQJ6XQd6bkI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com (2603:1096:202:2f::10)
 by HK0PR06MB2723.apcprd06.prod.outlook.com (2603:1096:203:59::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.18; Wed, 22 Dec
 2021 02:55:09 +0000
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::8986:b885:90d7:5e61]) by HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::8986:b885:90d7:5e61%3]) with mapi id 15.20.4801.023; Wed, 22 Dec 2021
 02:55:08 +0000
From:   Guo Zhengkui <guozhengkui@vivo.com>
To:     Christoph Hellwig <hch@infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org (open list:SWIOTLB SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Cc:     kernel@vivo.com, Guo Zhengkui <guozhengkui@vivo.com>
Subject: [PATCH] Swiotlb: remove a duplicate include
Date:   Wed, 22 Dec 2021 10:54:16 +0800
Message-Id: <20211222025416.3505-1-guozhengkui@vivo.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0024.apcprd06.prod.outlook.com
 (2603:1096:202:2e::36) To HK2PR06MB3492.apcprd06.prod.outlook.com
 (2603:1096:202:2f::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 673990f0-98a3-42bf-1d0d-08d9c4f676d3
X-MS-TrafficTypeDiagnostic: HK0PR06MB2723:EE_
X-Microsoft-Antispam-PRVS: <HK0PR06MB27232DE3B32EE92A5FF66864C77D9@HK0PR06MB2723.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nFqDs4dfL4ypTJT9k0vWkKJ+i49Uoqfgzz04fRE0iPj0hXjVtZgS5HEE3s7+ISRpNCi/NhOJZshibtjxrA8MMdjRYTVQRbAXSQ/CQMMU2hBWMIxd3PIL5dfkM/qfyVdm0md3LIXJMqOMVPf6wZHnhsjR2nY9WcYqRtPbHg8oOSdfS2HiKjeyZTynNMjvqgW3iZy9PW2OaHfTScUSspsQfXmXi6mzl9vBjHvZ86vGKGwAJsFvAdhwOAgC57VgzryIszNa2P9Y3VSIY8T3p+yCZfSPYHohj37Q9DkgPDIJ9jha2rM/GmFwvGkDWWf9I78F4lHZStPbFpEoo4E11Yv5GfD5tPJsOxZ2wWsGgXN67sG+qbctTuRsR4UyQiHsrcJa7B/YYIug/5OOtI3aaGdB49KlYbhVwsD4axh9CovOA+Z3/EqM3OoPGD2YO24aJPIJLKJBwFkY5awGLjxTRt00fF3M5ALseM44VvHPTFawy+D0IV6TfzaOvRJDphXXtnzjdHiP+pZQLPYG+eIpsoPWexpkQ6gqQyk4oTTMUV8oECkgpEiZ6nWnAAmbUn1PBrXQq7PcXRFfCGV8spgBYr9tYzP1psidwpHXn5XBt4FFoNrrvtyQIV+9sFcN2GnbGyCCvSeba8CpBjJ7cIbQV3F3EJbXwGyFVxRg26GRGWFq32XaD7mBUkXpKa7H8V8Ek3JxX5q2Gi0MhsIC0it/83o3Mw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR06MB3492.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(186003)(6486002)(26005)(316002)(52116002)(110136005)(508600001)(6506007)(8936002)(8676002)(2906002)(38100700002)(1076003)(6666004)(66556008)(66946007)(66476007)(36756003)(86362001)(2616005)(83380400001)(38350700002)(5660300002)(4744005)(107886003)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0vk8GTyQm2+fO4dv8WMkl37LAw79hYFFyOiIW0rCTYKYyflRH6clxGQCnkcJ?=
 =?us-ascii?Q?p9UNEhjsOOlsAtltXYgsW7ySj4cCPrg2EZWsQ0Z3XaS2PR68nj9xTMgbvI1O?=
 =?us-ascii?Q?1cG80BYN6xb1MIB6Nd62gEpkk2fHwsIZ1Gtu9TenThF85IzpKU2BRsAK60u0?=
 =?us-ascii?Q?DhR7yOKemIja4RcCVQytLGnWgXIGM27Zely8sd5aw736YM4yG1abQodgVJQ+?=
 =?us-ascii?Q?HTaa0zgIKmb/wczu+bFTfa9ntzlZkMlJxl23c6Us8nfDE1qqfWcC1FxIzLmp?=
 =?us-ascii?Q?jdOScFa/O9K8cKO51ph1jfir466e3tLbc9/IZth5XzqyGEj1APszSFUnCPie?=
 =?us-ascii?Q?A6W8+f4TqjTs547AAgUMjzN8/LxgaXLf2cYuP+DZLy1dAAM3Jk1zz6nXHyRQ?=
 =?us-ascii?Q?BMfIsJR8ZfZ3GyDaBpG3aou4MWC/z6kZnj+kwimlZTV5nPYiBpUq9zkntA1G?=
 =?us-ascii?Q?kuQH6CAxOPvRwxsBwEoBnLXwyQ1Fq0pIcOx+O/TSnGgoYGQJgQ/dweWGVeWj?=
 =?us-ascii?Q?c1OdfRbbMNl8OFMu3xe4lVTmWngfgCXtW8uz4EYqezfC0WhJKBoB3Jm2hNGy?=
 =?us-ascii?Q?Hnkysc7Nf6y4SKY56BBvkS2qJKgZ8vgN2ygaWjQTQDZuFKULkXLxtYWHLM8w?=
 =?us-ascii?Q?PrUZBFuY83ZAtqtECHZ5s85YtwFb+xjuOyZ8iR9s4g6R5jQPaRt+ywWQ2lzp?=
 =?us-ascii?Q?Fkh66/EdOy58b76DaCJPcASgGViei4W//rIOCb4E5HUEwOqLtbJxXq6VZMHa?=
 =?us-ascii?Q?wOV+uO/JDGn3gTmVring3X2TU1Lv50MYhbfb/ReRnb6Nyqp5j34JOEXKWrJb?=
 =?us-ascii?Q?5tFa9yGZc9vNz9Lqm2TLCGq6ZqrOsyC86tCCfUuqHZTQWhPjQBBQzJYK6scS?=
 =?us-ascii?Q?kMYaJcptZrbdbMgc4xkDvH+ZLqtjeEJvPj0sJ27lQ8j6qmAouVxIrX+3KP8B?=
 =?us-ascii?Q?zyEMR+xyS3cJmGhq/kav20kHnKni9tI6EfoyEHSXUo5B5gw9lIGc1iwHEG3S?=
 =?us-ascii?Q?qhVy3g1nRg4kQmmSFGygdkrqNjYTTOWdacYNDrTQjIk265FS7V2QH1E4AqI8?=
 =?us-ascii?Q?KES1TLcpdcqOUi4u3r7GGnUzDhWYhui4kT6MRJhnmsoWOZOSGv9sv9V4KWXQ?=
 =?us-ascii?Q?oeEIxn2WJe7HV474XFMj3q7bR3AlXPmxNta+QL4ISmUgGYPRCJLQxGFizxdy?=
 =?us-ascii?Q?pprpfJjwfoGzpsyKtAfl1qbluDkTwE7n6fwiWbTBshUUt0Myv/FesrrK0l3m?=
 =?us-ascii?Q?vWRfe2sEjFPrnsTy8kPKZNxTxsxSWgasZTF4SkVJunvs2WMfuA+FzooawRXY?=
 =?us-ascii?Q?qnvaDgTYcPjM+imfrFxD23UOAS0o/n+2a4NTTtkSLgZu72L8yn1zIHE6a2ga?=
 =?us-ascii?Q?9mrVBsftBUx2RqwEO601PaYjSSuVsFPyqxeLcOdo5E13W2YAAn3Qw3jhN4AN?=
 =?us-ascii?Q?YVCLC01/GIg6lKDwxoFwMgOfJpV84HOIsPTkKOnjfJAyYwVEpK/NYFK1xY3l?=
 =?us-ascii?Q?fKoHY7UVOvwUo1nLLnwe1Tt9/k2dIwwibMAZ3XkVo3JZGMM7ZK/4s4jfz24Y?=
 =?us-ascii?Q?tiDHfi/O6MLZN2l0rwUGoAyPt+MM1mckWpjuTHVW9PRjlmdWQPUqKG049GKm?=
 =?us-ascii?Q?+h73YegDlfUvke+SO2CVNcI=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 673990f0-98a3-42bf-1d0d-08d9c4f676d3
X-MS-Exchange-CrossTenant-AuthSource: HK2PR06MB3492.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2021 02:55:08.7775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZfEmeaxDSeU+zNJVVM2NlFGjasRrssEm3TK89Fs6u179EnTfaVlVFeVoFF/P37OdeHxjASID4uqLHWd1nDnoDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB2723
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove a duplicate "#include <linux/io.h>". The deleted one in line 43
is under "#ifdef CONFIG_DMA_RESTRICTED_POOL". However, there is already
one in line 53 with no conditional compile.

Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
---
 kernel/dma/swiotlb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 1b0501fd3e0e..8c091626ca35 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -33,21 +33,20 @@
 #include <linux/ctype.h>
 #include <linux/highmem.h>
 #include <linux/gfp.h>
 #include <linux/scatterlist.h>
 #include <linux/cc_platform.h>
 #include <linux/set_memory.h>
 #ifdef CONFIG_DEBUG_FS
 #include <linux/debugfs.h>
 #endif
 #ifdef CONFIG_DMA_RESTRICTED_POOL
-#include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_fdt.h>
 #include <linux/of_reserved_mem.h>
 #include <linux/slab.h>
 #endif
 
 #include <asm/io.h>
 #include <asm/dma.h>
 
 #include <linux/io.h>
-- 
2.20.1

