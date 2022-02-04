Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09874AA24F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 22:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241545AbiBDVaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 16:30:00 -0500
Received: from mail-co1nam11on2089.outbound.protection.outlook.com ([40.107.220.89]:12257
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241239AbiBDV36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 16:29:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gg2LyUdpPXeqM8joVqf8mOZkH5dAusWhOH3EBNeTYkbSEe1CPvL/1ErWBz1vc00qTZ7E6E6xwDJPPs5G7IoOZNM88gLRgDmOcgYAJ6R14Wne/XB2Sij9TY7KpSNlyBdLAdmZnbpnHQdaVQMzo5BkxlNdB+O/EgLXTobvXpjEbxP4BP5q20odOSdjijB+NEjHOJ7Q92uLzcQTyLa+D+98rkbECwTj5uhQXUaTLXkwdWA3/P6VbnvhunUaSP6OJlD6zsO95LGvI0uRsodvz3IH8pbuqUstJkrtnsWsdt/kzg3fA586YCMPcf6VygUs7W6DKFkHjQCsjUU+VcQimbfuew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hrjGO+hRkwqx0HWUOFZMw4IN8eJTdmOZyQdgEjFNxBI=;
 b=ngO23Lj9sVe9uA9q/aNiE3efmJekp2+rj1Q6DNzGhbUGb8qZ4kzB5tPw54HAU1zdc2mmNd6CnhrJrjuU9TpQhlQwwRDK8o52NmmGbKznGGD04tF1myVPcWxOfHNcSjUYEzzBVcj2Uxmn2/IsfJIO9AYKP+wygbZFx76AFqnYEeNCvGEFe7D/unzIZqxeIx9moK8Xa/E4nCw01+sYKJs2DL8djxfPBS8pPAbD/r68yS1qgUyzqbbcZCgnVjj+aIj0m+ja9MbWdikgXzDpTVtgpf0dK5NxZEScoVO2dN7M8kR5Oz920x3m9pMER/KhwhndZYG5nf0f+Tx/5QU8NuvWXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hrjGO+hRkwqx0HWUOFZMw4IN8eJTdmOZyQdgEjFNxBI=;
 b=ibfOsvuCE7yijOY7+TzLa5cLI1KBOyo9HEMTNomxz6MFJVaCondXQHEnUuZl9V3/GKfWqMSihu8s40jW4e8TzQ+FRf6kH2i/uk8oDNRdCq3ZZNeWatozRPBsAFbTtB4N2jEBPx6FhmHAQndi6xoSiIM213AjQ11Vy1B8LOZ0QiASNN3tI+oIKhDHFLQe92yydxM3o5GNLF1fAstqRzLncxctgO4Z5CekWDD/2VjaOSNOWNAGXOpiFBb/mjB/GkG/WkR3v20XWc0e6FVoD3WdB9lxh+sXZuFqQn7wAdKreAjYEKsjUZChJ4SevxgYZx76EqciSPneRTK2Zj/yC0rBYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by DM6PR12MB2651.namprd12.prod.outlook.com (2603:10b6:5:42::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 4 Feb
 2022 21:29:56 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2d75:a464:eaed:5f99]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2d75:a464:eaed:5f99%6]) with mapi id 15.20.4951.017; Fri, 4 Feb 2022
 21:29:56 +0000
Message-ID: <0c128b92-7dda-07be-f6e0-80be0b91d7cc@nvidia.com>
Date:   Fri, 4 Feb 2022 13:29:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 10/75] mm/gup: Remove hpage_pincount_add()
Content-Language: en-US
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org
References: <20220204195852.1751729-1-willy@infradead.org>
 <20220204195852.1751729-11-willy@infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220204195852.1751729-11-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0234.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::29) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 673d0637-71cd-44f8-6052-08d9e8257d84
