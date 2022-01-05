Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67E91485065
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 10:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239091AbiAEJwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 04:52:50 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4335 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiAEJwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 04:52:49 -0500
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JTPqG33Ygz67XhV;
        Wed,  5 Jan 2022 17:50:18 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Wed, 5 Jan 2022 10:52:46 +0100
Received: from localhost (10.47.83.118) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Wed, 5 Jan
 2022 09:52:45 +0000
Date:   Wed, 5 Jan 2022 09:52:52 +0000
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
Subject: Re: [PATCH 1/8] PM: core: Remove DEFINE_UNIVERSAL_DEV_PM_OPS()
 macro
Message-ID: <20220105095252.00007f7f@Huawei.com>
In-Reply-To: <20220104214214.198843-2-paul@crapouillou.net>
References: <20220104214214.198843-1-paul@crapouillou.net>
        <20220104214214.198843-2-paul@crapouillou.net>
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

On Tue, 4 Jan 2022 21:42:07 +0000
Paul Cercueil <paul@crapouillou.net> wrote:

> The deprecated UNIVERSAL_DEV_PM_OPS() macro uses the provided callbacks
> for both runtime PM and system sleep, which is very likely to be a
> mistake, as a system sleep can be triggered while a given device is
> already PM-suspended, which would cause the suspend callback to be
> called twice.
> 
> The amount of users of UNIVERSAL_DEV_PM_OPS() is also tiny (16
> occurences) compared to the number of places where
> SET_SYSTEM_SLEEP_PM_OPS() is used with pm_runtime_force_suspend() and
> pm_runtime_force_resume(), which makes me think that none of these cases
> are actually valid.
> 
> As this macro is currently unused, remove it before someone starts to
> use it in yet another invalid case.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
I suspect there are cases where calling suspend twice doesn't matter, but
it does seem unlikely to be particularly helpful.

So, makes sense to drop this unless there is some subtlety I'm missing.
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  include/linux/pm.h | 19 ++++++-------------
>  1 file changed, 6 insertions(+), 13 deletions(-)
> 
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index e1e9402180b9..31bbaafb06d2 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -366,6 +366,12 @@ static const struct dev_pm_ops name = { \
>  	SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
>  }
>  
> +/* Deprecated. Use DEFINE_SIMPLE_DEV_PM_OPS() instead. */
> +#define SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
> +const struct dev_pm_ops __maybe_unused name = { \
> +	SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
> +}
> +
>  /*
>   * Use this for defining a set of PM operations to be used in all situations
>   * (system suspend, hibernation or runtime PM).
> @@ -379,19 +385,6 @@ static const struct dev_pm_ops name = { \
>   * .resume_early(), to the same routines as .runtime_suspend() and
>   * .runtime_resume(), respectively (and analogously for hibernation).
>   */
> -#define DEFINE_UNIVERSAL_DEV_PM_OPS(name, suspend_fn, resume_fn, idle_fn) \
> -static const struct dev_pm_ops name = { \
> -	SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
> -	RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
> -}
> -
> -/* Deprecated. Use DEFINE_SIMPLE_DEV_PM_OPS() instead. */
> -#define SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
> -const struct dev_pm_ops __maybe_unused name = { \
> -	SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
> -}
> -
> -/* Deprecated. Use DEFINE_UNIVERSAL_DEV_PM_OPS() instead. */
>  #define UNIVERSAL_DEV_PM_OPS(name, suspend_fn, resume_fn, idle_fn) \
>  const struct dev_pm_ops __maybe_unused name = { \
>  	SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \

