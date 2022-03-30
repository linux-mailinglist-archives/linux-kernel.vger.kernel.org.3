Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABE6A4ECE17
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 22:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350974AbiC3UbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 16:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350973AbiC3UbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 16:31:18 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711456C958
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 13:29:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mf9wBN4Z399cIERcPRP7f8liT233bWEmVn1pU0U4Wc+eMkj6vcjjn9QbdUifBzFEg2f1mxvd9AfShu9HBW38ENQSlspe7noBaDsfvPKZYT+7Z/j+0e0iS5M4viSqB7SNoV9J/LcCnUXMQoq2Q8EGev3wSkXDhg6ZY/hthlyrEpmzXycmFk+ihv/fdHqH4CdO5lmLsvjfl60F8vAEWlbL4RTkqj17PWX2RAFSmUNZFQxBk5QyfA15xKH99KEjpoLyjimxxWGCWo0f/5o3j4MfmrRu2CKSBlN5Ix81ZTtGDrCYFTBLVNu2F5NcoLfiHOj9xKsOCfGnBpbbaC1SE2t05A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GWBJoNd0AI8/GvTTCgIuDMOxxQiNM0L2Js3AFv6yJRw=;
 b=TzVKz+jCJJzCIv50lQ2YW2hIvRn+G8Rm5zeNvTMUArjTTIbpP/AYqBCscm634I/OVeglGwTCAyaVsuFDjfGcgoeojo91ICTqk54vlsC+jmj891Wv8gc94xw+DjAduLiyPnz9aYHy5XEZ5YBK9tQZdF9IJ2zKece0PvUJA6cKAeDxsF5dLSeLqLFVSdvzox7Lg4rF/t/4d5r97ulDGJTPfO3omfXir+gNHPsnmnjJvU1R/T8UITYyOyEZoM3byeMlTMfA5B0ggho5tnEQOj6IK7MkawHedgTPpIp4LvtLd7fIe/AVd+DpA12Q28ABQFCdjyDGM+hGnFMpMKlqIsSw4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GWBJoNd0AI8/GvTTCgIuDMOxxQiNM0L2Js3AFv6yJRw=;
 b=nCQFwkN4xqnJlJv4cSIMJxGYF1f128fIrWM+9aRWlLNsBz0IcxboYxODbe+kASW5AazT3pv61GwsU+eS5yPdUQ54v/srfjmPoJkTa8pDkEB1UkzCFGyNaXP+vvKzhOivKx/GFL+8Jey/P26Tx82m0cTMi2bSAV5DEXtlFNj/ysa6PjZI2+7pFo1b2mL2gcGbNDdubpWY/oQ45CFOFDeQbovJwI1E2Djxx6ERzR3iLT3Dr6owqm+QJ5/QZHJGBdKQS/d3i9agce2Q3ezryS0032d7ATqKTr9FClk98Em4AobPyiAcH7r9g9ja1gufTZwYq2zENHVNx7SzIB2w9uB+Ig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Wed, 30 Mar
 2022 20:29:30 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::69f1:dff6:826b:7d9c]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::69f1:dff6:826b:7d9c%5]) with mapi id 15.20.5102.023; Wed, 30 Mar 2022
 20:29:30 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [BUG] Crash on x86_32 for: mm: page_alloc: avoid merging non-fallbackable pageblocks with others
Date:   Wed, 30 Mar 2022 16:29:28 -0400
X-Mailer: MailMate (1.14r5870)
Message-ID: <B7789993-75EC-4F74-B4E6-AF1CC2CBD9D4@nvidia.com>
In-Reply-To: <CAHk-=whz_8tRNGCr09X59nMW3JBzFLE-g-F-brxd+AkK+RceCw@mail.gmail.com>
References: <20220330154208.71aca532@gandalf.local.home>
 <CAHk-=whz_8tRNGCr09X59nMW3JBzFLE-g-F-brxd+AkK+RceCw@mail.gmail.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_4A61F81A-139E-49CF-92FF-394027EE5010_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL0PR1501CA0017.namprd15.prod.outlook.com
 (2603:10b6:207:17::30) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e817fd3-65e2-4091-7712-08da128bfe60
