Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEB054F7B0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 14:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382383AbiFQMgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 08:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381579AbiFQMgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 08:36:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ECA5F6161E
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 05:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655469394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RNdSBmShYOKDsuGy06c+NrA70N8YaR9zjSa+aBwZad0=;
        b=ZMeKTMjeejydWHwB3vapU1oR+2Tsloq384Ppg00vGS7Yp4tQPfJKZVv7G+zEiqjIaxp2tt
        OM/xUhXI947/rzuXXS0PsbJNq2gIzqys3ptnp/VVVhorYTBZk/YdzX55X8POXEgLGIrZKu
        2ojvt3GkWdTE4q/mKe18EYL8e1cjQI0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-37-MQXVIoELPQiFDZb23ICeMA-1; Fri, 17 Jun 2022 08:36:30 -0400
X-MC-Unique: MQXVIoELPQiFDZb23ICeMA-1
Received: by mail-ej1-f69.google.com with SMTP id hy20-20020a1709068a7400b00703779e6f2fso2018464ejc.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 05:36:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RNdSBmShYOKDsuGy06c+NrA70N8YaR9zjSa+aBwZad0=;
        b=QAk1wwkctX4lcgRSzKfBxxaWumG68Bue/3tjwtglig6g4K9UzO4ma4oscW50rT7Ncu
         FZ/YNkfO613B7L5TBgTHfkksmCTcBmW7GtwlxmWepmYCTL8kHo47lA0G9leCrkrHSRXS
         fLTEdtK3ttvKOia895idwS5chkvm1F8+q4/t6WMk4lxxhO/0blLiI1TiNp/F6d3oToLi
         ktyN2P05k7juKnoJtJtD5k0OxbJ9iudRNCTmS2ZB6/wr2y4apqxaW/JwakAA/wiT9k7t
         0LhVnbkjkrMgvhNs0Tfl0S0pV4hWrERjWbUPn9qSrqZS0XDr4WaeAaVEnr/pEQLe3g0q
         yl9w==
X-Gm-Message-State: AJIora9sCiaxBlagWHwKcocd0foRCVTmBcJvSluNEEPANWFC1ykRzU0B
        R38IB7wW1wjuFmlhSBYaJzOfOab+YHM6gLe8DIyjGulSFCh5+gKUNsCRkhxssXbF8cU3mENDbMV
        RxR4B2ciyP+f4rcr04OIo1WLl
X-Received: by 2002:a17:906:1b19:b0:70d:6fe8:eb44 with SMTP id o25-20020a1709061b1900b0070d6fe8eb44mr9235504ejg.129.1655469388914;
        Fri, 17 Jun 2022 05:36:28 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1umHXhoj133SUaYQ2dFkPt30Rc7hAXn4S/0TBhCi0UQuwOhLRoLLmk8YQXjeYRRgEr50dRwPA==
X-Received: by 2002:a17:906:1b19:b0:70d:6fe8:eb44 with SMTP id o25-20020a1709061b1900b0070d6fe8eb44mr9235488ejg.129.1655469388662;
        Fri, 17 Jun 2022 05:36:28 -0700 (PDT)
Received: from redhat.com ([2.54.189.19])
        by smtp.gmail.com with ESMTPSA id g10-20020a056402424a00b00435390befe2sm2934123edb.58.2022.06.17.05.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 05:36:28 -0700 (PDT)
Date:   Fri, 17 Jun 2022 08:36:24 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio: disable notification hardening by default
Message-ID: <20220617083420-mutt-send-email-mst@kernel.org>
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
> +          Enable to this

Enable this

> to harden the

handling of 

> device notifications and
> +          supress the ones that are illegal.

Experimental: not all drivers handle this correctly at this point.
If unsure, say N.


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

