Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D85164E6CBE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 04:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355952AbiCYDF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 23:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354366AbiCYDFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 23:05:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7BF42381A9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 20:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648177457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=voC+CecCW1anKRAUfc/O/ORcM2yqR9AcoKYTefROhcE=;
        b=OajAUJ8h1IDky/JCZcuaFpWScnwQZEEW6WrMBoDEzxvxLlRxdSaem591DbzTZBNAB09qdp
        lFPI/xCLUUnIjHjo3V4pJPSd/VaIYmkQQqZhEW3JXKlJ8d0wXYC3c8ZeEy0yzq67yVPSo7
        77le4rXKPBnJpaBXRDxp38oCB4xuDtI=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-352-WtCF0FrANMe1YbfXpdeQqQ-1; Thu, 24 Mar 2022 23:04:15 -0400
X-MC-Unique: WtCF0FrANMe1YbfXpdeQqQ-1
Received: by mail-pl1-f200.google.com with SMTP id u8-20020a170903124800b0015195a5826cso3499011plh.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 20:04:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=voC+CecCW1anKRAUfc/O/ORcM2yqR9AcoKYTefROhcE=;
        b=gBi7D3VuqQSDlb4xAg5J+Q+US1yhyvAemSjtliemOwriERiUzMratckrBYyb5PQioL
         T6sy177xqfa9A6TF3YZOU2OCzkjgUC/3LDpN7SpnmDlWmTKbrB9KGsXAKLd5tRbyqBpg
         /44auKDwWnPudwUqnC2yBESpbgC9uIBUxAGVxW6RXAiMN0+TUN+cz4lWXYm8KOl4QXDe
         9sYddgbkB2krZsoY8dr6xwhe25JJWYkqnFiFQ8DRnLG5ahoxGHJqE8bCajJPS5XIj3vK
         54ComSXQAaM0jXO5NxoSq8/g9w0kB4zyVNvVWwRfKGLfib0DGyvVrqCk12kJAlnbVIKm
         PBLg==
X-Gm-Message-State: AOAM531XEQZgHMECmJYZnIyL/xt9fx8F+F3LAJ08AbSh6lsGYGBvdax5
        7eFuCU6W51DpHYVmZ8i35QzB5dtWN+Y3E5Mmo9zmsSdBb4S/eDGR1gDm0kx3k0udfj1xcTCSFvK
        FqT7mro3Dj+H69Oh8AzqRhGQS
X-Received: by 2002:a17:90b:3889:b0:1c6:408b:6b0f with SMTP id mu9-20020a17090b388900b001c6408b6b0fmr9990230pjb.43.1648177454495;
        Thu, 24 Mar 2022 20:04:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwFx3WcIeuaQXTVCvFymtyj1BKnoAAMxv8dD0sHclg3dnO/dKXf9OYdN+lecYfp6b7JEyEV1Q==
X-Received: by 2002:a17:90b:3889:b0:1c6:408b:6b0f with SMTP id mu9-20020a17090b388900b001c6408b6b0fmr9990205pjb.43.1648177454090;
        Thu, 24 Mar 2022 20:04:14 -0700 (PDT)
Received: from [10.72.13.249] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id w61-20020a17090a6bc300b001c7ca8a1467sm2401352pjj.46.2022.03.24.20.04.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Mar 2022 20:04:13 -0700 (PDT)
Message-ID: <f7046303-7d7d-e39f-3c71-3688126cc812@redhat.com>
Date:   Fri, 25 Mar 2022 11:04:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH 3/3] virtio: harden vring IRQ
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, maz@kernel.org, tglx@linutronix.de,
        peterz@infradead.org, sgarzare@redhat.com, keirf@google.com
References: <20220324084004.14349-1-jasowang@redhat.com>
 <20220324084004.14349-4-jasowang@redhat.com>
 <20220324064849-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220324064849-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/3/24 下午7:03, Michael S. Tsirkin 写道:
> On Thu, Mar 24, 2022 at 04:40:04PM +0800, Jason Wang wrote:
>> This is a rework on the previous IRQ hardening that is done for
>> virtio-pci where several drawbacks were found and were reverted:
>>
>> 1) try to use IRQF_NO_AUTOEN which is not friendly to affinity managed IRQ
>>     that is used by some device such as virtio-blk
>> 2) done only for PCI transport
>>
>> In this patch, we tries to borrow the idea from the INTX IRQ hardening
>> in the reverted commit 080cd7c3ac87 ("virtio-pci: harden INTX interrupts")
>> by introducing a global irq_soft_enabled variable for each
>> virtio_device. Then we can to toggle it during
>> virtio_reset_device()/virtio_device_ready(). A synchornize_rcu() is
>> used in virtio_reset_device() to synchronize with the IRQ handlers. In
>> the future, we may provide config_ops for the transport that doesn't
>> use IRQ. With this, vring_interrupt() can return check and early if
>> irq_soft_enabled is false. This lead to smp_load_acquire() to be used
>> but the cost should be acceptable.
> Maybe it should be but is it? Can't we use synchronize_irq instead?


