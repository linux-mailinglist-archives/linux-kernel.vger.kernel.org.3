Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E68E948A6AD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 05:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347414AbiAKEHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 23:07:02 -0500
Received: from mail-bn8nam08on2044.outbound.protection.outlook.com ([40.107.100.44]:51392
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231165AbiAKEHB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 23:07:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QCkoEpUCfmbrC99azljTjLtI4U4hRF7njGBq4g3HezL+CCjRJmOx35dlObvyNphDwA85aq18AHjiXCWxRYLVjSJzctm1/AkRxnVwaOyZn58jh6eJEVSmAMZWJGxxHlgRNrB5KjIQICEJuZkHRaP3wxqRhSRlQGRWzd4hwlwTbEwx6JkhnOfxemKmJZ/+gaz+Z4lL7pOIix5Tdd7yjX5NBCHN+C/OTwXnnZB4IlKBg75l5+qL1bBKEgFVSwrEH2wK9L4zkH09aCkkOV9YHPse9tSrRXmWOcl1d92qHtnrLqc3QQLt7CN5gLISE4kEZkprna2/RE8mNRCGK8a1LVTPWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+H+nModkhmby4P1LGw0uRN8XOghs9F8HSowJqKc2bpc=;
 b=axQJ2YTz1U4vXooDZYDj8uPpl96halHkwBZbHi2r+/ppMeZVvJ+602WiPu3Adk+uQilVoN6vVc5TUGIZCvMeps6Wys6c8/g38XEIDlRvgW6WJWGLf6eD/PO6qJX9Jat9ebMRvrZYV395RsAeLb2qamspOcFpuHaxZ/ZxKO4/CAcMS3HIeKvPCS7sthnGarMwpCDQ1cegEkwufqJvswm2HxpL1eZF496tDueALZ+uK6qKE6u90dPM73/1Fbm2RdgqXaDzPryRDl0BMxOBkTxZaIE1ERKXAUuKZSIE4/DyEXLkrM/E4dLqKw/SYzhbJDZWS1wMXafwz2ALz7iwCjgwIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+H+nModkhmby4P1LGw0uRN8XOghs9F8HSowJqKc2bpc=;
 b=lB2MqtXpg9ka308pTTb8N25Pwze1b/8qst84s0PuNZHF4CLQ2m2exRCseUaZrl85McIVjZlhOCajkHOuIkuO29zoRUhPupiXLIeZIN2oCo1k+w+nrogdQsfbJto93DVkCGoye1nys0COhXrh4/5AIta6PtN6Lz9+vlfu0N35lepWrD6hMSaemsi3tRNO9OyUcrqbzXy4NeBuri2yI888PpZggBmfD/pbaJnXwA6JODECkUtcQbAfhznMzyCZEuTV+boGVZqlfREqzHfX+OtQ7q9xpqE0GNvBj0Nm3c9D9g4V/lb1zrs/8fKzNHakFpsMQrZWlHpZ5vQTpY5sJ3zFOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BYAPR12MB2790.namprd12.prod.outlook.com (2603:10b6:a03:69::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Tue, 11 Jan
 2022 04:06:57 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::8496:16fd:65c5:4af7]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::8496:16fd:65c5:4af7%4]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 04:06:56 +0000
Message-ID: <279070af-4ac8-942f-5096-f7f61db9aeb6@nvidia.com>
Date:   Mon, 10 Jan 2022 20:06:54 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v2 11/28] mm: Make compound_pincount always available
Content-Language: en-US
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Cc:     Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
References: <20220110042406.499429-1-willy@infradead.org>
 <20220110042406.499429-12-willy@infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220110042406.499429-12-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0009.namprd08.prod.outlook.com
 (2603:10b6:a03:100::22) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 346a1e72-440c-4bcf-991e-08d9d4b7cf04
