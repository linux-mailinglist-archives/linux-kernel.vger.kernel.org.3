Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5777B4EA7B4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 08:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232924AbiC2GPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 02:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232916AbiC2GPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 02:15:35 -0400
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF93536E33
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 23:13:53 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id yy13so32930694ejb.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 23:13:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ItpaG0Tnv5juva+CID2pxjnQCj/WOFNURFjytNL8z0g=;
        b=kzBSiAOTJ/YsU03NFItOpPxaTD8v7zzQTMwg4a1WJ8pUVv+wVAgeuvSv4d+QxZYKoA
         enA0gVJ47IqKW5HBr5ADrflLqqH/qYqmsybLizZ5XkGEYnTAq2jAdf8fvN5pplxp0k+Z
         xYqpelRDV2TaYOkvnkoZ+LujZbG3/9gPIKRcvi7scVHeOUVmsbf9Vn9m4TYyFEm0M+KT
         Zq+YafgdxSdrwKe7JjsQ+4ldh3SraSKcVisbU8D23tIrkNFKlYY6YSt+TJaShl4LSlwH
         2TPk9F1RCZGV8gJQWZ7624LH9NRuhC3pvcdDpfn2HWo6J5pagRUp0IizaOnjip6VRwKs
         2zOw==
X-Gm-Message-State: AOAM533qYwcRNj0zbelH/mpX/QF7Ni9Vh+AI0OUXye61HrePgSx0CIXt
        y/iLAqcNyPqisow4M3NzfPA=
X-Google-Smtp-Source: ABdhPJywLiFt6L8he7SF6wfhlAnnY7fPxpbENTbpqdDXkCzwwiBqCGUUEB7D2BbtqRO6Cwubgpj9ng==
X-Received: by 2002:a17:907:3e0c:b0:6e0:7d7e:58 with SMTP id hp12-20020a1709073e0c00b006e07d7e0058mr28657225ejc.597.1648534432366;
        Mon, 28 Mar 2022 23:13:52 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id sd7-20020a1709076e0700b006e015549bdfsm6513385ejc.53.2022.03.28.23.13.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Mar 2022 23:13:51 -0700 (PDT)
Message-ID: <b882ffc5-97df-7b26-4506-30ab7933d960@kernel.org>
Date:   Tue, 29 Mar 2022 08:13:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] tty: goldfish: Use tty_port_destroy() to destroy port
Content-Language: en-US
To:     Wang Weiyang <wangweiyang2@huawei.com>, gregkh@linuxfoundation.org,
        sheng@linux.intel.com, bruce.j.beare@intel.com,
        xiaohui.xin@intel.com, yunhong.jiang@intel.com, arve@google.com
Cc:     linux-kernel@vger.kernel.org
References: <20220328115844.86032-1-wangweiyang2@huawei.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220328115844.86032-1-wangweiyang2@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28. 03. 22, 13:58, Wang Weiyang wrote:
> In goldfish_tty_probe(), the port initialized through tty_port_init()
> should be destroyed in error paths.In goldfish_tty_remove(), qtty->port
> also should be destroyed or else might leak resources.
> 
> Fix the above by calling tty_port_destroy().

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

> Fixes: 666b7793d4bf ("goldfish: tty driver")
> Signed-off-by: Wang Weiyang <wangweiyang2@huawei.com>
> ---
>   drivers/tty/goldfish.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/tty/goldfish.c b/drivers/tty/goldfish.c
> index ad13532e92fe..9e1168c39e77 100644
> --- a/drivers/tty/goldfish.c
> +++ b/drivers/tty/goldfish.c
> @@ -405,6 +405,7 @@ static int goldfish_tty_probe(struct platform_device *pdev)
>   err_tty_register_device_failed:
>   	free_irq(irq, qtty);
>   err_dec_line_count:
> +	tty_port_destroy(&qtty->port);
>   	goldfish_tty_current_line_count--;
>   	if (goldfish_tty_current_line_count == 0)
>   		goldfish_tty_delete_driver();
> @@ -426,6 +427,7 @@ static int goldfish_tty_remove(struct platform_device *pdev)
>   	iounmap(qtty->base);
>   	qtty->base = NULL;
>   	free_irq(qtty->irq, pdev);
> +	tty_port_destroy(&qtty->port);
>   	goldfish_tty_current_line_count--;
>   	if (goldfish_tty_current_line_count == 0)
>   		goldfish_tty_delete_driver();

thanks,
-- 
js
suse labs
