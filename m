Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A18F8533B16
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 12:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237891AbiEYK6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 06:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbiEYK56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 06:57:58 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2075.outbound.protection.outlook.com [40.107.212.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F3012623;
        Wed, 25 May 2022 03:57:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nWBQwLp1HC0UJX5FE/M0ROQKcFcCJFjQ3fcRrcLAxgR3LCo2fou+Eu+Wa46Wf1t9G2bp3pNTh+QSuPje5eE7zWjCxNI0ZjN3nzuk42x3qLIXcwloimgPpsoApTjFsbYwcyUrcKeKBRqogIrVtFQOh6gNRClW8/8gmmOSxSBB7/o8VY7tQ2WumBp4mFkTY/OILxvmfYcYTRrWLtdluSV9DXQLRSp8VBW9bbNcDtPN69sdut2fdW+6dLB/e6ARC39Rv04r7sFSslMQIGxpQP1XsYKj+kkcrKx1ldj5gua4VFilhBfFO8z/nhJplAkXYxmam+u27Voy94x9FlM5nzNYNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dj3y9VonRoYLoTCldxt/e+yeLZe/koz09jDBZdj4v3E=;
 b=h9z6grwAGUO4s1UBS6wue7JH62DyP3mHdljv4KRdPdaVGwC329m6AxM08jYFMndL1rbH0rbD3mck0U8rdrQH5BwdCHWtan6UCypoi8GFxQiWdPzYatnx+ObOtfQyneTLB0eCSH5QGQSss9hT4lTZkRnqurMEQe7QPuKD+3Ie6+mmNzPS/JxlxsgEMfKNZfaEGEoSvm7D9/kVs38YJmXSXHJy7kAlZUyXpP7EDNwKuWdJfWid4JZfEYXCFdJJBxAyO20ENPzW2znyMICGl4szoEuxjOGtIa6OQCeGII8rVYcY2i53w7xUPoFbBPO12nMl/TPh4r2XvgvB2bg6kr6wgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dj3y9VonRoYLoTCldxt/e+yeLZe/koz09jDBZdj4v3E=;
 b=h68YB367+VO/TDCT7AGZVjTEdi24xLu3aKUiEyU7YGVuPTrdcPMF/gBLncWe40psLIGcPyH5vFEV/e8OKi8Edx6kqcyagsorjLks/pGh070STpABOuMKxpGs1rSruiP7sy0FjoJm6ft3Il6o4kEMhQUuLr+K/CK2C5Ow/qcuwSi7lqLG19kvZWyhfUNNhhBA8DJtQgm51HexMU+tgoIVz/frgooKKnRozZI4p5C4n+r/c8lfoyFJ4LeJod+nkIilSOQ9kZ+3XTfFWY2Q0DEmmgu7DvhaFRzE74Mh3LiNIXVzGGLqeKUmzIqsfQ6QLQ/2FedeIhOWtyQG9nvSJgBv6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 DM6PR12MB3081.namprd12.prod.outlook.com (2603:10b6:5:38::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.21; Wed, 25 May 2022 10:57:55 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f993:a9a1:3730:a7a5]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f993:a9a1:3730:a7a5%5]) with mapi id 15.20.5293.013; Wed, 25 May 2022
 10:57:55 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the mm tree
Date:   Wed, 25 May 2022 06:57:53 -0400
X-Mailer: MailMate (1.14r5870)
Message-ID: <6CA81704-417D-4843-940E-F901803A908C@nvidia.com>
In-Reply-To: <20220525155401.4a72ad6b@canb.auug.org.au>
References: <20220525155401.4a72ad6b@canb.auug.org.au>
Content-Type: multipart/signed;
 boundary="=_MailMate_B4925A09-6453-4FFD-99BE-7159977DFBFC_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR06CA0012.namprd06.prod.outlook.com
 (2603:10b6:208:23d::17) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b981e2e-7711-4163-f60f-08da3e3d6c09
