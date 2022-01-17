Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2F7C4903E6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 09:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbiAQIcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 03:32:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:37681 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238214AbiAQIcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 03:32:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642408321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vaBNs95WDlXx8iGl0AyfpROH/j47Hay2zVSLmFsrGtg=;
        b=Mq8yNpeEq2DZTB2XDE10++mLPAMFwqc9tz8XhoL9Xse00bZfhLMxOCIeGKniUI8XyLMEvJ
        zTpr0HNxa0bOL8C5ATCwzUuUn0b4MroZnc4RaAG+jxRBjnwVjepScfVuTfGij2ZhTzHZjM
        NQ89IhJtqnDW05DdGGg5OirnwssqP60=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-495-hMf16PxePYCDn8kyu880Dw-1; Mon, 17 Jan 2022 03:31:59 -0500
X-MC-Unique: hMf16PxePYCDn8kyu880Dw-1
Received: by mail-ed1-f70.google.com with SMTP id cf15-20020a0564020b8f00b0040284b671c6so2407509edb.22
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 00:31:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=vaBNs95WDlXx8iGl0AyfpROH/j47Hay2zVSLmFsrGtg=;
        b=ffjWhgrcaKqhEMxv0ZnXASmmjpIGIMHtoZQzlg3GhD2KUMtma2/lwqrPrv8HVi2fK0
         I4qJ2tglgcY2MjYDANKgGA0jI7WoVMPkVsO4ZNvoEpfCmRghpHI+Pc9xnC20jZg737qh
         QdIHpbv54lvRrU8GrlC9OYly/Go2Bh47RwnVfI7TeN7xejjnGHKgIFk5e7g2Ezx7xs0l
         jVPbb0ixv3Oag+T11K8E+FKb5yLRXSjOQKyiJkKjIvpQKA1LRoEPHkQw48PG/mop+uzn
         rDI1v/yr9PV3ZTDA4vsUlc/ujBpQgULdT14MUiM6CfBpkvQCQSLSsOyR32Ou4DO5mmUM
         yHwQ==
X-Gm-Message-State: AOAM530fY13fI+MlXLYpz3uxb2Q7QfMZglidrnEgpbWu75Su15e4LuDZ
        ZwTMo8i6SPI12KcegBMQ7LKh2ag9HVin/oYsHkq2idt2a6y0QblyzPOLCuN5v+so1cgX5Som/e4
        R/K/BuehSMAafn9CUilJf9Nr0
X-Received: by 2002:aa7:c609:: with SMTP id h9mr20143855edq.248.1642408318293;
        Mon, 17 Jan 2022 00:31:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzgZa/KW4xGU199wi9i9/KP8wY0G54upJDfddwLxn3V0PbEj2XKQGZhKuv6oRoWoO1Yxc7NKg==
X-Received: by 2002:aa7:c609:: with SMTP id h9mr20143839edq.248.1642408318111;
        Mon, 17 Jan 2022 00:31:58 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:dd00:68a1:1bd:6733:bde9? (p200300cbc705dd0068a101bd6733bde9.dip0.t-ipconnect.de. [2003:cb:c705:dd00:68a1:1bd:6733:bde9])
        by smtp.gmail.com with ESMTPSA id b19sm2463073edr.40.2022.01.17.00.31.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jan 2022 00:31:57 -0800 (PST)
Message-ID: <7ec8218e-9d76-a9b7-ccd0-b7c8ce257fe2@redhat.com>
Date:   Mon, 17 Jan 2022 09:31:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
References: <20220114214324.239444-1-mst@redhat.com>
 <1f703ebf-0f78-e530-0fe1-163613397cad@redhat.com>
 <20220117025341-mutt-send-email-mst@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] virtio_mem: break device on remove
In-Reply-To: <20220117025341-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.01.22 08:55, Michael S. Tsirkin wrote:
> On Mon, Jan 17, 2022 at 02:40:11PM +0800, Jason Wang wrote:
>>
>> 在 2022/1/15 上午5:43, Michael S. Tsirkin 写道:
>>> A common pattern for device reset is currently:
>>> vdev->config->reset(vdev);
>>> .. cleanup ..
>>>
>>> reset prevents new interrupts from arriving and waits for interrupt
>>> handlers to finish.
>>>
>>> However if - as is common - the handler queues a work request which is
>>> flushed during the cleanup stage, we have code adding buffers / trying
>>> to get buffers while device is reset. Not good.
>>>
>>> This was reproduced by running
>>> 	modprobe virtio_console
>>> 	modprobe -r virtio_console
>>> in a loop, and this reasoning seems to apply to virtio mem though
>>> I could not reproduce it there.
>>>
>>> Fix this up by calling virtio_break_device + flush before reset.
>>>
>>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>> ---
>>>   drivers/virtio/virtio_mem.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
>>> index 38becd8d578c..33b8a118a3ae 100644
>>> --- a/drivers/virtio/virtio_mem.c
>>> +++ b/drivers/virtio/virtio_mem.c
>>> @@ -2888,6 +2888,8 @@ static void virtio_mem_remove(struct virtio_device *vdev)
>>>   		virtio_mem_deinit_hotplug(vm);
>>>   	/* reset the device and cleanup the queues */
>>> +	virtio_break_device(vdev);
>>> +	flush_work(&vm->wq);
>>
>>
>> We set vm->removing to true and call cancel_work_sync() in
>> virtio_mem_deinit_hotplug(). Isn't is sufficient?
>>
>> Thanks
> 
> 
> Hmm I think you are right. David, I will drop this for now.
> Up to you to consider whether some central capability will be
> helpful as a replacement for the virtio-mem specific "removing" flag.

It's all a bit tricky because we also have to handle pending timers and
pending memory onlining/offlining operations in a controlled way. Maybe
we could convert to virtio_break_device() and use the
&dev->vqs_list_lock as a replacement for the removal_lock. However, I'm
not 100% sure if it's nice to use that lock from
drivers/virtio/virtio_mem.c directly.
-- 
Thanks,

David / dhildenb

