Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0539B48A704
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 06:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233798AbiAKFOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 00:14:14 -0500
Received: from mail-co1nam11on2051.outbound.protection.outlook.com ([40.107.220.51]:34752
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229436AbiAKFON (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 00:14:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iCnx8KyiDI55yRnRowNIOanOTvYo6L7Ot7zX7EuW3FCe0fAroPUrXsbdteaEOUUGt2UEwHmKstU8uQSjXq7DMB059i1I7D21Uik0Fy/cyhg4qPu7/6muYabb2rZrGyaz7t2kriIhgO+zoI8k86RiB+FfuR94xXbyo0l+ysPg60IGPF06muSXrJ5BGTUfDOwOXdjdG29C88M6Re19Citc+JjbMI8KmC5hGT3xn2Z89Zht1Z+iHW6w+B1qD2odV0+iBg5w4xSxFFta+6SYJ5zXHmgzonXWhS/7S5HGulZ7NZ7d1ONkgnGOJEBt2vyOnWQf2g8knZTcWTrKLdp2kiSlfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KEF5CgoaQUtYw7QbAfUhWhUynK+T6xtIp3jxAXn/S68=;
 b=V4ci9IxA9VQR8UGuqU/RgMzmTKvK+dfhaGQHLMzWHB4Yvrqv7lOXLJwlu+BK/tiS0rUWd6QrfhFLR9++e8XY4UcPhFcPPjZCzZpdflGFlCspmcEMU8WuTSGFXtyPd65GD3fAm6+MqktcDaliW5rwvgMSFF4Uj4eh+TppYBVF9WRIG/oU9cF5TkzjECEDcjQbUqSz0fF55BHYDNcvaIjRHz/gdvL7Gr+ZZ78ciZp4UvCJem7yjk5h55GT4JyiDXmTHmQXZ4i1bYq0g8b7ZZEnNgxptdfTLlA5fe2M6t5FyrlRQ3KXJPPFNf/cTWUQxuw3SmzZWqIXftsnzV7qOmKafA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KEF5CgoaQUtYw7QbAfUhWhUynK+T6xtIp3jxAXn/S68=;
 b=qksgRjPxJJQbfIZ/aDLKPUe8CL8MMqwfE7XJnGBJBrmmMO4FDx434hg1FFyS5pPsDK7wCFRCW1dgPRPdayzQmKvAsLsoLrOu7/iSblAKCTXZs4Z8OhSoSctGsRyBot05IGo6xsxw2oOceJw+ciM5j98ornfn8Ac4zz4IgdcoCoFdY9mJeHidtAO2zjlPLGyKEb/JLfZEzGJQCp05cRg4kH5LhdA9DOWnRVDrGLKNnKok1VIqf4DEuU7xGZS0hXeJwzTOaXhQ/NtGzNipN0+k7OU/MlO0NKfzwFy73xK0Nu28DaYpa8vkiYoMIOAPXEqJQRDS2QcyyGE9sB7SNSRbHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BY5PR12MB4887.namprd12.prod.outlook.com (2603:10b6:a03:1c6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Tue, 11 Jan
 2022 05:14:11 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::8496:16fd:65c5:4af7]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::8496:16fd:65c5:4af7%4]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 05:14:11 +0000
Message-ID: <0babe6ec-19d7-715b-4b0c-e476922434f5@nvidia.com>
Date:   Mon, 10 Jan 2022 21:14:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v2 16/28] mm: Remove page_cache_add_speculative() and
 page_cache_get_speculative()
Content-Language: en-US
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Cc:     Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
References: <20220110042406.499429-1-willy@infradead.org>
 <20220110042406.499429-17-willy@infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220110042406.499429-17-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0092.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::33) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77d46b8e-2b8c-4174-27f8-08d9d4c13412
X-MS-TrafficTypeDiagnostic: BY5PR12MB4887:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4887E9EEC0A5CB1DF857D4BEA8519@BY5PR12MB4887.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Q/7Oc55mb53Dv7yRga2KD/2hTnBp3Qc+LZuFg09FjvLD1nrce3do1mEjqTOSWyjZawVtEx95v7N2VA+jmjjF8iz/yU9lOuujGySjSbkxHCVsLyjeFpKkIuuWJBaZbCxqGnuIcf6RV70QwWsQnot8cQ8SUr61MWd8K1v1bgw0TERKDOg1XbSSAJ8RDOTmUwLiTG+i4jE/FV758aHWuNC55LROGGEl/CH3j8EKVTF8J+GfrZlx3r0ea9Phkar9B02F00G16c8CB6KnythgWGpLJ9BzOzwf4ui3GZVL41MA/3jK8tLjd1OvpZGYB/+uMa8L4wAxHmqbIn16k/xLi4jfkcAMpof2EQ5CNU0L/EkzD3eHMBIv2Wsv21y7mJVCcoCqppRLYsyVfCcM90Q3uxDgTuMoF6IsvjWP56NAWCVy5bKU3Azy461yFofpc/xHveuflSe4L33EY4/WSWMYfhdJbou+Syoi2R0esrnPDv3dJgLVlbspZZiuLEu5HCiztkmPkn5zYhaK/8FYpe6oRuOf35g2Af+TDdy/cIDGguYgerKKUKn5ODmU17fJhsDEn6wdvldkPRBj5vzYsak3R9H8JLtZYHsbu3I0bXa/i4iTK1VtXa4XSe8RA6gsrcU5h5lHJ0qfWcw1CByWLpeNmXg41fPl2QtSO5oQbMEWsWsty8YOdyWySKK3PRgYvfZla8N2ZXQIFaM0MNOXv1v5O6/L6CEZuYM7ZBCppbpQWZ9b0ya6rR0scpbotJlQ7DeU3ES
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(54906003)(38100700002)(8676002)(2616005)(5660300002)(6512007)(6486002)(2906002)(83380400001)(508600001)(31686004)(8936002)(316002)(66946007)(86362001)(6506007)(31696002)(186003)(53546011)(66556008)(36756003)(26005)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0pVNC80TWpqYmdUR1lNS2J1NGpJWjhzOWJadW1rdVdyYnEyQmc5TEtVUURK?=
 =?utf-8?B?Wm4zUjlaUXNKdmozU0tOVDZXdjRvWVJYR0xhL3RWT2F0UGxtLy9XZE9ERFNI?=
 =?utf-8?B?NjdKU0FETUdGaUhieUZ5eVVvcVh1eEd5bVpuKzBHNTkrWllsSVJyd3JNWE1k?=
 =?utf-8?B?VUVnZ1JXOHc2K1UzZzdMcHlkM2FvbFlVc1NnQnRSRjArTWNKV25zQzNTVDdj?=
 =?utf-8?B?dU1YbWh4c0JzQjc0Nm1zTm1sa1hsZG9pMlRUTHlEYzlZUGZsZ3c1NGsxU0V3?=
 =?utf-8?B?eWRCYnlEcUw0amVGZmdpMEJrOUVja1FUR09ycld5bjRuUW5KUFVZR0hnUndM?=
 =?utf-8?B?Q1hBTnFLK1lSbUJFZWtjUVJPUTlXVThaeXl0NnlnU1ZUV1BWZDZ4MGo3VlZK?=
 =?utf-8?B?TkR3QkF4SzhiMnFxaURzeHNkanUwek4zY3pKeU9YdzhNaUxlT21EbmxxVThw?=
 =?utf-8?B?SXBBR2pLZTlpTFJaWDZuSXVVaUlDcm1oNUhQS1o3MkFLNEVqS0Q3WURGZGxz?=
 =?utf-8?B?aGZ0eStzRTh0cTFieVQxZkFIZFZtc0hudWt0SDR1ZW1wRWZnUTBtTjA1Sk9P?=
 =?utf-8?B?eXNPdVJzWitXekdzc0xnTWdkYy95SEFTb0o3QWJjZWJvRjc0TE1DRmJGV2oz?=
 =?utf-8?B?dFJQZmpQTjB4aFl3N3NwWjIwWHg4cmNrUExjcXhUc3UvdWsvaFZlYm5GdG1D?=
 =?utf-8?B?REg4Y0RUaG1CQ0dTUHJmNTVLMDVFSmZwcXFGeWxZbkFRaENvR3kyS0RjQkVF?=
 =?utf-8?B?enRWeTVpUkJ1SFNQdG1SS1JVb0lkVm9uRVg3RWpKRDArazkxYXRMMXAyYTJz?=
 =?utf-8?B?UzkrSUtTSmVjTzZhZndRTWNqdGU0UmRHT2xqMDBSU2N0M1B1MDZRWFpGUHRu?=
 =?utf-8?B?WVJBeHFLSnpQT0QvZzJmMWE0MTR5amVodkxtR3JTWFFRUzNLNWU3bm1IR0Zr?=
 =?utf-8?B?aDllOXFiNWg1aDRIT2k0U3QwUGFZK1I5M3g1Y1MzaTVyaC9ZakdPQUpmMXF2?=
 =?utf-8?B?L25qcE8wKzIxeEJaVlhVak5FbTZGNGtyMTZaMTBlbzJGQzhlYlh5cDJPTU1z?=
 =?utf-8?B?VytxNDdoYVJTVHdDQlc1a1h0Y0VRTlpROWMwNWNLS3AySXJtS0JDL0h5M0dV?=
 =?utf-8?B?RHNyRkY4czFVUER6alVhUmRIU3V4REVYL3pNMnovWWs1Qk1ORHZlTEVDc00w?=
 =?utf-8?B?UmxydERFN2FTeFBqS2dPZS9nTFFZMitxdlk1V1YrVXJYMExDWnpFTkJsUi9n?=
 =?utf-8?B?bENaR3JqQytwVGxscWh3R3JTSTBwOHYvTU82MWR5aWtwRlhkWm5mY2R3c3hY?=
 =?utf-8?B?dklEMjJJSmVWMlRtU2Y5bUlRa2p2anprNmJmakdlSGpIVVVsMUJyWVA2VnFz?=
 =?utf-8?B?LzhDWW1YaVg1VUJKSC81Vys1czhQcFRtb0FSSkpxbWJXbnQ4UmVSdWN1Z3JB?=
 =?utf-8?B?T0N6T3NlUGF0VXpSZ0NqK3Y4ZFhYWWZETzBGMDZwNjQ4alhRVTFDTmtTanBM?=
 =?utf-8?B?bWUvWWI2RDdxOEtLYUFDVE5iekRIU1Y0cVo5cFlSaG9jQjlJRHZhbzdQT05r?=
 =?utf-8?B?enh4bERjODVHN3NROW9JRTZuYmdsejNNbUFHdFc1enpKRXA2dktWak5OTGxS?=
 =?utf-8?B?YjF6M1ErS1FaeWhoQWkwVlRhSktwN200emhQSmdsejZMd01zd0R5K1Q0R0wx?=
 =?utf-8?B?V1RZZFVaMEo3MUxqVnF0OTdKTWR0UmZTUnNQNkNPUWU0U3IyMlFzcUlOR3lp?=
 =?utf-8?B?aVhzR3lqOGFPSXQ5RmNRQTVrMHpoNGkreTREbXlva0V3NCthKzdtem1hQUh5?=
 =?utf-8?B?eExYa1lQTkFZNk9PUTdZeDJTWFVGTG9YeGlGNnVITXFsMVlZMGRxRVFrMEtZ?=
 =?utf-8?B?dlF5OTFBQXRWMUhEVUI0UEFyQnBNRDFCekxRd08yUU15L0tzdTNBU2xsVVZN?=
 =?utf-8?B?ZXBMS1pyMWNWQktoUHVLdy85anI4bzRmSGo5T0pmSDlBcXlQV1BJendxS1Zz?=
 =?utf-8?B?UnpCaGJSTEF0NjEzTENUdGpoMWg4cVl4eHlqdVZ1elJOUnhWYUxoK014d0c3?=
 =?utf-8?B?UUhUNTRIV2JMUEQwUGNIeXlXNEtBQStLNXhKcHFudmV1ZzlSWXVMcExQOFRz?=
 =?utf-8?B?TmZ5ZkRwYy83aUhVQm5oRVgxbFlTZXN0a3c1b2JBMVNGWXMwSS9uRU1XTENx?=
 =?utf-8?Q?cs1fFc+JovUMaODvEnO+esA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77d46b8e-2b8c-4174-27f8-08d9d4c13412
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 05:14:11.8579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hx5npwHXC51WACXMIV+px0OhtdpO+5a1MWGkVCeoaZCYx0FCYbR94WfAT7mXBCAyLpDjnvdcnoTDxi9t2bJVCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4887
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/22 20:23, Matthew Wilcox (Oracle) wrote:
> These wrappers have no more callers, so delete them.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   include/linux/mm.h      |  7 +++----
>   include/linux/pagemap.h | 11 -----------
>   2 files changed, 3 insertions(+), 15 deletions(-)

