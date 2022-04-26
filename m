Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F9450F911
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 11:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241369AbiDZJqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 05:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348226AbiDZJoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 05:44:25 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B0B1E030D;
        Tue, 26 Apr 2022 02:00:59 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id v65so15242108oig.10;
        Tue, 26 Apr 2022 02:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Nwb8/mmKZO6P2XfY+52W/cShYVLjOcMT6tDHNN8mOew=;
        b=HCXSqQvdAuaIFTCy251ccV6oh0hasfXDX64YFOgQJLaxeXoOUyhm8W1g7IUsXtWN/p
         1UsVYx5fub55CfJPvEdF8A10srT9i+AlW5L21I5QLvTc5JTJj4mZKslJIKwXl6EsACNY
         JwNRTFdGZbf/wI/FcRNS2knVV+2UQHKYjfmms2joZ/Excnab5Ouly0ys3DDra6fkmPsv
         nGZDGwlmfo8VqCuLwlLf66LDMZBjzd7KU2nT9KU1/cSi+Rnkl1d4gPNsQJPqW4QKfsCt
         k508Jcg/8ZeyslKYcSZaKXGmAcChWmwcVGvVC7UUtdoq31/wk32NyA9WIINLOukCk2HN
         WZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Nwb8/mmKZO6P2XfY+52W/cShYVLjOcMT6tDHNN8mOew=;
        b=P2aPJ9zI53waj3GjHAPGV0uXMpw0kePXU1zUgpPPiuW+DwuiMF7gUx0kzliZLtKjXy
         6HNqPHK6y2BeW8bRCMC06KOQuH5PWYlJypCTzISScJsYpF1L3lPSBD5dImAcN/qi0SIx
         RTeENC/j1ns/8f5a9iQSVruWn/3QzwQXeyd5bYY1Q0FU5k6yEGD1lUkHbjJeXJgJUYPW
         TwKH+9fVuKIcl+PmOBsBWp/AX/ytdkTXNX9taxXm/wr5YnpC9eKYCES0c9j9cu3T3iDB
         fY31LQlVtCtzN1Ub1oUH4j7+gXHKvWLqweQPkb0w33O1ES2Ytt+k2pIztXubi/Lhgb+K
         a0Bw==
X-Gm-Message-State: AOAM531neZfoq+ee6tlR3Lmyge6Z7xShRi0zHGghivtoc7OjenxG8BXr
        0PC9UBzxuZDZO2JYzSOs7ysuK4x/eLM=
X-Google-Smtp-Source: ABdhPJwUaViFkskduZFOqEI2ZLyl0iibEjD7lEBlQbzcpENqkhFic3BipIG+zKYZGGVjXTKPXso+rQ==
X-Received: by 2002:a05:6808:2189:b0:322:e874:e8f2 with SMTP id be9-20020a056808218900b00322e874e8f2mr10197307oib.289.1650963655383;
        Tue, 26 Apr 2022 02:00:55 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bp17-20020a056808239100b00322c34c4afbsm4812214oib.25.2022.04.26.02.00.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 02:00:53 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <f07ef9bd-2a1d-6aec-a490-4c419ca0daab@roeck-us.net>
Date:   Tue, 26 Apr 2022 02:00:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v5] watchdog: wdat_wdg: Using the existed function to
 check parameter timeout
Content-Language: en-US
To:     Liu Xinpeng <liuxp11@chinatelecom.cn>, wim@linux-watchdog.org,
        tzungbi@kernel.org
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1650962589-1992-1-git-send-email-liuxp11@chinatelecom.cn>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <1650962589-1992-1-git-send-email-liuxp11@chinatelecom.cn>
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

On 4/26/22 01:43, Liu Xinpeng wrote:
> Context: If max_hw_heartbeat_ms is provided, the configured maximum timeout

I am quite sure I asked you to drop "Context: " and to change "existed" in
the subject to "existing".

Guenter

> is not limited by it. The limit check in this driver therefore doesn't make
> much sense. Similar, the watchdog core ensures that minimum timeout limits
> are met if min_hw_heartbeat_ms is set. Using watchdog_timeout_invalid()
> makes more sense because it takes this into account.
> 
> Signed-off-by: Liu Xinpeng <liuxp11@chinatelecom.cn>
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

