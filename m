Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5619561F8F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 17:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235981AbiF3PoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 11:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235669AbiF3PoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 11:44:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 14CF71AD8A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 08:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656603843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b2JRsgc2hWOY7hbuh3CsyQAbWyr8QoHDSpgMdwF3Wow=;
        b=UDMYcCrtBSRIEZt5Ybkra4mXpan9lnBaFNOdykFpijT+ZtKB9HhaeXEKMrAsob8k9X/FO9
        I1jKApJYlPO6Fym4J34whlnG7MJUSWT2orPqPSTHpELeU2f1k63ePNjixOncuBGdkgq/H8
        BaEEteG6Oa5OPf9XlSFpkABgr4CfPps=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-617-7cUeDr9sNSSZIgDh784U7A-1; Thu, 30 Jun 2022 11:43:59 -0400
X-MC-Unique: 7cUeDr9sNSSZIgDh784U7A-1
Received: by mail-wr1-f71.google.com with SMTP id o1-20020adfba01000000b0021b90bd28d2so3228157wrg.14
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 08:43:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=b2JRsgc2hWOY7hbuh3CsyQAbWyr8QoHDSpgMdwF3Wow=;
        b=4eLZSxCvsE46ZtzrytBewtQHYH+LjdXQZa4As7OyYFZ5qTvvGp4GTYJxavw2jgwgqC
         /N0JUxxChm+xMwW91HtArZEkxOeh9fSXesjiG3BFVeu1/s+SroYrA6ILiUFAHOI6Jm7Q
         acVyYl+P6jpVRwz7NPNZ2s/S6jWiahwqnSvvZS6e9aU6DVZlQ6zo/TwM4OFD+Zqe8I0N
         3suRkl88efdPDGfPZk+J5E3Wa7p26E+zK+/xEbpJNzmfWoyUA22+qTsxdQvoB3NIVSON
         c6B0xTY2tKJy1xgdNZA5jdHf28iXp84s44UKq5Gdi6YkTa9NPc/F65xCWF214Qb//PCy
         gstQ==
X-Gm-Message-State: AJIora9A4Q69QqSmk3qddY/L3zkzRt6yDLrEECc6fV3Ls0XE5tVmTzLu
        yMarBpbMTSEf1qw8NWygHTsFqsPoO5FuNk+idZQSISr6ks0m5e0yfK7brr0yhE4CKw1g1YotcVf
        MVZifhECdAx0GU1b/n7MeIWhi
X-Received: by 2002:a5d:6487:0:b0:21b:983c:5508 with SMTP id o7-20020a5d6487000000b0021b983c5508mr8957402wri.185.1656603837947;
        Thu, 30 Jun 2022 08:43:57 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1s2tgO1/wtgZNb3F5h0bZwn+9gYHXB01spFOKXbw+pimANXZJW4Rt7moQE8g9ZSuC2ZSNSp/A==
X-Received: by 2002:a5d:6487:0:b0:21b:983c:5508 with SMTP id o7-20020a5d6487000000b0021b983c5508mr8957377wri.185.1656603837707;
        Thu, 30 Jun 2022 08:43:57 -0700 (PDT)
Received: from redhat.com ([2.55.3.188])
        by smtp.gmail.com with ESMTPSA id j14-20020adfa54e000000b0021b93b29cacsm24532667wrb.99.2022.06.30.08.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 08:43:57 -0700 (PDT)
Date:   Thu, 30 Jun 2022 11:43:52 -0400
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
Message-ID: <20220630114142-mutt-send-email-mst@kernel.org>
References: <20220630093651.25981-1-alexander.atanasov@virtuozzo.com>
 <20220630054532-mutt-send-email-mst@kernel.org>
 <1c72645a-f162-2649-bdb6-a28ba93bccd2@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1c72645a-f162-2649-bdb6-a28ba93bccd2@virtuozzo.com>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 01:08:53PM +0300, Alexander Atanasov wrote:
> Hello,
> 
> On 30/06/2022 12:46, Michael S. Tsirkin wrote:
> > On Thu, Jun 30, 2022 at 09:36:46AM +0000, Alexander Atanasov wrote:
> > > virtio: harden vring IRQ (8b4ec69d7e09) changed the use
> > > of vq->broken. As result vring_interrupt handles IRQs for
> > > broken drivers as IRQ_NONE and not IRQ_HANDLED and made impossible
> > > to initiallize vqs before the driver is ready, i.e. in probe method.
> > > Balloon driver does this and it can not load because it fails in
> > > vqs_init with -EIO.
> > > 
> > > So instead of changing the original intent ot the flag introduce
> > > a new flag vq->ready which servers the purpose to check of early IRQs
> > > and restore the behaviour of the vq->broken flag.
> > > 
> > > Signed-off-by: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
> > 
> > Does
> > 
> > commit c346dae4f3fbce51bbd4f2ec5e8c6f9b91e93163
> > Author: Jason Wang <jasowang@redhat.com>
> > Date:   Wed Jun 22 09:29:40 2022 +0800
> > 
> >      virtio: disable notification hardening by default
> > 
> > 
> > solve the problem for you?
> 
> 
> No, it won't if CONFIG_VIRTIO_HARDEN_NOTIFICATION is enabled - balloon still
> won't be able to init vqs.

Yea I intend to make CONFIG_VIRTIO_HARDEN_NOTIFICATION 
depend on BROKEN for now.

> The problem is in virtqueue_add_split and virtqueue_add_packed - can not set
> driver_ok without queues.
> 
> The return value of the vring_interrupt gets different - and iirc IRQ_NONE
> for broken device can lead to interrupt storms - i am not sure if that is
> valid for virtio devices yet but for real harware most likely.

No, I think it's the reverse. With IRQ_HANDLED an interrupt
storm will keep overloading the CPU since driver tells
kernel all is well. With IRQ_NONE kernel will eventually
intervene and disable the irq.

