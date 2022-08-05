Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDA758A7E1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 10:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235305AbiHEIPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 04:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237248AbiHEIPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 04:15:46 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FEA317596
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 01:15:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WWu7BWrZ+Ek9qWlat/E6vKW18QzKNNpQewmbEdqq0rgGbx9/F5acyUJzkGyTvfgRmYLgcxCNVTwm6eYJJ11N0QkbvntuQg8GR+L3AQOU+iXu5lypIglUqB0qb5rxPp7uhpsDYYWw18z1lnpNbsKwwAdIiUEt+7sqyVb4HlPXc+z4zIZt/pY1TR3yJcTKZSVuk9eLrtuD2jMXaJ5BjGxMlFDGzM+hw1ZbAbqPqewYEYxomJLPnCBXWC3QahnKHplRK8kPma+KjRMkUZOsd5o7W9mZz6ZKuWkv4mijo2f5kk7nWTU2Q06j/yeRqfTCmraEvLTgu8II/XzAMBZzvtF8wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ut7y/gNw+aOzFRI+p3aa1x16+2ttGrib6QhR9qiUAqs=;
 b=K9aEDrc4dwQ8ahcL7LegVBYA3RtgtCXfJn8D4UE7N4970f94uydqLb4Vid37lKj3ClmW8z2Vn0WXiE6YtSoejChyJakvu2Tsihe1KN84HGJFGKJzrxOQ84BT5GzNO9haGWYHvJFFZt71eZltCfa2PZAK336abr6k7HUjV7euTAfNPuRfhbqTc0qt8vT3cp8jfJJ47yEDZy+wvbfwonZQNkCYbU5S7u2GJQY2FmWc2OfJwxbJRu5vDq/PnJYal6m/j5ca9CkcF94h34+sdfFAP06zOLSfYC3wupwUGHHrjkE4ugF5jUKYqE3fb7KWzdXjO8XPyKSeavOoeUbcDlg+Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ut7y/gNw+aOzFRI+p3aa1x16+2ttGrib6QhR9qiUAqs=;
 b=kqHptCupH21AzCLvIp5EfMxU2q6t9QimWWnlO/b7SHKXGdWzLRCL1T/HzorzaAJCi5TrJgVOI8cIJDTecPvnrTZCZRPzoJEP1THzaUSMa4fP9TMC+5wrjHcMAF4r/pLitF4IKOIidh0CDb1DfdFs8X+/rY/Zpp21I9rJzLbuwwow3SS3EtbHdqelesuxc+t/V19pE8UNADdlZw/xve07Tt28RkE7JKQj0jRR/RGLVdvkeK+F0yaWvPDdmBMDlDzUU08ZOgN69pl02bjTWeWcjSBRqied0YkodQawNo0YOUz3az+HoW/O2Gh5PMbAcnwL0XBBDPepbBWHqVHJgrbeIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by PH7PR12MB5783.namprd12.prod.outlook.com (2603:10b6:510:1d2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Fri, 5 Aug
 2022 08:15:43 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5%9]) with mapi id 15.20.5504.016; Fri, 5 Aug 2022
 08:15:43 +0000
Message-ID: <65a9b473-9696-04ae-862b-8d4947c22703@nvidia.com>
Date:   Fri, 5 Aug 2022 01:15:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 2/2] mm/gup.c: Refactor
 check_and_migrate_movable_pages()
Content-Language: en-US
To:     Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        "Sierra Guiza, Alejandro (Alex)" <alex.sierra@amd.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        David Hildenbrand <david@redhat.com>
References: <3e20a542e756bbc0f66435c9344ff674f3ff7ac7.1659680600.git-series.apopple@nvidia.com>
 <3f6d04570907ee80f030ffaa85e8f506b3d31fc1.1659680600.git-series.apopple@nvidia.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <3f6d04570907ee80f030ffaa85e8f506b3d31fc1.1659680600.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0P220CA0006.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::29) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f4dc0a8-90a2-492e-86ce-08da76bab106
