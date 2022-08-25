Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE68D5A0569
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 02:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbiHYAyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 20:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiHYAy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 20:54:29 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11818E4EB;
        Wed, 24 Aug 2022 17:54:27 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VNAfI6D_1661388864;
Received: from 30.97.48.44(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VNAfI6D_1661388864)
          by smtp.aliyun-inc.com;
          Thu, 25 Aug 2022 08:54:25 +0800
Message-ID: <472ee15f-b89a-dc5a-548d-f2374f99dda0@linux.alibaba.com>
Date:   Thu, 25 Aug 2022 08:54:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] hwspinlock: sprd: Use devm_clk_get_enabled() helper
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-remoteproc@vger.kernel.org
References: <f962d22bfdbd09133d8923152133eeff9213dcee.1661324434.git.christophe.jaillet@wanadoo.fr>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <f962d22bfdbd09133d8923152133eeff9213dcee.1661324434.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/24/2022 3:55 PM, Christophe JAILLET wrote:
> The devm_clk_get_enabled() helper:
>     - calls devm_clk_get()
>     - calls clk_prepare_enable() and registers what is needed in order to
>       call clk_disable_unprepare() when needed, as a managed resource.
> 
> This simplifies the code, the error handling paths and avoid the need of
> a dedicated function used with devm_add_action_or_reset().
> 
> Based on my test with allyesconfig, this reduces the .o size from:
>     text	   data	    bss	    dec	    hex	filename
>     3423	   1528	      0	   4951	   1357	drivers/hwspinlock/sprd_hwspinlock.o
> down to:
>     3025	   1392	      0	   4417	   1141	drivers/hwspinlock/sprd_hwspinlock.o
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

LGTM. Thanks.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
> devm_clk_get_enabled() is new and is part of 6.0-rc1
> ---
>   drivers/hwspinlock/sprd_hwspinlock.c | 23 ++---------------------
>   1 file changed, 2 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/hwspinlock/sprd_hwspinlock.c b/drivers/hwspinlock/sprd_hwspinlock.c
> index 22e2ffb91743..cb37706f61be 100644
> --- a/drivers/hwspinlock/sprd_hwspinlock.c
> +++ b/drivers/hwspinlock/sprd_hwspinlock.c
> @@ -76,18 +76,11 @@ static const struct hwspinlock_ops sprd_hwspinlock_ops = {
>   	.relax = sprd_hwspinlock_relax,
>   };
>   
> -static void sprd_hwspinlock_disable(void *data)
> -{
> -	struct sprd_hwspinlock_dev *sprd_hwlock = data;
> -
> -	clk_disable_unprepare(sprd_hwlock->clk);
> -}
> -
>   static int sprd_hwspinlock_probe(struct platform_device *pdev)
>   {
>   	struct sprd_hwspinlock_dev *sprd_hwlock;
>   	struct hwspinlock *lock;
> -	int i, ret;
> +	int i;
>   
>   	if (!pdev->dev.of_node)
>   		return -ENODEV;
> @@ -102,24 +95,12 @@ static int sprd_hwspinlock_probe(struct platform_device *pdev)
>   	if (IS_ERR(sprd_hwlock->base))
>   		return PTR_ERR(sprd_hwlock->base);
>   
> -	sprd_hwlock->clk = devm_clk_get(&pdev->dev, "enable");
> +	sprd_hwlock->clk = devm_clk_get_enabled(&pdev->dev, "enable");
>   	if (IS_ERR(sprd_hwlock->clk)) {
>   		dev_err(&pdev->dev, "get hwspinlock clock failed!\n");
>   		return PTR_ERR(sprd_hwlock->clk);
>   	}
>   
> -	ret = clk_prepare_enable(sprd_hwlock->clk);
> -	if (ret)
> -		return ret;
> -
> -	ret = devm_add_action_or_reset(&pdev->dev, sprd_hwspinlock_disable,
> -				       sprd_hwlock);
> -	if (ret) {
> -		dev_err(&pdev->dev,
> -			"Failed to add hwspinlock disable action\n");
> -		return ret;
> -	}
> -
>   	/* set the hwspinlock to record user id to identify subsystems */
>   	writel(HWSPINLOCK_USER_BITS, sprd_hwlock->base + HWSPINLOCK_RECCTRL);
>   
