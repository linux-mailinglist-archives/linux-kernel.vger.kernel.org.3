Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDCF4762B9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 21:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234712AbhLOUKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 15:10:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234378AbhLOUKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 15:10:00 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8E5C061574;
        Wed, 15 Dec 2021 12:10:00 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id t18so40114089wrg.11;
        Wed, 15 Dec 2021 12:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9fwJJay5x47r2hBghamMydvV9fq4hGtlRRKE3PJ0IAc=;
        b=BKaQzk9NyxAqLkWnM4c8toF7n05vdSF75w7lD8VPAskRuFElT7GXRdHro2MkTBM9Uj
         GFmEO8rsZVEMLm7A/IxB49zMs0kAum00uKlXE6KculfLdpdeZ0VIOpUmhAEy1Djw8Pm6
         9xR8XagaGFUffrcB8IXViHAv6jQe232mySn3WfyJ1PvkqEBj+FFF1+z9xFayw4hBGpxv
         pWV4uGyXFw00ujRNkcOS4zDuT0z7O5bA7Mm/BEvlMZttF6YB7V+f/7MdMNMTN2E5V3O6
         kEtP1rEwsAFj5sOUSByAz+e+uVyOq7q6SsKdm1uUe6ZF2ajHEyJuJrAWlpnIzoAtVnfb
         lXcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9fwJJay5x47r2hBghamMydvV9fq4hGtlRRKE3PJ0IAc=;
        b=Ys8Cfg7TdkJTakFSw/FPNLXM/EbEhhKU9Hl/uthyGZC22Qgpp876tI1bIymEdWaX2R
         H5Jl8mMiZ+U1/oLJV+OZY9iEU28kAr/QLNtnGbx8N74e3+GyyQTeyisY8nUnbUMpYHDu
         cRFDloF8SUfH70cMoabyqxZjSe3r9O1/q8WEENZiM5muyop44lUSd1L4ydCcl5VkoT+/
         mmTw4TrkdF+IjAkDINcPDfoV6IetCaf513L/45bypp5DsrNpBkXR5uLEnemYZsBlGOed
         tj02/QO/pMgr1BbtXt9zv97GKxPUnIQgPvygtK1L84x4wIbJQQAJN/mV2cNa8nAY2d7M
         OTgQ==
X-Gm-Message-State: AOAM533A1HBlH/qFh/loirlgRba7cwMh20pYmEVYt5smtC7cpO54A/AT
        2n8cmvdPb/a4DjnpzDGk7bkkTbkiabs/sMmN0VU=
X-Google-Smtp-Source: ABdhPJwkv3UG4cKShRx3f7/OeRZlRq4dZYeasRuU92iCRfO52EWo3lhGFGjRnkGj59tcU5Y7uA3xvAUmayT0BTzg338=
X-Received: by 2002:adf:eac8:: with SMTP id o8mr4889507wrn.93.1639598998659;
 Wed, 15 Dec 2021 12:09:58 -0800 (PST)
MIME-Version: 1.0
References: <20211215174524.1742389-1-robdclark@gmail.com> <20211215174524.1742389-2-robdclark@gmail.com>
 <CAA8EJpri+3AjazR2saJaa3Uo05BhC_2gEsRXHJ5wJ81zs5AUTw@mail.gmail.com>
In-Reply-To: <CAA8EJpri+3AjazR2saJaa3Uo05BhC_2gEsRXHJ5wJ81zs5AUTw@mail.gmail.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Wed, 15 Dec 2021 12:15:18 -0800
Message-ID: <CAF6AEGsZmQR8FvAN5GrDT9psBsNwFL5mWRZq+i0rFcC8Zf09fQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] drm/msm/disp: Tweak display snapshot to match gpu snapshot
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
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

On Wed, Dec 15, 2021 at 11:17 AM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Wed, 15 Dec 2021 at 20:49, Rob Clark <robdclark@gmail.com> wrote:
> >
> > From: Rob Clark <robdclark@chromium.org>
> >
> > Add UTS_RELEASE and show timestamp the same way for consistency.
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>
> > ---
> >  drivers/gpu/drm/msm/disp/msm_disp_snapshot.h      | 4 ++--
> >  drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c | 9 ++++++---
> >  2 files changed, 8 insertions(+), 5 deletions(-)
>
> We should pull this out of disp/, it's no longer disp-specific.

Or possibly just move dsi/etc into disp?  It is disp specific in the
sense that dumping GPU state works quite differently..

BR,
-R

>
> --
> With best wishes
> Dmitry
