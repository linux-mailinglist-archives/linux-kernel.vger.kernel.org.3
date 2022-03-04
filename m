Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8684CD794
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 16:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240216AbiCDPW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 10:22:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240238AbiCDPWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 10:22:52 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDDA21C3D25
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 07:22:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jEAzMMN2Ch5xnfrOrEnvI3Pc9XQi6teHU29FQGiviCmYH6pLVgEncUzAkei1/yPcZ+N3uAGzFF4Ew229oj6zsYrjGyThq29cdJwhtrenPIlmueBFYnoYwwPDBoq/Aqd1wxZBDgcmjo0HjCmUiT3GbJlxKgom2HPoRnE+9Rei0R7y04ukx9XhY4ZW9Atq0twKDeVz2R5BbOjVcqbXNgodhhgMdnl110uRwtlHTLn7JLgKSMB6Y351YpckCSns2QTHtjbZSLxqXKkiPA8OwoA/y/jipWygs0Q4n2q4wNc/3cV/kRw0c/ZuAaLMCcpc7APQVUi/P34bX7j6GBfOwejsEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H7YNRvV6qiQYBtFc8Llwqqv9Nn5B6knviI4EHRt+My8=;
 b=TuTDasokMv+1GLBVbvB6uSvQW8Zf9dKQS8/+wpTO1+UItpb9FV4NvohfeqN4+rD7gNcGVvRwZPngJDLwhJe6uCf77cA+4TyBx+Y9uWeXfF71Mm4fAIEpkd20LyJnhmynFld31VPN/M6PENSfX/aVF0V4ZwaKIwNMzAyZXiBk8nci5kXpARihU1AnJqIq4/FSql1ad43HxEH7TWjUVlyhBpjjqh/HcwhtvaYmrSpDcdCR+5cT++KsJD96NKv1CxqsHik5ZJ8DwtxbGGlMhv7GFK7VkPhgcgLPTb1TyzSEbYRUHFssXXboz5rwg8yVrtV2KIt0h8iLTACF0BiWt1F1rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H7YNRvV6qiQYBtFc8Llwqqv9Nn5B6knviI4EHRt+My8=;
 b=JdbV8Bo/sp9fYw46zjc07WhN2T5XTSxtL6sRlFsPtep56rShHtM/FsyZ3RAUdCPFThHzI4ukIFzCoYqFmYHacgldLfaV8MD4Zv6UYzhe/K4nM1vYubo3hkvVXZrI0wb2y7MIpRWSVhMzhpMbP89oE+nsavASQeTHbk2DmeBtSHDuhUgSZiga5Rto56RNRlfDE5+QK0WCjuezmWxO5wlUpcMMGaN0x2tVmDcFKPFCXC/MASColcULMSSDHJ4LbO4Vq2YAIlM31i/oBzxpW1b/dKw8Sgp77DuY5HVbf0IiEj4dQF1h2FYTQONRr5OsFhzpXCkKeVkfo8kghEdFOVHwOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by DM6PR12MB4169.namprd12.prod.outlook.com (2603:10b6:5:215::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Fri, 4 Mar
 2022 15:22:01 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::40a6:6e1d:b057:a036]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::40a6:6e1d:b057:a036%6]) with mapi id 15.20.5038.017; Fri, 4 Mar 2022
 15:22:01 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, mike.kravetz@oracle.com,
        shy828301@gmail.com, willy@infradead.org, ying.huang@intel.com,
        minchan@kernel.org, apopple@nvidia.com, ave.hansen@linux.intel.com,
        o451686892@gmail.com, almasrymina@google.com, jhubbard@nvidia.com,
        rcampbell@nvidia.com, peterx@redhat.com, naoya.horiguchi@nec.com,
        mhocko@suse.com, riel@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/16] mm/migration: fix potential page refcounts leak in migrate_pages
Date:   Fri, 04 Mar 2022 10:21:58 -0500
X-Mailer: MailMate (1.14r5870)
Message-ID: <CB1578C2-88BC-4997-81AE-4623E7ED75C4@nvidia.com>
In-Reply-To: <20220304093409.25829-13-linmiaohe@huawei.com>
References: <20220304093409.25829-1-linmiaohe@huawei.com>
 <20220304093409.25829-13-linmiaohe@huawei.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_8C39A3DC-6834-4795-9BFA-AF0FE1BBB180_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR14CA0002.namprd14.prod.outlook.com
 (2603:10b6:208:23e::7) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24e0be4c-25c9-4884-f9ab-08d9fdf2bb39
