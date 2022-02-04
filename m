Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F33434AA1A5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 22:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240789AbiBDVNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 16:13:34 -0500
Received: from mail-dm6nam11on2051.outbound.protection.outlook.com ([40.107.223.51]:61569
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237272AbiBDVNd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 16:13:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CU7MKOsv6CFMZRNFp6ItAfquc+cR819xR1lIVjUQul55VGfuxGkfA5rFLSrGfUxBNnEoDHt/BPUYIy0KIfJJ1lTd2Wf4Lyxbh4YGK9RgihY46CfjceMEiLp5rCqElTDv+FX3gV8mDF7AINdKuk0GXCMcyWwPTjjlrxdxela2vFJWgegbvikUviu07yw7YTOxUmo50oY9S4w2cb45IdOsV8WJdY/jp7Gnmmt035tQaLtLTIywLToRk++gIWc6/f+D9sXsshdvW8YgKZzbQ7v2Rh3AxqqINHCYMQbI4VhVFDzw8kExFEMlMSiWsqIlocwM1HJAMzvAhO5YGlyHBjK5HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xa9b836ft3KeB5ZG0SOHjb7gkUax/aVgxFlTi8+2uKA=;
 b=c+N6kMq6QQ8+ame1BQo+IKgMySlgOA0p8OzYXZ/oHbYOWbtczhMsoTUAl/OMRGKYCCXIwEwOJbdF09E3iWlEDKlfE8Y+GumRn4GlYW43Jb2UK2y/DvH4SxPS9d4VMfQNA8Hy7JrndluGCsDQyB/seBoZFbSZ4CHg7eoTiQ7odJMw5Pv10SvpyqSHm1rPXyinu8qeoMjTYmKslQRmbONguhFxQT1RwTABaQUkbBare/z75597ezAJ+yqWcLta5w0QWofhZdzuSjoPVknjvdldXpSLa+tyDmPlTaU7o71Y2KChvs7RYXh6pHRoKvsxtZgigEeCH7Ck8M8p56jaUhtKLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xa9b836ft3KeB5ZG0SOHjb7gkUax/aVgxFlTi8+2uKA=;
 b=FBrrngDW9e/ZC2pM9U11ncK7LHVMV7AW4EMdQ9Wj9i0cxF/tbPEBrr3v+BSapMhqcWwbRlueMDmOeQl672Gh1M+aKI+enF3wfNcCyTdtOy/CfjCQ5hkO2e7kXljc3uRdAOFvzLgV2JL/wwxITBrb8PKkTt3EPC+8y3XKZ+gmixepwwiwQWPTgw5/E0j6bSviF2TiZyIWsTZA6b8xMh8ANi5LqF8KSPhzwL9i0LIzEDzEGu04ZCJqqvw3CQL9TSqP7+hs0lqGDHYKrCwZM9xaUi5i5UwePZYoMqfR1hJrZfs6nX+fgwmoZT42xlGcgYlq8JumlabbzZRilwzuYSteQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BY5PR12MB4819.namprd12.prod.outlook.com (2603:10b6:a03:1fd::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Fri, 4 Feb
 2022 21:13:31 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2d75:a464:eaed:5f99]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2d75:a464:eaed:5f99%6]) with mapi id 15.20.4951.017; Fri, 4 Feb 2022
 21:13:31 +0000
Message-ID: <185cd8a2-8d77-1933-987c-7b1d4f0e8603@nvidia.com>
Date:   Fri, 4 Feb 2022 13:13:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 01/75] mm/gup: Increment the page refcount before the
 pincount
Content-Language: en-US
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org
References: <20220204195852.1751729-1-willy@infradead.org>
 <20220204195852.1751729-2-willy@infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220204195852.1751729-2-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0081.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::26) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9ae7f86-23f1-4171-3938-08d9e8233232
