Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1642E496198
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 15:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381394AbiAUOzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 09:55:12 -0500
Received: from mail-sn1anam02on2051.outbound.protection.outlook.com ([40.107.96.51]:3070
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232344AbiAUOzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 09:55:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bP98xSQVNzZy4wEbJStE9UZXI6/E2PnkEe4hxUNBjoK35PCPiWNcXWP7J8YCSNmuz/X+GXwcBHzDLNLTAto+eVO8+5VLd3VoWOtL2x7ZcB1jzvngzRr6/Hc8xJW0NrR8bohL00k1AxnxAtuWddESg5bjDOSTaJnQAQtwgYzjA1G2IWIpEdGU19947hcNiln39wMtLpifQsigMIHOyA9D/P3cfz49Ai1q0KImFgYE5OGA2apjdJJq94+Lt1KaN7ganp0X+Izma83sf3KUaYGlFZBaBt1SBR2RJiOjThbxFyjvcUZwSvYbf0V+E95IdO56DCPU+9MzWrVKa1Oq9dwsjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7FFasz63fy3S029qvh221NF7oNBdpUsSOvC3nJMLERM=;
 b=Mr6d3jx43Nix28ZNDCwwKVZJcbq/fkTBfER3feb+/FQzqpzMXrz2j33x+JYSXLbRvEvLUoTkRqCiWy5S75zIXxNoZHmuull/BAdYK9dlZZFkxdfj5SUTO4ynPJfjF5zFFh52a5VqkpyIBscWIK3khuAtJ69W9SlxzOWUdTputg1MDU0Jek+pOKG4ZOpBCeViH/tvOg1iqCFQCUH6NapNdx7unORBgl2X495BlHF/jpeVRhhks9xSaXiqkGbAaKNBf/8/YveCLPkTXk+PTa6FqvkO8teKOhWe46tHYwVUDPGVeH38C4qz6XQO9sqj/9H7azaCwUvHKLMur9YU3T1jWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7FFasz63fy3S029qvh221NF7oNBdpUsSOvC3nJMLERM=;
 b=Z8tVqUo3scyTzEyUKAmmFVYZYvQ/+6GJCKN5hG2QuDWkvAAH+WMbxU1rM3LhMWyCaFaAmdgho8ZgHm8363WZ0QmK/ofRvtgdl2KocNrilbFeNfWtDvIaifU6B+f1jmrfwnkziczrc1s6yRYnU5v1TUOb6skDnNmeSdtaXf2fP1YaNblkm9BkMqQ4RzQTJMvt/6ZgXrR6UxtTmxSxrc4xIVazB07zIdzjZbmoJfNxmSCK7aurvihxtEBGJRg4gE86irOnJrxM7hjYuVek86t164wAsRpGiFHMa41R4GOeVrPkqH6IlsbgOCOlQmMnXVHoGrCj0fHGE1pYDmxuPrKqOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by BN9PR12MB5274.namprd12.prod.outlook.com (2603:10b6:408:11f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Fri, 21 Jan
 2022 14:55:09 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::a9db:9c46:183e:c213]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::a9db:9c46:183e:c213%3]) with mapi id 15.20.4909.010; Fri, 21 Jan 2022
 14:55:09 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: thp: fix wrong cache flush in remove_migration_pmd()
Date:   Fri, 21 Jan 2022 09:55:06 -0500
X-Mailer: MailMate (1.14r5853)
Message-ID: <22BE9A5D-5777-4BE3-9F2C-F5A722E4F4AA@nvidia.com>
In-Reply-To: <20220121081345.80320-1-songmuchun@bytedance.com>
References: <20220121081345.80320-1-songmuchun@bytedance.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_377CFD2C-6BA4-4640-BA5E-D321AD0EA02F_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR19CA0029.namprd19.prod.outlook.com
 (2603:10b6:208:178::42) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22c5dc5a-f701-49ce-8797-08d9dcee049f
