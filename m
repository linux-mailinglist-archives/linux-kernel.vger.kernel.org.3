Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C544C46701D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 03:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378120AbhLCCod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 21:44:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350748AbhLCCoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 21:44:32 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5C4C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 18:41:09 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id v15-20020a9d604f000000b0056cdb373b82so2244529otj.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 18:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=dixTX2RrlnwesW8iIjzk4nhy820PBObo86K/cFmNqMQ=;
        b=iM/D/ZJUqYaSokRA0yjzflf+/4LODWsu5gwGloRuNyTjAQEtTgoPcoOdA2I6kQ5lN2
         K5Ns7XaunKfXiHrNPHm+Dou+ZnKfnG3rzDHEE3TmxPiPcUrYMxYuh5Ad2c2DC4F+yclD
         hMNsUsZDl4ZPf68T1jHhUt9r91mbOjoLEGcTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=dixTX2RrlnwesW8iIjzk4nhy820PBObo86K/cFmNqMQ=;
        b=6vjlXYHAOHRGSyIFfgTcf/Z4wRZQDRNqDS1sIpny1h9iDXQ2qq8J5RipBSyh9w+71x
         iAyW+IsoXrmYh3IMAPZeZXpCUcIOAozLEa93vFjyVxgworpuelYmvkohiMRcnPVJhURp
         iw2XAHuxqAGd4UPN8d3Sg2Jl8ulra/XfGzCYCLv0YljeSo3opQOkO7InqwOu2pEgTtek
         CnNPUvLmNOq322kJ93tBONjvtHR9DOS9O3valJWCGw/cHikmMkPUrnr4ZesZKjRxad4e
         3kTw27X3EvhjzUR1zy65tGUmSxLmSOHoWLepAi2sPVznEyCRXDJcH8Xz3uOHe32j5HIh
         5ThQ==
X-Gm-Message-State: AOAM530/JaNwn0wIiRiAsJR8UJXL52E907nIAwipeDc6WJAa+I3rWTyJ
        oA8usHxpw7LD1YQxWMXNkBkgebyDFFjXGb5TugUODA==
X-Google-Smtp-Source: ABdhPJyK/ETlxs8XkQxa+hn+epgPr+mfELlA+cPMYqrCB6QQHK9j+S0/zfXRebJ/od3mAwIQuxUU5KO7z684Wem2OaU=
X-Received: by 2002:a9d:2243:: with SMTP id o61mr14174984ota.126.1638499268424;
 Thu, 02 Dec 2021 18:41:08 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 2 Dec 2021 18:41:08 -0800
MIME-Version: 1.0
In-Reply-To: <1636493893-7600-1-git-send-email-quic_khsieh@quicinc.com>
References: <1636493893-7600-1-git-send-email-quic_khsieh@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Thu, 2 Dec 2021 18:41:07 -0800
Message-ID: <CAE-0n51-=qTWfBVPFEmpEb7md6cg5O__bhydXTUb+=8dRqCuqg@mail.gmail.com>
Subject: Re: [PATCH v4] drm/msm/dp: do not initialize phy until plugin
 interrupt received
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, agross@kernel.org,
        airlied@linux.ie, bjorn.andersson@linaro.org, daniel@ffwll.ch,
        dmitry.baryshkov@linaro.org, robdclark@gmail.com, sean@poorly.run,
        vkoul@kernel.org
Cc:     quic_abhinavk@quicinc.com, aravindh@codeaurora.org,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kuogee Hsieh <khsieh@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2021-11-09 13:38:13)
> From: Kuogee Hsieh <khsieh@codeaurora.org>
>
> Current DP drivers have regulators, clocks, irq and phy are grouped
> together within a function and executed not in a symmetric manner.
> This increase difficulty of code maintenance and limited code scalability.
> This patch divided the driver life cycle of operation into four states,
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
> Fixes: e91e3065a806 ("drm/msm/dp: Add DP compliance tests on Snapdragon Chipsets")
>
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---

Can you please resend this based on the msm-next branch[1]? It doesn't
apply now that other patches have been applied.

[1] https://gitlab.freedesktop.org/drm/msm.git msm-next

>  drivers/gpu/drm/msm/dp/dp_ctrl.c    | 87 ++++++++++++++++---------------------
>  drivers/gpu/drm/msm/dp/dp_ctrl.h    |  9 ++--
>  drivers/gpu/drm/msm/dp/dp_display.c | 83 ++++++++++++++++++++++++++---------
>  3 files changed, 105 insertions(+), 74 deletions(-)
>
