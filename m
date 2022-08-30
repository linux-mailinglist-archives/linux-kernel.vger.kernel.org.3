Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46EFA5A6CFB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 21:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbiH3TSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 15:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiH3TSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 15:18:47 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1736B61B3C
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 12:18:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hDrE1+fDvA7uVbXxzlaIXTpwZ1VIaotFQutVsV07yIOOFsiUVRoJKA/SagEWY2hBRllvjeFsKOLA2m6HMcdIP2S84OcHF1hoVGM1V987x/iyTAyRLE7FBb8KwA4rhuMWUHDOwYfOAP+7fh2xidd0+JW5//NPty2BPpImfT5lYJaMCcTMnaznqvTXgvrYO3sYJ5aa/kOqNGuMZ+kP/s3CGBSQbvk1VwzZXJ/oA5+WHBcOK6JK8P7mqa/gL78hRc1Pk6zMkzi5HyJhiP7i2SIg8flaTCwa3kj4BJguCOTJFM99S1xW+sntOIrsiZIssGYavMB+pJcLQz5U59KCi54u7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PfDmqC6/l5nfFD3k0fOLSX2Uisjw3URDtzJVihSqCpA=;
 b=aXP5yTxFCpL+SylrwGARy+A/GsJ0ZU8WV/JpviNQPCpP10VVrvUEy8hBIu25P4LqCdBA9u3RbeeW9VAhYCoBP77PLQXdi3ELVVCW5H1LW6AzKpYI5qrnBZA2WXyUA+ucSCdUArf0WGziUSoVmfaUgTgylEoMCj4iZ2Z9VqlUuf+HhRtC9zIwJUl54kecbapTA/S+9hM7dpCmyrIiyKTPGfOaa5jxP3Vp5jtE0H7Z2ovaDUqcz/W4Jz0mHBZcEv+AJzytr2WKUL2sj0RXcaMzgfL5xe1OPbkspOAgnGtUp7eJoTXUUXZXEcrVdPiGTCA2NTKBSqi+GkODQJL/LkYHMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PfDmqC6/l5nfFD3k0fOLSX2Uisjw3URDtzJVihSqCpA=;
 b=A7TctpHS88ApI0eLDUzbVFO34upo2AkMcbzuUxihk7rogCiZ3BsfQmag6zxcMwy12UM0NjEkBrXpPi7+Wy3yTEZh9HBIHqjqK/6BfgL4rNqj+nLTpHFdBHQUCeh/S+C3FARCMugx6T2GGNppx7770GPIFR8Y056NgcOGafQUNqvi8/PCumsk06t8H8+NHjRoxb4GtSprGsI18ebGAAbDzVdEtN4jpuZ8otZYVUewhybOGWVT4KRi/1pawhD1zNW3GMzXdhGfEDVdBb7yVbYZ2HmIkIa8jFB/hqkil0fUjqpYarWz8b1GZ6Txr36/4/AcfXOL1VWKayw1YkggrphG5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by SA1PR12MB5614.namprd12.prod.outlook.com (2603:10b6:806:228::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Tue, 30 Aug
 2022 19:18:44 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5%9]) with mapi id 15.20.5588.010; Tue, 30 Aug 2022
 19:18:44 +0000
Message-ID: <9a4fe603-950e-785b-6281-2e309256463f@nvidia.com>
Date:   Tue, 30 Aug 2022 12:18:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v1 2/3] mm/gup: use gup_can_follow_protnone() also in
 GUP-fast
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>, Peter Xu <peterx@redhat.com>
References: <20220825164659.89824-1-david@redhat.com>
 <20220825164659.89824-3-david@redhat.com>
 <1892f6de-fd22-0e8b-3ff6-4c8641e1c68e@redhat.com>
 <2e20c90d-4d1f-dd83-aa63-9d8d17021263@redhat.com>
 <Yw5a1paQJ9MNdgmW@nvidia.com>
 <9ce3aaaa-71a6-5a81-16a3-36e6763feb91@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <9ce3aaaa-71a6-5a81-16a3-36e6763feb91@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0022.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::27) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 49fb9cd5-fb03-4a05-67de-08da8abc7472
