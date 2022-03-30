Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6822C4ECF7C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 00:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351508AbiC3WS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 18:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237444AbiC3WSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 18:18:20 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0830943EFA
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 15:16:35 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id s11so19702645qtc.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 15:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v5V3kvEJbyi9F3MHeceyPdx3c1Bu5E1z1aG7KQioCtA=;
        b=Rn4E6fpfodZzBNI9CHionnRmbtXxDFsoLCGl9rf4OHI2zq0q0y9+g6jo5yJe7jn4Xo
         K3XwMD4lfvd2o/Oag+klWSmmknJdJpYjbPccWmsbEbxdhbKRfqy84do86ezAT8PQCBhE
         FZcg4szpZtfucxmQaFZ8Z/jX+Yx6AWg/E253ow4IFaxbxHTEuh2EGe8TUKp9kMrj+dSC
         jTnAAVmVp27czFaUnlMNh8WNEYLAr55F4wj0CcO0Sh3aj3nHpFVXZlQY+ICacfQHKwb3
         IifLZ+eSWVzv9kZ9ilrXlkgtn5UYCP03Li2p4l3d3UoQ394uqnTb6oqWHTG/y+zD0vrh
         52dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v5V3kvEJbyi9F3MHeceyPdx3c1Bu5E1z1aG7KQioCtA=;
        b=QTjb01qOtRXa98knBfX/MLVx9t8nAdLktAsYHROTMBPoFq5vkfOthvNtNEMBIetVI5
         B0D+nJBaAz1MYSV7tnFzxmRI7sgDO44lSvbc0I8nE0BzFkDJ15RPoqeFeFUtH1hqai+x
         XGnEagvcIi0AOloXkwi9OZZIMk0JEeFmHIk6u07iMBRKViEAd7aVTV9kA6x4q206xmz1
         CIbNLu9ddKMnDH105LxZtV82w9zuxHysZqrq6nZFbzaphjN5dT8RZ3LDKdAgoyx+AyW+
         0OJ5v/ZgeGRqaF4RMWihlkecDsrNUZt1aswpC5LhLR8h0z806SigFr6Q2V9ztIUwYfEt
         as8A==
X-Gm-Message-State: AOAM531RZDkJpFXNwBy+j2QfTrXC1x2SWK47J51D+IHBY5m3YmHUztuD
        +uKyRk5d6HglwhUvFwQ3viuyqZ3YfBNpfv/sTeNwmA==
X-Google-Smtp-Source: ABdhPJxsJX49xZHbqWv8eB9xiCa1Z1dl/Fp1c1dn4pZmztEffRMsi66po2a6wqsBsf6w2fFECLcqbpU0iwxo+/WO3MI=
X-Received: by 2002:a05:622a:1314:b0:2e1:d943:c25b with SMTP id
 v20-20020a05622a131400b002e1d943c25bmr1756051qtk.370.1648678594189; Wed, 30
 Mar 2022 15:16:34 -0700 (PDT)
MIME-Version: 1.0
References: <1648656179-10347-1-git-send-email-quic_sbillaka@quicinc.com> <1648656179-10347-5-git-send-email-quic_sbillaka@quicinc.com>
In-Reply-To: <1648656179-10347-5-git-send-email-quic_sbillaka@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 31 Mar 2022 01:16:23 +0300
Message-ID: <CAA8EJprMvik_6xmGt2oZGpDG9FoMtC_ojuw+oTjPLTck4Hu3WA@mail.gmail.com>
Subject: Re: [PATCH v6 4/8] drm/msm/dp: avoid handling masked interrupts
To:     Sankeerth Billakanti <quic_sbillaka@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robdclark@gmail.com,
        seanpaul@chromium.org, swboyd@chromium.org,
        quic_kalyant@quicinc.com, quic_abhinavk@quicinc.com,
        dianders@chromium.org, quic_khsieh@quicinc.com,
        bjorn.andersson@linaro.org, sean@poorly.run, airlied@linux.ie,
        daniel@ffwll.ch, quic_vproddut@quicinc.com,
        quic_aravindh@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Mar 2022 at 19:03, Sankeerth Billakanti
<quic_sbillaka@quicinc.com> wrote:
>
> The interrupt register will still reflect the connect and disconnect
> interrupt status without generating an actual HW interrupt.
> The controller driver should not handle those masked interrupts.
>
> Signed-off-by: Sankeerth Billakanti <quic_sbillaka@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_catalog.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.c b/drivers/gpu/drm/msm/dp/dp_catalog.c
> index 3c16f95..1809ce2 100644
> --- a/drivers/gpu/drm/msm/dp/dp_catalog.c
> +++ b/drivers/gpu/drm/msm/dp/dp_catalog.c
> @@ -608,13 +608,14 @@ u32 dp_catalog_hpd_get_intr_status(struct dp_catalog *dp_catalog)
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
> +       return isr & (DP_DP_HPD_STATE_STATUS_MASK | mask);

I suspect that the logic is inverted here. Shouldn't it be:

return isr & DP_DP_HPD_STATE_STATUS_MASK & mask;

?

>  }
>
>  int dp_catalog_ctrl_get_interrupt(struct dp_catalog *dp_catalog)
> --
> 2.7.4
>


-- 
With best wishes
Dmitry
