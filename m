Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2F864CB825
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 08:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbiCCHxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 02:53:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbiCCHxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 02:53:07 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEEC916EABD
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 23:52:22 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id y5so2633657wmi.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 23:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yyyop4fY63SKx0bReSAkYJg24Sci71v5/4dsnKctGuU=;
        b=XHbZG0piUEw6QNedgoGvA9J+v55a67OEe562j+/wlvdX0APSIpixPRFrsy7MEXvgS9
         IWhRjGRBWszmK0FB2DpzQYShjzN/ZhyPjY/UXf5NGR3sKaXQh65/C1x0JUQfSacicejo
         jnVyYdjh2LaLI2XWRVDtnZyM/DBeH1xaqmsU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yyyop4fY63SKx0bReSAkYJg24Sci71v5/4dsnKctGuU=;
        b=fLxnHXy+9aw83y9T/md8RHpvSUDeCcbKfeMuOvQ671tru4UOEpypzUrJMZ1AkYiG3A
         +MHin2kUaTBDVCLtuH5ZY3RNA+riWU6BlUerNi8Yg+VkvYxfNmQN6+e1gdRxk72PTa1Q
         ZKOLUM+KlHOVr+BPyhesktjuc1G0FblDBiBBJYkPX2dO/I1HfAf3wX04Dj4gM+MF8fhZ
         8uDR7iIZk8AzHXeh4gqDGfQXJ2KJGw7d4iF6bB+nR91erwEfLGnYOON2W5hegRpqUE67
         sPDWW+v8xmK8dVBOMVRaZYfQfzWO9R92f58rvqZ4bIHHeAz3zQd+d873kjfz3lXNZFHz
         zkog==
X-Gm-Message-State: AOAM532XF6lrR8i5nF9rhb6Ar/rSjWUT5iERUKdm7yEuCQ/ockv4q9Ae
        k4AdEfwPcooLHoM8aOyheBpTb1V6/q3ysCUyes9/eQ==
X-Google-Smtp-Source: ABdhPJynAaTgSvmlIlgeV2ate07OIXbKHLw4YgBBR19SgdjD1iKMkNzeFIJkfKqIWt9zuajilhf07mhwfOLkmrLiu5A=
X-Received: by 2002:a7b:c3d5:0:b0:381:2ed5:aee1 with SMTP id
 t21-20020a7bc3d5000000b003812ed5aee1mr2714140wmj.113.1646293941617; Wed, 02
 Mar 2022 23:52:21 -0800 (PST)
MIME-Version: 1.0
References: <20220302120925.4153592-1-xji@analogixsemi.com>
In-Reply-To: <20220302120925.4153592-1-xji@analogixsemi.com>
From:   Pin-yen Lin <treapking@chromium.org>
Date:   Thu, 3 Mar 2022 15:52:10 +0800
Message-ID: <CAEXTbpeUTdfA31gpiJAzvyCScjWLUqCxjpF6-YCFCe5JmiyDZw@mail.gmail.com>
Subject: Re: drm/bridge: anx7625: Set downstream sink into normal status
To:     Xin Ji <xji@analogixsemi.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, treapking@google.com,
        qwen@analogixsemi.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, hsinyi@chromium.org,
        bliang@analogixsemi.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Pin-Yen Lin <treapking@chromium.org>


On Wed, Mar 2, 2022 at 8:09 PM Xin Ji <xji@analogixsemi.com> wrote:
>
> As downstream sink was set into standby mode while bridge disabled,
> this patch used for setting downstream sink into normal status
> while enable bridge.
>
> Signed-off-by: Xin Ji <xji@analogixsemi.com>
> ---
>  drivers/gpu/drm/bridge/analogix/anx7625.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> index 9aab879a8851..963eaf73ecab 100644
> --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> @@ -919,12 +919,20 @@ static void anx7625_dp_start(struct anx7625_data *ctx)
>  {
>         int ret;
>         struct device *dev = &ctx->client->dev;
> +       u8 data;
>
>         if (!ctx->display_timing_valid) {
>                 DRM_DEV_ERROR(dev, "mipi not set display timing yet.\n");
>                 return;
>         }
>
> +       dev_info(dev, "set downstream sink into normal\n");
> +       /* Downstream sink enter into normal mode */
> +       data = 1;
> +       ret = anx7625_aux_trans(ctx, DP_AUX_NATIVE_WRITE, 0x000600, 1, &data);
> +       if (ret < 0)
> +               dev_err(dev, "IO error : set sink into normal mode fail\n");
> +
>         /* Disable HDCP */
>         anx7625_write_and(ctx, ctx->i2c.rx_p1_client, 0xee, 0x9f);
>