X-MS-TrafficTypeDiagnostic: DM6PR12MB2619:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB2619A4D0808562C306658F5CC21F9@DM6PR12MB2619.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tEakbEQ/Lk1thD7JRFTU75XL44KV6LbV/cNx2gz8EVdHHtqRqhsPBilxk9gxouTlzS/tXleCaL7SgQD4hyHr1Wygi8TDcHhptGFp9Nk2rkyOIp9HfhC7Op2T8Og9aG0UCCpl/Ukg47rKIkNIu9yKtKxq1c/YQiTZF+F1pCDfEsCoGYvWYSoiSakkdQ75qFhpICP9+W+tt9+4KgNy5jMF/YdIyFWSglePcei25xVE/w787FewFL44/bAc5e62hAE56hRkXCrOpAWfMOHF0WrdPhG6YTnXUDUxogbRH50FetVSFpJuILwDxV5+tPttpEmREJDFZswQXnlPijIIzf+CraG1gOosz9A57712/3ryWtMbFZzsrMAgQ/KPlUOvPBm09mvnZuOTccV2RAu3hWgchMaDo4eMb9wKHSfN6c3xxo5wkgvVA0mqhpfl6OXcRz5XmhW9dejEYHsjBH2yo6355YxCovFCOOCkT/WtL+SCRN3wVgwtBZhpMxTsU1KwznZSm3ZA8YAJnrA+Qte0g2KK/p0YBxwJW1KSQyrC3thlhfYQKrEqUBgrDh4Nxtjp13QHbKIoapIcLfillVp8nezebgyi6G1kK42rvQjFnGq5Pqx9iZW5MOaGt4EzW6C+IdWCobaH6wnVvaUoWuZm+JW/27Ok+Bpi+G/4DH4hjU92KbLR+oZDVrFa+2bPF/6Zx5NxD2DfvaWq0GP1M/nvEsk9QQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(66556008)(53546011)(6486002)(4326008)(8676002)(2906002)(83380400001)(38100700002)(2616005)(186003)(508600001)(36756003)(26005)(6506007)(21480400003)(66946007)(316002)(66476007)(33656002)(110136005)(6512007)(7416002)(5660300002)(54906003)(235185007)(8936002)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GWnlULBbfYUVJWTefLXuAziyV9P1dNUP9PSsYdSOB6Zd4OAdFFwHL7mNzTfR?=
 =?us-ascii?Q?zilkvsUVas0UimIBq3UqP6IjKtA+qz+CHiKAuquu1f4mY2Mc4P8wDN0tlM7/?=
 =?us-ascii?Q?l8nIMjaD64P168jot6mkvmrylMiEfWzD5tJua5Gg+rYgAZy5Gti+oeVwNdWz?=
 =?us-ascii?Q?ybo6TCBihFSvMfrEQ3L+lT6t4m8EojrrFJKwwYZTBX+0vBNASnKxswqM0GZn?=
 =?us-ascii?Q?J0kjWPVauPZm7yFEfW3UBBhuSxtSOzqNMXnyoWIDOqt4bUb8pR4vjsvtX2wN?=
 =?us-ascii?Q?Qdb/qgNaxHUNj/9dwYeiJNU1aK88UpE3iUdsR0I8wwZQTJBgTCNbzgQNpbPM?=
 =?us-ascii?Q?EoEkpiaeKyRBA6Ouucp6nbRc99Aqkj0SlhAeq5PTMtO3H9/Poj4Q+aIKzu26?=
 =?us-ascii?Q?sRWrl0qxEOs/nVKvwDoeRG71SzgZItTRQYc/ruZlKrIMhaTZazA/aKewoUnw?=
 =?us-ascii?Q?P7wRlXT8U+KfTzfPKSxo2bUWjXMz9R01xfeDWzvBjiIh+KDzuO5flw7omg8j?=
 =?us-ascii?Q?aU8U2vN2nxFc2EqQp55kmenn0jfUKUHjhXGdf0xAIqH9QBF2adpLavVMTaal?=
 =?us-ascii?Q?r8v4ng7c4i1ift5qMuyN8T/6yF1dg4Uik8sfm5gSoHUiJXoRnKomq+DxBKuM?=
 =?us-ascii?Q?JBygRNdQZ4CAsF726Hm2CA9d6aD1Kl1bBLvqt7yhvNqbIorqFBau8TbEntcW?=
 =?us-ascii?Q?oWqVfyemrdTQjqjhBTNf8nLmoniAAH/EK0xOPYAuRiiHzNCV6L7ls5hFz8xP?=
 =?us-ascii?Q?wtb26vNPlscLG7CnobNzsFhXjubz5rDrahnC7Or+7ABhLd5W0wLpsa1Bd3qW?=
 =?us-ascii?Q?QJXcvAH18mOCQC/uA1Bnvynpye48erqc0PBfIkd6PVy+aouu0GtNYABD1MA0?=
 =?us-ascii?Q?ASyId5GFo/tuGSUQrhBBhm2YEPSwA2nHGM26tVjSL+qIw/0HnR4NcCdD12vP?=
 =?us-ascii?Q?sbQyr2OyoQZuMeKACHznODm4Cc8FjxoQg8bSszp6xYMJBkmQUmHCHjmFNf7H?=
 =?us-ascii?Q?PMEKM6JyN20BEv4DlsptuvFEOzokHs68ZZCs6lCCEIEP4G8GhVLgQzLzVS7C?=
 =?us-ascii?Q?CWNsHyxZsAZ1qyDEoXxlzQMiUWvYKnkATGVgdUHDbrgFYTBj4La16annstm0?=
 =?us-ascii?Q?1QN1Kz6EAxMrVKLMU1D/cflO7jRDBijVokxGM7wRHQ9LX9mfCbpGHstTWGOn?=
 =?us-ascii?Q?MDddt1PyhBr7Gd7uXErc7wR1lecMuHmZRl7pfybeYn81XlOP+tS6MHkDGuzL?=
 =?us-ascii?Q?usccwuRh0CKiNDbtVcwmEneoL/koyv37Kt8ez7E/AhZQxj2In6UL6vE0NBHK?=
 =?us-ascii?Q?ZAMahz58EfYL/T8XT1n4ENcfsAsLxzSjK4C1S+d7mOgDhrhLZEheRaADdUMB?=
 =?us-ascii?Q?c5qF2bHYrCeuIbeZx25Q1+vVCBNqgDN935BHT/+BTVHvM82OLIzUWe7kadKD?=
 =?us-ascii?Q?kw2AKaLv8ZZW5fhwSyj/hlXEIdemrWYkWiWsdTUcJgZAOKuvyzjjMJdbKCWQ?=
 =?us-ascii?Q?680+/6cifW/Dn/hwvE2Aah8ptoCOVfLmaILyiMurhUL7xB1/1JSv7LCi65qg?=
 =?us-ascii?Q?FIiGPvOckCu+QgEf81lEiFxSsK+GWKL/gDVqLUvm2oz7rmjD60pIaQabs7Cl?=
 =?us-ascii?Q?Y8FJcb90NYqdYZUvGRWaZDIzsSH02+ZnbJkr6Jm8ChJVuqsaaMWdEmDHS3HP?=
 =?us-ascii?Q?YzUtkfU06AVUw0a2NyJt194YlcLwiBuO5aes/4ZBB3AkHaUq/h3Uxm0KRvOd?=
 =?us-ascii?Q?+r93au9VpQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e817fd3-65e2-4091-7712-08da128bfe60
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2022 20:29:30.5554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OkihfaYHBAS2on5bpJGbjblGSGymSx+s2Fo/1spKJ7BtSdb1BUgvin1BwhFeJ7ZZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2619
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_4A61F81A-139E-49CF-92FF-394027EE5010_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 30 Mar 2022, at 16:05, Linus Torvalds wrote:

