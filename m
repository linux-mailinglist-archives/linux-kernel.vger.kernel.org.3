Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA384EE4C5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 01:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242886AbiCaXbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 19:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiCaXbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 19:31:15 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B8B154496
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 16:29:26 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id w25so1011458edi.11
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 16:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=avSGMtSz4ymacyl7GdMhd9/3YRX9NuWMZI8WC7CMKV0=;
        b=RB7qN+1nHYmA5Ki3RYQ5cOwMq+8+ec2V05lMPrIjOE0+2UCFYYM2uKN8wEUMfprHJd
         ber657p1Z3CwyukZldarn6sF9qZcZhzTh9Y/Nr6kgjdUGxUXyW3xmTRVYJOBuVfSKLTL
         qWjEu993x0lx2WpR1RPuyTpar5XfsrMV/EV58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=avSGMtSz4ymacyl7GdMhd9/3YRX9NuWMZI8WC7CMKV0=;
        b=UsgXDGxfFrdBgfFGKTjws3SgxavrvFc3V1tB+nuZVRuGJ4oUAf9d2Y2QYoldXDO5w2
         5UqyJels4vvuXWZ6SmYO3x0YNH/JLXqLI6wFZhXCM96+GUpvE4smkmI9JWSqhiCF1cqt
         vMlG+kHSQlKcKhVKVbp7T7Cogv1krlIjdssFD5fp+uJtxRT3u+DC9a3cejdukBOpc2St
         bEIF4oh8MVUxKdmoQ/H1GsJcxAu6SSOXyHW7UFN7dxZgzXfDP3xZiSGNGSR9/ruITlhG
         4vhwwksuGVe/Z/tO38aFkMs7ENgvZs07EcXgTm1ZJFomeNKhMTUgqtjU8gXGb3jUI3Hl
         ca9A==
X-Gm-Message-State: AOAM5332ZUZ+3Sr3E2Lrt9CEaAx9Y74aJmY2nxeKyXPqty+nBco+LjDX
        Y5lQwJgVNJMUpzm6H15XWx/xnDC8zCiA/Gs8bX0=
X-Google-Smtp-Source: ABdhPJzqzlWhIPtyuMGXAqIOnzNSY2V6NNL2BS6IXYbilLo9JjqfW0DrHWwL803ueMv9syqj66fqTA==
X-Received: by 2002:aa7:cd81:0:b0:410:d64e:aa31 with SMTP id x1-20020aa7cd81000000b00410d64eaa31mr18763298edv.167.1648769364473;
        Thu, 31 Mar 2022 16:29:24 -0700 (PDT)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id i11-20020a50fd0b000000b0041936bc0f7esm389398eds.52.2022.03.31.16.29.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 16:29:24 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id l7-20020a05600c1d0700b0038c99618859so2541773wms.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 16:29:23 -0700 (PDT)
X-Received: by 2002:a05:600c:2e02:b0:38c:8390:d8ca with SMTP id
 o2-20020a05600c2e0200b0038c8390d8camr6452311wmf.15.1648768957118; Thu, 31 Mar
 2022 16:22:37 -0700 (PDT)
MIME-Version: 1.0
References: <1648656179-10347-1-git-send-email-quic_sbillaka@quicinc.com> <1648656179-10347-3-git-send-email-quic_sbillaka@quicinc.com>
In-Reply-To: <1648656179-10347-3-git-send-email-quic_sbillaka@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 31 Mar 2022 16:22:24 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UtnNTWmMPYPkSJ5qceWspXtZ+hL6UTgSn=rHzd39Y42g@mail.gmail.com>
Message-ID: <CAD=FV=UtnNTWmMPYPkSJ5qceWspXtZ+hL6UTgSn=rHzd39Y42g@mail.gmail.com>
Subject: Re: [PATCH v6 2/8] drm/msm/dp: wait for hpd high before aux transaction
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
        quic_aravindh@quicinc.com
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

On Wed, Mar 30, 2022 at 9:03 AM Sankeerth Billakanti
<quic_sbillaka@quicinc.com> wrote:
>
> The source device should ensure the sink is ready before proceeding to
> read the sink capability or performing any aux transactions. The sink

s/performing/perform

> will indicate its readiness by asserting the HPD line. The controller
> driver needs to wait for the hpd line to be asserted by the sink before
> performing any aux transactions.
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
>
> Changes in v6:
>   - Wait for hpd high only for eDP
>   - Split into smaller patches
>
>  drivers/gpu/drm/msm/dp/dp_aux.c     | 13 ++++++++++++-
>  drivers/gpu/drm/msm/dp/dp_aux.h     |  3 ++-
>  drivers/gpu/drm/msm/dp/dp_catalog.c | 13 +++++++++++++
>  drivers/gpu/drm/msm/dp/dp_catalog.h |  1 +
>  drivers/gpu/drm/msm/dp/dp_display.c |  3 ++-
>  5 files changed, 30 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/dp/dp_aux.c b/drivers/gpu/drm/msm/dp/dp_aux.c
> index 6d36f63..a217c80 100644
> --- a/drivers/gpu/drm/msm/dp/dp_aux.c
> +++ b/drivers/gpu/drm/msm/dp/dp_aux.c
> @@ -36,6 +36,7 @@ struct dp_aux_private {
>         bool initted;
>         u32 offset;
>         u32 segment;
> +       bool is_edp;
>
>         struct drm_dp_aux dp_aux;
>  };
> @@ -337,6 +338,14 @@ static ssize_t dp_aux_transfer(struct drm_dp_aux *dp_aux,
>                 goto exit;
>         }
>
> +       if (aux->is_edp) {

Adding a comment about _why_ you're doing this just for eDP would
probably be a good idea. Like maybe:

/*
 * For eDP it's important to give a reasonably long wait here for HPD
 * to be asserted. This is because the panel driver may have _just_
 * turned on the panel and then tried to do an AUX transfer. The panel
 * driver has no way of knowing when the panel is ready, so it's up
 * to us to wait. For DP we never get into this situation so let's
 * avoid ever doing the extra long wait for DP.
 */


> @@ -491,7 +500,8 @@ void dp_aux_unregister(struct drm_dp_aux *dp_aux)
>         drm_dp_aux_unregister(dp_aux);
>  }
>
> -struct drm_dp_aux *dp_aux_get(struct device *dev, struct dp_catalog *catalog)
> +struct drm_dp_aux *dp_aux_get(struct device *dev, struct dp_catalog *catalog,
> +                               bool is_edp)

nit: I think your indentation of the 2nd line isn't quite right.


> diff --git a/drivers/gpu/drm/msm/dp/dp_aux.h b/drivers/gpu/drm/msm/dp/dp_aux.h
> index 82afc8d..c99aeec 100644
> --- a/drivers/gpu/drm/msm/dp/dp_aux.h
> +++ b/drivers/gpu/drm/msm/dp/dp_aux.h
> @@ -16,7 +16,8 @@ void dp_aux_init(struct drm_dp_aux *dp_aux);
>  void dp_aux_deinit(struct drm_dp_aux *dp_aux);
>  void dp_aux_reconfig(struct drm_dp_aux *dp_aux);
>
> -struct drm_dp_aux *dp_aux_get(struct device *dev, struct dp_catalog *catalog);
> +struct drm_dp_aux *dp_aux_get(struct device *dev, struct dp_catalog *catalog,
> +                               bool is_edp);

nit: I think your indentation of the 2nd line isn't quite right.


Things are pretty much nits, so FWIW:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
