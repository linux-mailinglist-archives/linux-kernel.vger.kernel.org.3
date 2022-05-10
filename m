Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E30BF5213BC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 13:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241022AbiEJLcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 07:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240994AbiEJLb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 07:31:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2AF08237B96
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 04:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652182078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NBBnb2I2NKEOa24s2priljbXubiGaWfTmbEUyqlIXqU=;
        b=Mr7nN2cjLu1vronnICIapd1mPe39OKFy3wsx6JfZoyMqIWR/iHgteFcv3JtxICPvTUUPZF
        rAw2ps8+VfiRnEFzBojeQLjqTPDoc4eE52hyCoIQdaUXZiuGG0qmVh9wuVX+MJi3RcA4Uq
        MgO2VzYIUeJ9F/T0n77IpyjT79X4IKg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-669--24z1fYkNj2QIvbExi_Ryg-1; Tue, 10 May 2022 07:27:57 -0400
X-MC-Unique: -24z1fYkNj2QIvbExi_Ryg-1
Received: by mail-wm1-f71.google.com with SMTP id v191-20020a1cacc8000000b0038ce818d2efso5159741wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 04:27:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NBBnb2I2NKEOa24s2priljbXubiGaWfTmbEUyqlIXqU=;
        b=arMWToJufTgAj8+Ot3szFP1REzW8X/wEwcFoPJCh9yPX6dyb4wTKPaJI+YSXxLMhO4
         LGfdenlhMOnGo6La1INXKAY33zXFKvdR1XZxMP6ylK2PYdScinUsLoWvSFGIVwtJDlc+
         tOl0N5niL8xlqZYBVCOQJIfmQWoyiQdONRZ35q/DwWCHzjfqoZ4rwl7BKb/IvmR8MWXP
         +dO5MwWE92fLQcw3S8Zd6RF7xVrM5trrm4LpBpT4tVYqblIVa+V1Z8a2hXceJj1TqZZp
         scbG9SK8Vgu+SGqNXDQr6SY5uNme/f9sjd8fmRSMkCSNG2DQeDbS83XpGQV1MY8bybOK
         90aQ==
X-Gm-Message-State: AOAM533Aw+K6oG7OJgPgFwLme4HoIj07rjH+QtAQrtBSceKG+yaAg3pw
        L2drHcUR4v4Z1fjdPPPfggpgIO4ObBPV24/obJoJNdyNm+0Mmi6BcdJKL5dYbvdZrZ0Ze+G1phM
        D1v9lUoQMy4vMKcdNBHSx2DaN
X-Received: by 2002:adf:d1e2:0:b0:20c:7012:47c3 with SMTP id g2-20020adfd1e2000000b0020c701247c3mr18327086wrd.631.1652182075784;
        Tue, 10 May 2022 04:27:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwnvYdgZfzsuO6nkuqGaiNO3U1dm9Ph0Vrt/DPepxKDYsE4pJN5El85U8fk2uFunwTZ9CLMlA==
X-Received: by 2002:adf:d1e2:0:b0:20c:7012:47c3 with SMTP id g2-20020adfd1e2000000b0020c701247c3mr18327073wrd.631.1652182075584;
        Tue, 10 May 2022 04:27:55 -0700 (PDT)
Received: from redhat.com ([2.55.130.230])
        by smtp.gmail.com with ESMTPSA id c17-20020a056000105100b0020c5253d8ccsm13448149wrx.24.2022.05.10.04.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 04:27:55 -0700 (PDT)
Date:   Tue, 10 May 2022 07:27:51 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, paulmck@kernel.org, maz@kernel.org,
        pasic@linux.ibm.com, cohuck@redhat.com, eperezma@redhat.com,
        lulu@redhat.com, sgarzare@redhat.com, xuanzhuo@linux.alibaba.com
Subject: Re: [PATCH V4 6/9] virtio-ccw: implement synchronize_cbs()
Message-ID: <20220510072451-mutt-send-email-mst@kernel.org>
References: <20220507071954.14455-1-jasowang@redhat.com>
 <20220507071954.14455-7-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220507071954.14455-7-jasowang@redhat.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 07, 2022 at 03:19:51PM +0800, Jason Wang wrote:
