Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28C1B49843B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 17:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243323AbiAXQHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 11:07:40 -0500
Received: from mail-bn8nam08on2082.outbound.protection.outlook.com ([40.107.100.82]:58848
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236170AbiAXQHi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 11:07:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VjQOgSOfPEDYSKreq4HRZ50E9sgIkeh6QV0M+xx4E1wg3aX+etzaBLTDPaIvHyb7/Hu7mQ6Y/syWxjTkvasuQM1SmkHubT4A5yzXXG0vF2BJRR++B/pFXAVAm6Rw9hzjReecGqAaBPn9CgGFqiboaNRJw1mk2gh2NMUTjcOP3U0HBvs3jzN3V7UKyzfBzsshXGqGaX1ngS31R5tpleANWyw3J553ke5CDUVTOOQySKLX+ZmlXi0AG7ywcSACan0M8CLtn2BC5YCNfSad/kCRIyHIoEJ9kvj90iTJICkd6Bnt78R4HNrmWhmudozetI1GUq99HYuHSDjL0HZlDKlVoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=InWxZcQ7w3/rd06SeMSddmGSTexiNW3XW7qGk9LKhxM=;
 b=jOOh0EvT85v1XMpgzLePdXydDZRJLnrD4GmAIid0aiZq9+p1pIOcbUMfaZXRrhW3Y/O0GPhbvSk/aVz9zp+VCm2aqmJwLZx8e1ohZAxE1uk6tjWQsS6SQZLlisPh8PJ9sV0OlBU2e4gkwqPaBSRW51d+5sVxIDGQyjaGmCLwrIt6w5YkKtWR75ygbfS5YX3upVn73/r1ynLRIGqDf8JW9LXkhOZElJEbU6Ye0ZnEuAvCfbAsfjPZER7DtDEWZ7hVXFxbcBlmRmsm2YV2ECnAC2Uf9fz4Oull/DP4RGyPgI7GobzOlXWauRFvXVooOiQsbk73Rj9l79EiJjreEVEJcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=InWxZcQ7w3/rd06SeMSddmGSTexiNW3XW7qGk9LKhxM=;
 b=iSni84A7+xST6vJrf7LbAxWVJgVwUXk3syTYA/xGVHY1Kn20/GfRiJDXxsybgN2WvjzZIUw6yzUai+wmqd8GdxJfYIS12N8j44hmlGVWG6Ge4PHytaE48wqq0K92l6QQ2uQ+QV0A6P6hJOSpv836tFhJn0VV2a+cW3kXWVIvZ1zaO1uVNnVetw7FN71tL+5rZ7+qjF7ltOSBvHbDKrGV1GWy91CFiN/8x41dzpozLc70dKzp4iQgOKIWiLYh4xbPZnkBNQJ4A6ghKkv22tNh8q2tCNCCExLiuVxKLdnZ07rXzpQirpw/4FhexHRlTZHv/r0naahPuQCCA9PMUSaOeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by BN6PR12MB1905.namprd12.prod.outlook.com (2603:10b6:404:fe::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Mon, 24 Jan
 2022 16:07:36 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::a9db:9c46:183e:c213]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::a9db:9c46:183e:c213%3]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 16:07:36 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com
Subject: Re: [PATCH v2 2/2] mm: fix missing cache flush for all tail pages of THP
Date:   Mon, 24 Jan 2022 11:07:33 -0500
X-Mailer: MailMate (1.14r5853)
Message-ID: <1F326ECC-9F85-40CA-B731-0945BF071FBF@nvidia.com>
In-Reply-To: <20220124051752.83281-2-songmuchun@bytedance.com>
References: <20220124051752.83281-1-songmuchun@bytedance.com>
 <20220124051752.83281-2-songmuchun@bytedance.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_25E49A25-621D-4FC0-B37A-8E9EB4A44DDC_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0321.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::26) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 758cb33a-5c3b-422f-2a55-08d9df53a2c6
