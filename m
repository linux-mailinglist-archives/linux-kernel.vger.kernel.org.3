Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3AA750EF3C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 05:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243158AbiDZDig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 23:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbiDZDie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 23:38:34 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74027369E0;
        Mon, 25 Apr 2022 20:35:25 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id m11so8570686oib.11;
        Mon, 25 Apr 2022 20:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=fX5/SmB4LFT9lUhkHcp6XSw02FIzxgMDTGj7ZQlgDD0=;
        b=S+4WkQHeHFGR3WaeyyaoDqCmZG/ca4mWuZ3liogl/yVMyWWrw3z7jY2FiG6/8ssoaR
         GSb7b9hFeC1IwoBYSCp3846cllV4gCRvEdloK+tqJtWD/Dr3fKJXlxx2P7YjIiET6L6E
         KIJFSmVi8/09SYvH/bIaBzOXdp8olwAxGbggReOenVsgjM+/zkbOXKkqw0lw+DJl4y5J
         WVAq4EzbUTgaDpxzPIqvt8dOJHf9AGu8Zyl96IOmjc6vym78s7bZC7rgLyHj0fvW23Qo
         ukfCQxtsTJXgDicI0kDV9HpuesIZqRsPNsTyUbfogVlO+p8UCORA4V8YBaV1Tb7s51Hn
         XA1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=fX5/SmB4LFT9lUhkHcp6XSw02FIzxgMDTGj7ZQlgDD0=;
        b=LxSJzkkuUtpq3URwro/zP6bYyS5KzBx5sULCJiQOGQgvtceHkqrdxT6ZEVQ3UbkonT
         1p60gT0SZ2zGv3uxPHE5sV25FAzzPcrHf0JAcIlH0X1ASjlHuTGKr0JX4iT8TSozfrYH
         NKLfmIQ82IoAapStvtuu4czc3OYEiJqZmDuUEBHPPjx4aDeSQDldfAzT+hGy705SYVe4
         LAhk3uvJwO+7o68sMNk0KPj22wGkxTfDiNHm4akUFXGuU1d7eW4XWUFwbjaB4zgjoQAW
         MhY+iwdzsUl2BrRP1//OPD4S2I5y5Db9130TN9XEt1TGzUnh3oedOq3m2PLVx/P6zGqL
         JVRw==
X-Gm-Message-State: AOAM533n//jmkPffxySyPIgbgaNtJ9ukx+HHc4MwibuH6T0kbSDhBMDq
        N9WVk5TmwHGoG1aabsZofZOBAwgvX2c=
X-Google-Smtp-Source: ABdhPJxjWzcB92zup51JLUhhaIFudWGq+14H/jWy21KLhAniUbIu4JVBRAjV/dLxjPzoX0pbNzf4rg==
X-Received: by 2002:a05:6808:1b26:b0:323:443:9f65 with SMTP id bx38-20020a0568081b2600b0032304439f65mr10093083oib.185.1650944125233;
        Mon, 25 Apr 2022 20:35:25 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d10-20020a9d51ca000000b00605522f0739sm4558908oth.41.2022.04.25.20.35.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 20:35:23 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <57d4e920-2571-4496-59ac-1bfc27cc74b4@roeck-us.net>
Date:   Mon, 25 Apr 2022 20:35:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Tzung-Bi Shih <tzungbi@kernel.org>,
        Liu Xinpeng <liuxp11@chinatelecom.cn>
Cc:     wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1650874932-18407-1-git-send-email-liuxp11@chinatelecom.cn>
 <1650874932-18407-2-git-send-email-liuxp11@chinatelecom.cn>
 <YmdhQC6WN/kMnQfD@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 1/3] watchdog: wdat_wdg: Using the existed function to
 check parameter timeout
In-Reply-To: <YmdhQC6WN/kMnQfD@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/22 20:04, Tzung-Bi Shih wrote:
> On Mon, Apr 25, 2022 at 04:22:10PM +0800, Liu Xinpeng wrote:
>>   #define MAX_WDAT_ACTIONS ACPI_WDAT_ACTION_RESERVED
>> +#define WDAT_TIMEOUT_MIN     1
>>   
>>   /**
>>    * struct wdat_instruction - Single ACPI WDAT instruction
>> @@ -344,6 +345,7 @@ static int wdat_wdt_probe(struct platform_device *pdev)
>>   	wdat->period = tbl->timer_period;
>>   	wdat->wdd.min_hw_heartbeat_ms = wdat->period * tbl->min_count;
>>   	wdat->wdd.max_hw_heartbeat_ms = wdat->period * tbl->max_count;
>> +	wdat->wdd.min_timeout = WDAT_TIMEOUT_MIN;
>>   	wdat->stopped_in_sleep = tbl->flags & ACPI_WDAT_STOPPED;
>>   	wdat->wdd.info = &wdat_wdt_info;
>>   	wdat->wdd.ops = &wdat_wdt_ops;
>> @@ -450,8 +452,7 @@ static int wdat_wdt_probe(struct platform_device *pdev)
>>   	 * watchdog properly after it has opened the device. In some cases
>>   	 * the BIOS default is too short and causes immediate reboot.
>>   	 */
>> -	if (timeout * 1000 < wdat->wdd.min_hw_heartbeat_ms ||
>> -	    timeout * 1000 > wdat->wdd.max_hw_heartbeat_ms) {
>> +	if (watchdog_timeout_invalid(&wdat->wdd, timeout)) {
> 
> Probably lacking of the context, I failed to see why the checks are
> equivalent.  Could you provide more information?

Not exactly equivalent; this is a fix.

Context: If max_hw_heartbeat_ms is provided, the configured maximum timeout
is not limited by it. The limit check in this driver therefore doesn't make
much sense. Similar, the watchdog core ensures that minimum timeout limits
are met if min_hw_heartbeat_ms is set. Using watchdog_timeout_invalid()
makes more sense because it takes this into account.

Guenter
