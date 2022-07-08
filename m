Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 866C156BA60
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 15:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237998AbiGHNLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 09:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237918AbiGHNLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 09:11:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5952A950;
        Fri,  8 Jul 2022 06:11:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 769BCB827B3;
        Fri,  8 Jul 2022 13:11:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98DBDC341C6;
        Fri,  8 Jul 2022 13:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657285879;
        bh=z5Uat0LSTUymLrXfMjnQF7MXtrkHeCBhETdVEQeiIOM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oZl+F8em0KnuzARWbL+MAL57Gpb5jRTAOeSNCYJZC4SO9wLHuMabsUEv20gscBmtL
         XPGu0ThuPm8hByuq4REd1UvwtTt82Hkpf7ulzYsdGA16VYhuBL7KaZjfMDC1s/l6TC
         L1wkeJd5quCCx1J3GLKKxPMq7xiFBsM2MOh6Ou5o=
Date:   Fri, 8 Jul 2022 15:11:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, jirislaby@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_msavaliy@quicinc.com,
        dianders@chromium.org, mka@chromium.org, swboyd@chromium.org
Subject: Re: [V3] tty: serial: qcom-geni-serial: Fix get_clk_div_rate() which
 otherwise could return a sub-optimal clock rate.
Message-ID: <Ysgs9MwCLyqeWgge@kroah.com>
References: <1657221457-32494-1-git-send-email-quic_vnivarth@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1657221457-32494-1-git-send-email-quic_vnivarth@quicinc.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2022 at 12:47:37AM +0530, Vijaya Krishna Nivarthi wrote:
> In the logic around call to clk_round_rate(), for some corner conditions,
> get_clk_div_rate() could return an sub-optimal clock rate. Also, if an
> exact clock rate was not found lowest clock was being returned.
> 
> Search for suitable clock rate in 2 steps
> a) exact match or within 2% tolerance
> b) within 5% tolerance
> This also takes care of corner conditions.
> 
> Fixes: c2194bc999d4 ("tty: serial: qcom-geni-serial: Remove uart frequency table. Instead, find suitable frequency with call to clk_round_rate")
> Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
> ---
> v3: simplified algorithm further, fixed robot compile warnings
> v2: removed minor optimisations to make more readable
> v1: intial patch contained slightly complicated logic
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 88 +++++++++++++++++++++--------------
>  1 file changed, 53 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index 2e23b65..ac2df1c 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -943,52 +943,71 @@ static int qcom_geni_serial_startup(struct uart_port *uport)
>  	return 0;
>  }
>  
> -static unsigned long get_clk_div_rate(struct clk *clk, unsigned int baud,
> -			unsigned int sampling_rate, unsigned int *clk_div)
> +static unsigned long find_clk_rate_in_tol(struct clk *clk, unsigned int desired_clk,
> +			unsigned int *clk_div, unsigned int percent_tol)
>  {
> -	unsigned long ser_clk;
> -	unsigned long desired_clk;
> -	unsigned long freq, prev;
> +	unsigned long freq;
>  	unsigned long div, maxdiv;
> -	int64_t mult;
> -
> -	desired_clk = baud * sampling_rate;
> -	if (!desired_clk) {
> -		pr_err("%s: Invalid frequency\n", __func__);
> -		return 0;
> -	}
> +	u64 mult;
> +	unsigned long offset, abs_tol, achieved;
>  
> +	abs_tol = div_u64((u64)desired_clk * percent_tol, 100);
>  	maxdiv = CLK_DIV_MSK >> CLK_DIV_SHFT;
> -	prev = 0;
> -
> -	for (div = 1; div <= maxdiv; div++) {
> -		mult = div * desired_clk;
> -		if (mult > ULONG_MAX)
> +	div = 1;
> +	while (div <= maxdiv) {
> +		mult = (u64)div * desired_clk;
> +		if (mult != (unsigned long)mult)
>  			break;
>  
> -		freq = clk_round_rate(clk, (unsigned long)mult);
> -		if (!(freq % desired_clk)) {
> -			ser_clk = freq;
> -			break;
> -		}
> +		offset = div * abs_tol;
> +		freq = clk_round_rate(clk, mult - offset);
>  
> -		if (!prev)
> -			ser_clk = freq;
> -		else if (prev == freq)
> +		/* Can only get lower if we're done */
> +		if (freq < mult - offset)
>  			break;
>  
> -		prev = freq;
> +		/*
> +		 * Re-calculate div in case rounding skipped rates but we
> +		 * ended up at a good one, then check for a match.
> +		 */
> +		div = DIV_ROUND_CLOSEST(freq, desired_clk);
> +		achieved = DIV_ROUND_CLOSEST(freq, div);
> +		if (achieved <= desired_clk + abs_tol &&
> +			achieved >= desired_clk - abs_tol) {
> +			*clk_div = div;
> +			return freq;
> +		}
> +
> +		div = DIV_ROUND_UP(freq, desired_clk);
>  	}
>  
> -	if (!ser_clk) {
> -		pr_err("%s: Can't find matching DFS entry for baud %d\n",
> -								__func__, baud);
> -		return ser_clk;
> +	return 0;
> +}
> +
> +static unsigned long get_clk_div_rate(struct clk *clk, unsigned int baud,
> +			unsigned int sampling_rate, unsigned int *clk_div)
> +{
> +	unsigned long ser_clk;
> +	unsigned long desired_clk;
> +
> +	desired_clk = baud * sampling_rate;
> +	if (!desired_clk) {
> +		pr_err("%s: Invalid frequency\n", __func__);

Note, this is a driver, ALWAYS use dev_err() and friends instead.

Also do not allow userspace to flood the kernel logs like this looks is
possible, this should just be dev_dbg().

And of course, never use __func__, it's not needed anymore for
dev_dbg().


> +		return 0;

Why if you have a error, are you returning 0?

>  	}
>  
> -	*clk_div = ser_clk / desired_clk;
> -	if (!(*clk_div))
> -		*clk_div = 1;
> +	/*
> +	 * try to find a clock rate within 2% tolerance, then within
> +	 */
> +	ser_clk = find_clk_rate_in_tol(clk, desired_clk, clk_div, 2);
> +	if (!ser_clk)
> +		ser_clk = find_clk_rate_in_tol(clk, desired_clk, clk_div, 5);
> +
> +	if (!ser_clk)
> +		pr_err("Couldn't find suitable clock rate for %lu\n", desired_clk);

return an error?

dev_err().

> +	else
> +		pr_debug("desired_clk-%lu, ser_clk-%lu, clk_div-%lu\n",
> +			desired_clk, ser_clk, *clk_div);

dev_dbg()?

Also, as the kernel test robot says, this does not build cleanly :(

thanks,

greg k-h