X-MS-TrafficTypeDiagnostic: BN6PR12MB1905:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1905B411197E03B8DAE8EB4EC25E9@BN6PR12MB1905.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vgvFZVW5YPHG7in6fp6iDu9Eby47FBqzLAGlDh0JYZcOQB/dherhea9s6m75cpDMQs2YWnJfQVVfgjZYeNXZp8MZZeN5VRCTPDhwHug2lzR7BkCPPZmlBU1ZHrJzQfulx3gb007NKJHluVB2af+iquR1jKLzMv7WIJOEoNtnGzeiq6wmEY3C8nxd3q0I2T5Hefws7PxAFsvVii/ECrmHk8KAZEf4KdRhkTFEuaySz8bZtLDJBjxi6L3vsbb7CDvvi/CG5Gz8ytRJbKfkk5SkbrGwOmkTyRz+SMQHaHgMhf8DX8jirBQ+LGoJlSjatyikHWqJZseSiDGVrW+U0YP+inIBgkLUbZ70AfiE2YZ8k8xkOloRFmgXw9BuHhM5pTD8LrJroRnBx8rmJFh91ZAuvLfbGryrC3tBZjq/Jt5VvD2FetqSDnrTSGkZF1PdCRbhWp7R0Dr6HRSR0tdMDGvq7GOv3nV3x+oh3ZTz+iaS3b9TQCkfArQmmR+yZOj/p+YVD3Fj7cGzCqrhYvQdtvkUYW5+EXQHBgwOQqc45qlYNdY4SisWXUHF0qWBCfjfBSk4eS+KIQmp1t3o3HVtxK/7XdsWcVeua1AlO5MGalkaIkJ/pcpGkRazy2MO6xfjL7CRLvn0svmhxhmTVUIw0KxDtwduCCO0wcG+NDEwsPUWuYvMozeplJA05yRPWyln/4EMBCjycv9TafEEaxoR/l/08GlZK0zxLfWHTr+Mx+zcUoU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(21480400003)(33656002)(36756003)(53546011)(83380400001)(6486002)(4326008)(8936002)(186003)(6666004)(5660300002)(66946007)(6512007)(8676002)(66476007)(66556008)(86362001)(2616005)(6916009)(38100700002)(316002)(2906002)(508600001)(26005)(6506007)(235185007)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hVQEzROl+8o/hBQQCZY2TKzR+bB4+WMJZybuLmLn7TaEgwrMs4kw4HSR5r34?=
 =?us-ascii?Q?Ka765j0N9jRIWdaOkdG2l5ZbKmo6KmslAIvMD5rUD9SPLtjEe/XaYRCvaZzj?=
 =?us-ascii?Q?CjOw4KzVO2tWw3PCNRqpOCoMC9kKK3zzc1RKmEuxvyViLCDvdaaleK8Ca4lg?=
 =?us-ascii?Q?ziaACpAyucG9EQ3nJOwnMrE+iluszvWNuQWZlEU0xdU0ZtMiLx3IXNycmesF?=
 =?us-ascii?Q?VX+KWbTAJI8vayyye+8orgPcshVHkfTyaOTdLKL5V4FbrorVeLQaHATlLakK?=
 =?us-ascii?Q?KDOb7pdIDTHG8c4FfCgImKhOEnJInPxs1SFxz9kl3qYMV3oOPI9qOWin7QGJ?=
 =?us-ascii?Q?q1BbyWU3exEpmxuFEvXcPg9d/f62RmtBK0Q+Epu8IwHEK/pTVuSxW+pGeQ2E?=
 =?us-ascii?Q?OmZiSlUZuLD6pt8H6o+F8aLjN5VEK0m/j4S+UvrtvXfCyWY0uA1hopkxAL3F?=
 =?us-ascii?Q?QTCVUmPiyP0GrDlDp1kS+h9EnqsJ3e1ApIeW/c0DHI4aM9bIgvzFo50g0ij7?=
 =?us-ascii?Q?ppzmuhgYmDRp/+j3LCwDrA9biApcCiS8neTW3s0F6J/fkwqb7Fr2OdU7EKko?=
 =?us-ascii?Q?pMANKgPyyGl7IIlZwEdxuSQBzJQRhQqzcr2JnAFzGcCNtKwI7gYT7ODIelzx?=
 =?us-ascii?Q?ooR7ToC3szqz8mXNWi+GLh3g9SDSJ/a3Wcu7FoPFS10JO9+cYYjrcYjXsvxr?=
 =?us-ascii?Q?+GjbM+Jkd51/xnxx5cXjrb+FFZmstti3GnBJSrSt7OO+MskLeqURdoqZZJ7C?=
 =?us-ascii?Q?1DDe1uGBoBu0vIOLr+5Xy3xoZwxCMmHfHGcC8oP1XNVIL4z4riNgYR3QsUYG?=
 =?us-ascii?Q?I50hJz9CpTQlHjxCrr6iSkUP4OUPmNKRZqERP2kUe+iqiX3R+xje8jqqHJ1C?=
 =?us-ascii?Q?pE6eAhJmYjG/59SI3mO5EOl7DDhPEPtqPdkma2QzyyAmLNRt4PmrcWjBOKhM?=
 =?us-ascii?Q?9kiMNtBUbakypv+igrA3Zxe/Xg756cvZ9fWlkCwAbIW2TeEwbLnXQxwbb+/v?=
 =?us-ascii?Q?iy3dvSL0tG/Q1XvCprD54uxslPCss8GJKnIJnhxuewxm5GoUKA+ST70OxnxK?=
 =?us-ascii?Q?mG8RHeiWqpOyZ9LNKtrf6aJydU3aJs/JIhtm6DnQYuv0gqAjMJrJbD0anwrz?=
 =?us-ascii?Q?Q90rmn6h14hwFgYl9Du8l33PHNQU5kOqcD//3wU9FYq7CWFyEpkQcwVB0v8r?=
 =?us-ascii?Q?umpCUaNZjGzLPQx90u6QITnF5pE9mCi7CoIewyfEYyyN1m3DCyjYvdMApsSn?=
 =?us-ascii?Q?qbzYxsNttb0vslGNASGXhj3KxT8EVyU+WaXYBGXLwFdlO/L6/7BGsHsGMNn5?=
 =?us-ascii?Q?ilW/Rs3m1yezpU311GVaNv2J8/JPaGDlqn/K66jRYJCt8Mm2Kc9N3MO1i6G9?=
 =?us-ascii?Q?35QpNtcrvo0XDY1qndH31pIPSzm/r2ODGd7/+4Ssmayh4uAaz3Ar3zhoi2Fv?=
 =?us-ascii?Q?m8EjbcpmUTyJQToTl7PXDgIoekxPuG0RtaafbNV0KKarT21I8S4v027NpBB+?=
 =?us-ascii?Q?w8i8JZIE7/a3rXKCwn3DRGHv3hW1Edr68IyGj/dNCqGEH/Lm0HK/SmYrsKka?=
 =?us-ascii?Q?FphwgNxXxfoQH8P1imM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 758cb33a-5c3b-422f-2a55-08d9df53a2c6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 16:07:35.8779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fJifXROLIuITBGGHhUCTLWvmYOzPTKw4R33Li+X8aHFnxhVxTekEV9+o8qxNaotu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1905
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_25E49A25-621D-4FC0-B37A-8E9EB4A44DDC_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 24 Jan 2022, at 0:17, Muchun Song wrote:

> The D-cache maintenance inside move_to_new_page() only consider one pag=
e,
> there is still D-cache maintenance issue for tail pages of THP. Fix thi=
s
> by not using flush_dcache_folio() since it is not backportable.
>
> Fixes: 616b8371539a ("mm: thp: enable thp migration in generic path")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
> Changes in v2:
>  - Using a for loop instead of the folio variant for backportable.
>
>  mm/migrate.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index c9296d63878d..c418e8d92b9c 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -933,9 +933,12 @@ static int move_to_new_page(struct page *newpage, =
struct page *page,
>  		if (!PageMappingFlags(page))
>  			page->mapping =3D NULL;
>
> -		if (likely(!is_zone_device_page(newpage)))
> -			flush_dcache_page(newpage);
> +		if (likely(!is_zone_device_page(newpage))) {
> +			int i, nr =3D compound_nr(newpage);
>
> +			for (i =3D 0; i < nr; i++)
> +				flush_dcache_page(newpage + i);
> +		}
>  	}
>  out:
>  	return rc;
> -- =

> 2.11.0

LGTM. Thanks. Reviewed-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi

--=_MailMate_25E49A25-621D-4FC0-B37A-8E9EB4A44DDC_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmHuzsUPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKdbYQALGOgrnDoIpBetzqBP/KGKbtF2o/DwQfjwto
VE7wgckZvcW1m0ZiWkEOI6ja3kChUYjoQw0rsZghPJjY1pQdv7MJLmNfofbFi5H2
E4mE3efv/AHZQaBODnvrylBOGoL1x8cSI4BADZNWpY7QC8dnjswCjD196NrgJ8kz
ZGVPcF36N5oGtXto3Bs0bnbLRBA36xwq4d4RHjSjr3sk2Y9nWa3g6iZ3sTJpdwY1
wfEJyXGKZ+F+68Jc4XWZyRarM5Fw2UzDVW7Fkf9WM5nvVVcAeQU/Fc2RIKE5wPid
RoJ1vQTOFha74a00aZOY0iQdKBTFAUCLvHGHRUqKLQR1yAtfRPvborxynR+AsBSE
ugDEBfiuaZazpAFrdOEY/RHPA/xHt06ZHPrvJDaK6XR6xOwusU8TPOKpkIXxeVTS
KzV34o+XdrH5Cr+rVYtAZdNOtzK7PId8bMoeq0Sih2TYLxTgDzaJKwgcx/fMtjRg
naLpGDIlxkcFt1dj27e3BO4V2WNDRFHMUh0OGuoWICQp1mkmWNeA7zi16DwCHW4Q
x/vtidqYlf1x2ZMTgAiEHCkjGT5Is7GGU9UutDM3Be7SFvwCRxdqDyHQef13uv+k
iswHDPdR0KAgpSNdQAuM8edhmBkf9PgZZDNr4WD+M3ACvcQbTO7x/dQys9nJWFVW
eSLgyKaa
=znuF
-----END PGP SIGNATURE-----

--=_MailMate_25E49A25-621D-4FC0-B37A-8E9EB4A44DDC_=--
