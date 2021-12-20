Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1808847B64D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 00:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233149AbhLTXxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 18:53:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbhLTXxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 18:53:17 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C87C06173E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 15:53:17 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id de30so11039410qkb.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 15:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NcXgqI6cxpe0e91iQv5hDRD0JOXrVC93a0bIwF8hPSM=;
        b=Ws1YkYkUr9UQiyjkjzcDfhUOL2xPU099pRZc/DVWPUqgSkTISCxkmbTnZUDKAzLfWA
         rXurwah7hW92RHgf4AfGporMV6jEGkWvykl1RhJbiY6Z31s88Vn+zEc35OMnbIZYeSP4
         CepC8EGG3Wii+57keP6eq1lsupwPUR+cgohunTTfdwPD7cZEJd2p0zmSqtyvcRd+Rpae
         +WIcvTi7P1Ey8W9eCBHQCRtVsuIwp70EIDu8b0sTFvy1ELF5TKrMhG3WZSojc0zMFxzX
         x54Z6g9bakthG8guJwl5gMXlk17VPKWIXt+cBnzITS6vFSkkMqmhoLdoJ5CfEU0dYCJS
         xChw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NcXgqI6cxpe0e91iQv5hDRD0JOXrVC93a0bIwF8hPSM=;
        b=KLVXlErfJ/HHcbOfhxXK8PqhIWTBJor44ygNFiLjhso/RIhBL0qAVJwpX1S6D0FiTl
         Ma46TOXGVYPk+n5qmw/CII1Fz1t6OKCwzhVFwsJe52s4qp4Xqs/e4Bw1okgUtBmaD63O
         z1jgiSQujE9LggVYknBif8rcaVdy0XPlz3FUkTKGt478vzs351i/KGFjaybM4xYrt/Wk
         +D3OPZ40erT8TzOR+kqDxjMtoRBRi6vnBnd+m2E8RR7mPWARifXNteq4M+y1T1y15kG4
         tph7CGu2k4P1TSPksKD6xS4oG+Swh+G1Yhy2FpdI+Q8rwSSD1DFogZAxrCiKgOnSY/Lu
         WObA==
X-Gm-Message-State: AOAM533X1NTt20lWl/ESrO84QEBFGyJlwHrNzw8y7O9jS1GD+YzzwfWj
        V1YWHsAdd6EXWUTAeHs2W4NIgdrYvZ328+E9P34C9Q==
X-Google-Smtp-Source: ABdhPJzFnDz2W0GHUrVIingh+4j+ON9BLU7ywtLTtBYgCoWWu0JGYwbykopD9mXXSuORzJrQ8/OZ1svpmcADUPTh3JU=
X-Received: by 2002:a05:620a:13ea:: with SMTP id h10mr476112qkl.30.1640044396450;
 Mon, 20 Dec 2021 15:53:16 -0800 (PST)
MIME-Version: 1.0
References: <20211217002026.2304973-1-bjorn.andersson@linaro.org>
In-Reply-To: <20211217002026.2304973-1-bjorn.andersson@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 21 Dec 2021 02:53:05 +0300
Message-ID: <CAA8EJpoYJFfB5qfFMoc3-QsmYZzO16C28MOrPyokANQyPBhdyg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/msm/dp: Only create debugfs for PRIMARY minor
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Dec 2021 at 03:19, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> dpu_kms_debugfs_init() is invoked for each minor being registered. Most
> of the files created are unrelated to the minor, so there's no reason to
> present them per minor.
> The exception to this is the DisplayPort code, which ends up invoking
> dp_debug_get() for each minor, each time associate the allocated object
> with dp->debug.
>
> As such dp_debug will create debugfs files in both the PRIMARY and the
> RENDER minor's debugfs directory, but only the last reference will be
> remembered.
>
> The only use of this reference today is in the cleanup path in
> dp_display_deinit_sub_modules() and the dp_debug_private object does
> outlive the debugfs entries in either case, so there doesn't seem to be
> any adverse effects of this, but per the code the current behavior is
> unexpected, so change it to only create debugfs files for the PRIMARY
> minor.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>
> Changes since v1:
> - Moved the check up from msm_dp_debugfs_init() to dpu_kms_debugfs_init()
>
>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> index 2ee70072a1b4..a54f7d373f14 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> @@ -193,6 +193,10 @@ static int dpu_kms_debugfs_init(struct msm_kms *kms, struct drm_minor *minor)
>         if (!p)
>                 return -EINVAL;
>
> +       /* Only create one set of debugfs per DP instance */

The comment is misleading. Could you please fix it?

> +       if (minor->type != DRM_MINOR_PRIMARY)
> +               return 0;
> +
>         dev = dpu_kms->dev;
>         priv = dev->dev_private;
>
> --
> 2.33.1
>


-- 
With best wishes
Dmitry
