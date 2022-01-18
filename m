Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8107493023
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 22:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349599AbiARVsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 16:48:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234970AbiARVsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 16:48:43 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9234C061574
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 13:48:43 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id bb37so1061316oib.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 13:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=XbypTSvua+Bn+tStGdHHerix/3+IgEDg0+FneAuZ170=;
        b=QpAAwHF2qWinW2uvaofhoAUY39nlZwvyaMiOxxeRdyuHYzNLDAAZIRF5kasuOU3+eC
         IVeupmELfxU1+XxjoKk/GtmN5MfLrFr5jLMaIofFTdVigAu5RgI74s+6US1TagKA9EYG
         5LWW55GQurbt9XXRFW9hic2ErARQMedsS3goQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=XbypTSvua+Bn+tStGdHHerix/3+IgEDg0+FneAuZ170=;
        b=6eOZg5Omkvl/tw58HjnImTlWvtSxtPemxBVIrzz5LdUhJRGSc33sLKwvz3Mh0FZq7u
         vM5e6ECrWm9dqWu4ViwSIbXT/TO99/jmh2DMkqfIsDfAqsv3gAhTFPLi44dyKUAN6cgV
         2JhXcL40wIbsCSrTjNJfnwYjgbSMmgQpwrJ/zmyUC5fw+2hJSYuKHJiVYyyg1wfilh0K
         xuICrfbEzwxWpHnCehHo9+fNuk2FrtCxmYXK5TIY7n0w2LBvezL7PoMbxDu6WRdExDQs
         2/O9CU5ImGvMkXAFxScPKqVvvWC0b5gHFFx6kSNSIAJO26b/dCpoivtwX7hcRrdahdck
         7Ygw==
X-Gm-Message-State: AOAM531UNiVk+qX5ufSFhOr1h7diH57BwIiAWjLKmZdSkvbB7aPo4f9y
        SJGqtFnmP8NroLlpJiUg5sle8Azn9mFIrppYQtsOXg==
X-Google-Smtp-Source: ABdhPJy9GaLVs4C+CRAAbCb6jqWMfK6XSY2DOuVH79+SDS+8SWhgAnJT9e4zefrFMl48i8wIYbvNmfwKg8rjy27WavQ=
X-Received: by 2002:aca:f241:: with SMTP id q62mr475173oih.64.1642542523126;
 Tue, 18 Jan 2022 13:48:43 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 18 Jan 2022 15:48:42 -0600
MIME-Version: 1.0
In-Reply-To: <1642531648-8448-2-git-send-email-quic_khsieh@quicinc.com>
References: <1642531648-8448-1-git-send-email-quic_khsieh@quicinc.com> <1642531648-8448-2-git-send-email-quic_khsieh@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 18 Jan 2022 15:48:42 -0600
Message-ID: <CAE-0n513EnHjFLNaRPecXZJMp0Cg7UHZyqq9q3NZS50CvJtn6w@mail.gmail.com>
Subject: Re: [PATCH v18 1/4] drm/msm/dp: do not initialize phy until plugin
 interrupt received
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, agross@kernel.org,
        airlied@linux.ie, bjorn.andersson@linaro.org, daniel@ffwll.ch,
        dmitry.baryshkov@linaro.org, dri-devel@lists.freedesktop.org,
        robdclark@gmail.com, sean@poorly.run, vkoul@kernel.org
Cc:     quic_abhinavk@quicinc.com, aravindh@codeaurora.org,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2022-01-18 10:47:25)
> Current DP drivers have regulators, clocks, irq and phy are grouped
> together within a function and executed not in a symmetric manner.
> This increase difficulty of code maintenance and limited code scalability.
> This patch divides the driver life cycle of operation into four states,
> resume (including booting up), dongle plugin, dongle unplugged and suspend.
> Regulators, core clocks and irq are grouped together and enabled at resume
> (or booting up) so that the DP controller is armed and ready to receive HPD
> plugin interrupts. HPD plugin interrupt is generated when a dongle plugs
> into DUT (device under test). Once HPD plugin interrupt is received, DP
> controller will initialize phy so that dpcd read/write will function and
> following link training can be proceeded successfully. DP phy will be
> disabled after main link is teared down at end of unplugged HPD interrupt
> handle triggered by dongle unplugged out of DUT. Finally regulators, code
> clocks and irq are disabled at corresponding suspension.
>
> Changes in V2:
> -- removed unnecessary dp_ctrl NULL check
> -- removed unnecessary phy init_count and power_count DRM_DEBUG_DP logs
> -- remove flip parameter out of dp_ctrl_irq_enable()
> -- add fixes tag
>
> Changes in V3:
> -- call dp_display_host_phy_init() instead of dp_ctrl_phy_init() at
>         dp_display_host_init() for eDP
>
> Changes in V4:
> -- rewording commit text to match this commit changes
>
> Changes in V5:
> -- rebase on top of msm-next branch
>
> Changes in V6:
> -- delete flip variable
>
> Changes in V7:
> -- dp_ctrl_irq_enable/disabe() merged into dp_ctrl_reset_irq_ctrl()
>
> Changes in V8:
> -- add more detail comment regrading dp phy at dp_display_host_init()
>
> Changes in V9:
> -- remove set phy_initialized to false when -ECONNRESET detected
>
> Changes in v10:
> --  group into one series
>
> Changes in v11:
> -- drop drm/msm/dp: dp_link_parse_sink_count() return immediately
>         if aux read
>
> Changes in v12:
> -- move dp_display_host_phy_exit() after dp_display_host_deinit()
>
> Changes in v13:
> -- do not execute phy_init until plugged_in interrupt for edp, same as DP.
>
> Changes in v14:
> -- remove redundant dp->core_initialized = false form dp_pm_suspend.
>
> Changes in v15:
> -- remove core_initialized flag check at both host_init and host_deinit
>
> Changes in v16:
> -- remove dp_display_host_phy_exit core_initialized=false at dp_pm_suspend
>
> Changes in v17:
> -- remove core_initialized checking before execute attention_cb()
>
> Changes in v18:
> -- remove core_initialized checking at dp_pm_suspend
>
> Fixes: 8ede2ecc3e5e ("drm/msm/dp: Add DP compliance tests on Snapdragon Chipsets")
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
