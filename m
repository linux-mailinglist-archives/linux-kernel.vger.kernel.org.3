Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D54F53368F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 07:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244038AbiEYFty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 01:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240770AbiEYFtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 01:49:52 -0400
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08396FD36;
        Tue, 24 May 2022 22:49:50 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id u27so27708796wru.8;
        Tue, 24 May 2022 22:49:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3Vo7ibPon3kehpyc25V6NoWKMeykmvgSpYHSi3SCMy4=;
        b=BBZ0rqylEWDMwBKhIz7lsKeSpEIn07L9G5R+eyStMl9J1r8gSMkjzC5OErtLMe+JZP
         uS6faFcFKt1/k8OoClYyChPFSupZhAIQy7+8eDIIfkfGyyw5mNlFpNIZktfnDRyp2FyK
         Q5w9RNzN0lxQh9I8ea/P7T7du4Wnm6ptPQW20M381W6XoRwLz/SBQvmSxkJb6fwo6GDA
         4qJTtkjFw3CXuoRz9n5VNxDbWC0HPY/Vk2bv7sCY8RA8/x8rwKKbBpVbZcIswe6fe440
         NEpzifz31H5naZxhZ9slwJ3EvqmbIMlqWtrSMiePgoJmq9nbTCj+2IO+O1RX5edyBGJL
         rtQA==
X-Gm-Message-State: AOAM5329NOPZM/fBpQWrV2+Ddgc0lEpnDW5U4LvVgMLnB8XzgjtJXlmV
        A/1n+DuMA5DePUR/QT8AtoEqNeBsB6nooA==
X-Google-Smtp-Source: ABdhPJz/Ca4G8Rs4bnoqlIwQ6g6Z4vlDUO9T+ognOpCZdiWmoKM1c/gcNtfCM8VWFbsCOtwFNpFBQg==
X-Received: by 2002:a05:6000:1a87:b0:20f:ecc0:3686 with SMTP id f7-20020a0560001a8700b0020fecc03686mr6835494wry.708.1653457789494;
        Tue, 24 May 2022 22:49:49 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id z15-20020a05600c0a0f00b003974860e15esm740063wmp.40.2022.05.24.22.49.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 May 2022 22:49:48 -0700 (PDT)
Message-ID: <5a3246cd-9edb-659f-8332-df7bcce3c13a@kernel.org>
Date:   Wed, 25 May 2022 07:49:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH -next] serial: pic32: fix missing clk_disable_unprepare()
 on error in pic32_uart_startup()
Content-Language: en-US
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     gregkh@linuxfoundation.org
References: <20220525021204.2407631-1-yangyingliang@huawei.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220525021204.2407631-1-yangyingliang@huawei.com>
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

On 25. 05. 22, 4:12, Yang Yingliang wrote:
> Fix the missing clk_disable_unprepare() before return
> from pic32_uart_startup() in the error handling case.
> 
> Fixes: 157b9394709e ("serial: pic32_uart: Add PIC32 UART driver")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>


Reviewed-by: Jiri Slaby <jirislaby@kernel.org>


> ---
>   drivers/tty/serial/pic32_uart.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/pic32_uart.c b/drivers/tty/serial/pic32_uart.c
> index b399aac530fe..f418f1de66b3 100644
> --- a/drivers/tty/serial/pic32_uart.c
> +++ b/drivers/tty/serial/pic32_uart.c
> @@ -503,7 +503,7 @@ static int pic32_uart_startup(struct uart_port *port)
>   	if (!sport->irq_fault_name) {
>   		dev_err(port->dev, "%s: kasprintf err!", __func__);
>   		ret = -ENOMEM;
> -		goto out_done;
> +		goto out_disable_clk;
>   	}
>   	irq_set_status_flags(sport->irq_fault, IRQ_NOAUTOEN);
>   	ret = request_irq(sport->irq_fault, pic32_uart_fault_interrupt,
> @@ -579,6 +579,8 @@ static int pic32_uart_startup(struct uart_port *port)
>   out_f:
>   	free_irq(sport->irq_fault, port);
>   	kfree(sport->irq_fault_name);
> +out_disable_clk:
> +	clk_disable_unprepare(sport->clk);
>   out_done:
>   	return ret;
>   }


-- 
js
suse labs