X-MS-TrafficTypeDiagnostic: DM6PR12MB2651:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB26517916F5338C8EDBA0B856A8299@DM6PR12MB2651.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r0ifnsUo2bRJlrExfGx3Lhc7cuBHQmXXyphPysx7y3bzVma1UsVS6/kKJztU7xPEGQnZ64AlfatZFML4Q0pf7xXL76X06S5KL/P76FI2hO+UnGo+cpTOjb3/Wy9LDm3n3nucauWCmPrERMyP/8CUv8mFZ9+vzC1em6+VXSqK7TVk5zGVAl1OEHA+U/eV832F0nGa7hIalZ/kKyAHIm4Vj6ti7tkCGs9vEt+muWMFOFMMy4FroM4yhYzVIbExUC7jWqC2ZRFXKm85oM71uAYrOMl/0jE9DinTKFgNzrdnNdY7nEZ5BUtEWuAyyW+uzMX8LWfkD/CUDm6s826ZUvIGJ/ZRMNfxntkDO2EwxnUt19XZ6CjI8UcT+xYOM3GCLSfeKm3GBa4VYQZZxK/f7QDT58GbHT1QC7rqPFbDoywYWJ8LUp6kUkcMutA8HZzwd8jl3Iz55LKO28Et6UqC5aSDczHlL3TJk8DokZs1nt19gXOMSUYqxMG7J86fF2fkYx+zp90OsIc1e/UZ2/qBT88gNLSk2P58/9kK8Rx64X7Vm2IYXFhJ84lrc5t+WP1gpXABWTnq+pZyWB9+z9O5/CtT6yflZYFZRagJg+a0xvfhegwt/1OclSTT2veYgWFKR7Rj6EF24cz7JtK2PDxuID/bKA1YqHKUpr9ZtY4MY4fppvceS3/c1AH38aNF+yrCia/u5h4zGoVXeTWC/kbHUl9Q0TEtfim0wJGFarjAETMkoyCUD6kG5ehBv3OVibl4iWPA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(31686004)(66946007)(66476007)(83380400001)(8676002)(316002)(2906002)(5660300002)(36756003)(8936002)(4326008)(6506007)(508600001)(6512007)(53546011)(2616005)(26005)(6486002)(186003)(38100700002)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2IyOUNKaVpVblJRdzkrdVBoRzJhM0h6bkYxNkVYdXgwbFhSMEZLcVArQU9v?=
 =?utf-8?B?aDl5ZCt1WVVuU1gxcERUc2VmZzd1cHBvcEtKOTRyVmRwVVpQODZLUVpTcTNz?=
 =?utf-8?B?TmsxNWV0d3ZUK0lZVE96SWFMQkl5aWpCdXkybXFzUE5HaTFQWi8vZTh2TmZT?=
 =?utf-8?B?NkVIV0psclQ1bTJLTnhsaGhUWXhxQTFlWk1CTmU5bzZOU0F0bUNHMFdKdkxv?=
 =?utf-8?B?UmE5UGlOejJlS2cyTXZXdVhMS2FzeTRxZFFHMG5VS0EzMkgvVFM2cFdHemhX?=
 =?utf-8?B?OU5NckhCN3BHK2RNK05sbitsS0ZkM0ltUXo0UjM4WUVLR0g1OEhvcjN6MURu?=
 =?utf-8?B?NHNKVWd3c3NxVnZQRXVSUlpDSERDUld5V3hYR3hYenFQTzdkblBhRVl5Qk5E?=
 =?utf-8?B?Q3BKUnJtaFlUREVhUFhtdldRZmFtRFN0MXVKNGNGUk5BMG1wQXlKWi9kakY5?=
 =?utf-8?B?b2svM01pWTY1dlhoK0greDBGbVJsN1V2SDk4b2NjSG02OVduUE91ajNaUzgz?=
 =?utf-8?B?MjFFNFRNNXVSMEEvVnpmVmlmajlNVUwvNGE0MCttWTllNDhYUXVacTFPMkth?=
 =?utf-8?B?VTdpOG9aaVVkY0sxM2c4NElJL2dZQlZoYjE1K1kxQnkzSkRtbnZwd3JEaENs?=
 =?utf-8?B?RW1JQVZQc0xJenljZDRvOTQvWjdwYjIycXJNUFNEbHlQQjFVK2ZRb1RWdVBT?=
 =?utf-8?B?UUNzRUp2bFBMZEh3VWJTeE5QRkRTcE8vM3dzTmRzdFpkU21yUmZkOFYvVWhZ?=
 =?utf-8?B?RHJXUzQvTXQybHB1YjY5K24wMCtvclN1NUo5YUVOci92OHp6aDdVRWZkaEZW?=
 =?utf-8?B?TlNlUFVzUW1vcjFOZVI3dzdZMmptaHdScDRNdkJtL0NxakVpakZRSzd1S2xx?=
 =?utf-8?B?SW5SSW4rNDA5dXFla1NSNUV1d1hBVWd1alN1WURDL3RrVytmQ3NDaXZZM1hl?=
 =?utf-8?B?UzRwQmVKRGFybWhubEhzbXdLalc0OWN6ZmhkNUtmWFZOT1hYeDM0ZjZOM0l1?=
 =?utf-8?B?UGRLRmFQV1BmZ21VcFBHSW1QcXBqcnphTFQ5US9FZVZUdEZMUUs5cWhnam9S?=
 =?utf-8?B?RUx0WlFtSTZubU9XRERPZy9Vd1lPVTdwbXZqWlhyR2ZMVnhkNHVOTU5EeHpi?=
 =?utf-8?B?aXdVdjdEM3Z3V1owZ2ZCZDR1MDM0R1IrSUxiSGNKL3o3YzFMTmw1eTFkN0dT?=
 =?utf-8?B?TWRFMkZ3djZkQjBtSVo3Z3BjNllsaG1kK3YwV1dSL3hvamdkQmZJazhneWlP?=
 =?utf-8?B?cXJpUHBHWC9jcU43SjcwaXNROFRQdjkzTjJXdWRYdWF6SWd6WFZvRjhWa0hL?=
 =?utf-8?B?WU04bmVoZGkvL205Zy9nQjM0ZWpxckZnUUJ1Y1JKT3dMV25RVWJ5bElGWlMv?=
 =?utf-8?B?MVZEVUhzNUNjKzR3MW5Pd3FISUtldWhZQUxGSmpoQUdUakk5YlRLUjJ4UzIx?=
 =?utf-8?B?ZkZvK1UwV2RMdm8rczNmR0ZPQnZ5WlgzbW0xYjJTVmNtOEpBanhuYkMxbHBX?=
 =?utf-8?B?Y3pPQmYzT2RuRWxFRVo4RmxlSFdlbDFXTUJRSzg2ekptRkNNbEV0bzJod3dY?=
 =?utf-8?B?aWR6ZEx2a3crWUxCem5TK21Qdmg0cTEwZVpTSlFSZ1BvcHRLMW1wY2xyVDNt?=
 =?utf-8?B?WDJGRHRzc0oyRWdoOTlvb3FWZUJpYUs0R1VDdXdqQlN1bXJsNWYweGVTdWtU?=
 =?utf-8?B?MkFwS0tuK1RVemVXVWsvejRXZWhRdko3dVdNMjBGTk9Qc0dHanNXWE5LbVBD?=
 =?utf-8?B?NFdaT2lYSFRRUm9IT0JFa1ovY3dtNS96VGFURlFPek1mL1V1Q2xKazlGREoz?=
 =?utf-8?B?ZGFSREZ4MVNya1VObENBcEJDa2FGT1IvSWZkbGJSNmNjMU4zYnFiN1lhSW9L?=
 =?utf-8?B?Y1J3djJkZHM0K0Z1WGRuL3lsUW9UVjVuQ3BmSFVmVktVNk5Kd3NhQ3JTcmUr?=
 =?utf-8?B?eVE1aUZEa045bndnb201RkFXeUFjenlQS1VRRTlVRG5MRi81ZWdQYzlkUXZs?=
 =?utf-8?B?Sng2NHNyKytkUTIwVGc5OWwzbVRRVHVSNlBvb29Wc2Q4STVGKzFSaGl1RW50?=
 =?utf-8?B?NlErYnBLdnkwTlZMblB0Tng4U09RWDhSTWlZNStJU3Z6cGRXNGZvcW9yNkJz?=
 =?utf-8?B?UEI1Sm1EZzF4WHdQRU9NSVVIM3pkYlIzZ0txUFFaKzBzK2xKbHUrZjd1VmRJ?=
 =?utf-8?Q?1kmzJ6Kaj9b3EEpce/qPlHw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 673d0637-71cd-44f8-6052-08d9e8257d84
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 21:29:56.8146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: azlfJDUfql1kkm8VwlgYbG4qvhCD06OL9mSj8INj+lOEG/NWnyAUSwADkXpPEdiOUrjsnRQj89tI5f47vysVwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2651
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/22 11:57, Matthew Wilcox (Oracle) wrote:
> It's clearer to call atomic_add() in the callers; the assertions clearly
> can't fire there because they're part of the condition for calling
> atomic_add().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   mm/gup.c | 33 +++++++++++----------------------
>   1 file changed, 11 insertions(+), 22 deletions(-)

