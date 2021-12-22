Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF9547D76B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 20:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345073AbhLVTIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 14:08:45 -0500
Received: from mail-eopbgr20105.outbound.protection.outlook.com ([40.107.2.105]:29719
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233746AbhLVTIo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 14:08:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XG1R9mfPJqJV2hQhiLsl8PXE3RmNiOLSk/YDzrC2qQZ3WAiZDkSG6kBWCoMK/b/rn2s3Ja8dvIsjJ14iVn7gKs0c+5JYDcmIWN1oEIBteSgTXpo7+2LRb3CNTTMgB8Keii5XDO/3tU8Vmq6CS+vBhNPS1Fe5/YyB9LgNekfWb7STSIlKfmCvigk8XHaauF1rS6tfFVAszifch8O6Vi6NQbq7SC5aeBTVWcbTICZyn5BqXpw/TMvW2XC9DScxFiwYVEDWglGeUMCbO1Z4bKrjgZZvnVCbPUw3TsbdplMlvwq6q/awmZeU7kkm6+HzxF6kpHKmOt+ONU6lm65WusNtNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oPWntKtAnpxz5Oqv5WLR21GJuDnIsfgBzHOKzeJSsJ0=;
 b=kZx9svWKcWMDSV7YGteh/u9X82hwBy+rX5uXcuJ4fRAC3Mfr8IwtxR7UoRFGj4Mz7ULmXNldGyJUxrt+YVnzU68TyNBMa1achOdaHLr5myz4sQyz54WTIdfiueLt1G+em4v4stxzSgXGYyMJAo1ow2U+WOlNEKTtUocLZEAe+ZGwWKgmDpbEFzIh3VM6rZ1xpETQqnm6DE9wH8m9OliNUECYT27bqiZDkLdJHULh+1fSE/kU5rCN+ZvYTQX0ccStv59o7JDHEOnvJDzZqK0U7XJ1xt5IntwI1uQRyXvSSpeYxSM0O6N/GgjHlS0HTyPPkXiVNHgStyoNGPkf3C8t4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPWntKtAnpxz5Oqv5WLR21GJuDnIsfgBzHOKzeJSsJ0=;
 b=j7EgMK3UaVwvsqSZWbnxfXKkEOpoqqwoqh47FMuHsUJRvOUM6X6P+TOwiL9GZLvU2L2b/ABKC6qQ6BJXGwVj6SERQCv0St2feojNJHn+kio7efVFoXFp0FA9N5Az2bypNO0Tm/MVPbNKQSWqxt1ATKmM9XiojQIjhm5rV0o6rYk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DB9PR08MB6619.eurprd08.prod.outlook.com (2603:10a6:10:257::21)
 by DB8PR08MB5497.eurprd08.prod.outlook.com (2603:10a6:10:11a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Wed, 22 Dec
 2021 19:08:41 +0000
Received: from DB9PR08MB6619.eurprd08.prod.outlook.com
 ([fe80::347f:d385:ec53:75aa]) by DB9PR08MB6619.eurprd08.prod.outlook.com
 ([fe80::347f:d385:ec53:75aa%7]) with mapi id 15.20.4801.023; Wed, 22 Dec 2021
 19:08:41 +0000
Subject: Re: [PATCH] ipc/sem: do not sleep with a spin lock held
From:   Vasily Averin <vvs@virtuozzo.com>
To:     Manfred Spraul <manfred@colorfullife.com>, cgel.zte@gmail.com,
        akpm@linux-foundation.org
Cc:     shakeelb@google.com, rdunlap@infradead.org, dbueso@suse.de,
        unixbhaskar@gmail.com, chi.minghao@zte.com.cn, arnd@arndb.de,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
References: <20211222081026.484058-1-chi.minghao@zte.com.cn>
 <63840bf3-2199-3240-bdfa-abb55518b5f9@colorfullife.com>
 <1181e64b-94c0-908a-b9e9-1a38f4610430@virtuozzo.com>
 <02171384-9d1e-19fa-5fa1-5f84b720a03e@virtuozzo.com>
 <4d786a02-1560-25ed-4603-8419672ec044@colorfullife.com>
 <d89356b2-c7d8-a3d0-5d3f-1ef37b631193@virtuozzo.com>
Message-ID: <bb788afc-b267-987c-278f-b844184f4767@virtuozzo.com>
Date:   Wed, 22 Dec 2021 22:08:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <d89356b2-c7d8-a3d0-5d3f-1ef37b631193@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6PR05CA0020.eurprd05.prod.outlook.com
 (2603:10a6:20b:2e::33) To DB9PR08MB6619.eurprd08.prod.outlook.com
 (2603:10a6:10:257::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8f1f0c8-ef64-4cae-8dc8-08d9c57e7793
X-MS-TrafficTypeDiagnostic: DB8PR08MB5497:EE_
X-Microsoft-Antispam-PRVS: <DB8PR08MB5497EEF81C0BB5EE1AE6327BAA7D9@DB8PR08MB5497.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: crAFXb7BGNIt2sZGeI3Ot+H/tG0twofLF2itft7XoGf1YUKQupNRUT401clI5FWH5EWr9G0Uzn5VOeiuAC8nJS4hGUj7G3neU8NECKyF9oWnXsl5rEDQgpQlNvbyvVesospWVsdsjsfaMWjldXRLGrcgKkUfa7pfKEfj3ajac/ah5IlgbhH5DgHVL1c8GtaddPeVQkZi1ttLwvXzRrkDKktbdntIBTCpqfISdMA6I7vmtyk7RNwf1WB02GsuuT9MkuS+S7hqGgxl6AwAf+jrJfQe8Qb7tyKwD2KbcAydcwwwLkw3bwsYrzmzR+lqK/fHiJlnuNOF4npTVd2Jn4IclfEM3MaQ9TYpZqHrj0VlMHY1KvRlKFrSJI78RduXOLa258gbs93jikVPr0b+bdMqOpn1YciCaXPAEPDILuPcZWl40S4BB9FRVxi/N+AHLOyk5/QUrudHCBK8SWkEgat0Dl0/ITcf5STmTRt9UMSpfR/sJXgsPuhzuUIQJZpE+Yhe+wuhlx2DfYLkiyheoGCNphayLDQocev2pGbMxqpoQdk9HZiRWt3ifhnb1Yz2jzOmYYAwXnzrf2BuuECMmjzIuLYgzrgw4/5NNOAcSP7I/QZtSwxnofFcf4/hfZTR6DGiNcXWrq59nJ7k66wz1LVN66VPiG+pEuVwpF66mmJcyy5qe3HfzAnMdfEMNZucLozpqfXgd+cm9H60iQ9eGZb7ReZUwRqi6XKL6mXrkgHMkUqOQ7+MuTtxeahfOwnq87ydqQg/bu+zD0KkqeZr4cFzpA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB6619.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(31686004)(508600001)(6506007)(26005)(7416002)(52116002)(186003)(316002)(53546011)(8936002)(5660300002)(86362001)(38100700002)(38350700002)(6486002)(4326008)(6512007)(83380400001)(66556008)(66476007)(31696002)(2906002)(66946007)(2616005)(8676002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVQ3QWZCWmdtTHRWTWFQUkQ0MkV0ZVg3K0JyNFdRbmo2QWllOUpScXRpVDRi?=
 =?utf-8?B?YjllT2QzYUZZMEI2dnFaM2RuWkxxd25PSVZkUTVSVUVpWTRmeStLcXpJeTl0?=
 =?utf-8?B?Y1VQTm9yc0pRejQxWUp5eTJXd2k2Vk5Da2VIcE1yZWR3Q2xuRkYzUmtMaEdL?=
 =?utf-8?B?WDY4eCtQVi80M0VEelZTa3RMVnJsLzlpSjZPT3hkUVI0UHFwK3dub2txVXJ2?=
 =?utf-8?B?ZFdFNFV2L3NXaDE3dFFMVG9meEtLSzJHLzh1cjhqSU1zRTBablZXY0pIK1BR?=
 =?utf-8?B?YWplNklXeHE2aXF4RVA4MWFFSWJHMlhXSXMwTjhtczE1NDJsbGhYTmFGVG5p?=
 =?utf-8?B?Z3dpY2Zod2hZalp1aWMzblN5RmdoMkttWTJnSkttak1rNVozK2xlVldWUVNy?=
 =?utf-8?B?R0RUdEZJbkFhZitUeXY3VnQ3SU5tNmJzdmJwRktTWG9Ea0lrUVo3NU5pVnM3?=
 =?utf-8?B?TnFTV1h2ckNCZ3I0aGcvVFdnWTdHYUNLVEdaYXF2VkZSMTk3bjdpSGZsak1V?=
 =?utf-8?B?MWx2SUNGMjJnYjNWYUVubTJJS1daa25Cak9QY0pzSGZBWWpUWjlITml5QlV0?=
 =?utf-8?B?TWhIKy9oVUMxY0JjS0JuSXR1U2JpZmpxQ1I5TjhoL1ZhNDlDdWRYbGg3SHRJ?=
 =?utf-8?B?MytOdlNMN1dsNUNXR3BQK0kxUW5YdjMvUnU0T2dlSmwvZjN0VTEvZG9vWFdM?=
 =?utf-8?B?Rzl3MDVyemVJWXl5VmY5a093bGNMdDlWTUdKaHRmbmwxR0NmeHloNm5RTnFM?=
 =?utf-8?B?djd2dVBRWmQ2cURCc3VjUTdONXd5N3N2bmp3L3p3N1hUN2JPWFlMdmFWd1lX?=
 =?utf-8?B?bnFocDFONFpzdlBIbHZMZk53ck0rSVVhV1V3RWxwdmdRb0w1N0IxRnlFWXRs?=
 =?utf-8?B?M3krcTRnUElsMGdjNHFBMVlYK1h4WnZybTMwd0h0cTdhMEFBbGNzTkM2em9Z?=
 =?utf-8?B?ZGcwL1IwR0haZXdsT3krbXpMd0dOWUt4RGhSc2tJMVJaT283eXIwUVgxZXFm?=
 =?utf-8?B?Ym4yNGd6VTdvemtkekptTkIybHRUN3p1bFFkOTZnamYwLzlCNVJKOUVNNGNp?=
 =?utf-8?B?RUhVSGsyUlFaNkpuNyt4M3FQSzF0dUZSVG9lNGRzVzNDMEVTd3VVQW5UQWo1?=
 =?utf-8?B?U1VtWmJUQ0ZINWJNUWh6amNLZytmQ3duWWo0cFFoTUpmY2JTMklGVkM4QUFh?=
 =?utf-8?B?Tk4xUlRsWGw4M2U1TkI0Tk4yeW4ydWxxVDl2bTJ4aE1hSVBHeEdYOTdDcXhB?=
 =?utf-8?B?ZUFmb1BXUXk0RzdzN2xXMFlpTTl5b1hWTUJobmhDdkZYSGVZbnYycGJSRmhl?=
 =?utf-8?B?eXFyUWVtZjZRbU5pL0ZRb0o0aVhpWlBTMG8yZlQrTWk5MXNQWlVScTN6b0dF?=
 =?utf-8?B?cmZCZkdFUlpwSmJPb3dqcU44L0dQTXI1Vkk2eDdncnhzc2pUVFNTQk9XMkpj?=
 =?utf-8?B?Q29yaUNlSFlzblBETEIzMEQ4UmZWaEtXQllYUVhSQ0lMcHNKQklnUHZvdzJt?=
 =?utf-8?B?WHl3dGR5UFQyanVMWS9zTm1qSGV4SmhaT3I3ekZWY3dtMGZJQk9UMElrbFhP?=
 =?utf-8?B?SFNnRk1LN1ZYb1hCYTQ0cUwyQW4rM3dBbzUxbkVuK3RYR2pMR2dhbHJlSTc2?=
 =?utf-8?B?anJTZHBHOXpMUG56WXZzWjNhZGlFVWVla2htc0ZuWlFoZmNDTElEbWZDNVBl?=
 =?utf-8?B?b3hMTUl2U3FtZzgwN2RoZXh3RmtJNThmMFUwRVErTHlQWHdRQTcyZXB0UjJ5?=
 =?utf-8?B?Q2VkbUFQdjZnelU4UGtGQktPSmNvNC9wbFltTmJHcHViSzg0YWNJWkhqZmZI?=
 =?utf-8?B?Z04xc09URzVhODIyeDhkTmErakxXUk0xNzFWdVE0cjFNN0RJOXRPelptNE5p?=
 =?utf-8?B?dVRYRlhGMzNCM1ZuVTdENGVoOTBVeDNlSTcxTEl5VFphL3ptVFVpdmJuRXhN?=
 =?utf-8?B?ZzRUUGFLQTlXeEdPWFpXNE1SQ0N3QVMrK29UYlM3d2VBRjlwK043cTJ2Sm5w?=
 =?utf-8?B?dEFocmhHM2pFNjUwU0dLUnhZVDdXcm9RLzhsT090U2loamM4dlQ1ckZldnFX?=
 =?utf-8?B?eXd6cTdlTDk4RnhiZzE4ZDE1OWw3TjhWY3lQMTl3MFFrZTJ6UHNGUzRxT05k?=
 =?utf-8?B?RDBvK05VcHRzSVZ1N0pJa05mTUVaMEhxaE5OREhwbzdxMDhiT3ZUVnJpWkVI?=
 =?utf-8?Q?XFqrFZx8YDq3mycExE98MxM=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f1f0c8-ef64-4cae-8dc8-08d9c57e7793
X-MS-Exchange-CrossTenant-AuthSource: DB9PR08MB6619.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2021 19:08:41.6039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U9hgAH+rAtcXKELh6o3OGMWTi/y0qg08dWrpkVOlL7ZpRI6x9PXKOJvhSZO5c6jCnYzjRovwfnQqhgWMIdkWaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5497
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.12.2021 20:38, Vasily Averin wrote:
> On 22.12.2021 20:06, Manfred Spraul wrote:
>> Hi Vasily,
>>
>> On 12/22/21 16:50, Vasily Averin wrote:
>>> On 22.12.2021 18:31, Vasily Averin wrote:
>>>> On 22.12.2021 14:45, Manfred Spraul wrote:
>>>>> Hi Minghao,
>>>>>
>>>>> On 12/22/21 09:10, cgel.zte@gmail.com wrote:
>>>>>> From: Minghao Chi <chi.minghao@zte.com.cn>
>>>>>>
>>>>>> We can't call kvfree() with a spin lock held, so defer it.
>>>> I'm sorry, but I do not understand why exactly we cannot use kvfree?
>>>> Could you explain it in more details?
>>> Got it,
>>> there is cond_resched() called in __vfree() -> __vunmap()
>>>
>>> However I'm still not sure that in_interrupt() is used correctly here.
>>
>> I see three different topics:
>>
>> - is the current code violating the API? I think yes, thus there is a bug that needs to be fixed.
> 
> I'm agree. Found issue is a bug and it should be fixed ASAP,
> I'm sorry for a mistake in my patch.
> 
>> - Where is __vunmap() sleeping? Would it be possible to make __vunmap() safe to be called when owning a spinlock?
> 
> I think it is possible, and we should do it to prevent similar incidents in future.
> vfree() should check preempt count to detect this situation (i.e. execution under taken spinlock)
> generate WARN_ON and then call __vfree_deferred() to avoid sleep.
> 
>> - should kvfree() use vfree() [i.e. unsafe when owning a spinlock] or vfree_atomic [i.e. a bit slower, but safe]
> 
> I think it's better to change vfree.

I mean something like this:

--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2674,7 +2674,7 @@ void vfree_atomic(const void *addr)
 
 static void __vfree(const void *addr)
 {
-       if (unlikely(in_interrupt()))
+       if (unlikely(in_atomic()))    <<<< VvS: do not sleep in atomic ...
                __vfree_deferred(addr);
        else
                __vunmap(addr, 1);
@@ -2703,7 +2703,7 @@ void vfree(const void *addr)
 
        kmemleak_free(addr);
 
-       might_sleep_if(!in_interrupt());
+       might_sleep_if(in_task());  <<<<< VvS: ... but generate warning if vfree was called
                                    <<<<<      in task context with taken spin_lock or spin_lock_bh
 
        if (!addr)
                return;


>> As we did quite many s/kfree/kvfree/ changes, perhaps just switching to vfree_atomic() is the best solution.
>>
>> @Andrew: What would you prefer?
>>
>> In addition, if we do not use vfree_atomic(): Then I would propose to copy the might_sleep_if() from vfree() into kvfree()
> I think it does not help, as far as I understand we are in task context, just under taken spinlock.
> 
> Thank you,
> 	vasily Averin
> 

