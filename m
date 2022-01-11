Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 422BA48A6C4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 05:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347791AbiAKEWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 23:22:16 -0500
Received: from mail-dm6nam12on2078.outbound.protection.outlook.com ([40.107.243.78]:53344
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229687AbiAKEWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 23:22:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eEl6QkU7zgf8jLdq7RZ0xIRLVZzQ/ozMyy72XdsomMm0RRKIOv9AP37tIhvYrwHrtCjXUMPNGr9C5zP0S1ijLQsFOUhfGCf2dfnFpFihOzpA/AKH7gSCD0t/IfG492INhsdJBk1ndYmRXQRwxPcfl1ZVKocwhAFNyIoRPBNDk/88pCV14e6stPQjIcxaLrSgBaZ2swAnOSQ2+rNT86EzGccyDwCp6HOpkF4onYveHfXnPV4huvv4a+YtTHq61X/lCv4i/HjDjxtzcSRjopFK+N20BBDTPhdm4ZfiPHBRAgtNoRKXuE8oHAfjo1IQpfbxUsV5lEZO/SYZemV271qxbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=449iKoL0c6wdLFwGHayRhCT36fmy1UZ7s9gp9L0qUSA=;
 b=JBrPyvrtNnm41XGXhGQ48KTpXILRpTEuBANdbFzHn9UM+vh5/93fockQ0EtVpH7Womzl6uy/CFkxb04mRdMcBF7gz1vDQLjxlbJpuSgv5ntJU8Kxs/AULHJSLpvqqAir8Ig2tpYsaSxsu4ByiLYmciOiGwyWFLHOgDR+1IyeJT5NUH7W8/58mOBtyMigTTuYdEUrkYWQfaDe0COeJZx0LP7Bt99ELTtcrzjecCCfGAs/gajcGcdLvGM+RRKmSnLOgMNmYSdcxAil6trovCD3tFC+jDTFCLmW1B6Btg8Dw+G0JM0Yevg0UmRJDO24pZm1YVxwLJifkN/MiK68pLh8XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=449iKoL0c6wdLFwGHayRhCT36fmy1UZ7s9gp9L0qUSA=;
 b=j+VRI28boUIVnBSN5/28/9DTRNswe4TufT20FrNJyQlgrg4rGj8euTWUJYV13kPA2U/LE+YkgMv/EX+jK74Lvf7KV8Mb6VUELMy5NMF4cD1aqvqZKMFhBbF+uzLmYBXkHd9nfrjhaZ2v556SsAvW1tVcgI2N/bZSNYk5E84+k+Y9EOwwdDr8rwYEF3TaKTY4K1iB6BN7egHPFf8tTJdtEurBh73PBM5mebOnGXHzjbPKHUVvkeFlSnJBNYSQOK+5mUQwZfOOCKOd5iQrJ388EkoLOY3vRRgkmh6CK7BOtHJXArNiaB3SV1rf/S/15fTrhCXBRLr9LwxGNmgt0bju7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BYAPR12MB2790.namprd12.prod.outlook.com (2603:10b6:a03:69::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Tue, 11 Jan
 2022 04:22:12 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::8496:16fd:65c5:4af7]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::8496:16fd:65c5:4af7%4]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 04:22:12 +0000
Message-ID: <19c12ef2-f0ab-1b17-ff77-a448a4636639@nvidia.com>
Date:   Mon, 10 Jan 2022 20:22:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v2 13/28] mm: Add folio_pincount_ptr()
Content-Language: en-US
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Cc:     Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
References: <20220110042406.499429-1-willy@infradead.org>
 <20220110042406.499429-14-willy@infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220110042406.499429-14-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0151.namprd05.prod.outlook.com
 (2603:10b6:a03:339::6) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07f300ec-4bdd-4412-3025-08d9d4b9f07b
