Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D4F4C8939
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 11:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbiCAK2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 05:28:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbiCAK2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 05:28:11 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11AA95F57
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 02:27:24 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id bn33so21247384ljb.6
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 02:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2i+D2PqtcWDc5KoZLbt1OkpDgJIEvu6U0OQ0ZqUGBOU=;
        b=LUb0D4AOtYKuu3o3RMENT8fWAAIPqnz3tK1e2GYt1n2IGj411QDVPC3bTl6VyGMsXu
         vKDXGBRX6kRktQq1VS7QmPsFecnmdnMBzCg3OROSq+PuwAWJAY6nctOsoaRzDWret1yj
         6KRxOtEdpkaxgfbQAri7Sv4FN0g6QUuQ17a/huvn00u9e2s8KlN+FChvyqO9z1LHF2MK
         UXDj26HmPP3JuUsGqGwpj/q+3grsd1EiCwyrb1SCbSFpFAvxrvAY6RuBixdN8YRC1X56
         CCFuQoIJve168JO/KZ8m6begRfbtWpOUq+X1yWXk3qMD4zW0SQCM8y25jcStovPImJww
         h5xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2i+D2PqtcWDc5KoZLbt1OkpDgJIEvu6U0OQ0ZqUGBOU=;
        b=64/1EJzKi7CyCH+4PqkwaoIWbuhG73oKteAyb0A+dzzVEKxed97gk4Vybee3XrUW0c
         Y6WqStOb+uYgdkfV8lJxS6rFeT8rCtEvjydAqwrF/EJmQt9JGgTkGImR8Bb93WErVkmr
         b16VoowsxnvAQuBvCtQ6vD9ZALTLNNoghwGRfKiA4yA80w002XFrhVd5utRbhe9ldVf/
         f7y1FwIzX9Ku0U/b5mJ3W9iuHZI730iOrX+8kHt2s1OVZ51VPC1Ri5OyIqJqrRoAg1rH
         1W3+82uF3hCO7EJPYiNH9WOhaW8MRzr1iv13xf9mUyT6DeDjlT1WBOKPVnHaFRyvP8QJ
         tmbg==
X-Gm-Message-State: AOAM532h8kAcKFqNJrmxsYOfarHaVPnj/Ra+4IFJ7WgfIufzeEagu5v7
        C6XfAeR0HBKz9p7HMkAdPGoxfFwHgYoueEOi4ipG0Q==
X-Google-Smtp-Source: ABdhPJwfMVDrAIuUOqBJa/BAlR77m5tBBCI4Nx3/rN8zw7wSDvQg4tEVnXyNw2+J+E43j9ppcyEVYlZr2Ix9iGFjdqY=
X-Received: by 2002:a05:651c:201b:b0:246:34b5:155e with SMTP id
 s27-20020a05651c201b00b0024634b5155emr15953966ljo.273.1646130442354; Tue, 01
 Mar 2022 02:27:22 -0800 (PST)
MIME-Version: 1.0
References: <20220223083441.1.I925ce9fa12992a58caed6b297e0171d214866fe7@changeid>
In-Reply-To: <20220223083441.1.I925ce9fa12992a58caed6b297e0171d214866fe7@changeid>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 1 Mar 2022 11:26:46 +0100
Message-ID: <CAPDyKFrDncw0D2ccw9GJS+oRdm2kROJh25OV9pMs+992vQV-cQ@mail.gmail.com>
Subject: Re: [PATCH] PM: runtime: Have devm_pm_runtime_enable() handle pm_runtime_dont_use_autosuspend()
To:     Douglas Anderson <dianders@chromium.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Feb 2022 at 17:35, Douglas Anderson <dianders@chromium.org> wrote:
>
> The PM Runtime docs say:
>   Drivers in ->remove() callback should undo the runtime PM changes done
>   in ->probe(). Usually this means calling pm_runtime_disable(),
>   pm_runtime_dont_use_autosuspend() etc.
>
> From grepping code, it's clear that many people aren't aware of the
> need to call pm_runtime_dont_use_autosuspend().

Well, I admit it's good practice that they should take care of this.

However, it doesn't really matter to keep the autosuspend turned on
when runtime PM becomes disabled, I think. When the driver gets probed
again, it will most likely call pm_runtime_use_autosuspend() again,
which should work fine, right?

>
> When brainstorming solutions, one idea that came up was to leverage
> the new-ish devm_pm_runtime_enable() function. The idea here is that:
> * When the devm action is called we know that the driver is being
>   removed. It's the perfect time to undo the use_autosuspend.
> * The code of pm_runtime_dont_use_autosuspend() already handles the
>   case of being called when autosuspend wasn't enabled.

Hmm, I am hesitating to extend devm_pm_runtime_enable(), as it
currently makes it look too simple to turn off things at ->remove()
for runtime PM. While in fact it's more complicated.

A bigger problem, for example, is that a driver calls
pm_runtime_put_sync() during ->remove(), relying on that it actually
ends up calling its ->runtime_suspend() callback to turn off various
specific resources for the device. And in fact there are no guarantees
that will happen - and when it doesn't, the next time the driver's
->probe() runs, things are likely to be really screwed up.

To cover this case, one could use the below code in the ->remove() callback:

...
pm_runtime_get_sync();

"turn off resources for the devices - like calling
clk_disable_unprepare(), for example"

pm_runtime_disable();
pm_runtime_put_noidle();
...

In this example, it would be too late to call pm_runtime_disable()
through the pm_runtime_disable_action().

Kind regards
Uffe

>
> Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  drivers/base/power/runtime.c | 5 +++++
>  include/linux/pm_runtime.h   | 4 ++++
>  2 files changed, 9 insertions(+)
>
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 2f3cce17219b..d4059e6ffeae 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -1476,11 +1476,16 @@ EXPORT_SYMBOL_GPL(pm_runtime_enable);
>
>  static void pm_runtime_disable_action(void *data)
>  {
> +       pm_runtime_dont_use_autosuspend(data);
>         pm_runtime_disable(data);
>  }
>
>  /**
>   * devm_pm_runtime_enable - devres-enabled version of pm_runtime_enable.
> + *
> + * NOTE: this will also handle calling pm_runtime_dont_use_autosuspend() for
> + * you at driver exit time if needed.
> + *
>   * @dev: Device to handle.
>   */
>  int devm_pm_runtime_enable(struct device *dev)
> diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> index 9f09601c465a..2bff6a10095d 100644
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -567,6 +567,10 @@ static inline void pm_runtime_disable(struct device *dev)
>   * Allow the runtime PM autosuspend mechanism to be used for @dev whenever
>   * requested (or "autosuspend" will be handled as direct runtime-suspend for
>   * it).
> + *
> + * NOTE: It's important to undo this with pm_runtime_dont_use_autosuspend()
> + * at driver exit time unless your driver initially enabled pm_runtime
> + * with devm_pm_runtime_enable() (which handles it for you).
>   */
>  static inline void pm_runtime_use_autosuspend(struct device *dev)
>  {
> --
> 2.35.1.473.g83b2b277ed-goog
>
