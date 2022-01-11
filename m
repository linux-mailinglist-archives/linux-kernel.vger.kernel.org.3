Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7276B48A891
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 08:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348590AbiAKHlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 02:41:36 -0500
Received: from mail-bn7nam10on2045.outbound.protection.outlook.com ([40.107.92.45]:50016
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235766AbiAKHlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 02:41:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C91YlWB1ASD3IN3gwLBh+1jNnVVHzkFBdO93GszU1jZSsQ0ioHfjq8M/MVB9tOOlTSzfewZA9YnrDVeEGeK3oNOxw9WVMPspi4dr6XmNDQW8aU+N4l931bzjxTUKDWNapmV4DWNXeyifr4Q5fKV/KBrhEVWjrAGORZ/rWX/WK7JKD7PMOc1hChJ1aO3zDwYN5UFBM7DBZ06m7IhAsGm8xNdw6oMinA6ymVxbc0AzFzntqsRsd5fVn54IEYZS3RsOtoR7o6VM2j7BCCywR159yezU28iaG2zxxchdFahSo1FBjURAYymk0Bo3gjmI2V8B0p9Noa06UmQJm9BMUpj/rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mqagKaOD2FzanfsDqXt527ZaLmnQb9ebXdDK3teFHVM=;
 b=Fp75Fb/g0Ic+yw/8LDM7aCmwcNPJeLSTftICbc5i6LWtYfgfni0RjvecPkGEfUFNxGnvLViEdehr7+7vJqQSorEAtRc8E4btWowfwT+2sbOcefjaocLhEGkAharO0/vk5cE8Uo7JjHEBauCg/J3iMnj29rVJmjrHVMzmD4CUhnDaQ4R1m7+WFeR3R9tln6zNgO+LmpHk/LHzvOrBo8wNAgUtnW2KvIB8QMK4EfXJTW9Z9NenEvDsAKOvNN/RF3fNtVWc4QyVKuOSLzqSmYvUZu3ki0IVkUKLXPhnq3+murQ3nFj1WgtTSFYXkM9jKPHmemYyUhNBwo7LxC1XXzswzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mqagKaOD2FzanfsDqXt527ZaLmnQb9ebXdDK3teFHVM=;
 b=UUdK1mGqL8XhekkcW44XWnZLoKxHxCDCt7n/N1JN/FE07klkoJl+ul2EP0gNIqK7wL/vB5v3XC7316fDbtfdV3YKFz8E7jnJhipobhQPuCglepOg2OdpajyPYOfltsfkTfZLOvZFCoXRQ/pKAqBjzGN4TqmeJR8p584v/wfrhRuqEQRbnf8SdtNv6+kkcVGaJpD3gxnMIG1mxCZ+4mwzrK86ztpeQqE7GuKZRlx9oTJFWJ/jQxR8Mu/2SjmbPS76c2vYRH0UaRI99PWQtDUmvj3CusXx2SQc2yxXSSPbnyBkSDfVMOIp+JS7rhDGnvArVePZ/tk7esnm/7lgo2dyJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Tue, 11 Jan
 2022 07:41:33 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::8496:16fd:65c5:4af7]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::8496:16fd:65c5:4af7%4]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 07:41:33 +0000
Message-ID: <2f400a3b-d58b-9bd4-df8f-eb3de06ade2a@nvidia.com>
Date:   Mon, 10 Jan 2022 23:41:31 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v2 25/28] gup: Convert compound_next() to gup_folio_next()
Content-Language: en-US
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Cc:     Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
References: <20220110042406.499429-1-willy@infradead.org>
 <20220110042406.499429-26-willy@infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220110042406.499429-26-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0045.namprd07.prod.outlook.com
 (2603:10b6:a03:60::22) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9578cb91-0bbb-4908-9888-08d9d4d5ca0e
