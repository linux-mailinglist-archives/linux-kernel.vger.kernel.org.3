Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2264C53F84B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 10:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238268AbiFGIhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 04:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbiFGIhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 04:37:37 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFC323BDC
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 01:37:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xj2E4I2OY4YWpXIzC8+Y9H3B9VR9nwoLSt2HXRRdvJ5zfsWZajfn1UW9Y3mY6xTf/9UZV1coSV9T+sd4by8wPcZuxRTx7WNyTA/HtR2Fp+wTrvJJyH25Il0VmRyfyIpVX1/7nFkH/L8RoZis6gvJM6k2f072MiNyBUUUqOgq2NIyEkBjjluTJHPzvs6N2oIiZpZa9DwZGALmwJqzVJ7Yyga0unT9RL3NVj9KnycWcctKrK7jR7gAp5bbFLKbjQCxsHHkVLcIDBA1XUY2jQxQ2xd+odR7HkKVtD9geO273YKHycaRUm7xsUslEH7y3K6PRy40V/pZKMFmNGOHlsME4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ny8WAuZDx3G7Fmqr5hQio2wMQFWMo/QTvayG8bFLhyo=;
 b=TuHEVZgj4OgUEQ2kIEr2hv3Wuc+eLK5/HfH5C1JIixyuxAt3Up7j6kCVivnj/cYqS5r5z66R9gPJGVedStmM0iYqpDdtrMg3tQZHJ1dQpLCPMGVEZ30DymW6fkbxlaFRHbU/Su/A/CigFL5oE9NoFCh75YY+UQBUePaBvkJM06NiELMoEEe59HQNJFMU/A+peLWzUcJj07ykO479hEAMOU3jQGQYZPKwSvCgizRDnPapHKtqPNxccuXqyE4srn+bU4oG7HjKdHfCaishci1W5qs+XjRjovrrGf00D9q2ev2lioVJKICDSO/mXNILFqPf84ipIwIm1agArI2eC+sFow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ny8WAuZDx3G7Fmqr5hQio2wMQFWMo/QTvayG8bFLhyo=;
 b=SNLE/VNiIu1B/VnL0nd8dKbn266VzoklgtDkBGlz1s5l5BWwAvKbe3Vt3ZXqOTq4BQiQ8LMMmsQ92GHejhwW1uhs6XsgKq4jC3stHHZ8s8pkxRe+O7F6nrENB6uyiQcFzeBAKJcCmHfi4cDn232kPe7OaoB+7k91BNAR+d6hJFVC/TTeZnnnVX2TAkThHqQlbaO601443vs4hV1gbqV/bP4Oi5JKa/9GODeg1Rr64enpATgXSGpbwIM9ifCtmV5YUiITcLICvywwtQgD72gDujnRyb875FY35swtxMgfrQWiOvh2+j9Q+8NzVIXKBd74q8z3ZIIhDE9lZWoKrnf56Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by BY5PR12MB5543.namprd12.prod.outlook.com (2603:10b6:a03:1d1::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Tue, 7 Jun
 2022 08:37:32 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::59cf:d090:5d26:6e7b]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::59cf:d090:5d26:6e7b%5]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 08:37:32 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        willy@infradead.org, Alistair Popple <apopple@nvidia.com>
Subject: [PATCH] mm/filemap.c: Always read one page in do_sync_mmap_readahead()
Date:   Tue,  7 Jun 2022 18:37:14 +1000
Message-Id: <20220607083714.183788-1-apopple@nvidia.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0208.ausprd01.prod.outlook.com
 (2603:10c6:10:16::28) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 559140f5-de26-444f-6733-08da4860f6ea
