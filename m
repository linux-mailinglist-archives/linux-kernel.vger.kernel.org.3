Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDD858D148
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 02:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244655AbiHIAQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 20:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbiHIAQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 20:16:42 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1B95F6B
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 17:16:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DgvXOODnaodcXa7fSvK6i4qIKv52SeP5SSkQz940Hiu+c3GShsiCzwI8qRkDDobaVWddv8r23+nsqsERU5ulKC3Z876GrievNIQYyTwJ/0CK++FxOwrCoL1Nb6nRVU3DZ7oKS723A83kHgJBC3QkKGnidP86iBy097GPcvAq725JzCos2MCkZz2c84VewduCrhPUR08VRnHEkye69An6qwXFAQbEWzjC8WNxbdsCpgBCMov5qNo9D7hBXPkXb/iOWhHv+y4QfQVsooIQPHv0PG9R/LOSPPFuEjn53n+0kYh9Z0qkkiaILF9zTU3WwPwoNuPTyzZpQsjqcD9LJRgf+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=76IQdPubhMWITmpzgq+05WjE3ITgDSyIf3LKiC1ibmU=;
 b=GgkV0JfBBb0can474So5I22wprOdOVsiT6C6R2YPdSBEzCBpqx1XEezxtm0hBAxaTYUDlzNeqaqjFdPkN9aHQtArMN5PoNCxG1hApzki2wc5PEHwDmjrma9GL024lGiDkiSL7DsdvCPZgAwdIRP2HW398ybnyO+Vqbq7v//clkIyBxRO/ZwoKK1XjP78AzR5FDl52dpQv/7l0Gkhs+5Ol1gJl4rNWubv6w0ph58NO4qbl2EEhp2ctWayWyDKrIkjgwQDVhSaYcrMN8T9U1URy3f/eZeTFeaVFprGSSC/iV1Z+OwJCuB9Jwb6E9q84lFQ3cTdOAzXWJljP9f0LIirOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=76IQdPubhMWITmpzgq+05WjE3ITgDSyIf3LKiC1ibmU=;
 b=oddEz1HjgwUdfqBZNE3k8a18JfhEtqHBkltvPKMjq5H/Z88p5nn5Sbr9HR9+mN19PtFWLbs3X7WDQJgfkm3p1k7nptlX16j3VePDVp2NTvTrW15F4z0lnioMDwrnWEADh+Sp3HUBxFXnvHILeKa2Tj/ualv1jAb607D9HZsKCXhJmmWikyajjC4aXiBJSorOZNWy4ZGjj3EynTlvZcZ11kLeuA3ywia6/pSmhGVpIm+p+9hJe2inDUcIFF5mwnHx/XcAQ1G3/x2EvZtJcRtKsLlPoSV7g5y0T2qnQ6TJmCFYjw7Ix807HT+W0nnE1ZOVLlRJ/dRJf49J7UazdIx7KQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by DM6PR12MB2780.namprd12.prod.outlook.com (2603:10b6:5:4e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Tue, 9 Aug
 2022 00:16:40 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7%5]) with mapi id 15.20.5504.020; Tue, 9 Aug 2022
 00:16:39 +0000
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
Subject: [PATCH v3 1/2] mm/gup.c: Don't pass gup_flags to check_and_migrate_movable_pages()
Date:   Tue,  9 Aug 2022 10:16:25 +1000
Message-Id: <487960bf67c7273ff5606c76f73bb51271bc7b90.1660003800.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0062.namprd17.prod.outlook.com
 (2603:10b6:a03:167::39) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85ea4dc6-2e62-4e8b-f552-08da799c6e2a
