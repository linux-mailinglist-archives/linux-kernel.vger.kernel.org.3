Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605204FE364
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 16:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353571AbiDLOJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 10:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239866AbiDLOJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 10:09:41 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5685E759
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 07:07:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W4OcSD5jHUzuD2NT/zTEjjzhYIosdbznbl0/7r7kVJA/HgHM7OHrTHcilAXpdieTTLrZDI3nfS3LFEIz54UQW3IG1fz8F8zWhUVFkXailzC/Vt7ci5dpCwonXHT0RCMJj8Ozcj1aTvt63IgyxBrGk/u+t1oZ8zVi5wq9hFXjme1F7BcsZlUAhLHEcVIf1LdcMP6xzpAc3OBeLtQ2dzk8ot0aGdrMt3I0Lj7Ph7KNjSCL/AF3Vba7geSWTK1mCTopO8FzZq7KnL0qOZZDUqyWP62w71J4B1s6V8JzHHyhTGhazFo/fdNQ4wyaruYw3GDSk6FTiBoRksPqrHXMFD2JXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8c7ICDgtXiwqfasWsgWdEepUS9lPA5LxRyM6hP1Z5sk=;
 b=bsapsLasyE4OU9SH6duc/VcInLa4ohb8E/LrnkITAghTHmzix0aEuISNUBAtYTfVXBwGZSJWZ4VQVPjrHPmj2+6wjUe+keE0GSWj9RaBkvSlUf2Xf1V10SGOuUGhIpXDp+sJwhI3XobnQYwlAIRxUUdrE65r6kqn4jUQEfEsIaS7V8qkKAOgEB94ZxTiIif61wcuce5soaJLW6I5WD9+L6Z2XAjN9mUPqvbHWtTwXbPntpP4cfHecUmwFwy8Uwd7JnB52LLbTu1zYF3fLifgi50JkiedtvW/QG1otXx9XXqChZno4bQ6vwvku/icHJvgHZyYbIi3rLRJjo7p8kBg3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8c7ICDgtXiwqfasWsgWdEepUS9lPA5LxRyM6hP1Z5sk=;
 b=ggNn1EbW6TivBzw0R212z6wFStQSbSktl+dqW+LCNZrhHe2Vgae6jfFK04ksd+bQz7n46DY2fD4b51KUt+BX6gM3dWosjBS8P3riUjWuJNwz191TmX7ZCuSZmRv6PoFhlAAxYBkv5uMULntQOqNQog9C6zecQQCg5POz8DqxM4foyzDE1c+sDp5iOGXXvKc0ZY+TPqLCpux8am/W0U+g8OwIif/3I8evwvLWiI3TZt/K4wBzgWwGjS6wDKxnE6++APM6h+bqbLdOuBUtN2IngaGqGSTCPhCxWb+O3nDNnupX59qQ83gqUXZvViNXUNHr/LldQnDb2DMXYIxw35Ll2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by BY5PR12MB3716.namprd12.prod.outlook.com (2603:10b6:a03:1a1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 14:07:22 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::69f1:dff6:826b:7d9c]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::69f1:dff6:826b:7d9c%5]) with mapi id 15.20.5144.030; Tue, 12 Apr 2022
 14:07:22 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Eric Ren <renzhengeek@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v10 2/5] mm: page_isolation: check specified range for unmovable pages
Date:   Tue, 12 Apr 2022 10:07:20 -0400
X-Mailer: MailMate (1.14r5870)
Message-ID: <039317AF-985C-43D7-BB99-714DD6022B5C@nvidia.com>
In-Reply-To: <ccae12f9-a452-95a8-f404-3398dcdf5bdf@redhat.com>
References: <20220406151858.3149821-1-zi.yan@sent.com>
 <20220406151858.3149821-3-zi.yan@sent.com>
 <ccae12f9-a452-95a8-f404-3398dcdf5bdf@redhat.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_028807DD-778A-4579-8BBE-C6E2F028EBD2_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0125.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::10) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 462394d5-4315-420d-ddc3-08da1c8dc391
