Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAE3A47232B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 09:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbhLMIoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 03:44:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbhLMIob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 03:44:31 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545ACC061748
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 00:44:31 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id t11so14500683qtw.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 00:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dowhile0-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h4WDvjM2kgyM01qsLxjBdup3VQZvL5+0/2y39dEt4C8=;
        b=BEKQMXeItUho4Q0NwJ1f8FstJ+Jf7PJ9R80lW/4yWOljS10XpFJ5HT0VacDeVVZ5dB
         RA8M/ibrXbb86GoJWidGhnp2LswMUu5ZEA8I+eBMOhkaVFr147SQCO22fS8My096MzHz
         /b4tB4pB3SK5lX3cOoqr4/vD0aAw3Bltsw/sRGVFuY5u0FVY/ewz5xqM6AScU3FhIGaF
         hzZZ8sjjAb530wrrBoAn2oyZwohVZ0dYe+J0zWB1Hrrao9Y0iWo3GoXfTu3jVY75H8s0
         sLy7Kmn6LBGQsS1Oq/Lj79Q5YUshGorcNIQIt/kifgDCscax9hh6tfa28rNWxSWGu/+Z
         Mp5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h4WDvjM2kgyM01qsLxjBdup3VQZvL5+0/2y39dEt4C8=;
        b=zJqJ0feDhr6DRsoOBbAMlQIjtzGItXgJoZt3iK5e2AQlMXz4uBHjDhSQa4ada+euGd
         0mGF9PX/vvl950PobucNdLkXMcmX/ZM5j4OGDUc8myVmzVKdjJqUSYr122KiT/5I9GmL
         9l9s7/O9j+fAnu7oQk9C+eKkunwA/Pvsm+6QSjd+ZK2AF746tsTN/lvo/8lLvghdrvQ6
         vb30Miuiag9vCwNfck69kZV00waPhePQ4kJzCdPrV91X4TpEpFCkSwnV6wjQ5p6EZPTP
         Ka6dwRyxd2Y4HzVd6FUpPjyfLAQtC6EASRusiNzDzFoeJuNDODV2uissyH85MjquO663
         +v7A==
X-Gm-Message-State: AOAM530WqIIg74JsZaAXVE88x8ihmsPuUpT0zilO//JH1dz/DXDwm/av
        zm1M2ZXhgaSKKEDqKL7imVl+ZMdWI/SWCvLK+f0oWw==
X-Google-Smtp-Source: ABdhPJziiOVM2+Dx6BT3tLzDj98Xw0vskZvlatbAvbgT2x6SaH8jcF/6PODw5NoYcf9gsRZOzBLKdkLelCk4wGV+gos=
X-Received: by 2002:a05:622a:202:: with SMTP id b2mr43442164qtx.34.1639385070353;
 Mon, 13 Dec 2021 00:44:30 -0800 (PST)
MIME-Version: 1.0
References: <20211212062407.138309-1-marcan@marcan.st> <20211212062407.138309-2-marcan@marcan.st>
In-Reply-To: <20211212062407.138309-2-marcan@marcan.st>
From:   Javier Martinez Canillas <javier@dowhile0.org>
Date:   Mon, 13 Dec 2021 09:44:19 +0100
Message-ID: <CABxcv=m4fu8h=FwY7R=thuvd13_ZbFqB9rNNN07QOAd__jdYSQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] of: Move simple-framebuffer device handling from
 simplefb to of
To:     Hector Martin <marcan@marcan.st>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        devicetree@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Hector,

On Sun, Dec 12, 2021 at 7:24 AM Hector Martin <marcan@marcan.st> wrote:
>
> This code is required for both simplefb and simpledrm, so let's move it
> into the OF core instead of having it as an ad-hoc initcall in the
> drivers.
>
> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  drivers/of/platform.c          |  4 ++++
>  drivers/video/fbdev/simplefb.c | 21 +--------------------
>  2 files changed, 5 insertions(+), 20 deletions(-)
>

This is indeed a much better approach than what I suggested. I just
have one comment.

> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index b3faf89744aa..793350028906 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -540,6 +540,10 @@ static int __init of_platform_default_populate_init(void)
>                 of_node_put(node);
>         }
>
> +       node = of_get_compatible_child(of_chosen, "simple-framebuffer");

You have to check if the node variable is NULL here.

> +       of_platform_device_create(node, NULL, NULL);

Otherwise this could lead to a NULL pointer dereference if debug
output is enabled (the node->full_name is printed).

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Best regards,
Javier
