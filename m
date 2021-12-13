Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 625F4473902
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 00:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244329AbhLMXzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 18:55:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40319 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244311AbhLMXzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 18:55:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639439750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FVJn8jwHDo/cZGCCQ5V+Thn/N1ZbGdPrh27DtsiDMDk=;
        b=cBj8/WJLI4cj/tWEFbYlR/+le7i7X7S7KNs0KRoRA2xw9Rbka5Mljfxqm2GAyY8JctFySR
        0DRJsqJrf/WXZ8NLMt+JmXcyfgNskQJwY5oaTKGPwQCVMtQQ3mpDp3WGpZQOo2rpQ5NChr
        z6V97L9W16sr4qOMYJdn5xKFV827Qcs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-350-YTemTlJKMaGcpBZ7_kuOtA-1; Mon, 13 Dec 2021 18:55:49 -0500
X-MC-Unique: YTemTlJKMaGcpBZ7_kuOtA-1
Received: by mail-wm1-f69.google.com with SMTP id 201-20020a1c04d2000000b003335bf8075fso10444034wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 15:55:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FVJn8jwHDo/cZGCCQ5V+Thn/N1ZbGdPrh27DtsiDMDk=;
        b=POgt/fC6MzzzqePUercK2rFmdeX11xgpLp10M3FVs0V+PQdzTFMY0EpviTwsk5yLrp
         pTNDnB2vY8s96eWvnVbJIJUeCpE+gloK4bZbdnPD4DrBI2PEWCMjV2gBCcZi5B2afMih
         DtudknU690wb2esYlWn9ncWDVb9Cub9q/TcPJ7MPMJldgvw7lpMbX5aUD5fAayAUi4td
         /qqAmQkUtpvVd3GzwNLrQDoPkkNdnVodlVTi/9eEsllXYKlSYqnrxExGxIW8UnDY/qVd
         0Hll/qexxQLBwwNMN6TGTmumMfzx7OtbDA4r7mOvSxk2jO/WkrXVL1GL+WRn3o8t0H4s
         yPfg==
X-Gm-Message-State: AOAM530qPSgKaz/2vY+yjVSeDXetJvRmFsdjGAb/cxQmu/SXsUJX3w8y
        noasJkciRJ/x1EjmcWqIKb+8h18WQ2NvVQ13o5Vl7lMrWtEJPJSAkDS53whYwFGEnKxbQUBgclF
        3b0pI1u0NFQ3XqqKVS4Iq/mwo
X-Received: by 2002:a05:6000:250:: with SMTP id m16mr1830931wrz.459.1639439748403;
        Mon, 13 Dec 2021 15:55:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxRuduDc4gHi1E9c1BxySUihdpD8sKyFElGW2gb5/RJfnRnGzyG7IjozaxundgzWnwsMzmibw==
X-Received: by 2002:a05:6000:250:: with SMTP id m16mr1830918wrz.459.1639439748269;
        Mon, 13 Dec 2021 15:55:48 -0800 (PST)
Received: from redhat.com ([2a03:c5c0:207d:b931:2ce5:ef76:2d17:5466])
        by smtp.gmail.com with ESMTPSA id f1sm10050910wrh.116.2021.12.13.15.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 15:55:47 -0800 (PST)
Date:   Mon, 13 Dec 2021 18:55:44 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Mikhail Golubev <Mikhail.Golubev@opensynergy.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] virtio_mmio: pm: Add notification handlers for restore
 and freeze
Message-ID: <20211213185317-mutt-send-email-mst@kernel.org>
References: <20211213160002.GA202134@opensynergy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213160002.GA202134@opensynergy.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 05:00:08PM +0100, Mikhail Golubev wrote:
> From: Yurii Danilovskyi <glyd@opensynergy.com>
> 
> Handle restore and freeze notifications from the PM core. Expose
> these to individual virtio drivers that can quiesce and resume vq
> operations.
> 
> Signed-off-by: Yurii Danilovskyi <glyd@opensynergy.com>
> Signed-off-by: Mikhail Golubev <Mikhail.Golubev@opensynergy.com>
> ---
>  drivers/virtio/virtio_mmio.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index 56128b9c46eb..af79f8c2a2f2 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -762,6 +762,24 @@ static void vm_unregister_cmdline_devices(void)
>  
>  #endif
>  
> +static int __maybe_unused virtio_mmio_freeze(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct virtio_mmio_device *vm_dev = platform_get_drvdata(pdev);
> +
> +	return virtio_device_freeze(&vm_dev->vdev);
> +}
> +
> +static int __maybe_unused virtio_mmio_restore(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct virtio_mmio_device *vm_dev = platform_get_drvdata(pdev);
> +
> +	return virtio_device_restore(&vm_dev->vdev);
> +}
> +
> +static SIMPLE_DEV_PM_OPS(virtio_mmio_pm_ops, virtio_mmio_freeze, virtio_mmio_restore);
> +
>  /* Platform driver */
>  
>  static const struct of_device_id virtio_mmio_match[] = {
> @@ -785,6 +803,7 @@ static struct platform_driver virtio_mmio_driver = {
>  		.name	= "virtio-mmio",
>  		.of_match_table	= virtio_mmio_match,
>  		.acpi_match_table = ACPI_PTR(virtio_mmio_acpi_match),
> +		.pm = &virtio_mmio_pm_ops,
>  	},
>  };

All this code needs to be within ifdef CONFIG_PM_SLEEP.  Alternatively,
tweak virtio.h to expose virtio_device_freeze/virtio_device_restore
unconditionally.


>  
> -- 
> 2.34.1
> 
> 
> -- 