X-MS-TrafficTypeDiagnostic: BY5PR12MB3716:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB3716BE74E4B867646A4B9D6CC2ED9@BY5PR12MB3716.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M0UpgiAGE5hpFNDnol0pIkkEM5Tx/1Xb+cUkTGFVTbejyjqqyovfmg9rtPBXQT4Tv61d9IFhMxwtkA27Z+zQA4iWv3O/Y8HS7daR7TTI6k9e0lO0dRNeX6V/64jqNH/j+1Y9yCld7sBhpjj2naZe+owzA8JZrF8ubm2RpX8jqcMSgB+0Dpa9yuuq36ZEVURUiLiLz5iouCtT+Xi36nHEEYEOHrqlMKoOxXzWq2kB2YdaCWSv+sJUDMPN/7+4kralI3eWO511gZiMpEq8xvNFtnRuXmw1P+tuzIxNLRxtCAcskK5d3nvaPE9EypowM71uGlPARPjbfeG2lMNLJ9erI+WPGmv1FWx34sesZmKj5fQIfT9lve100/oA84OCPGE/KYxHHeV733jT7RK1dCgoLvnboeLGNgtW3zalZiE10mTT3bNcrQr235aBQTwsAorRdpEymmzUfSmq4pc06qYPUt5LjB/m2eofF5a09Crb5bXL/3FsxS2jZPZjzRAD8HIG8HwFjH1VFGCJjKBhUMaB+3Jr7gZKKaYrTtAqMuU2mjXmGR5dE3Aoum/oqVPmMUPC8FNUgGsWH7OoI3ByaBJGH/y1jKzR2pcbY8mpU9zsiTQsG1OdVnotrjghVZ6lqUbcENIux1VJ4MUvOyZaOkVEnlW0aePyl6szpHwAcQijBQzryokxHr31EK/+4OUzVHBvbV5cnQxL8A4k9IaphlGbc3AB0tQWABUMQBNeu3602P0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(2616005)(86362001)(21480400003)(6916009)(186003)(26005)(2906002)(33656002)(316002)(6486002)(66476007)(8676002)(508600001)(36756003)(38100700002)(66946007)(66556008)(235185007)(7416002)(6512007)(8936002)(5660300002)(6506007)(83380400001)(53546011)(4326008)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2RWtvQFwFPdU1o0XmadgNDdqFE9YEyWPu+bW6ILaMiDYddZzJCpXav+EM4SJ?=
 =?us-ascii?Q?oqV4T+sHoCxPkxZIBQxlS4f4SVhBJ/nkSnlAAWEqy/GjMl68uZXaWCvYIoj8?=
 =?us-ascii?Q?l0EtXhbkDeJO9QgrxquhcP1zRLiynvA0CBQOEOhkGdKPWdvgsNz6II5RBf0/?=
 =?us-ascii?Q?vR7tMR5MU5SDYGhKE+TdsAihablchS6TrqHvhT5c8GNY0jVp7uG3/HmjKuH0?=
 =?us-ascii?Q?bY6jPn4p1TrL2tFa4Sx1xrN5XqdYLAFQbS5IvwgTP7iZFynzZf9JxwkZbUKx?=
 =?us-ascii?Q?zYKyy/RAjos2dbWrS7INa2yZQYLeJJzcGbRAiQ3itVcA47Deu3CKKyfxTwLl?=
 =?us-ascii?Q?0lMQlqHQJKRFMAQD18M8cWneFcOGTO6HFloWyFlXGQfP4rDK27B2DraO6icq?=
 =?us-ascii?Q?FVc4p0CGgF5ZVAeIFlf1r1LxzD3Wqo/l1JanpNgvnLRZodzUyC2bhOlrDF6g?=
 =?us-ascii?Q?nxYHvuRlLK8Wd+ucQFK5v0oN9/GFbfOQGqyucVaAGPbroV7KfN5LiI14I0vA?=
 =?us-ascii?Q?tzNWqzPjZRdXGJ5qEtCpfLCbRncAkn9nYSMk+fi8OCM+Vky5K2EViNjuUk/G?=
 =?us-ascii?Q?V6g24aLW3hnSKFWfj4XE+1UWIs61rXi8ABM00vEh1h4j3apwDMeLZxYyzrd5?=
 =?us-ascii?Q?mSHbEY5ELI2ATcfhsChDaqe21w/wv+nmLgOgXwiyqWEBFnpsW9lJLL34ekp4?=
 =?us-ascii?Q?5qYdvttkNaM+sWnTT1ryjblqEs2U9G81uLPv5cO/NHNzrEPpMFn5ZCPTzgbk?=
 =?us-ascii?Q?7+ikOuMdrpkTCbrFb9FLy8HcseVg5ITwc77DVUhMSN3Hw7YXuwBI3OzDoMHn?=
 =?us-ascii?Q?24aapvMRQxzAWz0DZpODgf894YRsdYgbdlLezzuYiiGqvuC87k4dL8HoYvPn?=
 =?us-ascii?Q?jstg/I1BP8e4BBLeaekvWN6nJwYnT32AnnzwDjm2GJZkdHMKRK6utgAPZrwx?=
 =?us-ascii?Q?WvSR1WlImT9Y/ZQAUEEkGQ3LD7u5Fsp+oEPMVtltPYXB2+WMKubJ2wTA6c7F?=
 =?us-ascii?Q?1Gm5qgiaFW9A5rzRmsZ/pbr7rEuSaHlBYPMPz7dfHkjWOvASFT4NE3bsc0q/?=
 =?us-ascii?Q?y9IiYix5/JUNRVLLBZSf0geTv3CIXBl9FTAzvF/HG73IZ/rSmhagKN+NKAuZ?=
 =?us-ascii?Q?PAVC18I6KmAB+v28r9Qw5x8yCMHJak89Ob2BWVVZPMjh8DXNuGQUx38PB90g?=
 =?us-ascii?Q?wEsTwibtH6rLfa1oCHipJjaqQWyjiUJBw+ohFvG3v85p6BPzsgfWJ7HaAvQW?=
 =?us-ascii?Q?6Wm0I/eymlrFpSL74Zvtfj4rzZBk/xq5HKkbFEJI3U/FAvxZovifJLVsI9Ds?=
 =?us-ascii?Q?XFEcACVNCC3xIcrB8Nj5jzljWE0tuxVQ4P0fvNR17y633dtZdn3HWzD86b9c?=
 =?us-ascii?Q?cq+kvyUoZ1eUkvc+ty/HNbmy2mqDV6ZoEfU/o63pcVR1qThstoR+XqiHi7qt?=
 =?us-ascii?Q?otIm8RX7UX/VWv7rKzwgP24P3y62ZSk1AfEGckxZxg7E+VA85lMakCjXFSJs?=
 =?us-ascii?Q?dqtPgEuaDiYtGQNn+yh75qos9gEA65TwMy8eS2wb0Q5jnzDGC+DLkQa7PglC?=
 =?us-ascii?Q?pVfuheZ828NnVS3TNKCHjoTST/Um0AHK2TEvCc0I0emnofOkgON+jPAE3N2m?=
 =?us-ascii?Q?5vPw39a8dJHZj0P7/AEZpMggtssg1uvAHzU/ndjRBSdGbeDPfgou3guOjlHK?=
 =?us-ascii?Q?nNpXJ2Bau5DGq9ZJ9AcMhwCTwtebMB9DrehmDoGgx4usFRikOybzYycy+Zyl?=
 =?us-ascii?Q?XoZuctuwCw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 462394d5-4315-420d-ddc3-08da1c8dc391
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 14:07:22.4523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lgk3W3BVpnENVYZUcLK8CXSlNAHmS+8YXOQAeviu9R/VCFE4FzUkuhb0ZpNaPtl6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3716
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_028807DD-778A-4579-8BBE-C6E2F028EBD2_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 12 Apr 2022, at 9:10, David Hildenbrand wrote:

