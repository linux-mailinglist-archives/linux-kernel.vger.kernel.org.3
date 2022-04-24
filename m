Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371A750D3AD
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 18:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236057AbiDXQ4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 12:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236019AbiDXQ4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 12:56:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62BB30550;
        Sun, 24 Apr 2022 09:53:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6B49BB80EAE;
        Sun, 24 Apr 2022 16:53:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54B73C385A7;
        Sun, 24 Apr 2022 16:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650819221;
        bh=D+w4BgSyXQuDDH5Cn/FASs6D+s7VpvQ7sliY6knecQM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rt1P0mtHJme34JK/ebPbf8acP+t6jv55z0nITUJWtL/Xb3xoFiTZoyFZ+oSVrdurq
         WeUsRw7mmtuWxTLX97JJkAnIdZtHqIdNcoinCgHg//6mpDLjbgFMx3B/RvBEpdhkDa
         2KKkTx/6Ku8N9tIeix12R6DWEh/44mOhTq1p51L897cr6sf4qdUjW3lEfnwkTTCWzc
         Cfc2aF2EHcIaI4UQmXsyL9TgV+DVwHJU87hH5tgKhKmTCYE48wgHL/U3zOqfQ9Ve5C
         LuoxivDlYfWAxEtByVwAxEZF+fKNXyOGb/Vdn8/wnRIkndX2BKAj0wGsXdvXmK2SX7
         UO4tn83DUKAKA==
Date:   Sun, 24 Apr 2022 18:01:47 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cixi Geng <gengcixi@gmail.com>
Cc:     lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, orsonzhai@gmail.com,
        baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        yuming.zhu1@unisoc.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 3/7] iio: adc: Fine tune the scale calibration values
Message-ID: <20220424180147.02d3c8ca@jic23-huawei>
In-Reply-To: <20220419142458.884933-4-gengcixi@gmail.com>
References: <20220419142458.884933-1-gengcixi@gmail.com>
        <20220419142458.884933-4-gengcixi@gmail.com>
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

On Tue, 19 Apr 2022 22:24:54 +0800
Cixi Geng <gengcixi@gmail.com> wrote:

> From: Cixi Geng <cixi.geng1@unisoc.com>
> 
> Small adjustment the scale calibration value for the sc2731,
> use new name sc2731_[big|small]_scale_graph_calib, and remove
> the origin [big|small]_scale_graph_calib struct for unused.
> 
> Fixes: 8ba0dbfd07a35 (iio: adc: sc27xx: Add ADC scale calibration)
No blank line here.
> 
> Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
> ---
>  drivers/iio/adc/sc27xx_adc.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.c
> index aee076c8e2b1..24211d2a71b1 100644
> --- a/drivers/iio/adc/sc27xx_adc.c
> +++ b/drivers/iio/adc/sc27xx_adc.c
> @@ -103,14 +103,17 @@ static struct sc27xx_adc_linear_graph small_scale_graph = {
>  	100, 341,
>  };
>  
> -static const struct sc27xx_adc_linear_graph big_scale_graph_calib = {
> -	4200, 856,
> -	3600, 733,
> +/*
> + * Add the sc2731_[big|small]_scale_graph_calib for sc2731 pmic.
> + */

Why Add?

Given the variable naming conveys this anyway, I would drop the comment entirely.

> +static const struct sc27xx_adc_linear_graph sc2731_big_scale_graph_calib = {
> +	4200, 850,
> +	3600, 728,
>  };
>  
> -static const struct sc27xx_adc_linear_graph small_scale_graph_calib = {
> -	1000, 833,
> -	100, 80,
> +static const struct sc27xx_adc_linear_graph sc2731_small_scale_graph_calib = {
> +	1000, 838,
> +	100, 84,
>  };
>  
>  static int sc27xx_adc_get_calib_data(u32 calib_data, int calib_adc)
> @@ -130,11 +133,11 @@ static int sc27xx_adc_scale_calibration(struct sc27xx_adc_data *data,
>  	size_t len;
>  
>  	if (big_scale) {
> -		calib_graph = &big_scale_graph_calib;
> +		calib_graph = &sc2731_big_scale_graph_calib;
>  		graph = &big_scale_graph;
>  		cell_name = "big_scale_calib";
>  	} else {
> -		calib_graph = &small_scale_graph_calib;
> +		calib_graph = &sc2731_small_scale_graph_calib;
>  		graph = &small_scale_graph;
>  		cell_name = "small_scale_calib";
>  	}