X-MS-TrafficTypeDiagnostic: SA1PR12MB5614:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fVe35gElqc/JMVv+UhVnOl9rqwNeakaUxlB4dxuVRFyNBRgoqekef/i5IHn1WIyQen0r9IXUYcFL1HtbCRuEC8vMlrHK/mZIAJDLCP24/hrN3RNmd0juFer/XJuucrXH6WXlmXZ/MnHTDZ0cMC2aoIXHulqnemxkCqtlArKG4S0ksQUF+GYtPa6N0wOEMRzBkHe06BDLq8+VY+iUGH84V22MhaGTAXlV8CVe7uXRTb0ZY2bF+5cLY1qY9m5ouCC09+HSl2ftv6DxVNdWTJt8ViYB/TzVF+4n8uJlKr5EKqOzpnXmI987DJmWSolM0uh1TxrVMzTHSa5B8z5QmBMaC9NXK5+UVltCTTIpo5TjeS4jwcfnjSQZ4FJDn1RlccgR200JNqy8nNf701LVIqq34Xm5786FOOQxJSC469W6ygj8+W+yMjdBZlilBrmp08GLsrZtSzVjGsdhX7n2w+BBvpb2i9WGVlSu7DeoHVYDDGVHZnJR6Ei9p4ifq66yl3dv9g0bH8S4PRMaqaUq5oEbx+Ld8MZw+0tb29X6ZZcsZoy8Um0LEzu1JlCvFGAd9VRScYh0m89klKGBP5c3x6HvyO+sKOJM2hP0AS7dDGAF4f3oTWYLtnxyw50YbjFp6CStd0oRl5Jc2ZEe3T37cLNZSTlCroFkrMnEX162VfALQCq03oQpiEk3kq6JNwjDxzomFCboffAhqLPORFJGo6QM38iW0gCD9yim7d/Dn2sEFqiU4B/zrRJXVUe1z9Emsl6osFZtusKWOilAK2BhbP+trFFTEyC3zGH9RxKeRNgpsBMNCoxYY3GGlicRd4ZXj8EfmdNBAc5XcInVw3BXdSaoVbMigpnGsU4LFG5rznrl5TlU9OgFowCoKDXiH7A8kptg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(376002)(366004)(39860400002)(396003)(38100700002)(6512007)(41300700001)(26005)(54906003)(83380400001)(186003)(2616005)(6486002)(966005)(8936002)(31696002)(5660300002)(2906002)(478600001)(36756003)(31686004)(6666004)(6636002)(6506007)(66476007)(86362001)(66946007)(66556008)(110136005)(53546011)(316002)(4326008)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VllmS1c2SmtIYVg4ZnoyMDhKMW95QnovcXc0aGk0QWZaakg3NmVxaVFFQXNJ?=
 =?utf-8?B?SzdVbktuejVtVHg4dU16UG42aHVqdS8yR1phWE1mR2tZR0c5N1NIK3VRN0RC?=
 =?utf-8?B?Z3dySVkxZHJUU0laSzVDZFN0L0gxUXdlTU1VVkQ2bHVFUFEwUWROZ2UyTkhU?=
 =?utf-8?B?ZTkrUkRUUXJRSU16WnYwUGdUT0s2NlNoR3R4MlFkempSajRYdnYwbEsycmpI?=
 =?utf-8?B?dHVBQklYZDYxekQ4UE5CekhoQmlndUNrdGFxWVRvSi9vd2hNQXNOci8yMFJ1?=
 =?utf-8?B?MjhNdXRRWEY4UWlRM1NmYUNBMDFMd1pVc0tQcGxuQ2t5QmI1azMyZ1k0YXlM?=
 =?utf-8?B?VUhid0lmRE94MUEwSmp1WmlwS1BPSnpSalA0bkR3NjUvYmVycWZyaUptQ09v?=
 =?utf-8?B?SEdBUmNCc1VzbXBDekU0dG5vRHZsajIzQTYxdjhmY01FUDdQbk4zcTVmRHA2?=
 =?utf-8?B?cDN5U25zOFBrTTJvWjBralRrOHp5YWEvNTdPRlVMcTg1ZW9zUnprcklRanAw?=
 =?utf-8?B?ak1yNUdNZFVrM1lBZm5JOWpkWVFkN21NOXdIK1pEU3hLMnZGTFpEZ2JUY2ZB?=
 =?utf-8?B?Ym9zZS84TVUzV3hnTmRJQzFrZ0NJZXRWaFAvYWlRMWFkZ1I2QWJRU3lpTlNF?=
 =?utf-8?B?T01ubFc4K21XVkZHN1lmZkJiV0tkcG9YaUJzRHNYQVQwOHlyMHFHc3Vyd3Rk?=
 =?utf-8?B?RHZoZWVVS0IrRCtpWFJvanFJK3A0YmFjb0NjU21qYVlXL09Wb21ldEltRDBu?=
 =?utf-8?B?S0pzVWpkZzlKS2xyNUEydWNWN0dFWGNubFh1bUsyaE1sNGdZbGEybElsSzhK?=
 =?utf-8?B?THlHZktxOEY3ZWdaZk9MWWg1dWNlazIwTVhscVQrRTdFc0Y0L0h5MS9yM0JG?=
 =?utf-8?B?VWxheHBGZ25KZ0R6WitCNHJ1ekFFeEhkdGlnV2oweGE0MkFiYlJLMy85aTZG?=
 =?utf-8?B?YURIK2hDTEZKMnBLMC9xYXJGUnRjb0lMWldHU1BDT1FYV0E1cnZ2QnZYeitK?=
 =?utf-8?B?RGFzZlNFbkJIOFYzTnpCTlh1U1NYR2o5bHIxeHQ4cGdYMG9zOUNXMXhZK3Bk?=
 =?utf-8?B?ODBVbEFWdWpna3dhSi81bWFlNytjWVYzUExhVTgzZ2dNa0R3dnlOakJVcmFl?=
 =?utf-8?B?TFc1Tld0ZnI1QjUwblVXT2h1WVc4b1BiSkF5WGJRSnB6dkV3aXVVQWRlK1Jz?=
 =?utf-8?B?ZmJqR1dGUUh2dG9qaVZkbk5UbjA1dHoydWdEUnFEbDZzWEVZS0NJY01kcVU2?=
 =?utf-8?B?Qi8wRW1xSDBKY0h0YWpBNGZrbjBCaHVCZlJveEZQN1F5UithdTliby9TUGdH?=
 =?utf-8?B?TEtpVm1vbzl2NHhxU2lHVFZOK0lyQ2RrckhyUDlaak41VXFNWE9LdXVrSEY4?=
 =?utf-8?B?MEt1RnBKMDdCSjdNS3FDbFoxa3ppM1VaT0g2d3dYSERNWVNQaEExcU1MUVZL?=
 =?utf-8?B?bjVQbm9QWnVjVFBrbVh2dWViOTdoa2phamZrM0lKeklCUlNDdS9rS3M5M0Vl?=
 =?utf-8?B?TzNvMitTSXVBbDc2TkZwWFZaSWVKNURSRXlkYmNoTDVRUUdKd3JFU0hyUFVk?=
 =?utf-8?B?bk5qY2Z1ZHhrSmNSaFhuOWt0MENaNFFPMWlIN0NKSnRjSTFwU2NBazNDbWhY?=
 =?utf-8?B?QjRFeEVENWpNdTRrSytRT3JzUGxZa2dwQ05rZE1iUjBmdVJ5bklualVPN3E4?=
 =?utf-8?B?S09WUW44NnVLR0xJTWdxT1B4TlZRaW83S0ZYY1JvQnd1Wk1BaHVqUGoxVHdV?=
 =?utf-8?B?NEVQOU13YkVmQ241MGVrU0gzL1Y5NDVCNzVSWGhzeXVsT21TcGNrYVg0NTlG?=
 =?utf-8?B?RFZRM1R0NTAxdjdVNDJSSGZhSUhVQllVbEZCS3A1NzNKY2dJaStIcndiMHRz?=
 =?utf-8?B?RUtPUFhMelpJTDdSelVrNUg0VnVuVG53dHIvbmNWczRwOGI4Uy9POW9XcWtP?=
 =?utf-8?B?NjhLa09mU2JTdFdUcUxEemlRM1pJc1FEV0tsZmFMcHR2VU5ZTHJEem96OUtZ?=
 =?utf-8?B?a2U3K1BzUmZZallwM1UzdUROWDFrcHlIYUdlQ0tDZUlQK2pUb2VkYjFnVzU4?=
 =?utf-8?B?eDJNWHNkeXhiY0dnT1BZZlRMMk9MdmJOaERJbUE1R1FqU1BJYzViRG1mM0dR?=
 =?utf-8?Q?Ix7y9NGJANpfDQQrOP5R7N55R?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49fb9cd5-fb03-4a05-67de-08da8abc7472
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 19:18:44.0048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f8B4h4X+fWuolyPVYZ/pia2zqlaRVnM0NU/KXoEquznmjGt/fFrUB5K4jDBMGhTVcnCMgVV0OjDOayniORgMyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5614
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/22 11:53, David Hildenbrand wrote:
> Good, I managed to attract the attention of someone who understands that machinery :)
> 
> While validating whether GUP-fast and PageAnonExclusive code work correctly,
> I started looking at the whole RCU GUP-fast machinery. I do have a patch to
> improve PageAnonExclusive clearing (I think we're missing memory barriers to
> make it work as expected in any possible case), but I also stumbled eventually
> over a more generic issue that might need memory barriers.
> 
> Any thoughts whether I am missing something or this is actually missing
> memory barriers?
> 