X-MS-TrafficTypeDiagnostic: BYAPR12MB2790:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB27903A0D918726668F75C106A8519@BYAPR12MB2790.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C6lzgbu70q8+48F4LqikshBEf/qHx/rUrb4pr/j2jgCLVpLWmROIgY534h03c1YceRgGJq8J5SWKZhwDiCY6vk3bteefyRPjsYtm2c/xTc7uoJoOcZ6gJ6PdueRlp5Ym9VzC/uzn2dH5ubutZZcWNLdAqGXpBVqnamrU200vSBjRXuIRyQD8a+3F3h9d5xqfjEIryif1lHbFzsVQzBAxJOw/6sfbOff47kz5QMyys7uhk8MFbiAu4RF3C6JMTSJ7KmpX209QLUnI2i3AdH68eBq6eerJKui6AZE/Jpw+jetwqwLXdAK1cJgTAJoFrm05jQsrSAl1K0b04bQoW8mzygw08OiE7MON0rwXcFTRCdEGDijbVA/qhgA7M/afr00PPleMBqYPw2UUlYZfxF5yfbTvBkbbesHab+Flk2nO2zvuOo1c45n3rhp3d6C5NBO5/1V1+liZfw4qHppZFp21ZOU+fzvbqm0D7cX0Fw+BXrQQMHQpd5NSvlOo/b+uIjAsynVSYjZFTvQtsaCWRHDIC7oJj4O9OwNx3KPZr6+vbylzTitcAWeIg44PSKLaDZojiguPSYhYB4+O+cRh2m4XOpqZtfMMzw4296KaWWdR6UvUNkAd1hXIVv42QKIvLbItWm8dJy4HKULh9oWTuj0BJEdX5fuR4UJVEwo6PG2iw3a471qyJHyKrEvaDsLhFNoeUEKuNvZRX8G4HZGw19n/oHcdxzoJVG3mlG3HAWBFCCw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(6512007)(8676002)(31686004)(26005)(66476007)(508600001)(316002)(66556008)(5660300002)(36756003)(66946007)(186003)(4326008)(6486002)(54906003)(2616005)(86362001)(38100700002)(31696002)(83380400001)(6506007)(53546011)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3RpbFNoaUk5b0JqcVpjYzZnUjBWYlZURkUyRG1vL012RE5UMFNGMzJObDJW?=
 =?utf-8?B?QjZOYWRaR0FnTnUzMGd4Snpyb1AxQTR0OHpJWmFlUFFSUldqR3lvdFpRRWs2?=
 =?utf-8?B?dEUyN3RDdVNjT21iRGhUaEZ3VjFyMWJkTlV4L0YrM1ZFWkdZT1FLNHBhOFRW?=
 =?utf-8?B?YVRYUG1HMlhCMWFnd1RUV3FBaWlOZU1EUUJNYXlMTE9wVThoTlphM3B2bWtm?=
 =?utf-8?B?WWpvN2xFSU5oUDJlQ2xUUXpFcW1lQ2RjWXkzTnhwZkVsMjdIZTQralhiek1y?=
 =?utf-8?B?eUF1NEJkRUhMMWUrSlpkclFPY2RhNGFtZGZSWTBCd2lETUxveGRxSXlNc25P?=
 =?utf-8?B?bEU4dFhuYWduejlGaEZPcTNxTk1rWmlnamdxaVF3VTR0SzA1Q0Z3UkhwUW84?=
 =?utf-8?B?anlpdDF1UWJ6RVcyMXYzN2J3U2oxWS9IU2JibEh6dTVQL0tUOU9zS3JKTlZL?=
 =?utf-8?B?Q2NnRFhiY25RVzlTNC9ZQmlYeDRKYnpaL3h3ZmdjMzd2Q1Y5bUkyV0JETWU5?=
 =?utf-8?B?YWl3cDJ0c1B4MXZZeU43NUpQaWQxdm9raC9rRDV3b0xKbzBLdlEwNStwalhV?=
 =?utf-8?B?KzBkZGZkYnZnQjAvQUhuYXJ6b0N5SmM0YmpxanV6TE9jN0JDa201cDI5dFdj?=
 =?utf-8?B?L3hSV09uWnlVU0FteDN6ODdqZVEvSFhIVGZaTlJGemk4NnN0WmQ5Uy9OSVBN?=
 =?utf-8?B?dDhLSXJxTGpmOUlYdU01S0JkbXFzV3NjQ0llb0tacVVGVXQ3YmlDaktPU1ZL?=
 =?utf-8?B?a1dOblZzZjhUdW1FYmw4YkEvMTJSRHEwQUJGQzhMRDhvbDdINzJSaGQvYXZ3?=
 =?utf-8?B?VWlESDFjdzhJQjZCVTJxSUlHdHZHRVpNL29LRzlOZ1Z6V3JCN1EzVlFhdS9z?=
 =?utf-8?B?WnZZdmd3UVdIZzJybUtVTUtmYU1MTlBscWFDeHlMWjlnTWY5RW84T0ZFZyt3?=
 =?utf-8?B?K2VKeXp2bTNORmRody9ibHVwMkRmZktvUE1BWXEvVzlhMTZSM0NuMWZnbXJh?=
 =?utf-8?B?MnptRU9LeVlGNGZmNEwySm5SZ3pyUzY3VXR3ZXBKYTU1Q09JU1gzTmVvVEMw?=
 =?utf-8?B?dU4xSmZ0b1EyYmRvdjRTY3NmZXg1Q0lJTWtLblpZMWprNUU3ZnVVK2hoc1Vu?=
 =?utf-8?B?ajhwSnM1QlpxWFhTUDRLZ05VcnhwR3BVRHZqOU5uNS9GYmdWaUdGdHh0N3E5?=
 =?utf-8?B?dUVKUzk2d1RLNHdYR0FWcGpWTElrQUJYbFBGbjZjdHFjc3NvMVBGdXFueUdw?=
 =?utf-8?B?YWhxUWJjSEkxeFRtUnZFVVhqY1lpSWNFNFlXMjhmU1JxbktFb2JydFJLQkpv?=
 =?utf-8?B?NUxwWVFKUVlhWXBrb3RodTVxMTBZbXZrbDlrR2x2M0w1ei9FbUdFUWd5SEg4?=
 =?utf-8?B?Y25HM1NRYkhaN25mTjF4SEdrT2R1WG5Ja2k4WmJkdWtnQjdIY0dWS1FsbzJC?=
 =?utf-8?B?Tk5Yd0RZUVQvbDI3TGI5S1ptSUlTb2xGTHMzckJEY0I2N2pyTDByMTlqNGc5?=
 =?utf-8?B?d2lKVGR0UFVMSmcrU0xsQytKNmU4L0dxNlF0Yy8wYitYb0pxeGZib0dUY2s0?=
 =?utf-8?B?MkxhYkMyT2diUlpqanZwWHlYbHY4bU9zbmY3OXVsVnN4UmhQSFp6YU5lbU5C?=
 =?utf-8?B?U3RnY2lZbWkvUkRuSTFocGxwRjBBWEtESzJEMUs2czZBV0hXSDViTkZTUjBZ?=
 =?utf-8?B?L1lzUjV5RmZRSUY2WnRDeUFoSTJBNHY3aG5TWmJYUGNoZHJySUQ3cGh3OG04?=
 =?utf-8?B?RVBRRFRkWld2U1pyYmhIc2FYUUhuUGE1alp3b3I4dEVOeE02cEhZbHJoYkFH?=
 =?utf-8?B?QUFyTGlQNkJGTTZXaTloWkxNSEZkNXd5SW5RUUlxTzJ1VjdTaWdpdkMxQks4?=
 =?utf-8?B?L2FWalp1NmdiZlZOdjRxL21YSkFjZU92M1c4QXZVVjRmenYra0Y3cjVuVkxY?=
 =?utf-8?B?dFJ5UWRVR2g3V0FVVnBoOVUra28rL1htaENLQWtOc3REYlF0N05SNEYxcGhP?=
 =?utf-8?B?dDQycGM1WVVtcXViSlo4bGk3MEVTRkpYdExoUjFzSDg3dk85Ym5xbjBYd3hz?=
 =?utf-8?B?dURqenM3Vjk3VU4xMTVTUmxleVpkYXpvUjdnTWp6c1d1eTFVK1IvaG1IRXM0?=
 =?utf-8?B?SXhHaGNTQWhKVEd4d0M1SGpRWU95WVcrdlZOVERsWFYzOENvT3dlU2plMkl1?=
 =?utf-8?Q?bA0nTwDSJaZnEiV+v6JgGpU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 346a1e72-440c-4bcf-991e-08d9d4b7cf04
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 04:06:56.7861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LCFLvDwjYVxMIj2Fi5pfWVmGqvtP7FWWWTsTaqb1WIHy/8jbBXFFl3bSjomq+3XgCRSepFuCbqqbR5IIS0AP/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2790
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/22 20:23, Matthew Wilcox (Oracle) wrote:
> Move compound_pincount from the third page to the second page, which
> means it's available for all compound pages.  That lets us delete
> hpage_pincount_available().

