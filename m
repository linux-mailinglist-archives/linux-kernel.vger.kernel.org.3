Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E594350EF5D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 05:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241798AbiDZDsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 23:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbiDZDsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 23:48:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C67203D1EA
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 20:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650944731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bQxkTt0XC9Rg9r5oloxnV9oPwCXKhivpkktVubMKxA4=;
        b=P537jH/6lKEQ92szaNQ+PVqluCapmaEVg9tRuFV2uwUJyxxJW8wKtXYIVj3iCdSfyf71aY
        D1IxQgAs44hOTcGh257c0een9DOXgrX2r4UwIoeXJwA8umhJvlnXgdlmzKuDn9QNxXKoho
        xisbVnaiQYnbViZvsXhiK0SetxzwVmI=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-671-2ByxXOXzNgqBIZH-5r0OVw-1; Mon, 25 Apr 2022 23:45:22 -0400
X-MC-Unique: 2ByxXOXzNgqBIZH-5r0OVw-1
Received: by mail-pg1-f198.google.com with SMTP id x2-20020a63aa42000000b003aafe948eeeso4376248pgo.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 20:45:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bQxkTt0XC9Rg9r5oloxnV9oPwCXKhivpkktVubMKxA4=;
        b=b0tJUqoLJNibSe8IdncjWYrXrEWQ0gbVWktpYfpR7KXy577adE2B4HTzpp/XvcB1O0
         Rduy9azpmp1XH+bD8UIXjJPUGSwSeKmPxMdgxJtB14BKnSOlx3Z1gUXCRh18gl80n3au
         UYwgofH5QNNqxZ9X160gQKbgQNH5SRBoemvcfd3buuaqdmqcpE0XalbgJ0R7R3WLWf9i
         bgPVJpEpFTgqBdmNqmjngWYePAmigLZ8sqTkTMcUe9QIRG3k4HR3a9QDkCVLaklvZfWY
         lwoHqVMOwq3KXL4FdsaT/ViwbmuAPJBD5H9ZDsLWWKOf9qyOCMHEbothofaK7ZRxQzED
         uwAQ==
X-Gm-Message-State: AOAM53109/1o56rPfp7Mv3SfcMqPUTDEUGZ6GUOML6kh6apTFCEgLBnf
        Hod+mBgNVDLof3vvFaYKOMwazadzPCTC6CP8rECptHITS2T6XJVx8jLcUZrP0mJbdlcgWXPAYUP
        CxyRT5sFbk6msVTuyJPpG/jdb
X-Received: by 2002:a05:6a00:2481:b0:50d:4839:5896 with SMTP id c1-20020a056a00248100b0050d48395896mr5375169pfv.37.1650944721343;
        Mon, 25 Apr 2022 20:45:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy+SJgwm09mTi+hWwYYLh/5RwsE1fpUGq4/MRnbAN9YFANBqojxJvgBPIHGh+BdrsxOJapPgA==
X-Received: by 2002:a05:6a00:2481:b0:50d:4839:5896 with SMTP id c1-20020a056a00248100b0050d48395896mr5375158pfv.37.1650944721072;
        Mon, 25 Apr 2022 20:45:21 -0700 (PDT)
Received: from [10.72.13.91] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id i62-20020a62c141000000b0050d48b96bb8sm3162809pfg.22.2022.04.25.20.45.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 20:45:20 -0700 (PDT)
Message-ID: <560bcbe5-f0db-ed61-8ec0-043031145fe4@redhat.com>
Date:   Tue, 26 Apr 2022 11:45:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH V3 7/9] virtio: allow to unbreak virtqueue
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, sgarzare@redhat.com,
        eperezma@redhat.com, lulu@redhat.com, tglx@linutronix.de,
        peterz@infradead.org, paulmck@kernel.org, maz@kernel.org,
        pasic@linux.ibm.com
References: <20220425024418.8415-1-jasowang@redhat.com>
 <20220425024418.8415-8-jasowang@redhat.com> <87v8ux72p5.fsf@redhat.com>
 <20220425100349-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220425100349-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/4/25 22:04, Michael S. Tsirkin 写道:
> On Mon, Apr 25, 2022 at 02:44:06PM +0200, Cornelia Huck wrote:
>> On Mon, Apr 25 2022, Jason Wang <jasowang@redhat.com> wrote:
>>
>>> This patch allows the virtio_break_device() to accept a boolean value
>>> then we can unbreak the virtqueue.
>>>
>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>>> ---
>>>   drivers/char/virtio_console.c              | 2 +-
>>>   drivers/crypto/virtio/virtio_crypto_core.c | 2 +-
>>>   drivers/s390/virtio/virtio_ccw.c           | 4 ++--
>>>   drivers/virtio/virtio_pci_common.c         | 2 +-
>>>   drivers/virtio/virtio_ring.c               | 4 ++--
>>>   include/linux/virtio.h                     | 2 +-
>>>   6 files changed, 8 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
>>> index e3c430539a17..afede977f7b3 100644
>>> --- a/drivers/char/virtio_console.c
>>> +++ b/drivers/char/virtio_console.c
>>> @@ -1958,7 +1958,7 @@ static void virtcons_remove(struct virtio_device *vdev)
>>>   	spin_unlock_irq(&pdrvdata_lock);
>>>   
>>>   	/* Device is going away, exit any polling for buffers */
>>> -	virtio_break_device(vdev);
>>> +	virtio_break_device(vdev, true);
>>>   	if (use_multiport(portdev))
>>>   		flush_work(&portdev->control_work);
>>>   	else
>>> diff --git a/drivers/crypto/virtio/virtio_crypto_core.c b/drivers/crypto/virtio/virtio_crypto_core.c
>>> index c6f482db0bc0..fd17f3f2e958 100644
>>> --- a/drivers/crypto/virtio/virtio_crypto_core.c
>>> +++ b/drivers/crypto/virtio/virtio_crypto_core.c
>>> @@ -215,7 +215,7 @@ static int virtcrypto_update_status(struct virtio_crypto *vcrypto)
>>>   		dev_warn(&vcrypto->vdev->dev,
>>>   				"Unknown status bits: 0x%x\n", status);
>>>   
>>> -		virtio_break_device(vcrypto->vdev);
>>> +		virtio_break_device(vcrypto->vdev, true);
>>>   		return -EPERM;
>>>   	}
>>>   
>>> diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
>>> index c19f07a82d62..9a963f5af5b5 100644
>>> --- a/drivers/s390/virtio/virtio_ccw.c
>>> +++ b/drivers/s390/virtio/virtio_ccw.c
>>> @@ -1211,7 +1211,7 @@ static void virtio_ccw_remove(struct ccw_device *cdev)
>>>   
>>>   	if (vcdev && cdev->online) {
>>>   		if (vcdev->device_lost)
>>> -			virtio_break_device(&vcdev->vdev);
>>> +			virtio_break_device(&vcdev->vdev, true);
>>>   		unregister_virtio_device(&vcdev->vdev);
>>>   		spin_lock_irqsave(get_ccwdev_lock(cdev), flags);
>>>   		dev_set_drvdata(&cdev->dev, NULL);
>>> @@ -1228,7 +1228,7 @@ static int virtio_ccw_offline(struct ccw_device *cdev)
>>>   	if (!vcdev)
>>>   		return 0;
>>>   	if (vcdev->device_lost)
>>> -		virtio_break_device(&vcdev->vdev);
>>> +		virtio_break_device(&vcdev->vdev, true);
>>>   	unregister_virtio_device(&vcdev->vdev);
>>>   	spin_lock_irqsave(get_ccwdev_lock(cdev), flags);
>>>   	dev_set_drvdata(&cdev->dev, NULL);
>>> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
>>> index d724f676608b..39a711ddff30 100644
>>> --- a/drivers/virtio/virtio_pci_common.c
>>> +++ b/drivers/virtio/virtio_pci_common.c
>>> @@ -583,7 +583,7 @@ static void virtio_pci_remove(struct pci_dev *pci_dev)
>>>   	 * layers can abort any ongoing operation.
>>>   	 */
>>>   	if (!pci_device_is_present(pci_dev))
>>> -		virtio_break_device(&vp_dev->vdev);
>>> +		virtio_break_device(&vp_dev->vdev, true);
>>>   
>>>   	pci_disable_sriov(pci_dev);
>>>   
>>> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
>>> index cfb028ca238e..6da13495a70c 100644
>>> --- a/drivers/virtio/virtio_ring.c
>>> +++ b/drivers/virtio/virtio_ring.c
>>> @@ -2382,7 +2382,7 @@ EXPORT_SYMBOL_GPL(virtqueue_is_broken);
>>>    * This should prevent the device from being used, allowing drivers to
>>>    * recover.  You may need to grab appropriate locks to flush.
>>>    */
>>> -void virtio_break_device(struct virtio_device *dev)
>>> +void virtio_break_device(struct virtio_device *dev, bool broken)
>> I think we need to be careful to say when it is safe to unset 'broken'.
>>
>> The current callers set all queues to broken in case of surprise removal
>> (ccw, pci), removal (console), or the device behaving badly
>> (crypto). There's also code setting individual queues to broken. We do
>> not want to undo any of these, unless the device has gone through a
>> reset in the meanwhile. Maybe add:
>>
>> "It is only safe to call this function to *remove* the broken flag for a
>> device that is (re)transitioning to becoming usable; calling it that way
>> during normal usage may have unpredictable consequences."
>>
>> (Not sure how to word this; especially if we consider future usage of
>> queue reset.)
>
> Right. I would prefer __virtio_unbreak_device or something similar


Ok, so I think then we don't want it to be exported.


> with a bit comment explaining it's only safe to call during probe.


Will do.

Thanks


>

