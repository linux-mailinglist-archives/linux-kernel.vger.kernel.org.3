Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226C95133DA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 14:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235459AbiD1Mm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 08:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234054AbiD1Mm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 08:42:26 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C17FAD121
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 05:39:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cccmPw9o9opOImTDo3RewN9gTgaqrYs/s95wqDZ7yPyMB7gE39zBVaSoCgbLWbXwLt9uedP3pWoBhUgOi3LMHW6KXgtM+kdVz4KUM1Yc/JgO4LOGwXqCNXIrZGumy1D/v8DclWpNYaRfAHFDZrgqrFNLTbv3JxeK56hRx3wQVFRshPLVeHSWA6EMp5vHYea/nyEvfCyjoygf/hHtqq/x5JtuHL9rHaZvYg11Owr17IdIm7ntOuNviNiMASFpBP9OfsZVI3lLwpTV/yutjAIEAIMzWzpRO/jOv5gRWqubvUDvRmxHC+A6xj/ZTTXLpfA+2foj+n5mEat5nf8uBK98RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0LP/xs/1N2fcd2ZejfdLl6/wHvFVXUE5zC3db6mRhgA=;
 b=FEx001VRGrmXNEXoYf9Igj81d7otj67gcYMpv/KpjIY+aszom6WLEJUZ60FkqmiObqC0ocmnSdjegBYSOYvIhYiMRYYBWk95SJ5MlbBiNMDfDenpxYs+5pnWjLdbR6qngmTMGkIQGi4wo1+EpQ6Jlgf8XONgArnDprJVuQKixRPPg00cmkreZMt33lROpP5yLdWR/S27Rg9DkwcdMZzmA4NhZHD26iV5KFcgvGYqSwFdlVTNVgCpI4xrfZHujiQItmxTJGm6Nue2p2nXtcarPQoyyJDjKOhAhIPnxXGrtGR6BjIz+YulmFLzRXyiFP+RI301Ms2Ie7fPDWsv8Lr4Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0LP/xs/1N2fcd2ZejfdLl6/wHvFVXUE5zC3db6mRhgA=;
 b=LgcugyXeWPpsRWK+y6tSS3EndIg5+cVHL2/qrlNt+Zn08pisnVuNO+huBkDFiZmfvXNwKtoniP1+omrx44M9YWYfyU1AfiWG+i5aessXvLy/qtrdOIBdfIERlf81Zvb9k+LO8BbGwqhAKLXqa9n3TTHSFnlk0GkLuX14kSZRplJ3u/Bxt32ilNV2/drwVNmduGfwWw+nv7CA9/f5+QIFD12t25gByyxkb9kXDAKkpZaF1ALa4NxFhpXzciv1stpuPAzE6DHd9DVxBKFGqlb25KqH8Yvnzq5CZVsek2ZnB5iyMNVb49GfzuEpxMbbvkWAehIXV9Mwc44032mxC1CF3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by MN2PR12MB3248.namprd12.prod.outlook.com (2603:10b6:208:a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Thu, 28 Apr
 2022 12:39:09 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::920:970d:6f94:1f10]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::920:970d:6f94:1f10%4]) with mapi id 15.20.5206.013; Thu, 28 Apr 2022
 12:39:09 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Eric Ren <renzhengeek@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v11 0/6] Use pageblock_order for cma and alloc_contig_range alignment.
Date:   Thu, 28 Apr 2022 08:39:06 -0400
X-Mailer: MailMate (1.14r5870)
Message-ID: <0E75B247-8150-48A3-83AE-56C586030006@nvidia.com>
In-Reply-To: <20220428123308.GA71@qian>
References: <20220425143118.2850746-1-zi.yan@sent.com>
 <20220426201855.GA1014@qian>
 <B621B4DD-5D11-4F0E-AFF5-F8684AE37E57@nvidia.com>
 <20220426210801.GA1038@qian>
 <2B9844C8-6D35-41E2-ACB2-9854E7A9C29F@nvidia.com> <20220427132720.GC71@qian>
 <1D88AE1B-4DFC-400F-A054-662E3824C9AF@nvidia.com>
 <A1956578-A851-4BF3-BD57-12571244DB5E@nvidia.com> <20220428123308.GA71@qian>
