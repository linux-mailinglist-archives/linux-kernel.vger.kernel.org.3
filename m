Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C90565A3729
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 13:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233427AbiH0LHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 07:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232814AbiH0LHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 07:07:32 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6B39FAB5;
        Sat, 27 Aug 2022 04:07:30 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id w19so7322056ejc.7;
        Sat, 27 Aug 2022 04:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=YTgnpIcAQhmjoJuO42KDhHQ8kYtmp+eevQhLrui+w8Q=;
        b=kt3XpQBdk1XAcVUk34LwN7ngG9w4tNv1eBUgC+CnrocH+fLz8rubN2MZQjE5+VRDba
         SbZ+LzycyTE4GfUmo8xgLRKZ1NhxIPC3+AASH1znADe2cM4iUp1CP/9+o2/TD/RV+hBU
         XwpyS3sf7w0qUOo7VbMkiUlLUKkPTN/KGdRWfFJbRMNMkCJTCti4BOV9JsdychxKI6XQ
         T/DHFUW+LzjJr4fI+jy3JZ22nnRu45BWtco54nUL1Zk9aNlv0p5daSz7MRBMT6IaLdlK
         /tCjJTEAm916Dhqvwh9i4/cjJUtCax9UEb7Teoyd9nQ/C3tPRq1VAtsWouPpeACCBt2P
         K16A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=YTgnpIcAQhmjoJuO42KDhHQ8kYtmp+eevQhLrui+w8Q=;
        b=AuIotd+/5jxlQUOjG3kYNdf4syInZPhhKo/UPCS5qHxsj2Y49yFaRUWUgatzXlAW1N
         0QjvtUs2CkVCBqBr6gER41PyPto7uir9aixoDGyajbTNNAvxVo6pWHFJa1ZCt7efutOb
         4do64aXn61BNnG+ki/wuk/K+HqrXKRHqcwjEsg2lHCNYPBbpGx6+sZ9MiMw6z/zbqNFC
         1iF0WKA6EjiC/nwyce4le0NOxBOXD3rwXaX5+QNw7CL5YGSMrpYfT1jabXNOaEEYQzCP
         EBtIFZYlKhWMTs8P2prdGkktAUGE+zr9YBBGb2glvaWxjk0KqIjhTuXDnn2LBCBIYkyk
         fBvw==
X-Gm-Message-State: ACgBeo004E8VZDLpNRkM9zJIN4YbCt2mXLmgDfyJC5kDpT2XUI+Z9XlH
        facPQeFUeErykTBm1dWsq9SDXKV4DSbszg==
X-Google-Smtp-Source: AA6agR5P8TV0zWZJbZcKt9Vo9CX2rY644iX6DJK+nF8WzC0wK6vMjLAy6F3i8u48GlLurFO/vD8k9g==
X-Received: by 2002:a17:907:7625:b0:73d:6593:6562 with SMTP id jy5-20020a170907762500b0073d65936562mr7835903ejc.505.1661598449106;
        Sat, 27 Aug 2022 04:07:29 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id es5-20020a056402380500b0043bc4b28464sm2521426edb.34.2022.08.27.04.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Aug 2022 04:07:28 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        Yang Yingliang <yangyingliang@huawei.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, wens@csie.org
Subject: Re: [PATCH -next 2/3] clk: sunxi-ng: ccu-sun9i-a80-de: Use dev_err_probe() helper
Date:   Sat, 27 Aug 2022 13:07:27 +0200
Message-ID: <4427774.LvFx2qVVIh@jernej-laptop>
In-Reply-To: <20220827094151.3323450-2-yangyingliang@huawei.com>
References: <20220827094151.3323450-1-yangyingliang@huawei.com> <20220827094151.3323450-2-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sobota, 27. avgust 2022 ob 11:41:50 CEST je Yang Yingliang napisal(a):
> dev_err() can be replace with dev_err_probe() which will check if error
> code is -EPROBE_DEFER.
> 
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  drivers/clk/sunxi-ng/ccu-sun9i-a80-de.c | 19 ++++++-------------
>  1 file changed, 6 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/clk/sunxi-ng/ccu-sun9i-a80-de.c
> b/drivers/clk/sunxi-ng/ccu-sun9i-a80-de.c index f2fe0e1cc3c0..1d8b1ae1619d
> 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun9i-a80-de.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun9i-a80-de.c
> @@ -213,21 +213,14 @@ static int sun9i_a80_de_clk_probe(struct
> platform_device *pdev) return PTR_ERR(reg);
> 
>  	bus_clk = devm_clk_get(&pdev->dev, "bus");
> -	if (IS_ERR(bus_clk)) {
> -		ret = PTR_ERR(bus_clk);
> -		if (ret != -EPROBE_DEFER)
> -			dev_err(&pdev->dev, "Couldn't get bus clk: 
%d\n", ret);
> -		return ret;
> -	}
> +	if (IS_ERR(bus_clk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(bus_clk),
> +				     "Couldn't get bus clk\n");
> 
>  	rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
> -	if (IS_ERR(rstc)) {
> -		ret = PTR_ERR(rstc);
> -		if (ret != -EPROBE_DEFER)
> -			dev_err(&pdev->dev,
> -				"Couldn't get reset control: 
%d\n", ret);
> -		return ret;
> -	}
> +	if (IS_ERR(rstc))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(rstc),
> +				     "Couldn't get reset 
control\n");
> 
>  	/* The bus clock needs to be enabled for us to access the 
registers */
>  	ret = clk_prepare_enable(bus_clk);




