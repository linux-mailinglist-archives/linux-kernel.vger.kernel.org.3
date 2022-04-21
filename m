Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0329050ABCA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 01:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441957AbiDUXHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 19:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392605AbiDUXHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 19:07:39 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2089.outbound.protection.outlook.com [40.107.212.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D5848890
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 16:04:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JMD0hkQ/fK+cWfS+7y7YBbDdol0qt1xv2LrNjiJB6eUJ8kczS5RmpS8mMcBquDrwhO4qs8j+AgBtn3pDWBtYZ1FVhsuIm7pw8kiOSigM0jm4/PditS1pC2spdT7XqBqNk1zjJEfSWqvP64dIIwrz7t6+/1L6qbKTnFpyaNr9PQSafZ3x9W2UWX1GQA6CCaaYq2SLtBEDU7eTAnfXythuzkJh93G+troZzN2AUBsoj4r5jAPx9usKMySFK1FTG29rjAH7hkvKEWlCVNIE9vrJ04T7Kgi/xUpl6TX4J/JJln3pi32x/h2pky4pqhvFQrzQuFNzXm9eVyLDi4Wifb3p3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c1AOGn30bC1YBkJTWGuwFq9kmo9325IayIdzgUIB6vQ=;
 b=DefSPTL8VLvTFfGyRypIpK/HK7m14n+sFcgBE9fU+vntqsVvbHkceGN8dMpr2Ie9C02uSsfyCTnBI0nL6eb8Zo8fAc99qtMvIz5IToTeXubjDE7DzkrOdfhIo7EfmKflWyjibcseUTlZM18GBdSrNnn7b5fRyaf3KlGQ6fhV8FijglfPNAP1kIC1g8C9ocfrjh7wDZsk+GhvLg5RTApql0wU+j5303qB6CNeGDxhzrzjoM0thlb8yeVI6kjSzMbIFeaMNnzhtdc2j36aWzzsFm8H3QI/UbegEWb3jYbOVtl0iMPjzNw0jXkscuSN8AXDKrHWhhxh8XerbI4mUdFFrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c1AOGn30bC1YBkJTWGuwFq9kmo9325IayIdzgUIB6vQ=;
 b=Yt4cj5K87KeBIHn3Qor8h+gUO6YTeRlBkYUUubUS3Hym1KvlJnDtAwRHs+aLdGzrFX5X7DJRYm3C11UffkF30LCVoqzBI2ouCcp52CSExndqkqHB6zqt7pPmY3VWS/aOs1cgnB41sX2GWM1Ghejbk4LnuTbjpll14HQ7Pw3S8rxKtMXVmJsqojTOMLk5XLZ3L1EpkMnhCrH8xiJE6ccDNztL5zVWMvKrsO3os+fIh+DlWOpNCsVwPwv+zgL0Po2g0hV7BRqvjyB3qHBPnkejs+sPK1+vpU06Cod28z04FAeiVkSjsVWhZNYueImsCdKpXSXQIE56BPJBbfo1OThWEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by MN2PR12MB2925.namprd12.prod.outlook.com (2603:10b6:208:ad::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 21 Apr
 2022 23:04:46 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::8187:9d64:dd55:f14]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::8187:9d64:dd55:f14%3]) with mapi id 15.20.5186.015; Thu, 21 Apr 2022
 23:04:46 +0000