Content-Type: multipart/signed;
 boundary="=_MailMate_30E9D664-60AD-4F7D-96C9-F9D7BC323E5D_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0440.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::25) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2fd6fc4f-a32f-4c6d-7981-08da291416f7
X-MS-TrafficTypeDiagnostic: MN2PR12MB3248:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB32485892921252F517F529EBC2FD9@MN2PR12MB3248.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: htvw4DaefrwIqGCKVgy8r/S1ZThTCmNlfxkWg+c8LF5GzGIFSIkG5P0X3vInrGt5EhtUF30tCwnEeBFrlRd5/FyH6OWzYq+nT1O6uJ8mos7r6mC1E51iW4mBKKQ/yxJVSJr8EcBPpK7qqEFSDtfakt8bSXba5gBqv9+ngyvQTbMMCUjUHI70ZkGv5vnjPj+MvhpMVyMpq1iIh0XlcUSY1BI6syrMzMgd8vHpSJocni4MvuVqfQjb5MDGod46X4sOJrlHojyIICjfvcfIHEpC/AxjgMyzWF1O5VC9g7W5aTBJHPa4HJ7jVeFV5+J+OLOO44DUNE5UN57HN55gU+diA5Q0sJpce5Lnb+Uml0cafnY28iGqmiytT4StYAyj+Bmv+b8zi08hy+LnSGKUjVyDp4zyjameCdGVN+namC6kojGnNvbyzJ7jgb6x5vNp7jNQaTUSiP2kIl0NzUGMgjLo0w8SLgKU1dA6KkgaBu+tDiPnc3zATdiGpx3G9qP2dD8hQ+geWw9Xa6t4U4M2VKFb/+aQPmy05o4yiRJmSUNjbtT2en+b0406l8eaCedaXwJItC3kUpVIARSeULgrRXwg8yS3ZUJY7vYA8zpMlsuDbzdAG1JgHIPcmFg3PMEbGTltV9K4IoUq5Dtktg/Le53oe9ZeXNiMDtqllOjn0Av/DE+grpAG0EcU1Sh/qSh4wJHgd8g22s4M0CafUf0NHaI9PE9sxrdznuZx8HH1lD4H6y4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(235185007)(8936002)(7416002)(8676002)(5660300002)(316002)(6916009)(36756003)(54906003)(6666004)(26005)(6486002)(53546011)(6512007)(508600001)(6506007)(66946007)(2906002)(66556008)(33656002)(66476007)(83380400001)(186003)(2616005)(86362001)(21480400003)(38100700002)(4326008)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EHhwETZP6rKRoZjS6FBxUF4hEhW+unpvGsnArmF25Fzoq/q2T5BksEGdePJr?=
 =?us-ascii?Q?klRyM8yAf/IyWSmarOQD70GQXa3dzBzAvfPM9xa6VweYOFJ/hTn9wUJQOivr?=
 =?us-ascii?Q?KXV5OAtMappJJ9Duwd7lijVFApSfXa1wr8KIM5N9XLMARN1UrS2WPtdUKYeX?=
 =?us-ascii?Q?3VZEVEpicOqg4wm7EX8IaozHeHO4LqIbG6CBOaTfPqp8rxPKBlKznqj/LDL7?=
 =?us-ascii?Q?07jN63m6UDHqCp65wB8CFcxKgm8NZm2xu9Zb+x2dnWLYU3qV5HOVjRLw3bXy?=
 =?us-ascii?Q?pRnFV2oty/DjBlKULdyoy1HXZa5h6eASvHlPQGDOyidhJdDYRo5FkDCgLk61?=
 =?us-ascii?Q?/H4DRrK2GCQtse3KKZJ3lfvpPCD0RE+qbEgZXqZgkJirUtAEqSuxnSvjPlqy?=
 =?us-ascii?Q?Q8Ip9ZFZtn4zcf2ZRfU2LjTaMrCFMZavdLx09hdH4+MVi2nJbuzArski7I8M?=
 =?us-ascii?Q?3RB7ItmzduIJdlKg1CyS75FwaV7n1nXCmF7uWteN4ed358XfTDjv6LebnQ1B?=
 =?us-ascii?Q?2tWwM/yJDGzqJ/ByxZpU57hWL+7X45Dbl9pERAfVt8uiMhhIUNeot/yYYmlP?=
 =?us-ascii?Q?kt9z+ZMQMbW59RgnDNhjQke7wg/P66YsfH0n/2VpNSFls4flkGRi8rY2mLwz?=
 =?us-ascii?Q?k0ovklS2mhRZwmkZcrqUwYlfB5xDD7dDeQKe91ZXVFdDBRv7Un8aJXMStyhs?=
 =?us-ascii?Q?GxQMA7odXMn+Y9Xdj3EWOtDt1FCUlo+ZQzpt37Ooj+LZ1owClbC+FhQnjav/?=
 =?us-ascii?Q?rFi6e7hc6eVkSaOm7u+KvLCTIidKXbvKdmfKettWrUWJnV8hRvNZcF46ZCZS?=
 =?us-ascii?Q?WUJ1fHD2K98SQD8i7pbrOuHB42PGmkrx+uITy2bWZ71VcMOUgvRjAobsycHs?=
 =?us-ascii?Q?30Ixg4FZ5MNFXw6v/i6bg7fgkQxQ2n75aogV1hY8gpwORtJ3HXDfLqnuZNSm?=
 =?us-ascii?Q?KC6Y3eUVDzgX8B3xq7f7AndIuvVgkrdSbfbT8jkyX1i1d6NPpS4fTgGT4BNz?=
 =?us-ascii?Q?EH/Iti7TWnTjOIKpXIsyVx2GQYG65yS5ltyB3yJZiEerI9t1dsVeHwlmqBJj?=
 =?us-ascii?Q?R3tAlRX7aTQoUMdBntlsckQnBjoAtGZSjAzgsiL9bl8n1Cb9SnYgMEoS8Tgz?=
 =?us-ascii?Q?512y452L/jhLSJ7fBqdUlYdVUgJwbar+iNApLE+H7uL7mnsKM629oA1HYWtz?=
 =?us-ascii?Q?bhuRknnMPpJzh+HLhIFfVg1qVfVHYepLSg1Q8e0XmTmqYmP6hDzYQnL6klPc?=
 =?us-ascii?Q?t2MofoZBomohlgZm5MKaLZCw0W4egRvj5/FD6Au4rUfdjnHJ7K9CefEPpGQ9?=
 =?us-ascii?Q?IDELrsZnzQbT2RgZbWB4rS9H0MJ232/jEeYNALxbmiGypjuflTYKQTWplr2Q?=
 =?us-ascii?Q?Ly5q9OYHAi0qhcOXngWDk73yh3Zu7XmKfTNYoZ2fL8QR63YS+AWOa0Q2IDGN?=
 =?us-ascii?Q?eFnVC1OAjamCJ4J4oI/g8GEeaWN6x1Ion+W/Uy7w6VIz8pkjXT1mDapp2rcA?=
 =?us-ascii?Q?2YwPKgIOaV2DjTWG4z0Fkd1du9zxZ5jxj6IBvC+BnBf7ePNlwAJWFDyEPC7d?=
 =?us-ascii?Q?8w7N3o3xVg9gAeBm2t9sWL2/MV56XTCApHMLH/TzTDD769bRD+pz0zsjuSYk?=
 =?us-ascii?Q?8nDq3vd/aC75rpXklj9beJ9L9N5vT1i0E44jowTUINNCZUACKxEXFczV2Jq7?=
 =?us-ascii?Q?lQQGYpMYHXi2N4nC6MB/QzEat28bHd1X8JZ402kqpND8FQRq2UCvzxnoqD6t?=
 =?us-ascii?Q?FYg3HwJAcw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fd6fc4f-a32f-4c6d-7981-08da291416f7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 12:39:08.9779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r5FEYm9Xl/3X3QBvSQ/wHQRcpzu1nwKB0tLXjIPLflNd7/CWv4zBYZMz9c+4UQx7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3248
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_30E9D664-60AD-4F7D-96C9-F9D7BC323E5D_=
Content-Type: multipart/mixed;
 boundary="=_MailMate_DD78CD5D-50B3-439A-913F-E07B640FBF7E_="


--=_MailMate_DD78CD5D-50B3-439A-913F-E07B640FBF7E_=
Content-Type: text/plain

On 28 Apr 2022, at 8:33, Qian Cai wrote:

> On Wed, Apr 27, 2022 at 05:04:39PM -0400, Zi Yan wrote:
>> Do you mind checking if the patch below fixes the issue? It works
>> for me.
>>
>> The original code was trying to migrate non-migratible compound pages
>> (high-order slab pages from my tests) during isolation and caused
>> an infinite loop. The patch avoids non-migratible pages.
>>
>> I will update my patch series once we confirm the patch fixes
>> the bug.
>
> I am not able to apply it on today's linux-next tree.
>
> $ patch -Np1 --dry-run < ../patch/migrate.patch
> checking file mm/page_isolation.c
> Hunk #1 FAILED at 367.
> 1 out of 1 hunk FAILED

How about the one attached? I can apply it to next-20220428. Let me know
if you are using a different branch. Thanks.


--
Best Regards,
Yan, Zi

--=_MailMate_DD78CD5D-50B3-439A-913F-E07B640FBF7E_=
Content-Disposition: attachment;
 filename="0001-fix-what-can-be-migrated-what-cannot.patch"
Content-ID: <C93C1789-0D2C-40F9-8246-E0FF5759344C@nvidia.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

