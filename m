Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B265349A8C1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1320316AbiAYDMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 22:12:31 -0500
Received: from mail-bn8nam12on2085.outbound.protection.outlook.com ([40.107.237.85]:11872
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1378779AbiAYCmv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 21:42:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cLgN2DtYnMF9wt2OijdpT1jZaP68kVO44CqgiuPCkJbyNrvQQYrY6DfoIm/n/LisqasxXGnA1RPQkCwCpoGWuw/MpF9oyRiK1uEkaWMxBIht6Aw8MWPJm703Jspb218mYV3zI1yyQKIUBNLb+Kur/yqjiFNxxRd4SWkWMvwKWjw+aszpprTRQBwzM1qkXePWDLDf3SVPaAvQb06uDLWOtOmNk3hSSml/t/oLWW+PRyD8846SBny+RGiEPeW+odetLT1EGg/TnBW0OIc8KREOIuNkzdVxbjRbs0vnkOKWOXP1nWo5EgEkdtcg8Gi0hxhKE8agvj6Mw+Ws+Pr52VH2rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5sB8grq6m+AWAolNwZilsjyYKCuzQ2mq/jFMqo0oQzM=;
 b=F7zLbP8JoAf2EL7OtEqijobI4FvzS4IrrOyTTVCZUxkya/zVP3tQ5j0vsk6tXmgwFXQMf69sL4oeMDYJWbizHFQ73Uk5dbMQQJbQ0G/FWhu57d0UF0rp5Soo+i6aP/svS+HOp+J1f0oayNP8px+93kvyoEcUD3wRjtMwmSZnQQ7+yAyevjyvks8Q192QD996LfNEaw5+dNFeF8pevkTy/BlMBjb4wy2HeyAxMyq6ock8nh6vtNz43ULSGGzmzbE3S1nd/rXdnpNDn2cMBNnIwLiF3T1/NpXGxJELDSt8I6YXSwtam6ITMeGF8S2EHBFBfFOHiiDYyP8tRJSsqO3Naw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5sB8grq6m+AWAolNwZilsjyYKCuzQ2mq/jFMqo0oQzM=;
 b=A4Zarld0OaKEroZWhJndKp10+JhJGlFI+i/7C0HJdDYsQ3gxTIgX10WGmmlhRsJUjLyebFX5aOtrs+vtF+w32HmYjwEL6bA29se8WVNaYdRA2B3xRo0EraHsBF8ETIgOINRF8/PWEhNzER48ihRnu5mlle3LkB2CxV0WXdDvLPjkY96WALFxv9sIEXPt0FyPwyOo5CRn1m/zbA7ytDILlMbfdwoi9VYRIMkS1x48Ie6hskSSFQkdiYDJ2WLkwuiav757IzASfjjeUnezuGKTL6hDrSBFq+Moqbr6wHsOHbF+e5p/IeU2CuSDbvxXNy0hDM2Q6Oep1JVLLgrAGeSYlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by MN2PR12MB4566.namprd12.prod.outlook.com (2603:10b6:208:26a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12; Tue, 25 Jan
 2022 02:42:45 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::a9db:9c46:183e:c213]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::a9db:9c46:183e:c213%3]) with mapi id 15.20.4909.017; Tue, 25 Jan 2022
 02:42:45 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        Lars Persson <lars.persson@axis.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH v2 2/2] mm: fix missing cache flush for all tail pages of THP
Date:   Mon, 24 Jan 2022 21:42:43 -0500
X-Mailer: MailMate (1.14r5857)
Message-ID: <7D7EB27F-DEA7-41AA-B24E-B61A2A1A5F07@nvidia.com>
In-Reply-To: <CAMZfGtXsLyagpo8rM6RmayAFR_hgk0987X1usxYWRZLeA5H45Q@mail.gmail.com>
References: <20220124051752.83281-1-songmuchun@bytedance.com>
 <20220124051752.83281-2-songmuchun@bytedance.com>
 <4d5044e7-cac9-b6e6-1467-59ea6010b0f5@google.com>
 <5D9B52E1-A74B-4964-AACF-ADB91536C4C0@nvidia.com>
 <CAMZfGtXsLyagpo8rM6RmayAFR_hgk0987X1usxYWRZLeA5H45Q@mail.gmail.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_D66EFF91-64EE-4FF8-A7D9-1F32B15AA181_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR05CA0015.namprd05.prod.outlook.com
 (2603:10b6:208:c0::28) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 302c4176-558c-4e00-ec86-08d9dfac5df8
X-MS-TrafficTypeDiagnostic: MN2PR12MB4566:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB45669CED33B614B43044E0B6C25F9@MN2PR12MB4566.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KvMuZU77RtnDpEzbB01CYL1ahxsbYT6465vupdCHF7DpN+OXSHCok18ikYf2ZTPf1bdNkoXdc7yIDYYEOEDsAvAxr5QBlutqerRSmTJNFrc6h01NB7QzmXNtXaTHwX8f+p4hI2nnFVRdCkCvCVG/DSMWzHig2+XuL/+EC/nU3NP/ahvQOXsY0m2qDlCsBYRb1LNEPsPNwYcKKjRBzzQyEwpqiQDgA089nsO5PamEDd676ZI6UrHPBGnnOe8fJrZ2Yt8cJx5v20lobzzM7Zt89J0WxWUChJQLxmSHIHaUOjF2sg7YJtAyqMDAt6C9d1PXBJsvSWmYavxglbnW6FkNJGS0xU7SjDksiZXiiJ9gQ3xrLlHzpZEjUg96X9e37wroOtAf3GwJLP4bhT6B7r1BlNIo0SjTXD6uneOiDu/vHIX/4KlY+4teCLr/TMupoviNM4WkqAuJ/XvP4vbrel0/WQqAJ2LlTi9jXfou6rqPjOFfDdshsIfBfkv5v17AI+TsMam9B6rvPqEbixCCRyFJ/eMOcXLak1AjlUVboo9VRHg3LsptBwug1k67IGeao5ciaTr/jl1q6unhBKHU0DNS4NKcTuzwob8gxQT1EANATQ2ll6MafTWM4tu+QdD99thH4DXJV22pxMOubpi22+HuSznw30goVzuUZdDyaCdncQYy1m1tNhxV4k1lTPYtRXEYHclvbdv47q4WDcgJPd7CuAgc6lL0o0IdjQIgSkZYa+PuuECanO+uaY3+nK/wKiw9AQJaTKj+s28l5+IeC3qbo32OPq9xa+OLXixfab+iDYUA1BEx+39TcZ+StGBu2+8S
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(6512007)(54906003)(186003)(53546011)(8676002)(508600001)(33656002)(5660300002)(6486002)(966005)(26005)(86362001)(21480400003)(316002)(33964004)(4326008)(8936002)(6506007)(6916009)(38100700002)(66946007)(235185007)(2616005)(66476007)(66556008)(36756003)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emsrZ0w0SHIvcUFkUlZGVWpNeG96dzU0OHhRaS9RUlhMR2FDRGp4SU5MVVBv?=
 =?utf-8?B?bHRCdW5iZWNsM1BWckRXMGp1M3FINFZldGZCc2pFMFRqZjVYWXB5T0FHN0JI?=
 =?utf-8?B?Vk9MMzRuQXZBQkE5UENwMzJ2RUJVeGV4MTBHTkRFRVN4YXBtT0xxS2tXeXcz?=
 =?utf-8?B?WWQrbStqNzBUK1JpMHZDM3hWZ0tZeHpodi9VZXFRRURvVjVPZnVzK2x2dDhU?=
 =?utf-8?B?TCsycFNSUGVYZU0yeHJ3OUxnM0laL0ZWaWo0M1NyazNOcnZDai8vcUVtVjNv?=
 =?utf-8?B?TGw4WHZtRDZjb1lWOUpobW5mY2V0R2tuNm5zY1BnZWFKbk11bmNqWEhNelFt?=
 =?utf-8?B?V3YrV2NKa1lCUnkxeHhYSmdEUVFjd2NNRVJWeVZ3NkxFUnowdjVUTjNhc0Q3?=
 =?utf-8?B?UG00eloya1dqK3MrM2xsVzVlNzJaNDdBMnZqWGwwMFMrQzVTUFd3cGc2ZVFR?=
 =?utf-8?B?c0VuVWgwV212K1Zvb3pnWkhTVGdydUR0SWgxWDc4MWxJNjh1MC9HZzM2bGdQ?=
 =?utf-8?B?dzMxVjNXSTFSZWlUSjlQTTFMZEVQWk5RZDhwdTIyTEY0SFNSYWwxcE81MlBX?=
 =?utf-8?B?WmNzdTg5bW9NZFE0VWxJZXFJMDZ5RjFmSUJ5bkJHN0lrMlo5ZnoyL1NWNEJB?=
 =?utf-8?B?SlMrMDg0ZFc4L1lyNGxxaGY5MExQRTNBVWFDT2t0MllEODlQSWozRWpNbnBI?=
 =?utf-8?B?bjJxWkxvNzZacTNVeVhuVWM5TjVNWHI1Mzh5Nit3L0laY1lVcWMzKzgwVzFw?=
 =?utf-8?B?WGo5NmUweU9iQkcrZ2NVYjdyMnJOQlVjT1h2V25PdFd6dzVVQmxsN1E3NGpu?=
 =?utf-8?B?R0N0YnN6REQ1VHVlR0o2UmFtdmltdVhSWDdZckpiOFlVMzdwM3JHYXZRcUhC?=
 =?utf-8?B?RFlodUQ3bG9TdHUwMlV3UUpxM0IzZVphc1dpSEh6Z09DKzJuOVA1aTJSaTdZ?=
 =?utf-8?B?djlHZHl5QWtJNUhnNkRMMTlhRGlOSWNnYlRpVGRkbTdlYVl5TTJIbTMxcThG?=
 =?utf-8?B?dlpyaHhoS2FHT2tERnZpOEExSlBqY3hLc3J0dEFOSzRURGpvdGN1cDR2ZTJP?=
 =?utf-8?B?b05CNjRnTmFMbitjR1pXVlQ2dGd4aXV3S2V4ZVJ5aklsTXZyWnhScEo1cjJI?=
 =?utf-8?B?S1JGVVZzcnFjVTR6NHgrdVgzSHZUalMxTUdPbTYvNTVZQW5hV3orMzRMcTBv?=
 =?utf-8?B?Q3dDNTBjOSt1K0VRNTl6aHhCMmVacmZmaVlGbGRPTTVkaVEva1NhTEZmMFlF?=
 =?utf-8?B?aW4xWmtPbDZtY3AyTytVaWJqaDBqdWsvZWozK2l0Q2ZqT3dJV0ZYVGhoYjIy?=
 =?utf-8?B?OG1rZUpVdFhpK29ucHc5R2tDZ3dTQms3bzdJSUtrRjhXOEd0TlpKUXpMRGx6?=
 =?utf-8?B?SFFGcVV6U0h5RERhL0k0Rk4rOXM1eHEwZDNqRlBBTGFrVG54WFZ0a01CN09i?=
 =?utf-8?B?aWZKOERxNjFKQXNXaFZyaXh2UHNWZzNjeGIxbHJLc2gyTDBsUzN3clNHWVZL?=
 =?utf-8?B?TjJhdGlMTWt6Y2p5bzBlR2ptZXliTnhxbFhESWNuRkdEUEEydE53c2QvL0tk?=
 =?utf-8?B?U3JhSUtnQzgwanNRT0czNFhhVFo1QTBrN1ZOWlh4dTdlVktHMm9QTDRZdGpo?=
 =?utf-8?B?L0xnSEk3L3ZwTTBibG5JODlsdXg1SHBEVHI4UVdZM0I4Y2Q5VjVVSlhhOWhV?=
 =?utf-8?B?dHZyai9mK29HeDhOUFFnSCtJcXU4aG9WbWNNZmZyb0JvUFVOQWV3ZnN2RWVC?=
 =?utf-8?B?MllzbEp6UGxTZ3ZCS0VvamR3VG9iVG9PM0JKZmVOZ1lmd0xmNkduZ3FTaThx?=
 =?utf-8?B?NnFCV3hNS0NhYTcyenFONVA1ZHp3bDl4ZXcxdnRiMnh2Z3BMY0dYSnJGdHox?=
 =?utf-8?B?MlI0bUQvc3FJSkVxcnFETTVUZ0cwOXV1c0g1QzFRamxqdWNwUGc5Y2srVXA1?=
 =?utf-8?B?TzlySjFCd1JQbkMwVHE1Q0N5amR1RStoTUhiNHFueDcwM2p3OG5VVmo3dXJ6?=
 =?utf-8?B?bmo4ZGNDTG85NWxOL21KRmFsRk1lejdZOURDTm1SL1E4YU5Pc3E1TlhOTWIz?=
 =?utf-8?B?VTlHNUNYWnRvaDhyUDZEUjVQajIyZWhlejgvOXhEVnJua2V6Z2RFYXF0SFRI?=
 =?utf-8?Q?Sd+o=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 302c4176-558c-4e00-ec86-08d9dfac5df8
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 02:42:45.6255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n/EGcg6J1AxVMBOQtYCk3RpPP7zj8/5QDQcgWU4KaY5p3k+mOyDKqVGyTGNcwlwm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4566
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_D66EFF91-64EE-4FF8-A7D9-1F32B15AA181_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 24 Jan 2022, at 20:55, Muchun Song wrote:

