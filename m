Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA088598D94
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 22:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236712AbiHRUPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 16:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345946AbiHRUPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 16:15:06 -0400
Received: from smtp.smtpout.orange.fr (smtp-18.smtpout.orange.fr [80.12.242.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F0113DE0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 13:14:53 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id OlujoUzUBXaJmOlujo7dck; Thu, 18 Aug 2022 22:14:51 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 18 Aug 2022 22:14:51 +0200
X-ME-IP: 90.11.190.129
Message-ID: <b4daf694-1188-a8f6-615f-7e416cef9be0@wanadoo.fr>
Date:   Thu, 18 Aug 2022 22:14:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] pwm: rockchip: Convert to use dev_err_probe()
Content-Language: en-GB
To:     zhaoxiao <zhaoxiao@uniontech.com>, thierry.reding@gmail.com,
        heiko@sntech.de
Cc:     u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220818075503.18442-1-zhaoxiao@uniontech.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220818075503.18442-1-zhaoxiao@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 18/08/2022 à 09:55, zhaoxiao a écrit :
> It's fine to call dev_err_probe() in ->probe() when error code is known.
> Convert the driver to use dev_err_probe().
> 
> Signed-off-by: zhaoxiao <zhaoxiao@uniontech.com>
> ---
>   v2: remove the %d in the message.
Hi,

You did more than that.

> 
>   drivers/pwm/pwm-rockchip.c | 10 +++-------
>   1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
> index f3647b317152..c6e088c1a6bf 100644
> --- a/drivers/pwm/pwm-rockchip.c
> +++ b/drivers/pwm/pwm-rockchip.c
> @@ -330,16 +330,12 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
>   
>   	if (IS_ERR(pc->pclk)) {
>   		ret = PTR_ERR(pc->pclk);
> -		if (ret != -EPROBE_DEFER)
> -			dev_err(&pdev->dev, "Can't get APB clk: %d\n", ret);
> -		return ret;
> +		return dev_err_probe(&pdev->dev, ret, "Can't get APB clk\n");
>   	}

You could use PTR_ERR(pc->pclk) directly. There is no need to assign it 
to 'ret'. This would simplify even further the code. ({} can be removed)


>   
>   	ret = clk_prepare_enable(pc->clk);
> -	if (ret) {
> -		dev_err(&pdev->dev, "Can't prepare enable PWM clk: %d\n", ret);
> -		return ret;
> -	}
> +	if (ret)
> +		dev_err_probe(&pdev->dev, ret, "Can't prepare enable PWM clk\n");

Is a 'return' before dev_err_probe() missing?

Before we were returning the error code, now we ignore it and continue.
If done on purpose, you should explain why in the commit log.


>   
>   	ret = clk_prepare_enable(pc->pclk);
>   	if (ret) {

Why just converting 2 dev_err() and leaving the other one in the probe 
untouched?

CJ
