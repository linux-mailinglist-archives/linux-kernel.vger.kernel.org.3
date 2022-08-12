Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433FD590A2B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 04:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235890AbiHLCN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 22:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235268AbiHLCNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 22:13:23 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56ADA223E
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 19:13:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NlxUQuUHPTfAQXt87WeEuy8yiwlJ0K0szr+ekoCOg+clcVrRu1L2utbf4wjW8LLnx/F/L8nPDEuNFSHxmomktAgLwWWdOwWiB209y16PR32xMjXHju6qTHaD7hq0N1PZBGj4UPaQxln/7BBQvQymq6mWfnE9RdvXNF7hv2JjZki7mn6VHIeKh5KGZL/JLPYRoZRrNjMdqwr9ZGIlKQNLne+eXA73IX6i39Rcc7Uz1YcX0WZC8gWorpPlvjplOqfqb+QvGzGFUpMkQl0jCOw19gp1XxA6ydvdQmDcfswNfdNcEcE7QIE4yGHSfWyKLNiUK31p02SUTCzwHa1sH2vJ1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=76IQdPubhMWITmpzgq+05WjE3ITgDSyIf3LKiC1ibmU=;
 b=jBf60yD1+PuMLbyDNfAaZuGB/1Xg3HAA+8fghioEJqVBmO+2Pqg676oOTd6VAsC39JONZZ/uG2iejfN3Gck/wWocruz8MbNXglvYJ5Np/wyMopPipUr/HM+k0pXLzDW15aqqo0J2Beh1Bn3OF8ih52w4THwP01mS/LwUHEsUFHAqiFQKJ1bESNJxIHUULmzf0ZLB73M5akDmbbQk1SEjuTPiUV8/sAw+vn9qnW6Q0uqSqjGgfBKAtUjWSQgTI3PMfNK5KUYDYW6KM/4Ktg8WH/Xo95PqjKu55HggqZcqQGGIJF3aVIKVGJbfPhcQo79dx3qA1+FE1L3P0a9ryhRsgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=76IQdPubhMWITmpzgq+05WjE3ITgDSyIf3LKiC1ibmU=;
 b=RsuRrj4F1s0/uA3qA1+/nVfNxbuhlo/gKY826xlpuRIZ4STdy4+NsxJ39O5mqPYhj1w8VNaLpDSCGY9FRwEJi1n8RRVWSAfk/CByA6598ZpGodKOY+a/AGYtwYe19Ie7Goma4a+b57rHrMV20iSlHf0LoJDljsW1eUEZwutWIcJwVV/8EEH8hTXHlxUABxYWU4m6i+RXetV7FAvXSDLbMjxaN+PHP6uZwpkg+FpDFzcu8uO2LoOyCZP7/03S+TvC/Oqk9rXFsYn3i2rCvwlppVqQktTQIoN3KYgc9MeK0YT5JFutezV5A9ZYLNt16H1vmS6VHkG7La3P622usqw9mw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by PH0PR12MB7080.namprd12.prod.outlook.com (2603:10b6:510:21d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.22; Fri, 12 Aug
 2022 02:13:19 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7%5]) with mapi id 15.20.5504.025; Fri, 12 Aug 2022
 02:13:19 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
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
        Matthew Wilcox <willy@infradead.org>,
        Alistair Popple <apopple@nvidia.com>
Subject: [PATCH v4 1/2] mm/gup.c: Don't pass gup_flags to check_and_migrate_movable_pages()
Date:   Fri, 12 Aug 2022 12:13:08 +1000
Message-Id: <487960bf67c7273ff5606c76f73bb51271bc7b90.1660269441.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0072.prod.exchangelabs.com (2603:10b6:a03:94::49)
 To BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4efa3f19-3662-4f26-b234-08da7c08396b