Message-ID: <92a2715c-3c98-251d-9195-872d1cf01f9d@nvidia.com>
Date:   Thu, 21 Apr 2022 16:04:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re:
Content-Language: en-US
To:     Yury Norov <yury.norov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220421164138.1250943-1-yury.norov@gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220421164138.1250943-1-yury.norov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0196.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::21) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae766800-9442-4c5c-7fb4-08da23eb53dd
X-MS-TrafficTypeDiagnostic: MN2PR12MB2925:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB29258EC0C028A3F3D9AA8A15A8F49@MN2PR12MB2925.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NjLcdvRhPT1EGx/6rOiM/M37Zs3HGwCDiW56cEI47tEJH0SStUiifYVwcRNT6Y/H4F+36KmtHZHMcC5AOV9s+B1i6EFVJl/+VQiuO/fo/GGF+XQGEnFHTeY63mLrIV9Y72/6fVRsxAmoYFl29wZyAuDC0LU40acXyGzY/1zUkm0bwXhmMz1Q5W6RsScq+sGr9jUTCKgbXUcry06HjoeFILtLGO6VBsD5DyUsR2q6fFNogtwJUNRroJzCA5MwL0WbjYkQuqBy1oOL+EsV3YaNVfQEKcoaOYgQgoObb9TJuw8Muy6MrttxTax2gwRYOV7EnPJ9CCHuFrAMJjJ8kuodQKfkwq0PfzGUFyfINmzWwG8ifoet3cFXlP1k5IwjB7G0DgRGXMZp6yEIE10soJLJtEeAVoaeMuE8qpyFxRAnYfcIglkrb1EN9XpyYOltzh4vCsEswID8JbfXbE1ZfeCflPDb8gTeDHxkUmNfQrKzeHjgMYIDGvKgWc7LYvxSPNh+UNqHn/e5h0fnVm3J4QSko1fgjdpaOfBBCzHzLKHTfLkAH3KFqE2B1sa9MUwnDo2fc0cKZ8SSLbDEXC5v7MAdWtER5vby8UibZS8eDZEoFUSiblMx1uLzYPb3WysJlNE1U0ZKAhABWQrzPyq6o1HBdQJxc/+oUmMIrQ6o20oKuFISGMv6k8wOQOSgZKWHRE6p+H3TTTaRCyUFhX7/DnayDmNrZBmEJ7FJmDDphsNpyI4MKaVCzQGuzWuanJOXFdZFPpfYjB48009F9jayJggdMsy+QgzQXkG4X3vdtd86L3FSCLh1/0Aygtoeuh6SMJ1uP8hkTNdZiJyIYipkDHbfNQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(966005)(508600001)(66946007)(7116003)(3480700007)(66556008)(6486002)(6512007)(316002)(2906002)(31686004)(66476007)(8936002)(6506007)(53546011)(36756003)(86362001)(2616005)(8676002)(83380400001)(5660300002)(38100700002)(26005)(31696002)(110136005)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djI0ckVqUWRXanI1WVVjTkgzMkZTVEpvNWEwSFo0UzRobjJ2Zitpd2NjTWI4?=
 =?utf-8?B?UlV3YXZ0Q0VQS1NMTktKdzludWFhSXN3eXErcEZwSnNEMmYzVFN4TFZISlNu?=
 =?utf-8?B?R2hmYjNMdit3MFg3cGdmNisxSTRDdnlaSlZsNDgrVzZQUUtXRjJwSzdndGkv?=
 =?utf-8?B?YlZ3aVpNVUVGbThjcXBubDBvd2FRbjIyUk1oQ1NNVmJ2U2s4bXNjS3puRWRl?=
 =?utf-8?B?VFFCQ2FHc2h2U0ZOck1HUzIzK2F1RnFzZG1URk4wZjVXMUl3eDFFV0FXNXJa?=
 =?utf-8?B?Y0E1ZFE0OStodVdERSttVkgyaWhDM1c2Mnlxa0pEUUFLRnY4NWQyeTNZVTdh?=
 =?utf-8?B?SlZkOWdCQzk0elp1cGRtQXoyMTlmYy9jL1JaWW1OY0pzMGs1UlJUa2JHRndM?=
 =?utf-8?B?UE1Ta3pUWEl0dGpLdFZGbldkMC9SOTMvZ3U3K3FIK0V2c0dKcy9wcStTNzRj?=
 =?utf-8?B?cmI3K2Y1emVXcWo2VXczb1JnWGQ2OW82amZiVFpyN0lmNXBWUnlscFlyMi91?=
 =?utf-8?B?eEhmQWh6UkVCNEtSUjRuOWxiUDdLYnZyQXNnWHFpZ3JqdU1xU3VPZHJTYUJ2?=
 =?utf-8?B?UWNyNTdxc2dJS1dJbWc5NFU3aUxjMlQyWE45a2ZXL3E2REhpbzh2UElHdTVj?=
 =?utf-8?B?dVo5Y0FubDA2cWYrazZFKzlPVFpTb1VTSmlWKzRrbExGaWl4eUJBeDArREhy?=
 =?utf-8?B?eDE2T3Zma3l2RGJ5MXUrQjBSUTc0MGZLRmJUQmltcUNwYk12dDJHUFcxc3JP?=
 =?utf-8?B?cGJGdnorcmlaY3hQMU05STJlbTJhN0FUKzM2MkdvNEN6b0hsSnBEOE45emYv?=
 =?utf-8?B?SFc4MUFTVXRNQlpYM2lCNDJaTk5ZWE5BREtUUlZrWlRFSUJyL3NlVnpEcExN?=
 =?utf-8?B?ZVR0R3k5L1FEeFpNbWNIdW1OUG5YcHI0OEpGZ1BNWjFad1V3ZjNGanowRDVC?=
 =?utf-8?B?RysvMUtOL1BOQkl5NjlWbnJHUkMxTzJsYWs0OThhd3EzSTB0aGdNdXF0SEsz?=
 =?utf-8?B?MDBRQ3FoVHRWM25zOXd2K2JvdExscTJjUGdjbzFvNldhQm5vaXRSTFgyK2Va?=
 =?utf-8?B?MnJVM2t3RXRLbmtKOXJZNXJHdHdZVzRra2Z2T0JuUTJLZ0w0U3o5MVRRVHRk?=
 =?utf-8?B?RnVVS2tIUkVBaU5rNWNJaC9yNFpWbEwrVFl1aG1qc0NNMHN3blYvYnUveXkv?=
 =?utf-8?B?YUpGRDJwQXJEcHNVMC93L3VmaTM2Ni9zMjVQQ2lIZnpkd1o3SThiQ2tsZHZ3?=
 =?utf-8?B?WHhmK0NvbHA1VTBRZHA4NjJxa0ZxUGRiaHl1aDFJSU9nOFpjdXkyeENEUWt5?=
 =?utf-8?B?ZCtMa3p2OXBQaVYvcnBBdHNOMDJYcGwwL2hqbmg2SGxNTVZ3MU9ibUtRdkxu?=
 =?utf-8?B?RXp3QmJVcjVhK3o2WVdUMWRwdklyY3htdldCemt2c1RNRkNPNFgxbVp1VEJY?=
 =?utf-8?B?SGhqdlduSFRlSkQ0RGxjMitZNHhld3lXZStTUXFXc1lHZFhacDQ4R2RCa1RO?=
 =?utf-8?B?YTk5NzRBdTQxWStMdUVBZFp1L3Uxemt1aTU1Q09OeVNPc012V0Jja2tRMDBG?=
 =?utf-8?B?WVp3K3k4UUE0eFFSM3NOMlczVjhoR3pCVktYNGlXNkg2cVl2dUNBd2pvd2lm?=
 =?utf-8?B?L1FLeHJJOWpiNjNwRWVVaVlOQS9kNXRWa2d0aGduTHFDQjdUeitNNEM2Vm45?=
 =?utf-8?B?THI5bWllZkV1dENRaUhzVmRNQUpQK1VHWlQwakFMc3lHeHZlZnZ3U1hVaGhN?=
 =?utf-8?B?ekdua0FaT2JLeEU2WjJRUGZUd2hWZVF0aTFLL2l3T09WYzhtWUozbHA0bUtO?=
 =?utf-8?B?TDRSdGlPVitULzdON3Q1bjQ3NXRmZG03cXQ0RUNESDB0cXc2eFh0b3NWUm41?=
 =?utf-8?B?U1RSbjd5Rzg0dnJ1QjBJOGpSb1VmY2Mybk94cUhPTFVQUkEzU3dPczhxdlI0?=
 =?utf-8?B?MWlFN3lWY1dyemlOZG9UN3NiNURMUnpLbGpBVlVGT1ZPUkw1NUI3Z0xqejlh?=
 =?utf-8?B?ZVIyTlNuQ05vRnpZWjNHd2QwNlg1TVB0ZkNLeUVVYUcyODNReHNFRXBodWM0?=
 =?utf-8?B?RnFLdWxhVStTNm1ac1lFdVZrQ1pRZng5N2t6SHlBU3llcEx5UG81OXBYTXpX?=
 =?utf-8?B?ZXd3M0xSZHJ6bE9zYVZxZUNFNjlnR0swUk9nSXBMc1htOTFKZzZ4L2toNzl0?=
 =?utf-8?B?YTI2L3Fia1JXM0RsenhrV0t5TVNLdzh2eThOanBDamxhT0prOXF2YzhTMmZR?=
 =?utf-8?B?c0E1MW9reTZ4N3Jmb3BsWkJWeDlwQldmQmQyMjZqb05YSkM0d0RIWmlOODhy?=
 =?utf-8?B?RU9mbldXdFBCT3lqOGpZT3Y4Z0hQSlE0bkNYQTVMQ3VUMWdrRk1mUkxaWjdq?=
 =?utf-8?Q?noyiAN2+EGvc2wik=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae766800-9442-4c5c-7fb4-08da23eb53dd
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 23:04:45.9845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vtt5vcw0oyRKU3+fOSD6PGQghaipYdJCL92IyQRcmvX7Fous1dclqpCR5VzEATVMukny7/wC66FwIUlHeurrFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2925
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/21/22 09:41, Yury Norov wrote:
> Subject: [PATCH] mm/gup: fix comments to pin_user_pages_*()
> 

