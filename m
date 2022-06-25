Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73CFD55A951
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 13:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232643AbiFYLVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 07:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbiFYLVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 07:21:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5162B25EA1;
        Sat, 25 Jun 2022 04:21:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6B32611BD;
        Sat, 25 Jun 2022 11:21:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DFC6C3411C;
        Sat, 25 Jun 2022 11:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656156071;
        bh=jts758vb4qnwO0h43mTFUgp8LuWd6wEdmuDOA8P+7OI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Fvpx5nKikCX0t4WACCyRIKMFM81YWwpflTM9Zul2WPnplCP/WLO+3YGyR6jZocxTN
         B2rWrckQoeTGkehBB2jgk8IOEMQtCTjDCCMtqm1qgOOsZTe+mLVi5ofKdkeg9Kfp5c
         +r9YRdLl/74Vi+RdYPiWVHXSC4LCC82ShJSEU/wkjigmh1Bp5kPgVYdpCzrmbugnXD
         beMHjkxlRabdJXD58FMNlfISAQtaqERBYgU8M36G8kWHAnG55V4Mj4HnIAJy/3Vjzt
         rhG5/TnyLXlxeOG31Nk1TGm3YEjaNyRgiKFWvO4vieR9DtfxYkk8PYMjL49jtyqiAP
         UvzqUGaTBGOQw==
Date:   Sat, 25 Jun 2022 12:30:37 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Kent Gustavsson <kent@minoris.se>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/10] iio: adc: mcp3911: use resource-managed
 version of iio_device_register
Message-ID: <20220625123037.0d907e4c@jic23-huawei>
In-Reply-To: <20220625103853.2470346-2-marcus.folkesson@gmail.com>
References: <20220625103853.2470346-1-marcus.folkesson@gmail.com>
        <20220625103853.2470346-2-marcus.folkesson@gmail.com>
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

On Sat, 25 Jun 2022 12:38:45 +0200
Marcus Folkesson <marcus.folkesson@gmail.com> wrote:

> Keep using managed resources as much as possible.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
See explanation on why this is wrong sent to the v1 version of this patch.

It's a fiddly and not always well understood area (here be dragons!).

Jonathan

> ---
> 
> Notes:
>     v2:
>         - No changes
> 
>  drivers/iio/adc/mcp3911.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
> index c5a0f19d7834..25a235cce56c 100644
> --- a/drivers/iio/adc/mcp3911.c
> +++ b/drivers/iio/adc/mcp3911.c
> @@ -312,7 +312,7 @@ static int mcp3911_probe(struct spi_device *spi)
>  
>  	mutex_init(&adc->lock);
>  
> -	ret = iio_device_register(indio_dev);
> +	ret = devm_iio_device_register(&adc->spi->dev, indio_dev);
>  	if (ret)
>  		goto clk_disable;
>  
> @@ -332,8 +332,6 @@ static void mcp3911_remove(struct spi_device *spi)
>  	struct iio_dev *indio_dev = spi_get_drvdata(spi);
>  	struct mcp3911 *adc = iio_priv(indio_dev);
>  
> -	iio_device_unregister(indio_dev);
> -
>  	clk_disable_unprepare(adc->clki);
>  	if (adc->vref)
>  		regulator_disable(adc->vref);

