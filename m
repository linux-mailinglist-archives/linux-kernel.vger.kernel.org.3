Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 264ED523416
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 15:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242281AbiEKNUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 09:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243735AbiEKNT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 09:19:58 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5BB239D9C;
        Wed, 11 May 2022 06:19:53 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id w130so2723848oig.0;
        Wed, 11 May 2022 06:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xTKoqmkJyd5jKlpEWOxjT/YXWFjjUDfLBGo4J9TZy7g=;
        b=kKYtw5KYvJu3JDMAeeeiZQqbGYik4wVt1sIFGpnkGAZMDSekQOJaQt1FVeZwvRPCmG
         G+PakaqZkpjmITjjoQLpTwQMI7+ZO9IvF/2NzRDjU9BSR/gafqIkbspnhnUj1OZKVymj
         b1A4z2AzqbGwV0a64HBw87knlUST8jNwz3NWjKY6JFjPaIy39i+VOSWk9XvAxZ9rI0hh
         akciP2cBFm9m6NuppgLPV+ajLMEGHhEV4gGe9TwcLwCA/Ezmy273YjF8fPWz1NBTkPnM
         OMwJ9lK3CLD6axBvSfTqNVTOkPyLep2ZEDKTSwxp3DXU9vQ7HIzZKekkp7L7YAVS68wc
         umIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xTKoqmkJyd5jKlpEWOxjT/YXWFjjUDfLBGo4J9TZy7g=;
        b=P7BBEeNvdWUgFMOSXWoSJxppobE+FmTxHxqyT/MIDuR1cHJ9TTp4ASI5HlMiKOZ7Qh
         C2ZAfm/4gcxOc+zTDuKmBfhUaUja8PxeUWWAv3thRKh9xgdFkgHwIykmVJj/iP6b8mrS
         oiVZKSn89b9Mf4QE1ZwcjUtS1qhp3nzLdOQU907eY4n3ciebJ/ptaLCsxrKfO4uLwWhu
         w3BpQK2ifXS09WYF+B2taaIjK27EagXeEP606q3Z0x7qTZq1MS+dG3kSSsXyT0u4F60A
         CME/M+b+Lkv5TescW70hBpxw4iwHAc4yIeqfx8dcBa3JqyQJkSGSUtCqN8mQrQdVyMrf
         vqbA==
X-Gm-Message-State: AOAM532LskvW50cvrZy1NO+of2KaLfDnGXnQAU7aYIpjpqm4d7Jl7Kix
        0Y6W/pAGlMUYRQj6jsjaxAnGrqTcdC6PYQ==
X-Google-Smtp-Source: ABdhPJwBIaXef/tEui+TOYaLAsav+BgIvyBQIyRvhutgluQotb5jEVONp6I43z5A0+6UPgrVnek+iA==
X-Received: by 2002:a05:6808:1ce:b0:325:7a0c:b315 with SMTP id x14-20020a05680801ce00b003257a0cb315mr2346533oic.40.1652275192877;
        Wed, 11 May 2022 06:19:52 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r9-20020a056870438900b000e92d5a54ffsm554131oah.26.2022.05.11.06.19.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 06:19:52 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <31fd924f-0b3e-a47b-1ee5-fd321c5f0f17@roeck-us.net>
Date:   Wed, 11 May 2022 06:19:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] watchdog: ts4800_wdt: Fix refcount leak in
 ts4800_wdt_probe
Content-Language: en-US
To:     Miaoqian Lin <linmq006@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Damien Riegel <damien.riegel@savoirfairelinux.com>,
        Rob Herring <robh@kernel.org>, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220511114203.47420-1-linmq006@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220511114203.47420-1-linmq006@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/22 04:42, Miaoqian Lin wrote:
> of_parse_phandle() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when done.
> Add  missing of_node_put() in some error paths.
> 
> Fixes: bf9006399939 ("watchdog: ts4800: add driver for TS-4800 watchdog")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/ts4800_wdt.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/ts4800_wdt.c b/drivers/watchdog/ts4800_wdt.c
> index c137ad2bd5c3..0ea554c7cda5 100644
> --- a/drivers/watchdog/ts4800_wdt.c
> +++ b/drivers/watchdog/ts4800_wdt.c
> @@ -125,13 +125,16 @@ static int ts4800_wdt_probe(struct platform_device *pdev)
>   	ret = of_property_read_u32_index(np, "syscon", 1, &reg);
>   	if (ret < 0) {
>   		dev_err(dev, "no offset in syscon\n");
> +		of_node_put(syscon_np);
>   		return ret;
>   	}
>   
>   	/* allocate memory for watchdog struct */
>   	wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
> -	if (!wdt)
> +	if (!wdt) {
> +		of_node_put(syscon_np);
>   		return -ENOMEM;
> +	}
>   
>   	/* set regmap and offset to know where to write */
>   	wdt->feed_offset = reg;

