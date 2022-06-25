Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C2055A94F
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 13:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbiFYLUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 07:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbiFYLUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 07:20:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD29D2559B;
        Sat, 25 Jun 2022 04:20:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7001DB80682;
        Sat, 25 Jun 2022 11:20:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0D28C3411C;
        Sat, 25 Jun 2022 11:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656156005;
        bh=tCAPE4B05AcXTXEs+jS/COSV5ldCKgSHLwp9pTpZBow=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uvGzDHNswO5rwpyKU23bhGleMde8GKR6wV4zmwYw9EhGRuSJc1i/OhEYBRsdP/Oiw
         M7HLUWSboDiwdfUwhtRUWmEK3MuvQpHC3wdtDrFchXFPzmVNlo5tSYZS8K4DwHLx4Y
         MnULGIUzNkPw+8NzLj9B5tUIjksgab+Wdw6kCfsa9uDh3NP089rrTVot1/B66n1l20
         WWnFxJpns6EflhVra92U37oRq94sYJiPiG12bOHyAG3QPHz32xSlNF7ESwHt05Pmex
         SZAxKaCFfdp9AP/r9fmXK3pC9e93vGgWb1eHAW8UqKU6aqGoHvTz/ovm8ivAgGUerD
         gdaSaNdcsthVQ==
Date:   Sat, 25 Jun 2022 12:29:31 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Kent Gustavsson <kent@minoris.se>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/10] iio: adc: mcp3911: correct
 "microchip,device-addr" property
Message-ID: <20220625122931.38a8001b@jic23-huawei>
In-Reply-To: <20220625103853.2470346-1-marcus.folkesson@gmail.com>
References: <20220625103853.2470346-1-marcus.folkesson@gmail.com>
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

On Sat, 25 Jun 2022 12:38:44 +0200
Marcus Folkesson <marcus.folkesson@gmail.com> wrote:

> Go for the right property name that is documented in the bindings.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Hi Marcus,

Series with more than 1 or 2 patches should always have a cover letter
(git format-patch --cover-letter) to provide some overview information
and allow for general comments on the series.

Also, whilst I know you are keen to move forwards quickly it is usually
a good idea to give more than 2 days for all reviews to come in on a series
and discussion of any questions to finish.

For instance, I just replied to your question to Andy on patch 2 and
that basically says your patch 2 in v2 is taking the wrong approach.
If you'd waited a few more days you'd have save on the noise by resolving
that before sending more patches.

Thanks,

Jonathan


> ---
> 
> Notes:
>     v2:
>         - Fallback to "device-addr" due to compatibility (Andy Shevchenko)
> 
>  drivers/iio/adc/mcp3911.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
> index 1cb4590fe412..c5a0f19d7834 100644
> --- a/drivers/iio/adc/mcp3911.c
> +++ b/drivers/iio/adc/mcp3911.c
> @@ -208,7 +208,13 @@ static int mcp3911_config(struct mcp3911 *adc)
>  	u32 configreg;
>  	int ret;
>  
> -	device_property_read_u32(dev, "device-addr", &adc->dev_addr);
> +	ret = device_property_read_u32(dev, "microchip,device-addr", &adc->dev_addr);
> +
> +	/* Fallback to "device-addr" due to historical mismatch between
> +	 * dt-bindings and implementation
> +	 */
> +	if (ret)
> +		device_property_read_u32(dev, "device-addr", &adc->dev_addr);
>  	if (adc->dev_addr > 3) {
>  		dev_err(&adc->spi->dev,
>  			"invalid device address (%i). Must be in range 0-3.\n",

