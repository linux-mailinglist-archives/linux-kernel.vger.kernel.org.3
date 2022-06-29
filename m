Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F084A560568
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 18:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbiF2QJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 12:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232027AbiF2QJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 12:09:20 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FABA20BF2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 09:09:19 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id pk21so33609391ejb.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 09:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JDZdXHc/WphZg80zTh85LyzZS5T7NHb+tCoW2mm59OU=;
        b=J9HxEwV3n+R04yS/42UfmWmxhW+k5z5P8BuhtL4w53/Nl5JV6km2qp6KrCt4X7eGx2
         67xG74PT4oJtkgzPJ3GlNoYKFINs1daCGdR0q2yyKAELO5jwm9nDPmXyxEWYGaUpUm76
         rzVb0HTiuU+JlLEuJEESm9M/c3xQFxHgJ1y7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JDZdXHc/WphZg80zTh85LyzZS5T7NHb+tCoW2mm59OU=;
        b=x2uhKsFJl5PiijKyGDWgHpY7t2Zf3kf+GRwQ8avY9VCc/i2SKdWkZaOPy1iEaz7aOm
         CM8qLccy6a7tuVHqMP/TV2PwS4e4tABd6wzRDfCE9bUppg8XS4Xsr9c0MLF7PpN57Z1K
         IGG69b1LwIkrc6fFnjJmDhNEqwIcdglsvI/XjsfRy1NcdCh2S2/rhMBAT0HholDq4o3f
         IVV7jBriZ8ILDO634gFHXnpUe5DuKcHkQ+CymTIcc107qxORYn2uTVxXO/nFv0jb2AGh
         2WoiszO8KIjD9gcqSiXX308wzP47talHeaHnJZK7ESQxNiYR4AVTieEBm1BiXgcHCUcn
         CSXg==
X-Gm-Message-State: AJIora+PQyIQtaFTfUtFQq4dLh05v8x1oBPUnbTx1rLlfYHSH39fsxU6
        2WNEhfyYcuMFahQUqfseDVq8qImIakhijn4AbxmN2Q==
X-Google-Smtp-Source: AGRyM1szLBHVbi6zOMzheJPJbhBaypovfe5Tpwg0NHcZ0Qb5aSvDOhIremhJNjtUHHe+ifmv75aalV85sZjzYtAkVe0=
X-Received: by 2002:a17:906:9b92:b0:722:f705:759d with SMTP id
 dd18-20020a1709069b9200b00722f705759dmr4069538ejc.745.1656518957624; Wed, 29
 Jun 2022 09:09:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220628104650.2239191-1-hsinyi@chromium.org>
In-Reply-To: <20220628104650.2239191-1-hsinyi@chromium.org>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Thu, 30 Jun 2022 00:08:51 +0800
Message-ID: <CAJMQK-j6VMBrt+31ozUw7V50SFn-PXQWtO1jq+b05TTCNToiAg@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: anx7625: use pm_runtime_force_suspend(resume)
To:     Robert Foss <robert.foss@linaro.org>, Xin Ji <xji@analogixsemi.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <maxime@cerno.tech>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 6:46 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> There's no need to check for IRQ or disable it in suspend.
>
> Use pm_runtime_force_suspend(resume) to make sure anx7625 is powered off
> correctly. Make the system suspend/resume and pm runtime suspend/resume
> more consistant.
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
The patch is re-sent again with other anx7625 patches in this series:
https://lore.kernel.org/lkml/20220629160550.433980-1-hsinyi@chromium.org/


>  drivers/gpu/drm/bridge/analogix/anx7625.c | 33 ++---------------------
>  1 file changed, 2 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> index 3710fa9ee0acd..09688a1076037 100644
> --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> @@ -2542,38 +2542,9 @@ static int __maybe_unused anx7625_runtime_pm_resume(struct device *dev)
>         return 0;
>  }
>
> -static int __maybe_unused anx7625_resume(struct device *dev)
> -{
> -       struct anx7625_data *ctx = dev_get_drvdata(dev);
> -
> -       if (!ctx->pdata.intp_irq)
> -               return 0;
> -
> -       if (!pm_runtime_enabled(dev) || !pm_runtime_suspended(dev)) {
> -               enable_irq(ctx->pdata.intp_irq);
> -               anx7625_runtime_pm_resume(dev);
> -       }
> -
> -       return 0;
> -}
> -
> -static int __maybe_unused anx7625_suspend(struct device *dev)
> -{
> -       struct anx7625_data *ctx = dev_get_drvdata(dev);
> -
> -       if (!ctx->pdata.intp_irq)
> -               return 0;
> -
> -       if (!pm_runtime_enabled(dev) || !pm_runtime_suspended(dev)) {
> -               anx7625_runtime_pm_suspend(dev);
> -               disable_irq(ctx->pdata.intp_irq);
> -       }
> -
> -       return 0;
> -}
> -
>  static const struct dev_pm_ops anx7625_pm_ops = {
> -       SET_SYSTEM_SLEEP_PM_OPS(anx7625_suspend, anx7625_resume)
> +       SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> +                               pm_runtime_force_resume)
>         SET_RUNTIME_PM_OPS(anx7625_runtime_pm_suspend,
>                            anx7625_runtime_pm_resume, NULL)
>  };
> --
> 2.37.0.rc0.161.g10f37bed90-goog
>
