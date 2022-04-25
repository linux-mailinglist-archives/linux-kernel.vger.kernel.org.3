Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D20050E288
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 16:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242310AbiDYODN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 10:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242296AbiDYODK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 10:03:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1ED8315702
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 07:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650895204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LCRBXICKlc3ggtUyIrchkbmub7vl/ize3vbtxq1kFlQ=;
        b=jWpl0gMEDS6NezsJSvVDc0o0gH/rhxaiadSiGhVJGJ7gN8Px+z46zjPIkThA/sALG0Scgk
        9+76Y67Y6vtrwaqv5GJgmsW0QS17N5tOjXfkLcu4XelmEK+0Pf2cv8z+cnlPYDwwDwZVZy
        Wxd7qf8cuAN1TU6tEAqWEX31EEmTl10=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-85-sNaL8U1GO-uX8x_B9pFXzw-1; Mon, 25 Apr 2022 10:00:01 -0400
X-MC-Unique: sNaL8U1GO-uX8x_B9pFXzw-1
Received: by mail-wm1-f72.google.com with SMTP id n25-20020a05600c3b9900b0038ff033b654so2504885wms.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 07:00:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LCRBXICKlc3ggtUyIrchkbmub7vl/ize3vbtxq1kFlQ=;
        b=DIuvLfXYZyV2nzKuerHdlT4yF2Aqjr2rimBIJ71dj8yvCbpbKrr7Eo6/IFDwSkcfYT
         f5qTMSEZQytR5vc9VHKtGy8SsnPoKlJHwn4rBvQfVli3ph0DC1Wlpg7EUDbrOHxgH7zq
         pZ715rzufPfVf8Q7qT4jZhSTSnSiilxp7NBxXivXdeWgYMo4Yj39w1p6TSjZoOZmSCo7
         QiH1DDp1Fjp45G7nhkQRgIKl56Qnx2gbSiS1csCB4F3kbhS8oDEu4oLrpxHOzpSXhkgp
         dU99tGfv38Va0vtMWF9Negs85Ixd/tE9lsHpFjLQUmLqn8VFvsfkjYeCR6ewrWZMF/Ij
         Ki/Q==
X-Gm-Message-State: AOAM532o0huPDEQZKMDQbul5CUI7NdQA9B2Ip1l8N4QKFKrG+Qvn8xHI
        4j9dd1XzWJa3SjuN2exwZ9NZSv1Pn8NJWMMvPZGejLPOmGF7miY13cvJjStn4fGVEMWzQpu2ovH
        ed+pFxve+Mh4YAMbATrizOT3j
X-Received: by 2002:a5d:53c1:0:b0:20a:db5d:2590 with SMTP id a1-20020a5d53c1000000b0020adb5d2590mr4313877wrw.411.1650895200453;
        Mon, 25 Apr 2022 07:00:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw4bxERd0FIVUxXcZBmcfh1BwLDZLpCr0yUyxle6hvnT6hbY5zk1PQnWmI1tP1BOBTSqRDMWQ==
X-Received: by 2002:a5d:53c1:0:b0:20a:db5d:2590 with SMTP id a1-20020a5d53c1000000b0020adb5d2590mr4313858wrw.411.1650895200199;
        Mon, 25 Apr 2022 07:00:00 -0700 (PDT)
Received: from redhat.com ([2.53.22.137])
        by smtp.gmail.com with ESMTPSA id a2-20020a056000188200b0020aa2581c7fsm10015485wri.104.2022.04.25.06.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 06:59:59 -0700 (PDT)
Date:   Mon, 25 Apr 2022 09:59:55 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, sgarzare@redhat.com,
        eperezma@redhat.com, lulu@redhat.com, tglx@linutronix.de,
        peterz@infradead.org, paulmck@kernel.org, maz@kernel.org,
        pasic@linux.ibm.com
Subject: Re: [PATCH V3 6/9] virtio-ccw: implement synchronize_cbs()
Message-ID: <20220425095742-mutt-send-email-mst@kernel.org>
References: <20220425024418.8415-1-jasowang@redhat.com>
 <20220425024418.8415-7-jasowang@redhat.com>
 <20220425040512-mutt-send-email-mst@kernel.org>
 <87a6c98rwf.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a6c98rwf.fsf@redhat.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 10:54:24AM +0200, Cornelia Huck wrote:
