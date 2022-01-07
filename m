Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0776486E83
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 01:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343865AbiAGAQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 19:16:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343805AbiAGAQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 19:16:09 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1F0C061201
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 16:16:08 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id v6so6007463oib.13
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 16:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=mE1P4O+5lb7Aj+m/u0inLsIsF4f3Obpma9YFsBVI+mk=;
        b=R+c4v+KB6lM8fqhf7qCx4POmsHZ85uFetKficsf+q36Un+SUnj9mAYdkTsUDRSUEum
         3ileYQjfrtriixrocxGrjGqEiu4uGATHnNupNBiTJoL0O/xhscZlTHbAyUz5ryn23sC8
         TDxs9J8GCQtY1X4V4fVgCPSWDG3oMtNcHwmRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=mE1P4O+5lb7Aj+m/u0inLsIsF4f3Obpma9YFsBVI+mk=;
        b=15A+t4bwBCc6Mfs0it7zKxUo8fUaxDT3s6VOHnMHVAKFiPzvV+DTqyrJIErtzRW4gb
         f7SVhXLlr24jIOj+jw5oq7LhdPJHUJu4hLHT0y/Mi8klWnzikF4Y8WbPVIBt/QyEj7FU
         lvsVmDKHbxAQ4kUg9QfJF9cqDDC1NeDRmhKSPYDqNKCWyZxsKw01HApvOnbPymNgdExr
         QzKIx2m+f9c407Lw3EgwrqnXLeLj1dLsJ0dx3NTzl7u+YUZvg9bhDYs+9lim+mWi/G04
         YS6g3sN4SS7sgxYMTDXL2bVITWcdEjI4y0vxtj2gg1c/0Why+nh+H/w9kPjdfb98fjCY
         Oe8w==
X-Gm-Message-State: AOAM530SLvAZ/Nl7F6a2Fqf+4KWlgJmugF5wFAMeFUeXH0OFbYgU8oxr
        FTwsngc1/JMNK53V9Oo0ZMb3ixT30/mK0gVOQH+NPQ==
X-Google-Smtp-Source: ABdhPJxYOfr7WP2LZzJN/EUDtSmVISjJlgmRyG+L1riCyACt9jPXB4g4etKquIwp2+r5rnPWy0RDAAxc2R9ayyc2n28=
X-Received: by 2002:aca:4382:: with SMTP id q124mr8016650oia.64.1641514568306;
 Thu, 06 Jan 2022 16:16:08 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 6 Jan 2022 16:16:07 -0800
MIME-Version: 1.0
In-Reply-To: <1641489296-16215-1-git-send-email-quic_khsieh@quicinc.com>
References: <1641489296-16215-1-git-send-email-quic_khsieh@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Thu, 6 Jan 2022 16:16:07 -0800
Message-ID: <CAE-0n52-SL6jPVtn_wEPtY1FQ4EUZ2PhiQ=agXcnA0AHPV9TQQ@mail.gmail.com>
Subject: Re: [PATCH v3] drm/msm/dp: add support of tps4 (training pattern 4)
 for HBR3
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, agross@kernel.org,
        airlied@linux.ie, bjorn.andersson@linaro.org, daniel@ffwll.ch,
        dmitry.baryshkov@linaro.org, robdclark@gmail.com, sean@poorly.run,
        vkoul@kernel.org
Cc:     quic_abhinavk@quicinc.com, aravindh@codeaurora.org,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kuogee Hsieh <khsieh@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2022-01-06 09:14:56)
> @@ -1189,12 +1190,20 @@ static int dp_ctrl_link_train_2(struct dp_ctrl_private *ctrl,
>
>         *training_step = DP_TRAINING_2;
>
> -       if (drm_dp_tps3_supported(ctrl->panel->dpcd))
> +       if (drm_dp_tps4_supported(ctrl->panel->dpcd)) {
> +               pattern = DP_TRAINING_PATTERN_4;
> +               state_ctrl_bit = 4;
> +       }
> +       else if (drm_dp_tps3_supported(ctrl->panel->dpcd)) {

also

	} else if (...) {
