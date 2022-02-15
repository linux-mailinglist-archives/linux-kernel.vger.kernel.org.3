Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89C4F4B7B3B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 00:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244511AbiBOXbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 18:31:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbiBOXb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 18:31:28 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946C2F94E9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 15:31:16 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id h5so369496ioj.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 15:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FCIgbleOoUZIo/u1NuclidM+6drC/fEPlkw9hx4YYSU=;
        b=GvKO9px9ieVv+SBaUWQl5Z5hBvQQJMAyCOyiS2JwDx+XKQQp/2UHuEPMHl1XMEw3t+
         jKQ/oSGEmyO8oPK4kXtaurAkGPbCXzS3axB1+4CyvMemDPEA4rS55bMksJsn+0sTuPCr
         K5h95ZHFNwqWo5hnqkFP3eH75IYW2unez2DNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FCIgbleOoUZIo/u1NuclidM+6drC/fEPlkw9hx4YYSU=;
        b=JWIboXtVXmR86jClVZ3Djh4eKwVNBeHQQebheBjmvoBrf9Xb7N3ammaADxj/imZqCJ
         MnMELTSrtJlUVYtKorrjWhE7Y+kvU7mhAmv2bcE2g97/aJT++y/fWi0k/APF88n2tJPm
         vZ0gIW8H2DUEl8L0bVeM54piL38plZu6suFcx87/ZBn+oNCXO17+ItEEkoeJpXORpsO3
         4DaNZ1McAOK6vPjf9p9HTKhck0RuAE5doQuijm32MIFlwUvzQ4vseXCi8xJzX4pdEliw
         L4TgIsR0rm1xaMTbDDavTzbWDOSAK18dw97+5vRTA+M43gMjFAVzIF4Qce5Gju7/Zl6t
         l26g==
X-Gm-Message-State: AOAM532UoFjop5kZMlLcL2Ehjnr6ab3uElxEZv/GyyMzu3KObHjLAaMW
        Qd4QYvsTSEDntupzE4OZu95bhmpOLpGRqQ==
X-Google-Smtp-Source: ABdhPJzjSo1eOBfrK1fjEOO3QKP+URL9V/5WnWaARFt2KC0mX4W24WOD15CHWuPZAdlrmpnAB1gsWQ==
X-Received: by 2002:a5d:8508:0:b0:62f:1fc2:d5d2 with SMTP id q8-20020a5d8508000000b0062f1fc2d5d2mr109750ion.13.1644967875821;
        Tue, 15 Feb 2022 15:31:15 -0800 (PST)
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com. [209.85.166.54])
        by smtp.gmail.com with ESMTPSA id s3sm19974360ilp.57.2022.02.15.15.31.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 15:31:14 -0800 (PST)
Received: by mail-io1-f54.google.com with SMTP id r8so343815ioc.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 15:31:13 -0800 (PST)
X-Received: by 2002:a05:6602:15c6:b0:611:591d:1d9a with SMTP id
 f6-20020a05660215c600b00611591d1d9amr84044iow.177.1644967873090; Tue, 15 Feb
 2022 15:31:13 -0800 (PST)
MIME-Version: 1.0
References: <20220205001342.3155839-1-dianders@chromium.org>
In-Reply-To: <20220205001342.3155839-1-dianders@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 15 Feb 2022 15:31:01 -0800
X-Gmail-Original-Message-ID: <CAD=FV=ULWobi5rDbZajiyPvd1TtLQg-x6EqTNgs2pWiGBUjPRg@mail.gmail.com>
Message-ID: <CAD=FV=ULWobi5rDbZajiyPvd1TtLQg-x6EqTNgs2pWiGBUjPRg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] drm/panel-edp: Debugfs for panel-edp
To:     dri-devel <dri-devel@lists.freedesktop.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Robert Foss <robert.foss@linaro.org>, lschyi@chromium.org,
        Sam Ravnborg <sam@ravnborg.org>, jjsu@chromium.org,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Feb 4, 2022 at 4:14 PM Douglas Anderson <dianders@chromium.org> wrote:
>
> The main goal of this series is the final patch in the series: to
> allow test code to reliably find out if we ended up hitting the
> "fallback" case of the generic edp-panel driver where we don't
> recognize a panel and choose to use super conservative timing.
>
> Version 1 of the patch actually landed but was quickly reverted since
> it was pointed out that it should have been done in debugfs, not
> sysfs.
>
> As discussed on IRC [1], we want this support to be under the
> "connector" directory of debugfs but there was no existing way to do
> that. Thus patch #2 in the series was born to try to plumb this
> through. It was asserted that it would be OK to rely on a fairly
> modern display pipeline for this plumbing and perhaps fail to populate
> the debugfs file if we're using older/deprecated pipelines.
>
> Patch #1 in the series was born because the bridge chip I was using
> was still using an older/deprecated pipeline. While this doesn't get
> us fully to a modern pipeline for ti-sn65dsi86 (it still doesn't move
> to "NO_CONNECTOR") it hopefully moves us in the right direction.
>
> This was tested on sc7180-trogdor devices with _both_ the ti-sn65dsi86
> and the parade-ps8640 bridge chips (since some devices have one, some
> the other). The parade-ps8640 already uses supports "NO_CONNECTOR",
> luckily.
>
> [1] https://people.freedesktop.org/~cbrill/dri-log/?channel=dri-devel&date=2022-02-02
>
> Changes in v2:
> - ("ti-sn65dsi86: Use drm_bridge_connector") new for v2.
> - ("drm: Plumb debugfs_init through to panels") new for v2.
> - Now using debugfs, not sysfs
>
> Douglas Anderson (3):
>   drm/bridge: ti-sn65dsi86: Use drm_bridge_connector
>   drm: Plumb debugfs_init through to panels
>   drm/panel-edp: Allow querying the detected panel via debugfs
>
>  drivers/gpu/drm/bridge/panel.c         | 12 +++++
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c  | 72 +++++---------------------
>  drivers/gpu/drm/drm_bridge_connector.c | 15 ++++++
>  drivers/gpu/drm/drm_debugfs.c          |  3 ++
>  drivers/gpu/drm/panel/panel-edp.c      | 37 +++++++++++--
>  include/drm/drm_bridge.h               |  7 +++
>  include/drm/drm_connector.h            |  7 +++
>  include/drm/drm_panel.h                |  8 +++
>  8 files changed, 98 insertions(+), 63 deletions(-)

Landed these three patches to drm-misc-next w/ accumulated tags:

$ git log --oneline -3
6ed19359d6bd drm/panel-edp: Allow querying the detected panel via debugfs
2509969a9862 drm: Plumb debugfs_init through to panels
e283820cbf80 drm/bridge: ti-sn65dsi86: Use drm_bridge_connector

If it turns out that we want to add more reporting when debugfs calls
return errors then I'm happy to submit follow-on patches. Discussion
about that can be found in:

https://lore.kernel.org/r/CAD=FV=Ut3N9syXbN7i939mNsx3h7-u9cU9j6=XFkz9vrh0Vseg@mail.gmail.com

Unless something changes, though, my current plan is not to do
follow-up patches and leave this as-is without any extra error
reporting.

-Doug
