Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D17F5A4C33
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 14:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbiH2Mqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 08:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiH2Mq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 08:46:29 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7CDB2482;
        Mon, 29 Aug 2022 05:31:12 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id cu2so15425687ejb.0;
        Mon, 29 Aug 2022 05:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=bC2z2S0UwWbCBQWC61peReEpzfQqE30gd7vkm5v9A+Y=;
        b=TT8TUuHWP/Ind+i6ru55YUCFWkRSLo4/NeccX8TZMsM0K6Pw5Fb7RTvCqfWvHQ3xZw
         gz4rfqX6fE/rofQHoqIXEppjNGDW15/LDakiyY75YKaLMtMAuH+FFkyVodMb1EN1isee
         p6gr5ne2qN3XOeWRyyvuZt3YCIsy6HVQ6FSnzZ8leiR+STMIHg/i5kLT+xF3x1yuQPxp
         REOYMnWKyE2yQo8RhZ/9hDaRozzKjexoSMKsoxNm2KyVy0pTP62IptYVvSfJvWg7+4kn
         YVm3sjcaH/amZ5yGwDEvZ+1JBL3rzDX/lU9D5HSXvxPKhB6wx4rNfTf+U9qnTBtCBMN2
         /nwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=bC2z2S0UwWbCBQWC61peReEpzfQqE30gd7vkm5v9A+Y=;
        b=HDpjpdRlFrZjurEfyPOT8BElrlMvX9a6DZhpBUNxEvuvicoUWgezMOY0Iphl5/b8kG
         2N3w7JinGVTJVk5SdjN5JJdALb5WciOT86DpQPqTWL1ffHCaWIcM17bjUPVKPuqDbu3P
         Ng6J8uWON9GUKTS10fLpxQwtWM/dPivQRezXmcHC6SvHJgIPAhw1Oz33B6R4/qjBBPMZ
         7gXdRoTGiUOpy6e/snCmlbH0fwFwgOUfvgGWTjfG1hUn9aZJiporr2U6rieXNlwtC6QH
         wgHxI8xiQwzu3MMK+wXvb0WO6dazW7vl5J9Crlbe1cPR+JF1Uae7ggl87ZdbdGso2w/t
         X4uw==
X-Gm-Message-State: ACgBeo1Q9q/RvKGfiuQ0aqoFPS5SOj6VwFQGmOH2AO1qcVvjIWFLPpVw
        5II1hSsuCemsBwwLwLynf16AYCFc9z8=
X-Google-Smtp-Source: AA6agR7PSgMWNHrHKcWwOB6Urkzu6yVZIv/Yqowk8TuQVkdXc8snDh6sKeWbPumgi3r5vtLwp35CKg==
X-Received: by 2002:a5d:4302:0:b0:225:5303:39e5 with SMTP id h2-20020a5d4302000000b00225530339e5mr6193061wrq.380.1661771786388;
        Mon, 29 Aug 2022 04:16:26 -0700 (PDT)
Received: from [192.168.0.30] ([47.62.125.55])
        by smtp.gmail.com with ESMTPSA id h15-20020a5d548f000000b0020e6ce4dabdsm6660033wrv.103.2022.08.29.04.16.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 04:16:25 -0700 (PDT)
Message-ID: <8761d5a8-8044-3568-6ec9-30ea2ba30829@gmail.com>
Date:   Mon, 29 Aug 2022 13:16:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 3/4] spi: mt7621: Use devm_spi_register_controller()
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        broonie@kernel.org, gregkh@linuxfoundation.org, neil@brown.name,
        blogic@openwrt.org
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <cover.1661599671.git.christophe.jaillet@wanadoo.fr>
 <b7698e198acc998d99e7e7c895a2910f14f89443.1661599671.git.christophe.jaillet@wanadoo.fr>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <b7698e198acc998d99e7e7c895a2910f14f89443.1661599671.git.christophe.jaillet@wanadoo.fr>
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
> Now that clk_disable_unprepare(clk) is handled with a managed resource,
> we can use devm_spi_register_controller() and axe the .remove function.
> 
> The order between spi_unregister_controller() and clk_disable_unprepare()
> is still the same.
> (see commit 46b5c4fb87ce ("spi: mt7621: Don't leak SPI master in probe
> error path") to see why it matters)
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
> I guess that the dev_set_drvdata() in the probe can be removed as-well.
> But it is also harmless to leave it as-is.
> ---
>   drivers/spi/spi-mt7621.c | 16 +---------------
>   1 file changed, 1 insertion(+), 15 deletions(-)
> 
> diff --git a/drivers/spi/spi-mt7621.c b/drivers/spi/spi-mt7621.c
> index 2580b28042be..114f98dcae5e 100644
> --- a/drivers/spi/spi-mt7621.c
> +++ b/drivers/spi/spi-mt7621.c
> @@ -373,20 +373,7 @@ static int mt7621_spi_probe(struct platform_device *pdev)
>   		return ret;
>   	}
>   
> -	ret = spi_register_controller(master);
> -
> -	return ret;
> -}
> -
> -static int mt7621_spi_remove(struct platform_device *pdev)
> -{
> -	struct spi_controller *master;
> -
> -	master = dev_get_drvdata(&pdev->dev);
> -
> -	spi_unregister_controller(master);
> -
> -	return 0;
> +	return devm_spi_register_controller(&pdev->dev, master);
>   }
>   
>   MODULE_ALIAS("platform:" DRIVER_NAME);
> @@ -397,7 +384,6 @@ static struct platform_driver mt7621_spi_driver = {
>   		.of_match_table = mt7621_spi_match,
>   	},
>   	.probe = mt7621_spi_probe,
> -	.remove = mt7621_spi_remove,
>   };
>   
>   module_platform_driver(mt7621_spi_driver);
