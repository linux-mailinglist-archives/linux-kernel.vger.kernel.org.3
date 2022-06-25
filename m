Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E71CF55A94A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 13:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232634AbiFYLRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 07:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbiFYLR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 07:17:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1527431DDA;
        Sat, 25 Jun 2022 04:17:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BA908B80819;
        Sat, 25 Jun 2022 11:17:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F47CC3411C;
        Sat, 25 Jun 2022 11:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656155843;
        bh=GF6if4jUJ+aAJLP7XEcfUSKNX9PxvOUmXSZ+E+xD8Hs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lczjRbs5+wi5/JjTDP2VbccjDnAMlU4wDQENHHvk/WJ7SIIg+rFRYpjy+93ff6DPh
         QRUTIrqOkV6yKLW2mFgwoxwdeaSi3iklgSNcJL/tFtzW7fwndv6LmtMcl+T0/0VAxj
         dMWVZX7wO8d4rXgLvBMMvh4UkT0gjdMgko+USK4iZrUmaNgTMbCbTst0eAE8jUyLph
         9ASToC4GGdnarbanj3F6czR2nLSaJVQWu4q7I/D70k39QcST+vxiSsgVN2iYHHVHqt
         me8If28e7lBLLn9MYsTe2f1M/rgqjO8CKvRGRiJOkgpM/My2ZjMiGGAlX2Gt+Hvp9J
         Q7tzYhxQySxZg==
Date:   Sat, 25 Jun 2022 12:26:50 +0100
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
Message-ID: <20220625122650.099fbba1@jic23-huawei>
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

Need a fixes tag so we know how far to back port this.

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
Multiline comment syntax should be

	/*
	 * Fallabck to "...
	 * dt-...
`	 */

> +	 * dt-bindings and implementation
> +	 */
> +	if (ret)
> +		device_property_read_u32(dev, "device-addr", &adc->dev_addr);
>  	if (adc->dev_addr > 3) {
>  		dev_err(&adc->spi->dev,
>  			"invalid device address (%i). Must be in range 0-3.\n",