It's actually missing memory barriers.

In fact, others have had that same thought! [1] :) In that 2019 thread,
I recall that this got dismissed because of a focus on the IPI-based
aspect of gup fast synchronization (there was some hand waving, perhaps
accurate waving, about memory barriers vs. CPU interrupts). But now the
RCU (non-IPI) implementation is more widely used than it used to be, the
issue is clearer.

> 
> From ce8c941c11d1f60cea87a3e4d941041dc6b79900 Mon Sep 17 00:00:00 2001
> From: David Hildenbrand <david@redhat.com>
> Date: Mon, 29 Aug 2022 16:57:07 +0200
> Subject: [PATCH] mm/gup: update refcount+pincount before testing if the PTE
>  changed
> 
> mm/ksm.c:write_protect_page() has to make sure that no unknown
> references to a mapped page exist and that no additional ones with write
> permissions are possible -- unknown references could have write permissions
> and modify the page afterwards.
> 
> Conceptually, mm/ksm.c:write_protect_page() consists of:
>   (1) Clear/invalidate PTE
>   (2) Check if there are unknown references; back off if so.
>   (3) Update PTE (e.g., map it R/O)
> 
> Conceptually, GUP-fast code consists of:
>   (1) Read the PTE
>   (2) Increment refcount/pincount of the mapped page
>   (3) Check if the PTE changed by re-reading it; back off if so.
> 
> To make sure GUP-fast won't be able to grab additional references after
> clearing the PTE, but will properly detect the change and back off, we
> need a memory barrier between updating the recount/pincount and checking
> if it changed.
> 
> try_grab_folio() doesn't necessarily imply a memory barrier, so add an
> explicit smp_mb__after_atomic() after the atomic RMW operation to
> increment the refcount and pincount.
> 
> ptep_clear_flush() used to clear the PTE and flush the TLB should imply
> a memory barrier for flushing the TLB, so don't add another one for now.
> 
> PageAnonExclusive handling requires further care and will be handled
> separately.
> 
> Fixes: 2667f50e8b81 ("mm: introduce a general RCU get_user_pages_fast()")
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/gup.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 5abdaf487460..0008b808f484 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2392,6 +2392,14 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
>  			goto pte_unmap;
>  		}
>  
> +		/*
> +		 * Update refcount/pincount before testing for changed PTE. This
> +		 * is required for code like mm/ksm.c:write_protect_page() that
> +		 * wants to make sure that a page has no unknown references
> +		 * after clearing the PTE.
> +		 */
> +		smp_mb__after_atomic();
> +
>  		if (unlikely(pte_val(pte) != pte_val(*ptep))) {
>  			gup_put_folio(folio, 1, flags);
>  			goto pte_unmap;
> @@ -2577,6 +2585,9 @@ static int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
>  	if (!folio)
>  		return 0;
>  
> +	/* See gup_pte_range(). */

Don't we usually also identify what each mb pairs with, in the comments? That would help.

> +	smp_mb__after_atomic();
> +
>  	if (unlikely(pte_val(pte) != pte_val(*ptep))) {
>  		gup_put_folio(folio, refs, flags);
>  		return 0;
> @@ -2643,6 +2654,9 @@ static int gup_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
>  	if (!folio)
>  		return 0;
>  
> +	/* See gup_pte_range(). */
> +	smp_mb__after_atomic();
> +
>  	if (unlikely(pmd_val(orig) != pmd_val(*pmdp))) {
>  		gup_put_folio(folio, refs, flags);
>  		return 0;
> @@ -2683,6 +2697,9 @@ static int gup_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
>  	if (!folio)
>  		return 0;
>  
> +	/* See gup_pte_range(). */
> +	smp_mb__after_atomic();
> +
>  	if (unlikely(pud_val(orig) != pud_val(*pudp))) {
>  		gup_put_folio(folio, refs, flags);
>  		return 0;


[1] https://lore.kernel.org/lkml/9465df76-0229-1b44-5646-5cced1bc1718@nvidia.com/


thanks,

-- 
John Hubbard
NVIDIA
