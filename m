Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C714953528B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 19:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238878AbiEZRdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 13:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237053AbiEZRdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 13:33:08 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A70934666
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 10:33:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d7tMJIPVIwIG9H2APebBYzCuAufO6yA4X9FuDN2gkyyxfroH+BOD/AiQyMmvt5CWZZZNo9QCPm0OqBzw9SMcDsoyDZ3o8m64z6pEoNin9garBOYZvPb+ozv5ddT6av1Ows+emMtLTZ3H+3qP4c422zHU7RHLfCFLbofltsFd5AZKzurvABnEhByK6L3WshlcbMGRQXdbp9Qs9Jmrz6rq+yTUMcPfiHRmihpLs8RZOnIE678Y866n1vTbCHUUdeJOkwgui97iOnupS5UU+kSgXih9jzZio9PaSiPlqCjNM+C2z34vivKmtwJnjy2vG+wS5/2lwF2zbN2gOWIRtrAgbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/iql55D4xhr9hyHCLoo+oDqUsALhs8bXrW7eAFkrps=;
 b=DJOstiwCZDjXn6FpiuEO2nbY0H8nl6WNMVrH+tah3zc0OgTYwcqRkS0JxUgZ0KhyS+UiGJIWwbcOw8F/Dk+kuBocYo443cf/zX9pppfnvSGAlNPxNGXOQvdGCF665oBzePDgJdUArmWoVK70b2XTjATtJ3Hzxyf6/zQZBBfnJNmxFi8V7txO4NFUImo2HEraUEc0krx5ETRhxwdsddyBJuYvq+WysVKwngXbRPZbFLvag54U/K4UpvRjk+Ffc1iWqo5+jNCOUxvgg6MAygtaOnvrTmAKADjcnlCCcB+CwT6fzGk6DXPIeUmnqwjqEVAalFKIUBrTNyqvdcI+zFYZMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/iql55D4xhr9hyHCLoo+oDqUsALhs8bXrW7eAFkrps=;
 b=guw/ZcsKaO4iYbF54cYPZfUnQVrkCJiXbnR4FKdBf1pXUs68yOo5v/W0aJdeFym0COqZl8t9peBjG4SCZNQEO87uwsZFTX+XZOvHqQJOlBsScgbBiKeG5LBqbUncrwbrLnMbJAxCUC9xFXVVHptiHgQGxda0gkOarO1QvzdMlcPhl0KSRyT6Wm8WG2iDHaVN06eBWAvIgtWUam9PF7ltcZxKDptAAsTDtV+mv3IOtUTQAkI2hb0G1IHfSnnhABCBjwLoFb85Tixo2zdjPa6QJ63EhjpHCaZo107Kd6PmT8pP2vsKaI9atyj8VXPLgxCNJGrGgRAcW2hxWgxer0gCRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 CH2PR12MB3783.namprd12.prod.outlook.com (2603:10b6:610:2f::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.13; Thu, 26 May 2022 17:33:02 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f993:a9a1:3730:a7a5]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f993:a9a1:3730:a7a5%5]) with mapi id 15.20.5293.013; Thu, 26 May 2022
 17:33:01 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Qian Cai <quic_qiancai@quicinc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Eric Ren <renzhengeek@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] mm: fix a potential infinite loop in start_isolate_page_range().
Date:   Thu, 26 May 2022 13:32:59 -0400
X-Mailer: MailMate (1.14r5870)
Message-ID: <8C74B0BA-3C69-46EE-8C14-0CE6787D0B65@nvidia.com>
In-Reply-To: <9b31868d-cec2-121a-cd1c-008dd9880cca@samsung.com>
References: <20220524194756.1698351-1-zi.yan@sent.com>
 <CGME20220525214802eucas1p1edda2be0c03b9048c3712af8ad425345@eucas1p1.samsung.com>
 <9b31868d-cec2-121a-cd1c-008dd9880cca@samsung.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_8F52F682-D0E2-4D5E-B0D3-4E954486DE7A_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0196.namprd13.prod.outlook.com
 (2603:10b6:208:2be::21) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c48720dd-629b-40a8-79c9-08da3f3dc88b
