Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE301516531
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 18:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349059AbiEAQ0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 12:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343792AbiEAQ0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 12:26:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7931660DE;
        Sun,  1 May 2022 09:22:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BF0760F30;
        Sun,  1 May 2022 16:22:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CECFC385A9;
        Sun,  1 May 2022 16:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651422175;
        bh=qishdcbixWQETntHOf7vaokjpCbepI6++lreU4OEr0A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HeDcvl06NnntL8LafiS+uEspQAlKCMVE6LO6QuqzX8Sr3Zb687Du2m/AJUM1fx8Sk
         apIntfuxs3C/mJErsd5Sj0J+wUGgL9Gmw+06UPUThOBApvr3LCAmrJ+ZT5Hqmgpve4
         LUswDtejm2PqUYhZmtPBiKf4td2epemyCGAJp/0nxs5eC0qupnXQUEb/JHNi/VE1tT
         sg9hQwq0Y1Eo/AVcPsP6TF3NDI5QPEYaECy59GCCBBUM8zEIFQkW6Z+TTen3+A5HSK
         qUr3aFJZAtAgKZ93yAlZA8uKeAi+dPrfzqqfH+iwdHAU/BsjAKO1ZY8VTiWffIXmDf
         uzuwH/3WhCiJA==
Date:   Sun, 1 May 2022 17:31:10 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     dan@dlrobertson.com, andy.shevchenko@gmail.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 6/9] iio: accel: bma400: Add step change event
Message-ID: <20220501173110.67a18bf9@jic23-huawei>
In-Reply-To: <20220420211105.14654-7-jagathjog1996@gmail.com>
References: <20220420211105.14654-1-jagathjog1996@gmail.com>
        <20220420211105.14654-7-jagathjog1996@gmail.com>
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

On Thu, 21 Apr 2022 02:41:02 +0530
Jagath Jog J <jagathjog1996@gmail.com> wrote:

> Added support for event when there is a detection of step change.
> INT1 pin is used to interrupt and event is pushed to userspace.
> 
> Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
Hi Jagath,

A query about handling of multiple interrupts...

> ---
>  drivers/iio/accel/bma400.h      |  2 +
>  drivers/iio/accel/bma400_core.c | 75 +++++++++++++++++++++++++++++++++
>  2 files changed, 77 insertions(+)
> 
>   * Read-write configuration registers
> diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
> index aafb5a40944d..fe101df7b773 100644
> --- a/drivers/iio/accel/bma400_core.c
> +++ b/drivers/iio/accel/bma400_core.c

>  
>  static const struct iio_trigger_ops bma400_trigger_ops = {
> @@ -971,6 +1035,7 @@ static irqreturn_t bma400_interrupt(int irq, void *private)
>  {
>  	struct iio_dev *indio_dev = private;
>  	struct bma400_data *data = iio_priv(indio_dev);
> +	s64 timestamp = iio_get_time_ns(indio_dev);
>  	int ret;
>  
>  	/* Lock to protect the data->status */
> @@ -981,6 +1046,16 @@ static irqreturn_t bma400_interrupt(int irq, void *private)
>  	if (ret)
>  		goto unlock_err;
>  
> +	if (FIELD_GET(BMA400_STEP_STAT_MASK, le16_to_cpu(data->status))) {
> +		iio_push_event(indio_dev,
> +			       IIO_EVENT_CODE(IIO_STEPS, 0, IIO_NO_MOD,
> +					      IIO_EV_DIR_NONE,
> +					      IIO_EV_TYPE_CHANGE, 0, 0, 0),
> +			       timestamp);
> +		mutex_unlock(&data->mutex);

Is it possible for two interrupt sources to be active at the same time?
Given the device is clearing interrupts on read (which is unusual enough to
make me check that on the datasheet) you will loose any other events.

Normal trick is to act on all set bits and if any of them were acted on
return HANDLED.

> +		return IRQ_HANDLED;
> +	}
> +
>  	if (FIELD_GET(BMA400_INT_DRDY_MSK, le16_to_cpu(data->status))) {
>  		mutex_unlock(&data->mutex);
>  		iio_trigger_poll_chained(data->trig);

