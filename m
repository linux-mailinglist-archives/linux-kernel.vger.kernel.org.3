Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61C3447617B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 20:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239643AbhLOTRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 14:17:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239478AbhLOTRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 14:17:49 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53237C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 11:17:49 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id q14so22899450qtx.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 11:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YShFWoZdfohuIaoHkzJfvwaOjJW0YWCrtgF0tbZxfuc=;
        b=UlCtoyzOkFrWyGOVFaJU8qsLzBhhoHooghGXITRKZE1Zq83KKPIb7c0zSx3QLeLT8L
         Y+xCxzUh1a6yaaBd3ZKqWBQN6fihrnKTkT7bhYZKbKdPrk9urj6tVs+v4zpgImJsz7a7
         gk7RQntBh0cyirDkrQeVsT/0aGZGbZHEDVAJrAs6SkRLSOrSp40EOM0zB+Hd28B52FNz
         qblXXrz6FFNXCQI5Jl/44mtLAArvcM4LRQ3XDj1+rv9YDKjnBpWUNatahXv3R8u+Uumi
         CRZ4Gj7RSyDxX8D+ydnP9DyPYCdMOiBYxPGc6TEUbmAh78HgRXO31fa8FpRejHglm8fg
         3bFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YShFWoZdfohuIaoHkzJfvwaOjJW0YWCrtgF0tbZxfuc=;
        b=s1yTW20iyDDWrUXP+NeD2ss22iUCO7bXJn2SuMZTCE+C/BOghlWEvguZrzc79IXrxt
         EDb6XbPQCAMej+QZCjTVuFWt/bmoGy1zD3JhoKqOWMU6PQAR7gwawVXqasb8nGAwjaWe
         7eG378+aUEHCiUYxvm4wi7ZVXfWY9uVRBKyjCmgwhcx8S+nRhrQUZOYbSrzr9Kx+4uOu
         y7RPt6L7j6l691QcUyEXTkVQpPOs1mc+d+lNT/W8ztYxaS6Dy3RO8LXKxjH5Uip3+20G
         8fgOePkIWTnpr/tg2ts6ZdfhdXcsERrqDo0gTkpFLZl07mzbXMcrUZnA65bho99PK0kZ
         N+eg==
X-Gm-Message-State: AOAM530FMN1ANCOpZ0dg4RUIU4uMbGsJdW4s+BTyEWv4Y9gkKtlxwvt2
        ZaTgk4MPEikSZYbT+wz/sxqSZssl8Plj7zOYL+e+Pw==
X-Google-Smtp-Source: ABdhPJzQ6zkCPECZcOmZlwDiF42Ds+mkiAEnmTOqZu1jr5lAXLAvu/wLfGhsMecRyWc/+WsXDPDGT2QtSA8ScDqEFfo=
X-Received: by 2002:a05:622a:15c6:: with SMTP id d6mr13380932qty.439.1639595868469;
 Wed, 15 Dec 2021 11:17:48 -0800 (PST)
MIME-Version: 1.0
References: <20211215174524.1742389-1-robdclark@gmail.com> <20211215174524.1742389-2-robdclark@gmail.com>
In-Reply-To: <20211215174524.1742389-2-robdclark@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 15 Dec 2021 22:17:37 +0300
Message-ID: <CAA8EJpri+3AjazR2saJaa3Uo05BhC_2gEsRXHJ5wJ81zs5AUTw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] drm/msm/disp: Tweak display snapshot to match gpu snapshot
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Rob Clark <robdclark@chromium.org>,
        Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Guo Zhengkui <guozhengkui@vivo.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Fernando Ramos <greenfoo@u92.eu>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Dec 2021 at 20:49, Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> Add UTS_RELEASE and show timestamp the same way for consistency.
>
> Signed-off-by: Rob Clark <robdclark@chromium.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>  drivers/gpu/drm/msm/disp/msm_disp_snapshot.h      | 4 ++--
>  drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c | 9 ++++++---
>  2 files changed, 8 insertions(+), 5 deletions(-)

We should pull this out of disp/, it's no longer disp-specific.


-- 
With best wishes
Dmitry
