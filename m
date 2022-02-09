Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9717A4AF535
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 16:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235801AbiBIP17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 10:27:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235504AbiBIP16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 10:27:58 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D62C0613C9
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 07:28:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NYkkjNoaRsh9/8dPl7W+zXh52LquiwGOyzv3+BwCjY+lymLlkWenZlfw9+crwKQhtMHwKn56smXrgptGGBDFMSaXCv/SYlU5+1k7s0YfOg3zQhreyNajG0F1CinuzPYxz5mMlYbJ3Fe7CGLwLyGkYk5xhBSCTzh/0z1swRxBRAFtoJ2RXrPDFMXbxqjq2pxQisDc8m3xWhpFHJrtMTvZyvdPty7UwF7pyWAliKikxmkL5zhCPdcYouCiPoPfVeKvJm939c5SHWI/wsr7Zp1c1xQWDH/x8NjAgkBcnuZC23h66TR6R4uZoGLeZs9aOKbci31eGGfUw00abs05da+ZVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TeO3+KdP869C9Wx4WUDQdzNPBg9pb7PRuWnsAxbDAY0=;
 b=GvwJ6k/A/dkqIhv9bB8cVvGUVbyZfPoggFqHYS7FlmhQC4hlWC5QshNVrNdMDC8JFr3BbABOWxSK1IDbCBJEDfyPPuqSo5qwnfZvPf5G8E3HwlWRnqnB5INvA2W5cM3XLC93Te3E/6GbN713VoZyBRwEJNvZl2CgeuL6xRwsFc76kwAAEsyGQDeLibASiPubyij7itEO53UQp9hf8KSRAMv8Yue0T1lF3XY9+7bpQnoR++UDkuXALh5wLwS8JYO9tCnmxVjXRDEWI7tkRn5SgAfmIDMxTGPa8Op3fLJqqA4vk8d1ndp6YBwpQmz+NNXhN3VcIKpyVKDX+dZ2oy7hQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TeO3+KdP869C9Wx4WUDQdzNPBg9pb7PRuWnsAxbDAY0=;
 b=M/xOy9Lv2oDbcTWHiBJIPPtVe0Kw0CWsDwpPgMLXw/5dKy9JPdmnS9rhPBe4IIQ9ybOdrOMZpjaZmIL+6PkZ1BOXrsuVEo97Y+BWxrpOxb0yTuoWOAQnX9e23cmixgwdgLCg938t+S59vWwVFZYAXkermJuC6Kn0HzfCRUhGpXdfx8qi4qeRH6bWhmKC11Ehw3AGEFvHcqitl9BaHiufNe5UKBYf0rQwM6iSl/9zLmMlmqqHHssczx1KhviNKvFBztDLs4AKi3GV1uNUz4w3fKPPwa7Kmj2qYbnjpLPGmMuVrSg24KQGGRJUfcM4BlphfvUP0HDPLbxwXM0OltX4ow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by BL0PR12MB4722.namprd12.prod.outlook.com (2603:10b6:208:8c::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Wed, 9 Feb
 2022 15:27:58 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::cb5:94df:b338:9b5e]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::cb5:94df:b338:9b5e%4]) with mapi id 15.20.4951.019; Wed, 9 Feb 2022
 15:27:58 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 52/75] mm/rmap: Convert try_to_migrate() to folios
Date:   Wed, 09 Feb 2022 10:27:56 -0500
X-Mailer: MailMate (1.14r5866)
Message-ID: <4B0C10F2-97FA-4CDE-A013-0DA377750A96@nvidia.com>
In-Reply-To: <20220204195852.1751729-53-willy@infradead.org>
References: <20220204195852.1751729-1-willy@infradead.org>
 <20220204195852.1751729-53-willy@infradead.org>
Content-Type: multipart/signed;
 boundary="=_MailMate_8354D710-C756-4FAD-97EA-93B63C58465F_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR06CA0009.namprd06.prod.outlook.com
 (2603:10b6:208:23d::14) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89d73ccb-0c23-4e02-35b9-08d9ebe0c04c
X-MS-TrafficTypeDiagnostic: BL0PR12MB4722:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB4722803738FADF0C2D7ADF8AC22E9@BL0PR12MB4722.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:605;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K7mTYKXzsiQSjhgHX1yF6xZdNf2ZWcO71PcouFS4g1v7MkTBFU878OL7XCv5wrBgZSdPUwd8F2tjOcXMF3PtvpZB7AyL2B9MSNE2CZwgn38TnqgD4VzBaZnYEcagO6oMXMt0kgYbWyYV9OFeAeX58OUUU97nBgKoUvzhBEB38HUj6LGVrmc6UMXdcsOYPiR0ORs1t5y9w25SkSiTyGjCAe+N7YKAOgtXDZ+OyTq5r5UrHrIl43f4xgH8b7UkhGeNnYxPCYvgZkZzaQhnV4nbA3VRbdQSOeG8IxQgA1qAEQrYP25jJ+doeIs7aKdl5eTfvTT9lpSqv6Rr6kreAlncPFzYv5MONmBx16HsPo6rKHcA2ekqCPtwdzV2GLBArHiGepKSxRwPoQjO/PVGX6eyMeJcipoAV7SemFjnRdvF7OmNtOoXW11OSS4RrFj3vxS4tFM5jfm692V4Ub4PKie+ROMlcoeyw7ofIFS0IBU7RdoVUvB0bU5MXvWLAU4yY1ew9xrQobHXKUT/5YRsNj3n4+7witFMEgEmC3tS2HnVIah3FRa1nSZTqBMKfQXIbY+cSK640Av/xUbS47d1b3iTu5h6a9I/uh+oKfWSnyCGpJPMEuHPuOVMCrKeWCWyfAEF7Vxe0nRCoqjxa+4hzJrEOH3yH2XPlcjqlTez5EYOnOv54XXIn2LRlWr9GOd/SN0HMMMKazcnRq4WsYICz5t0LUEGqIyPQaHNvk2swQZQaWk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(5660300002)(4326008)(6486002)(2616005)(66556008)(8676002)(235185007)(66946007)(83380400001)(186003)(6506007)(21480400003)(26005)(53546011)(86362001)(66476007)(6916009)(6512007)(33656002)(38100700002)(316002)(508600001)(36756003)(2906002)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g0ZGdfXleJ1VK6pvEd+e538Nn0NSLht+OWpX7399SMKxlye7pl9FKZIwCHS2?=
 =?us-ascii?Q?sbzVh9xBoPvPpWemP50Xa0opGkDM1SH0xFOCDXOirgBvPSQcEDOzLwJktJ3g?=
 =?us-ascii?Q?pc9yhC0kzF7O6JwuwH7q767j0KivR5UIx/8s4TqJOx1gBVwZjNNep2qR0Epp?=
 =?us-ascii?Q?DNKZD9piZ2DQGC/wYCRvDD3wQgCBbzap5z+fg1GMvOkkRv+XpyGP64DuFM1b?=
 =?us-ascii?Q?dXbP1pJwfFwHj0d+gCQtoIrpH5Yy+yGS6ipxpg3ZPGW0y9tyXqKawgB70y8Q?=
 =?us-ascii?Q?wisVXkPtvDTl3kmDmLoW8CWr0x3ewVBbP8XAJ4Ad3OXtm7CSRSRm7QwU4KZe?=
 =?us-ascii?Q?uRWROkwXJB4j2BYIpJr5VQrIbaq1x4y1XzoxuLdOcoPVgTAthj8y58oIlX8q?=
 =?us-ascii?Q?qdxnSGviOnxaf+N5i258iEGwd9wCZUZmjAYK1qCKwUaUnc/FAQk9mBkSzvnc?=
 =?us-ascii?Q?Nu7Rk9McnNxmdn3MTR/vp5nM5XJKuiZLRnTOa4sg1ptUjvGETeI3Y/LOxCT5?=
 =?us-ascii?Q?S4xxCExPGJ5n0mZMueMtRNX0vgbWr9KMwLfsZ8uwCcKRjqnDG1d5zItrQrtg?=
 =?us-ascii?Q?Gp2WMJqlnetUnBBsSMRGHm08VhggZu36Qpjp4JIMT4EHBD5tE9mXi8tzuiDg?=
 =?us-ascii?Q?SYgSMjpTtfFm4xu38pN4WrxThDTUDP4Bw2T8Jxnm/O2M5+rgLRq2m/smkZmq?=
 =?us-ascii?Q?3VbeI2O/2luV3327lq6MEnTbwiN3E6olDKTUnxXUJ67RRZPks5l/NJOEkoTN?=
 =?us-ascii?Q?f5Pg2pvC0SXcebsStFn3SRiOGw6zv3epw4LZqen+8AKf1W8XIrDgxzSXkqLS?=
 =?us-ascii?Q?1JpmDyrRweyeOZJ5DZGMEfH0hGKaxl+sX7FPUGxTgutd21mYxkZdh+iSfIHZ?=
 =?us-ascii?Q?BuD+i4d4bcj8rqAD3TQ6oTk2ciJOMYlavvinWTcEwJtJm2wprVtZJ1M9jmkG?=
 =?us-ascii?Q?IvMA1n5boEquQPTpumJFm/U5BzTwPmJMikA1tXapmxAXmvy+Z2vd2On6gs6v?=
 =?us-ascii?Q?ZKcZYaA7XIeQ3ABp5LsbgJDpKCrePoUE39R5MhZhcCCDobMIrFAWBKQet6d4?=
 =?us-ascii?Q?cvYsZItA6jFivd+LljyVPA56D7PqSfYnkbOVTtbDrCiGwQopvrNS8d1dqoeK?=
 =?us-ascii?Q?cQIDcmWkPgkWxL5321YHPkREOMY30AtPGCytq9qlpH4huiVpgRguhXes+GSb?=
 =?us-ascii?Q?hq0pvszt7Y0VYM5txAmrOVsDFLsJ0ImgnBT9tyaKC2ZTiuCmpzh3L35Gv6BB?=
 =?us-ascii?Q?/+zNYu8IHubRx3trC2PyRqBPZGzUk/WjcCCApEjO0MWNrABziZI0HxBLnR3F?=
 =?us-ascii?Q?i48BRmlGOAwz+CdY2hSlNlRRDSZjddTF3BmMzfGV8AbO5K9YXo+0iS5X7Apo?=
 =?us-ascii?Q?LNyU52ILOxJEn52tdh/N8qYymaJzZb5/50AhFP338MWQUDidc3yB351q8R1O?=
 =?us-ascii?Q?Njh108MyEY7D8Ejpdum2KSDxnzQoiWN46RwRyxcxGf13O9e1tGcyyGMQqTuH?=
 =?us-ascii?Q?yIUKaCVNn3dfMgBzw0FQzmRXUMfUlO139BtZxoGVSwKbnVEkMDJayr2ybYQ5?=
 =?us-ascii?Q?R5mq/KnOK4PO+UrO1Rw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89d73ccb-0c23-4e02-35b9-08d9ebe0c04c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 15:27:58.3088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: saV9Jd/8pvqaU2bhh3NOINysZ3WXy63Y/eESHFXZg1nDnyCzaDQywb5t/fH7nsrl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4722
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_8354D710-C756-4FAD-97EA-93B63C58465F_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 4 Feb 2022, at 14:58, Matthew Wilcox (Oracle) wrote:

