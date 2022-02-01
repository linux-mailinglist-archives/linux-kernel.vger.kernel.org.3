Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E40374A588B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 09:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235515AbiBAIdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 03:33:09 -0500
Received: from mail-co1nam11on2079.outbound.protection.outlook.com ([40.107.220.79]:25409
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231880AbiBAIdH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 03:33:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FQdfBN6avFxFmULbhQBTAThgCLLhs2qMpaShB2nOBZiQrrXXarWJWPCcbaK4Io2JNWTzetiQ/v+HB9Wgth/J72moA/IqTUEtgBZS/B6dfIz0+PqZ75iaQamWIDMmPjur5Sb5S/IRmYbMJsMXv2qhAbh5vhUFNAo/LEVEM3b2MwCvtJBfuBwsyKLsiBhyH5o+ui9P6Sr5n4DcLli029nuynZxqWoxGhvZoHcjV/5WAQDiSgcLslEwN+HwgTSRD6ZJrOfBWHvnWqbY9wU2wGba7WCdl6kNBuD1Ys+0m/Gi5e5VYWFsJYeolEdHlhaAxU/35bgBTakYM3/23FHRjstnwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HHtBxzcdMonPcgsl3oVzUQEwsLA28L3mkdSipJjxXbA=;
 b=LExtD2Zj/YAQL24+Vrutbc4zwdb+s+eUNfRhK6IJeEMofi7uX7+2gkuRL8FRz7dG3qBvXx0qS8K++wCLcyzYyxZpbTLlCRF8QW113rSWqY8RipadrvD1TP0271+8wSZO33RPpI3E7MFl4XFXr8t3q1emJO99ZqcQnLvDcJb3SFLJ6W2Dr2VV/V5r+6YPA89Fk1A5sC3LSenxa1HkbSZk7fzH/7VXmeZdNEdh5noDjF/pqq2I4RAyCwfJYnUoLYtQqY8jzhuI+Uya2PUj/eXa6A5nnbb9RWd025bk4i7QwEVdKgFv8nGRC1giIOxHeQCZ0kHBip/SMK4RzeDY6XsTjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HHtBxzcdMonPcgsl3oVzUQEwsLA28L3mkdSipJjxXbA=;
 b=EMwrilEeNh3qIw0jRg4zd47ET4ckioCFxbZ6vJWs/H/waQYuC16kp1jbFFsvs1sGQsTVBxtq9dLQPi0v2LUAS8lKpSIzug0hifDOwrXnr4Bs+jYUd0d5wex+QRoaFh8HMZ4xEyrBLTCiGMO5DuMvoksn0+fihGf9Mdeht1T4jTEoPyEa7pcjvk5vlWa+bQweFBmsvzYX8K6qeEhCp46pSV+P5z5XVmqli5ATb4WkzPWiBvjDiKOvtOlYc9yte6xNYvBjoYA0Z7IOv931syS29EMCRt3xV5ep5MqJRo5DSLFHQHwjvO72s5k/EGM2QOsNOVsVfiVgVqP7y1watgiT0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by MN2PR12MB3294.namprd12.prod.outlook.com (2603:10b6:208:af::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.20; Tue, 1 Feb
 2022 08:33:04 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2d75:a464:eaed:5f99]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2d75:a464:eaed:5f99%6]) with mapi id 15.20.4951.011; Tue, 1 Feb 2022
 08:33:04 +0000
Message-ID: <48a32ceb-0540-7a88-1fdc-419708d2bb8d@nvidia.com>
Date:   Tue, 1 Feb 2022 00:33:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v1 1/1] mm/gup: skip pinnable check for refs==1
Content-Language: en-US
From:   John Hubbard <jhubbard@nvidia.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Will McVicker <willmcvicker@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel-team@android.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220131203504.3458775-1-willmcvicker@google.com>
 <27e5f98a-0709-1a80-18ed-e4ccaaf39fe6@nvidia.com>
 <YfjhGKCkQ6h5H5uI@google.com>
 <36068cbd-2020-1961-5034-866a4c7b20cf@nvidia.com>
 <93a8440b-a5f5-1ddd-0834-57808c26d9bb@nvidia.com>
