Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC6859BA45
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 09:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233265AbiHVH3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 03:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233136AbiHVH31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 03:29:27 -0400
Received: from smtp.smtpout.orange.fr (smtp-12.smtpout.orange.fr [80.12.242.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E542A401
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 00:29:26 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id Q1s6ofUmvLFqbQ1s6oZUKW; Mon, 22 Aug 2022 09:29:23 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 22 Aug 2022 09:29:23 +0200
X-ME-IP: 90.11.190.129
Message-ID: <66333c4d-8e8b-22a0-0c05-b72e2db2d3ca@wanadoo.fr>
Date:   Mon, 22 Aug 2022 09:29:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4] pwm: rockchip: Convert to use dev_err_probe()
Content-Language: en-US
To:     zhaoxiao <zhaoxiao@uniontech.com>, thierry.reding@gmail.com,
        heiko@sntech.de
Cc:     u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220819092627.19416-1-zhaoxiao@uniontech.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220819092627.19416-1-zhaoxiao@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 19/08/2022 à 11:26, zhaoxiao a écrit :
> It's fine to call dev_err_probe() in ->probe() when error code is known.
> Convert the driver to use dev_err_probe().

Hi, just a last comment below.

> 
> Signed-off-by: zhaoxiao <zhaoxiao@uniontech.com>
> ---
>   v4: add the missing dev_err function.
>   drivers/pwm/pwm-rockchip.c | 18 ++++++------------
>   1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
> index f3647b317152..e6ee14c6a159 100644
> --- a/drivers/pwm/pwm-rockchip.c
> +++ b/drivers/pwm/pwm-rockchip.c
> @@ -328,22 +328,16 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
>   	else
>   		pc->pclk = pc->clk;
>   
> -	if (IS_ERR(pc->pclk)) {
> -		ret = PTR_ERR(pc->pclk);
> -		if (ret != -EPROBE_DEFER)
> -			dev_err(&pdev->dev, "Can't get APB clk: %d\n", ret);
> -		return ret;
> -	}
> +	if (IS_ERR(pc->pclk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(pc->pclk), "Can't get APB clk\n");
>   
>   	ret = clk_prepare_enable(pc->clk);
> -	if (ret) {
> -		dev_err(&pdev->dev, "Can't prepare enable PWM clk: %d\n", ret);
> -		return ret;
> -	}
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "Can't prepare enable PWM clk\n");
>   
>   	ret = clk_prepare_enable(pc->pclk);
>   	if (ret) {
> -		dev_err(&pdev->dev, "Can't prepare enable APB clk: %d\n", ret);
> +		dev_err_probe(&pdev->dev, ret, "Can't prepare enable APB clk: %d\n", ret);

As in the previous patches, %d and the final ret are not needed. 
dev_err_probe() will already display an error code in a human readable way.

>   		goto err_clk;
>   	}
>   
> @@ -360,7 +354,7 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
>   
>   	ret = pwmchip_add(&pc->chip);
>   	if (ret < 0) {
> -		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
> +		dev_err_probe(&pdev->dev, ret, "pwmchip_add() failed: %d\n", ret);

Same here.

Otherwise, LGTM.

CJ

>   		goto err_pclk;
>   	}
>   