X-MS-TrafficTypeDiagnostic: BY5PR12MB4819:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB481978E561E5CEFB8B0B1732A8299@BY5PR12MB4819.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eafu/h58Vmc0hP4TaajjAiUsBoVQ7fMrGvbzVGswNuiSP7nytDzlyXg7as8laTT+BM22QlyR3UmWwyuPg2Lh3zGx06LTednXzyJif8r4oW12V9ktz03T3kSm7eioM88a2twnHVJj7dnmLlgpiqxvIKDvfhn/jCRLhNfdovpD90w5o9HI7zWrFJ6nnk9reIIH5uPht0pI+2bh1CdFY8zPccpoaoWrdzh+nfbnyEViJgqX/IDshj7qL91/tdHqLKpggyDKMeUEuWzRLQanYScgCIk1/wI+ku2EHdEnYi6r9w+/WgWRwk+M+J9mlE6FP2LwXz6sl80s9E9G1rOKjTqqIf6FT+n4KzO1YPiilvO1BM76jZfGyh7fo60QDd2XZ1bWqL5yu1kz1tAU7DBmlnhSR7koon+MiFt9kvTeLEpYqcfVjQpvT0YQQ2qoy6Xm6OuCp6gL38lHpJzgiOd4AvDeWoO0ADwn6tj35VQWrgIK3+gelGoKWu8d18l7HpaXkvY+dGiuTMwHY0e3MEYmwzv9uLsmBFWW0I3MGAkVLr3Z+SDyVm/lEGv5eT2vHUnap9dPGw8Lm8fNHCQ01n1wc8OCy5o+MKIrrROl86tjZlxnrA0SJTtwa0U6/LHlfaqXSo2pZzFJuIfI67dpas/CB8RABA2hzKsiLxegNxL1WU6iCU3wYrIUnB1qqr2uNVt2rJ//7wKgwkNI2/Eg9ZmPv9Ce8rloQpzbhtYx//6nGjtHhJJO7hq87rDTaafQXhnd/ofh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(186003)(36756003)(2616005)(6486002)(83380400001)(26005)(508600001)(86362001)(5660300002)(6512007)(31696002)(53546011)(38100700002)(4326008)(8676002)(8936002)(66476007)(66556008)(6506007)(66946007)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWk3Rm04MXlwdmx3S1VnWlBJSFdUSmVHTUFJdlNsZG1NYUxzNzRqWTlWN0x4?=
 =?utf-8?B?NUt2MHBTdGZ3a1IrU0hPWlVZc1A3K0wyYmozQkZocC9XSjBaaWtyTWZWL2ND?=
 =?utf-8?B?TXMybmVBN3ZzL1FPdWprb0VPaU1mWHc0Y20xdmo5T2JPU3k1UEtMQVN6RTZr?=
 =?utf-8?B?THllc0M4ZFYwQjgxNUEvQ3NKNzBPOVc4TWpKTkFQS2ZsdjRaenlzU2xXbW14?=
 =?utf-8?B?dHRCQlpCRmZ4V1lETXlLWTdSS1lhYlpLL0l0K05ZQldWZjMzaW5UaitSWm9Z?=
 =?utf-8?B?ZmxaRTJSMjEzaXZmWi9iSG1RZU9PZTdLbEdObG85U25JY0J5UUs2RDAzVEs1?=
 =?utf-8?B?bzF3eXlJNjY2SGcxZkF5R1M2U0ZpMzBRelV6Y2JxVVpVWGlhT3ZTUWxTTDY5?=
 =?utf-8?B?eUV2N1lYc1ptZ1R3VThBWi9iM0VNUlI1VDVJQ0N3V3JUZjl1U2VzdmpndFkv?=
 =?utf-8?B?bWZpUmh4RGdPM3dhUGFpY28wTGtBR3VmMER6dXM3WlIzek5pZFZVL2QxaXJL?=
 =?utf-8?B?UjlmTElNWkVqYXVzMk16dlczZEI1Y3AwcUp3MC9KUUtDVEpFL3htMklXVnJh?=
 =?utf-8?B?WjN2d3ZVOVpNc29QR09jR3diRjJ4dlIyeHFKR1V1MTVuOFJHcGZBbUpHSVRj?=
 =?utf-8?B?WTNjQW92b1Q1dkhsS210c3lIZ0w3MXY5eDBjOWhMemRqK2lrM1pyQnVDeXl3?=
 =?utf-8?B?TVlpczN6RStuL2FhQndvQkJYdjVyZjdFbXZ5enZjcnl6TXdJb3V1Nlo4UWtV?=
 =?utf-8?B?RUNjY3pVTCsxVzhzMTVFaHVwMnFHemE4NWJkU213RU82SWphM24wbTZiemRG?=
 =?utf-8?B?cEo4MERtM1c0bC82NHMwVUlFR0w1S1A4dnR6Q0p5ai9EaVlSSWRuTjROK0dC?=
 =?utf-8?B?Ym8yQm40OEdlVXU0ZklwQXowZDRDRHBPRDB4ckRYTVo2clo4cUpvTG9ySFgw?=
 =?utf-8?B?UDFiR2RJV0FEeUlCL21rOXpDczdhYzFBaVYxOUFKc2NQRndmYmI5d1J0amxy?=
 =?utf-8?B?eVpWZEkvRzY4SXRnZXNuUitMUFI3bTRnbUNvMktNS2VnaE5KMWNmZXd6VnV0?=
 =?utf-8?B?YlhzbkJZcUJVcjFuc2oyRTdJSWJJSVhJR0E3dGs4N25LMGQyUFAwU2lsZFU1?=
 =?utf-8?B?TkpjWUxkbE9kQXBBa2JDK1dDVi9UcnZobTRNclZlaTcvK0hRT2tHeHdnTDJS?=
 =?utf-8?B?Y1Z0TURlWjZIMnZkdDZLVEc1UEdMNmtSc1kySXJCWjd3YnI3U1krT2JOVnJr?=
 =?utf-8?B?Q2ZRaVFsZlNzbXdSVXlETjc1K2pad0trNzgyeWh6UnNKMHdMYkhXZWJ0eXhU?=
 =?utf-8?B?Zm9HWjhRNE5OeHhOUXA1T1JxbC9PNnBaZEZmZU1Dc3c1Tm13UU9tVGlXM2NV?=
 =?utf-8?B?Z3Q2YjFMV2NzMHRjVHN4NFRrZlRvamhvYjkwcmZIMHE5anMwNElNYXlLb2Ey?=
 =?utf-8?B?R1BvaE1sWGZWOW9XTmcrVVlPbS9RWHhjRk0yYUVsdVBZTy9GdkFFS0EwcUNI?=
 =?utf-8?B?Wm9zMHZjTTJ3anAwRXl2bHJzOC9XUHovVlVWRE5IUmxKNWIreDBpUGVmTGtt?=
 =?utf-8?B?RkY5aDNpaDdqLzdvMkp2Rnc0SFY3TE1Kc0UreDd6alBIaEIya2lYTzk4MWs1?=
 =?utf-8?B?M1hwaHN3aC9iYnFJcTExSHRnQ3NpL2Nya3gzV0tPckg0S3psNlFnNFc4Wmty?=
 =?utf-8?B?WDNpMXBIL0EydFJUcEJodGNTajBiUUFBUVR0aDRCOElUQ3RXMDdZQzd1VlFN?=
 =?utf-8?B?YklZdjFqWC9Ma0lHRXpoYjNNeFI3Qnl3S3dLNTlra3VvVWVESmJQM2V5L3VO?=
 =?utf-8?B?czYweUFGcGlQVFJHdzVWMG0wYzl3UldacFByRG5tbGNScE1XT2ZvOHc4VjVx?=
 =?utf-8?B?QmQ1Tkk0SVh6aFczQzdQTnY4QjBQSEdQa3NqL1orbXJsay9jcmQ1WUF3VmNp?=
 =?utf-8?B?VWIwU0tOOHQ1VmVkenVMdGtzSlEva1U3NkZzN1dWcVdDcXB2ZmJXK3FCODdn?=
 =?utf-8?B?QjNZUlNJcUZqdlRJaUdOY1B2SEdmNnZLZ1FBbUZtcXV2ckphWFphelRRNDZD?=
 =?utf-8?B?QUNmck9pbDBvNjZLMHJCZ01id3VlNjdlWldBMkF4TmNJMFB5RWJSY2prdDhi?=
 =?utf-8?B?TWl6MGJlUnNJazd6WmlBUytKajMyMSt6ckxFdFQrNU0zNW1jSGUybyt2MjRW?=
 =?utf-8?Q?y8cUll9m8LDqnUJyNYj4Yko=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9ae7f86-23f1-4171-3938-08d9e8233232
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 21:13:31.6411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /V5BSftOXuCtSIpYn8nZp15o3ipgw370pvVcRK0CfUhJ1fsG6QCpzw7kRITu6Avr6sDIEUH5eppfxhtLFurGaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4819
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/22 11:57, Matthew Wilcox (Oracle) wrote:
> We should always increase the refcount before doing anything else to
> the page so that other page users see the elevated refcount first.