X-MS-TrafficTypeDiagnostic: BN9PR12MB5274:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB5274D7ADA92869A631424063C25B9@BN9PR12MB5274.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pTnnIyLOCRKjly6MYnfe9LcGsubdfACOAkoFqiLh9jaZFCbu9R5lf0WEeKivVy5c3Qn24p+dbZONoZVXyWHhPCOpjq2SJKl0idTufHD92oygcE1v0YmVZ571agg+MEbY7MITn34mbWJ5PU8T6XLp6uIOfo8m3izP6FbE017PAyXyaWjUpQl3/BlSakcth5dYGP0eoIH7AIsygh65EmEAI0LA3DB3h4I9voHzU8PfIXraMX6S67a1soU5XjN9J/X2bEsDcY6ifxfSnfpzamj3wzYZKNCzWZD4EKQRVV0J1/x5W5MbB/uYsOIvClcIl+89UpaY2iy4uYujWgX1V6nQAneFnksVscupxL3LfUdSh/Cxu7f0X2kmUSCOIaWvwN+MCAL7tEqiSOlIbV7+snOvRg5OOpWSqi8nxOSiV8skvXbpzee0j0c+UEuUcSsrSKBNGtme0RamRDEtR25CJfRVp/Js1DNgKQS+so24fJ8wHxPuNwZqCf/pIdzyNmmb0B4LpyfvrxRT5iWyZ2DsUpDuSZ9maOvHzAAh300ZnjiYRy0h89G4Qg66o/8QRpfpWp1TgRJD6fjRvmYZ0/OB5TkOC/jfQ8mvhFXImvei0FXcElyWt0sG2dJQFyAHJnPgLqa9/UVLakeWGJBnS+l/J0bKFIDgbSxlPuilpr74GEyk2yOBU8H1O5FXqWnpuj9/2418VVRSZAjZQKvpS4gH6cz9i/InmyD4BmZMXSKeAz7o3R8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(36756003)(83380400001)(33656002)(6666004)(38100700002)(8676002)(316002)(6916009)(53546011)(186003)(2906002)(235185007)(5660300002)(86362001)(21480400003)(2616005)(66556008)(6486002)(66476007)(6512007)(26005)(508600001)(66946007)(4326008)(6506007)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8eX8rNuiKtXZFs+1nFf8HF9bb2DS+CArbfs1c+EAHyu9Lm4CwH159zUrElZa?=
 =?us-ascii?Q?CQDL9jVygKAHAll6g2RootJ1N8486iX1w1vCacvJdPGfIjhEjggmGfti4FFa?=
 =?us-ascii?Q?0vammPKJqdPo//231Yz+wLuMD0qMFdCFr79OApWVKdhKFDvd6CpCf5pgoA1L?=
 =?us-ascii?Q?3RTjz/F3ZQIUqQijOJWZiBhqzJoGUioncZ6K5RqbTSR09zxz9+Yn/M0dRSBg?=
 =?us-ascii?Q?z2XMlsdKu/RaWwWLAfx2Po+WEKZ+GEKk7RlAkMqUjse60zpW/aSwVppxugMt?=
 =?us-ascii?Q?OfZS+M7/8aI36FaRX6GS4fp2nGnYBgM6e34STL7h7hmLJFw3xjtnk4wPSNVX?=
 =?us-ascii?Q?KTYI1h17V1kMRq0u8CDamDru35Gtp0uSab4rCXZ+k5ruM2ByQMOAKKFNGnbi?=
 =?us-ascii?Q?pBxe7HzscQUzG01qP5bUFabU6sLukQ5Jomr5M5W11jY+WQmf1kpl2NREgNsy?=
 =?us-ascii?Q?G5WJsY4DQdwNkVmib0ykMVFnma/iPMZu61IZ09WCNWFfzgAz0Zn8aZkA854/?=
 =?us-ascii?Q?dWfa5ZrvxVGY+MRzm9zClhDvNY/CKdgtOfcTsS0sGKS5Q+lq4prCNHuNfjut?=
 =?us-ascii?Q?gi2rZ09OxNAb9J9xi68KOUj+GusHmWLITJzRHa7o+NfcbX8sjEDKbJfLrzDg?=
 =?us-ascii?Q?fT3F8VrhBoI6wpaaCJZgyreCKBSaHBgOYXmXMTxjmVrTyoshzKyrtszxqH4z?=
 =?us-ascii?Q?z1z/zK/wN0zi6D2EDSsjh75Ci/GcbI3kHk7XkmY+a+Yy+eAWsWAbPsTPTIWx?=
 =?us-ascii?Q?7Is25uSvtP/tEaWYoH78hT2xgYRLWnnxHFSKuF2H32UnduugeQWf5LpNwIvm?=
 =?us-ascii?Q?GImBcVQoDS8W8NV25lKQhKIiBNLmyqOtr07VFdaGtLvJUepCpCMmb/1XGgs/?=
 =?us-ascii?Q?fNxVN+paa8my/PW2JkWHb20R9YB7/OBbsDzkl70iPq7l/sJN8PZHovAWTPfB?=
 =?us-ascii?Q?FPMjs6g8H2iJZ3JPQPvZLR71Fk8h72yE6tyxkv1KbYztSzvvS/nmd526Qdjk?=
 =?us-ascii?Q?Xi9bvuczcc8iUGDLJLKdGDwKpH3BdL4RCMEVxDpyqL2IwUBvaoVJV70FQ+BY?=
 =?us-ascii?Q?ZVOQKFAndrGOPAxfSBl00hZuQgcKI59R5oIGGCyu0FJ+vJh2A8D+V//K8Yk6?=
 =?us-ascii?Q?zC2foyoV/CjqYSmitSuCYSWYTcv1m0guAzgoI3gozkfCS+E+l5D5BBCoFXxz?=
 =?us-ascii?Q?Ywje7p7AphXcqOGJCws045C3l3PASkd6+xZrSra8TA10O/0C3F+inpECx0IN?=
 =?us-ascii?Q?SwCbhVC4Edz4KkhXOgg6KOHMc2Ct+KNoQ3YL/AV2h7nRuGaLfrRH3tFVlJa4?=
 =?us-ascii?Q?544g04zavpWh76SDu+D363DW3AE0Q9/CupWCzLYud/qQpiC+fXlIjZh6E+M9?=
 =?us-ascii?Q?a/YKdeUUrPzCfgsI+xRjVvC7D443ROAccqjyDcNk+iSw1XgjBdtk845Gqad4?=
 =?us-ascii?Q?HjTOgyjxK+Ac8JsMG451h0sp5QqiR/pmGI+41BuIWjv0PXOabajllXNNAplV?=
 =?us-ascii?Q?k3kj1daddoYroDEzKJ0r5AEktDBqveqI8k/1ijXUZQZB8Y+7rzo34P3X6vg1?=
 =?us-ascii?Q?58WtLO13zVS+Exc+Xb8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22c5dc5a-f701-49ce-8797-08d9dcee049f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 14:55:09.0495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jvm8FIfdfRH5o+24pH+oRZf2iP+QtsaLstol4fhjKRmC14V8w/eofH3LonJ5Pyu7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5274
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_377CFD2C-6BA4-4640-BA5E-D321AD0EA02F_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 21 Jan 2022, at 3:13, Muchun Song wrote:

