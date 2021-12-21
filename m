Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6FA47C0C1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 14:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237478AbhLUNaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 08:30:06 -0500
Received: from mail-eopbgr1300088.outbound.protection.outlook.com ([40.107.130.88]:7357
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231804AbhLUNaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 08:30:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B1Sk9iSDqMk2SBpG3FkVTJpTgGrnlXBiObSP6uvBJEBtmGLff6rQiDpLhw3nlH4x8g2Jsh+HXA1AKo2bYRdhryATPyWAsC06FSYBrvqUmGJA+KM1fHsvZ1d+RKw2WmLDoxLXCC6mBGdwURBT3m2l8ltx6oMSPK8lcUwGXryTf/qKmymeUVd8ODOOOd7o2nGhyFrEKbPANRmHbjwQ5Lc7cIihgMuD8bIL4q1qWL/r85j+hm+HdD0uF7YmFoq9+Ewo5VArLWO5hOPaWtUDLpdSQFkxLJbG3sEEge++XrT8LYekdJscolel9i4aQiZPZ6k7iTrbs8kX/lKZF18WtEajqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C4Yfwq09ODpeD6lefE65xQAG2AjRfwLSgJchaUIfEPw=;
 b=BMLVVKrpbzN1bDLbHLBtyl0Flmz8JfoFFZcOzVRpnr5rM5Q8suMpyNddR+0aMdYnkcufU5esv80Vd+vwyHwVVfBVwStYoww4rVfq443w4qnoOBCkjKpjs87p92S4uiE8DNR6txVUlUlaZku1+unTpH5+emwuS6TVG50iYafdHEUiYFXeC8J39Yqxl4eiPsm92DtZ6Oj0zOjePnZQAZOXJRgu+1lYbU+E00lunEUftm9OA0oA2RRBGwI+0afRx0e/0axI07Tgyf+aijyWemHWB5/36XmLjr7F57YAGhZhGZF4WvRaNp6q68Vk8NG9kyE9NXkfueSA7m8DAVt3gKbAcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C4Yfwq09ODpeD6lefE65xQAG2AjRfwLSgJchaUIfEPw=;
 b=sawz0JgaRaCJQ7+fA43obgrDb4Ifv2Q89BTh6PWnRFCfOsTtL+d1iwil1REncq0STm96sTlugoZ8RyRHnhESOGBC+kL2itktH9rWEeS2mX7zI+mRFveaq1uPRJ0Aj4ql8jSAVKLiCBOEdWy+3qZOK4PQnTa7N8uzQNlyYdVhbQ8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from HK0PR02MB2497.apcprd02.prod.outlook.com (2603:1096:203:21::22)
 by HK0PR02MB2707.apcprd02.prod.outlook.com (2603:1096:203:66::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.20; Tue, 21 Dec
 2021 13:30:01 +0000
Received: from HK0PR02MB2497.apcprd02.prod.outlook.com
 ([fe80::483f:813f:a012:746d]) by HK0PR02MB2497.apcprd02.prod.outlook.com
 ([fe80::483f:813f:a012:746d%5]) with mapi id 15.20.4801.020; Tue, 21 Dec 2021
 13:30:01 +0000
Message-ID: <0fd099e9-f293-51f0-3a4e-76aead43dc39@oppo.com>
Date:   Tue, 21 Dec 2021 21:30:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] sched: optimize __cond_resched_lock()
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
References: <20211221072316.42-1-xuhaifeng@oppo.com>
 <YcGVzClid/7q3DuB@hirez.programming.kicks-ass.net>
 <YcGnvDEYBwOiV0cR@hirez.programming.kicks-ass.net>
From:   xuhaifeng <xuhaifeng@oppo.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <YcGnvDEYBwOiV0cR@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HK2PR02CA0217.apcprd02.prod.outlook.com
 (2603:1096:201:20::29) To HK0PR02MB2497.apcprd02.prod.outlook.com
 (2603:1096:203:21::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc5b9fa9-42c3-4996-9653-08d9c485fd97
X-MS-TrafficTypeDiagnostic: HK0PR02MB2707:EE_
X-Microsoft-Antispam-PRVS: <HK0PR02MB270750EC53239EC0B3ADE28DD27C9@HK0PR02MB2707.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MjAlrbidhyBg7Ql1nfkWnQeZEpagWNyzQkmQ4a0oYtl6uVL2JK9a6Y60fuIYnZimW1jyEf3gwxJp6kuyIYk5um6UogJ0uDgux+1quQWTg9jPnyOjIV3lsIp6e+Kwk3vImuO3grha0e/b50WTwBq9h1hYWhBBbpsXXFmqvbVwhs4+7XSdMNalLfjQNrZ2hf6ZiY47eD25SJYKVcY0jVfWPIj1ttkjdmAOXZozKr1XJEZd3IcgXdizDrKL3ORhZwYkKJrCIyqn11T8USTOZUE1azHo81ec9t6X71tXldAv6Mz+p7x6eeYvzxo/LqJdYXEkTwX3OdlQ7MMkVWVJ5g0N+2AIp6BAgyrDV/dzs4PTu+SC5FJvAVauhiQ9uuP+8Rg9nQg4NmyH+fkvtaoHKkRFBDQUwXO5PIUUOp8ErUZn9OzMpqV2cYGjtf0EqOP84Fb49hJDdBLtmfDQ3AiVGsnBLcuKWJ8UakZCRlAFApuRWgQQwARwlsLbopsx8TDUBtRxrFgVbPYFIHToj8cwHNI3zFAsBYF51/8QCbJwLv9QVOozmSAMIANVi0wnjBX+ZBonzVX0MEK0q7RUQj4WKD6DIO41NpLu3xyZ2QvYSluklTO+jo4ILJ34r3zynyF/6hSbdwDR+wIVW2n7vTfcapkAQSJFfa1rcjgxKxx195onuMmLv3yXggIUxHxc216l74QAS2ECUehFvTKp64M9qgllcHsGHqx0IJkuTR95J/yie6hi33FkuUGk1uymkYDhBX1/wOhwJesPwqlr/KQ7eHI1mwuUYEcd2iyaqBOxw1shCjk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR02MB2497.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(186003)(83380400001)(31696002)(508600001)(26005)(316002)(66556008)(66946007)(6506007)(38350700002)(53546011)(66476007)(8676002)(8936002)(52116002)(6512007)(2906002)(86362001)(2616005)(5660300002)(6916009)(31686004)(36756003)(6486002)(4326008)(11606007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3huMU5ONldBQXVDaWE3UU1Xd2JRdmp6Y2pOM04rNXdsQkc3RjRVVVhaK3ZS?=
 =?utf-8?B?aXZPekM3TmZyUUJpQm1oUmZXbVoyelhmZFdGT3dSbVNxV2ZMYjF5S1FZeGFG?=
 =?utf-8?B?NmlrMDJiRCtmQjF5dDJpNUhaYnRnTWIwUGdxZ2luN3JNS1Z3bm1GVXdXdE5T?=
 =?utf-8?B?TFhlTFBycG56NGVvak4xNjh6MFRRRXhodlVsSklEWjh4SnBJOGp3dHlnT0Rh?=
 =?utf-8?B?dVNoOUMzTTMyczd6YXJNb25yZE1Xdk9DK3JsMVVkVnFXT3ZZQzFJM2g1Nkhn?=
 =?utf-8?B?V1JvYy94T3ZiYzdBRzZ3RTJ3K2VlWjErTnpaaDBkc3d3aldEVXZzbzc5VEIw?=
 =?utf-8?B?VXNzRFVHTHp5ZUREclRyVGpQSWZKUWJlRm1ZSnZXQ1RXcUhIVllLZ3daTEdz?=
 =?utf-8?B?RDNVZHkzWGhLL2cvM0llbS9KRW5VZzBoM1RGRjY3VDF6Uzd5UlI4dHB3Lzkr?=
 =?utf-8?B?eXVHUG9pTllxTXNuY3I0dVkwU3pheFF0cXNEWkNsUXYwZ3VTSmw4THA2aGpG?=
 =?utf-8?B?dUY3WGxYWUpqVUZHS1daMjNYNWZNUE5reDRhVEFkT3VjdHU3Q3pJOTNZRmw3?=
 =?utf-8?B?bGFVcDVWejdvTWQzU01NME9rK0VXL2wwSXdTYmlLTVVtcnFEanEvaXBNN3dn?=
 =?utf-8?B?MUoyclhlZUlpZktWWGNJaWdFdVpsMy9KS0NDVXFrRzEyL1lSbzgwaVM4WWZI?=
 =?utf-8?B?WHk3N3JkYlBFZEljdkVvK0RZa3hoSEZUV3F1dXVreis5VVREM0JrSUoyYkVL?=
 =?utf-8?B?SjNiUXpIcTM4d05zMDNCZ2N0eWtvaTZ2cUNQTGo4dURvSVNKbktmckdHR1Vq?=
 =?utf-8?B?SlJCMWtTRUVpZFd6cVJ4SUE2RFptajBJMlpETmxRVm5YL3N6eUoxUVgzdmZi?=
 =?utf-8?B?TzRBSEcxRFZLbHJpL3dVY2hSNitRZDVEYkw3TTZjYktPRE1FRG5haHBiWjlX?=
 =?utf-8?B?eHYybm1TZk9pTW13VHpFWDNsdExRL2tLOGt3bUlheXdrZERSR1dYdEpZOFMr?=
 =?utf-8?B?cGJsS1lFSTdmY1laZnROVktSNVUzV2tnYkNzMXhVeThwc2lBWEtBWkYxVU12?=
 =?utf-8?B?NWJidTh3U2JjTVBLaDd6SENOUHNzS29rcFdLSlh3MXNWekhtUitzRTVUQWor?=
 =?utf-8?B?RWFxNWRSODloU3FsR0JWK2F1ZDc4cTJUK000b3k1UFo4a1JhbTdkOUpxRDVJ?=
 =?utf-8?B?OUZDQ3VIdXBDL0NQTUhnNzE4TE5Sbkh5WUdPcmtJeEgvNmRtUUtEYnNmbk1J?=
 =?utf-8?B?dHA4TGxiS2NEYlNKSzBHbFNKaE5UR1grUnk3NG5la2xVTkJCR2VuaVgwOU9N?=
 =?utf-8?B?eEc1clJsdWR2T2k1a05Fc0dGZHY2dEdNRlQxdTM3a1dQQmU0QUg4MGdlWVUr?=
 =?utf-8?B?MXNYTHozOWdlckN2aWErdjZ4dHZoMC9hbEl6bXEwY1hRak1IRkNjQjR6TVhx?=
 =?utf-8?B?bkk0ODV1U1lxQXIxelN2N2E4MmpXYzBzMklpYm54N1lHbG5XUVJUMkQxeGRa?=
 =?utf-8?B?cUxvekZGbG9qZ1JVL0FBRzd5emhvMXdxNlkwNC94MmNZZ0oxSzFoNzExSDk3?=
 =?utf-8?B?WmswWFF2Yko1SVFFbE1pcXUwd3BQZWt4WVkySEVuRnAxQnVNYUlhQ1ZlRUVC?=
 =?utf-8?B?US9KNlZ6TWgrSEE2RGtCM1JQSllIVis3cXE5eThZNTNyQjJqNmRPZSsrN2wv?=
 =?utf-8?B?dGlCWExDMFdpVzhiZWl2cS9UNkZLN2o1bDM1VFlkTmRSV1ZITm1NMGU1ZzJT?=
 =?utf-8?B?WEljejVSZ01TSVA4Y0pGdGlCSk94aUJKZDlucUVRcFRlTDNocURuSm1hODdH?=
 =?utf-8?B?RnpiUmZPZFI3M3FBUVh0Mms3R0p3aFRMTmVFWFUveWZmdWx3czVKeHZPMExN?=
 =?utf-8?B?akFYT1BvQTVReGdqT0taZncrdUxsNGdLcHNGMTdESWp6NjJmdGFSTk9ZNFY3?=
 =?utf-8?B?Uzk2djdUTURVUXlwMXVpaHpiS1FDS3JVVHJqdXBnVXlLL285NURmTHRhaTlw?=
 =?utf-8?B?MnpmVHVFKzYweWtOV21RRE85MVBEdFlJTDg4L2hBdzBueFd5dFg4UmE5SmlO?=
 =?utf-8?B?MExmOERlR1drcmQ4QzBPS3NKODhlR2E5VndGL1BRTVl3eXNBeS9QUVU0d1B4?=
 =?utf-8?B?UEdPNTN1T2cwYlFsVHRVTzZCbUttUFlrTklwTlFnUXppV0xYVVRWYTBySVBV?=
 =?utf-8?Q?p6ScCFWcy+BoCl2fj2/IYtE=3D?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc5b9fa9-42c3-4996-9653-08d9c485fd97
X-MS-Exchange-CrossTenant-AuthSource: HK0PR02MB2497.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2021 13:30:01.5150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q1aDIZWqgc4KxUDYVYz7AUMltVg6spJGIMWnlbRYOHB+BLbwSzgiuTOUWREnkNFlfdtzasKBh6c5tlvEjLHXsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR02MB2707
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your review and suggestion.
It doesn't work if CONFIG_PREEMPTION=3Dy and CONFIG_PREEMPT_DYNAMIC=3Dy.
Can i change the patch like this?
---
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 83872f95a1ea..9b1e42f8ee60 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8202,6 +8202,15 @@ DEFINE_STATIC_CALL_RET0(might_resched,
__cond_resched);
 EXPORT_STATIC_CALL_TRAMP(might_resched);
 #endif

+static inline int cond_resched_preempt(void)
+{
+#ifdef CONFIG_PREEMPTION
+       return 0;
+#else
+       return __cond_resched();
+#endif
+}
+
 /*
  * __cond_resched_lock() - if a reschedule is pending, drop the given lock=
,
  * call schedule, and on return reacquire the lock.
@@ -8219,9 +8228,7 @@ int __cond_resched_lock(spinlock_t *lock)

        if (spin_needbreak(lock) || resched) {
                spin_unlock(lock);
-               if (resched)
-                       preempt_schedule_common();
-               else
+               if(!cond_resched_preempt())
                        cpu_relax();
                ret =3D 1;
                spin_lock(lock);
@@ -8239,9 +8246,7 @@ int __cond_resched_rwlock_read(rwlock_t *lock)

        if (rwlock_needbreak(lock) || resched) {
                read_unlock(lock);
-               if (resched)
-                       preempt_schedule_common();
-               else
+               if(!cond_resched_preempt())
                        cpu_relax();
                ret =3D 1;
                read_lock(lock);
@@ -8259,9 +8264,7 @@ int __cond_resched_rwlock_write(rwlock_t *lock)

        if (rwlock_needbreak(lock) || resched) {
                write_unlock(lock);
-               if (resched)
-                       preempt_schedule_common();
-               else
+               if(!cond_resched_preempt())
                        cpu_relax();
                ret =3D 1;
                write_lock(lock);

On 12/21/2021 6:09 PM, Peter Zijlstra wrote:
> On Tue, Dec 21, 2021 at 09:52:28AM +0100, Peter Zijlstra wrote:
>> On Tue, Dec 21, 2021 at 03:23:16PM +0800, xuhaifeng wrote:
>>> if the kernel is preemptible(CONFIG_PREEMPTION=3Dy), schedule()may be
>>> called twice, once via spin_unlock, once via preempt_schedule_common.
>>>
>>> we can add one conditional, check TIF_NEED_RESCHED flag again,
>>> to avoid this.
>>
>> You can also make it more similar to __cond_resched() instead of making
>> it more different.
>
> Bah, sorry, had to wake up first :/
>
> cond_resched_lock still needs to exist for PREEMPT because locks won't
> magically release themselves.
>
> Still don't much like the patch though, how's this work for you?
>
> That's arguably the right thing to do work PREEMPT_DYNAMIC too.
>
> ---
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 83872f95a1ea..79d3d5e15c4c 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -8192,6 +8192,11 @@ int __sched __cond_resched(void)
>       return 0;
>  }
>  EXPORT_SYMBOL(__cond_resched);
> +#else
> +static inline int __cond_resched(void)
> +{
> +     return 0;
> +}
>  #endif
>
>  #ifdef CONFIG_PREEMPT_DYNAMIC
> @@ -8219,9 +8224,7 @@ int __cond_resched_lock(spinlock_t *lock)
>
>       if (spin_needbreak(lock) || resched) {
>               spin_unlock(lock);
> -             if (resched)
> -                     preempt_schedule_common();
> -             else
> +             if (!__cond_resched())
>                       cpu_relax();
>               ret =3D 1;
>               spin_lock(lock);
> @@ -8239,9 +8242,7 @@ int __cond_resched_rwlock_read(rwlock_t *lock)
>
>       if (rwlock_needbreak(lock) || resched) {
>               read_unlock(lock);
> -             if (resched)
> -                     preempt_schedule_common();
> -             else
> +             if (!__cond_resched())
>                       cpu_relax();
>               ret =3D 1;
>               read_lock(lock);
> @@ -8259,9 +8260,7 @@ int __cond_resched_rwlock_write(rwlock_t *lock)
>
>       if (rwlock_needbreak(lock) || resched) {
>               write_unlock(lock);
> -             if (resched)
> -                     preempt_schedule_common();
> -             else
> +             if (!__cond_resched())
>                       cpu_relax();
>               ret =3D 1;
>               write_lock(lock);
________________________________
OPPO

=E6=9C=AC=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=
=BB=B6=E5=90=AB=E6=9C=89OPPO=E5=85=AC=E5=8F=B8=E7=9A=84=E4=BF=9D=E5=AF=86=
=E4=BF=A1=E6=81=AF=EF=BC=8C=E4=BB=85=E9=99=90=E4=BA=8E=E9=82=AE=E4=BB=B6=E6=
=8C=87=E6=98=8E=E7=9A=84=E6=94=B6=E4=BB=B6=E4=BA=BA=E4=BD=BF=E7=94=A8=EF=BC=
=88=E5=8C=85=E5=90=AB=E4=B8=AA=E4=BA=BA=E5=8F=8A=E7=BE=A4=E7=BB=84=EF=BC=89=
=E3=80=82=E7=A6=81=E6=AD=A2=E4=BB=BB=E4=BD=95=E4=BA=BA=E5=9C=A8=E6=9C=AA=E7=
=BB=8F=E6=8E=88=E6=9D=83=E7=9A=84=E6=83=85=E5=86=B5=E4=B8=8B=E4=BB=A5=E4=BB=
=BB=E4=BD=95=E5=BD=A2=E5=BC=8F=E4=BD=BF=E7=94=A8=E3=80=82=E5=A6=82=E6=9E=9C=
=E6=82=A8=E9=94=99=E6=94=B6=E4=BA=86=E6=9C=AC=E9=82=AE=E4=BB=B6=EF=BC=8C=E8=
=AF=B7=E7=AB=8B=E5=8D=B3=E4=BB=A5=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=E9=80=
=9A=E7=9F=A5=E5=8F=91=E4=BB=B6=E4=BA=BA=E5=B9=B6=E5=88=A0=E9=99=A4=E6=9C=AC=
=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=BB=B6=E3=80=82

This e-mail and its attachments contain confidential information from OPPO,=
 which is intended only for the person or entity whose address is listed ab=
ove. Any use of the information contained herein in any way (including, but=
 not limited to, total or partial disclosure, reproduction, or disseminatio=
n) by persons other than the intended recipient(s) is prohibited. If you re=
ceive this e-mail in error, please notify the sender by phone or email imme=
diately and delete it!
