Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F202A48A679
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 04:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347741AbiAKDgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 22:36:51 -0500
Received: from mail-bn7nam10on2078.outbound.protection.outlook.com ([40.107.92.78]:58016
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1347923AbiAKDfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 22:35:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eCGqpkzpPACRr5ShscQ0yWuNkz2aqIVVXKLaZqAh6um+rGBM9PdT8ufKTUYZhPVBqMARaJ0OvIpTF6K7iJ2hACgpZjgxIg5qApB9/XK7lTpvpbENrfJTZVuQupgEpSW6Qv4nucqwQRJq8ex1Jyx4dmn0ib1orGI0Fzzg1NblXwPG6GF5lERgMJSm9/jeve+EsVoeOxYH0zk9B5UC2RNY/R/lyr/5XHAgrJ9eLJBV6BJ4yQI7fs0Hk+Pn70SrhhhrxMmu3x8mOzV5HiNm0rhdBOqvCypDKaZWYYAAW6kvzFjjQV8awmsYi+FStluoj+RUoXqc6QlSkNIE+Fl/Ocvy+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BKKHZ3V8wTm3tAi/AkOVugzrt4Y0ZZmLt9ewqDdy5eA=;
 b=VrnQaHn0FWAC9srRR7UUkbLxseF7KrKWqSD2Ym4dTEXfdEMRm2fHJAoHjn9QnPLsJlfMjME6de+9CgSLTbMs8opPBk8iMUaBna09nzxUSAzwCgzKMwiaJCsElIQlnNTzuedyvo+NUbHuviOwQ1vqXdCfrrqwzg2Ibb23NImwFnI1xpLxbLeGxrPg/hVFK+enBo6btwW4IU4E+Q5aZRblisjiZ3ik/BUqm81JUFakuzwBqZi/2cKZBmEuwJl8vEbCkCf+8cA+AMQBT7vwL3+1mocu5/l+7fRMwIr+3PJLePNpX3l0TE3iZl/sCq9fs3ZBQLzbDTFmgOw6vQMgjRaFBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BKKHZ3V8wTm3tAi/AkOVugzrt4Y0ZZmLt9ewqDdy5eA=;
 b=fksWZD1lRwiC3nHCoprMv3oq5SRbyqf6yipuo2ViWjhGDM4O1Pck2oJPqFqDhVjsHRafG1xtCWBS/cP6vptd5et9TFNyDhqJnE/ZvedaBlNuesKfN5z3BspqKil+dxp0l1QzkkTtoCZg9rcTEP3tmW/8DJiuObzf4ndgSZ8A8nN1Eg9TAutBLFH0MXWBAqJfCvi3pmJwRNpM3nLw32d+3/G583imd2OkjLo4IQj3Z0qU9yaCboW8o25Oo+oL4FJKcW2lDrXxr0A2sTOYtBoMLkvEAenJSiTQF6PaH4oa4sjzx32By4F1QvgjXntg+AcfGiBC/yTIMrp0wEVvGue/8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BY5PR12MB4305.namprd12.prod.outlook.com (2603:10b6:a03:213::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Tue, 11 Jan
 2022 03:35:38 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::8496:16fd:65c5:4af7]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::8496:16fd:65c5:4af7%4]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 03:35:38 +0000
Message-ID: <854542d9-cac9-5274-6f47-ea547238b32d@nvidia.com>
Date:   Mon, 10 Jan 2022 19:35:36 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v2 09/28] gup: Turn hpage_pincount_add() into
 page_pincount_add()
Content-Language: en-US
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Cc:     Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
References: <20220110042406.499429-1-willy@infradead.org>
 <20220110042406.499429-10-willy@infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220110042406.499429-10-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0195.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::20) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a11e2b4-acaf-4beb-ac1f-08d9d4b36f33
