Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B06E513B81
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 20:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350897AbiD1S2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 14:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348944AbiD1S2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 14:28:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0965FB7C78;
        Thu, 28 Apr 2022 11:24:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 975546175C;
        Thu, 28 Apr 2022 18:24:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78E50C385A9;
        Thu, 28 Apr 2022 18:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651170293;
        bh=JXRHqXGYhAN3qdh93Rjj4pMQrePTMavErqL2y6eIzws=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YQrU1JHRjIWCkra4lxvDexdfa9qtNic2BsHyXxU6j8u49pwBATTGd4HxWgEvzYSig
         CXHPqaP3RhrfMChRdLXuVJT6cRdmhZWuqVNjSacAYsxIwGeA4uhXT1FlhdVQzD0zE6
         Z4S/O7zAPPh+pA5XqwZEZh0WhNaOhIRCRXB4IwCEC8kIviRtVFX9YzZuTz8HDAJjMb
         Uq3kcuLbZlVtQG7gpMYmXTsRzQJdgBMNmwtJQCJwV+F6ShOXgMz0IrmulqVJkj0lmu
         JEL6yZ6upitM4TjwGyFMmaC2OL3lFGVZlrGNyYVdzeJjNQtAIio1bwYCo4MOxgA+lo
         zJ235mQbq24og==
Date:   Thu, 28 Apr 2022 19:33:04 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Subject: Re: [PATCH v1 1/1] iio: trigger: stm32-lptimer-trigger: Make use of
 device properties
Message-ID: <20220428193304.016c46a3@jic23-huawei>
In-Reply-To: <20220413185656.21994-1-andriy.shevchenko@linux.intel.com>
References: <20220413185656.21994-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Apr 2022 21:56:56 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Convert the module to be property provider agnostic and allow
> it to be used on non-OF platforms.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

MAINTAINERS entry for this one uses extensive wild cards so may
escape scripts...

+CC Fabrice.

> ---
>  drivers/iio/trigger/stm32-lptimer-trigger.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/trigger/stm32-lptimer-trigger.c b/drivers/iio/trigger/stm32-lptimer-trigger.c
> index 98cdc7e47f3d..af46c10cea92 100644
> --- a/drivers/iio/trigger/stm32-lptimer-trigger.c
> +++ b/drivers/iio/trigger/stm32-lptimer-trigger.c
> @@ -13,6 +13,7 @@
>  #include <linux/mfd/stm32-lptimer.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> +#include <linux/property.h>
>  
>  /* List Low-Power Timer triggers */
>  static const char * const stm32_lptim_triggers[] = {
> @@ -77,7 +78,7 @@ static int stm32_lptim_trigger_probe(struct platform_device *pdev)
>  	if (!priv)
>  		return -ENOMEM;
>  
> -	if (of_property_read_u32(pdev->dev.of_node, "reg", &index))
> +	if (device_property_read_u32(&pdev->dev, "reg", &index))
>  		return -EINVAL;
>  
>  	if (index >= ARRAY_SIZE(stm32_lptim_triggers))

