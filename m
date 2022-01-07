Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF041487A6A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 17:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348275AbiAGQdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 11:33:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348268AbiAGQdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 11:33:42 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9A3C06173F
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 08:33:41 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id k21so17567198lfu.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 08:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UhF6StDpI+3ZSQ6faKXsbBjH2ED0Nvwq42ETEz4x9/g=;
        b=GfA0cldfIieDD4gKWyksixy8aDD3yca5nIRpVxlKor5YXoZ73svrV5gQNQWU1QRS+T
         lG/tO43LaEmQ8cXjrOMICRqHlsDQvFxWqBYVXfOuO5Z18T/XUTq2f+LpzN56W2B4v/Ya
         MvKg+J3KHJQ1Ugg4I+zfX7lQoNo9OSM9/wODvvxXf5xs9BA5ss2+P4+qjCt4PVMtgbi0
         cZKETLV9n482jRFAH+DpdfJVfH9y6GcJn7lgrEagqRIc7p1xYQvYu0D5YSJBsbteBUdR
         Bqc361go5ui1A+xiijGtK+07cIP14v9UBveCyhspOCF7DAoG3KlTMkoXe3S8uaQr6wkk
         qHxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UhF6StDpI+3ZSQ6faKXsbBjH2ED0Nvwq42ETEz4x9/g=;
        b=wZdnbb6jQV6qXIehG+aZhgM1hhVjfPFGoxSsxHG2yEjWUoLhH5sCucAb0SeDE28All
         rD8WEjGsRp/lp7mSieXkEh2wJqOT0tXML/pVpez/+bvYYt7rRFU4dMYuGsAJPnm1ySfe
         7RrpQ5Hu/9hrBBqF6h5wfDGjvbmCyUYTHfxoKHkRNPruR7U+H9Hzp+3Uh2gWO30gXeK5
         MBhad/pWyqJ4qmYAVaLZpEav2q1YOUgaQhE85wVq4Ht7RuXPbOcaGgFAFe+gNrrZkaS9
         rT7KN3HdDD4j/cwgoDwQHronK0sWoSvMZhsXQDqabJyDS/qbp06R6iM5leI63iyBSZfL
         tYxg==
X-Gm-Message-State: AOAM53389j7zxYSe/b4PKYO9qQUIbF0dLeNyR+igQqGB/kBEbrz2GSrl
        86RCDYStPFFDQWPh3vRVkZxKXhtnOBqHre4WDW3QMA==
X-Google-Smtp-Source: ABdhPJzEuYs2SrCVpC4N16SjpYsCCsLOn5le1WCCeYZTgg3m4RBql877sG3Jf9246QuyNJuQuYqOyfGO06QpvouC8jI=
X-Received: by 2002:a05:651c:1246:: with SMTP id h6mr39389480ljh.300.1641573220004;
 Fri, 07 Jan 2022 08:33:40 -0800 (PST)
MIME-Version: 1.0
References: <20220105182939.106885-1-paul@crapouillou.net> <20220105182939.106885-4-paul@crapouillou.net>
In-Reply-To: <20220105182939.106885-4-paul@crapouillou.net>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 7 Jan 2022 17:33:04 +0100
Message-ID: <CAPDyKFpUUPzqonNBrFq68h8QOVxardvf2q7AuEQVeUJ-S2726A@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] PM: core: Add EXPORT[_GPL]_SIMPLE_DEV_PM_OPS macros
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

On Wed, 5 Jan 2022 at 19:30, Paul Cercueil <paul@crapouillou.net> wrote:
>
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

How common is it to export the dev_pm_ops? Do we really need a macro for this?

The similar comment/question applies for patch5.

>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Kind regards
Uffe

> ---
>
> Notes:
>     v2: Remove useless empty line
>
>  include/linux/pm.h | 32 +++++++++++++++++++++++++++++---
>  1 file changed, 29 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index 389e600df233..b82f40e701ab 100644
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
> @@ -357,14 +358,39 @@ struct dev_pm_ops {
>  #define SET_RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn)
>  #endif
>
> +#define _DEFINE_DEV_PM_OPS(name, \
> +                          suspend_fn, resume_fn, \
> +                          runtime_suspend_fn, runtime_resume_fn, idle_fn) \
> +const struct dev_pm_ops name = { \
> +       SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
> +       RUNTIME_PM_OPS(runtime_suspend_fn, runtime_resume_fn, idle_fn) \
> +}
> +
>  /*
>   * Use this if you want to use the same suspend and resume callbacks for suspend
>   * to RAM and hibernation.
>   */
>  #define DEFINE_SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
> -const struct dev_pm_ops name = { \
> -       SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
> -}
> +       _DEFINE_DEV_PM_OPS(name, suspend_fn, resume_fn, NULL, NULL, NULL)
> +
> +#ifdef CONFIG_PM
> +#define _EXPORT_DEV_PM_OPS(name, suspend_fn, resume_fn, runtime_suspend_fn, \
> +                          runtime_resume_fn, idle_fn, sec) \
> +       _DEFINE_DEV_PM_OPS(name, suspend_fn, resume_fn, runtime_suspend_fn, \
> +                          runtime_resume_fn, idle_fn); \
> +       _EXPORT_SYMBOL(name, sec)
> +#else
> +#define _EXPORT_DEV_PM_OPS(name, suspend_fn, resume_fn, runtime_suspend_fn, \
> +                          runtime_resume_fn, idle_fn, sec) \
> +static __maybe_unused _DEFINE_DEV_PM_OPS(__static_##name, suspend_fn, \
> +                                        resume_fn, runtime_suspend_fn, \
> +                                        runtime_resume_fn, idle_fn)
> +#endif
> +
> +#define EXPORT_SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
> +       _EXPORT_DEV_PM_OPS(name, suspend_fn, resume_fn, NULL, NULL, NULL, "")
> +#define EXPORT_GPL_SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
> +       _EXPORT_DEV_PM_OPS(name, suspend_fn, resume_fn, NULL, NULL, NULL, "_gpl")
>
>  /* Deprecated. Use DEFINE_SIMPLE_DEV_PM_OPS() instead. */
>  #define SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
> --
> 2.34.1
>