X-MS-TrafficTypeDiagnostic: CH2PR12MB3783:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB3783306415CA0948893A98B5C2D99@CH2PR12MB3783.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0z4oO2cS+Srtmw0VNgz8r6oTOb9o0Lbx5dHD+HfzmtGcMwml4mXUJvFEPxjgmILnlEwe19jJukRlYdNfb7Zfg21aCFneRkzRVp31WodT71X8BWraSMiJkzRNYpqTvITx9YHZfXkjbZ8Tv5nh7remLEfeN77oDgXZRz+h8iksAolGNTIY7t7i6CIz4f07caLtYcYGxK0AZhele7XQAQetdJl/Lc7D2L1EDlwiWBUocdafotrZgtmrpwTui+sKjlH+nIjOJov5y+rKluiMV9XKNHVrU3eAOUZULRM3lMiQBG9NXQneE3Uoh5DC2TNhPdKMNPRWeFnXYhoBrcK3J26WhfruoVTux6w8wIxtF1XVOkpBm1sVrVEkDO6pM6bxa4Ij3zfCOjxx6fOnbecZ0/LEqWNDpERSL/9gcm0zhsBBaeSWZC8kmhbCqVd/TwKl7C86Rn9eIE7sh9RScQjlDnIY/55IAKJaBsWmJJrKo7mjLr5xabmm2fpEhInijnv8CHZ87w22oXTNGbfEClA9e3FsNdSI2AJmhVF+wnLw1WbeahbvEHA5ZN0t/ytHdypVy5Fuul38n1lCb7GK/Oie/0NxbVjPPh1jBGm86XTJIXfGTqvVjZFlBsBHq7NbSz86XCroyBBBUI8dSt8aEUSkbjoDcqo6CSwd4e2XSQfeeXKxLRKGtG9nx6MQVGqblWix0ah7XBmy/HnBFaXyuJQxXEjBklSYI26UdR0n8XQoGMfUqqA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(53546011)(2906002)(6506007)(83380400001)(33656002)(21480400003)(6486002)(186003)(8936002)(7416002)(26005)(5660300002)(235185007)(508600001)(6512007)(2616005)(4326008)(38100700002)(316002)(54906003)(66476007)(66556008)(6916009)(66946007)(36756003)(8676002)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hHMNSGin9D3R8cAym6ImExs19HAyC2OJbAUmqjJde9aa5NkvgjJO1oBeEKVn?=
 =?us-ascii?Q?CAX4b6yqcpOs0hvn45iDo8fJwCsdcl9251SffqzISAps6Dc2eD08jDmeAIFA?=
 =?us-ascii?Q?2KyvraGPRvfvskiv/aBUGo1GRl7skHY85yR/qw8z9hysduyKuzFk0wnLUV0y?=
 =?us-ascii?Q?/jjP53TMDBySV51ztd9ltVWPU/gVtYS0YKthBACh5A6SDZAJR7OLHkv0WOYt?=
 =?us-ascii?Q?A9fQKWFF9SA6fqcsmwnbMLn9IAbs5VIB9pLKpPrzCzTOkQqFqKDVo7RLPwke?=
 =?us-ascii?Q?uOVyLgE3XqPAhO5Uw3mGlZlS3SdVot4Iip2HvYMi2JazRVLdBNY/tlqM8/po?=
 =?us-ascii?Q?619MVfxHMRB41gReyoIeP/cStmuniLDSX5oyGr8f5CE4kH25AcKTQh5YC4el?=
 =?us-ascii?Q?VE30gkVrmq07nBbExk8xv1qvHGo2BUOqwaUucI9pRbo61dQd4tXSm2zLtPRy?=
 =?us-ascii?Q?4aFPg+Ge0l4KfWTRQ4pRpkzzRyptJiqAgX0l8mWyqOhmucs/0j+O2TdpdcTu?=
 =?us-ascii?Q?fV0EKGxYhDIdsJ+ojcaBNduZIbT8o2oNluRj2ML8zVWMPWgsdFAP9Wz6vy/I?=
 =?us-ascii?Q?l0QUVV3mtwQDqFUgQsvdAo11uQt1YpXfiuA2eAkGgKwAARPjplfQ+N0XSQFR?=
 =?us-ascii?Q?bpTjmMWFV95qb75JjOeICwbBgOiyxMuMf3S33/g0Ov+XC1IU9VUFRhSvSrIY?=
 =?us-ascii?Q?QwiJmdXB69QjniWwUmj8nUJpuqyit3U7n7ttpuBlZBHNJNr2+aPreBeJwnqs?=
 =?us-ascii?Q?4hal5784IgEtAxqgzdKhZY6zIppy3i/RGQuKTLBB3wlDPoFM044q0NaJ8i6G?=
 =?us-ascii?Q?18Bxc/QfHOwf906yh1NFZcy0KxMmJU7k3dwGbsp91j0Xu4bemqMiMg0NPQh+?=
 =?us-ascii?Q?SnTptK7b47cdsDbjwVkZYcQWCpMdTL3FrDeoBa/29ZUpgY2QhE5dzezQ2u96?=
 =?us-ascii?Q?x+FDhJkH8VkN4+rodFKYiutIqp6U+E/9o/OiiI/yCd3RgrKetAnDH1VhvzcJ?=
 =?us-ascii?Q?oQlx9tvOvYERUDqsmGCDoVco9uMUq2AGycyt5XokI0Vbsacg8krGlIENlqjd?=
 =?us-ascii?Q?GlHa6YXAX1Hgw9M+biokT5GxmIf0AhQg6haBj6LgJi38vNaKEoENYnBdfh0o?=
 =?us-ascii?Q?w+uC2nGx+idRRm5ZwtGMJ5bYlMP4fzK2n3oB8qWO0dwaQMmunnuOzc/O/Qsy?=
 =?us-ascii?Q?fSun84LIJK3ANXh9G281evlhX23sAbfsy8M8+PFXhfwvH+GxnUV+Sjo2GxJY?=
 =?us-ascii?Q?j6WrxKuhdUYGro6NYIk7r+r+tKy9swvUtvF7ydzCOPISoeKAlxguku07H820?=
 =?us-ascii?Q?5XLTvjx1iyUvTVg9tzmOwmzI22i1BZAKYMlfO6qzeyfuT9EzR0JFDL14Y/y3?=
 =?us-ascii?Q?FzAk7ui2sIN/Ii/nJscYwd+8FHQeMSWKiqbHUOXlhLdRcXDOlo8LPMQpgX95?=
 =?us-ascii?Q?vKmupUVmohFQZOXsRCdYIcmxrMjz5Fj1drjur07+lLCOp4rZjMRYuluzlAli?=
 =?us-ascii?Q?u+XYKu72jL9IuugBlMswmg/rb5DfM2d3oIwjys9oQO9jkoLmAbiAFLrtJhys?=
 =?us-ascii?Q?SN1raQUd8xMmcYvWeL+o22ONP8z+BdI1vNNK+BcSW55p812YM+xx+/F2VWBK?=
 =?us-ascii?Q?7MVu31ukRMTnaAhwzFtd6ybZ40z3qp/ce8sHGdjOiiH62g9Ehjah80f2l/oH?=
 =?us-ascii?Q?wcOyxHJIVm1Z3dH0KqnL9cUcWYxbYd8jBh9Sw2r4OulYeqhGIfAMH3Lc7YMh?=
 =?us-ascii?Q?Q9XkRjkLTw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c48720dd-629b-40a8-79c9-08da3f3dc88b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2022 17:33:01.7422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zrqgCIPMPdhbLyzyMRngi+FF99yOrjDY2B2pJ7yb7zg7zWGKuaPbfpY9ep+7e9xA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3783
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_8F52F682-D0E2-4D5E-B0D3-4E954486DE7A_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 25 May 2022, at 17:48, Marek Szyprowski wrote:

> On 24.05.2022 21:47, Zi Yan wrote:
>> From: Zi Yan <ziy@nvidia.com>
>>
>> In isolate_single_pageblock() called by start_isolate_page_range(),
>> there are some pageblock isolation issues causing a potential
>> infinite loop when isolating a page range. This is reported by Qian Ca=
i.
>>
>> 1. the pageblock was isolated by just changing pageblock migratetype
>>     without checking unmovable pages. Calling set_migratetype_isolate(=
) to
>>     isolate pageblock properly.
>> 2. an off-by-one error caused migrating pages unnecessarily, since the=
 page
>>     is not crossing pageblock boundary.
>> 3. migrating a compound page across pageblock boundary then splitting =
the
>>     free page later has a small race window that the free page might b=
e
>>     allocated again, so that the code will try again, causing an poten=
tial
>>     infinite loop. Temporarily set the to-be-migrated page's pageblock=
 to
>>     MIGRATE_ISOLATE to prevent that and bail out early if no free page=
 is
>>     found after page migration.
>>
>> An additional fix to split_free_page() aims to avoid crashing in
>> __free_one_page(). When the free page is split at the specified
>> split_pfn_offset, free_page_order should check both the first bit of
>> free_page_pfn and the last bit of split_pfn_offset and use the smaller=
 one.
