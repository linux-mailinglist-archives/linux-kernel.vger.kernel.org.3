Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4CB52DF5F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 23:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235125AbiESVfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 17:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbiESVfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 17:35:20 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE799ED79B
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 14:35:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D4VgKSxN2yw30IszoybBZZ2GRJltfPrXzqG2omRIL8Jq0hY1bAJqeIMuF7CAvS0CHrnUJa15gjKKFejF8X4lY2nMl/ZRvXj4TW52tgDXmiqveJJ4CQZIuGFAH9LTu2/OvXgIOZ2YM5vAp7vo0XGb4CEQAxWM5fAQKQYWfjY/fY9Qsgz1IvcIIjjRL39Rn+16Llugjhd9AOmSDvp7wpbABZIXHLfn0fSD+gBAxDxqYhQluLoqfh97K5quH+wk8XTOziTjAltkSLyB8jhQ0dmd5nppo2xmVO6umbbpMDlQkAWSY2S0WZ+YkmDvNkmNJ4r8HwamnAeIcM+rgDhKPUX8Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rkx3kzNU3NuOdffRIbrqaIivE0a7K5AU43YNl5YhTdA=;
 b=kTYO2aaAuGQU98k5eoanx9YnnGUy3ZRct9Vn+kaER+kTEbd9sKPtN4jVin0A9WxrN62OvxWWh7ssMeb7//7Z7msezGZPNIIGTzQvib7nIGyEzuVybJOICeCrYMOESjD+WA42Gd6rhC58zoQVMtBLTkEsDufvsjP7tJURkeUpXV4XRue/qpimBdYlZsQMw+TdQFhKJG6fVkK5RP0+un3XYe5VYMwYeaOIuMUkbVeoHlZC6zPBMoPiEXiO/j6sPOXdTmyAwQ3tkZTBj32eRXGRe8u24/ef0RFHBlbOuKcZjxvrwuYXeTZ2WiGhgEdH9HSIvaYX4WP0cBYVabEkWCRAVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rkx3kzNU3NuOdffRIbrqaIivE0a7K5AU43YNl5YhTdA=;
 b=NBT6JSXA7aa9KwLWFWCT08zAVltxce+68yL5vxYmyIrryWQNh9IRo/0FlgmD+ejm0gsQhaRrjTqpevaJNamjQbcJwPkvNAMD/fnMdDiZwhbwxWmOZgcKcpCacPa68Vb6jEsl1zX8GaZDrEBvBJW7kBI31zF40b5beyjNzFL6oQFYYsOhD6+hmmDcyCa7JYgiiCGKoSi8xCgGpeG7l5/wTYc5KHWToDXBZL3pBHTZOHnuGLeUEqBv52IjCArEkTKtvB4x2gh7X6eGc1MPMiUg6GwrBmRuNggIq9vT8eLKyh2g7pRycwp2P8623s5OJ4qkiMhTQL/IkH7j21PjhDfY9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 CY4PR12MB1608.namprd12.prod.outlook.com (2603:10b6:910:d::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.17; Thu, 19 May 2022 21:35:18 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::b406:bcb6:14d:c14a]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::b406:bcb6:14d:c14a%9]) with mapi id 15.20.5250.018; Thu, 19 May 2022
 21:35:17 +0000
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
Date:   Thu, 19 May 2022 17:35:15 -0400
X-Mailer: MailMate (1.14r5870)
Message-ID: <F6598450-EFE0-4EA9-912B-A727DE1F8185@nvidia.com>
In-Reply-To: <YoavU/+NfQIzQiDF@qian>
References: <20220425143118.2850746-1-zi.yan@sent.com>
 <20220426201855.GA1014@qian>
 <B621B4DD-5D11-4F0E-AFF5-F8684AE37E57@nvidia.com>
 <20220426210801.GA1038@qian>
 <2B9844C8-6D35-41E2-ACB2-9854E7A9C29F@nvidia.com> <20220427132720.GC71@qian>
 <1D88AE1B-4DFC-400F-A054-662E3824C9AF@nvidia.com>
 <A1956578-A851-4BF3-BD57-12571244DB5E@nvidia.com> <20220428123308.GA71@qian>
 <0E75B247-8150-48A3-83AE-56C586030006@nvidia.com> <YoavU/+NfQIzQiDF@qian>
Content-Type: multipart/signed;
 boundary="=_MailMate_6A47153A-6425-4835-989E-FD29B55B005A_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BLAPR03CA0084.namprd03.prod.outlook.com
 (2603:10b6:208:329::29) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb642fe8-457d-4138-e3e1-08da39df77d3
X-MS-TrafficTypeDiagnostic: CY4PR12MB1608:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1608B57F4EF680BED62BD108C2D09@CY4PR12MB1608.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LtBNkB0b6qrDgZYBaGy6q0qndH35CH0CxKZ7XgYvtdIkNyN+2hK7DHVaB6caEaP9ceZ2Qcgpxc3+Q9eYyi3XpVATtO1dNhsmuU78f0c/aUTEZ9F9TT8PtVO3Cy83xLZRlDiVEa49dRZc+LlvaRGLvSTJJxKYtuDl9CpYxLDAyHxhkREFH+ivysxYowwhKKCenlnVX0Cs+/NppEc4lhU8aKmEpA7WBrNNNRQnqJJQ1M0JZU6obFNr/unc/vc8N7VxERZpbeKYMaxKw+9Ewt/eEt6G5tka70BfOUdbV51qx9SU7l9i8NEoQVkLEpgcA+iYVc0E0YtUHFOnHpIj9XK7s8M2N1vqC6oUcHJi5HdO6iTJ0Wwg5Jus+yFTb5iUC9Jd++N01K31FCLTGDZi4bkXxIIn8RiYz6UJ3STBv2ZYR8i9CXiBzd4SS+eKovlNp1/ECPd4HykkH2BykH9Qe5zEWhNSjvdyWCZ70F8l8xmv7JpIUsg/YsHSgDcgbJSczfkSBo4+yf6VNZgryIvysRtJWg0DVV5kb9eFL6RXbJuCbYIQPpnmagKvtBm7I27bWsczvzajyhdncBl+8anPqxK6AE4FTS9cMIYS1ecZDiu4OcJL+8l2QZDiEd5jvd53FBvAS+axPHjOesM4y91k/w/1pzcPtubaGjb2hSeFCQx2KreAj+OP5/IMBz2qRJdL3XgnvDsbY//n+3ppGDeJXOEf/i3rxSEBAfo84T+vxlCX/o0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(33656002)(6506007)(21480400003)(53546011)(2906002)(83380400001)(36756003)(26005)(6512007)(2616005)(186003)(6916009)(38100700002)(66476007)(66556008)(86362001)(5660300002)(66946007)(235185007)(7416002)(6486002)(8676002)(4326008)(508600001)(54906003)(8936002)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j4NN3WpJw3J+hxJhMk9PbX0wzZbom+a0kNPTMntfP2rXFJthMOeKwRmz6Rov?=
 =?us-ascii?Q?tn6n3TTQ9x0PpK3DeyC65lVfwXwPDleiysqpOGby43dQTuHjdKCBNAQSywak?=
 =?us-ascii?Q?Zre/hVOG3wMlg6ZSeyWVIzIa7AfQ3WyU71ewlMBCQgozDGfVgbytgFy4W8Hx?=
 =?us-ascii?Q?RMFfxuGVfRwBWnmnZGgNE3LGEkfG49bdsPNurRnNrihT9ebWccbRthr0J2ck?=
 =?us-ascii?Q?Mp2NddQI0yagQpLfDHraNOqb148okB59vfJoG36N7D+4sSoGvfYN/Se0DBzF?=
 =?us-ascii?Q?M9Ynd1hw/JIWdVRGSgdRthhNk0YEMX9ruAnkd5YR1kHDZV/CnzFIsWgeIQvL?=
 =?us-ascii?Q?9CbLfbtAnlIaSBiZ4dhqSoM/TuJXKYdKwW08QiEPJ1CqgYqZ4N6X/poCYjke?=
 =?us-ascii?Q?KiaF4qigiw2pWPnadqrzdTdbp0kcyFzD8fHWH/uS7vF7Tzolf19jJ9D9GPYL?=
 =?us-ascii?Q?KWAndk0TrSkkx7+fS8Pkh5g/yCDlLFiLxfJ1SRue3w7x6OTXIOIhym0OhhcV?=
 =?us-ascii?Q?82RxZNnt1uYizNegLrUbrzjJLkz+0GvLPqHBTZcXe0eCS/xw2615mn/tZUzr?=
 =?us-ascii?Q?i72NkRO85ubOdrJc29BI9oRiTEMHrHIMnnc/ft8CH5LVjrtVv8dF0+mGr0gv?=
 =?us-ascii?Q?uH/9QmOOVynPCCohdyjCfXcWW995qxFVFOWS2a8SyPN6hQPpot3gs45Nh4rm?=
 =?us-ascii?Q?uNUMaOaR85enqSoN6hqfkuqlv0fYT+hsXwzuQqEqOD2PX6lOpKEKuvz4J4p0?=
 =?us-ascii?Q?fH/2I0d4gX75PaSS5hPfhLq2AtFrNcPFNyQaDlX3tg+XaxdBjSkybXEhEA87?=
 =?us-ascii?Q?8MLt2rCzCBVs/gQvCMKV/3to+jXWbmjxHqHfOvhVnvYlFlRh4lTxYTnaY99z?=
 =?us-ascii?Q?zEH3m/U1up8KmGdNjD5o/DzBCyCn9gE7nu96V31T6LEgb70ojk9OdZD8+3uK?=
 =?us-ascii?Q?fo8hpShHtWewzJe3FoTLlTKxPf2IRUT3iidZRu2otJGgIXktrBskFJpqHjL+?=
 =?us-ascii?Q?e45r55jKWj+JGwWPIka04bnOKHGmBaWsEYXeBqvvtSHJPVwgwz8Pw+6U1hnh?=
 =?us-ascii?Q?aKk1l8aoboSFaDkXYAKXE+tci0MoAznMKohO9mHVek9eeYYr91PwMwYt59nW?=
 =?us-ascii?Q?ZLi5dqFC5LOdUxGKlQWTjOz566CU/0kR3Fw5aK1qxMVBjWQxVhbPUoMXITOC?=
 =?us-ascii?Q?knk9Tvj3iXDy+oIK8C45MljH2UYVXstpFOblmzpW/uwZnaUOtNaTlC0JPOCL?=
 =?us-ascii?Q?/iSTqIaoOvLxXYEWKeUyXPDbS83zr1wMEJQmZS1Lh1tpGNzUtuBPgzEISFXd?=
 =?us-ascii?Q?S3ftWu5dKmNvOGvDbx/q/2tufZuD9LbC65fM38g5sFlTJpSC4SNleSmy0qTB?=
 =?us-ascii?Q?xc5MGfO7VeXlNfs7HIOEsgPScST5BFiLa+xbK/OicMDZBk2jPFgHKk+v2glX?=
 =?us-ascii?Q?n1GKOzrRnbYw9xqq6EWjjWB+FyYmA1Zvr/n18kw3h4ohcq8AMrtHcioBkvn9?=
 =?us-ascii?Q?A+celVStW5zqnLFlUvhTovLZuNsW0ozHWOu+y06e6V217tl8JK8Y6CQRCnTb?=
 =?us-ascii?Q?Uhjv4NKhpeItkXKap1vyGX6PhaWkIYmDgrPMEf6zeul3H7SvfMTCh4yT1sG3?=
 =?us-ascii?Q?pjGMa+yImpjXOMLkCXOBU8JZnKDEadNPBwH4KrROfLjD0zJ3XLBRNBXYU0gO?=
 =?us-ascii?Q?GdxDDMevsxyR2wUfDzR2V6PwrrW4MVdNSTwMglY4XG2vEUDegyTWQiiAavH5?=
 =?us-ascii?Q?xF389c36tA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb642fe8-457d-4138-e3e1-08da39df77d3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 21:35:17.8473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EcLIT49uqXZICsSNIA/s2gh2l5muDtGQaw81wP7CmcmUwY/+0wCs6A9Fw5R/ia1F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1608
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_6A47153A-6425-4835-989E-FD29B55B005A_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 19 May 2022, at 16:57, Qian Cai wrote:

