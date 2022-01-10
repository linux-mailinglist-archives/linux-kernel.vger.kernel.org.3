Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6CD548982B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 12:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245120AbiAJL6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 06:58:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245094AbiAJL6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 06:58:51 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D0CC061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 03:58:50 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id d3so17071691lfv.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 03:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vAXIYuNH/ABiPfxXuFwD6hgcp+PMFzZ1M3jPIGte8RQ=;
        b=NJ/1KfGQ48zcYiEWUDeXEubmTWTNVNFMx+ELOnyY6J+LpNXaV8IC5nwRla3xErpV/s
         TD3hTj+tjN5UDqdhhH1Fwv1KeGp+wSi9yu/hUyLr13SBtxex8FCmU0IkQcz4NZA3haNA
         sskjdqxUaOqcgQl1CXZrfiNtUG4RvqEFEydULZ9huWWhkfyUcuOITbZ/wXmBEgjIMtEe
         dkjXZE0Bn6DsBearqgyC3xlueG6vynTLnXe8Ymf+I3pkfAVZkNv0dnAWWg1Byc3UYwRA
         3PefZz7HTTY6TmTTSy5bWJGzXf6+/dtgPJzNuuoh5iIm+mroxAgS/jfW4o1aLrqxU9hN
         o0EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vAXIYuNH/ABiPfxXuFwD6hgcp+PMFzZ1M3jPIGte8RQ=;
        b=TBfR54A9kCQUN1FkBTYlL3hBv2jiFA1zD6ZUA4OWkkoZGc40zEri6LkUgFvgUHsnt1
         w+0AQt+evCn/Pmys2ZBtQY+YMoQBxfMlzMMJaNeMlUOGSoplrvaoH+vcGfyS27gRuKEO
         OJsR4F8txfI8te6bjHJpPhnptDdnA10K5C3QH5hOTQETNzqxr3mv0F8Op3EpL+M6yvJP
         5kPfIeWhBd8qrpzurXkmtJZVpwiQIpr6Q9RCCM8o5g3ar3KI0cjRd+lXOhYn7IC8P/ze
         9XXRvNzVYqFpvoPGxakYI4LU90/8ty5RE40+MgIzNEe1TYhxVWRi+0jabklExILhNJkX
         vrqg==
X-Gm-Message-State: AOAM531t3iagPXqQT0GujFgMmbb7vBxUhKIQeOBM1bgptlWPCLr4MAre
        Hx8MjFXvn5WhuyRdO0wNVLRhehP/ot7d68XHNOu06g==
X-Google-Smtp-Source: ABdhPJyvU0aPWAbZNBBTFMu8lAzaFaDMBdxzeezJqVEtf7JUnEGWH30MbzadfScGxijR2bznfgG5kndzKGGMa/VaCeE=
X-Received: by 2002:a05:6512:4021:: with SMTP id br33mr4147162lfb.233.1641815928741;
 Mon, 10 Jan 2022 03:58:48 -0800 (PST)
MIME-Version: 1.0
References: <20220107181723.54392-1-paul@crapouillou.net> <20220107181723.54392-2-paul@crapouillou.net>
In-Reply-To: <20220107181723.54392-2-paul@crapouillou.net>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 10 Jan 2022 12:58:12 +0100
Message-ID: <CAPDyKFobtZ_WGtbzhHdBRDT4RjQ8M_NXF+FmqXg2ZHTX=Z1frg@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] PM: core: Remove DEFINE_UNIVERSAL_DEV_PM_OPS() macro
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
> As the new macro DEFINE_UNIVERSAL_DEV_PM_OPS() which was introduced to
> replace UNIVERSAL_DEV_PM_OPS() is currently unused, remove it before
> someone starts to use it in yet another invalid case.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


> ---
>
> Notes:
>     v2: No change
>     v3: - Keep UNIVERSAL_DEV_PM_OPS deprecated
>         - Rework commit message
>
>  include/linux/pm.h | 21 ++++++++-------------
>  1 file changed, 8 insertions(+), 13 deletions(-)
>
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index e1e9402180b9..02f059d814bb 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -366,6 +366,12 @@ static const struct dev_pm_ops name = { \
>         SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
>  }
>
> +/* Deprecated. Use DEFINE_SIMPLE_DEV_PM_OPS() instead. */
> +#define SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
> +const struct dev_pm_ops __maybe_unused name = { \
> +       SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
> +}
> +
>  /*
>   * Use this for defining a set of PM operations to be used in all situations
>   * (system suspend, hibernation or runtime PM).
> @@ -378,20 +384,9 @@ static const struct dev_pm_ops name = { \
>   * suspend and "early" resume callback pointers, .suspend_late() and
>   * .resume_early(), to the same routines as .runtime_suspend() and
>   * .runtime_resume(), respectively (and analogously for hibernation).
> + *
> + * Deprecated. You most likely don't want this macro.
>   */
> -#define DEFINE_UNIVERSAL_DEV_PM_OPS(name, suspend_fn, resume_fn, idle_fn) \
> -static const struct dev_pm_ops name = { \
> -       SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
> -       RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
> -}
> -
> -/* Deprecated. Use DEFINE_SIMPLE_DEV_PM_OPS() instead. */
> -#define SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
> -const struct dev_pm_ops __maybe_unused name = { \
> -       SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
> -}
> -
> -/* Deprecated. Use DEFINE_UNIVERSAL_DEV_PM_OPS() instead. */
>  #define UNIVERSAL_DEV_PM_OPS(name, suspend_fn, resume_fn, idle_fn) \
>  const struct dev_pm_ops __maybe_unused name = { \
>         SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
> --
> 2.34.1
>