> On Wed, Mar 30, 2022 at 12:42 PM Steven Rostedt <rostedt@goodmis.org> w=
rote:
>>
>> I started testing new patches and it crashed when doing the x86-32 tes=
t on
>> boot up.
>>
>> Initializing HighMem for node 0 (000375fe:0021ee00)
>> BUG: kernel NULL pointer dereference, address: 00000878
>> #PF: supervisor read access in kernel mode
>> #PF: error_code(0x0000) - not-present page
>> *pdpt =3D 0000000000000000 *pde =3D f0000000f000eef3
>> Oops: 0000 [#1] PREEMPT SMP PTI
>> CPU: 0 PID: 0 Comm: swapper Not tainted 5.17.0-test+ #469
>> Hardware name: MSI MS-7823/CSM-H87M-G43 (MS-7823), BIOS V1.6 02/22/201=
4
>> EIP: get_pfnblock_flags_mask+0x2c/0x36
>> Code: 6d ea ff 55 89 e5 56 89 ce 53 8b 18 89 d8 c1 eb 1e e8 f7 fb ff f=
f 69 db c0 02 00 00 89 c1 89 c2 c1 ea 05 8b 83 7c d7 79 c1 5b <8b> 04 90 =
d3 e8 21 f0 5e 5d c3 55 89 e5 57 56 89 d6 53 89 c3 64 a1
>
> The whole function is in that Code: thing, and it decodes to:
>
>    0: 55                    push   %ebp
>    1: 89 e5                mov    %esp,%ebp
>    3: 56                    push   %esi
>    4: 89 ce                mov    %ecx,%esi
>    6: 53                    push   %ebx
>    7: 8b 18                mov    (%eax),%ebx
>    9: 89 d8                mov    %ebx,%eax
>    b: c1 eb 1e              shr    $0x1e,%ebx
>    e: e8 f7 fb ff ff        call   0xfffffc0a
>   13: 69 db c0 02 00 00    imul   $0x2c0,%ebx,%ebx
>   19: 89 c1                mov    %eax,%ecx
>   1b: 89 c2                mov    %eax,%edx
>   1d: c1 ea 05              shr    $0x5,%edx
>   20: 8b 83 7c d7 79 c1    mov    -0x3e862884(%ebx),%eax
>   26: 5b                    pop    %ebx
>   27:* 8b 04 90              mov    (%eax,%edx,4),%eax <-- trapping ins=
truction
>   2a: d3 e8                shr    %cl,%eax
>   2c: 21 f0                and    %esi,%eax
>   2e: 5e                    pop    %esi
>   2f: 5d                    pop    %ebp
>   30: c3                    ret
>
> with '%eax' being NULL, and %edx being 0x21e.
>
> (The call seems to be to 'pfn_to_bitidx().isra.0' if my compiler does
> similar code generation, so it's out-of-lined part of pfn_to_bitidx()
> despite being marked inline)
>
> So that oops is that
>
>         word =3D bitmap[word_bitidx];
>
> line, with 'bitmap' being NULL (and %edx contains 'word_bitidx').
>
> Looking around, your 'config-bad' doesn't even have
> CONFIG_MEMORY_ISOLATION enabled, and so I suspect the culprit is this
> part of the change:
>
> -               if (unlikely(has_isolate_pageblock(zone))) {
>
> which used to always be false for that config, and now the code is
> suddenly enabled.
>
> Alternatively, that code just can't deal with highmem properly.
>
> But I didn't really analyze things, I'm mainly doing pattern matching h=
ere.
>
> Zi Yan - and all the people who ack'ed and reviewed this - please take
> a deeper look..
>

In the original code, it will jump back to continue_merging and still tri=
es
to find the buddy. The crash means the found buddy is not valid, since it=
s
pageblock migratetype is NULL. That seems to suggest the physical memory
range is not aligned to MAX_ORDER_NR_PAGES, which should not be the case.=

But if (!page_is_buddy(page, buddy, order)) prevents further buddy mergin=
g.
I must be missing something.


Hi Steven,

Can you try the patch below to see if it fixes the crash? Thanks.

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index bdc8f60ae462..83a90e2973b7 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1108,6 +1108,8 @@ static inline void __free_one_page(struct page *pag=
e,

                buddy_pfn =3D __find_buddy_pfn(pfn, order);
                buddy =3D page + (buddy_pfn - pfn);
+               if (!page_is_buddy(page, buddy, order))
+                       goto done_merging;
                buddy_mt =3D get_pageblock_migratetype(buddy);

                if (migratetype !=3D buddy_mt


--
Best Regards,
Yan, Zi

--=_MailMate_4A61F81A-139E-49CF-92FF-394027EE5010_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmJEvagPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUs3IQAKVDvClXdkS8HkRtv5F9xMB6s5efViNxG+51
G2ohV8Wr3KVWPvanxMdKnc4PxCOK1j7624CWTpW1YEur3GbLQIbYGmhEO0YJOU/c
UILKElAu8XmW71q4hgiQPXFZWpcU0JPNrnk8tpK/hBNoWYYA5g4ATsscXmMxe05S
6vE8n8MDzXcPDIi1GbmcMhR64uR4uXYSTn+xs3r8LmtADzX1rscEYf5mhnSR/kFG
jHBtoR3nmqxGBfZ4wnTEGwNnFHlZswvsrku9/LNB2uBGBMV/561qxpBZHXj/jOBv
cR6+M8MNHBhYJxJq3HcrkSfqmnklcBvp/NA09S3evTRXvs1yQzn2S+QMKXR1iRmW
M9H344hdL37f2Y+VDa7XsvZOCRKkFd+2hOb+mjoD+x7O3vMEGVsdUjgOt1qEcVnw
/7h68JWC4754m3ebUfsmJcgeyraAk9fV0UPgIjB638LgVU2ugDH7VB/QdQy8E4lM
mQ1jWX192ge6vJ2eA4aVV7LTSP59g7gSxyUWJd/H9FApv+plXPegDpf97T1x1VyV
tmbHptQWTTu3Ro1AcXmOyezkHuLK0GqTVA88TvrQtAfEGtuhmExiYY44nyV7siez
DTyPg5aswkEKFYiGgu1ONV2KsJfXAAo/h+WJNbk0qqxLRClX6ZlPUmDAGHhpBRKF
55gWwTGF
=iN4j
-----END PGP SIGNATURE-----

--=_MailMate_4A61F81A-139E-49CF-92FF-394027EE5010_=--
