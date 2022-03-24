Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DAB54E620C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 12:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349642AbiCXLE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 07:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344077AbiCXLEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 07:04:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A299B580FA
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 04:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648119798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5hd0/imsrp/OLykBqV1xDV+Kanold+Mdqd1VE+I5W0w=;
        b=EVXtwXOmDvWK65EjHCiMVUNwW5tzVT6EaGdLgMuTXPEXsXujpSHj0e7j5rmIryCPZl/FxL
        tEOP27F9HMIJ8bMLMttA5mASk7x5G8x/tXqXEVvZ7QaVBjCiL5Co7Uep+3SCV89iUabSQ+
        7YQxN5CaYqcis3+jWScU/nqzdiI08g0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-426-1RP9LLGYOlaZYSh2PKxxlg-1; Thu, 24 Mar 2022 07:03:17 -0400
X-MC-Unique: 1RP9LLGYOlaZYSh2PKxxlg-1
Received: by mail-qk1-f197.google.com with SMTP id q24-20020a05620a0c9800b0060d5d0b7a90so2794410qki.11
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 04:03:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5hd0/imsrp/OLykBqV1xDV+Kanold+Mdqd1VE+I5W0w=;
        b=TAjAWzhuvEV5LSL7ScjuK/KEzWd4TWWnmHEOFHxIMsJMYhEFkiXEqkvBJzrlzAL9WA
         LQpCtoi/6sxR9A/xzys6Qa8rketWE0BCZqbi6uv5Fmjk73KEN77h078FGjsAGPC2aE6y
         3vyBzi0Q4UzfwjswrpJ2Gr7PHSpnWSa7wqjK8eLrdCUtFz0gB9WawOjV6crgks/gaWbO
         CB2J1xAdJshCT/Sy9xjcMm1kiz0Qc9IOhi/95Bmetsbho8QIJZzYnntAAh7InDuVaUjr
         6Ael+rRe/7bolmHa7qBgzwERNNKKnpFOy987ObaPzKKsp+NhfenHbxCUcBQ28dEFYNpO
         satA==
X-Gm-Message-State: AOAM533mece55LdjP+ZRYR2wViseMjuEwOjQL2Li8X2j04XeuDwzOQiu
        H0xAgSfrrNLnlyqTypu3lYLHYLO4wVuYkzGz/+JpB9eNzebg/sv2+w7g0/5VLfucoZCC1hIwi1p
        PKPJwbB1+FYXYu2AXtYWH1ZT1
X-Received: by 2002:ac8:5907:0:b0:2e1:ef6f:9535 with SMTP id 7-20020ac85907000000b002e1ef6f9535mr3711238qty.49.1648119797217;
        Thu, 24 Mar 2022 04:03:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz/AHWToiCj1Oz2oO7rka3RLZGj7wUXUyJp/oVEeeh9Y8fWRq4s7ozRbuOhdDM8JD0/x98EEA==
X-Received: by 2002:ac8:5907:0:b0:2e1:ef6f:9535 with SMTP id 7-20020ac85907000000b002e1ef6f9535mr3711190qty.49.1648119796829;
        Thu, 24 Mar 2022 04:03:16 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-114.business.telecomitalia.it. [87.12.25.114])
        by smtp.gmail.com with ESMTPSA id d12-20020a05620a158c00b00648ec3fcbdfsm1323328qkk.72.2022.03.24.04.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 04:03:15 -0700 (PDT)
Date:   Thu, 24 Mar 2022 12:03:07 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, maz@kernel.org, tglx@linutronix.de,
        peterz@infradead.org, keirf@google.com
Subject: Re: [PATCH 1/3] virtio: use virtio_device_ready() in
 virtio_device_restore()
Message-ID: <20220324110307.iizkdwuhc5c75noj@sgarzare-redhat>
References: <20220324084004.14349-1-jasowang@redhat.com>
 <20220324084004.14349-2-jasowang@redhat.com>
 <20220324064205-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220324064205-mutt-send-email-mst@kernel.org>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 06:48:05AM -0400, Michael S. Tsirkin wrote:
>On Thu, Mar 24, 2022 at 04:40:02PM +0800, Jason Wang wrote:
>> From: Stefano Garzarella <sgarzare@redhat.com>
>>
>> This avoids setting DRIVER_OK twice for those drivers that call
>> virtio_device_ready() in the .restore
>
>Is this trying to say it's faster?

Nope, I mean, when I wrote the original version, I meant to do the same 
things that we do in virtio_dev_probe() where we called 
virtio_device_ready() which not only set the state, but also called 
.enable_cbs callback.

Was this a side effect and maybe more compliant with the spec?

>If yes this one looks like a red herring. Yes we skip a write but we
>replace it with a read which is not better performance-wise.
>If we want to optimize this, it is better to just do that inside
>virtio_add_status:
>
>
>
>diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
>index 75c8d560bbd3..cd943c31bdbb 100644
>--- a/drivers/virtio/virtio.c
>+++ b/drivers/virtio/virtio.c
>@@ -161,8 +161,14 @@ static void virtio_config_enable(struct virtio_device *dev)
>
> void virtio_add_status(struct virtio_device *dev, unsigned int status)
> {
>+	unsigned int device_status;
>+
> 	might_sleep();
>-	dev->config->set_status(dev, dev->config->get_status(dev) | status);
>+
>+	device_status = dev->config->get_status(dev);
>+
>+	if (status & ~device_status)
>+		dev->config->set_status(dev, device_status | status);
> }
> EXPORT_SYMBOL_GPL(virtio_add_status);

Could there be a case where we want to set the status again even though 
the device tells us it's already set?

I think not, so I guess it's okay.

>
>
>> and it will allows us to do
>> extension on virtio_device_ready() without duplicating codes.
>>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>> ---
>>  drivers/virtio/virtio.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
>> index 22f15f444f75..75c8d560bbd3 100644
>> --- a/drivers/virtio/virtio.c
>> +++ b/drivers/virtio/virtio.c
>> @@ -526,8 +526,9 @@ int virtio_device_restore(struct virtio_device *dev)
>>  			goto err;
>>  	}
>>
>> -	/* Finally, tell the device we're all set */
>> -	virtio_add_status(dev, VIRTIO_CONFIG_S_DRIVER_OK);
>> +	/* If restore didn't do it, mark device DRIVER_OK ourselves. */
>
>I preferred the original comment, it said why we are doing this,
>new one repeats what code is doing.

I agree, copy & paste from virtio_dev_probe().

Jason can you fix this patch or should I resend?

Thanks,
Stefano

