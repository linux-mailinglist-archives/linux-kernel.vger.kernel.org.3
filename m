Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5CF501970
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 19:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243044AbiDNREB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 13:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243675AbiDNRDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 13:03:20 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9773A49F99
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 09:39:52 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 21so7125637edv.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 09:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nYg934FepxhPHJYVYrZutxuJmtuv3DcX7+LrwvmwUiI=;
        b=eGFM3ztMn9Emo9AjWCLBFf6FEEMtubNIu4UVefX1GeJ26mF6dhm/kQWOM5JylyVuYl
         AHn+lsZ0Yi4quPDxF8v/hLAKDCzF3fDmkLwshBHfrSsZIyCpo3q5P97DH5qN01gnoVSV
         2s/CAcL2joy6KFQjXDYCrSGLKApreqzCGzpJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nYg934FepxhPHJYVYrZutxuJmtuv3DcX7+LrwvmwUiI=;
        b=43lHCE7vKusTm/XsEK4HZo4anLK+8bnJXeM0eqxvxPYvmLk04Kj7/TECvZvClWtr4U
         2846OSqeV8uHPnEcLDuUjtz/ASDniHKZd7fSxBsUoes3IBTkhG65GQTvK0V6oUO254bT
         4khY9XkwA/fRJSVXow2+M3V9kO0FU59EWvddsYzWjUq+mTVQignCMXbeyIJmZHLNQ/Ay
         A+FMYx/ssoSRUVsyixh92wQVhTx6QGjtzbnEP0+rh17OPhbx0CZ/fTk3VuSZnma1RKR/
         ETXBRg9mjAfOx21UkOOlCEBZL5NWYqbg3Nvw6OiQbjxd5ruj3NcEz8u6hcfSNpHb3MoK
         o8Mg==
X-Gm-Message-State: AOAM531e5pThMXKC1OF7fIHWGZP+/LGKRoIDTZPS7gYh0x+l+APFHRUX
        ZJM4EA3dRSNmq/3iHs5kPcU8A4DZ5kK9ZpPL
X-Google-Smtp-Source: ABdhPJw6WShDi03suRIWIAIHP/pm9U+3Ino57J7025v9wvk84pLDuD+bu3zoMffy4ZtSCb8MagDu5Q==
X-Received: by 2002:a05:6402:1707:b0:41d:9794:6421 with SMTP id y7-20020a056402170700b0041d97946421mr3883033edu.212.1649954390887;
        Thu, 14 Apr 2022 09:39:50 -0700 (PDT)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id f2-20020a50e082000000b0041df731649asm1240677edl.60.2022.04.14.09.39.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 09:39:49 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id ay11-20020a05600c1e0b00b0038eb92fa965so6329059wmb.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 09:39:49 -0700 (PDT)
X-Received: by 2002:a05:600c:502b:b0:38f:f7c6:3609 with SMTP id
 n43-20020a05600c502b00b0038ff7c63609mr3225672wmr.15.1649954388394; Thu, 14
 Apr 2022 09:39:48 -0700 (PDT)
MIME-Version: 1.0
References: <1649938766-6768-1-git-send-email-quic_sbillaka@quicinc.com> <1649938766-6768-3-git-send-email-quic_sbillaka@quicinc.com>
In-Reply-To: <1649938766-6768-3-git-send-email-quic_sbillaka@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 14 Apr 2022 09:39:36 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Uc+qVKH7fAkqtB+Y_jHpWXy5tOABRCN=8TH1bibAp+8Q@mail.gmail.com>
Message-ID: <CAD=FV=Uc+qVKH7fAkqtB+Y_jHpWXy5tOABRCN=8TH1bibAp+8Q@mail.gmail.com>
Subject: Re: [PATCH v7 2/4] drm/msm/dp: Support only IRQ_HPD and REPLUG
 interrupts for eDP
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
> The panel-edp enables the eDP panel power during probe, get_modes
> and enable.

Technically the panel-edp powers on the panel in pre_enable()


> The eDP connect and disconnect interrupts for the eDP/DP
> controller are directly dependent on panel power. As eDP display can be
> assumed as always connected, the controller driver can skip the eDP
> connect and disconnect interrupts. Any disruption in the link status
> will be indicated via the IRQ_HPD interrupts.
>
> So, the eDP controller driver can just enable the IRQ_HPD and replug
> interrupts. The DP controller driver still needs to enable all the
> interrupts.
>
> Signed-off-by: Sankeerth Billakanti <quic_sbillaka@quicinc.com>
> ---
>
> Changes in v7:
>   - reordered the patch in the series
>   - modified the return statement for isr
>   - connector check modified to just check for eDP
>
>  drivers/gpu/drm/msm/dp/dp_catalog.c |  9 +++------
>  drivers/gpu/drm/msm/dp/dp_display.c | 22 +++++++++++++++++++++-
>  2 files changed, 24 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.c b/drivers/gpu/drm/msm/dp/dp_catalog.c
> index fac815f..07f2389 100644
> --- a/drivers/gpu/drm/msm/dp/dp_catalog.c
> +++ b/drivers/gpu/drm/msm/dp/dp_catalog.c
> @@ -569,10 +569,6 @@ void dp_catalog_ctrl_hpd_config(struct dp_catalog *dp_catalog)
>
>         u32 reftimer = dp_read_aux(catalog, REG_DP_DP_HPD_REFTIMER);
>
> -       /* enable HPD plug and unplug interrupts */
> -       dp_catalog_hpd_config_intr(dp_catalog,
> -               DP_DP_HPD_PLUG_INT_MASK | DP_DP_HPD_UNPLUG_INT_MASK, true);
> -
>         /* Configure REFTIMER and enable it */
>         reftimer |= DP_DP_HPD_REFTIMER_ENABLE;
>         dp_write_aux(catalog, REG_DP_DP_HPD_REFTIMER, reftimer);
> @@ -599,13 +595,14 @@ u32 dp_catalog_hpd_get_intr_status(struct dp_catalog *dp_catalog)
>  {
>         struct dp_catalog_private *catalog = container_of(dp_catalog,
>                                 struct dp_catalog_private, dp_catalog);
> -       int isr = 0;
> +       int isr, mask;
>
>         isr = dp_read_aux(catalog, REG_DP_DP_HPD_INT_STATUS);
>         dp_write_aux(catalog, REG_DP_DP_HPD_INT_ACK,
>                                  (isr & DP_DP_HPD_INT_MASK));
> +       mask = dp_read_aux(catalog, REG_DP_DP_HPD_INT_MASK);
>
> -       return isr;
> +       return isr & (mask | ~DP_DP_HPD_INT_MASK);

Please add a comment above this explaining what the goal of the above
statement is. I guess it's something like this, though you might want
to modify it to remove snark and insert the real reason unless you
like being snarky:

  /*
   * Report the raw status of all interrupts (AKA we still report the
   * interrupt as asserted even if it's masked) _except_ for HPD-related.
   * interrupts. We only report HPD-related interrupts if they're
   * unmasked. We do it this way because we thought it would be extra
   * confusing for readers of this code and we were bribed by Mordac to
   * confuse you.  OK, maybe that's not true. We actually do it this way
   * because of <insert your compelling reason here>.
   */

Along the same lines as my comments in patch #1, I don't have a great
feel for exactly when the various HPD bits are enabled / disabled and
it feels like it need to be made super obvious / well documented. That
being said, I'd be OK w/ that happening in the proposed cleanup.


-Doug
