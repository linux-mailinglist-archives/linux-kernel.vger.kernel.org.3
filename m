Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40FD4E1C48
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 16:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245279AbiCTPd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 11:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241296AbiCTPd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 11:33:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE401C934;
        Sun, 20 Mar 2022 08:32:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C5D6B80DC3;
        Sun, 20 Mar 2022 15:32:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 414E6C340EE;
        Sun, 20 Mar 2022 15:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647790321;
        bh=I2fW2DdqNLY/ug4CBXSippa33Z0N+xv29/G1k8QsKmM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JOaOpGdu7fFqvE6fUZxBZxUMph0BWJx8Bp+4/wdUadaARpL4pZEh7k5yY88GIDvhm
         syJi9YcMeD5ar+0knenq/PS7RhiNC2wiwr90K3NRDkdcgBc36y9rr6euWE1gzUGagZ
         xpzGIIXu4IkvhQO+rmgAt22DZKWhPPxw6m8OYUt7ePUCkFQyxSKMvQ62oHWNGAJCcm
         jFSn78SgT17gTvMTuJh0L+3XA8RGFVGvHRHrAcWJeSIPdYpxD44uzww6ifErv2VNtl
         JXVZ9quP5busRu610z2LHoX3a7RFzhPIWHKO1Gqju7cJs2Us0FvEySKGLksTQrCHgZ
         48AYBcq+irnlw==
Date:   Sun, 20 Mar 2022 15:39:25 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     trix@redhat.com
Cc:     roan@protonic.nl, lars@metafoo.de, nathan@kernel.org,
        ndesaulniers@google.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v2] iio: scd4x: check return of scd4x_write_and_fetch
Message-ID: <20220320153925.12bb01eb@jic23-huawei>
In-Reply-To: <20220301025223.223223-1-trix@redhat.com>
References: <20220301025223.223223-1-trix@redhat.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Feb 2022 18:52:23 -0800
trix@redhat.com wrote:

> From: Tom Rix <trix@redhat.com>
> 
> Clang static analysis reports this problem
> scd4x.c:474:10: warning: The left operand of '==' is a
>   garbage value
>   if (val == 0xff) {
>       ~~~ ^
> val is only set from a successful call to scd4x_write_and_fetch()
> So check it's return.
> 
> Fixes: 49d22b695cbb ("drivers: iio: chemical: Add support for Sensirion SCD4x CO2 sensor")
> Signed-off-by: Tom Rix <trix@redhat.com>

Hi Tom,

This looks good to me.  Timing was a bit unfortunate so now I'll queue this up for post
rc1.  Hence applied to my local copy of fixes-togreg (which includes the stuff that
should go in during the merge window) but not pushed out until I can rebase on rc1.

Thanks,

Jonathan

> ---
> v2: rework return on error logic to be similar to existing code
> 
>  drivers/iio/chemical/scd4x.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/chemical/scd4x.c b/drivers/iio/chemical/scd4x.c
> index 20d4e7584e923..37143b5526ee6 100644
> --- a/drivers/iio/chemical/scd4x.c
> +++ b/drivers/iio/chemical/scd4x.c
> @@ -471,12 +471,15 @@ static ssize_t calibration_forced_value_store(struct device *dev,
>  	ret = scd4x_write_and_fetch(state, CMD_FRC, arg, &val, sizeof(val));
>  	mutex_unlock(&state->lock);
>  
> +	if (ret)
> +		return ret;
> +
>  	if (val == 0xff) {
>  		dev_err(dev, "forced calibration has failed");
>  		return -EINVAL;
>  	}
>  
> -	return ret ?: len;
> +	return len;
>  }
>  
>  static IIO_DEVICE_ATTR_RW(calibration_auto_enable, 0);

