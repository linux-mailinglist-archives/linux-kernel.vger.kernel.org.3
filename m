Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE90C5616BF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 11:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234088AbiF3Jqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 05:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232905AbiF3Jqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 05:46:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3B6C54338F
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 02:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656582403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2QbMHU+OhzMMFuIDST1hXi+9o9ACjxg07MCvZDGIBNE=;
        b=PJcNrlKjPH7wBVevYVnmkQ2myym0KUuEElGC5uSUjRCCMykA3DtRfXJI7sBmXIKVByMpV0
        +k3I9S97LQVBB8j5jl5YHNbnjKbCvxnpibFn+fKAFGY0rE2hAf61OEGx/l2LgCQNvF0ZeI
        O1eXnPt890J4Mh/8GJrnfHp5+AFYJq4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-98-x5U9EnMYNYiZVLJ9PkWUCg-1; Thu, 30 Jun 2022 05:46:41 -0400
X-MC-Unique: x5U9EnMYNYiZVLJ9PkWUCg-1
Received: by mail-wr1-f71.google.com with SMTP id s14-20020adfa28e000000b0020ac7532f08so2943481wra.15
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 02:46:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2QbMHU+OhzMMFuIDST1hXi+9o9ACjxg07MCvZDGIBNE=;
        b=xmJZjUcL7DcazsrdEyO6y9fJ4BkPjMA28BPf/9ghYFmRWG+N9/ErSyvzlGPM9Rlknr
         vx84nopdVZyt/a+LJh2YVO+2vTXOvjQpcxj7UwIPkwQO2CRePHDthjThFzM+IVtlekWJ
         +tH/dxyqE758or4/prA5NpjU5KcNrH/lOpvK9Qy+F0jBJw04y9C8gy07DuSUCoEZFXO9
         P1lccVwE4mMJ9aoFMoZ4Z/SYIMnVHcVAYCnKXXG+9QX7+tzzZxrLtOaClkwL9rItO2tl
         zy3wUXeOPh2le0msxTvayWm68aviB+InKtb+zCBD6gfr+MPfmZoa+EPjrE7WIvUOOVsn
         BQ2g==
X-Gm-Message-State: AJIora8LbK619Nc0TgKL085WsKEti9KM81ujxpDi99KTOOYWoJP1yI06
        mI4W1pTO7LeF8H7DvnGsuMABmeVIVBfn6t9w3xujQAmcBIrprpt/0KWz8CWeVYbykAWsbBlioaX
        j9svZMr4VMTUPAAiqqkRPqHnv
X-Received: by 2002:a05:600c:35d5:b0:3a0:2f95:720b with SMTP id r21-20020a05600c35d500b003a02f95720bmr11318293wmq.162.1656582400410;
        Thu, 30 Jun 2022 02:46:40 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u1odtLgOr7pIerZRBZjkUkO149jCT02mesrCRDdnuMsff6JWno8s5dSGdLe5NdFnFIBYkhZg==
X-Received: by 2002:a05:600c:35d5:b0:3a0:2f95:720b with SMTP id r21-20020a05600c35d500b003a02f95720bmr11318247wmq.162.1656582400074;
        Thu, 30 Jun 2022 02:46:40 -0700 (PDT)
Received: from redhat.com ([2.55.3.188])
        by smtp.gmail.com with ESMTPSA id r5-20020a05600c320500b0039db500714fsm5697297wmp.6.2022.06.30.02.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 02:46:39 -0700 (PDT)
Date:   Thu, 30 Jun 2022 05:46:34 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Alexander Atanasov <alexander.atanasov@virtuozzo.com>
Cc:     Jason Wang <jasowang@redhat.com>, kernel@openvz.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Halil Pasic <pasic@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-s390@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] virtio: Restore semantics of vq->broken in
 virtqueues
Message-ID: <20220630054532-mutt-send-email-mst@kernel.org>
References: <20220630093651.25981-1-alexander.atanasov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220630093651.25981-1-alexander.atanasov@virtuozzo.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 09:36:46AM +0000, Alexander Atanasov wrote:
> virtio: harden vring IRQ (8b4ec69d7e09) changed the use
> of vq->broken. As result vring_interrupt handles IRQs for
> broken drivers as IRQ_NONE and not IRQ_HANDLED and made impossible
> to initiallize vqs before the driver is ready, i.e. in probe method.
> Balloon driver does this and it can not load because it fails in
> vqs_init with -EIO.
> 
> So instead of changing the original intent ot the flag introduce
> a new flag vq->ready which servers the purpose to check of early IRQs
> and restore the behaviour of the vq->broken flag.
> 
> Signed-off-by: Alexander Atanasov <alexander.atanasov@virtuozzo.com>


Does

commit c346dae4f3fbce51bbd4f2ec5e8c6f9b91e93163
Author: Jason Wang <jasowang@redhat.com>
Date:   Wed Jun 22 09:29:40 2022 +0800

    virtio: disable notification hardening by default


solve the problem for you?