X-MS-TrafficTypeDiagnostic: DM6PR12MB2780:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yoNGYEomSEFLCj6z3M3VSPXtJeyigpW03Fg+Wr9j0WdzBe7idkyd3qnkl/pWfHY0hwaScfFFzTU6xKNfRYDkATa2iarujgAjNQOUBlE33a1bOyYiQFn6ucarlaCB0Uvir0Bduesi8IpmnJkBrnhbbvmSLRjjABUICW+YYBDoA6+Y2py/M2cIWTYExN+LoeDhE7gZNxNQTm4Eh3TXjVEjuYIhcaMdLbqf+xj9X+jXKJuDw8ay1i2EhWQ3A4oyT3PjIsUhIf6RLrkwE2GYG1zlSLYVDEqSVlI1YaTgBUmcSHj8s7zgjfAJ+ryKQ4WTzqfSwr/eLCfI3GXc/VVH4sb+Pb9qcx51+y7DGlW83xk5l8tiFswR/exG/JNteNv/M9VI4pJCdJjrOBkTEMUPnPaQbyIZLSVXxeg+pEaWzq72EyC8YachWKK58Pmto0KNAYllYEYx+8m6VrZEgYMMyCT7GZoerkJmCVTuslxsumZIU/6v19nvBSvk8nMvC82uE3vz4Uv9oj/qua7lKoS+mxf27/oO7uSpLWjXhgsw5p51Z1KCC3Rk7cKOlhV5L6yunLQWIrQv57H1zZTYLEWsxnK7s3e1dkl/aCHW6RL/+BG7LBBqjmO95cCrALpRNyz+bf6iVYHKoXS7v51YMghunDaMlII8gyiR6hsk9yZbhrPuypzpo1tn0pDC90mr5XYABvMGhshRqsCjbStCl6jy2jtXT3IftTECmAShpIzKu+q5Iw7H3TERLzdZjBFDwV72gD31
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(136003)(346002)(366004)(376002)(38100700002)(478600001)(2616005)(86362001)(5660300002)(186003)(6486002)(8936002)(107886003)(8676002)(83380400001)(7416002)(54906003)(4326008)(66556008)(66476007)(6916009)(36756003)(66946007)(316002)(41300700001)(6666004)(2906002)(6506007)(26005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bGIAIN0/D7tpdQNLMZiqG2wW6RvuuG/f9f/lJVjZSWbiESI3r5eHYuKyTYXM?=
 =?us-ascii?Q?uSplSNiwIbnkOzXkwmRlo0uS2jBUI4tEj8eoyXLRLRydMfGerB+4JL/kQPJ3?=
 =?us-ascii?Q?0W49p7/ZWcZaLfPPuGRmR7wiXXFE4+YvpfPI2hRwEhB/5TJOkb6ruU2+lttW?=
 =?us-ascii?Q?e0GyYFsSPXoEOF7ZzxbJVQS7ATg4G8QEWk3FeAsveQBYiThfb4LNGGmqsHIH?=
 =?us-ascii?Q?9z/IeGVPNledKSs8kL0EgI+KXnStaUnDP8D7qmH0iit/93NaxJYtNdIkGaf7?=
 =?us-ascii?Q?kpRnqUWmalF5gBBWCerpbI2Jg5wAxJA4oVQDFE19Bblt1Fk4GSE0ND45QG3w?=
 =?us-ascii?Q?HwXUbxcqm3Gnw8QlWorpte1ILQwVQtLfR9F4wCx4zKt44lqrwgo/6+Pcu6Mf?=
 =?us-ascii?Q?ZKAugPiM7zVBJBb0EzCXvN4av5NPXKF9Fd+JyYiP1XDFBKxWTMh6P/J2qn1v?=
 =?us-ascii?Q?lVUNnSotyg4tq3E+tSrnAMrK7jw+F2lSyNCrh1mY9e8jXgWomVVuCuEBAopN?=
 =?us-ascii?Q?bCLl7Kp0yUAHEZNz2xg8Rx40cazgxMsLlDE/03kJC1NnyXoo/xqPt1jEtK1u?=
 =?us-ascii?Q?07UWlpcUgOk+11kPaXdyLUzcSeRDH55akiNqW3x2ScE6fDS/K/kftofx79bJ?=
 =?us-ascii?Q?aTJzw6/TWecJo9y20gDQEzzFNU7BqCV5Si0aAuZicasD7Cg/pLtbmrZl+xcS?=
 =?us-ascii?Q?SzWr5P+S2BE9vQV072CiSov4GfddFr0e/kXZEkSqElw9fHiGG74OsMRBOC3v?=
 =?us-ascii?Q?NT4UAHXgeHof1oeww2mFFdcMShweFDZmwJC8QgS1XfwboD+X+5EPZD+hAKds?=
 =?us-ascii?Q?fh+OX9t/uegQVVzYDCgACSKwmVqxXIELW5IAMIkQo5kTdcMarwaXMWLXfKwf?=
 =?us-ascii?Q?G5NUGXQTkeEUS5hej4LQneeidzN8alCA3LSKWo7kjkjmIeXAKxC8DEYNuysn?=
 =?us-ascii?Q?QYRHYMxsRC5wt493eW68o4Vp93dK2MjdFQLk9JHk5dHiGrXlaYRpTu30fe9M?=
 =?us-ascii?Q?Piz3ub12VuCcZBz62iBnQkMN+z6MIXBZ4KOSu//qgiG8LXnNbtCXVgzVrFqb?=
 =?us-ascii?Q?WkZcvlrr9vmyCuYapVnTJXcTJBweaZXupTuPC9wUafyk5DXgvfeBq111Ttf5?=
 =?us-ascii?Q?qw3JWTG5g9lDLzhT/ZuzCO/fh4cB8v8yqLy+BtBBmrCa8rL9nMKH0PqDUBRy?=
 =?us-ascii?Q?GDu/uGblOzPizAR3KdvXGApR8u2zmOH4TLuD9p9i6QpsOGs8QBX3+X90UqxU?=
 =?us-ascii?Q?u8y8G/aL42HtZD/68X68yHOEKtu9jPPOPhScqIMBph2qxZoENHAiHFvRefbZ?=
 =?us-ascii?Q?WsD8aPjCUOR7fPH972jtrhj1sqNDvh+w4RJC2GuYe9cusgxWxTVguQ80ZjWJ?=
 =?us-ascii?Q?6sLWhUVJgiaLN82LDZVsz3vjcn2aQwx5OZ7Ara/VHBGEuGMnKEbk7YalWNwS?=
 =?us-ascii?Q?Ld9t+kZuD0hjtbRauqSPT5rKT1LM45DX1vkHVSv0/VpBil9NdmJshIBdGrMt?=
 =?us-ascii?Q?CN8IQeEG4HXLofMQJGJfVe2oZlnfQ/EC+ZiLiTZ4z1aFjT8lXBeki1ty4XBL?=
 =?us-ascii?Q?Y9L5ZhoYWa79734NQaEg3vrzSOcKWcBwTcliMThE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85ea4dc6-2e62-4e8b-f552-08da799c6e2a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 00:16:39.8545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8GODe/kY+oMCCoETuiTTVob2rGNF6OJLz5CwTc1c6xzyYr5AK2eOfTgTAz4WfAYjScQyP1zMmhu6N1Vd23EN6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2780
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
