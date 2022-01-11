Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9C7348A4D5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 02:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346157AbiAKBOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 20:14:14 -0500
Received: from mail-mw2nam10on2050.outbound.protection.outlook.com ([40.107.94.50]:21323
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243319AbiAKBOK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 20:14:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OhRZ5oT6AM4k462lF4Xuz4/nLY44VoxHw7zw/ZMjPWi96c2NHbLtdDNhCgm5ujEeDVkbasqSF/uGZKcjHcgasGz4xhyieRGLsYqAA0JjXX+GwDQlnuuhRH/Xu4BZ5Pi/SURQykIwLnvMaddQ4HWeKmq4cgdWv08XliJLKauhGS4vtF8y6i3LPisBoytkgMDzCWj7DaVgiYbMslwOWmVtq4DfmK9J7HjeLE5JjTv1Wcn7hUcgPcc3di4sWYMDtOkWqZN54j+/0a13kBmG85n/cBYQfkdLSJUgdIXdMztxex0BF0WOGg7lYKrauVg7nAr9mF65Esi+yIeksFPtlvT6vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7GiFR3OVl6MtdgCPfFnxSK7z1WRwmgxjwLpwYqKo4Xg=;
 b=mpHeYhppKDEwpPya/KTJfHdS5BQqcaJ1FxVN07cfnZSsyDhv9MWD3lhEo8nMwGECRMrXTlO3RogLw8b44/1MTwLtCcFz2qrs9qZ6bCexiwWr1eouXc/VphuV0z/fAeUOJTbgI9AtyaU2PFl6NI9xZffGCV9iL2Z6Gmgg/GcSruZPnv+SykKTiygmHxOocHIVR6RXqWtNDM40bYLHbaMDE3NVQKq2GgwNA/80gIsiB3xs/jgwYei19Rx2Jf1FvYR3W8Odv3363WM98ILbqmJ84qL/oKMv9vVJmAaYe0VI58xA+3fRDsFZVm5SQcfn+BNQHlOp63+9WZRUERh91mDWow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7GiFR3OVl6MtdgCPfFnxSK7z1WRwmgxjwLpwYqKo4Xg=;
 b=Bk7qp6mibTHkO8vQuDlTmR8atFiCNz3Ag35v4CpIXN2Ivobi+7hJmqTJvh+1JomM58nGVdq6PBJzjBFemzOJ/IDSnVBYsRD+NJKTDgXa54kOwfDZkkEqwocTtoqQVgKZJA/wv/Zl47hxlYR83fqXx7rJTqpBcqp5EF5wyJ/k12zlaQvzOXqbKHJMzLiNHrmLfdOC/sciUUNegsT52Pa01uVqztFPfDSSik4KJOkQN2Raz/GFm+r/jZBSnoIxYXKQnB8ezurjRiytBUQffhhYIRwvP/G+8R7fWiuyve6VFbgY18+HU4LSP+yreKR8d0UKd7GmY/m2D7kBJknCBgpqjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BYAPR12MB4789.namprd12.prod.outlook.com (2603:10b6:a03:111::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Tue, 11 Jan
 2022 01:14:08 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::8496:16fd:65c5:4af7]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::8496:16fd:65c5:4af7%4]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 01:14:08 +0000
Message-ID: <7d0314fa-c7b8-0122-6efe-32ad0e48abf6@nvidia.com>
Date:   Mon, 10 Jan 2022 17:14:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v2 03/28] gup: Change the calling convention for
 compound_range_next()
Content-Language: en-US
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Cc:     Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
References: <20220110042406.499429-1-willy@infradead.org>
 <20220110042406.499429-4-willy@infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220110042406.499429-4-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0113.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::28) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 326350b0-97b1-491d-e30f-08d9d49faad1
