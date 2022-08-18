Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E626597B3F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 04:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242554AbiHRB47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 21:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiHRB4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 21:56:55 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB00A00E2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 18:56:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WVNG4okNsePZmOX54J8f7RUotDuVRi8wx8PIV+GW8vB7wAPEcZuD9D0FUKs8wHHHkomG6GL/RsgJ7qqOOonmVjql26XDCPnxs+28KzyrecapKSdySbxMedT4zkWJfw7YUM3yhthz2hvL6QxNMjlM+pp8LIHML+5GYQ2250t6kWYx2aBRIDV/yYE2lJwITtNVbBdxNfyC4zqpfTxJd38VhqTlz2DtLIU+XnhNkVMgOq2FRZbgWJJh7L8d+ovXlJsSy0f7Kh/llvJclm46RQ7OB2CA2Ja633xxHHxtDg0lEJHQO4y94xuEiuvIRMv1IW4cBSdbJwLc7AtkPPf3+9x1bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MCKeJXLsIngQdXbGadMhinw8sGoEtHj2BAFX2EvUDKA=;
 b=NzTXyb380DNNDseQ8qaT4uhuPUeo6pn1+GpklCYYcDJmkqj2er43xOzWvjRXE0PRnyZknmhkLvDCy5R4GNLVaiBcNz1fKgW7niVnodFbgxi6nHenU8JnF3zthUjMDVdzJc3+02ZZqRTOTb4HPr3t47jW9aDruMWVdoZGfpoin2RZkhUVizNhlKy9r92nWeqDzIDI4B9TzE0zS8PU1mqUH+e1pit7GiSQCRsLsuTV/NYr6ReRHptT54EWlgaSUo8AzbnuvZpo7X/KSHT4sS5991cI/PiTHKrkhyKnsXlyWQ9Q+4zKjeqQyj+qcta60hWfymXOjX/sNJGos5yvl3t0bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MCKeJXLsIngQdXbGadMhinw8sGoEtHj2BAFX2EvUDKA=;
 b=FrfsnxdY4qsJQtFYCImMCpg5O0TkXtLZUeDQTCEpGmGdHka4jYAoAF3+KNkJqnFZZV0XCi1lCWOUqaua19bOJOzsZieivDK68tKXDblsNHVlGv63V9M+zQpL5RHROHQsuyLMkSGlkdf35y/wYWl9kDTt7PmCrJBtuZ+xRqCaBh2WkIcE9tpwRQpM6UfZRqPwfY8T4MtVKYug0s/r7g5Xo20kAWA7jnZHXZjZ1lkttSIsvl+pLmvx4QNYwe6ELz0Ch508cDjoWgKjI1eqOG5iNcEUMDnb9YiHR3DGeAZeMEVjsYO9d6ce8dTxxcXRM1rPI5zo/W0vGDPHsljHPY1rpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by BL1PR12MB5286.namprd12.prod.outlook.com (2603:10b6:208:31d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.19; Thu, 18 Aug
 2022 01:56:52 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7%5]) with mapi id 15.20.5525.019; Thu, 18 Aug 2022
 01:56:52 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        "Sierra Guiza, Alejandro (Alex)" <alex.sierra@amd.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alistair Popple <apopple@nvidia.com>
