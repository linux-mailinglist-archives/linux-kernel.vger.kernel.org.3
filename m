Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 742DE5164D4
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 16:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347833AbiEAO6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 10:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232359AbiEAO62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 10:58:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50D55A148;
        Sun,  1 May 2022 07:55:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7872560AC5;
        Sun,  1 May 2022 14:55:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6995DC385A9;
        Sun,  1 May 2022 14:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651416901;
        bh=g8tQjFPdOup3y6BTLAYsRBG+vqUYuQhG4z9OhKIZjNk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=I8ySlaxnd51oP9M2Vnd38IVdnRcZMqGuykaylbA6wDkJJ0dv8G95plP8tJ4uMvk47
         BLdjcx3y85nd330OI9jx1QrY1UzG3+dyMgAB4i7nCPM63GhNw8E9WRIsImITW7+RSv
         yK0sJA5yAFfw0/04PvncHbdL65dsHJIf8Ea0Ux15+qpeDm1tAL+BvVRvwFxfkSkWxh
         EghLELpmLIXzDy0PUiBa1gpcB+qmrvfkYghsnAjD+9PcGgCTLzxD7Oyi/XFryFrVm0
         fXmXKzqtHIgtyUpvohPLzZz4KulZn6fifZ2xrz909638+mTJGiwMhkE9LvNgJf+EfU
         r2bA5fDAtjYEA==
Date:   Sun, 1 May 2022 16:03:17 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V4] iio: gp2ap020a00f: Fix signedness bug
Message-ID: <20220501160317.62d4737c@jic23-huawei>
In-Reply-To: <1651196214-7114-1-git-send-email-baihaowen@meizu.com>
References: <20220428194132.5a02555c@jic23-huawei>
        <1651196214-7114-1-git-send-email-baihaowen@meizu.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Apr 2022 09:36:54 +0800
Haowen Bai <baihaowen@meizu.com> wrote:

> function gp2ap020a00f_get_thresh_reg() is unsigned but returning -EINVAL
> errcode, and thresh_reg_l is unsigned but receiving -EINVAL errcode. so
> we have to change u8 -> int. Also we need to do index bound check at
> gp2ap020a00f_read_event_val().
> 
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
Hi Haowen Bai,

Please add a fixes tag.  Also, this thread is getting rather deep
and illustrates why I tend to ask for each new version of IIO patches
to be posted without replying to previous thread (so start a new thread).

One issue below with locking.

Thanks,

Jonathan

> ---
> V1->V2: s8 is not enough to hold an (arbitrary) error code. To be on the safe
> side we need to use int.
> V2->V3: add bound check at gp2ap020a00f_read_event_val().
> V3->V4: 
> 1. add fix tag.
> 2. add check before use at gp2ap020a00f_write_event_val().
> 3. returns an error we should pass that on unchanged at
> gp2ap020a00f_read_event_val()
> 
>  drivers/iio/light/gp2ap020a00f.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
> index b820041159f7..13583e1191d4 100644
> --- a/drivers/iio/light/gp2ap020a00f.c
> +++ b/drivers/iio/light/gp2ap020a00f.c
> @@ -994,7 +994,7 @@ static irqreturn_t gp2ap020a00f_trigger_handler(int irq, void *data)
>  	return IRQ_HANDLED;
>  }
>  
> -static u8 gp2ap020a00f_get_thresh_reg(const struct iio_chan_spec *chan,
> +static int gp2ap020a00f_get_thresh_reg(const struct iio_chan_spec *chan,
>  					     enum iio_event_direction event_dir)
>  {
>  	switch (chan->type) {
> @@ -1025,12 +1025,18 @@ static int gp2ap020a00f_write_event_val(struct iio_dev *indio_dev,
>  	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
>  	bool event_en = false;
>  	u8 thresh_val_id;
> -	u8 thresh_reg_l;
> +	int thresh_reg_l;
>  	int err = 0;
>  
>  	mutex_lock(&data->lock);
>  
>  	thresh_reg_l = gp2ap020a00f_get_thresh_reg(chan, dir);
> +
> +	if (thresh_reg_l < 0){
> +		err = thresh_reg_l;
> +		goto error_unlock;
> +	}
> +
>  	thresh_val_id = GP2AP020A00F_THRESH_VAL_ID(thresh_reg_l);
>  
>  	if (thresh_val_id > GP2AP020A00F_THRESH_PH) {
> @@ -1082,13 +1088,16 @@ static int gp2ap020a00f_read_event_val(struct iio_dev *indio_dev,
>  				       int *val, int *val2)
>  {
>  	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
> -	u8 thresh_reg_l;
> +	int thresh_reg_l;
>  	int err = IIO_VAL_INT;
>  
>  	mutex_lock(&data->lock);
>  
>  	thresh_reg_l = gp2ap020a00f_get_thresh_reg(chan, dir);
>  
> +	if (thresh_reg_l < 0)
mutex_unlock() ?

I'd expect something like
	if (thresh_reg_l < 0) {
		err = thresh_reg_l;
		goto error_unlock;
	}

> +		return thresh_reg_l;
> +
>  	if (thresh_reg_l > GP2AP020A00F_PH_L_REG) {
>  		err = -EINVAL;
>  		goto error_unlock;