Absolutely agree in principle. Is there anything else to say, though,
such as why this matters here? Or is the change just being done for
"best practices"? (Which is still a very solid reason, of course.)
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   mm/gup.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index a9d4d724aef7..08020987dfc0 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -220,18 +220,18 @@ bool __must_check try_grab_page(struct page *page, unsigned int flags)
>   		if (WARN_ON_ONCE(page_ref_count(page) <= 0))
>   			return false;
>   
> -		if (hpage_pincount_available(page))
> -			hpage_pincount_add(page, 1);
> -		else
> -			refs = GUP_PIN_COUNTING_BIAS;
> -
>   		/*
>   		 * Similar to try_grab_compound_head(): even if using the
>   		 * hpage_pincount_add/_sub() routines, be sure to
>   		 * *also* increment the normal page refcount field at least
>   		 * once, so that the page really is pinned.
>   		 */
> -		page_ref_add(page, refs);

A fine point: this hunk removes the last use of "refs", which means that
this patch will lead to an unused variable warning. So I think it would
be best to remove the "int refs = 1;" line in this patch, rather than
waiting until patch #10.

With that change, please feel free to add:

Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard
NVIDIA

> +		if (hpage_pincount_available(page)) {
> +			page_ref_add(page, 1);
> +			hpage_pincount_add(page, 1);
> +		} else {
> +			page_ref_add(page, GUP_PIN_COUNTING_BIAS);
> +		}
>   
>   		mod_node_page_state(page_pgdat(page), NR_FOLL_PIN_ACQUIRED, 1);
>   	}
