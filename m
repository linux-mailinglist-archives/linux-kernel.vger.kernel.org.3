Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8D455E957
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347394AbiF1Owv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 10:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347381AbiF1Owr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 10:52:47 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A9332067
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 07:52:46 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id q6so26219833eji.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 07:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zLp244HRKuXK443MblJOFX9TiLKY+sMNN7lfWRmJzw4=;
        b=Lk7xi3t/LB2zXUPx3APLw1OdwcapOiHYlZJA4tOn/NbuDoTBbMcIduKURJqTEBrkoj
         YYZ4czzT6ihRD/blwTjeq6YA9LXg+DB/+iymb+sPgeQRaIxaptCod570AG3D80pBU9e4
         5+8iG89M5uxSJJ+dv/Ns8XdtFg+q/u0L7J170=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zLp244HRKuXK443MblJOFX9TiLKY+sMNN7lfWRmJzw4=;
        b=gLCndqAK9R+Kal4YOtTHEnnIH3T1DG8rE0BtAIMOqq7cE3ousPgSr8+w1Qxcdjq8iR
         y327ey+gieaf0tC6OTCdqAyGWFG/Dg54YS5I27LkJzpeBR9RY5/SNoazUrFZ0goG98VQ
         w1eDIi97bNv9ZSw+u2EqCmMPup2qWDFLk8v1gNvTI3eC/dLWzIVnK7sCJpOY54xiZvnY
         IQiriQhXg9j0MBa7l28gUBBjOPmsp0UYzYbTBgeJuTv0WjTm5p00qsKDi4woVWjHPaOW
         WscTwAopeESX0qkO6P3beAw9IrFgMD29iIy6Zfwls0FjtVbZeBGWKFpoan+SVyBX2Izs
         ok7g==
X-Gm-Message-State: AJIora/hQBzFzOQBZXHrmWrxU7iPwZ7PrnIQZvVWENTXlLzSWLE3krow
        txyBoEJ24nAd0AgBZsPa5J6J7tECNyJw7oJ2
X-Google-Smtp-Source: AGRyM1vX1p7kZVN0sUmjJGiOeMbb0NtTVfpWZKJU0fBZNl4aDI2D8YJ/0MDYasw9BJnksOCzTqi7Kg==
X-Received: by 2002:a17:906:1b01:b0:726:be5e:7125 with SMTP id o1-20020a1709061b0100b00726be5e7125mr7146802ejg.678.1656427964983;
        Tue, 28 Jun 2022 07:52:44 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id o19-20020a17090611d300b007109b15c109sm6608095eja.66.2022.06.28.07.52.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 07:52:44 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id b26so5682518wrc.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 07:52:43 -0700 (PDT)
X-Received: by 2002:a5d:4046:0:b0:21a:3a12:239e with SMTP id
 w6-20020a5d4046000000b0021a3a12239emr18136405wrp.138.1656427963334; Tue, 28
 Jun 2022 07:52:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220628085949.2147920-1-rexnie3@gmail.com>
In-Reply-To: <20220628085949.2147920-1-rexnie3@gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 28 Jun 2022 07:52:31 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U8oR-L7XRJH7qVG2p2m1J8obnQSTzA2moZZ8Kmy2SzFw@mail.gmail.com>
Message-ID: <CAD=FV=U8oR-L7XRJH7qVG2p2m1J8obnQSTzA2moZZ8Kmy2SzFw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm/panel-edp: Add eDP innolux panel support
To:     Rex Nie <rexnie3@gmail.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sandeep Panda <spanda@codeaurora.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Hsin-Yi Wang <hsinyi@chromium.org>,
        Rob Herring <robh@kernel.org>
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

Hi,

On Tue, Jun 28, 2022 at 2:00 AM Rex Nie <rexnie3@gmail.com> wrote:
>
> Add support for the 14" innolux,n140hca-eac eDP panel.
>
> Signed-off-by: Rex Nie <rexnie3@gmail.com>
> Acked-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
> index 3626469c4cc2..2a8fcdffe80c 100644
> --- a/drivers/gpu/drm/panel/panel-edp.c
> +++ b/drivers/gpu/drm/panel/panel-edp.c
> @@ -1355,6 +1355,29 @@ static const struct panel_desc innolux_n125hce_gn1 = {
>         },
>  };
>
> +static const struct display_timing innolux_n140hca_eac_timing = {
> +       .pixelclock = { 72600000, 76420000, 80240000 },
> +       .hactive = { 1920, 1920, 1920 },
> +       .hfront_porch = { 80, 80, 80 },
> +       .hback_porch = { 190, 190, 190 },
> +       .hsync_len = { 60, 60, 60 },
> +       .vactive = { 1080, 1080, 1080 },
> +       .vfront_porch = { 6, 6, 6 },
> +       .vback_porch = { 38, 38, 38 },
> +       .vsync_len = { 8, 8, 8 },
> +       .flags = DISPLAY_FLAGS_VSYNC_LOW | DISPLAY_FLAGS_HSYNC_LOW,
> +};

A few questions:

1. If I'm doing my math right, you're saying that this panel runs at
30 Hz refresh rate. Truly? While I won't dismiss that as impossible,
it feels unlikely. Specifically:

In [2]: 72600000 / ((1920 + 80 + 190 + 60) * (1080 + 6 + 38 + 8))
Out[2]: 28.50412249705536

In [3]: 80240000 / ((1920 + 80 + 190 + 60) * (1080 + 6 + 38 + 8))
Out[3]: 31.503729878288183

NOTE: I managed to dig up a datasheet for this panel and the datasheet
I have shows it as a 60 Hz refresh rate panel.


2. You're using the "struct display_timing" here instead of the
"struct drm_display_mode". That can be OK, but can I ask why exactly?


3. Are you sure you need to add this entry? Moving forward I'm trying
to encourage people to use the generic "edp-panel". Mostly you'd want
to add a hardcoded panel here if:

a) Devices have already shipped using hardcoded timings and we don't
want to risk breaking something in the field with "edp-panel".

b) You're trying to support some eDP controller that can't handle the
generic "edp-panel". In this case I'm OK with landing changes but I'd
strongly encourage you to update the controller to handle things.


> +static const struct panel_desc innolux_n140hca_eac = {
> +       .timings = &innolux_n140hca_eac_timing,
> +       .num_timings = 1,
> +       .bpc = 6,

Is it really 6 bpc? The datasheet I dug up claims 16777216 colors
which would be 8 bpc. The EDID from that same datasheet also claims 8
bpc.


> +       .size = {
> +               .width = 309,
> +               .height = 174,
> +       },

Where are your delays? I know in old code these were hard to figure
out from the panel spec, but the kernel doc comments now translate it
into standard eDP terminology so this should be trivially easy for you
to provide.
