Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E549755A589
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 02:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbiFYA3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 20:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiFYA3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 20:29:45 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD4369FA1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 17:29:44 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 88so6893857qva.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 17:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XJj2jKLrKWKYCL3G0JVCzxE24zzw7IepY2Hipgb7xdU=;
        b=ItIXMMRXGzTB4SAjQ/ljwU3he2WFwrwfNYqNw6nx/LVB1pEkb5GqVhkJ0CGNJZSFh2
         9uvGcLACEQw+x0kHvxWYM5t5IhpCmS6jXGVatAX2Of0e5ohhlghwwgrOIFGZZ/UcmSXD
         Ii1eLOobes6KSm1te90jx4zGT+10O/yHwiFJuX+d2laYGZltRSvs0HilbQkhW/rgexcQ
         GNMwF5CiSGe/2jQMVJvrJXAHvkCluoUoJRperjbVF9eOIvetr30WEkpnV03Ierh+9i9E
         ONExAocAHSxDRAEKUHbd7I1K42nlVAxH2cYewU0r1qiuDVNSLz+G8Eaa8Hz2lBKLQ7Th
         BkmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XJj2jKLrKWKYCL3G0JVCzxE24zzw7IepY2Hipgb7xdU=;
        b=uyGRLOaBEdhSmcMx6zYXdaNJwOHNP/X920S3pL30SUjjIsx0aWfNMlRiXFkSGUTf1x
         NVPPvwvAID7LnEJlmTrx1ZX5V548UZDLfE4Srfa3dpKAAKhDo96rq9CYuGnkY7paXWt8
         9ZN5xKSXjQf8SKRGpOkLAuF86N65Dtl3kIWXRWZ1agKiky1NNpYW/lTnofJhoX6X/Kl8
         e+NU/q94RZKyOTzlvF1dztRYP0PD9EQtcMQa84GDHJEG8hfAq8zkQvOnDgONNFLH+WKh
         mW+QNtqwIaGFoROgpN+zGMi9d7qejyUxMBH9nLYqgOHfCA/Xul+oRLFzWy1KXo6o0sKV
         xh+g==
X-Gm-Message-State: AJIora+iU+k3/DRqIp9BD7Txo/m/hLKdocd48JBLl7ll6RdCoOk+BjKq
        SDd6BQPxoq6dPKYfe1AzE+4GgweBRYSru29ov6R8tA==
X-Google-Smtp-Source: AGRyM1t1LNe3ggUGTtV/WfBEzzJamFsd40RNO/gCCttMTGrOCrn1bQ/LPwHe0A/36/p2hLFpcB3urShWjF6qtQ+zjFY=
X-Received: by 2002:a05:622a:1351:b0:305:2e58:939 with SMTP id
 w17-20020a05622a135100b003052e580939mr1422121qtk.295.1656116983913; Fri, 24
 Jun 2022 17:29:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220625002811.3225344-1-swboyd@chromium.org>
In-Reply-To: <20220625002811.3225344-1-swboyd@chromium.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 25 Jun 2022 03:29:32 +0300
Message-ID: <CAA8EJprV_wqFrG6TVV0SAyxN9WHfC-vU-B_31toiWOYMqeNeUw@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dp: Remove encoder pointer from struct msm_dp
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Sean Paul <sean@poorly.run>, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org,
        Kuogee Hsieh <quic_khsieh@quicinc.com>
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

On Sat, 25 Jun 2022 at 03:28, Stephen Boyd <swboyd@chromium.org> wrote:
>
> We don't need to stash the encoder here. Instead we can simply pass it
> around as an argument.
>
> Cc: Kuogee Hsieh <quic_khsieh@quicinc.com>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 4 +---
>  drivers/gpu/drm/msm/dp/dp_display.h | 1 -
>  drivers/gpu/drm/msm/dp/dp_drm.c     | 8 ++++----
>  drivers/gpu/drm/msm/dp/dp_drm.h     | 2 +-
>  4 files changed, 6 insertions(+), 9 deletions(-)

-- 
With best wishes
Dmitry
