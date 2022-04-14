Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1706A50197C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 19:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239158AbiDNREo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 13:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243317AbiDNRDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 13:03:47 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C75DABF52
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 09:40:26 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id t25so7070672edt.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 09:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uNCknelIIQ0A0jhcGpNkNt/itvQulq3csLsSq+jMi4k=;
        b=OFD1FNp9YuGu2v7rR5vIDLHqSlz5x0ooKxLOUUFLXVcVscIABJa9XczVMvEG6Hdpic
         QEwuykdd5CFYaIM4fwYl2u3dNKd7uLY+YmmM3txQhfvMJ2+kl0ds92uwsXIkXH97bUKc
         WjRgnLpsfAzXQuHotizBIDeTEdVOmrYFEECKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uNCknelIIQ0A0jhcGpNkNt/itvQulq3csLsSq+jMi4k=;
        b=wxlqL+YGaAGj9ab0bfAk6JfD3ftGtKF6XjT1H4R73qjUJMRBXnEQCiTC8MV+W32zbm
         Mhl010O8gIaaEFRG7yF4wlziD+CNWBtHw7Wd92edyzXL/f+S5ueOfkh38koaOWsHysXL
         TdLljoEIBNHnppBQ7tIp0lg5ashNxjQDLPEttDSw5Kc+LBGRf12e7Z93RRZF02M0m9mm
         PJCTMBF63AgdUWgSztLDzXCDlM+qnBOh2U3wTsTYjDmf4gkyS/RFt6MTYDDZehVdW64C
         IN4+4GKlj7CTL4YldReIrjV4gQtp6QJRrilTNWsFFE1MEy8WE/2y1bX45NtvgLjbkoh7
         0AMg==
X-Gm-Message-State: AOAM5321ZzkXrpvKpTEZ0QjljuZsRqA5xaqMgC08ONtfEQaBP7zZeuJo
        5iIWbOD+HmlvIpmAlGteFuqYS4IS0uIQPJGw
X-Google-Smtp-Source: ABdhPJwOGGG1A/5LIUnYG9t+hcGmolpondGmp9eL1r03Ub3mRDnKjE7yQmaEC6+LVHu6dq8YBvo83A==
X-Received: by 2002:a05:6402:34c8:b0:420:d786:bbcf with SMTP id w8-20020a05640234c800b00420d786bbcfmr4043202edc.73.1649954424478;
        Thu, 14 Apr 2022 09:40:24 -0700 (PDT)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id e13-20020a1709067e0d00b006e880b53294sm773031ejr.58.2022.04.14.09.40.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 09:40:20 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id r13so7680267wrr.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 09:40:19 -0700 (PDT)
X-Received: by 2002:adf:c14d:0:b0:207:a28f:f5dd with SMTP id
 w13-20020adfc14d000000b00207a28ff5ddmr2647776wre.679.1649954418519; Thu, 14
 Apr 2022 09:40:18 -0700 (PDT)
MIME-Version: 1.0
References: <1649938766-6768-1-git-send-email-quic_sbillaka@quicinc.com> <1649938766-6768-5-git-send-email-quic_sbillaka@quicinc.com>
In-Reply-To: <1649938766-6768-5-git-send-email-quic_sbillaka@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 14 Apr 2022 09:40:04 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xrsnk0PYENn5Een1xdUc9B1DKy8jvd1itKbFkvHAivMg@mail.gmail.com>
Message-ID: <CAD=FV=Xrsnk0PYENn5Een1xdUc9B1DKy8jvd1itKbFkvHAivMg@mail.gmail.com>
Subject: Re: [PATCH v7 4/4] Support the eDP modes given by panel
To:     Sankeerth Billakanti <quic_sbillaka@quicinc.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Clark <robdclark@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        quic_kalyant <quic_kalyant@quicinc.com>,
        "Abhinav Kumar (QUIC)" <quic_abhinavk@quicinc.com>,
        "Kuogee Hsieh (QUIC)" <quic_khsieh@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        quic_vproddut <quic_vproddut@quicinc.com>,
        "Aravind Venkateswaran (QUIC)" <quic_aravindh@quicinc.com>,
        Steev Klimaszewski <steev@kali.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Apr 14, 2022 at 5:20 AM Sankeerth Billakanti
<quic_sbillaka@quicinc.com> wrote:
>
> The eDP controller does not have a reliable way keep panel
> powered on to read the sink capabilities. So, the controller
> driver cannot validate if a mode can be supported by the
> source. We will rely on the panel driver to populate only
> the supported modes for now.
>
> Signed-off-by: Sankeerth Billakanti <quic_sbillaka@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index c7277f0..0f18a16 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -998,6 +998,14 @@ enum drm_mode_status dp_bridge_mode_valid(struct drm_bridge *bridge,
>                 return -EINVAL;
>         }
>
> +       /*
> +        * The eDP controller currently does not have a reliable way of
> +        * enabling panel power to read sink capabilities. So, we rely
> +        * on the panel driver to populate only supported modes for now.
> +        */
> +       if (dp->is_edp)
> +               return MODE_OK;

As discussed out-of-band, I agree that this is the right thing for now
and making this assumption won't break anything. In general the set of
eDP panels is known ahead of time it's fairly unlikely someone would
set things up so that a panel couldn't use the mode it was reporting.

Longer term we should figure out a way to solve this but it doesn't
have to be today. To properly implement mode_valid() we've got to
combine knowledge from the panel (mostly rates supported and number of
lanes supported) with the controller (rates supported, number of lanes
supported/hooked up on this board).

In any case:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
