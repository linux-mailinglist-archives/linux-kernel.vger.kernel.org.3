Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 178F74F75D8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 08:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240982AbiDGGVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 02:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236654AbiDGGVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 02:21:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EC86E4C42F
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 23:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649312348;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TSoQ5rtvOHp3Q8UdZ46y3auvh3IsXFHtX0lRwfM7Hh0=;
        b=AdW5jKWSyHVueE8MHBdBL5cEFKdgbYIKUmWZL7UFWIjoYUXarmgeBz0TghHUEoLpiihoC2
        /JorNQgq9fD7N8DxnAcBaay/5Y4Mw3PDdcXC/4jbNw08qaiUPy5IsMeE32nJWdZLUFqA05
        lTyCM7gautL5BmrEpx2rFfbdSb7RY9g=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-554-AsLJcbsaMc-JfaW1qLfvVw-1; Thu, 07 Apr 2022 02:19:07 -0400
X-MC-Unique: AsLJcbsaMc-JfaW1qLfvVw-1
Received: by mail-pl1-f198.google.com with SMTP id f10-20020a170902ce8a00b00156a6b150e4so2308505plg.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 23:19:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TSoQ5rtvOHp3Q8UdZ46y3auvh3IsXFHtX0lRwfM7Hh0=;
        b=B76/Swox4ZP09HafNqfvhoCuMkqMo0juaC9MnxJ0HBcy3Uj0HSDuQ0uCXlGzhvZAZT
         zY73E3IiYt1//u+aiPEUWAYWMagwTrLsGcPm2G9NUKn1INkNCi2rTywvRm1O360YowD7
         ulhEEQZbqtG5QavgRdp+YOuYA3fDVC3WbkeFNWe99/hpZoGah0uvQmhbHO6U+SaDDzKb
         ZlBxsU8mLrki+WkOPxMoGQcbVC3Ad5igRUUr3On9NqIix2EXgnfAH9vdjQ+0SQfbnd9H
         yq7nsMqWCaU/B4OVuc1FIc0lMUeipCmTP5PocPgLZJ25V6M73VFHQGKXKn5pE1/xCQRA
         m1IA==
X-Gm-Message-State: AOAM532dnfGTEepAe3sMcy70iU56dUQBDrfv+Vhrz/VJkUD+8R8aAObY
        zwwMO5UOrzDshaZKH/sFD7Z/dcGAKzhhX5M4R3zQgCwzs/w6pfaAyOCOo2ucWFXuhqXjOIiU18A
        SbA0OXG3KE7oHxSS4Mg4fRnQk
X-Received: by 2002:a17:90b:4b10:b0:1c7:5b66:28df with SMTP id lx16-20020a17090b4b1000b001c75b6628dfmr14030857pjb.33.1649312346596;
        Wed, 06 Apr 2022 23:19:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJweJp2zPRrmAPlPETh78WGTKxsWNZZmlfTbsV43Rw8FTB6b1dnjjPEVt0sxXbGTw9H+3SE4Fw==
X-Received: by 2002:a17:90b:4b10:b0:1c7:5b66:28df with SMTP id lx16-20020a17090b4b1000b001c75b6628dfmr14030831pjb.33.1649312346324;
        Wed, 06 Apr 2022 23:19:06 -0700 (PDT)
Received: from [10.72.13.105] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id b10-20020a056a00114a00b004f784ba5e6asm21959166pfm.17.2022.04.06.23.19.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 23:19:05 -0700 (PDT)
Message-ID: <be2dd73d-7394-20d0-fa2b-652fdaa5700f@redhat.com>
Date:   Thu, 7 Apr 2022 14:19:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH V2 1/5] virtio: use virtio_device_ready() in
 virtio_device_restore()
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, maz@kernel.org, tglx@linutronix.de,
        peterz@infradead.org, sgarzare@redhat.com,
        "Paul E. McKenney" <paulmck@kernel.org>
References: <20220406083538.16274-1-jasowang@redhat.com>
 <20220406083538.16274-2-jasowang@redhat.com>
 <20220406073803-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220406073803-mutt-send-email-mst@kernel.org>
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


在 2022/4/6 下午7:44, Michael S. Tsirkin 写道:
> patch had wrong mime type. I managed to extra it but pls fix.
>
>>
>> From: Stefano Garzarella <sgarzare@redhat.com>
>>
>> It will allows us
> will allow us
>
>> to do extension on virtio_device_ready() without
>> duplicating codes.
> code
>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: "Paul E. McKenney" <paulmck@kernel.org>
>> Cc: Marc Zyngier <maz@kernel.org>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>> ---
>>   drivers/virtio/virtio.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
>> index 22f15f444f75..75c8d560bbd3 100644
>> --- a/drivers/virtio/virtio.c
>> +++ b/drivers/virtio/virtio.c
>> @@ -526,8 +526,9 @@ int virtio_device_restore(struct virtio_device *dev)
>>   			goto err;
>>   	}
>>   
>> -	/* Finally, tell the device we're all set */
>> -	virtio_add_status(dev, VIRTIO_CONFIG_S_DRIVER_OK);
>> +	/* If restore didn't do it, mark device DRIVER_OK ourselves. */
>> +	if (!(dev->config->get_status(dev) & VIRTIO_CONFIG_S_DRIVER_OK))
>> +		virtio_device_ready(dev);
>>   
>>   	virtio_config_enable(dev);
> it's unfortunate that this adds an extra vmexit since virtio_device_ready
> calls get_status too.
>
> We now have:
>
> static inline
> void virtio_device_ready(struct virtio_device *dev)
> {
>          unsigned status = dev->config->get_status(dev);
>                  
>          BUG_ON(status & VIRTIO_CONFIG_S_DRIVER_OK);
>          dev->config->set_status(dev, status | VIRTIO_CONFIG_S_DRIVER_OK);
> }
>
>
> I propose adding a helper and putting common code there.


Ok, let me fix it.

Thanks


>
>>   
>> -- 
>> 2.25.1