X-MS-TrafficTypeDiagnostic: DM6PR12MB4169:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4169E1168777F4562A97849BC2059@DM6PR12MB4169.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qB132jlWwIMHqkUnOKCA4yyLuo8mzwTvs8qL2KpP1oTkrhsxK0vqrHCc86ZxubyzLaAJtBjvqIZ2sRxSpRNE7a8xikjtT/enU4p5Lh3ElSbg+uMRNHludoNjcFHJ1178lLo4uiZb07g3gsh4+Asc3oBGivN8BT786CsBuGND1+00HDaT0ucaChRCbl069r1MWIE2Z4H76aoDtQwu88pCkeq1v6nc8LNiBADsRfZBf9XfpybvfSThQvRyLhWO/2qAFRgzaPK6HKIq0QHUdxlA8tt3UbeW5axptubMiorNcG0KFkuby4nHEsh0teEdPkNmMV+DpI79JuOOPYyCkt8lmqR85Ro3fAQCqczGMCq6urU3uoTlM8H9GEWiJgsk0CGyJn2VNqQMn580IiwUgvGQw4QoEPA9tBPmSwXiWN1whmFg7wxux90AY+TDeN38ynsha3Mf4NmR1i9EOYix7L1Wn1XSSagkGkq6gG0xzbGQw68i38v57XH6AY2l7nT6ON9/Lq7Jw9w0+2gaJGv+hhT3LNKXyX4HegETN2dxo6pRJsdCeLfQEWDmb2OKoYXM+8bo3Ph5nUdQcjtN7tzsayXR7N7XhS0D6wPoQnC9wZ58KqU9o6V7HwDl4+86Ctm3rwJ06cXJcJsZ+KWWlrvTXwR/wK1KMXsuWW0mPce73xXOzzutEbQrdZ0kNKenWXgjQRygRvN6dZe5ctYxTQzuRnbZ9jtIHWyYtvkXU0cBeEH5u00=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6916009)(8936002)(2616005)(6512007)(66476007)(66556008)(316002)(36756003)(33656002)(186003)(26005)(6666004)(21480400003)(7416002)(5660300002)(235185007)(66946007)(38100700002)(6506007)(53546011)(83380400001)(2906002)(8676002)(4326008)(6486002)(508600001)(86362001)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iafOJ+GHF/2ApMllulGr7KD1/SqXyUN2s3D+pZpBFD7BrUOQsjr1o5wnpcQY?=
 =?us-ascii?Q?+4Du4967zgJs/intwSNyPDdx8tDd7LLrHj+IEIRn+uCJGEjxBnS7x43EeegQ?=
 =?us-ascii?Q?giM6Q5YN/vy79ZaeNX1fk/WR07bTr/GY49wWvcygm66WW10p4EWVqX41s3x6?=
 =?us-ascii?Q?JcitHdo9LVkz9+3bcc6TQ3A8/Owef/KpQWuIyS62L8oYA4jaJUsRwlXCbtSh?=
 =?us-ascii?Q?wSF9NKNCb7BNU5+l1i2l8GMPSRfp9HMIoe9FnqEUg3mZ47GS8VvEXjMutOrv?=
 =?us-ascii?Q?0peZQ+iN8XfrS4XH/W+/sQnLk2xgg4WlHzS2Mb4G6pIZElfby71iVJbbHJs2?=
 =?us-ascii?Q?IdtTUATiqNB75DSbQhi11XUiAYpsAuXxGxUMBBA4xWhFV3XHpUCFJg6dsfrS?=
 =?us-ascii?Q?mR9DfB7VYr72c2kBwwmCAWPspFRscfGp1/86VccSUTB0RTgJDddut9gNRWcc?=
 =?us-ascii?Q?x7S3MGwW7nSxicHxHyzz+JxJXHc9ZS7sgOqis4fHTJCGEepeaq5MGjfd6O8n?=
 =?us-ascii?Q?xuPucBvzjYKQUeNqi5eCJL4f4WtOOh7Co6fxbPsLlOUuS4WOXK+nI16+8LLf?=
 =?us-ascii?Q?SIjJbqg+EMv2yEJeD83PiHm/E5vr1B7kzVc/pvlQoq23pyb1kBZOPV7YYCrO?=
 =?us-ascii?Q?/d7VXFUhLdKFi7x8vZWMpP8zu7r9GsCWv5ZgUcAVk00iO1u/P2Ni8O2yRZUQ?=
 =?us-ascii?Q?B5nsx4WLo9xjZeE2dVPGcdfOU9HIeAy/V8L6E+ftn5SyO8Q0U9tIv0mcwFgE?=
 =?us-ascii?Q?yLBV/ho5IeuXbP7Iv8g0B8TECLiTBo+7aU6VQm4CS3mvVwXxsWOKQXFRxt4a?=
 =?us-ascii?Q?KCn+i+PKEzynWEJK7kRv28BR46vIEPBgXn01mZfHKLpvoENHOw3kh2e+yFku?=
 =?us-ascii?Q?b4LhzOpkNjAF9H+8l4f53k8id+WkGSQ6bAPn6dx/wObl0NmH8wtXS5eB92Pl?=
 =?us-ascii?Q?vzZC94HWuFKK6lCWJGIw8wgmMCGV1QJ4ibPOmPsgDDEAb3zEoXsYJ9ksF8Xl?=
 =?us-ascii?Q?89s++JKmE6XlSfV3j3QJOFqxq9UL44jaffuincD1igLa2CMgQ0BRps3Zt7EU?=
 =?us-ascii?Q?eN3o64J5a2/Kl6dYxceoesUe3GXSrv+4rpkERVDDqF0YkZLvbUXK+Kbs1pkm?=
 =?us-ascii?Q?8qwecv5gjNEFKkEglT/3/TfGapEQWvzPanVjzwT9Ln4jJd6zwH+6u8/y0iH0?=
 =?us-ascii?Q?EOiKrVhDTm0nxJBNmdH1wilchnVikD/7krYWYr3aLyCXDzwA5tgj/cDIsF/2?=
 =?us-ascii?Q?81c7ZH+i4IS2DIGt6h1Pm1yuU7BMuNxqSgAO7Ui9SlB1E8Y7NXU3xXjFDEsn?=
 =?us-ascii?Q?b2PjmeJNOD8er84h4eLlTHVjbjXn0m9Hm36MOPhtHNbpeBAuQIYCVT4E8JJY?=
 =?us-ascii?Q?q4v8OZQ0jjK1Hf1VciE2lJ3FobSWYvCGGXjd0b9kNpPTLN80bQaUJ2NYSIDA?=
 =?us-ascii?Q?9m+b6iECBwjsb1sU7KnDiGb8VfVNza9Jcf4DfA+zBhDeFWcaReKscUhkK8KU?=
 =?us-ascii?Q?dIOMV1IG5QbFdgo+jWAdt5AuU19qLlgH8JLRV27Yl+J3qdJskHeLytpCl2ZY?=
 =?us-ascii?Q?d2ip0OuZYi00NjsgsWk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24e0be4c-25c9-4884-f9ab-08d9fdf2bb39
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 15:22:01.7499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: egBOADq0GJZQq+0jPXz/M6f8ouJeterhl6etTGAJdo1PUHf4w3jSZr7zYHMZ+0PI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4169
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_8C39A3DC-6834-4795-9BFA-AF0FE1BBB180_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 4 Mar 2022, at 4:34, Miaohe Lin wrote:

> In -ENOMEM case, there might be some subpages of fail-to-migrate THPs
> left in thp_split_pages list. We should move them back to migration
> list so that they could be put back to the right list by the caller
> otherwise the page refcnt will be leaked here. Also adjust nr_failed
> and nr_thp_failed accordingly to make vm events account more accurate.
>
> Fixes: b5bade978e9b ("mm: migrate: fix the return value of migrate_page=
s()")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/migrate.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index e0db06927f02..6c2dfed2ddb8 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1422,6 +1422,15 @@ int migrate_pages(struct list_head *from, new_pa=
ge_t get_new_page,
>  				}
>
>  				nr_failed_pages +=3D nr_subpages;
> +				/*
> +				 * There might be some subpages of fail-to-migrate THPs
> +				 * left in thp_split_pages list. Move them back to migration
> +				 * list so that they could be put back to the right list by
> +				 * the caller otherwise the page refcnt will be leaked.
> +				 */
> +				list_splice_init(&thp_split_pages, from);
> +				nr_failed +=3D retry;
> +				nr_thp_failed +=3D thp_retry;
>  				goto out;
>  			case -EAGAIN:
>  				if (is_thp)
> -- =

> 2.23.0

LGTM. Thanks. Reviewed-by: Zi Yan <ziy@nvidia.com>


--
Best Regards,
Yan, Zi

--=_MailMate_8C39A3DC-6834-4795-9BFA-AF0FE1BBB180_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmIiLpYPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKYuMP/2BBdv8a3f09EpeUwHhjkHIi6yH1NI/Td6iQ
Z3bxppkOZVlHTwGNqMyzMU3f9VRNtOfimNFS6GzshNp9Ho6lx6unYcz7kcTBvjSH
5SgHcIe3hOQcp0hctFbrQYF8P1aZ+h5mI5M4xGvio4zKd+yHq1TnPsTlmVrNW38U
c7ZpaK2a0PwZOrRjTLY4+Uzv2T4RMdQcWVf0NZNCyBiKydbUwM5GC6zm4bakitPH
NmaN9LRb70vXm6mhxn30UdF2p5qQoEmkxn6cMHkpd8quy+VmEoZLBtrMGuogpEDy
PFid1/UtO2tXvAaycUCJUlTkIVm8tGio990S3rWbBiIWC41DcMML+GA8um97+GWE
cJ+YB4oh9r/7EOQdoiE3v71UeKedIgH2oOY1FAC4njxj23FInL3542rl4uDQj8y8
vFckiBc0XXFDh6igfh9hxxOrlHvhXXIloCvpjGy3pyrc7DQl9Flpr7OtoD9x0Ncv
xY/IjGSxgmyw+9d6oKBYXsvewKFvj58bHzHoCxzzT05TEX3m9x7BXiL/BfAs598l
JC4ZsVklQEU3s/PSe2LeFMLj8i1UlTK7NibIdCGgpc1KJDxyFDaV8RtYu5e6+bs1
kbPZ6r2lIkKKtMQaFpxabOV3tDToh+ALk9mZpdSVUc4pNVmw615F+wGsiwUtV9Wt
8YURZOIN
=b9jc
-----END PGP SIGNATURE-----

--=_MailMate_8C39A3DC-6834-4795-9BFA-AF0FE1BBB180_=--