> On Tue, Jan 25, 2022 at 3:22 AM Zi Yan <ziy@nvidia.com> wrote:
>>
>> On 24 Jan 2022, at 13:11, David Rientjes wrote:
>>
>>> On Mon, 24 Jan 2022, Muchun Song wrote:
>>>
>>>> The D-cache maintenance inside move_to_new_page() only consider one =
page,
>>>> there is still D-cache maintenance issue for tail pages of THP. Fix =
this
>>>> by not using flush_dcache_folio() since it is not backportable.
>>>>
>>>
>>> The mention of being backportable suggests that we should backport th=
is,
>>> likely to 4.14+.  So should it be marked as stable?
>>
>> Hmm, after more digging, I am not sure if the bug exists. For THP migr=
ation,
>> flush_cache_range() is used in remove_migration_pmd(). The flush_dcach=
e_page()
>> was added by Lars Persson (cc=E2=80=99d) to solve the data corruption =
on MIPS[1],
>> but THP migration is only enabled on x86_64, PPC_BOOK3S_64, and ARM64.=

>
> I only mention the THP case. After some more thinking, I think the Huge=
TLB
> should also be considered, Right? The HugeTLB is enabled on arm, arm64,=

> mips, parisc, powerpc, riscv, s390 and sh.
>

+Mike for HugeTLB

