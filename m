Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F0D4E1C57
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 16:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245401AbiCTPrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 11:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233295AbiCTPrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 11:47:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7093EA80;
        Sun, 20 Mar 2022 08:45:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 383B461173;
        Sun, 20 Mar 2022 15:45:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 447F0C340E9;
        Sun, 20 Mar 2022 15:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647791137;
        bh=MnUF6wCu+lWH4VvXQgRyL0zXXsXRlGEixv7B9idCdm0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YzLjCxph/GMrA5ekbgxwc8rsNBuZRV/sZmdrQEqkUoskYOE6GeFek46EKOMDLzi6m
         2jfxaI/enLvin7gVW6JWUin2iwZsLCT4aYXTP+f7HwLHJNC0JkTOJfuv9KNgiy9uXO
         lfoAT0WBG6qoF76MZje/P8fI6S+IKcfqxCXdCyNdnfe0pORHN2aOWK/t/HZFWFo6/A
         J1krQ8yAFD2MFGZROh38QCYscasstEEzS+BEo3KSTFrDJyxvaWC/CGkmcZSjXla9Rb
         dB8a5IiS9uuoLn2VjHSIXJ4EaoFNxVMiGFi9JEFw/UH8sPVOigmeJ5qlmhBu4rsC0R
         LK3LXp4icorzQ==
Date:   Sun, 20 Mar 2022 15:52:59 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Colin Ian King <colin.king@intel.com>,
        Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH] iio: palmas: shut up warning about calibration mismatch
 (due to noise)
Message-ID: <20220320155259.0fc79dd3@jic23-huawei>
In-Reply-To: <1cee45bfc3fa2ab59dcc17242fb52468035360a1.1646743982.git.hns@goldelico.com>
References: <1cee45bfc3fa2ab59dcc17242fb52468035360a1.1646743982.git.hns@goldelico.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  8 Mar 2022 13:53:03 +0100
"H. Nikolaus Schaller" <hns@goldelico.com> wrote:

> Although technically checking for ADC values below 0 is correct,
> because they are outside of the calibration values, there is usually
> noise which spuriously fills the console log with error messages if
> calculated input voltage gets close to 0V.
> 
> Ignore small negative calculated values, but clamp them to 0.
> 
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
Hi.

Should we treat this as a fix or a cleanup?

I don't mind either way.

Jonathan


> ---
>  drivers/iio/adc/palmas_gpadc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_gpadc.c
> index f9c8385c72d3..bcfa6a7f6cb2 100644
> --- a/drivers/iio/adc/palmas_gpadc.c
> +++ b/drivers/iio/adc/palmas_gpadc.c
> @@ -376,7 +376,8 @@ static int palmas_gpadc_get_calibrated_code(struct palmas_gpadc *adc,
>  					adc->adc_info[adc_chan].gain_error;
>  
>  	if (val < 0) {
> -		dev_err(adc->dev, "Mismatch with calibration\n");
> +		if (val < -10)
> +			dev_err(adc->dev, "Mismatch with calibration var = %d\n", val);
>  		return 0;
>  	}
>  

