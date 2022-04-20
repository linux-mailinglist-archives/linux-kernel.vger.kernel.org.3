Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C32508036
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 06:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359322AbiDTElM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 00:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242849AbiDTElK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 00:41:10 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2063.outbound.protection.outlook.com [40.107.236.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6161AD8B
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 21:38:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SwJCwN1saRR6vZa/C1UDTo3MaT6i4U08BTzUaqfS7gL74mWTYOBPsbvKmJHyIeQ2OgjhzFcw90vaoopQomtIYPmDzyJ8jtNeMxmhx3ni+Ku+ng1b/IgPe5YPDnyMzcUcO8RMLVPUAhRX2uVazL6HVYVmFOCENE4oe1x//q+cyR18ctIMW7uouUDOuXXTMiXEsLKduAGJIx5O5lP4HnJVbWgI+A4tukKBuH13Vg7DsRKMRH+wO5TvCMvfDKjbEP0fIGMQLRhwQgjhdxMww5a5SXe2CwWfJ59YGEPIvTNaTGuhVZZwopusrcmMybt0LJP5f/zH1A6Oyqs1igR6o0bA/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5uMTFQ5bepkouB90poSYhvFc2Yf6VIs9rr+ETkJNwPY=;
 b=dZN6+hS4ux7+hf/CfKO4WOvWwmiNvBYtOYP3J9z0xBq44kCj84hAwQGW/ztJGv8bELDTTifEBbMIBO1cUR1V76gejknf9K0Dgqa5ynxDA5amstSOB2gI3rDHG0tTywuwYOSkWdBAR5gAdTIirTAA7bOYjxQCLmmz1u87JCsXxELdGmCw7MkNP1iddCk1+H4KdElvNlpMD7230y8rKsWtjHtvbmDUaeRIZPqbz4AW45kLeiKAeB8OhUfXdxyxyfnU2pEFke99JnPUDJLR6i2lwLLZkHl5eZcDJpR+vxLGu9KrNHkaSei3BTBcGrho+qmlaZhYEV79cVZ9sCoE3tPo+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5uMTFQ5bepkouB90poSYhvFc2Yf6VIs9rr+ETkJNwPY=;
 b=RA26HtoCfFHTqwKGNJE8iiR4+RS4RE6gwP2e3R/VZI1o2YJJQvpMzUccestGPpcbO3NNeXuKmx3qq4Z5vdnPUmjTlqd1isWNhsF44u9WHFvFww6TQqwSLv5Gab5vdfnj/7xTyzXE4u1yqsbk+lKYwu47jZhzbHuxmglXG+dyD+Ql6af9VpGjDBDWN/Dpilx1+gPy14MPssHRKDNhet4O2v0TpxGAQFbrIPitD3uAfa1Co0IOtvniVYsHRBiR2i+/zCltF6M2kRosaLqoHkgp5mY7jpq0ev4XNIIa7fB/dFlLEZWdaJE6HV0G9mhjwx4tXlCC7IvHNN2OoDcPepxosw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by SN1PR12MB2477.namprd12.prod.outlook.com (2603:10b6:802:28::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 04:38:19 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::2d17:b68a:e101:4c18]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::2d17:b68a:e101:4c18%6]) with mapi id 15.20.5164.025; Wed, 20 Apr 2022
 04:38:19 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        christian.koenig@amd.com, jhubbard@nvidia.com,
        rcampbell@nvidia.com, Alistair Popple <apopple@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v2] mm/mmu_notifier.c: Fix race in mmu_interval_notifier_remove()
