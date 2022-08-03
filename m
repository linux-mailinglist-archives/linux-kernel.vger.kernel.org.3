Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C88588BF5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 14:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237863AbiHCMZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 08:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236468AbiHCMZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 08:25:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269F16309;
        Wed,  3 Aug 2022 05:25:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C766EB82256;
        Wed,  3 Aug 2022 12:25:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0384AC433C1;
        Wed,  3 Aug 2022 12:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659529528;
        bh=KBxUEvbgFw8DXqQSgEcViomJraxgciK5S7Dm84Ftw2o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Goc3bsN27al2y8i7OBaNeuuMPi1lsellMNVW6KcqEnFhlA8H5+zXvwVIwl9W+zm6u
         gPqlJB6gMDDsFWH7VEdjdEKZmS2vNqPexojlSe9SPe4U9mK24i9pjtn94xCJEgngRm
         U2PmuYNKAZX2F4rm6YCQ+Adn37EpbUrzd+rCePK2rIqTdLIjSyx7SKXMEFKXAMvUAJ
         l4hSNBLt9SEe3HWTmOyD+zlJ7Wywi4iWl/g0oDLFQxQIHAy8safzQ3fF9B4aAZnrNK
         VzqsIQsVhhbqvslhGxOQaanOD8xAr8NlFKzaRDuSW5TbuNjq+aqzlE2o8XbQI7c77x
         WYnRZgV63VAWg==
Date:   Wed, 3 Aug 2022 17:55:24 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: Re: [PATCH] crypto: qcom-rng - Fix qcom_rng_of_match unused warning
Message-ID: <YuppNF2+MYs9V84j@matsya>
References: <202207240830.NxaVYPVM-lkp@intel.com>
 <YuOp49dCARTVQ+c+@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuOp49dCARTVQ+c+@gondor.apana.org.au>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-07-22, 17:35, Herbert Xu wrote:
> On Sun, Jul 24, 2022 at 08:12:39AM +0800, kernel test robot wrote:
> >
> > >> drivers/crypto/qcom-rng.c:190:34: warning: 'qcom_rng_of_match' defined but not used [-Wunused-const-variable=]
> >      190 | static const struct of_device_id qcom_rng_of_match[] = {
> >          |                                  ^~~~~~~~~~~~~~~~~
> 
> ---8<---
> Module device tables need to be declared as maybe_unused because
> they will be unused when built-in and the corresponding option is
> also disabled.
> 
> This patch adds the maybe_unused attributes to OF and ACPI.  This
> also allows us to remove the ifdef around the ACPI data structure.

Reviewed-by: Vinod Koul <vkoul@kernel.org>

> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> 
> diff --git a/drivers/crypto/qcom-rng.c b/drivers/crypto/qcom-rng.c
> index 031b5f701a0a..72dd1a4ebac4 100644
> --- a/drivers/crypto/qcom-rng.c
> +++ b/drivers/crypto/qcom-rng.c
> @@ -9,6 +9,7 @@
>  #include <linux/crypto.h>
>  #include <linux/io.h>
>  #include <linux/iopoll.h>
> +#include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> @@ -201,15 +202,13 @@ static int qcom_rng_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -#if IS_ENABLED(CONFIG_ACPI)
> -static const struct acpi_device_id qcom_rng_acpi_match[] = {
> +static const struct acpi_device_id __maybe_unused qcom_rng_acpi_match[] = {
>  	{ .id = "QCOM8160", .driver_data = 1 },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(acpi, qcom_rng_acpi_match);
> -#endif
>  
> -static const struct of_device_id qcom_rng_of_match[] = {
> +static const struct of_device_id __maybe_unused qcom_rng_of_match[] = {
>  	{ .compatible = "qcom,prng", .data = (void *)0},
>  	{ .compatible = "qcom,prng-ee", .data = (void *)1},
>  	{}
> -- 
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

-- 
~Vinod
