Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C82A53AA7D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 17:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354950AbiFAPvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 11:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345870AbiFAPvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 11:51:06 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7269EA33B4;
        Wed,  1 Jun 2022 08:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654098665; x=1685634665;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=q/JCgQJMfniqm5NlBbmMmlvO36AzeXT/fGZ9D1AgbOc=;
  b=M+d+qdMUR2t5KUCW+J8/zD4RvGF5yyanIY7Qc2fQaYJNHOKhzfcwgQML
   FViIGKmz0UbxzDYn7282oFzt0LQ5lXSll6e0MEvMyB25EnjTE0Vp/YfN+
   dmmEpNO2IPTn37qxQEbaIMGwXZoLf9rJXh1g6JlegB+7DkBwvKmcj5HlY
   1esq4vS+d9zWa0lS3XAqcbt5mRMsOq26MuoCYNLFpzSXiG9iJPAqXotTA
   LpGOzGTP9QU8Bzc7//CgwmqQIKcF1QNs4DZ8+EwosoorRyBxvl5SWdx5k
   pbqZuG9iTU4x8v7TXDKMzx3X3BfT8gtZKDTmchtr+Ajv3HvYZA/fYym2Q
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="362007353"
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; 
   d="scan'208";a="362007353"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 08:51:04 -0700
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; 
   d="scan'208";a="756253891"
Received: from mpcolomb-cxt3.amr.corp.intel.com (HELO [10.212.136.29]) ([10.212.136.29])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 08:51:03 -0700
Message-ID: <e965160d-08d1-f148-6452-f759053e7e99@linux.intel.com>
Date:   Wed, 1 Jun 2022 08:51:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.8.1
Subject: Re: [PATCH v1 1/1] gpio: wcove: make irq_chip immutable
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
References: <20220601154833.2173-1-andriy.shevchenko@linux.intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20220601154833.2173-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/1/22 8:48 AM, Andy Shevchenko wrote:
> Since recently, the kernel is nagging about mutable irq_chips:
> 
>     "not an immutable chip, please consider fixing it!"
> 
> Drop the unneeded copy, flag it as IRQCHIP_IMMUTABLE, add the new
> helper functions and call the appropriate gpiolib functions.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Looks good to me

Reviewed-by: Kuppuswamy Sathyanarayanan 
<sathyanarayanan.kuppuswamy@linux.intel.com>

> ---
>   drivers/gpio/gpio-wcove.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-wcove.c b/drivers/gpio/gpio-wcove.c
> index 16a0fae1e32e..c18b6b47384f 100644
> --- a/drivers/gpio/gpio-wcove.c
> +++ b/drivers/gpio/gpio-wcove.c
> @@ -299,6 +299,8 @@ static void wcove_irq_unmask(struct irq_data *data)
>   	if (gpio >= WCOVE_GPIO_NUM)
>   		return;
>   
> +	gpiochip_enable_irq(chip, gpio);
> +
>   	wg->set_irq_mask = false;
>   	wg->update |= UPDATE_IRQ_MASK;
>   }
> @@ -314,15 +316,19 @@ static void wcove_irq_mask(struct irq_data *data)
>   
>   	wg->set_irq_mask = true;
>   	wg->update |= UPDATE_IRQ_MASK;
> +
> +	gpiochip_disable_irq(chip, gpio);
>   }
>   
> -static struct irq_chip wcove_irqchip = {
> +static const struct irq_chip wcove_irqchip = {
>   	.name			= "Whiskey Cove",
>   	.irq_mask		= wcove_irq_mask,
>   	.irq_unmask		= wcove_irq_unmask,
>   	.irq_set_type		= wcove_irq_type,
>   	.irq_bus_lock		= wcove_bus_lock,
>   	.irq_bus_sync_unlock	= wcove_bus_sync_unlock,
> +	.flags			= IRQCHIP_IMMUTABLE,
> +	GPIOCHIP_IRQ_RESOURCE_HELPERS,
>   };
>   
>   static irqreturn_t wcove_gpio_irq_handler(int irq, void *data)
> @@ -452,7 +458,7 @@ static int wcove_gpio_probe(struct platform_device *pdev)
>   	}
>   
>   	girq = &wg->chip.irq;
> -	girq->chip = &wcove_irqchip;
> +	gpio_irq_chip_set_chip(girq, &wcove_irqchip);
>   	/* This will let us handle the parent IRQ in the driver */
>   	girq->parent_handler = NULL;
>   	girq->num_parents = 0;

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
