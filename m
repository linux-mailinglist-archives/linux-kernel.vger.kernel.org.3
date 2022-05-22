Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 824DE5304C1
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 18:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343889AbiEVQyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 12:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235505AbiEVQyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 12:54:12 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B154C3615B
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 09:54:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=liEXzh205Bsbif9XwdoJevhKt7p2S9SKZeoKx6OiuUSRIdkU7tOylYvgFciLDGYfxz1D7xVoZTu8nllRT1jVtWvGL4GJ+RIpqV4skGnysag8nxRfW/IetxSdkbBGCD1Eskwxu7FMjieJP2rFSQ5xs3Bz+nzUjz1NdKHIaaqx0JLpGf5bLohJEqgXbTLRekgFYTra5X09p15q9zstgrQZ9LZgtgN4fgrpZhPw0wUTKdg2ZF83sAzv0GeDqn1Nefe9Qv8ShdmlUQfkaytAlR/U0uO9q/OW6EHThdQBTsaodgHotm7dTG/Sd7kAxyHZL/KvrJZFmU4B7J+mZIY2OVUpGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A1VTET/VdR03sFu6Mo4iUxNd+A/OEdMrrHWbzgq/t/E=;
 b=dphBv+DAVhb7AQY8zn3syfpVPaYuP1sWtxSD4iniXffDNdyVxr11U786EJIYtMkjn/Y37E9qPTp5v9YeVz0sQU1w9mK3nKBRAKJTGC+xHy1s4nbWG1B3SMghXctYJL4llwTCPCzxm+/8o5HreElXbk0hiG+EM/OALKLUni6nR20JzqiocgdbuSob+1xooru2DutBnYCPQlvOl91hAoPlikMpA+ar+eqBKG+IxzkYkUF2tPAjrxH8XCNFVBpMl6eqewGgXLTyB6SWgptuydDtEPXsGefoex0hXMFleKcFEkdwdaDM1Bv8jkWEk58XqD/jz9+23/sS6wsPQkinCQGCvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A1VTET/VdR03sFu6Mo4iUxNd+A/OEdMrrHWbzgq/t/E=;
 b=AaBTFB2AVb3UhcKDzyCGqnoM+lxX7HkE5f5ygcsQ+w/TD+wruyF9xAj+bOPgxDrlIRDII1m6VbVa/gkzYnFHScs75YKQEw3Ria50/FEXJnbFFBXuhiWX7fsoKE0G9Vc+MMGWv7pTgvJBiKnfdFJzcwaHNt3qd+lqBpsOfABH9MgEMIURbq2BqQ5Lh7c+FeQ1rOnnxpjPNmkc43Qfcsk/QZF+RxcXRqSaqKxMWPAF1KjogawDPSxS0hErcy3sCvWUMhXVQ6nDYJMtOd/+nRTGsaM1k+VbkMRj30IKXouLJa58EyBNgKQ4kM7ybABJgPCw5OKC0VKdqfJUlAxxu27k2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 BN9PR12MB5211.namprd12.prod.outlook.com (2603:10b6:408:11c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Sun, 22 May
 2022 16:54:07 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::b406:bcb6:14d:c14a]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::b406:bcb6:14d:c14a%9]) with mapi id 15.20.5273.022; Sun, 22 May 2022
 16:54:07 +0000
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
Date:   Sun, 22 May 2022 12:54:04 -0400
X-Mailer: MailMate (1.14r5870)
Message-ID: <FB2C38FF-1AF3-4A8D-94C0-AE5014E5592E@nvidia.com>
In-Reply-To: <YognDJT8C/o1Mt+y@qian>
References: <A1956578-A851-4BF3-BD57-12571244DB5E@nvidia.com>
 <20220428123308.GA71@qian> <0E75B247-8150-48A3-83AE-56C586030006@nvidia.com>
 <YoavU/+NfQIzQiDF@qian> <F6598450-EFE0-4EA9-912B-A727DE1F8185@nvidia.com>
 <Yod71OhUa3VWWPCG@qian> <48D48FDC-B8DD-41C9-B56A-EBD7314883AB@nvidia.com>
 <A03D6267-5945-4A6A-9C55-5F3DDDB35CC2@nvidia.com> <Yofu5wUgov+2eVCE@qian>
 <C1636974-A315-4E0A-81C2-845878429920@nvidia.com> <YognDJT8C/o1Mt+y@qian>