X-MS-TrafficTypeDiagnostic: BY5PR12MB4305:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4305FB85B460D90C93F5BDFAA8519@BY5PR12MB4305.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IVsXUasaM1laXtbV5TN2/wMBALzcoseEbaQf7lENvFphiju6G0sFioAZoG67NoPbtTwzRVAt5iqCcOxmhRJsFGy+DL1yehLlUxHIrIbyf1QSctjZxHnFei7ET1IFd6/QNQefhF87d+pqxBfbIQp4IuobObK/0Mijbh0hfmlhFWBmzivsUNTahBT5LzKs0ZL0wzLuTuMycQilxEk5LKJ4R/NBdgDKv/a96rVL40i3db/uGjTx+1YNI/Og2VHuRsy91MMLAGFc1hJBFj7JdBY14lQVeVyBtaNyAaSSgLTRVfx1pKjxONDJigmmR/D0Q9Bb5xOri/Yj80VQ8tasmpXnbpl3rjBPhLPAkTXNE/EryArmDQlFXgFnCEA928HFMs0c6O46NyoIyGxsEoLmnaGiOxStLpvjYEKdyAXwj0SrzjyGInYyWqje8Qig8R9KO7McAGUgdk8QGFt4igQdJ3TAaBDivS+4SOzaOxBwrWbQq3OiMtL4kRuJyw2Y2LefDqn/4NfkJD1+HwV1xMHnZ41P/2VyQFuRXvAkXb36Ksg1fF69lOOn4Dl+Ip/KCSgkn+EVSGYvG6Mo/IIDrEWHSt9x2k8PEBWFpfkT4pVx2MPkip92yUEJ9KbRkZffc1mhsrGPR8U7ob6Mx8Q9h+p3xWlDp4I3gdzzoZWtcQ14JxqsVAQcV4EbRcrC3U+mSXkCDKqtufw/dHUjk5XGaoSP6O40oQYTRnbPgJWKqRol7QkRSc5hL4efxKFKHjH+N6IMOssS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2616005)(83380400001)(66946007)(66556008)(66476007)(26005)(5660300002)(8936002)(8676002)(316002)(508600001)(86362001)(36756003)(38100700002)(31686004)(186003)(2906002)(6512007)(54906003)(4326008)(31696002)(6486002)(53546011)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFVIakt1eHRTblplV0swZHF1RGk3Nmt4dDdwUGtsUi83Qno4Mks2VDcyUGtR?=
 =?utf-8?B?S3M3M3djZm9IY0hkZjlpRk1wQ2Mrb3BWRGMyRThQU3lHenpyeUs4Uy9RS1FX?=
 =?utf-8?B?eGVlT2Y1a1lsVERGeEpRVWF0RjVrbHJYYzlTOHc0MFhvMmxseWpleG1wRFFn?=
 =?utf-8?B?UFRjQVFTSE5vOWZyUGpFeEhhcTFZbjgzK1Bvai9ZbGdMUUg4NFNDVWVkT1V3?=
 =?utf-8?B?d3hTWHk5ekp2NnFZQ1NPQ2kzOUUvZ2tGa01mY2xQanRWRUdEUGtzMTlDcGpZ?=
 =?utf-8?B?b0JwRmlmeXhNSmZyVTNkSEJpL05vVUI4dlJ5WHdWVFJTd0ZGREZ1S1dxVzRO?=
 =?utf-8?B?dkk5YjBwakhtQW1ySlNvajV5enMvY3hEd3RJK2R5b2RNdFV2VE9EY2Iybm16?=
 =?utf-8?B?ZnN0Tk1LRFoxYjQ2UVZJUlR2R1REcFdsRExVN1BjenNmMEV4NnVzQ1lpOGxW?=
 =?utf-8?B?ZUlsWTlOaEtLOXdWS29LTEZCaEp2dFl3UGx2ZUt1a28wMnJ1dWxZdUpkWlFO?=
 =?utf-8?B?NXpPY2o5a1BYK045eCtLNTBqallVUjdHajJWbW81K3RFRjNyRm8yVC9WcGVj?=
 =?utf-8?B?SnpGRjdsS05oalZmRTIxZEJyZkM2cVVCR2JhYjhxZ05aeXhOelJ3MytrNy8r?=
 =?utf-8?B?RkQzVGZuNmg1bFg0S0l3MjhqeU1QWUxnTGtqSGhmVDRGNDJpTXdqaE9rMFBU?=
 =?utf-8?B?U2xBOE1zTWFQaENLTytKYlJGWHNLTWtuUGRJelBqN3daQzFQZW5MZ243bDh1?=
 =?utf-8?B?cWZyVk9BNEI1VXNiQURROGtzeHNnN0l6Yi9pMHB5YThTNFJicVVnMzNJOGJD?=
 =?utf-8?B?NGpxMWdqN3NHR1JZR2dEcVFyZStpUVJOVVdieG9TNzErc1NlQWU2UVB2cXlO?=
 =?utf-8?B?SEEyMnMyQTlvVzB2UzB4OE5mUldncFJERjV2VTVnNXYyTDJGUHEyY3c2Rm5t?=
 =?utf-8?B?OE8yd3F4N25NUDBIaVd3a0VkRWNUalMxcDBSREZKZEZCZzBscjI5aG9NT2w3?=
 =?utf-8?B?Zi9QNm1aZWJ0Q0F5NjJ4Y2VMZis4VGJYemJTTFVEVFlvalZSK0lkLzdYU2t6?=
 =?utf-8?B?OHlvQ1VmUlBYeWV5SkdXanNxUWVXbVBoTkczQ2xqL0U5SXo0YTQyMzJQbzg3?=
 =?utf-8?B?Q0tpOG1WOW9LM1V6RmdmZ3A1TFd2NVIwOEZ4WFFJWkI5L3B1SVE2aDNNT3lp?=
 =?utf-8?B?a3AxZmdRcURISm1XNWJCRC9GczNMRTNVRm50WldTUlh5YzdaMlZvRjJubHFZ?=
 =?utf-8?B?SXFrekIyMm1ZWG5lVVhXRm5qQjBhaGZmUkVQZll0ZVc5SXZKWUpoRzROYk5v?=
 =?utf-8?B?bVMza3BtNTY1V3l5c3ZMRm41Y1hDYWZ6d0ZLbU00dlVjcmVON2hNWk94cmNR?=
 =?utf-8?B?WVBOOTFheUd5Z2lqUnJCRmdVZlBBd1BRbUphaURCazlIcHRidHRoR05FOVdh?=
 =?utf-8?B?QStrei9SRitIQXdzVW1HRWtKQ1MrTWIvcExIWi9ueTlPSjZCVmVjUHN6OGpx?=
 =?utf-8?B?aWg1cXhVQTd5Y3Yxb0pDRmg3UkFJQjRUTTB6MjV6TGh2MVNLcVd2eGR1Q0JW?=
 =?utf-8?B?UjZENWZnTmpya2Z3UUVEMTY3Z0VYTlVFR1VrMW1talRpWFF5MUZyZklWeWdt?=
 =?utf-8?B?WC9TRkloUjZ5elBWd255QzZHazBKbUZuSU9TZTRXN2h4bERHK2dSb3NHeExn?=
 =?utf-8?B?ZEMweGRReEM3WTYzNkhnMG5VUms1RnZaeWQyZTYzeHJ0SW9jeFpFVGtFWDlB?=
 =?utf-8?B?VHBFa3RhYmppMmNEZW9aUjZuQ2NCa1loaUxqajhsd0xOc1dqVDlNai9nQzV0?=
 =?utf-8?B?ckpXM0J2OXNFY2tCdXFmT3laRVBBMzZTT2pyT3BUdVZXY1F5eDVESXFTN1R6?=
 =?utf-8?B?MGV4WWlZS0dqTTVJU2xEZDhmMmFEbmNIQkQzZEx3bEE0dUtuSDQ3ZWFmV01r?=
 =?utf-8?B?NWhGemV4alQ3WDllWnVna2d0ckNvcVRHTmprQWFrVWdVRnVNZ1A5K1FwQU5r?=
 =?utf-8?B?OFlpVzBZaExlSStXcXVHM2JPOVJ5VUVuTFhQZVpTMmkwMThFbzJiWW5Wc3lW?=
 =?utf-8?B?aTlOOVVjSzQ0V3ZGbzYwNG1BNGNHT0xQTlp1VWhiVzRiVVZRMGI2RHNPUDdi?=
 =?utf-8?B?RDdJYjMzVm1HVXJmak5yZFFwcTg4U3lvNFJvS0FPRUdBY2krbzVxdS8xMFlQ?=
 =?utf-8?Q?DZMbmcH1ATvRJnu/dERyF+w=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a11e2b4-acaf-4beb-ac1f-08d9d4b36f33
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 03:35:38.1246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VdObIOWd4r25zXq7lDKY8ebfYp+VuO3zT3WqXRm6yHyNq6bSA1f4StYbpF5ZCHOVdBW96n732v5xubAvLm2Mig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4305
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/22 20:23, Matthew Wilcox (Oracle) wrote:
> Simplify try_grab_compound_head() and remove an unnecessary
> VM_BUG_ON by handling pages both with and without a pincount field in
> page_pincount_add().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   mm/gup.c | 33 +++++++++++++++------------------
>   1 file changed, 15 insertions(+), 18 deletions(-)

Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard
NVIDIA

