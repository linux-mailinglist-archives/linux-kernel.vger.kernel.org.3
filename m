Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E045695C0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 01:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234084AbiGFXTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 19:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbiGFXTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 19:19:15 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0D523160
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 16:19:14 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id r21so771922eju.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 16:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q/Ysdr5RliGVgXwVXSg+b/L5hF2oyr6zGQqCB2KMY/0=;
        b=gUDNXgh8oYKcJZw0fUdo4BytcCdgQxI55O9Z8eNCVrgBjjaoaN+pidJLGzKrW3fAqI
         hsvgccN+NLv3W4Qd5dsHD4E/vPub65TAG6ylvI/+TfIpXY4YS8UOm1l61MtOvueWxmzh
         TU02Ugf9JLdShW2ETtxvEPvMRHEZhot0uKREE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q/Ysdr5RliGVgXwVXSg+b/L5hF2oyr6zGQqCB2KMY/0=;
        b=AkxYRpMb2bG6wtJbOl7se9kM7loAFlPo9nKXwzANn98ZPZEpYJoCzrldNxbJrMTZwB
         6aXrPPnpGmY9DKHMqRBbu44hfd9NYYGX4P7QKUkLrfH4n3cCZRdykcpUBoPYcUG25H8x
         fN4uhWuczat8oRjvGQErFPXtseWUnvGs+/YHLgBZMgvVCUJ4bPh8Eu2jOhDv3JkOZpOg
         NXWOGECQ0Myr2XyfJl5S2AWlDLdywdN0V7VrLH/sfwG1+fy6G9vbPGPvSXtuGAybieyL
         rEgHBkhWR7BHK2L2zvNzmr9BxiE7cc13J3C762TycVnfI2kZxTLe1rergL5qgOiBJrkJ
         uJWg==
X-Gm-Message-State: AJIora8T6zJXXrEdFHn9KRcbBRr8Fl+j8h8Ms7GfaQK60lleiiQXw9nD
        93iBS+jLHDQcxcjxGjlM9iowRkHz7qKWVlqR
X-Google-Smtp-Source: AGRyM1u05DCuy6hb+9IHu6cKxh1K8K1/HBMfJdJL6jrelhVl7rWTNZ6JKxlWbjhV8dhhwgGgyCTfHg==
X-Received: by 2002:a17:906:9c82:b0:6e1:2c94:1616 with SMTP id fj2-20020a1709069c8200b006e12c941616mr41388062ejc.64.1657149552863;
        Wed, 06 Jul 2022 16:19:12 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id g4-20020a170906868400b006fee98045cdsm18434844ejx.10.2022.07.06.16.19.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 16:19:11 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id o4so24014388wrh.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 16:19:11 -0700 (PDT)
X-Received: by 2002:adf:f90d:0:b0:20c:de32:4d35 with SMTP id
 b13-20020adff90d000000b0020cde324d35mr38633425wrr.583.1657149550898; Wed, 06
 Jul 2022 16:19:10 -0700 (PDT)
MIME-Version: 1.0
References: <1657135928-31195-1-git-send-email-quic_khsieh@quicinc.com>
In-Reply-To: <1657135928-31195-1-git-send-email-quic_khsieh@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 6 Jul 2022 16:18:58 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vx7LAXuUZjvgZZejPh7DvBinVbjNpOddFrL1xtHJMnjw@mail.gmail.com>
Message-ID: <CAD=FV=Vx7LAXuUZjvgZZejPh7DvBinVbjNpOddFrL1xtHJMnjw@mail.gmail.com>
Subject: Re: [PATCH v4] drm/msm/dp: make eDP panel as the first connected connector
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Stephen Boyd <swboyd@chromium.org>,
        Vinod Koul <vkoul@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Abhinav Kumar (QUIC)" <quic_abhinavk@quicinc.com>,
        "Aravind Venkateswaran (QUIC)" <quic_aravindh@quicinc.com>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        freedreno <freedreno@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jul 6, 2022 at 12:32 PM Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
>
> Some userspace presumes that the first connected connector is the main
> display, where it's supposed to display e.g. the login screen. For
> laptops, this should be the main panel.
>
> This patch call drm_helper_move_panel_connectors_to_head() after
> drm_bridge_connector_init() to make sure eDP stay at head of
> connected connector list. This fixes unexpected corruption happen
> at eDP panel if eDP is not placed at head of connected connector
> list.
>
> Changes in v2:
> -- move drm_helper_move_panel_connectors_to_head() to
>                 dpu_kms_drm_obj_init()
>
> Changes in v4:
> -- move drm_helper_move_panel_connectors_to_head() to msm_drm_init()
>
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>  drivers/gpu/drm/msm/msm_drv.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Douglas Anderson <dianders@chromium.org>

NOTE: I tested this upstream with these two trees merged together:

msm-next: 1ff1da40d6fc Merge branches 'msm-next-lumag-core'...
qcom/for-next: d014f9463260 Merge branches 'arm64-for-5.20'...

...plus a revert to make things boot again [1]. I booted this on a
sc7280-herobrine running Chrome OS. When I do this, the original
reported glitching is fixed (yay) and I think we should land it.

...but I'm not convinced that all glitching is fixed by this. In
particular I've occasionally seen an underrun at bootup (blue color)
followed by a temporary glitch. With the above plus ${SUBJECT} patch I
also reliably see a glitch on my external (DP) display every time I
plug in. I don't see either on the downstream Chrome OS kernel,
though...

[1] https://lore.kernel.org/r/20220706144706.1.I48f35820bf3670d54940110462555c2d0a6d5eb2@changeid
