Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE1DB48A6C6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 05:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347822AbiAKE1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 23:27:21 -0500
Received: from mail-dm6nam12on2072.outbound.protection.outlook.com ([40.107.243.72]:61856
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230008AbiAKE1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 23:27:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ET4zHu3Ok/Zi+2jEn0AzlQzBcDhcuGjtqjCXrU2+bEHHCXvpBR8cbxOT93N2XBIEeouCeEFLHywmj43kC0/OGuKHLMoJy09V480Xnq2cSj8DeGZvyko5+cStQXP6ZnmTgdZdwGmRruMPsRVNZq+UfD9xPY4OheF3r0l3VuJIZpEIBWI8Illn+F33Al43Yy2MPwyN1y1XAsKJC+cVWdBXI/vbuWhVxPRS+w6kr2gT1u0Wm5U3UvSfcZhnK9+f3KpcT6yxaWuyhL3WqyjDNm0R/XKlSMJWErfHOpQChkhLfFtvQI33xzvGynA9KPho0qcpBREOdxkx01rY/R2DDna9TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iNPx8lftIqjoHYDTQhE/WS2/c/NuzAitAbIMHNDpP2c=;
 b=CWI2yqDO0Etw8bdZeXCHGi8Ok4TVCY8vR7U/lVShphDOYE6YSSu/BFZ5aik5paBZr3hp4eFvy93JLoHpCwhz8Q6qt+ERP57wb4O+TM+IAGlX+UIyzriFkPXx68psOUSMHyX01xIjqE3GkG5NB3uXOZooR+uTmn3dEcgzrfEaVaIWGKM28ZoWuNtYyR4YpbKxVmOQSc+un3XQJRM7jeE2rN8pPFrIpyov1XBBGLUG+siivl2fQwJ9viein2hoqSOi/W/UkuWy1X+wOjqguW8QvtPd2mez1bkp4dCZdH8ld3VFOl+p9tiwVoxywWZY6rAK6BoGCOPL37oP8FBdsWIiZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iNPx8lftIqjoHYDTQhE/WS2/c/NuzAitAbIMHNDpP2c=;
 b=AQDzrDxySigczw8cXDbvQ+i3MzHSEtuINqREWYyRlZKEwDk3J0yDzMvPrcz7iQ0SOKL8w3AHy/bpUgVwpHwK8qX4NJmGumnxD748gxNGzk0ZJ8OtMt+2dD7CJ3kRsVaJfmLpgqMTJdVjzyAbSfMLnP7ixMFHbiPQCGk5uUOtB9sVAUg+1tOKla0Hn4MKzusrlWK/qIEU/kdNe+lovdTqluOwNmTbyTWwqbqHFygiyC9IpzymlDBMfVjLV89nKLg5Za7DwOM38Yy7L2EusM+4R16xdqNWjkvlXLYmjzND4x2xq7IYmLKptd/tfWb6v3GSrTSahmY0H1WX+eqmPFHN9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BYAPR12MB2790.namprd12.prod.outlook.com (2603:10b6:a03:69::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Tue, 11 Jan
 2022 04:27:18 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::8496:16fd:65c5:4af7]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::8496:16fd:65c5:4af7%4]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 04:27:18 +0000
Message-ID: <4c4e4790-41dd-e97b-8620-9177ee15a46b@nvidia.com>
Date:   Mon, 10 Jan 2022 20:27:16 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v2 14/28] mm: Convert page_maybe_dma_pinned() to use a
 folio
Content-Language: en-US
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Cc:     Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
References: <20220110042406.499429-1-willy@infradead.org>
 <20220110042406.499429-15-willy@infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220110042406.499429-15-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::26) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 171fd05e-36ef-4eb0-f791-08d9d4baa73c
