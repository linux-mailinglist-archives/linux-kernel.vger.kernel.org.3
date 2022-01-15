Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0197D48F3F7
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 02:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbiAOBNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 20:13:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiAOBNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 20:13:33 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8558CC06161C
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 17:13:33 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id y14so14643393oia.9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 17:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=2e5tIIWoJF2Q+eyt2ltN1h2wnkPnspxpy/ND3U7gfvw=;
        b=eXZemXw1GAkki7wQd61a0SI0b/KpRWe4zOKRpXpcxIme4L3z7B868A8iCkyhcvE4Xu
         Vg0vd+09neevGqHg1DoE7Bxc5OWyi+H6DcuRDfGYVnkEEsUTn3uakzmBTGUyraaYtDV+
         cMcNG+bARXr3QNKHR8eWtk6uJ+7B46nxeYfyQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=2e5tIIWoJF2Q+eyt2ltN1h2wnkPnspxpy/ND3U7gfvw=;
        b=n3faeqfhaKNsrBoL4Li3H/QlB/CI2sxC8Jx2E+q8coMoss1pnLeQDI1jvveaeBZB8M
         Wk6cjpIx/aApDkgazfv19DPpD7fX6wQHsLnlOsYN/SPPw4DwPUPuu82+9BVWAa7P17oX
         4p4EYrm+YF4Dep+VP3xNPwiqYa4DKrINyp9wg/avdF4h0QFPdCHNo+P0LEVIlP18hcRS
         dbWOEjrE1swoQ92Nq3CupQ5B15wHXFfkL1Y+E1kp5/F6PzfB0hBX3/ZctkyA1H6rVAKo
         sqSZRrLNBPwH1aHok5qvUdMy0v1JaNXGYrmVPpvf+6CDS3Eqzoo4Q1s/Hhxv+/3jIYAf
         ufDA==
X-Gm-Message-State: AOAM531mOyezk2SqfScnhCn1f41Q4HpGh+b+v1NUa97fl0N14GwWj+VX
        PDhtnEwwmzGzBj38CnuuzxMLoOF/kpGgIsOCJrECsQ==
X-Google-Smtp-Source: ABdhPJx/wUgNcsQ4Wj0mkNyi+IJLwQfypHQ8gPkC3Gp3HPUmDhGgT8r8xkmgy+tNXZb5f4Ip2JMwSVhN7pDOywNR7iI=
X-Received: by 2002:aca:a953:: with SMTP id s80mr15220958oie.164.1642209212880;
 Fri, 14 Jan 2022 17:13:32 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 14 Jan 2022 19:13:32 -0600
MIME-Version: 1.0
In-Reply-To: <1642208315-9136-2-git-send-email-quic_khsieh@quicinc.com>
References: <1642208315-9136-1-git-send-email-quic_khsieh@quicinc.com> <1642208315-9136-2-git-send-email-quic_khsieh@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 14 Jan 2022 19:13:32 -0600
Message-ID: <CAE-0n52KfpfnxsC5SKvR9zWWONmh2oyD3cS9L-8-J1RHHzKSdQ@mail.gmail.com>
Subject: Re: [PATCH v17 1/4] drm/msm/dp: do not initialize phy until plugin
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

Quoting Kuogee Hsieh (2022-01-14 16:58:32)
> @@ -1363,14 +1368,14 @@ static int dp_pm_suspend(struct device *dev)
>                 if (dp_power_clk_status(dp->power, DP_CTRL_PM))
>                         dp_ctrl_off_link_stream(dp->ctrl);
>
> +               dp_display_host_phy_exit(dp);
> +
> +               /* host_init will be called at pm_resume */
>                 dp_display_host_deinit(dp);
>         }

I thought we determined that core_initialized was always true here, so
the if condition is redundant. Furthermore, removing that check allows
us to entirely remove the core_initialized variable from the code.
