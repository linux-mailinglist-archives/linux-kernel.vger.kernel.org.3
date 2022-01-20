Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB0D495012
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 15:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345826AbiATOZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 09:25:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233267AbiATOZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 09:25:08 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20704C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 06:25:08 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id j2so29336563edj.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 06:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FAhsQDmY+UEIFHjWgi4z9bftnzJtob5tCT+hA+Of3Tc=;
        b=KJEjgCdFG0dpF+3j0wAsKxGexfu15gsGWeXYUVgoDvXZHy2v0EQey/SQX7X4mYBsSp
         I2UnEh7K6RxCTHjo7Shad43R2GcXtPLrFEKdOCAxEif+jzcmr0OzMr/cGHYQmUOjX0dX
         j8VWdbTp3bckcfROeq0sRC9ycPXnU++G0KRAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FAhsQDmY+UEIFHjWgi4z9bftnzJtob5tCT+hA+Of3Tc=;
        b=Xag793nrLTYLFEKHw8GzldmXljd17vnH3sR31+iqGyN6Wfcm8CgtatpfkXWxMqT6LX
         4PtTeiaZOzc7mN1agOJ6qNMBnbdK4O3RmD9qA6k2l/NAW9Zz3TCephqS4mOlCrJUOjiV
         9eM1d9v1+jqd6pZtkoPzMCQXFoMUf/Gcgf/IeKkn6HvJuyKDFD4IwR1SPqV3ulO2uDsH
         DATmMSGVaIY2hNK/g2HCTqqHmu2DQTu13a6ke8ZIfbokNIXQIt/jzptnnnr1mO5RtFnL
         1zBLFdJRYKg4ci2Or+/QKcYWji+gNBttYXMZgjpRyF0kcnjDGcNfuWSj+e370xUW26+k
         6Z6A==
X-Gm-Message-State: AOAM532u9JTH/yC9Y5ED0pWZbI9Hc6B0bvlBPtx0oYc/DIucwnr/DXkV
        wZG3ShzNU+BEHd7TQFlePdCM/H8idHvFTHCNgkSZLGeXwsg=
X-Google-Smtp-Source: ABdhPJy4wH7/I8d3vpY8drpkpk3qBL9l/808L6I024OQggLfoUx7l3gQI5KIjzpg9Q0pWjfKBcf3bh29R7L7Wb5fBgc=
X-Received: by 2002:a05:6402:4244:: with SMTP id g4mr13521547edb.271.1642688706615;
 Thu, 20 Jan 2022 06:25:06 -0800 (PST)
MIME-Version: 1.0
References: <20220120083357.1541262-1-narmstrong@baylibre.com> <20220120083357.1541262-7-narmstrong@baylibre.com>
In-Reply-To: <20220120083357.1541262-7-narmstrong@baylibre.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Thu, 20 Jan 2022 19:54:55 +0530
Message-ID: <CAMty3ZBvbPvKgUpNW1LVho5_S9kwzNioE0SxvX_E8bmgw-+fXw@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] drm/meson: add support for MIPI-DSI transceiver
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     dri-devel@lists.freedesktop.org,
        martin.blumenstingl@googlemail.com,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 2:04 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> The Amlogic G12A/G12B/SM1 SoCs embeds a Synopsys DW-MIPI-DSI transceiver (ver 1.21a),
> with a custom glue managing the IP resets, clock and data input similar to the DW-HDMI
> Glue on other Amlogic SoCs.
>
> This adds support for the Glue managing the transceiver, mimicing the init flow provided
> by Amlogic to setup the ENCL encoder, the glue, the transceiver, the digital D-PHY and the
> Analog PHY in the proper way.
>
> An optional "MEAS" clock can be enabled to measure the delay between each vsync feeding the
> DW-MIPI-DSI transceiver.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/gpu/drm/meson/Kconfig             |   7 +
>  drivers/gpu/drm/meson/Makefile            |   1 +
>  drivers/gpu/drm/meson/meson_dw_mipi_dsi.c | 357 ++++++++++++++++++++++
>  drivers/gpu/drm/meson/meson_dw_mipi_dsi.h | 160 ++++++++++
>  4 files changed, 525 insertions(+)
>  create mode 100644 drivers/gpu/drm/meson/meson_dw_mipi_dsi.c
>  create mode 100644 drivers/gpu/drm/meson/meson_dw_mipi_dsi.h
>
> diff --git a/drivers/gpu/drm/meson/Kconfig b/drivers/gpu/drm/meson/Kconfig
> index 6c70fc3214af..71a1364b51e1 100644
> --- a/drivers/gpu/drm/meson/Kconfig
> +++ b/drivers/gpu/drm/meson/Kconfig
> @@ -17,3 +17,10 @@ config DRM_MESON_DW_HDMI
>         default y if DRM_MESON
>         select DRM_DW_HDMI
>         imply DRM_DW_HDMI_I2S_AUDIO
> +
> +config DRM_MESON_DW_MIPI_DSI
> +       tristate "MIPI DSI Synopsys Controller support for Amlogic Meson Display"
> +       depends on DRM_MESON
> +       default y if DRM_MESON
> +       select DRM_DW_MIPI_DSI
> +       select GENERIC_PHY_MIPI_DPHY
> diff --git a/drivers/gpu/drm/meson/Makefile b/drivers/gpu/drm/meson/Makefile
> index 833e18c20603..43071bdbd4b9 100644
> --- a/drivers/gpu/drm/meson/Makefile
> +++ b/drivers/gpu/drm/meson/Makefile
> @@ -6,3 +6,4 @@ meson-drm-y += meson_encoder_hdmi.o meson_encoder_dsi.o
>
>  obj-$(CONFIG_DRM_MESON) += meson-drm.o
>  obj-$(CONFIG_DRM_MESON_DW_HDMI) += meson_dw_hdmi.o
> +obj-$(CONFIG_DRM_MESON_DW_MIPI_DSI) += meson_dw_mipi_dsi.o

Can the naming convention prefix with dw-mipi-dsi like other glue
drivers follow?

Jagan.
