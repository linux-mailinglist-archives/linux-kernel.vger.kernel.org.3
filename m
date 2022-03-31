Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDBF4EE4CC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 01:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243049AbiCaXdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 19:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238019AbiCaXd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 19:33:29 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE9624EDA4
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 16:31:41 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id s13so1770674ljd.5
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 16:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oU/P0lUIzx1uZfbuXoLmvC/k7etlrfD8HbND/4uBtMs=;
        b=CVm3r8sEiJHudIn3wBe5psgjEjOXEvg7kAXV5xw19t+3DbObpkYUHppzcz6qWIyEKC
         iD+uGmLJdXzgNCcEVX3/o2rL3pH35aBBGYvKh1WC1iiWOWhQglndY1DyhfDoBvDHciUT
         HKdhiizGnGLfo9pL1ZqNneKf5bIxKreY/JwCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oU/P0lUIzx1uZfbuXoLmvC/k7etlrfD8HbND/4uBtMs=;
        b=cY9fPdlH5Axoq7pt/cjBXPdulyMUr4TUth02xpWwGxFCm2wXVzfB3VqbdrMDne0PI4
         aYS8urXf/guuxkV/oD3Kq5uQ1QFZxPcwuMz05mVlj4JdLCmYfhtizaoLzHKK/MuBUGWw
         SHb5yXzq+c/i7r6Yfba6dJMD86hTeVFuFjNHq6q4rMuA99KJohb7vDtEpIkav3f5XfAh
         2x+6wS2JIvAKg8N1ezHtiWR35OkIAsyOC/2dISWTpbx9OfoSKeFkk2jxuQ8huUjqZfkl
         W896EhFU+GVvUG7KQquu8YCVQ8Demkze1u4VH6INSmhf+a1QjSnXgpzkcOagNQIEUjNS
         ETPg==
X-Gm-Message-State: AOAM530QIxSlMuyutpuRXIfxkhhO1t0fnP7ntInODIMCCo+mfhn6Aepc
        qXDXxrAR5fQOnYiTP2P7H0AQBaJIdUZR8RBOdyg=
X-Google-Smtp-Source: ABdhPJwM8hshitALuFrHoINGWdqe4cZKb4Jjdq+xTJlsXsSihNX3+OEueIyZd+afamDKCYiOaNk53w==
X-Received: by 2002:a2e:8610:0:b0:249:7bc4:bbb8 with SMTP id a16-20020a2e8610000000b002497bc4bbb8mr12028763lji.370.1648769499469;
        Thu, 31 Mar 2022 16:31:39 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id z13-20020a195e4d000000b0044a49605b88sm70888lfi.50.2022.03.31.16.31.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 16:31:39 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id 5so1910476lfp.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 16:31:38 -0700 (PDT)
X-Received: by 2002:a5d:4491:0:b0:203:f63a:e89b with SMTP id
 j17-20020a5d4491000000b00203f63ae89bmr5618171wrq.342.1648769032444; Thu, 31
 Mar 2022 16:23:52 -0700 (PDT)
MIME-Version: 1.0
References: <1648656179-10347-1-git-send-email-quic_sbillaka@quicinc.com> <1648656179-10347-8-git-send-email-quic_sbillaka@quicinc.com>
In-Reply-To: <1648656179-10347-8-git-send-email-quic_sbillaka@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 31 Mar 2022 16:23:40 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V92j=yEoaM4REO6ws=AXpBjM6zWwBtZ8SbPiFd2cu3yw@mail.gmail.com>
Message-ID: <CAD=FV=V92j=yEoaM4REO6ws=AXpBjM6zWwBtZ8SbPiFd2cu3yw@mail.gmail.com>
Subject: Re: [PATCH v6 7/8] drm/msm/dp: Support edp/dp without hpd
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

On Wed, Mar 30, 2022 at 9:04 AM Sankeerth Billakanti
<quic_sbillaka@quicinc.com> wrote:
>
> Some eDP sinks or platform boards will not support hpd.
> This patch adds support for those cases.

You could say more, like:

If we're not using HPD then _both_ the panel node and the eDP
controller node will have "no-hpd". This tells the eDP panel code to
hardcode the maximum possible delay for a panel to power up and tells
the eDP driver that it should continue to do transfers even if HPD
isn't asserted.


> Signed-off-by: Sankeerth Billakanti <quic_sbillaka@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_catalog.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.c b/drivers/gpu/drm/msm/dp/dp_catalog.c
> index 1809ce2..8f1fc71 100644
> --- a/drivers/gpu/drm/msm/dp/dp_catalog.c
> +++ b/drivers/gpu/drm/msm/dp/dp_catalog.c
> @@ -244,10 +244,17 @@ void dp_catalog_aux_update_cfg(struct dp_catalog *dp_catalog)
>
>  int dp_catalog_aux_wait_for_hpd_connect_state(struct dp_catalog *dp_catalog)
>  {
> -       u32 state;
> +       u32 state, hpd_en;
>         struct dp_catalog_private *catalog = container_of(dp_catalog,
>                                 struct dp_catalog_private, dp_catalog);
>
> +       hpd_en = dp_read_aux(catalog, REG_DP_DP_HPD_CTRL);
> +       hpd_en &= DP_DP_HPD_CTRL_HPD_EN;
> +
> +       /* no-hpd case */
> +       if (!hpd_en)
> +               return 0;
> +
>         /* poll for hpd connected status every 2ms and timeout after 500ms */
>         return readl_poll_timeout(catalog->io->dp_controller.aux.base +
>                                 REG_DP_DP_HPD_INT_STATUS,
> @@ -586,8 +593,10 @@ void dp_catalog_ctrl_hpd_config(struct dp_catalog *dp_catalog)
>         reftimer |= DP_DP_HPD_REFTIMER_ENABLE;
>         dp_write_aux(catalog, REG_DP_DP_HPD_REFTIMER, reftimer);
>
> -       /* Enable HPD */
> -       dp_write_aux(catalog, REG_DP_DP_HPD_CTRL, DP_DP_HPD_CTRL_HPD_EN);
> +       /* Enable HPD if supported*/
> +       if (!of_property_read_bool(catalog->dev->of_node, "no-hpd"))

I don't think this is a particularly lightweight operation. It's
literally iterating through all of our device tree properties and
doing string compares on them. ...but this function is called somewhat
often, isn't it? It feels like the kind of thing that should happen at
probe time and be stored in a boolean.

...and then you can use that same boolean in
dp_catalog_aux_wait_for_hpd_connect_state() rather than reading the
register value, right?


-Doug
