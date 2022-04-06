Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B85924F6AA7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 21:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbiDFT7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 15:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233999AbiDFT62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 15:58:28 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5029EB0A5
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 11:14:00 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id 125so3913461iov.10
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 11:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0OCy6LDYOIaS0T1WcEa+rwDReqz2SxY3oGp8Y6a/ndc=;
        b=fUL21+aV9GSqoqJkETQjlSLoHe+M9P2mRn+vKYS1qWwmVQrbKUlsMi1coUdwgaFQkZ
         WnX4p9HYOr5jPZ2YJRw/G4PrtQQqR7OCaHeROXcO0Di2ozo/ZoxCl4KtEn1UInHPGIAd
         Eu4o4NFOCIRaTAgpNSW1rCVz/FZL4C4/20pYw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0OCy6LDYOIaS0T1WcEa+rwDReqz2SxY3oGp8Y6a/ndc=;
        b=8MZylkvp5zDV3CURkv8nEAGhjoym6vLeRhGDuqc70e/KUgQM86XAYgmvZil1Cfo75J
         vVTYecwuv+30CZR/EvOXRXkyWL3gdszJZ0NXtz2Wk9VJPHoANFy1QUb5dHL+x+c9Sv2Z
         FPkxOwp80oNZ0QXtsuWS1K2MKVGho925+OKaxe96HSr13uBYpERrq4KpH95pWA66j/vb
         YKELOgx94UCz3LqihNEc4OLJVjDLqm4Zn5K6s5wH25SamPB1umwyOvidqG4woaRX1+Mz
         TWpg2wHETKi4/mGkQp/E/mOaIzX2uh84GKpCjymAXabtu7H1uS/QnxSadrTxdqmvibKH
         LC+g==
X-Gm-Message-State: AOAM5329cVP9uXCGO7PiKncv82kH5xuOoGLj/mFm2Ny4JMPGyCDE3JMS
        Biv4X93CKyu/DJX3Q25aFC+m3w==
X-Google-Smtp-Source: ABdhPJy+pe5o48OnBlUAWmG9tMdvl9j+ZgBFPO9RgRnitcES25uJqa3ZAi7AwksabLAclXno5xxLqg==
X-Received: by 2002:a05:6602:2aca:b0:646:a866:9fd4 with SMTP id m10-20020a0566022aca00b00646a8669fd4mr4829331iov.92.1649268838737;
        Wed, 06 Apr 2022 11:13:58 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id f20-20020a6be814000000b00649d9a4db2asm11145251ioh.27.2022.04.06.11.13.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 11:13:58 -0700 (PDT)
Subject: Re: [PATCH] usb: usbip: fix a refcount leak in stub_probe()
To:     Hangyu Hua <hbh25y@gmail.com>, valentina.manea.m@gmail.com,
        shuah@kernel.org, gregkh@linuxfoundation.org, khoroshilov@ispras.ru
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220406061713.18938-1-hbh25y@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <4341150b-195c-a896-1f6a-8715bbb539e2@linuxfoundation.org>
Date:   Wed, 6 Apr 2022 12:13:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220406061713.18938-1-hbh25y@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/22 12:17 AM, Hangyu Hua wrote:
> usb_get_dev is called in stub_device_alloc. When stub_probe fails after
> that, usb_put_dev needs to be used.
> 

Thank you for the patch. Please include details on how you found
this problem.

Nit: Change this to:

usb_get_dev() is called in stub_device_alloc(). When stub_probe() fails
after that, usb_put_dev() needs to be called to release the reference.

> Fix this by moving usb_put_dev() to sdev_free
> 

Nit: Change this to:

Fix this by moving usb_put_dev() to sdev_free error path handling.

> Fixes: 3ff67445750a ("usbip: fix error handling in stub_probe()")
> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
> ---
>   drivers/usb/usbip/stub_dev.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/usbip/stub_dev.c b/drivers/usb/usbip/stub_dev.c
> index d8d3892e5a69..3c6d452e3bf4 100644
> --- a/drivers/usb/usbip/stub_dev.c
> +++ b/drivers/usb/usbip/stub_dev.c
> @@ -393,7 +393,6 @@ static int stub_probe(struct usb_device *udev)
>   
>   err_port:
>   	dev_set_drvdata(&udev->dev, NULL);
> -	usb_put_dev(udev);
>   
>   	/* we already have busid_priv, just lock busid_lock */
>   	spin_lock(&busid_priv->busid_lock);
> @@ -408,6 +407,7 @@ static int stub_probe(struct usb_device *udev)
>   	put_busid_priv(busid_priv);
>   
>   sdev_free:
> +	usb_put_dev(udev);
>   	stub_device_free(sdev);
>   
>   	return rc;
> 

With the above addressed:

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
