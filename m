Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426C753C07C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 23:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239493AbiFBVsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 17:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234954AbiFBVsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 17:48:37 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B821DA77
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 14:48:36 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id s6so909329eja.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 14:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PlQ+AfYx33ch5Af1MOc8eSZOWrp4sa+5BG8p2IQdVOQ=;
        b=LQbMJioZzGwe6/fK5um+5Ha94Y3saA4t6tLL33c0D7+smsDYIjGyCJ62XISlVIfDnb
         k7+IGE4QIPIQO60LtADGNIslNBNGIZ5QqLEoOEwAapZhW8OmMhz8yMIQrfL9zX/HltC7
         qkwO9hwIWO1HMZSqakKMcSasFiJdp5cXvDCAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PlQ+AfYx33ch5Af1MOc8eSZOWrp4sa+5BG8p2IQdVOQ=;
        b=jaeEKKSkR3inz3O8aPtMWe+LbVGDjFkd+X3vhWsLXR4v8C4fyKq7xbFuyFXkUPvcvA
         heDMEFNtMwbznEAQdDGDMZ7rM5YkPNfe+xM3xPDfEgaj9TzxK65yuP8wnlMjiMEeH2+q
         qGZeswQX3U8jhnIjh5QfoceU7AH/zFLuVM1RhTQo7GXMeIDBsxw6rhaYZYcFEpLGXaMI
         di7kp4nWljL35y4TbxRhaKpw7z2X1tV7o4s1WUaUPXVwVCA0NOw0oOC93BZM6TVw+wTV
         KTfczGSC2VhFfwpVMsDnCo7WwEBGRoBAcGLnPCrctWDuBUrLefAyuYmCJSkqYFllbEkf
         MATQ==
X-Gm-Message-State: AOAM530TpKrL3UTifbd3k0lnXvvBZ/4P/t4QyNCvsTbAlnZ3N9Fe2Fkc
        HnksfSOaFVrWi63m2tmd0w0/h0SY9hLtCpHJ
X-Google-Smtp-Source: ABdhPJwwz+bUVOpWXkknSNSCJSxFuzavZHAFV1WyqPS/Ej6uTrQLFYaLsQVVutCmJtmbibcw50b59Q==
X-Received: by 2002:a17:907:2daa:b0:6fe:b449:6a8f with SMTP id gt42-20020a1709072daa00b006feb4496a8fmr5980945ejc.318.1654206514601;
        Thu, 02 Jun 2022 14:48:34 -0700 (PDT)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id l1-20020a1709060e0100b006fec4ee28d0sm722773eji.189.2022.06.02.14.48.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 14:48:33 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id n185so3190390wmn.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 14:48:33 -0700 (PDT)
X-Received: by 2002:a05:600c:4f0c:b0:397:75d7:613 with SMTP id
 l12-20020a05600c4f0c00b0039775d70613mr35121379wmq.34.1654206512562; Thu, 02
 Jun 2022 14:48:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220601094637.1200634-1-hsinyi@chromium.org>
In-Reply-To: <20220601094637.1200634-1-hsinyi@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 2 Jun 2022 14:48:20 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W+5GAUBh_ZMPeKhqxQXxau2OKCbt3p2QmsDhROf207dA@mail.gmail.com>
Message-ID: <CAD=FV=W+5GAUBh_ZMPeKhqxQXxau2OKCbt3p2QmsDhROf207dA@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] Add a panel API to return panel orientation
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Rob Clark <robdclark@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jun 1, 2022 at 2:46 AM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> Panels usually call drm_connector_set_panel_orientation(), which is
> later than drm/kms driver calling drm_dev_register(). This leads to a
> WARN()[1].
>
> The orientation property is known earlier. For example, some panels
> parse the property through device tree during probe.
>
> The series add a panel API drm_panel_get_orientation() for drm/kms
> drivers. The drivers can use the API to get panel's orientation, so they
> can call drm_connector_set_panel_orientation() before drm_dev_register().
>
> Panel needs to implement .get_orientation callback to return the property.
>
> [1] https://patchwork.kernel.org/project/linux-mediatek/patch/20220530081910.3947168-2-hsinyi@chromium.org/
>
> Hsin-Yi Wang (8):
>   drm/panel: Add an API drm_panel_get_orientation() to return panel
>     orientation
>   drm/panel: boe-tv101wum-nl6: Implement .get_orientation callback
>   drm/panel: panel-edp: Implement .get_orientation callback
>   drm/panel: lvds: Implement .get_orientation callback
>   drm/panel: panel-simple: Implement .get_orientation callback
>   drm/panel: ili9881c: Implement .get_orientation callback
>   drm/panel: elida-kd35t133: Implement .get_orientation callback
>   drm/mediatek: Config orientation property if panel provides it
>
>  drivers/gpu/drm/drm_panel.c                    |  8 ++++++++
>  drivers/gpu/drm/mediatek/mtk_dsi.c             | 10 ++++++++++
>  drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c |  8 ++++++++
>  drivers/gpu/drm/panel/panel-edp.c              |  8 ++++++++
>  drivers/gpu/drm/panel/panel-elida-kd35t133.c   |  8 ++++++++
>  drivers/gpu/drm/panel/panel-ilitek-ili9881c.c  |  8 ++++++++
>  drivers/gpu/drm/panel/panel-lvds.c             |  8 ++++++++
>  drivers/gpu/drm/panel/panel-simple.c           |  9 +++++++++
>  include/drm/drm_panel.h                        | 10 ++++++++++
>  9 files changed, 77 insertions(+)

Seems reasonable to me. I added a request to the panel-edp patch that
probably applies to all of the panel patches requesting a comment next
to the old calls in get_modes().

I assume that all but patch #8 ought to land through drm-misc. I'm
happy to help commit them once everyone is happy. If the Mediatek
maintainer(s) want to Ack patch #8 I can land that in drm-misc too. If
we want something fancier like an immutable branch you'll probably
have to get someone involved that's got a higher drm pay grade than
me. ;-)

-Doug
