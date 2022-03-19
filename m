Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5EBE4DE931
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 17:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243580AbiCSQEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 12:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239355AbiCSQE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 12:04:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B23C1D12E0;
        Sat, 19 Mar 2022 09:03:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EB484B801BD;
        Sat, 19 Mar 2022 16:03:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 986DBC340EC;
        Sat, 19 Mar 2022 16:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647705784;
        bh=Pu/qEiTVIC3okv79NryBXfptx6zHCq81obKy2Cm9TOA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=F3Jg1Tz9gTmj4TvSUmUsc8tQh83eX6VUMbeEzET4DLEaVfsmVZ8FVaH3R2jEeU349
         MuC1YoM+6LSlXI0WBAo8Uht+eAbPQQTlswCagtcbN7wIVK1ENewcZhveI0DbsB+ZhK
         llA+0YEfKmo0cm6nUlvuZniOTMR0aLRIKjlAJG/37BiruIreTDzqzJpGY1u0hyB48G
         CHlxPoRIYUmajqmU/egZnLj9wAkLXerMCWwUcB7fpnVHaHZwDs6K+UA0MBiSMbz4vU
         g59JBORqaoDIRzxL8MzfhrwlIYuZdlGHPmrqzuaw30cAVANGi4w45hkr7U7Myez0E7
         hcYmu0WeSsXxg==
Date:   Sat, 19 Mar 2022 16:10:28 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     <alexandru.tachici@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 7/8] iio: adc: ad7124: add disable_all() callback
Message-ID: <20220319161028.4fac7672@jic23-huawei>
In-Reply-To: <20220318162722.51215-8-alexandru.tachici@analog.com>
References: <20220318162722.51215-1-alexandru.tachici@analog.com>
        <20220318162722.51215-8-alexandru.tachici@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Mar 2022 18:27:21 +0200
<alexandru.tachici@analog.com> wrote:

> From: Alexandru Tachici <alexandru.tachici@analog.com>
> 
> Add the disable all callback to the ad_sigma_delta_info struct.
> 
> Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>

I think patch 5 leaves a non working driver as this will be required
for slots > 1.  So squash this with patch 5.

> ---
>  drivers/iio/adc/ad7124.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> index 782b7cdd8ebe..3214079ff05f 100644
> --- a/drivers/iio/adc/ad7124.c
> +++ b/drivers/iio/adc/ad7124.c
> @@ -524,9 +524,25 @@ static int ad7124_append_status(struct ad_sigma_delta *sd, bool append)
>  	return ad_sd_write_reg(&st->sd, AD7124_ADC_CONTROL, 2, st->adc_control);
>  }
>  
> +static int ad7124_disable_all(struct ad_sigma_delta *sd)
> +{
> +	struct ad7124_state *st = container_of(sd, struct ad7124_state, sd);
> +	int ret;
> +	int i;
> +
> +	for (i = 0; i < st->num_channels; i++) {
> +		ret = ad7124_spi_write_mask(st, AD7124_CHANNEL(i), AD7124_CHANNEL_EN_MSK, 0, 2);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
>  static const struct ad_sigma_delta_info ad7124_sigma_delta_info = {
>  	.set_channel = ad7124_set_channel,
>  	.append_status = ad7124_append_status,
> +	.disable_all = ad7124_disable_all,
>  	.set_mode = ad7124_set_mode,
>  	.has_registers = true,
>  	.addr_shift = 0,