Even if we allow the transport driver to synchornize through 
synchronize_irq() we still need a check in the vring_interrupt().

We do something like the following previously:

         if (!READ_ONCE(vp_dev->intx_soft_enabled))
                 return IRQ_NONE;

But it looks like a bug since speculative read can be done before the 
check where the interrupt handler can't see the uncommitted setup which 
is done by the driver.


>
>> To avoid breaking legacy device which can send IRQ before DRIVER_OK, a
>> module parameter is introduced to enable the hardening so function
>> hardening is disabled by default.
> Which devices are these? How come they send an interrupt before there
> are any buffers in any queues?


I copied this from the commit log for 22b7050a024d7

"

     This change will also benefit old hypervisors (before 2009)
     that send interrupts without checking DRIVER_OK: previously,
     the callback could race with driver-specific initialization.
"

If this is only for config interrupt, I can remove the above log.


>
>> Note that the hardening is only done for vring interrupt since the
>> config interrupt hardening is already done in commit 22b7050a024d7
>> ("virtio: defer config changed notifications"). But the method that is
>> used by config interrupt can't be reused by the vring interrupt
>> handler because it uses spinlock to do the synchronization which is
>> expensive.
>>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>
>> ---
>>   drivers/virtio/virtio.c       | 19 +++++++++++++++++++
>>   drivers/virtio/virtio_ring.c  |  9 ++++++++-
>>   include/linux/virtio.h        |  4 ++++
>>   include/linux/virtio_config.h | 25 +++++++++++++++++++++++++
>>   4 files changed, 56 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
>> index 8dde44ea044a..85e331efa9cc 100644
>> --- a/drivers/virtio/virtio.c
>> +++ b/drivers/virtio/virtio.c
>> @@ -7,6 +7,12 @@
>>   #include <linux/of.h>
>>   #include <uapi/linux/virtio_ids.h>
>>   
>> +static bool irq_hardening = false;
>> +
>> +module_param(irq_hardening, bool, 0444);
>> +MODULE_PARM_DESC(irq_hardening,
>> +		 "Disalbe IRQ software processing when it is not expected");
>> +
>>   /* Unique numbering for virtio devices. */
>>   static DEFINE_IDA(virtio_index_ida);
>>   
>> @@ -220,6 +226,15 @@ static int virtio_features_ok(struct virtio_device *dev)
>>    * */
>>   void virtio_reset_device(struct virtio_device *dev)
>>   {
>> +	/*
>> +	 * The below synchronize_rcu() guarantees that any
>> +	 * interrupt for this line arriving after
>> +	 * synchronize_rcu() has completed is guaranteed to see
>> +	 * irq_soft_enabled == false.
> News to me I did not know synchronize_rcu has anything to do
> with interrupts. Did not you intend to use synchronize_irq?
> I am not even 100% sure synchronize_rcu is by design a memory barrier
> though it's most likely is ...


According to the comment above tree RCU version of synchronize_rcu():

"""

  * RCU read-side critical sections are delimited by rcu_read_lock()
  * and rcu_read_unlock(), and may be nested.  In addition, but only in
  * v5.0 and later, regions of code across which interrupts, preemption,
  * or softirqs have been disabled also serve as RCU read-side critical
  * sections.  This includes hardware interrupt handlers, softirq handlers,
  * and NMI handlers.
"""

So interrupt handlers are treated as read-side critical sections.

And it has the comment for explain the barrier:

"""

  * Note that this guarantee implies further memory-ordering guarantees.
  * On systems with more than one CPU, when synchronize_rcu() returns,
  * each CPU is guaranteed to have executed a full memory barrier since
  * the end of its last RCU read-side critical section whose beginning
  * preceded the call to synchronize_rcu().  In addition, each CPU having
"""

So on SMP it provides a full barrier. And for UP/tiny RCU we don't need 
the barrier, if the interrupt come after WRITE_ONCE() it will see the 
irq_soft_enabled as false.


>
>> +	 */
>> +	WRITE_ONCE(dev->irq_soft_enabled, false);
>> +	synchronize_rcu();
>> +
>>   	dev->config->reset(dev);
>>   }
>>   EXPORT_SYMBOL_GPL(virtio_reset_device);
> Please add comment explaining where it will be enabled.
> Also, we *really* don't need to synch if it was already disabled,
> let's not add useless overhead to the boot sequence.


Ok.


>
>
>> @@ -427,6 +442,10 @@ int register_virtio_device(struct virtio_device *dev)
>>   	spin_lock_init(&dev->config_lock);
>>   	dev->config_enabled = false;
>>   	dev->config_change_pending = false;
>> +	dev->irq_soft_check = irq_hardening;
>> +
>> +	if (dev->irq_soft_check)
>> +		dev_info(&dev->dev, "IRQ hardening is enabled\n");
>>   
>>   	/* We always start by resetting the device, in case a previous
>>   	 * driver messed it up.  This also tests that code path a little. */
> one of the points of hardening is it's also helpful for buggy
> devices. this flag defeats the purpose.


