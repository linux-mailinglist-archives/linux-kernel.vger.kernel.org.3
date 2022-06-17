Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA8754F4C1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 12:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381248AbiFQKCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 06:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380595AbiFQKCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 06:02:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3762669292
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 03:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655460122;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TSVh7yijYlapN8vzLiNc0otlLUAAzEtnNLfWmNY1vGE=;
        b=OqzU6p60v1Z6g4f/TlNJI3sAgEmv/5atDHajTGl8TEC3U/BSKtwVCQstSLGxkaVA+lwtb5
        gezyFNwJeMuz+7cDwmKKs7uMV7pGhK4l5rru1eM2t+pd0PZveHUvq+33aqGyLYLcoNoTkN
        7ARab/97TnXCcUEcDnJG5O+AE8KuAwk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-211-SJFlonKnMj20AdhdJeneug-1; Fri, 17 Jun 2022 06:01:51 -0400
X-MC-Unique: SJFlonKnMj20AdhdJeneug-1
Received: by mail-wm1-f70.google.com with SMTP id v184-20020a1cacc1000000b0039c7efa3e95so1410364wme.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 03:01:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TSVh7yijYlapN8vzLiNc0otlLUAAzEtnNLfWmNY1vGE=;
        b=LP9rO11ExmzODz75J1ad3EoU+K5qxN97iLgV6POQ31PF1mcWZTk1jIiRVTAetbl/5v
         N2qLFxrBkex9i5GsQANsfFeDDDE25wf+UsSiyPbXbRpxyLvhdVY9axCe/CRFLmC0Vkra
         eFzbVFxDOyQFmlBkgPMMyRTOrkVM21JPSPOJLVD9f336pmDpuF4MaztcPVCS6ub+we1z
         rSRFI2k4wyoL10P1Isu5KU+DWwXAiKyTOtrKsFl3xO2ItwMNrjKBBZwxtZQ/E/OOzXG9
         OFt6bDAjXnlaqxh1j9o9hFxR8htmsN276wDiwyKx/AU/CdZ5d2IIq0gxKO35JPUQ9bUO
         cXhw==
X-Gm-Message-State: AJIora9teiXGjgJX0z9RGummK8wo+tdZNTxVmZVnENdMWeyojjMte03G
        zJneWoFpZs1RiLuwWBKECTLcXTx8McokTh6H07U8TokdJ5wTaLVSFbFiUfGurbg+1CVTUgf53zK
        RYxrV0MYWuYdiLXUbhvNMAuJA
X-Received: by 2002:a05:6000:1111:b0:212:d9ea:8609 with SMTP id z17-20020a056000111100b00212d9ea8609mr8689018wrw.522.1655460110685;
        Fri, 17 Jun 2022 03:01:50 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v8oTtQKSi5Cmw+jxp4WuOkWmcH0i3GQ/fJ95cJqHwaeCaQcWr0LlRvF1z+hNcGMxe0/fHbBw==
X-Received: by 2002:a05:6000:1111:b0:212:d9ea:8609 with SMTP id z17-20020a056000111100b00212d9ea8609mr8689000wrw.522.1655460110368;
        Fri, 17 Jun 2022 03:01:50 -0700 (PDT)
Received: from redhat.com ([2.54.189.19])
        by smtp.gmail.com with ESMTPSA id n8-20020a5d4c48000000b0021b8213fa3bsm411504wrt.19.2022.06.17.03.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 03:01:49 -0700 (PDT)
