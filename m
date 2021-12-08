Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C14946D4B6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 14:46:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbhLHNtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 08:49:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37353 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229799AbhLHNtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 08:49:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638971178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+uG3H1vipEMFCuV22E7rSIzNhPvbVMp9rjg6yhw3x7Y=;
        b=AAT6q9kw8qufbE+CtA42osXXnSyRGdR0KsmEjBYZGTeAIR7t2mNMPlmafQ70qb6/2Ogaoj
        0nmSr4nnZ6QVU3lYX9HyAPWwpDquqpjVBnFJ5L6AhX/yMbyWDbEwPKRsi3+VtAIXWzhUIR
        +ZrxIu45+yac1J+jbUCrKuR5DszV3nk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-266-z6s8FtLhOTGz7J7ryn223A-1; Wed, 08 Dec 2021 08:46:17 -0500
X-MC-Unique: z6s8FtLhOTGz7J7ryn223A-1
Received: by mail-wm1-f71.google.com with SMTP id j25-20020a05600c1c1900b00332372c252dso1436335wms.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 05:46:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=+uG3H1vipEMFCuV22E7rSIzNhPvbVMp9rjg6yhw3x7Y=;
        b=b6Z74ArDH1Dm2r4+3SBhL2JiYJBqfK6UMnGqY70fftxqwUuEsVGosKNeiLHB5faY16
         K6kx9WdXRyXT1rmsHFNua5O1vRhBLoeNJ5eDvK6VYVilN2pA/qC6GfI/qnEtGFn/+b7E
         G284bF8pMVL2WEvhYkzqjYmfLFq5H5gd+V0imBGD8jAeUuMtN2RA7YqwpI5++PHnkq94
         /DPdBwBSmPILyS2+NnPIJsCjVgVB4drLG8v+U99p8AO0pzgzvwCVHv9keFIA/ixxDAbh
         REfJHPkNAyhg7IoR4cGYwtlAzTf+HrQs8FfbaKmr6dNiKJ9EDnakHKFjlg0nJQqigrNz
         0Qyg==
X-Gm-Message-State: AOAM530zpCEimNW74b3Djl4PTEYD7BSwAYBE/ISxZ9g0oyf2hY6rLKrz
        aamykPsBTPvGpUS2xExwD6c32xawPjUcmAulBA4sAMHaQNhnJ4rQKERkyCtcA7GoEtilHkYzRRZ
        CnMOc/YFfWLL0xXhAymbF0Ypw
X-Received: by 2002:adf:f04d:: with SMTP id t13mr60666787wro.324.1638971176165;
        Wed, 08 Dec 2021 05:46:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw7ftkYHL7EFWBAFprRePUmZDegLdyZnDj6tuy+vYaF74RRmKsYgY3vQttx90Vg+a2mlq4HYA==
X-Received: by 2002:adf:f04d:: with SMTP id t13mr60666762wro.324.1638971175874;
        Wed, 08 Dec 2021 05:46:15 -0800 (PST)
Received: from [10.33.192.183] (nat-pool-str-t.redhat.com. [149.14.88.106])
        by smtp.gmail.com with ESMTPSA id h2sm2768795wrz.23.2021.12.08.05.46.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Dec 2021 05:46:15 -0800 (PST)
Message-ID: <0f1c6b3e-7e33-6fd1-11e7-f4857ec55105@redhat.com>
Date:   Wed, 8 Dec 2021 14:46:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Content-Language: en-US
To:     Harald Freudenberger <freude@linux.ibm.com>,
        linux-s390@vger.kernel.org, Tony Krowiak <akrowiak@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
References: <20211201141110.94636-1-thuth@redhat.com>
 <210e3c57-bdc2-09ed-3e41-8dab57e8f36c@linux.ibm.com>
 <319a5ce7-873b-b8b9-1fa8-f2a69b418ac4@redhat.com>
 <15a39981-37ca-ed2d-3baf-c4cb74f8c343@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Subject: Re: [RFC PATCH] s390: vfio-ap: Register the vfio_ap module for the
 "ap" parent bus
In-Reply-To: <15a39981-37ca-ed2d-3baf-c4cb74f8c343@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/12/2021 09.33, Harald Freudenberger wrote:
> On 02.12.21 08:13, Thomas Huth wrote:
>> On 01/12/2021 18.10, Harald Freudenberger wrote:
>>> On 01.12.21 15:11, Thomas Huth wrote:
>>>> The crypto devices that we can use with the vfio_ap module are sitting
>>>> on the "ap" bus, not on the "vfio_ap" bus that the module defines
>>>> itself. With this change, the vfio_ap module now gets automatically
>>>> loaded if a supported crypto adapter is available in the host.
>>>>
>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>> ---
>>>>    Note: Marked as "RFC" since I'm not 100% sure about it ...
>>>>          please review carefully!
>>>>
>>>>    drivers/s390/crypto/vfio_ap_drv.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
>>>> index 4d2556bc7fe5..5580e40608a4 100644
>>>> --- a/drivers/s390/crypto/vfio_ap_drv.c
>>>> +++ b/drivers/s390/crypto/vfio_ap_drv.c
>>>> @@ -39,7 +39,7 @@ static struct ap_device_id ap_queue_ids[] = {
>>>>        { /* end of sibling */ },
>>>>    };
>>>>    -MODULE_DEVICE_TABLE(vfio_ap, ap_queue_ids);
>>>> +MODULE_DEVICE_TABLE(ap, ap_queue_ids);
>>>>      /**
>>>>     * vfio_ap_queue_dev_probe:
>>> Hello Thomas, interesting.
>>> Did you test this ? I mean did you build a kernel and have it run on a s390 with crypto cards available ?
>>
>> Yes, I've tested it. Without the patch, the vfio_ap module does not get loaded automatically if a crypto card is available. With the patch applied, the vfio_ap module correctly gets loaded automatically on my system (similar to the vfio_ccw module).
>>
>>> My strong feeling is that this will make the AP bus code stumble as the code silently assumes there are exact
>>> two types of ap devices attached to the ap bus: ap cards and ap queues.
>>
>> This is only about getting the module loaded automatically once such a device is available ... AFAIK it does not grab any of the devices automatically, so there shouldn't be any problems?
>>
>>   Thomas
>>
> Yes, of course for the automatic module load works this way. But you understand that now
> the vfio devices are childs of the ap bus and thus are siblings of the ap queue and ap card
> devices. As I wrote the ap bus code is not prepared to deal with a 3th type of devices
> dangling on the ap bus. So you should test what happens when there are real vfio ap devices
> in use together with 'regular' ap card and queue devices.

I pondered about this for a while, but I still do not quite understand. The 
MODULE_DEVICE_TABLE macro only adds a __mod_something_device_table symbol to 
the module, it does not change the hierarchy of the vfio devices ... so this 
is really only about loading the module automatically. Or do you say that 
there is already a problem if a user loads the module manually and thus it 
should not get loaded automatically?

> However, I am still not sure if it is preferable to have the vfio ap module loaded automatically. The majority
> of customers will never use vfio ap devices - this is specific to kvm hosts only.
vfio-ccw also gets loaded automatically via MODULE_DEVICE_TABLE, so I think 
vfio-ap should be handled the same way.
(Or should we maybe rather remove the MODULE_DEVICE_TABLE line from both 
modules instead?)

  Thomas