> ---
>  drivers/virtio/virtio_ring.c  | 20 ++++++++++++++------
>  include/linux/virtio.h        |  2 +-
>  include/linux/virtio_config.h | 10 +++++-----
>  3 files changed, 20 insertions(+), 12 deletions(-)
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Halil Pasic <pasic@linux.ibm.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Vineeth Vijayan <vneethv@linux.ibm.com>
> Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
> Cc: linux-s390@vger.kernel.org
> Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> 
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 13a7348cedff..dca3cc774584 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -100,6 +100,9 @@ struct vring_virtqueue {
>  	/* Other side has made a mess, don't try any more. */
>  	bool broken;
>  
> +	/* the queue is ready to handle interrupts  */
> +	bool ready;
> +
>  	/* Host supports indirect buffers */
>  	bool indirect;
>  
> @@ -1688,7 +1691,8 @@ static struct virtqueue *vring_create_virtqueue_packed(
>  	vq->we_own_ring = true;
>  	vq->notify = notify;
>  	vq->weak_barriers = weak_barriers;
> -	vq->broken = true;
> +	vq->broken = false;
> +	vq->ready = false;
>  	vq->last_used_idx = 0;
>  	vq->event_triggered = false;
>  	vq->num_added = 0;
> @@ -2134,7 +2138,10 @@ irqreturn_t vring_interrupt(int irq, void *_vq)
>  		return IRQ_NONE;
>  	}
>  
> -	if (unlikely(vq->broken)) {
> +	if (unlikely(vq->broken))
> +		return IRQ_HANDLED;
> +
> +	if (unlikely(!vq->ready)) {
>  		dev_warn_once(&vq->vq.vdev->dev,
>  			      "virtio vring IRQ raised before DRIVER_OK");
>  		return IRQ_NONE;
> @@ -2180,7 +2187,8 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
>  	vq->we_own_ring = false;
>  	vq->notify = notify;
>  	vq->weak_barriers = weak_barriers;
> -	vq->broken = true;
> +	vq->broken = false;
> +	vq->ready = false;
>  	vq->last_used_idx = 0;
>  	vq->event_triggered = false;
>  	vq->num_added = 0;
> @@ -2405,7 +2413,7 @@ EXPORT_SYMBOL_GPL(virtio_break_device);
>   * (probing and restoring). This function should only be called by the
>   * core, not directly by the driver.
>   */
> -void __virtio_unbreak_device(struct virtio_device *dev)
> +void __virtio_device_ready(struct virtio_device *dev)
>  {
>  	struct virtqueue *_vq;
>  
> @@ -2414,11 +2422,11 @@ void __virtio_unbreak_device(struct virtio_device *dev)
>  		struct vring_virtqueue *vq = to_vvq(_vq);
>  
>  		/* Pairs with READ_ONCE() in virtqueue_is_broken(). */
> -		WRITE_ONCE(vq->broken, false);
> +		WRITE_ONCE(vq->ready, true);
>  	}
>  	spin_unlock(&dev->vqs_list_lock);
>  }
> -EXPORT_SYMBOL_GPL(__virtio_unbreak_device);
> +EXPORT_SYMBOL_GPL(__virtio_device_ready);
>  
>  dma_addr_t virtqueue_get_desc_addr(struct virtqueue *_vq)
>  {
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index d8fdf170637c..538c5959949a 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -131,7 +131,7 @@ void unregister_virtio_device(struct virtio_device *dev);
>  bool is_virtio_device(struct device *dev);
>  
>  void virtio_break_device(struct virtio_device *dev);
> -void __virtio_unbreak_device(struct virtio_device *dev);
> +void __virtio_device_ready(struct virtio_device *dev);
>  
>  void virtio_config_changed(struct virtio_device *dev);
>  #ifdef CONFIG_PM_SLEEP
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index 49c7c32815f1..35cf1b26e05a 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -259,21 +259,21 @@ void virtio_device_ready(struct virtio_device *dev)
>  
>  	/*
>  	 * The virtio_synchronize_cbs() makes sure vring_interrupt()
> -	 * will see the driver specific setup if it sees vq->broken
> +	 * will see the driver specific setup if it sees vq->ready
>  	 * as false (even if the notifications come before DRIVER_OK).
>  	 */
>  	virtio_synchronize_cbs(dev);
> -	__virtio_unbreak_device(dev);
> +	__virtio_device_ready(dev);
>  	/*
> -	 * The transport should ensure the visibility of vq->broken
> +	 * The transport should ensure the visibility of vq->ready
>  	 * before setting DRIVER_OK. See the comments for the transport
>  	 * specific set_status() method.
>  	 *
>  	 * A well behaved device will only notify a virtqueue after
>  	 * DRIVER_OK, this means the device should "see" the coherenct
> -	 * memory write that set vq->broken as false which is done by
> +	 * memory write that set vq->ready as true which is done by
>  	 * the driver when it sees DRIVER_OK, then the following
> -	 * driver's vring_interrupt() will see vq->broken as false so
> +	 * driver's vring_interrupt() will see vq->true as true so
>  	 * we won't lose any notification.
>  	 */
>  	dev->config->set_status(dev, status | VIRTIO_CONFIG_S_DRIVER_OK);
> -- 
> 2.25.1