X-MS-TrafficTypeDiagnostic: BY5PR12MB4115:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB411530979E69908C82470D6FA8519@BY5PR12MB4115.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yhIT1X6mouz0L+3veWzV9+J4IL+OHSTBN/dW26TsuMfNuaP613wRnhQX/aRBUO56Za8tioxmEGWfxzAYh3MqALROGtK2mJLy8qrZpUTbEhVAHpxVgdyuaamGJRBhrXDPz86WvVMwHXML+aHwFLjjFRjk52fHTXoWmYwOD68DRqKDJ1TXe+HmgQXFaSwtQ164s5+AtJXAjdv+v8O1iRecsaaA3ZTxUemWTWJcCmQBl8vXNyzlNV8ISx77hGRmMY2d6g6TkJePYEjfwn18z0+/NlorqaeG3ZXct2uedWqTyFmQ1Jy0mqFk6ESb42JI2lTXI+7IkVn3cE3D7PJPJ53eC3o9dTdWBtUElZLx5M1YqTsj2QVxt1KQolobn/vDP+uIKEUnvZlj0AmC0VpGXaN8gZywKggrf7ynX3T+/a+yd6ROj18NujJAfchH/B78A2hFWJ3WGJ1Hs5ops+qoBMHEv0srXMJUErPKGGjhMVsELf9GIDFOLDu7bs1kfmRlIL85L1s8HvIYqOAbGDrSSaXF7i0kuB2W0EgzFdx681IMpmIyDUhusIo3AInCe4ZJawoCNg2Edln6oEb1wA6liRTikpTHvC4j8gcQQ22pPwJFspni3Q0N1gvsBoxSKVaZERsZ7Z8kET9P/+O5KR1AmmJuKZSO22S4cJRW6AxQJsBKSGniDrEP0LD4j+GvKJvcJ7styFLJKU5xF3M44HxyCvbuPqhTyDnAteAPforieYzILc0MlyNRTfGCp29Jrv0VIXKF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(26005)(8676002)(38100700002)(53546011)(31696002)(6506007)(186003)(83380400001)(66946007)(6512007)(31686004)(66556008)(2616005)(316002)(6486002)(66476007)(2906002)(54906003)(508600001)(5660300002)(86362001)(4326008)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWdYNnBjRTE5M2hjNU55YkZ3cEttMTdrdG16Rld6SWdsVjFPclpuMko1T3k5?=
 =?utf-8?B?ZUtkZDQ2aWUwY0I2OWhQRktSMlBmNFVXblhUU3pNK1FMSmxFaHlxSnVKZFdC?=
 =?utf-8?B?Zk91WTYydkhvcjM1N1BJV0JFS296RTd3UjdBakJYOHVsVGo3eXoyUXR5UVp4?=
 =?utf-8?B?cU5EU2s0ODEyNlROM2w3amR0SGlGRFllV3ViVFl3LzAwVUdMelRHeHp3a2NF?=
 =?utf-8?B?cDRlRG0zMzFVSUQ5K0llVktpOW5BdXRDNHdvdVFhKzJuVWZyUmlrUmhnTmtN?=
 =?utf-8?B?MzJGOWo5dDZyNlpGMU56c2JYTmFYMllydnU5RDlkUUNnOWYyZTYzaGFDQTVk?=
 =?utf-8?B?VlFFQXhaUmxHc3p4aFJtOWdUNnBURUhtODZlYWJjZmc2Q3h1YnNMUG1zM05q?=
 =?utf-8?B?aUJXYTN0QXVXcXdoWFFHRVlCeHM0T2dhZExJL1ZVQjhSRVd4Zi91UGtyelNr?=
 =?utf-8?B?SFZYNTJlNU44bUwycGcxODFTUmtPbVBkTjI0M3J1Njc5cUphdUlzYzVRNVRZ?=
 =?utf-8?B?TkV6Mk0wbWlWT2N5VUxyMHIzb2ZDWEtwTmN4YU5OSzZ5cDgvbDdFbFg4TG9u?=
 =?utf-8?B?bXRnMnFUZHlxbXBKS293RGd5ZENLbGI0MlZad2dHQm9NWDRwcXpxdld5cEZR?=
 =?utf-8?B?dFdrM21ubUh5akpxOFh1UlpZNG1oeGc2Vk5raHl6UFZkQVE3WTYyV3RlMUZN?=
 =?utf-8?B?M1dVQmJXK3dTVTUzMnh5ZDVNbG1EakU0RWloa0g1VGFobjAvMVpQczR6cmZS?=
 =?utf-8?B?MnlNMGtoOGNiUU0xVWdrTStoZ1VwQ2tlc3pablJuL056N1R3SWJ4RE4zVWNP?=
 =?utf-8?B?WFg5Y0oyNWdSSDJmZXNGVnhoUDNkUTZsRUs1ZlQxaHJrK056aE5hdUF6UWsv?=
 =?utf-8?B?dDlFVGZzbXUvZllxSDdEY0ZNWkhkMlg5SDhoL2hmY2s5eDV2WkJiMndzUDlz?=
 =?utf-8?B?YVpzdmM2ekNvOUx2b1R5ZnFFVWVVb0tHSm5EMHlJbi9kWGFUL1BrT2xMRzlp?=
 =?utf-8?B?TnM3L0RGSnZYVzdNNnY4c3J1TmZNcW9jSHlCZEl3eEZpemtEQVVTUGNxby9t?=
 =?utf-8?B?QnhUOVg1QTB3QXZHVjRMcEx1S0ZlRldXclZZZEZUYTVEUGx0M0lzK1pWbzJq?=
 =?utf-8?B?OHVRRWZkMmViTlVKYlhFamhheE9PTGFqQjYyL2VuMjE4RjF4MGs5dmFYbThK?=
 =?utf-8?B?R1gxbS9xOXNNS1c0ZW5xLzBwSUU1dkV1eFAreUVvUWZaQlpWNjByaHBNdE1W?=
 =?utf-8?B?TTAwNTN0cEYzaXhlV1RGaXJ4UFh4WUw5enhyRFd5UFo1Vm16YjdLWHdTaDVE?=
 =?utf-8?B?N3l6OGwzeEh1OGNJMWJMSVF0QTBOcGNPNGVFUDh4MWdLMnVVMmVUNTVpOUp3?=
 =?utf-8?B?WGFwUE4zZ0F0bkxyZ3Qxb0IvQzc4ejgxeEpLK2FPSDdTMlA3WTFadTBpdHlM?=
 =?utf-8?B?Y0pldU1ZWjQ3NDg3OTdtaDFMcVJSYUkvejVPK1puMDhoK2pjbDhXb2FpelVr?=
 =?utf-8?B?a3pnRWRsc0pwMXNqdCtJQ2pTaGlWOXlEVDJIUXRzRDFUb0RVSnJvOFZQd3Bu?=
 =?utf-8?B?QjZjWk5vSGc2TWxGTjJWWlh2UHF0USt2K0RVWThhcWJScUJMR0pWTmVFOGRk?=
 =?utf-8?B?UjhqTXdoR2tGS1BJZlI0NUx6cmpRZm9jaXpSZmhaQis5Q1VPV2luMDJvcUp2?=
 =?utf-8?B?MWhLN0I1TGpqN2FJS1NQYWRzMDc5dlZ5ak9hUG1mR3B4MDd1Tm9XdHJIdXZq?=
 =?utf-8?B?RURsdzNKaXcvOTRVWkFnTUpyckpOTmE4YktlUFdUdXhlZy80dkhmTkxaYnNT?=
 =?utf-8?B?S3AwKzBUZUhtYmpJaTJ4VjlCcFFKNlNzSFJNVFg4NGlWYmNGUFVYZ1Fhb3dM?=
 =?utf-8?B?ellVVldPcTJ3b1FnNlpITzNTTXU0U3Y4c3Izb0NvNlhKTXNsaC9KNDFIa1F0?=
 =?utf-8?B?LzBWbW1mdUxsbURTSzkvZkRDZk42L2ZEa3dpc08ya29zTStZc0V2azhDMHFI?=
 =?utf-8?B?YXBSMDRsNDZOYmhMRElHTVd6V1R5NUkzTnZUbWpTSjRXVzNrZEkrNnl5czAw?=
 =?utf-8?B?dlRLVTNWQVlSM3FGQkdFc1VSYitmVVAwSENTRzRSalRNRmkrdUcwdXd4SGhr?=
 =?utf-8?B?R1YvSGp1MWMzNm05Y2kwUWU3WURtckwrcGxMWFcrbDFZcXVDMkI0cjBJSlo4?=
 =?utf-8?Q?y1PFsUL10fxzxHbTfrdvtTA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9578cb91-0bbb-4908-9888-08d9d4d5ca0e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 07:41:33.3961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eTZSVZ0zhXY5GpHcpS8o9MY3+3xaTSoNxWD4B6ZAuA2whb/X0fuHizMiXAiy99xx4nLKDmxRc0SlOXKde5yNng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4115
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/22 20:24, Matthew Wilcox (Oracle) wrote:
> Convert both callers to work on folios instead of pages.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   mm/gup.c | 41 ++++++++++++++++++++++-------------------
>   1 file changed, 22 insertions(+), 19 deletions(-)

Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard
NVIDIA

