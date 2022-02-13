Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E71804B3CAB
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 18:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237573AbiBMRxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 12:53:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbiBMRxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 12:53:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC475A584;
        Sun, 13 Feb 2022 09:53:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8A2CFB80B0E;
        Sun, 13 Feb 2022 17:53:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF9FBC004E1;
        Sun, 13 Feb 2022 17:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644774779;
        bh=kPHxeTgcg9NmBIAzq6Zcpzz0ekEcpp+pRXOIDMqRzhw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Yfg7avbQeAvZoIIXzV24s1tWEfcF5XFVC1hDW6+V6Nar/TQvPUDFqZlOCcJwIgo6L
         cM3Z/v2t2Lwfdx9IdyKMCsHNuFgFxqEAH/2c3/KdG312xiW3rqqUv85sRu9DZnGHYw
         2ot7Wi8AzlEBWmjQ0TKLrmZB92cWw54VpAMG9cHBEt4ybj427j5Xr1e/2aXkiieRFm
         Vjrj5s2RGNi3cAnse4/ZgPC3b/qiP7d5BT2RU+se5gzybbZ4CaEmmxCI5fsBQgM6tG
         gccd7RbCaZQ4wJNwZE4AqXXPvymW19SPRqtTqM3h/T+mBxeAq3udK5nxaWZ4HlWSqG
         P0wVCTVjCBmQw==
Date:   Sun, 13 Feb 2022 17:59:40 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Qing Wang <wangqing@vivo.com>
Cc:     Jyoti Bhayana <jbhayana@google.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: use div64_u64() instead of do_div()
Message-ID: <20220213175940.1066f5a8@jic23-huawei>
In-Reply-To: <1644395873-3937-1-git-send-email-wangqing@vivo.com>
References: <1644395873-3937-1-git-send-email-wangqing@vivo.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  9 Feb 2022 00:37:53 -0800
Qing Wang <wangqing@vivo.com> wrote:

> From: Wang Qing <wangqing@vivo.com>
> 
> do_div() does a 64-by-32 division.
> When the divisor is u64, do_div() truncates it to 32 bits, this means it
> can test non-zero and be truncated to zero for division.
> 
> fix do_div.cocci warning:
> do_div() does a 64-by-32 division, please consider using div64_u64 instead.
> 
> Signed-off-by: Wang Qing <wangqing@vivo.com>
These look correct to me.  Jyoti, please could give these a sanity check?

Thanks,

Jonathan

> ---
>  drivers/iio/common/scmi_sensors/scmi_iio.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/common/scmi_sensors/scmi_iio.c b/drivers/iio/common/scmi_sensors/scmi_iio.c
> index d538bf3..d6df5da
> --- a/drivers/iio/common/scmi_sensors/scmi_iio.c
> +++ b/drivers/iio/common/scmi_sensors/scmi_iio.c
> @@ -160,7 +160,7 @@ static int scmi_iio_set_odr_val(struct iio_dev *iio_dev, int val, int val2)
>  	mult = scnprintf(buf, sizeof(buf), "%llu", sf) - 1;
>  
>  	sec = int_pow(10, mult) * UHZ_PER_HZ;
> -	do_div(sec, uHz);
> +	div64_u64(sec, uHz);
>  	if (sec == 0) {
>  		dev_err(&iio_dev->dev,
>  			"Trying to set invalid sensor update value for sensor %s",
> @@ -237,10 +237,10 @@ static void convert_ns_to_freq(u64 interval_ns, u64 *hz, u64 *uhz)
>  	u64 rem, freq;
>  
>  	freq = NSEC_PER_SEC;
> -	rem = do_div(freq, interval_ns);
> +	rem = div64_u64(freq, interval_ns);
>  	*hz = freq;
>  	*uhz = rem * 1000000UL;
> -	do_div(*uhz, interval_ns);
> +	div64_u64(*uhz, interval_ns);
>  }
>  
>  static int scmi_iio_get_odr_val(struct iio_dev *iio_dev, int *val, int *val2)
> @@ -266,7 +266,7 @@ static int scmi_iio_get_odr_val(struct iio_dev *iio_dev, int *val, int *val2)
>  	mult = SCMI_SENS_CFG_GET_UPDATE_EXP(sensor_config);
>  	if (mult < 0) {
>  		sensor_interval_mult = int_pow(10, abs(mult));
> -		do_div(sensor_update_interval, sensor_interval_mult);
> +		div64_u64(sensor_update_interval, sensor_interval_mult);
>  	} else {
>  		sensor_interval_mult = int_pow(10, mult);
>  		sensor_update_interval =
> @@ -500,7 +500,7 @@ static u64 scmi_iio_convert_interval_to_ns(u32 val)
>  	mult = SCMI_SENS_INTVL_GET_EXP(val);
>  	if (mult < 0) {
>  		sensor_interval_mult = int_pow(10, abs(mult));
> -		do_div(sensor_update_interval, sensor_interval_mult);
> +		div64_u64(sensor_update_interval, sensor_interval_mult);
>  	} else {
>  		sensor_interval_mult = int_pow(10, mult);
>  		sensor_update_interval =