If HugeTLB page migration also misses flush_dcache_page() on its tail pag=
es,
you will need a different patch for the commit introducing hugetlb page m=
igration.

>>
>> To make code more consistent, I guess flush_cache_range() in remove_mi=
gration_pmd()
>> can be removed, since it is superseded by the flush_dcache_page() belo=
w.
>
> From my point of view, flush_cache_range() in remove_migration_pmd() is=

> a wrong usage, which cannot replace flush_dcache_page(). I think the co=
mmit
> c2cc499c5bcf ("mm compaction: fix of improper cache flush in migration =
code")
> , which is similar to the situation here, can offer more infos.
>

Thanks for the information. That helps. But remove_migration_pmd() did no=
t cause
any issue at the commit pointed by Fixes but at the commit which enabled =
THP
migration on IBM and ARM64, whichever came first.

IIUC, there will be different versions of the fix targeting different sta=
ble
trees:

1. pre-4.14, THP migration did not exist: you will need to fix the use of=

flush_dcache_page() at that time for HugeTLB page migration. Both flushin=
g
dcache page for all subpages and moving flush_dcache_page from
remove_migration_pte() to move_to_new_page(). 4.9 and 4.4 are affected.
But EOL of 4.4 is next month, so you might skip it.

2. 4.14 to before device public page is removed: your current fix will no=
t
apply directly, but the for loop works. flush_cache_range() in
remove_migration_pmd() should be removed, since it is dead code based on
the commit you mentioned. It might not be worth the effort to find when
IBM and ARM64 enable THP migration.

3. after device public page is removed: your current fix will apply clean=
ly
and the removal of flush_cache_range() in remove_migration_pmd() should
be added.

Let me know if it makes sense.

>>
>> The Fixes can be dropped. Let me know if I miss anything.
>>
>>>
>>> That aside, should there be a follow-up patch that converts to using
>>> flush_dcache_folio()?
>>
>> Are you suggesting to convert just this code or the entire move_to_new=
_page()
>> to use folio? The latter might be more desirable, since the code will =
be
>> more consistent.
>>
>>
>> [1] https://lore.kernel.org/all/20190315083502.11849-1-larper@axis.com=
/T/#u
>>

--
Best Regards,
Yan, Zi

--=_MailMate_D66EFF91-64EE-4FF8-A7D9-1F32B15AA181_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmHvY6MPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKWSoP/2bg+X2D84/XBcVtXR8OVog2997ud5iZP0HI
wR54QWDkNMWMzsND2AGPCxNOjoYTYvAWXDvlnpPPySUBBc6RsGLn63wORJceaM+F
pASPxvvkqZcfGqqsUw1MHs8dtR7op36yenRo2rMROX5GeDTqMUkaSJbkTnyLlJEM
gPVNH04qoPkuGtVhMtBywvkMQ5L8swBM1bYT23+OM8WxB0L+sQ6m9kV/miZLaXxA
rFtXEJWuD1tFsC5D8EnS8x1pXBeiAB6VUF6cK7gOCeRuy/C66fFAqXqJu8qhUUlR
nj9kGK5CSD+JebznoxiD10YPXn843Psbky+AFPII40zvi2anfEU1tHq7KSKq6fQs
/HbVFjkwgQcX1mQ9S8ggdaXw7pmUNX6YnacEx6jOmesugNp4PlbEF9pSyfEYvuvg
qfFuguGOh5LfW1gVx26pBt6M1dbEEJaj9uUdmZXZW2kReiJIgEbY8F7felKhBn6X
2nNr81pmF/9ZniMuK1S0Q6f89q+Z+zox60XhLGatxN2C52BPQsDBx0TJm4KJyJcC
KOT+aTIYlQY0DoOWtwI8pXqxZ+LrpsiTVqXyJGyFnBRbltFeWDNKkH1AFIA6TpH0
sxx4siVMO95NEDPXJ0uds1m61r71w1myDjcjsMm0cwNCitgio3R33pNZKtH5nIkl
jMNycqsZ
=uRP8
-----END PGP SIGNATURE-----

--=_MailMate_D66EFF91-64EE-4FF8-A7D9-1F32B15AA181_=--
