Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE3C64850DE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 11:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239318AbiAEKPu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 5 Jan 2022 05:15:50 -0500
Received: from aposti.net ([89.234.176.197]:48484 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229984AbiAEKPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 05:15:49 -0500
Date:   Wed, 05 Jan 2022 10:15:36 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 3/8] PM: core: Add EXPORT[_GPL]_SIMPLE_DEV_PM_OPS macros
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Len Brown <len.brown@intel.com>,
        Pavel Machek <pavel@ucw.cz>, list@opendingux.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-pm@vger.kernel.org
Message-Id: <06F85R.46PNU7YFWD631@crapouillou.net>
In-Reply-To: <20220105100332.000001c1@Huawei.com>
References: <20220104214214.198843-1-paul@crapouillou.net>
        <20220104214214.198843-4-paul@crapouillou.net>
        <20220105100332.000001c1@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

Le mer., janv. 5 2022 at 10:03:32 +0000, Jonathan Cameron 
<Jonathan.Cameron@Huawei.com> a écrit :
> On Tue, 4 Jan 2022 21:42:09 +0000
> Paul Cercueil <paul@crapouillou.net> wrote:
> 
>>  These macros are defined conditionally, according to CONFIG_PM:
>>  - if CONFIG_PM is enabled, these macros resolve to
>>    DEFINE_SIMPLE_DEV_PM_OPS(), and the dev_pm_ops symbol will be
>>    exported.
>> 
>>  - if CONFIG_PM is disabled, these macros will result in a dummy 
>> static
>>    dev_pm_ops to be created with the __maybe_unused flag. The 
>> dev_pm_ops
>>    will then be discarded by the compiler, along with the provided
>>    callback functions if they are not used anywhere else.
>> 
>>  In the second case, the symbol is not exported, which should be
>>  perfectly fine - users of the symbol should all use the pm_ptr() or
>>  pm_sleep_ptr() macro, so the dev_pm_ops marked as "extern" in the
>>  client's code will never be accessed.
>> 
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  ---
>>   include/linux/pm.h | 33 ++++++++++++++++++++++++++++++---
>>   1 file changed, 30 insertions(+), 3 deletions(-)
>> 
>>  diff --git a/include/linux/pm.h b/include/linux/pm.h
>>  index 389e600df233..a1ce29566aea 100644
>>  --- a/include/linux/pm.h
>>  +++ b/include/linux/pm.h
>>  @@ -8,6 +8,7 @@
>>   #ifndef _LINUX_PM_H
>>   #define _LINUX_PM_H
>> 
>>  +#include <linux/export.h>
>>   #include <linux/list.h>
>>   #include <linux/workqueue.h>
>>   #include <linux/spinlock.h>
>>  @@ -357,14 +358,40 @@ struct dev_pm_ops {
>>   #define SET_RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn)
>>   #endif
>> 
>>  +#define _DEFINE_DEV_PM_OPS(name, \
>>  +			   suspend_fn, resume_fn, \
>>  +			   runtime_suspend_fn, runtime_resume_fn, idle_fn) \
>>  +const struct dev_pm_ops name = { \
>>  +	SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
>>  +	RUNTIME_PM_OPS(runtime_suspend_fn, runtime_resume_fn, idle_fn) \
>>  +}
>>  +
> 
> one blank line probably enough.
> 
>>  +
>>   /*
>>    * Use this if you want to use the same suspend and resume 
>> callbacks for suspend
>>    * to RAM and hibernation.
>>    */
>>   #define DEFINE_SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
>>  -const struct dev_pm_ops name = { \
>>  -	SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
>>  -}
>>  +	_DEFINE_DEV_PM_OPS(name, suspend_fn, resume_fn, NULL, NULL, NULL)
>>  +
>>  +#ifdef CONFIG_PM
>>  +#define _EXPORT_DEV_PM_OPS(name, suspend_fn, resume_fn, 
>> runtime_suspend_fn, \
>>  +			   runtime_resume_fn, idle_fn, sec) \
>>  +	_DEFINE_DEV_PM_OPS(name, suspend_fn, resume_fn, 
>> runtime_suspend_fn, \
>>  +			   runtime_resume_fn, idle_fn); \
>>  +	_EXPORT_SYMBOL(name, sec)
>>  +#else
>>  +#define _EXPORT_DEV_PM_OPS(name, suspend_fn, resume_fn, 
>> runtime_suspend_fn, \
>>  +			   runtime_resume_fn, idle_fn, sec) \
>>  +static __maybe_unused _DEFINE_DEV_PM_OPS(__static_##name, 
>> suspend_fn, \
>>  +					 resume_fn, runtime_suspend_fn, \
>>  +					 runtime_resume_fn, idle_fn)
>>  +#endif
>>  +
>>  +#define EXPORT_SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
>>  +	_EXPORT_DEV_PM_OPS(name, suspend_fn, resume_fn, NULL, NULL, NULL, 
>> "")
>>  +#define EXPORT_GPL_SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
>>  +	_EXPORT_DEV_PM_OPS(name, suspend_fn, resume_fn, NULL, NULL, NULL, 
>> "_gpl")
> 
> So you can get away with these two cases because the 
> SYSTEM_SLEEP_PM_OPS() all have
> pm_sleep_ptr() wrappers.  However, _EXPORT_DEV_PM_OPS() could be used 
> directly and
> would require __maybe_unused for the RUNTIME_PM_OPS() parameters 
> which isn't ideal.

I don't see why. On both cases (CONFIG_PM enabled/disabled) the 
runtime-PM callbacks are referenced directly, so at no point do they 
appear as unused; therefore __maybe_unused is not needed.

Cheers,
-Paul

> Maybe I'm missing some reason that isn't a problem though as easy to 
> get lost in
> these macros. :)
> 
> You could argue that the _ is meant to indicate that macro shouldn't 
> be used directly
> but I'm not that optimistic.
> 
> Jonathan
> 
> 
> 
>> 
>>   /* Deprecated. Use DEFINE_SIMPLE_DEV_PM_OPS() instead. */
>>   #define SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
> 


