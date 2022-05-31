Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDD45397B8
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 22:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344124AbiEaUDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 16:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233062AbiEaUDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 16:03:36 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C8A2FE4F
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 13:03:35 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id h11so18974630eda.8
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 13:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VeXRYquwBdQ1dOZMflf5nsQE+opZ3d34q51TacEF7HA=;
        b=XuZGseWjCdQCUpLS7SWx2X04gT9YVCZqwuF0O3a7BrK7scNXHX2Pml9WwshUdl5VkY
         aIC0pGpDEEEg1XCkAz3YScYnYGWVcrZhAa01mvHgfLyWtgES/O8bj8YwxPaWHWiFG5RH
         JpfoXo7eKL8C7fYzSGLdyfQp7ZXU7EO+3Qd3+Z+mUzaTeCxZNVZ4STp0XazAq2aZ5ohY
         8u51PbmoCd8sbikiANJVhCKkhLhIxyNjPxg4H4aFnAekHmz0TwaXFs22aOt5vetk5pEb
         a7KzE6z0jh43w3F2gnNfMAdv4T/h5fE54520BL7miy3XFym4oBBaf/qG/H8NOhsThB9A
         e1Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VeXRYquwBdQ1dOZMflf5nsQE+opZ3d34q51TacEF7HA=;
        b=ocGAWoUXkJDOCB6ken49M3GpRLxzwMuy77809jt7PI7XHNOCsBEP0/P3OEYhh74zYc
         2DLjYdzbccMTWm46ajl0/yKOCZ6C5kX9QngphueXTmvLWMV+vycG99td2DwFg1Gy1CXf
         nssPz4ngsEHprTm3CMlr45UWt+HUXCORQw4KjZXG5ItBpquAvKahWHI6tEvuuf9aZkfa
         5k0zFxKGtQKfrJkKF4eTpkg52PwHDV1Vit1+Uz4m+ndvFUwFUACdRkmGVtEz/UYZbZ7w
         8brky9iuuItIDzXig4D6MTELPKudEGlqLxiPcCsOkzPuOgiYk+WnVsN0dfOeN1R2R46L
         oRVQ==
X-Gm-Message-State: AOAM530RW0wpN0AMifCPa6HFX1vNB16NilOq3fZnti1Ts7ieIcL5dU/F
        LYW0h3ChyOyVHu8W5rvWF+l8E4p+ntEVdtt0YW8=
X-Google-Smtp-Source: ABdhPJwjVOUsvRdeo5FK73NryLg6a7micfi5ToPTE2Sq7rMy5xFF/f8eN3aQLibNcx6ds/c/F7VnYcaMymS5mq+P96A=
X-Received: by 2002:a05:6402:254a:b0:42b:6c9a:c06c with SMTP id
 l10-20020a056402254a00b0042b6c9ac06cmr47415245edb.199.1654027413836; Tue, 31
 May 2022 13:03:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220531144818.26943-1-linmq006@gmail.com> <20220531144818.26943-2-linmq006@gmail.com>
In-Reply-To: <20220531144818.26943-2-linmq006@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 31 May 2022 22:03:23 +0200
Message-ID: <CAFBinCANaU4Tk42j-GDBWwUDk39_XiCfeu4D9vGFjFc_G4PZGQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/meson: encoder_hdmi: Fix refcount leak in meson_encoder_hdmi_init
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

first of all: thank you for spotting this and sending a patch!

On Tue, May 31, 2022 at 4:49 PM Miaoqian Lin <linmq006@gmail.com> wrote:
[...]
> diff --git a/drivers/gpu/drm/meson/meson_encoder_hdmi.c b/drivers/gpu/drm/meson/meson_encoder_hdmi.c
> index 5e306de6f485..f3341458f8b7 100644
> --- a/drivers/gpu/drm/meson/meson_encoder_hdmi.c
> +++ b/drivers/gpu/drm/meson/meson_encoder_hdmi.c
> @@ -363,6 +363,7 @@ int meson_encoder_hdmi_init(struct meson_drm *priv)
>         }
>
>         meson_encoder_hdmi->next_bridge = of_drm_find_bridge(remote);
> +       of_node_put(remote);
further down in the same function remote is used again:
  pdev = of_find_device_by_node(remote);

My understanding is that we should only use of_node_put() once we
don't need to access the node (in this case the variable is "remote")
anymore.


Best regards,
Martin
