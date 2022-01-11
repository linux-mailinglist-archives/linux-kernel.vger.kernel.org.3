Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A44AB48A6C8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 05:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347866AbiAKEcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 23:32:25 -0500
Received: from mail-dm6nam11on2089.outbound.protection.outlook.com ([40.107.223.89]:9441
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230245AbiAKEcY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 23:32:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XYcig206sQK3h8f00kFKk3K4EGx1LwsHck8k+Ov556PjfKeTT1BRTszhFfAZll3TixB40WsE3MHBum9UUpDs9+FHktkPYwfOJagu80wQkSClSv49q9di7ri6BshG4Klbi3mei3vgchmkIxYzVTPrw5uM61lctj0oSMK3N7EaqGYA6TkLzvm03NOTJmvRgD/992VGFCrAgepFwGen30rt71cp9vGJBOFSO50Bj2u74yg+YTRIReLkJdvLZzvfD7LP7KYKjwPAI+cxpNJMCjlA0BG1Pt6Nm7c01U+VNMmMb6zf2W2Z+Bv50OWx+Q2qmuL/E9Gxyc6qhj4K+1mNs1l72A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zMxRxSnoFnUxGxygDXyndZE27aILAtFH8gtjdNsvE/A=;
 b=b4i/9b3VgZJ8bvwQ9ufQFTt8bGjsoSzob69rpNHKMt9KONgV7PmHwsWvFZO5SBF1389PpJA8jhyohKUAlYgVZyjazt2nqBxpM3yLWRNrYw6Plq4G/1mUPjmRKcK4Y9j2DPbN3MIZEd8WDPea73i45HKUK5ae4eKfQ08BWbltMA0zmdFqd4sS73eTOXhP84xsBbbivPIqbIHGJJGwFtqy8TjB6ALPjqww3Nmb+fKgsZUu/9cmvvrLE2eHFsryQSgnaGIx1wHo65Q/zMcD3lltIAqMveMtTLynRQWRoPzy+zznCjBsMU9jETqLRnhdkUeqyxn47ay8IPQcCV5fMePPGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMxRxSnoFnUxGxygDXyndZE27aILAtFH8gtjdNsvE/A=;
 b=WYQaa5itaNoFfrxqJp4uF8CCGOyWpyTOlri4te6lsCnqfL2GUkPo4dQQxpsgif+aronYiP5GZHligGJfw8wwLsmpAAChMo6oUGHnnF+2QAVvxcGSm7Cq7UeiBRMrnPrcvyvK5f/C10ZKEys939msQl4AyvkQ5EImV36YNTKEGpdMHIH5w8jUEm0soAcmYKi00Sv1YwwfCUNIepwJH1jJze6pooC3z5qqM261V8YlD4oHFXEiLiMbg0BqwURoLNB8Dia0UMhYdwA/X1+3ZZKTR0j2Q6HV3f3nlz3o9qRPTJEKPHObCy0fn9l2/SPlgUecWJABnxxIhL+1uskDe4iKZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BYAPR12MB3384.namprd12.prod.outlook.com (2603:10b6:a03:d8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Tue, 11 Jan
 2022 04:32:22 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::8496:16fd:65c5:4af7]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::8496:16fd:65c5:4af7%4]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 04:32:22 +0000
Message-ID: <8ad9c4b4-19a6-b22d-91b8-72125bc710cd@nvidia.com>
Date:   Mon, 10 Jan 2022 20:32:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v2 09/28] gup: Turn hpage_pincount_add() into
 page_pincount_add()
Content-Language: en-US
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Cc:     Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
References: <20220110042406.499429-1-willy@infradead.org>
 <20220110042406.499429-10-willy@infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220110042406.499429-10-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0033.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::46) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dfe37c0a-d6bc-454c-8152-08d9d4bb5c56
