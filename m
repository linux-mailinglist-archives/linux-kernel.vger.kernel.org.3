Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2C35505BC
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 17:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235024AbiFRP30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 11:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235449AbiFRP2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 11:28:13 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0461DB4BF;
        Sat, 18 Jun 2022 08:28:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2C26DCE02BE;
        Sat, 18 Jun 2022 15:28:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B478C3411A;
        Sat, 18 Jun 2022 15:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655566084;
        bh=BVsNfMePkIkcRLJKxWnrPVHIGrWk4Pmg3MuN5L6XZTI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YEdkot7sy/W+8Tns+DaPXCCEzI2fvdOGx22Bzu01XVJf8iNNbwtA36CP5KFedCT2A
         vVTeEbf4JQusT+4Q4NRqHAq+XE03j7Tw+129AY6547iNY6UlS3VKqQWGchghwPYtvZ
         BRVotCHJzS6k2YEJIlWppzi9XTEFpgcmp3hPdmyrVwJCKui6AXYrVbv2nquswlAeFK
         a9V1KPwMnsDbXiGicHxl9048UsoFRB+Dq6OjP4Sb0+1RFjaU0yJW2pxEw22pqYkV2t
         y80531VDnHD8aHXVWFE1aJRiFovycfJgh5G2Re1QIGj60TjuS5YXYCOJ26Z9e6XuOC
         ffXOolx148r3Q==
Date:   Sat, 18 Jun 2022 16:37:21 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Subject: Re: [PATCH v1 1/1] iio: dac: stm32-dac: Replace open coded
 str_enable_disable()
Message-ID: <20220618163721.1cef64c9@jic23-huawei>
In-Reply-To: <20220616220023.9894-1-andriy.shevchenko@linux.intel.com>
References: <20220616220023.9894-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jun 2022 01:00:23 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Replace open coded str_enable_disable() in error message in
> stm32_dac_set_enable_state().
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
+CC Fabrice.

Looks good + harmless to me, so I'll pick it up now, but still time
for any additional feedback as I'll only push it out for 0-day to poke
at initially.

Applied to the togreg branch of iio.git.

Thanks,

Jonathan

> ---
>  drivers/iio/dac/stm32-dac.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/dac/stm32-dac.c b/drivers/iio/dac/stm32-dac.c
> index e842c15c674d..315d66648210 100644
> --- a/drivers/iio/dac/stm32-dac.c
> +++ b/drivers/iio/dac/stm32-dac.c
> @@ -14,6 +14,7 @@
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/string_helpers.h>
>  
>  #include "stm32-dac-core.h"
>  
> @@ -79,8 +80,7 @@ static int stm32_dac_set_enable_state(struct iio_dev *indio_dev, int ch,
>  	ret = regmap_update_bits(dac->common->regmap, STM32_DAC_CR, msk, en);
>  	mutex_unlock(&dac->lock);
>  	if (ret < 0) {
> -		dev_err(&indio_dev->dev, "%s failed\n", en ?
> -			"Enable" : "Disable");
> +		dev_err(&indio_dev->dev, "%s failed\n", str_enable_disable(en));
>  		goto err_put_pm;
>  	}
>  

