Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900C05A4B6C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 14:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiH2MS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 08:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbiH2MR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 08:17:57 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466E114D25;
        Mon, 29 Aug 2022 05:01:19 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id w19so4827952ljj.7;
        Mon, 29 Aug 2022 05:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=6Y6slmLiEStk3SAV5P2VBUiGfRCGd21AEadH/l3GXUg=;
        b=KLBfc+M/JLXURCR3AOZ3shzI4eXZOAoneqUu0gAJca1EcbP7U3snYwCyrFyj8zZ9Vs
         Z0q6ZvRwX76HwYowuMtf0QzxuAuxRE9d2nkGXLVO/x6jwhELI9bJTihTTvk+GM4CQ7pt
         q5NEJrQluBi6i7tpAgjVtYaSuafdrA3UJUZ47ZUnKivtkpxs3q7orVa7IJLfA6k0BCdG
         lGVsuX7uH1A1LWoiSMuMVfgbaWBX59//A4ryyxMnlCqZUdPXyhnadwx1dWhV8+yH3FKL
         14Tc3a2ob2TlXSwXAEVulvBTN6b8pbwrJYYcZNSUUL/1uNqs3xxDE9X3keYdMOMmeb65
         vytQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=6Y6slmLiEStk3SAV5P2VBUiGfRCGd21AEadH/l3GXUg=;
        b=QSlvFhykn9TBy6ZaZwhzSHgxq9/IN0euPsS4wCxHaWyYInfXs7Jut7NYFrbywgN2Q4
         CEec6YHWqrkTyvLrzoMmK1MI3WOuA8blT3dr74IsdpXUY26k5VHsXhEth7gAymUoWJjT
         qfZ5nPgo5Vh8llaPx8yg4djOCsjk42hqi3mabZ3HSmRuBfyXbA1WgY6NKcweSnF3DV1T
         ygL+PusifJ8AuieL6iPZqyndReqlk69ndgiG4kxMdojCU+AJ4b5aWIj0hG0Wyuzt5bcO
         2Ym7QyyuAFDpqP9CqpMEkYTpE53w7y7UdYPTb3SV/cX7e9IAwV799UjnvLqQnsgmgZ9a
         MICg==
X-Gm-Message-State: ACgBeo0LqDmPIv/E5INaiLO9MfQY3gjMrxH3NbOaG4GWsYUn6bOXD2Gs
        7KwPmr3hC+DElDwaff/YOuFeqZrYmt0=
X-Google-Smtp-Source: AA6agR7wUOBv831RR9vPXNVN1xlDyiMTFsmanmANwV+5egTSjVEgQmKduYuE3lZVG+8ZkGMeNnGbZQ==
X-Received: by 2002:adf:ed50:0:b0:225:4c37:5346 with SMTP id u16-20020adfed50000000b002254c375346mr6030765wro.207.1661771919256;
        Mon, 29 Aug 2022 04:18:39 -0700 (PDT)
Received: from [192.168.0.30] ([47.62.125.55])
        by smtp.gmail.com with ESMTPSA id j18-20020a05600c191200b003a5c1e916c8sm30268815wmq.1.2022.08.29.04.18.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 04:18:38 -0700 (PDT)
Message-ID: <a8c87417-f37e-7c7a-a4a4-c5a01118e7a8@gmail.com>
Date:   Mon, 29 Aug 2022 13:18:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 4/4] spi: mt7621: Remove 'clk' from 'struct mt7621_spi'
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        broonie@kernel.org, gregkh@linuxfoundation.org, neil@brown.name,
        blogic@openwrt.org
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <cover.1661599671.git.christophe.jaillet@wanadoo.fr>
 <76ed0ef91479498b9a2d5ef539f80851cffdb4ea.1661599671.git.christophe.jaillet@wanadoo.fr>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <76ed0ef91479498b9a2d5ef539f80851cffdb4ea.1661599671.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/08/2022 13:42, Christophe JAILLET wrote:
> The 'clk' field in 'struct mt7621_spi' is useless, remove it.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

IMHO should be part of patch 2/4.

Regards,
Matthias

> ---
>   drivers/spi/spi-mt7621.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/spi/spi-mt7621.c b/drivers/spi/spi-mt7621.c
> index 114f98dcae5e..c4cc8e2f85e2 100644
> --- a/drivers/spi/spi-mt7621.c
> +++ b/drivers/spi/spi-mt7621.c
> @@ -55,7 +55,6 @@ struct mt7621_spi {
>   	void __iomem		*base;
>   	unsigned int		sys_freq;
>   	unsigned int		speed;
> -	struct clk		*clk;
>   	int			pending_write;
>   };
>   
> @@ -361,9 +360,8 @@ static int mt7621_spi_probe(struct platform_device *pdev)
>   
>   	rs = spi_controller_get_devdata(master);
>   	rs->base = base;
> -	rs->clk = clk;
>   	rs->master = master;
> -	rs->sys_freq = clk_get_rate(rs->clk);
> +	rs->sys_freq = clk_get_rate(clk);
>   	rs->pending_write = 0;
>   	dev_info(&pdev->dev, "sys_freq: %u\n", rs->sys_freq);
>   