Hi Yuri,

Thanks for picking this up. I have been distracted and didn't trust
myself to focus on this properly, so it's good to have help!

IT/admin point: somehow the first line of the commit description didn't
make it into an actual email subject. The subject line was blank when it
arrived in my inbox, and the subject is in the body here instead. Not
sure how that happened.

Maybe check your git-sendemail setup?


> pin_user_pages API forces FOLL_PIN in gup_flags, which means that the
> API requires struct page **pages to be provided (not NULL). However,
> the comment to pin_user_pages() says:
> 
>      * @pages:      array that receives pointers to the pages pinned.
>      *              Should be at least nr_pages long. Or NULL, if caller
>      *              only intends to ensure the pages are faulted in.
> 
> This patch fixes comments along the pin_user_pages code, and also adds
> WARN_ON(!pages), so that API users will have better understanding
> on how to use it.

No need to quote the code in the commit log. Instead, just summarize.
For example:

pin_user_pages API forces FOLL_PIN in gup_flags, which means that the
API requires struct page **pages to be provided (not NULL). However, the
comment to pin_user_pages() clearly allows for passing in a NULL @pages
argument.

Remove the incorrect comments, and add WARN_ON_ONCE(!pages) calls to
enforce the API.

> 
> It has been independently spotted by Minchan Kim and confirmed with
> John Hubbard:
> 
> https://lore.kernel.org/all/YgWA0ghrrzHONehH@google.com/

