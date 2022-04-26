Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 410D6510AA0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 22:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354526AbiDZUjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 16:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245092AbiDZUjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 16:39:35 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED98530F77;
        Tue, 26 Apr 2022 13:36:26 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-e68392d626so15562787fac.4;
        Tue, 26 Apr 2022 13:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dvZkqe38UsmxOTbwKr+ZpgOFpqms9JoxuO792ba7W7A=;
        b=WlH1aEnpPqEhRKRA8auX76dxowKfdqJCT1s1sIn+rC+D5ZDKqm3+VmkokAJNEArddq
         YrZEQ35b190PfuurBIHHejSZS2HPOeXEVT+GKr3C6nx5ukFMwslG5ALDipXT5h4ppJjJ
         uBGaXXKmYJN2DdgNLZbn/yPMk4x67P58X9o6OWQDiXtCqrzmCIqwf+rS0S9Aqf2bybOf
         p2EK7uJ46G9R92/co08JkxxPxNFhNkG+dp0xmEEHtyoQ0LWAWVxzuQnfZXVHjLCgB7u5
         d+EXIgkUhdjLyEo5+36WG9WFVO93M5yApSIk2UbznyqCaD0e8jD5hQN8cablo8G7mzyp
         cQLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dvZkqe38UsmxOTbwKr+ZpgOFpqms9JoxuO792ba7W7A=;
        b=q/Qyai0sc2yCBpIy5DkbBXkQMZwq9VEYQZXO6BXMmE95WhkZ0/ebiNIRXguJpvdNu5
         XJtQlrspcnFxEqFR0N2ZpFn7bnnchVP23Hymdw5JVYHPp0kkzG29KEyF76UzZF+UzQ7q
         2tAASqaaPCtGc8XJJa/EZMq47DO1CADfETwnPzE/VBVHgPtCesuflT9w8UmESSpH22oi
         zHoc3xhV9oNItOJVC8FjmmFsk1Z+lBONAZxFbJA0uvhbNjXNzrAAFdceg0O0ahg0Hr7R
         lIo8oWsboZmYI/wznyeQh99JH0+FBO75321OipqysYuUJIlabtEvnaDgPuDodDGtqJj8
         mc1Q==
X-Gm-Message-State: AOAM530dWP7OBbq1Oleo+RMiM56MlZcqkKs7aCRdtEDb9CdAnu+PxmzX
        7Bo1D351PDavqehXvP6stJQ=
X-Google-Smtp-Source: ABdhPJxvZAmJFmnR9gb1XLCDjtFDMRGm3lEdpr1hCqXdb1shn0Ek/d1OGiByHKUrpsp2hLIr74UHFw==
X-Received: by 2002:a05:6870:580e:b0:e2:7e06:e785 with SMTP id r14-20020a056870580e00b000e27e06e785mr10597212oap.38.1651005386240;
        Tue, 26 Apr 2022 13:36:26 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 62-20020a9d0dc4000000b00605db31d0b7sm117703ots.2.2022.04.26.13.36.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 13:36:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <0d6a606e-0864-104e-1b25-545388a4f73f@roeck-us.net>
Date:   Tue, 26 Apr 2022 13:36:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/1] watchdog: sp805: disable watchdog on remove
Content-Language: en-US
To:     Eliav Farber <farbere@amazon.com>, wim@linux-watchdog.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ronenk@amazon.com, talel@amazon.com, hhhawa@amazon.com,
        jonnyc@amazon.com, hanochu@amazon.com, dwmw@amazon.co.uk
References: <20220414054233.1357-1-farbere@amazon.com>
 <20220414054233.1357-2-farbere@amazon.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220414054233.1357-2-farbere@amazon.com>
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

On 4/13/22 22:42, Eliav Farber wrote:
> Disable the watchdog if it is active while removing the module.
> It is necessary in order to prevent a reset in case watchdog
> hw was running before the removal.
> 
> Signed-off-by: Eliav Farber <farbere@amazon.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Note that sending an introduction is not necessary for individual patches.

Guenter

> ---
>   drivers/watchdog/sp805_wdt.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
> index d8876fba686d..69a6182c2dfe 100644
> --- a/drivers/watchdog/sp805_wdt.c
> +++ b/drivers/watchdog/sp805_wdt.c
> @@ -273,6 +273,7 @@ sp805_wdt_probe(struct amba_device *adev, const struct amba_id *id)
>   	watchdog_set_nowayout(&wdt->wdd, nowayout);
>   	watchdog_set_drvdata(&wdt->wdd, wdt);
>   	watchdog_set_restart_priority(&wdt->wdd, 128);
> +	watchdog_stop_on_unregister(&wdt->wdd);
>   
>   	/*
>   	 * If 'timeout-sec' devicetree property is specified, use that.

