Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA7950C9AA
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 13:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235258AbiDWLon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 07:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235072AbiDWLok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 07:44:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0CCFC18364
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 04:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650714101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IqzEerzWLABZb+iaArImvfubeSzbeeC6t3f7w2iOtok=;
        b=EtShkVozwmp4KTif6VBOg0WYMnbqd6ZvfnPXyCYJbjlXnuh1/zi0uBpzr8Zr78xv2vCPRA
        TkFKWeEs3p6ZmQNyTiKTUurpBwDc9zm5smAhbXTdEGwBRItBq8svyXb0RQed1gRZA+TLhW
        QWQmLL+hvYPvmYeDL8K+woK5P465yTs=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-614-0vRaFlwCMnq3jgueq18GiA-1; Sat, 23 Apr 2022 07:41:33 -0400
X-MC-Unique: 0vRaFlwCMnq3jgueq18GiA-1
Received: by mail-ed1-f69.google.com with SMTP id eg38-20020a05640228a600b00425d61d0302so372772edb.17
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 04:41:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IqzEerzWLABZb+iaArImvfubeSzbeeC6t3f7w2iOtok=;
        b=gAdS+xFziFbtjhHGzEAAvskATKGh4QsNlTrIdMJLrNniFmlC0he+ZwJXMXI46qsYlW
         w62xsbOPDRmC8zvcpyVz2XEfj3X4q1XsYbrBfgJtw4qSKk87vyu6USyksDOIqxR3Wgik
         yrKDOY4B0ZDxmRsB3RV1UM6wqtfBLEji+m8BFJbzH6pFvfjPKB6GLd6Za8XrdKwHkoM6
         9oSKQmQ2O95aja/ZSYFvkf6giMafOk9ow+lB23k6jFms5bvCIOmj7hWS1YesGNr3wv6N
         IgV87sR0LfeXsLSSVJfw38K8l3C6XVCy/3ZQUSZXN4LlpdeqEGQ/HrwpCTT9XbPRS8uz
         V7tw==
X-Gm-Message-State: AOAM532Lbt6TIJI1AeqGDkc4LvqrQZNbV4LYpTI2DWUZICW8i1NxuUSe
        7PwOktwToKHNmLoVNKR0nwvqAXQgpOi4s0HzLcJ1kXi18a2lgD9m7dtKVA0O7R+kFf1juU72uR1
        9oiWRZfe8+QJWLiiJfhIPNVTp
X-Received: by 2002:aa7:d393:0:b0:425:a8f8:663a with SMTP id x19-20020aa7d393000000b00425a8f8663amr9604018edq.323.1650714091955;
        Sat, 23 Apr 2022 04:41:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw0Jn+0aFqCOru0ASVdqHvFdRTfaXap9NgOmqvmpPfCgU0d1vFfaUjn/Q/fIjU4FI8lDbhnhg==
X-Received: by 2002:aa7:d393:0:b0:425:a8f8:663a with SMTP id x19-20020aa7d393000000b00425a8f8663amr9604008edq.323.1650714091787;
        Sat, 23 Apr 2022 04:41:31 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id v21-20020a1709064e9500b006e8973a14d0sm1617204eju.174.2022.04.23.04.41.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Apr 2022 04:41:31 -0700 (PDT)
Message-ID: <876f7c92-4e50-401e-f0b0-c2942bd8b63d@redhat.com>
Date:   Sat, 23 Apr 2022 13:41:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 2/3] HID: logitech-hidpp: Fix double free on managed
 resource
Content-Language: en-US
To:     =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        hadess@hadess.net
Cc:     dmitry.torokhov@gmail.com, rydberg@bitmath.org, lains@riseup.net,
        jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220422161709.30198-1-jose.exposito89@gmail.com>
 <20220422161709.30198-2-jose.exposito89@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220422161709.30198-2-jose.exposito89@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/22/22 18:17, José Expósito wrote:
> As described in the documentation for devm_input_allocate_device():
> 
>   Managed input devices do not need to be explicitly unregistered or
>   freed as it will be done automatically when owner device unbinds from
>   its driver (or binding fails).
> 
> However this driver was explicitly freeing the input device, allocated
> using devm_input_allocate_device() through hidpp_allocate_input().
> 
> Remove the call to input_free_device() to avoid a possible double free
> error.

Actually calling input_free_device() on a devm allocated input device
is fine. The input subsystem has chosen to not have a
separate devm_input_free_device(), instead input_free_device() knows
if a device is allocated through devm and then also frees the devres
tied to it:

void input_free_device(struct input_dev *dev)
{
        if (dev) {
                if (dev->devres_managed)
                        WARN_ON(devres_destroy(dev->dev.parent,
                                                devm_input_device_release,
                                                devm_input_device_match,
                                                dev));
                input_put_device(dev);
        }
}


> 
> Fixes: c39e3d5fc9dd3 ("HID: logitech-hidpp: late bind the input device on wireless connection")
> Signed-off-by: José Expósito <jose.exposito89@gmail.com>
> ---
>  drivers/hid/hid-logitech-hidpp.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
> index 81de88ab2ecc..9c00a781ab57 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -3957,11 +3957,7 @@ static void hidpp_connect_event(struct hidpp_device *hidpp)
>  	}
>  
>  	hidpp_populate_input(hidpp, input);
> -
> -	ret = input_register_device(input);
> -	if (ret)
> -		input_free_device(input);
> -

The original code does look wrong there though, since the input device
is free-ed it should not be stored in hidpp->delayed_input, so this should be comes:

	ret = input_register_device(input);
	if (ret) {
		input_free_device(input);
		return;
	}


Regards,

Hans


>  	hidpp->delayed_input = input;
>  }
>  


