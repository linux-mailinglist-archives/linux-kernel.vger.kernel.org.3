Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A561E55A9AB
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 14:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbiFYMHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 08:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232912AbiFYMHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 08:07:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3EF2F3A3;
        Sat, 25 Jun 2022 05:07:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7A4A3B807E5;
        Sat, 25 Jun 2022 12:07:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 095DCC3411C;
        Sat, 25 Jun 2022 12:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656158822;
        bh=c/HExtt6iaHl6sZUIMWUGS2K9JmTJCeHiuTbLSzYhQk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=k5APQKQyhSShlihnRr0Ao+2uqzxkLufCeEM59SRoI5ebWumF/ef0kzcxv6sj98/VQ
         TbZZ8tCRjnsFim+eLwR2iz0Udl66BPD6itDjNEHo/mAyskg4dk3uOGN6v8YDk3atUe
         AoB6gyD1AmmnO/dZJ9XdocPloFfsX3nmw6dC34S7yXC8UqfBqBqbgMHndJHpwfR3vy
         2vGncEAQ5aSYtKzXY6BIuTyPRwg2ix1DJmqGryTxJZ6i5YikMYPO1JJsSmI309XCF+
         rzBBZmXFnLUwJnH0nqsLKwwFHfdoBvpXAphMJoKEuVfruVrRew+uR6C0njRPAFWptj
         1RtooT9ogW/bQ==
Date:   Sat, 25 Jun 2022 13:16:29 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Kent Gustavsson <kent@minoris.se>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/10] iio: adc: mcp3911: use correct formula for AD
 conversion
Message-ID: <20220625131629.16c226a5@jic23-huawei>
In-Reply-To: <20220625103853.2470346-7-marcus.folkesson@gmail.com>
References: <20220625103853.2470346-1-marcus.folkesson@gmail.com>
        <20220625103853.2470346-7-marcus.folkesson@gmail.com>
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

On Sat, 25 Jun 2022 12:38:50 +0200
Marcus Folkesson <marcus.folkesson@gmail.com> wrote:

> The ADC conversion is actually not rail-to-rail but with a factor 1.5.
> Make use of this factor when calculating actual voltage.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>

Fixes tag?  Also, fixes should be at the beginning of the patch set
to make it easier to backport them to stable kernels etc.

Otherwise looks good to me.

Thanks,

Jonathan


> ---
> 
> Notes:
>     v2:
>         - No changes
> 
>  drivers/iio/adc/mcp3911.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
> index 1469c12ebbb2..ede1ad97ed4d 100644
> --- a/drivers/iio/adc/mcp3911.c
> +++ b/drivers/iio/adc/mcp3911.c
> @@ -48,8 +48,8 @@
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
> @@ -178,11 +178,18 @@ static int mcp3911_read_raw(struct iio_dev *indio_dev,
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

