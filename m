Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81A54DD303
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 03:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbiCRCXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 22:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbiCRCXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 22:23:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CC1BD14DFDE
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 19:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647570121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jcLirLBEGvDklvL5IK4efni0vW6AGIFKCzBkNt8jT7I=;
        b=S8a/WwwAv9Q5PLCPEG7pqvrm01Byb3a6oFhIO3xwWwwYzGe2tGaLLVlRg7ecJmtDB24PT2
        qPHIK2r6BDpGlk91Pg7Q9rbYtunYE84xEdocEfEVaJl3WwEUR/KsvvDwmlzms01UMz7hZm
        Rn1fnbC9r/+mkF8HTP0ibtoGtTLaXxQ=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-313-ABaCNY-2O0yIENAsREIDEA-1; Thu, 17 Mar 2022 22:22:00 -0400
X-MC-Unique: ABaCNY-2O0yIENAsREIDEA-1
Received: by mail-lj1-f199.google.com with SMTP id 6-20020a2eb946000000b002463d2915d2so2840852ljs.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 19:22:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jcLirLBEGvDklvL5IK4efni0vW6AGIFKCzBkNt8jT7I=;
        b=mnv8+zr7ZWwEckcStbIVDMWuETWq2MNR6SO7HJqpamDP1GBnVMsBh4dySVQ37TfdbO
         lmf0EnVe5pvafG5MggV1wJVbWdMdsF/QHnWA73faUqEg71TgAHfYHjZP//9FFEf+pmZy
         NR8JfD3OYx2+FtWFKlhdfwqxps1vNxrZlYdijH/GLmf6JtsqxRomifg1ecaFfyXdxTpz
         RiNgizr4oDi3wNUY0xAUcwXJKskAIeIXCDMjV8PTeehW+TvSxGe88Hgz8y4Ht3dGkIF/
         lIWdn5b/dR32r0wcysLqdTThSTX4uZnRcDwVRrWhVsW6+HA0SBYq3+CLtH8VCJSo25IE
         HTpw==
X-Gm-Message-State: AOAM533WMjDNAtCM4bmOcNmCKhBf44OcDGy+kAE/qfgPsluzLEgI1VQk
        7snXoS/FieTN6mUhSwnc9oAbePL4dhDT+RWVo4X4+N/J0ENutO4cIRZkdE2MZ6NkqrrQ464NYxD
        L1838L+z83LFR0x86nUsy9yaqx0KYxVcp6rCzRk5r
X-Received: by 2002:a2e:a54b:0:b0:249:5889:70bb with SMTP id e11-20020a2ea54b000000b00249588970bbmr3089132ljn.73.1647570118802;
        Thu, 17 Mar 2022 19:21:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxk6ZmWwZJZgL5aAwzVCKI91S5sYhdAYPx9fT50h9cafmylYRfNrDC7JqFe8GbC9ScB1+C+LvoG3W2kcLxxVP8=
X-Received: by 2002:a2e:a54b:0:b0:249:5889:70bb with SMTP id
 e11-20020a2ea54b000000b00249588970bbmr3089119ljn.73.1647570118609; Thu, 17
 Mar 2022 19:21:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220318005858.2141967-1-chi.minghao@zte.com.cn>
In-Reply-To: <20220318005858.2141967-1-chi.minghao@zte.com.cn>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 18 Mar 2022 10:21:47 +0800
Message-ID: <CACGkMEvFK9O1qzKAeihF-3EGDC=iOmszKUA8QoMnCv5ovrg8yw@mail.gmail.com>
Subject: Re: [PATCH] virito-pci-modern: Remove useless DMA-32 fallback configuration
To:     cgel.zte@gmail.com
Cc:     mst <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2022 at 8:59 AM <cgel.zte@gmail.com> wrote:
>
> From: Minghao Chi <chi.minghao@zte.com.cn>
>
> As stated in [1], dma_set_mask() with a 64-bit mask will never fail if
> dev->dma_mask is non-NULL.
> So, if it fails, the 32 bits case will also fail for the same reason.
>
> Simplify code and remove some dead code accordingly.
>
> [1]: https://lkml.org/lkml/2021/6/7/398
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> ---
>  drivers/virtio/virtio_pci_modern_dev.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
> index e8b3ff2b9fbc..dff0b15a239d 100644
> --- a/drivers/virtio/virtio_pci_modern_dev.c
> +++ b/drivers/virtio/virtio_pci_modern_dev.c
> @@ -255,9 +255,6 @@ int vp_modern_probe(struct virtio_pci_modern_device *mdev)
>         }
>
>         err = dma_set_mask_and_coherent(&pci_dev->dev, DMA_BIT_MASK(64));
> -       if (err)
> -               err = dma_set_mask_and_coherent(&pci_dev->dev,
> -                                               DMA_BIT_MASK(32));

So we had:

        if (!dev->dma_mask || !dma_supported(dev, mask))
                return -EIO;

in dma_set_mask(), any reason dma_supported() can't be false here?

Thanks

>         if (err)
>                 dev_warn(&pci_dev->dev, "Failed to enable 64-bit or 32-bit DMA.  Trying to continue, but this might not work.\n");
>
> --
> 2.25.1
>

