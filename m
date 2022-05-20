Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 403D152E11F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 02:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343965AbiETAVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 20:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343950AbiETAVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 20:21:38 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203C99CF4B
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 17:21:37 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id i19so12742790eja.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 17:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+wYJNaePiHcWNH/q3h1ZhNLEV4dJ71MIiiBiHgAmbYA=;
        b=NVM/bktb8CtRk0VgJ75AEtD+l1Etp4dc82+iRcIAsF62UYPJmJUe2sENhNxQGCGQpE
         vCsHBMNUy7vONzvYsBEHm8ej3XihpZ8QIBEoXSsqArdCBjVJF4IByYjx2R35+TnR4FqV
         VDBFu5MpvMXsafQZ0SE+nZWoCjniwY9mA1MNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+wYJNaePiHcWNH/q3h1ZhNLEV4dJ71MIiiBiHgAmbYA=;
        b=O/hb0l+eauUOydPJ+X6PDe+r5ewmtvfODcwmYH8ahg0XqFDgQKp2W3z6/cqJhzOWVO
         D0h4lnYQfOWFfhVnjMGdSRtz8P217uUxSBManSLNa6KK/AyTC2rg/CwVGVEWZCMtK6tU
         qUHDiM2qIZ6SPy3OHJqr4ROy4eCJzRfKvDkO78Pd90fcuZf3+7EW5orCrnaBHeYXAC+n
         /dr8fEuc0TMNRviNYz/2SRX2YW5/iNoDh5xcjjltc/5XUkTPlWYj116+OUjfC65hk42T
         /KPkmVmlAr2yszrGf/7GUtWijBSm0vQOZg8eY3CufG6fEpw3/5qY9bEEscTBDtvehGT5
         4btw==
X-Gm-Message-State: AOAM533V3oKoCvAOiV9Otv0z3dGcQYyOX04JsQ+BG8iG9KhcmZb/IA62
        dfnXPo3e/3TIK9r+4/UxdNbbXbAYcyt+zsjQ3j0=
X-Google-Smtp-Source: ABdhPJzPrJ8zGcRWMPOP2PJNJAK5Fbrl6/BgusQP8fQkCJvp56hibTuiFQhGnY465Zq2NEzWdwN8VQ==
X-Received: by 2002:a17:907:6d25:b0:6f4:d753:f250 with SMTP id sa37-20020a1709076d2500b006f4d753f250mr6442505ejc.580.1653006095466;
        Thu, 19 May 2022 17:21:35 -0700 (PDT)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id m5-20020a17090677c500b006f3ef214e28sm2638465ejn.142.2022.05.19.17.21.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 17:21:33 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id j24so9406563wrb.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 17:21:33 -0700 (PDT)
X-Received: by 2002:a5d:5085:0:b0:20d:5f6:63fa with SMTP id
 a5-20020a5d5085000000b0020d05f663famr5861629wrt.679.1653006092752; Thu, 19
 May 2022 17:21:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220511155749.v3.1.I2dd93486c6952bd52f2020904de0133970d11b29@changeid>
 <20220511155749.v3.2.I4ac7f55aa446699f8c200a23c10463256f6f439f@changeid>
In-Reply-To: <20220511155749.v3.2.I4ac7f55aa446699f8c200a23c10463256f6f439f@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 19 May 2022 17:21:20 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X7cr-=UwV_XbAYovTqeUYXO3LVLTU2bLiwf8wU2kGsLA@mail.gmail.com>
Message-ID: <CAD=FV=X7cr-=UwV_XbAYovTqeUYXO3LVLTU2bLiwf8wU2kGsLA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] drm/probe-helper: For DP, add 640x480 if all other
 modes are bad
To:     dri-devel <dri-devel@lists.freedesktop.org>
Cc:     freedreno <freedreno@lists.freedesktop.org>,
        Stephen Boyd <swboyd@chromium.org>,
        "Kuogee Hsieh (QUIC)" <quic_khsieh@quicinc.com>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        "Abhinav Kumar (QUIC)" <quic_abhinavk@quicinc.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        "Aravind Venkateswaran (QUIC)" <quic_aravindh@quicinc.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Wed, May 11, 2022 at 3:58 PM Douglas Anderson <dianders@chromium.org> wrote:
>
> As per Displayport spec section 5.2.1.2 ("Video Timing Format") says
> that all detachable sinks shall support 640x480 @60Hz as a fail safe
> mode.
>
> A DP compliance test expected us to utilize the above fact when all
> modes it presented to the DP source were not achievable. It presented
> only modes that would be achievable with more lanes and/or higher
> speeds than we had available and expected that when we couldn't do
> that then we'd fall back to 640x480 even though it didn't advertise
> this size.
>
> In order to pass the compliance test (and also support any users who
> might fall into a similar situation with their display), we need to
> add 640x480 into the list of modes. However, we don't want to add
> 640x480 all the time. Despite the fact that the DP spec says all sinks
> _shall support_ 640x480, they're not guaranteed to support it
> _well_. Continuing to read the spec you can see that the display is
> not required to really treat 640x480 equal to all the other modes. It
> doesn't need to scale or anything--just display the pixels somehow for
> failsafe purposes. It should also be noted that it's not hard to find
> a display hooked up via DisplayPort that _doesn't_ support 640x480 at
> all. The HP ZR30w screen I'm sitting in front of has a native DP port
> and doesn't work at 640x480. I also plugged in a tiny 800x480 HDMI
> display via a DP to HDMI adapter and that screen definitely doesn't
> support 640x480.
>
> As a compromise solution, let's only add the 640x480 mode if:
> * We're on DP.
> * All other modes have been pruned.
>
> This acknowledges that 640x480 might not be the best mode to use but,
> since sinks are _supposed_ to support it, we will at least fall back
> to it if there's nothing else.
>
> Note that we _don't_ add higher resolution modes like 1024x768 in this
> case. We only add those modes for a failed EDID read where we have no
> idea what's going on. In the case where we've pruned all modes then
> instead we only want 640x480 which is the only defined "Fail Safe"
> resolution.
>
> This patch originated in response to Kuogee Hsieh's patch [1].
>
> [1] https://lore.kernel.org/r/1650671124-14030-1-git-send-email-quic_khsieh@quicinc.com
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Tested-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>
> Changes in v3:
> - Removed WARN_ON
>
> Changes in v2:
> - Two underscores for __drm_helper_update_and_validate().
> - Return err and use WARN_ON instead of returning a bool.
>
>  drivers/gpu/drm/drm_probe_helper.c | 27 ++++++++++++++++++++++-----
>  1 file changed, 22 insertions(+), 5 deletions(-)

Pushed to drm-misc-next:

e7c254d75d16 drm/probe-helper: For DP, add 640x480 if all other modes are bad
