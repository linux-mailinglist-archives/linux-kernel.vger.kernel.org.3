Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9495B5969C1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 08:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238599AbiHQGnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 02:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232993AbiHQGne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 02:43:34 -0400
Received: from smtp.smtpout.orange.fr (smtp-26.smtpout.orange.fr [80.12.242.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1582D1CF
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 23:43:32 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id OClyoHRZ0g7y2OClyokcqD; Wed, 17 Aug 2022 08:43:30 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 17 Aug 2022 08:43:30 +0200
X-ME-IP: 90.11.190.129
Message-ID: <27846879-6660-26b3-5839-997b92cda6d2@wanadoo.fr>
Date:   Wed, 17 Aug 2022 08:43:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] pwm: rockchip: Convert to use dev_err_probe()
Content-Language: en-US
To:     zhaoxiao <zhaoxiao@uniontech.com>, thierry.reding@gmail.com,
        heiko@sntech.de
Cc:     u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220817055949.20497-1-zhaoxiao@uniontech.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220817055949.20497-1-zhaoxiao@uniontech.com>
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

Le 17/08/2022 à 07:59, zhaoxiao a écrit :
> It's fine to call dev_err_probe() in ->probe() when error code is known.
> Convert the driver to use dev_err_probe().
> 
> Signed-off-by: zhaoxiao <zhaoxiao@uniontech.com>
> ---
>   drivers/pwm/pwm-rockchip.c | 9 +++------
>   1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
> index f3647b317152..bd7ab37aaf88 100644
> --- a/drivers/pwm/pwm-rockchip.c
> +++ b/drivers/pwm/pwm-rockchip.c
> @@ -331,15 +331,12 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
>   	if (IS_ERR(pc->pclk)) {
>   		ret = PTR_ERR(pc->pclk);
>   		if (ret != -EPROBE_DEFER)
> -			dev_err(&pdev->dev, "Can't get APB clk: %d\n", ret);
> -		return ret;
> +			return dev_err_probe(&pdev->dev, ret, "Can't get APB clk: %d\n");

Hi,

Previously, if (ret != -EPROBE_DEFER), we were returning. Now we just 
ignore it and continue.
If done on purpose, you should explain why in the commit log.

My guess is that the test should also be removed. dev_err_probe() 
handles that for us.


You could use PTR_ERR(pc->pclk) directly. There is no need to assign it 
to ret. This would simplify even further the code.


You removed the last 'ret' parameter, which is fine, but left the %d in 
the message.
Compiling trigger the issue.
Please, ALWAYS, at least compile test your changes, even when things 
look obvious.


Look at the code around line 316 to see how it is done.

>   	}
>   
>   	ret = clk_prepare_enable(pc->clk);
> -	if (ret) {
> -		dev_err(&pdev->dev, "Can't prepare enable PWM clk: %d\n", ret);
> -		return ret;
> -	}
> +	if (ret)
> +		dev_err_probe(&pdev->dev, ret, "Can't prepare enable PWM clk: %d\n");

'return' before dev_err_probe() missing?

You removed the last 'ret' parameter, but left the %d in the message.
(same comment about compiling as above)

>   
>   	ret = clk_prepare_enable(pc->pclk);
>   	if (ret) {


Why just converting 2 dev_err() and leaving the other one in the probe 
untouched?

CJ
