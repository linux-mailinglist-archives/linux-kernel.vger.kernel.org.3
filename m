Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4957E50DADD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 10:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbiDYILs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 04:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiDYILk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 04:11:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 942A4272C
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 01:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650874116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GjbwvOEeWOxXzRSzSZG07fPrd7M1g4I0kIEVzwMrJBw=;
        b=aDgXxomOX8dz5as+jDL5wOEI+Z2V2rI/1CUPC4mcHGwp9BAjItE1n5D0F0dBkp5RH9V93T
        MAZLZLyUbCfcsxJzmyeKBtsGc6egA5YAst4U3fjPyrbau7v+ymke0Cbcen38yQvk//FsA8
        thOwH9MiJgmAyxDnGShuGxpHkFCGqcQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-150-9sR4Vp_KPiyMshugEOEpww-1; Mon, 25 Apr 2022 04:08:35 -0400
X-MC-Unique: 9sR4Vp_KPiyMshugEOEpww-1
Received: by mail-wr1-f69.google.com with SMTP id w4-20020adfbac4000000b0020acba4b779so1627699wrg.22
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 01:08:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GjbwvOEeWOxXzRSzSZG07fPrd7M1g4I0kIEVzwMrJBw=;
        b=bUB0lPRLHjx5LMgiVYVgseR9KkfETh6M0z+pVsJlkdjKTLMxCzxKVdZO3ThjDZ0OMB
         ccNL7LC2w4k6dgL214KiCw/qT78GoJfaL47Y7rpCbm3cswSOjwmBve14yEhp+xCXdSvN
         L1DQEbckERf6qI2MOGwDzuWue6rappTghGY3NUjl1UQeiurverXBERj9S8ErJUg2E/FN
         W5HE1ibcUihBj90RBcq+DJIKwwELqGFZTaCvddz27s5VLGC89PF0wYAvDPJnJfQ5biiy
         +nviz3ncduTpd/JS1mF2xB6Rrx/8S5lfFb9XdgfqxTHxAPhiZqGY9pCh2gcPueHgb6yy
         QGKA==
X-Gm-Message-State: AOAM5338i7jYDT2nyCcO4VUMrITb3ErJq4jsRgYTOgGvALJG8X8Un1sD
        GCDe/CYbm3MOsSTxeJWIkvXVcpOsPIko4ZrK2zi5tffbG+JqdvbnOKDAJ2d5sQlMDOoPFsU1aLc
        3jGtSkB9UDjznKDxZn+m7hdAL
X-Received: by 2002:a05:600c:29c3:b0:392:af6e:b500 with SMTP id s3-20020a05600c29c300b00392af6eb500mr21517494wmd.13.1650874114125;
        Mon, 25 Apr 2022 01:08:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwXGUYkNTWUWYGgOmwLXbwR8xJKoVb31vM9aHcOr7nHFi4up04xH9rsaIBf5GsTykbF9G7BSw==
X-Received: by 2002:a05:600c:29c3:b0:392:af6e:b500 with SMTP id s3-20020a05600c29c300b00392af6eb500mr21517469wmd.13.1650874113874;
        Mon, 25 Apr 2022 01:08:33 -0700 (PDT)
Received: from redhat.com ([2.55.142.213])
        by smtp.gmail.com with ESMTPSA id n10-20020a5d598a000000b0020a9493bdddsm9299870wri.40.2022.04.25.01.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 01:08:32 -0700 (PDT)
Date:   Mon, 25 Apr 2022 04:08:27 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, sgarzare@redhat.com,
        eperezma@redhat.com, lulu@redhat.com, tglx@linutronix.de,
        peterz@infradead.org, paulmck@kernel.org, maz@kernel.org,
        pasic@linux.ibm.com, cohuck@redhat.com
Subject: Re: [PATCH V3 6/9] virtio-ccw: implement synchronize_cbs()
Message-ID: <20220425040512-mutt-send-email-mst@kernel.org>
References: <20220425024418.8415-1-jasowang@redhat.com>
 <20220425024418.8415-7-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425024418.8415-7-jasowang@redhat.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 10:44:15AM +0800, Jason Wang wrote:
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


This is the only one that is giving me pause. Halil, Cornelia,
should we be concerned about the performance impact here?
Any chance it can be tested?

> ---
>  drivers/s390/virtio/virtio_ccw.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> index d35e7a3f7067..c19f07a82d62 100644
> --- a/drivers/s390/virtio/virtio_ccw.c
> +++ b/drivers/s390/virtio/virtio_ccw.c
> @@ -62,6 +62,7 @@ struct virtio_ccw_device {
>  	unsigned int revision; /* Transport revision */
>  	wait_queue_head_t wait_q;
>  	spinlock_t lock;
> +	spinlock_t irq_lock;
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
> +	/*
> +	 * Synchronize with the vring_interrupt() called by
> +	 * virtio_ccw_int_handler().
> +	 */
> +	spin_lock(&vcdev->irq_lock);
> +	spin_unlock(&vcdev->irq_lock);
> +
> +	if (info) {
> +		/*
> +		 * Synchronize with the vring_interrupt() with airq indicator
> +		 */
> +		write_lock(&info->lock);
> +		write_unlock(&info->lock);
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
> +	spin_lock_irqsave(&vcdev->irq_lock, flags);
>  	for_each_set_bit(i, indicators(vcdev),
>  			 sizeof(*indicators(vcdev)) * BITS_PER_BYTE) {
>  		/* The bit clear must happen before the vring kick. */
> @@ -1114,6 +1139,7 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
>  		vq = virtio_ccw_vq_by_ind(vcdev, i);
>  		vring_interrupt(0, vq);
>  	}
> +	spin_unlock_irqrestore(&vcdev->irq_lock, flags);
>  	if (test_bit(0, indicators2(vcdev))) {
>  		virtio_config_changed(&vcdev->vdev);
>  		clear_bit(0, indicators2(vcdev));
> @@ -1284,6 +1310,7 @@ static int virtio_ccw_online(struct ccw_device *cdev)
>  	init_waitqueue_head(&vcdev->wait_q);
>  	INIT_LIST_HEAD(&vcdev->virtqueues);
>  	spin_lock_init(&vcdev->lock);
> +	spin_lock_init(&vcdev->irq_lock);
>  	mutex_init(&vcdev->io_lock);
>  
>  	spin_lock_irqsave(get_ccwdev_lock(cdev), flags);
> -- 
> 2.25.1

