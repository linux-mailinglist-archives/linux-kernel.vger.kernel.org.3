Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAECE516538
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 18:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349123AbiEAQ3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 12:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238590AbiEAQ3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 12:29:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35399BCA6;
        Sun,  1 May 2022 09:25:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DB63CB80E78;
        Sun,  1 May 2022 16:25:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D891FC385AA;
        Sun,  1 May 2022 16:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651422345;
        bh=HIW4EALSEwmwk0YmbIWhY/XgqaK3U5bYWUg7I08+sNc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tEyRMLtu1bY6XoqP1+9di/O5j/Y6eSqsuaz6qgiR0/nmPP2lg47WjiC2a1ZaajaLU
         gh/hkA07L1Y1yh1Z1mfqcTm0/o+Ncgq522rvnFD8meyidHpF7O9/R2gp5cqrZRe4aM
         ns0T0akoLH3rt0J2nDg9UYaTIsClHHFmRvefJOSuUyX4RiBhUkVFB/snqHEFGrFqjW
         XyIYxBpyCvLUaFECjGxRTN/hrz58vX94tGTq1ui0S8HQgUzz89Lv+vOoAEVmP87ATb
         YbHfy9MiTEP5HAJ2cbpgxFCzuuqhKT01MSa6JOlSKiZ7NbuVqvZgiGH/wI+NJyT5eF
         qOhfMtmKG/bTw==
Date:   Sun, 1 May 2022 17:34:01 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     dan@dlrobertson.com, andy.shevchenko@gmail.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 8/9] iio: accel: bma400: Add debugfs register access
 support
Message-ID: <20220501173401.3ae7372d@jic23-huawei>
In-Reply-To: <20220420211105.14654-9-jagathjog1996@gmail.com>
References: <20220420211105.14654-1-jagathjog1996@gmail.com>
        <20220420211105.14654-9-jagathjog1996@gmail.com>
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

On Thu, 21 Apr 2022 02:41:04 +0530
Jagath Jog J <jagathjog1996@gmail.com> wrote:

> Add support to read/write byte from/to bma400 device from the userspace
> using debugfs interface.
> 
> Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
> ---
>  drivers/iio/accel/bma400_core.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
> index 073fff7d64a3..5b1b28972ef9 100644
> --- a/drivers/iio/accel/bma400_core.c
> +++ b/drivers/iio/accel/bma400_core.c
> @@ -1030,6 +1030,19 @@ static int bma400_write_event_config(struct iio_dev *indio_dev,
>  	}
>  }
>  
> +static int bma400_debugfs_reg_access(struct iio_dev *indio_dev,
> +				     unsigned int reg,
> +				     unsigned int writeval,
> +				     unsigned int *readval)
> +{
> +	struct bma400_data *data = iio_priv(indio_dev);
> +
> +	if (readval)
> +		return regmap_read(data->regmap, reg, readval);
> +	else
> +		return regmap_write(data->regmap, reg, writeval);

Hmm. So normally reads are safe, but not on this device because a read
of the status register has side effects.  As such, I'd either block
reading that register or simply not provide debugfs access at all.

Writes are often likely to break things, so users tend to be aware
of that...

Jonathan

> +}
> +
>  static int bma400_data_rdy_trigger_set_state(struct iio_trigger *trig,
>  					     bool state)
>  {
> @@ -1060,6 +1073,7 @@ static const struct iio_info bma400_info = {
>  	.write_raw_get_fmt = bma400_write_raw_get_fmt,
>  	.read_event_config = bma400_read_event_config,
>  	.write_event_config = bma400_write_event_config,
> +	.debugfs_reg_access = bma400_debugfs_reg_access,
>  };
>  
>  static const struct iio_trigger_ops bma400_trigger_ops = {

