Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F20B48D57F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 11:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbiAMKOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 05:14:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbiAMKOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 05:14:34 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4299DC06173F
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 02:14:34 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id a7so6171178plh.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 02:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TkZGo4ib8VZZ8ihxuuV6YmzTOBkymNznVCB4ykbKHBg=;
        b=uODuKrRl1kYEThI/weFKqxAvCbXumiOqI9vUSZUZJXGstj2DtxeU5fADGwhPsjGE3F
         BOByd07tgtRdxlbSjo6q0kKfh3yhgF2D//MQ+HsUDDFpFasPJQjqoDUzGdpwyMPkR3vh
         WMKIaoGpV1SI8iMAY2uWbwhWDMNtji6KtkEe5Dsi5ppjmtxGSbd5tTY/FRN3RchIe6oN
         74abPUv1Cr62B4zACwpwvgkNhSNQFE6bQyR7VkCcYbAg0gswZblsr9iIcicwf6rj+ShS
         umE+eXieXXccy3jm4zcXhK1BXbRDuYG9DlUR6SvtC3tdZLWHnU/X+w5yySgkdCmUyoKA
         ePNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TkZGo4ib8VZZ8ihxuuV6YmzTOBkymNznVCB4ykbKHBg=;
        b=J23qjNB7QzjOVcdIqT3Imi5WphH96lOAM92xxmv2YBy5+XEK3V+87ea1T2Y7Z89yrj
         OCPA/hB9MpdmjnfInyE62K81QxfnP2ZHatpf3+iaDlHRY+e1D+J4MBZ2rwLgj52Leamn
         SxYali0PBijuWaLNsz654LA4fge4aTEzhHFWNyxoK0Apa3/aOHvmzRHFa1sfRxypIC/U
         xEsI9JauHQeHQTKwtn5KTK3M9rO9j2RHAsGz2UA9ezEpHI2Ff51yiq9g+n1Iy1OXdutO
         Kmkz5kP4ibI6O1SuoFwOJSrCvnSHmyr+29SYzOTbvgg2+OlB+J2qCDrHROILrtTRY8sY
         4M7g==
X-Gm-Message-State: AOAM530f1Pq7fu5TPvclUHAokEpyKg7a258NvaGU3+iH+bWh9KlSJX3k
        DO/7FZJmNZ39VV4xy35xMlgSAzDzlXERM/bc7/1X3g==
X-Google-Smtp-Source: ABdhPJyOJSTy7FXKwD4Q5dhcJsbga5MTLbhco1lMH1GPghjvgriT6iCmZrF2YwxQHVoWar3BhUS+RPW7JyVq1wUJV/g=
X-Received: by 2002:a17:90b:4b0f:: with SMTP id lx15mr4366831pjb.232.1642068873774;
 Thu, 13 Jan 2022 02:14:33 -0800 (PST)
MIME-Version: 1.0
References: <20220111034051.28913-1-lzmlzmhh@gmail.com>
In-Reply-To: <20220111034051.28913-1-lzmlzmhh@gmail.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Thu, 13 Jan 2022 11:14:22 +0100
Message-ID: <CAG3jFyuZQko8gj6NXnHQ2GoFNfHSYDwkgmb3Wi+upDZFZpPM4Q@mail.gmail.com>
Subject: Re: [PATCH] Remove extra device acquisition method of i2c client in
 lt9611 driver
To:     lzmlzm <lzmlzmhh@gmail.com>
Cc:     a.hajda@samsung.com, narmstrong@baylibre.com,
        laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Thanks for submitting this cleanup patch.

On Tue, 11 Jan 2022 at 04:41, lzmlzm <lzmlzmhh@gmail.com> wrote:
>

A commit message is necessary for all changes, no matter how trivial.

> Signed-off-by: lzmlzm <lzmlzmhh@gmail.com>

Is your name listed correctly above? For the 'Signed-off-by' tag to be
meaningful, a real name needs to be supplied.

> ---
>  drivers/gpu/drm/bridge/lontium-lt9611.c    | 2 +-
>  drivers/gpu/drm/bridge/lontium-lt9611uxc.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/lontium-lt9611.c b/drivers/gpu/drm/bridge/lontium-lt9611.c
> index dafb1b47c15f..e0feb4fd9780 100644
> --- a/drivers/gpu/drm/bridge/lontium-lt9611.c
> +++ b/drivers/gpu/drm/bridge/lontium-lt9611.c
> @@ -1090,7 +1090,7 @@ static int lt9611_probe(struct i2c_client *client,
>         if (!lt9611)
>                 return -ENOMEM;
>
> -       lt9611->dev = &client->dev;
> +       lt9611->dev = dev;
>         lt9611->client = client;
>         lt9611->sleep = false;
>
> diff --git a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
> index 33f9716da0ee..e50e42312e82 100644
> --- a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
> +++ b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
> @@ -860,7 +860,7 @@ static int lt9611uxc_probe(struct i2c_client *client,
>         if (!lt9611uxc)
>                 return -ENOMEM;
>
> -       lt9611uxc->dev = &client->dev;
> +       lt9611uxc->dev = dev;
>         lt9611uxc->client = client;
>         mutex_init(&lt9611uxc->ocm_lock);
>
> --

With these two issues fixed, please submit a v2 of this patch.


Rob.