=46rom 1567f4dbc287f6fe2fa6d4dc63fa1f9137692cff Mon Sep 17 00:00:00 2001
From: Zi Yan <ziy@nvidia.com>
Date: Wed, 27 Apr 2022 16:49:22 -0400
Subject: [PATCH] fix what can be migrated what cannot.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/page_isolation.c | 88 +++++++++++++++++++++++++--------------------
 1 file changed, 49 insertions(+), 39 deletions(-)

diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 75e454f5cf45..7968a1dd692a 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -367,58 +367,68 @@ static int isolate_single_pageblock(unsigned long b=
oundary_pfn, gfp_t gfp_flags,
 		}
 		/*
 		 * migrate compound pages then let the free page handling code
-		 * above do the rest. If migration is not enabled, just fail.
+		 * above do the rest. If migration is not possible, just fail.
 		 */
-		if (PageHuge(page) || PageTransCompound(page)) {
-#if defined CONFIG_COMPACTION || defined CONFIG_CMA
+		if (PageCompound(page)) {
 			unsigned long nr_pages =3D compound_nr(page);
-			int order =3D compound_order(page);
 			struct page *head =3D compound_head(page);
 			unsigned long head_pfn =3D page_to_pfn(head);
-			int ret;
-			struct compact_control cc =3D {
-				.nr_migratepages =3D 0,
-				.order =3D -1,
-				.zone =3D page_zone(pfn_to_page(head_pfn)),
-				.mode =3D MIGRATE_SYNC,
-				.ignore_skip_hint =3D true,
-				.no_set_skip_hint =3D true,
-				.gfp_mask =3D gfp_flags,
-				.alloc_contig =3D true,
-			};
-			INIT_LIST_HEAD(&cc.migratepages);
 =

 			if (head_pfn + nr_pages < boundary_pfn) {
-				pfn +=3D nr_pages;
+				pfn =3D head_pfn + nr_pages;
 				continue;
 			}
 =

-			ret =3D __alloc_contig_migrate_range(&cc, head_pfn,
-						head_pfn + nr_pages);
-
-			if (ret)
-				goto failed;
+#if defined CONFIG_MIGRATION
 			/*
-			 * reset pfn, let the free page handling code above
-			 * split the free page to the right migratetype list.
-			 *
-			 * head_pfn is not used here as a hugetlb page order
-			 * can be bigger than MAX_ORDER-1, but after it is
-			 * freed, the free page order is not. Use pfn within
-			 * the range to find the head of the free page and
-			 * reset order to 0 if a hugetlb page with
-			 * >MAX_ORDER-1 order is encountered.
+			 * hugetlb, lru compound (THP), and movable compound pages
+			 * can be migrated. Otherwise, fail the isolation.
 			 */
-			if (order > MAX_ORDER-1)
+			if (PageHuge(page) || PageLRU(page) || __PageMovable(page)) {
+				int order;
+				unsigned long outer_pfn;
+				int ret;
+				struct compact_control cc =3D {
+					.nr_migratepages =3D 0,
+					.order =3D -1,
+					.zone =3D page_zone(pfn_to_page(head_pfn)),
+					.mode =3D MIGRATE_SYNC,
+					.ignore_skip_hint =3D true,
+					.no_set_skip_hint =3D true,
+					.gfp_mask =3D gfp_flags,
+					.alloc_contig =3D true,
+				};
+				INIT_LIST_HEAD(&cc.migratepages);
+
+				ret =3D __alloc_contig_migrate_range(&cc, head_pfn,
+							head_pfn + nr_pages);
+
+				if (ret)
+					goto failed;
+				/*
+				 * reset pfn to the head of the free page, so
+				 * that the free page handling code above can split
+				 * the free page to the right migratetype list.
+				 *
+				 * head_pfn is not used here as a hugetlb page order
+				 * can be bigger than MAX_ORDER-1, but after it is
+				 * freed, the free page order is not. Use pfn within
+				 * the range to find the head of the free page.
+				 */
 				order =3D 0;
-			while (!PageBuddy(pfn_to_page(pfn))) {
-				order++;
-				pfn &=3D ~0UL << order;
-			}
-			continue;
-#else
-			goto failed;
+				outer_pfn =3D pfn;
+				while (!PageBuddy(pfn_to_page(outer_pfn))) {
+					if (++order >=3D MAX_ORDER) {
+						outer_pfn =3D pfn;
+						break;
+					}
+					outer_pfn &=3D ~0UL << order;
+				}
+				pfn =3D outer_pfn;
+				continue;
+			} else
 #endif
+				goto failed;
 		}
 =

 		pfn++;
-- =

2.35.1


--=_MailMate_DD78CD5D-50B3-439A-913F-E07B640FBF7E_=--

--=_MailMate_30E9D664-60AD-4F7D-96C9-F9D7BC323E5D_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmJqiuoPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUdi0P/33Ef8ksOZYk2z7uAdX/7ckWPHR0q9WG26cP
y7HTiblM4ddyLD6jhG6rnFmJ7XI4WCZi1cB3XMNz6aB1wGme/i4uRjPxUQqysneD
0brxTolfZKneb8IvHj3yRJb2QMZduCtGbKM7NMaLVCy41Nh7gnJekAH/awxe4Zap
VrBSwSOXtvk1An5FpOh8QH5gTJTJ4ot5rYGuAEcu8NXD/NQtbvgRYil+WD5y4A/o
M2cGjkVEKPRajk1qS3pjyUmZmNcEdFDZ8+6rLan2MylCvD5Gj0ImSvzLUQbsIhF7
yb8lSPWL4niLB8FdpYJ8CVvUcbUJ3idioZDBU6kNVyo2bolCkeyB5F6c68u08gU2
2p488iq2wRBdGyXnL5YfO3iupiJ6tGGJhmhPMIwxoKRIsIAiMMBVtKoDwkOfLm4t
LIzm2PXR52qQl089IqRkEBCiqktNqMt2LxPCeGet1YuAxTI0y4MQQaN1m5KmXrB3
SIhgq7AH5uWaI0Do0D0cL1D7wpZxt+H43DmEBnwyL7bIc4o/iL6v04ih2gDL4Tfq
vOnvy4q3pXwXireqnGFXkQXrhqkSYyVLfB94bVOHfO/lklsHT2KlVSiO3tNUrQTx
JrprFMzQjZQZU2wKLGMj0ELc5HXlg6OpbwGYO3WhYxet8Rfz521hN+iB+bAX7ovO
PJHV6URL
=MLaY
-----END PGP SIGNATURE-----

--=_MailMate_30E9D664-60AD-4F7D-96C9-F9D7BC323E5D_=--
