Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B048948A4DC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 02:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346175AbiAKBRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 20:17:01 -0500
Received: from mail-mw2nam08on2080.outbound.protection.outlook.com ([40.107.101.80]:35425
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243319AbiAKBQ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 20:16:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MjIt0t00PutA0GCxtPIc487OfmKtoVMn34iefrEpWaC8mYta7EYdDrhpeplo06CSh7nmrUkVfj5QuuG4oIpEX8UEut9zaz9wpfG9X+IIbFOUjAlwa2Nhge9Gm578pE0EAet5k2ndDQ+ibz0U1MTb4I5Do8qei5qgGjYMVdRLKWud7KZRrYfgsCRD2kyLBYNIhpK6KfLdKmXE5i9FQ3dd/d3ZvJZHuRPVPHrP9RZ4XRtJi5lHdznW+/oJaL05aQteHrtR86rNqKwPoyhmPNQuopB0xYDivBD5jRtJPtF/ioUN2ZLzTHRdVLZSWZNPQpSZ15Veu0x3NZKN3H+ZzUOcaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=829rtBA5dD6qx9SzowUOR6IS2j9jijh2RppU9wF5CRs=;
 b=n9RoTy48rC8SZCXp+2Bt2QDB5NH4qb8B9h0Wk4Bv9M0JC2fQgTgKUd7uidBx4lNrkb8ywAl+kj4leeiMvDyrjj9m2QkUrumnVqoynQ0iqbtvSDQOljUBtrZnTNDIdolpnZ10YpVPp3Wk53DVHNwSGnZM6yTHu1ZbjLJjPowxq/VWjFX47tKNcWsky2s/mhWfdoBHyGt5BhbadsFaSZBNPRoYCTQH0IL8gOlCVMdHNODQghiZQSF0yRUawDsEqYzkJZO3gvHGFXx5aVhJ5983xN9GwKZwV+iD00b63qc2VuJ60/t5F13dQPFjQG+h6SklWabURGR7LkZxg1p7ryBVzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=829rtBA5dD6qx9SzowUOR6IS2j9jijh2RppU9wF5CRs=;
 b=saTB/hAuJE4wqlHN03aFzTG3rNQcA3aky5DXp6euKOYRk8Wxzj63BEpT1gh9+7c3oDuPi0wMM4bJNjMrSRoXeNWldboH1X84JnkbXXVw6zTRGKFhM8dSy7k+klyjxnxemR70+kEeOGroVxPNrycHDCUhJVDGMjAwA/rouNsuvE19xsh+a54OS3nT4zYFOULE55wEZXTJduWacBeB5pkYtV1IXsQhaDeIofoBt/HuDhD6lOAGAYfICTagpmNkyw5W6rmUlAfuZ3cPiV6dRnAYSQqTFV4cpL03WpOmUreHvHTInXcGwjM/lgtFYvYRNV/52gb3HLF47586AA1Tc+iPBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BY5PR12MB3651.namprd12.prod.outlook.com (2603:10b6:a03:1a9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Tue, 11 Jan
 2022 01:16:58 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::8496:16fd:65c5:4af7]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::8496:16fd:65c5:4af7%4]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 01:16:57 +0000
Message-ID: <f1b4823c-87c4-993a-eb52-c91219833ebc@nvidia.com>
Date:   Mon, 10 Jan 2022 17:16:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v2 04/28] gup: Optimise compound_range_next()
Content-Language: en-US
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Cc:     Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
References: <20220110042406.499429-1-willy@infradead.org>
 <20220110042406.499429-5-willy@infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220110042406.499429-5-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0026.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::31) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 479a91af-684d-40f5-3998-08d9d4a00fd1
