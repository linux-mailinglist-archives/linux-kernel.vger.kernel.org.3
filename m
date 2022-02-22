Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB8644C0460
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 23:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236015AbiBVWKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 17:10:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbiBVWKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 17:10:47 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B130512D231
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 14:10:21 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id i11so38630066eda.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 14:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MwFKzwhh8vOvVeS07pTWz4ZTdQ5Z+NLOUhpyVBv4D9Q=;
        b=O/jITcbrb5aoH7sPwYaBWxEd+YJ1x5KXbkQkrtCB64fkBBeXrwXPwYjpNDLLVqLhLE
         6P0xsF4mDd7F1fKigupRlFmDpfR0WeyGmbS0FOt+X0dNG1Hek8yTglcMvfFxiWjE0hib
         JI1CvKC/XX+jb6fFHdB6lGrJYWiPMqlROrssQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MwFKzwhh8vOvVeS07pTWz4ZTdQ5Z+NLOUhpyVBv4D9Q=;
        b=sm1qJeVYpMMhf9BwsMFWavFk+0UKcInEmIFYSVJIFos2yYjP2q1TbR9wrVMw+63oKT
         ppK5D7hVXmLJN0DYnhEp1nMnXwrp6iAkRZuYp5IfBYNpobYfj6+9aMNo30rwerrrtdTr
         aGMUQqemWElSOKRm6ONtDbXZay0NyXXM5O2SsggLQX4MtNS2ThqnP7A7hxc/T9gfxvAL
         IBMScc1UiuEhTXWUe9M5VvbTXq1eh10RuQG/Vvp/Lusjztc7ypd+2QL60OxqsMi2qkPU
         EXWRPwDgVxpbqeNxJJqWy2ghrb4sjVmVSojCRsLPe/gTj2FKLWA8vu96R08fBamrmy0K
         2Klw==
X-Gm-Message-State: AOAM5328OWyjRIU9MASCzZo1r9zb33oaHpd32SgsssUyRw7WdH+8cHT/
        t3Md0cuPRmpY8sAq451k6N04X0MncEH/e+tqhjA=
X-Google-Smtp-Source: ABdhPJyU4wIog87s6zJsJPyX64yatyU89mkAeGsyEQHKwG5ZzGrOuD5r3e3T+d8iBPoO/dFhAv/TtA==
X-Received: by 2002:a50:ba8e:0:b0:410:a99c:4c3b with SMTP id x14-20020a50ba8e000000b00410a99c4c3bmr29274671ede.427.1645567820027;
        Tue, 22 Feb 2022 14:10:20 -0800 (PST)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id j9sm6741875ejo.87.2022.02.22.14.10.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 14:10:18 -0800 (PST)
Received: by mail-wm1-f47.google.com with SMTP id y5so2051250wmi.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 14:10:18 -0800 (PST)
X-Received: by 2002:a05:600c:228e:b0:37c:2eef:7bf with SMTP id
 14-20020a05600c228e00b0037c2eef07bfmr4903688wmf.73.1645567818110; Tue, 22 Feb
 2022 14:10:18 -0800 (PST)
MIME-Version: 1.0
References: <20220217144136.v3.1.I773a08785666ebb236917b0c8e6c05e3de471e75@changeid>
In-Reply-To: <20220217144136.v3.1.I773a08785666ebb236917b0c8e6c05e3de471e75@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 22 Feb 2022 14:10:04 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XmqG13QuyxpcS9sN2UCtPWDyhD_T1xjkDf8tp-_bSOWw@mail.gmail.com>
Message-ID: <CAD=FV=XmqG13QuyxpcS9sN2UCtPWDyhD_T1xjkDf8tp-_bSOWw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] drm/bridge: analogix_dp: Grab runtime PM reference
 for DP-AUX
To:     Brian Norris <briannorris@chromium.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Sean Paul <sean@poorly.run>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        "# 4.0+" <stable@vger.kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Feb 17, 2022 at 2:42 PM Brian Norris <briannorris@chromium.org> wrote:
>
> If the display is not enable()d, then we aren't holding a runtime PM
> reference here. Thus, it's easy to accidentally cause a hang, if user
> space is poking around at /dev/drm_dp_aux0 at the "wrong" time.
>
> Let's get a runtime PM reference, and check that we "see" the panel.
> Don't force any panel power-up, etc., because that can be intrusive, and
> that's not what other drivers do (see
> drivers/gpu/drm/bridge/ti-sn65dsi86.c and
> drivers/gpu/drm/bridge/parade-ps8640.c.)
>
> Fixes: 0d97ad03f422 ("drm/bridge: analogix_dp: Remove duplicated code")
> Cc: <stable@vger.kernel.org>
> Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
>
> Changes in v3:
> - Avoid panel power-up; just check for HPD state, and let the rest
>   happen "as-is" (e.g., time out, if the caller hasn't prepared things
>   properly)
>
> Changes in v2:
> - Fix spelling in Subject
> - DRM_DEV_ERROR() -> drm_err()
> - Propagate errors from un-analogix_dp_prepare_panel()
>
>  drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>


-Doug
