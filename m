Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD6904B912D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 20:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbiBPT3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 14:29:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbiBPT3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 14:29:51 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C482AF938
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 11:29:38 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id c6so2964393edk.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 11:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AI8joxrk1YyY98A4abN1SonGW2lvV7xnuRU9NFCob50=;
        b=OMOMVpSoOJQ54fMEuRukmDdSLLKh6/vsEUaz/TTeA/q0kDcXGMcglN/JS5LBzCX8Lv
         lmpYnb6FTlqbP97L5MeOKH4seXrJJZvQxfiDHYkIdrjRBTduDl/H35RJX8e4JhKcb22j
         8u0V3hJ4O23K2ze9bvRjq6uL7yKhYRpsOymjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AI8joxrk1YyY98A4abN1SonGW2lvV7xnuRU9NFCob50=;
        b=1Z+akD86nP5TKBhxmqkZp5ftYUBUNxImnFq6xnlagjt9BMTExJy/FCB8ZvwNKgFPiH
         52paMEcbT3j6gUXjN7/lt03hk57ikHZiHksCoxYnhK4WNr6SxuKM184nEy7tqcSapFe+
         s9i1YX4NScro7Kc+udjSgU6vfF+iasr3OynnjcHu2GdKYOkagLciW7w/dLsfC/u6lG+4
         PvUC6bAA0GxUOa8mvcusfvxWdpsBFmJLQTd4v8xgBn84Ruu63Dwcwrbd/6rFp7qd/HN3
         giQFLOkxjHJfsyZ3d1t+HAUDuVXzSh3V7O4bcKOPlxCnr0Xs32j1C9mEt4QLP3Sq2VdC
         TfMQ==
X-Gm-Message-State: AOAM533HgFgjXA6M4/DwbtICzrYxp/289ddgvUwKECTIta+5gblpmsnv
        VR9kaROcJZCQK1IggQRyOkEEU6/dRGCMEKbJ2e0=
X-Google-Smtp-Source: ABdhPJyqgJzyihgPZOWPFVceMBlYw5K8s2KkotiSj+gBWp7Qd4y5Kob1K6oNhsaV85XLL4VIUHurlQ==
X-Received: by 2002:a50:8713:0:b0:410:db7a:4b2a with SMTP id i19-20020a508713000000b00410db7a4b2amr4629247edb.140.1645039776444;
        Wed, 16 Feb 2022 11:29:36 -0800 (PST)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id j19sm246211ejo.202.2022.02.16.11.29.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 11:29:35 -0800 (PST)
Received: by mail-wm1-f54.google.com with SMTP id y6-20020a7bc186000000b0037bdc5a531eso3284979wmi.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 11:29:34 -0800 (PST)
X-Received: by 2002:a05:600c:228e:b0:37c:2eef:7bf with SMTP id
 14-20020a05600c228e00b0037c2eef07bfmr2876839wmf.73.1645039773639; Wed, 16 Feb
 2022 11:29:33 -0800 (PST)
MIME-Version: 1.0
References: <1644494255-6632-1-git-send-email-quic_sbillaka@quicinc.com> <1644494255-6632-5-git-send-email-quic_sbillaka@quicinc.com>
In-Reply-To: <1644494255-6632-5-git-send-email-quic_sbillaka@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 16 Feb 2022 11:29:21 -0800
X-Gmail-Original-Message-ID: <CAD=FV=V9vXbvuU5oK6maXKAfzEPzT2Fp5Vf3CUqpJvmM+wrjeg@mail.gmail.com>
Message-ID: <CAD=FV=V9vXbvuU5oK6maXKAfzEPzT2Fp5Vf3CUqpJvmM+wrjeg@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] drm/panel-edp: Add eDP sharp panel support
To:     Sankeerth Billakanti <quic_sbillaka@quicinc.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, quic_kalyant@quicinc.com,
        quic_abhinavk@quicinc.com, quic_khsieh@quicinc.com,
        quic_mkrishn@quicinc.com, quic_vproddut@quicinc.com
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

On Thu, Feb 10, 2022 at 3:58 AM Sankeerth Billakanti
<quic_sbillaka@quicinc.com> wrote:
>
> Add support for the 14" sharp,lq140m1jw46 eDP panel.
>
> Signed-off-by: Sankeerth Billakanti <quic_sbillaka@quicinc.com>
> ---
> 00 ff ff ff ff ff ff 00 4d 10 23 15 00 00 00 00
> 35 1e 01 04 a5 1f 11 78 07 de 50 a3 54 4c 99 26
> 0f 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 5a 87 80 a0 70 38 4d 40 30 20
> 35 00 35 ae 10 00 00 18 65 38 80 a0 70 38 4d 40
> 30 20 35 00 35 ae 10 00 00 18 00 00 00 fd 00 30
> 90 a7 a7 23 01 00 00 00 00 00 00 00 00 00 00 fc
> 00 4c 51 31 34 30 4d 31 4a 57 34 39 0a 20 00 77
>
> ----------------
>
> Block 0, Base EDID:
>   EDID Structure Version & Revision: 1.4
>   Vendor & Product Identification:
>     Manufacturer: SHP
>     Model: 5411
>     Made in: week 53 of 2020
>   Basic Display Parameters & Features:
>     Digital display
>     Bits per primary color channel: 8
>     DisplayPort interface
>     Maximum image size: 31 cm x 17 cm
>     Gamma: 2.20
>     Supported color formats: RGB 4:4:4
>     Default (sRGB) color space is primary color space
>     First detailed timing includes the native pixel format and preferred refresh rate
>     Display is continuous frequency
>   Color Characteristics:
>     Red  : 0.6396, 0.3291
>     Green: 0.2998, 0.5996
>     Blue : 0.1494, 0.0595
>     White: 0.3125, 0.3281
>   Established Timings I & II: none
>   Standard Timings: none
>   Detailed Timing Descriptors:
>     DTD 1:  1920x1080  143.981 Hz  16:9   166.587 kHz  346.500 MHz (309 mm x 174 mm)
>                  Hfront   48 Hsync  32 Hback  80 Hpol N
>                  Vfront    3 Vsync   5 Vback  69 Vpol N
>     DTD 2:  1920x1080   59.990 Hz  16:9    69.409 kHz  144.370 MHz (309 mm x 174 mm)
>                  Hfront   48 Hsync  32 Hback  80 Hpol N
>                  Vfront    3 Vsync   5 Vback  69 Vpol N
>   Display Range Limits:
>     Monitor ranges (Bare Limits): 48-144 Hz V, 167-167 kHz H, max dotclock 350 MHz
>     Display Product Name: 'LQ140M1JW49'
> Checksum: 0x77
>
> Changes in v4:
>   -Add all modes from EDID
>   -Provide EDID blob
>
> Changes in v3:
>   None
>
>  drivers/gpu/drm/panel/panel-edp.c | 44 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)

We want to be moving to the generic edp-panel but even if we move to
edp-panel there's no harm in supporting things the old way, especially
as people are transitioning.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
