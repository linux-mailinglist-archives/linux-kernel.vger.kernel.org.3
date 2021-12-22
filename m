Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89AE447D5E8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 18:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344382AbhLVRig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 12:38:36 -0500
Received: from mail-eopbgr130119.outbound.protection.outlook.com ([40.107.13.119]:27834
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232852AbhLVRia (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 12:38:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NjJ2F4GLYI9IiAkEO2uzH5OtvKVSUuI0GJTjr6R0tV9x5wbMzoFreNZM4nL5WZvo60VkHO+lmKNGQa8qSrSiFoOyiYrsdOQ4O6seQ+zzu1rPsAvbRK1plPiso831LBs30ihLvIY+Khd4aRYEyXGkkm7sHhA+V6DFxh44p6AneDmragfRKBJx8wzQhnhW7BHkf7MpcuGWda10I0sZ8zk8L+KRzIDCqY1lM688/oD+BgJhOgLwiY9RNqI5dItlrxvi5jYdUvxd6ffy1ohTThbad/fOuO1RYglW6Ue0rzrYzbUYKaVOe7MaMYIFxF8OYHCKWV0o3ix5cYKxOxJlzGBJbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HVu0FyqaKZGI/tkS7ovW/MRDSAqgmKVWJ557BThj660=;
 b=LWfphksmA28Aue3uWmDIlc0xnH0JLI0n7sLfSHSCMpsa4OrNWtM0MPiK5YwB9mHGWlcwrQLkYF8m3Iy848eh578TtseJ4n1/pN4hmpNSW92syMfXbdzjQCPl2ordaYIIXaeyKYHWdy4CovXlo3SsLtm3upH4FeJsLlWHkMbzCHYH2kmBvl2ZPbZ6uy653LHlABJkOS7UAc4fLemFPHHTZZfIuqTnscDnQWIBUOZxdzxLOc8lkd8G89lzOov5SoL0zZV1pmQMp84Gunoux6GwSWSkaX0DN9qwYjS46Y93h0qi7PFLIxDkRhY+WjRnoYbHKaSHB6YXceUW2mxSYglzoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HVu0FyqaKZGI/tkS7ovW/MRDSAqgmKVWJ557BThj660=;
 b=SooJgx3o+XRHndTj0kyA8SGx2OkB2bBfqmGJ8dWiR32yTLne4R6YjsksVMb2itaRJS36rw60i65xe8gDGhAhZunLL80PhMvjZ9uxRmAQBUdm4FURiVVGwV79UiJJ5TkgUUtdwEBBu8jIivER5KXKmdC+P6pbjIMPajmyaXWrDDc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DB9PR08MB6619.eurprd08.prod.outlook.com (2603:10a6:10:257::21)
 by DBBPR08MB4476.eurprd08.prod.outlook.com (2603:10a6:10:d0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.20; Wed, 22 Dec
 2021 17:38:27 +0000
Received: from DB9PR08MB6619.eurprd08.prod.outlook.com
 ([fe80::347f:d385:ec53:75aa]) by DB9PR08MB6619.eurprd08.prod.outlook.com
 ([fe80::347f:d385:ec53:75aa%7]) with mapi id 15.20.4801.023; Wed, 22 Dec 2021
 17:38:27 +0000
Subject: Re: [PATCH] ipc/sem: do not sleep with a spin lock held
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
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <d89356b2-c7d8-a3d0-5d3f-1ef37b631193@virtuozzo.com>
Date:   Wed, 22 Dec 2021 20:38:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <4d786a02-1560-25ed-4603-8419672ec044@colorfullife.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6PR0202CA0048.eurprd02.prod.outlook.com
 (2603:10a6:20b:3a::25) To DB9PR08MB6619.eurprd08.prod.outlook.com
 (2603:10a6:10:257::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 381f08ec-4a8d-4575-6adb-08d9c571dcb3
X-MS-TrafficTypeDiagnostic: DBBPR08MB4476:EE_
X-Microsoft-Antispam-PRVS: <DBBPR08MB44767F5579B3C0A868BBD60BAA7D9@DBBPR08MB4476.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m50+JKlxQP2P4VPdb5Z5+sPlazrPujRQDOzwy0tQ850wYs2jlF+B/yaHSPQy2kLYtFIM6yg7hNAU/TDqY2bBc66pAa05hi9UHKsTpwisY7NFYudjOJ6utGw8dxAUu9I+7rWo9Smp5ciMTsKIbjl39eHcM7qSPWkD9YuA+RHqm9kcM1hJCWSLkeStgw4FV+kswLsMnMbuMvObvJgK6i1qqO9q9jnZKuo9TQsq+nIYF3TE7vfeeTJpJtnD3CXnPuRlX7ao65mv+s3MToRPltKrMEpM7wvuFV8J+wXx03w5fmZfBEcxeKqVsIE1I7bsk+l57etzPquV1khGlSWSYdtYMFpBYlu/+8s1a3qjRGyzOIL2PHToBzneE9+aKQ44nEFVUm/zBym4mxNjkghA7ezFiqO0wtAANzw5+FcDMANNrjjnDArpKpqpF9gxfJ/X5xXBrlYOIL2/3oXwFb+X755gtOMwEWeuxc+kNPxizlTbBgaLXiRpNUXz0Xeea0FBgHu6BMR+vmPSDj1VGCdMbCxoXNLa+zusN31SX8rSR4EBEKsF/X2jURSEJmjeci7liy+5vWjDgiRl7kxyHkQ+cyIMmqzJOXzxS/gzjyZGyMQv2Um7cNH7wV60GJRhipgEQk0SuQxkMnNtJS+YatSWdDOIXhX8KLNZszt/7c7JpKIMuFcyIMXSqL2EKmcAYs82+4m9A5O9MAcnrC50WkH73WzOb7AOwmahT1wgSK4NxHKpITHNMeCPVZ4psm7u0azultCL7gk6Trs35Wlv1Hrmk63qFA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB6619.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(31696002)(26005)(38100700002)(66476007)(83380400001)(36756003)(7416002)(66556008)(4326008)(6506007)(52116002)(53546011)(31686004)(66946007)(38350700002)(6486002)(6512007)(86362001)(316002)(2906002)(186003)(2616005)(8676002)(5660300002)(8936002)(508600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGI4RzhXdjBSRERWLzlvYktHY0Z1bTVsYlJRUFhEUGFrME55V0Y1ZkJqOUJG?=
 =?utf-8?B?MFg4UWhVYWZwSzJVVk9nYy9YNzJtdVBZUlZWbXZIUVBGUWR2MXNxcXdTbkF3?=
 =?utf-8?B?ZTVSa1V0YVBLL0NxRGMvT0ZUMWg0SlNlcDA2ZHdtTmtBaVFjSG1oSzhVY3JS?=
 =?utf-8?B?MEF3dThjallHUVczT2ZWaG9DamJqeG9tNXQ1azRZSGhsSnFPc2prSFVZZUk4?=
 =?utf-8?B?U1FMVnRFWmpNc29ZN3lDdzdWbU9hQ0lldkd5UHBHSU9kb1dQazBuQkFJLzQx?=
 =?utf-8?B?QXg2ZlV1K3dIdlFLOUtGcVl3Y25ZaTN6Qm91Znpab1Q5SU00TkllOEQzY0xM?=
 =?utf-8?B?c1BpbnQrNnRWckZFeERRNEZGTVYvcmFNT0U0T003WGlXd2FuTGhPY0hTaXVm?=
 =?utf-8?B?M1ljNnJ0NDI0YWU5WCsxeW5FRW03Z0RVVjBrbDlHcFhRU2VjeDVHVlBJcXJj?=
 =?utf-8?B?RnlNRXMyZmh1ekQxOEc1YXU2TjdaRDBveDF4SnFsOEFNekRvNW1lM3pqRXZk?=
 =?utf-8?B?QUR3UEI4S3Q3QjRXQkxaamR0RzFHM25uWkh4MytkYlBPTWRmMkplNE1uTXJ5?=
 =?utf-8?B?d1BKQnMwQ1ZEazJic1g2ZmJSUUFqdVZNZXNDdHVrelZEWXl5NERyMmMveTlw?=
 =?utf-8?B?elNUaXRtKzRZWXJQQnRoNkNCV2Z6SWpPazJlTmoxVEV6R1RTMlNlU3RtLzNP?=
 =?utf-8?B?RUd3OHNBVExYREc1SnRMUk1RdEducTI1b082TU1wSW02Zk5vUnAzL1FwQ1FU?=
 =?utf-8?B?Z0VOUWJkekQzc2lqWTl4aVk2NHlGRnM0WTBXbmd3V0hXZE91K2FHMmJ1ZEc1?=
 =?utf-8?B?VXR2TU40bU9MbmZCZkRJVDlwdzUyN010bVdNUWg4R2JNSjBpWnZEajFYUHpD?=
 =?utf-8?B?Yzk1dCthU2xtUDlHVkxDTXdMU3QyN2ZwRU5HcVVJU0JIWW90akJXa2h1N3BT?=
 =?utf-8?B?YlpzNk5KTHBaeXdLbnFQRWkwYXNQRnYvZzNTQXlxR1VXWGFUVGtCeDBKTXFK?=
 =?utf-8?B?bTMwUStBY1lyU2tkeEduTGZXZk5oc2JzLzh4TnB5S0xhNWZTZUhSVUxkb01Q?=
 =?utf-8?B?Q2FnY1NnTllBOFJpZ3FmOEMxZkJGd2tYTXJ0SDBhYXRaQVNBaUg5M3cwSCtn?=
 =?utf-8?B?dGRIdkRBZHZSc2tnY3BYYnRZY0tvcWVZNi92U0NXSTdiVnVNYXRuWXhWWlh6?=
 =?utf-8?B?aE03TEgrWDVJSnJaMlQyZnVOOFM1M0xZNnBsYlNGdDg3NjIxVFZwclBNVTZh?=
 =?utf-8?B?clMxSG01OUZCcDRnY1g2ZlBFcGhCQWJvaG13K3BmZUVYWVpaeGhlWXpKbGFa?=
 =?utf-8?B?YklGTU9yaVJ0dXlzZmlwY0k2RUlXQjV0NHdzME5BRHhiSk5HK25jcHBlUVJF?=
 =?utf-8?B?RnpITERYM1F1dm5mSFNZUmp1cytzbERvQmljQUxNd09yWUIyQ2dlN09mbjJn?=
 =?utf-8?B?cUFLdkNTTW80YW85a2FiaUg5d05hN2p4TTJoQUtkWjMxZGdBRXppR1lLQXlU?=
 =?utf-8?B?aGEreE5Ld0t0NnlVempHZkt3VXR3ZGVVQThhTTZSSEkxaGVkdjFZOFpBK1h1?=
 =?utf-8?B?cllvRDhsajZudS9iZTE2QTJ5ZzB6Y2JadENPc1dPWUh4eWJ1US9LaGpiVkJR?=
 =?utf-8?B?SVNNdGJqM1NRWlp4SzF6dWc1NVFYUExhcW4wdXRvOXkvd0l5UGlSajFDSHVV?=
 =?utf-8?B?a3NBdHN2RHV4eUtiNm5qaE92dElqa04rdkRGRjBTYVFxR1plQ0RNRUQwZWZt?=
 =?utf-8?B?dkE1NVBMbnZJdHV3d3ljQ1JodlNVbEUrb0J3cjZ5UWFXdWhDOVVYWW9jZ0hK?=
 =?utf-8?B?QkIyUTNvVm43SytET1o0TE1sRE56Qkc5bTJCUzFFS2txaWdBRkFuVEN2S0xw?=
 =?utf-8?B?c05WK2cralBmWUdoTGFMYjUvaXBYdk0wNHNQNklIL2hFSElOZWNKdUc5Zzhv?=
 =?utf-8?B?UE5XNVdmZURyRW1iSUxrNUlPR25YZ0NtTnFEaElUR2RodE5pRVZqUEx0TFph?=
 =?utf-8?B?SUtSQm40MG85ZWx2MVpXZE41OGI1blF1VFZSSHRSWmtEWTI3bGhucmxwalRH?=
 =?utf-8?B?ZERvNGdCdmx2VlcweGZpWnhaUVRrK3dKT2JydHN0MEZkcUE1MCtsRmhCMlpj?=
 =?utf-8?B?UjdNckN2TnRLUDlBUnh6S29iYlBhcUhXN2dYbVZwSWMxUUp5TE8rMVU4a2Zp?=
 =?utf-8?Q?n1I4mZ1y0rYEeVQEHKopafg=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 381f08ec-4a8d-4575-6adb-08d9c571dcb3
X-MS-Exchange-CrossTenant-AuthSource: DB9PR08MB6619.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2021 17:38:27.6100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m/RpxyhdT/itnTtivo2zyW/TxG62Lu+d62/u/vUCwoF241iB3Qun/SDmg7bwUtD+2gfLKpYcGS7OWpDhk8WV4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4476
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.12.2021 20:06, Manfred Spraul wrote:
> Hi Vasily,
> 
> On 12/22/21 16:50, Vasily Averin wrote:
>> On 22.12.2021 18:31, Vasily Averin wrote:
>>> On 22.12.2021 14:45, Manfred Spraul wrote:
>>>> Hi Minghao,
>>>>
>>>> On 12/22/21 09:10, cgel.zte@gmail.com wrote:
>>>>> From: Minghao Chi <chi.minghao@zte.com.cn>
>>>>>
>>>>> We can't call kvfree() with a spin lock held, so defer it.
>>> I'm sorry, but I do not understand why exactly we cannot use kvfree?
>>> Could you explain it in more details?
>> Got it,
>> there is cond_resched() called in __vfree() -> __vunmap()
>>
>> However I'm still not sure that in_interrupt() is used correctly here.
> 
> I see three different topics:
> 
> - is the current code violating the API? I think yes, thus there is a bug that needs to be fixed.

I'm agree. Found issue is a bug and it should be fixed ASAP,
I'm sorry for a mistake in my patch.

> - Where is __vunmap() sleeping? Would it be possible to make __vunmap() safe to be called when owning a spinlock?

I think it is possible, and we should do it to prevent similar incidents in future.
vfree() should check preempt count to detect this situation (i.e. execution under taken spinlock)
generate WARN_ON and then call __vfree_deferred() to avoid sleep.

> - should kvfree() use vfree() [i.e. unsafe when owning a spinlock] or vfree_atomic [i.e. a bit slower, but safe]

I think it's better to change vfree.

> As we did quite many s/kfree/kvfree/ changes, perhaps just switching to vfree_atomic() is the best solution.
> 
> @Andrew: What would you prefer?
> 
> In addition, if we do not use vfree_atomic(): Then I would propose to copy the might_sleep_if() from vfree() into kvfree()
I think it does not help, as far as I understand we are in task context, just under taken spinlock.

Thank you,
	vasily Averin
