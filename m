Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1E244DE8FF
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 16:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243455AbiCSPUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 11:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbiCSPUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 11:20:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C77227C4A;
        Sat, 19 Mar 2022 08:19:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1D9A5B801BE;
        Sat, 19 Mar 2022 15:19:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44030C340EC;
        Sat, 19 Mar 2022 15:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647703156;
        bh=voeVY0dquz3eQPqFCqVamA7LalOvjToF8Z2pWGbtxWg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FJMqL4o+aFjBGTHdCCYF1S/NQGb0Dsrj2eI6ODOAvQ1JfsYarwk4lPbmw0PHuruSt
         k/6XGWaOFPTC8PKJ4X8sEyVzSObOX4uHVHGN0JMmGSC3Dm8WqLfd0dZ+X96ZZ0/mD4
         wWdxlMZbihplQ8L7P5QBNVwvXD6vLCqTz/COUx71j70iUTbfe54UsbxS71Jit6/XVe
         vy1BNaPABNkWTLg3hP/MrTAz+CJennOnZHMe3mG7r9K52Q4rh8eLI6IIk2H4Yf1XVW
         BJcj7TzQGLJ1xLfN4xnfNnuL5Vi16mLazDUngjplgDeagHJVTY1dUow5Ndq39X1qdi
         DtRUATMPF4djA==
Date:   Sat, 19 Mar 2022 15:26:41 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: Re: [PATCH] iio:proximity:sx9324: Fix hardware gain read/write
Message-ID: <20220319152641.49d8b3e1@jic23-huawei>
In-Reply-To: <20220318204808.3404542-1-swboyd@chromium.org>
References: <20220318204808.3404542-1-swboyd@chromium.org>
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

On Fri, 18 Mar 2022 13:48:08 -0700
Stephen Boyd <swboyd@chromium.org> wrote:

Hi Stephen,


> There are four possible gain values according to sx9324_gain_vals[]: 1,
> 2, 4, and 8. When writing and reading the register the values are off by
> one. 
> The bits should be set according to this equation:
> 
> 	ilog2(<gain>) + 1
> 
> so that a gain of 8 is 0x3 in the register field and a gain of 4 is 0x2
> in the register field, etc. Fix up the functions.

So is the 0 value reserved?  I can't find an sx9324 datasheet but he
9320 is online and that seems to be the case there.  If so please state
that in this description as well.

> 
> Fixes: 4c18a890dff8 ("iio:proximity:sx9324: Add SX9324 support")
> Cc: Gwendal Grignou <gwendal@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/iio/proximity/sx9324.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
> index 0d9bbbb50cb4..a3c8e02f5a56 100644
> --- a/drivers/iio/proximity/sx9324.c
> +++ b/drivers/iio/proximity/sx9324.c
> @@ -379,7 +379,10 @@ static int sx9324_read_gain(struct sx_common_data *data,
>  	if (ret)
>  		return ret;
>  
> -	*val = 1 << FIELD_GET(SX9324_REG_PROX_CTRL0_GAIN_MASK, regval);
> +	regval = FIELD_GET(SX9324_REG_PROX_CTRL0_GAIN_MASK, regval);
> +	if (regval)

If 0 is reserved then I'd return and error code here to indicate
we don't know what the gain is rather than carrying on regardless.
Or is this going to cause problems as it will be an ABI change (error
return possible when it wasn't really before)?

> +		regval--;

> +	*val = 1 << regval;



>  
>  	return IIO_VAL_INT;
>  }
> @@ -725,7 +728,7 @@ static int sx9324_write_gain(struct sx_common_data *data,
>  	unsigned int gain, reg;
>  	int ret;
>  
> -	gain = ilog2(val);
> +	gain = ilog2(val) + 1;
>  	reg = SX9324_REG_PROX_CTRL0 + chan->channel / 2;
>  	gain = FIELD_PREP(SX9324_REG_PROX_CTRL0_GAIN_MASK, gain);
>  
> 
> base-commit: a8ee3b32f5da6c77a5ccc0e42c2250d61ba54fe0