Looks nice.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard
NVIDIA

> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 923a0d44203c..60168a09d52a 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -29,14 +29,6 @@ struct follow_page_context {
>   	unsigned int page_mask;
>   };
>   
> -static void hpage_pincount_add(struct page *page, int refs)
> -{
> -	VM_BUG_ON_PAGE(!hpage_pincount_available(page), page);
> -	VM_BUG_ON_PAGE(page != compound_head(page), page);
> -
> -	atomic_add(refs, compound_pincount_ptr(page));
> -}
> -
>   static void hpage_pincount_sub(struct page *page, int refs)
>   {
>   	VM_BUG_ON_PAGE(!hpage_pincount_available(page), page);
> @@ -151,17 +143,17 @@ __maybe_unused struct page *try_grab_compound_head(struct page *page,
>   			return NULL;
>   
>   		/*
> -		 * When pinning a compound page of order > 1 (which is what
> -		 * hpage_pincount_available() checks for), use an exact count to
> -		 * track it, via hpage_pincount_add/_sub().
> +		 * When pinning a compound page of order > 1 (which is
> +		 * what hpage_pincount_available() checks for), use an
> +		 * exact count to track it.
>   		 *
> -		 * However, be sure to *also* increment the normal page refcount
> -		 * field at least once, so that the page really is pinned.
> -		 * That's why the refcount from the earlier
> +		 * However, be sure to *also* increment the normal page
> +		 * refcount field at least once, so that the page really
> +		 * is pinned.  That's why the refcount from the earlier
>   		 * try_get_compound_head() is left intact.
>   		 */
>   		if (hpage_pincount_available(page))
> -			hpage_pincount_add(page, refs);
> +			atomic_add(refs, compound_pincount_ptr(page));
>   		else
>   			page_ref_add(page, refs * (GUP_PIN_COUNTING_BIAS - 1));
>   
> @@ -216,22 +208,19 @@ bool __must_check try_grab_page(struct page *page, unsigned int flags)
>   	if (flags & FOLL_GET)
>   		return try_get_page(page);
>   	else if (flags & FOLL_PIN) {
> -		int refs = 1;
> -
>   		page = compound_head(page);
>   
>   		if (WARN_ON_ONCE(page_ref_count(page) <= 0))
>   			return false;
>   
>   		/*
> -		 * Similar to try_grab_compound_head(): even if using the
> -		 * hpage_pincount_add/_sub() routines, be sure to
> -		 * *also* increment the normal page refcount field at least
> -		 * once, so that the page really is pinned.
> +		 * Similar to try_grab_compound_head(): be sure to *also*
> +		 * increment the normal page refcount field at least once,
> +		 * so that the page really is pinned.
>   		 */
>   		if (hpage_pincount_available(page)) {
>   			page_ref_add(page, 1);
> -			hpage_pincount_add(page, 1);
> +			atomic_add(1, compound_pincount_ptr(page));
>   		} else {
>   			page_ref_add(page, GUP_PIN_COUNTING_BIAS);
>   		}