> On Thu, Apr 28, 2022 at 08:39:06AM -0400, Zi Yan wrote:
>> How about the one attached? I can apply it to next-20220428. Let me kn=
ow
>> if you are using a different branch. Thanks.
>
> Zi, it turns out that the endless loop in isolate_single_pageblock() ca=
n
> still be reproduced on today's linux-next tree by running the reproduce=
r a
> few times. With this debug patch applied, it keeps printing the same
> values.
>
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -399,6 +399,8 @@ static int isolate_single_pageblock(unsigned long b=
oundary_pfn, gfp_t gfp_flags,
>                                 };
>                                 INIT_LIST_HEAD(&cc.migratepages);
>
> +                               printk_ratelimited("KK stucked pfn=3D%l=
u head_pfn=3D%lu nr_pages=3D%lu boundary_pfn=3D%lu\n", pfn, head_pfn, nr_=
pages, boundary_pfn);
>                                 ret =3D __alloc_contig_migrate_range(&c=
c, head_pfn,
>                                                         head_pfn + nr_p=
ages);
>
>  isolate_single_pageblock: 179 callbacks suppressed
>  KK stucked pfn=3D2151120384 head_pfn=3D2151120384 nr_pages=3D512 bound=
ary_pfn=3D2151120896
>  KK stucked pfn=3D2151120384 head_pfn=3D2151120384 nr_pages=3D512 bound=
ary_pfn=3D2151120896
>  KK stucked pfn=3D2151120384 head_pfn=3D2151120384 nr_pages=3D512 bound=
ary_pfn=3D2151120896
>  KK stucked pfn=3D2151120384 head_pfn=3D2151120384 nr_pages=3D512 bound=
ary_pfn=3D2151120896
>  KK stucked pfn=3D2151120384 head_pfn=3D2151120384 nr_pages=3D512 bound=
ary_pfn=3D2151120896
>  KK stucked pfn=3D2151120384 head_pfn=3D2151120384 nr_pages=3D512 bound=
ary_pfn=3D2151120896
>  KK stucked pfn=3D2151120384 head_pfn=3D2151120384 nr_pages=3D512 bound=
ary_pfn=3D2151120896
>  KK stucked pfn=3D2151120384 head_pfn=3D2151120384 nr_pages=3D512 bound=
ary_pfn=3D2151120896
>  KK stucked pfn=3D2151120384 head_pfn=3D2151120384 nr_pages=3D512 bound=
ary_pfn=3D2151120896
>  KK stucked pfn=3D2151120384 head_pfn=3D2151120384 nr_pages=3D512 bound=
ary_pfn=3D2151120896

