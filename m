Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A91AB48900F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 07:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238926AbiAJGOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 01:14:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47708 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230147AbiAJGO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 01:14:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641795266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jgXD4sawCttacEEpkCSathegDH0wVsgBeAverivRcnY=;
        b=KbxMqR7J79mjPicV4nHiTW+yrptFh5zzVJ8cZqnBPI36x3DRr5EjABnrfeq8q94nXG3pFi
        nJEX3jzcyU+xNIokGDuVfNRkJb6UcvsT95JD7IxWBfuDXEtY7+8Sq50nlrRwP+C3Q6M08c
        +LgyaGCJI/llHnI1EjK1F5TNJysOMDo=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-600-RzFx4nMFOsyi0-e19eK48Q-1; Mon, 10 Jan 2022 01:14:23 -0500
X-MC-Unique: RzFx4nMFOsyi0-e19eK48Q-1
Received: by mail-pf1-f200.google.com with SMTP id x22-20020a056a00189600b004be094fc848so1846836pfh.8
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jan 2022 22:14:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jgXD4sawCttacEEpkCSathegDH0wVsgBeAverivRcnY=;
        b=Tjypq9PmI5mvQzsfAIGS/GuXsCwJYu1Do1OSJcJtgS8Zj84+y2fbqirNMsod7BpDzI
         Czhut6QxKyVRLdFqoe/FiaJbNyRvTCQNYJTlFpRvP67sIFAhaoFnnd9K7pu3+eUVCKpu
         qnG//05UF69Ul1rij8Ln/iNn4LOBFpVAG2S3Dh08LIm8yQVr02GkGiWy1lQFfwmIOqIB
         f4pUPVAOy4T/B3m19RQSiVDPMD0zkSD2tqkzJoXhS7vxa7TtTkR/EFYTKVvHIlJZiero
         3qwtsT+1zg3pG1RBrXYflScEcq89LpoRUQh3/u7qL7avg3ue4V03eFP34kF3Pw62SmCd
         ap5w==
X-Gm-Message-State: AOAM5332k0CgoqcZPhpQjkW6BN0SNTsKHC55mdfbrh2OG30OvXgfgSRx
        XZGQN0Ro/8rwYicRmyp3avkoil1dIMX8UW7M3nCUl3h1+fHoW7rwAx3Qon931WEZazmRnbi1J98
        R2zZnOirvCfVvz9WkKt3fajVf
X-Received: by 2002:a17:90a:8b04:: with SMTP id y4mr10015923pjn.32.1641795261857;
        Sun, 09 Jan 2022 22:14:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy4aPgQKlyDy297NQKXLejUdh9aMnuu1RHCa90y9sWogZhI8ZRQVJ4x/vhe9gBjqQSTC8GRLg==
X-Received: by 2002:a17:90a:8b04:: with SMTP id y4mr10015911pjn.32.1641795261619;
        Sun, 09 Jan 2022 22:14:21 -0800 (PST)
Received: from [10.72.13.131] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id nu18sm8133017pjb.15.2022.01.09.22.14.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jan 2022 22:14:20 -0800 (PST)
Message-ID: <42ba2840-bfa8-d530-4bcf-3eeee9403a31@redhat.com>
Date:   Mon, 10 Jan 2022 14:14:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH] virtio: Simplify DMA setting
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>, mst@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <fc97319a44d41d8b7eb127e1facdef4139ed77ac.1641625657.git.christophe.jaillet@wanadoo.fr>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <fc97319a44d41d8b7eb127e1facdef4139ed77ac.1641625657.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/1/8 下午3:08, Christophe JAILLET 写道:
> As stated in [1], dma_set_mask() with a 64-bit mask will never fail if
> dev->dma_mask is non-NULL.
> So, if it fails, the 32 bits case will also fail for the same reason.


I'd expect to be more verbose here. E.g I see dma_supported() who has a 
brunch of checks need to be called if dma_mask is non-NULL.

Thanks


>
> Simplify code and remove some dead code accordingly.
>
>
> While at it, include directly <linux/dma-mapping.h> instead on relying on
> indirect inclusion.
>
> [1]: https://lkml.org/lkml/2021/6/7/398
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>   drivers/virtio/virtio_mmio.c           | 4 +---
>   drivers/virtio/virtio_pci_legacy_dev.c | 7 +++----
>   drivers/virtio/virtio_pci_modern_dev.c | 6 ++----
>   3 files changed, 6 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index 56128b9c46eb..aa1efa854de1 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -617,9 +617,7 @@ static int virtio_mmio_probe(struct platform_device *pdev)
>   		rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
>   	}
>   	if (rc)
> -		rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
> -	if (rc)
> -		dev_warn(&pdev->dev, "Failed to enable 64-bit or 32-bit DMA.  Trying to continue, but this might not work.\n");
> +		dev_warn(&pdev->dev, "Failed to enable DMA.  Trying to continue, but this might not work.\n");
>   
>   	platform_set_drvdata(pdev, vm_dev);
>   
> diff --git a/drivers/virtio/virtio_pci_legacy_dev.c b/drivers/virtio/virtio_pci_legacy_dev.c
> index 677d1f68bc9b..52b1c4dd43fe 100644
> --- a/drivers/virtio/virtio_pci_legacy_dev.c
> +++ b/drivers/virtio/virtio_pci_legacy_dev.c
> @@ -2,6 +2,7 @@
>   
>   #include "linux/virtio_pci.h"
>   #include <linux/virtio_pci_legacy.h>
> +#include <linux/dma-mapping.h>
>   #include <linux/module.h>
>   #include <linux/pci.h>
>   
> @@ -26,9 +27,7 @@ int vp_legacy_probe(struct virtio_pci_legacy_device *ldev)
>   		return -ENODEV;
>   
>   	rc = dma_set_mask(&pci_dev->dev, DMA_BIT_MASK(64));
> -	if (rc) {
> -		rc = dma_set_mask_and_coherent(&pci_dev->dev, DMA_BIT_MASK(32));
> -	} else {
> +	if (!rc) {
>   		/*
>   		 * The virtio ring base address is expressed as a 32-bit PFN,
>   		 * with a page size of 1 << VIRTIO_PCI_QUEUE_ADDR_SHIFT.
> @@ -38,7 +37,7 @@ int vp_legacy_probe(struct virtio_pci_legacy_device *ldev)
>   	}
>   
>   	if (rc)
> -		dev_warn(&pci_dev->dev, "Failed to enable 64-bit or 32-bit DMA.  Trying to continue, but this might not work.\n");
> +		dev_warn(&pci_dev->dev, "Failed to enable DMA.  Trying to continue, but this might not work.\n");
>   
>   	rc = pci_request_region(pci_dev, 0, "virtio-pci-legacy");
>   	if (rc)
> diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
> index e8b3ff2b9fbc..830dc269d68f 100644
> --- a/drivers/virtio/virtio_pci_modern_dev.c
> +++ b/drivers/virtio/virtio_pci_modern_dev.c
> @@ -1,6 +1,7 @@
>   // SPDX-License-Identifier: GPL-2.0-or-later
>   
>   #include <linux/virtio_pci_modern.h>
> +#include <linux/dma-mapping.h>
>   #include <linux/module.h>
>   #include <linux/pci.h>
>   
> @@ -256,10 +257,7 @@ int vp_modern_probe(struct virtio_pci_modern_device *mdev)
>   
>   	err = dma_set_mask_and_coherent(&pci_dev->dev, DMA_BIT_MASK(64));
>   	if (err)
> -		err = dma_set_mask_and_coherent(&pci_dev->dev,
> -						DMA_BIT_MASK(32));
> -	if (err)
> -		dev_warn(&pci_dev->dev, "Failed to enable 64-bit or 32-bit DMA.  Trying to continue, but this might not work.\n");
> +		dev_warn(&pci_dev->dev, "Failed to enable DMA.  Trying to continue, but this might not work.\n");
>   
>   	/* Device capability is only mandatory for devices that have
>   	 * device-specific configuration.

