Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED96480C44
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 19:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236849AbhL1SAT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 28 Dec 2021 13:00:19 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:42294 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233559AbhL1SAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 13:00:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 825A3B80D35;
        Tue, 28 Dec 2021 18:00:17 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id CC515C36AEC;
        Tue, 28 Dec 2021 18:00:12 +0000 (UTC)
Date:   Tue, 28 Dec 2021 18:05:57 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Kamel Bouhara <kamel.bouhara@bootlin.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 07/23] counter: microchip-tcb-capture: Convert to
 counter_priv() wrapper
Message-ID: <20211228180557.72628e57@jic23-huawei>
In-Reply-To: <20211227094526.698714-8-u.kleine-koenig@pengutronix.de>
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
        <20211227094526.698714-8-u.kleine-koenig@pengutronix.de>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Dec 2021 10:45:10 +0100
Uwe Kleine-König         <u.kleine-koenig@pengutronix.de> wrote:

> This is a straight forward conversion to the new counter_priv() wrapper.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
(doing these individually in case your use b4 to pick up tags
as I don't think it can interpret a tag for last N patches :)


> ---
>  drivers/counter/microchip-tcb-capture.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/counter/microchip-tcb-capture.c b/drivers/counter/microchip-tcb-capture.c
> index bb69f2e0ba93..1b56b7444668 100644
> --- a/drivers/counter/microchip-tcb-capture.c
> +++ b/drivers/counter/microchip-tcb-capture.c
> @@ -72,7 +72,7 @@ static int mchp_tc_count_function_read(struct counter_device *counter,
>  				       struct counter_count *count,
>  				       enum counter_function *function)
>  {
> -	struct mchp_tc_data *const priv = counter->priv;
> +	struct mchp_tc_data *const priv = counter_priv(counter);
>  
>  	if (priv->qdec_mode)
>  		*function = COUNTER_FUNCTION_QUADRATURE_X4;
> @@ -86,7 +86,7 @@ static int mchp_tc_count_function_write(struct counter_device *counter,
>  					struct counter_count *count,
>  					enum counter_function function)
>  {
> -	struct mchp_tc_data *const priv = counter->priv;
> +	struct mchp_tc_data *const priv = counter_priv(counter);
>  	u32 bmr, cmr;
>  
>  	regmap_read(priv->regmap, ATMEL_TC_BMR, &bmr);
> @@ -148,7 +148,7 @@ static int mchp_tc_count_signal_read(struct counter_device *counter,
>  				     struct counter_signal *signal,
>  				     enum counter_signal_level *lvl)
>  {
> -	struct mchp_tc_data *const priv = counter->priv;
> +	struct mchp_tc_data *const priv = counter_priv(counter);
>  	bool sigstatus;
>  	u32 sr;
>  
> @@ -169,7 +169,7 @@ static int mchp_tc_count_action_read(struct counter_device *counter,
>  				     struct counter_synapse *synapse,
>  				     enum counter_synapse_action *action)
>  {
> -	struct mchp_tc_data *const priv = counter->priv;
> +	struct mchp_tc_data *const priv = counter_priv(counter);
>  	u32 cmr;
>  
>  	regmap_read(priv->regmap, ATMEL_TC_REG(priv->channel[0], CMR), &cmr);
> @@ -197,7 +197,7 @@ static int mchp_tc_count_action_write(struct counter_device *counter,
>  				      struct counter_synapse *synapse,
>  				      enum counter_synapse_action action)
>  {
> -	struct mchp_tc_data *const priv = counter->priv;
> +	struct mchp_tc_data *const priv = counter_priv(counter);
>  	u32 edge = ATMEL_TC_ETRGEDG_NONE;
>  
>  	/* QDEC mode is rising edge only */
> @@ -230,7 +230,7 @@ static int mchp_tc_count_action_write(struct counter_device *counter,
>  static int mchp_tc_count_read(struct counter_device *counter,
>  			      struct counter_count *count, u64 *val)
>  {
> -	struct mchp_tc_data *const priv = counter->priv;
> +	struct mchp_tc_data *const priv = counter_priv(counter);
>  	u32 cnt;
>  
>  	regmap_read(priv->regmap, ATMEL_TC_REG(priv->channel[0], CV), &cnt);