Do you mean:

1) we need something like config_enable? This seems not easy to be 
implemented without obvious overhead, mainly the synchronize with the 
interrupt handlers

2) enable this by default, so I don't object, but this may have some 
risk for old hypervisors


>
>> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
>> index 962f1477b1fa..0170f8c784d8 100644
>> --- a/drivers/virtio/virtio_ring.c
>> +++ b/drivers/virtio/virtio_ring.c
>> @@ -2144,10 +2144,17 @@ static inline bool more_used(const struct vring_virtqueue *vq)
>>   	return vq->packed_ring ? more_used_packed(vq) : more_used_split(vq);
>>   }
>>   
>> -irqreturn_t vring_interrupt(int irq, void *_vq)
>> +irqreturn_t vring_interrupt(int irq, void *v)
>>   {
>> +	struct virtqueue *_vq = v;
>> +	struct virtio_device *vdev = _vq->vdev;
>>   	struct vring_virtqueue *vq = to_vvq(_vq);
>>   
>> +	if (!virtio_irq_soft_enabled(vdev)) {
>> +		dev_warn_once(&vdev->dev, "virtio vring IRQ raised before DRIVER_OK");
>> +		return IRQ_NONE;
>> +	}
>> +
>>   	if (!more_used(vq)) {
>>   		pr_debug("virtqueue interrupt with no work for %p\n", vq);
>>   		return IRQ_NONE;
>> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
>> index 5464f398912a..957d6ad604ac 100644
>> --- a/include/linux/virtio.h
>> +++ b/include/linux/virtio.h
>> @@ -95,6 +95,8 @@ dma_addr_t virtqueue_get_used_addr(struct virtqueue *vq);
>>    * @failed: saved value for VIRTIO_CONFIG_S_FAILED bit (for restore)
>>    * @config_enabled: configuration change reporting enabled
>>    * @config_change_pending: configuration change reported while disabled
>> + * @irq_soft_check: whether or not to check @irq_soft_enabled
>> + * @irq_soft_enabled: callbacks enabled
>>    * @config_lock: protects configuration change reporting
>>    * @dev: underlying device.
>>    * @id: the device type identification (used to match it with a driver).
>> @@ -109,6 +111,8 @@ struct virtio_device {
>>   	bool failed;
>>   	bool config_enabled;
>>   	bool config_change_pending;
>> +	bool irq_soft_check;
>> +	bool irq_soft_enabled;
>>   	spinlock_t config_lock;
>>   	spinlock_t vqs_list_lock; /* Protects VQs list access */
>>   	struct device dev;
>> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
>> index dafdc7f48c01..9c1b61f2e525 100644
>> --- a/include/linux/virtio_config.h
>> +++ b/include/linux/virtio_config.h
>> @@ -174,6 +174,24 @@ static inline bool virtio_has_feature(const struct virtio_device *vdev,
>>   	return __virtio_test_bit(vdev, fbit);
>>   }
>>   
>> +/*
>> + * virtio_irq_soft_enabled: whether we can execute callbacks
>> + * @vdev: the device
>> + */
>> +static inline bool virtio_irq_soft_enabled(const struct virtio_device *vdev)
>> +{
>> +	if (!vdev->irq_soft_check)
>> +		return true;
>> +
>> +	/*
>> +	 * Read irq_soft_enabled before reading other device specific
>> +	 * data. Paried with smp_store_relase() in
> paired


Will fix.

Thanks


>
>> +	 * virtio_device_ready() and WRITE_ONCE()/synchronize_rcu() in
>> +	 * virtio_reset_device().
>> +	 */
>> +	return smp_load_acquire(&vdev->irq_soft_enabled);
>> +}
>> +
>>   /**
>>    * virtio_has_dma_quirk - determine whether this device has the DMA quirk
>>    * @vdev: the device
>> @@ -236,6 +254,13 @@ void virtio_device_ready(struct virtio_device *dev)
>>   	if (dev->config->enable_cbs)
>>                     dev->config->enable_cbs(dev);
>>   
>> +	/*
>> +	 * Commit the driver setup before enabling the virtqueue
>> +	 * callbacks. Paried with smp_load_acuqire() in
>> +	 * virtio_irq_soft_enabled()
>> +	 */
>> +	smp_store_release(&dev->irq_soft_enabled, true);
>> +
>>   	BUG_ON(status & VIRTIO_CONFIG_S_DRIVER_OK);
>>   	dev->config->set_status(dev, status | VIRTIO_CONFIG_S_DRIVER_OK);
>>   }
>> -- 
>> 2.25.1

