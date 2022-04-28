Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B743B513B9D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 20:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351095AbiD1Sgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 14:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351025AbiD1Sgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 14:36:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBBCBC857;
        Thu, 28 Apr 2022 11:33:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8AA76B82F54;
        Thu, 28 Apr 2022 18:33:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B5DDC385A0;
        Thu, 28 Apr 2022 18:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651170799;
        bh=dM6SoIhKU87s7JyFiu8ZaRPnKv0+Vb1zN0hW0z5OG5U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kBe2CEqMcaaLxZcAjYt6vzZWMJD+jUyZPbBKlES+nEdUFKobJonRu4HypAsL/Tt8h
         4iWPDrRlh/zcEIttBC8kAdR91hyTxH61nHkw1asz5tA9OsMuTW1fiFTWXSkIqVYSjY
         j0MB3+LuXlxmAQa+teNK532AqlqUWSHb00p6Bq94kNSCEB50i4vToMcgi9WIuc4NeV
         I9yzYD+YSAcl7JU0F/hLUqf1ZXsMdtHH24Cv/aNhFBlvfF6g4I/qOD6JGrwOq+UYvi
         dD+u993ZT3OOJR4ICzWlr2/9HU7fVSkq4X6UjwinMGwO/tDl4U3rYnI5Dsl/HnEbGN
         B6iT8jqh7bPQg==
Date:   Thu, 28 Apr 2022 19:41:32 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V3] iio: gp2ap020a00f: Fix signedness bug
Message-ID: <20220428194132.5a02555c@jic23-huawei>
In-Reply-To: <1650248375-6334-1-git-send-email-baihaowen@meizu.com>
References: <20220415185205.26a3d352@jic23-huawei>
        <1650248375-6334-1-git-send-email-baihaowen@meizu.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Apr 2022 10:19:35 +0800
Haowen Bai <baihaowen@meizu.com> wrote:

> function gp2ap020a00f_get_thresh_reg() is unsigned but returning -EINVAL
> errcode, and thresh_reg_l is unsigned but receiving -EINVAL errcode. so
> we have to change u8 -> int. Also we need to do index bound check at
> gp2ap020a00f_read_event_val().
> 
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>

Please add a Fixes tag if possible.

> ---
> V1->V2: s8 is not enough to hold an (arbitrary) error code. To be on the safe
> side we need to use int.
> V2->V3: add bound check at gp2ap020a00f_read_event_val().
> 
> 
>  drivers/iio/light/gp2ap020a00f.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
> index b820041159f7..f80d30786035 100644
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
> @@ -1025,7 +1025,7 @@ static int gp2ap020a00f_write_event_val(struct iio_dev *indio_dev,
>  	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
>  	bool event_en = false;
>  	u8 thresh_val_id;
> -	u8 thresh_reg_l;
> +	int thresh_reg_l;

You need to check this val after the function call, but before it is used.


>  	int err = 0;
>  
>  	mutex_lock(&data->lock);
> @@ -1082,14 +1082,14 @@ static int gp2ap020a00f_read_event_val(struct iio_dev *indio_dev,
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
> -	if (thresh_reg_l > GP2AP020A00F_PH_L_REG) {
> +	if (thresh_reg_l < 0 || thresh_reg_l > GP2AP020A00F_PH_L_REG) {
>  		err = -EINVAL;
If a function returns an error we should pass that on unchanged 
Here the value is the same, but none the less we should have this look something
like.

	if (thresh_reg_l < 0)
		return thresh_reg_l;
	if (thresh_reg_l > GP2AP020A00F_PH_L_REG)
	...

>  		goto error_unlock;
>  	}

