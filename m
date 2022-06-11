Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B9454731F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 11:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbiFKJUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 05:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiFKJUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 05:20:22 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA216205EE
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 02:20:19 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id a15so1367920wrh.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 02:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=SN97VSJ1ccdaEz1KGuxxY4a0gyyHuUYZhfE4f2SEekI=;
        b=S4DZUmlE5di6YR+DIoUPQ2ra/KrGSonq34VzOmzlnMhnJ/HxCDBB68C8ftHGJHzwpl
         ZnkzQYPD3yYx9aij7Tjx83Zi6b8LbA+G007vdFsANw+kvjwuN5REGSdx9YCPnAhmROKA
         lrlSy34tfbKpOPTv8g/e4gxOivAwh9+midL5kcBmzjxVmRhaG/bWaJ54Zhs3ETeeE/7T
         qjyR8+VK4pjaAv895bKEbHQFdN2E4b0h27o8K/Od9CQj/89/m7SD3DLDQLvhTW1DsP95
         GeWzuds6Allhjh8Ks5c/BPdJdk8MGxEXZseC7QutKINlRk7WKAdR5P4yE0mwI20SNSDf
         Mneg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SN97VSJ1ccdaEz1KGuxxY4a0gyyHuUYZhfE4f2SEekI=;
        b=tJkpBkupZ/xXKVxKNakOSse0PkfeisNphASQhlGVmAZGhJvIY2LJMfNPigE1VYHh2Z
         xyr86ZKMsiPWKE89++X+KCZMrTooD6RX86jv8Yn3u/fESKC11anubx9iFO/+ryE9V8a4
         U2UdFvmp8k8gTls0Wyly0gy7QGghIkIuWN2cHKPo/BIcF311b+PnOwlgKEfsg0jaIH9T
         VdVJ2gpgvzVxz/sZIC8mtq7NVHrjBF8Br6e7I39BUWHCiGiN0PHm4rX+r04rt9oagyXx
         RGg1XJEaSm+iF54jq4cb362CETD9VsfvK160mhoYo/gcRAWbVdwav8eRr13L8FKqgU6S
         ISGQ==
X-Gm-Message-State: AOAM533IqVsY/d3YeyXYhrP07Nsy3pF8bT05ArjOpcJ+5Y6rgCRlzg2v
        pae19g8COegTz65sUQzcc/ZGWQ==
X-Google-Smtp-Source: ABdhPJyRht1sUkgMy4Z++odCZ2gsBir+F4UaeNv5bYzwGOOPas4d2NSfZ359qCB4ZMWqCE1OFKkt7w==
X-Received: by 2002:a5d:4f92:0:b0:214:c773:d615 with SMTP id d18-20020a5d4f92000000b00214c773d615mr41098127wru.525.1654939217948;
        Sat, 11 Jun 2022 02:20:17 -0700 (PDT)
Received: from [192.168.2.222] ([51.37.234.167])
        by smtp.gmail.com with ESMTPSA id p14-20020a5d48ce000000b002183cedbf34sm1949282wrs.73.2022.06.11.02.20.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jun 2022 02:20:17 -0700 (PDT)
Message-ID: <50540bda-ffaa-1141-b077-197ac64fcdd1@conchuod.ie>
Date:   Sat, 11 Jun 2022 10:20:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] spi: microchip-core: Fix the error handling path in
 mchp_corespi_probe()
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Conor Dooley <conor.dooley@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Daire McNamara <daire.mcnamara@microchip.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Lewis Hanly <lewis.hanly@microchip.com>,
        linux-riscv@lists.infradead.org, linux-spi@vger.kernel.org
References: <a90bec10dec43719b12afdb967e87526c4bc849a.1654933052.git.christophe.jaillet@wanadoo.fr>
From:   Conor Dooley <mail@conchuod.ie>
In-Reply-To: <a90bec10dec43719b12afdb967e87526c4bc849a.1654933052.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/06/2022 08:37, Christophe JAILLET wrote:
> clk_prepare_enable() is called instead of clk_disable_unprepare() in the
> error handling path of the probe function.
> 
> Change the function that is called so that resources are released
> correctly.
> 
> Fixes: 9ac8d17694b6 ("spi: add support for microchip fpga spi controllers")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Hey Christophe,
Peng Wu already sent a patch for this, but thanks for trying
to clean up after me anyway.
Thanks,
Conor.

> ---
>  drivers/spi/spi-microchip-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-microchip-core.c b/drivers/spi/spi-microchip-core.c
> index 5b2aee30fa04..bf6847d95fe3 100644
> --- a/drivers/spi/spi-microchip-core.c
> +++ b/drivers/spi/spi-microchip-core.c
> @@ -580,7 +580,7 @@ static int mchp_corespi_probe(struct platform_device *pdev)
>  
>  error_release_hardware:
>  	mchp_corespi_disable(spi);
> -	clk_prepare_enable(spi->clk);
> +	clk_disable_unprepare(spi->clk);
>  error_release_master:
>  	spi_master_put(master);
>  
