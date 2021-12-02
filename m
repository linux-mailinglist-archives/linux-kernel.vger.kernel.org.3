Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 911194668DC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 18:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359835AbhLBRNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 12:13:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235350AbhLBRNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 12:13:45 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D502CC06174A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 09:10:22 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id 35-20020a9d08a6000000b00579cd5e605eso600378otf.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 09:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3WayNfqfYACfpbERzCtZCuTnUQRk8ktnSw63UP5xFjE=;
        b=a618i81ZV9JVXx+IZ/d1w1zmAk/IeXGu0wUb929VY3G5KhUufp3jFW+XuYZaZ6OSEb
         lv0QzOCVZjSimWE6x5anfaeHNQQhQZn8z3zGMJhuO6JdRJNY7Hb+UJDiAioOT5Z6pWJL
         TY9hSVTI8z+8e33sEYOAnkMydqNJS6U2rOxE7EfIiF8FSb4IuXsfTfF8ERspEtnlwSaI
         prlS8r83NORVHQEaFJKepdgLWZOIdC1K/mr9nxSovltq3qSAR4/HIS+o72vKjHpCiWUY
         +VN83ksIjGI/K/QbG3sGct7jEt6qlIpyHojzwZN6FYNLNa9Z+H5l+AyFAZcBPGaga/6x
         ZI2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3WayNfqfYACfpbERzCtZCuTnUQRk8ktnSw63UP5xFjE=;
        b=tt6JCUAlpfFzSUAQ66cSpQ1tpfIhZrogTFXKMXJyMoKEoCMZiGXeRx4LBW0xhNf7Wn
         PylGwVkjSU2qzHwKd4cpKIkRJdTzZANB9tpxUiCg5546IFomVUCNBHbCB5ADxyybVl/+
         0QnAM8MAGed05T/R/0a0XV/kTR+MCx8zRtWLlSoChAzxypJVTNOqwT0JeLgV2ozj364K
         nVNLELG8Ufjpae5WZ+v0pHuUBhLbx6o3WzEQqemmjpjNB23Ow8ZviGjizwla+Id/Kzy8
         FL8tcM/gGtjcFa9g24hPUHKmQHCroAkSoQg0mJMrCDFolUyx2WWi2UxPno8X71smw8PI
         doqw==
X-Gm-Message-State: AOAM532p0M3/dww976Zgx9KKbhf6jpY2wavfnUdlkkevTJYJimSKmXDK
        5U0bus+Fi+PEoE6Pbu1fT6iC9cbJtA3w+aiKBrg=
X-Google-Smtp-Source: ABdhPJzrkUf5R3KYcTa3CesqJov61lKyaXuCS3yOQezyTdB0qn7VhnDLKacPNbFj0iU++cfMWNRw3m/BkkFN/2qFF6A=
X-Received: by 2002:a9d:67c1:: with SMTP id c1mr12454183otn.299.1638465022218;
 Thu, 02 Dec 2021 09:10:22 -0800 (PST)
MIME-Version: 1.0
References: <CADnq5_P8amQK60zD-2tkVWBneZCoLENe5KY_S6eqoAAyOieatg@mail.gmail.com>
 <20211202161738.79176-1-zhou1615@umn.edu>
In-Reply-To: <20211202161738.79176-1-zhou1615@umn.edu>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 2 Dec 2021 12:10:10 -0500
Message-ID: <CADnq5_OZkc9oCFut1cmX+-RaJreVxH7T94seCdgKSgq2xyaSnw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: Fix a NULL pointer dereference in amdgpu_connector_lcd_native_mode()
To:     Zhou Qingyang <zhou1615@umn.edu>
Cc:     Jammy Zhou <Jammy.Zhou@amd.com>, David Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, Kangjie Lu <kjlu@umn.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        hongao <hongao@uniontech.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Thu, Dec 2, 2021 at 11:17 AM Zhou Qingyang <zhou1615@umn.edu> wrote:
>
> In amdgpu_connector_lcd_native_mode(), the return value of
> drm_mode_duplicate() is assigned to mode, and there is a dereference
> of it in amdgpu_connector_lcd_native_mode(), which will lead to a NULL
> pointer dereference on failure of drm_mode_duplicate().
>
> Fix this bug add a check of mode.
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
> Builds with CONFIG_DRM_AMDGPU=m show no new warnings, and
> our static analyzer no longer warns about this code.
>
> Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
> Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
> ---
> Changes in v2:
>   -  Fix the similar bug in else clause
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> index 0de66f59adb8..df1f9b88a53f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> @@ -387,6 +387,9 @@ amdgpu_connector_lcd_native_mode(struct drm_encoder *encoder)
>             native_mode->vdisplay != 0 &&
>             native_mode->clock != 0) {
>                 mode = drm_mode_duplicate(dev, native_mode);
> +               if (!mode)
> +                       return NULL;
> +
>                 mode->type = DRM_MODE_TYPE_PREFERRED | DRM_MODE_TYPE_DRIVER;
>                 drm_mode_set_name(mode);
>
> @@ -401,6 +404,9 @@ amdgpu_connector_lcd_native_mode(struct drm_encoder *encoder)
>                  * simpler.
>                  */
>                 mode = drm_cvt_mode(dev, native_mode->hdisplay, native_mode->vdisplay, 60, true, false, false);
> +               if (!mode)
> +                       return NULL;
> +
>                 mode->type = DRM_MODE_TYPE_PREFERRED | DRM_MODE_TYPE_DRIVER;
>                 DRM_DEBUG_KMS("Adding cvt approximation of native panel mode %s\n", mode->name);
>         }
> --
> 2.25.1
>