Confirmed that at this point in the series there are no more callers.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard
NVIDIA

> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index d3769897c8ac..b249156f7cf1 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1291,10 +1291,9 @@ static inline void put_page(struct page *page)
>    * applications that don't have huge page reference counts, this won't be an
>    * issue.
>    *
> - * Locking: the lockless algorithm described in page_cache_get_speculative()
> - * and page_cache_gup_pin_speculative() provides safe operation for
> - * get_user_pages and page_mkclean and other calls that race to set up page
> - * table entries.
> + * Locking: the lockless algorithm described in folio_try_get_rcu()
> + * provides safe operation for get_user_pages(), page_mkclean() and
> + * other calls that race to set up page table entries.
>    */
>   #define GUP_PIN_COUNTING_BIAS (1U << 10)
>   
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 704cb1b4b15d..4a63176b6417 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -283,17 +283,6 @@ static inline struct inode *folio_inode(struct folio *folio)
>   	return folio->mapping->host;
>   }
>   
> -static inline bool page_cache_add_speculative(struct page *page, int count)
> -{
> -	VM_BUG_ON_PAGE(PageTail(page), page);
> -	return folio_ref_try_add_rcu((struct folio *)page, count);
> -}
> -
> -static inline bool page_cache_get_speculative(struct page *page)
> -{
> -	return page_cache_add_speculative(page, 1);
> -}
> -
>   /**
>    * folio_attach_private - Attach private data to a folio.
>    * @folio: Folio to attach data to.