Content-Type: multipart/signed;
 boundary="=_MailMate_2CE369BC-BC0B-4638-8CD4-3B5E5A89A3C2_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0226.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::21) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be35b9d7-73f7-4834-6443-08da3c13af30
X-MS-TrafficTypeDiagnostic: BN9PR12MB5211:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB52117DF462CC3577DE292977C2D59@BN9PR12MB5211.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fWQXRS92Z1pKtzqD4x4HHJAl9lYmTidMolNkZBlQpjygtXie8lKpvbL678RnMGqpdWYZZVI+DVRQool1fe4K5fJ7TRx/MJctnqPjegFrkBrdWFJ3WQkpJn48msAuQgBPT5eBlOkYfnkNa5IsB2s4wfjMDEikv4xZ72kUqufQ+qaQSbon5CB/TeaYFXAvMrKAKFwHsgD3U2LVqZNOUv2at8fuQts4tG2CyOBBjVs9R6SDVyVHI9hUfKFg6xD8DfE2+zQzjKieOyrkJFwJpPSRGrnWW574K4yQH+Zs0jMXNsYRLuweXHmd7maVIKYHqAHvj39fKXMQXe43qpXhgvR6xRvl6VQYXOik0k8/xiL8nzsil1KpLiHd7rYV3rTSV+2nUDR8Cl/UVGs/rogkT/bERd1ddc+bGune+60VKb4MWTGOihDs0GEblUR6lG4mHU6YxtGzEVbjd1q4m0BYwNgOVeTxfxF2qBspuRSAc8wGRr9WEojQr2fyGb5tOavFMl9u/JAEiP/UZn3iZIIYx4EjC9k+seTDaWNVXf2RZCvmm0EckFyyHxCecidyerJcbVS4dC5+PgKznVGsLR9KMGMucw7oiGGSevHQYIFxFBdOteI5XxD2xyKPkKTkclKSavBPVVIMZlqdHXNBUXwc+d49mR39SfjZarmq0zKyuP0EwrDS+TKt1WhE3xKwtjeSSMnclHW27P7dgZs9BgMOqAmSeqxLZghrx9TNf0tsHy+CwTQW8vpJVPnUVFBKuzRQSNT0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(53546011)(508600001)(6506007)(83380400001)(6486002)(186003)(2616005)(33656002)(38100700002)(86362001)(316002)(2906002)(54906003)(21480400003)(66946007)(66476007)(66556008)(4326008)(8676002)(6512007)(36756003)(8936002)(5660300002)(6916009)(235185007)(7416002)(6666004)(21314003)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M5/T6n07wustAgv7V24PKHI5+8hOghu6t9PkJDhMendJh0hXGWvk6v1d9rHV?=
 =?us-ascii?Q?X4Lp+lURuQl3vf3/F20iD4GmHoaWFkbbuL+bDLBwEhu9RruK5PQ74PTUGWa9?=
 =?us-ascii?Q?ATl4IcHFgXhcpOEf69yQrUaw3fm0xGbKtvmaO3vlJy8V2iWXpBsn/LQXznox?=
 =?us-ascii?Q?RjzIYBpFfzXbrQE/DNdZtrk8Ry08dC4kxLNsvnHH4hlqgRmkVoHwMnuKRTM0?=
 =?us-ascii?Q?P0DNQ15+iuskIwklrC/cuWF73ALDjvsoUo+XmFdb++5bGYZNuKOJJZYSeWq1?=
 =?us-ascii?Q?lmqWWdDiJ1G4Q9fetGremADz1mpI4nc4fPebTp6NPJXIDSST+wT7i/D0hQsn?=
 =?us-ascii?Q?bP8Y8/+FFJ7iXuXDkSaMOJHGQM9rCCtYFPqPtwMt64qkTHQQjVnTkL5cLj24?=
 =?us-ascii?Q?PjLj1v7KaBFU1R2VLQ+4haD3f09rIfY0TpP9+paHTZHLHLmhCDa856N2QgxZ?=
 =?us-ascii?Q?RTVA5kY1rzSzW3ZOIzkFxMJU02COcXM6QBmQEHh3jI0AKiepaxLiVWYry11l?=
 =?us-ascii?Q?++K8xJTd/0ofmUXta4KDMINXdBOqT5VGtey8ZK++rrJ50GL+wY7On4/wsPZ/?=
 =?us-ascii?Q?kwB+hmcgi8tknAhW3MSXbcGROF9M8iJxynExJcezz2rCBX8ivQMdGk5H03S2?=
 =?us-ascii?Q?Thr1K5Uvu0sjbeg0i1GxJAG/7CIzspgAyBH/y8KGQKKUOsLHUeEJw0xHkcOH?=
 =?us-ascii?Q?kq2EzzUz7C/q9KgsyU5YkfREspDacBAXRaTd6VCiRmx1IAjIQTWEoebSWBme?=
 =?us-ascii?Q?V62kpT2GRzNOZw3Bg/baQZC1R6whIz1+l7oxQSwzbvaQVlS1cm5qC4qsfjJP?=
 =?us-ascii?Q?aTdGIqoHS/C/jiNgRYyDWmpvu6abZSDA0RbLDfGswXBALVDDAK4sE8wgbLgw?=
 =?us-ascii?Q?kILud+n80b9+MYoaDmnbsNFAOK+FM75qblsOagjtjwh4R+xedX+vo+7+k5ZT?=
 =?us-ascii?Q?iS+EwvKIHVkzlZ88s/phZH9Q89qyZxU5+mxDk9XSO6GY4xJFfxN2t74mxqHi?=
 =?us-ascii?Q?1vh6RLTpN3CXthrI9maWLaKB8zP+RcyqyLWYYzeGI2yE2yEXVI/5VZb44dtz?=
 =?us-ascii?Q?QVuW0Pvq9rtuhF1GC1keb6Du76dFNBqqIgmFUUogR0sqxrJ8shgLwIGCpGHJ?=
 =?us-ascii?Q?2agtLW3POqjkeWzyLhktRri9NpzvPn1hW/BtYFwUiDJQbOWyTlV+OEKsMqGL?=
 =?us-ascii?Q?NPhw8WtnWbVoLMxF/23K7yT3h83PFTeQ+GnM53qjsnhYHeYe4Uy9eswi2kWI?=
 =?us-ascii?Q?YiCq1KKPNlQcmUwk8+Hyhu8p/WQqhDmjFGWdy6e/wM2/2R2B354R6agaMdLQ?=
 =?us-ascii?Q?RBZ6asXH7JYm8jurm2VPp/otQeNUwoIIX2Uq54L7fsOyvxCSaVVc3gJ9LmXf?=
 =?us-ascii?Q?molDLxpvEj5QxCMYVJY+gdlkZdcJJcOHLSqIq0EnVeEmli6zvwWzvzpS05BO?=
 =?us-ascii?Q?8CQo/LnYz9NHQfBH2inMjkUf9zAPVdio/7rQHLTWh53cO7qx0xjnfYaFN2gP?=
 =?us-ascii?Q?wpyJfnwetYmZn2kiLPUNX71g278WtVft9jqATtbMJ9kxFkNn5esN04cH/Av6?=
 =?us-ascii?Q?SQ0pKRDfTyJy6GlQVoSOIfnIj43CGJWDce0TkMOpS6ID/YSOlJoCpEJlAFEL?=
 =?us-ascii?Q?YkonGwoT/O0tda86eN89MIRrUhv9Jo+0+2KBaLhKTH3qF/K2jBunV52AFpmI?=
 =?us-ascii?Q?Rz+Xo646VpcqaANdIb3j7ndlHoxia/HcRPQH+n/qkZF4PfJ2USxRDlW8xDvy?=
 =?us-ascii?Q?XvHWSl6+Mw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be35b9d7-73f7-4834-6443-08da3c13af30
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2022 16:54:06.9450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8/GCyzP/NaSfg36pdU9+GDwrgqVxS8z6tiRbunPXEPNunc+mU5xQ7rbLTsF7LT2M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5211
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_2CE369BC-BC0B-4638-8CD4-3B5E5A89A3C2_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 20 May 2022, at 19:41, Qian Cai wrote:

