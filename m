Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6100B485A85
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 22:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244389AbiAEVQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 16:16:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244377AbiAEVQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 16:16:28 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7742C061245
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 13:16:27 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id r131so876523oig.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 13:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=lQIYB8bEUDp4cYpSdlfyhVUVPvpZOy0FK7CuWF/SNCs=;
        b=VJULhypwX0wcHpzibsftrllI34j0tWSOHncXLf7DHHkdYytd/cshD8afr1mSu99W1X
         5576rOFq3ZsuMTtEMmkl35fCepUmdxDNOuSIyBj8AZ8Ln5mt1Q5T94eSYumDbIGu8xj3
         KOX/VorQzAFVCWTJ3UCq5UmHuzcc0ZdP3q3y4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=lQIYB8bEUDp4cYpSdlfyhVUVPvpZOy0FK7CuWF/SNCs=;
        b=TcQD20fNy9LrOYA+wURUqQdh2Cg0PCQkxxFH3XF9vvcW3GMH2bsenJOAkLKmTQDpaN
         jOdiy2APMe30tdz/lGp1NnJW6n82PRYimvRSfrUJq3SgH6AsW6UYcdG5ybd0QNV6vOnx
         3S8Jh1nbajLcE7lvFeBNdYjklugxl/2iKih405yhsBUb6WqEIRaTCO4wIuBlPJjWs9w1
         UYyhts3UILUp/uupQdTcL/JD36ZHdx/QHrFvFtLFkPtHaTwMC2oOBQV+zbCbj2+MEmuC
         +gkXJfd30Db/SttDd6fygeo3gPMw2uCX+y+6TsFTdqI1Nx7/cvQ1Z6OvsfXA0S0bcMvF
         PE/A==
X-Gm-Message-State: AOAM530xS9Q7VvI67JpW+RZz8a8QA0xRHv67BHOrAH05wMf8WPSc4p31
        ByayycFzW7+woeLxUyDmqZOUHhzcSrzkzAKUbhpLZA==
X-Google-Smtp-Source: ABdhPJyOxzmq0ckko0uEYH+WNow6f32CMqXcPtkrxYZG3rRoP/75NVBgFtr5ndOsSm393obYSgK+4GjDbI6lo3fsLZI=
X-Received: by 2002:aca:a953:: with SMTP id s80mr4041796oie.164.1641417386974;
 Wed, 05 Jan 2022 13:16:26 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 5 Jan 2022 13:16:26 -0800
MIME-Version: 1.0
In-Reply-To: <1641340327-2261-1-git-send-email-quic_khsieh@quicinc.com>
References: <1641340327-2261-1-git-send-email-quic_khsieh@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 5 Jan 2022 13:16:26 -0800
Message-ID: <CAE-0n51FHOks2mF1tNxzEt7Hqz03in0KHRx8_49SGk-0F34Cvg@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dp: stop link training after link training 2 failed
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, agross@kernel.org,
        airlied@linux.ie, bjorn.andersson@linaro.org, daniel@ffwll.ch,
        dmitry.baryshkov@linaro.org, robdclark@gmail.com, sean@poorly.run,
        vkoul@kernel.org
Cc:     quic_abhinavk@quicinc.com, aravindh@codeaurora.org,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2022-01-04 15:52:07)
> Each DP link training contains link training 1 followed by link
> training 2.  There is maximum of 5 retries of DP link training
> before declared link training failed. It is required to stop link
> training at end of link training 2 if it is failed so that next
> link training 1 can start freshly. This patch fixes link compliance
> test  case 4.3.1.13 (Source Device Link Training EQ Fallback Test).
>
> Fixes: 2e0adc765d88 ("drm/msm/dp: do not end dp link training until video is ready")
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
