Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6143C48A652
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 04:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233739AbiAKDay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 22:30:54 -0500
Received: from mail-dm6nam10on2080.outbound.protection.outlook.com ([40.107.93.80]:41728
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1347829AbiAKDa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 22:30:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gpz+lK4jFVcT3n0LJ21qmsuzL/pxQxPxmKTro6xnmaHTiwF+fYNq2lql9g2DnrZ2e/dmTw5oi8hbBhggeWY6Y4FqnL/Cp6uPbnthnylFeImwln8w+Y72lBcGHdLa7dxdPmc8o2ovmXdjw3O2s7lMGgnlPu8A9ifQAMw4YlBT++iEoYSxEDlyn8EzTK2x8aa3K6qBSdGv9GvOclV2p06Tr1G5gebzwEpNmeYHh8ffYBtYfabLdW7oY8NLjonhGWdRwViOy2BhKKV90xTeVmt1MZLavo1Y4GWmtG9t0SRFCLVsuTAi/0sBCJgyfqB3ZOkhJlwGE/Ed8a63Kd/jSMCLdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eYGF76cfANH7DN8pZtjlVgFW4XGMFpS20x3kIHfe2N4=;
 b=nFPebRXrJyXj7etdQpqen4Hi/RcKRvXbDLvXSTajjHoP0rnbh5dguEcxd1hzsT8Nz/MikviSFynojCMYPCmc3A++JnlZf2ixzZXYTJ3UBEa6ChbCOzlslkDslXgeaUN9nQq2Lws7YRmrZa/UNcxCRGblxB5K5NW1u5lQWloe1Ioftc9xbDX6OirIqvq4+/1wjjAz5ycuaiVoXY5Q0nBG1eh+hkYRtCaL+pCfjMkoKP5lfGnjxakg/qlYGRlOSambO/LpM7/F/vgW0qZSlkNJ5nrktUVMSXqr5qLr00V8P6UmQq3+VrVVDMfYKfmPyqC+uK4OAV481SwyEgAIlh5RJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eYGF76cfANH7DN8pZtjlVgFW4XGMFpS20x3kIHfe2N4=;
 b=c4ly+60V87bvpJjfcD/RAvdWJWW/0r4Q8/rxP0ST55cCHge7FoaWqhKqSqJ6gwK25doA252ptEUkD1L6JDThr+gY9KU1oB7FQNU2uV1puUz+yNDews0Ptg3ykYuVbfPPx0Wq8XiD+iHW9pKr+L1rig8l+B0TSySQMxOrXyvjRq6X0d9CaONTjgl87zBY+jP4UtUUlv9RabpUsGwZkXRIwRH+rjug1/qTs3lp0pJ0YmSguexnXvCLFDSn5AwkwUYj8zx2HUbP2Pq/FWTmnlt4fxhCgMDEhdz6kkKDi3a3UB8U3QvG9B9nn2qIVTff61J3YiQSTgPuA4Nbgz32m0L7OA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BY5PR12MB4997.namprd12.prod.outlook.com (2603:10b6:a03:1d6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Tue, 11 Jan
 2022 03:30:27 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::8496:16fd:65c5:4af7]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::8496:16fd:65c5:4af7%4]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 03:30:27 +0000
Message-ID: <c7ca4374-4389-8bb5-ad0d-8d2e8c0784e2@nvidia.com>
Date:   Mon, 10 Jan 2022 19:30:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v2 08/28] gup: Handle page split race more efficiently
Content-Language: en-US
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Cc:     Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
References: <20220110042406.499429-1-willy@infradead.org>
 <20220110042406.499429-9-willy@infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220110042406.499429-9-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0070.namprd17.prod.outlook.com
 (2603:10b6:a03:167::47) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb627d65-d47b-48c6-3756-08d9d4b2b63b
