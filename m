Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 792B24CE339
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 07:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbiCEGHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 01:07:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiCEGHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 01:07:17 -0500
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2ACF23F38B
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 22:06:27 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R651e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=dtcccc@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V6FfDh8_1646460384;
Received: from 192.168.0.205(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0V6FfDh8_1646460384)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 05 Mar 2022 14:06:25 +0800
Message-ID: <a293da49-b62e-8ad1-5dde-9dcbdbcf475e@linux.alibaba.com>
Date:   Sat, 5 Mar 2022 14:06:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [RFC PATCH 1/2] kfence: Allow re-enabling KFENCE after system
 startup
Content-Language: en-US
From:   Tianchen Ding <dtcccc@linux.alibaba.com>
To:     Marco Elver <elver@google.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220303031505.28495-1-dtcccc@linux.alibaba.com>
 <20220303031505.28495-2-dtcccc@linux.alibaba.com>
 <CANpmjNOOkg=OUmgwdcRus2gdPXT41Y7GkFrgzuBv+o8KHKXyEA@mail.gmail.com>
 <ea8d18d3-b3bf-dd21-2d79-a54fe4cf5bc4@linux.alibaba.com>
In-Reply-To: <ea8d18d3-b3bf-dd21-2d79-a54fe4cf5bc4@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/5 13:26, Tianchen Ding wrote:
> On 2022/3/5 02:13, Marco Elver wrote:
>> On Thu, 3 Mar 2022 at 04:15, Tianchen Ding <dtcccc@linux.alibaba.com> 
>> wrote:
>>>
>>> If once KFENCE is disabled by:
>>> echo 0 > /sys/module/kfence/parameters/sample_interval
>>> KFENCE could never be re-enabled until next rebooting.
>>>
>>> Allow re-enabling it by writing a positive num to sample_interval.
>>>
>>> Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>
>>
>> The only problem I see with this is if KFENCE was disabled because of
>> a KFENCE_WARN_ON(). See below.
>>
>>> ---
>>>   mm/kfence/core.c | 16 ++++++++++++++--
>>>   1 file changed, 14 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
>>> index 13128fa13062..19eb123c0bba 100644
>>> --- a/mm/kfence/core.c
>>> +++ b/mm/kfence/core.c
>>> @@ -55,6 +55,7 @@ EXPORT_SYMBOL_GPL(kfence_sample_interval); /* 
>>> Export for test modules. */
>>>   #endif
>>>   #define MODULE_PARAM_PREFIX "kfence."
>>>
>>> +static int kfence_enable_late(void);
>>>   static int param_set_sample_interval(const char *val, const struct 
>>> kernel_param *kp)
>>>   {
>>>          unsigned long num;
>>> @@ -65,10 +66,11 @@ static int param_set_sample_interval(const char 
>>> *val, const struct kernel_param
>>>
>>>          if (!num) /* Using 0 to indicate KFENCE is disabled. */
>>>                  WRITE_ONCE(kfence_enabled, false);
>>> -       else if (!READ_ONCE(kfence_enabled) && system_state != 
>>> SYSTEM_BOOTING)
>>> -               return -EINVAL; /* Cannot (re-)enable KFENCE 
>>> on-the-fly. */
>>>
>>>          *((unsigned long *)kp->arg) = num;
>>> +
>>> +       if (num && !READ_ONCE(kfence_enabled) && system_state != 
>>> SYSTEM_BOOTING)
>>
>> Should probably have an 'old_sample_interval = *((unsigned long
>> *)kp->arg)' somewhere before, and add a '&& !old_sample_interval',
>> because if old_sample_interval!=0 then KFENCE was disabled due to a
>> KFENCE_WARN_ON(). Also in this case, it should return -EINVAL. So you
>> want a flow like this:
>>
>> old_sample_interval = ...;
>> ...
>> if (num && !READ_ONCE(kfence_enabled) && system_state != SYSTEM_BOOTING)
>>    return old_sample_interval ? -EINVAL : kfence_enable_late();
>> ...
>>
> 
> Because sample_interval will used by delayed_work, we must put setting 
> sample_interval before enabling KFENCE.
> So the order would be:
> 
> old_sample_interval = sample_interval;
> sample_interval = num;
> if (...) kfence_enable_late();
> 
> This may be bypassed after KFENCE_WARN_ON() happens, if we first write 
> 0, and then write 100 to it.
> 
> How about this one:
> 
>      if (ret < 0)
>          return ret;
> 
> +    /* Cannot set sample_interval after KFENCE_WARN_ON(). */
> +    if (unlikely(*((unsigned long *)kp->arg) && 
> !READ_ONCE(kfence_enabled)))
> +        return -EINVAL;
> +
>      if (!num) /* Using 0 to indicate KFENCE is disabled. */
>          WRITE_ONCE(kfence_enabled, false);
> 

Hmm...
I found KFENCE_WARN_ON() may be called when sample_interval==0. (e.g., 
kfence_guarded_free())
So it's better to add a bool.

diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index ae69b2a113a4..c729be0207e8 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -38,14 +38,17 @@
  #define KFENCE_WARN_ON(cond) 
          \
  	({                                                                     \
  		const bool __cond = WARN_ON(cond);                             \
-		if (unlikely(__cond))                                          \
+		if (unlikely(__cond)) {                                        \
  			WRITE_ONCE(kfence_enabled, false);                     \
+			disabled_by_warn = true;                               \
+		}                                                              \
  		__cond;                                                        \
  	})

  /* === Data 
================================================================= */

  static bool kfence_enabled __read_mostly;
+static bool disabled_by_warn __read_mostly;

  unsigned long kfence_sample_interval __read_mostly = 
CONFIG_KFENCE_SAMPLE_INTERVAL;
  EXPORT_SYMBOL_GPL(kfence_sample_interval); /* Export for test modules. */
@@ -70,7 +73,7 @@ static int param_set_sample_interval(const char *val, 
const struct kernel_param
  	*((unsigned long *)kp->arg) = num;

  	if (num && !READ_ONCE(kfence_enabled) && system_state != SYSTEM_BOOTING)
-		return kfence_enable_late();
+		return disabled_by_warn ? -EINVAL : kfence_enable_late();
  	return 0;
  }
