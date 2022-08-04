Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C177D589688
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 05:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238924AbiHDDXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 23:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238782AbiHDDW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 23:22:58 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC1E1570D
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 20:22:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CPvonWM4e/uXm51BsF5yBiI+Rafyos1JJjFi+0ilKST/NHtvOOPYcZ+rGzOV2iOuEu7keSgGXpLheTenWI+YqBAdVMNMX0ZeIEz8rMlXWa7HC5ptksQwRXzTG2A1XmHqRPxQ17tSRhaF7P7bCaj/8pkTQPNRCbcSHU2ylNZRphFOLrA2NF3dfJ4UihCR6FzekBO0iJRHpIXkv3TfQzbnskM7AMeAIUKYV6SSslr4UJRzYctNybOxTxLo02zATKWp9JrxpLDYPkofk7A7XDAwxToGudxKZPBVCI3onUSv1+1m721PwKAgSJWHAs+nRUitu50ONMp8BWY6XYCwma+ABg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ie3E69NNFimjNpTukhM9g1+eptQKwtizqSs9Kze3k04=;
 b=TNgDjro+n+1JqGgiUlgB9M+xQuJk1XimoUWNrz/Vbjfxb9464x1wbzp4GnuS7EE0Qo/W9O1ivQRvMqPR77Jv75g1OQqPsr7HpVIbDSUtGP0nfBuq3XbwGMuuCZ/wNwk4yTB59dQcwAwE1/g73vO3T0jLLeZ/LFVK/1a3f+54Eb/5W/7gfnh6g8EHhvVTDtYJ5/VEPablAM/QHm3ZXpHA79L3o8s7UA23JDcUVPXGpYWkenwIel45/xbe21fqVnEl/voy1yS3XAcRDqS1Gll9wEcb0iwXuH22XTSPiHcJOk5a1BAnqDQp+Dn+RWz12JmZ2Wl5mgyjORxu9l1Y35ftqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ie3E69NNFimjNpTukhM9g1+eptQKwtizqSs9Kze3k04=;
 b=P3bNY3lRK3GR+VhpLbx7O9mkMO9Ju9xeA9Tct+5X0QjJdSt17WcTimg3SkdEZODxMMJiyyd4Gpr/H+WRcBSDDwm0Xiyw1spkHcE/GVfFRr2HlnPy8ZLeSuDFhjZ+T/fggZwElRB8z3G4PjN2RaHS+gfXzCHyoNVL38tccBDqmSLD5kVN1iCWOPE8w7fSMD2owb0twAg/2y+LsKg9fE3wtxGBrAjr/FinOPwjmvdMdLIE3T4d3Qq2HboC/ZaigV4AVEY7oUJZ2270a6YjocdnL6pUb/KpxIGcLwK1FAthM7krrUqPizcr445JcVRz8KDh/O02upSeoXUhauPedzyjwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by DM6PR12MB4988.namprd12.prod.outlook.com (2603:10b6:5:16a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.12; Thu, 4 Aug
 2022 03:22:55 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7%5]) with mapi id 15.20.5482.016; Thu, 4 Aug 2022
 03:22:55 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Alistair Popple <apopple@nvidia.com>,
        "Sierra Guiza, Alejandro (Alex)" <alex.sierra@amd.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: [PATCH] mm/gup.c: Refactor check_and_migrate_movable_pages()
Date:   Thu,  4 Aug 2022 13:22:41 +1000
Message-Id: <20220804032241.859891-1-apopple@nvidia.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0126.ausprd01.prod.outlook.com
 (2603:10c6:10:1b8::19) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a7411ce-1d32-4a16-6fb1-08da75c89f04