Wow, OK. That's a welcome simplification. Looks good. A couple comments
below, too.

...
> @@ -955,7 +944,9 @@ static inline int compound_pincount(struct page *page)
>   static inline void set_compound_order(struct page *page, unsigned int order)
>   {
>   	page[1].compound_order = order;
> +#ifdef CONFIG_64BIT
>   	page[1].compound_nr = 1U << order;
> +#endif
>   }
>   
>   /* Returns the number of pages in this potentially compound page. */
> @@ -963,7 +954,11 @@ static inline unsigned long compound_nr(struct page *page)
>   {
>   	if (!PageHead(page))
>   		return 1;
> +#ifdef CONFIG_64BIT
>   	return page[1].compound_nr;
> +#else
> +	return 1UL << compound_order(page);
> +#endif

Now that you are highlighting this, I have this persistent feeling (not
yet confirmed by any testing) that compound_nr is a micro-optimization
that is actually invisible at runtime--but is now slicing up our code
with ifdefs, and using space in a fairly valuable location.

Not for this patch or series, but maybe a separate patch or series
should just remove the compound_nr field entirely, yes? It is
surprising to carry around both compound_order and (1 <<
compound_order), right next to each other. It would be different if this
were an expensive calculation, but it's just a shift.

Maybe testing would prove that that's a bad idea, and maybe someone has
already looked into it, but I wanted to point it out.

...

> @@ -42,7 +41,7 @@ static void page_pincount_add(struct page *page, int refs)
>   {
>   	VM_BUG_ON_PAGE(page != compound_head(page), page);
>   
> -	if (hpage_pincount_available(page))
> +	if (PageHead(page))
>   		atomic_add(refs, compound_pincount_ptr(page));
>   	else
>   		page_ref_add(page, refs * (GUP_PIN_COUNTING_BIAS - 1));
> @@ -52,7 +51,7 @@ static int page_pincount_sub(struct page *page, int refs)
>   {
>   	VM_BUG_ON_PAGE(page != compound_head(page), page);
>   
> -	if (hpage_pincount_available(page))
> +	if (PageHead(page))

OK, so we just verified (via VM_BUG_ON_PAGE(), which is not always active)
that this is not a tail page. And so PageHead() effectively means PageCompound().

I wonder if it would be better to just use PageCompound() here and in similar
cases. Because that's what is logically being checked, after all. It seems
slightly more accurate.

>   		atomic_sub(refs, compound_pincount_ptr(page));
>   	else
>   		refs *= GUP_PIN_COUNTING_BIAS;
> @@ -129,12 +128,11 @@ static inline struct page *try_get_compound_head(struct page *page, int refs)
>    *
>    *    FOLL_GET: page's refcount will be incremented by @refs.
>    *
> - *    FOLL_PIN on compound pages that are > two pages long: page's refcount will
> - *    be incremented by @refs, and page[2].hpage_pinned_refcount will be
> - *    incremented by @refs * GUP_PIN_COUNTING_BIAS.
> + *    FOLL_PIN on compound pages: page's refcount will be incremented by
> + *    @refs, and page[1].compound_pincount will be incremented by @refs.

ha, thanks for fixing that documentation bug!

This all looks good, the above are very minor questions,

Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard
NVIDIA
