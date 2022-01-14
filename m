Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 314B148EC13
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 15:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242117AbiANO6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 09:58:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242086AbiANO6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 09:58:38 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B64C061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 06:58:38 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id s127so12526583oig.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 06:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wfClCLv6Y1r8w1Mu+agZFlOnL6tT+xTZ/GoMhkTbfjo=;
        b=lla/8dPmgBwIE5Ye+/wPVYx4oODRSuU0LWqPXzTmjCkU1MHT4PyuZTKKBe3l/8maGy
         zGjT8mAseUGWVU1Fr5pUs90fhfl/4wIAzCJce1q26mz0N9EV894vNhMwd8xADKFb7MJX
         QSqE+Gu3lORLKfEe3P8Xo5gRH+Wh92nd+GVNSB0/0jJtbTztkUL+aR/+H0tceNsf1Wpv
         L2l4wB/y/iJs8GRZcLjRUQ9FfH583XbfrI+WT8SZs+04EURyFMwayApsm03ij2H2XLnL
         CGpG1IYL9fZu/EAhEZcqkqCWfIQdn2QEusCif3tdBVlBEVHX+ND0tMLJPQcDTqRm9F0a
         26Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wfClCLv6Y1r8w1Mu+agZFlOnL6tT+xTZ/GoMhkTbfjo=;
        b=aCMQHqYDKS36STUaTe3ILP9/Jv6bMKBqXP16M50yNUuCbA5IiyZXhIxkHZvxToLuUt
         gsVhM/2gfU9Ma772dX8n6cg1Hu52vKGSLNQluvoByN/+Ptx4fKCVso6BKj+cbcGPpaBL
         GlPjPCjJ8F2hNKCsNTcIlIlbbbWEccegzfvlkkgO2610BMuufF9ePmNFecUow5Br2Omr
         ZXtOp55X+sC+KRzPBLuzo9zTLpbf3EflvCsnVCgXvr8MOnTCC0MNTYFYt+1Izx1/raPi
         A9QVek0/gaApVj/W0UMrpdxuHiQKWb2iFMf3Izlj3rMfpYm/LesSbStasvAs68bPHz6D
         4obg==
X-Gm-Message-State: AOAM530U3YIhcQTvC4eZreTlqoNZKEYyY2ghJ4KA8F7s/hFyiDRh2XA9
        KueoTq6V09epaQ4Mh/rJZgE1R6NRONKljt3+8RbzjKF8
X-Google-Smtp-Source: ABdhPJz/wm3H+YEiAJ3MpcV1GlQbLxHcJ9Y/g45F2Nl022nbTv2aOmXXrx1SbSLP3iCas2q//oDlugM9xkV1SktK/RQ=
X-Received: by 2002:a05:6808:300b:: with SMTP id ay11mr7410616oib.120.1642172317794;
 Fri, 14 Jan 2022 06:58:37 -0800 (PST)
MIME-Version: 1.0
References: <20220114065141.14506-1-lukas.fink1@gmail.com> <CADnq5_PBt9-x9d9TuW7_0Yrarpmp2bMTdDPXFv2ep=p89sULkg@mail.gmail.com>
In-Reply-To: <CADnq5_PBt9-x9d9TuW7_0Yrarpmp2bMTdDPXFv2ep=p89sULkg@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 14 Jan 2022 09:58:27 -0500
Message-ID: <CADnq5_OVB-P2dE=ZZRXC2QsL6tFTXbZoaPw3FmK6XHECvZgZZg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix rejecting Tahiti GPUs
To:     Lukas Fink <lukas.fink1@gmail.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2022 at 9:56 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Fri, Jan 14, 2022 at 3:27 AM Lukas Fink <lukas.fink1@gmail.com> wrote:
> >
> > eb4fd29afd4a ("drm/amdgpu: bind to any 0x1002 PCI diplay class device") added
> > generic bindings to amdgpu so that that it binds to all display class devices
> > with VID 0x1002 and then rejects those in amdgpu_pci_probe.
> >
> > Unfortunately it reuses a driver_data value of 0 to detect those new bindings,
> > which is already used to denote CHIP_TAHITI ASICs.
> >
> > The driver_data value given to those new bindings was changed in
> > dd0761fd24ea1 ("drm/amdgpu: set CHIP_IP_DISCOVERY as the asic type by default")
> > to CHIP_IP_DISCOVERY (=36), but it seems that the check in amdgpu_pci_probe
> > was forgotten to be changed. Therefore, it still rejects Tahiti GPUs.
> >
> > Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1860
> > Fixes: eb4fd29afd4a ("drm/amdgpu: bind to any 0x1002 PCI diplay class device")
> >
> > Signed-off-by: Lukas Fink <lukas.fink1@gmail.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > index 9ec58bf74012..224d073022ac 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > @@ -1903,7 +1903,7 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
> >                         return -ENODEV;
> >         }
> >
> > -       if (flags == 0) {
> > +       if (flags == CHIP_IP_DISCOVERY) {
> >                 DRM_INFO("Unsupported asic.  Remove me when IP discovery init is in place.\n");
> >                 return -ENODEV;
> >         }
>
> Thanks.  Actually this entire check can be removed at this point.  The
> IP discovery support is in place.  I'll send a patch.

Actually, I'll take this patch and then send a patch to remove it on
top of that.  Thanks for fixing this.

Alex

>
> Alex
>
>
> > --
> > 2.34.1
> >
