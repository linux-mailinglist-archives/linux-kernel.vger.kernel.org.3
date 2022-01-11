Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDB648A4C8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 02:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346130AbiAKBLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 20:11:19 -0500
Received: from mail-bn8nam11on2077.outbound.protection.outlook.com ([40.107.236.77]:2221
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243256AbiAKBLS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 20:11:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jJX9ur+Tt9x9o3QJLUtXEZ3hoVr6WfGap9O56wnY2jDr52P479Z4+swHnA/RV33yDv7VPudyAoN9Qheme637dguBcAw0+h544xGyNx9x0cPUlrJ4+fffC72oOm7HmC8UkEUPmA5ZzFp8xqOTruFUTkFtbpcc5wjLd+AZhCEEXsm5gxDjfIvtfNbv2pn6RCfQjbt4azu/8Ruq9hwgJB3vMt2sccnXPwqT6y3xPK+Yk4yiunFqy5JGr7S/ky8CJTkdYnnyNxJk9eGaodgas+tT0X0o0iyaEk4PTUbv/DD+UTcaPLzMm8PwlJdW8AGgf1F6Z+iRE3mCwnwYo4kMV8R4OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f1CuogxryWITDKxQkmWF72xL+mix5zrNwNisPgmxkeY=;
 b=CHAb5Dk8cKexuEl2UH00k9CYa9WuHrwE8ucmg2Ows/C3lk6/vb9+pOS7tYoVxqZpoDlNwHSZe9B/6E0meepe3vDU7o2+wrDmGbj/XZWXdcf1NkBD4QMSFBvzixMGrSYnsEk8s/VbLBLWTWucijYCxdppGl88Hq3oHxnIGjekDyRKdP8epO5SAqm/j6Ph2+geaaamJ6DaYC/KzeX9fQS9HRa705L7UMLZ9O5AdY8PuXdv6wYF2bqZ+rzTG7wu65C7Jjv9AuenUF7bbNw8JI40r4P/1hjLY1PGWGAR64TOtEctR9QrZyRjTMlfTPMmGE46yelgPKcQMMPcIOLkQ813lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f1CuogxryWITDKxQkmWF72xL+mix5zrNwNisPgmxkeY=;
 b=neEYbsG8appQOuzAb/gQxpeCDHKJwSuJjflOffmFJ39MJEbITNWBMXhcaV42JZZg7ulKaaO926MjEdEdNTfd1exYD/7/LapKqDMfhN2qp9H8PAR9cpNgHdWVExN8jk+8iWDXVMu8sKix+mAlb3E01BQmh8/ICJfnigfL3YyWlHW8Mfl/YpCOJ3gmc8Z7QcdN4mQY9EBPDbXHMzOFW2FL8LhwAKEXKNlFNogpjaZvziO/AFuNzWIZj/NQs+cEYuZwz5bE+qQLvJf21/562GnS6LNGVGoTNff+oqYlEIMpyljPWg4DE0GV+TX0Bs1Y9n9aSNfDlHkPjr+qDOOOqhWx1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BY5PR12MB4853.namprd12.prod.outlook.com (2603:10b6:a03:1da::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Tue, 11 Jan
 2022 01:11:16 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::8496:16fd:65c5:4af7]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::8496:16fd:65c5:4af7%4]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 01:11:16 +0000
Message-ID: <2eabe1ff-821b-a0b4-9585-db72d2f1a9b4@nvidia.com>
Date:   Mon, 10 Jan 2022 17:11:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v2 02/28] gup: Remove for_each_compound_head()
Content-Language: en-US
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Cc:     Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
References: <20220110042406.499429-1-willy@infradead.org>
 <20220110042406.499429-3-willy@infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220110042406.499429-3-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0058.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::33) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd2cd0bb-f656-4aca-a5c4-08d9d49f442e