> 
> diff --git a/mm/gup.c b/mm/gup.c
> index dbb1b54d0def..3ed9907f3c8d 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -29,12 +29,23 @@ struct follow_page_context {
>   	unsigned int page_mask;
>   };
>   
> -static void hpage_pincount_add(struct page *page, int refs)
> +/*
> + * When pinning a compound page of order > 1 (which is what
> + * hpage_pincount_available() checks for), use an exact count to track
> + * it, via page_pincount_add/_sub().
> + *
> + * However, be sure to *also* increment the normal page refcount field
> + * at least once, so that the page really is pinned.  That's why the
> + * refcount from the earlier try_get_compound_head() is left intact.
> + */
> +static void page_pincount_add(struct page *page, int refs)
>   {
> -	VM_BUG_ON_PAGE(!hpage_pincount_available(page), page);
>   	VM_BUG_ON_PAGE(page != compound_head(page), page);
>   
> -	atomic_add(refs, compound_pincount_ptr(page));
> +	if (hpage_pincount_available(page))
> +		atomic_add(refs, compound_pincount_ptr(page));
> +	else
> +		page_ref_add(page, refs * (GUP_PIN_COUNTING_BIAS - 1));
>   }
>   
>   static void hpage_pincount_sub(struct page *page, int refs)
> @@ -150,21 +161,7 @@ struct page *try_grab_compound_head(struct page *page,
>   		if (!page)
>   			return NULL;
>   
> -		/*
> -		 * When pinning a compound page of order > 1 (which is what
> -		 * hpage_pincount_available() checks for), use an exact count to
> -		 * track it, via hpage_pincount_add/_sub().
> -		 *
> -		 * However, be sure to *also* increment the normal page refcount
> -		 * field at least once, so that the page really is pinned.
> -		 * That's why the refcount from the earlier
> -		 * try_get_compound_head() is left intact.
> -		 */
> -		if (hpage_pincount_available(page))
> -			hpage_pincount_add(page, refs);
> -		else
> -			page_ref_add(page, refs * (GUP_PIN_COUNTING_BIAS - 1));
> -
> +		page_pincount_add(page, refs);
>   		mod_node_page_state(page_pgdat(page), NR_FOLL_PIN_ACQUIRED,
>   				    refs);
>   

