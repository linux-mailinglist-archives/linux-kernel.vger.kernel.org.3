Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570594F15E3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 15:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352686AbiDDNcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 09:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352659AbiDDNcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 09:32:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DA9B31EC48
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 06:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649079008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nRwIzU35RFV24MotolnoU7GJboLYAGylG3pVGa9Oths=;
        b=J2jvXIF3rYrn5uhfkKjEJlcOOyK1t4S2C6Q2Ei8+NmIuDzeuRImuz63I30ObWYk2i4vvxl
        dnyAF3kA+i/tj6IhY1m2nNyZWRfmsiMjlGxYXkxldLsxYSH5CvQs5FnDxB5jbfmeR+ggRb
        8LfPL6Qu5xvlmgG3lsGxm/aHeiBi3Ks=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-511-SunKCr0CNn2ektagJ8i8kQ-1; Mon, 04 Apr 2022 09:30:07 -0400
X-MC-Unique: SunKCr0CNn2ektagJ8i8kQ-1
Received: by mail-ed1-f70.google.com with SMTP id w8-20020a50d788000000b00418e6810364so5448900edi.13
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 06:30:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nRwIzU35RFV24MotolnoU7GJboLYAGylG3pVGa9Oths=;
        b=kpqqjQ4+KkXInnUbKpvzQqN2Rb0yMq2FL94XnJoybB3/X6nIWfQkxDonpqETvqT5P2
         JYgtgaKTQyWea//dJvJhzlMvF9szCo8mAwyNEKnIk5uhe7akku4G7hTonUVnCoBxxYJ6
         hI36OAtn4TdqrtVwLK3UYcsC3cZln/RZyjYKIRutnqdaB2//JvvlFm5Ha8BYv9SwEzvb
         r3/RJT0c9P3PPcJpvlJoB08nMEtKtDysihkhZ6DiajA8Ac0jIl9YwQ/QOXhyjCsAKoSo
         NmFhWQj/JaKcLsarXXXWH37E+JtH0q8JyT0IoNJ5gyvKCnr6CxuiOBhqGQ64rU5cwcy1
         HgjA==
X-Gm-Message-State: AOAM533tjmttUd4xjQ4irPNsQyyEC/fvEGpNoigvs3+Ay+FTw0q2xj5a
        BdM/xmrCgecWOJJC69acJKBB43DCgbx0AtzqParWzxL191xiCF5gulewEWh/z4Z8X2us1/MQn+d
        oLA6Ba19bkpOWp1NWNfO3LvrT
X-Received: by 2002:a05:6402:1e90:b0:419:4cdc:8b05 with SMTP id f16-20020a0564021e9000b004194cdc8b05mr33216277edf.211.1649079006754;
        Mon, 04 Apr 2022 06:30:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy/h7QadbxpwMpWnjIBS4WTd1CwyUjzgQocOaJDG0sKf88TrM/0HN7eAoRcGLttPKS51hKLGg==
X-Received: by 2002:a05:6402:1e90:b0:419:4cdc:8b05 with SMTP id f16-20020a0564021e9000b004194cdc8b05mr33216257edf.211.1649079006559;
        Mon, 04 Apr 2022 06:30:06 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id g2-20020aa7dc42000000b00418ef55eabcsm5339033edu.83.2022.04.04.06.30.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 06:30:06 -0700 (PDT)
Message-ID: <121c8136-8d8d-3f4f-dac2-443f5adceea6@redhat.com>
Date:   Mon, 4 Apr 2022 15:30:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] samsung-laptop: Fix an unsigned subtraction which can
 never be negative
Content-Language: en-US
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        corentin.chary@gmail.com
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
References: <20220322061830.105579-1-jiapeng.chong@linux.alibaba.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220322061830.105579-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/22/22 07:18, Jiapeng Chong wrote:
> Eliminate the follow smatch warnings:
> 
> drivers/platform/x86/samsung-laptop.c:1124 kbd_led_set() warn: unsigned
> 'value' is never less than zero.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans


> ---
>  drivers/platform/x86/samsung-laptop.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/samsung-laptop.c b/drivers/platform/x86/samsung-laptop.c
> index c1d9ed9b7b67..19f6b456234f 100644
> --- a/drivers/platform/x86/samsung-laptop.c
> +++ b/drivers/platform/x86/samsung-laptop.c
> @@ -1121,8 +1121,6 @@ static void kbd_led_set(struct led_classdev *led_cdev,
>  
>  	if (value > samsung->kbd_led.max_brightness)
>  		value = samsung->kbd_led.max_brightness;
> -	else if (value < 0)
> -		value = 0;
>  
>  	samsung->kbd_led_wk = value;
>  	queue_work(samsung->led_workqueue, &samsung->kbd_led_work);