X-MS-TrafficTypeDiagnostic: BY5PR12MB4997:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4997529833FF5D053605E9E0A8519@BY5PR12MB4997.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T6lkVxs5XN8LtHgJmC06X0RhdlLQydJGvecC2RuWcqRJwi73RmPdALhm7FKPtqViLxrZlRfs4hIXEhxch/2oPaJVhTGiHIlzOQeHxXynowMVrymTZlh1Y9prWIQnlBNWWfzEM05kuU6xXV1B+pcJA+E1JYzuT1QDmUTkHdm8nXtBrj8KAu1FXYdoAppaui//P92O1vyghpTj9lDYvkWpygKcl2GdbgycZXiu1oxPPLhkEd3d9e5xXUF7K4nUnlBYQW/zyydfo17Tlk6beSlxNaxqYaSWcIcmtmtZnSOc2FFz324wltw9GMilajBaSODmidhss/b93ZGrkxCgBDrXjrEJsHs0TgTyGgAoxHNkfZXuJmqJAGh6H0IrGRTepSsi2hdoh5DnnMqWHzVxqoN5+b9rGS3nQ1VjllRMJd0fnA0JTn6pgrCUULqxDieEBrFS7aq73TSEyGMiMf9Y1exG9xdj9sON9j5cOwaJk4Wqf1LMX7fTqJOfIUIiNvVxbnYKfzxf4kh0hQ+y5qCfmpjURoRnxxV8iKVYCgjrVxTkdwDwS+0hb/iPYIAQpz6OzHvaVq9GkGRV+C9eNyTSVIVUrno+RcFq9lPHuKUe1neEDV0HHorVbJdcwQ4FWRNOnLrTovkmZfLffj6Itg3FneSgGRNXXuxeB6GYt9Xvxj/1vNX4d0hbKm3+7LWPyfHwCIaO5detdI5hdfz9lcMn2QB2Y//AtZRJkDN4p7bx9EkVBvZOLpQ5IDYHT1ssXluW/CxN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(31696002)(6486002)(86362001)(26005)(2616005)(2906002)(186003)(54906003)(5660300002)(38100700002)(66946007)(66556008)(53546011)(8676002)(508600001)(6506007)(66476007)(316002)(36756003)(8936002)(6512007)(4326008)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TldNMnBOdVRGdFVUSkQ0MjBnQWltZUtpbDQ2NTdtL1BYcXB3Qm5jZUw0S21m?=
 =?utf-8?B?dHRSRXBHU3RXclV1ZFJCbjM0dDBsYy9pQUp4b3hESWFSZ2FyK0wyVnVhWFBY?=
 =?utf-8?B?aGE1SHRQeVdpNHJNSHFZVlh2M0ExWTl1M2t1UC9zZHlKcWo5WGw1MVBSdllG?=
 =?utf-8?B?NDFNZm9hTllHQlkxYzM4eU9IRHI3cElZZGJXWHRFcEVaUDV2VGdoRkt6SXlx?=
 =?utf-8?B?Ti9sQzcwSDdKSmd1eW4xTmRHeitjcytkNW44RStYejMyYnBFUzZQS2NLZEl4?=
 =?utf-8?B?amJYZ1kwL2xkUC9SeE1NelBqVHdLOWRuanN6dmV5SnlCY2FJRDYzcG13Wi9i?=
 =?utf-8?B?SUVFWVV4U1M5YTI3TTdqOHhGTFBSUE9tcmNVNlN6SUJjQWhLa2J6UG1ZWFZM?=
 =?utf-8?B?QWtLY2lqZVlMaHdhMjR0OFZrMTU3RGFHbWxTMFFRTFVuTGVzU1NWWFVFT3Vv?=
 =?utf-8?B?Zk1MT0tuNHpiallMQU9CKytxQ1cxd2JLaHd5ckRGRHBlYWQ4SVdVcnhESXhM?=
 =?utf-8?B?YWdXWmcrdW5kOURWb0VyMzBPTk1neXdNUkNCN0cwYWp6M0xENk9tZ1FoT3Ex?=
 =?utf-8?B?SWZyUldycVQzUVpDeFlOcmxpZ0poZUhpR3dsSWZkeUpsM3NIOHZzQ1BCWGtp?=
 =?utf-8?B?bC9aQllHbERnYUJOVnhLQnJJNnN3NWY5cHZRdTRPUkRpNFRUV0gvbHRzLzdy?=
 =?utf-8?B?OVNDTVlUV1pTNmtpUzhhb21taVpTWGs0VGdNTVp5ZzdnaU5wR0VPU1I4SURG?=
 =?utf-8?B?M1gxZlRDaTRYRVNDRkxNWlVwK0ZrWmF6OC83MnVtdWZUWWpURTVhWXo2enF2?=
 =?utf-8?B?YkJXQ0RnalVoVDhySWJmSitrcm9mZzRoUUVLNDljUDM4OVRRZnQrelhwU0Nk?=
 =?utf-8?B?OG11N01nWm1NNXhwSmxLODlGbTRCMzdsWVg1WHBCUEZzR1ppSlp1Tkp1S2Rj?=
 =?utf-8?B?WDJWcDBpUkE5TVRJSER5Q1ROYmtFMVlHME1nbzR0QVo1aUJvdmdGVnNqR25Y?=
 =?utf-8?B?Z3FDeHFFWXFHVGNKQjNXZEQ1SWQxV1hvQy9KSWZMVmRiUzdTMmRKS0cvK0pR?=
 =?utf-8?B?VmRQWVdFSWpIWDFGL2J0blpDay9SZ0ltdGJrTk5mWTMwOTBFUXo4bm5jWUg3?=
 =?utf-8?B?NklkWVp3ZS94ekxnOGNndkIxbldNM1hMNXFrRWNGT29ObDN4OVlxZDVFbmVI?=
 =?utf-8?B?RW82R1ZlYXJObDJXMUJMWmxTck9sRXVyVlpDaUxIZlBzeUZhL091OUlJUXRi?=
 =?utf-8?B?NDVIUkRxa3NLVkJMcW5TK3VoNlBJME1nQ0JGZ2ZXUEdNSTgwYzRsL0hvTEJ1?=
 =?utf-8?B?bnRNa0VtelhUZWVuNFY0WSs4MEFwS3J4Z3ltSlNxY2swejYwQW5HUC9zNEt0?=
 =?utf-8?B?ZXBRM3Q0L1IwZmtYRGlzMDJvVkNRelo1bkVnaWllR2FrU3luempvdU53OURx?=
 =?utf-8?B?dmFnUEdkSnNhNGkwMzEzUU03R3o3VVREU2FZT2RvZHRKWEdVZlQwOHJjdENy?=
 =?utf-8?B?cVRHV1ZaeHI1MGFnRmhTeWorQTBqa1FDUW9jNmRSb2tpdGtRQkpNd1YySTZw?=
 =?utf-8?B?YmJJcWtjWkFxdzhLTFlxL1drbzkveTJHRitqckZwSUpnTm9HZ3JkOXN1a09t?=
 =?utf-8?B?TjJqeCtoemZ2dGhjNGhDVzVwVGl6Z1c4R1hrZHprb2dGR0RiYldqSUdaV0pi?=
 =?utf-8?B?V3RndFhqN1dCQ2pZQU1DMEpwNHNOWExvUlFncFo1TDQ5ZVBtWVBBT1lkZ3dW?=
 =?utf-8?B?TGx0Z3JkZW1KcFRQa05uSzYxS2JQK1VmNG9YR2xCV2JOSE9SZlNTMXAycjYw?=
 =?utf-8?B?UTQ4eTU3bm15a3loU0dqWWw0a1h0SjhyT01NYkhnRUppd01DL1lvbEF4aXVG?=
 =?utf-8?B?YnJCekpTRTRYVEhTZFI0UmJ6NmtqUkoxby9mVkgvUGNlby9YZnRTNzNKZFRK?=
 =?utf-8?B?NmFGQVVXNGcydGYvaXd4M3R5NVJ6eHluQ3hsVjdKVzhYNS9vK3ZoNnhMaW1O?=
 =?utf-8?B?Q25ueHZvZGVFRCtyOFM2RFA3NFF2bUdEcU1Ud3h6ZmZOZllrSDFGR1VSakJC?=
 =?utf-8?B?QVRlVHc1VjQ2Q05HWGhyWExtQTlZM3dFaWp0RWxPd1RaTzFKQWVzNWQ1d1Bt?=
 =?utf-8?B?YUMwRytOYW1ucFJ6djJkOWxlRHpUNjZoWkpkMkFuaTljT1BFSkU2NFdLN3JO?=
 =?utf-8?Q?dUF5KPmvRnBFCVBSlC67+3M=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb627d65-d47b-48c6-3756-08d9d4b2b63b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 03:30:27.7955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uZrxsByq8Mq9pr3NhxVEh7IGYz9UU5Akt/Hqbmultoyg6nnq9dGFM/fWx4u7JiIobTfNYFYSVucr9mXwLScCBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4997
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/22 20:23, Matthew Wilcox (Oracle) wrote:
> If we hit the page split race, the current code returns NULL which will
> presumably trigger a retry under the mmap_lock.  This isn't necessary;
> we can just retry the compound_head() lookup.  This is a very minor
> optimisation of an unlikely path, but conceptually it matches (eg)
> the page cache RCU-protected lookup.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   mm/gup.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)


Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard
NVIDIA

> 
> diff --git a/mm/gup.c b/mm/gup.c
> index afb638a30e44..dbb1b54d0def 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -68,7 +68,10 @@ static void put_page_refs(struct page *page, int refs)
>    */
>   static inline struct page *try_get_compound_head(struct page *page, int refs)
>   {
> -	struct page *head = compound_head(page);
> +	struct page *head;
> +
> +retry:
> +	head = compound_head(page);
>   
>   	if (WARN_ON_ONCE(page_ref_count(head) < 0))
>   		return NULL;
> @@ -86,7 +89,7 @@ static inline struct page *try_get_compound_head(struct page *page, int refs)
>   	 */
>   	if (unlikely(compound_head(page) != head)) {
>   		put_page_refs(head, refs);
> -		return NULL;
> +		goto retry;
>   	}
>   
>   	return head;