X-MS-TrafficTypeDiagnostic: PH7PR12MB5783:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DAX43ATzXvFkbuYRr1vOHHrV87DSiKi9vM5GoOA8ftGY3CduJ8hs6EICvgSeLvd0LAh6IdgEjn0KFrN6DF+ITHmtuIYvyzKEEtWRJudeC30uZ2qswleez0u681NxHwzol/jt5BGJPglc5ML1DxA8ujxLHRUCU+Og57ui+B84NnOMEmVkKBOjtrm+0i+Rw1jxyMp3ymCECMSLGUWxdA06m/OxsVygn8azE7vgdxHGzb8prKAqKTvSJr03MAzG2n2ofD+P7Dq5J/B+XCiucA8Bst8sptMNxxM/rS41dsyVyVAFJsFyVsDr21/eKEA4K5cjFSJliDbnRyGWMM7im0599f72OAV8gqPWpKvsWbYuu9dfY1BptTnA4eGE4fX4g7ca9CZp9vfv1SSOTUx7kGfK3aUvoFkaxmoMAe3tNSHSOv5DpSygjF0HBxeB/MuGDJp+iBMuLWKHTxh7FxcO6ZE4TUkqIF2tmYi5WgLS5BIP3LsQEBBdTiFc34b95cGJaj/ga6ZhNPivQZ52tvKEtQH4Xt2if3EvHKc5g/1/W+SbYXBDNAunh/LlnPWKIigjkp9QD9bu8t1wRhW6Y4+uVbafnbzg/VWcNAg+lzMAjUpWRFCKT/m8eAKNpNCIfasCSGrbkvwMSMH15PoVQblKr+VoIUM/D/yIHoeaBZi9ujx5JxLCGPCM655DYbzpyG0oY3mMUuVO5VMYRQVtCzxGGg1ay/QnpOXLVGnz2tPsbAXFOThc37e1b6KyZIUgnkUBWZRUy+0dha+QC/5rfbfpuXwSp+4wSpQboYDiX/MQZfqc8NA+328TgliJg6jftGHzL6khLRzkBJHmlYl4l1WmsRGl03g4GTUo5gRIM7wtTBHNcgHeMIwSGgahJtjTy6VkHH8qVx0rYUTQzKAzSlyN61X1Er15WFdvfzdWOeQ+dY6gXyo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(396003)(346002)(366004)(39860400002)(41300700001)(186003)(2616005)(53546011)(5660300002)(4326008)(31696002)(6506007)(36756003)(26005)(6512007)(478600001)(31686004)(966005)(83380400001)(6486002)(54906003)(2906002)(316002)(86362001)(66476007)(8676002)(66946007)(38100700002)(66556008)(8936002)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlgvTjM5allvK1RmWHI2Mld2YlRPakNZUWgwak10Q3NGZ3JlbXdlVTR0ZEs2?=
 =?utf-8?B?aURuUDc0UHNoNGRLRStTU3VoUUI3VytoUENQdjdBQ1lPWHNOZnRHRVJVZ1dQ?=
 =?utf-8?B?WWZUbk1qRFJnSUpMc0pwdzVBQnpDNDJlYXl4L2I3SnBvb1MvRDBJcTMxSkZS?=
 =?utf-8?B?LzNZL0p1K2tYT1lDSlNRR3VDcTZsdFFDYysrMFVtU0M5WExJWGVjUjBsRG5F?=
 =?utf-8?B?QncwUTRzNkFleUNQZUJSTTcvRTc0NjVtb1Fzdzg3VTkwMG13MU1wNjFadmRt?=
 =?utf-8?B?U3FMVFdiV0NBcUtwVkVkVnVTbjZ0MDhJbUs0RVJVQURkZGticVFjRS9ObmZm?=
 =?utf-8?B?blNsbnhvenlQTUZValh3VVVzaGZXWTRFTGRRajBoMG5CMzlGMjRaWUg2K1Fr?=
 =?utf-8?B?LysyN2xqVTNWd0JmOXdXUFZtRGtMOWIwS0Z4NnhMdGt2UnhYYnliaWJ3SmND?=
 =?utf-8?B?dHRsZ0Y5VG94K3AvWmJRWENYQUllRElaVHZ3K3BMaVI4ZUNCaVE0UlBmVmVR?=
 =?utf-8?B?cXNFaUw4RkVqUXdaNmFlZ1F2RlZBNzhneVhNMzd0cjZGcVZrdm1VREhEQ2tI?=
 =?utf-8?B?TDFLcVk1ZDdCejZDYkphaWFwaStxd1pCR1VlK0psSGhoN01sUUVGd1ZkWnQ3?=
 =?utf-8?B?cHNlTVh2L3UyMW50dU41L1NyQjNHNDJ2Y3pkTmdrMEZFR0laSFptaDNYSGlE?=
 =?utf-8?B?S2lvUnBESkdpakRjVURUV0MyT3lraDR4dU5sYmFvaHgwN25mU2x1WSsvUmU1?=
 =?utf-8?B?dGdNUzF3TlBlTUVUMk8xTjBEcEI5WjZNTWVueHlHQTc4VW0vaW5oQzF3eGla?=
 =?utf-8?B?Q1A4Y290MW5QelFKWVZuWFdnVDBQNHhJWFRzc0NxZUUvWU1IVXVlZmdKaU9z?=
 =?utf-8?B?U2FRSDdHY0lDRnB2bEx6VmZ0N2FaRXh1L3B6cHFxdzdiS0JPRGwxWVhyc3Ni?=
 =?utf-8?B?bytLbTJWa28yWWEwWUNwZUNSRG9CZUxaV1pEQTBBNFUwL3E5cUZNQWxKZEN5?=
 =?utf-8?B?dWpHRHY0UWJnTXNUY09nak00d1pHY200dzZ0bDlZNDJSam0yTEVnalBnenNZ?=
 =?utf-8?B?SVJvRkZ6Z2dxMWc2a2R1YzFzK0R0UXlCNmtsYzRLWkF0Y1ZjM3hNUXMrM0NH?=
 =?utf-8?B?ZFBJeUQvRVVHOForSSs4cjg0cmlsTW9uOHVxMkp3bmxmRDJzSFhHMXFPVkk2?=
 =?utf-8?B?MThZQm9pS3FCUXd3T2pYQ2x5R01zNGZRQzNYSFphRXBVODRLbk5IOFZnUTFT?=
 =?utf-8?B?dFQrejB3NTB3aTZRV2Zob3JzSkRQMkhPYTBEd0hhdHhudDZwZkVSMFdFbkRC?=
 =?utf-8?B?VzgrSWpyVk1YOWc0dkhMdFF3V3BmbU9Hbno4OXdFdjFDU0t1RDhNaU9aeUoz?=
 =?utf-8?B?WHJUQjBXVGJENnVXMWZnYVk4MkdWZXNGUGtWdUF2dVZ3aGhWWDd3VFROeXVB?=
 =?utf-8?B?OTFTUFJHdlFDNmZab2Iwd1orUC9aVnErd3hSRUVwSTNxdkE1cVBPeTB3M0ZZ?=
 =?utf-8?B?Z3lvVk5MUzZVWWVwbCt5aXdKYi82UVpHdUhZcktPRFMxM2V4S1JhVlFCOVBn?=
 =?utf-8?B?TjUxb0sveDBmSUppWDQraVY1c1dTNFVRZmlJb2F2aGJUc3FjeXl0d1d2V00w?=
 =?utf-8?B?d3lqRmFHS2Jlc21aeXRZVDRkVVh0OTZ3VThJelhPMncxZVlBSTNCZnFuUDgr?=
 =?utf-8?B?eW84ZEV3K2xLaGhXa1JJVEJxMlV4THdpN1JYODl1cmswcTJOYkU0OElMUWVy?=
 =?utf-8?B?L1Jjc3JJaHhvSFMySjFJVVYvT3ZFOHRRR1h1Q3hQUytWVW85U1R5d2ptYlAr?=
 =?utf-8?B?aUNGSkZHTlg5K1NwSEF0aEo2czV1emJRSE9BOTBhako5RGpVRk4yVkJiZlpK?=
 =?utf-8?B?Y3UxTzVKU3ZXdFhISWVzRFpDdExhQnptb1puZmt0K09uayt3bG05Z1l4Y0Iv?=
 =?utf-8?B?MGhPVW9CUWdZOTRMZDdUTE8zNXpKME0xLzkwZlRTaXltN00wdTZqclJsZFRh?=
 =?utf-8?B?blhuK0xJWU9Uc25GdWJKdmFRbVlCNzRrUi9qaGs0TDREWjRJYUs2d05Jajhp?=
 =?utf-8?B?c0lxK1U5ZjlHT01oSjEyUEZVV0R4ZXR3NTVBd3hHaWRKbUsrR1FmS0RYdTlz?=
 =?utf-8?Q?5Z+nNJIWT540WqrvKhZyB/hNO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f4dc0a8-90a2-492e-86ce-08da76bab106
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 08:15:43.3742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SLB44pbm6AGTOsyUsRk6qx1m1lvH2ukK02Nz1ZrpwSrFM5Hp7u0KuSMMaS/bRZThsy3PzZPcJ4n3I2jGc99brQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5783
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/22 23:29, Alistair Popple wrote:
> When pinning pages with FOLL_LONGTERM check_and_migrate_movable_pages()
> is called to migrate pages out of zones which should not contain any
> longterm pinned pages.
> 
> When migration succeeds all pages will have been unpinned so pinning
> needs to be retried. Migration can also fail, in which case the pages
> will also have been unpinned but the operation should not be retried. If
> all pages are in the correct zone nothing will be unpinned and no retry
> is required.
> 
> The logic in check_and_migrate_movable_pages() tracks unnecessary state
> and the return codes for each case are difficult to follow. Refactor the
> code to clean this up. No behaviour change is intended.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> 
> ---
> 
> Changes for v2:
> 
>   - Split into different functions as suggested by John.
>   - Made error handling more conventional as requested by Jason.
> 
> Personally I'm not entirely convinced the conventional approach to error
> handling is easier to follow here but have left it in for feedback as I
> might be getting too familiar with the code.
> 
> Originally posted as "mm/gup.c: Simplify and fix
> check_and_migrate_movable_pages() return codes"[1].
> 
> Changes from that version:
> 
>   - Restore the original isolation failure behaviour and don't fail the
>     pup. Instead retry indefinitely.
>   - Unpin all pages on retry or failure rather than just failure.
> 
> [1] https://lore.kernel.org/linux-mm/814dee5d3aadd38c3370eaaf438ba7eee9bf9d2b.1659399696.git-series.apopple@nvidia.com/
> ---
>   mm/gup.c | 159 ++++++++++++++++++++++++++++++--------------------------
>   1 file changed, 88 insertions(+), 71 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index e26ccc0..60cb30a 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1900,20 +1900,14 @@ struct page *get_dump_page(unsigned long addr)
>   #endif /* CONFIG_ELF_CORE */
>   
>   #ifdef CONFIG_MIGRATION
> -/*
> - * Check whether all pages are pinnable, if so return number of pages.  If some
> - * pages are not pinnable, migrate them, and unpin all pages. Return zero if
> - * pages were migrated, or if some pages were not successfully isolated.
> - * Return negative error if migration fails.
> - */
> -static long check_and_migrate_movable_pages(unsigned long nr_pages,
> -					    struct page **pages)

