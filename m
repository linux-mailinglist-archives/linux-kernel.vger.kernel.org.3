Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2180C58A5E4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 08:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236978AbiHEGaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 02:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbiHEGaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 02:30:13 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4010E31F
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 23:30:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FfnQKy4k91ro0c+WH9tDZkAWHbxXbqu/KMaz0T0v2eC5lsfjuKatDlPkr1fA0gySceeb7WmUsfu+BrfeVFJjlNNwWG3AlKVjIK4sZTmnuNyX8Wf/Q/qC3pez9QWFg0xzlrUi7leomBw0Euiw8IpaDSdbGvAQs6ZSpqTG90iXItIxTru2wd4JR56IamYSef5D3HxOWdHON/n4bg7TQsDjS3OXyQuXNshS51huH19u95fr+gHw6xnXzH9fNdC/7BqZj0cYvYIjSJyzz3M4gRpL8FzH5KEn3WQ0IS2R0YTxTpnTU7IBzvegsY1e+0Y9n3QQWLEZVV9qzqdl/W5Aq23B0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y9YP5CB/KLf/ZQSCWaYUwoTyOvoICu+A6z2ecRVYt2E=;
 b=UDOGNt/3ke9IYnNw9vMvHTcerShlTLjUIzMU4W0XD+joPtsVGHR3+0JN3BQyXeWNvCNpcW5/yxuvmts2nD507Vm1NydmVASe8qkBAPabxBxwMWeueWWnOhfXxPqTFyfMOClcBtSB17DcKNB6N6SPLVAWlTCC0gAOxaq03l43jNcZZAG4FNjQm040biFAWbKMdttaoq7xVekQKzlPS50McTOieGrFyhjlwmiuMdR2CB75zD3FOxTbW2To8LIBv6xP/2F+ZcrmvtEyDD+9pKpLb1M3OWRgdqSzg+RjcpNGctCmqkRMy+hzCKiPV8n2WiBNba6gbCHi7LAoDudzHmGy8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y9YP5CB/KLf/ZQSCWaYUwoTyOvoICu+A6z2ecRVYt2E=;
 b=JUY2ZQ64MEu56l240LyVmWinhpi8EpEhVNBr69lXRjaV93GgP10RVyU9wVxfLXtdp2WFU7MDhR9AT9qi/i8Ob4LwKHk8mF4X/P2EblyZI1jrJCC30eSAKzlvHVVbP/ihAJUAXLznlDtDXbankwSyjTRITMeBabancxUjly4egYCU15DFeceZ3Zn819PQMFy2NdPw0WefpE+W2bWM5rsg9IFBbE1bQdITrg+SBACW5inf1RcvmdjUcMhht9Oeyv6Tan9lxoJuYyACD7nVQoZIr3DhfxThNo1Cyg1bUox8IEyOzGimXpWZIE0ruOdrbMaSNHcYhZ6mEBXlObY4Ifi+Cg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3179.namprd12.prod.outlook.com (2603:10b6:5:183::18)
 by SA1PR12MB5613.namprd12.prod.outlook.com (2603:10b6:806:23e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Fri, 5 Aug
 2022 06:30:10 +0000
Received: from DM6PR12MB3179.namprd12.prod.outlook.com
 ([fe80::d0c7:5814:170e:b016]) by DM6PR12MB3179.namprd12.prod.outlook.com
 ([fe80::d0c7:5814:170e:b016%4]) with mapi id 15.20.5504.015; Fri, 5 Aug 2022
 06:30:09 +0000
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
Subject: [PATCH v2 1/2] mm/gup.c: Don't pass gup_flags to check_and_migrate_movable_pages()
Date:   Fri,  5 Aug 2022 16:29:52 +1000
Message-Id: <3e20a542e756bbc0f66435c9344ff674f3ff7ac7.1659680600.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0271.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::6) To DM6PR12MB3179.namprd12.prod.outlook.com
 (2603:10b6:5:183::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81594e28-aa32-4358-4016-08da76abf1e5
X-MS-TrafficTypeDiagnostic: SA1PR12MB5613:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ESspMRI40DlnbJVzB2kC0Cu4QoYLbPLylcf+Yv6SmPuwK864blvOMqH6fOk2m+Vjp5otcsUQtafu7j+x7xGJzhk9+vQAjMn85Ma+V3QnLGig6++3ioTdjaB4Xiq8TNrT7tLJsOgWYICmdAuToFSlfODY8rJZTcKprdmRMmXIU1vPzF1YBevQOwBCAq6ZZ2jF0T3++Z2tf7od3dYituN+gFpV3xcS/iyvzN/NRNdpl5GTLXPVD/apmrA6HTMqb+2V9uMxKbKV3WTCGAxCUzScLZ2GBjmwo8Ja9eUjUncIJeUcSllsNl2KkWiljz+/Qy5PCzf+n+HNJPIKlAL36hxsXni5qWvyZQtiAl7whAoXdZpNF81bDaADysaCg0SZJE9hXobJIFlxh8scekl0MH3RHykEWkw6ldgA83P45aRve1W0MvEijDrLFrSIYWvqrWNGMK1HADRMEE+3BeRwuu+cCp4KZxToVbcEoELqvrIDMIq9gdBG6N4YEyVUcBFO8T06cstTX1DIWuhJoY7qWAnrARrT8NyzYc3tMbj3bsIKB2ABC+7X6Ia5FU+kMLFpzU2S1cudQ73Hqrxd+HW7ItUnPzYhNCOJ4B2Nj/Jzfn+5zqA10kXU5AF1voJ6eaULevPOxgMe8F5H+FM1YpqVg18LbEgm0ZY0/3V3nrjJGtXtE4spWtnNN5cCyOMLJRPzA7SfedSQA2XTef/t/+YN4IrJnox+ROzi4RtTinnbEglWrot9UsCPIFs1nw+kGgLyZA5L
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(366004)(396003)(136003)(346002)(83380400001)(38100700002)(2906002)(54906003)(2616005)(26005)(6666004)(186003)(107886003)(6506007)(6512007)(86362001)(66946007)(4326008)(36756003)(8676002)(5660300002)(66476007)(66556008)(6916009)(8936002)(478600001)(6486002)(316002)(41300700001)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lgQXvoRdmwQ9fNak11bfMLx6DWvnD8repEz+BGmcNDRJzeLa1Dmyj9iwdUgZ?=
 =?us-ascii?Q?omJ0bjmC//w2eW3+h6AfiFD4DTba5/DY68+5d8LB/zhl/lygoOwogYa07m5u?=
 =?us-ascii?Q?N+pHZf11CGI8owg6DE0jViVDps9QoxgeFE9B7TNcRlb/o2pmiIIiBCdv+wvQ?=
 =?us-ascii?Q?aB/wd1GvsGkoZC+UgHcqPImjVLDykaUhKkO7c+P2nefIhO0Ts+/8bSwxsf+/?=
 =?us-ascii?Q?baL4e8QwQqf8aNwV0w+YHp9IEZDtSdOzGChK6ayjAlQ7dwG9yTxhS9W9fMHF?=
 =?us-ascii?Q?otUnMOae2GxxKNsZS8cCcxHh5K5KsDURhjslZkUc56rnE502XBPAOwCoHhTD?=
 =?us-ascii?Q?iC6MUUzvuk16Y2bb2s8TtcnXRaK6rceufwrFuKFe9cYzFgs+63BQLPEvvOM3?=
 =?us-ascii?Q?OqvX0lwWUCm7LSFp2KFGe++UPlTF/NPV/EA0asZHDXtxkxujDiS06GCmqcBg?=
 =?us-ascii?Q?NeBHDohzYYd6UNOE/QEp2WxwsoE9P6cFYuuIqjaSnxu7KT0FsNhi9V5tiFhi?=
 =?us-ascii?Q?dtZKHx/enLCe6t497f6APZ6frE1zFR+8Zv+QksF+l4IOFainbY33F5hoOZ2X?=
 =?us-ascii?Q?MgYSqYhEL1r3htUg+WjmV0mclBUUhpXiBRmD/Xc61QvC8te/CPxoOCQe2cJc?=
 =?us-ascii?Q?ojd7YgirrwPNSSmGcvtmKR01BtsX0kYpArnLfZaDYj4aUpkR2iHwEYQFu20h?=
 =?us-ascii?Q?2N1gktmQMqGPGbs6EO1zY5oK44ooKsehsyKFhg1UTowxIKAH1il+v1WdV0Lr?=
 =?us-ascii?Q?pmkN2i0vZW0mskiRgodtMlagT27cXUYbMp0uNKbBJYN/iVfwq//66qbAcEwW?=
 =?us-ascii?Q?Ol97weJbl4LqknWDWB55bgJNos7ZUuffwFCHr9extOR0nT6J7iJFgJJjRsLo?=
 =?us-ascii?Q?Dz9H5nbOCsPv+d+Zhx/N0RoiRhYLcw+VmfakUGWqui5pqsnfKEcMucfWyLnL?=
 =?us-ascii?Q?bFRmtkbqxExfAMWqbkzwN4e+oIuS2GXv1TfYTopegdGsRJLj/Lehsjy5Uaqy?=
 =?us-ascii?Q?mOs5hOVWJm6h8uN+ntZBWtzb8Qt7xmGiIhPsAB0cKpAikHk4D47mMvKLgMPu?=
 =?us-ascii?Q?RLjiq63N9pH+snjchfuuLH6LgZtata56b7FBleAhHjFNw4l7KVSuO7uexPsr?=
 =?us-ascii?Q?eyO5hV+nfoUlyKkp9K9UhscKenJ5UtuZA2hBBA2jB3kWjzTn4R29kBasVKNq?=
 =?us-ascii?Q?raK5rdfpaxB83xzhd3OqtqLrbosqshZD+7AM9theuA6AUszXOsaLEgHNEast?=
 =?us-ascii?Q?lq6Xb+DawjZv9NjJuWReLXtUSDeyDOdvZ59JjFYUVyjmdKH3UUB0qrrXffBU?=
 =?us-ascii?Q?rWlvWcpP2CKCFwxPApKke171m1O9n8V+Z+GVgWAhtNVL3ooAUPGG0+CzyEAS?=
 =?us-ascii?Q?0gExwXRogSPO0j6JuBWbLZgCi8nw0Ba32xDl5fmw6EoPVgEIqQ37+Se6R5pJ?=
 =?us-ascii?Q?65ppoyjZoHWFW7lU/23SSlBk9G9yqO9hu/JRxaQdW0aEJYByDoHehbmvIJS8?=
 =?us-ascii?Q?uminEJ2OfGbtvVwsNLfm6DQecLO2gBDMbeUXtPKM+sJ0HLvxFIVRmdF5ztKB?=
 =?us-ascii?Q?54Loj0RClh0pgPNATD1bI1GuqaPK++ckM6UjlJyC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81594e28-aa32-4358-4016-08da76abf1e5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 06:30:09.8039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CqpGJi+z0cuVNc7BGjyF1tBn9AUWV5gRbNttY3hoReRSyt+QgOgK4bJNMbacwVHHxGlJxxqruH7WKgTlSN6LNA==
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

gup_flags is passed to check_and_migrate_movable_pages() so that it can
call either put_page() or unpin_user_page() to drop the page reference.
However check_and_migrate_movable_pages() is only called for
FOLL_LONGTERM, which implies FOLL_PIN so there is no need to pass
gup_flags.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 mm/gup.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index c6d060d..e26ccc0 100644
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
@@ -2053,7 +2046,9 @@ static long __gup_longterm_locked(struct mm_struct *mm,
 					     NULL, gup_flags);
 		if (rc <= 0)
 			break;
-		rc = check_and_migrate_movable_pages(rc, pages, gup_flags);
+
+		WARN_ON_ONCE(!(gup_flags & FOLL_PIN));
+		rc = check_and_migrate_movable_pages(rc, pages);
 	} while (!rc);
 	memalloc_pin_restore(flags);
 

base-commit: 360614c01f81f48a89d8b13f8fa69c3ae0a1f5c7
-- 
git-series 0.9.1
