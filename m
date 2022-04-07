Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBCF14F7667
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 08:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241444AbiDGGk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 02:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241425AbiDGGkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 02:40:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4EC06BB92E
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 23:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649313524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jTfYg7LEaBj5/S/22hrPYrBqzaTarRrfht4+k3OtluQ=;
        b=O62Qcxg3MkTBlxVHZxzQV9M2tNn9gXx1/SjmR3w8bS9Ev3fGDiq3Rv9cwZIYomru0KdY0L
        /sfEAwMwQt7JSWLWTabKJEBAiO9aD/33NcOXGQcq3zHDCGZxlKmbJmiex7bVNF+Cj7E0yS
        ab6UFI/DT59qDoZR42/SEZI0nXcS3m8=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-584-p860NfOnNXiJXfEbslDNAQ-1; Thu, 07 Apr 2022 02:38:40 -0400
X-MC-Unique: p860NfOnNXiJXfEbslDNAQ-1
Received: by mail-pg1-f197.google.com with SMTP id h9-20020a631209000000b0039cc31b22aeso984115pgl.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 23:38:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jTfYg7LEaBj5/S/22hrPYrBqzaTarRrfht4+k3OtluQ=;
        b=toqg/ATF0Hw78KGvH6wNVMnfinKBU4FD7Syuvf+HL4fuVBPqKVIoe3IGlETgaQYYvK
         EBYrLDqpWswljwqk6mySVnY5lY0+Ata+MXmPJxNMx3xvMAKY69Z/PzVC/pJmSZ50zomh
         9sN/XqK6iywhUNL+Hj+hDPnFLVJbQqmr9HV0excWEQ4Xxp+K9VC3cPZVVMCMGi/pJYg4
         MqXesSFXKCFE68A+73e/ItJv2ZN412FeuR+I88suSTGyrJo8tIIXDDixLYlKzsB45TQm
         pgfw2CL9xjSmZlLGcJV5qX+JB5YSDYGm0lP0J2h3bXD7+l1Drc4HKcWw+PMYi1kUgUGY
         T50Q==
X-Gm-Message-State: AOAM531mnMqS4RKExQoSC2UFHFnhD5kav4nFlU2n7Lc+mnBdu+peXo/d
        IwACW4onmMRujeqt/I98NjsOdLnp593qN+XqRxAzJWTVLTL3pOQsmWB/6j4PvgbPxdc2RV0X3/U
        De5r6Y70OCBT4B1RDh12Se0Z8
X-Received: by 2002:a63:9711:0:b0:398:5cf2:20bc with SMTP id n17-20020a639711000000b003985cf220bcmr10087297pge.480.1649313519911;
        Wed, 06 Apr 2022 23:38:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyybYdCM1oR5OU+iW4g0AIFWnE/HZaYWWpa91mlmNGr0JeNBLBQ2wKoCRb9OSR1VOXXK+2DZQ==
X-Received: by 2002:a63:9711:0:b0:398:5cf2:20bc with SMTP id n17-20020a639711000000b003985cf220bcmr10087277pge.480.1649313519510;
        Wed, 06 Apr 2022 23:38:39 -0700 (PDT)
Received: from [10.72.13.105] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id p34-20020a056a000a2200b004cd49fc15e5sm22753099pfh.59.2022.04.06.23.38.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 23:38:39 -0700 (PDT)
Message-ID: <7e99abbf-f68d-4aa5-71b6-9d1d71b2d25b@redhat.com>
Date:   Thu, 7 Apr 2022 14:38:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH V2 4/5] virtio-pci: implement synchronize_vqs()
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, peterz@infradead.org,
        maz@kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, tglx@linutronix.de,
        Halil Pasic <pasic@linux.ibm.com>
References: <20220406083538.16274-1-jasowang@redhat.com>
 <20220406083538.16274-5-jasowang@redhat.com>
 <20220406075952-mutt-send-email-mst@kernel.org> <87wng2e527.fsf@redhat.com>
 <20220406112858-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220406112858-mutt-send-email-mst@kernel.org>
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


在 2022/4/6 下午11:31, Michael S. Tsirkin 写道:
> On Wed, Apr 06, 2022 at 03:04:32PM +0200, Cornelia Huck wrote:
>> On Wed, Apr 06 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>>
>>> On Wed, Apr 06, 2022 at 04:35:37PM +0800, Jason Wang wrote:
>>>> This patch implements PCI version of synchronize_vqs().
>>>>
>>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>>> Cc: "Paul E. McKenney" <paulmck@kernel.org>
>>>> Cc: Marc Zyngier <maz@kernel.org>
>>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>>> Please add implementations at least for ccw and mmio.
>> I'm not sure what (if anything) can/should be done for ccw...
>>
>>>> ---
>>>>   drivers/virtio/virtio_pci_common.c | 14 ++++++++++++++
>>>>   drivers/virtio/virtio_pci_common.h |  2 ++
>>>>   drivers/virtio/virtio_pci_legacy.c |  1 +
>>>>   drivers/virtio/virtio_pci_modern.c |  2 ++
>>>>   4 files changed, 19 insertions(+)
>>>>
>>>> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
>>>> index d724f676608b..b78c8bc93a97 100644
>>>> --- a/drivers/virtio/virtio_pci_common.c
>>>> +++ b/drivers/virtio/virtio_pci_common.c
>>>> @@ -37,6 +37,20 @@ void vp_synchronize_vectors(struct virtio_device *vdev)
>>>>   		synchronize_irq(pci_irq_vector(vp_dev->pci_dev, i));
>>>>   }
>>>>   
>>>> +void vp_synchronize_vqs(struct virtio_device *vdev)
>>>> +{
>>>> +	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>>>> +	int i;
>>>> +
>>>> +	if (vp_dev->intx_enabled) {
>>>> +		synchronize_irq(vp_dev->pci_dev->irq);
>>>> +		return;
>>>> +	}
>>>> +
>>>> +	for (i = 0; i < vp_dev->msix_vectors; ++i)
>>>> +		synchronize_irq(pci_irq_vector(vp_dev->pci_dev, i));
>>>> +}
>>>> +
>> ...given that this seems to synchronize threaded interrupt handlers?
> No, any handlers at all. The point is to make sure any memory changes
> made prior to this op are visible to callbacks.
>
> Jason, maybe add that to the documentation?


Sure.


>
>> Halil, do you think ccw needs to do anything? (AFAICS, we only have one
>> 'irq' for channel devices anyway, and the handler just calls the
>> relevant callbacks directly.)
> Then you need to synchronize with that.


Have a quick glance at the codes, it looks to me we can synchronize with 
the IO_INTERRUPT. (Assuming all callbacks are triggered via 
ccw_device_irq()).

Thanks


>
>>>>   /* the notify function used when creating a virt queue */
>>>>   bool vp_notify(struct virtqueue *vq)
>>>>   {

