Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFD1495147
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 16:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376428AbiATPT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 10:19:58 -0500
Received: from mail-bn8nam12on2078.outbound.protection.outlook.com ([40.107.237.78]:12481
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231292AbiATPT4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 10:19:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QvGxLIDb7GReutUwBW4bXY55lLC8oyWwaqFlm34isUWnzYDzrje3gfDfxI0+BRv9VrCHI4pqCVfaii6sPTKTX9b/XdOOpYxZ6y7gf3Ok18+L/eu3Mra+Yzy1imzaT9cpG/KJ9ouNTmTelirYmGZxlzXdZRvxOvq4KbUAkSu439V/hMwI875AURh6B/wTqpz3hg4qvV3X+Uiv8G4D2W1J1KNedTSVjp5PPJSBLCNryIoKPayCnEMqW3xiP5hkB3G5eC0BbOzHMeh1pRKoHiwnKUL/PSEEyotwlvJYrrcUAHq16cKqHCQpUXZmZWcEElySipuC29nOTgKylVViq6XcgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JLluIJHeVZKrk4ubl58sjcv5+SI6BDjDQhI1IMm463s=;
 b=gI4jTYXtmxTiui9p/IsKE0NIKdVpdQJZhOtTcMSnvReyNFQ8LIW4Fd3kGYIYgvRPuLd7s8F2luCOs97wOJPr78vSanihoUjKYjxPoZc+1azANUsk/4YiAoelNI6kD0CaAa/T58XEdqF8Az/AVawzZvRp7DE4vep5zB/ehRoZjc2zQQXlHADE4/9ea4AL1Ie/u/rBwyFKrwbLjQoyh+nq7aL2gFSSdTyGsuZ3Nop4hLvElyekwKb6M7k61o8LvtgJyz952UwY1xlnp6gbaT9XGYB6DMKgMqm4CHQ/wPGJEtGrCUOnzRHIL71ZrcWPw2vs6ce61XqC8hcf8CSFYyc0rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JLluIJHeVZKrk4ubl58sjcv5+SI6BDjDQhI1IMm463s=;
 b=CRB8XdTykYLyut4CkODcnzk99fne/dlev8OuHA6aoMZ7VYL0Y2wcdojGRGbJUjYsc5elePYUnaP/5ODMkjqx/5Pj8XHsLlcK1o0oemEMA1HDWgn/SurA+7r5OfiAD9GfYr08lxgf57YqCrmNu6Yi8arNKc4SXuX78KDmkL7N/vecouzKx8ErPoqmUmPd5+aBJTL3s5fFvUF2lXEqaxd5hfVZfpBvtYBAmiokqHNWpzwolHW/JwV4GkJzEQhYrzIUT0txrqL0KAwTJZS6Pc5KzckFRYKABr/+UGVElL1aIBIE4fxPwYwQP1TZyCvWqaMOvlLSe70Mm7qRWm9jpaH01g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3819.namprd12.prod.outlook.com (2603:10b6:5:1c6::20)
 by DM6PR12MB4842.namprd12.prod.outlook.com (2603:10b6:5:1fe::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Thu, 20 Jan
 2022 15:19:54 +0000
Received: from DM6PR12MB3819.namprd12.prod.outlook.com
 ([fe80::edc1:f6c2:1e17:76ae]) by DM6PR12MB3819.namprd12.prod.outlook.com
 ([fe80::edc1:f6c2:1e17:76ae%3]) with mapi id 15.20.4909.008; Thu, 20 Jan 2022
 15:19:54 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, rientjes@google.com, pjt@google.com,
        weixugc@google.com, gthelen@google.com, mingo@redhat.com,
        will@kernel.org, rppt@kernel.org, dave.hansen@linux.intel.com,
        hpa@zytor.com, aneesh.kumar@linux.ibm.com, jirislaby@kernel.org,
        songmuchun@bytedance.com, qydwhotmail@gmail.com, hughd@google.com,
        anshuman.khandual@arm.com
Subject: Re: [PATCH 1/3] mm/debug_vm_pgtable: remove pte entry from the page table
Date:   Thu, 20 Jan 2022 10:19:50 -0500
X-Mailer: MailMate (1.14r5853)
Message-ID: <0839D3DA-61AF-46B2-94FA-748BED4C9E0E@nvidia.com>
In-Reply-To: <20220120042513.1648831-2-pasha.tatashin@soleen.com>
References: <20220120042513.1648831-1-pasha.tatashin@soleen.com>
 <20220120042513.1648831-2-pasha.tatashin@soleen.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_FCA45BCE-0618-499B-A2EC-C2EC20EA2454_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0432.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::17) To DM6PR12MB3819.namprd12.prod.outlook.com
 (2603:10b6:5:1c6::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f74fa1c-c3ec-45e8-191f-08d9dc284f09
X-MS-TrafficTypeDiagnostic: DM6PR12MB4842:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB48422A4D4DFFDA7D5610D4B2C25A9@DM6PR12MB4842.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HTjGP81ejTkVaN+gwYoXR/fLCfdhgSWT2t2Ep5ser/YRpN81jDMuTkkB8aKpCfxyyzCmDfzAYTaSoufKwL/Iri/QqFtRjH9yDyWutN4fa7lEMYvq2/RozMHdJgFC7KxrB3+wc/dOsYuoC6g497rT49GrFOyr7CoJPDeslLTgl18LHfoPoZSIXD3tRSt8JmvDN1UaitKB+X18FkglfUDG5H2usGQqjqr53+DE0jPHK4nvT7lCgE+00hWyN0brJSfrtS0VxLypxdrfN9n3Z6sJjQRDt45fZ/TbdlnaE8iikokPFcKQRLmNiGqkpbzM2A5NXAV0bc61OnYCCeTqGmX8MOC8W6pUV8FAcwCJWFwiXFVBTVSoq82ALPWfbYHEEGiFEC+5PWSrlS883VZXwG93XEuPQYhrNoQsUPbGDYhlHXRSOTiSoxDApHt9NCuA7KejdyO2xGiPIaoQKEQtgRZd7rQ1aSbUI164oO9tgcCCU4MB+MAjNHeSDuzrTW3ospopyC6p8YTDp6oDE6xUQt+G3qjzA4vHmfUffqLnyzo8Bytpc+9UKidEh70cX0TPX9C/j8MopUiQlTZavqKCppu9YvF9uHxH4hvxCmtgr/bPf0OVfXdas9u52NPYVHHNAdFvuNukKL22n11oiZirYYW5zRkwlu45fVQW6fl2Fz5cbKDCkIVzKsetBUWhEzQj4bq4p1orUG5ZwOsav3ed6jnu8NjD1S9TBNYSo7qsEFijTbM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3819.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(8676002)(8936002)(26005)(6512007)(2906002)(7416002)(316002)(5660300002)(235185007)(6486002)(6916009)(2616005)(53546011)(508600001)(66946007)(6506007)(38100700002)(83380400001)(66556008)(86362001)(66476007)(21480400003)(33656002)(36756003)(6666004)(4326008)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rYTlXw0JvzrYkwOitJJl5xxMkN4R25Fk2W0N1+vd86UIP3RxSJGdGoaTm1io?=
 =?us-ascii?Q?SmuEzTZIWKwbm6hojzASGSRSXUmhFoAqXJ1MuekLmEx5dXJW+dbjSY3l3ewB?=
 =?us-ascii?Q?ZsFrZNQhCeCbORsXnk4hQCwuL4OA8qJ4Sh2eE0gFlNTKYxyGcndjYP918D8F?=
 =?us-ascii?Q?ZVt8K4w3K7llQKm91DBl8sN9GnbAEPscUeU6PYpUo1blB7zVJ2yH1hLQxZyW?=
 =?us-ascii?Q?QBzygrPfQwDUG510/hD58bFTMe/PkaYKAWaes3z62QbMW+nNHw43Z9jCWzLt?=
 =?us-ascii?Q?xzD2H/ii/GXfPRXHyG/ywkEKCH0+eLuXKono0imNWBR1O1DJbZt4No5fmUGf?=
 =?us-ascii?Q?jmqNB29yA8iwVbtIbrXjvsqns3G+38Jx7p6c7TaP7XCEPh0F3I2MpdO3BFzj?=
 =?us-ascii?Q?B40qZxWWI9Uq+8hkcRz1RJLkl+jF2EsWCUtOXnNAOXgzgX1VnpVNVGj6izT6?=
 =?us-ascii?Q?m9tewQCvYOlev/7CsIqz3Dq4JL3MbesFBq3amuxwM3K3dgNVEGl7gUyI8SM9?=
 =?us-ascii?Q?C3JTQ2UNO7wqrPWHe4tw8DHr3M6JN7b9fH450f4CpQ29QKFHc6o7Ug/RMz6L?=
 =?us-ascii?Q?Le8n43gL5br/kcTDM9wNc3j1INHAI8/SShRYkoKXADjWkygm3s1uMkSjyb1m?=
 =?us-ascii?Q?6OM9QSuPxpLWx0q11oag8twoVjXkv2cVU8yZMRPxIvco2ZeRTlbI2wVdJDUA?=
 =?us-ascii?Q?rBoXOKyoQEBNusiKblbIJu5h006kf2F1RftrMBE6gp9Ef9unr9iDnhppKd0o?=
 =?us-ascii?Q?1sHLZnk6BmhTrXXwgBY3osi2fkicokEerVb8Ube5BSR7tupKXMDksyIB7myP?=
 =?us-ascii?Q?BtAWNq8SBF08mYMiZdkqLN45fTzcTN6I0iO+v2wB19rSSiMBPbuwHKfyYMUh?=
 =?us-ascii?Q?aq3Ku1jq00TxaaAUveX/0Go5Y+wSMKF3zBDL/QE8H/l6SAPlBqb8cYN7tJtj?=
 =?us-ascii?Q?/XpSh9Fib53LG40lUKZNWlVy3TzHVwiRMrZ4Hh2g5IXDzwM0e32uV89QDlXd?=
 =?us-ascii?Q?4qOrjRO0xFnGI3N52l0JKugfDY5H/4drNNKiNFMykah6NJzWb3PZ3iyvmdRV?=
 =?us-ascii?Q?531/zc/R7w2nFqn3nx3G0jyDT2FAFKFOzouDbieKblsQ3diP4gOmNcq6ZWL4?=
 =?us-ascii?Q?BwFNNlgY0MTtGJmXXs6YJoW4x2ciqk6Mi23cMudr2xclYT9xS+4J2pecaY21?=
 =?us-ascii?Q?7zVoMK8FJ/O85mgX7rmHCWARV8Zm4X7Kotd82jO8IaWrA8Cd743Ii9jDXndP?=
 =?us-ascii?Q?rgXaIv+b7L+limzsxr00u4oqJUHN8gpuZXv29fg3A1mIQlC97rRk1KjJITH7?=
 =?us-ascii?Q?TuC736YIJR60IgYgJrzE7KJmY5kfHG93uk9d/TeaEE12P/umlTVB5MGgm5tF?=
 =?us-ascii?Q?/5EEabu7LaOgzm+eQgJApvjXhkEAM+n0WCuzVyEqKS4+m7zJ5//mM4v3MJWG?=
 =?us-ascii?Q?1AHVynlqB+UuCEitVe14medI88KIdvKHGaPw65lIbCbnomtYMn9Sfo6yJXkI?=
 =?us-ascii?Q?QGcAjyw8Fw85Yi/RjTF3PwyUPBj1v6hGGMf/Oza37sB0UG0Yn20Z/PtQk+bb?=
 =?us-ascii?Q?jA566NAW0gLJYRsvkq0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f74fa1c-c3ec-45e8-191f-08d9dc284f09
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3819.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 15:19:53.5003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UAAjhWCIoBandAH1pUcY05EsHQU6i5p7giL8bAiF3UpUVB4ppz2k/DnQJH/rz17P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4842
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_FCA45BCE-0618-499B-A2EC-C2EC20EA2454_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 19 Jan 2022, at 23:25, Pasha Tatashin wrote:

> The pte entry that is used in pte_advanced_tests() is never removed fro=
m
> the page table at the end of the test.
>
> The issue is detected by page_table_check, to repro compile kernel with=

> the following configs:
>
> CONFIG_DEBUG_VM_PGTABLE=3Dy
> CONFIG_PAGE_TABLE_CHECK=3Dy
> CONFIG_PAGE_TABLE_CHECK_ENFORCED=3Dy
>
> During the boot the following BUG is printed:
>
> [    7.483050][    T1] debug_vm_pgtable: [debug_vm_pgtable         ]:
> Validating architecture page tabs
> [    7.490930][    T1] ------------[ cut here ]------------
> [    7.494926][    T1] kernel BUG at mm/page_table_check.c:194!
> [    7.499172][    T1] invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> [    7.503610][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.16.0=
+
> [    7.508600][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX,
> ...
>
> The entry should be properly removed from the page table before the pag=
e
> is released to the free list.
>
> Fixes: a5c3b9ffb0f4 ("mm/debug_vm_pgtable: add tests validating advance=
d arch page table helpers")
>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  mm/debug_vm_pgtable.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
> index a7ac97c76762..f7c5970f1719 100644
> --- a/mm/debug_vm_pgtable.c
> +++ b/mm/debug_vm_pgtable.c
> @@ -171,6 +171,7 @@ static void __init pte_advanced_tests(struct pgtabl=
e_debug_args *args)
>  	ptep_test_and_clear_young(args->vma, args->vaddr, args->ptep);
>  	pte =3D ptep_get(args->ptep);
>  	WARN_ON(pte_young(pte));
> +	ptep_get_and_clear_full(args->mm, args->vaddr, args->ptep, 1);
>  }
>
>  static void __init pte_savedwrite_tests(struct pgtable_debug_args *arg=
s)
> -- =

> 2.34.1.703.g22d0c6ccf7-goog

LGTM. Thanks.

Reviewed-by: Zi Yan <ziy@nvidia.com> and Tested-by: Zi Yan <ziy@nvidia.co=
m>

--
Best Regards,
Yan, Zi

--=_MailMate_FCA45BCE-0618-499B-A2EC-C2EC20EA2454_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmHpfZYPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKvyMP/RNQ2axMF35sL4wQe1/6OI2nQW09LzelWg/9
Rs7XTXPybxxB1ZoXnlAEjbmg8tR/b+V5vd2ToGjveEtPCB+ElFzrDroGdgt/kW+N
K+RtLpK+DYvYiEaznTLzJWUeY0RJjA4w2s7lerYA3+S+qF1Itlh8jsQ/gSeq+fjL
KRgX/vAYaM+NfIxxdsToPwVcLST0DOuQt/QBhCRSHNfld07UbKK5whiTSsglkR7H
eed/vBBI9yEJK53FJAUJXEQy+8r5YlRmi4reKOy1hvLXybm4Mi7kINODJraIH01H
40FCjR1vVPqvpDYyILrARGkTwBIDDzVWxwWzfOaL75IIuyfHBVOStqwRaUgOgcrP
dHluZwE9Q2/0e2fHwDT/Gi82MVSRIgy7ip1YUV8hCw9/ZKbXWZYkUG8Fv+j9Q3ia
x7xVWzcYapfUWf/660+HI9Z7K1HPVQt1OnHiLoduF0EGEVoDZ/4NYkT92oy4lA12
7z+1STIGK0EklbTBHZveUhikkWzC3qDhCBRO0z9deDMCrTzVYoQhNPe4GebF0vlb
u9JNZSsEvuq7muI+4j9Od+HM8WBgnSLleH9y91guFhMOiKVS4KXaFpIzVDQVYIVx
QbYSTs3ytesVGNluAH1wvhl2SAr8oAIxeAYQ3Tdgx8UmHKkgt5GhuFYFec0QocZk
xGxWesiL
=z0KQ
-----END PGP SIGNATURE-----

--=_MailMate_FCA45BCE-0618-499B-A2EC-C2EC20EA2454_=--