> Either way if
> you have a mix of  drivers working differently depending on return of the
> handler  it would get really messy.
> 
> RR's original intent was to flag a driver as bad why reuse it like that  ?
> 
> 
> > >   drivers/virtio/virtio_ring.c  | 20 ++++++++++++++------
> > >   include/linux/virtio.h        |  2 +-
> > >   include/linux/virtio_config.h | 10 +++++-----
> > >   3 files changed, 20 insertions(+), 12 deletions(-)
> > > 
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > > Cc: Marc Zyngier <maz@kernel.org>
> > > Cc: Halil Pasic <pasic@linux.ibm.com>
> > > Cc: Cornelia Huck <cohuck@redhat.com>
> > > Cc: Vineeth Vijayan <vneethv@linux.ibm.com>
> > > Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
> > > Cc: linux-s390@vger.kernel.org
> > > Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > 
> > > 
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > index 13a7348cedff..dca3cc774584 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -100,6 +100,9 @@ struct vring_virtqueue {
> > >   	/* Other side has made a mess, don't try any more. */
> > >   	bool broken;
> > > +	/* the queue is ready to handle interrupts  */
> > > +	bool ready;
> > > +
> > >   	/* Host supports indirect buffers */
> > >   	bool indirect;
> > > @@ -1688,7 +1691,8 @@ static struct virtqueue *vring_create_virtqueue_packed(
> > >   	vq->we_own_ring = true;
> > >   	vq->notify = notify;
> > >   	vq->weak_barriers = weak_barriers;
> > > -	vq->broken = true;
> > > +	vq->broken = false;
> > > +	vq->ready = false;
> > >   	vq->last_used_idx = 0;
> > >   	vq->event_triggered = false;
> > >   	vq->num_added = 0;
> > > @@ -2134,7 +2138,10 @@ irqreturn_t vring_interrupt(int irq, void *_vq)
> > >   		return IRQ_NONE;
> > >   	}
> > > -	if (unlikely(vq->broken)) {
> > > +	if (unlikely(vq->broken))
> > > +		return IRQ_HANDLED;
> > > +
> > > +	if (unlikely(!vq->ready)) {
> > >   		dev_warn_once(&vq->vq.vdev->dev,
> > >   			      "virtio vring IRQ raised before DRIVER_OK");
> > >   		return IRQ_NONE;
> > > @@ -2180,7 +2187,8 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
> > >   	vq->we_own_ring = false;
> > >   	vq->notify = notify;
> > >   	vq->weak_barriers = weak_barriers;
> > > -	vq->broken = true;
> > > +	vq->broken = false;
> > > +	vq->ready = false;
> > >   	vq->last_used_idx = 0;
> > >   	vq->event_triggered = false;
> > >   	vq->num_added = 0;
> > > @@ -2405,7 +2413,7 @@ EXPORT_SYMBOL_GPL(virtio_break_device);
> > >    * (probing and restoring). This function should only be called by the
> > >    * core, not directly by the driver.
> > >    */
> > > -void __virtio_unbreak_device(struct virtio_device *dev)
> > > +void __virtio_device_ready(struct virtio_device *dev)
> > >   {
> > >   	struct virtqueue *_vq;
> > > @@ -2414,11 +2422,11 @@ void __virtio_unbreak_device(struct virtio_device *dev)
> > >   		struct vring_virtqueue *vq = to_vvq(_vq);
> > >   		/* Pairs with READ_ONCE() in virtqueue_is_broken(). */
> > > -		WRITE_ONCE(vq->broken, false);
> > > +		WRITE_ONCE(vq->ready, true);
> > >   	}
> > >   	spin_unlock(&dev->vqs_list_lock);
> > >   }
> > > -EXPORT_SYMBOL_GPL(__virtio_unbreak_device);
> > > +EXPORT_SYMBOL_GPL(__virtio_device_ready);
> > >   dma_addr_t virtqueue_get_desc_addr(struct virtqueue *_vq)
> > >   {
> > > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > > index d8fdf170637c..538c5959949a 100644
> > > --- a/include/linux/virtio.h
> > > +++ b/include/linux/virtio.h
> > > @@ -131,7 +131,7 @@ void unregister_virtio_device(struct virtio_device *dev);
> > >   bool is_virtio_device(struct device *dev);
> > >   void virtio_break_device(struct virtio_device *dev);
> > > -void __virtio_unbreak_device(struct virtio_device *dev);
> > > +void __virtio_device_ready(struct virtio_device *dev);
> > >   void virtio_config_changed(struct virtio_device *dev);
> > >   #ifdef CONFIG_PM_SLEEP
> > > diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> > > index 49c7c32815f1..35cf1b26e05a 100644
> > > --- a/include/linux/virtio_config.h
> > > +++ b/include/linux/virtio_config.h
> > > @@ -259,21 +259,21 @@ void virtio_device_ready(struct virtio_device *dev)
> > >   	/*
> > >   	 * The virtio_synchronize_cbs() makes sure vring_interrupt()
> > > -	 * will see the driver specific setup if it sees vq->broken
> > > +	 * will see the driver specific setup if it sees vq->ready
> > >   	 * as false (even if the notifications come before DRIVER_OK).
> > >   	 */
> > >   	virtio_synchronize_cbs(dev);
> > > -	__virtio_unbreak_device(dev);
> > > +	__virtio_device_ready(dev);
> > >   	/*
> > > -	 * The transport should ensure the visibility of vq->broken
> > > +	 * The transport should ensure the visibility of vq->ready
> > >   	 * before setting DRIVER_OK. See the comments for the transport
> > >   	 * specific set_status() method.
> > >   	 *
> > >   	 * A well behaved device will only notify a virtqueue after
> > >   	 * DRIVER_OK, this means the device should "see" the coherenct
> > > -	 * memory write that set vq->broken as false which is done by
> > > +	 * memory write that set vq->ready as true which is done by
> > >   	 * the driver when it sees DRIVER_OK, then the following
> > > -	 * driver's vring_interrupt() will see vq->broken as false so
> > > +	 * driver's vring_interrupt() will see vq->true as true so
> > >   	 * we won't lose any notification.
> > >   	 */
> > >   	dev->config->set_status(dev, status | VIRTIO_CONFIG_S_DRIVER_OK);
> > > -- 
> > > 2.25.1
> 
> -- 
> Regards,
> Alexander Atanasov

