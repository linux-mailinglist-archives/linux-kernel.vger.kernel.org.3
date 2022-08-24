Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36FD759F866
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 13:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237014AbiHXLLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 07:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236162AbiHXLLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 07:11:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45CC4B4AB
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 04:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661339498;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9TqH0ArTYk8TZMFyZIQ/Pebcny4HSZknKX0gNIQOJb0=;
        b=iHVV0cTixJvyBH/o/PI/U3d2HprPFHmbbsBDQvKVTXi3/DrfSa8pXNBj9IBGSDR+v5K71Y
        M8H2S1X1E46b5tce6uBtLAzk/H9/hSYbY1XabaYKkgmxbvJ8wUg/XHqlPwKrl0lfTWfCxr
        PA4buXDJIcqgilA9HnggpveGgZGwu90=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-352-4q3mK5wHNX2tDxhNRPFzQQ-1; Wed, 24 Aug 2022 07:11:34 -0400
X-MC-Unique: 4q3mK5wHNX2tDxhNRPFzQQ-1
Received: by mail-ed1-f69.google.com with SMTP id y14-20020a056402440e00b0044301c7ccd9so10694251eda.19
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 04:11:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=9TqH0ArTYk8TZMFyZIQ/Pebcny4HSZknKX0gNIQOJb0=;
        b=khBzYwccSeqRC67dMveID6DSn1mAxQeZMrAsvCt+J02gWvpxZNb5Rigd4lJDcJLF4m
         bhmTwGFiLlYAi2GrHXMYZjtxeJ254sYVpdWW+l/cYS/IxkAgLWvBUR8JNgQBFcWpTIOE
         KZDQBhcZkeSkcARRnlXKyWKD6O9DO+ypWKL5NaGxoWBVrob88pQ0nvfk61/9HItUpK8x
         3pGd5nl0U9+lZ2szyP881k/6hgb5J+3nrwI0FRiz4bb/T1xV5xAc0GIoU3sQYWD8O8AQ
         ACY9ZGcEA6mRy+3MS+xLHpaSsu/dsjivxqxeYDsb3VWM5enKpCoRBQncTHXNbQWyaQYp
         1KZQ==
X-Gm-Message-State: ACgBeo1e2aslDcx1JSc3maXxOpm86NMbDy2OJhAAAwJxkTaHzEgsLVWV
        ic7LqvgOS632DitnvtWqU6EukJK14D5nWBvrmyDXaBNstJcSrvLWRfaUY8b/+bTvfsmAiMH69Im
        ZgTXarPhbYNsh4VKCLYG1k5oL
X-Received: by 2002:a17:907:7e9e:b0:73d:ae12:5f11 with SMTP id qb30-20020a1709077e9e00b0073dae125f11mr2638941ejc.176.1661339493401;
        Wed, 24 Aug 2022 04:11:33 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4TTUrACK/XGWepadxCNkEhbNTCg5CXj3F2sC2Kjg3Ffk30X1pmCR6/61mhnzNzP/v4iHhBDA==
X-Received: by 2002:a17:907:7e9e:b0:73d:ae12:5f11 with SMTP id qb30-20020a1709077e9e00b0073dae125f11mr2638927ejc.176.1661339493199;
        Wed, 24 Aug 2022 04:11:33 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id f20-20020a17090631d400b0073c5192cba6sm999953ejf.114.2022.08.24.04.11.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 04:11:32 -0700 (PDT)
Message-ID: <ca13b742-7bb9-da20-4e50-2d04233aaf93@redhat.com>
Date:   Wed, 24 Aug 2022 13:11:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 1/1] platform/x86: asus-wmi: Add mic-mute LED classdev
 support
Content-Language: en-US
To:     PaddyKP Yao <ispaddy@gmail.com>, Pavel Machek <pavel@ucw.cz>
Cc:     PaddyKP_Yao@asus.com, andy.shevchenko@gmail.com,
        acpi4asus-user@lists.sourceforge.net, corentin.chary@gmail.com,
        linux-kernel@vger.kernel.org, luke@ljones.dev,
        mgross@linux.intel.com, platform-driver-x86@vger.kernel.org
References: <HK0PR04MB33636680A6DC47211560BB43FA879@HK0PR04MB3363.apcprd04.prod.outlook.com>
 <20220711024718.1700067-1-PaddyKP_Yao@asus.com> <20220824100615.GA1049@bug>
 <20220824110908.GB111@AA2000783-NB2.corpnet.asus>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220824110908.GB111@AA2000783-NB2.corpnet.asus>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/24/22 13:09, PaddyKP Yao wrote:
> Hi Pavel,
> 
> On Wed, Aug 24, 2022 at 12:06:15PM +0200, Pavel Machek wrote:
>>>  drivers/platform/x86/asus-wmi.c            | 25 ++++++++++++++++++++++
>>>  include/linux/platform_data/x86/asus-wmi.h |  1 +
>>>  3 files changed, 28 insertions(+)
>>>
>>> asus->micmute_led.name = "asus::micmute";
>>
>> Please see/modify well-known-leds.txt file. We want this consistent on all devices.
> 
> Thanks for your feedback.
> Do you mean I should use "platform::micmute" instead of "asus::micmute"?

Yes. Since I have already merged your original patch can you please make
this a new patch on top of your original patch ?  In other words just
make this 1 small change in the new patch:

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 2d9d709aa59f..18e584eb9f0f 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -1060,7 +1060,7 @@ static int asus_wmi_led_init(struct asus_wmi *asus)
 	}
 
 	if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_MICMUTE_LED)) {
-		asus->micmute_led.name = "asus::micmute";
+		asus->micmute_led.name = "platform::micmute";
 		asus->micmute_led.max_brightness = 1;
 		asus->micmute_led.brightness = ledtrig_audio_get(LED_AUDIO_MICMUTE);
 		asus->micmute_led.brightness_set_blocking = micmute_led_set;

Regards,

Hans

