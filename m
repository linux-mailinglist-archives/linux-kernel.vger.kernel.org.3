Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7C6E5318A2
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239142AbiEWQr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 12:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238892AbiEWQrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 12:47:52 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D20A340D7
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 09:47:51 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id f9so30139628ejc.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 09:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MEws4DwjHJownhbfu+ZS9DYpAvJAvD1xJi7PEnph5Es=;
        b=DVN/LllFu0NRh49fsIEhd3xNw/x+qM841drkPE9Auic6RUQhHEOWbHU3m3h5ND4968
         Sz8aznj0zITPihHiFfft7uES0P2bx2aP1FABmWIxcxJ6RIoEKpsN7IbvOnYIlFiKYOk8
         MRcgi6G9XeMhnzg9hDKuj1hUVyFGUz/1fc5P0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MEws4DwjHJownhbfu+ZS9DYpAvJAvD1xJi7PEnph5Es=;
        b=2XtWtE6W5oMYfwxQE5/HNxS9B1RBUoObUu8kJfWZgCV8z2PXsQ0zlehIwx57JkEtWi
         Sno7EmuH7dQOCVV2IkOd52CVhzL06lKbJ7YXS2+NP01Em/BIxEqkUXTnrqkr5+gcHzO4
         3U/4mTpwxv1BqdTvYSTr/RLKb0X74vS3T1HxU+I2XoblFVSHgNh1VnATtMBrEWI0Zswm
         R5vl2qTSugT9YHVnUvALRLsxHdJ+QoP78l6WqkVo92tF51L3NhEyidMb8Xu7m+UCbfEM
         l7FozmTkivDwaJ5UPm+pHMKTAeMDBmsJWhvi0JPiRQ2uZoeOZogsc5xY5bcy8S6N9slF
         aTbg==
X-Gm-Message-State: AOAM530A51y7hwCfCjPlOyqtfT1kEnd3LsWBjTQMn2GBbs4FESA6NXCe
        5ecGf7n3oViZoAka2AXHvOFUXdRqmpDUmH1vTCs=
X-Google-Smtp-Source: ABdhPJxGGgt9e0NWtd3e/L0qhT0m/DeEteZ4GvADZKYl9iVU7YbMWHw6WgQrBZY4tyLztSg6nKQHhQ==
X-Received: by 2002:a17:906:6985:b0:6fe:988b:d248 with SMTP id i5-20020a170906698500b006fe988bd248mr19086192ejr.226.1653324468939;
        Mon, 23 May 2022 09:47:48 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id p3-20020a056402074300b0042617ba63a5sm8434965edy.47.2022.05.23.09.47.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 09:47:47 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id t13so3046007wrg.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 09:47:47 -0700 (PDT)
X-Received: by 2002:a5d:6483:0:b0:20f:d046:6382 with SMTP id
 o3-20020a5d6483000000b0020fd0466382mr8111413wri.342.1653324466491; Mon, 23
 May 2022 09:47:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220523085745.276-1-gaochao49@huawei.com>
In-Reply-To: <20220523085745.276-1-gaochao49@huawei.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 23 May 2022 09:47:32 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VVZo+wsR0yPLvq-8jkZg12+Sw0NM0TkgQLHDCxCiFdGw@mail.gmail.com>
Message-ID: <CAD=FV=VVZo+wsR0yPLvq-8jkZg12+Sw0NM0TkgQLHDCxCiFdGw@mail.gmail.com>
Subject: Re: [PATCH -next] drm/panel: Fix build error when CONFIG_DRM_PANEL_SAMSUNG_ATNA33XC20=y
 && CONFIG_DRM_DISPLAY_HELPER=m
To:     gaochao <gaochao49@huawei.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sean Paul <seanpaul@chromium.org>, zhengbin13@huawei.com,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, May 23, 2022 at 1:58 AM gaochao <gaochao49@huawei.com> wrote:
>
> If CONFIG_DRM_PANEL_SAMSUNG_ATNA33XC20=y && CONFIG_DRM_DISPLAY_HELPER=m,
> bulding fails:
>
> drivers/gpu/drm/panel/panel-samsung-atna33xc20.o: In function `atana33xc20_probe':
> panel-samsung-atna33xc20.c:(.text+0x744): undefined reference to
>  `drm_panel_dp_aux_backlight'
> make: *** [vmlinux] Error 1
>
> Let CONFIG_DRM_PANEL_SAMSUNG_ATNA33XC20 select DRM_DISPLAY_DP_HELPER and
> CONFIG_DRM_DISPLAY_HELPER to fix this error.
>
> Fixes: 32ce3b320343 ("drm/panel: atna33xc20: Introduce the Samsung ATNA33XC20 panel")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: gaochao <gaochao49@huawei.com>

I think the author / Signed-off-by are supposed to be real names. Is
"gaochao" your legal name?

> ---
>  drivers/gpu/drm/panel/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)

Other than the Signed-off-by / Author issue:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
