Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09A6F48A4B6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 02:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346091AbiAKBHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 20:07:18 -0500
Received: from mail-bn8nam08on2069.outbound.protection.outlook.com ([40.107.100.69]:23745
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243225AbiAKBHR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 20:07:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SsN7OXTewWzsWrfUbQl0gC2XU22LM6Iykuun2mPXgiFNJ6qSTw+NdmTSzEU+83NnG9JhN/f1E9IYR2XyivsjoZ1R489V/gbqzDazPcU3rOsFA0aBe3XyUnzmrX0MpoT9J17t/VltTjPnrLje0AGMkxQDRt3VH5FQijljhq/8ADZYln1K6bHlj9cjdVkFx+xg8UbT7eEEK3Lqhz4YHfdwrAOpH70DaaRHkJyaepMWx/aOgCWzIn9N5t+zi1s4OePC9nMe7Dw4lL19ClBSKTNrpIyhkHh82PcVitA5OF/fUUhVdgkf5e7LjW6OZk/2MyhDsS0Qq9dkkyOhfhrg78rbgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EuP90IgeZ1n4FYplgBEOtdL3SZh9pdYN4W8ftPnToYQ=;
 b=DaTfCEa24Kk58bfnhhK6NivC5393SCmXrGyeJH9VEawJ3BGi0Jb9Pm3xuiXR2KkxNbl/SApeE6GPpik/ikS+RctGm7Ojxd0qKPUpIdN3Nfe97e/k8ahExOByZtSmbZ1TleAultoJ62N+gw3UPDNOafuECcrMZqqWNlyqkQ/M1r8mEOQ4ZOH8JPtxKdMlCsjzBK5Q4mGxCjxfI0AnzDBcS7TBLdFpZZbcwq7Q/VnRQi4651tLg1oy7+HpXtkvrR9SNLbFw3DbNmsT3yom3qk/5P691hP+1kYU1PoBfAo+puRI4Ow2kFhzXpQXBASBgUHFgtjps81R2klHS+MnYbdzAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EuP90IgeZ1n4FYplgBEOtdL3SZh9pdYN4W8ftPnToYQ=;
 b=r+6FbovBWE+5d/U+1z9e7O+RUQ1JCuVUWXGtG5DAuS251Tkv7TMofJc9lDcBf8JyImHo1vfu6fza/46e5lyn1GevYnhQV7XWRGdJ4/R3+flDXzQUXJs2yNTxQlDk4zYWtnwB2vK1SZ3X2YU8pu0sUIUMFGfk86171JJGg4GCvVU3WaWRTQ71AvhCvoiTVfS2dMKHX7QOTkJrJ2yq61NpenAyUtURRzVTaBXrK2nZMQeSSZNAFc3PVayQJYH5I1ZEGgSYR+CBqhWn/Uqc5pnZ5HK//2Ha85lVck1wZ7wgCAtfH7skGBYICDY8c0mcXZv0ZV0LoH89TBSmmiAej+XteA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BY5PR12MB3778.namprd12.prod.outlook.com (2603:10b6:a03:1a6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Tue, 11 Jan
 2022 01:07:14 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::8496:16fd:65c5:4af7]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::8496:16fd:65c5:4af7%4]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 01:07:14 +0000
Message-ID: <5de5e884-417b-a884-d1b4-55f6892fad8b@nvidia.com>
Date:   Mon, 10 Jan 2022 17:07:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v2 01/28] gup: Remove for_each_compound_range()
Content-Language: en-US
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Cc:     Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
References: <20220110042406.499429-1-willy@infradead.org>
 <20220110042406.499429-2-willy@infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220110042406.499429-2-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::25) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ae71d02-6c7c-4e7a-51d8-08d9d49eb437
X-MS-TrafficTypeDiagnostic: BY5PR12MB3778:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB3778A5D7A22F83532E65AC41A8519@BY5PR12MB3778.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:862;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rh3PC2qA725Rq+7Ez4DWW4vn7/8FI1Z13LIKhUiwtDh1uH4EgIungi6GeaW8Zn+CwOVYL/zEXVascHJdPdarjeHijgz+EGntKjCP9usr5UmQebcKPOWzyEXRs7/WNywVTLOYFJpSofepHTkVjnEJxKG78g++V14hqdA0SVEXWwkXrDMGUSGH3BwkwBnVxKNvpne9r11q7BoFlj26PN7omi50qELLLS0x8Ud5jlZ6LynT4oNrtb3vkqlDFXqIBS9PrIdFvXP+bL++jGyTnmbD9iBeJJnS1IZbzl4kC8EP23LvpAUJRAx9212oM/ZryKwcPnpxlTmvWbURDh8fCbPqdsJuHZH35LkrKKNktOeAJT+hIWb3x5s6c89x7NsnRsMhQJ41HkVuN+3Tkh17JFjn9DajWSBBPQw2IiT8tV733vr+a8fM/Acnt1sjj7O42VZNYLwjDfI25iC+5XZh4f7hWcEh6KuS30QaWX9/QgEkTGIcHopI8RDlQZ1tCMNQFvfqA1P4WAn1YiQYUGHcArDuE3zvIlvnpV/RoKJBY30JecsqKmhV3NenjIN0U+eMQs1dR5+zFehvJW4NKTmOVWj6sfTwXGJ/fx+a6HB/gc3AqwdSAK4E566IWTC0z41cs4PgrWVhZZ6otgzsWv7Ob6XXThlsdHj21novj369ljYU2Td4OFSYA0NXYHN7gydSKdaSre4LylwmEtvbMJYSY9YeibV/TEIMU7/5iQ4S2LETS91zgwyKLfRuq4fEFVjK4Kvf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(316002)(8936002)(38100700002)(8676002)(5660300002)(31696002)(186003)(66556008)(66946007)(66476007)(2616005)(53546011)(6506007)(26005)(4326008)(54906003)(6486002)(6512007)(2906002)(86362001)(31686004)(36756003)(508600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0lvSEZtK0I0YXF4dWMwUEFkOEloUWZFajBDSTk4WjIzSEIrQUtXQkJneHZR?=
 =?utf-8?B?OHVQMXB4S3VhZHAxY3BhZVJQT1RyeFFvTm1uTmlQQXlMUXhsbU1NbEZCNitm?=
 =?utf-8?B?UW1HSml5NXBERkxWVjBxY3NCenZPbEdUaW8rQjQrRVgzY01uWVJwU2F4clJM?=
 =?utf-8?B?UGpxRWl2Sm9mU2lQdjBHZU4zT0pnMWdkU2hpOHdWUWU0eFU4TWw5b1k0bVE2?=
 =?utf-8?B?NU43T1ZyUDZmOWdkUVZqR1d4M1B4YnZOS29ldnlna3ZjL1ZkUEtkY2xxU1R3?=
 =?utf-8?B?RzF2b2QzNnNUZUNKSUdJelFrUDFtdzFtYmpidWlhTFZIVVBWR0V4RlIrc2tT?=
 =?utf-8?B?blc2UC9DdG1vMXpNMThDejAzZk9xaGRWR2c2TitxMnJ1VUMvOS9rNzJ5NnVI?=
 =?utf-8?B?c2pNUGFnblFSZWpqa0JycFFoQjMwWUZ2eW1BdjNCa3pnRVRVaEV2UTVRWEZx?=
 =?utf-8?B?YXNpV2ZLMnZoSHBia0lKWjNuTE1IcEE4UXBSbDN6ZFA4TzVycDRQUm1SYjFw?=
 =?utf-8?B?R2FwazI2WWJjb0thejUzNENhL1l5WUd2TXppM2FYUFpHT2tic2kwUjVKV1Ar?=
 =?utf-8?B?UUY4bi9tazU1akg5czBlY2lQMHlZRFNwek9UYzlCYTJNTm00ZzQrQXQ1bU45?=
 =?utf-8?B?U2FWOURySjNhWDRidnBrRnVVVUtQUDV2YTVXNmZvYjR4TmF3TCtIdlVERkIr?=
 =?utf-8?B?NjhKWkJ4NTZPL3ArVFI4OEdPMnZsSUlxcnRzU3puYlViNEFQNWN6Yyt0L3NO?=
 =?utf-8?B?blp0Tnd3MlRLZW1QTmM5cnUvVWVHMHcvaWszanJ0VktJUE8xbU4vUHVGZ2V0?=
 =?utf-8?B?MVp4Y0dLdmdyUllmcmNpVWNaTWRoNGV3dW5OaS90UEZxMHdmREFwRnAyVVUz?=
 =?utf-8?B?R2pqVEVCTjdHRW9SWGt3ZmRqUEg3NG1MTTk2V3BZK002T1FHcWZ0dFVmZTRV?=
 =?utf-8?B?K1VXYk9LcDJsZGJlNFlpVWJ0WnA4YjZzekd0a1hFL296MFNSN3cvTXIrUEJx?=
 =?utf-8?B?N1RCU0NacDIzQ1gxdkFhbE9tSVVKVXNEYS80cHpsZjl6VVFZWjNRM1k5bGJS?=
 =?utf-8?B?VlN0ZHZhM1MxT2puZExVS0p6amk5b3ZoTy9GeVlNRFM2NlY0bk9BalU1bUJY?=
 =?utf-8?B?S0NQYkcxaTc4NmdGVFdCQTdDOXkycFdtWXFvSVJ2UHgySmNqMEJwSTBicnhu?=
 =?utf-8?B?c2U1dHhCNU9XWXM0TUZPcEQyTEkwb1J6bUZ0U1J4aXpNcWxBU29HSEdEQjBu?=
 =?utf-8?B?azc2TGtNQ3B3Vm05azl0V0tObkZYdU9GQVhzTjZLbld4M04zMFlHeS9FeVRw?=
 =?utf-8?B?RXJRZHpJUHlCNThaSlBabm9uSnFaeHdLNWpkWkVJTzJuTlkrR3dFeURpNkdK?=
 =?utf-8?B?WW5EVTg5bGtXODJWcUZHRDZzN2p2STdidnIvYjNDSTZsTE9MeGw4SzQ1ZGlU?=
 =?utf-8?B?RzlzT0NrTVVUYnIrbURhOEVEVE0vd080Qk0rNGNmWnFwR2hwYVVUTGZlelFs?=
 =?utf-8?B?cW1xV05RZXc0TFlwOUxOczRNWmJ4ZkxtZFI0bGZuSXFXSzg3MTR0NzJtbVBL?=
 =?utf-8?B?TGUvcVE3dFBhd25FODBhaVJkdmNZTTZvc29oRDFid0dXeWloYmlOYUpSczkr?=
 =?utf-8?B?V2RSQTh1aS9UaG9sV2dNYkZFblF3Y0RtTEcvZ2F5ZFFVL2pjMllaZmZNZVNk?=
 =?utf-8?B?UmozN1AvRm50RFd2MGxZWmkrYWhad2JKLzlCamx1bGN0YlVLS3NGdlNDd3U3?=
 =?utf-8?B?TmxLYitnaTV2VXdTcDJhc1ZNQW44N0tjWmdTQnVZeEFReUh3VEhiRnQ2M1Fs?=
 =?utf-8?B?YVdMYnB3aS9ZbzlCNnlvUkxyN1V5YTVSVElhMGVrejJzaDNWNW5YcnlWemk2?=
 =?utf-8?B?dkxWbDAvTXp3SjBOM3MybGZ0T1k5VHNBUUszeGtFbDFjK29LZlRjNGZyUlFl?=
 =?utf-8?B?TU9zaXVNRFAyYWhKaE1yTXYwbnh4VnJzRGlUT1J4QStVNkYwR1EvOUREbXlM?=
 =?utf-8?B?YzV1YUwrTXM3RkQ0MVNQbHU3MlpWYnBLa2tFU0J2MTFRb2pEWmk3ZithOGx2?=
 =?utf-8?B?WVFERlF5Q0F6cDAyeDBVZ25GaHR5Q3h2N2pTK3NCbyswZ0YvZFRYRWdoTGtS?=
 =?utf-8?B?b3Q0L2E1MEk3MTdsNndBdzRhY092RDVoeEtTNjA0VUF0QjRWeCtDWmpmZHYz?=
 =?utf-8?Q?oFk9vyiiM7cuImt4NVTqMZk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ae71d02-6c7c-4e7a-51d8-08d9d49eb437
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 01:07:14.6062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z08/4KHfRWtnEaHdACSZWxeLhtlG8UjkBewcuLXd4XtlssVTmId+8eJ70Dfu6/GicxrQ1PyuPZJJKEyg0Vputg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3778
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/22 20:23, Matthew Wilcox (Oracle) wrote:
> This macro doesn't simplify the users; it's easier to just call
> compound_range_next() inside the loop.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   mm/gup.c | 12 ++----------
>   1 file changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 2c51e9748a6a..7a07e0c00bf5 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -236,9 +236,6 @@ static inline void compound_range_next(unsigned long i, unsigned long npages,
>   	struct page *next, *page;
>   	unsigned int nr = 1;
>   
> -	if (i >= npages)
> -		return;
> -
>   	next = *list + i;
>   	page = compound_head(next);
>   	if (PageCompound(page) && compound_order(page) >= 1)
> @@ -249,12 +246,6 @@ static inline void compound_range_next(unsigned long i, unsigned long npages,
>   	*ntails = nr;
>   }
>   
> -#define for_each_compound_range(__i, __list, __npages, __head, __ntails) \
> -	for (__i = 0, \
> -	     compound_range_next(__i, __npages, __list, &(__head), &(__ntails)); \
> -	     __i < __npages; __i += __ntails, \
> -	     compound_range_next(__i, __npages, __list, &(__head), &(__ntails)))
> -

Yes!! Thank you.

>   static inline void compound_next(unsigned long i, unsigned long npages,
>   				 struct page **list, struct page **head,
>   				 unsigned int *ntails)
> @@ -371,7 +362,8 @@ void unpin_user_page_range_dirty_lock(struct page *page, unsigned long npages,
>   	struct page *head;
>   	unsigned int ntails;
>   
> -	for_each_compound_range(index, &page, npages, head, ntails) {
> +	for (index = 0; index < npages; index += ntails) {
> +		compound_range_next(index, npages, &page, &head, &ntails);

And now the code is more "honest and up front": items that are changed are
passed by reference, and one can see right here what those are.


>   		if (make_dirty && !PageDirty(head))
>   			set_page_dirty_lock(head);
>   		put_compound_head(head, ntails, FOLL_PIN);

Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard
NVIDIA