Subject: [PATCH v5 2/2] mm/gup.c: Refactor check_and_migrate_movable_pages()
Date:   Thu, 18 Aug 2022 11:56:23 +1000
Message-Id: <b16996b55deeb7f3415250a5a940d560d5b5ff3c.1660787700.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <487960bf67c7273ff5606c76f73bb51271bc7b90.1660787700.git-series.apopple@nvidia.com>
References: <487960bf67c7273ff5606c76f73bb51271bc7b90.1660787700.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::35) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 883484d4-0758-4124-01e2-08da80bcebd7
X-MS-TrafficTypeDiagnostic: BL1PR12MB5286:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RXQSEss5xgqGUzrf8uthJfuPt5RLlX0vlGQH4Ji/yfAzeitIz3F8gKU4GTDebsegpKF3UFxS+/7N/rOQ85btv69yBa5hnZ9mYmbouKguRESo0t4VJe4O1pTts2h/85Rvy/ZeycAlWYWL34ztaEVOu0AtsoaKOUh29DIButeONFbngS49ON8ogXuN6Vo2aDacWCuQhxR+yL6QFXAV2By4ItHJlNf0YOpjTTSc2DkRP+9lRRT+RKAkT20q4pDq5UkVaID8IIDet5spz6aY8v968MUpaygGG/hZLLrMMv5q7DhhA+1/un5bu65MXMLhocH4vwvLRHXARi2RSSYg0hV3UmMS++ZibatCbBaFWKOMHw8OyhRILr7GMXFT5ps9OhAHGIFr9ztdAzFnIOssUZ1ac1LgPAzX3yO1KNrsk+XQqrvh0N8aslLYX7itLd5n5DOkqMNAhIHUTgZjItSn4/J7ot/J9VrGSxw1uUKTgRtK3i/KuHbiSpBML+HJ0p2dPbMw0hOl+3axbARIO1MhDLWezIr58/Qd57kUE30eydlD3K5V779jFETsyb446CYWjuPrfGaPzt+ZcJUGxCUHkt3bhDeLAGofsZCUlOfq7iyekRruktl/Vt+Hw0hZyvn96hiCsPKjitrrdKlTC/dHl7aVFc9nuZMIvbdTV23ib8GCfbtqLuKYNB/NhaWBIMLXGVxo5t4aCDg5Ah147o8LWF+jgcHjR89Ld0x80L8udW5iZlNd0cr8aUPwh3iPG6EdPnIRd8Ay6RkiUK11vHKCF9mYBH8OhYfGtvVSwICJOumseow=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(376002)(346002)(39860400002)(136003)(5660300002)(36756003)(478600001)(7416002)(6486002)(107886003)(316002)(6666004)(54906003)(41300700001)(66946007)(966005)(2906002)(66556008)(8676002)(8936002)(66476007)(4326008)(186003)(6512007)(2616005)(6506007)(86362001)(26005)(83380400001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K/NUkaP2eQes2gC8qU30DcOxpD0qFDQo0mbOeT918a+zllrOv2oVPeNZ7kqG?=
 =?us-ascii?Q?97rTY0Q/Ta5xSjPahyFU6V4EWlm2i4BZFhjDoVHZsFll9o6md01VRUm+bj/o?=
 =?us-ascii?Q?Dj/bOpWVCCYnrB0IQSVCkNTHKVsMz4K0GWk2YlED3ZUuT5vTNjVmFbveH032?=
 =?us-ascii?Q?uw3lLYV6WctV48QToHCuPoKS/JHltUIeuWrLGzLtHz033aynRpHrc4Q3KGCE?=
 =?us-ascii?Q?VUROxsNoXbowvyD5tpPq5pwE8hTh9IVcHLpEZSQI5lb8zJq1REcOiJY+19+B?=
 =?us-ascii?Q?wKjIeNd17xgn3DImOSaJmcIx6G7rO9WSJninQbdOBF0kHiQXL8MRsIrpBKv7?=
 =?us-ascii?Q?qjecJBbCTS/moS0CDa4YMlFXTKd4PWzyQdLcWHY5PROzrLM/GTPNgbhXJJ9u?=
 =?us-ascii?Q?SLwm7N0CDwhsfNvPn6MoHojx4ciKKAwtpmvcpAvhF1pXKNL0AYllS68AvXB/?=
 =?us-ascii?Q?HJ05GaUKDPCIrVWvPcHqcVrOug8ZQVEV2MA6lBxEMW00fBq793Tc9sT5dinm?=
 =?us-ascii?Q?q2wV0uNBQu9FiFJaTi+FZPlmPlQ3Zxlr7imb7TUnJ27ikS46TZ/kr/FnUj/9?=
 =?us-ascii?Q?aEDnw/45myIFjwlukkWTmoq7ep/OOyADJKL4Ye9rid4fcKrt2dHAvBtDRJ7m?=
 =?us-ascii?Q?2BykaFlgIUILOE+ZWFjcxjKs4Hrys8RZwfTHrHmY/cU64ByTwizq1DTJYRJP?=
 =?us-ascii?Q?LdcdOMNPRHjo4C2GYuQXRO5wC++un2V5Sd9tDaAPC8Y2S0K3XsaUqLpicUL2?=
 =?us-ascii?Q?X+Ax50V6TyiYHJ4p0dhiZ7dVTfZHUHAYXlo/QfPrYNkkE8GvhviUmai29i6I?=
 =?us-ascii?Q?aP7D6lgnxl2iiAbaSws7MjIpS58zu/VLH30SJCqlH4kU2ssiPGA4ojm6IcI3?=
 =?us-ascii?Q?DannKd9wqsSQ7arflVhGXrrRCRp/rvkuzNRS/aSOyBqL03xOGgr7qkTQXfAv?=
 =?us-ascii?Q?HFpWzM5bcKeXYGDgG2L4GBkCSO5O8ZT9i0QMMN8HjnlePX7MsYIPoH24UyJn?=
 =?us-ascii?Q?oOXvsfj+DPTOry760i13C+ahHXIsfxda/GtqUCIYZwG/aKO+nFGg88Y3D+gM?=
 =?us-ascii?Q?QB9wJBdwxYXswY35X0ck3FyKiY4NQLRrnGDwPFyHA7S3nxioOflqO9WjkNdS?=
 =?us-ascii?Q?gFn92MDVp16KFeSFFVHWCabx7sPIOTNcwa1xIlfxZMgUuNRJmzkGSkTVlhaJ?=
 =?us-ascii?Q?P9oXwLT9dFZGy/zWAc0ChpM7LjzsZ9/5zDDTYzINHpQdwhkHRbYNe/8rZuIj?=
 =?us-ascii?Q?m8Uzc+Vcga0EGbM3r32VZJGrj9ZCQyGLDzlA2oeWX4rW1a67BzgKfdB6FiJn?=
 =?us-ascii?Q?LPbaJprQ8nAcQBSy5dDqpar9mjOLDN2NoqxClj5w3Ubz/W14fa95c6wZOPCM?=
 =?us-ascii?Q?0fsknubd4tv/nklDDesK/lTZuxBYVj+zAiSSG/Iu2RfOjYb9vD9lgJh0x+w8?=
 =?us-ascii?Q?7e+gXUuYwHGVsDKzHBILmTI1iW8HWAN+hIA8j2oeJzRbWiBIOBnMfvBveDlL?=
 =?us-ascii?Q?8Nj9lX9YqaFvGWBgFPryKB65cpHT0uYN3Ox7Bpfe51wZl+G4lHCFO5YSReGo?=
 =?us-ascii?Q?y14E3lHqGzgDOItm2hNDYgtd8zR+Df1dmuZln5CD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 883484d4-0758-4124-01e2-08da80bcebd7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2022 01:56:52.6696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XAPUs5ZnzApsfKMs399y1I0ZZjUEKaeguC6e+LeRsqa9vqLwa+ruLuTY49yfpu1NTyl55KwKP4gmrwOpxHZzYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5286
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When pinning pages with FOLL_LONGTERM check_and_migrate_movable_pages()
is called to migrate pages out of zones which should not contain any
longterm pinned pages.

When migration succeeds all pages will have been unpinned so pinning
needs to be retried. Migration can also fail, in which case the pages
will also have been unpinned but the operation should not be retried. If
all pages are in the correct zone nothing will be unpinned and no retry
is required.

The logic in check_and_migrate_movable_pages() tracks unnecessary state
and the return codes for each case are difficult to follow. Refactor the
code to clean this up. No behaviour change is intended.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>

---

Changes for v5:

 - Minor formatting fixes.
 - Improved comments from John.
 - Cleaned up return code logic in check_and_migrate_movable_pages()

Changes for v4:

 - Use folio directly instead of page based functions and folio->page.

Changes for v3:

 - Improved comments (thanks John).
 - Fix up inconsistent int/long/unsigned long.
 - Rename (migrate|collect)_unpinnable_pages
   to (migrate|collect)_longterm_unpinnable_pages() as suggested by David.

Changes for v2:

 - Split into different functions as suggested by John.
 - Made error handling more conventional as requested by Jason.

Originally posted as "mm/gup.c: Simplify and fix
check_and_migrate_movable_pages() return codes"[1].

Changes from that version:

 - Restore the original isolation failure behaviour and don't fail the
   pup. Instead retry indefinitely.
 - Unpin all pages on retry or failure rather than just failure.

[1] https://lore.kernel.org/linux-mm/814dee5d3aadd38c3370eaaf438ba7eee9bf9d2b.1659399696.git-series.apopple@nvidia.com/
---
 mm/gup.c | 192 +++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 122 insertions(+), 70 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index a2baa8b..6365005 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1901,19 +1901,16 @@ struct page *get_dump_page(unsigned long addr)
 
 #ifdef CONFIG_MIGRATION
 /*
- * Check whether all pages are pinnable, if so return number of pages.  If some
- * pages are not pinnable, migrate them, and unpin all pages. Return zero if
- * pages were migrated, or if some pages were not successfully isolated.
- * Return negative error if migration fails.
+ * Returns the number of collected pages. Return value is always >= 0.
  */
-static long check_and_migrate_movable_pages(unsigned long nr_pages,
-					    struct page **pages)
+static unsigned long collect_longterm_unpinnable_pages(
+					struct list_head *movable_page_list,
+					unsigned long nr_pages,
+					struct page **pages)
 {
-	unsigned long isolation_error_count = 0, i;
+	unsigned long i, collected = 0;
 	struct folio *prev_folio = NULL;
-	LIST_HEAD(movable_page_list);
-	bool drain_allow = true, coherent_pages = false;
-	int ret = 0;
+	bool drain_allow = true;
 
 	for (i = 0; i < nr_pages; i++) {
 		struct folio *folio = page_folio(pages[i]);
@@ -1922,43 +1919,16 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
 			continue;
 		prev_folio = folio;
 
-		/*
-		 * Device coherent pages are managed by a driver and should not
-		 * be pinned indefinitely as it prevents the driver moving the
-		 * page. So when trying to pin with FOLL_LONGTERM instead try
-		 * to migrate the page out of device memory.
-		 */
-		if (folio_is_device_coherent(folio)) {
-			/*
-			 * We always want a new GUP lookup with device coherent
-			 * pages.
-			 */
-			pages[i] = 0;
-			coherent_pages = true;
-
-			/*
-			 * Migration will fail if the page is pinned, so convert
-			 * the pin on the source page to a normal reference.
-			 */
-			get_page(&folio->page);
-			unpin_user_page(&folio->page);
+		if (folio_is_longterm_pinnable(folio))
+			continue;
 
-			ret = migrate_device_coherent_page(&folio->page);
-			if (ret)
-				goto unpin_pages;
+		collected++;
 
+		if (folio_is_device_coherent(folio))
 			continue;
-		}
 
-		if (folio_is_longterm_pinnable(folio))
-			continue;
-		/*
-		 * Try to move out any movable page before pinning the range.
-		 */
 		if (folio_test_hugetlb(folio)) {
-			if (isolate_hugetlb(&folio->page,
-						&movable_page_list))
-				isolation_error_count++;
+			isolate_hugetlb(&folio->page, movable_page_list);
 			continue;
 		}
 
@@ -1967,59 +1937,133 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
 			drain_allow = false;
 		}
 
-		if (folio_isolate_lru(folio)) {
-			isolation_error_count++;
+		if (!folio_isolate_lru(folio))
 			continue;
-		}
-		list_add_tail(&folio->lru, &movable_page_list);
+
+		list_add_tail(&folio->lru, movable_page_list);
 		node_stat_mod_folio(folio,
 				    NR_ISOLATED_ANON + folio_is_file_lru(folio),
 				    folio_nr_pages(folio));
 	}
 
-	if (!list_empty(&movable_page_list) || isolation_error_count ||
-	    coherent_pages)
-		goto unpin_pages;
+	return collected;
+}
 
