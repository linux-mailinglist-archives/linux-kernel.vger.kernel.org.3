Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3603F50AFB5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 07:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbiDVFxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 01:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbiDVFxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 01:53:25 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DFB4F466;
        Thu, 21 Apr 2022 22:50:32 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id b188so7921204oia.13;
        Thu, 21 Apr 2022 22:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+lv4oW90oOtDBOcazfFT89nppWJrsKFyLcsfC8SczvY=;
        b=nlv72w6aoG+XbDU0ymR9MPrXw2ncXVW2RxODIDHqztYmhdJp13KynBfB6UFOCpPJ49
         9BTKfVhbFi1bkYR71AVYqXkVGmMW67bT/6gBGiYsvJozjP/1diySF9ChDtiU+2jSUXns
         jT1Bz1rbcbUyRTqvAFZKvw//D3kPPdsOPTUF6Rxdx0xSI4fv7LW/pLKM2MF68BykvAOS
         IZtkbMwxRrHGpWrfMAcM/ym517iAultjlm2qsl8K8+ghSCYXQ1uw3bFU6RThp8g3VpHK
         yREPrNYgNQKVwCioXOOamhS4VS+3oWIrwU9fidPbMciYbbZm7pCM01C38L3Vx0gMaJ8s
         byXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+lv4oW90oOtDBOcazfFT89nppWJrsKFyLcsfC8SczvY=;
        b=qnH61qMe3VElRTpGPOd6rvbyg31Gdme4ZxfvqMKJIKoavwLGwjyq4YlUkJ6Ktxvwbt
         8FJIg2ze9wBpJV/gDPdbItLi8LfuH/67IpesP67tzLWFmSlCThA81s2FOfdcpREF3mNb
         DlCk7dU00Be6YUNhUVeiPITY9HZ0aPWXA2OkvZYPmlBCXNKNiVE1rKd6wu5mmb3R1wLx
         mNgUu5nCG7ethPBVzVMNurVOglImD3Z9QIQ/asUJ6uNz7xqOp2e9bQsDHUo8BXYWcyDm
         Kw7IOVn9Q23FdmNFEkFR/zsV+vf6LaMCvgZNGtK1wrW9aJCYKlDtL/WiAtVK3s/cbp5Z
         OwEA==
X-Gm-Message-State: AOAM5304Ve4Dq/bkJnFmI8KIoisUqRe0B4u+9V2kpM5IOVyUHJ2vA4pr
        obGiizs1ubcX3HoS7TRVF6OFk5jo55k=
X-Google-Smtp-Source: ABdhPJzWO3JaG1383g9idsIvPz0gJ9abPKD9WwkMoALvnS83neYoimUvzNLjgfCds6q/dHWvXD0Pgw==
X-Received: by 2002:a05:6808:1793:b0:322:4275:b070 with SMTP id bg19-20020a056808179300b003224275b070mr5918095oib.195.1650606631649;
        Thu, 21 Apr 2022 22:50:31 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c25-20020a0568301af900b0060579b0abe2sm396997otd.61.2022.04.21.22.50.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 22:50:30 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <d0e2beb8-1bb2-ba9d-f600-aaf435663dcf@roeck-us.net>
Date:   Thu, 21 Apr 2022 22:50:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] Watchdog: Checking timeout invalid if hardware heartbeat
 range is configured
Content-Language: en-US
To:     liuxp11 <liuxp11@chinatelecom.cn>, wim <wim@linux-watchdog.org>
Cc:     linux-watchdog <linux-watchdog@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1650550938-24608-1-git-send-email-liuxp11@chinatelecom.cn>
 <bcb94cc7-b693-b6e5-6adb-d555ad4f543d@roeck-us.net>
 <6261E966.4050709@chinatelecom.cn>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <6261E966.4050709@chinatelecom.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/21/22 16:31, liuxp11 wrote:
>  > diff --git a/drivers/watchdog/wdat_wdt.c b/drivers/watchdog/wdat_wdt.c
> 
>      > index 195c8c004b69..d166d33ce7ae 100644
>      > --- a/drivers/watchdog/wdat_wdt.c
>      > +++ b/drivers/watchdog/wdat_wdt.c
>      > @@ -450,8 +450,7 @@ static int wdat_wdt_probe(struct platform_device *pdev)
>      >        * watchdog properly after it has opened the device. In some cases
>      >        * the BIOS default is too short and causes immediate reboot.
>      >        */
>      > -    if (timeout * 1000 < wdat->wdd.min_hw_heartbeat_ms ||
>      > -        timeout * 1000 > wdat->wdd.max_hw_heartbeat_ms) {
>      > +    if (watchdog_timeout_invalid(&wdat->wdd, timeout)) {
>      >           dev_warn(dev, "Invalid timeout %d given, using %d\n",
>      >                timeout, WDAT_DEFAULT_TIMEOUT);
>      >           timeout = WDAT_DEFAULT_TIMEOUT;
>     Thanks your reply, read these code,thinking can put them into watchdog_timeout_invalid.


Again, no. If anything the above code is wrong; there should be no
upper limit if max_hw_heartbeat_ms is provided. The code should
probably set min_timeout and just call watchdog_timeout_invalid()
without any change in that function.

Guenter
