Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 755C550F359
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 10:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344527AbiDZIJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 04:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344473AbiDZIJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 04:09:13 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28D032EC6;
        Tue, 26 Apr 2022 01:06:01 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-e5ca5c580fso18623636fac.3;
        Tue, 26 Apr 2022 01:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Yx4DJC6j8cvTM/tBpp7NRdOzF7TbB+jWhGor2L5SzGU=;
        b=RALJ0CRBIAAlVZ8KxS1r/ZFduX+cJd2JNfmZN2hRGoVJSH+I3fMFY3KYoVp0LqTsyt
         3F7mRevxbKUIVX4MOxJ+41XCxFOrL9VsUM+IfpBn2+WJsoRf+qUWJ1VlvyL7NKTso5ps
         bJLuvL4eBhUcfa8xUqjW77dqBZsVkwA2dHCQThZ7RYpKFVYnHvb0jTzK6onEGToqpDhx
         EGliTGBfvaeXp16Wl4a7lgWpY7SXdgo09XNl1ZNZyLMTxCkEG2Roumt0urgM65yxETvF
         rQAfEdVCVDOln34gStg3J7uTa5HKhnpFkEMGNqJeXfA3ZPmMGdEfyphkG+md+xTPFErF
         7v5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Yx4DJC6j8cvTM/tBpp7NRdOzF7TbB+jWhGor2L5SzGU=;
        b=O4BmVAJeCZuiro5+hb22ApyZVFHgkSdGS+mXwFDNEwLwBKex9wmDD2xuCrEr81rXWD
         FIZNUsDLUpG7mdq8JOsjqMkpR3mrFR8TTquMO4lGUHkiXbkMk/R4WVIWW4+1BmF8IsWi
         HELWd2MiGCkqrGEgITiD+NP34tgZeOem2I8EhrVGZ1/uzUb5x4mp3fHY7MtxYhNDd5yR
         GNydvQmC11QZ9ZKcDUkH+1ebM46NxOzAPN8/Ai0o+sX1zlwHyvXCdpXWz2X/fqQGjNRS
         LKYCHZVerx1xqSwBbc0zL/QsKj+jdMy9BbghmtisZb7myTY4g3dlT6kXhb0xqYxd6gjY
         NaUA==
X-Gm-Message-State: AOAM531tGOAm7Hx0eJdDsTuKWgqvx/Fs6YtthdK1l4iH7j1CYATf8Squ
        9UsOOieCj78kPhQvytQ7Egg=
X-Google-Smtp-Source: ABdhPJxwGxMsRqyvVxDkD1OzPzbtSteHeUo2dmlJwNpwTWBve7JPcd/WUPfrfn95tvyToisoD77sUw==
X-Received: by 2002:a05:6870:42c7:b0:e9:11d2:b259 with SMTP id z7-20020a05687042c700b000e911d2b259mr6834771oah.272.1650960361120;
        Tue, 26 Apr 2022 01:06:01 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d21-20020a4a3c15000000b0033364bde9besm5372819ooa.32.2022.04.26.01.05.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 01:06:00 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <f55c7bba-2096-c392-d81f-b04d44ea1175@roeck-us.net>
Date:   Tue, 26 Apr 2022 01:05:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 1/4] watchdog: wdat_wdg: Using the existed function to
 check parameter timeout
Content-Language: en-US
To:     Liu Xinpeng <liuxp11@chinatelecom.cn>, wim@linux-watchdog.org,
        tzungbi@kernel.org
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1650957029-910-1-git-send-email-liuxp11@chinatelecom.cn>
 <1650957029-910-2-git-send-email-liuxp11@chinatelecom.cn>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <1650957029-910-2-git-send-email-liuxp11@chinatelecom.cn>
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

On 4/26/22 00:10, Liu Xinpeng wrote:
> Context: If max_hw_heartbeat_ms is provided, the configured maximum timeout

Drop "Context:".

Also, in the subject, it should be "existing".

> is not limited by it. The limit check in this driver therefore doesn't make
> much sense. Similar, the watchdog core ensures that minimum timeout limits
> are met if min_hw_heartbeat_ms is set. Using watchdog_timeout_invalid()
> makes more sense because it takes this into account.
> 
> Signed-off-by: Liu Xinpeng <liuxp11@chinatelecom.cn>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>

And you really should not make up Reviewed-by: tags. This is completely
inappropriate.

Guenter

> ---
>   drivers/watchdog/wdat_wdt.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/wdat_wdt.c b/drivers/watchdog/wdat_wdt.c
> index 195c8c004b69..9db01d165310 100644
> --- a/drivers/watchdog/wdat_wdt.c
> +++ b/drivers/watchdog/wdat_wdt.c
> @@ -55,6 +55,7 @@ MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
>   		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
>   
>   #define WDAT_DEFAULT_TIMEOUT	30
> +#define WDAT_MIN_TIMEOUT     1
>   
>   static int timeout = WDAT_DEFAULT_TIMEOUT;
>   module_param(timeout, int, 0);
> @@ -344,6 +345,7 @@ static int wdat_wdt_probe(struct platform_device *pdev)
>   	wdat->period = tbl->timer_period;
>   	wdat->wdd.min_hw_heartbeat_ms = wdat->period * tbl->min_count;
>   	wdat->wdd.max_hw_heartbeat_ms = wdat->period * tbl->max_count;
> +	wdat->wdd.min_timeout = WDAT_MIN_TIMEOUT;
>   	wdat->stopped_in_sleep = tbl->flags & ACPI_WDAT_STOPPED;
>   	wdat->wdd.info = &wdat_wdt_info;
>   	wdat->wdd.ops = &wdat_wdt_ops;
> @@ -450,8 +452,7 @@ static int wdat_wdt_probe(struct platform_device *pdev)
>   	 * watchdog properly after it has opened the device. In some cases
>   	 * the BIOS default is too short and causes immediate reboot.
>   	 */
> -	if (timeout * 1000 < wdat->wdd.min_hw_heartbeat_ms ||
> -	    timeout * 1000 > wdat->wdd.max_hw_heartbeat_ms) {
> +	if (watchdog_timeout_invalid(&wdat->wdd, timeout)) {
>   		dev_warn(dev, "Invalid timeout %d given, using %d\n",
>   			 timeout, WDAT_DEFAULT_TIMEOUT);
>   		timeout = WDAT_DEFAULT_TIMEOUT;