Hi Qian,

Thanks for your testing.

Do you have a complete reproducer? From your printout, it is clear that a=
 512-page compound
page caused the infinite loop, because the page was not migrated and the =
code kept
retrying. But __alloc_contig_migrate_range() is supposed to return non-ze=
ro to tell the
code the page cannot be migrated and the code will goto failed without re=
trying. It will be
great you can share what exactly has run after boot, so that I can reprod=
uce locally to
identify what makes __alloc_contig_migrate_range() return 0 without migra=
ting the page.

Can you also try the patch below to see if it fixes the infinite loop?

diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index b3f074d1682e..abde1877bbcb 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -417,10 +417,9 @@ static int isolate_single_pageblock(unsigned long bo=
undary_pfn, gfp_t gfp_flags,
                                order =3D 0;
                                outer_pfn =3D pfn;
                                while (!PageBuddy(pfn_to_page(outer_pfn))=
) {
-                                       if (++order >=3D MAX_ORDER) {
-                                               outer_pfn =3D pfn;
-                                               break;
-                                       }
+                                       /* abort if the free page cannot =
be found */
+                                       if (++order >=3D MAX_ORDER)
+                                               goto failed;
                                        outer_pfn &=3D ~0UL << order;
                                }
                                pfn =3D outer_pfn;

--
Best Regards,
Yan, Zi

--=_MailMate_6A47153A-6425-4835-989E-FD29B55B005A_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmKGuBMPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhU0wgP/2xW27cSkmbQiWqRoPOdGZut6VJAOYxkWaWg
wzeUcq+d+x+ZBSoJukV0nezjOV6+tXSJAy4PBYpk15Pp/sZ4Df9DmuJO69bEDD0u
FOK9phl5mto+Uvnezimue3E82KHwc7t+UQ+xxZdHQfIo/hk/5eH6xEJrRs/6pQw3
Pa50fwO7h+jUu75nqxi8s+3RSgzambdif46uQInPt5ELCheL8lJZ6aIrqvvvXxhh
txCSr65xceHIPk8OU2el7SaQ+V/OQJKwaIJgCccZhy0hDvOLC1duDWoG+f6kPVsV
dT+444VUIZEO2DWiWssuX4RpxO3cFgV1H0xxj5xyPscOEdr0LbGFefdS25TtOmYx
2zcc7mrVdaV5ATfAxsCcIyitjapzJ7jFGrGPzk3VwRvCdvlFBPO0ARFMkZHRXHAZ
XEKzcn/zMtuaTrUDBzpsVMR+cdQp1cRJ3E2wVOZ21kXg87Xn3RpVfF6ivUTz3wAx
EUFOUAwL+kzDEObutLb8scRgsOL6sQV1PQ+7LBYh7t1YCqObt4RFdB4+J75i0kyj
OjrKggZkOSJ+jd4HyDvCQ3w90SuSaeUotPCOATtgdanjghW0qzfqYYP61BuARUko
2KHk2cfr8QBeHbZmVZu4Xcg18+GYxwan7jQc53Vm0rEYUoRBdLiA1TEq65gT2laQ
05bktsnz
=MgVJ
-----END PGP SIGNATURE-----

--=_MailMate_6A47153A-6425-4835-989E-FD29B55B005A_=--
