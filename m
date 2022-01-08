Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 575BF4884F7
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 18:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233648AbiAHRdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 12:33:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbiAHRdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 12:33:54 -0500
Received: from balrog.mythic-beasts.com (balrog.mythic-beasts.com [IPv6:2a00:1098:0:82:1000:0:2:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E46DC06173F;
        Sat,  8 Jan 2022 09:33:53 -0800 (PST)
Received: from [81.101.6.87] (port=34286 helo=jic23-huawei)
        by balrog.mythic-beasts.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <jic23@jic23.retrosnub.co.uk>)
        id 1n6Faq-0001DM-Oj; Sat, 08 Jan 2022 17:33:33 +0000
Date:   Sat, 8 Jan 2022 17:38:51 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Len Brown <len.brown@intel.com>,
        Pavel Machek <pavel@ucw.cz>, list@opendingux.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3 3/6] PM: core: Add EXPORT[_GPL]_SIMPLE_DEV_PM_OPS
 macros
Message-ID: <20220108173825.08ebf8ba@jic23-huawei>
In-Reply-To: <20220107181723.54392-4-paul@crapouillou.net>
References: <20220107181723.54392-1-paul@crapouillou.net>
        <20220107181723.54392-4-paul@crapouillou.net>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BlackCat-Spam-Score: 19
X-Spam-Status: No, score=1.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  7 Jan 2022 18:17:20 +0000
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
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Hi Paul,

Can definitely be a follow up rather than needing to be in this series
but an EXPORT_NS_[_GPL]_SIMPLE_DEV_PM_OPS() will be needed as I suspect
a lot of the places that export pm_ops structures will have their exports
moved to a namespace at somepoint.

That can easily go in with the first user though rather than needing
to be rushed in now.

Jonathan

> ---
> 
> Notes:
>     v2: Remove useless empty line
>     v3: - Reorder the code to have non-private macros together in the file
>         - Add comment about the necesity to use the new export macro when
>           the dev_pm_ops has to be exported
> 
>  include/linux/pm.h | 35 ++++++++++++++++++++++++++++++++---
>  1 file changed, 32 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index 8e13387e70ec..8279af2c538a 100644
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
> @@ -357,14 +358,42 @@ struct dev_pm_ops {
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
>  /*
>   * Use this if you want to use the same suspend and resume callbacks for suspend
>   * to RAM and hibernation.
> + *
> + * If the underlying dev_pm_ops struct symbol has to be exported, use
> + * EXPORT_SIMPLE_DEV_PM_OPS() or EXPORT_GPL_SIMPLE_DEV_PM_OPS() instead.
>   */
>  #define DEFINE_SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
> -const struct dev_pm_ops name = { \
> -	SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
> -}
> +	_DEFINE_DEV_PM_OPS(name, suspend_fn, resume_fn, NULL, NULL, NULL)
> +
> +#define EXPORT_SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
> +	_EXPORT_DEV_PM_OPS(name, suspend_fn, resume_fn, NULL, NULL, NULL, "")
> +#define EXPORT_GPL_SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
> +	_EXPORT_DEV_PM_OPS(name, suspend_fn, resume_fn, NULL, NULL, NULL, "_gpl")
>  
>  /* Deprecated. Use DEFINE_SIMPLE_DEV_PM_OPS() instead. */
>  #define SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \

