Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF674F7675
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 08:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234984AbiDGGmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 02:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240018AbiDGGmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 02:42:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7A597E9C9B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 23:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649313594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OG5GNjyBBg6GuhhD2ccdgmToZso90lqtSFSgk9L3dxA=;
        b=UivYftNdhH9gVxp+cphLJzpeRKxy9t9un7tUJhO1eSMtViLPp4j/F+giVE5ah0ccgnVWtw
        a0becfLwb+3X+InqbS2y/fDI1a7PTg1J3QMOE5psN+R8QXRbKfWkwkQdqMb6GGfZts355E
        1kYco4pU+D1MdsIwdMfxdeeAe36BdOY=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-422-dcJFSUq-Pv2-mUhlWI5uHw-1; Thu, 07 Apr 2022 02:39:51 -0400
X-MC-Unique: dcJFSUq-Pv2-mUhlWI5uHw-1
Received: by mail-pg1-f200.google.com with SMTP id d1-20020a631d41000000b0039cbc6d6499so1398336pgm.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 23:39:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OG5GNjyBBg6GuhhD2ccdgmToZso90lqtSFSgk9L3dxA=;
        b=MiAmPSnflLi0LNsMnE/KUaih/h6vyzzkBdzIKx8xAgZBJZ6vPEc5vjgiySNb2adUth
         fOntXNXj4hKhi4jh7wfqwpHuj1JqK3eSPbPplRCUNcBk7LAl1bPbGrI1k1BnMXLIiMos
         3acR1YFwJaYx7tjEmDs5AqDkJhs0wymrHX3+S5coss5qj5lTpxz6egG7tKxXTlTyqupO
         bJQuQ70545sDR7rPaX62UZAIJ/iyPUM1Jp4bjQHlopXTlJnz5AwpzeugiEnCjuAvkzah
         htR5NCsuuJn8VmDt04osNUo9tokfwBxTtsXqgoadvC7XLSe5FOB5IfNgw2wPFGHB1uU/
         31ug==
X-Gm-Message-State: AOAM530IwfXLXIUIe2hYLlinRYkZ18XLHafltB7X803A9nnyLByCfptP
        9jvjdYDlzwyb3mxm0fhs3/ynMNnDomX8JmCyi1rtAwi1FYGHW5QxJ1F0v1XdKC+TN5lZTnfdBvY
        MO3qknG9SDH/eOPg4lb4nUII+
X-Received: by 2002:a17:90b:1bc2:b0:1c9:9cd1:a4fe with SMTP id oa2-20020a17090b1bc200b001c99cd1a4femr14137780pjb.136.1649313590168;
        Wed, 06 Apr 2022 23:39:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZZmLkK2KTu+6hYyXHJCHf5jxdVnoM5DfGypuoK3qjvhEKnIVHWTGSZ5+lZz0DskhFVkG9gw==
X-Received: by 2002:a17:90b:1bc2:b0:1c9:9cd1:a4fe with SMTP id oa2-20020a17090b1bc200b001c99cd1a4femr14137760pjb.136.1649313589934;
        Wed, 06 Apr 2022 23:39:49 -0700 (PDT)
Received: from [10.72.13.105] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id y16-20020a637d10000000b00381268f2c6fsm18145927pgc.4.2022.04.06.23.39.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 23:39:49 -0700 (PDT)
Message-ID: <726caf4c-3dde-8a47-e665-6b2b963304b6@redhat.com>
Date:   Thu, 7 Apr 2022 14:39:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH V2 5/5] virtio: harden vring IRQ
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, maz@kernel.org, tglx@linutronix.de,
        peterz@infradead.org, sgarzare@redhat.com,
        "Paul E. McKenney" <paulmck@kernel.org>
References: <20220406083538.16274-1-jasowang@redhat.com>
 <20220406083538.16274-6-jasowang@redhat.com>
 <20220406080135-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220406080135-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/4/6 下午8:04, Michael S. Tsirkin 写道:
> On Wed, Apr 06, 2022 at 04:35:38PM +0800, Jason Wang wrote:
>> This is a rework on the previous IRQ hardening that is done for
>> virtio-pci where several drawbacks were found and were reverted:
>>
>> 1) try to use IRQF_NO_AUTOEN which is not friendly to affinity managed IRQ
>>     that is used by some device such as virtio-blk
>> 2) done only for PCI transport
>>
>> In this patch, we tries to borrow the idea from the INTX IRQ hardening
>> in the reverted commit 080cd7c3ac87 ("virtio-pci: harden INTX interrupts")
>> by introducing a global device_ready variable for each
>> virtio_device. Then we can to toggle it during
>> virtio_reset_device()/virtio_device_ready(). A
>> virtio_synchornize_vqs() is used in both virtio_device_ready() and
>> virtio_reset_device() to synchronize with the vring callbacks. With
>> this, vring_interrupt() can return check and early if driver_ready is
>> false.
>>
>> Note that the hardening is only done for vring interrupt since the
>> config interrupt hardening is already done in commit 22b7050a024d7
>> ("virtio: defer config changed notifications"). But the method that is
>> used by config interrupt can't be reused by the vring interrupt
>> handler because it uses spinlock to do the synchronization which is
>> expensive.
>>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: "Paul E. McKenney" <paulmck@kernel.org>
>> Cc: Marc Zyngier <maz@kernel.org>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>> ---
>>   drivers/virtio/virtio.c       | 11 +++++++++++
>>   drivers/virtio/virtio_ring.c  |  9 ++++++++-
>>   include/linux/virtio.h        |  2 ++
>>   include/linux/virtio_config.h |  8 ++++++++
>>   4 files changed, 29 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
>> index 8dde44ea044a..2f3a6f8e3d9c 100644
>> --- a/drivers/virtio/virtio.c
>> +++ b/drivers/virtio/virtio.c
>> @@ -220,6 +220,17 @@ static int virtio_features_ok(struct virtio_device *dev)
>>    * */
>>   void virtio_reset_device(struct virtio_device *dev)
>>   {
>> +	if (READ_ONCE(dev->driver_ready)) {
>> +		/*
>> +		 * The below virtio_synchronize_vqs() guarantees that any
>> +		 * interrupt for this line arriving after
>> +		 * virtio_synchronize_vqs() has completed is guaranteed to see
>> +		 * driver_ready == false.
>> +		 */
>> +		WRITE_ONCE(dev->driver_ready, false);
>> +		virtio_synchronize_vqs(dev);
>> +	}
>> +
>>   	dev->config->reset(dev);
>>   }
>>   EXPORT_SYMBOL_GPL(virtio_reset_device);
>> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
>> index cfb028ca238e..a4592e55c9f8 100644
>> --- a/drivers/virtio/virtio_ring.c
>> +++ b/drivers/virtio/virtio_ring.c
>> @@ -2127,10 +2127,17 @@ static inline bool more_used(const struct vring_virtqueue *vq)
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
>> +	if (!READ_ONCE(vdev->driver_ready)) {
>
> I am not sure why we need READ_ONCE here, it's done under lock.


I may miss something but which lock did you mean here? (Note the irq 
handler doesn't hold the irq descriptor lock).

Thanks


>
>
> Accrdingly, same thing above for READ_ONCE and WRITE_ONCE.
>
>
>> +		dev_warn_once(&vdev->dev, "virtio vring IRQ raised before DRIVER_OK");
>> +		return IRQ_NONE;
>> +	}
>> +
>>   	if (!more_used(vq)) {
>>   		pr_debug("virtqueue interrupt with no work for %p\n", vq);
>>   		return IRQ_NONE;
>> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
>> index 5464f398912a..dfa2638a293e 100644
>> --- a/include/linux/virtio.h
>> +++ b/include/linux/virtio.h
>> @@ -95,6 +95,7 @@ dma_addr_t virtqueue_get_used_addr(struct virtqueue *vq);
>>    * @failed: saved value for VIRTIO_CONFIG_S_FAILED bit (for restore)
>>    * @config_enabled: configuration change reporting enabled
>>    * @config_change_pending: configuration change reported while disabled
>> + * @driver_ready: whehter the driver is ready (e.g for vring callbacks)
>>    * @config_lock: protects configuration change reporting
>>    * @dev: underlying device.
>>    * @id: the device type identification (used to match it with a driver).
>> @@ -109,6 +110,7 @@ struct virtio_device {
>>   	bool failed;
>>   	bool config_enabled;
>>   	bool config_change_pending;
>> +	bool driver_ready;
>>   	spinlock_t config_lock;
>>   	spinlock_t vqs_list_lock; /* Protects VQs list access */
>>   	struct device dev;
>> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
>> index 08b73d9bbff2..c9e207bf2c9c 100644
>> --- a/include/linux/virtio_config.h
>> +++ b/include/linux/virtio_config.h
>> @@ -246,6 +246,14 @@ void virtio_device_ready(struct virtio_device *dev)
>>   {
>>   	unsigned status = dev->config->get_status(dev);
>>   
>> +	virtio_synchronize_vqs(dev);
>> +        /*
>> +         * The above virtio_synchronize_vqs() make sure
>
> makes sure
>
>> +         * vring_interrupt() will see the driver specific setup if it
>> +         * see driver_ready as true.
> sees
>
>> +         */
>> +	WRITE_ONCE(dev->driver_ready, true);
>> +
>>   	BUG_ON(status & VIRTIO_CONFIG_S_DRIVER_OK);
>>   	dev->config->set_status(dev, status | VIRTIO_CONFIG_S_DRIVER_OK);
>>   }
>> -- 
>> 2.25.1