X-MS-TrafficTypeDiagnostic: DM6PR12MB3081:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB30811E38E3745BE230C1F5E8C2D69@DM6PR12MB3081.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZuNtbxu4DXRaM+P8fI7LBBv0NI46GNv+ZU2ExHKN+b2YbQNzqs8r2p3w9R7TFJxsc2UhJ3Bj1/3E6Nr3TuWKncuVAYJl5oXCMTZ0uQoAW4vJacUZH/ye1gKTQOnkh63+SmvnhQd59sJChfaGYXulcAyqqbu1Z5zPBiRMmVAZqzC9UVpcWXQGmfCHeC/x40oJM1c6bMfDiCqhqFcn2encKSADmExB0Htd/u5uV0J2eiZVZEMJKoviLWj7IkGOQ9pgGxrCpawunuOpsRGrjrkVILN1GeVrxSdj7CoZ5/rO90h4EWydkExVIN6g9sGFc8CZ9AfnLWgZ7Fcm0U4goZ86NEtkZ5iR0X3s++vDdc8OTH8SKi5LKQ2rx2D2osgjyJQc8r91YNFBbC48NvrYO9b3h709PfNgbISwQq3LE0Q3xFVrg4vvnnGTfNkO3zcgxq+lsxH0Xkems5qR36ZTbhOAMTHwlN3oRbiTZqAbm/i/iEp1cx3Su1/x6I+9a976X7zCvKJ/79xtl6v1mEd/Ln4f8LeyPnwl+QnrLwEXBEtMpES9fPCA4fBLsdafLpoYcX/xcVI8hUK566Absa8dzD6Wdd/MTgqy2WjJ+rXiWOHD1vADSoRoQz+B2BcLQY3O1Jmcke6cxyz7+KSBpdyNaGL8b4dc3qp5srfthujz0qxd5N/dUNXO7w90Ea6MZqXMW5LIa5J8ydg9WdSbO6xgklksxoO6K8ShHkhcut2ZxdmOqmI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(66946007)(86362001)(66476007)(4326008)(21480400003)(83380400001)(36756003)(8676002)(186003)(2616005)(6486002)(2906002)(33656002)(54906003)(8936002)(316002)(5660300002)(26005)(53546011)(235185007)(6512007)(38100700002)(6916009)(6506007)(508600001)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZYZdICY5mkxvu0arT+I/tGZvnZHdir9lc4THM3khH93qVDSNWALsrNTC77l5?=
 =?us-ascii?Q?YPIC2khAeYMJzxf51ycZzYDFvRSpIyUIk9a74jHizOXySu8r/h5rQurAFDL6?=
 =?us-ascii?Q?P4yFlRolTuLaHxV7+6b5LOvVnE5GCn1vkm3O49/633YznNqokL9K1MCx66gL?=
 =?us-ascii?Q?2MpYEnXl51PKlOOsDyghQ++givbBl3jqfetRWzdTZJjFJVkTS950atpKTqho?=
 =?us-ascii?Q?YR5nRDXPbuL9juwH2vLzqW8a18YVgJjbiksULZ/IhL2fkjHOfW4RckwSHqLA?=
 =?us-ascii?Q?1y30vMs19t/tuBYuBHC8vXC1IYSKy/2zDfOtiSQsWBkOdVIZyqo9FOjTNRMd?=
 =?us-ascii?Q?bWRgpn0duMbUq4Kd89FvBIYnVrKvLKQvqb8KhmGp5RbZYeG9V/ZrHjPWI967?=
 =?us-ascii?Q?tpI0Z60qTrBlnPd4MdoH2tKWEFqyuix4YIgOtoigzSxnHQtfQCwQy1z2WsUH?=
 =?us-ascii?Q?4qUWgf2ku058TGjMc8sstVHZHD0QTYkYPgM8xpCuEdHeaTFbpLd8snAyX7wU?=
 =?us-ascii?Q?9lx2+AQSNO76mGAQ4NHrBQvmTOCw/alv25sU/KIkOY59txf7ur96M9I3ivVQ?=
 =?us-ascii?Q?kMfBh0mBIA1W5N/73ea5WI4sCy8WJ2uYjX2lO60G6f9nKgi/I8y9f6cQ08no?=
 =?us-ascii?Q?We1mNszIc5+MHGBwuVAbUYfkJAX3KO3vSmfsG3eHoV6guZ9hSGpqVCk04Kdi?=
 =?us-ascii?Q?e/C4jQDtv6AefVeD8Hk7vCnEOUGnQ0pm4xwDXxAumlqk7PaeStObQg/wCXQv?=
 =?us-ascii?Q?2YxHN6ESKzQoNUrjk2fg9Wjj4MbXTtr90OaY4SW9D0uYYWqMGyPk/u5EsGXs?=
 =?us-ascii?Q?CshlRpr7rZYX5n49cKdBmVxdbgEsZXjkSBmZfliX/s8xhcS22FIns258GCaI?=
 =?us-ascii?Q?Yp8aEu9bU13Xs46SH9C7ZvqvUrVck2E93tqYAX0ATrbFZ0JMDK4nALcxQ78z?=
 =?us-ascii?Q?9guvG5+wbhdzI6sAz/1iGzPMv4Tvpxq5rTlBsWKdYfyLSr1Q/59xHE9xd8s7?=
 =?us-ascii?Q?yajMRJCoSwTQ37+CFJTVbVm47gFGaH7lxkkiO8h0ZiVlVb6q40lMczXLyx5i?=
 =?us-ascii?Q?NrPP6K8D07gfyhyRciBLUfOK45K+jRPyRUnC0HelTsLR8bcOAmFAN6EzA1PW?=
 =?us-ascii?Q?dirlUfI2jRpS2E7C/B6uvGMZoCJrWTOPk7Yj2YvdjP7qc9Ap1JL9ww/8ypTN?=
 =?us-ascii?Q?lo2wm1ViDTXqZz/MsPbHS3S1EmcVAG7Ke3fi/6xDbvU842f6Mc5kdZIQH39D?=
 =?us-ascii?Q?7GH/um8mgOuEZYxJJd6nqY+wBI5/u1AIcdeY0A+QEhx2dESztukdmNMCUfrb?=
 =?us-ascii?Q?Cvs/QbG13Zn/2TmWb/hWR9rZHUiTuY1PLfUSmaoGr8yuMhcb2DyhTRjxMxik?=
 =?us-ascii?Q?g/SSU8/Dv9RU8LiyhFoWwh/xqkVEXwaoyZT4AE3CzUBJUPY4pK8BV1whtA+S?=
 =?us-ascii?Q?VbXCJIUezEnChiegmIlcCH4eMST8Zgsb3X5TPKT3uRVrxC8Puwjo/URb547h?=
 =?us-ascii?Q?g7uRFZ5xHaUl46ZbfTPW/Mvryek27HjRdl3/QcKZ+twp+MqrlNL2EOBc0nQO?=
 =?us-ascii?Q?mMhNjjJZEjrCrUU6zXwrGNs+RLeeaphVs+qpjT1VcZ2Dga8ZO8xhHAS5Y3NU?=
 =?us-ascii?Q?m7Kn5cwOZGRF9J4niCEK4/W+/7MmSQoDqZsEWKZKisgCHAgjvXkD4S3n27Y0?=
 =?us-ascii?Q?w9VTH6EgA5IxwurRFZqaY9IL10UGV7LM5o9ku9tAO6WpXmR05wuHZO9TxkOv?=
 =?us-ascii?Q?XmIyFPp0xA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b981e2e-7711-4163-f60f-08da3e3d6c09
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 10:57:55.4740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vmPSlerqRBML4M1EaPnlZnGqSikBNIg+7pksvc1Wxtf6wr5pOk0dXFx9JTD0Te97
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3081
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_B4925A09-6453-4FFD-99BE-7159977DFBFC_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 25 May 2022, at 1:54, Stephen Rothwell wrote:

> Hi all,
>
> After merging the mm tree, today's linux-next build (sparc64 defconfig)=

> produced this warning:
>
> In file included from include/linux/kernel.h:26,
>                  from include/linux/cpumask.h:10,
>                  from include/linux/smp.h:13,
>                  from include/linux/lockdep.h:14,
>                  from include/linux/spinlock.h:62,
>                  from include/linux/mmzone.h:8,
>                  from include/linux/gfp.h:6,
>                  from include/linux/mm.h:7,
>                  from mm/page_alloc.c:19:
> mm/page_alloc.c: In function 'split_free_page':
> include/linux/minmax.h:20:35: warning: comparison of distinct pointer t=
ypes lacks a cast
>    20 |         (!!(sizeof((typeof(x) *)1 =3D=3D (typeof(y) *)1)))
>       |                                   ^~
> include/linux/minmax.h:26:18: note: in expansion of macro '__typecheck'=

>    26 |                 (__typecheck(x, y) && __no_side_effects(x, y))
>       |                  ^~~~~~~~~~~
> include/linux/minmax.h:36:31: note: in expansion of macro '__safe_cmp'
>    36 |         __builtin_choose_expr(__safe_cmp(x, y), \
>       |                               ^~~~~~~~~~
> include/linux/minmax.h:45:25: note: in expansion of macro '__careful_cm=
p'
>    45 | #define min(x, y)       __careful_cmp(x, y, <)
>       |                         ^~~~~~~~~~~~~
> mm/page_alloc.c:1138:35: note: in expansion of macro 'min'
>  1138 |                 free_page_order =3D min(pfn ? __ffs(pfn) : orde=
r, __fls(split_pfn_offset));
>       |                                   ^~~
>
> Introduced by commit
>
>   29a8af92b874 ("mm: fix a potential infinite loop in start_isolate_pag=
e_range()")

Hi Stephen,

The patch below should fix it:

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 6eec0211e0be..dbbfe4a079d3 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1123,7 +1123,9 @@ void split_free_page(struct page *free_page,
             pfn < free_page_pfn + (1UL << order);) {
                int mt =3D get_pfnblock_migratetype(pfn_to_page(pfn), pfn=
);

-               free_page_order =3D min(pfn ? __ffs(pfn) : order, __fls(s=
plit_pfn_offset));
+               free_page_order =3D min_t(unsigned long,
+                                       pfn ? __ffs(pfn) : order,
+                                       __fls(split_pfn_offset));
                __free_one_page(pfn_to_page(pfn), pfn, zone, free_page_or=
der,
                                mt, FPI_NONE);
                pfn +=3D 1UL << free_page_order;

--
Best Regards,
Yan, Zi

--=_MailMate_B4925A09-6453-4FFD-99BE-7159977DFBFC_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmKOC7EPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUXKkQAJgxJ8zqF3IOtBitI21EXjdirYrgcBbvdrhM
cXE4vp6KnbxpYCEUN7A8IcnD5U37jPOXzgm+WEQW25AmWbmomWsJ1aZm7k3O7xyr
WMTFjgVeKBfZKIg1a1Cu+dkU2Z1o5c/f7+vb29rHeuaa9GyVh6qvpsBLZdUcW25y
5/Jp5gyo6x9O+TGTjETEnA8oH9HvNiUOqIhROQipIzn3yyigLypA9RUCgQulx09V
k6M9TSwn8d7axBniAajuQvqJlCW6ZKzd9/EPxVijEOGOtkRNB+C/NN0/Liy3KAvC
7y9WSYBxl3j3GGsne6l+WfI/7nZT0mQBcRkKS28ysaq+f3iprI4F971IuTRBt6Sm
eJwKi6xSSubZZjl4xzh4Gnxs3tz80HuTDJkW3AKTlUJgBHE4ZR286ElN+J+85dmD
BLhZxcb82vCqEjLTp3d1pRMg71Qz70AD1G1FpDDjldi+FxcKIg0WVs3chUd3lfwH
kErE45xqo+oVn8rTbpTxE6VJ+6o1egcoQ6vBvRlscpOjijqmjJOVLNyBVNwe9DOC
r/grEmLPrbA17/VAqjsuLPVLfz6z5ed4kuOJPlbmPsg+QaARPsDP0Gt39TnZGo7t
6CgFw951pTQBoNdge9BTaOMkEyy4+qVbnkuqd1XRUaMZZNLbCDYfDABB62j8jsl3
Jcma1QVc
=S0Ob
-----END PGP SIGNATURE-----

--=_MailMate_B4925A09-6453-4FFD-99BE-7159977DFBFC_=--
