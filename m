Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779924D5520
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 00:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344603AbiCJXLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 18:11:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344595AbiCJXLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 18:11:52 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C3919ABC7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 15:10:50 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id w4so8884472edc.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 15:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rlIR4SYrDHWvWgYAtu+J3wURm7Ipv3I/6B8kSrbq2OQ=;
        b=bnA6CRJ2glIWfPlZurqkST+p1m84ot07sH8B7u7nQt41FHNRxKdcB9v/3KwAfTtrTe
         Z/wwid20/a7jSY4S0NjlyFhk4vO1sheV/Pq4+oqC5EElTSI3cH9CaCnz671N7XutTnU/
         Za3slb/6KLXSCm7mJtfoyWY3LDE2pXA2YtELs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rlIR4SYrDHWvWgYAtu+J3wURm7Ipv3I/6B8kSrbq2OQ=;
        b=G5sW7GB4lUGSUeKl5Oom11J+1W3Bs5Aeg28nrP9Uj+WVmRLnRT+IJDXAAP5HB9k619
         Q431y7WGIbsK0CiXs32cY4jUdRwELaf7B6e/3yK3eQb35aNEFVt1bWyHYm2ag+DNDWj9
         Lkv2YsE0slkjFdVrZ2U9SBNKFE/S/7GazZDtWaYdhV5Qx6WhD+NonSC6kc9k+bdwume4
         8rgITIvHpUnLIGNLKfnnNjJ/lzbbnoA+Wnq6W2+ViuvwCsxMu03VE5+kMN6VD5ChfQ/e
         KelmSNA5iTqV0qgLVfvar7jBcz424fxLgiUnL7WMHA04heOUeLZui+Bk7jDGZxGUy1Vm
         WFKg==
X-Gm-Message-State: AOAM533CjExhtq7EMKOI+UWwGUO8QGUErr6gLiS64KQFHuAeldm2J3Qj
        XmCqlnvlZoWRL8ARuEDgGhtHXKaN5tkKLV6P
X-Google-Smtp-Source: ABdhPJxerKAYw9QMy8ync7ggMw5GxzyzzlEU+ZY+tmDuu5ALpNHozMPNQn4h6/Wzs95qVxgoRKsKIw==
X-Received: by 2002:a05:6402:5193:b0:416:b3bf:23c3 with SMTP id q19-20020a056402519300b00416b3bf23c3mr4914764edd.163.1646953848890;
        Thu, 10 Mar 2022 15:10:48 -0800 (PST)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id s14-20020aa7cb0e000000b00410bf015567sm2502186edt.92.2022.03.10.15.10.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 15:10:47 -0800 (PST)
Received: by mail-wr1-f47.google.com with SMTP id t11so10390225wrm.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 15:10:47 -0800 (PST)
X-Received: by 2002:adf:eb45:0:b0:1ef:6070:7641 with SMTP id
 u5-20020adfeb45000000b001ef60707641mr5371549wrn.301.1646953847020; Thu, 10
 Mar 2022 15:10:47 -0800 (PST)
MIME-Version: 1.0
References: <20220310152227.2122960-1-kieran.bingham+renesas@ideasonboard.com> <20220310152227.2122960-2-kieran.bingham+renesas@ideasonboard.com>
In-Reply-To: <20220310152227.2122960-2-kieran.bingham+renesas@ideasonboard.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 10 Mar 2022 15:10:34 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XU5VGdKZ77UNb14Ah=LYKvSqbtBpzobMJYyMNDOXH2qg@mail.gmail.com>
Message-ID: <CAD=FV=XU5VGdKZ77UNb14Ah=LYKvSqbtBpzobMJYyMNDOXH2qg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] drm/bridge: ti-sn65dsi86: Support DisplayPort
 (non-eDP) mode
To:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Mar 10, 2022 at 7:22 AM Kieran Bingham
<kieran.bingham+renesas@ideasonboard.com> wrote:
>
> From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
>
> Despite the SN65DSI86 being an eDP bridge, on some systems its output is
> routed to a DisplayPort connector. Enable DisplayPort mode when the next
> component in the display pipeline is detected as a DisplayPort
> connector, and disable eDP features in that case.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Reworked to set bridge type based on the next bridge/connector.
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> --
> Changes since v1/RFC:
>  - Rebased on top of "drm/bridge: ti-sn65dsi86: switch to
>    devm_drm_of_get_bridge"
>  - eDP/DP mode determined from the next bridge connector type.
>
> Changes since v2:
>  - Remove setting of Standard DP Scrambler Seed. (It's read-only).
>  - Prevent setting DP_EDP_CONFIGURATION_SET in
>    ti_sn_bridge_atomic_enable()
>  - Use Doug's suggested text for disabling ASSR on DP mode.
>
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> index c892ecba91c7..93b54fcba8ba 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> @@ -62,6 +62,7 @@
>  #define SN_LN_ASSIGN_REG                       0x59
>  #define  LN_ASSIGN_WIDTH                       2
>  #define SN_ENH_FRAME_REG                       0x5A
> +#define  ASSR_CONTROL                          BIT(0)

nit that the ASSR_CONTROL define is no longer used.

Other than that, this patch looks fine to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
