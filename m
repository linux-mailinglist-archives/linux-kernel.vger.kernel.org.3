Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 430B7487D58
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 20:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbiAGTxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 14:53:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbiAGTxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 14:53:52 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B7BC061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 11:53:51 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id s8-20020a0568301e0800b00590a1c8cc08so1827766otr.9
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 11:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QCWW9l5TYpSQZW7IxxLh+Bgf0Q6VOgQSqAtLWyGSPG8=;
        b=TSvb+oZLVoX48cum8Tneyp4hOVRDoWpx43qobWvAqcV210AucgvxhLWdQdLxxtWQQB
         jAtLe7wcu5JD1u9jwbPfnqPiDwIUNhW5t3rT2A6TenGk26VT7u7QFw1xIsNysbO1GoJK
         EOw2wRBVkRwMtvgoIBXfJ0aE4Gvcaop5VWoojwhdL2CvNnrlZDEiju2vwIRk87XegqRe
         w8KSPFDuZtQl8jR5NqlutMQ5Q/eKDXZl7CZ8yIMBt0Xm1zgEAR/yBwAZmswQS7kBJ+4Z
         IyxFY5DVfV3Dcd5VIryoTDS40YVJsRt7rLGB8B12lwpjQtYDz+nHesX/aIA2Q10S07nv
         lDYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QCWW9l5TYpSQZW7IxxLh+Bgf0Q6VOgQSqAtLWyGSPG8=;
        b=TmFxdTFth0dXnDGrIV6RdKasblCpoan04orNmdKKvrwbJaMrNaE1E/tXEieZRcbNBM
         C38RpCAs64Yp2Lh9jasTJ7wB3r/K32kr/uNmPzqqbcPjNHmusDjerl8iU6rI9GeQbNAQ
         S+iFkQw7g8bPF4tYTF539BQxI6pN8B3DjrjRaSNdbsL5Qwa1og/Llud2+Ukwx/obaTWK
         3l0fqnsB4VsAM0j+YSebGlnEVItPrkidwV8z7A1xuKt7EhFhuJTwvH0nKC/tUbCfdVyo
         7cqLH8YefC7lvOmbNp1Ha0R62rQSIIsEDOS+1z/qztUlJU3IOVs6wRVaI0gGM8kA8mnD
         c6Cg==
X-Gm-Message-State: AOAM533soBQsAhEyOs8xPy+mG+1AVaJLmoA8Mw6ljlgkoEtdVeyk51cI
        8MAld+XOVYo/eQis/ebSfOgydbw0A5ShJbvFc4I=
X-Google-Smtp-Source: ABdhPJyXnHKGLUUrWi9ONP1JYi50W6b4XY0LDv8Cc+uSqLxZ1hoRdPKME4Nr7/LktZjOyhNhOIlrzo3B7/+IwHBnZcI=
X-Received: by 2002:a9d:6390:: with SMTP id w16mr48527995otk.200.1641585230853;
 Fri, 07 Jan 2022 11:53:50 -0800 (PST)
MIME-Version: 1.0
References: <20211230040626.646807-1-victor.liu@nxp.com>
In-Reply-To: <20211230040626.646807-1-victor.liu@nxp.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 7 Jan 2022 14:53:39 -0500
Message-ID: <CADnq5_PsxrYeZ+p5NbXRks3EaJrYNMN+vbUJkiKHZ4cf=x=dsg@mail.gmail.com>
Subject: Re: [PATCH] drm/atomic: Check new_crtc_state->active to determine if
 CRTC needs disable in self refresh mode
To:     Liu Ying <victor.liu@nxp.com>
Cc:     Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Clark <robdclark@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Sean Paul <seanpaul@chromium.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 29, 2021 at 11:07 PM Liu Ying <victor.liu@nxp.com> wrote:
>
> Actual hardware state of CRTC is controlled by the member 'active' in
> struct drm_crtc_state instead of the member 'enable', according to the
> kernel doc of the member 'enable'.  In fact, the drm client modeset
> and atomic helpers are using the member 'active' to do the control.
>
> Referencing the member 'enable' of new_crtc_state, the function
> crtc_needs_disable() may fail to reflect if CRTC needs disable in
> self refresh mode, e.g., when the framebuffer emulation will be blanked
> through the client modeset helper with the next commit, the member
> 'enable' of new_crtc_state is still true while the member 'active' is
> false, hence the relevant potential encoder and bridges won't be disabled.
>
> So, let's check new_crtc_state->active to determine if CRTC needs disable
> in self refresh mode instead of new_crtc_state->enable.
>
> Fixes: 1452c25b0e60 ("drm: Add helpers to kick off self refresh mode in drivers")
> Cc: Sean Paul <seanpaul@chromium.org>
> Cc: Rob Clark <robdclark@chromium.org>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Signed-off-by: Liu Ying <victor.liu@nxp.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Do you need someone to push this for you?

Alex

> ---
>  drivers/gpu/drm/drm_atomic_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> index a7a05e1e26bb..9603193d2fa1 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -1016,7 +1016,7 @@ crtc_needs_disable(struct drm_crtc_state *old_state,
>          * it's in self refresh mode and needs to be fully disabled.
>          */
>         return old_state->active ||
> -              (old_state->self_refresh_active && !new_state->enable) ||
> +              (old_state->self_refresh_active && !new_state->active) ||
>                new_state->self_refresh_active;
>  }
>
> --
> 2.25.1
>
