Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8095050DB14
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 10:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234516AbiDYI0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 04:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbiDYIZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 04:25:47 -0400
Received: from first.geanix.com (first.geanix.com [116.203.34.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B46E13DE0;
        Mon, 25 Apr 2022 01:22:37 -0700 (PDT)
Received: from Seans-MBP.hinnerup (unknown [185.17.218.86])
        by first.geanix.com (Postfix) with ESMTPSA id A74DA1243266;
        Mon, 25 Apr 2022 08:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1650874561; bh=zpyIMFNzUI8cZ+GpAKZh9PezH2X29eaTTMBolZ0ekmo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=IyXwGtRcBN7z0f8/jUgpgxTNma7fzj8RFmPhtigWEMwB77RqfxEcgvXnzOqrubUXI
         Yny419lcf2Qw1B7+RNwAuIQTx5v4Q/pt/N7gBnbcXX7wa4aWo5DxB7XDo1Eo5KMpJc
         yimxrmc7SmRpigT1yh/d4bxBwGG2+XU3g/52W58ym5/Ih0MpN0k4YPHtN5lTyHwlcn
         ffKIUzccfics3BXXQg+yiLy7CqFQbL1DEivhYyWw3C/R7SIB5v6E4Y+n9C6wmCmg6D
         DkELNwxssXOrhSXSYG51Xggq0kzpFdq+NavBxtEL76mp+grpapGqsyc0Dz4lBO6yO/
         6V0ESEr5ZvTEA==
Date:   Mon, 25 Apr 2022 10:16:01 +0200
From:   Sean Nyekjaer <sean@geanix.com>
To:     Peter Rosin <peda@axentia.se>
Cc:     linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: dac: ti-dac5571: add support for ti,dac121c081
Message-ID: <20220425081601.cs42eujnghzxnxgt@Seans-MBP.hinnerup>
References: <b657ebf9-e2e3-6d3f-e7e9-c660e860e54c@axentia.se>
 <6e63f598-ff54-6cb6-8c7d-83e9d6231af0@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6e63f598-ff54-6cb6-8c7d-83e9d6231af0@axentia.se>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 08:02:34AM +0200, Peter Rosin wrote:
> It fits right in as a single 12-bit DAC.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
Reviewed-by: Sean Nyekjaer <sean@geanix.com>
> ---
>  drivers/iio/dac/Kconfig      | 2 +-
>  drivers/iio/dac/ti-dac5571.c | 3 +++
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index c0bf0d84197f..d6248b188645 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -417,7 +417,7 @@ config TI_DAC5571
>  	help
>  	  Driver for the Texas Instruments
>  	  DAC5571, DAC6571, DAC7571, DAC5574, DAC6574, DAC7574, DAC5573,
> -	  DAC6573, DAC7573, DAC8571, DAC8574.
> +	  DAC6573, DAC7573, DAC8571, DAC8574, DAC121C081.
>  	  If compiled as a module, it will be called ti-dac5571.
> diff --git a/drivers/iio/dac/ti-dac5571.c b/drivers/iio/dac/ti-dac5571.c
> index 4a3b8d875518..ce542bd8b69e 100644
> --- a/drivers/iio/dac/ti-dac5571.c
> +++ b/drivers/iio/dac/ti-dac5571.c
> @@ -13,6 +13,7 @@
>   * https://www.ti.com/lit/ds/symlink/dac5573.pdf
>   * https://www.ti.com/lit/ds/symlink/dac6573.pdf
>   * https://www.ti.com/lit/ds/symlink/dac7573.pdf
> + * https://www.ti.com/lit/ds/symlink/dac121c081.pdf
>   */
>  #include <linux/iio/iio.h>
> @@ -394,6 +395,7 @@ static const struct of_device_id dac5571_of_id[] = {
>  	{.compatible = "ti,dac5573"},
>  	{.compatible = "ti,dac6573"},
>  	{.compatible = "ti,dac7573"},
> +	{.compatible = "ti,dac121c081"},
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, dac5571_of_id);
> @@ -408,6 +410,7 @@ static const struct i2c_device_id dac5571_id[] = {
>  	{"dac5573", quad_8bit},
>  	{"dac6573", quad_10bit},
>  	{"dac7573", quad_12bit},
> +	{"dac121c081", single_12bit},
>  	{}
>  };
>  MODULE_DEVICE_TABLE(i2c, dac5571_id);
> -- 
> 2.20.1
> 
