Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B99855A579
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 02:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbiFYAXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 20:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbiFYAX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 20:23:29 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADDD532D5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 17:23:27 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id s124so5641235oia.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 17:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=aM/iH2gWxnXoR4sehLWupEN2NCl54gcxQiHVIQqiXeA=;
        b=XUdqjNBs7l7aNzEdKeTcgl6xsOJP5AbQJTNWTxsogl01wW+lDC4wB0Xt26N/RB/+rq
         JABElLRg7MJ6OGAtiRkQnVe0u96orezmaKZPE59BcfZZBv8pyAvPk30t9bsz+nDinPPC
         dK+MsucwjJtNSvhtWaYtTlcVElPQbB9mTVnLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=aM/iH2gWxnXoR4sehLWupEN2NCl54gcxQiHVIQqiXeA=;
        b=FFC64NssKp9egRlNgA6O6SxoEcR3TG5AhvT+e6ecIjL8C0AET7S+uJnebf6kcNinQL
         v/Zo+3Cs5y8qPDw7j8CZHWqm9YQLKOzRgiRVkRnnplwJwTkRXeUoV4Pvp4MUx/8766gc
         Kba/LvWGWIYcWwTS7aO0RNl6kVvnzVAgwLfS1nXlomkneFLMwrjz8eFH74iuCYw/TcdL
         y2lcdGk/HkBgHzEkW2PZoG38H3bQbztZrMXe6h6Ar7uFG9Z67THkIUNUk7Lu7OTr4ZLM
         ScS6NJb/6r2T/t1lMbld0Qdiln3HXRZIf8idr8u+kWRPppJko96aiNJY15NMrPABo5OX
         Cogw==
X-Gm-Message-State: AJIora/4QoNIMnMb41CDmJDtUffy0vmPEmWsiQTRgNUF7BctAVaZPZXu
        YK1+EfWBCG6qMxqFYGJPX1aDCXjkI+lOOErScqQDLA==
X-Google-Smtp-Source: AGRyM1sudyl98+v08a1GhP8uqyAKl4OiZWmeoxBotLTLTNJ/RuYkbkU3l7KlHSFvKfOhbiTH7WhlpREVG+SjVY88HBc=
X-Received: by 2002:a05:6808:171c:b0:334:9342:63ef with SMTP id
 bc28-20020a056808171c00b00334934263efmr1076539oib.63.1656116607321; Fri, 24
 Jun 2022 17:23:27 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 24 Jun 2022 17:23:26 -0700
MIME-Version: 1.0
In-Reply-To: <CAE-0n51PiVo042oj8JrAxNTytmAoQx0kdqs_iCDffXa1+iur1A@mail.gmail.com>
References: <1656090912-18074-1-git-send-email-quic_khsieh@quicinc.com>
 <fa7f8bf1-33cd-5515-0143-6596df2bd740@quicinc.com> <CAE-0n51g-EVsC-i9=sJV-ySa8VnE+yT7cg=b-TNMi9+3uBiOVA@mail.gmail.com>
 <326912ff-9771-0711-366d-79acd436908b@quicinc.com> <CAE-0n51qrdrFtSr0vRwgYkMgSZfnzQuinaUROQsp30QoDchWQA@mail.gmail.com>
 <0ff3d6a3-dc5c-7c77-f8a1-6c4f6c1a3215@quicinc.com> <CAE-0n515hMKqQ+Vj1Sg54PpwkbWMYJ77QN+y+KZNBWymjhpWKw@mail.gmail.com>
 <66ff4642-f268-f5b0-7e28-b196368c508a@quicinc.com> <5cf094cf-343a-82d7-91c4-1284683f9748@quicinc.com>
 <CAE-0n51PiVo042oj8JrAxNTytmAoQx0kdqs_iCDffXa1+iur1A@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 24 Jun 2022 17:23:26 -0700
Message-ID: <CAE-0n50Qq2_eayXAUMzU29wKkpa6JZTG6J1dthUY1Y9tAjy_2Q@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] drm/msm/dp: decoupling dp->id out of dp
 controller_id at scxxxx_dp_cfg table
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>, agross@kernel.org,
        airlied@linux.ie, bjorn.andersson@linaro.org, daniel@ffwll.ch,
        dianders@chromium.org, dmitry.baryshkov@linaro.org,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, vkoul@kernel.org
Cc:     quic_aravindh@quicinc.com, quic_sbillaka@quicinc.com,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

Quoting Stephen Boyd (2022-06-24 17:11:01)
> Quoting Abhinav Kumar (2022-06-24 17:03:37)
> >
> > So let me try to explain this as this is what i understood from the
> > patch and how kuogee explained me.
> >
> > The ordering of the array still matters here and thats what he is trying
> > to address with the second change.
>
> The order of the array should not matter. That's the problem.

It seems like somewhere else the order of the array matters, presumably
while setting up encoders?

>
> >
> > So as per him, he tried to swap the order of entries like below and that
> > did not work and that is incorrect behavior because he still retained
> > the MSM_DP_CONTROLLER_x field for the table like below:
> >
> > diff --git a/drivers/gpu/drm/msm/dp/dp_display.c
> > b/drivers/gpu/drm/msm/dp/dp_display.c
> > index dcd80c8a794c..7816e82452ca 100644
> > --- a/drivers/gpu/drm/msm/dp/dp_display.c
> > +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> > @@ -140,8 +140,8 @@ static const struct msm_dp_config sc7180_dp_cfg = {
> >
> >   static const struct msm_dp_config sc7280_dp_cfg = {
> >          .descs = (const struct msm_dp_desc[]) {
> > -               [MSM_DP_CONTROLLER_0] = { .io_start = 0x0ae90000,
> > .connector_type = DRM_MODE_CONNECTOR_DisplayPort, .wide_bus_en = true },
> >                  [MSM_DP_CONTROLLER_1] = { .io_start = 0x0aea0000,
> > .connector_type = DRM_MODE_CONNECTOR_eDP, .wide_bus_en = true },
> > +               [MSM_DP_CONTROLLER_0] = { .io_start = 0x0ae90000,
> > .connector_type = DRM_MODE_CONNECTOR_DisplayPort, .wide_bus_en = true },
> >          },
> >          .num_descs = 2,
> >   };
> >
> >
> > The reason order is important is because  in this function below, even
> > though it matches the address to find which one to use it loops through
> > the array and so the value of *id will change depending on which one is
> > located where.
> >
> > static const struct msm_dp_desc *dp_display_get_desc(struct
> > platform_device *pdev,
> >                               unsigned int *id)
>
> Thanks! We should fix this function to not overwrite the id.
>

Ah nevermind. I mixed up dp->id and h_tile_instance thinking one was
overwriting the other but that doesn't make any sense.