X-MS-TrafficTypeDiagnostic: DM6PR12MB4988:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xYknlPcWdhciHx3gJPtcI3ze32LDUflEnYNEwtoxAntuIzfGCR+8ubwIQ2hFe3g3eqaKeJJyLktA4s3ye/XxzFaw73Yp8P5ne75sqfGDvWsHlbRfekVClufmIWKPe5cKzBRSodTOiM2wmZwrL4x7lBym/3I9EaHeV398a9h0xKcspl25QvHALllC52/3LXMhUSmlafJUaXhXE+O1CtbzGn/dV2FRc+3EB4KktOGbhzk2bg5bG3bXbezqzwEHPOFgs57HqSsSt0a3oa+XiHWcoBs3qXeF/Y3vplHVTBwX92PCDScEIVpwIgyoBwzK/H2UnwvSC1fVhH2DDgAnScWsZW47KPTklIdsMFTqoW9ea4O5BLQt9r4Mlatc1HNOCsssrt9PNg9O0rBO2/SiIlRzZLM7fdQjsilWm5NG1z54fHbzVj1vQIq2MirJdzkzFbwwZcD50Pn4ss482xjl0lgcowBzzHCpZjH57afhgEjTtDq5vGYH/SNrp5HDLgAQMUrloyDLgG1xsD3B0LtvldQehlYnc7azRwnqn7MHnZpG+QVzGqj9bVS8+rc2h35pfCi9Ab/fxE8sHyFGEwxzzoeVZHcEhm+k8KUzZs0qtZryN4PV6UETuLeOt1WYcK2W/dhRmnc3mPWYomq/lFzTrwIieW6a3fxrldIIrwOL+lsrjTlXvfAJO5mrqfPeV5JvKdZHYAQ4SBDUaBFjMvw3nc/Nmf+sViVTBI8kq4++K0XLif7QwSI2+edXJtlqM5WpC6gHt61V2w27W3rYhxkioWM2dlEz+OxSiqq0ru+FBylhPzMAYSta97s3q3b7GTySbJj2wpIGsmX2Ul2A/r1mu4LP1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(396003)(136003)(366004)(39860400002)(86362001)(83380400001)(26005)(6666004)(6506007)(186003)(2906002)(41300700001)(38100700002)(6512007)(6916009)(316002)(5660300002)(1076003)(6486002)(966005)(54906003)(4326008)(2616005)(8676002)(107886003)(66476007)(8936002)(66556008)(66946007)(478600001)(36756003)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UpWjfcVvshv/oLREmResnbZQt/lvDswYKI6X24t3fA3HI1eJeIoOGf1d22a1?=
 =?us-ascii?Q?OI4iXXeao1l0qIlcPYTLX2BPwydjfpacacCUXUMoAdnzvmtCvFbKg623Pfrq?=
 =?us-ascii?Q?ij5yzi1NOLSEfTIK/M/pH+KlonlnKwAslJTtE/Q3EWJQmoSZUIXp+Mg/uuPg?=
 =?us-ascii?Q?Q9tRFVhdp0JB/QUkBGFehVAI8H7cEpk8F76v9Aj6cXIUDQQAkGOzGbphYdxg?=
 =?us-ascii?Q?3l5ik9L4IH3OWvI3ylrOEFax1uHsDeor6OIFxbG+b/IfJCOZXlCpoNZjOo0n?=
 =?us-ascii?Q?ryGT8zwaLOOGPVNnrwSkovKEnbSszHSMT3e5s+IepLh/GQLZuqMUHjrH8Qze?=
 =?us-ascii?Q?Tfs5OKrUXB2lZE9yCDqlvmAK0A2J0dKaI/kwETZJuNuwGltZ51PhVr2Ts7Ka?=
 =?us-ascii?Q?Uef8mG6pPzRoT6zyr4xiyGUoctbUfSXvZu93JXejp0BeqWx3cpdavaqNuvNc?=
 =?us-ascii?Q?Q8dIom3xUqzuojrj8ku0GscvnKKe85LsWSaKRv9JE0X4dOL6pLKr4Yw7guv3?=
 =?us-ascii?Q?xb21WglwVw5Bx0D6johhHhLWM0AtuZk27jnjaLqFXtQg39s+U/gEN1CbVxX/?=
 =?us-ascii?Q?mQ9o+QKNPS8vr3muSxaWAYSewgA0pYhNblInCSmJBhrx54/1dQvy3MeDK15G?=
 =?us-ascii?Q?bKbwR9J8B+QTFO6/rmpUAGOT3jdFWVDxPXFdEUBFo8riSZFTysg8ZIp6I3xA?=
 =?us-ascii?Q?4HWnsgI7to3FYZQ1SRnLuhZVGUuiG5ooi4iaNB4QDA+9+ppdOXgUpR8UaOy7?=
 =?us-ascii?Q?0+Z8+eFMa/y1gk2yBC1974Um/cIuB5pDiHdWgpI/qQVDZViKMd1Jw8N1HIip?=
 =?us-ascii?Q?ORTAp0OGi1IQh+1IbIKAWFM6e/IEdzKZrXk/Y4YDnDNJoS2McTd1pwyaLS+C?=
 =?us-ascii?Q?iG3Ajl/TeuOXASE0nloKW2IVwuxejZp0hR/9zIrW6A5V52yMSB5vDDiTRcqA?=
 =?us-ascii?Q?4BgQmqgV7E5tOUZglvljXqKInNv8SSxtY8Et5F5AdvsS7qJpZBtHBEy8/RKw?=
 =?us-ascii?Q?Mce0Pr2MAzgIiHml3OXSZ8twSEbyqIpR71msuiVcYhTKrRwXfj/RE0Y0weZC?=
 =?us-ascii?Q?aEZIF7tkglfHsujzOe0LzMtiIH7GDLb83FlkywGThMR7wKZbWbOS52jF/xxA?=
 =?us-ascii?Q?oFpQGCJCmNqJY5mJh26g1kz0ILpuanjVxBUwYh75bd4ab3C5uRZadRLQbdm1?=
 =?us-ascii?Q?RLXDkpExjj7LuX4wgCaEtEmQwe3FEh0Uc8Bt6zFJNe/6ARYcxmu+ucPvIYA0?=
 =?us-ascii?Q?Q4bpVqAqkKpVuKKhLrNQyYm4T+9XeyjcgeKpF9yVd895FKcC42r+BYFC562G?=
 =?us-ascii?Q?+GlohrxPJHj7m3u9+jfTjM7lZZOnN8WBYIzFTYMbdnMiawZTm2DJCgHHtFFD?=
 =?us-ascii?Q?Re71Zv2ZxWXAmnoL7FLDdZEMCH67spr6XD6ijm9Iu0PQtPkAXMzpm/mKLd73?=
 =?us-ascii?Q?/s361TXWWXJfHE/IP2I1RLzWJLO2ZxyZiD1+aso7YwrI/uj3vQX03ZkZGgm0?=
 =?us-ascii?Q?nVI8CX6A2HPk6Uznu69H4NAWXse7FuFYjhGxjfxki0lZg4mfcQaCRUkmxq4T?=
 =?us-ascii?Q?F/2GxbQkgQ6qjp9kZbj4nvD0phi/zGCNhlfcRT2T?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a7411ce-1d32-4a16-6fb1-08da75c89f04
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2022 03:22:54.9998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WikvfDg7JXiKWJHwr+Hv2eYJaSYQgWlOV93gqvpjfKLfRu9tapOzgmVumLCnCMAXsi1MigpnRhv5Vb1XhQF8FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4988
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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
Cc: "Sierra Guiza, Alejandro (Alex)" <alex.sierra@amd.com>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Logan Gunthorpe <logang@deltatee.com>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Muchun Song <songmuchun@bytedance.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Ralph Campbell <rcampbell@nvidia.com>

