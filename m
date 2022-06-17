Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 156FC54FAED
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 18:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383213AbiFQQQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 12:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383009AbiFQQQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 12:16:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D206723178;
        Fri, 17 Jun 2022 09:16:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5317161D5C;
        Fri, 17 Jun 2022 16:16:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44426C3411B;
        Fri, 17 Jun 2022 16:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655482602;
        bh=lnu81QyPDi00Mq1jQuI7cW9W9cwwy3aOWczD2B7ak38=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WcGbIAr+AAeY7smpw+ugWXhb0Eazs3O6ql6zVB/Dsj3knY0vxQOpQmhP51T2TRqq2
         tHbGrW/jexZR8LSeL/Z2XMWZxVIyRhdaqUjZH/XIC1/altbw6iYQxa7xegHeCBvBCT
         A86EnRqQp532TRxTIZVGQyFMb4tHBgagHh9aMJ2nBpL6ke23AhXMByosncgkqnNFhQ
         pkQliK6SlXu584vYJGaPC2iyj3F1leRc37z7znbECzqwAuKDY4r1GvKmpxOBi+aTfq
         QjZhP6tzF2jPuLSP9uT45Swl4BosYVBtJv5fnLVkvKG7gtGM3P03AQeGNQGEqhtgQ0
         xs9uTRVa7TXzA==
Message-ID: <e20d30c4-2971-5e1f-f7dd-be30560d5689@kernel.org>
Date:   Fri, 17 Jun 2022 18:16:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH V4 17/20] watchdog/dev: Add tracepoints
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Gabriele Paoloni <gpaoloni@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org
References: <cover.1655368610.git.bristot@kernel.org>
 <e153b772306577bcb3915474ed10eb3dcb228eda.1655368610.git.bristot@kernel.org>
 <a141e63a-c62c-8094-fedf-7f22f9090b0f@roeck-us.net>
 <4d8c53a1-7b94-fb0e-29e5-ed13b72093f1@kernel.org>
 <dc48373d-6568-4fab-cbe6-39f2c84ee1b5@roeck-us.net>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <dc48373d-6568-4fab-cbe6-39f2c84ee1b5@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/17/22 01:55, Guenter Roeck wrote:
> On 6/16/22 08:47, Daniel Bristot de Oliveira wrote:
>> On 6/16/22 15:44, Guenter Roeck wrote:
>>> On 6/16/22 01:44, Daniel Bristot de Oliveira wrote:
>>>> Add a set of tracepoints, enabling the observability of the watchdog
>>>> device interactions with user-space.
>>>>
>>>> The events are:
>>>>      watchdog:watchdog_open
>>>>      watchdog:watchdog_close
>>>>      watchdog:watchdog_start
>>>>      watchdog:watchdog_stop
>>>>      watchdog:watchdog_set_timeout
>>>>      watchdog:watchdog_ping
>>>>      watchdog:watchdog_nowayout
>>>>      watchdog:watchdog_set_keep_alive
>>>>      watchdog:watchdog_keep_alive
>>>>      watchdog:watchdog_set_pretimeout
>>>>      watchdog:watchdog_pretimeout
>>>>
>>>> Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
>>>> Cc: Guenter Roeck <linux@roeck-us.net>
>>>> Cc: Jonathan Corbet <corbet@lwn.net>
>>>> Cc: Steven Rostedt <rostedt@goodmis.org>
>>>> Cc: Ingo Molnar <mingo@redhat.com>
>>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>>> Cc: Will Deacon <will@kernel.org>
>>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>>> Cc: Marco Elver <elver@google.com>
>>>> Cc: Dmitry Vyukov <dvyukov@google.com>
>>>> Cc: "Paul E. McKenney" <paulmck@kernel.org>
>>>> Cc: Shuah Khan <skhan@linuxfoundation.org>
>>>> Cc: Gabriele Paoloni <gpaoloni@redhat.com>
>>>> Cc: Juri Lelli <juri.lelli@redhat.com>
>>>> Cc: Clark Williams <williams@redhat.com>
>>>> Cc: linux-doc@vger.kernel.org
>>>> Cc: linux-kernel@vger.kernel.org
>>>> Cc: linux-trace-devel@vger.kernel.org
>>>> Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
>>>> ---
>>>>    drivers/watchdog/watchdog_dev.c        |  43 ++++++++++-
>>>>    drivers/watchdog/watchdog_pretimeout.c |   2 +
>>>>    include/linux/watchdog.h               |   7 +-
>>>>    include/trace/events/watchdog.h        | 101 +++++++++++++++++++++++++
>>>>    4 files changed, 143 insertions(+), 10 deletions(-)
>>>>    create mode 100644 include/trace/events/watchdog.h
>>>>
>>>> diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
>>>> index 54903f3c851e..2f28dc5ab763 100644
>>>> --- a/drivers/watchdog/watchdog_dev.c
>>>> +++ b/drivers/watchdog/watchdog_dev.c
>>>> @@ -44,6 +44,9 @@
>>>>    #include <linux/watchdog.h>    /* For watchdog specific items */
>>>>    #include <linux/uaccess.h>    /* For copy_to_user/put_user/... */
>>>>    +#define CREATE_TRACE_POINTS
>>>> +#include <trace/events/watchdog.h>
>>>> +
>>>>    #include "watchdog_core.h"
>>>>    #include "watchdog_pretimeout.h"
>>>>    @@ -130,9 +133,11 @@ static inline void watchdog_update_worker(struct
>>>> watchdog_device *wdd)
>>>>        if (watchdog_need_worker(wdd)) {
>>>>            ktime_t t = watchdog_next_keepalive(wdd);
>>>>    -        if (t > 0)
>>>> +        if (t > 0) {
>>>>                hrtimer_start(&wd_data->timer, t,
>>>>                          HRTIMER_MODE_REL_HARD);
>>>> +            trace_watchdog_set_keep_alive(wdd, ktime_to_ms(t));
>>>> +        }
>>>>        } else {
>>>>            hrtimer_cancel(&wd_data->timer);
>>>>        }
>>>> @@ -141,7 +146,7 @@ static inline void watchdog_update_worker(struct
>>>> watchdog_device *wdd)
>>>>    static int __watchdog_ping(struct watchdog_device *wdd)
>>>>    {
>>>>        struct watchdog_core_data *wd_data = wdd->wd_data;
>>>> -    ktime_t earliest_keepalive, now;
>>>> +    ktime_t earliest_keepalive, now, next_keepalive;
>>>>        int err;
>>>>          earliest_keepalive = ktime_add(wd_data->last_hw_keepalive,
>>>> @@ -149,14 +154,16 @@ static int __watchdog_ping(struct watchdog_device *wdd)
>>>>        now = ktime_get();
>>>>          if (ktime_after(earliest_keepalive, now)) {
>>>> -        hrtimer_start(&wd_data->timer,
>>>> -                  ktime_sub(earliest_keepalive, now),
>>>> +        next_keepalive = ktime_sub(earliest_keepalive, now);
>>>> +        hrtimer_start(&wd_data->timer, next_keepalive,
>>>>                      HRTIMER_MODE_REL_HARD);
>>>> +        trace_watchdog_set_keep_alive(wdd, ktime_to_ms(next_keepalive));
>>>>            return 0;
>>>>        }
>>>>          wd_data->last_hw_keepalive = now;
>>>>    +    trace_watchdog_ping(wdd);
>>>>        if (wdd->ops->ping)
>>>>            err = wdd->ops->ping(wdd);  /* ping the watchdog */
>>>>        else
>>>> @@ -215,6 +222,7 @@ static void watchdog_ping_work(struct kthread_work *work)
>>>>        wd_data = container_of(work, struct watchdog_core_data, work);
>>>>          mutex_lock(&wd_data->lock);
>>>> +    trace_watchdog_keep_alive(wd_data->wdd);
>>>>        if (watchdog_worker_should_ping(wd_data))
>>>>            __watchdog_ping(wd_data->wdd);
>>>>        mutex_unlock(&wd_data->lock);
>>>> @@ -250,6 +258,8 @@ static int watchdog_start(struct watchdog_device *wdd)
>>>>          set_bit(_WDOG_KEEPALIVE, &wd_data->status);
>>>>    +    trace_watchdog_start(wdd);
>>>> +
>>>>        started_at = ktime_get();
>>>>        if (watchdog_hw_running(wdd) && wdd->ops->ping) {
>>>>            err = __watchdog_ping(wdd);
>>>> @@ -294,6 +304,7 @@ static int watchdog_stop(struct watchdog_device *wdd)
>>>>            return -EBUSY;
>>>>        }
>>>>    +    trace_watchdog_stop(wdd);
>>>>        if (wdd->ops->stop) {
>>>>            clear_bit(WDOG_HW_RUNNING, &wdd->status);
>>>>            err = wdd->ops->stop(wdd);
>>>> @@ -367,6 +378,7 @@ static int watchdog_set_timeout(struct watchdog_device *wdd,
>>>>
>>>>        if (watchdog_timeout_invalid(wdd, timeout))
>>>>            return -EINVAL;
>>>>    +    trace_watchdog_set_timeout(wdd, timeout);
>>>
>>> The driver has no obligation to set the timeout to the
>>> requested value. It might be more valuable to report both
>>> the requested and the actual values.
>>>
>>>
>>
>> Ack! how do I get the actual value?
>>
> Read it from the data structure after the driver function returned.

Got it! I will add this field too.

-- Daniel
