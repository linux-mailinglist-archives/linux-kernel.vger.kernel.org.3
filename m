Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7941657E265
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 15:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235090AbiGVNgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 09:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiGVNgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 09:36:11 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AFB613FA7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 06:36:10 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id u12so866595edd.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 06:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=csCPVk6hB5Ta9ejYwXsButhNH0HX4XzJJybT/ifyFJE=;
        b=DuvnTvus6TaGwQHQW4LGA+Gl1HZzCv3r14kXIlvJpVG9K0G6Jy/zdPu0lUeYxcFojt
         bmpnPZTYkymqeob1NPcSLh2Ga6pNCG4DHZU1pMY/X55wTYtav1qVm8PRWt6bF1M9V2Br
         ixSm9zABPgRzrvOVk8BHvVWnWglevpToAzBpY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=csCPVk6hB5Ta9ejYwXsButhNH0HX4XzJJybT/ifyFJE=;
        b=DbT2WICf1e3L907p36y6ZzxgA58AwBgC4PewiwbIUtucjr3qJONUGYPvX0PEGUEgH9
         0ALSQmdbehVyc163VUf+a9oOgVbp2+c4QQx+MQ/c+HcKIIFlgsKjS0HRqNFTl3DzxzBQ
         Wla3ae54UM52el0E2wzg19xCNouPL+QU35rF/m6flSXaHhMxUNarMjFGK5nsjrwfcBn9
         tR7toS5AXvndL53aKdyf+A/mBOlOq7e42C2Gjm+QZVvBm6kgmNXxo5p3thtRJtBYooHf
         8e54yspnxSNkK4vHiht2nhgxGj3DhT+I+GFeAXDV9mwX+iYJDmic4Yos4bGfEyPn231Y
         1bMg==
X-Gm-Message-State: AJIora+uD0MrrPNoiPOrAoIs67/BItJjPgahdJB6Xy6SU0DwQzODvSHE
        HkhQsVT+A4yhYnl7fFpFVD6lmwSP0GB1+IV1WhE=
X-Google-Smtp-Source: AGRyM1sDzKPoooczk8qnIU4tokp2VItCqAXJb6SUc/IBFGVbZ3LHoejj61wlO8V1Y2Js2EHroIYnLQ==
X-Received: by 2002:a05:6402:28c8:b0:43a:aba5:efe5 with SMTP id ef8-20020a05640228c800b0043aaba5efe5mr767499edb.2.1658496968907;
        Fri, 22 Jul 2022 06:36:08 -0700 (PDT)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id ky4-20020a170907778400b0072aadbd48c7sm2010233ejc.84.2022.07.22.06.36.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 06:36:07 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id u14-20020a05600c00ce00b003a323062569so2513025wmm.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 06:36:07 -0700 (PDT)
X-Received: by 2002:a05:600c:2e48:b0:3a3:1ce3:3036 with SMTP id
 q8-20020a05600c2e4800b003a31ce33036mr11932470wmf.188.1658496966715; Fri, 22
 Jul 2022 06:36:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220722074755.660258-1-javierm@redhat.com>
In-Reply-To: <20220722074755.660258-1-javierm@redhat.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 22 Jul 2022 06:35:55 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WR3UP4XMch5z8Hz8GzWRg5cCsK6FVwgoo=HHDnpTwz+g@mail.gmail.com>
Message-ID: <CAD=FV=WR3UP4XMch5z8Hz8GzWRg5cCsK6FVwgoo=HHDnpTwz+g@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: ti-sn65dsi86: Use dev_err_probe() to avoid
 polluting the log
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Erico Nunes <ernunes@redhat.com>,
        Enric Balletbo i Serra <eballetbo@redhat.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jul 22, 2022 at 12:48 AM Javier Martinez Canillas
<javierm@redhat.com> wrote:
>
> If devm_drm_of_get_bridge() can't find the connected bridge, it returns an
> ERR_PTR(-EPROBE_DEFER) to indicate that the probe should be deferred.
>
> But this path also prints an error message, which pollutes the kernel log
> since is printed on every probe deferral, i.e:
>
>   $ dmesg | grep "failed to create panel bridge" | wc -l
>   38
>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
>
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

If someone else doesn't beat me to it, I'll apply next week sometime.