X-MS-TrafficTypeDiagnostic: BYAPR12MB3384:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB33846F9731F56A735716BA37A8519@BYAPR12MB3384.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ff5eJlkxoR5hRqVO3n/QybcCOty9f/wEixppcKCQT9u/9NivshfFGSKIAUEs3ku39GDxuCGrAyfJFnzq7546gpTRwNtXSyxaGq4lmgDlfhoTsVTT5fhbxdbkNubX/MsVb7ZuboIsl42kpcV3PsKKFSlMKGVNWLK4jKjnUnsPB47GHPK6UpyYPK5iZECrQQ42c7HaQd6KwxYXUt/mWWw0u+dYoRQbM1438qmtUMVtpmPyRrJeguunJwutZPVcEElwmOAXNS7o9xrzNYz7zBB9hv3OD6txqvL9RYdMatcrdQ68CiWnI0cYsagvWlLBnlLBeVBPCQy5nYZCcN+L3DFJ2HBJupsQJaH2y8roOxnnNMDthF5X/0jvIDSYsDRVHBztCRvBwsY0T2aHE1IkQ0dGDrwmpsIBonS5VPZ3hKI2AlNpu91rhjfUjOXJgGq3YzynjAOs4NVt6Lq51z1Wm5PtrAWfJpad2rVp/4C/RaaSE1adyp8HtP6+Xgic5xnS9OJ5UCvWZ01ZEm9VlPZXlR6/n+bn840gMCSre/7B633yTS4SZXeImv6QVnbrx1IrrGe0lDx7Fbbm21+4h6GLoM+o46VsgFKR45lM0hdtkm4Ewgy50hHa9agr7+za19kVnecNskdWv6/hBoZr0HLIx7wgdp2ROU2kq/7vWWkFFgy8NnuYgp2dpmiMEhTSrliKQZdT9jysV0k9acj+QKCtUP5WDRBJrwMnygAxgYOTeHVdsbbLm5DRB5RxBDtwN8zgJ4Dx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(8936002)(53546011)(316002)(36756003)(31696002)(66476007)(66946007)(66556008)(6506007)(86362001)(31686004)(2906002)(8676002)(508600001)(26005)(38100700002)(5660300002)(6512007)(83380400001)(186003)(6486002)(2616005)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWNYUUtLaFFEbG5RS1VCTlJpN1MrSlhRNEFtZ2hrV1dDQ0ZMVzg4YlZxaWYv?=
 =?utf-8?B?WE1kZGJJL01vVW5RR3dYd3VmMkt1ZkpiditqZTJQME9vVEZmNDZiOXhaVnZS?=
 =?utf-8?B?UnUwVzdiK3RacS9qM29LS2xOSmdNcEMvTlMxdGdGbVRieXEyT2N1aTNBOS8z?=
 =?utf-8?B?R292VU9mOFViaHRKM1Y3d1ozRSs3TDhBZjVIWU5yemY0dWhJUzhIZHVYZlN4?=
 =?utf-8?B?QlN5dFllVkhNakJzWmNncXhXOXRrM2dRWVlLeXpHQmdqMldNNUR5OXF4VHJn?=
 =?utf-8?B?Q0MzMk5YTnh3aTFCQ1V6eG1MWjBGbkFLUDB4YmNPdHdnM25BbVZWeXhkQU5N?=
 =?utf-8?B?TjY4T2wwNXFuVXJ2dUlvQ24xMFZ2MEdzeHlOS2hXWkZ3MmpBTk5tM0lzS2Nm?=
 =?utf-8?B?dzlUbkZPa2poRERRb2RhdDhldmpWYlBINXc2YXVQN2hFNHdVTVhtN3ZXRkdJ?=
 =?utf-8?B?SjVjVk5oVXNWTzJIMXZmdmVGZW1sMDMyTnBEc2htMFdIbUxYZVYyRThrTjl2?=
 =?utf-8?B?L0NZTUFqMGZMcUJ3RWZwVlJNMXJBbmZhNEx5Nk1hUW9SMjV5VmgxVWVKMGNG?=
 =?utf-8?B?T21KNUJCSmRCaUpFV0luckdGVmtqdTY5bDlMQnpYMXg3QUVpUVZTT0xOZGhP?=
 =?utf-8?B?SlhVcXpuRWoycFFSYm01UHZPMGo3R292eThhV3p5MkVWRkdtNjRoTUVWSytP?=
 =?utf-8?B?WkpGbENBdnJUTUZtVzlkWEttTUdqa1cwSGtHSVZmUmZ0aGZIL3VxVkZ5bU8y?=
 =?utf-8?B?eU8yUElzWW9EZElmMTNuZGtmWitjNnIwbFpNU0VueXljZWMyZUJEZ3dmS3Bp?=
 =?utf-8?B?Vml4U0xCTXVtalJqQWhPVkdtUFIwb05yS29qK0ZISnJ4bXkvMENsMnMxVDBJ?=
 =?utf-8?B?cjFNZ3NNbnRZaGJYdUdnc085cFRNK3pMajd2V3BOVjNhRnh3S1UrUFZ1alNG?=
 =?utf-8?B?OERHVWp5N2dsOGMxaENROFprcTkyeGl2cWpIRDI4VERseDBMZVliTXFDZTEr?=
 =?utf-8?B?S0RlUlpoeGJ5ZEZKdi9yRitRa0xhdk10UFM0T2N4RithUGtBMTNHbXdWQjBj?=
 =?utf-8?B?dkltNWdIQ1JTYjd3dkpqR1Fxc01jU0cxK2tvRzdUUXlmcm5JTXYyQjVobzNF?=
 =?utf-8?B?QVJZVkVyMU1ZTDJEU0VqTXYxcTloV0NlUnFkbnhJQjM4OVd4SERXOU9kV3Z2?=
 =?utf-8?B?RllCNFNieW9iN3djeWdyMTRUNTNFQkFwaEpBRDRTMFFEV0FKczA4N3h1U3FS?=
 =?utf-8?B?ckd6bzUydTd3UmxWRlBBaEFnQjZnajJuV0RRblJURnNSTlBDS21Xd0F1NnJh?=
 =?utf-8?B?OTVsdVZVZUJ4NWs4UEN1SEFwRTUyLzREYUhFdEwvTVB4MEZzWjJpanpaeXhE?=
 =?utf-8?B?bW4xUWN6RENpVWRSRHhYbjEyaFV0N08yeXd6ZGNSNEpyWCs2M3djeVR6ZlFD?=
 =?utf-8?B?UHIrUmN6blYxMW5udGpLKytBRERJc1ZJc0lFVVhhYUlqTDAwdFg3bGZIMjdl?=
 =?utf-8?B?YmR3eGFGeHdEcVM3c2kxazY5bXBiM2tYcldDYUg0ZHJUaFRQUVhMcHJCWDI3?=
 =?utf-8?B?TzM2VHZvL2ZqbnZSaTkzZ2liejdlMFZpTHd3S1hkcWlmRmpGZGVMaHNnU3Jk?=
 =?utf-8?B?L2RwYUVwOElrcktvRG1aODZsK24zTWF5YWhQNHdIUEtuU1psQzgzMGVIZ08x?=
 =?utf-8?B?WVlkUXMzWTMwWjgrOUl6c3ZUSW9XaXpVcERxU2FwU1BnOUFnVDhhNnJkc010?=
 =?utf-8?B?RitqNEYyVGVzaHZ6V1lLRysyUWVJK29RTkxTR0pqY0RFZUVvY0FLL0tlanIr?=
 =?utf-8?B?WXBLL2VnSFhWQ1FaSkFOWng0L1pKWGpaWFhDR204V1c2cU1ZeG1OZkJ4T0hG?=
 =?utf-8?B?Qi9KWkRLRU9DSmhlb3pvbnRYMTFaVjF3eUV5SDBtLzRXczlPYzNRZCtBUk5W?=
 =?utf-8?B?MnF4REt5L0hjU1FWUXhnMExURnR5bnlrMFE2SXJKTzdweGFqYVlvQVJRaEpU?=
 =?utf-8?B?RkRpMExhVjlIcmIwQ1owWnBPaS9vQlpaVjJzMnFnRGtScDRRZk5uSHhyZVFO?=
 =?utf-8?B?c2k4bWdpaEZQQWlwS3RKQVVWQmU0bTNxL0NmeGo4R2hqRDVxaXhIc2RRUFFw?=
 =?utf-8?B?Z1ExZzBuNVhPeWNYNGliKzZDaUdoSnkzZDdZYnBSYW0xRHlXdEJCVWxKZDQw?=
 =?utf-8?Q?ZW8rro9jJzGEMUIu48OLrFQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfe37c0a-d6bc-454c-8152-08d9d4bb5c56
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 04:32:22.4500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W1PK+jsk1GgadwTo7a9BnapA/wJpmpfDYzcSM99zu6LMKzutF2UEE0OQgapI1/p+fMnmCzpqKHzqlFDzx88LFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3384
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/22 20:23, Matthew Wilcox (Oracle) wrote:
...
> diff --git a/mm/gup.c b/mm/gup.c
> index dbb1b54d0def..3ed9907f3c8d 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -29,12 +29,23 @@ struct follow_page_context {
>   	unsigned int page_mask;
>   };
>   
> -static void hpage_pincount_add(struct page *page, int refs)
> +/*
> + * When pinning a compound page of order > 1 (which is what
> + * hpage_pincount_available() checks for), use an exact count to track
> + * it, via page_pincount_add/_sub().
> + *
> + * However, be sure to *also* increment the normal page refcount field
> + * at least once, so that the page really is pinned.  That's why the
> + * refcount from the earlier try_get_compound_head() is left intact.
> + */

