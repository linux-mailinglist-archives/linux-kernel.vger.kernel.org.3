Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 423FE486E89
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 01:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343916AbiAGAQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 19:16:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343889AbiAGAQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 19:16:38 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24320C061201
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 16:16:38 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id a129so5005952oif.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 16:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=AhAOsZ/7jHs5SUsagnpCXuv8mziNMy8lNAe5OxNHwRI=;
        b=jtu0UCzsfvv7r/9Ui35y3wcCDJ3CTyXCC8ChvPsXCS9J3W37m6SMoBTQbsj+ErtfE9
         pe0aHLL5ZWI9rFnxE5JXD20lz7HQ5hXDUeTh2khVn4BFwqA6b1gU7t/PkpRjvVqM6VpH
         u3uv0WnE20bi241CKaAwLaQZj5rAyiY2wkRUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=AhAOsZ/7jHs5SUsagnpCXuv8mziNMy8lNAe5OxNHwRI=;
        b=3t8sVF0C064emzAB+bf+aMMUuhzFmJjpgDcy5yArhPRqa2KJ0p7//G1yqC2T+x9KMt
         zOaDHJvDvsQ71vKIx0z9OlBO5m/3xUPa3gzEpipSq1UPyNsV24zD31Zs9wpOYcDsHf4e
         /Gf02W/Mf7rdakmzbRlo2uLJdyYHbPuGWd9oCuWNBfGIyOk5xAoZctAjfXiaNfqLTTxh
         R37K5m2UlOUSPhzX86EYzB8vaHadsQWm/zZZ7e9X2PnYDS12Co9XEupwRD8nwbwIGrzc
         rIi4Pd0Di5HENkjO1FYiwpS0qNS3xF1p0+CvktKNiBEb+IZYjh05NtUR3Pemud58ys5w
         bVDA==
X-Gm-Message-State: AOAM530U+u9sJOUX93RcKnilLPtSlpJiD4G2QHkEjfe5LCqtX0yLnmyp
        BUcINVBT6BHQh6fKEG7qRAlyK7jMvFGIupTHxQseIA==
X-Google-Smtp-Source: ABdhPJzdnu0U3lCEWw7wwT5P+wBqtXsBtwXolcxsJQLEGILR/MbyPZuk7wEfhLzqqaqCXLmimPsFv6cKTyObVMLoGMs=
X-Received: by 2002:a54:4710:: with SMTP id k16mr7970018oik.32.1641514597511;
 Thu, 06 Jan 2022 16:16:37 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 6 Jan 2022 16:16:37 -0800
MIME-Version: 1.0
In-Reply-To: <1641501894-17563-1-git-send-email-quic_khsieh@quicinc.com>
References: <1641501894-17563-1-git-send-email-quic_khsieh@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Thu, 6 Jan 2022 16:16:37 -0800
Message-ID: <CAE-0n51WQMSeChCyMKCHOGSqhGKf4=TamDinndrF8iVFrmrZ7A@mail.gmail.com>
Subject: Re: [PATCH v4] drm/msm/dp: populate connector of struct dp_panel
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

Quoting Kuogee Hsieh (2022-01-06 12:44:54)
> DP CTS test case 4.2.2.6 has valid edid with bad checksum on purpose
> and expect DP source return correct checksum. During drm edid read,
> correct edid checksum is calculated and stored at
> connector::real_edid_checksum.
>
> The problem is struct dp_panel::connector never be assigned, instead the
> connector is stored in struct msm_dp::connector. When we run compliance
> testing test case 4.2.2.6 dp_panel_handle_sink_request() won't have a valid
> edid set in struct dp_panel::edid so we'll try to use the connectors
> real_edid_checksum and hit a NULL pointer dereference error because the
> connector pointer is never assigned.
>
> Changes in V2:
> -- populate panel connector at msm_dp_modeset_init() instead of at dp_panel_read_sink_caps()
>
> Changes in V3:
> -- remove unhelpful kernel crash trace commit text
> -- remove renaming dp_display parameter to dp
>
> Changes in V4:
> -- add more details to commit text
>
> Fixes: 7948fe12d47 ("drm/msm/dp: return correct edid checksum after corrupted edid checksum read")
> Signee-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
