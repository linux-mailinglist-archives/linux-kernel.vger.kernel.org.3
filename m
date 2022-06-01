Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C60753ADC8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 22:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbiFAUri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 16:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbiFAUqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 16:46:48 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A6313390E
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 13:41:19 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id m82so4120562oif.13
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 13:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yq2KQdG6/LqMMNGY1MWEE6ZyXA6F1VGTHd9bSTup/3o=;
        b=UARHyJjjhNcYzRbzkaCgemaWFT5Gh3U0EynMwzXn2AMBL42sV7T+9SKExYW+jqptUw
         5cCXSI7UQRbu2C3dVEwi1yOHBQG7evklGKr3UmM5mf6MQflTQ9kFM93gkYt5WUDvz8re
         C8FgujhQx59oIpLc2KkHWKGquo4eY6wE+1s8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yq2KQdG6/LqMMNGY1MWEE6ZyXA6F1VGTHd9bSTup/3o=;
        b=Qfdr46JDVZJyrztYKPixX74PRrGpNVCxkNs39LgRftXIpzHcvMI9Wk8tXwbniNG/VO
         XlA/R94WpMTntQdvTUYisSYiUpJcS8UKHq+TBWIUSunrbSF0q8xC1JuGH9uIH/tsJ/aH
         VzuFSLc/rP1/wwOc+JFxxK//KerbHRX/NIGy/X1QXc15A8EMciJCM94jHrP22NyXQkQG
         wKOxIKbtK8O8KA1y7hPx758wQIHhZWDNXCH8eUucIgj8E8PiNsjawtG+drl7PXhforQx
         BD2N+mOYvQGX3yDMYoijEBOp6cZcmL8JFHfiQ9i2mOQqo41/ifW9vOr5XazMUDO6uAln
         6mvg==
X-Gm-Message-State: AOAM530QVEOmxkCSIktQYRzmNp1sXO8qkraIG/ir2K7J2yT2rVsYO41c
        f2kVo0kKBDoLd23WZHHiBHFGrnnY2PHZ/qm9
X-Google-Smtp-Source: ABdhPJzFs/mjEG38DUmQjbQ21SmgO+2p76ONStSgS1VzShbQBGe6YFYECSECS3+IRWAboHhM1ChGCw==
X-Received: by 2002:a17:90b:3b8a:b0:1e2:f1da:bf9b with SMTP id pc10-20020a17090b3b8a00b001e2f1dabf9bmr19460441pjb.77.1654112064201;
        Wed, 01 Jun 2022 12:34:24 -0700 (PDT)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com. [209.85.216.42])
        by smtp.gmail.com with ESMTPSA id z35-20020a631923000000b003fca29a49bbsm1761768pgl.1.2022.06.01.12.34.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 12:34:23 -0700 (PDT)
Received: by mail-pj1-f42.google.com with SMTP id nn3-20020a17090b38c300b001e0e091cf03so4427222pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 12:34:23 -0700 (PDT)
X-Received: by 2002:a05:6102:23d9:b0:335:e916:b99d with SMTP id
 x25-20020a05610223d900b00335e916b99dmr830606vsr.70.1654111658217; Wed, 01 Jun
 2022 12:27:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220601112302.v4.1.I31ec454f8d4ffce51a7708a8092f8a6f9c929092@changeid>
In-Reply-To: <20220601112302.v4.1.I31ec454f8d4ffce51a7708a8092f8a6f9c929092@changeid>
From:   Sean Paul <seanpaul@chromium.org>
Date:   Wed, 1 Jun 2022 15:27:00 -0400
X-Gmail-Original-Message-ID: <CAOw6vb+6g2Se-TPPy1=9P+tK7f+9sb6tuqbSAEqXXCG=XGPyhA@mail.gmail.com>
Message-ID: <CAOw6vb+6g2Se-TPPy1=9P+tK7f+9sb6tuqbSAEqXXCG=XGPyhA@mail.gmail.com>
Subject: Re: [Freedreno] [PATCH v4] drm/probe-helper: Default to 640x480 if no
 EDID on DP
