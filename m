Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3E650DBC1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 10:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235278AbiDYI6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 04:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239953AbiDYI5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 04:57:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0A6EECF5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 01:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650876869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q7eIeWS47Em435MDdVzeQsQsPcR5jLBoUJYfnOUHKBU=;
        b=MG8j2Sb12nlEsDzTA4mpbtN1NsWNpl+JDi5VbKajyf6yj2dl0gVKphWjg/iKDWKRmV7nwH
        SpkCUh1xo5aOhbpPWlZ1SvdpxUUNQyiY7iDo56C6LO8D+j2VlDSumtinp2QWC/Oe7ShQI0
        kG+YMXVpMgXCdae77xgjwo+lUXPdq/I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-625-OxcRZ2GINRaOhAtSpaFdkw-1; Mon, 25 Apr 2022 04:54:26 -0400
X-MC-Unique: OxcRZ2GINRaOhAtSpaFdkw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E7999811E7A;
        Mon, 25 Apr 2022 08:54:25 +0000 (UTC)
Received: from localhost (unknown [10.39.192.116])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9EAC51402427;
        Mon, 25 Apr 2022 08:54:25 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, sgarzare@redhat.com,
        eperezma@redhat.com, lulu@redhat.com, tglx@linutronix.de,
        peterz@infradead.org, paulmck@kernel.org, maz@kernel.org,
        pasic@linux.ibm.com
Subject: Re: [PATCH V3 6/9] virtio-ccw: implement synchronize_cbs()
In-Reply-To: <20220425040512-mutt-send-email-mst@kernel.org>
Organization: Red Hat GmbH
References: <20220425024418.8415-1-jasowang@redhat.com>
 <20220425024418.8415-7-jasowang@redhat.com>
 <20220425040512-mutt-send-email-mst@kernel.org>
User-Agent: Notmuch/0.34 (https://notmuchmail.org)
Date:   Mon, 25 Apr 2022 10:54:24 +0200
Message-ID: <87a6c98rwf.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Mon, Apr 25, 2022 at 10:44:15AM +0800, Jason Wang wrote:
>> This patch tries to implement the synchronize_cbs() for ccw. For the
>> vring_interrupt() that is called via virtio_airq_handler(), the
>> synchronization is simply done via the airq_info's lock. For the
>> vring_interrupt() that is called via virtio_ccw_int_handler(), a per
>> device spinlock for irq is introduced ans used in the synchronization
>> method.
>> 
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: "Paul E. McKenney" <paulmck@kernel.org>
>> Cc: Marc Zyngier <maz@kernel.org>
>> Cc: Halil Pasic <pasic@linux.ibm.com>
>> Cc: Cornelia Huck <cohuck@redhat.com>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>
>
> This is the only one that is giving me pause. Halil, Cornelia,
> should we be concerned about the performance impact here?
> Any chance it can be tested?

We can have a bunch of devices using the same airq structure, and the
sync cb creates a choke point, same as registering/unregistering. If
invoking the sync cb is a rare operation (same as (un)registering), it
should not affect interrupt processing for other devices too much, but
it really should be rare.

For testing, you would probably want to use a setup with many devices
that share the same airq area (you can fit a lot of devices if they have
few queues), generate traffic on the queues, and then do something that
triggers the callback (adding/removing a new device in a loop?)

I currently don't have such a setup handy; Halil, would you be able to
test that?

>
>> ---
>>  drivers/s390/virtio/virtio_ccw.c | 27 +++++++++++++++++++++++++++
>>  1 file changed, 27 insertions(+)
>> 
>> diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
>> index d35e7a3f7067..c19f07a82d62 100644
>> --- a/drivers/s390/virtio/virtio_ccw.c
>> +++ b/drivers/s390/virtio/virtio_ccw.c
>> @@ -62,6 +62,7 @@ struct virtio_ccw_device {
>>  	unsigned int revision; /* Transport revision */
>>  	wait_queue_head_t wait_q;
>>  	spinlock_t lock;
>> +	spinlock_t irq_lock;
>>  	struct mutex io_lock; /* Serializes I/O requests */
>>  	struct list_head virtqueues;
>>  	bool is_thinint;
>> @@ -984,6 +985,27 @@ static const char *virtio_ccw_bus_name(struct virtio_device *vdev)
>>  	return dev_name(&vcdev->cdev->dev);
>>  }
>>  
>> +static void virtio_ccw_synchronize_cbs(struct virtio_device *vdev)
>> +{
>> +	struct virtio_ccw_device *vcdev = to_vc_device(vdev);
>> +	struct airq_info *info = vcdev->airq_info;
>> +
>> +	/*
>> +	 * Synchronize with the vring_interrupt() called by
>> +	 * virtio_ccw_int_handler().
>> +	 */
>> +	spin_lock(&vcdev->irq_lock);
>> +	spin_unlock(&vcdev->irq_lock);
>> +
>> +	if (info) {
>> +		/*
>> +		 * Synchronize with the vring_interrupt() with airq indicator
>> +		 */
>> +		write_lock(&info->lock);
>> +		write_unlock(&info->lock);
>> +	}

I think we can make this an either/or operation (devices will either use
classic interrupts or adapter interrupts)?

>> +}
>> +
>>  static const struct virtio_config_ops virtio_ccw_config_ops = {
>>  	.get_features = virtio_ccw_get_features,
>>  	.finalize_features = virtio_ccw_finalize_features,

