Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E502050EA82
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 22:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245563AbiDYUba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 16:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245522AbiDYUbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 16:31:14 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0C838BF6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 13:26:10 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-e9027efe6aso10004994fac.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 13:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=GY8nfdZIIJMjKD8udXATRrBvCI90FRL703LkUIvDAlU=;
        b=C/ET6AeSQZ2SaYHzT8jZQsZxbTkp+o+3wp1UMk5UJoMbzgWL+QL4x+sxVHHWDGwNGb
         PghAnpgDCD7NLYJwGGMd5NkLMfvp+9hTzOpzn++XyH6DAuYTvuO2+SB16OoOUfhX9kWs
         iTg0xVBII2dSOGValyuc370C5fb0UdUQ7D0fU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=GY8nfdZIIJMjKD8udXATRrBvCI90FRL703LkUIvDAlU=;
        b=YFjO3MfIW4LYQGCOOYFmBS91K0ifs865i84IoPFxbhnguTRdm3xFDy6QC4ZR8w5ouB
         U9zbVQBb+f4pGGaEfi5MzQG+q+kqKmEZTJo4EKa+td62B90vZ0w3QjaUYUD3XlqddoVB
         yGr1VYaYpB0EHFcuSWU+A8sgm71iIHKcz3aK3rpKGxgAqRaitLGTzUjtUOibt6oxQuLx
         CbzGZi6hR8xaB1RTkYGpbOtLqaBWCcjva0qXotC4AB1/gSWJ19pMLLjjHPJ6Zo2EGVxF
         FNFywPTq7Cywx3HnK0nEdpReo2y4ZFiHmdTznAL7aRMchHp3GQqoh/gsHemErG6kRU8d
         ymXg==
X-Gm-Message-State: AOAM533UTpV1AyZYRHGtotg04L5dPXGR9H7sh/TvOSNAO1wqKus2nLjI
        BuRm4asOFKljNiptibiu3puBAm9mnXcsk+1f3tn83A==
X-Google-Smtp-Source: ABdhPJwtgqfdj2bI0xf9NqacpOrKLAx8wbR4ILpgTMgDRv4vIFNkUSXqfxqjSLpsTgoPKZ0wedCV8wLpGgv4u2sksLA=
X-Received: by 2002:a05:6870:15ca:b0:e9:551:6d1c with SMTP id
 k10-20020a05687015ca00b000e905516d1cmr6326639oad.193.1650918369702; Mon, 25
 Apr 2022 13:26:09 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 25 Apr 2022 13:26:09 -0700
MIME-Version: 1.0
In-Reply-To: <MW4PR02MB7186108BA0131C8BFC46A219E1F89@MW4PR02MB7186.namprd02.prod.outlook.com>
References: <1650618666-15342-1-git-send-email-quic_sbillaka@quicinc.com>
 <1650618666-15342-2-git-send-email-quic_sbillaka@quicinc.com>
 <CAE-0n51VBDmOOworjpuB1nqVD-7055yqvn2Er5H13qgFC5R2AQ@mail.gmail.com> <MW4PR02MB7186108BA0131C8BFC46A219E1F89@MW4PR02MB7186.namprd02.prod.outlook.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 25 Apr 2022 13:26:09 -0700
Message-ID: <CAE-0n51oUFkYuZ5qd2CbnaUGo2xcAjU+F0M+Kptk8b=7curH0Q@mail.gmail.com>
Subject: RE: [PATCH v9 1/4] drm/msm/dp: Add eDP support via aux_bus
To:     Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "robdclark@gmail.com" <robdclark@gmail.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        quic_kalyant <quic_kalyant@quicinc.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        "dianders@chromium.org" <dianders@chromium.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "sean@poorly.run" <sean@poorly.run>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>,
        quic_vproddut <quic_vproddut@quicinc.com>,
        Aravind Venkateswaran <quic_aravindh@quicinc.com>,
        "steev@kali.org" <steev@kali.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sankeerth Billakanti (QUIC) (2022-04-25 02:39:43)
> Hi Stephen,
>
> >Quoting Sankeerth Billakanti (2022-04-22 02:11:03)
> >> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c
> >> b/drivers/gpu/drm/msm/dp/dp_display.c
> >> index d7a19d6..055681a 100644
> >> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> >> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> >
> >Some nitpicks
> >
> >Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> >
> >> @@ -1508,7 +1509,8 @@ void msm_dp_irq_postinstall(struct msm_dp
> >> *dp_display)
> >>
> >>         dp_hpd_event_setup(dp);
> >>
> >> -       dp_add_event(dp, EV_HPD_INIT_SETUP, 0, 100);
> >> +       if (!dp_display->is_edp)
> >> +               dp_add_event(dp, EV_HPD_INIT_SETUP, 0, 100);
> >
> >Did it turn out that in fact DP isn't ready still to setup even after delaying the
> >irq?
> >
>
> The host_init, config_hpd, phy_init and enable_irq are happening in modeset_init already for eDP.
> So, I am not scheduling the EV_HPD_INIT_SETUP event for eDP. I am not modifying the delay for DP.

Cool. That didn't answer my question though. Why does DP still need the
delay? I thought recent changes made it unnecessary.
