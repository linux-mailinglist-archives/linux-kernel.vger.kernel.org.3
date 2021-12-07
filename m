Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9803446B12B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 04:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbhLGDFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 22:05:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:53732 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229567AbhLGDFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 22:05:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638846127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zBN+syKSSAxUFyLOlRxVGt24z0QMP6DSO9PlA+lBJtY=;
        b=aXTYI8K8379HmPdrHvMQpLRfEm31DvEYVmNXEbvpjX8eImJEuUgip2poOsvskxYxtWNtl/
        QU7yJnJUjf5gxMC71vMu8giiXYSWtm/CHZw2VYRT4nGOauZlztAEF+WoyWQVaqmdw9js4n
        9PXLf2DHfYFEkuQfIKveCzug8Da7J6I=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-335-DiAQgblOMESxfHFIvKf9IQ-1; Mon, 06 Dec 2021 22:02:06 -0500
X-MC-Unique: DiAQgblOMESxfHFIvKf9IQ-1
Received: by mail-lj1-f200.google.com with SMTP id 2-20020a2e0902000000b00218c22336abso4116590ljj.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 19:02:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zBN+syKSSAxUFyLOlRxVGt24z0QMP6DSO9PlA+lBJtY=;
        b=IthE1vHsTgql/8gc7fVGaF5GTzw3ehvGsLw/OoWH5ktJ/oGH4hcf16x8i63IzI1xtB
         ohxoRizoYHv/pdEzcAnuj+W29G2pFzLmVOYfrMtxlWtlaTTzB2x0p+cBuBs/iitPHKJD
         Ln+qDEBZBYndm2D+7wqjeHlpfLg5cyK+ZNsROrV8Bo41BVtjY1csvUz6mFnarVU+7j+a
         uLv1QKzC6SIL0xLU5Ye9IdfhfnwFoNeAT6bqWgjaxKKBzsJ1PMoH0BkNkMUkxl92S6mG
         C1EdfQ5LLxJiktcYAm/UclRipytKSliYlAUVz5I+lBKvATjaDYtN80E2cGs3DQnHBJLm
         OK1g==
X-Gm-Message-State: AOAM530+DQphR2OtFyzVGbDp6jZpcWbHG+SgCg0LfkQdj82USKvtVWsz
        iduPX6CaBoDBbm/IX51XTPG8261LiDsl1WZZQ3fu0MYT0kegky9tI0SyWXREPyAA4zDmznlm2Z8
        xW2sKq2RWUPPTlJBLOQTQCUlFripcnKFChUa4PFTK
X-Received: by 2002:a2e:b88d:: with SMTP id r13mr39374141ljp.362.1638846124615;
        Mon, 06 Dec 2021 19:02:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxCqfug/3TpuWUxGv4K4tZ1JDQBHCFlRMNWmHhg3z1EzToZ5S5LdMB+CS75Q4G3NbAKp9Xy0GDAoi5QA0mHri8=
X-Received: by 2002:a2e:b88d:: with SMTP id r13mr39374124ljp.362.1638846124375;
 Mon, 06 Dec 2021 19:02:04 -0800 (PST)
MIME-Version: 1.0
References: <20211206085034.2836099-1-arnd@kernel.org>
In-Reply-To: <20211206085034.2836099-1-arnd@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 7 Dec 2021 11:01:53 +0800
Message-ID: <CACGkMEtX4gF7i__dBhsq=pOsCvTHx4iJdGJguoRmM9cxCLCppA@mail.gmail.com>
Subject: Re: [PATCH] [v2] virtio: always enter drivers/virtio/
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Wu Zongyong <wuzongyong@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>,
        Hans de Goede <hdegoede@redhat.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 6, 2021 at 4:50 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> When neither VIRTIO_PCI_LIB nor VIRTIO are enabled, but the alibaba
> vdpa driver is, the kernel runs into a link error because the legacy
> virtio module never gets built:
>
> x86_64-linux-ld: drivers/vdpa/alibaba/eni_vdpa.o: in function `eni_vdpa_set_features':
> eni_vdpa.c:(.text+0x23f): undefined reference to `vp_legacy_set_features'
> x86_64-linux-ld: drivers/vdpa/alibaba/eni_vdpa.o: in function `eni_vdpa_set_vq_state':
> eni_vdpa.c:(.text+0x2fe): undefined reference to `vp_legacy_get_queue_enable'
> x86_64-linux-ld: drivers/vdpa/alibaba/eni_vdpa.o: in function `eni_vdpa_set_vq_address':
> eni_vdpa.c:(.text+0x376): undefined reference to `vp_legacy_set_queue_address'
> x86_64-linux-ld: drivers/vdpa/alibaba/eni_vdpa.o: in function `eni_vdpa_set_vq_ready':
> eni_vdpa.c:(.text+0x3b4): undefined reference to `vp_legacy_set_queue_address'
> x86_64-linux-ld: drivers/vdpa/alibaba/eni_vdpa.o: in function `eni_vdpa_free_irq':
> eni_vdpa.c:(.text+0x460): undefined reference to `vp_legacy_queue_vector'
> x86_64-linux-ld: eni_vdpa.c:(.text+0x4b7): undefined reference to `vp_legacy_config_vector'
> x86_64-linux-ld: drivers/vdpa/alibaba/eni_vdpa.o: in function `eni_vdpa_reset':
>
> When VIRTIO_PCI_LIB was added, it was correctly added to drivers/Makefile
> as well, but for the legacy module, this is missing.  Solve this by always
> entering drivers/virtio during the build and letting its Makefile take
> care of the individual options, rather than having a separate line for
> each sub-option.
>
> Fixes: 64b9f64f80a6 ("vdpa: introduce virtio pci driver")

I think this is not true. we had:

obj-$(CONFIG_VIRTIO_PCI_LIB)   += virtio/

since then.

The patch looks good to me.

Thanks

> Fixes: e85087beedca ("eni_vdpa: add vDPA driver for Alibaba ENI")
> Fixes: d89c8169bd70 ("virtio-pci: introduce legacy device module")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/Makefile | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/Makefile b/drivers/Makefile
> index be5d40ae1488..a110338c860c 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -41,8 +41,7 @@ obj-$(CONFIG_DMADEVICES)      += dma/
>  # SOC specific infrastructure drivers.
>  obj-y                          += soc/
>
> -obj-$(CONFIG_VIRTIO)           += virtio/
> -obj-$(CONFIG_VIRTIO_PCI_LIB)   += virtio/
> +obj-y                          += virtio/
>  obj-$(CONFIG_VDPA)             += vdpa/
>  obj-$(CONFIG_XEN)              += xen/
>
> --
> 2.29.2
>

