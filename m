Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4A649DF82
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 11:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239528AbiA0KeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 05:34:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:22440 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237623AbiA0KeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 05:34:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643279641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tHJnjwaX7+NIVJtJcj9tiGjlPglWEq6X8f8Sk2sXdug=;
        b=CioHEHLUW00oUiNvDNsJ4GrUK+2Z0773YKULMdVB+tI6+mKemqkuHp3NgxVkwf5PpSWeD4
        zF6SbPkv/tx+nz19xNFpmUVIxVB13OloatdT9sRFZZgwNWxRfTBLhNHvTY66G0vsQcqw1c
        4hMQlj+6gq77z/3IDPumZs9CQ5zS4PQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-281-TK_vWyExMKKnxtgwTUbo3w-1; Thu, 27 Jan 2022 05:33:58 -0500
X-MC-Unique: TK_vWyExMKKnxtgwTUbo3w-1
Received: by mail-wm1-f70.google.com with SMTP id f188-20020a1c1fc5000000b0034d79edde84so506848wmf.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 02:33:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tHJnjwaX7+NIVJtJcj9tiGjlPglWEq6X8f8Sk2sXdug=;
        b=NC7vkgOFFwdXTgOmVk+eNXelVDXKrs8GRYB/5jQsTtmHO6eMpuyEBDkp+jGxWRLuWP
         CM2kGlN1C/8zx/3S4lpRKpw/gxBoLR815TzfZ/BAgx9VkYPmxxLhN9EBYErnUMy22EdX
         1b9bl6SqfMuUH5GaylwXkwzJIpJXvsacZNLA0yRstcqswlpxt+IGS9rrYMspbpOYvAJL
         Ef0bR4DyxoDxkMbFyKrUrtLp/6YDSf0uy8O1XFPKBdyLmP/sO/cV7H7V2yDWD/NyVXx4
         iNBJIK/D/4WwLmlkvibwwZCrAX3XqUuas+o+aqe7WVy46tt6/O6yYzZO8bMT2VyCwSmZ
         x6Rw==
X-Gm-Message-State: AOAM5336y+FgQLu/5WOCWjQAXvxrGsl9ymhLX+7CkcMEX14+H5t6L92M
        dZT5ZGiww+aEjN8wx4OzQudaguVlsaI70qYJghKYFnTxBAMhTaAKo/NnHX9+melPoCrZZtF5ED2
        whrSPNJGXIGvKcEHjxiln+b8y
X-Received: by 2002:a5d:64ad:: with SMTP id m13mr2504469wrp.671.1643279636923;
        Thu, 27 Jan 2022 02:33:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw5IvihLfiDx/ynbIWg0oAQh+cwAQ+GhXf+waYye0ZXXq5LJn2ADpZKOO2KHn67cE0qkK6KJw==
X-Received: by 2002:a5d:64ad:: with SMTP id m13mr2504453wrp.671.1643279636714;
        Thu, 27 Jan 2022 02:33:56 -0800 (PST)
Received: from [10.33.192.183] (nat-pool-str-t.redhat.com. [149.14.88.106])
        by smtp.gmail.com with ESMTPSA id b2sm2080880wri.88.2022.01.27.02.33.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 02:33:56 -0800 (PST)
Message-ID: <345cc07e-e654-2607-57ff-95e78dbfe12d@redhat.com>
Date:   Thu, 27 Jan 2022 11:33:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH] s390: vfio-ap: Register the vfio_ap module for the
 "ap" parent bus
Content-Language: en-US
To:     Tony Krowiak <akrowiak@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        linux-s390@vger.kernel.org, Halil Pasic <pasic@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20211201141110.94636-1-thuth@redhat.com>
 <8512bb0a-a34a-09b0-65f3-781f3d092364@linux.ibm.com>
 <e0558344-54a0-eebb-44e0-af61575a4769@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <e0558344-54a0-eebb-44e0-af61575a4769@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/12/2021 22.28, Tony Krowiak wrote:
> 
> 
> On 12/13/21 10:44, Harald Freudenberger wrote:
>> On 01.12.21 15:11, Thomas Huth wrote:
>>> The crypto devices that we can use with the vfio_ap module are sitting
>>> on the "ap" bus, not on the "vfio_ap" bus that the module defines
>>> itself. With this change, the vfio_ap module now gets automatically
>>> loaded if a supported crypto adapter is available in the host.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>   Note: Marked as "RFC" since I'm not 100% sure about it ...
>>>         please review carefully!
>>>
>>>   drivers/s390/crypto/vfio_ap_drv.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/s390/crypto/vfio_ap_drv.c 
>>> b/drivers/s390/crypto/vfio_ap_drv.c
>>> index 4d2556bc7fe5..5580e40608a4 100644
>>> --- a/drivers/s390/crypto/vfio_ap_drv.c
>>> +++ b/drivers/s390/crypto/vfio_ap_drv.c
>>> @@ -39,7 +39,7 @@ static struct ap_device_id ap_queue_ids[] = {
>>>       { /* end of sibling */ },
>>>   };
>>> -MODULE_DEVICE_TABLE(vfio_ap, ap_queue_ids);
>>> +MODULE_DEVICE_TABLE(ap, ap_queue_ids);
>>>   /**
>>>    * vfio_ap_queue_dev_probe:
>> I had a chance to check this now.
>> First I have to apologize about the dispute with vfio devices appearing on 
>> the ap bus.
>> That's not the case with this patch. As Connie states the 
>> MODULE_DEVICE_TABLE() does not
>> change the parent of a device and vfio_ap_drv is a driver for ap devices 
>> and thus
>> belongs to the ap bus anyway.
>> So what's left is that with this change the vfio_ap kernel module is 
>> automatically loaded
>> when an ap device type 10-13 is recognized by the ap bus. So the intention 
>> of the patch
>> is fulfilled.
>> Yet another kernel module which may occupy memory but will never get used 
>> by most customers.
>> This may not be a problem but I had a glance at the list of kernel modules 
>> loaded on my
>> LPAR with and without the patch and the difference is:
>> ...
>> kvm                   512000  1 vfio_ap
>> vfio_ap                28672  0
>> ...
>> So the vfio_ap module has a dependency to the biggest kernel module ever - 
>> kvm.
>> Do I need to say something more?
>>
>> If this dependency is removed then I would not hesitate to accept this 
>> patch. However
>> this is up to Tony as he is the maintainer of the vfio ap device driver.
> 
> The vfio_ap device driver has a dependency on kvm, it can not be removed.
> If the user base for vfio_ap is minimal, then I see no reason why the vfio_ap
> module should be automatically loaded when an AP device type 10-13 is
> recognized by the AP bus. The module is needed only to pass through AP
> queue devices to a KVM guest.

To continue the discussion here - it seems like my patch here won't be 
accepted? Shall I send another one instead to remove the bad 
MODLE_DEVICE_TABLE from the vfio_ap_drv.c file?

  Thomas

