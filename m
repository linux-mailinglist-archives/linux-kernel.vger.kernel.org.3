Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB4950A3FD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 17:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390043AbiDUP0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 11:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232403AbiDUP0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 11:26:48 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A7A42A14
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 08:23:58 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id i27so10734613ejd.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 08:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rWHrkI/plHQsKHEeS5/0Rby949Lxiklh2NSSrLYMtUM=;
        b=ZhforE7iVW5RAp7ovyVF911uWEZSiPFqpwhnpmO8NbXTjh/OEabvdgvFeeGy86Iyjx
         ARnVvz6IBOS3JkLh8eCwYpnKjgfkxZmH6+UQBzOY/Gzk7bdYAcEzGeXpg+Nknw4p+8FC
         aqR5gA0GKGWQLbDBgz4ayC70r7I+L74SaskP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rWHrkI/plHQsKHEeS5/0Rby949Lxiklh2NSSrLYMtUM=;
        b=Ffo6HB11niRo6+mum6OAK0HJkG5GfSvBUC+Q7XIRc8EOkrPR4LAiGnHe7wsUsb1JPB
         RyP1P3efZU+jlMgCICBTp0qMtizpHpmSVmvjORvd16ApA1V6wHAwCGYn9uMJI1ncjPVw
         g49dWw3LWenlMMuBg1SSzus3JX52MZo/nJ1o77QefxaDsb3ytvvvOS1SWatLkZwGpd8A
         hkUcstg0MbvNAPxE4YoIHws20V3zmnCuE88wyLVYH8mce+IT0FNJ5BpkOX87Snl705eL
         yfpXOxeH1rPyBJBElbYC4PkoCbCtWEPzMIL+QA326DeVVjEXEhI42ZNqL4jkk+Lk4C9w
         RAfw==
X-Gm-Message-State: AOAM533oxUPnG+EMJ3psz5AzcqFqRzbQqa8lC6fWiKJzc100lB0N+9Ty
        mx+zdEg9tnM2oe1JIc95/WAyLTNhUxb24cDL
X-Google-Smtp-Source: ABdhPJzOQmORuAoQUL9XBw37LyELOacnKdZYelNNiaETpXMIe4dYKl9CO6QTHtvI5lvHkynixzgjbA==
X-Received: by 2002:a17:906:6a13:b0:6f0:26f3:fd3e with SMTP id qw19-20020a1709066a1300b006f026f3fd3emr88351ejc.190.1650554636311;
        Thu, 21 Apr 2022 08:23:56 -0700 (PDT)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id x18-20020a170906b09200b006e8baac3a09sm7956942ejy.157.2022.04.21.08.23.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 08:23:55 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id u3so7209969wrg.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 08:23:55 -0700 (PDT)
X-Received: by 2002:a05:6000:1105:b0:20a:80b4:bcaf with SMTP id
 z5-20020a056000110500b0020a80b4bcafmr166285wrw.679.1650554634333; Thu, 21 Apr
 2022 08:23:54 -0700 (PDT)
MIME-Version: 1.0
References: <1650551811-24319-1-git-send-email-quic_sbillaka@quicinc.com> <1650551811-24319-3-git-send-email-quic_sbillaka@quicinc.com>
In-Reply-To: <1650551811-24319-3-git-send-email-quic_sbillaka@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 21 Apr 2022 08:23:41 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UVmUG0t-8wFXT-NT1-naojeJ_gcd8eEVr96AnMos0m4A@mail.gmail.com>
Message-ID: <CAD=FV=UVmUG0t-8wFXT-NT1-naojeJ_gcd8eEVr96AnMos0m4A@mail.gmail.com>
Subject: Re: [PATCH v8 2/4] drm/msm/dp: Support only IRQ_HPD and REPLUG
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
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Apr 21, 2022 at 7:37 AM Sankeerth Billakanti
<quic_sbillaka@quicinc.com> wrote:
>
> The panel-edp enables the eDP panel power during probe, get_modes
> and pre-enable. The eDP connect and disconnect interrupts for the eDP/DP
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
> Changes in v8:
>   - add comment explaining the interrupt status return
>
> Changes in v7:
>   - reordered the patch in the series
>   - modified the return statement for isr
>   - connector check modified to just check for eDP
>
>  drivers/gpu/drm/msm/dp/dp_catalog.c | 18 ++++++++++++------
>  drivers/gpu/drm/msm/dp/dp_display.c | 22 +++++++++++++++++++++-
>  2 files changed, 33 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.c b/drivers/gpu/drm/msm/dp/dp_catalog.c
> index fac815f..3a298e9 100644
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
> @@ -599,13 +595,23 @@ u32 dp_catalog_hpd_get_intr_status(struct dp_catalog *dp_catalog)
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
> +       /*
> +        * REG_DP_DP_HPD_INT_STATUS reports the status of all interrupts
> +        * irrespective of their masked status. The HW interrupt will not be
> +        * generated if an interrupt is masked. However, the interrupt status
> +        * bit in the register will still be set. The eDP controller driver
> +        * masks the plug and unplug interrupts unlike DP controller which
> +        * unmasks all the interrupts. So, do not report the status of the
> +        * masked interrupts.
> +        */
> +       return isr & (mask | ~DP_DP_HPD_INT_MASK);

What's still missing in your comments is why you aren't just doing
"return isr & mask;". In other words, why is the API for HPD bits
different from the API for non-HPD bits? What code out there wants to
know about non-HPD interrupts even if they are masked?

Actually, thinking about this more, my preference would be this:

a) Rename the existing function to dp_catalog_hpd_get_intr_status_raw()

b) Create a new function called dp_catalog_hpd_get_intr_status() whose
implementation is:

  return dp_catalog_hpd_get_intr_status_raw() & mask;

Then any callers who care about the raw status can be changed to call
dp_catalog_hpd_get_intr_status_raw(). If no callers need
dp_catalog_hpd_get_intr_status_raw() then you don't actually need to
create this function.

If you make that change then all of a sudden the API isn't weird/wonky
and you can just get rid of the comment I asked you to add.


-Doug
