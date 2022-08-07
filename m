Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 455EA58BB2E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 16:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233142AbiHGONz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 10:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiHGONw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 10:13:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76AFF65A6;
        Sun,  7 Aug 2022 07:13:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 155B160F11;
        Sun,  7 Aug 2022 14:13:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39A69C433C1;
        Sun,  7 Aug 2022 14:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659881630;
        bh=xMZq75Du6rS5lyJPiJ67r965UxA+2sRNdhec7Gf4viI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aBSXR+ObfXzeVSyIXSOsc0z/gDlkPtyKbhiOX3IL/hGQ2Xg8ikti5jkSkQOYmCxPN
         6W5QabnOziS2qpvacT11QGhDNTefDUfnvaMP4RhO4ZkeLddHeNZKYUlt0pFMPZWjcW
         ReXKoLCFRrqgH0eTeRzJliCBM0T9CVyYlOXVIWxI2j7GiaVyG/BHqyK8hGdWEjGs5F
         f+V9VVSp8qhu3LXfrdr9VBgfDhVxSDSi75645tV8fHuSVXonBuEPe2jBDK7Q+sM24n
         0kBpbSorrs2QoF0dm2N//tfZ+eNUQ/DG1+39DkkTqzSb+mBUfMXrrWZ/O3djtkb2qu
         L7eNEcSEjzwCA==
Date:   Sun, 7 Aug 2022 15:24:10 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Kent Gustavsson <kent@minoris.se>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/9] iio: adc: mcp3911: use correct formula for AD
 conversion
Message-ID: <20220807152410.01722574@jic23-huawei>
In-Reply-To: <20220722130726.7627-4-marcus.folkesson@gmail.com>
References: <20220722130726.7627-1-marcus.folkesson@gmail.com>
        <20220722130726.7627-4-marcus.folkesson@gmail.com>
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

On Fri, 22 Jul 2022 15:07:20 +0200
Marcus Folkesson <marcus.folkesson@gmail.com> wrote:

> The ADC conversion is actually not rail-to-rail but with a factor 1.5.
> Make use of this factor when calculating actual voltage.
> 
> Fixes: 3a89b289df5d ("iio: adc: add support for mcp3911")
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Patches 1-3 now applied to the fixes-togreg branch of iio.git
which is currently based on char-misc-linus which is at
Linus' tree just after he took the char-misc pull requests for
the merge window.  I might rebase this on rc1 once available
or I might just use the base as is.  Either way, it should be
fine in linux-next

Thanks,

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

