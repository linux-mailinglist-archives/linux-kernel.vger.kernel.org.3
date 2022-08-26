Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECE55A20AC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 08:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237153AbiHZGKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 02:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiHZGKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 02:10:32 -0400
Received: from smtp.smtpout.orange.fr (smtp01.smtpout.orange.fr [80.12.242.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99BD82E9E4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 23:10:31 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id RSXzoogIBBDYDRSXzooGkT; Fri, 26 Aug 2022 08:10:29 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 26 Aug 2022 08:10:29 +0200
X-ME-IP: 90.11.190.129
Message-ID: <a2804b0d-01d3-c6f2-d681-bec104870408@wanadoo.fr>
Date:   Fri, 26 Aug 2022 08:10:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH -next] regulator: drivers: Remove unnecessary print
 function dev_err()
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>, tony@atomide.com
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
References: <20220825070438.128093-1-yang.lee@linux.alibaba.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220825070438.128093-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 25/08/2022 à 09:04, Yang Li a écrit :
> The print function dev_err() is redundant because
> platform_get_irq_byname() already prints an error.
> 
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=1986
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>   drivers/regulator/tps65219-regulator.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/regulator/tps65219-regulator.c b/drivers/regulator/tps65219-regulator.c
> index 7ba2594e437c..ab16e6665625 100644
> --- a/drivers/regulator/tps65219-regulator.c
> +++ b/drivers/regulator/tps65219-regulator.c
> @@ -363,11 +363,9 @@ static int tps65219_regulator_probe(struct platform_device *pdev)
>   		irq_type = &tps65219_regulator_irq_types[i];
>   
>   		irq = platform_get_irq_byname(pdev, irq_type->irq_name);
> -		if (irq < 0) {
> -			dev_err(tps->dev, "Failed to get IRQ %s: %d\n",
> -				irq_type->irq_name, irq);
> +		if (irq < 0)
>   			return -EINVAL;
> -		}
> +
>   		irq_data[i].dev = tps->dev;
>   		irq_data[i].type = irq_type;
>   

Hi,

just in case it has an importance, this is not exactly the same.
Previously, the error was related to 'pdev', now it is related to 'tps' 
and we have:
	'struct tps65219 *tps = dev_get_drvdata(pdev->dev.parent);'

I don't think it really matters, but just in case...

CJ
