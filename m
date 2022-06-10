Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A63D546CBC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 20:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349841AbiFJSsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 14:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350407AbiFJSsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 14:48:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8C18AF5B4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 11:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654886902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2kuLRtRoKUifo/tKfS7LdiA/ElsrLzJlIXXi0O8EF0U=;
        b=epXrpOV+l5NLQ8wBGL3NPE4YEpgwI5NEbTS70D8u+w/6FQKLxwABz7EKaf36K+u1MCnROj
        lemLPidTGs+h+mygZM2Pwi4LMfIIFEsuF8D9UbNyaPjgN2szvR3pimVUJOevAh0y8vQDNk
        QIYBmMWZeG+xubqYjmzbAU350JMgPM4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-558-FhtlCfq-ObOJ5SVmnIncUw-1; Fri, 10 Jun 2022 14:48:21 -0400
X-MC-Unique: FhtlCfq-ObOJ5SVmnIncUw-1
Received: by mail-ed1-f72.google.com with SMTP id ee46-20020a056402292e00b0042dd4d6054dso56512edb.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 11:48:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2kuLRtRoKUifo/tKfS7LdiA/ElsrLzJlIXXi0O8EF0U=;
        b=m1htyuqI2AfoNNii/ZmT7kOONSqzTDQTK0g+PSnkStxRpPQxtifz9hI+WANmAlUOys
         nfeowCg6XMJz/W7JfhdAR56lhs5FnVkUOWMXKEcT8q0DCzlLy714wV29/EJuTlhSDgVO
         26AhIhWwbKCaafvAKZRgFHzGMbsD2HQsY+LADl+Afz2EQ/6Nz+Z9XGrHmY62jU71ORvC
         u/iOLvKHKOOSRVQACpjxFNL31TLPDXB/Nkm/hXZOfV0qHkkhovqtZUzx0QWO2Wcw+FuU
         56FQFxF3n16p/FK+ZZZeK/4IV9Q8IdsDq8ottaVt1t1kyA7uwvbqoZ19cas3W1NC4eL1
         +PiQ==
X-Gm-Message-State: AOAM533mFVQK3oR6TbudMrIPfFhqqHdmS/05ZuFWdhTDjb+PC930HIaN
        gq6VW2qg1N03JotmyeO0asDIxWwlaJZL7OoF5MLFJ0R3t39AL+ijsABehSBxZuUKQprfRs6MxDq
        Ky+L2bOsUkNTd8GlhlxU331Qd
X-Received: by 2002:a17:906:414f:b0:711:ce99:69ec with SMTP id l15-20020a170906414f00b00711ce9969ecmr25093229ejk.724.1654886900342;
        Fri, 10 Jun 2022 11:48:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwqEM5tPbFuvpNe/haxDXhAPPziWrdTs8l89PJk48KAGAYo4y++uBvXFWfvBsk2LG4uj5ozZA==
X-Received: by 2002:a17:906:414f:b0:711:ce99:69ec with SMTP id l15-20020a170906414f00b00711ce9969ecmr25093220ejk.724.1654886900122;
        Fri, 10 Jun 2022 11:48:20 -0700 (PDT)
Received: from ?IPV6:2001:1c00:2a07:3a01:67e5:daf9:cec0:df6? (2001-1c00-2a07-3a01-67e5-daf9-cec0-0df6.cable.dynamic.v6.ziggo.nl. [2001:1c00:2a07:3a01:67e5:daf9:cec0:df6])
        by smtp.gmail.com with ESMTPSA id ga33-20020a1709070c2100b0070a50832376sm11716543ejc.154.2022.06.10.11.48.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jun 2022 11:48:19 -0700 (PDT)
Message-ID: <25e78a1e-6ec2-845c-61b6-ec3f0d6766de@redhat.com>
Date:   Fri, 10 Jun 2022 20:48:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] platform/x86: barco-p50-gpio: Add check for
 platform_driver_register
Content-Language: en-US
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        santoshkumar.yadav@barco.com, peter.korsgaard@barco.com,
        markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220526090345.1444172-1-jiasheng@iscas.ac.cn>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220526090345.1444172-1-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/26/22 11:03, Jiasheng Jiang wrote:
> As platform_driver_register() could fail, it should be better
> to deal with the return value in order to maintain the code
> consisitency.
> 
> Fixes: 86af1d02d458 ("platform/x86: Support for EC-connected GPIOs for identify LED/button on Barco P50 board")
> 
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>

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
>  drivers/platform/x86/barco-p50-gpio.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/barco-p50-gpio.c b/drivers/platform/x86/barco-p50-gpio.c
> index 05534287bc26..8dd672339485 100644
> --- a/drivers/platform/x86/barco-p50-gpio.c
> +++ b/drivers/platform/x86/barco-p50-gpio.c
> @@ -405,11 +405,14 @@ MODULE_DEVICE_TABLE(dmi, dmi_ids);
>  static int __init p50_module_init(void)
>  {
>  	struct resource res = DEFINE_RES_IO(P50_GPIO_IO_PORT_BASE, P50_PORT_CMD + 1);
> +	int ret;
>  
>  	if (!dmi_first_match(dmi_ids))
>  		return -ENODEV;
>  
> -	platform_driver_register(&p50_gpio_driver);
> +	ret = platform_driver_register(&p50_gpio_driver);
> +	if (ret)
> +		return ret;
>  
>  	gpio_pdev = platform_device_register_simple(DRIVER_NAME, PLATFORM_DEVID_NONE, &res, 1);
>  	if (IS_ERR(gpio_pdev)) {

