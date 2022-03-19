Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A84FD4DE912
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 16:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243508AbiCSPjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 11:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243503AbiCSPjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 11:39:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293903969A;
        Sat, 19 Mar 2022 08:38:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BF0C3B80D34;
        Sat, 19 Mar 2022 15:38:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D7E3C340EC;
        Sat, 19 Mar 2022 15:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647704300;
        bh=eFjsIQ4Ug64AFymX45z0eMA4lTrZ6u2EWKvvJ+mTANw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uL0IrdkMqWRPctZNM1gasROGOjUeZ4CX9d/llxr2VC0bOj/d+Z5Ye0E5WfzOGZeUK
         Bdh6BjJumHg7IIira/oJbpfW8CfnWvAdMtt0MCGMSbgloEIVcfnWYNqzpwewjWIOTi
         Ut892q0b3yyOVRU9R6zFI6pOJGTu20VmuYfQIB4eTnlNRDgoHkXSlZW561uP9AF42e
         m8KCBee59pDkEgGXEVLIMvS0T5k/OnxTJf1PHsBvH1lzmB5ZqYQJ1bGgAgrEC/ow42
         MO5jB2M+gUVx5g2/d+CekDJpt0v3y+xXfuGWd3rTyHcnIN2oX5ZTSI21/L50Qv+6y6
         +i8fk7s2h7+Ng==
Date:   Sat, 19 Mar 2022 15:45:43 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     <alexandru.tachici@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/8] iio: adc: ad7124: Add update_scan_mode
Message-ID: <20220319154543.0ae8993e@jic23-huawei>
In-Reply-To: <20220318162722.51215-3-alexandru.tachici@analog.com>
References: <20220318162722.51215-1-alexandru.tachici@analog.com>
        <20220318162722.51215-3-alexandru.tachici@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Mar 2022 18:27:16 +0200
<alexandru.tachici@analog.com> wrote:

> From: Alexandru Tachici <alexandru.tachici@analog.com>
> 
> The callback .set_channel cannot be used to enable
> and disable multiple channels at once as they are
> presented in the active_scan_mask.
Trivial: Aim to wrap commit messages around 70ish chars
and whatever you pick be consistent.

Patch looks fine to me otherwise so if nothing else comes up, I
may rewrap these patch descriptions whilst applying.

Jonathan

> 
> By adding an update_scan_mode callback, every time the
> continuous mode is activated, channels will be enabled/disabled
> accordingly.
> 
> Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
> ---
>  drivers/iio/adc/ad7124.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> index 7249db2c4422..428ec3e257d7 100644
> --- a/drivers/iio/adc/ad7124.c
> +++ b/drivers/iio/adc/ad7124.c
> @@ -669,11 +669,32 @@ static const struct attribute_group ad7124_attrs_group = {
>  	.attrs = ad7124_attributes,
>  };
>  
> +static int ad7124_update_scan_mode(struct iio_dev *indio_dev,
> +				   const unsigned long *scan_mask)
> +{
> +	struct ad7124_state *st = iio_priv(indio_dev);
> +	bool bit_set;
> +	int ret;
> +	int i;
> +
> +	for (i = 0; i < st->num_channels; i++) {
> +		bit_set = test_bit(i, scan_mask);
> +		ret = ad7124_spi_write_mask(st, AD7124_CHANNEL(i),
> +					    AD7124_CHANNEL_EN_MSK,
> +					    AD7124_CHANNEL_EN(bit_set),
> +					    2);
> +		if (ret < 0)
> +			return ret;
> +	}
> +	return 0;
> +}
> +
>  static const struct iio_info ad7124_info = {
>  	.read_raw = ad7124_read_raw,
>  	.write_raw = ad7124_write_raw,
>  	.debugfs_reg_access = &ad7124_reg_access,
>  	.validate_trigger = ad_sd_validate_trigger,
> +	.update_scan_mode = ad7124_update_scan_mode,
>  	.attrs = &ad7124_attrs_group,
>  };
>  