Let's add:

/*
  * Returns the number of collected pages. Return value is always >= 0.
  */
> +static int collect_unpinnable_pages(struct list_head *movable_page_list,
> +				    unsigned long nr_pages,
> +				    struct page **pages)
>   {
> -	unsigned long isolation_error_count = 0, i;
> +	unsigned long i;
> +	int collected = 0;

This should be an unsigned long.


>   	struct folio *prev_folio = NULL;
> -	LIST_HEAD(movable_page_list);
> -	bool drain_allow = true, coherent_pages = false;
> -	int ret = 0;
> +	bool drain_allow = true;
>   
>   	for (i = 0; i < nr_pages; i++) {
>   		struct folio *folio = page_folio(pages[i]);
> @@ -1922,43 +1916,16 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
>   			continue;
>   		prev_folio = folio;
>   
> -		/*
> -		 * Device coherent pages are managed by a driver and should not
> -		 * be pinned indefinitely as it prevents the driver moving the
> -		 * page. So when trying to pin with FOLL_LONGTERM instead try
> -		 * to migrate the page out of device memory.
> -		 */
> -		if (folio_is_device_coherent(folio)) {
> -			/*
> -			 * We always want a new GUP lookup with device coherent
> -			 * pages.
> -			 */
> -			pages[i] = 0;
> -			coherent_pages = true;
> -
> -			/*
> -			 * Migration will fail if the page is pinned, so convert
> -			 * the pin on the source page to a normal reference.
> -			 */
> -			get_page(&folio->page);
> -			unpin_user_page(&folio->page);
> +		if (folio_is_longterm_pinnable(folio))
> +			continue;
>   
> -			ret = migrate_device_coherent_page(&folio->page);
> -			if (ret)
> -				goto unpin_pages;
> +		collected++;
>   
> +		if (folio_is_device_coherent(folio))
>   			continue;
> -		}
>   
> -		if (folio_is_longterm_pinnable(folio))
> -			continue;
> -		/*
> -		 * Try to move out any movable page before pinning the range.
> -		 */
>   		if (folio_test_hugetlb(folio)) {
> -			if (isolate_hugetlb(&folio->page,
> -						&movable_page_list))
> -				isolation_error_count++;
> +			isolate_hugetlb(&folio->page, movable_page_list);
>   			continue;
>   		}
>   
> @@ -1967,59 +1934,109 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
>   			drain_allow = false;
>   		}
>   
> -		if (folio_isolate_lru(folio)) {
> -			isolation_error_count++;
> +		if (!folio_isolate_lru(folio))
>   			continue;
> -		}
> -		list_add_tail(&folio->lru, &movable_page_list);
> +
> +		list_add_tail(&folio->lru, movable_page_list);
>   		node_stat_mod_folio(folio,
>   				    NR_ISOLATED_ANON + folio_is_file_lru(folio),
>   				    folio_nr_pages(folio));
>   	}
>   
> -	if (!list_empty(&movable_page_list) || isolation_error_count ||
> -	    coherent_pages)
> -		goto unpin_pages;
> +	return collected;
> +}
>   
> -	/*
> -	 * If list is empty, and no isolation errors, means that all pages are
> -	 * in the correct zone.
> -	 */
> -	return nr_pages;

