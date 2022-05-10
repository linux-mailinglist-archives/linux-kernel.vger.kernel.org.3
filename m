Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3855213D6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 13:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241027AbiEJLgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 07:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233899AbiEJLgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 07:36:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AE4AE41F8E
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 04:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652182362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/6JGU3yCeXbwd8q2TiB3We0T+2lr2Ip1+nsoAPs6S2s=;
        b=YOifvgOohhYD3h49AFuojryzEohmk0Fu58c6erBapOPMwpSnGn3uysWyHELu3aK+RNKBN4
        ZEPuphFdTNlJcKKPFGImkpmQcO/tov3uOxtoGPyjdo2MucBCBcRoQ4IfRVTxWkwNV/8Ze9
        huH8V1+YHqQVzFYMR/nNeLvr+1g/Dig=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-612-jGV8qUgyP3muJtob3e284A-1; Tue, 10 May 2022 07:32:41 -0400
X-MC-Unique: jGV8qUgyP3muJtob3e284A-1
Received: by mail-wm1-f69.google.com with SMTP id z23-20020a05600c221700b003942fd37764so1141276wml.8
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 04:32:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/6JGU3yCeXbwd8q2TiB3We0T+2lr2Ip1+nsoAPs6S2s=;
        b=zVEeCHaoPQAC/flNJPDZDCj4lWNOtfTaSzQOttTI32zPXS9TLpkjpVk9vRcLeR7SXR
         FS8JirdTpXOyBzyRAyXbZ0hfansBL9boF2T2zUClcsWHvV1jnVXJ89/MgAuZ+NvKcG4t
         le32ooHutIK/aDgoWAMT9uzD664KCKOJysSUHzwOnjsOXD3urOyeemRg1rHIn2xNVuQF
         ARRn/7IU4CCozd0lRqTQccH5QpzwFCKoWaGq5Bff2RB+TRYiunXFdb8XyKBN9Cs6klH3
         qTmqBtCyTZxIPYw5kVsUh8g/iAsYjKxonZRKqxKjicZKcq/VJElMrGoCzxaWsE6yWTlK
         hL2w==
X-Gm-Message-State: AOAM533Ka+4b/7eR/pj2PXD4ysQgAR4lRie7CEkraOa2G72ZBPO5ld+D
        VDAl1Oli9Dlv3Oewlg8frwL9Q4FwKg8uG6UdO6F+FEv+Y0lqwjkghHOcCobkyYLbdTty+WMeQbz
        +LV45UYVdXJI6ZszzY09BX0fu
X-Received: by 2002:a05:6000:144f:b0:20c:6090:3040 with SMTP id v15-20020a056000144f00b0020c60903040mr17724136wrx.479.1652182360186;
        Tue, 10 May 2022 04:32:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzsEleGX5w1OSWKo2o5f2WSyJKHdkzs/SrI4J/pz4kEhj9uYYK5k7bkfywVoL/OsCq+T9m4og==
X-Received: by 2002:a05:6000:144f:b0:20c:6090:3040 with SMTP id v15-20020a056000144f00b0020c60903040mr17724121wrx.479.1652182359954;
        Tue, 10 May 2022 04:32:39 -0700 (PDT)
Received: from redhat.com ([2.55.130.230])
        by smtp.gmail.com with ESMTPSA id c17-20020a056000105100b0020c5253d8ccsm13457840wrx.24.2022.05.10.04.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 04:32:39 -0700 (PDT)
Date:   Tue, 10 May 2022 07:32:35 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, paulmck@kernel.org, maz@kernel.org,
        pasic@linux.ibm.com, cohuck@redhat.com, eperezma@redhat.com,
        lulu@redhat.com, sgarzare@redhat.com, xuanzhuo@linux.alibaba.com
Subject: Re: [PATCH V4 8/9] virtio: harden vring IRQ
Message-ID: <20220510072833-mutt-send-email-mst@kernel.org>
References: <20220507071954.14455-1-jasowang@redhat.com>
 <20220507071954.14455-9-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220507071954.14455-9-jasowang@redhat.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 07, 2022 at 03:19:53PM +0800, Jason Wang wrote:
> This is a rework on the previous IRQ hardening that is done for
> virtio-pci where several drawbacks were found and were reverted:
> 
> 1) try to use IRQF_NO_AUTOEN which is not friendly to affinity managed IRQ
>    that is used by some device such as virtio-blk
> 2) done only for PCI transport
> 
> The vq->broken is re-used in this patch for implementing the IRQ
> hardening. The vq->broken is set to true during both initialization
> and reset. And the vq->broken is set to false in
> virtio_device_ready(). Then vring_interrupt can check and return when
> vq->broken is true. And in this case, switch to return IRQ_NONE to let
> the interrupt core aware of such invalid interrupt to prevent IRQ
> storm.
> 
> The reason of using a per queue variable instead of a per device one
> is that we may need it for per queue reset hardening in the future.
> 
> Note that the hardening is only done for vring interrupt since the
> config interrupt hardening is already done in commit 22b7050a024d7
> ("virtio: defer config changed notifications"). But the method that is
> used by config interrupt can't be reused by the vring interrupt
> handler because it uses spinlock to do the synchronization which is
> expensive.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Halil Pasic <pasic@linux.ibm.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio.c       | 15 ++++++++++++---
>  drivers/virtio/virtio_ring.c  | 11 +++++++----
>  include/linux/virtio_config.h | 12 ++++++++++++
>  3 files changed, 31 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index 8dde44ea044a..696f5ba4f38e 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -220,6 +220,15 @@ static int virtio_features_ok(struct virtio_device *dev)
>   * */
>  void virtio_reset_device(struct virtio_device *dev)
>  {
> +	/*
> +	 * The below virtio_synchronize_cbs() guarantees that any
> +	 * interrupt for this line arriving after
> +	 * virtio_synchronize_vqs() has completed is guaranteed to see
> +	 * driver_ready == false.
> +	 */
> +	virtio_break_device(dev);
> +	virtio_synchronize_cbs(dev);
> +
>  	dev->config->reset(dev);
>  }
>  EXPORT_SYMBOL_GPL(virtio_reset_device);
> @@ -428,6 +437,9 @@ int register_virtio_device(struct virtio_device *dev)
>  	dev->config_enabled = false;
>  	dev->config_change_pending = false;
>  
> +	INIT_LIST_HEAD(&dev->vqs);
> +	spin_lock_init(&dev->vqs_list_lock);
> +
>  	/* We always start by resetting the device, in case a previous
>  	 * driver messed it up.  This also tests that code path a little. */
>  	virtio_reset_device(dev);
> @@ -435,9 +447,6 @@ int register_virtio_device(struct virtio_device *dev)
>  	/* Acknowledge that we've seen the device. */
>  	virtio_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE);
>  
> -	INIT_LIST_HEAD(&dev->vqs);
> -	spin_lock_init(&dev->vqs_list_lock);
> -
>  	/*
>  	 * device_add() causes the bus infrastructure to look for a matching
>  	 * driver.
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 5b7df7c455f0..9dfad2890d7a 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1690,7 +1690,7 @@ static struct virtqueue *vring_create_virtqueue_packed(
>  	vq->we_own_ring = true;
>  	vq->notify = notify;
>  	vq->weak_barriers = weak_barriers;
> -	vq->broken = false;
> +	vq->broken = true;
>  	vq->last_used_idx = 0;
>  	vq->event_triggered = false;
>  	vq->num_added = 0;
> @@ -2136,8 +2136,11 @@ irqreturn_t vring_interrupt(int irq, void *_vq)
>  		return IRQ_NONE;
>  	}
>  
> -	if (unlikely(vq->broken))
> -		return IRQ_HANDLED;
> +	if (unlikely(vq->broken)) {
> +		dev_warn_once(&vq->vq.vdev->dev,
> +			      "virtio vring IRQ raised before DRIVER_OK");
> +		return IRQ_NONE;
> +	}
>  
>  	/* Just a hint for performance: so it's ok that this can be racy! */
>  	if (vq->event)
> @@ -2179,7 +2182,7 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
>  	vq->we_own_ring = false;
>  	vq->notify = notify;
>  	vq->weak_barriers = weak_barriers;
> -	vq->broken = false;
> +	vq->broken = true;
>  	vq->last_used_idx = 0;
>  	vq->event_triggered = false;
>  	vq->num_added = 0;
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index d8a2340f928e..23f1694cdbd5 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -256,6 +256,18 @@ void virtio_device_ready(struct virtio_device *dev)
>  	unsigned status = dev->config->get_status(dev);
>  
>  	BUG_ON(status & VIRTIO_CONFIG_S_DRIVER_OK);
> +
> +	/*
> +	 * The virtio_synchronize_cbs() makes sure vring_interrupt()
> +	 * will see the driver specific setup if it sees vq->broken
> +	 * as false.
> +	 */
> +	virtio_synchronize_cbs(dev);

since you mention vq->broken above, maybe add
	"set vq->broken to false"

> +	__virtio_unbreak_device(dev);
> +	/*
> +	 * The transport is expected ensure the visibility of

to ensure

> +	 * vq->broken

let's add: "visibility by vq callbacks"

> before setting VIRTIO_CONFIG_S_DRIVER_OK.
> +	 */


Can I see some analysis of existing transports showing
this is actually the case for them?
And maybe add a comment near set_status to document the
requirement.

>  	dev->config->set_status(dev, status | VIRTIO_CONFIG_S_DRIVER_OK);
>  }
>  
> -- 
> 2.25.1