X-MS-TrafficTypeDiagnostic: BY5PR12MB4853:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB485342F5F8FC47676F38CA1CA8519@BY5PR12MB4853.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:153;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KpfNrotObTYEaSmHLm9Jwo8+FUSl9qgVdZjenAd+xfEMyo5kSwzCzewEeu/3Pv2QQGeuWaJ4oghEXJRQUrv1Qcq7fTVCdPA1GIRYzK90+gRmXOXbt8T+42F6DMRw8pEvQer1bQNWzfTAYoDpQMhBaGA9kR3KAg0OmEXGsS9JuurY1Ebg8XxybkPvo5Asuv/paPnWRTdNiEcMPe30vZJWm81L1luAJlWaZQ+sT00RJXx/PRFWg9QlwVa4JEqN1F9bVBlDMCd7Kj1nclgUkG/3hkfUbpq4vVhjFG3Wov5g4Txv8gotPS6LFW/FryOEsppjKGiZfA6i8aEOrlAuEb1zQXrL0qviKLQNPUp3u6X2RkOx5E8W+jyISef+NR3orXN5eCS5SWUHO/TQvVVM600kPbmBcqurX0KO57uO2CQHP08VVyJ7jkUxA4JlGhd8gWdIgrea4BtX3MEmmvyAXQs1J/1sCN0X3M4A+LILgyZLA8d7p9LAf5D1tvVBSZ1LXHmgi9hWrJdM5b3qssTyz95iM7XEm/djOUiTw43ma/oxZ3JKa9YVoxUsJchjIQFGaf4+ObxbPSt6R3MMoecZD2+aJAkp8BQv3cKhxfGuLYF8jQGeA3jUUf+bDkWkVTLZkeqCuSMXNpRFKZBlWXCkh8zyCnlNa9HbxlLwB1J2nGCVPv7qN2OuIy2fSHNSmwY+5yA5MGgs0eb2buF+7Cmw0Ob3tTEEKotSzwxclqKEvAOzuDqxKNEQuST9BHZLgxb21yOR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(6512007)(8936002)(53546011)(6506007)(6486002)(186003)(31696002)(66946007)(2906002)(66476007)(54906003)(26005)(2616005)(4326008)(316002)(5660300002)(66556008)(31686004)(86362001)(36756003)(83380400001)(8676002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXIycHdJOVJuajQ0MG1QdXF2NWsrRDhtU1E3RUtXb3BXdVBVeVNtVDlvUHRC?=
 =?utf-8?B?WVpyaFhrZnVXdVNJRTBMN1c5dmdBSWpOQjlmb3hMQ29OTC9YaFh4ZFRDdHIr?=
 =?utf-8?B?OVN0bEFxR0NHSGsxTmFZNk5mLzdHTDQ2VE5KL3F1aEZXVUs1bkFwUWIza2pp?=
 =?utf-8?B?b2dMaUJaaDJxb3dKWTBtVlA3U1BNOG83UTRuOG96clNFRGRQeUhxc0xPd05S?=
 =?utf-8?B?azFQSEZUMlEyVTFEU2JNdUhEa284YUpGSDFEUTFBb2F2T2UraVo3YTZBbmFy?=
 =?utf-8?B?ZDV2MElDa0pHeC9TVWZYTDgvem9pTWF3TWdsK1Myc1lXWWZadFRYcnBISSt2?=
 =?utf-8?B?YkJKQmJlNkg1dm5waHJkenFEVTFzbU54amdaL3NvWGxrTjhmQklkS3lzTHNW?=
 =?utf-8?B?ZktDTDE0a3p4Wi9oeTliSC83cWpJQWhLYlJibnQ2Q05QTlF1VG16anFZeEQ4?=
 =?utf-8?B?OEJPaDdYVDI1ZGZWZ3ordFZ6SzBkbHE1NDJGbGtSMWJlVjA4Y21nYmtVN0g1?=
 =?utf-8?B?NUtBa3BwZVY0U1oxUDk5d1NidGNmbzNlS3RhT24zaHM5ckNjYnZ0OGl4Ymxj?=
 =?utf-8?B?YmRKU2hjclgvd1dGTkFiRmFKSzlwWG9mRzFtbnpBRCs1R2pBYnN0bGNtK0Nz?=
 =?utf-8?B?czVtbjJjcVJvRklvZUtZK3JoUTY5VGZoTUNzTnR6T0FOZWZDZEFNODQwa1py?=
 =?utf-8?B?MU5mcjBXU0NzR2dueDJyVTZKOHMzODhoWDhrU1h6aUpDenNyUTBTY043eS9Y?=
 =?utf-8?B?bUIvYmJRREIxcmtNUUFVMUNzcXY3ejlyaUNqTmJ1WS9jaXhRc0E2Mk1pdExK?=
 =?utf-8?B?VjBnTnl6ZXdOcWRJZTNhaGVCTHlGaWVNZzdDUXpHSWZocWdRR3l0UzRQMVh6?=
 =?utf-8?B?cHY2UmRQWjVIa2lqQlUyM3FFTG5rT1hCRHBFczBOQWtHTVNVM1lPRjU2bEZL?=
 =?utf-8?B?T3kzS1c3MVBUV09mZ1ZHRCs1NGtNYVhkVHhodkpzUnpRT2FOSnZBUFJIQ0lZ?=
 =?utf-8?B?dWFtTGhPUG9oSjJ3eGJiTmhIT3ErM3ZMOWthaWJWMzlORExYMzB2emRtNmRi?=
 =?utf-8?B?RWQzelBVSDFnS1B3WGpiYlFVVzRQUUlCd240SVRVZ1Z1ME5KcExxVHE3TFM1?=
 =?utf-8?B?ZDJ5cWczcGxRTG1rL2R3alk0OXZHRjdIZlgxSnJqQXZEZXNzOTdLTXgxR1Jk?=
 =?utf-8?B?UlJidTl1aUJ6ajF0T1dQbXlTa1BqT3ZCeGZDa05QUmVTUXA2U3lPdHlZUi85?=
 =?utf-8?B?UnJEazdPUTVLam9IbVd6THNiYS9pM3Q0NkJQUjgwTllDZy84enozZE5XRkpX?=
 =?utf-8?B?M1REZStsU0FRMksxZmVraG12SUJTQTZEUVlwd0o0Rno0MStEZFk3ZnpsM3lU?=
 =?utf-8?B?VHdLU1hkS240TFhXOW0yVDBuR3FnMlpQeER2WUxuUzJIRWNRQkYydHMrTTBm?=
 =?utf-8?B?dEVBQ0RoSDlKL0V3ZVBGMXB5K3VHN3k4VmxaQi9hQkhIWUFrTWFkemZMcS84?=
 =?utf-8?B?YW9Ea2t1NzliZkFaUWdlUEVnK2pHWCtGb3dBVG0xVUxGQjdLcytrSlBRV1J1?=
 =?utf-8?B?RTd5NHVNUlhHVmh6djI5TEJoa2NZZU1mbzNCdWlKbWNSMXNINFREcERuYVRT?=
 =?utf-8?B?cWN0VnA1Mm8wbnhBb0xueFhsTndqWHdidy9RYytRTFNOUjJNaHNnUWNhOVRq?=
 =?utf-8?B?UTAwaFdOd3J6U0djSklQQy9rOGNibm9wWlhycGYxQlpFNDc4NER1Q21DaWpE?=
 =?utf-8?B?U2lIbnBtOUZ3UmRCdnZKd3FmZXFSZTZhS2E0MlZoZUhRUFZMd3B3Wk5TVzFx?=
 =?utf-8?B?MnRtNnlCYnNsNTFnU3hENDhtMGJwS0N2VThLdlFFNndBaS9mRVo5VDllNGh4?=
 =?utf-8?B?aEZrSk85WEFBUktWdEd0VTNLMjNVRlhqS1VGSzhqR1M4VE5teXp0emhQbVF0?=
 =?utf-8?B?T1RZeGFLc292OW1xNFJQWWdzdDMxd1hJRUQxZlppVFA4STZBdHhPaXdENnNn?=
 =?utf-8?B?Q0NoSnZBakNjMGhZbU9ZaWhpc1VJQUU4bnZOZ1JoQUZySlZvdmc0WndBemFI?=
 =?utf-8?B?alFhUGtkeHZUVUthMGtSeVEvQVYzcVpNSGU3LzM4YnNTRFA4WG9vQ2thckVu?=
 =?utf-8?B?SnNubU9WQ3NEUGh1ejFNUGxoeGd0SjAvR0VuUER6dDhITyszUERIMFdhS21E?=
 =?utf-8?Q?a2SnVNdv6G78zzsGKaFhg2s=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd2cd0bb-f656-4aca-a5c4-08d9d49f442e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 01:11:15.9838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e0DNJkE4hE869BK34xubWjGUml8dH3lMRsw6ssoygSLqggmTlp8aYJo9mSCkp4jgfxHzDp4UEGdcrmabTlTSsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4853
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/22 20:23, Matthew Wilcox (Oracle) wrote:
> This macro doesn't simplify the users; it's easier to just call
> compound_next() inside a standard loop.

Yes it is. :)

> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---

Looks great.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard
NVIDIA

>   mm/gup.c | 16 +++++-----------
>   1 file changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 7a07e0c00bf5..86f8d843de72 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -253,9 +253,6 @@ static inline void compound_next(unsigned long i, unsigned long npages,
>   	struct page *page;
>   	unsigned int nr;
>   
> -	if (i >= npages)
> -		return;
> -
>   	page = compound_head(list[i]);
>   	for (nr = i + 1; nr < npages; nr++) {
>   		if (compound_head(list[nr]) != page)
> @@ -266,12 +263,6 @@ static inline void compound_next(unsigned long i, unsigned long npages,
>   	*ntails = nr - i;
>   }
>   
> -#define for_each_compound_head(__i, __list, __npages, __head, __ntails) \
> -	for (__i = 0, \
> -	     compound_next(__i, __npages, __list, &(__head), &(__ntails)); \
> -	     __i < __npages; __i += __ntails, \
> -	     compound_next(__i, __npages, __list, &(__head), &(__ntails)))
> -
>   /**
>    * unpin_user_pages_dirty_lock() - release and optionally dirty gup-pinned pages
>    * @pages:  array of pages to be maybe marked dirty, and definitely released.
> @@ -306,7 +297,8 @@ void unpin_user_pages_dirty_lock(struct page **pages, unsigned long npages,
>   		return;
>   	}
>   
> -	for_each_compound_head(index, pages, npages, head, ntails) {
> +	for (index = 0; index < npages; index += ntails) {
> +		compound_next(index, npages, pages, &head, &ntails);
>   		/*
>   		 * Checking PageDirty at this point may race with
>   		 * clear_page_dirty_for_io(), but that's OK. Two key
> @@ -394,8 +386,10 @@ void unpin_user_pages(struct page **pages, unsigned long npages)
>   	if (WARN_ON(IS_ERR_VALUE(npages)))
>   		return;
>   
> -	for_each_compound_head(index, pages, npages, head, ntails)
> +	for (index = 0; index < npages; index += ntails) {
> +		compound_next(index, npages, pages, &head, &ntails);
>   		put_compound_head(head, ntails, FOLL_PIN);
> +	}
>   }
>   EXPORT_SYMBOL(unpin_user_pages);
>   
