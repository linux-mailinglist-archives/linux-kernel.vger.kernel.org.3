Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A833459F2FC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 07:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234679AbiHXFK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 01:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234594AbiHXFKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 01:10:16 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE216457
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 22:10:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MGxzr7UvnTf0Dm5ORkeQzHpUUNQqKHCnzN2r6+JnyznhoWKJcpi0g8yME+ZyERvIZKYYfRRSaWezl0rBc/94OyAxAHpA0Ow9B/e+ViBaUQdrlysiObjIn26phjbKG9oQTKORwvPeHlTygDACzqwHCTcPehxWNI7nOKUc0Wly8OoebCJeLnoyjx/YE4UeBga4Q/TQBs1qjW0m+VU5krj5IsrDowXHRCbN6xdyKUHpQlK8zxlzBNLa+TCi43cLCniEem72YiKcxJcIQBJihSBdySMcOwgfWUdrxFa62GXXOU55XsVDNBeYf/xPIZdodxKJHfzuRATcJ07SL7DC/u0B1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jlPr1u1DasuJLNBQTAijt5mELyMjSf5RQaPl7+4dKkg=;
 b=NdilfWD16N93EI7spFWpdJ1ahJjuN7bCe/lQX2GQ5EOb2UH5uY2UWbwTQ8dCHLhrxFSE644b8RktzypXhB+rO27CEpaTljeZw6nL/VBTuZ1KVLvwgxRbBsFhP2S41QGrgnNjmLvjW5jGtgQNbJPalY0ko7FQIoSXfy0XzNhxD3i9fafPhT8ytbFkySqahnaQTlUfXz/DfEdtOXBbfZYXispTK1eGuXRpKDmDHgIOUPe1zwSdanaAvMa0IGFQXKRzgn6GLeSr/k0kWoohyKdlQryCsQzljrg83MtXNiyOl4C92oAxN86b5wMkIL4E2FVvapAiUoPQroMef+eFNYzxKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jlPr1u1DasuJLNBQTAijt5mELyMjSf5RQaPl7+4dKkg=;
 b=mMr/9VgYSv5OYCgD6m8ed/91sVJa21+zIg70f6aiKoMASJvqsffDUSbjv0pFqDHyxCAUV5MHAJDf4k008aFbTBv4qBU3WIlESKwabkmY58NMjFFs3cS9Xz0kMBqWbWQXnHCrom4sAkp98aVyeubhsSTE3lwkqYHJ+NVzNuKSSKUoB9VREm9maYzSS1+P4KN6U1Z7whws4iVauDo7C3MzcX27YWsM6ikgW59lKBxJQXOocGzVQb7TzmD0eTu0qit0MeDsUS2KluTTqc7x8+08e8idBMeIzsPUNFcdGZgRrm2gYD4H8gz6ut/jE1HgI9LPDcrwE0jodAkbGNdLdiajcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by BL0PR12MB4657.namprd12.prod.outlook.com (2603:10b6:207:1a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.19; Wed, 24 Aug
 2022 05:10:11 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::7432:2749:aa27:722c]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::7432:2749:aa27:722c%7]) with mapi id 15.20.5546.022; Wed, 24 Aug 2022
 05:10:11 +0000
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
        Alistair Popple <apopple@nvidia.com>,
        Shigeru Yoshida <syoshida@redhat.com>
