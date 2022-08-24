Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B041559F87F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 13:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236325AbiHXLRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 07:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233768AbiHXLRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 07:17:39 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FE97F259;
        Wed, 24 Aug 2022 04:17:38 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id q63so500798pga.9;
        Wed, 24 Aug 2022 04:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=NW2FQwGNAroq7kGJ/SM5+2ixhiz8WdBcU3MZns9y+ZQ=;
        b=B2HlsCjau6l9n5Vbr/PKGuE1opvjcUsTNIwZUILw5ZS1KC/aBymytdGZr8lnV32jOy
         m1T8LJJWZq6LYyMGBIdzmI4GdUT9cvGYTikqXdWi0GY+fg4bWisw0bYLsHN0jrCUg2uc
         vEuhwkWE1O6/BCXFpyR8vZ3E0S40D+e77CIwHMA2uZoe+UBr6HR4ntZ+onJtbbOO4ZFP
         KEnOjFSG2pbxJjfgvN5Piz8KUaa4vqJuL8t74+o62RAZ31IQopaUjsk2CigqQnMAYj3x
         qrMqR1Mgjd66eBfnVxN9cO5KzF9MmNN3CtoCM5y7WboXYKHCbw5s1Xruf10k2SYcNxaY
         WZOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=NW2FQwGNAroq7kGJ/SM5+2ixhiz8WdBcU3MZns9y+ZQ=;
        b=inCLum7H3CC6vElW4xCsLNHKolDUqTeq7hJ2JHNKiL6xZTqAydU0X3w0u6iXI7hhP0
         LyvrXddNjZ1XuFdWotfpd4hd+6xUoMqnHRmLnkHoCI/KcoNXa2bRhIo6OnNSMF0JB/I1
         qaIoqH+2KVDutjZ2YvCXjy8JyDHxnTZZimDF/q7kX0Bbqeuo/6rYyGAt4jIlbQ77GXsS
         yttJrs6l1SMBeYEHqtB/0vBd7mBGVqKnG6uLO+IE5Ub5tq8V8T+AtNsoMzKA/FY+GFhM
         DbaYmidNcXq8evPrqPvvJdJIq2U6rQjCN+9kEN/r4ua2+13gemaXuRdGWPOV5XJf/XJZ
         0U7w==
X-Gm-Message-State: ACgBeo0Ex3YeBuzFJRuxeqA5pCw+dxLd5Zgc2hQZ9r2Ot4xupV9UKX6O
        cDlTi4ambAjsPPW++s0d8V0=
X-Google-Smtp-Source: AA6agR4QDK1gssjmyVghqiF+FjmNbR39rJhzGns1cUN/i1fubGYWNPzWvLHyJ97j3DXOT6qV6ZQvyA==
X-Received: by 2002:a05:6a00:1894:b0:537:2e86:c7df with SMTP id x20-20020a056a00189400b005372e86c7dfmr3314915pfh.18.1661339857865;
        Wed, 24 Aug 2022 04:17:37 -0700 (PDT)
Received: from AA2000783-NB2.corpnet.asus (125-229-150-10.hinet-ip.hinet.net. [125.229.150.10])
        by smtp.gmail.com with ESMTPSA id u64-20020a627943000000b0052c7ff2ac74sm13101357pfc.17.2022.08.24.04.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 04:17:37 -0700 (PDT)
Date:   Wed, 24 Aug 2022 19:17:34 +0800
From:   PaddyKP Yao <ispaddy@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Pavel Machek <pavel@ucw.cz>, PaddyKP_Yao@asus.com,
        andy.shevchenko@gmail.com, acpi4asus-user@lists.sourceforge.net,
        corentin.chary@gmail.com, linux-kernel@vger.kernel.org,
        luke@ljones.dev, mgross@linux.intel.com,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2 1/1] platform/x86: asus-wmi: Add mic-mute LED classdev
 support
Message-ID: <20220824111734.GA8434@AA2000783-NB2.corpnet.asus>
References: <HK0PR04MB33636680A6DC47211560BB43FA879@HK0PR04MB3363.apcprd04.prod.outlook.com>
 <20220711024718.1700067-1-PaddyKP_Yao@asus.com>
 <20220824100615.GA1049@bug>
 <20220824110908.GB111@AA2000783-NB2.corpnet.asus>
 <ca13b742-7bb9-da20-4e50-2d04233aaf93@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca13b742-7bb9-da20-4e50-2d04233aaf93@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On Wed, Aug 24, 2022 at 01:11:32PM +0200, Hans de Goede wrote:
> Yes. Since I have already merged your original patch can you please make
> this a new patch on top of your original patch ?  In other words just
> make this 1 small change in the new patch:
> 
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 2d9d709aa59f..18e584eb9f0f 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -1060,7 +1060,7 @@ static int asus_wmi_led_init(struct asus_wmi *asus)
>  	}
>  
>  	if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_MICMUTE_LED)) {
> -		asus->micmute_led.name = "asus::micmute";
> +		asus->micmute_led.name = "platform::micmute";
>  		asus->micmute_led.max_brightness = 1;
>  		asus->micmute_led.brightness = ledtrig_audio_get(LED_AUDIO_MICMUTE);
>  		asus->micmute_led.brightness_set_blocking = micmute_led_set;
> 
> Regards,
> 
> Hans
> 

Thanks for your advice.
No problem, I will fix it soon.

Best Regards, Paddy
