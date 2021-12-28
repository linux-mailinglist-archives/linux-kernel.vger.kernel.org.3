Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3288D480C51
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 19:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236889AbhL1SDC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 28 Dec 2021 13:03:02 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:43834 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236164AbhL1SC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 13:02:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 25341B80D35;
        Tue, 28 Dec 2021 18:02:58 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id 45ED9C36AEC;
        Tue, 28 Dec 2021 18:02:52 +0000 (UTC)
Date:   Tue, 28 Dec 2021 18:08:36 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 12/23] counter: stm32-timer-cnt: Convert to
 counter_priv() wrapper
Message-ID: <20211228180836.085dcd30@jic23-huawei>
In-Reply-To: <20211227094526.698714-13-u.kleine-koenig@pengutronix.de>
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
        <20211227094526.698714-13-u.kleine-koenig@pengutronix.de>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Dec 2021 10:45:15 +0100
Uwe Kleine-König         <u.kleine-koenig@pengutronix.de> wrote:

> This is a straight forward conversion to the new counter_priv() wrapper.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/counter/stm32-timer-cnt.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
> index 0546e932db0c..4b05b198a8d8 100644
> --- a/drivers/counter/stm32-timer-cnt.c
> +++ b/drivers/counter/stm32-timer-cnt.c
> @@ -47,7 +47,7 @@ static const enum counter_function stm32_count_functions[] = {
>  static int stm32_count_read(struct counter_device *counter,
>  			    struct counter_count *count, u64 *val)
>  {
> -	struct stm32_timer_cnt *const priv = counter->priv;
> +	struct stm32_timer_cnt *const priv = counter_priv(counter);
>  	u32 cnt;
>  
>  	regmap_read(priv->regmap, TIM_CNT, &cnt);
> @@ -59,7 +59,7 @@ static int stm32_count_read(struct counter_device *counter,
>  static int stm32_count_write(struct counter_device *counter,
>  			     struct counter_count *count, const u64 val)
>  {
> -	struct stm32_timer_cnt *const priv = counter->priv;
> +	struct stm32_timer_cnt *const priv = counter_priv(counter);
>  	u32 ceiling;
>  
>  	regmap_read(priv->regmap, TIM_ARR, &ceiling);
> @@ -73,7 +73,7 @@ static int stm32_count_function_read(struct counter_device *counter,
>  				     struct counter_count *count,
>  				     enum counter_function *function)
>  {
> -	struct stm32_timer_cnt *const priv = counter->priv;
> +	struct stm32_timer_cnt *const priv = counter_priv(counter);
>  	u32 smcr;
>  
>  	regmap_read(priv->regmap, TIM_SMCR, &smcr);
> @@ -100,7 +100,7 @@ static int stm32_count_function_write(struct counter_device *counter,
>  				      struct counter_count *count,
>  				      enum counter_function function)
>  {
> -	struct stm32_timer_cnt *const priv = counter->priv;
> +	struct stm32_timer_cnt *const priv = counter_priv(counter);
>  	u32 cr1, sms;
>  
>  	switch (function) {
> @@ -140,7 +140,7 @@ static int stm32_count_direction_read(struct counter_device *counter,
>  				      struct counter_count *count,
>  				      enum counter_count_direction *direction)
>  {
> -	struct stm32_timer_cnt *const priv = counter->priv;
> +	struct stm32_timer_cnt *const priv = counter_priv(counter);
>  	u32 cr1;
>  
>  	regmap_read(priv->regmap, TIM_CR1, &cr1);
> @@ -153,7 +153,7 @@ static int stm32_count_direction_read(struct counter_device *counter,
>  static int stm32_count_ceiling_read(struct counter_device *counter,
>  				    struct counter_count *count, u64 *ceiling)
>  {
> -	struct stm32_timer_cnt *const priv = counter->priv;
> +	struct stm32_timer_cnt *const priv = counter_priv(counter);
>  	u32 arr;
>  
>  	regmap_read(priv->regmap, TIM_ARR, &arr);
> @@ -166,7 +166,7 @@ static int stm32_count_ceiling_read(struct counter_device *counter,
>  static int stm32_count_ceiling_write(struct counter_device *counter,
>  				     struct counter_count *count, u64 ceiling)
>  {
> -	struct stm32_timer_cnt *const priv = counter->priv;
> +	struct stm32_timer_cnt *const priv = counter_priv(counter);
>  
>  	if (ceiling > priv->max_arr)
>  		return -ERANGE;
> @@ -181,7 +181,7 @@ static int stm32_count_ceiling_write(struct counter_device *counter,
>  static int stm32_count_enable_read(struct counter_device *counter,
>  				   struct counter_count *count, u8 *enable)
>  {
> -	struct stm32_timer_cnt *const priv = counter->priv;
> +	struct stm32_timer_cnt *const priv = counter_priv(counter);
>  	u32 cr1;
>  
>  	regmap_read(priv->regmap, TIM_CR1, &cr1);
> @@ -194,7 +194,7 @@ static int stm32_count_enable_read(struct counter_device *counter,
>  static int stm32_count_enable_write(struct counter_device *counter,
>  				    struct counter_count *count, u8 enable)
>  {
> -	struct stm32_timer_cnt *const priv = counter->priv;
> +	struct stm32_timer_cnt *const priv = counter_priv(counter);
>  	u32 cr1;
>  
>  	if (enable) {