X-MS-TrafficTypeDiagnostic: BYAPR12MB4789:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB4789EF6988E9A7DAF94DF0DDA8519@BYAPR12MB4789.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:619;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sJirKyDGJXtGN12MEN/mHL1+qmx56FL0coOndJLwYhyOZh5csnPmz2qrYy87nTHAFJjfgBjtRMEpbdiYkGLU1BC4yXcm0dwVkzmpR1jIgcavZiMQC2o02O8281jwhcaYOLZNXY5DPNn6Gv+2LO5iVZRC2m1n176VSRMOJIiQGgh3Kv23y+pnOfuAz7Tg27vzzBVEQIpgjldoVeEot4cj6oR0CUSlO67XxgygtxxlziZLVQWHOEi37cBfU93vMCVDL41mw0ZUQII4MQlJ7+TxT8NNQG0Aaxq2Hl8DKk7X/xBKADm8LOlO0YwQGadtvyRFXv8XqprC6ybNOipDBY+cuGx/Pf1zOWgrw4Vhk3rA4ynEpWRXtjZyJglvrB1poDeeLkpHYRsZ/geCjbh8l7blEceXQt93zqcC7o2p8hNmxY1QXHbfIXh6WPuJhXcKUDp7sFiHog6IQ7q5jRnYZM0IYljYskhzkebaIouCXK6b84D1xASU5C5Rpaiih5KEG0QyZ2k3BcTy6ckn15mpz4IvWBGRxkfXrVIWvsCD/+XuILFRwhhzu8iA7LYyB1jf0bTQ/EEV38a8fNkhfqANhVmq4iVRRmfwTP2aM2LTKpsVUlGXkxKOdf0eBMJ6LwDWWYar9AUOD1pBUvmFDWy4k8oyvdoWFv1JNjRsO9n143alpwjtm7Qci9d+hOdCKMRzV2+Blu+TVwyjQNqK/CBao/z7rECFbIsJZssb17kCVQZazDO8gEzhE28hJX5wdXPbQIMj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(83380400001)(38100700002)(316002)(31696002)(86362001)(26005)(31686004)(508600001)(66946007)(6512007)(66476007)(8936002)(186003)(8676002)(6486002)(2616005)(2906002)(36756003)(54906003)(53546011)(6506007)(66556008)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1ovZVJlaGQvaW5CTGMxNDNRaFdweVlWUk5vaTJIVXUzaUdqVmp4M25qNGxB?=
 =?utf-8?B?bTNtc3VkbVVkTlYzd0E2T25xbHlaYW1iVmlVODlLNWUzVitXYUZIOG1TUkdp?=
 =?utf-8?B?MWMyMmtKNjA3NlA3dFI3eDNDaUlXOTlPTVVTSXhFSzVUVkMvYmIrMWlVS0RS?=
 =?utf-8?B?Y3J1YWJ2WjB0ckd1cEttKzE4NVVXRS9USE1jUldEYUJYR3YwNjUyMktZejhZ?=
 =?utf-8?B?akdNRk5HL3NsL3lodkd5VnJNQlMzWGVkREUzN0hzS3dnRnpUMW5vNlorN2Zt?=
 =?utf-8?B?V2w3cUJMWkFLVUpOc1dzdm9EaHM5NjhUanh5ZnltUW0vOFJueTEyOTE5YVhj?=
 =?utf-8?B?RGticE9PdVR1bGRyeU96ajJIYUFpWHZ5RFF1d21GK0dHYVFORTVwOU1rYlRy?=
 =?utf-8?B?NFdOUldUTXQzOHdnNkVMNHJqb2VaV01RTjlYZ25QNWZBQ0tLWGJhRDgrZnVy?=
 =?utf-8?B?eFFpcFhCTm5WMWFUUWJ5d0dPN1NZK0FjUUkvU09kYUROcXhiSWFuLzNMSEYr?=
 =?utf-8?B?eFhJQWkvQVlrQTl1cDZ0WjkxdjRBMGg5a1BRSXU2QkxTeVhaOXQ0UVFQVm1K?=
 =?utf-8?B?QUd0bXR0NDNqL201T21rL0J0ZWpmYzg2MG9NaDZ1aHJIQnBibGs2bUtTczk2?=
 =?utf-8?B?Yzd3eUhWbnBXdTNvZ2diV3d6UkJ2L0RFcUh2K0N6Y3VuMG9KTm9HOFNvaGo3?=
 =?utf-8?B?dWF6THJHR0svY1V0dDFsMHNVSXdmREFVTzdZSXNpMEZ5TXJYcWkrdGs5aFZZ?=
 =?utf-8?B?R3RpaGJlSDRGcXlOTysxNktnR21FaHU5bnFTWjlFWFhiMVpBdFNPK1RlUHRO?=
 =?utf-8?B?VWFOcE0xbytsemZkR3FNYUExUUtrblV3Qmd2TWxVTWQwUmpDbHRacTYrcXJw?=
 =?utf-8?B?NEtLeUZtT1VUMTIyZTNwaENvRXp6Q21ubTFGQ1JEeDgyMlhaQmVDR2JCa1ph?=
 =?utf-8?B?MTBad2FJeEhyc0hTZTNvMUMwYjlJU0laZkpiUHF0VEFnNWoyQTM2TE5Ddytt?=
 =?utf-8?B?NlN1VDBrM3prZlNuU0xPMURpQ1FQTGx3d0pkMHlKejhYWTRrSVMvcmFYUDNu?=
 =?utf-8?B?Uzd3a3RwSUhjYWV6TXhUbHFLWHFOaGZpWHNmOWU1dlErMVE4TTQva1FUTDhy?=
 =?utf-8?B?WnEwU2Rra29SbjVnU3R6R0JpOUVtL2Z5bHJ1ZDQvYzNHV2IvTDZ0M2ZBS3Jn?=
 =?utf-8?B?NmQ4dXl2K3pUcllEM3Z4dDNpeU5aeGd6ZXRmQ1RZQjk0Rkk5U2RXRUZoVGgv?=
 =?utf-8?B?UGZ3cTN6M21tSDVTSzcyUld3blV6ZE1JcWZoRUZVOXZiTlFJQ2R1ajl0alpi?=
 =?utf-8?B?YjVad2M0bXZ4Skp3R0NaWjRTeEFacmtEeEVKeXFkS21zUTkzMWNiZmRhaDBX?=
 =?utf-8?B?MEdldHIvZitoRWpteHR2UGJjaFVpbUpJa1NoTDNoNDRVUTlOOUQ2YzM0akVL?=
 =?utf-8?B?TU5JUjNJTmsxaWkyOGdsZkFLcVhQd1VmOVpGdXpPRmd4SlVKU29lMnZEWjlP?=
 =?utf-8?B?TGQ4WmdpYTZWMkpNV2NSNFpjNG52R2s4citBQ0kvaG5zYU1DcUxZMWUrbHBL?=
 =?utf-8?B?em80SjYvcUNoVEhQeks3MFptTko4YkhYTlpOMUxDQkRzMVRHSFhyLzdwQ0kz?=
 =?utf-8?B?M2Vnc1BmMFFNdHB3bkFkaTRkSDdVcUl2SVBqcG10Wmt2dm84SE1HVDNOYzlY?=
 =?utf-8?B?S2RCbHo0OFhLS1V2ZFRCMUZ1bnZsYllwcnV5b3NRcGZCNUpMNzUvVTBPTkwr?=
 =?utf-8?B?aStwTGlReEdkUkRhRkdCUk9FVXRTaytVa1BFbHh6d25pcHJVVTVmSVBwTWtW?=
 =?utf-8?B?MXRJSWh2c0hra1NFTFhhVzlPSFVoNXpOaEF1b2lMc3B4YnZWTDhjcERwaUYy?=
 =?utf-8?B?Y1hJc1hKRk1EYXkvZHN3MGtwS2NtWkJyRHJuOVRCTStHYlAwTUpGaXFwZElX?=
 =?utf-8?B?OVlhUGZnbllEZXUvdVdPM1h2bzdTTFdHb254QjViRERaWm5vVllucHZrMnB3?=
 =?utf-8?B?cTZHYWR4Sk9naU5rTVhadEVueklBV3o5M0dTMXM4d3FXd2toMzdkTWxKUnky?=
 =?utf-8?B?OElZR2FpM3gxV0tGbUNCMkhnSXQrTGdTTlZ1bWcrMVU3NDVOa1FQWjJCU1dB?=
 =?utf-8?B?R1lyMjlwT3VWeHlOY1pxL0MrbVN5bWVQMVM0dUFKamlTYnZnSDNLOUVaYkhn?=
 =?utf-8?Q?NUdwN0EWQ+Jx7BF28y2nAwU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 326350b0-97b1-491d-e30f-08d9d49faad1
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 01:14:08.1812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ad19+0Q6t2zWxRif5RLbzQ2pTIOqIdIdKuKAONMNvxST5NgmzxJzZDCryDQUjtuD8/NY6ymNwy1sx5PyvF5FbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4789
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/22 20:23, Matthew Wilcox (Oracle) wrote:
> Return the head page instead of storing it to a passed parameter.
> Pass the start page directly instead of passing a pointer to it.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---

Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard
NVIDIA