In-Reply-To: <93a8440b-a5f5-1ddd-0834-57808c26d9bb@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::36) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9938e55d-9979-49a2-a833-08d9e55d775e
X-MS-TrafficTypeDiagnostic: MN2PR12MB3294:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB329458B09B08F546E13D731EA8269@MN2PR12MB3294.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:262;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UWidhg513X1KzzbZJpObgqq/K8U+6HjkxgnyZUojZlFs+8YmAmbf9KZ2bdMIuYj39OqK0Y7zC2041NvXE8ksmtYpudjh4dOAREJY+DqQG2rrs3UfHTXRuGYub8xTUFxppgoCewfMfdmGTjMeaw2zvDCGQiX4hBj69wulxVUGdKib0CslXaRdM7+WJIn/dPiLXub6s4YSguVdKz/3QK3r9PdjFM7rR8/zYS0OJ9KUT0/5iO7zBqNGThKCH6PeI34y3yL52/6L5FsnMNE9QSXOt14gtwFen3bi9+3/CjBcK6a+anyl5BGceMLBUfEbP9qf5JGTlIPWs+Ww8vzRXYcOWfVOfqxiTtx8MThCRi1H3C4QOr+n+HtSXdkZFC36YI7i4bjaz9SbTpCM/5dawx6XOqhabuXMlD8utXQtg8WZtkB4lbpdfO66ooo6rAhPSzMLgk9h3pkXurbQRQXqfZzFGMHDSowRjbI+3UsppMiovad7cgGcPAgEvuTe4WAi5ylT+0rsT+UO/HVrmQ26UGTQ1C1lbIenzUx7QScljKkftDiLhAhlKl4ze6uPwI7hWUx/HyelPFyXbDZ7d15CnQPrnluYoDGGuHDoggPYbldrJA6rsLIGw8B3r6o6Ei/ujsYaZsiW/3+0vC9sHxkT8ZUB5B+GTvRXnJgdDQb8W1oUDSNO3WqYnRY5KrGXP2fA+jlIzGUaxukn4IcFeRpJROCNu2lpK5oXfmMfqm13UEEgz1WWioYZvMDfOFjPG9QrE9nz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(54906003)(31696002)(6916009)(36756003)(26005)(508600001)(2616005)(86362001)(5660300002)(186003)(83380400001)(66556008)(4326008)(8676002)(8936002)(66946007)(6486002)(38100700002)(6512007)(6506007)(53546011)(31686004)(66476007)(2906002)(45980500001)(43740500002)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajNsNFQvcFVGc1RYZHY1czFxK2FWS2ljNEZQWHZiODRPMGtkK3dXUlpnRVMx?=
 =?utf-8?B?dmdvNzVrUzBWaDRoZUkyMVVpZ1dzWWZVUXFyNlJ6NDljTE1kdTlLY1JjYWZ2?=
 =?utf-8?B?ODVIREJXQkNmaythaFk3VU5jbHRIZUViQTQwZjFUNTk3TXJ3cTNLWjllZ0R6?=
 =?utf-8?B?ZkRlUTcrRXpqR25ld1hSVFJhOFo4T3d4aUU5VnJCYjZINE0vMWZNU2JhZ3ZV?=
 =?utf-8?B?K1FzdFc2elkxM2d2Q08rejlpZ1A4TWRXSWRVZjEzU3lBajlmakJxRU9jMW4x?=
 =?utf-8?B?anhlTWlzVVNNdWUxN2ZLVTVJUkx0OWJZbkx4eUNVUmptRnhoUkVEQnRiMTE2?=
 =?utf-8?B?NGdBakZycElsZkIrRU41cnc5TllYYjNRa1RzdFdmNTNQTCtueHZsK3Vwb3Iy?=
 =?utf-8?B?MkZ3L2YvbFpMRjBHRDdHTlB2QjF0RW04V0g2eTJNQS8vclhwd1pYT3hKLy90?=
 =?utf-8?B?bFRMbHpMSVpCWEdkVUFNM0pmaDJLbmE1ZUJXUlI5M1I3TzBqM0pxaHAxSzZZ?=
 =?utf-8?B?a1hTTU9ad0VMc0lYUW5iUmM3cWZZL3NrNmprRzFmbDFkTE9Nb2NYRVo1UDNh?=
 =?utf-8?B?ek42V2lNN0VXd0phcCtZWkxmbVZxZm42TE1ScWEyS0FjS3FXLy81WTU2RVM0?=
 =?utf-8?B?REZaZGFTd3ZIb3RLMjVMdzAvOXNsOHZOblNFUzN5WEE0cTROMVRGZFNINFZs?=
 =?utf-8?B?MDhiZ3JnVi9ocEtSQ1NSdGt4aDk1Mk9xbjl4OE5JNWxLa2tLMnR2Yk5IRkxH?=
 =?utf-8?B?eVJPaXZhL3UrRUV0V3hJSmpoZmszWTFTL2RlMFlJQVBaTlVrS3NuK1FTalgz?=
 =?utf-8?B?aE1WanJaYnY0NmJqNkwwN2RjOU9LTWMzRDB0QW9YTnJZTFZSQXlPZWVCbU1r?=
 =?utf-8?B?aS9CS3Yzb3krWWJkYmxLUUNkRWtmMjlnNnNQTWVhUHRMSXU2TW1Zd0NLNHVY?=
 =?utf-8?B?YUFzOVlETUFTVWtTZTlNT1hoNGtMa09XY2F0L3ZLa05ZV3FSOUpxdldMNFZD?=
 =?utf-8?B?clp2MDRVSVMvRUxMOTZRUGlOcHBEajNkMURCUUV6WXhaa0wwa1grdzFXSDMr?=
 =?utf-8?B?OHB6TVo4NnIva2tpN1pkK1liY1FOaGlETGhFbXAyL0RlVmFDWVdyeXlPakhL?=
 =?utf-8?B?N3BJL0FjZm9Lbng1MFJPNHpONndYeVNzRnMvUTFmRGswMDNGbzd4eS8rb0dO?=
 =?utf-8?B?eGlzR3pTQktNQkpuY1VrTWl4UWJnbUd3NlZRR2VpTTJON3ZsRTRaREJscDBP?=
 =?utf-8?B?b3QzaXZpVGFVTEduMWNENVhmNlBsSGFxWHl1RTZHejhkRU5HN3ZMQnVPMHJt?=
 =?utf-8?B?N3g0ZHY3NTcwTTR2Qm1jR2xFSGQ1aGs3QnlhWEdJRzU2TWF2L2dqSmtDWlRj?=
 =?utf-8?B?NFU1K2svbTFua0hMTVkwRDJ0eWx0V3hCZ0c4TVllc0hDQnhlc3RWZXdyR1VY?=
 =?utf-8?B?VmlqMng0MVJiS3ZhUjJVSUZDSHV4R0cwNjBrUWk4ZEFsSVlOZSs5WjI3UU1U?=
 =?utf-8?B?REI4OFdqSEt1YnJkMWJSUEN0bzNobGtNZVNBQkRaUTNUSm1hU1dzaFYwSUZu?=
 =?utf-8?B?anpubmwyTk51UUx6dlhBa29ITFI4WFBVVlVCQzM5KzYzMEp0M1hza2ptdmxv?=
 =?utf-8?B?SGEvRnpJeUprUmEvemd1aDNJalFOUGNMNWhKQTI1cUVhVVRyZ3dVMVlSSzdL?=
 =?utf-8?B?SENPemFkVWtRcmF0UWRZcjM4SFBJS3FIRzFXcnVYWng2bVFycW94S1hBekUx?=
 =?utf-8?B?MUVWOUtoNnRxSkdHcGMxQzRhcVUxblhsY3FiNzVST2VWUVJ4QTBxSDdXRElQ?=
 =?utf-8?B?d05ac2lmQ1krUFFSdFROOFRXWlVvMHBqYmJmQ2R1ckxoR1pvUlZDQlNPdWpX?=
 =?utf-8?B?UVYvTG5OcjVCMW4vUnExNmlEYTlXMktUK2hmNjlDV28wbXI5ZWgrbWc2Y1Nj?=
 =?utf-8?B?Q1dnOE1hMWwxSkxsekhBVlhFVTdXTkFWaExMTy9QTTBWb281YnhaR3BNQzJH?=
 =?utf-8?B?N2NhZ05TQlJTL21RM0owcjFZWWVYSkFrM0RrNzZEQ2kxOTg3K3pJNlcrdVdC?=
 =?utf-8?B?S1FueXgzQndVYVR0L3R1eVJHV1pvVWdKOGFpcFJ3eTYvbTRZeWRYYkZmdWt3?=
 =?utf-8?B?K0dtb2l0MEh4MXozQ0hHTUg0Vkd1VjdpcXAzRzdGRXVrZXc4SlRwZjBDaHc3?=
 =?utf-8?Q?Lbs+v5usb/VXyatJ+XinNoc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9938e55d-9979-49a2-a833-08d9e55d775e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2022 08:33:04.8765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XS6R2OoeJ0e1GIVD/B0wV+kuLqErJrQqyAmJqOhroqC6tzQ3Ng8RaZWt9x6GKW9LLlFXo+0eV1Nu5tVD83kZXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3294
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/22 23:43, John Hubbard wrote:
>>> pin_user_pages
>>>    __get_user_pages_locked
>>>      follow_page_mask
>>>        follow_page_pte
>>>          try_grab_page
>>>            !is_pinnable_page(page)
>>>              return NULL;
>>>          return ERR_PTR(-ENOMEM);
>>>       return -ENOMEM without faultin_page
>>
>> Yes, that's all clear.
>> ...oh, but I guess you're pointing out that it's always going to be
> page-at-a-time this deep in the pin_user_pages() call path. Which is true.
> 
> I hadn't worked through how to fix this yet, my initial reaction was
> that allowing single refs to go through, while prohibiting multiple refs,
> was clearly *not* the way to go.
> 

