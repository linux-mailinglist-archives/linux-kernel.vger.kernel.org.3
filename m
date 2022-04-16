Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1CB550379B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 18:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbiDPQnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 12:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbiDPQnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 12:43:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A999BF2B;
        Sat, 16 Apr 2022 09:40:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 470FF60DCA;
        Sat, 16 Apr 2022 16:40:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0722C385A1;
        Sat, 16 Apr 2022 16:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650127245;
        bh=Dub8dgKGw6wtQmZV+WoeLQ2mDrh6IlymRzNx7PEclcQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=j1cFlU0eND8N4p4d6UACgXx7AUDzwu+RAwtvqVoetIPYHIpy6ACHGi59GZmgH5rdj
         CUqR6fW0KATCyuVWmuBeOWZuH5r6RGRQhaCknMRxamkwBHHdu6/9RcoLGeERZCVhjE
         7xa4kqasdj4qGBKpgHYGbFoqtfE5lCTe25tx2p6RLJCSbvTaL4nkPCJgqjCdzL8B98
         M4hWrrjgjY4CsxaLV1QGz9FuqikwDs49Bh/cCeV5y0mRd2hI3AU8Xl53TNoOAJtMo6
         w4phlh9PODY4h8i8v/uCCX5dXLBCdpTwm8Y8sF/PQY19AJjVdBp8l8hmx0uZsDAVQs
         H2ZdTtcEp8Hmg==
Date:   Sat, 16 Apr 2022 17:48:42 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     dan@dlrobertson.com, andy.shevchenko@gmail.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 8/9] iio: accel: bma400: Add debugfs register access
 support
Message-ID: <20220416174842.37a40e38@jic23-huawei>
In-Reply-To: <20220411203133.19929-9-jagathjog1996@gmail.com>
References: <20220411203133.19929-1-jagathjog1996@gmail.com>
        <20220411203133.19929-9-jagathjog1996@gmail.com>
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

On Tue, 12 Apr 2022 02:01:32 +0530
Jagath Jog J <jagathjog1996@gmail.com> wrote:

> Add support to read/write byte from/to bma400 device from the userspace
> using debugfs interface.
> 
> Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
> ---
>  drivers/iio/accel/bma400_core.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
> index 69d2caa4ed18..b6c79cfabaa4 100644
> --- a/drivers/iio/accel/bma400_core.c
> +++ b/drivers/iio/accel/bma400_core.c
> @@ -1028,6 +1028,23 @@ static int bma400_write_event_config(struct iio_dev *indio_dev,
>  	}
>  }
>  
> +static int bma400_debugfs_reg_access(struct iio_dev *indio_dev,
> +				     unsigned int reg,
> +				     unsigned int writeval,
> +				     unsigned int *readval)
> +{
> +	struct bma400_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	mutex_lock(&data->mutex);

Guess what? :)  Can't see what purpose locking this has.

> +	if (readval)
> +		ret = regmap_read(data->regmap, reg, readval);
> +	else
> +		ret = regmap_write(data->regmap, reg, writeval);
> +	mutex_unlock(&data->mutex);
> +	return ret;
> +}
> +
>  static int bma400_data_rdy_trigger_set_state(struct iio_trigger *trig,
>  					     bool state)
>  {
> @@ -1058,6 +1075,7 @@ static const struct iio_info bma400_info = {
>  	.write_raw_get_fmt = bma400_write_raw_get_fmt,
>  	.read_event_config = bma400_read_event_config,
>  	.write_event_config = bma400_write_event_config,
> +	.debugfs_reg_access = bma400_debugfs_reg_access,
>  };
>  
>  static const struct iio_trigger_ops bma400_trigger_ops = {

