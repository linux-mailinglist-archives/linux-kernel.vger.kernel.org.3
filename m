Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1AAA50494C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 21:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234907AbiDQTWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 15:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbiDQTWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 15:22:43 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC0162D2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 12:20:07 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id x33so21486791lfu.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 12:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=UX+UJJi6cm6n3siakzXlqA7VdWeUuC0amPEI0CKnoy8=;
        b=anmuYIHMR44DHUBsKUVkyea2mPIgGJA1WVaLfL42XbsYHNLQ0QX5zF1vmXuveOfZa4
         TlIHgkTCOoYjOOVnzvPRkPqi+LYsmZYW7I9daLrolOUzGvJlP00NxPg1O42tKDiJdj3F
         W9UfoOoRhm9POPkypEpow7p+m6+WvsPwt0uKdYh6rfDXjumAupEnI2eqJ5bvdLrMXSrC
         Cydz5opZP1kh8wO33oIdvdQNglyjqHQLYMwCMFJqbSQLDJLtzHIrpnxoZKpVTXJ6x3oS
         ln3RXLd9fG/Z8R9g6sIQ9UgqXuc/KTif0O4MOzEsU4QUu9/7gdRIRnOzt0xx7Xe7vU1v
         3hVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=UX+UJJi6cm6n3siakzXlqA7VdWeUuC0amPEI0CKnoy8=;
        b=pGNA3JB767d77WW52sF7A4xhYsx4M8BqQNaF/ZVD3MaNTuWvz//11fGAmiCKw6fu9o
         4bgXcT/IileL2xmosB1ffIy9phFWZpbcTdEzSY0iRvPyI/3/nnjE+YtJ2CF4w6X82k74
         ff1epwBM8oQQLs24gq27ySWfX/tnoB8bdjy0mQKD76PDbSH3NOgN5WRsZr4vAv58zUMf
         mVJ29dMDZatgP/4AeW7rPgY1S7o1IMSxVeh+L92VPkF/mPt2ExAPMACWTmz8FMIhEBAn
         BTopJCJTzj4FtH/2V/JQeMPbcFDUEwUfEULDHwMy0fZAjvIx/v7XO5d41BpTSFeZHrPH
         FEXA==
X-Gm-Message-State: AOAM531OtGVmYKhsLsUZt+UolUiej3TnYXA41fg790nscM89A5iK+H0g
        9JuBzdqb+Mpgw2jjMrG/hJY=
X-Google-Smtp-Source: ABdhPJwipgGgKdPerX/TjaWsmOWeRcT7lQlBUqHmoX8ARPDdhaoRZak1gHU/2o+0U1HoS6YY+cJbTA==
X-Received: by 2002:a05:6512:c21:b0:471:9935:f8f2 with SMTP id z33-20020a0565120c2100b004719935f8f2mr35608lfu.650.1650223205568;
        Sun, 17 Apr 2022 12:20:05 -0700 (PDT)
Received: from [192.168.1.7] ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id f3-20020a056512322300b0046bbce218f2sm1005348lfe.79.2022.04.17.12.20.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Apr 2022 12:20:05 -0700 (PDT)
Subject: Re: [RFC PATCH 6/6] arm/xen: Assign xen-virtio DMA ops for virtio
 devices in Xen guests
To:     Stefano Stabellini <sstabellini@kernel.org>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, Julien Grall <julien@xen.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
References: <1649963973-22879-1-git-send-email-olekstysh@gmail.com>
 <1649963973-22879-7-git-send-email-olekstysh@gmail.com>
 <alpine.DEB.2.22.394.2204151305050.915916@ubuntu-linux-20-04-desktop>
From:   Oleksandr <olekstysh@gmail.com>
Message-ID: <8df1dc60-614a-67fa-3a9d-e2db4a7e0132@gmail.com>
Date:   Sun, 17 Apr 2022 22:20:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2204151305050.915916@ubuntu-linux-20-04-desktop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 16.04.22 01:02, Stefano Stabellini wrote:


Hello Stefano

> On Thu, 14 Apr 2022, Oleksandr Tyshchenko wrote:
>> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
>>
>> Call xen_virtio_setup_dma_ops() only for Xen-aware virtio devices
>> in Xen guests if restricted access to the guest memory is enabled.
>>
>> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
>> ---
>>   include/xen/arm/xen-ops.h | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/include/xen/arm/xen-ops.h b/include/xen/arm/xen-ops.h
>> index 621da05..28b2ad3 100644
>> --- a/include/xen/arm/xen-ops.h
>> +++ b/include/xen/arm/xen-ops.h
>> @@ -2,12 +2,19 @@
>>   #ifndef _ASM_ARM_XEN_OPS_H
>>   #define _ASM_ARM_XEN_OPS_H
>>   
>> +#include <linux/virtio_config.h>
>>   #include <xen/swiotlb-xen.h>
>> +#include <xen/xen-ops.h>
>>   
>>   static inline void xen_setup_dma_ops(struct device *dev)
>>   {
>>   	if (xen_swiotlb_detect())
>>   		dev->dma_ops = &xen_swiotlb_dma_ops;
>> +
>> +#ifdef CONFIG_XEN_VIRTIO
>> +	if (arch_has_restricted_virtio_memory_access() && xen_is_virtio_device(dev))
>> +		xen_virtio_setup_dma_ops(dev);
>> +#endif
> This makes sense overall.


thank you


> Considering that the swiotlb-xen case and the
> virtio case are mutually exclusive, I would write it like this:
>
> 	if (arch_has_restricted_virtio_memory_access() && xen_is_virtio_device(dev))
> 		xen_virtio_setup_dma_ops(dev);
> 	else if (xen_swiotlb_detect())
> 		dev->dma_ops = &xen_swiotlb_dma_ops;


Agree, will do


>
> There is no need for #ifdef (also see other comments).


Agree, if !CONFIG_XEN_VIRTIO then xen_virtio_ are just stubs.


#ifdef CONFIG_XEN_VIRTIO
void xen_virtio_setup_dma_ops(struct device *dev);
bool xen_is_virtio_device(struct device *dev);
#else
static inline void xen_virtio_setup_dma_ops(struct device *dev)
{
}
static inline bool xen_is_virtio_device(struct device *dev)
{
     return false;
}
#endif /* CONFIG_XEN_VIRTIO */



-- 
Regards,

Oleksandr Tyshchenko