X-MS-TrafficTypeDiagnostic: BY5PR12MB3651:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB3651F9AB647E08B2FF5AC0FEA8519@BY5PR12MB3651.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:663;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yKHLqsfk6lhvUNv+QS6ubaEE3ToUv3tbgZZA4LubQDZIuWfq+CVjxk+/hl2kukIbUYpvflLxeLPbLMhw7zpeee3QF5OyMtoiIQfEvIjea9NI6AXO0CWxJwJsQXaVD1cmKAVTt+eGiURZRQulaZKGRSpX3+N7peJGUPwhOYQMxEMZER8WsX9L7sLiIxO00SDY+BlQXo/ZPkFwDnvIAWRY6LrFUPGvswY7sMXgP6+fHc1rqxeWJafMWo5xrOyoD8O8gPWqncp/Jo6fX84cmjhvAbZdj7euDiStOnOGRVlB98Pb6gZpiCEpKP5JEEI0pD3Lz+cOK1muTk3iybSDb2vZkVSHPyMlNTaxcF2FexTCFH/+bN1c+K/GJpwuLJYGDrTOgQ/uRLZ6H5JtUO/D8rUH+RmQGIf7/t61NAuSWdEoKg0ncaEVXlafTqwCM5rAvOxjVUony8kRFbUtEmPG2gQoNhi3/RzQtQ5lSu/r1Lt03BhwiKs552A4C55TikAG9xWzH9hDcJNOYs+kngIsIxwWpsNxTD3LKpYsXjwafFwaBiWbDgLR+xkHscl/N//2mR7fnIwaHwZAawSIsrWDpLe9B47OBwbMbRvdA4jsx34cDd+AXNqyh5gsTh4sjtaSyGg6/WtxwYdhapLnaux65Wbxuzljo0Xp+suDvpfwKycF5BPgcRlLoMq2ZnOZSMae93uPn45k3x3D0Srei0cXCLGsCY3YiA+SR6XzG0+DU8eEiNg3OcPVYxWVG6VP9nQQshUL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(38100700002)(6486002)(316002)(31686004)(86362001)(53546011)(8936002)(4744005)(186003)(2906002)(66946007)(26005)(54906003)(36756003)(31696002)(66556008)(83380400001)(66476007)(6506007)(4326008)(6512007)(2616005)(5660300002)(508600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1JGMUtOaGwzQkl1SEZCUEp2eXFxY2xKWnFYYnRDUmkzL0xNUGI5RFMrMElL?=
 =?utf-8?B?UFBMWndnL2gzWCtUQkYxZnR1S2ZXYStPTjA4MENZQ0w0MFAwaEpsNWhWOFpw?=
 =?utf-8?B?WjZPNWx4L2tzUnRrN3pYb1ZoNzFWZEN0WXlzbFJpc3dJeWRSVUhxZ1JEYVBO?=
 =?utf-8?B?SUpHSFZGSmphQnh5L0t1eTJwOVpPTmV2YllnZXNaWkVDZ2Yvd2ZOblZxMjcz?=
 =?utf-8?B?OU1mRTB6Q1RGd1FhNm4wTHdkT3lrWno3SUR1Rmt4ZGc2aDhDZDRVY0R3bmQr?=
 =?utf-8?B?ZmlmdTdVNnBBVlZJVEhsdlBxQzNqeTRpUUNmYldQak1GYytaVlhrZWJBTGJs?=
 =?utf-8?B?bGlNdTBnUUh4bkJWQ3FiWURXUy95WGxjMGFSeEdGTlJRNUpvVUd5cEFtOXUv?=
 =?utf-8?B?c3FxakIxbWVCMFFkN0lxakRLSjVwaVlwZ0ZVOEFtVWZ0eE1WaHI2MWNzdENz?=
 =?utf-8?B?TTNJUzR6WFVacUU0SDZ3dWY5ZkdRVjc2YzNlNFJpVzFNZ0NKcU52cGR0T2xQ?=
 =?utf-8?B?aVphanVDSGR2NHF5ZDRlc2tLbmFLWVN1RDNDN1pEV0xtdGdJT0RnWG5sNkh5?=
 =?utf-8?B?TnMxYXlRQW9pa2JWSE1VM2ljNzJDU1FLN2VyZ2VZTTYrNTB2UXRxbjVoMmhZ?=
 =?utf-8?B?bFpkVHpod25DRjhMcW01YzNaTzYxdTkrczN4K1VmaTFmNHNpTE9ERTdiRGlI?=
 =?utf-8?B?QlhqbW1aNmZBQjRTa2lOeWU4TytVVkVMQTdmOHdiaEFhTDhhYUViUytGWVdJ?=
 =?utf-8?B?NFhvdG52dEZkSFhTOFlTYU9KeDIya3grNzgzbTNQdlZ4TkZ3UkxEcGVVN1lF?=
 =?utf-8?B?SXJmYnQycDg2dHAxQmFnZFhsUzhYZjZ2TW50QmgwUmhnZFByeWFrQks0cEwy?=
 =?utf-8?B?TG1TSWx0WjZWLzcyN3dCcGZLb3owQU5lSDNPbDh5a1JVdzgzUDY3eW1maHpr?=
 =?utf-8?B?cGltSFBBUDZpenl3Mlduc0lET3VkSzgrb2NIdllsZkQwc09ZN29MTWt1dVRJ?=
 =?utf-8?B?MUovSWUrR1ZSL3NrMmVieTJheUZVd25zc254bGl3SGlXb0NIcHRSeWtYUG9S?=
 =?utf-8?B?Y0plMDRSVDNMYUN4M01UeTV1VG1Bd0FuaHErT25SWWNJWkZsZnVPRDVKeU5a?=
 =?utf-8?B?RnFUeUk4dTdVNUthZElpM0FmLzViWFV1MDhOU2hYc0FnMVF0alFwN1NHYi8y?=
 =?utf-8?B?ZFBMd0p1RkFJWVladE41L3BTYTk0bjl2bENMU1BmNERLSG9XalNqTGdUMWZQ?=
 =?utf-8?B?TjZxZ1M2d3AxN0czU0JNS2lhMkh3YXFESWlVdE56aThkM2JHWjJISFBqWWd1?=
 =?utf-8?B?aFFzcUU0a0thK1lzdFlHVGNLd3l1aVV4QjFyOVdVb0VuWUU5cE9HUXc3Wk4v?=
 =?utf-8?B?MDZqSlBsK01lOEVtMWdBNjJpYW1QS2ZVRXZMM0NENUk4TFJPZmM4UTNkemxi?=
 =?utf-8?B?RUQwdXUreFR4WGVHSmpwVkFGcXJQcGxIbElTd2hENDZJYm92eTkvaS9RRXc1?=
 =?utf-8?B?WFMyRnN1RDVXMit1Vmpad2ZEalJ2cE5aWjhpZUgwcW1ZbXhOVnJaK1RzOSt4?=
 =?utf-8?B?SEQxelRVQW1QMHFIcHdkS2lWVFFyS0hqRHRBRGZ5VUhxb0tiaG9janFxRmVZ?=
 =?utf-8?B?QStPZXBCbXgyaFpyVnFxVlZhQ05xNVNFUkVpOXVEYU5scXJmUUxlMGVaTExG?=
 =?utf-8?B?OVNoM2RxMGNQQnRhc3A1cU5ZREJ0SU05b01OR2pvN3JBaGptVHozWHAzR3h0?=
 =?utf-8?B?NGRqUkhvblRoUkVXV1drUU5mRVNFaXNSUFo5UzBYUk9HZCtlcXJOMzY5cDFB?=
 =?utf-8?B?eEs3V2lVYUxHeEN4SzFkd3JEakVJL3YrMkxCQ3hKbmpJZTBvZkxiamkzeVli?=
 =?utf-8?B?VmkweDIvWXFyd2N6QjdQVUtEWWEzVUxFTVRMaUdjZjg2MmRvV0VkTktnbGIz?=
 =?utf-8?B?WERqb1RxRzY5Q2lPNmRzRFZBeFRrcjFvTEZpaGt0b1RHOUN6LzZ5S09vcTl6?=
 =?utf-8?B?Z29PZmR5SjFMRVBBSy9NTHIwTGdHdEg4RGdsTWRNZ1g3R1JERldFUEd5OWVI?=
 =?utf-8?B?bkVKT2ZsV0VxRHo2d0FhK20yR1FUemNxQStEZ1orY2F1d1dCeHFzcG9TcVBU?=
 =?utf-8?B?V1hYOEU3WmJpUmRSSjI3cERSaDhZbTN1ZEpxaTZra2NvT2U4ejIxYlZFd2hC?=
 =?utf-8?Q?F97Jsm4v5g3gUVA8FltXf1g=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 479a91af-684d-40f5-3998-08d9d4a00fd1
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 01:16:57.8298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UG5zvhuuCqIyBpT6qJvYhztkFhXADZN28EdfnuNxT+MKb1GvqQ/ZG8QV8VtkYHZlyl9UzMJAa3cjWkVonVBErA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3651
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/22 20:23, Matthew Wilcox (Oracle) wrote:
> By definition, a compound page has an order >= 1, so the second half
> of the test was redundant.  Also, this cannot be a tail page since
> it's the result of calling compound_head(), so use PageHead() instead
> of PageCompound().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---

Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard
NVIDIA

>   mm/gup.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 3c93d2fdf4da..6eedca605b3d 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -237,7 +237,7 @@ static inline struct page *compound_range_next(unsigned long i,
>   
>   	next = start + i;
>   	page = compound_head(next);
> -	if (PageCompound(page) && compound_order(page) >= 1)
> +	if (PageHead(page))
>   		nr = min_t(unsigned int,
>   			   page + compound_nr(page) - next, npages - i);
>   

