Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECEF64961A8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 15:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381440AbiAUO7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 09:59:30 -0500
Received: from mail-bn8nam08on2060.outbound.protection.outlook.com ([40.107.100.60]:42337
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238192AbiAUO7Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 09:59:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AAKKniWlliSNkrQB6E7gjAB6+4Wr+t8ve/11pUMsLtN1EZExh5wr9PwuUrzEN65HCy6nCsMEd5zuILEUN3hgnbngh72Or9m1PnBFDqRG+qVpbPsl7jIxT2Iyqfk3cwwpLTIE5mbfImdSShfLiIvsW19Rik4gIc/0hJekj5j166gNJLI03eR7/0mJ5LC0KCiZsC3ial4lWuFbMGxMNg7MpiAwtsXcfiFgkNDbv6JnzGzqDmkwuGsyKvNxJwEmPkrSyL/uZUyAnM5FiH1AcwsfTS5eQu4zL7j592hmZ9g6Ew56HC9+75lObPMX61RLX9VyuZeS0cvuC5O+VzDdHnhNNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dZuXvZx2rx3DG5k/6smiiRsF6QLoyQIsA1HkMmwUvZQ=;
 b=RhnY/g4bJ4WXresa+MYNy77QPXWhjzNn7O0xagdeJqjuapabd0ciBUcXwgf0a65JLaYc1Gi7cwj4DFR/MzkOxwOYsBcuyxW8uuYgZPISckRRDWr8rsX3KgcdeaZ0LxmUzempwh/u86AHkPoMQyvXoKBlq8PFZuDEZxy4gUiO98OSd6l28ttJCv8krHFVypY8MLj9MRZIWB4C37zzVbGMuP7pCGnRkR1sqxrh41yWcHrenxns3ZyUmIBDrZ5okGj8+7snBy+kmZiZTXkYd7OcK01qTn0IHMlC8HeI5dtqBaZN/VVeqf9x8n/37CKpIUzBJyQH4fKPX1LfNEejpY+LrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZuXvZx2rx3DG5k/6smiiRsF6QLoyQIsA1HkMmwUvZQ=;
 b=grhJ24RvMLkJnLhvtMdxuAoEdTfDOr4Y0/I6h/9IGJd777aohXUeGGttX6AcwkriRLh4Zr4ZAzbaj4s8+RYgrAxIVLllGOIzr6OgOggA22KmpnN5PDjgFpE6KXoAGD3N3FvchD96HlJTiCFBxQM5i3XexmsIJF0QbwY67mGydfCW9IrCVLsv+lnVjrrFN8BCg29xoaamOmvOYZyGaYFXL6feU9LYDxEb4YS8A/Y3OkMf0Jl5s7/BxeOhRD/gtd4O/tODAeixzTplhXVLt6rMoPGMAQZ6X09oYDMvcYjmmp46GUaU/WhGJAE1g6BKXhGai4CXEGnS+w1BLG3DVyBiiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by MWHPR1201MB2494.namprd12.prod.outlook.com (2603:10b6:300:de::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Fri, 21 Jan
 2022 14:59:22 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::a9db:9c46:183e:c213]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::a9db:9c46:183e:c213%3]) with mapi id 15.20.4909.010; Fri, 21 Jan 2022
 14:59:22 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm: fix missing cache flush for all tail pages of THP