Let's add approximately (maybe there is better wording):

/*
  * Returns zero for success, or -errno for failure (or partial success).
  */

> +static int migrate_unpinnable_pages(struct list_head *movable_page_list,
> +				    unsigned long nr_pages,
> +				    struct page **pages)
> +{
> +	int ret, i;

There is an uneasy mixing of int and long and unsigned long. Instead, this
should use unsigned long whenever it deals with nr_pages. Like here.

>   
> -unpin_pages:
> -	/*
> -	 * pages[i] might be NULL if any device coherent pages were found.
> -	 */
>   	for (i = 0; i < nr_pages; i++) {
> -		if (!pages[i])
> +		struct folio *folio = page_folio(pages[i]);
> +
> +		if (folio_is_device_coherent(folio)) {
> +			/*
> +			 * Migration will fail if the page is pinned, so convert
> +			 * the pin on the source page to a normal reference.
> +			 */
> +			pages[i] = NULL;
> +			get_page(&folio->page);
> +			unpin_user_page(&folio->page);
> +
> +			if (migrate_device_coherent_page(&folio->page)) {
> +				ret = -EBUSY;
> +				goto err;
> +			}
> +
>   			continue;
> +		}
>   
> +		/*
> +		 * We can't migrate pages with unexpected references, so drop
> +		 * the reference obtained by get_user_pages().

The get_user_pages() reference is confusing, since we only handle FOLL_PIN
here. It's hard to connect the comment to the code. Maybe a more precise
pointer to where the reference was taken would help.

> +		 * folio_isolate_lru() takes a reference so the page won't be
> +		 * freed.

Also confusing because it's difficult to connect the comment back to the code.
Maybe mention where folio_isolate_lru() is called from in this case?


> +		 */
>   		unpin_user_page(pages[i]);
> +		pages[i] = NULL;

Is this correct? The loop covers all of nr_pages, so we are setting every
pages[i] = NULL, for non-DEV_COHERENT cases. This seems wrong.

>   	}
>   
> -	if (!list_empty(&movable_page_list)) {
> +	if (!list_empty(movable_page_list)) {
>   		struct migration_target_control mtc = {
>   			.nid = NUMA_NO_NODE,
>   			.gfp_mask = GFP_USER | __GFP_NOWARN,
>   		};
>   
> -		ret = migrate_pages(&movable_page_list, alloc_migration_target,
> -				    NULL, (unsigned long)&mtc, MIGRATE_SYNC,
> -				    MR_LONGTERM_PIN, NULL);
> -		if (ret > 0) /* number of pages not migrated */
> +		if (migrate_pages(movable_page_list, alloc_migration_target,
> +				  NULL, (unsigned long)&mtc, MIGRATE_SYNC,
> +				  MR_LONGTERM_PIN, NULL)) {
>   			ret = -ENOMEM;
> +			goto err;
> +		}
>   	}
>   
> -	if (ret && !list_empty(&movable_page_list))
> -		putback_movable_pages(&movable_page_list);
> +	putback_movable_pages(movable_page_list);
> +
> +	return 0;
> +
> +err:
> +	for (i = 0; i < nr_pages; i++)
> +		if (pages[i])
> +			unpin_user_page(pages[i]);
> +	putback_movable_pages(movable_page_list);
> +
>   	return ret;
>   }
> +
> +/*
> + * Check whether all pages are pinnable. If some pages are not pinnable migrate
> + * them and unpin all the pages. Returns -EAGAIN if pages were unpinned or zero
> + * if all pages are pinnable and in the right zone. Other errors indicate
> + * migration failure.
> + */
> +static long check_and_migrate_movable_pages(unsigned long nr_pages,
> +					    struct page **pages)
> +{
> +	int ret;
> +	long collected;

That should be unsigned long, too.

> +	LIST_HEAD(movable_page_list);
> +
> +	collected = collect_unpinnable_pages(&movable_page_list, nr_pages, pages);
> +	if (!collected)
> +		return 0;
> +
> +	ret = migrate_unpinnable_pages(&movable_page_list, nr_pages, pages);
> +	if (!ret)
> +		return -EAGAIN;
> +	else
> +		return ret;
> +}
>   #else
>   static long check_and_migrate_movable_pages(unsigned long nr_pages,
>   					    struct page **pages)
>   {
> -	return nr_pages;
> +	return 0;
>   }
>   #endif /* CONFIG_MIGRATION */
>   
> @@ -2049,10 +2066,10 @@ static long __gup_longterm_locked(struct mm_struct *mm,
>   
>   		WARN_ON_ONCE(!(gup_flags & FOLL_PIN));
>   		rc = check_and_migrate_movable_pages(rc, pages);
> -	} while (!rc);
> +	} while (rc == -EAGAIN);
>   	memalloc_pin_restore(flags);
>   
> -	return rc;
> +	return rc ? rc : nr_pages;

This seems to add some holes in the handling of error cases. If -EBUSY
or -ENOMEM happens, then we return an -errno, rather than the number
of pinned pages. But some pages may have been pinned.

Previously it just looped if there was any error, so that couldn't
happen.


thanks,
-- 
John Hubbard
NVIDIA
>   }
>   
>   static bool is_valid_gup_flags(unsigned int gup_flags)