> 
> diff --git a/mm/gup.c b/mm/gup.c
> index b5786e83c418..0cf2d5fd8d2d 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -220,20 +220,20 @@ static inline struct page *compound_range_next(unsigned long i,
>   	return page;
>   }
>   
> -static inline struct page *compound_next(unsigned long i,
> +static inline struct folio *gup_folio_next(unsigned long i,
>   		unsigned long npages, struct page **list, unsigned int *ntails)
>   {
> -	struct page *page;
> +	struct folio *folio;
>   	unsigned int nr;
>   
> -	page = compound_head(list[i]);
> +	folio = page_folio(list[i]);
>   	for (nr = i + 1; nr < npages; nr++) {
> -		if (compound_head(list[nr]) != page)
> +		if (page_folio(list[nr]) != folio)
>   			break;
>   	}
>   
>   	*ntails = nr - i;
> -	return page;
> +	return folio;
>   }
>   
>   /**
> @@ -261,17 +261,17 @@ static inline struct page *compound_next(unsigned long i,
>   void unpin_user_pages_dirty_lock(struct page **pages, unsigned long npages,
>   				 bool make_dirty)
>   {
> -	unsigned long index;
> -	struct page *head;
> -	unsigned int ntails;
> +	unsigned long i;
> +	struct folio *folio;
> +	unsigned int nr;
>   
>   	if (!make_dirty) {
>   		unpin_user_pages(pages, npages);
>   		return;
>   	}
>   
> -	for (index = 0; index < npages; index += ntails) {
> -		head = compound_next(index, npages, pages, &ntails);
> +	for (i = 0; i < npages; i += nr) {
> +		folio = gup_folio_next(i, npages, pages, &nr);
>   		/*
>   		 * Checking PageDirty at this point may race with
>   		 * clear_page_dirty_for_io(), but that's OK. Two key
> @@ -292,9 +292,12 @@ void unpin_user_pages_dirty_lock(struct page **pages, unsigned long npages,
>   		 * written back, so it gets written back again in the
>   		 * next writeback cycle. This is harmless.
>   		 */
> -		if (!PageDirty(head))
> -			set_page_dirty_lock(head);
> -		put_compound_head(head, ntails, FOLL_PIN);
> +		if (!folio_test_dirty(folio)) {
> +			folio_lock(folio);
> +			folio_mark_dirty(folio);
> +			folio_unlock(folio);
> +		}
> +		gup_put_folio(folio, nr, FOLL_PIN);
>   	}
>   }
>   EXPORT_SYMBOL(unpin_user_pages_dirty_lock);
> @@ -347,9 +350,9 @@ EXPORT_SYMBOL(unpin_user_page_range_dirty_lock);
>    */
>   void unpin_user_pages(struct page **pages, unsigned long npages)
>   {
> -	unsigned long index;
> -	struct page *head;
> -	unsigned int ntails;
> +	unsigned long i;
> +	struct folio *folio;
> +	unsigned int nr;
>   
>   	/*
>   	 * If this WARN_ON() fires, then the system *might* be leaking pages (by
> @@ -359,9 +362,9 @@ void unpin_user_pages(struct page **pages, unsigned long npages)
>   	if (WARN_ON(IS_ERR_VALUE(npages)))
>   		return;
>   
> -	for (index = 0; index < npages; index += ntails) {
> -		head = compound_next(index, npages, pages, &ntails);
> -		put_compound_head(head, ntails, FOLL_PIN);
> +	for (i = 0; i < npages; i += nr) {
> +		folio = gup_folio_next(i, npages, pages, &nr);
> +		gup_put_folio(folio, nr, FOLL_PIN);
>   	}
>   }
>   EXPORT_SYMBOL(unpin_user_pages);