> This patch tries to implement the synchronize_cbs() for ccw. For the
> vring_interrupt() that is called via virtio_airq_handler(), the
> synchronization is simply done via the airq_info's lock. For the
> vring_interrupt() that is called via virtio_ccw_int_handler(), a per
> device spinlock for irq is introduced ans used in the synchronization
> method.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Halil Pasic <pasic@linux.ibm.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/s390/virtio/virtio_ccw.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> index d35e7a3f7067..001e1f0e6037 100644
> --- a/drivers/s390/virtio/virtio_ccw.c
> +++ b/drivers/s390/virtio/virtio_ccw.c
> @@ -62,6 +62,7 @@ struct virtio_ccw_device {
>  	unsigned int revision; /* Transport revision */
>  	wait_queue_head_t wait_q;
>  	spinlock_t lock;
> +	rwlock_t irq_lock;
>  	struct mutex io_lock; /* Serializes I/O requests */
>  	struct list_head virtqueues;
>  	bool is_thinint;
> @@ -984,6 +985,27 @@ static const char *virtio_ccw_bus_name(struct virtio_device *vdev)
>  	return dev_name(&vcdev->cdev->dev);
>  }
>  
> +static void virtio_ccw_synchronize_cbs(struct virtio_device *vdev)
> +{
> +	struct virtio_ccw_device *vcdev = to_vc_device(vdev);
> +	struct airq_info *info = vcdev->airq_info;
> +
> +	if (info) {
> +		/*
> +		 * Synchronize with the vring_interrupt() with airq indicator
> +		 */
> +		write_lock(&info->lock);
> +		write_unlock(&info->lock);
> +	} else {
> +		/*
> +		 * Synchronize with the vring_interrupt() called by
> +		 * virtio_ccw_int_handler().
> +		 */
> +		write_lock(&vcdev->irq_lock);
> +		write_unlock(&vcdev->irq_lock);
> +	}
> +}
> +
>  static const struct virtio_config_ops virtio_ccw_config_ops = {
>  	.get_features = virtio_ccw_get_features,
>  	.finalize_features = virtio_ccw_finalize_features,
> @@ -995,6 +1017,7 @@ static const struct virtio_config_ops virtio_ccw_config_ops = {
>  	.find_vqs = virtio_ccw_find_vqs,
>  	.del_vqs = virtio_ccw_del_vqs,
>  	.bus_name = virtio_ccw_bus_name,
> +	.synchronize_cbs = virtio_ccw_synchronize_cbs,
>  };
>  
>  
> @@ -1079,6 +1102,7 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
>  {
>  	__u32 activity = intparm & VIRTIO_CCW_INTPARM_MASK;
>  	struct virtio_ccw_device *vcdev = dev_get_drvdata(&cdev->dev);
> +	unsigned long flags;
>  	int i;
>  	struct virtqueue *vq;
>  
> @@ -1106,6 +1130,7 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
>  			vcdev->err = -EIO;
>  	}
>  	virtio_ccw_check_activity(vcdev, activity);
> +	read_lock_irqsave(&vcdev->irq_lock, flags);
>  	for_each_set_bit(i, indicators(vcdev),
>  			 sizeof(*indicators(vcdev)) * BITS_PER_BYTE) {
>  		/* The bit clear must happen before the vring kick. */

Cornelia sent a lockdep trace on this.

Basically I think this gets the irqsave/restore logic wrong.
It attempts to disable irqs in the handler (which is an interrupt
anyway).
And it does not disable irqs in the synchronize_cbs.

As a result in interrupt might try to take a read lock while
.synchronize_cbs has the writer lock, resulting in a deadlock.

I think you want regular read_lock + write_lock_irq.


> @@ -1114,6 +1139,7 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
>  		vq = virtio_ccw_vq_by_ind(vcdev, i);
>  		vring_interrupt(0, vq);
>  	}
> +	read_unlock_irqrestore(&vcdev->irq_lock, flags);
>  	if (test_bit(0, indicators2(vcdev))) {
>  		virtio_config_changed(&vcdev->vdev);
>  		clear_bit(0, indicators2(vcdev));
> @@ -1284,6 +1310,7 @@ static int virtio_ccw_online(struct ccw_device *cdev)
>  	init_waitqueue_head(&vcdev->wait_q);
>  	INIT_LIST_HEAD(&vcdev->virtqueues);
>  	spin_lock_init(&vcdev->lock);
> +	rwlock_init(&vcdev->irq_lock);
>  	mutex_init(&vcdev->io_lock);
>  
>  	spin_lock_irqsave(get_ccwdev_lock(cdev), flags);
> -- 
> 2.25.1

