Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3D2476180
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 20:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344180AbhLOTS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 14:18:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238749AbhLOTSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 14:18:25 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0548C06173E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 11:18:25 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id de30so21143737qkb.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 11:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lupv2Y8caxWSPo/yUIpJfaEyopRdwsl8zpftq2TZo8c=;
        b=JeUquh9xs0mAhV646mX1fPpTfEWDBFm4VpV2DzQrI7hCt0URfzBNzPsqmp+Xcqga0n
         +MLIN75Prpx1MOT0sRYpZ1ckgt2UIU9Uly3dvMbUd+LgfWr+nu6ndecT3/1r9wmeg8p8
         sVaeU9BJcpoaRYpkyKjQcsfqQfakqh3Le8i/34X9IKrCmTEqU88aNYXxQcQAROakjvV0
         2pue5P3G7sATp3CiU51ut2qCjCvKB0u2H0um0qcQ26PDbW5o8hr55KWust5VfocLUuLJ
         x1sSIItAq9vS/jenmboVqsQ64XvKvwW4MvWXZxtLxKI7owqbjC6RuCuDWYNAMHinWcvI
         HPXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lupv2Y8caxWSPo/yUIpJfaEyopRdwsl8zpftq2TZo8c=;
        b=c0Y94d0Dwl6jijHVA8xmu8DREZNq5Zej1GMsK8cieRrFyjXR2fNEltLgN35qbMzuIz
         BiJTvKFP1KRKxQEwhWnMzxJwN2uaF4OnKJLV9bApTWeqPR0c0fFDm3C4Sml7uwjBXHpC
         NIpxUenGcIGRjGMVt75HmgIwZeUYjSoCNvyAjxmx9xe3v6Ryk6PJcqU1Pxn7xOCOzVMF
         NTumazorle3LSzwG2n4UjpU3s7RV1Bf2EaCk9L1565jwiTuptMvbubx3V6u9gGnEJmiK
         F4dvdzI9DWiVCyc6FNZog9rpDZUadXQc9+FSxsSruRNqKhaBPkAyUc1K8Y5jdSUgApyc
         ZWWA==
X-Gm-Message-State: AOAM533yi2tzMce8ovYxUm1KdDqSLjIqa0agaj9VyaJyLeNdeoS0RLTS
        av+WK+hUKWqhXUTzrLSytamBJKBnjZh3yZTv5yYk9w==
X-Google-Smtp-Source: ABdhPJzmCzYw51IcVPfPmlbc4eeB5qwnEMYGJDj12g7Z7Wts0i2C3Tw6O2uiNZd87jJ7F7AWfQ2H8EeM1UL3meIYKTU=
X-Received: by 2002:a05:620a:13ea:: with SMTP id h10mr9971617qkl.30.1639595904803;
 Wed, 15 Dec 2021 11:18:24 -0800 (PST)
MIME-Version: 1.0
References: <20211215174524.1742389-1-robdclark@gmail.com> <20211215174524.1742389-3-robdclark@gmail.com>
In-Reply-To: <20211215174524.1742389-3-robdclark@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 15 Dec 2021 22:18:14 +0300
Message-ID: <CAA8EJpruB5kiynfJU93RzrmEiEZLYUyw+qEJoNgfcu4HK+7xFA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] drm/msm/disp: Export helper for capturing snapshot
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Rob Clark <robdclark@chromium.org>,
        Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Guo Zhengkui <guozhengkui@vivo.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Dec 2021 at 20:49, Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> We'll re-use this for debugfs.
>
> Signed-off-by: Rob Clark <robdclark@chromium.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>  drivers/gpu/drm/msm/disp/msm_disp_snapshot.c | 28 +++++++++++++++-----
>  drivers/gpu/drm/msm/disp/msm_disp_snapshot.h | 10 +++++++
>  2 files changed, 31 insertions(+), 7 deletions(-)
>


-- 
With best wishes
Dmitry
