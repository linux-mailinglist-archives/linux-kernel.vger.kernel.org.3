Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1911650666F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 09:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241204AbiDSIBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 04:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349687AbiDSIBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 04:01:49 -0400
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC2D2459F;
        Tue, 19 Apr 2022 00:59:06 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id z99so20189603ede.5;
        Tue, 19 Apr 2022 00:59:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gT3sY/sJ5AwFaw0rh4FR4+pzY6MGkVY982EJNWqX/aU=;
        b=hXdNbQETCGUiWUFbZdJ1e/NII6VYDMLT/QHoioq0afBjTLOH5tCbXSo1PoldC3jizK
         5SebXQCGyCFCowVZdux6oub0vHI7XhgwLQEW91OXNEXIOyOOAirDS5YifWj1wkELqhRf
         z/3XmX4XypuW7sG0TsadonpfAAHGPglfbfTia4EQMaNWiIR7r15f/7C23P8WjVefwM2w
         r05ZGfHAt+2r+d+66HvhsjFQOHboUsKjX7x2GbSHCEdoQclFPrGmnzI+CZ0+5KXDbKkl
         21A2GjfhBni9et5kHbamsHnT2TEXg6GJOeYRZMTBwAQ5vXEagyMVAHSu+j0TlFXRbpn8
         McJA==
X-Gm-Message-State: AOAM533MHaiQRKIdKyMTDu9D72Jd95nUm9L87O1Buw/T31rLy2J/77Ne
        xnF6S3me89OydjnLlcb+18A=
X-Google-Smtp-Source: ABdhPJyZacKv5Ha8d6XbpAoK7HZJX9Bu9gzntK/TY+nXUveQpUuvrSXYJ9WJ+dvD4rVS65YXY0Iyyw==
X-Received: by 2002:a05:6402:1e88:b0:419:746e:fb05 with SMTP id f8-20020a0564021e8800b00419746efb05mr15909112edf.307.1650355145376;
        Tue, 19 Apr 2022 00:59:05 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id qb10-20020a1709077e8a00b006e892cf471asm5312049ejc.84.2022.04.19.00.59.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 00:59:04 -0700 (PDT)
Message-ID: <30de7cc8-c75e-8a97-b1da-1ee8198bebcd@kernel.org>
Date:   Tue, 19 Apr 2022 09:59:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] tty: serdev: using pm_runtime_resume_and_get instead of
 pm_runtime_get_sync
Content-Language: en-US
To:     cgel.zte@gmail.com, robh@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20220418110635.2559391-1-chi.minghao@zte.com.cn>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220418110635.2559391-1-chi.minghao@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18. 04. 22, 13:06, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Using pm_runtime_resume_and_get is more appropriate
> for simplifing code

... because it's helper doing exactly the same thing.

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> ---
>   drivers/tty/serdev/core.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> index 0180e1e4e75d..e550ad3e7f2b 100644
> --- a/drivers/tty/serdev/core.c
> +++ b/drivers/tty/serdev/core.c
> @@ -156,11 +156,9 @@ int serdev_device_open(struct serdev_device *serdev)
>   	if (ret)
>   		return ret;
>   
> -	ret = pm_runtime_get_sync(&ctrl->dev);
> -	if (ret < 0) {
> -		pm_runtime_put_noidle(&ctrl->dev);
> +	ret = pm_runtime_resume_and_get(&ctrl->dev);
> +	if (ret < 0)
>   		goto err_close;
> -	}
>   
>   	return 0;
>   


-- 
js
suse labs
