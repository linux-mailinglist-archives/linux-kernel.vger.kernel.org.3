Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36C650197B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 19:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242141AbiDNREu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 13:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242271AbiDNRDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 13:03:44 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410DFA6E37
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 09:40:11 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id t11so11080906eju.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 09:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sMT54nF1SMSOMqMYCZmgi8xN7eOCKvvK35fHMg+oHcc=;
        b=HSJ9f0E6ehW76H552h3PgIs14xn6y6HwbJiaJF0oa3iCxtOPhzg/D2glMXnfa5V7zs
         2ydypI+2zeXrr0g9B4UWfLJdZ34Qn5AYYeaah1j314JBM4begDsciAwS3BG0HazrznFc
         uoig8EHfEzKP8qEFJ3HrxOKUff/q+RBzzM2nM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sMT54nF1SMSOMqMYCZmgi8xN7eOCKvvK35fHMg+oHcc=;
        b=7KjSucgZ/T9KJ6fDIMDlcPXyGVfqkFKAxBNUCIfuihuIMRJvWGC5SqSIjhta9wdZNZ
         VALcd8GrBWrqK7OaAOD3Wzq0h0KwSieJCwQzs7sDyo/gExmNIE1M24Cus4IHcapf00Cc
         r+h1F7J1vd+I2X6iQdNpMNmHKpYOypQYi3ewi6sB0uhkzlPUswliWu9dJBOsYnHxFJXO
         aFwGPPYvbIU1iW6ntL5rcnK0VmTkvxp9rv8mVIPP7biyTfhEUhvqbiubIdbrnK8lY/cA
         iVXq1bqBNP5pqd4ayf0lggejmSzyi/kcCCYEtOyZBjBN2L5PgoTCEbAXc4lkUB+rWX6n
         dORg==
X-Gm-Message-State: AOAM533x6IrBGeabeCZNQCih7doNiZc5/zBnBC7BXXX33uXK+mBVSJRV
        cIR9T8SOSB6wxgNrqLj794ZjLuD1oSBb1ewr
X-Google-Smtp-Source: ABdhPJzC6Zdo9Y60vx6ibu7VbqFg8+p0ARmmB6yVy2I1t+DgFT6S2zrBGAWizHck8OAKsCMNKxv9vg==
X-Received: by 2002:a17:907:97c5:b0:6da:c285:44f5 with SMTP id js5-20020a17090797c500b006dac28544f5mr3092947ejc.208.1649954409429;
        Thu, 14 Apr 2022 09:40:09 -0700 (PDT)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id kw3-20020a170907770300b006b2511ea97dsm784844ejc.42.2022.04.14.09.40.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 09:40:06 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id c7so7756580wrd.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 09:40:05 -0700 (PDT)
X-Received: by 2002:a5d:64ce:0:b0:208:fff6:22cb with SMTP id
 f14-20020a5d64ce000000b00208fff622cbmr2751540wri.301.1649954404806; Thu, 14
 Apr 2022 09:40:04 -0700 (PDT)
MIME-Version: 1.0
References: <1649938766-6768-1-git-send-email-quic_sbillaka@quicinc.com> <1649938766-6768-4-git-send-email-quic_sbillaka@quicinc.com>
In-Reply-To: <1649938766-6768-4-git-send-email-quic_sbillaka@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 14 Apr 2022 09:39:52 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wv57p-A=zniSKZYStRSPby7vSE-SqZQ-JVuQsO+MbK+A@mail.gmail.com>
Message-ID: <CAD=FV=Wv57p-A=zniSKZYStRSPby7vSE-SqZQ-JVuQsO+MbK+A@mail.gmail.com>
Subject: Re: [PATCH v7 3/4] drm/msm/dp: wait for hpd high before aux transaction
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
> The source device should ensure the sink is ready before proceeding to
> read the sink capability or perform any aux transactions. The sink
> will indicate its readiness by asserting the HPD line. The controller
> driver needs to wait for the hpd line to be asserted by the sink before
> it performs any aux transactions.
>
> The eDP sink is assumed to be always connected. It needs power from the
> source and its HPD line will be asserted only after the panel is powered
> on. The panel power will be enabled from the panel-edp driver and only
> after that, the hpd line will be asserted.
>
> Whereas for DP, the sink can be hotplugged and unplugged anytime. The hpd
> line gets asserted to indicate the sink is connected and ready. Hence
> there is no need to wait for the hpd line to be asserted for a DP sink.
>
> Signed-off-by: Sankeerth Billakanti <quic_sbillaka@quicinc.com>
> ---

