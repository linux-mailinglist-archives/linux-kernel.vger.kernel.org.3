Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20CB45B1D10
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 14:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiIHMcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 08:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiIHMcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 08:32:43 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6721228EA
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 05:32:40 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id o25so1213820wrf.9
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 05:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=K4//uLRap3ZN9p7j6IwL1Ekr7qChaDLbj801Pd1B0Hw=;
        b=NFIr1Bmb5KneaaJtNCxyYxeXdSmvFf66jYK8smezhE18XhR1D34721d1lOqHal9qYa
         l00RNF/aP6+FjZ5+Jn32bpEo4Y4hKbyXk+8zSoDo7KzNVurN9SlAdKtgW4YR87PXhjD5
         2+fmnWoNEOQR3nIJvd2ygO2nmY5nmzA9Y2dtFllkQZURR+xLU6EqR8/wFvutgD9VqoTl
         6C+ZSUDd9eV5vave9/PVFAHbFuL618uzI6uyJi+Etm48YujEEKImY9w/fljQ10lk6LSJ
         c5J8avhTHfPQKjOn5u5hBX9qex9FpRzsLt9/GNr/NhCdGoV/hCdseW8Az/L9rJtD7Q13
         DCNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=K4//uLRap3ZN9p7j6IwL1Ekr7qChaDLbj801Pd1B0Hw=;
        b=HUEDEzb2VuTHqSYqUNM7uZl0ybqJyUuXgIrM0sKZCJbnj9KMnWNNt9SXR9Vp+I4tSf
         yslsMoiqH1/q+n0xdcDhdFUxv/ep3AzIsgPC4fQXRaVissn2cNwnYCzX/YOIAp6vu9we
         XlwVBi0jrHe7904iXBJi1/Z1RtXAhfo2/ICudKnqNGPk63RVERSpNQ0RPCWfpNn8LCNq
         /wa+CQFufdc/OtExlQowJn8JJLHT22+pNVBh+ZlXyHswb669XKK3UcTF15rG8wMF8/89
         VxTr4ExfHOZP4TcCpyo9VvmvVYSt/BiKcVPMfHkqER/omLXwDfKA4Ch4iW1LWjETk+oT
         Z6vg==
X-Gm-Message-State: ACgBeo01/RhIXkjUy4A4/GaUPrvzpoyiwzRzgGsqquQ68uPJGNR30A1n
        nEYoNRDNy+dXqM2XXQGEmEdvHQ==
X-Google-Smtp-Source: AA6agR57mq56aryOcq1X2FNoQzovdWnSlKJXToEnvp4OCasrnJsw1+rflMa41xYoSUr/pakjz0ZN+g==
X-Received: by 2002:adf:d1ea:0:b0:226:f421:79b5 with SMTP id g10-20020adfd1ea000000b00226f42179b5mr5001114wrd.173.1662640359519;
        Thu, 08 Sep 2022 05:32:39 -0700 (PDT)
Received: from blmsp (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id n8-20020a5d51c8000000b0022a3517d3besm886970wrv.5.2022.09.08.05.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 05:32:38 -0700 (PDT)
Date:   Thu, 8 Sep 2022 14:32:37 +0200
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: meson-spicc: do not rely on busy flag in pow2 clk
 ops
Message-ID: <20220908123237.6hgd22o6koe5ulmm@blmsp>
References: <20220908121803.919943-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220908121803.919943-1-narmstrong@baylibre.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

thanks for fixing.

On Thu, Sep 08, 2022 at 02:18:03PM +0200, Neil Armstrong wrote:
> Since [1], controller's busy flag isn't set anymore when the
> __spi_transfer_message_noqueue() is used instead of the
> __spi_pump_transfer_message() logic for spi_sync transfers.
> 
> Since the pow2 clock ops were limited to only be available when a
> transfer is ongoing (between prepare_transfer_hardware and
> unprepare_transfer_hardware callbacks), the only way to track this
> down is to check for the controller cur_msg.
> 
> [1] ae7d2346dc89 ("spi: Don't use the message queue if possible in spi_sync")
> 
> Fixes: 09992025dacd ("spi: meson-spicc: add local pow2 clock ops to preserve rate between messages")
> Fixes: ae7d2346dc89 ("spi: Don't use the message queue if possible in spi_sync")
> Reported-by: Markus Schneider-Pargmann <msp@baylibre.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Tested-by: Markus Schneider-Pargmann <msp@baylibre.com>

Best,
Markus

> ---
>  drivers/spi/spi-meson-spicc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/spi/spi-meson-spicc.c b/drivers/spi/spi-meson-spicc.c
> index e4cb52e1fe26..6974a1c947aa 100644
> --- a/drivers/spi/spi-meson-spicc.c
> +++ b/drivers/spi/spi-meson-spicc.c
> @@ -537,7 +537,7 @@ static unsigned long meson_spicc_pow2_recalc_rate(struct clk_hw *hw,
>  	struct clk_divider *divider = to_clk_divider(hw);
>  	struct meson_spicc_device *spicc = pow2_clk_to_spicc(divider);
>  
> -	if (!spicc->master->cur_msg || !spicc->master->busy)
> +	if (!spicc->master->cur_msg)
>  		return 0;
>  
>  	return clk_divider_ops.recalc_rate(hw, parent_rate);
> @@ -549,7 +549,7 @@ static int meson_spicc_pow2_determine_rate(struct clk_hw *hw,
>  	struct clk_divider *divider = to_clk_divider(hw);
>  	struct meson_spicc_device *spicc = pow2_clk_to_spicc(divider);
>  
> -	if (!spicc->master->cur_msg || !spicc->master->busy)
> +	if (!spicc->master->cur_msg)
>  		return -EINVAL;
>  
>  	return clk_divider_ops.determine_rate(hw, req);
> @@ -561,7 +561,7 @@ static int meson_spicc_pow2_set_rate(struct clk_hw *hw, unsigned long rate,
>  	struct clk_divider *divider = to_clk_divider(hw);
>  	struct meson_spicc_device *spicc = pow2_clk_to_spicc(divider);
>  
> -	if (!spicc->master->cur_msg || !spicc->master->busy)
> +	if (!spicc->master->cur_msg)
>  		return -EINVAL;
>  
>  	return clk_divider_ops.set_rate(hw, rate, parent_rate);
> -- 
> 2.25.1
> 