X-MS-TrafficTypeDiagnostic: BYAPR12MB2790:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB2790AB6FF0AFB3C295DAA8C2A8519@BYAPR12MB2790.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mN/jkt/tuwL5ssMpX6uTb5PEgZvlmlcIYDbdn1qrsu1d0UsVDAog+4UZddB1u47rRQovPLEe+w3Jfu2jTWrCZAVSh5iKw14xFLLNQwIXoOoG3A1OuuXY80UQXpiglmWIDRZ5BQTE+2wSyLxbwAr9wqCvqh2kkHCkpQ7k1SLfnzAKGuhK1+7MwyTGSYKbrdnRdBYih2hdwAYZ9kIFCfgJhhr5icV82Bj3f6qqQvRrPAr0G1lVqM12v8OthsVeyQEVINEHCpLJ3a6dqTuHx4fdB+nIY3SR4gb1d4S4PO43PCxlPbZzIuLvfFEdcK9gFZBnCyS8w1quIpOKfbxtXlutkTmxRccyPZUL9ePuIkCoEanSE0gIGmkJEqpGc2GEqkvBhmN0L41O7wODgj6QMw9qfHi7o5aZIKoPdTT4Yc/+2PjEdY7bEbKgtnNK/ascm1rE5ukGIiosXOYBEC795OkXrMOLqT1ntuMCl21QYZ3qj8QJxPCNZ+7fsQfwEIyNmZvq35Zbr9+mawJX7N2f8Ek3K21EZLOqswoaO+MjrH8g282nODTy08qJWiXGHD5OEbbm+BKD0Fl2YS1wRefTtdjbYcBnXASE9dyVnhI2YUeVQgi+hx5LO1x5HvEvV1OGYeACicbsUpLYceX33hDS4jTvWuQV9zQt88vd7hE4LEE5VKCvG6rt+tTkKGliblhspqKvlnmolDIrEwOE05gLzqk3smzE0iaiCKQOjYg/EARS+5u7zxKlqM6HGXT+Xjuz0VSC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(86362001)(6506007)(53546011)(8936002)(31696002)(83380400001)(26005)(66476007)(508600001)(316002)(31686004)(5660300002)(36756003)(66556008)(6512007)(2906002)(8676002)(6486002)(54906003)(2616005)(66946007)(186003)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SklESXdGOC9hMFdHTWw0YThmR1FFNndneERaVWd0MWpXK1pnR0lRWmo1K3RZ?=
 =?utf-8?B?SW9QbTJqam54S3RXRE1QRGZxSUkwejlFZ0NxL0hTQXE0K2R1dmMvSjBBQWxi?=
 =?utf-8?B?RlNwTmJocXY5ZlhZMDl4Q1JuenFSMUpTMkpPQWpXdEQ1eGZqTWdCMzVValpm?=
 =?utf-8?B?eFY4WnhOeFUxSW5uV3hwZ05pRHJ4dkc2NVlzYXlwWEF2TG5lcFNnaEgvTlFY?=
 =?utf-8?B?R0VvMDJ4TkE3VVJQcTJlMjVZTGVGZE9COEl3VGM3UUFtdFVESVpIckpGcmFO?=
 =?utf-8?B?WFg5dXBpRXVZaWJmZ1JIQkVOR1h4dUhyNFNHb0VoK1RjTXVLM0xxMWd5T1ZH?=
 =?utf-8?B?aUQ2VjhyZVNTYVdXeXJ4UlhhU3RFdFJTZHNQRURYSG1neTdUa3pBWE1QZ3B3?=
 =?utf-8?B?ejlEd1NGOVliZVhySmFmUlJZcEZiVmtKUFJDaWpHUTRha3E2SG1FMlVaYlpo?=
 =?utf-8?B?ZVNzSlVxVGJsTTVUYnZMbWxHM2VHZWZQSURCa1VKb0RIVlcrRjU1RkYxZmow?=
 =?utf-8?B?bXN3NzVoRVpNZjNyUDlUanRHNVFOOFBpMDMydGFKaUdnaDRUb1dGcjJVM0Y5?=
 =?utf-8?B?MGJWcm5YTVp2R1BkQitrTXRtcVNQTU5PZFJGT2lNRmVPOVd6SkptMWtGdWdk?=
 =?utf-8?B?Si9YR3FoQjNxZnZHR05NdlJLODdObG1RMGkyK2RKOExtalZ6WHdtRGYrc3Fs?=
 =?utf-8?B?NCtiellhV3FySUx4WkhOdlNUR2dGelVnUmFFU3BJWDRCejVKbWlqbUNaZldS?=
 =?utf-8?B?bjFqL0gwSXQweXFaeFN1T0RBbFFRNTJqZUozQUVJeTRTQmUxVm92aVBFZGEx?=
 =?utf-8?B?YzVpNDFPRFdBcDd1NHpLRXJoWFozYmw4enliNjIraS96SDMzeTdnUEU1R3kw?=
 =?utf-8?B?S0VaZWNqdVdWYlJFSTM0MlVNSDNOYjFYVzZ5dUE3cm9oalFFVEl2R2srYkFW?=
 =?utf-8?B?UWFLTHc2TEp0VDFtSmNYQWwrM1k4N21wQ3cybGk5NGM4blpNV0FhNXVCYjhT?=
 =?utf-8?B?QkNKUDBOa3Z4VDJROFRsZlpuWXRjbnZVc2pETE0xUkQwSm41L3RBcnByNnYw?=
 =?utf-8?B?MXdpblB4ZytPOEMyWGxzQU5LaVVsMlowMTVRUHhGbGw4Tk5BcGhUOU9HVG1t?=
 =?utf-8?B?eUR3b1RhTHpmUWgwR0hZRTdmVHoza09lNGZDRGZGOFUyci9tWmNxUFphVjRy?=
 =?utf-8?B?WEdTQmxZK2dCM1F5U2xhZ3crSUs3OUM4Tkt6b3JnUTkvRHNST2VwNnJZaDVh?=
 =?utf-8?B?K1lFSEc3WnJQbC90QTMrQzJzRFJ4emZPN1BtMjJNUWRtMmRoUWliZTFjNlp5?=
 =?utf-8?B?MUlmWE1sWHk5bjdnNjhwV1Y4T2syL2Y2RHBDL1JGSTIvdWVNS0xZY0Y1WER2?=
 =?utf-8?B?bUlzZzQ4U1JOSUxXNDJqa2htUWN2OE5mUXBJMXpEeHZGUHA2TllkOGkzMDlu?=
 =?utf-8?B?QzAvcWcxTEo2MGloVGFyZVIyK0tvSnRHRVpuaXlnR1gwcERzSDZBN21TSG1r?=
 =?utf-8?B?clU4RUc2Mm5WM2tUTjUzNStXM24rSWd3MDY3R2Q5cWhPT2Q2YjNtRGJWbWwr?=
 =?utf-8?B?LzBFK1VYZ01kN3JMRk5ITFlHTmNLTDh0Qzh3eEFRcEp3cmc1Mi9lenlYZFNC?=
 =?utf-8?B?U1ZPSEp6U1J3Zmt5aVdnRDE0YXZXRmZxRklST0lieHF4ODR1NVlMWjdwdmFW?=
 =?utf-8?B?dFUyR1pYeXZPWitzc0VmNXdXZ1NZT0l1RmwyU1B0OUx4ZjVrOWdVWEVHdDdQ?=
 =?utf-8?B?eU9SM1NJZWt1djA0eWRGR2VMaStWckJyenkwV2NkTGxpdWo1Z2JOMytTejl5?=
 =?utf-8?B?UWNXS0VDMGFjNGUrTDAvOU9OK1V6V2VWd1F2TmpJTEFMMGtIWTFmd1RMQngy?=
 =?utf-8?B?QW9ESlFsZWpQb0UrOGhldXJYSXcxVTg4eElhd3hQU1FYL3ZScDFUNmNBYXBu?=
 =?utf-8?B?MVJCdlJhNmtqK0cwQTRBa05ENjFJa0ZtZnVyQzd5NEliK2g3NDBPZGhhUVJ5?=
 =?utf-8?B?d3BUa0hoMWc2UlloVnlQcWpUbmlNaEhTYS9RTzdDT2hzRUYwTmNwRk12TEhV?=
 =?utf-8?B?ZWNPdzg2d2NjcGR4S1dreFdReWt0T3hQRUh2aFdlc0xtbjBjUkNicGdXd2lj?=
 =?utf-8?B?VEZuU3VXYSs2dFN5R0c2MFZrMTM2ZmJHcHFBTi9tVzZSUEoyb1QyZy9EdWJX?=
 =?utf-8?Q?GF69qIbenHrwmTKtlpKgO7w=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 171fd05e-36ef-4eb0-f791-08d9d4baa73c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 04:27:18.7101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dJuvsBX9kXYttNG3QZxR5TL6RM6uysKDgpZPPQbWI0U/9fkZ8Bwn2H80H6EMRgX3oUvfXxnJiL2P5lVtgo532w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2790
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/22 20:23, Matthew Wilcox (Oracle) wrote:
> Replace three calls to compound_head() with one.  This removes the last
> user of compound_pincount(), so remove that helper too.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   include/linux/mm.h | 21 ++++++++-------------
>   1 file changed, 8 insertions(+), 13 deletions(-)

Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard
NVIDIA

> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index bf9624ca61c3..d3769897c8ac 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -934,13 +934,6 @@ static inline int head_compound_pincount(struct page *head)
>   	return atomic_read(compound_pincount_ptr(head));
>   }
>   
> -static inline int compound_pincount(struct page *page)
> -{
> -	VM_BUG_ON_PAGE(!PageCompound(page), page);
> -	page = compound_head(page);
> -	return head_compound_pincount(page);
> -}
> -
>   static inline void set_compound_order(struct page *page, unsigned int order)
>   {
>   	page[1].compound_order = order;
> @@ -1340,18 +1333,20 @@ void unpin_user_pages(struct page **pages, unsigned long npages);
>    */
>   static inline bool page_maybe_dma_pinned(struct page *page)
>   {
> -	if (PageCompound(page))
> -		return compound_pincount(page) > 0;
> +	struct folio *folio = page_folio(page);
> +
> +	if (folio_test_large(folio))
> +		return atomic_read(folio_pincount_ptr(folio)) > 0;
>   
>   	/*
> -	 * page_ref_count() is signed. If that refcount overflows, then
> -	 * page_ref_count() returns a negative value, and callers will avoid
> +	 * folio_ref_count() is signed. If that refcount overflows, then
> +	 * folio_ref_count() returns a negative value, and callers will avoid
>   	 * further incrementing the refcount.
>   	 *
> -	 * Here, for that overflow case, use the signed bit to count a little
> +	 * Here, for that overflow case, use the sign bit to count a little
>   	 * bit higher via unsigned math, and thus still get an accurate result.
>   	 */
> -	return ((unsigned int)page_ref_count(compound_head(page))) >=
> +	return ((unsigned int)folio_ref_count(folio)) >=
>   		GUP_PIN_COUNTING_BIAS;
>   }
>   
