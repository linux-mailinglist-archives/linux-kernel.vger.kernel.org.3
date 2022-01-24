Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3C9849A804
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1315894AbiAYCyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 21:54:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S3409749AbiAYA1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 19:27:18 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D0FC046E0D;
        Mon, 24 Jan 2022 14:10:07 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id n6-20020a9d6f06000000b005a0750019a7so2596237otq.5;
        Mon, 24 Jan 2022 14:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dfQ1Cr8MOGNWzImPgM3FPvJ3DRDIShXaWCzTw2fuiGo=;
        b=Z+F0etylmIPRLfXkQxHrbCduqN93SYw7wl/ke/YpNeM4rPaukRCnKxTe71ymWVnYxP
         7Vp4nnlA+M4Rm1eAhkuZw7yqe9BkTYhucCx+9Fsb6LaMeeQg6V2LonO6YxMnEKLTLNWf
         ThtFvcc/fRFn4UZPlVRhL+vS5U3wQmnxEtFLUPWE3obBRz8H/TwYkyRptXqFHff3vgKB
         jcy7q9coHrKyr3wha1pNcOuLmgUKjtbpCVRunpmpzDKtiFy4PTDQ6ZyeH6WC1swXj9wH
         1gUQHxkh7d72RWBkcPCYm2r14IlbhITnuWDjv0rAlIdb7LUIu60GlZpkmIhgWB5EqtZk
         o1eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dfQ1Cr8MOGNWzImPgM3FPvJ3DRDIShXaWCzTw2fuiGo=;
        b=jIjGTjM2GDixBCvyqqZwMd4H8icOPehTYjUxp/co5i3uthLq3AYzK0AdICpvl6M7ij
         0Mnm/flsHy7Dm88UbWW8A0XjrIKZ+lwSj4oouDGzTV0GecSYpfkDhHELYoi2FD5ObpEr
         6yfsKzxoJ7drfxQw7FO6keR3x6i2SGFw6q+p3wXxte9XdUR0qxI/b3xWJlJ7M1IAYRCk
         2XR66nVm8eb0vd6BzrnM6nHqlUX7hdwtz01dky/3MxroK9caHnMdXZTHm5P8UK0Iy8X2
         3u73KKOdUegjLQnxdc7F6v7XtafHC/P07SyV3EIbRHi+G2aitSKJLPDYlSbEC/wfTMqv
         W4fw==
X-Gm-Message-State: AOAM530RfR2LQrZbhbBi/6Oryk/dMwA241tUfYKs2y2/Kw/Of2WHvf43
        Ii/2bknvfs/Ned2YJJx0EYKsfm9GiT5P21RtgB4=
X-Google-Smtp-Source: ABdhPJwvLyrL8/z3f3oeYcfh5RaeZB2rvDsalLA+HVQ+FDuwfMu1r9GNC9grwWebJSLxVHBZqstuKTAHNHQYm1JYjGE=
X-Received: by 2002:a05:6830:1d90:: with SMTP id y16mr13147279oti.200.1643062206810;
 Mon, 24 Jan 2022 14:10:06 -0800 (PST)
MIME-Version: 1.0
References: <20220119224628.123084-1-colin.i.king@gmail.com> <CAKwvOdnMibw77AvvWw7seB2PPamS_OLMUarSjdsa4w4OP1isKg@mail.gmail.com>
In-Reply-To: <CAKwvOdnMibw77AvvWw7seB2PPamS_OLMUarSjdsa4w4OP1isKg@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 24 Jan 2022 17:09:55 -0500
Message-ID: <CADnq5_P4F9MqfP2BHSzj7rgXBDxRPtiphh5sqF0+dW7NSTLFVA@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: remove redundant assignment to reg
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Colin Ian King <colin.i.king@gmail.com>, llvm@lists.linux.dev,
        David Airlie <airlied@linux.ie>,
        xinhui pan <Xinhui.Pan@amd.com>,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Mon, Jan 24, 2022 at 3:21 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Wed, Jan 19, 2022 at 2:46 PM Colin Ian King <colin.i.king@gmail.com> wrote:
> >
> > The pointer reg is being assigned a value that is not read, the
> > exit path via label 'out' never accesses it. The assignment is
> > redundant and can be removed.
> >
> > Cleans up clang scan build warning:
> > drivers/gpu/drm/radeon/radeon_object.c:570:3: warning: Value
> > stored to 'reg' is never read [deadcode.DeadStores]
> >
> > Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
>
> Thanks for the patch!
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>
> > ---
> >  drivers/gpu/drm/radeon/radeon_object.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/radeon/radeon_object.c b/drivers/gpu/drm/radeon/radeon_object.c
> > index 56ede9d63b12..87536d205593 100644
> > --- a/drivers/gpu/drm/radeon/radeon_object.c
> > +++ b/drivers/gpu/drm/radeon/radeon_object.c
> > @@ -567,7 +567,6 @@ int radeon_bo_get_surface_reg(struct radeon_bo *bo)
> >                 return 0;
> >
> >         if (bo->surface_reg >= 0) {
> > -               reg = &rdev->surface_regs[bo->surface_reg];
> >                 i = bo->surface_reg;
> >                 goto out;
> >         }
> > --
> > 2.33.1
> >
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers
