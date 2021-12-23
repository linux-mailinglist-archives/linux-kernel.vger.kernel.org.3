Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA6B647DED4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 06:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346490AbhLWF7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 00:59:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55049 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346414AbhLWF7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 00:59:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640239140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eP5DWolnVEj7zO24iHvs8bq5q4izn4uLMYYf6eLn4i0=;
        b=XvYAOk2A12rReilZ+lcRPS767nl+l++VyFgU0cr9nlkFDJEAv9VeHXMyj7BNsSAG9bHV2F
        8/+7cfftCDQ7IcVnUryzDuFRDf+alqdIjQKajMFRlQ/55nidNgiI2lGGrbUieCKY50aoNU
        vaavkZIXw49Ta1u8h6Clcwm1Ww1J958=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-528-1D7ELapwNs-k7XFXSMHokQ-1; Thu, 23 Dec 2021 00:58:59 -0500
X-MC-Unique: 1D7ELapwNs-k7XFXSMHokQ-1
Received: by mail-lj1-f199.google.com with SMTP id s16-20020a2ea710000000b0021b674e9347so1008454lje.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 21:58:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eP5DWolnVEj7zO24iHvs8bq5q4izn4uLMYYf6eLn4i0=;
        b=UpKW6WmKlJMpboIFHJU2OIkCQ4XVhDEiD/v/pOA5oygGkM31dp9qbHIdsIw8i7N8Df
         VEri1mndN+y6+p96QvKSGRJ3fB3N3oSejUjtc09acgvho0plvZ2K+Gdowd/++9BFIbG1
         I7Cdex4PHb9wlqLn8si5bHRbViQhEAYkAxJR47Tv010w+VlvjxRGqaKCdk6vqnsGMhDI
         JiW43jzOF0oBtO7FVtqtQYe+vaUQFGZiD86K9CEamccu9b/D7T/fMcEybYJI7QAngX8p
         i16rE1Xd31hkQE2YZ4tPF7O6Ehp38CMCL4wBUv/KihXCNyuc5CpIJOL2qXiQEHVl8Cv/
         AB6Q==
X-Gm-Message-State: AOAM530aYWMcQz1qAm9ihYSaVmJx3zHEj0daoq7SPkZ+ngjcW02np2dO
        HMC5V9lOZe1Pq6Gv3PXnIqXCVxW8thSbmCOZ9N3MFjAfpi4n2NA41oysRQMJh0f/NWp0sYJzzni
        CQc/5xEoaKCwyXizl7oLbHFXR1PzjmKzjhaoiJX6K
X-Received: by 2002:a05:6512:108b:: with SMTP id j11mr769777lfg.629.1640239137630;
        Wed, 22 Dec 2021 21:58:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJze+1MRfxRzVt2CRB2uJgLx/trRKa/yExHXWTRkPp/1cU/SLHMDcUhLNuYita2ff2D4n+sLWZqCbiovDS0Kl8I=
X-Received: by 2002:a05:6512:108b:: with SMTP id j11mr769767lfg.629.1640239137443;
 Wed, 22 Dec 2021 21:58:57 -0800 (PST)
MIME-Version: 1.0
References: <20211222112014.87394-1-flyingpeng@tencent.com>
In-Reply-To: <20211222112014.87394-1-flyingpeng@tencent.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 23 Dec 2021 13:58:46 +0800
Message-ID: <CACGkMEszTmn1nO=qkzqGawtjq1f6AJK_U63Tw96+PU02C3Cdew@mail.gmail.com>
Subject: Re: [PATCH] virtio/virtio_pci_legacy_dev: ensure the correct return value
To:     Peng Hao <flyingpenghao@gmail.com>
Cc:     mst <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 7:21 PM Peng Hao <flyingpenghao@gmail.com> wrote:
>
> When pci_iomap return NULL, the return value is zero.
>
> Signed-off-by: Peng Hao <flyingpeng@tencent.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

>  drivers/virtio/virtio_pci_legacy_dev.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/virtio/virtio_pci_legacy_dev.c b/drivers/virtio/virtio_pci_legacy_dev.c
> index 9b97680dd02b..677d1f68bc9b 100644
> --- a/drivers/virtio/virtio_pci_legacy_dev.c
> +++ b/drivers/virtio/virtio_pci_legacy_dev.c
> @@ -45,8 +45,10 @@ int vp_legacy_probe(struct virtio_pci_legacy_device *ldev)
>                 return rc;
>
>         ldev->ioaddr = pci_iomap(pci_dev, 0, 0);
> -       if (!ldev->ioaddr)
> +       if (!ldev->ioaddr) {
> +               rc = -EIO;
>                 goto err_iomap;
> +       }
>
>         ldev->isr = ldev->ioaddr + VIRTIO_PCI_ISR;
>
> --
> 2.27.0
>

