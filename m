Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC0948EC10
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 15:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242097AbiANO4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 09:56:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242005AbiANO4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 09:56:38 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23AD2C061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 06:56:38 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id t6-20020a9d7746000000b005917e6b96ffso10307672otl.7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 06:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HXQISz6uUvwg8Vwt1+DIrxstrllwfzEuYjBo3yyTGQk=;
        b=KvyUbQkcGR3KApmkiZfu8C5xmBmzwpDOMQhR6WXG3miM86IPV6nfbAa3aqFSmkFIT4
         Io0wuqtpSpPfNvf2LkobGgtBXIiwpomuyI+x1Co09hZAF0EukRzWIEXi2XhrJZbThuWm
         UaJiYglKy6n6Yo1uw5Pqak6Ypb3N5cauggsXotdIs9wGfgXMjKqhcOwTSfFu4BFKaxEH
         kRQt0iOHxYWNkvVJPOBQNq1f356aEXVVIRTYJzY7C5+fKyVicWrLJALyIE831d4J85AM
         AKHNBV6dSiTSsKankfwnDqKPgqXdWyjIIw4JUt9kYQvtN9XfGuEqLx703FctdeIE4NgB
         mJqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HXQISz6uUvwg8Vwt1+DIrxstrllwfzEuYjBo3yyTGQk=;
        b=g46BzvAYODEtXbrzhcLwgtxkkm0Zc1yHfJhYimIhXcdp8tIqzdL0VcbQpUznsEBOlU
         9AGl8VlDc8t2prcYftbHiZuZCnWzDhVMuH/K9hCJm/xtEUS4yYJ6cgZVYmp7rBDojIQp
         8t3oRVLKq1FItoXC8SLrG0LzSy3cfvPqdzHrZfgpMUbcXkCzKHTS5tH031IkvOHXvnhh
         pwI0c6bnCb6So4L+BxWmTLUDNX9ro2kAEuLS8OLarOn7hY9kCUNgJofgCRtSFJuClPvK
         ioR/qAplDU7awc7V/znPYZh3zPmfmJBTXgBX3TEyUdayKHQ6d5XekAOQy4m2Ml27QjKy
         QSsw==
X-Gm-Message-State: AOAM530omM7XEZiKccVMO0VlZnEGJj0eUW57sUhp1usuCHs8cWF5pv4K
        gbi44jKxRjiiMB7DrqaNMJqiMYv5XbGqcyEsn1zXsSU4
X-Google-Smtp-Source: ABdhPJzDS22hiVXyfeCFx1bY6D/SQdYj6JjBOobUXzm4JrBhml3GZ+MsD+6xfd1BH+kWL3QLJAIFLT+r2hQC+tMsiGY=
X-Received: by 2002:a05:6830:19e6:: with SMTP id t6mr4712317ott.357.1642172197491;
 Fri, 14 Jan 2022 06:56:37 -0800 (PST)
MIME-Version: 1.0
References: <20220114065141.14506-1-lukas.fink1@gmail.com>
In-Reply-To: <20220114065141.14506-1-lukas.fink1@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 14 Jan 2022 09:56:26 -0500
Message-ID: <CADnq5_PBt9-x9d9TuW7_0Yrarpmp2bMTdDPXFv2ep=p89sULkg@mail.gmail.com>
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

On Fri, Jan 14, 2022 at 3:27 AM Lukas Fink <lukas.fink1@gmail.com> wrote:
>
> eb4fd29afd4a ("drm/amdgpu: bind to any 0x1002 PCI diplay class device") added
> generic bindings to amdgpu so that that it binds to all display class devices
> with VID 0x1002 and then rejects those in amdgpu_pci_probe.
>
> Unfortunately it reuses a driver_data value of 0 to detect those new bindings,
> which is already used to denote CHIP_TAHITI ASICs.
>
> The driver_data value given to those new bindings was changed in
> dd0761fd24ea1 ("drm/amdgpu: set CHIP_IP_DISCOVERY as the asic type by default")
> to CHIP_IP_DISCOVERY (=36), but it seems that the check in amdgpu_pci_probe
> was forgotten to be changed. Therefore, it still rejects Tahiti GPUs.
>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1860
> Fixes: eb4fd29afd4a ("drm/amdgpu: bind to any 0x1002 PCI diplay class device")
>
> Signed-off-by: Lukas Fink <lukas.fink1@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 9ec58bf74012..224d073022ac 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -1903,7 +1903,7 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
>                         return -ENODEV;
>         }
>
> -       if (flags == 0) {
> +       if (flags == CHIP_IP_DISCOVERY) {
>                 DRM_INFO("Unsupported asic.  Remove me when IP discovery init is in place.\n");
>                 return -ENODEV;
>         }

Thanks.  Actually this entire check can be removed at this point.  The
IP discovery support is in place.  I'll send a patch.

Alex


> --
> 2.34.1
>
