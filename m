Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA1253E740
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239496AbiFFOVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 10:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239416AbiFFOVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 10:21:47 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5158222654A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 07:21:46 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id v1so18586110ejg.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 07:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=opLWEqC00jn82y4owwASw7k3zRYvjzMou2cjWKLBV64=;
        b=gkHpY3ulU0qVJsCW/7cg5SzAjNDdn7t3avgpO4JqTMDcqwd128gyp/ezfuttq/hmoR
         aLEzdUBdsdu9XlKb5oqWrctb+KeObzqrZ5blifz3w5ziL2IdUk1HAwIZtGb0nj94jxEo
         WdDsmtzzAZ//UM7RfSH9d71dAoQNSW5P6aMlc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=opLWEqC00jn82y4owwASw7k3zRYvjzMou2cjWKLBV64=;
        b=qXUqLlwIijS7vg75VcKOFTdJNFdEaj7Uoh2UNFfRBIE6ayLf85/9mdKMZiKxTFKVpG
         sSQaDXpEwTAv4NzK0mIsGPOl5Uo8rVkxcYmZK7LFWVzRRjlnUIgg9h61xDy1MDJLJo2g
         zSEPiZ65aDRzIAPg83i0vp6Ag2FiNUhjzQjAAuNSq29JYqY51yPiQurFRzWTfaR30A2Q
         axrBA56JQBwz40h90QIPSTRycE47Fq1ohM50eDlpFMeqoonlRqNBhVUmzuRJlO/2/2nD
         0E1sKG2R+vn4XO8W7+JT6Mr/Eb2lVQbr5pEcUclXXMHmzsnMe08lMoQFIH+GzDRLM7Tm
         ztHw==
X-Gm-Message-State: AOAM531CBnDXM08u0mahdoQFj5N5sPkEc5IS+ttQ2YB+criy1wJEFLM9
        5urCnoszCVwNnaY6+sVl9kaDGYn50IaTuv1Z
X-Google-Smtp-Source: ABdhPJyLKv92PcYhNBmJ97j10A1uFIPr5keVI8yOE6qBp94oVJuvqS+MWaqBbWH4WzZ0JCLj3yYCZQ==
X-Received: by 2002:a17:907:1b09:b0:6d8:faa8:4a06 with SMTP id mp9-20020a1709071b0900b006d8faa84a06mr21403792ejc.701.1654525304650;
        Mon, 06 Jun 2022 07:21:44 -0700 (PDT)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id kl10-20020a170907994a00b006fec69a3978sm6396244ejc.207.2022.06.06.07.21.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jun 2022 07:21:42 -0700 (PDT)
Received: by mail-wm1-f41.google.com with SMTP id r123-20020a1c2b81000000b0039c1439c33cso7998288wmr.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 07:21:39 -0700 (PDT)
X-Received: by 2002:a05:600c:591:b0:39c:4544:b814 with SMTP id
 o17-20020a05600c059100b0039c4544b814mr12815954wmd.118.1654525298761; Mon, 06
 Jun 2022 07:21:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220606044720.945964-1-hsinyi@chromium.org> <20220606044720.945964-2-hsinyi@chromium.org>
In-Reply-To: <20220606044720.945964-2-hsinyi@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 6 Jun 2022 07:21:26 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V7FmkJyyXr4C6jy9-hOhnzgoo=g5tx_3z3rnCCC40Exg@mail.gmail.com>
Message-ID: <CAD=FV=V7FmkJyyXr4C6jy9-hOhnzgoo=g5tx_3z3rnCCC40Exg@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] drm/panel: Add an API drm_panel_get_orientation()
 to return panel orientation
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
> Panels usually call drm_connector_set_panel_orientation(), which is
> later than drm/kms driver calling drm_dev_register(). This leads to a
> WARN().
>
> The orientation property is known earlier. For example, some panels
> parse the property through device tree during probe.
>
> Add an API to return the property from panel to drm/kms driver, so the
> drivers are able to call drm_connector_set_panel_orientation() before
> drm_dev_register().
>
> Suggested-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> ---
> v2->v3: no change
> ---
>  drivers/gpu/drm/drm_panel.c |  8 ++++++++
>  include/drm/drm_panel.h     | 10 ++++++++++
>  2 files changed, 18 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
> index f634371c717a..4a512ca80673 100644
> --- a/drivers/gpu/drm/drm_panel.c
> +++ b/drivers/gpu/drm/drm_panel.c
> @@ -223,6 +223,14 @@ int drm_panel_get_modes(struct drm_panel *panel,
>  }
>  EXPORT_SYMBOL(drm_panel_get_modes);
>
> +enum drm_panel_orientation drm_panel_get_orientation(struct drm_panel *panel)
> +{
> +       if (panel && panel->funcs && panel->funcs->get_orientation)
> +               return panel->funcs->get_orientation(panel);
> +
> +       return DRM_MODE_PANEL_ORIENTATION_UNKNOWN;
> +}
> +EXPORT_SYMBOL(drm_panel_get_orientation);
>  #ifdef CONFIG_OF

nit: there used to be a blank line before the #ifdef but there no
longer is after your patch.

Other than that...

Reviewed-by: Douglas Anderson <dianders@chromium.org>