> On Mon, Apr 25 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Mon, Apr 25, 2022 at 10:44:15AM +0800, Jason Wang wrote:
> >> This patch tries to implement the synchronize_cbs() for ccw. For the
> >> vring_interrupt() that is called via virtio_airq_handler(), the
> >> synchronization is simply done via the airq_info's lock. For the
> >> vring_interrupt() that is called via virtio_ccw_int_handler(), a per
> >> device spinlock for irq is introduced ans used in the synchronization
> >> method.
> >> 
> >> Cc: Thomas Gleixner <tglx@linutronix.de>
> >> Cc: Peter Zijlstra <peterz@infradead.org>
> >> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> >> Cc: Marc Zyngier <maz@kernel.org>
> >> Cc: Halil Pasic <pasic@linux.ibm.com>
> >> Cc: Cornelia Huck <cohuck@redhat.com>
> >> Signed-off-by: Jason Wang <jasowang@redhat.com>
> >
> >
> > This is the only one that is giving me pause. Halil, Cornelia,
> > should we be concerned about the performance impact here?
> > Any chance it can be tested?
> 
> We can have a bunch of devices using the same airq structure, and the
> sync cb creates a choke point, same as registering/unregistering.

BTW can callbacks for multiple VQs run on multiple CPUs at the moment?
this patch serializes them on a spinlock.

> If
> invoking the sync cb is a rare operation (same as (un)registering), it
> should not affect interrupt processing for other devices too much, but
> it really should be rare.
> 
> For testing, you would probably want to use a setup with many devices
> that share the same airq area (you can fit a lot of devices if they have
> few queues), generate traffic on the queues, and then do something that
> triggers the callback (adding/removing a new device in a loop?)
> 
> I currently don't have such a setup handy; Halil, would you be able to
> test that?
> 
> >
> >> ---
> >>  drivers/s390/virtio/virtio_ccw.c | 27 +++++++++++++++++++++++++++
> >>  1 file changed, 27 insertions(+)
> >> 
> >> diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> >> index d35e7a3f7067..c19f07a82d62 100644
> >> --- a/drivers/s390/virtio/virtio_ccw.c
> >> +++ b/drivers/s390/virtio/virtio_ccw.c
> >> @@ -62,6 +62,7 @@ struct virtio_ccw_device {
> >>  	unsigned int revision; /* Transport revision */
> >>  	wait_queue_head_t wait_q;
> >>  	spinlock_t lock;
> >> +	spinlock_t irq_lock;
> >>  	struct mutex io_lock; /* Serializes I/O requests */
> >>  	struct list_head virtqueues;
> >>  	bool is_thinint;
> >> @@ -984,6 +985,27 @@ static const char *virtio_ccw_bus_name(struct virtio_device *vdev)
> >>  	return dev_name(&vcdev->cdev->dev);
> >>  }
> >>  
> >> +static void virtio_ccw_synchronize_cbs(struct virtio_device *vdev)
> >> +{
> >> +	struct virtio_ccw_device *vcdev = to_vc_device(vdev);
> >> +	struct airq_info *info = vcdev->airq_info;
> >> +
> >> +	/*
> >> +	 * Synchronize with the vring_interrupt() called by
> >> +	 * virtio_ccw_int_handler().
> >> +	 */
> >> +	spin_lock(&vcdev->irq_lock);
> >> +	spin_unlock(&vcdev->irq_lock);
> >> +
> >> +	if (info) {
> >> +		/*
> >> +		 * Synchronize with the vring_interrupt() with airq indicator
> >> +		 */
> >> +		write_lock(&info->lock);
> >> +		write_unlock(&info->lock);
> >> +	}
> 
> I think we can make this an either/or operation (devices will either use
> classic interrupts or adapter interrupts)?
> 
> >> +}
> >> +
> >>  static const struct virtio_config_ops virtio_ccw_config_ops = {
> >>  	.get_features = virtio_ccw_get_features,
> >>  	.finalize_features = virtio_ccw_finalize_features,