X-MS-TrafficTypeDiagnostic: BY5PR12MB5543:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB55436904228A2A2A3CD418B0DFA59@BY5PR12MB5543.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9CVtn48g9k+yu1yOV+95NBsc5UojFULXsmhJDGCNNL1bu2Lyp/KAYRRjn750xv8kl5TM9T0qEIpHHJaVb9LMgVEBJlGKbji2I/E839YusdkzJuq6Cak6xdMp5H2v6nRGWtmSX/TgaFcPJskWlWuTjVr6B69n9scv3XVJwc60p2YED8hlBPsKYk1LawGgdKcSjsv1qcumwQPfUD51GCYkG0FZlHzbRhNhkCeW4g98t1+009J91/2AxrjDgGXzOBAZs5MEhurYk6WW0HV4VRh3LXw/3U+yvtTCRwvflP8P5c5p9IiOX6eycHKpp4zbgC/Uwo3gNlgvasFrtLKWGVk82vdgcWaQc8Lk40U9zFByH4iQKK/WHtz7u/sm50wg7j05Vw3kmLhuMnQsO/+WxkW2UBD4v7e6OHc32JY6lv9eoMejtWRZSjiwzQV+fy6pFG+X5R5Dkp8LN5eP1OGY78aemfG8KF3jkQmtuJtrXjMfWi5a0IbLBz4jYRdHN9MHCj2WbeRjpSmtH3Wk7LnOgsGc+G7FgDMr52fPTOM35KDvxa8dKvb9k4iuYoquGTFOa68uMZ94e/a7uv5/OH400fmXH4DzZyeOBlYU8XbmMHnai1hQGKEZ0QyFILZ6XnizJVzO6h6Xun5BGbpqeYV10s3VXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(8936002)(8676002)(36756003)(5660300002)(66476007)(38100700002)(66556008)(66946007)(316002)(86362001)(83380400001)(6486002)(6666004)(2906002)(508600001)(6916009)(6512007)(6506007)(26005)(1076003)(107886003)(186003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AjUU0wOcSO54SgPTDMsqLZe5TaDDuwt0CKwRiLV106PzlAgVf5maNUIh2gCa?=
 =?us-ascii?Q?hU5i4GmesnDwGe+9fsyTvaPXKr1Lql2IWJm67uGKRDHACKxJX3PJ+QwGoNTC?=
 =?us-ascii?Q?VaXBzW86MGOrUNn0Rs7WosnGGTQr6cdKlNQ1NdqjXV6Vy65rH/anEZ1NZ+2l?=
 =?us-ascii?Q?bs3u/VIgaVj7/VYyBV0Tlv7pBSYp9tgBUcGLnyE+Joz2Mw/BC+Q75ENY8xWX?=
 =?us-ascii?Q?TyrI+UVtYzH5gkOXFsu3HUwWXpfavJpEDaBi7sP2VWjmevKXMAaxs0s8gtU8?=
 =?us-ascii?Q?rZHgrkdDiy+tmUdS9dh7fwH0snn4f34/2R0D255V058sZV0srQ503jk/i2dN?=
 =?us-ascii?Q?iXrJZ9nNeQjpn+xBpmi21pTb3q2ouRA+dafPdnU15Xzp/ci34YDZHiIFhuDF?=
 =?us-ascii?Q?dZuAQHfmlF/8irBvnVHtfCek3rbFUlIFN2tH0CooF7c29mSg3+UZRekD6rAF?=
 =?us-ascii?Q?jKpBeB1/Ze/5i1UxaFkIVphWSUe5xkHh4ZoYk7nk8wz8pCtAXKyqkikj7YMh?=
 =?us-ascii?Q?vtqlnJdZxKH7D4zF/8FIR06GbCRnl5cyQHzkFoCwJac7fbnboJY8AonngHAt?=
 =?us-ascii?Q?Z2V2FsOQ6K2x2HIgFgwZGiGro7h4Jqy0k8KiNaYHFsnzZBF98Ybt/pZnDSjf?=
 =?us-ascii?Q?ZM045fd5VU203pLqV4PsVKQjIogfm59v4T460w+iQv12tRtBOvSGIpKA+VzP?=
 =?us-ascii?Q?CwqAlzRXsyzRbiGx0phPWAbH++kp8+d3meE9yFssAIkcAPntn8FA/YvMY8RM?=
 =?us-ascii?Q?5El/JzlZOEyFUTYREXtD2sCn6/jDbl8laQ7Pg7sK/SNaa4clCfexDEL9BpYM?=
 =?us-ascii?Q?zUS9kYc3Wax/g9UI5UlesAUdSofeHCFjuTxdQ+lOVchW0+gRYpNCjTwBXSaL?=
 =?us-ascii?Q?aiFlkU9Il3TpHe9X55SrlsHHuRNE8Sycc8mwp+ZQwz6Hfsj6f5GA7x7euttE?=
 =?us-ascii?Q?EJlMsPbkkZKhLwgCbFuNvgVhuBTQHkdlpd2vn0twytBKzcSWueuOG5zO/nUI?=
 =?us-ascii?Q?e5l74t6qRXly+h98DRwbz09438JTx4aQqic6R4xK7tju+xN0X8+QpRKJXKXO?=
 =?us-ascii?Q?Ix9di3g4arCr/muN15rc1FQQ0m3EXGyn71IXv6JOSZwYq7yphhtGuWCZ1SXq?=
 =?us-ascii?Q?Csfk++SknKJNDUS1ufT7MoXGzwDOGp3umfdXYVIPERMmN1ktACgEWAP7ynk5?=
 =?us-ascii?Q?brbzDQ83U9lbCFaZZu3RVHiN1bk1rmKQwvxOAk6+nC2jKRU49dhzzU7Adutz?=
 =?us-ascii?Q?FumSbalVa7dEwF2fB2wuCfu/5pg2L496G9fH8xmNnaOHtXeg4TEnLPpIC4J5?=
 =?us-ascii?Q?EunT5EFgfaBpQ4B8YhTOhKAdT+627i1doZV4lSOiw9E9uLfUHik3lj7CjzPK?=
 =?us-ascii?Q?xWZRb1NgF3HjHj6ZfvnajE+9te5fRwUhBcMoIEjMbXK6p8Vx/Lf1dsyxSeNB?=
 =?us-ascii?Q?UM+2t22Vlt8Os780tb+2EByRkx+sOBxNsWUkyY5MEpmyfmfvSGPZeRYvUuYL?=
 =?us-ascii?Q?bVf42p9YUNwHLW/R/vYU9MKB197XGsMqcbPUiyHMnmILePBsetK4FPREPyLC?=
 =?us-ascii?Q?VfdBjlzzdpCGUib+peXIaIGOtIYLM/pXebNpUtjuknbDhnPC1/Pdz9DE9nqE?=
 =?us-ascii?Q?WIGv/GeuPdZF0U/xexe1C8PE/DBk5D/NTvgp/rxtjZohqD/7WoxMho2DWSSD?=
 =?us-ascii?Q?Gf0/KMmdy0LoMtvziJ4SY1TBUtvK5COY8j+Rx1ywZ2gzwHzaqhuSc/6v5mPs?=
 =?us-ascii?Q?pSzRIi+adQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 559140f5-de26-444f-6733-08da4860f6ea
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 08:37:32.4213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iR5hvgM9WsaNdubcUJIWb4mcZcFAjHA9Vo7b3ZUD2AvuS3D8kTcPaYtOMRxjPPQFW3BuInoiJE7WDtzZQS6zpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5543
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

filemap_fault() calls do_sync_mmap_readahead() to read pages when no
page is found in the page cache. However do_sync_mmap_readahead() will
not actually read any pages if VM_RAND_READ is specified or if there
have been a lot of page cache misses.

This means filemap_fault() will see a folio that is not up-to-date which
is treated as an IO error. The IO error handling path happens to make
VM_RAND_READ work as expected though because it retries reading the
page.

However it would be cleaner if this was handled in
do_sync_mmap_readahead() to match what is done for VM_HUGEPAGE. Also as
do_sync_mmap_readahead() adds the newly allocated folio to the pagecache
and unlocks it this clean-up also allows the FGP_FOR_MMAP flag to be
removed.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Suggested-by: Matthew Wilcox <willy@infradead.org>
---
 include/linux/pagemap.h |  7 +++---
 mm/filemap.c            | 47 +++++++++++++----------------------------
 2 files changed, 18 insertions(+), 36 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 993994cd943a..e0e0f5e7d4a0 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -505,10 +505,9 @@ pgoff_t page_cache_prev_miss(struct address_space *mapping,
 #define FGP_WRITE		0x00000008
 #define FGP_NOFS		0x00000010
 #define FGP_NOWAIT		0x00000020
-#define FGP_FOR_MMAP		0x00000040
-#define FGP_HEAD		0x00000080
-#define FGP_ENTRY		0x00000100
-#define FGP_STABLE		0x00000200
+#define FGP_HEAD		0x00000040
+#define FGP_ENTRY		0x00000080
+#define FGP_STABLE		0x00000100
 
 struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 		int fgp_flags, gfp_t gfp);
diff --git a/mm/filemap.c b/mm/filemap.c
index 9a1eef6c5d35..15d7e0a0ad4b 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1922,9 +1922,6 @@ static void *mapping_get_entry(struct address_space *mapping, pgoff_t index)
  * * %FGP_CREAT - If no page is present then a new page is allocated using
  *   @gfp and added to the page cache and the VM's LRU list.
  *   The page is returned locked and with an increased refcount.
- * * %FGP_FOR_MMAP - The caller wants to do its own locking dance if the
- *   page is already in cache.  If the page was allocated, unlock it before
- *   returning so the caller can do the same dance.
  * * %FGP_WRITE - The page will be written to by the caller.
  * * %FGP_NOFS - __GFP_FS will get cleared in gfp.
  * * %FGP_NOWAIT - Don't get blocked by page lock.
@@ -1993,7 +1990,7 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 		if (!folio)
 			return NULL;
 
-		if (WARN_ON_ONCE(!(fgp_flags & (FGP_LOCK | FGP_FOR_MMAP))))
+		if (WARN_ON_ONCE(!(fgp_flags & FGP_LOCK)))
 			fgp_flags |= FGP_LOCK;
 
 		/* Init accessed so avoid atomic mark_page_accessed later */
@@ -2007,13 +2004,6 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 			if (err == -EEXIST)
 				goto repeat;
 		}
