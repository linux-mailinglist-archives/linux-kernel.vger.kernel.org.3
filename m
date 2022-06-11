Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 292A3547653
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 18:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234792AbiFKQFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 12:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233496AbiFKQFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 12:05:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4001F25294;
        Sat, 11 Jun 2022 09:05:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE56761154;
        Sat, 11 Jun 2022 16:05:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62B78C3411B;
        Sat, 11 Jun 2022 16:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654963546;
        bh=uQGH4sFj2WRe9mI9K7xL+Xi4+jrmG0wytJBcXdI8uRQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uQoZcgbrqa+VUdd4CByAP1V/QOoNk0uKWLK6fHizwKfaUQ56FQatX5hiMZm9pHt3a
         zxSc8cJVdPP80qAwZa+ug43Itb1GWDrMfYsf9KfTLKivwfxPmZOefIx2HzCmvNW2Rh
         QFDcBXII0MAhRJkzG22OYte/6H1W5ve+FSE9JU1PRJT56E33YQTQVmBRdiSJ9ESbSr
         IEQGVVcccWgQyB4lF1J0WfC3rySNci+YJezeOtoEkyAnoHQ+zni/wvhhVw8MEMi6jB
         UC1uDSvYCTYI5f+wUglCBy2szRNC820DdyUHmHoeEhnug41SangzcLktq82wpJBlfT
         YF23YnlJ3+rKA==
Date:   Sat, 11 Jun 2022 17:14:55 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Olivier Moysan <olivier.moysan@foss.st.com>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH] iio: adc: stm32: fix maximum clock rate for stm32mp15x
Message-ID: <20220611171455.13798411@jic23-huawei>
In-Reply-To: <20220609095234.375925-1-olivier.moysan@foss.st.com>
References: <20220609095234.375925-1-olivier.moysan@foss.st.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Jun 2022 11:52:34 +0200
Olivier Moysan <olivier.moysan@foss.st.com> wrote:

> Change maximum STM32 ADC input clock rate to 36MHz, as specified
> in STM32MP15x datasheets.
> 
> Fixes: d58c67d1d851 ("iio: adc: stm32-adc: add support for STM32MP1")
No gap here as per the other patch. Fixed up whilst applying and marked
for stable.

Thanks,

Jonathan

> 
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> ---
>  drivers/iio/adc/stm32-adc-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
> index 142656232157..ce1a63a82034 100644
> --- a/drivers/iio/adc/stm32-adc-core.c
> +++ b/drivers/iio/adc/stm32-adc-core.c
> @@ -805,7 +805,7 @@ static const struct stm32_adc_priv_cfg stm32h7_adc_priv_cfg = {
>  static const struct stm32_adc_priv_cfg stm32mp1_adc_priv_cfg = {
>  	.regs = &stm32h7_adc_common_regs,
>  	.clk_sel = stm32h7_adc_clk_sel,
> -	.max_clk_rate_hz = 40000000,
> +	.max_clk_rate_hz = 36000000,
>  	.has_syscfg = HAS_VBOOSTER | HAS_ANASWVDD,
>  	.num_irqs = 2,
>  };

