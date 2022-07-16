Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD521577056
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 19:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbiGPRIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 13:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiGPRIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 13:08:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4019D60C4;
        Sat, 16 Jul 2022 10:08:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DF2C3B8091D;
        Sat, 16 Jul 2022 17:08:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 729C1C34114;
        Sat, 16 Jul 2022 17:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657991324;
        bh=ASWR+Lq+N6UVuyDWaltEqyzZDGZ5HbBCVAfKjT+dymI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=knjC/ltcnSsS4cycVnbMEGUjn8ya1X8LzhJRyjSQ0NSPNBYsvbClP/yNL3KgwhO7A
         FBOga+aqWE8Rcx7hdefJFHD74bkV4BT9W0gTVdMmwETGXMzd11nC0YsKQ5m3nrppzf
         yJZPumMnZ4TXsqRowYdiPgDbVYfagtOaa/m5axTQ22ABmFmYlG+g/Gess6yEbyrMsh
         UZJZY+fl1tg0h/XUoWK2sil0minNn3i6r85xCF539dJ78onmjeCos2flopNe4zbzVb
         3sagKg52ko3au5rlN/+RSVnp0ONafU9tR/SananWC6w2slYfmQvGYPrtX+ZXT/MfEz
         Vzz9xHaqQMAMA==
Date:   Sat, 16 Jul 2022 18:18:37 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Kent Gustavsson <kent@minoris.se>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/9] iio: adc: mcp3911: use correct formula for AD
 conversion
Message-ID: <20220716181837.4b0b8870@jic23-huawei>
In-Reply-To: <20220704172116.195841-4-marcus.folkesson@gmail.com>
References: <20220704172116.195841-1-marcus.folkesson@gmail.com>
        <20220704172116.195841-4-marcus.folkesson@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Mon,  4 Jul 2022 19:21:10 +0200
Marcus Folkesson <marcus.folkesson@gmail.com> wrote:

> The ADC conversion is actually not rail-to-rail but with a factor 1.5.
> Make use of this factor when calculating actual voltage.
> 
> Fixes: 3a89b289df5d ("iio: adc: add support for mcp3911")
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> Acked-by: Jonathan Cameron <jic23@kernel.org>
?  I doubt I gave a tag (mostly because I don't give tags to patches
I'll pick up and give a SoB on.

Note that tags have to be given explicitly in full form before you can
add them to a patch.  If in doubt (people often given handwavey responses)
then ask people to give an explicit tag.

Jonathan


> ---
>  drivers/iio/adc/mcp3911.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
> index f8875076ae80..890af7dca62d 100644
> --- a/drivers/iio/adc/mcp3911.c
> +++ b/drivers/iio/adc/mcp3911.c
> @@ -40,8 +40,8 @@
>  #define MCP3911_CHANNEL(x)		(MCP3911_REG_CHANNEL0 + x * 3)
>  #define MCP3911_OFFCAL(x)		(MCP3911_REG_OFFCAL_CH0 + x * 6)
>  
> -/* Internal voltage reference in uV */
> -#define MCP3911_INT_VREF_UV		1200000
> +/* Internal voltage reference in mV */
> +#define MCP3911_INT_VREF_MV		1200
>  
>  #define MCP3911_REG_READ(reg, id)	((((reg) << 1) | ((id) << 5) | (1 << 0)) & 0xff)
>  #define MCP3911_REG_WRITE(reg, id)	((((reg) << 1) | ((id) << 5) | (0 << 0)) & 0xff)
> @@ -139,11 +139,18 @@ static int mcp3911_read_raw(struct iio_dev *indio_dev,
>  
>  			*val = ret / 1000;
>  		} else {
> -			*val = MCP3911_INT_VREF_UV;
> +			*val = MCP3911_INT_VREF_MV;
>  		}
>  
> -		*val2 = 24;
> -		ret = IIO_VAL_FRACTIONAL_LOG2;
> +		/*
> +		 * For 24bit Conversion
> +		 * Raw = ((Voltage)/(Vref) * 2^23 * Gain * 1.5
> +		 * Voltage = Raw * (Vref)/(2^23 * Gain * 1.5)
> +		 */
> +
> +		/* val2 = (2^23 * 1.5) */
> +		*val2 = 12582912;
> +		ret = IIO_VAL_FRACTIONAL;
>  		break;
>  	}
>  