I just realized, after looking at this again in a later patch, that the
last paragraph, above, is now misplaced. It refers to the behavior of the
caller, not to this routine. So it needs to be airlifted back to the
caller.

> +static void page_pincount_add(struct page *page, int refs)
>   {
> -	VM_BUG_ON_PAGE(!hpage_pincount_available(page), page);
>   	VM_BUG_ON_PAGE(page != compound_head(page), page);
>   
> -	atomic_add(refs, compound_pincount_ptr(page));
> +	if (hpage_pincount_available(page))
> +		atomic_add(refs, compound_pincount_ptr(page));
> +	else
> +		page_ref_add(page, refs * (GUP_PIN_COUNTING_BIAS - 1));
>   }
>   
>   static void hpage_pincount_sub(struct page *page, int refs)
> @@ -150,21 +161,7 @@ struct page *try_grab_compound_head(struct page *page,
>   		if (!page)
>   			return NULL;
>   
> -		/*
> -		 * When pinning a compound page of order > 1 (which is what
> -		 * hpage_pincount_available() checks for), use an exact count to
> -		 * track it, via hpage_pincount_add/_sub().
> -		 *
> -		 * However, be sure to *also* increment the normal page refcount
> -		 * field at least once, so that the page really is pinned.
> -		 * That's why the refcount from the earlier
> -		 * try_get_compound_head() is left intact.
> -		 */

...here.

> -		if (hpage_pincount_available(page))
> -			hpage_pincount_add(page, refs);
> -		else
> -			page_ref_add(page, refs * (GUP_PIN_COUNTING_BIAS - 1));
> -
> +		page_pincount_add(page, refs);
>   		mod_node_page_state(page_pgdat(page), NR_FOLL_PIN_ACQUIRED,
>   				    refs);
>   

thanks,
-- 
John Hubbard
NVIDIA
