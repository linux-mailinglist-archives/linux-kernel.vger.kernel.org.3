Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19B69479BC0
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 17:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbhLRQX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 11:23:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbhLRQX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 11:23:26 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15EA7C061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Dec 2021 08:23:26 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id l7so8370136lja.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Dec 2021 08:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CT+taMHRza/UDXhL528VUpODcNvw/ubR6oyOC8X9Wdw=;
        b=Tv2DOX79UEnrnuO1h61dSfhprFrMdKLtswO+OTm7IXUY9NoSJTSi0dUhq799rWt2Rn
         HuuFjJhzNnl6u6wC72VmiEnOmLgqkC8GduhFHPLWCr+ZKsYOi2JgriM892VkS76AOkxw
         8HzaW6jyu+IYAkEOFl8ko1bp699GbC51xsl0hTjHECg07nMs2sNgw9tWanSbyru1wRM2
         Xuxk0BvjAwQtRbO2ABqVmue11+Wk/saDy7Y2tsNrIqlExpXNqj3wuIhxmSejlVc/mXHN
         v0AZHySQIVH59HLbTDt0L6rc73vFb4LXJvzgSqxhyegXsAP3ACtD+rB/BpSi1kpECUvr
         axQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CT+taMHRza/UDXhL528VUpODcNvw/ubR6oyOC8X9Wdw=;
        b=yigdNLNfyokhzFtWkDoeMSsUuk4WgiBlX6vn1zyR2YUimQAsGLERaYn9BdeyUwEp3j
         vZcztaN70REJjn1Mtm/BYDYlEnr5wxgIKNEXZbyrgtjDJEmyyZDFR+Fny3+szTfyQGl6
         9argNia7guxwtf4eRfv1D5Hc8H0fpay8u5Fjhm0JHVgIEYrt4Tnr9zquY+ilG9w6bsVQ
         fc4VD/YsLb40+JgDfrr1Y66kGVA3Nn3LXi4FUS2mpssAr0wz0SnOhJOEyYvNAeV4rrJk
         s17Wx+oBlY1Gd9eQfpssFpmuwuW5eInjevr0qSz5GOTQB8tbM9YvGf3D5b8sfSZlODU7
         PeVA==
X-Gm-Message-State: AOAM530AHO6o7E4QasergrH8qH3QCahwCLrIa2oTUpqcKlqwGfGhEx/r
        0QXm9OyIsQ3bWJXZrBVxLFERhD/biOqV5AduQnY=
X-Google-Smtp-Source: ABdhPJxJnfSrLNaqB6iW92bjbg8H0Jtao8C93yQc/c7+tg7Mc5frwZ1wHJsJrj4GnPjDYB2296jlkQ1KjD3FYhAavgM=
X-Received: by 2002:a05:651c:323:: with SMTP id b3mr7271328ljp.316.1639844604258;
 Sat, 18 Dec 2021 08:23:24 -0800 (PST)
MIME-Version: 1.0
References: <1639473108-18629-1-git-send-email-zou_wei@huawei.com>
In-Reply-To: <1639473108-18629-1-git-send-email-zou_wei@huawei.com>
From:   Kevin Tang <kevin3.tang@gmail.com>
Date:   Sun, 19 Dec 2021 00:23:07 +0800
Message-ID: <CAFPSGXZLWmahF+ptQC2TT84rB6E0v=V2c6ETkKAd4GKP3c756A@mail.gmail.com>
Subject: Re: [PATCH -next] drm/sprd: fix potential NULL dereference
To:     Zou Wei <zou_wei@huawei.com>
Cc:     airlied@linux.ie, daniel@ffwll.ch, orsonzhai@gmail.com,
        baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        maarten.lankhorst@linux.intel.com, maxime@cerno.tech,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Wei,
Thank you for your notice. I have received it. I will be fix it later.

Best wishes

Zou Wei <zou_wei@huawei.com> =E4=BA=8E2021=E5=B9=B412=E6=9C=8814=E6=97=A5=
=E5=91=A8=E4=BA=8C 17:11=E5=86=99=E9=81=93=EF=BC=9A
>
> platform_get_resource() may fail and return NULL, so we should
> better check it's return value to avoid a NULL pointer dereference
> a bit later in the code.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>
> ---
>  drivers/gpu/drm/sprd/sprd_dpu.c | 2 ++
>  drivers/gpu/drm/sprd/sprd_dsi.c | 2 ++
>  2 files changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/sprd/sprd_dpu.c b/drivers/gpu/drm/sprd/sprd_=
dpu.c
> index 06a3414..920cb7d 100644
> --- a/drivers/gpu/drm/sprd/sprd_dpu.c
> +++ b/drivers/gpu/drm/sprd/sprd_dpu.c
> @@ -790,6 +790,8 @@ static int sprd_dpu_context_init(struct sprd_dpu *dpu=
,
>         int ret;
>
>         res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       if (!res)
> +               return -EINVAL;
>         ctx->base =3D devm_ioremap(dev, res->start, resource_size(res));
>         if (!ctx->base) {
>                 dev_err(dev, "failed to map dpu registers\n");
> diff --git a/drivers/gpu/drm/sprd/sprd_dsi.c b/drivers/gpu/drm/sprd/sprd_=
dsi.c
> index 911b3cd..c90a950 100644
> --- a/drivers/gpu/drm/sprd/sprd_dsi.c
> +++ b/drivers/gpu/drm/sprd/sprd_dsi.c
> @@ -907,6 +907,8 @@ static int sprd_dsi_context_init(struct sprd_dsi *dsi=
,
>         struct resource *res;
>
>         res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       if (!res)
> +               return -EINVAL;
>         ctx->base =3D devm_ioremap(dev, res->start, resource_size(res));
>         if (!ctx->base) {
>                 drm_err(dsi->drm, "failed to map dsi host registers\n");
> --
> 2.6.2
>
