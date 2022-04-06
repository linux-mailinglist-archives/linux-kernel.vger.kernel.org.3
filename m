Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A44024F62F2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 17:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbiDFPLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 11:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235650AbiDFPKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:10:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 98FAB26B0BD
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 05:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649246610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ze2TWxpmAqqDUL49E+XcPJ1705fMWUsu9cAskjBwj0E=;
        b=RacFOQEcat13njQY1H5G4z9iwYtTTpW7qA+RG83eY2InK2bkrVrVV9B6t6xWlmqUwR5Poo
        2Z1Sv6beARq6B4zM/cQwMtruxYW6tRlKAQQsqvjtVTU3MiME6zrBJmPK026S2ZbI0V4SpB
        nk6zmP1xB1TiauxgATnci00L+wCQFR4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-183-3j_ILxw9Pe2DH7h12y0k-g-1; Wed, 06 Apr 2022 08:00:18 -0400
X-MC-Unique: 3j_ILxw9Pe2DH7h12y0k-g-1
Received: by mail-wm1-f69.google.com with SMTP id c19-20020a05600c4a1300b0038e6b4a104cso2863181wmp.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 05:00:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ze2TWxpmAqqDUL49E+XcPJ1705fMWUsu9cAskjBwj0E=;
        b=YKiTDlw22i4LnmUwM+qAsYuD+X7tg7j8Na/jnWx5hQVpbL6lE9mCu6LVSY1PCCCMEq
         tXzTErKIrl3xzsurH5Nv1uSFQr8yKVuphSkoc7vc3wtcnts8fO3U+wpFN/JMLy5o6h6v
         hyxDiYw2Uch7Py5kSEssoTzrnIEQ91HUnIKBZwbL1dWCV4CY8MICong/WyzlRPIQ39Jz
         vMQ3XdfL+RrxDynbySbupeSE1DY4G92CNu8sx1NP3gB6xmpjRz6sO0hQ2bef6Xgbg6S1
         fLRMef99NmOrKY3haPZxbtSCCCG4bw1Ize3F6AN05MoECeMFWT9JifhhrQ8VOyxabqoA
         ikqw==
X-Gm-Message-State: AOAM530K9Yo7uB2AgyyO4qbgg6eBG3toZZmYVN2GijNgvnQduTWWFKSO
        SlYKRX+vKZgNSP7yGB3fofC2JaKXQfDsm6jJWjZZcvY3jRuOKdTNtVCQ/Vrxa2knijzOxhsQo1V
        NQT+ufDS3HU7se7kR+CwmBWQM
X-Received: by 2002:adf:f10e:0:b0:206:1837:b5a9 with SMTP id r14-20020adff10e000000b002061837b5a9mr6235217wro.347.1649246417777;
        Wed, 06 Apr 2022 05:00:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwAufotzexY7Jj8FBhbUyN69cKdArXStk+wlr/BcYVa/P4zN5BWio7QBwNF1ollNyzQV0IO1w==
X-Received: by 2002:adf:f10e:0:b0:206:1837:b5a9 with SMTP id r14-20020adff10e000000b002061837b5a9mr6235196wro.347.1649246417519;
        Wed, 06 Apr 2022 05:00:17 -0700 (PDT)
Received: from redhat.com ([2.55.179.195])
        by smtp.gmail.com with ESMTPSA id r12-20020a5d6c6c000000b00203ec2b1255sm18278692wrz.60.2022.04.06.05.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 05:00:17 -0700 (PDT)
Date:   Wed, 6 Apr 2022 08:00:13 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, maz@kernel.org, tglx@linutronix.de,
        peterz@infradead.org, sgarzare@redhat.com,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH V2 4/5] virtio-pci: implement synchronize_vqs()
Message-ID: <20220406075952-mutt-send-email-mst@kernel.org>
References: <20220406083538.16274-1-jasowang@redhat.com>
 <20220406083538.16274-5-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406083538.16274-5-jasowang@redhat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06, 2022 at 04:35:37PM +0800, Jason Wang wrote:
> This patch implements PCI version of synchronize_vqs().
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Please add implementations at least for ccw and mmio.

> ---
>  drivers/virtio/virtio_pci_common.c | 14 ++++++++++++++
>  drivers/virtio/virtio_pci_common.h |  2 ++
>  drivers/virtio/virtio_pci_legacy.c |  1 +
>  drivers/virtio/virtio_pci_modern.c |  2 ++
>  4 files changed, 19 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index d724f676608b..b78c8bc93a97 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -37,6 +37,20 @@ void vp_synchronize_vectors(struct virtio_device *vdev)
>  		synchronize_irq(pci_irq_vector(vp_dev->pci_dev, i));
>  }
>  
> +void vp_synchronize_vqs(struct virtio_device *vdev)
> +{
> +	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> +	int i;
> +
> +	if (vp_dev->intx_enabled) {
> +		synchronize_irq(vp_dev->pci_dev->irq);
> +		return;
> +	}
> +
> +	for (i = 0; i < vp_dev->msix_vectors; ++i)
> +		synchronize_irq(pci_irq_vector(vp_dev->pci_dev, i));
> +}
> +
>  /* the notify function used when creating a virt queue */
>  bool vp_notify(struct virtqueue *vq)
>  {
> diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
> index eb17a29fc7ef..2b84d5c1b5bc 100644
> --- a/drivers/virtio/virtio_pci_common.h
> +++ b/drivers/virtio/virtio_pci_common.h
> @@ -105,6 +105,8 @@ static struct virtio_pci_device *to_vp_device(struct virtio_device *vdev)
>  void vp_synchronize_vectors(struct virtio_device *vdev);
>  /* the notify function used when creating a virt queue */
>  bool vp_notify(struct virtqueue *vq);
> +/* synchronize with callbacks */
> +void vp_synchronize_vqs(struct virtio_device *vdev);
>  /* the config->del_vqs() implementation */
>  void vp_del_vqs(struct virtio_device *vdev);
>  /* the config->find_vqs() implementation */
> diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
> index 6f4e34ce96b8..5a9e62320edc 100644
> --- a/drivers/virtio/virtio_pci_legacy.c
> +++ b/drivers/virtio/virtio_pci_legacy.c
> @@ -192,6 +192,7 @@ static const struct virtio_config_ops virtio_pci_config_ops = {
>  	.reset		= vp_reset,
>  	.find_vqs	= vp_find_vqs,
>  	.del_vqs	= vp_del_vqs,
> +	.synchronize_vqs = vp_synchronize_vqs,
>  	.get_features	= vp_get_features,
>  	.finalize_features = vp_finalize_features,
>  	.bus_name	= vp_bus_name,
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index a2671a20ef77..584850389855 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -394,6 +394,7 @@ static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
>  	.reset		= vp_reset,
>  	.find_vqs	= vp_modern_find_vqs,
>  	.del_vqs	= vp_del_vqs,
> +	.synchronize_vqs = vp_synchronize_vqs,
>  	.get_features	= vp_get_features,
>  	.finalize_features = vp_finalize_features,
>  	.bus_name	= vp_bus_name,
> @@ -411,6 +412,7 @@ static const struct virtio_config_ops virtio_pci_config_ops = {
>  	.reset		= vp_reset,
>  	.find_vqs	= vp_modern_find_vqs,
>  	.del_vqs	= vp_del_vqs,
> +	.synchronize_vqs = vp_synchronize_vqs,
>  	.get_features	= vp_get_features,
>  	.finalize_features = vp_finalize_features,
>  	.bus_name	= vp_bus_name,
> -- 
> 2.25.1