---

Originally posted as "mm/gup.c: Simplify and fix
check_and_migrate_movable_pages() return codes"[1].

Changes from that version:

 - Restore the original isolation failure behaviour and don't fail the
   pup. Instead retry indefinitely.
 - Unpin all pages on retry or failure rather than just failure.

Jason - I dropped your Reviewed-by. I had to remove the changes to make
error handling follow convention as we need to always unpin the pages.
We also need the list_empty() checks because we may or may not have
pages in the list if we found coherent pages. So there isn't much I
could see to simplify, but let me know if you spot some.

[1] https://lore.kernel.org/linux-mm/814dee5d3aadd38c3370eaaf438ba7eee9bf9d2b.1659399696.git-series.apopple@nvidia.com/
---
 mm/gup.c | 61 +++++++++++++++++++++++++-------------------------------
 1 file changed, 27 insertions(+), 34 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index c6d060dee9e0..5ce0106a92f8 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1901,20 +1901,20 @@ struct page *get_dump_page(unsigned long addr)
 
 #ifdef CONFIG_MIGRATION
 /*
- * Check whether all pages are pinnable, if so return number of pages.  If some
- * pages are not pinnable, migrate them, and unpin all pages. Return zero if
- * pages were migrated, or if some pages were not successfully isolated.
- * Return negative error if migration fails.
+ * Check whether all pages are pinnable. If some pages are not pinnable migrate
+ * them and unpin all the pages. Returns -EAGAIN if pages were unpinned or zero
+ * if all pages are pinnable and in the right zone. Other errors indicate
+ * migration failure.
  */
 static long check_and_migrate_movable_pages(unsigned long nr_pages,
 					    struct page **pages,
 					    unsigned int gup_flags)
 {
-	unsigned long isolation_error_count = 0, i;
+	unsigned long i;
 	struct folio *prev_folio = NULL;
 	LIST_HEAD(movable_page_list);
 	bool drain_allow = true, coherent_pages = false;
-	int ret = 0;
+	int ret = -EAGAIN;
 
 	for (i = 0; i < nr_pages; i++) {
 		struct folio *folio = page_folio(pages[i]);
@@ -1946,10 +1946,10 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
 				unpin_user_page(&folio->page);
 			}
 
-			ret = migrate_device_coherent_page(&folio->page);
-			if (ret)
-				goto unpin_pages;
-
+			if (migrate_device_coherent_page(&folio->page)) {
+				ret = -EBUSY;
+				break;
+			}
 			continue;
 		}
 