> On Fri, May 20, 2022 at 05:56:52PM -0400, Zi Yan wrote:
>> Do you have the page information like refcount, map count, mapping, in=
dex, and
>> page flags? That would be more helpful. Thanks.
>
> page:fffffc200c7f8000 refcount:393 mapcount:1 mapping:0000000000000000 =
index:0xffffbb800 pfn:0x8039fe00
> head:fffffc200c7f8000 order:9 compound_mapcount:0 compound_pincount:0
> memcg:ffff40026005a000
> anon flags: 0xbfffc000009001c(uptodate|dirty|lru|head|swapbacked|node=3D=
0|zone=3D2|lastcpupid=3D0xffff)
> raw: 0bfffc000009001c fffffc2007b74048 fffffc2009c087c8 ffff08038dab918=
9
> raw: 0000000ffffbb800 0000000000000000 0000018900000000 ffff40026005a00=
0
>

This is a PTE-mapped THP, unless <393 subpages are mapped, meaning extra =
refcount is present,
the page should be migratable. Even if it is not migratible due to the ex=
tra pin,
__alloc_contig_migrate_range() will return non-zero and bails out the cod=
e.
No idea why it caused the infinite loop.

>> I cannot reproduce it locally after hundreds of iterations of flip_mem=
=2Epy on my
>> x86_64 VM and bare metal.
>>
>> What ARM machine are you using? I wonder if I am able to get one local=
ly.
>
> Ampere Altra.