> Convert the callers to pass a folio and the try_to_migrate_one()
> worker to use a folio throughout.  Fixes an assumption that a
> folio must be <=3D PMD size.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  include/linux/rmap.h |  2 +-
>  mm/huge_memory.c     |  4 ++--
>  mm/migrate.c         | 12 ++++++----
>  mm/rmap.c            | 57 +++++++++++++++++++++++---------------------=

>  4 files changed, 41 insertions(+), 34 deletions(-)
>
> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> index 66407434c3b5..502439f20d88 100644
> --- a/include/linux/rmap.h
> +++ b/include/linux/rmap.h
> @@ -192,7 +192,7 @@ static inline void page_dup_rmap(struct page *page,=
 bool compound)
>  int folio_referenced(struct folio *, int is_locked,
>  			struct mem_cgroup *memcg, unsigned long *vm_flags);
>
> -void try_to_migrate(struct page *page, enum ttu_flags flags);
> +void try_to_migrate(struct folio *folio, enum ttu_flags flags);
>  void try_to_unmap(struct folio *, enum ttu_flags flags);
>
>  int make_device_exclusive_range(struct mm_struct *mm, unsigned long st=
art,
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 4ea22b7319fd..21676a4afd07 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2294,8 +2294,8 @@ static void unmap_page(struct page *page)
>  	 * pages can simply be left unmapped, then faulted back on demand.
>  	 * If that is ever changed (perhaps for mlock), update remap_page().
>  	 */
> -	if (PageAnon(page))
> -		try_to_migrate(page, ttu_flags);
> +	if (folio_test_anon(folio))
> +		try_to_migrate(folio, ttu_flags);
>  	else
>  		try_to_unmap(folio, ttu_flags | TTU_IGNORE_MLOCK);
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 766dc67874a1..5dcdd43d983d 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -927,6 +927,7 @@ static int move_to_new_page(struct page *newpage, s=
truct page *page,
>  static int __unmap_and_move(struct page *page, struct page *newpage,
>  				int force, enum migrate_mode mode)
>  {
> +	struct folio *folio =3D page_folio(page);
>  	int rc =3D -EAGAIN;
>  	bool page_was_mapped =3D false;
>  	struct anon_vma *anon_vma =3D NULL;
> @@ -1030,7 +1031,7 @@ static int __unmap_and_move(struct page *page, st=
ruct page *newpage,
>  		/* Establish migration ptes */
>  		VM_BUG_ON_PAGE(PageAnon(page) && !PageKsm(page) && !anon_vma,
>  				page);
> -		try_to_migrate(page, 0);
> +		try_to_migrate(folio, 0);
>  		page_was_mapped =3D true;
>  	}
>
> @@ -1173,6 +1174,7 @@ static int unmap_and_move_huge_page(new_page_t ge=
t_new_page,
>  				enum migrate_mode mode, int reason,
>  				struct list_head *ret)
>  {
> +	struct folio *src =3D page_folio(hpage);
>  	int rc =3D -EAGAIN;
>  	int page_was_mapped =3D 0;
>  	struct page *new_hpage;
> @@ -1249,7 +1251,7 @@ static int unmap_and_move_huge_page(new_page_t ge=
t_new_page,
>  			ttu |=3D TTU_RMAP_LOCKED;
>  		}
>
> -		try_to_migrate(hpage, ttu);
> +		try_to_migrate(src, ttu);
>  		page_was_mapped =3D 1;
>
>  		if (mapping_locked)
> @@ -2449,6 +2451,7 @@ static void migrate_vma_unmap(struct migrate_vma =
*migrate)
>
>  	for (i =3D 0; i < npages; i++) {
>  		struct page *page =3D migrate_pfn_to_page(migrate->src[i]);
> +		struct folio *folio;
>
>  		if (!page)
>  			continue;
> @@ -2472,8 +2475,9 @@ static void migrate_vma_unmap(struct migrate_vma =
*migrate)
>  			put_page(page);
>  		}
>
> -		if (page_mapped(page))
> -			try_to_migrate(page, 0);
> +		folio =3D page_folio(page);
> +		if (folio_mapped(folio))
> +			try_to_migrate(folio, 0);
>
>  		if (page_mapped(page) || !migrate_vma_check_page(page)) {
>  			if (!is_zone_device_page(page)) {
> diff --git a/mm/rmap.c b/mm/rmap.c
> index c598fd667948..4cfac67e328c 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1767,7 +1767,7 @@ static bool try_to_migrate_one(struct page *page,=
 struct vm_area_struct *vma,
>  	range.end =3D vma_address_end(&pvmw);
>  	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, vma->vm_mm,=

>  				address, range.end);
> -	if (PageHuge(page)) {
> +	if (folio_test_hugetlb(folio)) {
>  		/*
>  		 * If sharing is possible, start and end will be adjusted
>  		 * accordingly.
> @@ -1781,21 +1781,24 @@ static bool try_to_migrate_one(struct page *pag=
e, struct vm_area_struct *vma,
>  #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
>  		/* PMD-mapped THP migration entry */
>  		if (!pvmw.pte) {
> -			VM_BUG_ON_PAGE(PageHuge(page) ||
> -				       !PageTransCompound(page), page);
> +			subpage =3D folio_page(folio,
> +				pmd_pfn(*pvmw.pmd) - folio_pfn(folio));

Here you removed the assumption that folio is always <=3D PMD, right?

In the commit message, maybe the below is better?
In THP migration code, fixes an assumption that a folio must be <=3D PMD =
size.

> +			VM_BUG_ON_FOLIO(folio_test_hugetlb(folio) ||
> +					!folio_test_pmd_mappable(folio), folio);
>
> -			set_pmd_migration_entry(&pvmw, page);
> +			set_pmd_migration_entry(&pvmw, subpage);
>  			continue;
>  		}
>  #endif
>
>  		/* Unexpected PMD-mapped THP? */
> -		VM_BUG_ON_PAGE(!pvmw.pte, page);
> +		VM_BUG_ON_FOLIO(!pvmw.pte, folio);
>
> -		subpage =3D page - page_to_pfn(page) + pte_pfn(*pvmw.pte);
> +		subpage =3D folio_page(folio,
> +				pte_pfn(*pvmw.pte) - folio_pfn(folio));
>  		address =3D pvmw.address;
>
> -		if (PageHuge(page) && !PageAnon(page)) {
> +		if (folio_test_hugetlb(folio) && !folio_test_anon(folio)) {
>  			/*
>  			 * To call huge_pmd_unshare, i_mmap_rwsem must be
>  			 * held in write mode.  Caller needs to explicitly
> @@ -1833,15 +1836,15 @@ static bool try_to_migrate_one(struct page *pag=
e, struct vm_area_struct *vma,
>  		flush_cache_page(vma, address, pte_pfn(*pvmw.pte));
>  		pteval =3D ptep_clear_flush(vma, address, pvmw.pte);
>
> -		/* Move the dirty bit to the page. Now the pte is gone. */
> +		/* Set the dirty flag on the folio now the pte is gone. */
>  		if (pte_dirty(pteval))
> -			set_page_dirty(page);
> +			folio_mark_dirty(folio);
>
>  		/* Update high watermark before we lower rss */
>  		update_hiwater_rss(mm);
>
> -		if (is_zone_device_page(page)) {
> -			unsigned long pfn =3D page_to_pfn(page);
> +		if (folio_is_zone_device(folio)) {
> +			unsigned long pfn =3D folio_pfn(folio);
>  			swp_entry_t entry;
>  			pte_t swp_pte;
>
> @@ -1877,16 +1880,16 @@ static bool try_to_migrate_one(struct page *pag=
e, struct vm_area_struct *vma,
>  			 * changed when hugepage migrations to device private
>  			 * memory are supported.
>  			 */
> -			subpage =3D page;
> -		} else if (PageHWPoison(page)) {
> +			subpage =3D &folio->page;
> +		} else if (PageHWPoison(subpage)) {
>  			pteval =3D swp_entry_to_pte(make_hwpoison_entry(subpage));
> -			if (PageHuge(page)) {
> -				hugetlb_count_sub(compound_nr(page), mm);
> +			if (folio_test_hugetlb(folio)) {
> +				hugetlb_count_sub(folio_nr_pages(folio), mm);
>  				set_huge_swap_pte_at(mm, address,
>  						     pvmw.pte, pteval,
>  						     vma_mmu_pagesize(vma));
>  			} else {
> -				dec_mm_counter(mm, mm_counter(page));
> +				dec_mm_counter(mm, mm_counter(&folio->page));
>  				set_pte_at(mm, address, pvmw.pte, pteval);
>  			}
>
> @@ -1901,7 +1904,7 @@ static bool try_to_migrate_one(struct page *page,=
 struct vm_area_struct *vma,
>  			 * migration) will not expect userfaults on already
>  			 * copied pages.
>  			 */
> -			dec_mm_counter(mm, mm_counter(page));
> +			dec_mm_counter(mm, mm_counter(&folio->page));
>  			/* We have to invalidate as we cleared the pte */
>  			mmu_notifier_invalidate_range(mm, address,
>  						      address + PAGE_SIZE);
> @@ -1947,8 +1950,8 @@ static bool try_to_migrate_one(struct page *page,=
 struct vm_area_struct *vma,
>  		 *
>  		 * See Documentation/vm/mmu_notifier.rst
>  		 */
> -		page_remove_rmap(subpage, PageHuge(page));
> -		put_page(page);
> +		page_remove_rmap(subpage, folio_test_hugetlb(folio));
> +		folio_put(folio);
>  	}
>
>  	mmu_notifier_invalidate_range_end(&range);
> @@ -1958,13 +1961,13 @@ static bool try_to_migrate_one(struct page *pag=
e, struct vm_area_struct *vma,
>
>  /**
>   * try_to_migrate - try to replace all page table mappings with swap e=
ntries
> - * @page: the page to replace page table entries for
> + * @folio: the folio to replace page table entries for
>   * @flags: action and flags
>   *
> - * Tries to remove all the page table entries which are mapping this p=
age and
> - * replace them with special swap entries. Caller must hold the page l=
ock.
> + * Tries to remove all the page table entries which are mapping this f=
olio and
> + * replace them with special swap entries. Caller must hold the folio =
lock.
>   */
> -void try_to_migrate(struct page *page, enum ttu_flags flags)
> +void try_to_migrate(struct folio *folio, enum ttu_flags flags)
>  {
>  	struct rmap_walk_control rwc =3D {
>  		.rmap_one =3D try_to_migrate_one,
> @@ -1981,7 +1984,7 @@ void try_to_migrate(struct page *page, enum ttu_f=
lags flags)
>  					TTU_SYNC)))
>  		return;
>
> -	if (is_zone_device_page(page) && !is_device_private_page(page))
> +	if (folio_is_zone_device(folio) && !folio_is_device_private(folio))
>  		return;
>
>  	/*
> @@ -1992,13 +1995,13 @@ void try_to_migrate(struct page *page, enum ttu=
_flags flags)
>  	 * locking requirements of exec(), migration skips
>  	 * temporary VMAs until after exec() completes.
>  	 */
> -	if (!PageKsm(page) && PageAnon(page))
> +	if (!folio_test_ksm(folio) && folio_test_anon(folio))
>  		rwc.invalid_vma =3D invalid_migration_vma;
>
>  	if (flags & TTU_RMAP_LOCKED)
> -		rmap_walk_locked(page, &rwc);
> +		rmap_walk_locked(&folio->page, &rwc);
>  	else
> -		rmap_walk(page, &rwc);
> +		rmap_walk(&folio->page, &rwc);
>  }
>
>  /*
> -- =

> 2.34.1

Otherwise, LGTM. Thanks. Reviewed-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi

--=_MailMate_8354D710-C756-4FAD-97EA-93B63C58465F_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmID3XwPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKJBcP/0DcashIbsGxLVApN7ZxCKFJi1iXfhUvGprD
OY+HCcR6VXkrYbFY8WnJD4uvcOKliHULBvt6jKm274rvXkTGlrJJkoHRHDX1ALdO
INP/KlPx3Ry8NHatx5NhFtXjCtc3y5ZM7yn8J06b0rGOlrgnOKUb5Fnt7LgGGmtK
CCpIBsRQg24QOTghzSW04r1T3mJldm/5bQq4AQPl1VD845SALw0dqQGK5PQ/w4HF
gBjY/UYG/IFkQ+jCK5CubM33mhaD01NdIfjhQx5NaXR5lHZyWoePlCR4aEiQhYpq
NatAiTPIGBkf/CFpAwwCZrZC9N4lNKj+zNkhCcmy1Cd+si/IFJiERTnQsShnojLZ
bOZIK/cUTExiGXsS+DaFtWvbDKrD5oej7wlBM9isS3h2XtDtd7O7UIMvsEQo1qk8
PSvCCycJ/zMbnLeNBlVYo+qWmLlRkedsUf8xL38PuLPm5qQdYn3L32ekXaG3vWfe
PEpehgG1VBg45KdSD/8ZQe3ChbWlAe4w9pnFnhaotFqKVgzrlmmLSs4fBDbXCgls
k0r1LXS5fbI71TCfYFtr4cm6pA6eqrTHE9BKYkWxwkvYNJaXk7YUFzc1GMDl2mYI
P4/XdhbGtvENFYyNCjEibpce1g5rso24FZAmMrkbHyu8zyTFl9u1iPKDzmYAsnpD
INwEXuAc
=5q/U
-----END PGP SIGNATURE-----

--=_MailMate_8354D710-C756-4FAD-97EA-93B63C58465F_=--