Subject: [PATCH v6 1/2] mm/gup.c: Don't pass gup_flags to check_and_migrate_movable_pages()
Date:   Wed, 24 Aug 2022 15:09:51 +1000
Message-Id: <d611c65a9008ff55887307df457c6c2220ad6163.1661317396.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0033.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::46) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd80df3a-e3a6-453c-7ad3-08da858eebb4
X-MS-TrafficTypeDiagnostic: BL0PR12MB4657:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: InXdTtMigDQBz7rTTHz4ZkvpyKs7vZ7TwXiPokk1u4wPBsZh50OduY3xghV07LS7zF/cBo5lNnUyBnFxMtiAnWIDkcGhC0Hd26OBppd/QlngatAx1PBLFfL1ZFZa+uvpB1b3WG6/w9XaeksO4c5SgkwRK17hI3CTG731nOeXNjf/9fOqlXqMwn+LyM0elxagjwYmkX6U4XP10Bnen5/WeVwkLjYEvLryFXV3sNgyTJ88hV3uhW68k7r84/uzL9wxekwTGJ2lr8+dayCEIwc9/hx/rCBAIOG7+S7ZbbP7M+JbKQx+tusQU1sSWXO2/5G4tcm9eBDUiDDRoJzcVwnkirYGp5vC9ywV+ooL6raZY+23ufmhFAlJM3uocEuyS5g7xWlfO+O+SpkFfVWzsSwCLk+nr5b5YzlzQltjAASurdTbnT+IS7bmH9t4I022CUmm2LadgzfUmOIGnsR0MeXKa9O78A6yen8T7bhgAlFlGFXJvMJKW2zs3P+XXEHwDfuVhahZBFfHdeaSYitJodhWdnQ9T1TfnrhsWtiD8rx52Wf2cpa2LXjrR1t+hZBUPLdd9EqMdagHmIg3bRjV0JBo5InVAt4Z9IEmjXGLE7tRUndku/dH0rXJ0uB77oIOBV0iUcXzuFmQPbG36MwzDquAqPxmE/ePMy/mo+o0VSQhqIPZm9a1UHwZtrRPjAvI4LwcCqtARpDjoER50/RWwZIKgA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(2616005)(6506007)(6512007)(26005)(38100700002)(8676002)(7416002)(83380400001)(4326008)(5660300002)(186003)(66946007)(66556008)(8936002)(6486002)(6666004)(66476007)(41300700001)(2906002)(54906003)(86362001)(316002)(36756003)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fAFP7Cj+l+tVn+ICQNuOr2GuCqbqZgWEyDGXgKLoT/ngdCQdGsEZi3CnhEqg?=
 =?us-ascii?Q?HU2qPb62w4S5sw/j5wCfJ1M5aTCkCe0RrFLQi38YNqMvlsiOuY62FbMqPJL2?=
 =?us-ascii?Q?bsvT3qpAXpjDxXWYCGtZiDYJ3l5Vp5XQTzjizM0iW4D3IMrK7ztFnAtYDium?=
 =?us-ascii?Q?LI6g1+kBeFbzm77Svs4GVaeYey/62QUBNdfOLwet8MszBXfJ1zpClpTEZHq2?=
 =?us-ascii?Q?joXrX3ZvXlQphhcg2Z6cRp1AcmgXsmD71WcNpNWBWDI/8ld5XxVwmcQ2lX2v?=
 =?us-ascii?Q?QWsz6JAiB4lQVb2sW/yyi3/CCBnF55HiKqoCIlmNzCEgLXAk5qmGlbnNBzjm?=
 =?us-ascii?Q?KdmHM+SC4bpZPk3IeXBp79xYlaI6rD646uUGvjF2bHj8zwZ0WYAYzU0ObOS1?=
 =?us-ascii?Q?HWH7/unHfteHxQ18FTczol/2ERw+TjaJ4gQ6JvMFGil/vXDowArJZxFje6XT?=
 =?us-ascii?Q?sQhtiVDDL8H9QfArNGLo9x+EMSYSFD9/LcwuIIAAgh6/zBMZP10VYb86L1X8?=
 =?us-ascii?Q?V8JEXxlJs/G5kRhBHwT6IHKiqssM7iJwPvsT23OKyTITsEFzj/+ACApAPj1/?=
 =?us-ascii?Q?FYGFc+OL8soFqJacUCOkjDE+jaNa2TczPDnkmYZ+dBVfFDP84Wm02nwCP0VQ?=
 =?us-ascii?Q?Feq6FOyLT/sA8lNgETeIKCP+e+EyszLjhjpRiZXfgkCPJjRpD5r8Q0EROacU?=
 =?us-ascii?Q?C8w8VNHVfPg96HST4GQfp1EWbmwaZoE72unjl8wX+Ohh61EnBvYBNg8dZ7Qq?=
 =?us-ascii?Q?QZT1REGmRMai4hjq6u2ZrgzVlLdRoCxMzmLHa+NJpfsmlJEAAW2h5WvWa6H2?=
 =?us-ascii?Q?V84GHN/osCanclt113zjpF3D+hvHCyjHFoqEHFiIsY8nNym9D3zkq7P0n2pR?=
 =?us-ascii?Q?fSCHAjgImRPZSxh4kmQpNk93YgO4Jl1oIyWBfu49WINx7SttHfe5OoBe1K4R?=
 =?us-ascii?Q?7WiBPf6XZYWPArzwVahZz8ke8DkmksGwTftEqopi7LDcUAMfH/PPEjkHsODh?=
 =?us-ascii?Q?vJGecEjC2Qz/EaUAbKDqDmUHavSBNEy0H20USj93sINT4/GgZ4QfEDtHWT1S?=
 =?us-ascii?Q?b6o5jCX8nt7EF/KodEGstK+DfutTaI3musExwHj6WEGqTnh5IIdJE5WnVa1V?=
 =?us-ascii?Q?YOlRYn+/902mXrGwzt5Yug5Rd6q78ZDvq0I4CqUJHxJ1m3jGR/HFdusmEKPb?=
 =?us-ascii?Q?YXchXJHZe/lk2DdDLReMNpYXl2aUTszj+VYDsciVbmMYq92VwLfU1vxV7tIN?=
 =?us-ascii?Q?JbZF5gVq0BB9u7abBlS7gud7E/pVlN/KwvVGlZ74perAuY7djDcaMBuxeQvP?=
 =?us-ascii?Q?oOd0Br8GPqbKThRtN4t7NwMj7ccWFK7I9eh2KJApKN5880YUA80Dsb2tscV4?=
 =?us-ascii?Q?AE3ylkqCwFIBWWt7NTW95mJdudY7L10rTaTFJ3H9lVYbbe8Qqh7yJGCyW6H+?=
 =?us-ascii?Q?Ud5qA/6cZhwcP0msTHrZhC73/1cvK31VcYl9UqIVfN9WC+mh1qwDYP8yWsRu?=
 =?us-ascii?Q?av1J7wbT7hW3E+hGdmR9V4hg3NRnwDqGXj50oAnaLy0PlNhH/pUpgMmBDH7d?=
 =?us-ascii?Q?+fS3MsU1DtNsQlk7yqg4ex0CMsggbbNEAKdKyWsS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd80df3a-e3a6-453c-7ad3-08da858eebb4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 05:10:11.4076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tnho5wlvkvsbX0iYQxZNhNoxfnkwUlTojN7u/bzbTNoCigWVAmY7cLKb03uXb0Vaz6mfdHzWATwh/sWv0SaJjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4657
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

