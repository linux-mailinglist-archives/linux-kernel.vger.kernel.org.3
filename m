Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A92F4656DC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 21:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344607AbhLAUHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 15:07:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245437AbhLAUHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 15:07:45 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260FBC061574
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 12:04:24 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id bf8so50935625oib.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 12:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gNibeRohHDnBf3Tf3ZwWeQm6vav5gbJko9AzXB4JdnE=;
        b=W8oD8sK5M3DtjSF5B8h4ww0GCkEP00y6YSU4iTmdYlaS8XiebJfwYsiENMur5nsT8y
         w+3y5IwvLoUsWrXKIVy1NHLkiis+2It4sG09Dbvp8SMIs9E5fmxXeHCL9+60EPNsbYWx
         kE4H3yepWi1spYfXNLId6a8p4CZKrp2D2FjiAhLUHzB354yvoiiGtsPk+qw5vVQjdLUm
         132N8HrrJ+v8ysIU2NKy7o16gtPhYtFDUdMVoAnI/dRpzOVAXllKt8OJUF+idKDkN1YI
         DUX3ExzECkOqlL2mVIWhApRze2se6k7NKEx47GXg4aHoAJEUMbHvtAVy4YhBUNxbg+0z
         rZBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gNibeRohHDnBf3Tf3ZwWeQm6vav5gbJko9AzXB4JdnE=;
        b=a9CYL21I0UgxYKZFw7YK1CG4ik0FKRzjixw1N/r43tRFSsEL64gQOoDOKp3ah+QCig
         det6b8kwkklCHfaMbvR5zy8rWeN4GzfzNti9IIZQ1kczlp8ulNvvviBoat88GnfDvyPt
         eVRoKwwXO7PT/1ReVN+gKwFffX5uWvCHWOGrnrzOMXv6Rj+ZivKrxGqWjrwaA+LzGUEh
         i1/lVaDh92z+wyQcfq+L74LnGnauOtq1HN7MeqkzBCG+7hy0NFsoFYFtBUp/Gfp9QPiS
         c25ief0v6qDpJCr6XKP+ji7lAn8lqUBWbo855c9BpurCl/0cY0yjXmfhEWBIqS+qkof1
         L1/Q==
X-Gm-Message-State: AOAM5303V2Ts74mvymHNndvIoHXIg1GJv5R8LF9X6t/4clsvGD/NnOcl
        ovEz7CaKiIq7Q7UjWuAQm/prQNC0YhYikJVkiIs=
X-Google-Smtp-Source: ABdhPJwDMNr2tA0qqHWz0509+tWjBzPQqB1bqESBTlKPcLPImrrPy7C3+d69EAYHFau7J8vFwDoAsuPOcyzwKDDn7Hg=
X-Received: by 2002:a05:6808:300b:: with SMTP id ay11mr415925oib.120.1638389063521;
 Wed, 01 Dec 2021 12:04:23 -0800 (PST)
MIME-Version: 1.0
References: <20211130144827.163717-1-zhou1615@umn.edu>
In-Reply-To: <20211130144827.163717-1-zhou1615@umn.edu>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 1 Dec 2021 15:04:12 -0500
Message-ID: <CADnq5_ONy+=6ufko6aBiTDwBsUuRGqqJxcDvNmAEoELUMJMxWw@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon/radeon_connectors: Fix a NULL pointer
 dereference in radeon_fp_native_mode()
To:     Zhou Qingyang <zhou1615@umn.edu>
Cc:     David Airlie <airlied@linux.ie>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, Kangjie Lu <kjlu@umn.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Dave Airlie <airlied@redhat.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 9:49 AM Zhou Qingyang <zhou1615@umn.edu> wrote:
>
> In radeon_fp_native_mode(), the return value of drm_mode_duplicate() is
> assigned to mode and there is a dereference of it in
> radeon_fp_native_mode(), which could lead to a NULL pointer
> dereference on failure of drm_mode_duplicate().
>
> Fix this bug by adding a check of mode.
>
> This bug was found by a static analyzer. The analysis employs
> differential checking to identify inconsistent security operations
> (e.g., checks or kfrees) between two code paths and confirms that the
> inconsistent operations are not recovered in the current function or
> the callers, so they constitute bugs.
>
> Note that, as a bug found by static analysis, it can be a false
> positive or hard to trigger. Multiple researchers have cross-reviewed
> the bug.
>
> Builds with CONFIG_DRM_RADEON=m show no new warnings,
> and our static analyzer no longer warns about this code.
>
> Fixes: d2efdf6d6f42 ("drm/radeon/kms: add cvt mode if we only have lvds w/h and no edid (v4)")
> Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
> ---
>  drivers/gpu/drm/radeon/radeon_connectors.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_connectors.c b/drivers/gpu/drm/radeon/radeon_connectors.c
> index 607ad5620bd9..49f187614f96 100644
> --- a/drivers/gpu/drm/radeon/radeon_connectors.c
> +++ b/drivers/gpu/drm/radeon/radeon_connectors.c
> @@ -473,6 +473,9 @@ static struct drm_display_mode *radeon_fp_native_mode(struct drm_encoder *encode
>             native_mode->vdisplay != 0 &&
>             native_mode->clock != 0) {
>                 mode = drm_mode_duplicate(dev, native_mode);
> +               if (!mode)
> +                       return NULL;
> +

The else if clause needs a similar check.  Care to fix that up as well?

Alex

>                 mode->type = DRM_MODE_TYPE_PREFERRED | DRM_MODE_TYPE_DRIVER;
>                 drm_mode_set_name(mode);
>
> --
> 2.25.1
>
