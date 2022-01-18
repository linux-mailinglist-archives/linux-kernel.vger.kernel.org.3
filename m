Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 672D3492F1E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 21:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349110AbiARURB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 15:17:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234274AbiARURA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 15:17:00 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446C1C061574
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 12:17:00 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id t4-20020a05683022e400b00591aaf48277so25846484otc.13
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 12:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=He49yW7OyJJZQm4z6JSnGw3avbkaRtaS3bqUTuhHunc=;
        b=XuITQ2FaV6SooarHn5WnGL2EmHNlAsAIIy1rnRhSYfbOSxlAijkcvN6cF0KrUY49or
         e9TQUbVoJy9NcWRJm5WOUcAT680yX93YjYtL67LPnzEdWTtrDIu6iWy3BfpAtoCFUT9d
         3fcjinfectzksRwnOc98D4rw759DrpdnaKBDtGf+J/1mcBMXMw33CfbeubtGU5UZtSoL
         pYcTPZU1GWEk+ri0P5ClUk5KurrM17v33bjuO/+kRJ2ch8Z3QKDX+VQZaeh8qic9ZKhN
         vKORlYVLApuut6NPojyQmeqGNwKncRPIeWVH7f+jIMSDegowVwXTCTxUwzyZGe55KR2L
         B0Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=He49yW7OyJJZQm4z6JSnGw3avbkaRtaS3bqUTuhHunc=;
        b=W6H/RDP5WsoMNjjR2PJ8c09dNz9N4bGbqNp7rmXNvBtbV1ynzxk0Cziz5qCEgiC179
         tZDakGXJEgJP+VxuHLzqnofQMSAT2pcvTtAJxIGStRrHP78jiyEMpcV7Bo7KL5je/Dlw
         2+TdRXlKgEcvhK4S2Rp4MyXBnrPpD0YyJuyyvYLU2EDenelgS8a4qViieyBzNVFPlEGO
         Tph7wy89/tUq7rM3meX+00KvabS8LvMD2X2v96POskdy2iz9IuMOyjcEJxMWxd8Z0kzw
         A/r03zg9p+0Nz0jH0/NbOvq5Yg8B0d0fgKI612StreBj0agEB5jQoaWyC4JjumuF9ve0
         zkng==
X-Gm-Message-State: AOAM532dxlI0abaCxc1b8te0YzPeiMiKc/xk4yVuP9TlrjKlxjqdPqWd
        z+eOCnZFq4L0Ixn/Ha0DmBbSVhM4J6fhhRyJuMU=
X-Google-Smtp-Source: ABdhPJyEoz0zXwrzFuBM2JIVgjhTpd4kPETh6fm7uOfPE7ttfRQg6574AJwyvrb+0D3mIMPKuaRWt0oKed0v3J96Dss=
X-Received: by 2002:a9d:12f7:: with SMTP id g110mr22360780otg.299.1642537019635;
 Tue, 18 Jan 2022 12:16:59 -0800 (PST)