To:     Douglas Anderson <dianders@chromium.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        "Aravind Venkateswaran (QUIC)" <quic_aravindh@quicinc.com>,
        "Kuogee Hsieh (QUIC)" <quic_khsieh@quicinc.com>,
        freedreno <freedreno@lists.freedesktop.org>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 1, 2022 at 2:23 PM Douglas Anderson <dianders@chromium.org> wrote:
>
> If we're unable to read the EDID for a display because it's corrupt /
> bogus / invalid then we'll add a set of standard modes for the
> display. Since we have no true information about the connected
> display, these modes are essentially guesses but better than nothing.
> At the moment, none of the modes returned is marked as preferred, but
> the modes are sorted such that the higher resolution modes are listed
> first.
>
> When userspace sees these modes presented by the kernel it needs to
> figure out which one to pick. At least one userspace, ChromeOS [1]
> seems to use the rules (which seem pretty reasonable):
> 1. Try to pick the first mode marked as preferred.
> 2. Try to pick the mode which matches the first detailed timing
>    descriptor in the EDID.
> 3. If no modes were marked as preferred then pick the first mode.
>
> Unfortunately, userspace's rules combined with what the kernel is
> doing causes us to fail section 4.2.2.6 (EDID Corruption Detection) of
> the DP 1.4a Link CTS. That test case says that, while it's OK to allow
> some implementation-specific fall-back modes if the EDID is bad that
> userspace should _default_ to 640x480.
>
> Let's fix this by marking 640x480 as default for DP in the no-EDID
> case.
>
> NOTES:
> - In the discussion around v3 of this patch [2] there was talk about
>   solving this in userspace and I even implemented a patch that would
>   have solved this for ChromeOS, but then the discussion turned back
>   to solving this in the kernel.
> - Also in the discussion of v3 [2] it was requested to limit this
> 83;40900;0c  change to just DP since folks were worried that it would break some
>   subtle corner case on VGA or HDMI.
>
> [1] https://source.chromium.org/chromium/chromium/src/+/a051f741d0a15caff2251301efe081c30e0f4a96:ui/ozone/platform/drm/common/drm_util.cc;l=488
> [2] https://lore.kernel.org/r/20220513130533.v3.1.I31ec454f8d4ffce51a7708a8092f8a6f9c929092@changeid
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>


Reviewed-by: Sean Paul <seanpaul@chromium.org>

>
> ---
> I put Abhinav's Reviewed-by tag from v2 here since this is nearly the
> same as v2. Hope this is OK.
>
> Changes in v4:
> - Code is back to v2, but limit to just DP.
> - Beefed up the commit message.
>
> Changes in v3:
> - Don't set preferred, just disable the sort.
>
> Changes in v2:
> - Don't modify drm_add_modes_noedid() 'cause that'll break others
> - Set 640x480 as preferred in drm_helper_probe_single_connector_modes()
>
>  drivers/gpu/drm/drm_probe_helper.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/drm_probe_helper.c b/drivers/gpu/drm/drm_probe_helper.c
> index 425f56280d51..75a71649b64d 100644
> --- a/drivers/gpu/drm/drm_probe_helper.c
> +++ b/drivers/gpu/drm/drm_probe_helper.c
> @@ -569,8 +569,17 @@ int drm_helper_probe_single_connector_modes(struct drm_connector *connector,
>                 count = drm_add_override_edid_modes(connector);
>
>         if (count == 0 && (connector->status == connector_status_connected ||
> -                          connector->status == connector_status_unknown))
> +                          connector->status == connector_status_unknown)) {
>                 count = drm_add_modes_noedid(connector, 1024, 768);
> +
> +               /*
> +                * Section 4.2.2.6 (EDID Corruption Detection) of the DP 1.4a
> +                * Link CTS specifies that 640x480 (the official "failsafe"
> +                * mode) needs to be the default if there's no EDID.
> +                */
> +               if (connector->connector_type == DRM_MODE_CONNECTOR_DisplayPort)
> +                       drm_set_preferred_mode(connector, 640, 480);
> +       }
>         count += drm_helper_probe_add_cmdline_mode(connector);
>         if (count != 0) {
>                 ret = __drm_helper_update_and_validate(connector, maxX, maxY, &ctx);
> --
> 2.36.1.255.ge46751e96f-goog
>
