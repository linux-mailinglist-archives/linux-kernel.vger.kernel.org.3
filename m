Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA6558A5E5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 08:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237126AbiHEGaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 02:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236906AbiHEGaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 02:30:16 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2076.outbound.protection.outlook.com [40.107.95.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA33B6272
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 23:30:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QcvnJcIhxbdvRmXujmR2gPE9oVy3JITPD3lHne4xDUW0iAnF2p8yzv1QjciQDTMWCD8Nt/KFK8YnuPbFLEb6yI0unUQFR/rpNavNEReBnvE7lvsBs4qDTlb+Klfk2Bvn7CBEipdG1rJCRH5siImgfTbuA9lEFFYScovk5bbC+0zS+wiPMPwkR00Gr3Zpr6/epaPFD+Ul3Lf6/Mp+85ICoCcEJMw+rPdLPwoO9V3VHm5iy5UMNh30gt0vBWtLbEAlF8FgYEVqkTa6CIy6nKgaLz+TPER3QXENZCbo/TSuWtY9Jo3uA89/mo2BxMIdm+jqg2HL1vDJSTTVdUEOn1hxAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rmm7Lmiwgjz3sy/7/4287JSulfBY6cPf23Vy1NwWlb4=;
 b=L8JsDvHzUTXT5QsEdqm/r2OcXhEONJtWZW2SOvZKqB6RH0mxDSk6C+T9yRvdgnsH0WgAI3NgTKlA80v+V4HBy+iY0kTuWb97xneaZMGSI6g8z9vifVXLwrfsyLSKEq5sYgrqjTtDFz3OMndVvjYpEfDr7oGhy8BUVI2pNOCL9g2BRZsCsk73H6pDgnc1q2T65V8B2gkmZhq86BkDbobDmA5nThH7aXmHDXU/3O+n3GC/lWwyYFW9uRBEJhoSHsKWSo0ptBGgFF118Kq6oS/XiX/dQyO9I5DiSSZXRtzxqE9DN1ceDU/kPvxYdCUU4K9swLYvOPjmx+fexQYndWq1sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rmm7Lmiwgjz3sy/7/4287JSulfBY6cPf23Vy1NwWlb4=;
 b=FgmjD0U6g8Uoyw5WUON+1m04Zav5rn+lfVi0XT568hF9wtxUg0BNgcbdr5nBTi6fTVjB6RMLF3djJ6u33s/65ExwkyHUviRVWjAqOAPEdvt+rr4jwp4DNT59j51xNAxV7EsWiQdGiPgR6D4LmCd8x4cUnE3YHuftgRKMRX/bGe5k+mePD5riRy08JhOvfYgiDd7NaJ1S9MsDLKrtIAFpep3cIxXaRX6bhb14Hfw0m7A8Xn5yDAeUzEactxU1YQVSQ7rreoC1x58HTCQ7I96526K8FcLk2k8vfvAmlQbZ4/hrpWZjVZt1n+rRtvVyqDzet62Yo2E1PuZzjjTyicNB2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3179.namprd12.prod.outlook.com (2603:10b6:5:183::18)
 by SA1PR12MB5613.namprd12.prod.outlook.com (2603:10b6:806:23e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Fri, 5 Aug
 2022 06:30:14 +0000
Received: from DM6PR12MB3179.namprd12.prod.outlook.com
 ([fe80::d0c7:5814:170e:b016]) by DM6PR12MB3179.namprd12.prod.outlook.com
 ([fe80::d0c7:5814:170e:b016%4]) with mapi id 15.20.5504.015; Fri, 5 Aug 2022
 06:30:14 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        "Sierra Guiza, Alejandro (Alex)" <alex.sierra@amd.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Alistair Popple <apopple@nvidia.com>
Subject: [PATCH v2 2/2] mm/gup.c: Refactor check_and_migrate_movable_pages()
Date:   Fri,  5 Aug 2022 16:29:53 +1000
Message-Id: <3f6d04570907ee80f030ffaa85e8f506b3d31fc1.1659680600.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <3e20a542e756bbc0f66435c9344ff674f3ff7ac7.1659680600.git-series.apopple@nvidia.com>
References: <3e20a542e756bbc0f66435c9344ff674f3ff7ac7.1659680600.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0042.namprd02.prod.outlook.com
 (2603:10b6:a03:54::19) To DM6PR12MB3179.namprd12.prod.outlook.com
 (2603:10b6:5:183::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2954f86-daee-448d-a208-08da76abf45a
X-MS-TrafficTypeDiagnostic: SA1PR12MB5613:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fglv3BFkCwvb7lgUeTeshZ2ymIF3gUStnAa+aXMueRwmrPTjmvj5l/OKEwv3xt3OvSRjvLSMwlxWpzMoyTDATHvjWOiRZvDxNFbxrxdm9Lv7MUEokOuH+MqQ4yN7NrFkQAlbV94u7nQZeVbsfbhVKZIa/DpVVXLnse2da/WpIIz9bfqd382mE5lMcJLjtsRi89q2oCnMOuihu8SKuArbOaxVTKrzPujudCb3XdXcgfJpvhJyx1zYazRIs/RwtoRCj/RPl9TNICwZa2+j04ppeIu9vAEeIb0CUxMjVgIQ1hLBjNcU1QztjeTJ75v3U0q7LvSpDTmYM8f8sUyVSRsV0KIH0JquM+FN3VAVf2/fmcnC5il9F/vEvO0Ohx0bCkd9baGw7Q0a02saFJrTBwUsPusVhCviC4s38Xr2gEUlDV6MyCLJorqse7kHYccnaEy/X1w9T6zAJSkNqbIpCrw1SmvWMYsITzsF3U2WMkPpZoiZMmgngc6CEAPEpfm2b5y13dCo0raok8Iyyc3RjmEhJV4pccXjJMnoORWF7gelyyyIMBaIt83U4NEAR7x01YGOZfS+0gEGrf9vygLfD6GUXNhGVLlEDoO3PtEpOBqMP7TRexj8Ej0N/GBV2VWApwMHo7wIQNowOmbS9Col2/2hKviGAzw9U8FJhyovGEAv33JELEHT6+8XPsMpB4jsSFsctjQzvNNO3peUlCmS/Q4/RsofN+OyUO9fNaY8mYIm50SChVejO3xeYkttkDvsnOdDpp3W8HZZekK7xK8ERfQeSxVmMLdDFuwBMhhvGSCKq+InNLwucT94gjeMtF2KDwvdLrx815y7J/wm3ZTCCmuVGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(366004)(396003)(136003)(346002)(83380400001)(38100700002)(2906002)(54906003)(2616005)(26005)(6666004)(186003)(107886003)(6506007)(6512007)(86362001)(66946007)(4326008)(36756003)(8676002)(5660300002)(66476007)(66556008)(6916009)(8936002)(478600001)(6486002)(966005)(316002)(41300700001)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c2JbYF3VxdHHbUgIZs+bCWs2oxsMIERzfb+ZVIgRb1z6XMVi+lPTOB36Ksjw?=
 =?us-ascii?Q?t5HXaEQmSKtBADNu5P3Ksh7xaLUcnZozZwi0ll5OXBrtuOyHiTOKQEU8qjkP?=
 =?us-ascii?Q?y0Ex9HlHB/ToTN8ph66/wup1GhIHXXM1j6TnH8tutpGwqBWzV24XJrrl0FKx?=
 =?us-ascii?Q?CtmEjjV3LuVVf2nF4UFM030zeNx5Jo7K7Klkgdp9yjkaVUvo6CS8f2GKH/pl?=
 =?us-ascii?Q?5Db/ycVS/PMNMHXrycX6F53MOwH2dWLDXkr/PrGmbYUt+r5BCyP97dy/AAzi?=
 =?us-ascii?Q?4mgJgyW9AJc84MNLL5UU9CDGi9naS1MlxrEu5BW7adCABhKo9u2LSm2qhHCx?=
 =?us-ascii?Q?A7B97LMMnqKuFpOqnp05Q6ks9yLH74fSSS01JHiGXqJZUkbDoQ2Y+JdSDwba?=
 =?us-ascii?Q?wg6XvzanB9ny7NAxeJrdHQ7A+Df7GDDTsTHKBXMOUZE8gvCHT/Ivj3zkyZfM?=
 =?us-ascii?Q?/rX8lxfzZf89/0YgqNED3Pn7g2NfAzCCYZfeV8zL4dhzzNeiSpbq7l86s8J2?=
 =?us-ascii?Q?SmaYxaOSoQnWWpPv1NBy9C5EToyrLhHqI/1c8r8sfWSk5JE8t92WSj6POIYB?=
 =?us-ascii?Q?ZMMeMzYIiFayLKLMvATkw86zTZ255dyADiSm/b5LcwNs4sohRXfNPjjUjYD1?=
 =?us-ascii?Q?Mn11X72mRQvgwqerY14afmlh57g6WCyqimLYt+cHPSy5U482oGw621eRFaeB?=
 =?us-ascii?Q?czJPn+HXvmxwzo+sskdwLQwnZsyKf77MAQp7CraBOXDQrtUn22upqDxr3bcW?=
 =?us-ascii?Q?0HbN1wNrJq4By8yfFtskqtrxlWHZnmsgThYEwkpWyxI+717hlBm7yn4/UR17?=
 =?us-ascii?Q?K4wTE0MngkiP3S5L4k9J9MlLYqECRocKMQszkILUaJb0kQewaIHzSrHMuLOU?=
 =?us-ascii?Q?e5S/xTjoRg5XLxOzow3UukjnMIGadIE+Qp0PXZx+fT1wtYgIGawYHjd6L75K?=
 =?us-ascii?Q?4gELHtlxplUC9MCNJnGfMkcHE/PbqSsB5ks6sG8NmQHvc/0hfmaS1nA1NWsm?=
 =?us-ascii?Q?elJDVNx5egjY4s+gTWfHAyMenVph99aW8r2LCKsrL/IvicQPNsTKnLrhy1UZ?=
 =?us-ascii?Q?VfGJQQ4YfxzkyBU2+ev8OE/dSmkdoub6raaC4k2LbEE1IxqQnN+PkdeRmoJA?=
 =?us-ascii?Q?iei/hEO4LEcU/zjerPFaYDk49qdu6Qh+GwG6DjQocJ3wNR/BZYFpWanxlqoR?=
 =?us-ascii?Q?NV+y35ZdmJ09+BuzjWmYs9rl7KLnt22UkSGMfJ5/iLBkSDJsj+FiX/LJvmS8?=
 =?us-ascii?Q?fH6ujpy+ShBoqEZFX84YEANeXE5aJiLJ03do28Nit5I4TLAUEd+A2ki13DGd?=
 =?us-ascii?Q?IruEOpp328OSts2J1z+NlXMhoF9OtJNBJxlE429ohn62A4iRcsPkjKlI9l2B?=
 =?us-ascii?Q?zNHWjP1eCd1fMKOe9ebzIzXWit0NYE9uq4Ntx0d0wUo5csuDe5n/gYF70eOW?=
 =?us-ascii?Q?bhSUo46A1NvVFFRIO4/VnPTATfnQdm6BXEjRdNk1lHQaA9QMbd86blMWILyq?=
 =?us-ascii?Q?zD4ve2Buhl5xlAxFUD5nBTd9qzOERs469kfRQmKjVV2Kk3K3dKVwExLcfoXd?=
 =?us-ascii?Q?3KbyNXqz4tH5Q6mLnz05vhP3pTyda5YTZG+ULa/V?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2954f86-daee-448d-a208-08da76abf45a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 06:30:13.8974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2XjNXgMxKWfDw0yqxW6VS+2UWQpsl3OVRi5ztpLJtLANzbP7NyGXC8JEHxDPDrGImBW0Tufe4OdWJTvQlBk7cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5613
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

---

Changes for v2:

 - Split into different functions as suggested by John.
 - Made error handling more conventional as requested by Jason.

Personally I'm not entirely convinced the conventional approach to error
handling is easier to follow here but have left it in for feedback as I
might be getting too familiar with the code.

Originally posted as "mm/gup.c: Simplify and fix
check_and_migrate_movable_pages() return codes"[1].

Changes from that version:

 - Restore the original isolation failure behaviour and don't fail the
   pup. Instead retry indefinitely.
 - Unpin all pages on retry or failure rather than just failure.

[1] https://lore.kernel.org/linux-mm/814dee5d3aadd38c3370eaaf438ba7eee9bf9d2b.1659399696.git-series.apopple@nvidia.com/
---
 mm/gup.c | 159 ++++++++++++++++++++++++++++++--------------------------
 1 file changed, 88 insertions(+), 71 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index e26ccc0..60cb30a 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1900,20 +1900,14 @@ struct page *get_dump_page(unsigned long addr)
 #endif /* CONFIG_ELF_CORE */
 
 #ifdef CONFIG_MIGRATION
-/*
- * Check whether all pages are pinnable, if so return number of pages.  If some
- * pages are not pinnable, migrate them, and unpin all pages. Return zero if
- * pages were migrated, or if some pages were not successfully isolated.
- * Return negative error if migration fails.
- */
-static long check_and_migrate_movable_pages(unsigned long nr_pages,
-					    struct page **pages)
+static int collect_unpinnable_pages(struct list_head *movable_page_list,
+				    unsigned long nr_pages,
+				    struct page **pages)
 {
-	unsigned long isolation_error_count = 0, i;
+	unsigned long i;
+	int collected = 0;
 	struct folio *prev_folio = NULL;
-	LIST_HEAD(movable_page_list);
-	bool drain_allow = true, coherent_pages = false;
-	int ret = 0;
+	bool drain_allow = true;
 
 	for (i = 0; i < nr_pages; i++) {
 		struct folio *folio = page_folio(pages[i]);
@@ -1922,43 +1916,16 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
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
 
@@ -1967,59 +1934,109 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
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
+static int migrate_unpinnable_pages(struct list_head *movable_page_list,
+				    unsigned long nr_pages,
+				    struct page **pages)
+{
+	int ret, i;
 
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
+			get_page(&folio->page);
+			unpin_user_page(&folio->page);
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
+		 * the reference obtained by get_user_pages().
+		 * folio_isolate_lru() takes a reference so the page won't be
+		 * freed.
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
+ * Check whether all pages are pinnable. If some pages are not pinnable migrate
+ * them and unpin all the pages. Returns -EAGAIN if pages were unpinned or zero
+ * if all pages are pinnable and in the right zone. Other errors indicate
+ * migration failure.
+ */
+static long check_and_migrate_movable_pages(unsigned long nr_pages,
+					    struct page **pages)
+{
+	int ret;
+	long collected;
+	LIST_HEAD(movable_page_list);
+
+	collected = collect_unpinnable_pages(&movable_page_list, nr_pages, pages);
+	if (!collected)
+		return 0;
+
+	ret = migrate_unpinnable_pages(&movable_page_list, nr_pages, pages);
+	if (!ret)
+		return -EAGAIN;
+	else
+		return ret;
+}
 #else
 static long check_and_migrate_movable_pages(unsigned long nr_pages,
 					    struct page **pages)
 {
-	return nr_pages;
+	return 0;
 }
 #endif /* CONFIG_MIGRATION */
 
@@ -2049,10 +2066,10 @@ static long __gup_longterm_locked(struct mm_struct *mm,
 
 		WARN_ON_ONCE(!(gup_flags & FOLL_PIN));
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