X-MS-TrafficTypeDiagnostic: BYAPR12MB2790:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB27902ED0681BE4C8CD99ADE7A8519@BYAPR12MB2790.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G6zsphn0nlxysgcD8/9qXnygSyy4F3z8wncWw0a+BAfltQ/jdnNFoD4/ggBrdtcmAEJkgABe4ru6UzQWV4M09o+xew3g7zB7CWg25Ie4hXdOnYbp1nB3eZL95BZ5EWFZyK+rNz5M+07daLaYPb5zLBULSvqrHycnb+Snlo0x9Qnevqry+qxvMKxMKzSlvJId+q5GjLsbtVWfn4X760bhqwL3WKQKYwJ3WFKybvQpmVLbvL324uj0pH1zS7JTdvt6/IftynrSnmhnWIunbKksT/HJTlTohcRdB5z54vyrKdH91T3awq85fMhVZA7NFwDxZK1gXtBTxPGgsQBe6geQl2kQctOH4pR3YZ65AKPZnOI8WdyotFv/O+DBHvNE2ZuN8od7Nei8jhR3UIUj+WmhfD6bA79Tkp0qj/8wSbgcEoZEvUubiAjgn8NGPaL0SwB0HiXw8zque92YDKdDXAt6hI52c04zeQDwjIA+yTUGt7Z5BBYc8coM3XfHn5fSqNMfw797XXLXSK9OgOjEVPEXdM+seeTIs9AX7ivepJbPU6uX+VR46gPHoFFF23uNkMdC0YZqUJs8kjqB7q3SSM0Ia7rymETCqNf0uPe4DLI7VgW/3ErQsJHFOI5ixMWGjptRGkpQAQrL0Psp6MExoNJHrx2XO0I5rYd2gIw5IDVu1nKPr04rtcAUQYA7xbyrF3hx7jXqN091Hs2Uj3EreKcmn80gCt6/3K3LBofKNFZiXE0B7E/MEHYuDpUru+ZymOwh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(86362001)(6506007)(53546011)(8936002)(31696002)(26005)(66476007)(508600001)(316002)(31686004)(5660300002)(36756003)(66556008)(6512007)(2906002)(8676002)(6486002)(54906003)(2616005)(66946007)(186003)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjU3NDkvbDdhbmdWaDQyZ1E5ZTJDUFJsMnd2WFQ2Z3c5MXBFdjM3TU9qaE5N?=
 =?utf-8?B?UUtrdEtJenpFbGpTaytYWC96djQ4MjliVDdhdTl3Z2oxR0Y2czZHTitjTENM?=
 =?utf-8?B?eVZ3YXdVdXBWNzRMaWRWa3NDbUR6UWxpRnh4YktIcUFpdFRMT29SbThzaVM1?=
 =?utf-8?B?K3NGSWx0UE9oS2xFV3QrREZrRk1JZFFzWGpxQlZMZlB0WXl4bThnZ2JVWk42?=
 =?utf-8?B?MVY1OExIR0VvMkhGcFViVkU4cjJtdFdhSGZOWFhmNFhiY2U4eGVmc0oxblYw?=
 =?utf-8?B?TytaeGFyZ3JLb1hwZDJPOWhrMjZmODJrOEtTaTlFM2IvbTludFpVWTNBbDZU?=
 =?utf-8?B?MVBXcW5OZHJlaUdESzQrTVRNUlBxSWdTLzVxbTdmWjBWR3gyQndVTGNvWS9x?=
 =?utf-8?B?UlplS0tlL2Y4cWpkK1puMFp2Lzh5UzdPYXpjZG5zbVBGK0VHaXJPSldOL0ov?=
 =?utf-8?B?Wk5sMzBrdXlEOEFPNHpsNGp5Sis4UytYN0xlZFIxOXFJdHJvSG45dXQ1OXRv?=
 =?utf-8?B?Q3RybWUxazNnOFFWRkNCbEt3eHdrNkpwbWkxTk1ObncveGFpM2MzYzdZNHY0?=
 =?utf-8?B?allCY2RrSTl4eUh6ZFFqemJveXJjc2VYeW4veWdYdGZJNUhhRmQ1VE4xdW1Z?=
 =?utf-8?B?SFZzVHJkWDlsOWI4UDhNcjFTdEVONXZ1aXdxSjVxYXlNaG42dmY1L2lxR2ll?=
 =?utf-8?B?YVg5U1IwdVl1Q1UyTnBISmtkUTB6UTVZRVVXUVVFUW90dVBraks3aWtwNkxP?=
 =?utf-8?B?bGhEWVdybTR0allzYTFhTGVXSWV3cTdLZHRNNDRqUUw5aXRiRVV2dVE3OWtZ?=
 =?utf-8?B?UDV3N3htOTI3Qm0rN2wxU0hOVHRPUklWRm5KSzFzYTZlbGdrV1U4UVR6WHpI?=
 =?utf-8?B?enBRTzhMeklnbjB4eG9CT0Q3RVo4WFU5OTYyM1RPRS9BcjYveVJHaHk2MFUv?=
 =?utf-8?B?TXZwVWV6MzdCak5lNDdTVjNPazVCS2ZkTEhURE85ZlVsQTI4dGpBWnVRbUZ2?=
 =?utf-8?B?RmZHWm11OFlhVjBYZlQ4eURuc1pEL3lUT3RTZ1VuZy8wZE4vbFRDak1KaDU5?=
 =?utf-8?B?ZnNaRnFKZHNKbGhKYk9yM0JjRWJydHZ2bmhYSFVBN3lGN2ZBbFZaQzRhZmhF?=
 =?utf-8?B?WlNwMzlYb2ZuOVYyMGFtbDNvUkVHcSsrdnA3ZmtJVzZEYnZYVHpsamNvNkly?=
 =?utf-8?B?UndlUER2YXlROGMxRHNkN0VPMGlaMTl1RUJmTS9iZXc2bkcxdTVxaWNvemMr?=
 =?utf-8?B?aE5mNmdhTGpHQ1RZTDJTcEVFL2pTTjFWUkhQVGtnTDk4T2pZNTNCYmk4SDRs?=
 =?utf-8?B?UGNUSGRpRDRoZzUzL0hYRkhvS05vaStmaVlVc1J1Ykl3RVhJQU9XMmgvc3Js?=
 =?utf-8?B?d2kzYWR5MnZkdU1DYk1WbE9wcTE3SjlLSlR6cHVKL3ZkZFdtUCtDc0ZodjI4?=
 =?utf-8?B?NkhibVVDNy9JT1loQklMZFRucFBGOHhsU3VIdStwWUhDQThtUHZzRWRLbnZY?=
 =?utf-8?B?aHBlQ0xqRXZOSTRvaURKa1RGM01iMjFDaHBsWHZTR1RwNUZZNlg0V1NlSFVu?=
 =?utf-8?B?VTNFWEJkZk15RnZ0bkxIRGo2K1ZuUFdUelc2ano3MzFaNStRME1scFN1MVM1?=
 =?utf-8?B?Y3JxQkdsbzA4eFh2Z2k3ZE91c1FheFZKcWtteWxaa2JzajNDOUJzcCtqWlBK?=
 =?utf-8?B?clFLb2JuejJ4ZWhyWjZIcVZZYlBDTER4OHpZOGd5K0daV0pmb21KR3JXSU4z?=
 =?utf-8?B?MXhwOTc0dnZhSGd3S0dzenMwc04wNE8xZUN0bXhHakk5KzhpbHRhdVA3Ykgr?=
 =?utf-8?B?SVpja3kvdWIxbEZjbXNjSExIUXJkZ0tTcll6RjcxSjgyeVMwRFVianRjQkFC?=
 =?utf-8?B?dzVZMmdSbGlBRkFWcm1pWVhrWTdXM0xWdUFMTkZXUXVaZnZkUG9JbURpZzlM?=
 =?utf-8?B?Q1doOTRaSURibWJDWmhlcFkyOW5icHdidDdSVUZMZ2tINFMzQzhQMktvZ0gr?=
 =?utf-8?B?ck1jRHR4SzZJSlFrWFpKZEViYmZ2MWQzd1JEZGl5VTBNN1JSWUxHZjlxYlhY?=
 =?utf-8?B?QkpiekdTMHIwSlNFaTBPeTZ1Vi81eWY3Q0cwazRaSFE5VWQ5NUtKL1FPYWww?=
 =?utf-8?B?djAxUVNTZjJoL1JXeUdqZ0h2MmdqQ0xhVUVLbzB1bHZ6WmJQaUZmbEFYYnFr?=
 =?utf-8?Q?kH0AQu1GJ2u9x9rylqySTyA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07f300ec-4bdd-4412-3025-08d9d4b9f07b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 04:22:11.9684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZN+0l+UakJteP+knrvVCfPy/nHnrDXmkbyfi5VVLAOmVFR1P86hVF/vOHYpLJVlR9KQ0wjSN0Nl9L/zsNDztZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2790
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/22 20:23, Matthew Wilcox (Oracle) wrote:
> This is the folio equivalent of compound_pincount_ptr().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   include/linux/mm_types.h | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 60e4595eaf63..34c7114ea9e9 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -312,6 +312,12 @@ static inline atomic_t *compound_mapcount_ptr(struct page *page)
>   	return &page[1].compound_mapcount;
>   }
>   
> +static inline atomic_t *folio_pincount_ptr(struct folio *folio)
> +{
> +	struct page *tail = &folio->page + 1;
> +	return &tail->compound_pincount;
> +}
> +

Should we make this code (the various folio map/pin count inline
functions) more uniform? I see that you prefer "+1" over page[1], sure,
but having a mix seems like it's trying to call out a difference for
which the reader would search in vain. :)

After the whole series is applied, this area ends up with a 50/50 mix of the
two.

Or am I overlooking something, and they really *should* look different?


Just a very minor point, so either way,

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard
NVIDIA

>   static inline atomic_t *compound_pincount_ptr(struct page *page)
>   {
>   	return &page[1].compound_pincount;
