Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB594E5ADC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 22:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345022AbiCWVtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 17:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbiCWVtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 17:49:23 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB508E1BC
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 14:47:53 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id qx21so5473714ejb.13
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 14:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SFPXmPT7/mwXkkz89BQ6Ja5ArCL0mt2OdL/RGrBAAyM=;
        b=OFCDwRlZ4PBEwBgRJ2fN0hWjPJeC4zcCImAwyCHTlIWxjUu97sa7XaKAMJN7NAkvb5
         D6SKJzYDt9JZr7b+KOER1At1m32cTeKX5DOzzThOMZXnDIWZsi2YCsQ05+hwPXQ6vtC5
         Gl5BfMsmzcGr4ViX9uMIBY4qmJd80xnnpWddw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SFPXmPT7/mwXkkz89BQ6Ja5ArCL0mt2OdL/RGrBAAyM=;
        b=l3F2ZEsTK6uIUYiA8b5WWtM8ylb05RvegZMBpPk5tRHKISHF9r/sEL2+ha9VhAhWFz
         SQ/EaJN57bK4xq19PHwrWxHA0mUv1EeKyWW2DvICUagMh4FP7Qg8K4Jeli3/IATaQLG3
         yoG7VS0hxmmK83I2nwo+AmzIKcOE3IEru6eMlQ2TWmxsbrfu/GhGRbH4QEYsPlyYT9Ig
         8Hz1m6IJsK2l1lJ/6XAxPsh2ddpnfss0pv6BheBnuJ6ItSE4NnahCOGJ5sGRd8dkuUf4
         cJn1w1ABzMz1KsQQI6ly7zpWsFzWXbBxEx0B3C/Dzfmq1ZJp13yaqwqQIlfxYwBbotCN
         haIg==
X-Gm-Message-State: AOAM532SgznzMVUv44RW0xSWADcGTHCRVFhyzXm5PGe0hv56oaCRyBCC
        Hh1mkwzvADE4p91IfZtR/Xg6Vl+a/0H77u9i
X-Google-Smtp-Source: ABdhPJx4hOxUVpl9b+ebWFzjyRyEaVBaQJ8snQaLkbceBVXP9+Y+oJvAA+AxPbh5WdCud2TlHsTxXg==
X-Received: by 2002:a17:906:4fcb:b0:6e0:55b7:179 with SMTP id i11-20020a1709064fcb00b006e055b70179mr2452062ejw.159.1648072071791;
        Wed, 23 Mar 2022 14:47:51 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id s14-20020aa7cb0e000000b00410bf015567sm461670edt.92.2022.03.23.14.47.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 14:47:51 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id m30so4039908wrb.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 14:47:51 -0700 (PDT)
X-Received: by 2002:a05:6000:1704:b0:203:d857:aa7a with SMTP id
 n4-20020a056000170400b00203d857aa7amr1701592wrc.513.1648072070767; Wed, 23
 Mar 2022 14:47:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220317131250.1481275-1-kieran.bingham+renesas@ideasonboard.com> <20220317131250.1481275-3-kieran.bingham+renesas@ideasonboard.com>
In-Reply-To: <20220317131250.1481275-3-kieran.bingham+renesas@ideasonboard.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 23 Mar 2022 14:47:38 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XwThyeZ-LFvxD9RYA=_T7aycbE84QYSjA7crkAwv=2fQ@mail.gmail.com>
Message-ID: <CAD=FV=XwThyeZ-LFvxD9RYA=_T7aycbE84QYSjA7crkAwv=2fQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] drm/bridge: ti-sn65dsi86: Implement bridge
 connector operations
To:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
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

On Thu, Mar 17, 2022 at 6:13 AM Kieran Bingham
<kieran.bingham+renesas@ideasonboard.com> wrote:
>
> From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
>
> Implement the bridge connector-related .get_edid() operation, and report
> the related bridge capabilities and type.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
> Changes since v1:
>
> - The connector .get_modes() operation doesn't rely on EDID anymore,
>   __ti_sn_bridge_get_edid() and ti_sn_bridge_get_edid() got merged
>   together
>  - Fix on top of Sam Ravnborg's DRM_BRIDGE_STATE_OPS
>
> Changes since v2: [Kieran]
>  - Only support EDID on DRM_MODE_CONNECTOR_DisplayPort modes.
>
> Changes since v3: [Kieran]
>  - Remove PM calls in ti_sn_bridge_get_edid() and simplify
>
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Looks good to me now.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
