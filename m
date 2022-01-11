Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F87E48A8E7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 08:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348724AbiAKHwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 02:52:06 -0500
Received: from mail-dm6nam11on2047.outbound.protection.outlook.com ([40.107.223.47]:1123
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1348721AbiAKHwG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 02:52:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mVsdABdVw11M0nVmWhyaEw8cTCChFQP0cYu7MddJsxkwyhVYcjj7I717EU/k1eK7IQbof5h4xG/7dr4i5yPcFK2G1pBrfKhbvKxqZxCJEYXjO/sTW8Y2i/GCnbAFCg/d+RZuxuM2rAewaTY/BnLQmLcl7yfH9+L/rkm+N8mVYIkSAiwaPmG/pXhT3hGICBePLtEd7Xr3Xgbc7Z3U/8fIopKtWsJBibyRC2WxhHPcZbYJl4Uy4+gbWASzMG7A/Oedry000dD/RTR4hGVS9QZyRMW2t4sYZ9JpXJYC1NXfkIYmsj/ypDqIUXfWNpnnDtj1MPOhFOv5f9HrAgoVeiMDzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQO4uhlRLMgRPi4nZ33bQ3ohCh/rG+2c8hZnro2wnVY=;
 b=Itv/b7L3svH9wBzkkpBrUjnVW4yG06yfSmojsDRLHCrH9VY/+1G42DiIa6/jsbF1XP2/cVc3W+w6rBzG6ba6AymzcP/zaURWUnahTNIrmT1YftiU0pwRpmswdK0eOuZorGMuM7JELUxkItbWo9ZBGj58FiJcnoakALX13rzTD0gQzYGDtiuyUyeNpoAzltjyGMoOn06r1aK9UNwHH/gpkSW9l8CeiQjrt3PP0RwNmaxDeWsVoVzOPQ1Ta2x5voG44tzOUWXOAKE7HX06Ilf5JvPQRpHjrsfAV5k4h499XzgRdgeo8znKEMZKNxhm9AbkiSve45VaIOygciEt3iSprg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQO4uhlRLMgRPi4nZ33bQ3ohCh/rG+2c8hZnro2wnVY=;
 b=MDg/PmqcoWec++W+5PCX4tG4ygCzljxRYR4uWKqHzY5BxWAmb5b4Qofa+FuK+yikkRbT1Q/pwPNAwJX5RPkqWVO36Tzg/OFx6KCjZ+p7sAhFnkR2BJNO1E/H9TEO/T/utVcYxu6mIcYgodKbBx6U7tWU5npStcYC3XhfMZxugvcgQhB4Pn6+/tERZnwTUgbDPql6xMX0LBCe3IQGrviQPMS3T7WHo0i79As4p8seggP4PlCVDAa2ZPq/jrRxB8ekEK87KnzsIA+ENEmmW+GvEgiO9olp2a6YbGDOAPUNfjg/3TGYBkRuenT0gotdvb2Fdfa2lUSP2sIHfUyLDt8dDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BYAPR12MB3062.namprd12.prod.outlook.com (2603:10b6:a03:aa::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.10; Tue, 11 Jan
 2022 07:52:04 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::8496:16fd:65c5:4af7]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::8496:16fd:65c5:4af7%4]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 07:52:04 +0000
Message-ID: <7a72bcb6-3145-e5bc-c670-73ffc64ce3f4@nvidia.com>
Date:   Mon, 10 Jan 2022 23:52:02 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v2 28/28] gup: Convert check_and_migrate_movable_pages()
 to use a folio
Content-Language: en-US
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Cc:     Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
References: <20220110042406.499429-1-willy@infradead.org>
 <20220110042406.499429-29-willy@infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220110042406.499429-29-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0094.namprd05.prod.outlook.com
 (2603:10b6:a03:334::9) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f2fc6f3-8dce-4348-726c-08d9d4d74216