>   mm/gup.c | 11 +++++------
>   1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 86f8d843de72..3c93d2fdf4da 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -229,21 +229,20 @@ void unpin_user_page(struct page *page)
>   }
>   EXPORT_SYMBOL(unpin_user_page);
>   
> -static inline void compound_range_next(unsigned long i, unsigned long npages,
> -				       struct page **list, struct page **head,
> -				       unsigned int *ntails)
> +static inline struct page *compound_range_next(unsigned long i,
> +		unsigned long npages, struct page *start, unsigned int *ntails)
>   {
>   	struct page *next, *page;
>   	unsigned int nr = 1;
>   
> -	next = *list + i;
> +	next = start + i;
>   	page = compound_head(next);
>   	if (PageCompound(page) && compound_order(page) >= 1)
>   		nr = min_t(unsigned int,
>   			   page + compound_nr(page) - next, npages - i);
>   
> -	*head = page;
>   	*ntails = nr;
> +	return page;
>   }
>   
>   static inline void compound_next(unsigned long i, unsigned long npages,
> @@ -355,7 +354,7 @@ void unpin_user_page_range_dirty_lock(struct page *page, unsigned long npages,
>   	unsigned int ntails;
>   
>   	for (index = 0; index < npages; index += ntails) {
> -		compound_range_next(index, npages, &page, &head, &ntails);
> +		head = compound_range_next(index, npages, page, &ntails);
>   		if (make_dirty && !PageDirty(head))
>   			set_page_dirty_lock(head);
>   		put_compound_head(head, ntails, FOLL_PIN);

