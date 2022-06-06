Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6872853E9AB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239529AbiFFOWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 10:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239414AbiFFOWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 10:22:41 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C922D4444
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 07:22:36 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id v1so18590937ejg.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 07:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HR9ZimCCmd1j/amkGhRbfPT914SxfF+DwhvAMa7hG8s=;
        b=Be/WplNQmJ47YORrypJyjDO3xZsi5v0eEVHzRhHm2XQqN5zxhzrkg7g+OKgS/P4kbm
         ZEtsFw6L3iaoh/1K2n7/XQ0Km74kYu+r1oguG6izyr2gCro2CAG9vbUsiuQS1PwXTH5n
         FrBly5SHx9gQH+Pb60Yer4UrxS7ftU1j4CmJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HR9ZimCCmd1j/amkGhRbfPT914SxfF+DwhvAMa7hG8s=;
        b=J98YlpXKIMc5gMxkS0PNi59Ilmh1DuSWdUYQkBYuIE4c+a0yrBkkAPWzfo9lAWh8MI
         ByRMXIZqbnPn9WrSd5vZlOQFR2SRGmK20ukfD96JtvlnMCKFTBIxQVgP6X6QbjLgENIk
         bm0uGkHv6VkLBeGcN1JHx+SU+9AnIUvFUN5PjcT2e/vYNzTU5WCnV0ySB6oqUOzLmRUD
         BO9ZB5u9iMN+6ikPDW4sMMoxOrZWUcx0kXVuwrO9F0mZoC7o5NEgGz3gd0mSXb8B4a7+
         IW8s4VX2vfa1bNTu0tbdx7l6YNuVSRpTztgNU2qBgf7/+VhRda4vGlp0wL+ZTiy50+go
         +MSA==
X-Gm-Message-State: AOAM532ABoE40p0bcuA/kZl3l4UvrcODa/K7DQpX2AHEPMPee+49wcrR
        yCBlMq5EjeJlWP9IOw59OmiiA48TOBrDJzBs
X-Google-Smtp-Source: ABdhPJwjpCK4iPMPc8Lp8n+ybBbAMGzGfDJiHUlhbWdR25GyXGYVvBPf7dGzeIpHgWX/zllmtQA6Yw==
X-Received: by 2002:a17:907:2161:b0:70f:5db6:1ff2 with SMTP id rl1-20020a170907216100b0070f5db61ff2mr13832771ejb.249.1654525354800;
        Mon, 06 Jun 2022 07:22:34 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id h1-20020a170906590100b006fe97996423sm6339072ejq.219.2022.06.06.07.22.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jun 2022 07:22:33 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id q15so12043811wrc.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 07:22:32 -0700 (PDT)
X-Received: by 2002:a5d:6483:0:b0:20f:d046:6382 with SMTP id
 o3-20020a5d6483000000b0020fd0466382mr21837218wri.342.1654525352126; Mon, 06
 Jun 2022 07:22:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220606044720.945964-1-hsinyi@chromium.org> <20220606044720.945964-5-hsinyi@chromium.org>
In-Reply-To: <20220606044720.945964-5-hsinyi@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 6 Jun 2022 07:22:20 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XQbXK13M_X_AsqSPS+D_zQqLtAGFGz=YbHoPu3bcvhZQ@mail.gmail.com>
Message-ID: <CAD=FV=XQbXK13M_X_AsqSPS+D_zQqLtAGFGz=YbHoPu3bcvhZQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] drm/panel: lvds: Implement .get_orientation callback
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
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Jun 5, 2022 at 9:47 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> To return the orientation property to drm/kms driver.
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> ---
> v2->v3: add comments for notice.
> ---
>  drivers/gpu/drm/panel/panel-lvds.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/gpu/drm/panel/panel-lvds.c b/drivers/gpu/drm/panel/panel-lvds.c
> index 27a1c9923b09..239527409b00 100644
> --- a/drivers/gpu/drm/panel/panel-lvds.c
> +++ b/drivers/gpu/drm/panel/panel-lvds.c
> @@ -102,15 +102,29 @@ static int panel_lvds_get_modes(struct drm_panel *panel,
>         connector->display_info.bus_flags = lvds->data_mirror
>                                           ? DRM_BUS_FLAG_DATA_LSB_TO_MSB
>                                           : DRM_BUS_FLAG_DATA_MSB_TO_LSB;

Can you rebase your patch and send again? There's a context conflict
with the above line because your tree is lacking commit 83c784e70036
("drm/panel: lvds: Use bus_flags from DT panel-timing property")

In any case:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
