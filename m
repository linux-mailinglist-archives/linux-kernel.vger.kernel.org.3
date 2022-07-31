Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15224585E31
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 10:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236376AbiGaInd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 04:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiGaInc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 04:43:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F6312632;
        Sun, 31 Jul 2022 01:43:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 29B42B80CE4;
        Sun, 31 Jul 2022 08:43:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD881C433D6;
        Sun, 31 Jul 2022 08:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659257008;
        bh=iHmeSLolgWMCdbdbeCxvGWbO1LZfF2j0Uq3ba5TK07A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fVomZ5uhxxcT2aYHpDRvNLs8UeURpEPQUEuBd+pEKdwmcLEdt/t7KD1+Bc09VMYiP
         oArqm5zhw+sorUS69UgAk7yFBVX1+I1ayMEjIZvwl6Zz2nQEVdS5s5kOvcTJYNwJAB
         bpXr/I2nC1CuEwQAcnMWIpZh2y+0kaHek8qx5GBlqCPQJO3EY7cWk9WtGt3rVPNkrJ
         Nf+aZytU/WKnBzLkZZBw9CTubGUW95e2d/LEllAVH+P18YlpHgkGqh0C53zxh1vqLR
         smsnyeJapvJe/647irHnTz5wKaImXtPsjZoM0QpV/dFLYkbrkKWRD5BDKsE7tT4uyZ
         YH/HriTokiB+Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oI4Y1-000343-UA; Sun, 31 Jul 2022 10:43:42 +0200
Date:   Sun, 31 Jul 2022 10:43:41 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>,
        Steev Klimaszewski <steev@kali.org>
Subject: Re: [PATCH] remoteproc: qcom_q6v5_pas: Do not fail if regulators are
 not found
Message-ID: <YuZAvX13W9Qip7Ja@hovoldconsulting.com>
References: <20220730062834.12780-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220730062834.12780-1-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 30, 2022 at 11:58:34AM +0530, Manivannan Sadhasivam wrote:
> devm_regulator_get_optional() API will return -ENODEV if the regulator was
> not found. For the optional supplies CX, PX we should not fail in that case
> but rather continue. So let's catch that error and continue silently if
> those regulators are not found.
> 
> The commit 3f52d118f992 ("remoteproc: qcom_q6v5_pas: Deal silently with
> optional px and cx regulators") was supposed to do the same but it missed
> the fact that devm_regulator_get_optional() API returns -ENODEV when the
> regulator was not found.
> 
> Cc: Abel Vesa <abel.vesa@linaro.org>
> Fixes: 3f52d118f992 ("remoteproc: qcom_q6v5_pas: Deal silently with optional px and cx regulators")
> Reported-by: Steev Klimaszewski <steev@kali.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/remoteproc/qcom_q6v5_pas.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
> index 98f133f9bb60..5bf69ef53819 100644
> --- a/drivers/remoteproc/qcom_q6v5_pas.c
> +++ b/drivers/remoteproc/qcom_q6v5_pas.c
> @@ -362,12 +362,24 @@ static int adsp_init_clock(struct qcom_adsp *adsp)
>  static int adsp_init_regulator(struct qcom_adsp *adsp)
>  {
>  	adsp->cx_supply = devm_regulator_get_optional(adsp->dev, "cx");
> -	if (IS_ERR(adsp->cx_supply))
> -		return PTR_ERR(adsp->cx_supply);
> +	if (IS_ERR(adsp->cx_supply)) {
> +		/* Do not fail if the regulator is not found */

I agree with Abel that these comments shouldn't be necessary.

> +		if (PTR_ERR(adsp->cx_supply) == -ENODEV)
> +			adsp->cx_supply = NULL;
> +		else
> +			return PTR_ERR(adsp->cx_supply);
> +	}
>  
> -	regulator_set_load(adsp->cx_supply, 100000);
> +	if (adsp->cx_supply)
> +		regulator_set_load(adsp->cx_supply, 100000);
>  
>  	adsp->px_supply = devm_regulator_get_optional(adsp->dev, "px");
> +	if (IS_ERR(adsp->px_supply)) {
> +		/* Do not fail if the regulator is not found */
> +		if (PTR_ERR(adsp->px_supply) == -ENODEV)
> +			adsp->px_supply = NULL;

Please return the error here as for cx.

> +	}
> +
>  	return PTR_ERR_OR_ZERO(adsp->px_supply);

And drop this abomination which just obfuscates code and return 0
explicitly in the success path.

With that fixed:

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

Johan