OK, so after looking at this some more, I think that the real problem
with commit 54d516b1d62f ("mm/gup: small refactoring: simplify
try_grab_page()") is that it funnels fast and slow gup through the same
routine (try_grab_compound_head()). And the problem with *that*, is that
try_grab_compound_head() is coded up with that assumption that it is
being called *only* by fast-gup:

		/*
		 * Can't do FOLL_LONGTERM + FOLL_PIN gup fast path if not in a
		 * right zone, so fail and let the caller fall back to the slow
		 * path.
		 */
		if (unlikely((flags & FOLL_LONGTERM) &&
			     !is_pinnable_page(page)))
			return NULL;

Now, to fix that, I'd really rather not conflate "refs == 1" with "on
the slow path", because that's a conceptual mismatch.

So, other ideas:

a) Remove the above check, and fail fast gup at a different point for
the (FOLL_LONGTERM && !is_pinnable) case. Haven't looked closely at this
yet.

b) Pass in FOLL_FAST_ONLY from all call sites *except* try_grag_page().
Skip the above check in slow-gup (!FOLL_FAST_ONLY) cases.

This makes the code ugly, though, and I'm just listing it here for
completeness.

c) Just call the entire refactoring idea a mistake, and roll it back
either entirely, or enough to keep fast and slow gup separate.

Unless a better idea shows up, (c) is probably the way to go, I think...


thanks,
-- 
John Hubbard
NVIDIA