Date:   Fri, 21 Jan 2022 09:59:21 -0500
X-Mailer: MailMate (1.14r5853)
Message-ID: <80208467-D04B-4215-9C5A-8BDBDB365853@nvidia.com>
In-Reply-To: <20220121081345.80320-2-songmuchun@bytedance.com>
References: <20220121081345.80320-1-songmuchun@bytedance.com>
 <20220121081345.80320-2-songmuchun@bytedance.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_477A3799-56B6-4CEE-9BE3-74405336E458_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0152.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::7) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d247faf-54d9-42b0-0886-08d9dcee9bd0
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2494:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB2494446F6D1BD9AAC5398F53C25B9@MWHPR1201MB2494.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VvictvghVZYhMPw+CFhBsNMKiQnxNacZXymHoHHN8MDn0AzpH7eYqm+PO8Za1tJeNDZducgxlZf7xPNDO0QQ5TbQRReb5XT1OgAK8NRi1zuP0YyKcc3m4+DZ6YmXLMwzpn65Whnlw9NvVWMLO6+xTxiVtgM5Q/JjFUlSnkY4LnBuJQP09nUXAwBpSccY46v05vp3UfAtc071HkX9BSb9RB25SFzVZ1kR8BC7uvOA5MmMlqaBu/fkhTU1Etv3kzAjG6B9RoPwIRRugyiYvi8t93U5xphkyLhIdvulKAHpZpKlGsif2DFPR2A7NisP4UpbukXcsX7wQhLJaL1nrf9qnKBBgj7wJGqTwd+xdh72seTvnJ3lnxzW4E+VKZtkl8JnL/aNkxtsMNyElGc2tbBvFgcmeSxrr1PEpL3HWlZDtiBr9t4gBWyUUBmN3JgeTDk/QtIt4oY4eyNp8GNP+4d6ihjUyrY8UecQNHA27d1+i1rrhy0dIiYt+wFNTa6s0j63k81CXWltaCTCIthr0Kh7KglDnx4dkLTNX4s09mpRwO875ENsERV+rBr8W3xonC//CZv7Yj1VaIZCk6eU5BrYu6TaGHz+TEptnXkkumbYFfisdXj++cKm0G3ia6Fj/ygY/49Mh9yEolWMaYOR63Cygjf/THgFWjCdq4rczDDZRqCd+mGbxQ7GckB6KYIZ3nRfkip0mdDDBOVmYSOe1PpduhFfnmIYVdr7/UOyDNmtpcY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(83380400001)(508600001)(6916009)(2616005)(5660300002)(66476007)(2906002)(235185007)(66556008)(38100700002)(33656002)(4326008)(6512007)(8676002)(8936002)(6486002)(6506007)(36756003)(53546011)(316002)(26005)(86362001)(21480400003)(186003)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?teYkbHwloAo5CfwAX8UrdKdTyNTUcn2As1+6wGwCsrvO7bhVwLWqc+/fus3p?=
 =?us-ascii?Q?1aR6Smw1EFWiWiIq2uREjKHPPMSeUmXRiAqnLDug91ozoxBl+vRY0KO1oWAz?=
 =?us-ascii?Q?Jb6dig7bUIui2UoJ80qAzCoTrYuVq5EtOU2dbI07N0qkqqgAE8ZNGG0sx6Xs?=
 =?us-ascii?Q?D/Ecavr9vT+Y6PsMrCus178momGWWhnumcnaGP/vb19pYpVKDUEz8Q1zml5r?=
 =?us-ascii?Q?UUPuWTK6oSUSk4o9YURr+0OUh629UtehDIdS2jm0l0UaLvnMSfSV7oYwWdGk?=
 =?us-ascii?Q?SqYMod72Paz9Gb55qj0OcImOKCD0fHNR0YDS6fNqzA+Y3pDp6d6maYpEDhbZ?=
 =?us-ascii?Q?/2F+nq5PGcqdBNChmRfFooxYTbZGIlWf4rJ5PxFgb+509/8WONlmbD6Tye2I?=
 =?us-ascii?Q?u/eXnqiqCpJbQFuA5gn8GkIbGBWmZ6PSIISc8aKH2gihfbqxjLEVAgYqxtfs?=
 =?us-ascii?Q?miBC5mzA8PLsjNiyYMy+wRTRToSNiixZCPNZhpJ83v9Sur/kaduIaFvsGl0+?=
 =?us-ascii?Q?s45ey5VpJNzgdG71UFO9i9TQel0qtLA89iZ6n9mM68pEk0/VZD2vOG2CRp9l?=
 =?us-ascii?Q?cgpcqkyhWR1rHPALuHqxmpEZXwMtlfWTTqI5GWeScVC098k2UL0y37RSj38L?=
 =?us-ascii?Q?TGgta3FsnbBNPLB2qH2rhfWfLjfYvlokHCcSSyp1ONigOMehSZYdI4tU6ixy?=
 =?us-ascii?Q?HABiF/d0XFS6QUuuzPNFmq5kgU0sol2FhYrqJly+ab9lim3iP/etOkJFwcjz?=
 =?us-ascii?Q?cSTKD9SnDNyIaInRlswOteqoEij02FVptZKZnE9pJrcFJ17ZIc6Wm3jlc/Pw?=
 =?us-ascii?Q?zgTJXFAqGmWzhSV/K47lMWA6MT/gGcZgfDqdSzIbWwv+XjFr36HinLJVWPcT?=
 =?us-ascii?Q?JgI86wRJiwDOcCdwADpnfDHSi9OhQuFgEvn1zJJ/a0ItoPEFyXUiihax5+eB?=
 =?us-ascii?Q?jNoGg7ZqlShHfcvv9lWapNmlYYNHbBqMW745wcm3h+2CJJlLIHV/ycRqSWKL?=
 =?us-ascii?Q?7E+oVMyHRya9BTvtjn0uTc1yYSta7Bza6KLfwuxFxR3f67cDy06YWcn+GpQs?=
 =?us-ascii?Q?U38+labE4/iMRVBFgL7qUbF6e/coNDPX2o0ZTM+oCYUkGLvkSJd0KQehKcDo?=
 =?us-ascii?Q?f6DMO42ALrtF6Hk48tVUtjNqSah99NjecuJjPY/rCK7VEgavVuPteVljOdue?=
 =?us-ascii?Q?PIl+ThhNkC/ktWGhWh/+cQZpYv7LFFNV8Oq+OQek1JH6iNIDUA0Lhae52Ftp?=
 =?us-ascii?Q?rxIdaRvzcfgwchRoSYlC2nusbcU4zMuI82un2FshQHUkBc/XLaNUc/Wkmiqw?=
 =?us-ascii?Q?SVyO8t7pZJiwY/uyPYqt0IzvSvlpIyu4gLtpLajAZXUKacMCvAK+lZ67rI58?=
 =?us-ascii?Q?mJW8sC0B8Eadf5cR8auWQxURtyFZ8W4R8Y6Gs0b7DuG1W0bUHIo8pOqiofWH?=
 =?us-ascii?Q?BWFd537+I7FL78oC/mdpqOYNj7iD8kF6jXW5kjmIzfSLIybOWM1CTZmWTolY?=
 =?us-ascii?Q?sPf9mzkiTEx5Tu6HAgIoUMDUDAsHufYRjFhmMVW6Q77xbG6SWCdQGTjfVlfs?=
 =?us-ascii?Q?YMrMJtBxLVkG7Y1NJ/I=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d247faf-54d9-42b0-0886-08d9dcee9bd0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 14:59:22.5783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PCMGFwJ51H3K/Y8RmWiKGhEK+mAOUqhsYm4uu3D5cm9BMjykPtiBIO7Dhub9v59Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2494
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_477A3799-56B6-4CEE-9BE3-74405336E458_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 21 Jan 2022, at 3:13, Muchun Song wrote:

> The D-cache maintenance inside move_to_new_page() only consider one pag=
e,
> there is still D-cache maintenance issue for tail pages of THP. Fix thi=
s
> by using flush_dcache_folio().
>
> Fixes: 616b8371539a ("mm: thp: enable thp migration in generic path")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/migrate.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index c9296d63878d..daf2b3508670 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -934,8 +934,7 @@ static int move_to_new_page(struct page *newpage, s=
truct page *page,
>  			page->mapping =3D NULL;
>
>  		if (likely(!is_zone_device_page(newpage)))
> -			flush_dcache_page(newpage);
> -
> +			flush_dcache_folio(page_folio(newpage));
>  	}
>  out:
>  	return rc;
> -- =

> 2.11.0

Yes, the entire THP should be flushed. But it is better
to use a for loop instead of the folio variant, so that the patch
can be ported easily to the stable trees. The for loop can be
converted later when the whole function is converted to use folio.

Thanks.

--
Best Regards,
Yan, Zi

--=_MailMate_477A3799-56B6-4CEE-9BE3-74405336E458_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmHqykkPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKAcYP/0kIU8xflB3akw9CS9saWJrB4HiZs4MCBRMt
9QkbyFK11EOXWv3LT//nG5sTXZDmKxOLtZZIvW30s0Kvefr8FZydO8bBay2n64ZF
au6psftiRE1r2JkOQDPMgFkTFj8lxGEOrp5uQxQDvs7IRg4iRjkAxGS+5FJ6ow9O
8orPHcMXLlhFc3+7Mt2q1UTfIbEGoCX1lj0mFTSOdsFtHDfrm+Bx9ks+JZ8988pf
NPu55FJzqoTXa2Mt0stismpKQX+5m4k0ayDdLWnZANeYfRZCijpxFOAcbSLznrMb
VvrOPUFajUqJWJD0LSul6bPO0X9G91tMowR+ZInFIt2JkaUBKqvw6QHoLRqqb/QW
lTR5sIgLtT/KtBz8PylORTSNvVLAV+BqRI/ITQEVHHNNln/mTjf9COY9itKOyvZ5
n3jWoTbEA4eUrQ4VwyYO4P9C6hPPDCktWKuNs42NAfRnWFXELHAXaKco0zl2WBmh
TcmETjzSWP8yWJHb3EuUaGNS5WWg2N46xLKybfkyOvRGCdHPtflQh2KRBLsX51nV
Iv6irF3i1y44pH1JYkyw2PkooVPd9mZFy9baQsGGBeLioQRjg15VMWQpFTrSl3SH
AvVMnLNxLzNvQRx+ZQlyvn2ibyn10BTTum/QQ+Db/SDOSHU4jMOHMxKBlxpvAKMX
5gzoBa7H
=Vi02
-----END PGP SIGNATURE-----

--=_MailMate_477A3799-56B6-4CEE-9BE3-74405336E458_=--