Date:   Wed, 20 Apr 2022 14:37:34 +1000
Message-Id: <20220420043734.476348-1-apopple@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0045.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::20) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01d0bbb1-cdc0-4710-766c-08da2287982f
X-MS-TrafficTypeDiagnostic: SN1PR12MB2477:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB24777452B143159427BF7584DFF59@SN1PR12MB2477.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XBakrtWIw/1qJ0inNNTB/onVi1GUSfr6Vo5FNrZEsNr2BRiBeN+2fDdPfsIsE/AjvIZBZhOnlsasPPPACtLj1eBJpfASz5Ii4kVeh3AnL1WuR5x4Fqo6ZCVa06ZC3yy16q+tK46dGcBz8gfdbkKv3mZIjmSzSy9reTnq2iMMKo+rJqrEKP8saSAxhK2lMGWMHj8Fh6qYWbdjqenKrkt4cuyftccEghPzOK3b/rXYKn0FjbZiZF2uHpBF9U3U/F4ChPIIAxZWcVNjgm4AFOBpDwkMccPiKr9mzozCOcge2NTa+id8dn3M2XCkUkxCMQb2DRNqVLm2xjBaRT/uoWmJ/3+g2wwZa2Zk4kItwj+kz8vxL8KkKlQF/ZGHs4vunZSKkTnte/SseRs7P50deTB2ExkjGjNIKZe62m1lHinyEIQPYtZOm4tGWuljupp7rPWML5y/V080LOBOSQvdHWN2nUCJKcXkRRqaT02JsEDBOtFlpasLsforKfN1WRaSeDbwpbl66OkVgvOQ6/5l3hpYxLaPON/tgWJpcCoLdxkTLXe/7BwWt5LGltHo9H/RPi5QiS7jw0Pa0prsUhiUgaKq3QrVrZzzpE3py4N/4/whBjg+1ecf8PBUjCI8SUvxnjETPDAXy9d7A1U+ZajByyQ5pg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(107886003)(26005)(8676002)(86362001)(6916009)(2616005)(6666004)(2906002)(66476007)(8936002)(6506007)(6512007)(6486002)(38100700002)(508600001)(66556008)(1076003)(66946007)(83380400001)(186003)(54906003)(36756003)(4326008)(5660300002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hXJ3wI5gifKOMLigI3a64mnOM158k97j8fIGiNJUxJ9pel48QGmEHD/SBUnC?=
 =?us-ascii?Q?28Z6/NeA+MpCdGb8EgkPnCFhIYGpR3vxgamNr0FYAsOn7c8ZzDLQbW0erCNQ?=
 =?us-ascii?Q?Qn8vhMhA3AK5mfNlspYVdBr8B9jQ4FNK0Fu44vGJUlOoTagUjoEYlugzvap3?=
 =?us-ascii?Q?ivCAVWCh3UXyPwL4kaxwzM6E9gAzbM8BYq+0ojVe+3gcCxP5cnaT6l/26Arp?=
 =?us-ascii?Q?5tVKiKmSz+bkDBBW/RPJCXdyPX2UfyGb3Cqmhbyfq4K31QfE1uuU40bG1Z7u?=
 =?us-ascii?Q?ShKaZBMwT85Mek89/ND3+CddN/ZUbM650NY4lprIeLo5ZcEbo/oqbs2UcIvZ?=
 =?us-ascii?Q?7uSHF4FRI+15q4H20LACm3jz+iQY4qQtvdAd6W4ZV8kst5iTxcZG5tFL1vm/?=
 =?us-ascii?Q?k111GuD9dSnFg3np7YMdAbZixCOYIbz1l7SqUul6xvB4Cz2QMXUEtVH/bnAW?=
 =?us-ascii?Q?66j8JLWgegSoj2ku8wTEzcRmR0LLrwOkWlExuR2yNmcUGXUgtpYugunbIhE5?=
 =?us-ascii?Q?hWQN7mwtDjV61w3hCQ9QDCKd+R24bFyqZtGxcrT2/aLqxq2McBmeyYc5r3RP?=
 =?us-ascii?Q?WIsTBqYq6/YjYOct/YOCLNeuuLWCvOej1F/FgqzKfqlXdwkifQAg+Yir9LLm?=
 =?us-ascii?Q?6vDNPkE0LTjuvpFkiIHN2WF4OiJx/GirmuZyDALmwMsT+oY00t0mVq00r8vX?=
 =?us-ascii?Q?pYKrGRR0l2AfUiHWoKpDJoXc5JFuKzp8pB1Qc7iQMfW0SPg/6tElQNsyUA8V?=
 =?us-ascii?Q?XNLZTojAqLtlw87PeEFu3NpGpQvsNaHBIrgRzZ/GPP/QsL43rdKAYxj2ZBcZ?=
 =?us-ascii?Q?NrypDjDgOb0E4BzSO2Cm5zac+Cl19RC2sfOsmq7HbSM9Vn+nogA2hq1RUGJN?=
 =?us-ascii?Q?q4PU95WKYKdhVJ25WzHL+GCH9kJxN0zRct3XvE1c1Igaopz6pqkIwcesdprP?=
 =?us-ascii?Q?d+41bME0EQBAxaeVc6mcGoKzmvkQlyYQRoulR7+qtdnxZscomJPdIy7lGvAA?=
 =?us-ascii?Q?RH5ns8HZD4E7SRGRykhfSyW6tdL71ea4PU2OICUq9EmyqkHwIkl3gp3HpTh8?=
 =?us-ascii?Q?ACAm/ZP7MJp2z7l0UhBLS0Ex0U0skY6Tv5ugmfKTKDdShjS6p/YEz9tlRY3+?=
 =?us-ascii?Q?mI+Ouqd+BfWl1BY2zinYNieHPD6JcsVWIEwJmsR9fge49D2/I9sZYvRwP77r?=
 =?us-ascii?Q?b1hnVYVXKjIrBP4V/2anBy5QhawPciENTvZ6BoDZXVSW4Vl2VuEzIKD7BSrZ?=
 =?us-ascii?Q?K0DYPiLmn0LO4LfEm55hkbGXhjT2W5IqMMcLHiIuvsUxt1NGKy76NxDJ9cLV?=
 =?us-ascii?Q?ttGgWHhHzXjWtfWuFVB9SZy3XEPHE9a5sIKxchdIEadaz8tBQJYLK/pcGWZu?=
 =?us-ascii?Q?LzQUyJgEXK/GEku9Cvnj4oVWZa9YKaRoNAb0tf8dGDfGzoX0/rqLJ3cNo2PF?=
 =?us-ascii?Q?mZZFAmfT9FOsfq5mlDUNtwh7jXQWm30F+dkx4UxFRhGQ78ZVS5na+enAEFyn?=
 =?us-ascii?Q?KtuJS0Q+Wptz23LpX4YnbtKu1wJXblBMKw7F2ifeXYBR3Y1nCmnsu7xli5ZV?=
 =?us-ascii?Q?JdeqnObXYTStEk654hZ8P9HEUnGOYaBYAheGJPzN/nvS4oYFrk8vQRNvK2EI?=
 =?us-ascii?Q?6lnw9s1qoN2bKkQHPYoH67xhDpjgHFqOTu8mcVPjuOSJStMi4BrrV7aDUa7J?=
 =?us-ascii?Q?/H1d98YSDOqe7ajL7BPIU9oVv8rsU98LZGM65n71Xs8JuoBFcJV2bfFgDVsY?=
 =?us-ascii?Q?FwwrmTCtTSWu6zc4d5zDQN+XaZUQ/mg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01d0bbb1-cdc0-4710-766c-08da2287982f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 04:38:19.6929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZqSYAm0xM0tpzB9iH3x8d/Fzj8kHpax81ppjHseOssXivxpASt82Eq+rVyGuSXwY6Kdb1flNaeX5VQUjIBpZmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2477
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some cases it is possible for mmu_interval_notifier_remove() to race
with mn_tree_inv_end() allowing it to return while the notifier data
structure is still in use. Consider the following sequence:

CPU0 - mn_tree_inv_end()            CPU1 - mmu_interval_notifier_remove()
----------------------------------- ------------------------------------
                                    spin_lock(subscriptions->lock);
                                    seq = subscriptions->invalidate_seq;
spin_lock(subscriptions->lock);     spin_unlock(subscriptions->lock);
subscriptions->invalidate_seq++;
                                    wait_event(invalidate_seq != seq);
                                    return;
interval_tree_remove(interval_sub); kfree(interval_sub);
spin_unlock(subscriptions->lock);
wake_up_all();

As the wait_event() condition is true it will return immediately. This
can lead to use-after-free type errors if the caller frees the data
structure containing the interval notifier subscription while it is
still on a deferred list. Fix this by taking the appropriate lock when
reading invalidate_seq to ensure proper synchronisation.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Fixes: 99cb252f5e68 ("mm/mmu_notifier: add an interval tree notifier")
---
 mm/mmu_notifier.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
index 3f3bbcd298c6..e0275b9f6b81 100644
--- a/mm/mmu_notifier.c
+++ b/mm/mmu_notifier.c
@@ -1036,6 +1036,18 @@ int mmu_interval_notifier_insert_locked(
 }
 EXPORT_SYMBOL_GPL(mmu_interval_notifier_insert_locked);
 
+static bool
+mmu_interval_seq_released(struct mmu_notifier_subscriptions *subscriptions,
+			  unsigned long seq)
+{
+	bool ret;
+
+	spin_lock(&subscriptions->lock);
+	ret = subscriptions->invalidate_seq != seq;
+	spin_unlock(&subscriptions->lock);
+	return ret;
+}
+
 /**
  * mmu_interval_notifier_remove - Remove a interval notifier
  * @interval_sub: Interval subscription to unregister
@@ -1086,7 +1098,7 @@ void mmu_interval_notifier_remove(struct mmu_interval_notifier *interval_sub)
 	lock_map_release(&__mmu_notifier_invalidate_range_start_map);
 	if (seq)
 		wait_event(subscriptions->wq,
-			   READ_ONCE(subscriptions->invalidate_seq) != seq);
+			   mmu_interval_seq_released(subscriptions, seq));
 
 	/* pairs with mmgrab in mmu_interval_notifier_insert() */
 	mmdrop(mm);
-- 
2.34.1