Let's add a Cc: line for Michan as well:

Cc: Minchan Kim <minchan@kernel.org>

> 
> Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> ---
>   mm/gup.c | 26 ++++++++++++++++++++++----
>   1 file changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index f598a037eb04..559626457585 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2871,6 +2871,10 @@ int pin_user_pages_fast(unsigned long start, int nr_pages,
>   	if (WARN_ON_ONCE(gup_flags & FOLL_GET))
>   		return -EINVAL;
>   
> +	/* FOLL_PIN requires pages != NULL */

Please delete each and every one of these one-line comments, because
they merely echo what the code says.

> +	if (WARN_ON_ONCE(!pages))
> +		return -EINVAL;
> +
>   	gup_flags |= FOLL_PIN;
>   	return internal_get_user_pages_fast(start, nr_pages, gup_flags, pages);
>   }
> @@ -2893,6 +2897,10 @@ int pin_user_pages_fast_only(unsigned long start, int nr_pages,
>   	 */
>   	if (WARN_ON_ONCE(gup_flags & FOLL_GET))
>   		return 0;
> +
> +	/* FOLL_PIN requires pages != NULL */
> +	if (WARN_ON_ONCE(!pages))
> +		return 0;
>   	/*
>   	 * FOLL_FAST_ONLY is required in order to match the API description of
>   	 * this routine: no fall back to regular ("slow") GUP.
> @@ -2920,8 +2928,7 @@ EXPORT_SYMBOL_GPL(pin_user_pages_fast_only);
>    * @nr_pages:	number of pages from start to pin
>    * @gup_flags:	flags modifying lookup behaviour
>    * @pages:	array that receives pointers to the pages pinned.
> - *		Should be at least nr_pages long. Or NULL, if caller
> - *		only intends to ensure the pages are faulted in.
> + *		Should be at least nr_pages long.
>    * @vmas:	array of pointers to vmas corresponding to each page.
>    *		Or NULL if the caller does not require them.
>    * @locked:	pointer to lock flag indicating whether lock is held and
> @@ -2944,6 +2951,10 @@ long pin_user_pages_remote(struct mm_struct *mm,
>   	if (WARN_ON_ONCE(gup_flags & FOLL_GET))
>   		return -EINVAL;
>   
> +	/* FOLL_PIN requires pages != NULL */
> +	if (WARN_ON_ONCE(!pages))
> +		return -EINVAL;
> +
>   	gup_flags |= FOLL_PIN;
>   	return __get_user_pages_remote(mm, start, nr_pages, gup_flags,
>   				       pages, vmas, locked);
> @@ -2957,8 +2968,7 @@ EXPORT_SYMBOL(pin_user_pages_remote);
>    * @nr_pages:	number of pages from start to pin
>    * @gup_flags:	flags modifying lookup behaviour
>    * @pages:	array that receives pointers to the pages pinned.
> - *		Should be at least nr_pages long. Or NULL, if caller
> - *		only intends to ensure the pages are faulted in.
> + *		Should be at least nr_pages long.
>    * @vmas:	array of pointers to vmas corresponding to each page.
>    *		Or NULL if the caller does not require them.
>    *
> @@ -2976,6 +2986,10 @@ long pin_user_pages(unsigned long start, unsigned long nr_pages,
>   	if (WARN_ON_ONCE(gup_flags & FOLL_GET))
>   		return -EINVAL;
>   
> +	/* FOLL_PIN requires pages != NULL */
> +	if (WARN_ON_ONCE(!pages))
> +		return -EINVAL;
> +
>   	gup_flags |= FOLL_PIN;
>   	return __gup_longterm_locked(current->mm, start, nr_pages,
>   				     pages, vmas, gup_flags);
> @@ -2994,6 +3008,10 @@ long pin_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
>   	if (WARN_ON_ONCE(gup_flags & FOLL_GET))
>   		return -EINVAL;
>   
> +	/* FOLL_PIN requires pages != NULL */
> +	if (WARN_ON_ONCE(!pages))
> +		return -EINVAL;
> +
>   	gup_flags |= FOLL_PIN;
>   	return get_user_pages_unlocked(start, nr_pages, pages, gup_flags);
>   }

I hope we don't break any callers with the newly enforced !pages, but it's
the right thing to do, in order to avoid misunderstandings.

thanks,
-- 
John Hubbard
NVIDIA