> The flush_cache_page() is supposed to be justified only if the page
> is already placed in process page table, and that is done right after
> flush_cache_page(). So using this interface is wrong. And there is
> no need to invalite cache since it was non-present before in
> remove_migration_pmd(). So just to remove it.
>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/huge_memory.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index f58524394dc1..45ede45b11f5 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3207,7 +3207,6 @@ void remove_migration_pmd(struct page_vma_mapped_=
walk *pvmw, struct page *new)
>  	if (pmd_swp_uffd_wp(*pvmw->pmd))
>  		pmde =3D pmd_wrprotect(pmd_mkuffd_wp(pmde));
>
> -	flush_cache_range(vma, mmun_start, mmun_start + HPAGE_PMD_SIZE);
>  	if (PageAnon(new))
>  		page_add_anon_rmap(new, vma, mmun_start, true);
>  	else
> @@ -3215,6 +3214,8 @@ void remove_migration_pmd(struct page_vma_mapped_=
walk *pvmw, struct page *new)
>  	set_pmd_at(mm, mmun_start, pvmw->pmd, pmde);
>  	if ((vma->vm_flags & VM_LOCKED) && !PageDoubleMap(new))
>  		mlock_vma_page(new);
> +
> +	/* No need to invalidate - it was non-present before */
>  	update_mmu_cache_pmd(vma, address, pvmw->pmd);
>  }
>  #endif

LGTM. Thanks. Reviewed-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi

--=_MailMate_377CFD2C-6BA4-4640-BA5E-D321AD0EA02F_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmHqyUsPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKMKUP/ifcU2b+hUQMYoOHzLnSLwO7cR4xbvQJeUG6
uq/25KjrNrTklFhOkM3BWZeBUXrNFA1lw8uRrtHEoMMCajxN1QDWxuR+ReO73/VH
Z6RrXrzmqyHunscMGKTZulPPWS4+BdfwlqoPMZoRd8+7ylorxKMJiXk5WKMiUybF
/SO18f2Ja8LeMGqQb+zbjPs/ljeDa9Cw+I8I0uMfr66Z/9shx34oRDMn9CgNSWgk
QdDyZ9GS5lhXcE79qtBEdYmbA3GHrueW5Ex52CxbmOxAQQuL1bJxEg6VelIbEk4l
WPZvVq4/4j54+/n9xlNqUsvfraAWZmiEnekvfm4k690PyOfJjLfM/lOKUWGRdSlP
BwqTR8/hPgkOoB0Ffrpy0iiC2+1vHlaia1547hpWl8ULxbinIebdAyt75Wn9BA6I
TFZm6eF6HSvT6BIfrR45Tl+UeRD6Uari+poG7QOAfs7UL79qFC5FUv9EINGLXsWs
iO0DyaQRhRYSJafMgz8nuvHxnY1ATW6tIH4fQ1npuehNGQmkEw+He6BKYG0QM7QU
SPgmawlF2aM/rRHPBwzrPuPOgQpLGJ4Zt+Brf2R7ebCdHys/CGpfZTxrCq5mNxXO
Y1HTtkAoyRdoL3eJqpep3eRVdckcmlO8sxkRTmPxrXf33s4iKwCyimQpoBxqPThm
76Y9wpIL
=XmVw
-----END PGP SIGNATURE-----

--=_MailMate_377CFD2C-6BA4-4640-BA5E-D321AD0EA02F_=--
