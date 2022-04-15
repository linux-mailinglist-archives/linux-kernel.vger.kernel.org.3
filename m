Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47BBC502E65
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 19:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245570AbiDORqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 13:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245230AbiDORqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 13:46:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C832B7C4E;
        Fri, 15 Apr 2022 10:44:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2ED3CB82E49;
        Fri, 15 Apr 2022 17:44:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A38C4C385A4;
        Fri, 15 Apr 2022 17:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650044648;
        bh=lrCSsYksbzncOviQk3dUVWiQ8mHKA/HxHFi/7Dt223o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZpGtAMnFkcHPD8rEc9Bd+vacb2sQFH6p4ACXrTMQMf/DdPfkuat6OcYILEzuRnHFS
         FDNwew7gMUoKeWkCSB92cVOwpnFekM8GcSt49FQzqDrAn/oLV3SJwS49HJo5pJeWD3
         ud3x6vxR0LeLpAIucCD/7PyzI1flPk886i9KQpWSDUds2b9orWXfoOdNrQBHVAVehD
         R8QqCShFgTRnqLbZfsErDDpCDiEUiARkk5UNsmAWCVyj70w2HPX+neRLoqtEI0txFx
         f5ORQMwpjLlfHL57gLbCW378L00nYJZIcHBMyVfhjpA36jUu2eyb6apDgJrYPtxsQH
         Uq/4OvcUIbGvQ==
Date:   Fri, 15 Apr 2022 18:52:05 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] iio: gp2ap020a00f: Fix signedness bug
Message-ID: <20220415185205.26a3d352@jic23-huawei>
In-Reply-To: <1649985637-18854-1-git-send-email-baihaowen@meizu.com>
References: <CAHp75VfbZhMvs7dHwadvNs6maPsBVOY3Mk5wkKSwZ1RANQQHDA@mail.gmail.com>
        <1649985637-18854-1-git-send-email-baihaowen@meizu.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
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

On Fri, 15 Apr 2022 09:20:37 +0800
Haowen Bai <baihaowen@meizu.com> wrote:

> function gp2ap020a00f_get_thresh_reg() is unsigned but returning -EINVAL 
> errcode, and thresh_reg_l is unsigned but receiving -EINVAL errcode. so 
> we have to change u8 -> int.
> 
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
Hi,

The return value is not checked in *read_event_val(), so if we actually got
-EINVAL (in reality we can't because the switch in *_get_thresh_reg*) always
matches) then we'd use it to index an array (after performing some maths on
the value).  So please also add a check that the return value is not
negative in read_event_val()

Same is true or write_event_val.


Note that the bug here is probably the fact we return -EINVAL in the
first place. We could just stop doing that but it would be non obvious
when looking at the code that we couldn't get a failure to match in
the switch statement - so fixing as you have done (plus the extra
check I'm requesting) is probably the neatest solution.

Thanks,

Jonathan


> ---
> V1->V2: s8 is not enough to hold an (arbitrary) error code. To be on the safe
> side we need to use int
> 
>  drivers/iio/light/gp2ap020a00f.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
> index b820041159f7..b0e62d3c6fa0 100644
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
>  	int err = 0;
>  
>  	mutex_lock(&data->lock);
> @@ -1082,7 +1082,7 @@ static int gp2ap020a00f_read_event_val(struct iio_dev *indio_dev,
>  				       int *val, int *val2)
>  {
>  	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
> -	u8 thresh_reg_l;
> +	int thresh_reg_l;
>  	int err = IIO_VAL_INT;
>  
>  	mutex_lock(&data->lock);