-
-		/*
-		 * filemap_add_folio locks the page, and for mmap
-		 * we expect an unlocked page.
-		 */
-		if (folio && (fgp_flags & FGP_FOR_MMAP))
-			folio_unlock(folio);
 	}
 
 	return folio;
@@ -3011,14 +3001,8 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 	}
 #endif
 
-	/* If we don't want any read-ahead, don't bother */
-	if (vmf->vma->vm_flags & VM_RAND_READ)
-		return fpin;
-	if (!ra->ra_pages)
-		return fpin;
-
+	fpin = maybe_unlock_mmap_for_io(vmf, fpin);
 	if (vmf->vma->vm_flags & VM_SEQ_READ) {
-		fpin = maybe_unlock_mmap_for_io(vmf, fpin);
 		page_cache_sync_ra(&ractl, ra->ra_pages);
 		return fpin;
 	}
@@ -3029,19 +3013,20 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 		WRITE_ONCE(ra->mmap_miss, ++mmap_miss);
 
 	/*
-	 * Do we miss much more than hit in this file? If so,
-	 * stop bothering with read-ahead. It will only hurt.
+	 * mmap read-around. If we don't want any read-ahead or if we miss more
+	 * than we hit don't bother with read-ahead and just read a single page.
 	 */
-	if (mmap_miss > MMAP_LOTSAMISS)
-		return fpin;
+	if ((vmf->vma->vm_flags & VM_RAND_READ) ||
+	    !ra->ra_pages || mmap_miss > MMAP_LOTSAMISS) {
+		ra->start = vmf->pgoff;
+		ra->size = 1;
+		ra->async_size = 0;
+	} else {
+		ra->start = max_t(long, 0, vmf->pgoff - ra->ra_pages / 2);
+		ra->size = ra->ra_pages;
+		ra->async_size = ra->ra_pages / 4;
+	}
 
-	/*
-	 * mmap read-around
-	 */
-	fpin = maybe_unlock_mmap_for_io(vmf, fpin);
-	ra->start = max_t(long, 0, vmf->pgoff - ra->ra_pages / 2);
-	ra->size = ra->ra_pages;
-	ra->async_size = ra->ra_pages / 4;
 	ractl._index = ra->start;
 	page_cache_ra_order(&ractl, ra, 0);
 	return fpin;
@@ -3145,9 +3130,7 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 			filemap_invalidate_lock_shared(mapping);
 			mapping_locked = true;
 		}
-		folio = __filemap_get_folio(mapping, index,
-					  FGP_CREAT|FGP_FOR_MMAP,
-					  vmf->gfp_mask);
+		folio = filemap_get_folio(mapping, index);
 		if (!folio) {
 			if (fpin)
 				goto out_retry;
-- 
2.35.1

