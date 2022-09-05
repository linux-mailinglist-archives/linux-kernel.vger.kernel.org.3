Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217A75AD7D6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 18:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237327AbiIEQsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 12:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbiIEQsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 12:48:19 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0766C61D49
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 09:48:19 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id gb36so18125202ejc.10
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 09:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=vFf1NC6e/rXutxdhKSLLrUKw8nDhPmH+BJYLwhNt7yw=;
        b=OxL4rVf+D+fKCzNOe9TQVDoMnh3EEoNcvQiMeDXPlP+kxFVp8p8JFZXkc3bdYqa3ak
         691sPhlXD/oheR4/nNStORcTlIGLbQuFwhfkpLd0it2H0SztxNxY4Re4xQL0y1K2WN/M
         YWc+c0t6TcZJLaBpJZ5hk/feOKsV/LnhkSZw8KEyBWY+0+BZSWjwkEY5bguyzzqRVup+
         bui6FbMAtvRVU5OMyOud6uBOjomUrAt6SQDWFc/cyDYs2KymJ1dzPOZeNUTT7nrOfef8
         oNyxRwxqdxnTuiXfEZDtQqc717YgrBFHmUmYYPSNdOqzap2vrefvja3picn38zkEVXs1
         xM2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=vFf1NC6e/rXutxdhKSLLrUKw8nDhPmH+BJYLwhNt7yw=;
        b=sw0qrIoVJDVZSjJc7UQxt2UbV3QIJ0+rx3PZ3miUnwsVD/O9TS5nbDyy9OwMdj3406
         6C3UrOzxk1rp6BdfLUCzA97KId9oIJ0lj3IoIOcJ2zYT2g/wwmea9+ZBb9qxwmvGrAZa
         4MVPtoIHIsSmRCoA23lPj3RBCdrdvARpHWJmHjuQlFNDlY+SxPCPkR37AmkWNWIMcpSp
         CenuJJG3s169dnFRapug7eMAqrR1IevZ1MlXfWZKY9Vphiko0baUIO7O422Bv6XqfzoA
         oAeJHg72X5l3MlTz1He65xQAET0Odc0wzZxf2XOnW9j+IpI4ragmRlv/C0wxikwUoueD
         v3Mg==
X-Gm-Message-State: ACgBeo28WGPBu+wjmJ6W0KY9efBSTDftUfDcCr4Hn8dZLKBYaxk6s7xf
        5xfvpx7fIQ+X51moEJG6mOEaWFSe+Ju/J2K83rkM+A==
X-Google-Smtp-Source: AA6agR5NLqtR8oGfFTf8feIBOe08qSCAQgSn3cBwuBtLBXKmRKosxUcLTwt7GXQEJ7mpo2ehybr7vEnFmXmgLF1srr4=
X-Received: by 2002:a17:907:6092:b0:731:59f0:49ac with SMTP id
 ht18-20020a170907609200b0073159f049acmr36298700ejc.383.1662396497455; Mon, 05
 Sep 2022 09:48:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220903130833.541463-1-xji@analogixsemi.com>
In-Reply-To: <20220903130833.541463-1-xji@analogixsemi.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Mon, 5 Sep 2022 18:48:06 +0200
Message-ID: <CAG3jFyum5M8iGdW++c7rayUn4ogJ6izWaX7VaqMfV7ShAe_kRQ@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: anx7625: Set HPD irq detect window to 2ms
To:     Xin Ji <xji@analogixsemi.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, bliang@analogixsemi.com,
        qwen@analogixsemi.com, mliu@analogixsemi.com, hsinyi@chromium.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xin,

On Sat, 3 Sept 2022 at 15:09, Xin Ji <xji@analogixsemi.com> wrote:
>
> Some panels trigger HPD irq due to noise, the HPD debounce
> may be 1.8ms, exceeding the default irq detect window, ~1.4ms.
> This patch set HPD irq detection window to 2ms to
> tolerate the HPD noise.
>
> Signed-off-by: Xin Ji <xji@analogixsemi.com>
> ---
>  drivers/gpu/drm/bridge/analogix/anx7625.c | 14 ++++++++++++++
>  drivers/gpu/drm/bridge/analogix/anx7625.h |  6 ++++++
>  2 files changed, 20 insertions(+)
>
> diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> index c74b5df4cade..0c323b5a1c99 100644
> --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> @@ -1440,6 +1440,20 @@ static void anx7625_start_dp_work(struct anx7625_data *ctx)
>
>  static int anx7625_read_hpd_status_p0(struct anx7625_data *ctx)
>  {
> +       int ret;
> +
> +       /* Set irq detect window to 2ms */
> +       ret = anx7625_reg_write(ctx, ctx->i2c.tx_p2_client,
> +                               HPD_DET_TIMER_BIT0_7, HPD_TIME & 0xFF);
> +       ret |= anx7625_reg_write(ctx, ctx->i2c.tx_p2_client,
> +                                HPD_DET_TIMER_BIT8_15,
> +                                (HPD_TIME >> 8) & 0xFF);
> +       ret |= anx7625_reg_write(ctx, ctx->i2c.tx_p2_client,
> +                                HPD_DET_TIMER_BIT16_23,
> +                                (HPD_TIME >> 16) & 0xFF);

Does the HPD debounce timer register need to be written for every HPD
status read?

> +       if (ret < 0)
> +               return ret;
> +
>         return anx7625_reg_read(ctx, ctx->i2c.rx_p0_client, SYSTEM_STSTUS);
>  }
>
> diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.h b/drivers/gpu/drm/bridge/analogix/anx7625.h
> index e257a84db962..14f33d6be289 100644
> --- a/drivers/gpu/drm/bridge/analogix/anx7625.h
> +++ b/drivers/gpu/drm/bridge/analogix/anx7625.h
> @@ -132,6 +132,12 @@
>  #define I2S_SLAVE_MODE 0x08
>  #define AUDIO_LAYOUT   0x01
>
> +#define HPD_DET_TIMER_BIT0_7   0xea
> +#define HPD_DET_TIMER_BIT8_15  0xeb
> +#define HPD_DET_TIMER_BIT16_23 0xec
> +/* HPD debounce time 2ms for 27M clock */
> +#define HPD_TIME               54000
> +
>  #define AUDIO_CONTROL_REGISTER 0xe6
>  #define TDM_TIMING_MODE 0x08
>
> --
> 2.25.1
>