MIME-Version: 1.0
References: <20220117074731.29882-1-maqianga@uniontech.com> <581d4658-0f12-f355-0c4c-4b0da9b23d61@amd.com>
In-Reply-To: <581d4658-0f12-f355-0c4c-4b0da9b23d61@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 18 Jan 2022 15:16:48 -0500
Message-ID: <CADnq5_OoB90EGoujeLaK+iSQig=K0uzysM-OSLFhJAy0e4T9_w@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: fix UVD suspend error
To:     Leo Liu <leo.liu@amd.com>
Cc:     Qiang Ma <maqianga@uniontech.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Mon, Jan 17, 2022 at 3:05 PM Leo Liu <leo.liu@amd.com> wrote:
>
>
> On 2022-01-17 2:47 a.m., Qiang Ma wrote:
> > I met a bug recently and the kernel log:
> >
> > [  330.171875] radeon 0000:03:00.0: couldn't schedule ib
> > [  330.175781] [drm:radeon_uvd_suspend [radeon]] *ERROR* Error destroying UVD (-22)!
> >
> > In radeon drivers, using UVD suspend is as follows:
> >
> > if (rdev->has_uvd) {
> >          uvd_v1_0_fini(rdev);
> >          radeon_uvd_suspend(rdev);
> > }
> >
> > In radeon_ib_schedule function, we check the 'ring->ready' state,
> > but in uvd_v1_0_fini funciton, we've cleared the ready state.
> > So, just modify the suspend code flow to fix error.
>
> It seems reasonable to me. The suspend sends the destroy message if
> there is still incomplete job, so it should be before the fini which
> stops the hardware.
>
> The series are:
>
> Reviewed-by: Leo Liu <leo.liu@amd.com>
>
>
> >
> > Signed-off-by: Qiang Ma <maqianga@uniontech.com>
> > ---
> >   drivers/gpu/drm/radeon/cik.c       | 2 +-
> >   drivers/gpu/drm/radeon/evergreen.c | 2 +-
> >   drivers/gpu/drm/radeon/ni.c        | 2 +-
> >   drivers/gpu/drm/radeon/r600.c      | 2 +-
> >   drivers/gpu/drm/radeon/rv770.c     | 2 +-
> >   drivers/gpu/drm/radeon/si.c        | 2 +-
> >   6 files changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/radeon/cik.c b/drivers/gpu/drm/radeon/cik.c
> > index 81b4de7be9f2..5819737c21c6 100644
> > --- a/drivers/gpu/drm/radeon/cik.c
> > +++ b/drivers/gpu/drm/radeon/cik.c
> > @@ -8517,8 +8517,8 @@ int cik_suspend(struct radeon_device *rdev)
> >       cik_cp_enable(rdev, false);
> >       cik_sdma_enable(rdev, false);
> >       if (rdev->has_uvd) {
> > -             uvd_v1_0_fini(rdev);
> >               radeon_uvd_suspend(rdev);
> > +             uvd_v1_0_fini(rdev);
> >       }
> >       if (rdev->has_vce)
> >               radeon_vce_suspend(rdev);
> > diff --git a/drivers/gpu/drm/radeon/evergreen.c b/drivers/gpu/drm/radeon/evergreen.c
> > index eeb590d2dec2..455f8036aa54 100644
> > --- a/drivers/gpu/drm/radeon/evergreen.c
> > +++ b/drivers/gpu/drm/radeon/evergreen.c
> > @@ -5156,8 +5156,8 @@ int evergreen_suspend(struct radeon_device *rdev)
> >       radeon_pm_suspend(rdev);
> >       radeon_audio_fini(rdev);
> >       if (rdev->has_uvd) {
> > -             uvd_v1_0_fini(rdev);
> >               radeon_uvd_suspend(rdev);
> > +             uvd_v1_0_fini(rdev);
> >       }
> >       r700_cp_stop(rdev);
> >       r600_dma_stop(rdev);
> > diff --git a/drivers/gpu/drm/radeon/ni.c b/drivers/gpu/drm/radeon/ni.c
> > index 4a364ca7a1be..927e5f42e97d 100644
> > --- a/drivers/gpu/drm/radeon/ni.c
> > +++ b/drivers/gpu/drm/radeon/ni.c
> > @@ -2323,8 +2323,8 @@ int cayman_suspend(struct radeon_device *rdev)
> >       cayman_cp_enable(rdev, false);
> >       cayman_dma_stop(rdev);
> >       if (rdev->has_uvd) {
> > -             uvd_v1_0_fini(rdev);
> >               radeon_uvd_suspend(rdev);
> > +             uvd_v1_0_fini(rdev);
> >       }
> >       evergreen_irq_suspend(rdev);
> >       radeon_wb_disable(rdev);
> > diff --git a/drivers/gpu/drm/radeon/r600.c b/drivers/gpu/drm/radeon/r600.c
> > index ca3fcae2adb5..dd78fc499402 100644
> > --- a/drivers/gpu/drm/radeon/r600.c
> > +++ b/drivers/gpu/drm/radeon/r600.c
> > @@ -3232,8 +3232,8 @@ int r600_suspend(struct radeon_device *rdev)
> >       radeon_audio_fini(rdev);
> >       r600_cp_stop(rdev);
> >       if (rdev->has_uvd) {
> > -             uvd_v1_0_fini(rdev);
> >               radeon_uvd_suspend(rdev);
> > +             uvd_v1_0_fini(rdev);
> >       }
> >       r600_irq_suspend(rdev);
> >       radeon_wb_disable(rdev);
> > diff --git a/drivers/gpu/drm/radeon/rv770.c b/drivers/gpu/drm/radeon/rv770.c
> > index e592e57be1bb..38796af4fadd 100644
> > --- a/drivers/gpu/drm/radeon/rv770.c
> > +++ b/drivers/gpu/drm/radeon/rv770.c
> > @@ -1894,8 +1894,8 @@ int rv770_suspend(struct radeon_device *rdev)
> >       radeon_pm_suspend(rdev);
> >       radeon_audio_fini(rdev);
> >       if (rdev->has_uvd) {
> > -             uvd_v1_0_fini(rdev);
> >               radeon_uvd_suspend(rdev);
> > +             uvd_v1_0_fini(rdev);
> >       }
> >       r700_cp_stop(rdev);
> >       r600_dma_stop(rdev);
> > diff --git a/drivers/gpu/drm/radeon/si.c b/drivers/gpu/drm/radeon/si.c
> > index 013e44ed0f39..8d5e4b25609d 100644
> > --- a/drivers/gpu/drm/radeon/si.c
> > +++ b/drivers/gpu/drm/radeon/si.c
> > @@ -6800,8 +6800,8 @@ int si_suspend(struct radeon_device *rdev)
> >       si_cp_enable(rdev, false);
> >       cayman_dma_stop(rdev);
> >       if (rdev->has_uvd) {
> > -             uvd_v1_0_fini(rdev);
> >               radeon_uvd_suspend(rdev);
> > +             uvd_v1_0_fini(rdev);
> >       }
> >       if (rdev->has_vce)
> >               radeon_vce_suspend(rdev);
