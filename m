Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2691C4F75F2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 08:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241057AbiDGG1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 02:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241045AbiDGG1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 02:27:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9C6A623140
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 23:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649312751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BLlHrE4/3Q5dXoiIyxRCC0oUmaF9F+xq6LvaySDB8mM=;
        b=CbRgjWtzmMFEodKY241pi2fUvf6ueaZYQMUabYe8mP8Ln7zovRemtbxfj6IYe7Wqr2Ttit
        q/Q79Aq+xiQiU2P186yHkGCsQhESraYzq/Wt6OzEjClIUHn3B7+mZp9SQfso9pEIncvaO3
        4ViTWSGf3W6tSkXdEQEA/B9StV5f7iA=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-502-Op709g23Nx6MDNr4u66UYw-1; Thu, 07 Apr 2022 02:25:50 -0400
X-MC-Unique: Op709g23Nx6MDNr4u66UYw-1
Received: by mail-pg1-f197.google.com with SMTP id p4-20020a631e44000000b00399598a48c5so2670116pgm.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 23:25:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BLlHrE4/3Q5dXoiIyxRCC0oUmaF9F+xq6LvaySDB8mM=;
        b=IjKCu5YnGMaSh0TFzWPsvKUV/BzbpIYxV5VuaZteUtlKty15WWFcmAZRBlz9S8lfpN
         n3lFwv9rrbbBEWSP6cnv8SigV1lKNd5hFe9TbvrqUIHA2KHwfc4SfJXlIccdCypPBEuY
         da6Cs1AkvuXQ0lWIGiJoWaesFDOCEmsBxkVXaNh8GTa3s7qcZIIA9+fZz5IW3ZQUm8xI
         +QdOssbvskzPA6xrClZGlWkCBnjxPc8oEsyQjhvf5zG8+XdbuNOXxdVloqdZrq2WpDxc
         T9hpnJYJzJQoGR5C6DcRcStPv68rclWZuEc79rNNnLLTijSYCJdRd8TqvfYpmSkM9udd
         uJ3g==
X-Gm-Message-State: AOAM532Zv9rBVObe3quaFP/Fz9AReaI4Vr4NAZ/xroUJXEGlFdKs3nYr
        OuDgoms9NhxyXbVRmnPlV3zB5koUF9tVYELiYrUj7+lyJalETXVY7yXS8q9/VhnaJpyDWJnRMPh
        4L7K9CH+lZjWB1c0UpvRTbDoX
X-Received: by 2002:a63:150c:0:b0:39c:c255:27c1 with SMTP id v12-20020a63150c000000b0039cc25527c1mr2456712pgl.293.1649312749688;
        Wed, 06 Apr 2022 23:25:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw7Urc0kd92WlKyjtKSL1EBQ8HS2giXe/92fnhicU5/VPPQiUq4Uydc1QmX44+8VB5bkRQFGQ==
X-Received: by 2002:a63:150c:0:b0:39c:c255:27c1 with SMTP id v12-20020a63150c000000b0039cc25527c1mr2456702pgl.293.1649312749437;
        Wed, 06 Apr 2022 23:25:49 -0700 (PDT)
Received: from [10.72.13.105] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id j22-20020a637a56000000b003984be1f515sm17860519pgn.69.2022.04.06.23.25.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 23:25:48 -0700 (PDT)
Message-ID: <53831b99-6c63-7ca9-9b95-bc3f8c5e015c@redhat.com>
Date:   Thu, 7 Apr 2022 14:25:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH V2 3/5] virtio: introduce config op to synchronize vring
 callbacks
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, maz@kernel.org, tglx@linutronix.de,
        peterz@infradead.org, sgarzare@redhat.com,
        "Paul E. McKenney" <paulmck@kernel.org>
References: <20220406083538.16274-1-jasowang@redhat.com>
 <20220406083538.16274-4-jasowang@redhat.com>
 <20220406075405-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220406075405-mutt-send-email-mst@kernel.org>
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


在 2022/4/6 下午7:59, Michael S. Tsirkin 写道:
> On Wed, Apr 06, 2022 at 04:35:36PM +0800, Jason Wang wrote:
>> This patch introduce
> introduces
>
>> a new
> new
>
>> virtio config ops to vring
>> callbacks. Transport specific method is required to call
>> synchornize_irq() on the IRQs. For the transport that doesn't provide
>> synchronize_vqs(), use synchornize_rcu() as a fallback.
>>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: "Paul E. McKenney" <paulmck@kernel.org>
>> Cc: Marc Zyngier <maz@kernel.org>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>> ---
>>   include/linux/virtio_config.h | 16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>>
>> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
>> index b341dd62aa4d..08b73d9bbff2 100644
>> --- a/include/linux/virtio_config.h
>> +++ b/include/linux/virtio_config.h
>> @@ -57,6 +57,8 @@ struct virtio_shm_region {
>>    *		include a NULL entry for vqs unused by driver
>>    *	Returns 0 on success or error status
>>    * @del_vqs: free virtqueues found by find_vqs().
>> + * @synchronize_vqs: synchronize with the virtqueue callbacks.
>> + *	vdev: the virtio_device
> I think I prefer synchronize_callbacks


Ok, I will rename it.


>
>>    * @get_features: get the array of feature bits for this device.
>>    *	vdev: the virtio_device
>>    *	Returns the first 64 feature bits (all we currently need).
>> @@ -89,6 +91,7 @@ struct virtio_config_ops {
>>   			const char * const names[], const bool *ctx,
>>   			struct irq_affinity *desc);
>>   	void (*del_vqs)(struct virtio_device *);
>> +	void (*synchronize_vqs)(struct virtio_device *);
>>   	u64 (*get_features)(struct virtio_device *vdev);
>>   	int (*finalize_features)(struct virtio_device *vdev);
>>   	const char *(*bus_name)(struct virtio_device *vdev);
>> @@ -217,6 +220,19 @@ int virtio_find_vqs_ctx(struct virtio_device *vdev, unsigned nvqs,
>>   				      desc);
>>   }
>>   
>> +/**
>> + * virtio_synchronize_vqs - synchronize with virtqueue callbacks
>> + * @vdev: the device
>> + */
>> +static inline
>> +void virtio_synchronize_vqs(struct virtio_device *dev)
>> +{
>> +	if (dev->config->synchronize_vqs)
>> +		dev->config->synchronize_vqs(dev);
>> +	else
>> +		synchronize_rcu();
> I am not sure about this fallback and the latency impact.


Unless each transport can implement their own synchronization routine, 
we need something that can do best effort as fallback here.


> Maybe synchronize_rcu_expedited is better here.


Not sure, it might lead IPIs and according to the 
Documentation/RCU/checklist.rst:


"""

         The expedited forms of these primitives have the same semantics
         as the non-expedited forms, but expediting is both expensive and
         (with the exception of synchronize_srcu_expedited()) unfriendly
         to real-time workloads.  Use of the expedited primitives should
         be restricted to rare configuration-change operations that would
         not normally be undertaken while a real-time workload is running.
         However, real-time workloads can use rcupdate.rcu_normal kernel
         boot parameter to completely disable expedited grace periods,
         though this might have performance implications.

"""

It will be expensive for real time workloads.

Thanks


>
>> +}
>> +
>>   /**
>>    * virtio_device_ready - enable vq use in probe function
>>    * @vdev: the device
>> -- 
>> 2.25.1

