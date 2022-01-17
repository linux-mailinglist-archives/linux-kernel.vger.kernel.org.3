Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC004905DC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 11:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238541AbiAQKZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 05:25:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34557 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235846AbiAQKZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 05:25:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642415117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bRTOEGKQdU6bW9SvqAbl8ZaW57LsRIIgasIMjL77UE4=;
        b=KUUZwaShI1v4FSQcR+lRNa9onRLG0knDd8Vz2EFoN+yui4bCLlnX/23M7eNowfHpuy/zD5
        +1wsRkZgEfShfL95p0DQJ/7I05wEV+4f9NNgCk2N/EwCBFRWO5JRIoUZPTcGCEC4TPp55G
        +QjTk2ctTOMdRAoU1vN6QejwitOamGM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-486-AaFuSVsqPjilY9zdH6brgA-1; Mon, 17 Jan 2022 05:25:15 -0500
X-MC-Unique: AaFuSVsqPjilY9zdH6brgA-1
Received: by mail-wm1-f71.google.com with SMTP id 14-20020a05600c024e00b0034a83f7391aso9434021wmj.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 02:25:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=bRTOEGKQdU6bW9SvqAbl8ZaW57LsRIIgasIMjL77UE4=;
        b=BguL5rYvs4hbB3bzULSSXBkm4oHovCSVcOiFTP7W5TeZdx3quDiCH8PDZ61kBjHaD3
         /PBDSbSlE4xF8cW3mrA7Gnx7GTe/m8lR9k4Y2tDsoDnFcRqXpGRPJmFuyrXTnTbYQX9f
         KQDA4tmIz6PPR/6Y9dqDDfxAId1pV6+CPHgpcNItPFUjecISSeDZVovurT8qFeH2CYNN
         pcrgAN8+PKrQgs5efmTqA8YrD6DeKnZeZdksRlfTz2fFcvjB9i6eKP4cRwCBC5XsMJGB
         BjjzQRl5/nSGZ9cHQQrLNHPqlzQ11xitUqQSBYvqjXy4YxI2fqFsTymkLWaVvrhmmG9t
         1Njw==
X-Gm-Message-State: AOAM533xZNrsX5ntU88Ks8wQXZvDLgbSc9jVEguRGnyFYM5EN7+nF1dR
        ZgHsyZmhpk2ak7ck2BfY/gD+wLvr6TXvgyfloeth/kZX1k4qfQ8Xy/DpiOwIvBbaYyQTHF0WsoW
        VSB9jSPCc/XNqeXo645FBz/p5
X-Received: by 2002:a5d:4e4c:: with SMTP id r12mr18488125wrt.666.1642415114326;
        Mon, 17 Jan 2022 02:25:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyPl7bnqFISpEF/IIt3W1vtdnK3spv2RFZfeF9T3ymO2IE/CL/KSw+I3yjrleUpAezP6l+kbQ==
X-Received: by 2002:a5d:4e4c:: with SMTP id r12mr18488107wrt.666.1642415114112;
        Mon, 17 Jan 2022 02:25:14 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:dd00:68a1:1bd:6733:bde9? (p200300cbc705dd0068a101bd6733bde9.dip0.t-ipconnect.de. [2003:cb:c705:dd00:68a1:1bd:6733:bde9])
        by smtp.gmail.com with ESMTPSA id p15sm11141294wrw.93.2022.01.17.02.25.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jan 2022 02:25:13 -0800 (PST)
Message-ID: <44f4ee97-562c-ce37-a5af-9f58e052f3a9@redhat.com>
Date:   Mon, 17 Jan 2022 11:25:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] virtio_mem: break device on remove
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
References: <20220114214324.239444-1-mst@redhat.com>
 <1f703ebf-0f78-e530-0fe1-163613397cad@redhat.com>
 <20220117025341-mutt-send-email-mst@kernel.org>
 <7ec8218e-9d76-a9b7-ccd0-b7c8ce257fe2@redhat.com>
 <20220117033644-mutt-send-email-mst@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220117033644-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.01.22 09:40, Michael S. Tsirkin wrote:
> On Mon, Jan 17, 2022 at 09:31:56AM +0100, David Hildenbrand wrote:
>> On 17.01.22 08:55, Michael S. Tsirkin wrote:
>>> On Mon, Jan 17, 2022 at 02:40:11PM +0800, Jason Wang wrote:
>>>>
>>>> 在 2022/1/15 上午5:43, Michael S. Tsirkin 写道:
>>>>> A common pattern for device reset is currently:
>>>>> vdev->config->reset(vdev);
>>>>> .. cleanup ..
>>>>>
>>>>> reset prevents new interrupts from arriving and waits for interrupt
>>>>> handlers to finish.
>>>>>
>>>>> However if - as is common - the handler queues a work request which is
>>>>> flushed during the cleanup stage, we have code adding buffers / trying
>>>>> to get buffers while device is reset. Not good.
>>>>>
>>>>> This was reproduced by running
>>>>> 	modprobe virtio_console
>>>>> 	modprobe -r virtio_console
>>>>> in a loop, and this reasoning seems to apply to virtio mem though
>>>>> I could not reproduce it there.
>>>>>
>>>>> Fix this up by calling virtio_break_device + flush before reset.
>>>>>
>>>>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>>>> ---
>>>>>   drivers/virtio/virtio_mem.c | 2 ++
>>>>>   1 file changed, 2 insertions(+)
>>>>>
>>>>> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
>>>>> index 38becd8d578c..33b8a118a3ae 100644
>>>>> --- a/drivers/virtio/virtio_mem.c
>>>>> +++ b/drivers/virtio/virtio_mem.c
>>>>> @@ -2888,6 +2888,8 @@ static void virtio_mem_remove(struct virtio_device *vdev)
>>>>>   		virtio_mem_deinit_hotplug(vm);
>>>>>   	/* reset the device and cleanup the queues */
>>>>> +	virtio_break_device(vdev);
>>>>> +	flush_work(&vm->wq);
>>>>
>>>>
>>>> We set vm->removing to true and call cancel_work_sync() in
>>>> virtio_mem_deinit_hotplug(). Isn't is sufficient?
>>>>
>>>> Thanks
>>>
>>>
>>> Hmm I think you are right. David, I will drop this for now.
>>> Up to you to consider whether some central capability will be
>>> helpful as a replacement for the virtio-mem specific "removing" flag.
>>
>> It's all a bit tricky because we also have to handle pending timers and
>> pending memory onlining/offlining operations in a controlled way. Maybe
>> we could convert to virtio_break_device() and use the
>> &dev->vqs_list_lock as a replacement for the removal_lock. However, I'm
>> not 100% sure if it's nice to use that lock from
>> drivers/virtio/virtio_mem.c directly.
> 
> We could add an API if you like. Or maybe it makes sense to add a
> separate one that lets you find out that removal started. Need to figure
> out how to handle suspend too then ...
> Generally we have these checks that device is not going away
> sprinkled over all drivers and I don't like it, but
> it's not easy to build a sane API to handle it, especially
> for high speed things when we can't take locks because performance.

The interesting case might be how to handle virtio_mem_retry(), whereby
we conditionally queue work if !removing.

Having that said, in an ideal world we could deny removal requests for
virtio_mem completely if there is still any memory added to the system ...


-- 
Thanks,

David / dhildenb

