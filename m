Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2A4859A307
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 20:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351203AbiHSRuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 13:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351301AbiHSRt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 13:49:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C557C32F;
        Fri, 19 Aug 2022 10:20:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6C3AFB82852;
        Fri, 19 Aug 2022 17:20:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6B2EC433D6;
        Fri, 19 Aug 2022 17:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660929618;
        bh=pqfYAKcyggEoIGvq/LHNLs/YpU/JRraQ9n78keTDpNk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Y2EltIagHroUZbMf+CyAqnokaZoI983lqcAJO3KuyWlHrGajVQ6J5saQ4e/VCY5Bw
         Bd/3+gzN9heMk2mlUteyp49dHgxtUz0uhkRMJ1NFoYl7j4TfCY8WFZ/dCj7AGEpH6B
         sLH2QTzOLx6D2xra3Pjrfe21Mxn1xNkAErjaIeTh9jrjcVUJoKc9Tc8AuEdSaA/nw1
         6YS53b6vd2bpmwSgtbLKJhsKAgaR3tDEHq3iHP66ZNbGjreKktn090wsA5RXJKOFBa
         KK2UkNmajG0qnFu03YyrmMTWjKmkN5QjjIGJvfFLXArpjZ1E3N/XSNxFjAh1nbLSBB
         UYsaF+97i+qsg==
Date:   Fri, 19 Aug 2022 18:30:52 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Robert Marko <robimarko@gmail.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lars@metafoo.de,
        sboyd@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v8 3/5] iio: adc: qcom-spmi-adc5: add ADC5_VREF_VADC to
 rev2 ADC5
Message-ID: <20220819183052.49cf14e9@jic23-huawei>
In-Reply-To: <20220818221815.346233-3-robimarko@gmail.com>
References: <20220818221815.346233-1-robimarko@gmail.com>
        <20220818221815.346233-3-robimarko@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Aug 2022 00:18:13 +0200
Robert Marko <robimarko@gmail.com> wrote:

> Add support for ADC5_VREF_VADC channel to rev2 ADC5 channel list.
> This channel measures the VADC reference LDO output.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I've changed my mind on this, mostly because we've reached a new
cycle and I'd rather not see a v9 series + Lee is (I think)
keen to only take stuff through MFD if there is a build time
dependency.

Applied this patch directly to the togreg branch of iio.git
and pushed that out as testing for 0-day to play with it.
> ---
>  drivers/iio/adc/qcom-spmi-adc5.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
> index e96da2ef1964..821fee60a765 100644
> --- a/drivers/iio/adc/qcom-spmi-adc5.c
> +++ b/drivers/iio/adc/qcom-spmi-adc5.c
> @@ -597,6 +597,8 @@ static const struct adc5_channels adc5_chans_rev2[ADC5_MAX_CHANNEL] = {
>  					SCALE_HW_CALIB_DEFAULT)
>  	[ADC5_1P25VREF]		= ADC5_CHAN_VOLT("vref_1p25", 0,
>  					SCALE_HW_CALIB_DEFAULT)
> +	[ADC5_VREF_VADC]	= ADC5_CHAN_VOLT("vref_vadc", 0,
> +					SCALE_HW_CALIB_DEFAULT)
>  	[ADC5_VPH_PWR]		= ADC5_CHAN_VOLT("vph_pwr", 1,
>  					SCALE_HW_CALIB_DEFAULT)
>  	[ADC5_VBAT_SNS]		= ADC5_CHAN_VOLT("vbat_sns", 1,

