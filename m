Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0E1485098
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 11:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239169AbiAEKDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 05:03:32 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4337 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239176AbiAEKD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 05:03:29 -0500
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JTQ0n6CRPz67lT1;
        Wed,  5 Jan 2022 17:58:33 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 5 Jan 2022 11:03:26 +0100
Received: from localhost (10.47.83.118) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Wed, 5 Jan
 2022 10:03:25 +0000
Date:   Wed, 5 Jan 2022 10:03:32 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Paul Cercueil <paul@crapouillou.net>
CC:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Arnd Bergmann" <arnd@arndb.de>, Len Brown <len.brown@intel.com>,
        Pavel Machek <pavel@ucw.cz>, <list@opendingux.net>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mips@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 3/8] PM: core: Add EXPORT[_GPL]_SIMPLE_DEV_PM_OPS macros
Message-ID: <20220105100332.000001c1@Huawei.com>
In-Reply-To: <20220104214214.198843-4-paul@crapouillou.net>
References: <20220104214214.198843-1-paul@crapouillou.net>
        <20220104214214.198843-4-paul@crapouillou.net>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.83.118]
X-ClientProxiedBy: lhreml704-chm.china.huawei.com (10.201.108.53) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jan 2022 21:42:09 +0000
Paul Cercueil <paul@crapouillou.net> wrote:

> These macros are defined conditionally, according to CONFIG_PM:
> - if CONFIG_PM is enabled, these macros resolve to
>   DEFINE_SIMPLE_DEV_PM_OPS(), and the dev_pm_ops symbol will be
>   exported.
> 
> - if CONFIG_PM is disabled, these macros will result in a dummy static
>   dev_pm_ops to be created with the __maybe_unused flag. The dev_pm_ops
>   will then be discarded by the compiler, along with the provided
>   callback functions if they are not used anywhere else.
> 
> In the second case, the symbol is not exported, which should be
> perfectly fine - users of the symbol should all use the pm_ptr() or
> pm_sleep_ptr() macro, so the dev_pm_ops marked as "extern" in the
> client's code will never be accessed.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  include/linux/pm.h | 33 ++++++++++++++++++++++++++++++---
>  1 file changed, 30 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index 389e600df233..a1ce29566aea 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -8,6 +8,7 @@
>  #ifndef _LINUX_PM_H
>  #define _LINUX_PM_H
>  
> +#include <linux/export.h>
>  #include <linux/list.h>
>  #include <linux/workqueue.h>
>  #include <linux/spinlock.h>
> @@ -357,14 +358,40 @@ struct dev_pm_ops {
>  #define SET_RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn)
>  #endif
>  
> +#define _DEFINE_DEV_PM_OPS(name, \
> +			   suspend_fn, resume_fn, \
> +			   runtime_suspend_fn, runtime_resume_fn, idle_fn) \
> +const struct dev_pm_ops name = { \
> +	SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
> +	RUNTIME_PM_OPS(runtime_suspend_fn, runtime_resume_fn, idle_fn) \
> +}
> +

one blank line probably enough.

> +
>  /*
>   * Use this if you want to use the same suspend and resume callbacks for suspend
>   * to RAM and hibernation.
>   */
>  #define DEFINE_SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
> -const struct dev_pm_ops name = { \
> -	SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
> -}
> +	_DEFINE_DEV_PM_OPS(name, suspend_fn, resume_fn, NULL, NULL, NULL)
> +
> +#ifdef CONFIG_PM
> +#define _EXPORT_DEV_PM_OPS(name, suspend_fn, resume_fn, runtime_suspend_fn, \
> +			   runtime_resume_fn, idle_fn, sec) \
> +	_DEFINE_DEV_PM_OPS(name, suspend_fn, resume_fn, runtime_suspend_fn, \
> +			   runtime_resume_fn, idle_fn); \
> +	_EXPORT_SYMBOL(name, sec)
> +#else
> +#define _EXPORT_DEV_PM_OPS(name, suspend_fn, resume_fn, runtime_suspend_fn, \
> +			   runtime_resume_fn, idle_fn, sec) \
> +static __maybe_unused _DEFINE_DEV_PM_OPS(__static_##name, suspend_fn, \
> +					 resume_fn, runtime_suspend_fn, \
> +					 runtime_resume_fn, idle_fn)
> +#endif
> +
> +#define EXPORT_SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
> +	_EXPORT_DEV_PM_OPS(name, suspend_fn, resume_fn, NULL, NULL, NULL, "")
> +#define EXPORT_GPL_SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
> +	_EXPORT_DEV_PM_OPS(name, suspend_fn, resume_fn, NULL, NULL, NULL, "_gpl")

So you can get away with these two cases because the SYSTEM_SLEEP_PM_OPS() all have
pm_sleep_ptr() wrappers.  However, _EXPORT_DEV_PM_OPS() could be used directly and
would require __maybe_unused for the RUNTIME_PM_OPS() parameters which isn't ideal.

Maybe I'm missing some reason that isn't a problem though as easy to get lost in
these macros. :)

You could argue that the _ is meant to indicate that macro shouldn't be used directly
but I'm not that optimistic.

Jonathan



>  
>  /* Deprecated. Use DEFINE_SIMPLE_DEV_PM_OPS() instead. */
>  #define SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \

