Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0915AE1AF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 09:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238536AbiIFH50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 03:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238975AbiIFH5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 03:57:19 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5186DAE3;
        Tue,  6 Sep 2022 00:57:17 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id mj6so10453762pjb.1;
        Tue, 06 Sep 2022 00:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=7d/92Uix5upXpWyYq3ETNsVVpKrhQj/Lk0f9mVGVjPA=;
        b=SRFlpzCyevXhUYSNS4G8ug5Y5wTKHeebo7uJ5ejYWctEDgNggKRNfNUf6xBYSRn0eU
         JCAdctcZQngCOYd8E7Zxp8duIE/8CC2dGNSSFXYmxL3JUHK4T5yIuVAd1PKY7XQFi5Vh
         mYhGO7HmeFNq/nU9yy4ZRcO+ybuyD15g4LnZfTZCNbqYzSjQPRKxdMvd18qaEOBazjvM
         Xrbh9P8Z9yRg0OpUF3rFDQrY683kCVVMCwMqfkCX9RDN+NDyjSC8y+aAtAGKFpmB8n9S
         GG4H6YKugEsD0G4buFb+rGe3s1BIykgvIqfCMdjwhBy4YEnTOJt3OPojve9+waMqy20C
         plhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=7d/92Uix5upXpWyYq3ETNsVVpKrhQj/Lk0f9mVGVjPA=;
        b=x7aieBMc3G4fXah85WbkHzmqdTgAVbZ7RsaNb0U0XN0G3OTQMImc6iU+60Mvpl3QmF
         88ums4acaZfURYN8Tkhb+DwkD/DXvVbzo+e8tr9B/0FRq9QKHxbHWmFqWnaR0Z/jYl4e
         /YQUXWTJTJsnQ6rAL0SkUfOcsBB1gmsOdif26BwFE/9+SqER1WretlL94Yg2YdsBzJ44
         ia+Vd09xMEAAHrdyDZFagyb+L7bdUhL5/BS/rFX4auUKVYD2jY3VRNKFSMl5yoDUOGie
         YCPGIBn/+wsubo/Uj86vjV5DQKpD6wWHiBqYrNjxlcMEAz7mHOGGVcFuEt4/3OyFOXfs
         17RA==
X-Gm-Message-State: ACgBeo3/njmcNtK7IUL4ryly6WcEtTB/EGYZNw/q2eURLTvuehs1WRjy
        dAVfadMXLGsJT+EloScQk2U=
X-Google-Smtp-Source: AA6agR6bl4BhuuZ/gx9PXCMRzEiC6M1YXyi3FOUk3XLFORk1ZPNG0kMEzGxKMCheiVFmaaqr3ezNHA==
X-Received: by 2002:a17:903:11c7:b0:170:a74e:3803 with SMTP id q7-20020a17090311c700b00170a74e3803mr51951613plh.156.1662451037255;
        Tue, 06 Sep 2022 00:57:17 -0700 (PDT)
Received: from [192.168.50.247] ([129.227.150.140])
        by smtp.gmail.com with ESMTPSA id a12-20020a170902710c00b00174c235e1fdsm8989725pll.199.2022.09.06.00.57.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Sep 2022 00:57:16 -0700 (PDT)
Message-ID: <64a3bd41-1184-e65b-e70f-01ef8daadb53@gmail.com>
Date:   Tue, 6 Sep 2022 15:57:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] hid: hid-logitech-hidpp: avoid unnecessary assignments in
 hidpp_connect_event
Content-Language: en-US
To:     lains@riseup.net, jikos@kernel.org, benjamin.tissoires@redhat.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220812025515.19467-1-hbh25y@gmail.com>
From:   Hangyu Hua <hbh25y@gmail.com>
In-Reply-To: <20220812025515.19467-1-hbh25y@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/2022 10:55, Hangyu Hua wrote:
> hidpp->delayed_input can't be assigned to an object that already call
> input_free_device when input_register_device fails.
> 
> Fixes: c39e3d5fc9dd ("HID: logitech-hidpp: late bind the input device on wireless connection")
> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
> ---
>   drivers/hid/hid-logitech-hidpp.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
> index 68f9e9d207f4..c3602bf8f9b9 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -3959,8 +3959,10 @@ static void hidpp_connect_event(struct hidpp_device *hidpp)
>   	hidpp_populate_input(hidpp, input);
>   
>   	ret = input_register_device(input);
> -	if (ret)
> +	if (ret) {
>   		input_free_device(input);
> +		return;
> +	}
>   
>   	hidpp->delayed_input = input;
>   }
Gentel ping.
