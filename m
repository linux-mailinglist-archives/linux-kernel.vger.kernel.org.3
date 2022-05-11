Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87725522F98
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 11:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbiEKJjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 05:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242976AbiEKJjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 05:39:02 -0400
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573F860B8B;
        Wed, 11 May 2022 02:38:27 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id h16so1443013wrb.2;
        Wed, 11 May 2022 02:38:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lzACg4GskWgzpiC8FnJ6syyhmXEEgXE0lIGs/KbCq9o=;
        b=jtKfFP1lCqOriGDRrs8EeuSS2fvWnHaFJLntOm0zScTV/rPmrps6rxl3v72KDTi7LO
         vEh9zC+0vOsL3pEwj0192VQcqij+iraKlP01ZaMcaoW6JRO/IOk32pTaTpxNLqegF0+R
         WEOEdObBj/buvrnpFVkee+nfPmdtk3D+fkdhRVr5fWpjWcVdMbRpcKR6fRzF+s0M/tt+
         PD00mRDywuk+RjbH+mh2icRjJXpFk6spKIkXGyWNLyOG1R0vK+vjzuSdIux5Vxv17e1i
         me9gnlL/jNI2xTosySaSv7087/YcyppdBeo51tZ4z8lrHlbahZNZvYj5pBEorz9Hha3c
         dXGw==
X-Gm-Message-State: AOAM531PApvYR3wH8V19cW7kGH/DK8AzoptiEUGpS2SMtTj+ZX2NW3zP
        X0AaK8wyApdlcVdqe0r9Pf4NtdwHnwE=
X-Google-Smtp-Source: ABdhPJwoJ97JtoBiACfuZa0lRu3jF4CuA/9qZMyWjZsGxIHdriTf72Obw5v7nF1vuabJn1bt50PEUw==
X-Received: by 2002:a5d:4b48:0:b0:207:9abd:792a with SMTP id w8-20020a5d4b48000000b002079abd792amr11189756wrs.118.1652261905757;
        Wed, 11 May 2022 02:38:25 -0700 (PDT)
Received: from [192.168.1.49] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id e8-20020a5d5308000000b0020c5253d8c2sm1209516wrv.14.2022.05.11.02.38.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 02:38:25 -0700 (PDT)
Message-ID: <cc73ed8b-b51f-59bc-ef4b-5f7e4ab26828@kernel.org>
Date:   Wed, 11 May 2022 11:38:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH -next] tty: serial: max3100: Add missing
 uart_unregister_driver in max3100_probe
Content-Language: en-US
To:     Zheng Bin <zhengbin13@huawei.com>, gregkh@linuxfoundation.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     gaochao49@huawei.com
References: <20220511071523.3128725-1-zhengbin13@huawei.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220511071523.3128725-1-zhengbin13@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11. 05. 22, 9:15, Zheng Bin wrote:
> max3100_probe misses a call uart_unregister_driver in error path,
> this patch fixes that.

I believe, that's intentional. Cf. uart_driver_registered.

> Signed-off-by: Zheng Bin <zhengbin13@huawei.com>
> ---
>   drivers/tty/serial/max3100.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
> index 0b5f21fbb53d..6d34ca2a3f7b 100644
> --- a/drivers/tty/serial/max3100.c
> +++ b/drivers/tty/serial/max3100.c
> @@ -752,6 +752,7 @@ static int max3100_probe(struct spi_device *spi)
>   		if (!max3100s[i])
>   			break;
>   	if (i == MAX_MAX3100) {
> +		uart_unregister_driver(&max3100_uart_driver);
>   		dev_warn(&spi->dev, "too many MAX3100 chips\n");
>   		mutex_unlock(&max3100s_lock);
>   		return -ENOMEM;
> @@ -759,6 +760,7 @@ static int max3100_probe(struct spi_device *spi)
> 
>   	max3100s[i] = kzalloc(sizeof(struct max3100_port), GFP_KERNEL);
>   	if (!max3100s[i]) {
> +		uart_unregister_driver(&max3100_uart_driver);
>   		dev_warn(&spi->dev,
>   			 "kmalloc for max3100 structure %d failed!\n", i);
>   		mutex_unlock(&max3100s_lock);
> --
> 2.31.1
> 


-- 
js
suse labs
