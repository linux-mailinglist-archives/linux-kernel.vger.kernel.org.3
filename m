Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9E10480C4E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 19:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236871AbhL1SC1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 28 Dec 2021 13:02:27 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:51050 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233279AbhL1SC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 13:02:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A60B7611C8;
        Tue, 28 Dec 2021 18:02:26 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id 87DA9C36AEC;
        Tue, 28 Dec 2021 18:02:21 +0000 (UTC)
Date:   Tue, 28 Dec 2021 18:08:05 +0000
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
Subject: Re: [PATCH v2 11/23] counter: stm32-lptimer-cnt: Convert to
 counter_priv() wrapper
Message-ID: <20211228180805.54b99114@jic23-huawei>
In-Reply-To: <20211227094526.698714-12-u.kleine-koenig@pengutronix.de>
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
        <20211227094526.698714-12-u.kleine-koenig@pengutronix.de>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Dec 2021 10:45:14 +0100
Uwe Kleine-König         <u.kleine-koenig@pengutronix.de> wrote:

> This is a straight forward conversion to the new counter_priv() wrapper.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/counter/stm32-lptimer-cnt.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/counter/stm32-lptimer-cnt.c b/drivers/counter/stm32-lptimer-cnt.c
> index 5168833b1fdf..9cf00e929cc0 100644
> --- a/drivers/counter/stm32-lptimer-cnt.c
> +++ b/drivers/counter/stm32-lptimer-cnt.c
> @@ -141,7 +141,7 @@ static const enum counter_synapse_action stm32_lptim_cnt_synapse_actions[] = {
>  static int stm32_lptim_cnt_read(struct counter_device *counter,
>  				struct counter_count *count, u64 *val)
>  {
> -	struct stm32_lptim_cnt *const priv = counter->priv;
> +	struct stm32_lptim_cnt *const priv = counter_priv(counter);
>  	u32 cnt;
>  	int ret;
>  
> @@ -158,7 +158,7 @@ static int stm32_lptim_cnt_function_read(struct counter_device *counter,
>  					 struct counter_count *count,
>  					 enum counter_function *function)
>  {
> -	struct stm32_lptim_cnt *const priv = counter->priv;
> +	struct stm32_lptim_cnt *const priv = counter_priv(counter);
>  
>  	if (!priv->quadrature_mode) {
>  		*function = COUNTER_FUNCTION_INCREASE;
> @@ -177,7 +177,7 @@ static int stm32_lptim_cnt_function_write(struct counter_device *counter,
>  					  struct counter_count *count,
>  					  enum counter_function function)
>  {
> -	struct stm32_lptim_cnt *const priv = counter->priv;
> +	struct stm32_lptim_cnt *const priv = counter_priv(counter);
>  
>  	if (stm32_lptim_is_enabled(priv))
>  		return -EBUSY;
> @@ -200,7 +200,7 @@ static int stm32_lptim_cnt_enable_read(struct counter_device *counter,
>  				       struct counter_count *count,
>  				       u8 *enable)
>  {
> -	struct stm32_lptim_cnt *const priv = counter->priv;
> +	struct stm32_lptim_cnt *const priv = counter_priv(counter);
>  	int ret;
>  
>  	ret = stm32_lptim_is_enabled(priv);
> @@ -216,7 +216,7 @@ static int stm32_lptim_cnt_enable_write(struct counter_device *counter,
>  					struct counter_count *count,
>  					u8 enable)
>  {
> -	struct stm32_lptim_cnt *const priv = counter->priv;
> +	struct stm32_lptim_cnt *const priv = counter_priv(counter);
>  	int ret;
>  
>  	/* Check nobody uses the timer, or already disabled/enabled */
> @@ -241,7 +241,7 @@ static int stm32_lptim_cnt_ceiling_read(struct counter_device *counter,
>  					struct counter_count *count,
>  					u64 *ceiling)
>  {
> -	struct stm32_lptim_cnt *const priv = counter->priv;
> +	struct stm32_lptim_cnt *const priv = counter_priv(counter);
>  
>  	*ceiling = priv->ceiling;
>  
> @@ -252,7 +252,7 @@ static int stm32_lptim_cnt_ceiling_write(struct counter_device *counter,
>  					 struct counter_count *count,
>  					 u64 ceiling)
>  {
> -	struct stm32_lptim_cnt *const priv = counter->priv;
> +	struct stm32_lptim_cnt *const priv = counter_priv(counter);
>  
>  	if (stm32_lptim_is_enabled(priv))
>  		return -EBUSY;
> @@ -277,7 +277,7 @@ static int stm32_lptim_cnt_action_read(struct counter_device *counter,
>  				       struct counter_synapse *synapse,
>  				       enum counter_synapse_action *action)
>  {
> -	struct stm32_lptim_cnt *const priv = counter->priv;
> +	struct stm32_lptim_cnt *const priv = counter_priv(counter);
>  	enum counter_function function;
>  	int err;
>  
> @@ -321,7 +321,7 @@ static int stm32_lptim_cnt_action_write(struct counter_device *counter,
>  					struct counter_synapse *synapse,
>  					enum counter_synapse_action action)
>  {
> -	struct stm32_lptim_cnt *const priv = counter->priv;
> +	struct stm32_lptim_cnt *const priv = counter_priv(counter);
>  	enum counter_function function;
>  	int err;
>  