Date:   Fri, 17 Jun 2022 06:01:46 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio: disable notification hardening by default
Message-ID: <20220617060111-mutt-send-email-mst@kernel.org>
References: <20220617072626.30503-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220617072626.30503-1-jasowang@redhat.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 03:26:26PM +0800, Jason Wang wrote:
> We try to harden virtio device notifications in 8b4ec69d7e09 ("virtio:
> harden vring IRQ"). It works with the assumption that the driver or
> core can properly call virtio_device_ready() at the right
> place. Unfortunately, this seems to be not true and uncover various
> bugs of the existing drivers, mainly the issue of using
> virtio_device_ready() incorrectly.
> 
> So let's having a Kconfig option and disable it by default. It gives
> us a breath to fix the drivers and then we can consider to enable it
> by default.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>


Do you want to drop irq_lock lock/unlock in ccw too?

> ---
>  drivers/virtio/Kconfig        |  6 ++++++
>  drivers/virtio/virtio.c       |  2 ++
>  drivers/virtio/virtio_ring.c  | 12 ++++++++++++
>  include/linux/virtio_config.h |  2 ++
>  4 files changed, 22 insertions(+)
> 
> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> index b5adf6abd241..b059c39af3d4 100644
> --- a/drivers/virtio/Kconfig
> +++ b/drivers/virtio/Kconfig
> @@ -35,6 +35,12 @@ menuconfig VIRTIO_MENU
>  
>  if VIRTIO_MENU
>  
> +config VIRTIO_HARDEN_NOTIFICATION
> +        bool "Harden virtio notification"
> +        help
> +          Enable to this to harden the device notifications and
> +          supress the ones that are illegal.
> +
>  config VIRTIO_PCI
>  	tristate "PCI driver for virtio devices"
>  	depends on PCI
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index ef04a96942bf..21dc08d2f32d 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -220,6 +220,7 @@ static int virtio_features_ok(struct virtio_device *dev)
>   * */
>  void virtio_reset_device(struct virtio_device *dev)
>  {
> +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
>  	/*
>  	 * The below virtio_synchronize_cbs() guarantees that any
>  	 * interrupt for this line arriving after
> @@ -228,6 +229,7 @@ void virtio_reset_device(struct virtio_device *dev)
>  	 */
>  	virtio_break_device(dev);
>  	virtio_synchronize_cbs(dev);
> +#endif
>  
>  	dev->config->reset(dev);
>  }
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 13a7348cedff..d9d3b6e201fb 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1688,7 +1688,11 @@ static struct virtqueue *vring_create_virtqueue_packed(
>  	vq->we_own_ring = true;
>  	vq->notify = notify;
>  	vq->weak_barriers = weak_barriers;
> +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
>  	vq->broken = true;
> +#else
> +	vq->broken = false;
> +#endif
>  	vq->last_used_idx = 0;
>  	vq->event_triggered = false;
>  	vq->num_added = 0;
> @@ -2135,9 +2139,13 @@ irqreturn_t vring_interrupt(int irq, void *_vq)
>  	}
>  
>  	if (unlikely(vq->broken)) {
> +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
>  		dev_warn_once(&vq->vq.vdev->dev,
>  			      "virtio vring IRQ raised before DRIVER_OK");
>  		return IRQ_NONE;
> +#else
> +		return IRQ_HANDLED;
> +#endif
>  	}
>  
>  	/* Just a hint for performance: so it's ok that this can be racy! */
> @@ -2180,7 +2188,11 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
>  	vq->we_own_ring = false;
>  	vq->notify = notify;
>  	vq->weak_barriers = weak_barriers;
> +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
>  	vq->broken = true;
> +#else
> +	vq->broken = false;
> +#endif
>  	vq->last_used_idx = 0;
>  	vq->event_triggered = false;
>  	vq->num_added = 0;
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index 9a36051ceb76..d15c3cdda2d2 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -257,6 +257,7 @@ void virtio_device_ready(struct virtio_device *dev)
>  
>  	WARN_ON(status & VIRTIO_CONFIG_S_DRIVER_OK);
>  
> +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
>  	/*
>  	 * The virtio_synchronize_cbs() makes sure vring_interrupt()
>  	 * will see the driver specific setup if it sees vq->broken
> @@ -264,6 +265,7 @@ void virtio_device_ready(struct virtio_device *dev)
>  	 */
>  	virtio_synchronize_cbs(dev);
>  	__virtio_unbreak_device(dev);
> +#endif
>  	/*
>  	 * The transport should ensure the visibility of vq->broken
>  	 * before setting DRIVER_OK. See the comments for the transport
> -- 
> 2.25.1