> On 06.04.22 17:18, Zi Yan wrote:
>> From: Zi Yan <ziy@nvidia.com>
>>
>> Enable set_migratetype_isolate() to check specified sub-range for
>> unmovable pages during isolation. Page isolation is done
>> at MAX_ORDER_NR_PAEGS granularity, but not all pages within that
>> granularity are intended to be isolated. For example,
>> alloc_contig_range(), which uses page isolation, allows ranges without=

>> alignment. This commit makes unmovable page check only look for
>> interesting pages, so that page isolation can succeed for any
>> non-overlapping ranges.
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
>
> [...]
>
>>  /*
>> - * This function checks whether pageblock includes unmovable pages or=
 not.
>> + * This function checks whether the range [start_pfn, end_pfn) includ=
es
>> + * unmovable pages or not. The range must fall into a single pagebloc=
k and
>> + * consequently belong to a single zone.
>>   *
>>   * PageLRU check without isolation or lru_lock could race so that
>>   * MIGRATE_MOVABLE block might include unmovable pages. And __PageMov=
able
>> @@ -28,12 +30,14 @@
>>   * cannot get removed (e.g., via memory unplug) concurrently.
>>   *
>>   */
>> -static struct page *has_unmovable_pages(struct zone *zone, struct pag=
e *page,
>> -				 int migratetype, int flags)
>> +static struct page *has_unmovable_pages(unsigned long start_pfn, unsi=
gned long end_pfn,
>> +				int migratetype, int flags)
>>  {
>> -	unsigned long iter =3D 0;
>> -	unsigned long pfn =3D page_to_pfn(page);
>> -	unsigned long offset =3D pfn % pageblock_nr_pages;
>> +	unsigned long pfn =3D start_pfn;
>> +	struct page *page =3D pfn_to_page(pfn);
>
>
> Just do
>
> struct page *page =3D pfn_to_page(start_pfn);
> struct zone *zone =3D page_zone(page);
>
> here. No need to lookup the zone again in the loop because, as you
> document "must ... belong to a single zone.".
>
> Then, there is also no need to initialize "pfn" here. In the loop heade=
r
> is sufficient.
>

Sure.

>> +
>> +	VM_BUG_ON(ALIGN_DOWN(start_pfn, pageblock_nr_pages) !=3D
>> +		  ALIGN_DOWN(end_pfn - 1, pageblock_nr_pages));
>>
>>  	if (is_migrate_cma_page(page)) {
>>  		/*
>> @@ -47,8 +51,11 @@ static struct page *has_unmovable_pages(struct zone=
 *zone, struct page *page,
>>  		return page;
>>  	}
>>
>> -	for (; iter < pageblock_nr_pages - offset; iter++) {
>> -		page =3D pfn_to_page(pfn + iter);
>> +	for (pfn =3D start_pfn; pfn < end_pfn; pfn++) {
>> +		struct zone *zone;
>> +
>> +		page =3D pfn_to_page(pfn);
>> +		zone =3D page_zone(page);
>>
>>  		/*
>>  		 * Both, bootmem allocations and memory holes are marked
>> @@ -85,7 +92,7 @@ static struct page *has_unmovable_pages(struct zone =
*zone, struct page *page,
>>  			}
>>
>>  			skip_pages =3D compound_nr(head) - (page - head);
>> -			iter +=3D skip_pages - 1;
>> +			pfn +=3D skip_pages - 1;
>>  			continue;
>>  		}
>>
>> @@ -97,7 +104,7 @@ static struct page *has_unmovable_pages(struct zone=
 *zone, struct page *page,
>>  		 */
>>  		if (!page_ref_count(page)) {
>>  			if (PageBuddy(page))
>> -				iter +=3D (1 << buddy_order(page)) - 1;
>> +				pfn +=3D (1 << buddy_order(page)) - 1;
>>  			continue;
>>  		}
>>
>> @@ -134,11 +141,18 @@ static struct page *has_unmovable_pages(struct z=
one *zone, struct page *page,
>>  	return NULL;
>>  }
>>
>> -static int set_migratetype_isolate(struct page *page, int migratetype=
, int isol_flags)
>> +/*
>> + * This function set pageblock migratetype to isolate if no unmovable=
 page is
>> + * present in [start_pfn, end_pfn). The pageblock must intersect with=

>> + * [start_pfn, end_pfn).
>> + */
>> +static int set_migratetype_isolate(struct page *page, int migratetype=
, int isol_flags,
>> +			unsigned long start_pfn, unsigned long end_pfn)
>
> I think we might be able do better, eventually not passing start_pfn at=

> all. Hmm.

IMHO, having start_pfn and end_pfn in the parameter list would make the
interface easier to understand. Otherwise if we remove start_pfn,
the caller needs to adjust @page to be within the range of [start_pfn,
end_pfn)

>
> I think we want to pull out the
> start_isolate_page_range()/undo_isolate_page_range() interface change
> into a separate patch.

You mean a patch just adding

unsigned long isolate_start =3D pfn_max_align_down(start_pfn);
unsigned long isolate_end =3D pfn_max_align_up(end_pfn);

in start_isolate_page_range()/undo_isolate_page_range()?

Yes I can do that.

>
> Let me try to give it a shot, I'll try hacking something up real quick
> to see if we can do better.

Sure. Thanks.

--
Best Regards,
Yan, Zi

--=_MailMate_028807DD-778A-4579-8BBE-C6E2F028EBD2_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmJVh5gPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUfhIP/3KPVz8K+mIKTOCUuMqC2gYxikIEbNK2OF2R
dux4h2h+tZTI6pMTxfJghc/hgxdK1hii5OJPPbKAdxpliLIzgRsnF7QJezCFMa7z
3mXdzhwZuhdVvX4WvTczcQmr6DbJluaDGRzQxsVLWE7hcHsKqrun+upDYD5tDfut
NEZylB1CoDIvi5ntSJSZ4grSZORuNqQqHEtYIB3hbkSO9gNEteOcIbXzSJyfpTWi
M5y9guxZFqxEIL5laFYCaqSF66h44CVJY6KzLQ7Y5g5h7JKwerkJY0kcyfmKxhPW
0cMgmMnZ9FUNbhJv6k6IS4a9P3q+8/nVPPxMXp+fPBGo7c3RN5Q1+jDC/GeNJcJT
By3gjFtSUdf+dSEvpoSQdI1XWM2cKcZRMRaCPSQKMjV9MkpceMQZkDV4GSzaLOtt
pLUN0aSdyoGjRE7uLtq0ji1cpBPfpR9/2m5/KAQU168zn5XE7hcQ4179AYcrS9DO
FHxEy+pOLo5vmj4P2A1Kbz56PRC1sFimnlgSw/PNZRt1dBQH8DiezN+ntyDLWeFY
+fWu85k8UHxHkKcQxoDGXSXy81NY0/d2iY9HxsygsqPDVoAJUDWYXrw8jPdgRC4B
slydcEmEhFdvc+DyLigW9Z0MRlDQa1/kp7QKrcisvyUnp8Z8/3/5g6YvLgx2h0BR
cglhNLe6
=+MNw
-----END PGP SIGNATURE-----

--=_MailMate_028807DD-778A-4579-8BBE-C6E2F028EBD2_=--
