Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4A6754AF27
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 13:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243367AbiFNLRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 07:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbiFNLRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 07:17:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D20220F7;
        Tue, 14 Jun 2022 04:17:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 63039B817D7;
        Tue, 14 Jun 2022 11:17:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F08E6C3411F;
        Tue, 14 Jun 2022 11:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655205429;
        bh=OLxdqz8v9c0jsmtShQ9ZLaEVr+VzqF9XJMhBZg7aA0s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XUX9WALMpQht+A2WyY/9Y0FRt3yAGu56w8ac6rFSzGJ85yg8dT6J3K6RDGfIB7XYP
         5HRj8Zqf13Q+sQpnfcdtNH98UD2JYWmX/Jb8tSk0vKQaMzCAs98x6RJzWCrUiIP1WS
         5UYokwEoFl4RnGKOl/XYv6G1l5hjU+Jv0ozicDBKLOU/1pRJXBsEcIX9pU6VUDZpmS
         BPOXW6DMtZ4LTYDZLXKIgeikFskqOIjZi7EJJjJzRbhD06VdjY4hs4B/rJWa7cw0B+
         j0DppMULkWDGui31JWKazA0hSoFKp7OaVzM6kBPz4vSnKrKqJ3BPNQAkaj/+Cm1K9X
         asz2bWB0wPX9g==
Date:   Tue, 14 Jun 2022 12:26:18 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: dac: cio-dac: Implement and utilize register
 structures
Message-ID: <20220614122618.68e2e9d1@jic23-huawei>
In-Reply-To: <44aec703753f930cceff448babd1c8e2959eebb0.1654118389.git.william.gray@linaro.org>
References: <cover.1654118389.git.william.gray@linaro.org>
        <44aec703753f930cceff448babd1c8e2959eebb0.1654118389.git.william.gray@linaro.org>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  6 Jun 2022 10:15:18 -0400
William Breathitt Gray <william.gray@linaro.org> wrote:

> Reduce magic numbers and improve code readability by implementing and
> utilizing named register data structures.
> 
> Signed-off-by: William Breathitt Gray <william.gray@linaro.org>

I'm unconvinced this one really helps readability seeing
as you are only indexing a straight forward array.

Simply using u16 __iomem *
would provide the main cleanup which is avoiding the indexing
via * 2.

Thanks,

Jonathan


> ---
>  drivers/iio/dac/cio-dac.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/dac/cio-dac.c b/drivers/iio/dac/cio-dac.c
> index 8080984dcb03..7860450ceaf3 100644
> --- a/drivers/iio/dac/cio-dac.c
> +++ b/drivers/iio/dac/cio-dac.c
> @@ -16,6 +16,7 @@
>  #include <linux/isa.h>
>  #include <linux/module.h>
>  #include <linux/moduleparam.h>
> +#include <linux/types.h>
>  
>  #define CIO_DAC_NUM_CHAN 16
>  
> @@ -34,14 +35,22 @@ static unsigned int num_cio_dac;
>  module_param_hw_array(base, uint, ioport, &num_cio_dac, 0);
>  MODULE_PARM_DESC(base, "Measurement Computing CIO-DAC base addresses");
>  
> +/**
> + * struct cio_dac_reg - device register structure
> + * @da:	D/A data
> + */
> +struct cio_dac_reg {
> +	u16 da[CIO_DAC_NUM_CHAN];
> +};
> +
>  /**
>   * struct cio_dac_iio - IIO device private data structure
>   * @chan_out_states:	channels' output states
> - * @base:		base port address of the IIO device
> + * @reg:		I/O address offset for the device registers
>   */
>  struct cio_dac_iio {
>  	int chan_out_states[CIO_DAC_NUM_CHAN];
> -	void __iomem *base;
> +	struct cio_dac_reg __iomem *reg;
>  };
>  
>  static int cio_dac_read_raw(struct iio_dev *indio_dev,
> @@ -61,7 +70,6 @@ static int cio_dac_write_raw(struct iio_dev *indio_dev,
>  	struct iio_chan_spec const *chan, int val, int val2, long mask)
>  {
>  	struct cio_dac_iio *const priv = iio_priv(indio_dev);
> -	const unsigned int chan_addr_offset = 2 * chan->channel;
>  
>  	if (mask != IIO_CHAN_INFO_RAW)
>  		return -EINVAL;
> @@ -71,7 +79,7 @@ static int cio_dac_write_raw(struct iio_dev *indio_dev,
>  		return -EINVAL;
>  
>  	priv->chan_out_states[chan->channel] = val;
> -	iowrite16(val, priv->base + chan_addr_offset);
> +	iowrite16(val, priv->reg->da + chan->channel);
>  
>  	return 0;
>  }
> @@ -106,8 +114,8 @@ static int cio_dac_probe(struct device *dev, unsigned int id)
>  	}
>  
>  	priv = iio_priv(indio_dev);
> -	priv->base = devm_ioport_map(dev, base[id], CIO_DAC_EXTENT);
> -	if (!priv->base)
> +	priv->reg = devm_ioport_map(dev, base[id], CIO_DAC_EXTENT);
> +	if (!priv->reg)
>  		return -ENOMEM;
>  
>  	indio_dev->info = &cio_dac_info;
> @@ -117,8 +125,8 @@ static int cio_dac_probe(struct device *dev, unsigned int id)
>  	indio_dev->name = dev_name(dev);
>  
>  	/* initialize DAC outputs to 0V */
> -	for (i = 0; i < 32; i += 2)
> -		iowrite16(0, priv->base + i);
> +	for (i = 0; i < CIO_DAC_NUM_CHAN; i++)
> +		iowrite16(0, priv->reg->da + i);
>  
>  	return devm_iio_device_register(dev, indio_dev);
>  }

