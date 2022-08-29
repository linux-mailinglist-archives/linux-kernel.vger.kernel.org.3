Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E275A49B1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 13:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbiH2L2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 07:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbiH2L0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 07:26:25 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67BE778229;
        Mon, 29 Aug 2022 04:16:16 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id h204-20020a1c21d5000000b003a5b467c3abso7978421wmh.5;
        Mon, 29 Aug 2022 04:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=lOhpCObqWHdCARz2NDIqCtnDWiHAAEeM53JGliLfbVs=;
        b=lPGL8ZYWjAj7lle2UsdjAKp8K4qbyHtSf55Qa20c3HvaGTUBoTNNE3UbgpAQzUSdJ9
         ScCRoCdu1b/tozGYB49Vrh6y22+ltPQmKoFzXnjAP0eRt9MgOtyhCAd7/zptlTRSuZCi
         /ri+vo2WEQD3283UxpbIfrcLtUaV/d8oNSdkqRSM/2Ruya08cC9WnnUsE2ji6bI4u17V
         iN6gRKwKEXi6I/BhxBOFIJpsAtiYkn3Yz/OWGaHZy0sMIzQ56ise+n4dZwylixG3w9bK
         a8mB3KaYAA6kF4kPDdGk0WG25mg27N4E3Xn0ORxHPpWWRdkD2VR7Cl1HfkI0rrcyBWGb
         Q4gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=lOhpCObqWHdCARz2NDIqCtnDWiHAAEeM53JGliLfbVs=;
        b=uVGuddQaLjarwyT0/c2+NLbFIljYVkA9Vt5h/mWF6h78pM689TYO/D/c6Iz2wDJjXS
         AFkXSMNqn0YSeawmmxBL5mkSp1dkxNcecu7wzXfkUdFhXSYa6hWghWlZxOnjs5FtRfaz
         i4m48i4fLUAxA5pWQa6z2P1p5ltayL8Yacr9O1WIKuUXsXalwLBtyC3AeYga3RO+Ko+y
         1WWv2bVlYs6VNxulYQTS97uQsnucBSfbCv+dUiQ6Oawd+zoTMI4E5fx9r20Gg6aOhi+N
         AqGW97odEw4pCK9R79bXhpyCg3CCSAT/kkScZtFijUpYuT3r34O8UerANV4gJbxM90P6
         x4hg==
X-Gm-Message-State: ACgBeo2yndI7IDJfHWMrlY+C4YVT6VYVmXzJSvCbnIU8nJcd4T8VbLUc
        0x3qn+K5VMqfqO9G76suhUw=
X-Google-Smtp-Source: AA6agR4qShWVRNC4Kl1p705Z5ez+1h9e3xNpc5r4siUX0qgzgQ1wfjL7bmInQOMaCVIxez4Wdyz4KA==
X-Received: by 2002:a05:600c:198e:b0:3a5:d4a2:8896 with SMTP id t14-20020a05600c198e00b003a5d4a28896mr6318695wmq.140.1661771694406;
        Mon, 29 Aug 2022 04:14:54 -0700 (PDT)
Received: from [192.168.0.30] ([47.62.125.55])
        by smtp.gmail.com with ESMTPSA id n8-20020adff088000000b002258235bda3sm6624936wro.61.2022.08.29.04.14.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 04:14:53 -0700 (PDT)
Message-ID: <ae3523f9-6420-9413-30cf-ab6a081c8500@gmail.com>
Date:   Mon, 29 Aug 2022 13:14:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 2/4] spi: mt7621: Use the devm_clk_get_enabled() helper to
 simplify error handling
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        broonie@kernel.org, gregkh@linuxfoundation.org, neil@brown.name,
        blogic@openwrt.org
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <cover.1661599671.git.christophe.jaillet@wanadoo.fr>
 <05a7fd22719008c8a905d6328aa9548ce40f2a7a.1661599671.git.christophe.jaillet@wanadoo.fr>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <05a7fd22719008c8a905d6328aa9548ce40f2a7a.1661599671.git.christophe.jaillet@wanadoo.fr>
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
> The devm_clk_get_enabled() helper:
>     - calls devm_clk_get()
>     - calls clk_prepare_enable() and registers what is needed in order to
>       call clk_disable_unprepare() when needed, as a managed resource.
> 
> This helper is well suited for cases where the clock would be kept
> prepared or enabled for the whole lifetime of the driver.
> 
> This simplifies the error handling a lot.
> 
> The order between spi_unregister_controller() (in the remove function) and
> the clk_disable_unprepare() (now handle by a  managed resource) is kept
> the same.
> (see commit 46b5c4fb87ce ("spi: mt7621: Don't leak SPI master in probe
> error path") to see why it matters)
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
> The order with  devm_spi_release_controller() (which undoes
> devm_spi_alloc_master()) is reversed, but I don't think it is an issue.
> ---
>   drivers/spi/spi-mt7621.c | 14 +-------------
>   1 file changed, 1 insertion(+), 13 deletions(-)
> 
> diff --git a/drivers/spi/spi-mt7621.c b/drivers/spi/spi-mt7621.c
> index 351b0ef52bbc..2580b28042be 100644
> --- a/drivers/spi/spi-mt7621.c
> +++ b/drivers/spi/spi-mt7621.c
> @@ -327,7 +327,6 @@ static int mt7621_spi_probe(struct platform_device *pdev)
>   	struct spi_controller *master;
>   	struct mt7621_spi *rs;
>   	void __iomem *base;
> -	int status = 0;
>   	struct clk *clk;
>   	int ret;
>   
> @@ -339,19 +338,14 @@ static int mt7621_spi_probe(struct platform_device *pdev)
>   	if (IS_ERR(base))
>   		return PTR_ERR(base);
>   
> -	clk = devm_clk_get(&pdev->dev, NULL);
> +	clk = devm_clk_get_enabled(&pdev->dev, NULL);
>   	if (IS_ERR(clk))
>   		return dev_err_probe(&pdev->dev, PTR_ERR(clk),
>   				     "unable to get SYS clock\n");
>   
> -	status = clk_prepare_enable(clk);
> -	if (status)
> -		return status;
> -
>   	master = devm_spi_alloc_master(&pdev->dev, sizeof(*rs));
>   	if (!master) {
>   		dev_info(&pdev->dev, "master allocation failed\n");
> -		clk_disable_unprepare(clk);
>   		return -ENOMEM;
>   	}
>   
> @@ -376,13 +370,10 @@ static int mt7621_spi_probe(struct platform_device *pdev)
>   	ret = device_reset(&pdev->dev);
>   	if (ret) {
>   		dev_err(&pdev->dev, "SPI reset failed!\n");
> -		clk_disable_unprepare(clk);
>   		return ret;
>   	}
>   
>   	ret = spi_register_controller(master);
> -	if (ret)
> -		clk_disable_unprepare(clk);
>   
>   	return ret;
>   }
> @@ -390,13 +381,10 @@ static int mt7621_spi_probe(struct platform_device *pdev)
>   static int mt7621_spi_remove(struct platform_device *pdev)
>   {
>   	struct spi_controller *master;
> -	struct mt7621_spi *rs;
>   
>   	master = dev_get_drvdata(&pdev->dev);
> -	rs = spi_controller_get_devdata(master);
>   
>   	spi_unregister_controller(master);
> -	clk_disable_unprepare(rs->clk);
>   
>   	return 0;
>   }