@@ -1959,9 +1959,7 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
 		 * Try to move out any movable page before pinning the range.
 		 */
 		if (folio_test_hugetlb(folio)) {
-			if (isolate_hugetlb(&folio->page,
-						&movable_page_list))
-				isolation_error_count++;
+			isolate_hugetlb(&folio->page, &movable_page_list);
 			continue;
 		}
 
@@ -1970,29 +1968,25 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
 			drain_allow = false;
 		}
 
-		if (folio_isolate_lru(folio)) {
-			isolation_error_count++;
+		if (folio_isolate_lru(folio))
 			continue;
-		}
+
 		list_add_tail(&folio->lru, &movable_page_list);
 		node_stat_mod_folio(folio,
 				    NR_ISOLATED_ANON + folio_is_file_lru(folio),
 				    folio_nr_pages(folio));
 	}
 
-	if (!list_empty(&movable_page_list) || isolation_error_count ||
-	    coherent_pages)
-		goto unpin_pages;
-
 	/*
-	 * If list is empty, and no isolation errors, means that all pages are
-	 * in the correct zone.
+	 * All pages are still pinned and in the correct zone.
 	 */
-	return nr_pages;
+	if (list_empty(&movable_page_list) && !coherent_pages)
+		return 0;
 
-unpin_pages:
 	/*
-	 * pages[i] might be NULL if any device coherent pages were found.
+	 * Unpin all pages. If device coherent pages were found
+	 * migrate_deivce_coherent_page() will have already dropped the pin and
+	 * set pages[i] == NULL.
 	 */
 	for (i = 0; i < nr_pages; i++) {
 		if (!pages[i])
@@ -2010,15 +2004,14 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
 			.gfp_mask = GFP_USER | __GFP_NOWARN,
 		};
 
-		ret = migrate_pages(&movable_page_list, alloc_migration_target,
-				    NULL, (unsigned long)&mtc, MIGRATE_SYNC,
-				    MR_LONGTERM_PIN, NULL);
-		if (ret > 0) /* number of pages not migrated */
+		if (migrate_pages(&movable_page_list, alloc_migration_target,
+					NULL, (unsigned long)&mtc, MIGRATE_SYNC,
+					MR_LONGTERM_PIN, NULL))
 			ret = -ENOMEM;
-	}
 
-	if (ret && !list_empty(&movable_page_list))
 		putback_movable_pages(&movable_page_list);
+	}
+
 	return ret;
 }
 #else
@@ -2026,7 +2019,7 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
 					    struct page **pages,
 					    unsigned int gup_flags)
 {
-	return nr_pages;
+	return 0;
 }
 #endif /* CONFIG_MIGRATION */
 
@@ -2054,10 +2047,10 @@ static long __gup_longterm_locked(struct mm_struct *mm,
 		if (rc <= 0)
 			break;
 		rc = check_and_migrate_movable_pages(rc, pages, gup_flags);
-	} while (!rc);
+	} while (rc == -EAGAIN);
 	memalloc_pin_restore(flags);
 
-	return rc;
+	return rc ? rc : nr_pages;
 }
 
 static bool is_valid_gup_flags(unsigned int gup_flags)
-- 
2.35.1

