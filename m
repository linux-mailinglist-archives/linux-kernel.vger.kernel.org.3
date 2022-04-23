Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42A450C9AC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 13:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235303AbiDWLpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 07:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235072AbiDWLpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 07:45:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 04E4D7B540
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 04:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650714136;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OwPKJJZoyh0J9XvsXfdGaYSKuFZgp9vWLt5wohr2zdw=;
        b=R27LrEhfhCAW+YsBiDd15e/8Tg3oiAdgCrK12VMWh/LU/zFj4GseNr3obF3cUSGWiTh7zR
        BZtUtLyJWLQjQw2Bn/bYkbBZMHOuMWGYyzFQHRzevWcLoxAdWUpUtnZndRWrV8eCio36Sv
        olqeWpM6YpbRV/qUd54VpUE0rpS1nsI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-652-xydek-yfPZ-eecERMY4L3A-1; Sat, 23 Apr 2022 07:42:14 -0400
X-MC-Unique: xydek-yfPZ-eecERMY4L3A-1
Received: by mail-ed1-f70.google.com with SMTP id s13-20020a056402036d00b0041d7a5f8397so6524399edw.10
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 04:42:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OwPKJJZoyh0J9XvsXfdGaYSKuFZgp9vWLt5wohr2zdw=;
        b=ha9PwnJfqYCfAf4oMXacjs1ROqJk55B+z1VCZsZnXiP2x/d/cib8UFKo8Y0L/2YTbF
         l1kDWIt3Z1s3Vbo1bWHZv5IN+vw26C1HeMejL+fE/gEmpEm+Dc6k8mZzWiX37LKE1zly
         LDABnuOnqBBQbwdgw9tJ+Ru04BqQrulIFcmNCU78m5v+GNrSkmDPg19NlarAQptSwrXz
         WPbiAUJM+Fw3VXuZyTQbnzhOG+7vN1AkdHAyjOHq4OvfnyalvUQNujm1yLa4feIkCoEC
         0rq/uoq6fF21C1oWc67OnjtoYWoG2RiA+md3/+5phSFTBZ33Gz0e8B0JkNxgLpXb99Np
         5GEQ==
X-Gm-Message-State: AOAM533Oovy5Y6w+kd6E0zHJtKIxNy6P5h7Wdvrdi+/rYPwzS8NAi9KG
        8bJ3M7+YRjn9jJggtLCE9UOePEVlTCrgawGDQM1fSZweDDnzOcpwQlEfvlWX6sLWvjg1xGJR4gW
        UkA5g7XaAmG07h/iEj412tjGD
X-Received: by 2002:a17:906:3289:b0:6ef:ebf3:388 with SMTP id 9-20020a170906328900b006efebf30388mr8024258ejw.202.1650714133714;
        Sat, 23 Apr 2022 04:42:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwzpWkWqjQRQBIJ5ruBJFunay/l54Uztzgvw0Madb5PplYe2Xgl14TeK0fuqU5c79PRmuQ9Hw==
X-Received: by 2002:a17:906:3289:b0:6ef:ebf3:388 with SMTP id 9-20020a170906328900b006efebf30388mr8024248ejw.202.1650714133554;
        Sat, 23 Apr 2022 04:42:13 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id s5-20020a508dc5000000b004241a4abbdfsm2149488edh.45.2022.04.23.04.42.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Apr 2022 04:42:12 -0700 (PDT)
Message-ID: <e6f914ca-5863-c983-b2fe-7bda7262fb1d@redhat.com>
Date:   Sat, 23 Apr 2022 13:42:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 3/3] HID: wacom: Fix double free on managed resource
Content-Language: en-US
To:     =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        hadess@hadess.net
Cc:     dmitry.torokhov@gmail.com, rydberg@bitmath.org, lains@riseup.net,
        jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220422161709.30198-1-jose.exposito89@gmail.com>
 <20220422161709.30198-3-jose.exposito89@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220422161709.30198-3-jose.exposito89@gmail.com>
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
> using devm_input_allocate_device() through wacom_allocate_input().
> 
> Remove the calls to input_free_device() to avoid a possible double free
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

So there is no need for this patch.

Regards,

Hans




> 
> Fixes: d2d13f18aaa51 ("Input: wacom - create a separate input device for pads")
> Signed-off-by: José Expósito <jose.exposito89@gmail.com>
> ---
>  drivers/hid/wacom_sys.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index 066c567dbaa2..164c0f7cb796 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -2098,7 +2098,6 @@ static int wacom_register_inputs(struct wacom *wacom)
>  	error = wacom_setup_pen_input_capabilities(pen_input_dev, wacom_wac);
>  	if (error) {
>  		/* no pen in use on this interface */
> -		input_free_device(pen_input_dev);
>  		wacom_wac->pen_input = NULL;
>  		pen_input_dev = NULL;
>  	} else {
> @@ -2110,7 +2109,6 @@ static int wacom_register_inputs(struct wacom *wacom)
>  	error = wacom_setup_touch_input_capabilities(touch_input_dev, wacom_wac);
>  	if (error) {
>  		/* no touch in use on this interface */
> -		input_free_device(touch_input_dev);
>  		wacom_wac->touch_input = NULL;
>  		touch_input_dev = NULL;
>  	} else {
> @@ -2122,7 +2120,6 @@ static int wacom_register_inputs(struct wacom *wacom)
>  	error = wacom_setup_pad_input_capabilities(pad_input_dev, wacom_wac);
>  	if (error) {
>  		/* no pad in use on this interface */
> -		input_free_device(pad_input_dev);
>  		wacom_wac->pad_input = NULL;
>  		pad_input_dev = NULL;
>  	} else {