X-MS-TrafficTypeDiagnostic: BYAPR12MB3062:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB30627F9F8CA1426FC85165DEA8519@BYAPR12MB3062.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XHiwCPWyNDgPtjzQBZyC5wH9BM+dT//TgvMvNcvwiAv6fTzqPbcHW0++jUmkZBJBudHrBntc4knNbqXnn7wMELa9K+/YiaL2Yrw9giBxYlc3JCWhzc/HncLY/OTBx0rMjijnodLXjqEkS00Aw8UkDifjrRI1ERodQ939aXtcdKBk1BC9WNVOTqXI1GaI1O4MDbREzG/4c/Kbgu7ycAALlSz2RAIGEvIZWhOdCnd3sQwqmJfDUsZRkmHIOXtzz+MjaOiC9fbI0sT2wIO6wS7+lYM/15gfcS/GcsWY9feGaB45HxilNJGu3gXMzaoP3fte98FZnntw79RFVrKkL2Dre/Uf9O+w4Sf+2q0IPuzpu08GyP35AClSd2GUYSxJ//f6383pGKclpgZwQEZuYyFADu/joB6VTh20O2mYq8KnioTVMcBXuyhV3gJlhQFuhmEH2//eqgMz26RI/l8+dyUBEI1zqfeuipTcyy5cXjcSAQkG9TnUnnLwLYfsg0BLWHKy/FSk/oGmeHhx+gldSlW1tQvdEORrCmDp3kSZ60fvICKPJN+uiv7cpXdvisRsaCDeEaf+bhsl3eQqmrN6uo6swbbnLMJU6HFBnr6/9gJgygt5rTJeiDxaSoLgRAWLMPJfq8BGHFHfwoIR9F1kK40fbCjzNvqES55A4yPWTS2wjuOYJoqZ+vm9lzJLmg1+GzLZsiuSQBsrdAvW4FCdiIOjyPJVcngSmgep0InW5jOpx+67p8ZEsWva7nog9EE1v/KY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(66476007)(2616005)(53546011)(508600001)(6506007)(66946007)(83380400001)(38100700002)(2906002)(6512007)(31696002)(36756003)(8936002)(6486002)(54906003)(31686004)(5660300002)(316002)(86362001)(4326008)(186003)(8676002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTA4eU9xbStETncyNytObEJkWkhtaDlMeXpENFhTeVZaRlRCVTNtUUpLRXhZ?=
 =?utf-8?B?aDQ4QXlIbGNSUkd6dHZ3cmY4N0JLeThyTFJucU85d0J2emJYa3NDNm1ZaTNV?=
 =?utf-8?B?SUFOUnV4OGhDNncvcnZSRi9ZellFRm9BeUpHQWkrdUU5dEwyelEvci91TVVr?=
 =?utf-8?B?RTFtR0dVSFNtMllTdDRvL0RwTzZUUEhTT2NHdmFPQ25NdDJrOTlGY2JJWkVw?=
 =?utf-8?B?SnlCV2JXRnk1RUlXQjQ5UE5zUmpRNEVDVW4wSXk3aStwU0RRNVEzTkVWZTlR?=
 =?utf-8?B?L2hPb2duM3laRDZ6c1ZIUkdQRUtpbGpINFZmR3Z6cTlaR2czMVJBU2R3ZTBC?=
 =?utf-8?B?TFN4bDZwQjVMLzh5L3pPNzFVRmFxVmNKOSt4K1FnQVJWY1pORy84bkNaU3JL?=
 =?utf-8?B?WTRqNk9INkU1bjRYbDE4VnNLRnM5OUtzOXNRZWpaNmdXdlJsWjdHblk1bVNE?=
 =?utf-8?B?Rjl1azZiR2NiU2dGdHNrQ29teXBNQjV2eGg5ZFpHMW1aeFYrcUthbmRsOWhS?=
 =?utf-8?B?ZW52ay85dk9aYWh5SGlLTW0vYnh6U2hrZERuUStxOHlHdDJZckFBYXVvYjZo?=
 =?utf-8?B?cFNjYVh1UW5raTdJUVZZSUhvRmEyYjVETXBERFdjQU5oMDhsY1JMVHRkdWEx?=
 =?utf-8?B?REQxTGZJaVBJcnVUQ01kc2g3OHV4V0FqWnlFeE9hQ1JyclR1Nk85TjgzSXh1?=
 =?utf-8?B?bmZaTWpETUkvZUovR2U3VThzczF3VTZsWHBLemlJZlZLTUQra0FoUTZMUUxk?=
 =?utf-8?B?NUd1VHZySURsM0FKc3pYRDgxTWlCL2U0REdIZGI2ZlFSWjErNi9QcjRCN293?=
 =?utf-8?B?N2FsK09XeC9lMEdlY1dFc0VCSDdtVVJ2MHlLY2xyUTdaOEV6Z3ZxZXdXQzM4?=
 =?utf-8?B?cnB0OVVoeUZpS3NoVkQ5ZEJRekVLZUtMUVc0eGVXM1ZkcmtmM0p5QjZkMDVU?=
 =?utf-8?B?bFpzOXFuYVVKOVFvL1ZaUEttRndHWDUrcERENGRxK01CVW9iSHR4MDRNYXdM?=
 =?utf-8?B?a3grNlNyR2xpanhqckVaYjViMzN0eVRjSGNYU0tMTk1XZU5LL2RFTTVYVjBQ?=
 =?utf-8?B?ellhVndTc0xZMUNOY0JLYVQzSzRjclZmRTJ2SUhqUVBYWjZCL0JtSmFTcjZH?=
 =?utf-8?B?RFhFRDBWVUpnRE16RjlxZGxrSklHNmVyZWpWNjBHN2hyeU91VlhrVTR3b1Ar?=
 =?utf-8?B?ZVhCWkpWbXMwYU52bzFWV1lXRnpYR0RveGQ2ZDBkTGpYMC9hM3hBa01LWGFY?=
 =?utf-8?B?L1c2bC9QZjcwZm54R1NVeW5ZWmg2L0tXa3J1YWRhbGpScUJsNDVQVDgycENn?=
 =?utf-8?B?cHZIYXBRc2piSW1tZEhrQTh1TTUvRXNaQkhHQ2Y5L2JhRjdDZUJpS1lYR1Fa?=
 =?utf-8?B?Q0Ercm5IWEhDdlB6OWhYY3pzd3hqeHlnSUQvYkZGbVVXY2d2UWsyVmNvSk9n?=
 =?utf-8?B?VHA3MDJMWkRaUFNvZDlaZ2t2empweW9VdThNWm4rWFk5WDNaZkRtMkM5bS9x?=
 =?utf-8?B?TFRrMWRQcEtXZW4yNHd3elo3NC81ZnEydjJ6cFREOTR4cDFITmxaZU1TVHJX?=
 =?utf-8?B?Q1VoMXo5WENtV3FlZ2ZYTVVWNS9yY1pSa1NSWjYvRSswdXRQaW9URmd0S3Q5?=
 =?utf-8?B?VEtUSG80VGpYV1EzYnAwT3BTZldyZnZIY3ZBZzVuUGRhZkUyMmUyVTZnQkE1?=
 =?utf-8?B?VDczbC9OZmRkc3pvZGZCK0JoOXU4RU56NEF3Y1JPZGlRaHkzU1NYY1FZeFNF?=
 =?utf-8?B?dStoZUJJditxYTBJb2V5NkNMR3lwa1pRMk5xbHVlVksrSXZ1Yk1GbkErNTMw?=
 =?utf-8?B?ZldTMXo4RHV4emw0VHhPK0xYQ201bmszMG05d082c05saWFZY3JOL1dlYmhz?=
 =?utf-8?B?K0kxZXRzWVFpOEcvMFVSTjlZaVFPWDBmVEpid3FBVm1MT2ZnSjMzd0JUYTRX?=
 =?utf-8?B?M3hJdnZkbExDaVdmcXY1TzBlanI0ZWZ0ZmpxRDVmYWNjVkVxK1h6WVhDM3oz?=
 =?utf-8?B?NlFsSmRWWHM0SFNlY0ZrSWs4M1g4aWxsVkVZZWhjZXNnamoxRDd0aWt3WTNM?=
 =?utf-8?B?eHRoQjRpZVg3dXg1cXFWLzg4MzVEM2p6RDAvMVVMQTNJQWprTzdsRVhOWk41?=
 =?utf-8?B?ZzhhckJldTNMdzY2Q3ZjbVV1Q0x5NGV1TW9FdXJ3UGRMQ1pSdXhaNHV5Qk50?=
 =?utf-8?Q?7KQ9yzmt672trhsqb1NBANQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f2fc6f3-8dce-4348-726c-08d9d4d74216
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 07:52:04.3178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GB0teriIudmSONFdIwZFXKsIiJOZnH7K3FcBUqGT7lcGumpXu9YmJx7ca4eaCXmqiY1Wocpk0Jh+QWIJqDXguA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3062
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/22 20:24, Matthew Wilcox (Oracle) wrote:
> Switch from head pages to folios.  This removes an assumption that
> THPs are the only way to have a high-order page.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   mm/gup.c | 28 ++++++++++++++--------------
>   1 file changed, 14 insertions(+), 14 deletions(-)

Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard
NVIDIA

> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 1cdd5f2887a8..b2d109626c44 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1801,41 +1801,41 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
>   	bool drain_allow = true;
>   	LIST_HEAD(movable_page_list);
>   	long ret = 0;
> -	struct page *prev_head = NULL;
> -	struct page *head;
> +	struct folio *folio, *prev_folio = NULL;
>   	struct migration_target_control mtc = {
>   		.nid = NUMA_NO_NODE,
>   		.gfp_mask = GFP_USER | __GFP_NOWARN,
>   	};
>   
>   	for (i = 0; i < nr_pages; i++) {
> -		head = compound_head(pages[i]);
> -		if (head == prev_head)
> +		folio = page_folio(pages[i]);
> +		if (folio == prev_folio)
>   			continue;
> -		prev_head = head;
> +		prev_folio = folio;
>   		/*
>   		 * If we get a movable page, since we are going to be pinning
>   		 * these entries, try to move them out if possible.
>   		 */
> -		if (!is_pinnable_page(head)) {
> -			if (PageHuge(head)) {
> -				if (!isolate_huge_page(head, &movable_page_list))
> +		if (!is_pinnable_page(&folio->page)) {
> +			if (folio_test_hugetlb(folio)) {
> +				if (!isolate_huge_page(&folio->page,
> +							&movable_page_list))
>   					isolation_error_count++;
>   			} else {
> -				if (!PageLRU(head) && drain_allow) {
> +				if (!folio_test_lru(folio) && drain_allow) {
>   					lru_add_drain_all();
>   					drain_allow = false;
>   				}
>   
> -				if (isolate_lru_page(head)) {
> +				if (isolate_lru_folio(folio)) {
>   					isolation_error_count++;
>   					continue;
>   				}
> -				list_add_tail(&head->lru, &movable_page_list);
> -				mod_node_page_state(page_pgdat(head),
> +				list_add_tail(&folio->lru, &movable_page_list);
> +				node_stat_mod_folio(folio,
>   						    NR_ISOLATED_ANON +
> -						    page_is_file_lru(head),
> -						    thp_nr_pages(head));
> +						    folio_is_file_lru(folio),
> +						    folio_nr_pages(folio));
>   			}
>   		}
>   	}