Sorry, I have no access to such a machine right now and cannot afford to =
buy one.

Can you try the patch below on top of linux-next to see if it fixes the i=
nfinite loop issue?
Thanks.

1. split_free_page() change is irrelevant but to make the code more robus=
t.
2. using set_migratetype_isolate() in isolate_single_pageblock() is to pr=
operly mark the pageblock
MIGRATE_ISOLATE.
3. setting to-be-migrated page's pageblock to MIGRATE_ISOLATE is to avoid=
 a possible race
that another thread might take the free page after migration.
4. off-by-one fix and no retry if free page is not found after migration =
like I added before.

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 4dcfa0ceca45..ad8f73b00466 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1122,13 +1122,16 @@ void split_free_page(struct page *free_page,
 	unsigned long flags;
 	int free_page_order;

+	if (split_pfn_offset =3D=3D 0)
+		return;
+
 	spin_lock_irqsave(&zone->lock, flags);
 	del_page_from_free_list(free_page, zone, order);
 	for (pfn =3D free_page_pfn;
 	     pfn < free_page_pfn + (1UL << order);) {
 		int mt =3D get_pfnblock_migratetype(pfn_to_page(pfn), pfn);

-		free_page_order =3D ffs(split_pfn_offset) - 1;
+		free_page_order =3D min(pfn ? __ffs(pfn) : order, __fls(split_pfn_offs=
et));
 		__free_one_page(pfn_to_page(pfn), pfn, zone, free_page_order,
 				mt, FPI_NONE);
 		pfn +=3D 1UL << free_page_order;
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index b3f074d1682e..706915c9a380 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -283,6 +283,7 @@ __first_valid_page(unsigned long pfn, unsigned long n=
r_pages)
  * isolate_single_pageblock() -- tries to isolate a pageblock that might=
 be
  * within a free or in-use page.
  * @boundary_pfn:		pageblock-aligned pfn that a page might cross
+ * @flags:			isolation flags
  * @gfp_flags:			GFP flags used for migrating pages
  * @isolate_before:	isolate the pageblock before the boundary_pfn
  *
@@ -298,14 +299,15 @@ __first_valid_page(unsigned long pfn, unsigned long=
 nr_pages)
  * either. The function handles this by splitting the free page or migra=
ting
  * the in-use page then splitting the free page.
  */
-static int isolate_single_pageblock(unsigned long boundary_pfn, gfp_t gf=
p_flags,
-			bool isolate_before)
+static int isolate_single_pageblock(unsigned long boundary_pfn, int flag=
s,
+			gfp_t gfp_flags, bool isolate_before)
 {
 	unsigned char saved_mt;
 	unsigned long start_pfn;
 	unsigned long isolate_pageblock;
 	unsigned long pfn;
 	struct zone *zone;
+	int ret;

 	VM_BUG_ON(!IS_ALIGNED(boundary_pfn, pageblock_nr_pages));

@@ -325,7 +327,11 @@ static int isolate_single_pageblock(unsigned long bo=
undary_pfn, gfp_t gfp_flags,
 				      zone->zone_start_pfn);

 	saved_mt =3D get_pageblock_migratetype(pfn_to_page(isolate_pageblock));=

-	set_pageblock_migratetype(pfn_to_page(isolate_pageblock), MIGRATE_ISOLA=
TE);
+	ret =3D set_migratetype_isolate(pfn_to_page(isolate_pageblock), saved_m=
t, flags,
+			isolate_pageblock, isolate_pageblock + pageblock_nr_pages);
+
+	if (ret)
+		return ret;

 	/*
 	 * Bail out early when the to-be-isolated pageblock does not form
@@ -374,7 +380,7 @@ static int isolate_single_pageblock(unsigned long bou=
ndary_pfn, gfp_t gfp_flags,
 			struct page *head =3D compound_head(page);
 			unsigned long head_pfn =3D page_to_pfn(head);

-			if (head_pfn + nr_pages < boundary_pfn) {
+			if (head_pfn + nr_pages <=3D boundary_pfn) {
 				pfn =3D head_pfn + nr_pages;
 				continue;
 			}
@@ -386,7 +392,8 @@ static int isolate_single_pageblock(unsigned long bou=
ndary_pfn, gfp_t gfp_flags,
 			if (PageHuge(page) || PageLRU(page) || __PageMovable(page)) {
 				int order;
 				unsigned long outer_pfn;
-				int ret;
+				int page_mt =3D get_pageblock_migratetype(page);
+				bool isolate_page =3D !is_migrate_isolate_page(page);
 				struct compact_control cc =3D {
 					.nr_migratepages =3D 0,
 					.order =3D -1,
@@ -399,9 +406,31 @@ static int isolate_single_pageblock(unsigned long bo=
undary_pfn, gfp_t gfp_flags,
 				};
 				INIT_LIST_HEAD(&cc.migratepages);

+				/*
+				 * XXX: mark the page as MIGRATE_ISOLATE so that
+				 * no one else can grab the freed page after migration.
+				 * Ideally, the page should be freed as two separate
+				 * pages to be added into separate migratetype free
+				 * lists.
+				 */
+				if (isolate_page) {
+					ret =3D set_migratetype_isolate(page, page_mt,
+						flags, head_pfn, boundary_pfn - 1);
+					if (ret)
+						goto failed;
+				}
+
 				ret =3D __alloc_contig_migrate_range(&cc, head_pfn,
 							head_pfn + nr_pages);

+				/*
+				 * restore the page's migratetype so that it can
+				 * be split into separate migratetype free lists
+				 * later.
+				 */
+				if (isolate_page)
+					unset_migratetype_isolate(page, page_mt);
+
 				if (ret)
 					goto failed;
 				/*
@@ -417,10 +446,9 @@ static int isolate_single_pageblock(unsigned long bo=
undary_pfn, gfp_t gfp_flags,
 				order =3D 0;
 				outer_pfn =3D pfn;
 				while (!PageBuddy(pfn_to_page(outer_pfn))) {
-					if (++order >=3D MAX_ORDER) {
-						outer_pfn =3D pfn;
-						break;
-					}
+					/* stop if we cannot find the free page */
+					if (++order >=3D MAX_ORDER)
+						goto failed;
 					outer_pfn &=3D ~0UL << order;
 				}
 				pfn =3D outer_pfn;
@@ -435,7 +463,7 @@ static int isolate_single_pageblock(unsigned long bou=
ndary_pfn, gfp_t gfp_flags,
 	return 0;
 failed:
 	/* restore the original migratetype */
-	set_pageblock_migratetype(pfn_to_page(isolate_pageblock), saved_mt);
+	unset_migratetype_isolate(pfn_to_page(isolate_pageblock), saved_mt);
 	return -EBUSY;
 }

@@ -496,12 +524,12 @@ int start_isolate_page_range(unsigned long start_pf=
n, unsigned long end_pfn,
 	int ret;

 	/* isolate [isolate_start, isolate_start + pageblock_nr_pages) pagebloc=
k */
-	ret =3D isolate_single_pageblock(isolate_start, gfp_flags, false);
+	ret =3D isolate_single_pageblock(isolate_start, flags, gfp_flags, false=
);
 	if (ret)
 		return ret;

 	/* isolate [isolate_end - pageblock_nr_pages, isolate_end) pageblock */=

-	ret =3D isolate_single_pageblock(isolate_end, gfp_flags, true);
+	ret =3D isolate_single_pageblock(isolate_end, flags, gfp_flags, true);
 	if (ret) {
 		unset_migratetype_isolate(pfn_to_page(isolate_start), migratetype);
 		return ret;


--
Best Regards,
Yan, Zi

--=_MailMate_2CE369BC-BC0B-4638-8CD4-3B5E5A89A3C2_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmKKaqwPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUMyYP/R63ptExX79H7K+VVfPC7xdcrFGAWHRH1Vb5
QT8ol0xRK+7246kQZdiMLeh1dG67ztTS6vRUtZ9ylNAKHcpBRr34XglOVdWuV3+/
OUa97UMDkTjLpt5ko2EMedCszOklAJ0A0JR3AYYtMS+hzgEanbFDdHYdXo77AU6q
mUjS9CaPHfSllq6vsoMEYwMSCKgqAUlnCSIwzyvbUCMhhNV+X9PqWlEaOM6Kw7bP
tXmjf2TL5qMXN1rgD1NTGHDQMBLZQTxErCNZpyE9YxEI4HlB3sInLs9zBCi15PBL
+nhYhnHVfN9K+MnGY7wBN+/qG8hmLlxYHNHYuJ9vf58Vp56Eu1zptNc5WIylHfgn
jjRba9hCjVkuAgmAslN8qosgWn+dY6rAJ6eC7TjJQ4R1kDKisX7Gu+KzLWzDyHzs
MhpS0y+1U26SCiqRL0KQrsbGVN6D651E0zdXWzzAkl9tx3UIhax71Zh4Rk3MPGOo
AXoimwO0dJuLck4/nUCOZxA/Cage25ECHxXNqiKNACfxoz5blCHHNoKs4jOAabp4
ke4gvbz6AUnwFlhPQ95GoF9lpIveAn+hJdh7Ty4LAdWe91Deu5gZXyV5gLS4Fk88
1JDZe047+uBwnuwsGwZI2hcPa9WxmMO6jIBiEtTy5QFn+TUobVHaUWXXa3EIv3fu
raWB09rF
=09v2
-----END PGP SIGNATURE-----

--=_MailMate_2CE369BC-BC0B-4638-8CD4-3B5E5A89A3C2_=--