>> For example, if free_page_pfn=3D0x10000, split_pfn_offset=3D0xc000,
>> free_page_order should first be 0x8000 then 0x4000, instead of 0x4000 =
then
>> 0x8000, which the original algorithm did.
>>
>> Fixes: b2c9e2fbba ("mm: make alloc_contig_range work at pageblock gran=
ularity")
>> Reported-by: Qian Cai <quic_qiancai@quicinc.com>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>
> This patch landed in linux next-20220525 as commit 29a8af92b874 ("mm:
> fix a potential infinite loop in start_isolate_page_range()").
> Unfortunately it breaks all CMA allocations done by the DMA-mapping
> framework. I've observed this on ARM 32bit and 64bit. In the logs I onl=
y
> see messages like:
>
> cma: cma_alloc: linux,cma: alloc failed, req-size: 128 pages, ret: -16
>
> I will try to analyze it a bit more tomorrow, but it looks that
> isolation always fails.
>

Hi Marek,

Thanks for reporting the issue.

Can you try the patch below to see if it fixes the issue?

Basically, the bug introduced by this commit is that it does not consider=

the situation when a smaller than pageblock range is to be isolated,
the set_migratetype_isolate() in the second isolate_single_pageblock()
called by start_isolate_page_range() returns with a failure. Skipping iso=
lating
the pageblock which has been isolated by the first isolate_single_pageblo=
ck()
solves the issue.

The patch below also includes the fix for the free memory accounting issu=
e.

diff --git a/mm/internal.h b/mm/internal.h
index 64e61b032dac..c0f8fbe0445b 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -374,8 +374,8 @@ extern void *memmap_alloc(phys_addr_t size, phys_addr=
_t align,
 			  phys_addr_t min_addr,
 			  int nid, bool exact_nid);

-void split_free_page(struct page *free_page,
-				int order, unsigned long split_pfn_offset);
+int split_free_page(struct page *free_page,
+			unsigned int order, unsigned long split_pfn_offset);

 #if defined CONFIG_COMPACTION || defined CONFIG_CMA

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index bc93a82e51e6..6f6e4649ac21 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1100,30 +1100,44 @@ static inline void __free_one_page(struct page *p=
age,
  * @order:		the order of the page
  * @split_pfn_offset:	split offset within the page
  *
+ * Return -ENOENT if the free page is changed, otherwise 0
+ *
  * It is used when the free page crosses two pageblocks with different m=
igratetypes
  * at split_pfn_offset within the page. The split free page will be put =
into
  * separate migratetype lists afterwards. Otherwise, the function achiev=
es
  * nothing.
  */
-void split_free_page(struct page *free_page,
-				int order, unsigned long split_pfn_offset)
+int split_free_page(struct page *free_page,
+			unsigned int order, unsigned long split_pfn_offset)
 {
 	struct zone *zone =3D page_zone(free_page);
 	unsigned long free_page_pfn =3D page_to_pfn(free_page);
 	unsigned long pfn;
 	unsigned long flags;
 	int free_page_order;
+	int mt;
+	int ret =3D 0;

 	if (split_pfn_offset =3D=3D 0)
-		return;
+		return ret;

 	spin_lock_irqsave(&zone->lock, flags);
+
+	if (!PageBuddy(free_page) || buddy_order(free_page) !=3D order) {
+		ret =3D -ENOENT;
+		goto out;
+	}
+
+	mt =3D get_pageblock_migratetype(free_page);
+	if (likely(!is_migrate_isolate(mt)))
+		__mod_zone_freepage_state(zone, -(1UL << order), mt);
+
 	del_page_from_free_list(free_page, zone, order);
 	for (pfn =3D free_page_pfn;
 	     pfn < free_page_pfn + (1UL << order);) {
 		int mt =3D get_pfnblock_migratetype(pfn_to_page(pfn), pfn);

-		free_page_order =3D min_t(int,
+		free_page_order =3D min_t(unsigned int,
 					pfn ? __ffs(pfn) : order,
 					__fls(split_pfn_offset));
 		__free_one_page(pfn_to_page(pfn), pfn, zone, free_page_order,
@@ -1134,7 +1148,9 @@ void split_free_page(struct page *free_page,
 		if (split_pfn_offset =3D=3D 0)
 			split_pfn_offset =3D (1UL << order) - (pfn - free_page_pfn);
 	}
+out:
 	spin_unlock_irqrestore(&zone->lock, flags);
+	return ret;
 }
 /*
  * A bad page could be due to a number of fields. Instead of multiple br=
anches,
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index c643c8420809..f539ccf7fb44 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -300,7 +300,7 @@ __first_valid_page(unsigned long pfn, unsigned long n=
r_pages)
  * the in-use page then splitting the free page.
  */
 static int isolate_single_pageblock(unsigned long boundary_pfn, int flag=
s,
-			gfp_t gfp_flags, bool isolate_before)
+			gfp_t gfp_flags, bool isolate_before, bool skip_isolation)
 {
 	unsigned char saved_mt;
 	unsigned long start_pfn;
@@ -327,11 +327,16 @@ static int isolate_single_pageblock(unsigned long b=
oundary_pfn, int flags,
 				      zone->zone_start_pfn);

 	saved_mt =3D get_pageblock_migratetype(pfn_to_page(isolate_pageblock));=

-	ret =3D set_migratetype_isolate(pfn_to_page(isolate_pageblock), saved_m=
t, flags,
-			isolate_pageblock, isolate_pageblock + pageblock_nr_pages);

-	if (ret)
-		return ret;
+	if (skip_isolation)
+		VM_BUG_ON(!is_migrate_isolate(saved_mt));
+	else {
+		ret =3D set_migratetype_isolate(pfn_to_page(isolate_pageblock), saved_=
mt, flags,
+				isolate_pageblock, isolate_pageblock + pageblock_nr_pages);
+
+		if (ret)
+			return ret;
+	}

 	/*
 	 * Bail out early when the to-be-isolated pageblock does not form
@@ -367,8 +372,11 @@ static int isolate_single_pageblock(unsigned long bo=
undary_pfn, int flags,
 			int order =3D buddy_order(page);

 			if (pfn + (1UL << order) > boundary_pfn)
-				split_free_page(page, order, boundary_pfn - pfn);
-			pfn +=3D (1UL << order);
+				/* free page changed before split, check it again */
+				if (split_free_page(page, order, boundary_pfn - pfn))
+				    continue;
+
+			pfn +=3D 1UL << order;
 			continue;
 		}
 		/*
@@ -463,7 +471,8 @@ static int isolate_single_pageblock(unsigned long bou=
ndary_pfn, int flags,
 	return 0;
 failed:
 	/* restore the original migratetype */
-	unset_migratetype_isolate(pfn_to_page(isolate_pageblock), saved_mt);
+	if (!skip_isolation)
+		unset_migratetype_isolate(pfn_to_page(isolate_pageblock), saved_mt);
 	return -EBUSY;
 }

@@ -522,14 +531,18 @@ int start_isolate_page_range(unsigned long start_pf=
n, unsigned long end_pfn,
 	unsigned long isolate_start =3D ALIGN_DOWN(start_pfn, pageblock_nr_page=
s);
 	unsigned long isolate_end =3D ALIGN(end_pfn, pageblock_nr_pages);
 	int ret;
+	bool skip_isolation =3D false;

 	/* isolate [isolate_start, isolate_start + pageblock_nr_pages) pagebloc=
k */
-	ret =3D isolate_single_pageblock(isolate_start, flags, gfp_flags, false=
);
+	ret =3D isolate_single_pageblock(isolate_start, flags, gfp_flags, false=
, skip_isolation);
 	if (ret)
 		return ret;

+	if (isolate_start =3D=3D isolate_end - pageblock_nr_pages)
+		skip_isolation =3D true;
+
 	/* isolate [isolate_end - pageblock_nr_pages, isolate_end) pageblock */=

-	ret =3D isolate_single_pageblock(isolate_end, flags, gfp_flags, true);
+	ret =3D isolate_single_pageblock(isolate_end, flags, gfp_flags, true, s=
kip_isolation);
 	if (ret) {
 		unset_migratetype_isolate(pfn_to_page(isolate_start), migratetype);
 		return ret;



--
Best Regards,
Yan, Zi

--=_MailMate_8F52F682-D0E2-4D5E-B0D3-4E954486DE7A_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmKPucsPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUCKQP/RLsuqOIAuQRfyB8xNb+lxJfb0NW1ueJ/q3s
wQRBj8d3/eAhMWksNFWBQmsUZ44b7RpfuCd82W7O413EdKoj5FHiuAB1C/m07SVc
v1EH1eYJR/qhqnCT/TJDLra8PLdShK1FbcvadpxEAbgm/FPiMsfJIPGZBbUI0JQV
XhjPne1PSpbMpSvj8oQj0z7JgLR/RY4xkqbaMizxjQzy5EFzURQv2wFvVqZGSMri
HCnzWIz7ksPdhWyM+EJfr1rynZ02/8MCe0lxERuldZi3dGzER+M8uDxcqlzmX1qf
UuMydNoYrV9k1rvzZWNbnJ7xnvoOPkeHmMgUt/0PED854frlHwNj0dL0EIxuG068
qmOQHa3eKKs12Ahz7dVrDMIpGZFI9V1C9o4VBflMG82srM6ylZud8lLJtk8Rt8BU
vf9PBWnVsjnnTG6BTD90+8wIUQdVzWxSnvY8KquXPDhm8u8khNQIhNW73CtmYCaU
0JYrtufcGVrWMq5187l0eeHkfqKDR354mW9bN7Q+ut1+L2CQz48d5JGTnx2XwFRb
mMRtD1JETKmlPFAcj98N69z70hdvesXvdwT6JKc1w0OOQ1fo5JWJhCvNVP3jSdBT
JKtSogeSm/a9QsJFbonGXblAhweSo5loFqwrmoJAgDnqZvdwKlMrFxXm6W+QrsWw
nTLD0a7M
=ZYQa
-----END PGP SIGNATURE-----

--=_MailMate_8F52F682-D0E2-4D5E-B0D3-4E954486DE7A_=--