-	/*
-	 * If list is empty, and no isolation errors, means that all pages are
-	 * in the correct zone.
-	 */
-	return nr_pages;
+/*
+ * Unpins all pages and migrates device coherent pages and movable_page_list.
+ * Returns zero if all pages were successfully migrated or -errno for failure
+ * (or partial success).
+ */
+static int migrate_longterm_unpinnable_pages(
+					struct list_head *movable_page_list,
+					unsigned long nr_pages,
+					struct page **pages)
+{
+	int ret;
+	unsigned long i;
 
-unpin_pages:
-	/*
-	 * pages[i] might be NULL if any device coherent pages were found.
-	 */
 	for (i = 0; i < nr_pages; i++) {
-		if (!pages[i])
+		struct folio *folio = page_folio(pages[i]);
+
+		if (folio_is_device_coherent(folio)) {
+			/*
+			 * Migration will fail if the page is pinned, so convert
+			 * the pin on the source page to a normal reference.
+			 */
+			pages[i] = NULL;
+			folio_get(folio);
+			gup_put_folio(folio, 1, FOLL_PIN);
+
+			if (migrate_device_coherent_page(&folio->page)) {
+				ret = -EBUSY;
+				goto err;
+			}
+
 			continue;
+		}
 
+		/*
+		 * We can't migrate pages with unexpected references, so drop
+		 * the reference obtained by __get_user_pages_locked().
+		 * Migrating pages have been added to movable_page_list after
+		 * calling folio_isolate_lru() which takes a reference so the
+		 * page won't be freed if it's migrating.
+		 */
 		unpin_user_page(pages[i]);
+		pages[i] = NULL;
 	}
 
-	if (!list_empty(&movable_page_list)) {
+	if (!list_empty(movable_page_list)) {
 		struct migration_target_control mtc = {
 			.nid = NUMA_NO_NODE,
 			.gfp_mask = GFP_USER | __GFP_NOWARN,
 		};
 
-		ret = migrate_pages(&movable_page_list, alloc_migration_target,
-				    NULL, (unsigned long)&mtc, MIGRATE_SYNC,
-				    MR_LONGTERM_PIN, NULL);
-		if (ret > 0) /* number of pages not migrated */
+		if (migrate_pages(movable_page_list, alloc_migration_target,
+				  NULL, (unsigned long)&mtc, MIGRATE_SYNC,
+				  MR_LONGTERM_PIN, NULL)) {
 			ret = -ENOMEM;
+			goto err;
+		}
 	}
 
-	if (ret && !list_empty(&movable_page_list))
-		putback_movable_pages(&movable_page_list);
+	putback_movable_pages(movable_page_list);
+
+	return 0;
+
+err:
+	for (i = 0; i < nr_pages; i++)
+		if (pages[i])
+			unpin_user_page(pages[i]);
+	putback_movable_pages(movable_page_list);
+
 	return ret;
 }
+
+/*
+ * Check whether all pages are *allowed* to be pinned. Rather confusingly, all
+ * pages in the range are required to be pinned via FOLL_PIN, before calling
+ * this routine.
+ *
+ * If any pages in the range are not allowed to be pinned, then this routine
+ * will migrate those pages away, unpin all the pages in the range and return
+ * -EAGAIN. The caller should re-pin the entire range with FOLL_PIN and then
+ * call this routine again.
+ *
+ * If an error other than -EAGAIN occurs, this indicates a migration failure.
+ * The caller should give up, and propagate the error back up the call stack.
+ *
+ * If everything is OK and all pages in the range are allowed to be pinned, then
+ * this routine leaves all pages pinned and returns zero for success.
+ */
+static long check_and_migrate_movable_pages(unsigned long nr_pages,
+					    struct page **pages)
+{
+	int ret;
+	unsigned long collected;
+	LIST_HEAD(movable_page_list);
+
+	collected = collect_longterm_unpinnable_pages(&movable_page_list,
+						nr_pages, pages);
+	if (!collected)
+		return 0;
+
+	ret = migrate_longterm_unpinnable_pages(&movable_page_list, nr_pages,
+						pages);
+	if (ret)
+		return ret;
+
+	/*
+	 * We successfully migrated and unpinned all unpinnable pages. Caller
+	 * should retry.
+	 */
+	return -EAGAIN;
+}
 #else
 static long check_and_migrate_movable_pages(unsigned long nr_pages,
 					    struct page **pages)
 {
-	return nr_pages;
+	return 0;
 }
 #endif /* CONFIG_MIGRATION */
 
@@ -2040,7 +2084,15 @@ static long __gup_longterm_locked(struct mm_struct *mm,
 	if (!(gup_flags & FOLL_LONGTERM))
 		return __get_user_pages_locked(mm, start, nr_pages, pages, vmas,
 					       NULL, gup_flags);
-	/* check_and_migrate_movable_pages() assumes pages have been pinned. */
+
+	/*
+	 * If we get to this point then FOLL_LONGTERM is set, and FOLL_LONGTERM
+	 * implies FOLL_PIN (although the reverse is not true). Therefore it is
+	 * correct to unconditionally call check_and_migrate_movable_pages()
+	 * which assumes pages have been pinned via FOLL_PIN.
+	 *
+	 * Enforce the above reasoning by asserting that FOLL_PIN is set.
+	 */
 	if (WARN_ON(!(gup_flags & FOLL_PIN)))
 		return -EINVAL;
 	flags = memalloc_pin_save();
@@ -2051,10 +2103,10 @@ static long __gup_longterm_locked(struct mm_struct *mm,
 			break;
 
 		rc = check_and_migrate_movable_pages(rc, pages);
-	} while (!rc);
+	} while (rc == -EAGAIN);
 	memalloc_pin_restore(flags);
 
-	return rc;
+	return rc ? rc : nr_pages;
 }
 
 static bool is_valid_gup_flags(unsigned int gup_flags)
-- 
git-series 0.9.1