X-MS-TrafficTypeDiagnostic: PH0PR12MB7080:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CJRm16v0BSlOmCIxdyJgKOfVGv/q7yd7F5TG2w0IDC6aNPEgJX9ewY+ajlY1lwacy3tMlKifxS7f4qRoqbmNejVV58Q/YCK4Baqyh0RYNyAOkPyg/zoJzCJRaqCIntxiyMjX0elsJxoPfW3PXnWUI4SDZNIoJ1kDWS7BzeLXEa6KAtnYjnXJHZnR7NW1ru7nWKDxwnJmO2hp6VN9kYXZZwWxj2nYH5W6JyQ+AYJ5tc5HSd0UAqa4gd7e0LuYLbo+kutA7+nQSNfDZ22BerQFdwT5O94zoMy0tbntscaOY8ZRU5r3bzDZHNWDPpsDCTl+Hh3gTXz7E5lgQeUb9iF+OR97MPw15prtTuro/gQJU7DAgDEoZdJ47B/uPfpt4aN0pj4BUDLNaUQZqzDBdgxa0B+E/eiqenW+0UOioukAC7w91zO3laFHGn0aG3QCxMeZOGEtTQem/qd9gCa8eVjXmveq738FfyDlXINy0HkrcCu+bLV3IzFjY3lxHp9ZwAMy62MTsW3CcCeGA9FCPnI0rPAQDTbevlLw1wmG7pmNOTXIQOXuqMSEt1EQJIGnY+V1rW5aNAIkigR75DbVfSlqpvZfYkgxs3kccbpfYIfY60Ro+NgTbYkfaST8xLq17NYNqCYbeEH+t4H6LzI2hDSOGMQAiD00g4G5ciTpScGrRPZ7LurYiIfQT9fup/cPJYHz2zKmA1r3EKNOoD0XzguiiN2imaqZFFP3/EGSR6DcdtlnfQVb4Pzdj34uyvQ+onBz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(366004)(136003)(39860400002)(376002)(186003)(86362001)(6666004)(107886003)(6512007)(26005)(38100700002)(6506007)(2906002)(36756003)(83380400001)(478600001)(6486002)(7416002)(66946007)(8936002)(66476007)(66556008)(316002)(4326008)(2616005)(8676002)(5660300002)(54906003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PfQnMyF3gt1v0ElSBgHDsz4BzqNtxcRRGVJYnfl6caaJpwqjwinmJyy1jZLF?=
 =?us-ascii?Q?o+zZ3m81FgN10Ljlvm5xUrwLq2j03fcz3wCUe9fcoaRg7Gtk+EGvZo0deBog?=
 =?us-ascii?Q?sMeqCVt3TBjd+eEGRrKcuMOGYdWrHuHfFT5uOiPdFRTbjgEyfxr1aS0VQa4O?=
 =?us-ascii?Q?HahypoCilSLyUpmi9lD//QzEPe5nsBlU1P++ILlfbBh04Q9l6GGHeRBWojS+?=
 =?us-ascii?Q?uknw+1vxdJfFkhDxf8/mnXaWw7n2rVx/igUFo+Vb6NbKMpZQYxTLmhGxBDP4?=
 =?us-ascii?Q?9vpzRM5ZgR5lQ0q6cOCqNAkmiT3UfbdcAf7iUEk7/t3VJMaCCdZ2I99TIgTw?=
 =?us-ascii?Q?t23Ue+EfSm8pQQBW8VbwPIOH8dX0w9VK9ijGsL6pzbPh3xfE22alOH1N4Xxu?=
 =?us-ascii?Q?Kd8Pd4cPeKUsYPLCMBiXO19nuU1XDDdOrTTWEstmX3knGpLEseQMTfZROPeU?=
 =?us-ascii?Q?cMCgA44j92JtQEmPMYIMvpKeFUKYrPngLlAAaB/sd/TTisYl3G6I48JkC0k1?=
 =?us-ascii?Q?ZNSG+FFDvR7gUZKhcfIrhJZo7so4niLyoIjTtKW76OAL89R5sIuMsv8ckJGE?=
 =?us-ascii?Q?t+MkmUWfMb+rsd/fvSozcjtrG4e5qT7HkNK1G8qbILCxholocce12f5QYh06?=
 =?us-ascii?Q?xVHWJVc5iLv5ICFXn3ChShETef9Ps5hA4C33bhqf+U1Q9YEIEm6RO6ntrc41?=
 =?us-ascii?Q?eZ3DqWBov//vD0uqMozx4LthEz+bNMpgRuNRdTSYim+B6SVpLlQcGuMSFBzJ?=
 =?us-ascii?Q?2kJnJg7nAIjx1k+65Gs+TETPgKEnHsUqP31nbF1cYFu9ssRgz78ru8rSIf5x?=
 =?us-ascii?Q?CGvhgXsbSMu923SclUQysaJTqA4mlub4hXmLdFCs4cpsc/Xl4UyZfg+XTG1s?=
 =?us-ascii?Q?sS4IjUpMt0B6RiGEImVpGO1MHXz/T1ZYachB/QDKk6HUrzMa5j0QO023sRzR?=
 =?us-ascii?Q?pxpSmcRcj3VWY+9eouDq5TzqQAUrOdtAUH4TZ9ZahQtC4ITzK81uM9YXxi1y?=
 =?us-ascii?Q?KILVLzxEbEJ7iMcGWe13GxoTuBsEokwbWn/fxKLi8pbZA0QFflEQHDvxpcxB?=
 =?us-ascii?Q?bnyxGSd8o0acB2jkNIFtO2gMIjpoVNxaYXhvpIdxeOvpOFJnREIb6V7UYXXy?=
 =?us-ascii?Q?z6j0feLyDtNP7ln8Kw8gBu20+/w8RJ6aTaao1Cj5YCObgVm3gYXf9xBrWUT0?=
 =?us-ascii?Q?7do4AM9KWpUZkPvBa7gZvkyJd/NnyJFfGmDgH8tBjrbBhIL13EQG3y9ly5da?=
 =?us-ascii?Q?BPuy0tLu2olb2nxVE7HEVf14kRdRad6lAMyDwbaFKnNC6DwGdZ2JF/FPfWv/?=
 =?us-ascii?Q?Z6+GZV7FZlROU1opZGHuld71xN8D5KDKgy36spumGQdcMTcprCMZoqj/i58x?=
 =?us-ascii?Q?paPjmz7UmYypu2chC6StApPj1mcsZilHM9hq8p8bVm1yNDnnhyf+9mC/xDjo?=
 =?us-ascii?Q?fF4xbzihHEDriaG3GyUpNTsqn1LBXG0aPUNJdko9v2eLfEnlrUc4aqLwDH1I?=
 =?us-ascii?Q?2mcfC/mohUWcWHLQ1F5FYQDQw40VdKGIQyPGwfODhrqYvkK+P48LkUOmp/gn?=
 =?us-ascii?Q?sSNhBvSeEC/5mmP6UCJidEG9nXQy6UnrNkRQo3uJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4efa3f19-3662-4f26-b234-08da7c08396b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 02:13:19.4100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tuPUU6JNl4d3asujeZPeCACiS/aXyHsNyzPMPKkGuDvohLIq7OHvAiYjtbbkhNfvhYODZLaJsXexS+sOlIdKWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7080
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gup_flags is passed to check_and_migrate_movable_pages() so that it can
call either put_page() or unpin_user_page() to drop the page reference.
However check_and_migrate_movable_pages() is only called for
FOLL_LONGTERM, which implies FOLL_PIN so there is no need to pass
gup_flags.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>

---

Changes for v3:

 - Move WARN_ON() out of loop
---
 mm/gup.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index c6d060d..a2baa8b 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1907,8 +1907,7 @@ struct page *get_dump_page(unsigned long addr)
  * Return negative error if migration fails.
  */
 static long check_and_migrate_movable_pages(unsigned long nr_pages,
-					    struct page **pages,
-					    unsigned int gup_flags)
+					    struct page **pages)
 {
 	unsigned long isolation_error_count = 0, i;
 	struct folio *prev_folio = NULL;
@@ -1941,10 +1940,8 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
 			 * Migration will fail if the page is pinned, so convert
 			 * the pin on the source page to a normal reference.
 			 */
-			if (gup_flags & FOLL_PIN) {
-				get_page(&folio->page);
-				unpin_user_page(&folio->page);
-			}
+			get_page(&folio->page);
+			unpin_user_page(&folio->page);
 
 			ret = migrate_device_coherent_page(&folio->page);
 			if (ret)
@@ -1998,10 +1995,7 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
 		if (!pages[i])
 			continue;
 
-		if (gup_flags & FOLL_PIN)
-			unpin_user_page(pages[i]);
-		else
-			put_page(pages[i]);
+		unpin_user_page(pages[i]);
 	}
 
 	if (!list_empty(&movable_page_list)) {
@@ -2023,8 +2017,7 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
 }
 #else
 static long check_and_migrate_movable_pages(unsigned long nr_pages,
-					    struct page **pages,
-					    unsigned int gup_flags)
+					    struct page **pages)
 {
 	return nr_pages;
 }
@@ -2047,13 +2040,17 @@ static long __gup_longterm_locked(struct mm_struct *mm,
 	if (!(gup_flags & FOLL_LONGTERM))
 		return __get_user_pages_locked(mm, start, nr_pages, pages, vmas,
 					       NULL, gup_flags);
+	/* check_and_migrate_movable_pages() assumes pages have been pinned. */
+	if (WARN_ON(!(gup_flags & FOLL_PIN)))
+		return -EINVAL;
 	flags = memalloc_pin_save();
 	do {
 		rc = __get_user_pages_locked(mm, start, nr_pages, pages, vmas,
 					     NULL, gup_flags);
 		if (rc <= 0)
 			break;
-		rc = check_and_migrate_movable_pages(rc, pages, gup_flags);
+
+		rc = check_and_migrate_movable_pages(rc, pages);
 	} while (!rc);
 	memalloc_pin_restore(flags);
 

base-commit: 360614c01f81f48a89d8b13f8fa69c3ae0a1f5c7
-- 
git-series 0.9.1
