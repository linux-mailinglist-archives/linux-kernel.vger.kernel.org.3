Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D02BA489876
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 13:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245362AbiAJMTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 07:19:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245356AbiAJMTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 07:19:37 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79BCC061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 04:19:36 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id x7so43580033lfu.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 04:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oItLJqty6s53Y67BNr1LeaFk3C3IPxdqdZSq0A/p/Zc=;
        b=W9E+tboVCcYCEqiAMgrWXq1sx+HJoOHmwwyVUKW3oIvCiUj9F28OcSPJFgzqPsM7Lz
         CT0aMoC6lVCrPQ/LKJVLStgZL9rN+E9hEzCd3rrIqRsfgptvdazd3oS+o7YhjHJZKCyD
         fCCR2YjUqTzxXnECAHaVWr/UBLKg/ap4yd3qYGecva/m9KXmcmLcnJvkHMESbhpxnMGd
         mFPdCBFjBHw9tRWFwIBh7ZORM00dzMrofv02pDTo60LAWdxw93Euhe/7N6zAy3tEMmeD
         x4PR+lJK3PoLaXi7pV2IjkEM0Wk9FjufWcrej8K0TPIlj8E0MbSMtlsN+zxRveJzrc2A
         siPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oItLJqty6s53Y67BNr1LeaFk3C3IPxdqdZSq0A/p/Zc=;
        b=2nIXAhMNmhyeqQ28Th3EtSCpBf3IUq8zkBTn8imKA4LHd3rqcCr8gu8n8FaLPr4m37
         QJyAxHHG2qACizTnLYehd1zX9J29rFIlKO8Ximcw1dE684EeEQP0I8wjFEkWheoNl38i
         vOHS6DRgYlGnKeP5qS4ZGcdassdTDEj4eZKT0DDp9JvXAPROQvzb6aLJjKNKczw5wcIJ
         0agu946tNHDltLOEThkuX1cIYv0/q7S7ekXt1YgUYZL0U/QElsSLBwHgFxNOZVWgRhsu
         Ngc7fuzj2Sg8sscchmZzRMjpCxKl+eUdsHl5kcqLRfxlxynAzZk9cif1UkCYpxBkm3hR
         S1oQ==
X-Gm-Message-State: AOAM531HxtYv39wiX2cxe7q/E66W4poRLbARFk+WReruvNZ0jtKh4OdY
        7RB4NBQ2GFl27A9dvRVxW/GUx90OrRzY3SpcqtHVBA==
X-Google-Smtp-Source: ABdhPJwbk3S2fn8ZFetKG19LQFq5sp0v346WOXX8vKHH85YoPDQzN7F39asaudOZFvvguHTzqSAZ/jCrqvB3OUXKqt0=
X-Received: by 2002:a2e:7d08:: with SMTP id y8mr55330598ljc.273.1641817175137;
 Mon, 10 Jan 2022 04:19:35 -0800 (PST)
MIME-Version: 1.0
References: <20220107181723.54392-1-paul@crapouillou.net> <20220107181723.54392-5-paul@crapouillou.net>
In-Reply-To: <20220107181723.54392-5-paul@crapouillou.net>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 10 Jan 2022 13:18:59 +0100
Message-ID: <CAPDyKFqqF_YqQcKLSZvSrPcrNMOnRyq7KghR-o3uuw_udDZB=w@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] PM: runtime: Add DEFINE_RUNTIME_DEV_PM_OPS() macro
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Len Brown <len.brown@intel.com>,
        Pavel Machek <pavel@ucw.cz>, list@opendingux.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Jonathan Cameron <jonathan.cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jan 2022 at 19:17, Paul Cercueil <paul@crapouillou.net> wrote:
>
> A lot of drivers create a dev_pm_ops struct with the system sleep
> suspend/resume callbacks set to pm_runtime_force_suspend() and
> pm_runtime_force_resume().
>
> These drivers can now use the DEFINE_RUNTIME_DEV_PM_OPS() macro, which
> will use pm_runtime_force_{suspend,resume}() as the system sleep
> callbacks, while having the same dead code removal characteristic that
> is already provided by DEFINE_SIMPLE_DEV_PM_OPS().
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>
> Notes:
>     v2-v3: No change
>
>  include/linux/pm.h         |  3 ++-
>  include/linux/pm_runtime.h | 14 ++++++++++++++
>  2 files changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index 8279af2c538a..f7d2be686359 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -414,7 +414,8 @@ const struct dev_pm_ops __maybe_unused name = { \
>   * .resume_early(), to the same routines as .runtime_suspend() and
>   * .runtime_resume(), respectively (and analogously for hibernation).
>   *
> - * Deprecated. You most likely don't want this macro.
> + * Deprecated. You most likely don't want this macro. Use
> + * DEFINE_RUNTIME_DEV_PM_OPS() instead.
>   */
>  #define UNIVERSAL_DEV_PM_OPS(name, suspend_fn, resume_fn, idle_fn) \
>  const struct dev_pm_ops __maybe_unused name = { \
> diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> index 016de5776b6d..4af454d29281 100644
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -22,6 +22,20 @@
>                                             usage_count */
>  #define RPM_AUTO               0x08    /* Use autosuspend_delay */
>
> +/*
> + * Use this for defining a set of PM operations to be used in all situations
> + * (system suspend, hibernation or runtime PM).
> + *
> + * Note that the behaviour differs from the deprecated UNIVERSAL_DEV_PM_OPS()
> + * macro, which uses the provided callbacks for both runtime PM and system
> + * sleep, while DEFINE_RUNTIME_DEV_PM_OPS() uses pm_runtime_force_suspend()
> + * and pm_runtime_force_resume() for its system sleep callbacks.
> + */
> +#define DEFINE_RUNTIME_DEV_PM_OPS(name, suspend_fn, resume_fn, idle_fn) \
> +       _DEFINE_DEV_PM_OPS(name, pm_runtime_force_suspend, \
> +                          pm_runtime_force_resume, suspend_fn, \
> +                          resume_fn, idle_fn)
> +
>  #ifdef CONFIG_PM
>  extern struct workqueue_struct *pm_wq;
>
> --
> 2.34.1
>