It might be worth mentioning "after the cut" that we may eventually
end up changing the rules if people like my proposal [1]. However,
what your code is doing here for eDP is correct as things are
currently intended to work and it would make sense to land it while we
debate about whether we want to add the is_hpd_asserted() callback
like my patch does.

[1] https://lore.kernel.org/r/20220408193536.RFC.3.Icf57bb12233a47727013c6ab69eebf803e22ebc1@changeid/


> Changes in v7:
>   - add a comment to say why the wait si done for eDP
>   - correct the commit text
>
> Changes in v6:
>   - Wait for hpd high only for eDP
>   - Split into smaller patches
>
>  drivers/gpu/drm/msm/dp/dp_aux.c     | 21 ++++++++++++++++++++-
>  drivers/gpu/drm/msm/dp/dp_aux.h     |  3 ++-
>  drivers/gpu/drm/msm/dp/dp_catalog.c | 13 +++++++++++++
>  drivers/gpu/drm/msm/dp/dp_catalog.h |  1 +
>  drivers/gpu/drm/msm/dp/dp_display.c |  2 +-
>  5 files changed, 37 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/dp/dp_aux.c b/drivers/gpu/drm/msm/dp/dp_aux.c
> index 6d36f63..cf0739f 100644
> --- a/drivers/gpu/drm/msm/dp/dp_aux.c
> +++ b/drivers/gpu/drm/msm/dp/dp_aux.c
> @@ -36,6 +36,7 @@ struct dp_aux_private {
>         bool initted;
>         u32 offset;
>         u32 segment;
> +       bool is_edp;

Kinda nitty, but can you put it next to the other booleans? This will
help with structure packing.


>         struct drm_dp_aux dp_aux;
>  };
> @@ -337,6 +338,22 @@ static ssize_t dp_aux_transfer(struct drm_dp_aux *dp_aux,
>                 goto exit;
>         }
>
> +       /*
> +        * For eDP it's important to give a reasonably long wait here for HPD
> +        * to be asserted. This is because the panel driver may have _just_
> +        * turned on the panel and then tried to do an AUX transfer. The panel
> +        * driver has no way of knowing when the panel is ready, so it's up
> +        * to us to wait. For DP we never get into this situation so let's
> +        * avoid ever doing the extra long wait for DP.
> +        */
> +       if (aux->is_edp) {
> +               ret = dp_catalog_aux_wait_for_hpd_connect_state(aux->catalog);
> +               if (ret) {
> +                       DRM_DEBUG_DP("Panel not ready for aux transactions\n");
> +                       goto exit;
> +               }
> +       }
> +
>         dp_aux_update_offset_and_segment(aux, msg);
>         dp_aux_transfer_helper(aux, msg, true);
>
> @@ -491,7 +508,8 @@ void dp_aux_unregister(struct drm_dp_aux *dp_aux)
>         drm_dp_aux_unregister(dp_aux);
>  }
>
> -struct drm_dp_aux *dp_aux_get(struct device *dev, struct dp_catalog *catalog)
> +struct drm_dp_aux *dp_aux_get(struct device *dev, struct dp_catalog *catalog,
> +                               bool is_edp)

nit: I think indentation rules for this file are that the type of the
argument for the 2nd line should line up right under the 1st. Thus you
should delete one tab character and insert 6 spaces before the "bool".

Similar in other places, like your header file.


Stuff above is all nits and this looks right to me. I'm happy with:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