gup_flags is passed to check_and_migrate_movable_pages() so that it can
call either put_page() or unpin_user_page() to drop the page reference.
However check_and_migrate_movable_pages() is only called for
FOLL_LONGTERM, which implies FOLL_PIN so there is no need to pass
gup_flags.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>

---

Changes for v6:

 - Rebased onto mm-unstable

Changes for v3:

 - Move WARN_ON() out of loop
---
 mm/gup.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 3b656b7..8d66ee2 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1934,8 +1934,7 @@ struct page *get_dump_page(unsigned long addr)
  * migration failure.
  */
 static long check_and_migrate_movable_pages(unsigned long nr_pages,
-					    struct page **pages,
-					    unsigned int gup_flags)
+					    struct page **pages)
 {
 	unsigned long i;
 	struct folio *prev_folio = NULL;
@@ -1968,10 +1967,8 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
 			 * Migration will fail if the page is pinned, so convert
 			 * the pin on the source page to a normal reference.
 			 */
-			if (gup_flags & FOLL_PIN) {
-				get_page(&folio->page);
-				unpin_user_page(&folio->page);
-			}
+			get_page(&folio->page);
+			unpin_user_page(&folio->page);
 
 			if (migrate_device_coherent_page(&folio->page)) {
 				ret = -EBUSY;
@@ -2024,10 +2021,7 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
 		if (!pages[i])
 			continue;
 
-		if (gup_flags & FOLL_PIN)
-			unpin_user_page(pages[i]);
-		else
-			put_page(pages[i]);
+		unpin_user_page(pages[i]);
 	}
 
 	if (!list_empty(&movable_page_list)) {
@@ -2050,8 +2044,7 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
 }
 #else
 static long check_and_migrate_movable_pages(unsigned long nr_pages,
-					    struct page **pages,
-					    unsigned int gup_flags)
+					    struct page **pages)
 {
 	return 0;
 }
@@ -2074,6 +2067,9 @@ static long __gup_longterm_locked(struct mm_struct *mm,
 	if (!(gup_flags & FOLL_LONGTERM))
 		return __get_user_pages_locked(mm, start, nr_pages, pages, vmas,
 					       NULL, gup_flags);
+	/* check_and_migrate_movable_pages() assumes pages have been pinned. */
+	if (WARN_ON(!(gup_flags & FOLL_PIN)))
+		return -EINVAL;
 	flags = memalloc_pin_save();
 	do {
 		nr_pinned_pages = __get_user_pages_locked(mm, start, nr_pages,
@@ -2081,8 +2077,7 @@ static long __gup_longterm_locked(struct mm_struct *mm,
 							  gup_flags);
 		if (nr_pinned_pages <= 0)
 			break;
-		rc = check_and_migrate_movable_pages(nr_pinned_pages, pages,
-						     gup_flags);
+		rc = check_and_migrate_movable_pages(nr_pinned_pages, pages);
 	} while (rc == -EAGAIN);
 	memalloc_pin_restore(flags);
 

base-commit: d711de4adbec4cb0b8769bcae971b13293e6d311
-- 
git-series 0.9.1
