Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F5F57CBD2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 15:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiGUNZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 09:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGUNZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 09:25:46 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3229B82
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 06:25:44 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id m10so1149780qvu.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 06:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DGrBLaNIprWPnLASVzucMIdeH8IwcuTiWBUYmrgNEq4=;
        b=blMArCRIQqdXMvhhNuLcI+8rbpoj3mba+jisYAjiGNck3+Yrkpitf3sBSMLXU0MYu1
         JnGMr7qaUuib3O0fPQMF23cjXCfaiwVbi8pH05GUO0+w3HJy0f70v+OYZCWvTWwruCT8
         cbkbGErUBDDfm6CgzF82H+OS71moycWT9T1MrNyE6JMJin9EyL/oDIhMYC8VeTuAqsB7
         8MOJpuVrOi6hrwjiCJA/evwd6WfNyNw6tVB7TdBfikLUxjzFRU02ArPAu7usZ3LWLAcG
         pD0qfxC8x7dPyqMwAfo1On3QDv2/kl81p3iLk1f2deY53RKZHwV26qUBXuOVQEAkIYrk
         EORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DGrBLaNIprWPnLASVzucMIdeH8IwcuTiWBUYmrgNEq4=;
        b=GXY206TJidRpcHNLGj24r2cqXHef8LNcp3rgf9zqub0JmPOTCvbZ7XXCUsFlVJYHhy
         tWOeavQEtDFfyPbr2iX96IX4Zq9Y3OLa3uC1UsQBA9yPmjPdjlQjsSPHyMhiCIZwTapB
         0JDbsq4b+rrKgDhRH733g9Wbl7AyVScS+seDGKjk5cpYuAx7kjzBs4uml5awPcyoU88l
         CX7K4tCY8Tyaolp7LnjWWFqlgPtGLuZakWo4mCNdQs9mKahFjnF7575KpiCDSc/MhGJN
         +5gdqz8pYl/ZAUVxDYIEkTkH0BnJm7zJd+Kvtp1iV8RyIv/6SyNRR1BMf4nhIRgsn7w9
         8dWQ==
X-Gm-Message-State: AJIora85cvwwx9Ce1hrPzPhjGlxAVZeuG3Rrd52tY6iASORKMSWVJrkf
        rc8ILBzcqUTDm3XU9FrqqsAV6JiqbCnxT5zZM1PRjg==
X-Google-Smtp-Source: AGRyM1t+UP7BoSoJdJI25zgNAHeecjAWzPFa9Wrm9U9VbpfVkvmZ3snud9x2l21so/p6slH37Gs7Pze5kD1tVod2jvY=
X-Received: by 2002:ad4:5761:0:b0:473:7861:69d1 with SMTP id
 r1-20020ad45761000000b00473786169d1mr34026860qvx.73.1658409944065; Thu, 21
 Jul 2022 06:25:44 -0700 (PDT)
MIME-Version: 1.0
References: <1657038556-2231-1-git-send-email-quic_khsieh@quicinc.com> <YtkrDcjTGhpaU1e0@hovoldconsulting.com>
In-Reply-To: <YtkrDcjTGhpaU1e0@hovoldconsulting.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 21 Jul 2022 16:25:32 +0300
Message-ID: <CAA8EJprQnnWjDZJy9+zUBsVQCi3jtc0Ngtzzk9MXpwOvuAS68g@mail.gmail.com>
Subject: Re: [PATCH v16 0/3] eDP/DP Phy vdda realted function
To:     Johan Hovold <johan@kernel.org>
Cc:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Douglas Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, daniel@ffwll.ch,
        airlied@linux.ie, agross@kernel.org, quic_abhinavk@quicinc.com,
        quic_aravindh@quicinc.com, quic_sbillaka@quicinc.com,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jul 2022 at 13:31, Johan Hovold <johan@kernel.org> wrote:
>
> On Tue, Jul 05, 2022 at 09:29:13AM -0700, Kuogee Hsieh wrote:
> > 0) rebase on https://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tree
> > 1) add regulator_set_load() to eDP phy
> > 2) add regulator_set_load() to DP phy
> > 3) remove vdda related function out of eDP/DP controller
> >
> > Kuogee Hsieh (3):
> >   phy: qcom-edp: add regulator_set_load to edp phy
> >   phy: qcom-qmp: add regulator_set_load to dp phy
> >   drm/msm/dp: delete vdda regulator related functions from eDP/DP
> >     controller
> >
> >  drivers/gpu/drm/msm/dp/dp_parser.c        | 14 -----
> >  drivers/gpu/drm/msm/dp/dp_parser.h        |  8 ---
> >  drivers/gpu/drm/msm/dp/dp_power.c         | 95 +------------------------------
> >  drivers/phy/qualcomm/phy-qcom-edp.c       | 12 ++++
> >  drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 41 ++++++++++---
> >  5 files changed, 46 insertions(+), 124 deletions(-)
>
> This series breaks USB and PCIe for some SC8280XP and SA540P machines
> where the DP PHY regulators are shared with other PHYs whose drivers do
> not request a load.

I'm trying to understand, why does this series cause the regression.
Previously it would be the DP controller voting on the regulators
load, now it has been moved to the DP/eDP PHYs.

> Specifically, the hard-coded vdda-phy load of 21.8 mA added by this
> series, causes several RPMh regulators to now be put in low-power mode.
>
> I found Doug's suggestion to handle situations like this in regulator
> core:
>
>         https://lore.kernel.org/all/20180814170617.100087-1-dianders@chromium.org/
>
> but since that was rejected, how do we deal with this generally?
>
> In the above thread Doug mentioned adding support for load requests to
> further drivers and Bjorn mentioned working around it by adding
> regulator-system-load properties to DT.
>
> It seems quite likely that changes like this one affects other systems
> too, and the effects may be hard to debug. So a more general solution
> than playing whack-a-mole using DT would be good to have.

I think enabling a regulator which supports set_load() and without
load being set should cause a warning, at least with
CONFIG_REGULATOR_DEBUG. WDYT?

-- 
With best wishes
Dmitry
