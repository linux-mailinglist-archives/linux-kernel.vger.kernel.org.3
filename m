Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0CF480C4A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 19:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236877AbhL1SB4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 28 Dec 2021 13:01:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236871AbhL1SBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 13:01:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58127C061574;
        Tue, 28 Dec 2021 10:01:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01A0B611C8;
        Tue, 28 Dec 2021 18:01:55 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id 09647C36AEC;
        Tue, 28 Dec 2021 18:01:50 +0000 (UTC)
Date:   Tue, 28 Dec 2021 18:07:35 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, David Lechner <david@lechnology.com>
Subject: Re: [PATCH v2 10/23] counter: ti-eqep: Convert to counter_priv()
 wrapper
Message-ID: <20211228180735.1e7e78b5@jic23-huawei>
In-Reply-To: <20211227094526.698714-11-u.kleine-koenig@pengutronix.de>
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
        <20211227094526.698714-11-u.kleine-koenig@pengutronix.de>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Dec 2021 10:45:13 +0100
Uwe Kleine-König         <u.kleine-koenig@pengutronix.de> wrote:

> This is a straight forward conversion to the new counter_priv() wrapper.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/counter/ti-eqep.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
> index 09817c953f9a..abeda966e7be 100644
> --- a/drivers/counter/ti-eqep.c
> +++ b/drivers/counter/ti-eqep.c
> @@ -90,7 +90,7 @@ struct ti_eqep_cnt {
>  static int ti_eqep_count_read(struct counter_device *counter,
>  			      struct counter_count *count, u64 *val)
>  {
> -	struct ti_eqep_cnt *priv = counter->priv;
> +	struct ti_eqep_cnt *priv = counter_priv(counter);
>  	u32 cnt;
>  
>  	regmap_read(priv->regmap32, QPOSCNT, &cnt);
> @@ -102,7 +102,7 @@ static int ti_eqep_count_read(struct counter_device *counter,
>  static int ti_eqep_count_write(struct counter_device *counter,
>  			       struct counter_count *count, u64 val)
>  {
> -	struct ti_eqep_cnt *priv = counter->priv;
> +	struct ti_eqep_cnt *priv = counter_priv(counter);
>  	u32 max;
>  
>  	regmap_read(priv->regmap32, QPOSMAX, &max);
> @@ -116,7 +116,7 @@ static int ti_eqep_function_read(struct counter_device *counter,
>  				 struct counter_count *count,
>  				 enum counter_function *function)
>  {
> -	struct ti_eqep_cnt *priv = counter->priv;
> +	struct ti_eqep_cnt *priv = counter_priv(counter);
>  	u32 qdecctl;
>  
>  	regmap_read(priv->regmap16, QDECCTL, &qdecctl);
> @@ -143,7 +143,7 @@ static int ti_eqep_function_write(struct counter_device *counter,
>  				  struct counter_count *count,
>  				  enum counter_function function)
>  {
> -	struct ti_eqep_cnt *priv = counter->priv;
> +	struct ti_eqep_cnt *priv = counter_priv(counter);
>  	enum ti_eqep_count_func qsrc;
>  
>  	switch (function) {
> @@ -173,7 +173,7 @@ static int ti_eqep_action_read(struct counter_device *counter,
>  			       struct counter_synapse *synapse,
>  			       enum counter_synapse_action *action)
>  {
> -	struct ti_eqep_cnt *priv = counter->priv;
> +	struct ti_eqep_cnt *priv = counter_priv(counter);
>  	enum counter_function function;
>  	u32 qdecctl;
>  	int err;
> @@ -245,7 +245,7 @@ static int ti_eqep_position_ceiling_read(struct counter_device *counter,
>  					 struct counter_count *count,
>  					 u64 *ceiling)
>  {
> -	struct ti_eqep_cnt *priv = counter->priv;
> +	struct ti_eqep_cnt *priv = counter_priv(counter);
>  	u32 qposmax;
>  
>  	regmap_read(priv->regmap32, QPOSMAX, &qposmax);
> @@ -259,7 +259,7 @@ static int ti_eqep_position_ceiling_write(struct counter_device *counter,
>  					  struct counter_count *count,
>  					  u64 ceiling)
>  {
> -	struct ti_eqep_cnt *priv = counter->priv;
> +	struct ti_eqep_cnt *priv = counter_priv(counter);
>  
>  	if (ceiling != (u32)ceiling)
>  		return -ERANGE;
> @@ -272,7 +272,7 @@ static int ti_eqep_position_ceiling_write(struct counter_device *counter,
>  static int ti_eqep_position_enable_read(struct counter_device *counter,
>  					struct counter_count *count, u8 *enable)
>  {
> -	struct ti_eqep_cnt *priv = counter->priv;
> +	struct ti_eqep_cnt *priv = counter_priv(counter);
>  	u32 qepctl;
>  
>  	regmap_read(priv->regmap16, QEPCTL, &qepctl);
> @@ -285,7 +285,7 @@ static int ti_eqep_position_enable_read(struct counter_device *counter,
>  static int ti_eqep_position_enable_write(struct counter_device *counter,
>  					 struct counter_count *count, u8 enable)
>  {
> -	struct ti_eqep_cnt *priv = counter->priv;
> +	struct ti_eqep_cnt *priv = counter_priv(counter);
>  
>  	regmap_write_bits(priv->regmap16, QEPCTL, QEPCTL_PHEN, enable ? -1 : 0);
>  

