Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF1C500BAE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 12:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237797AbiDNK7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 06:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiDNK7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 06:59:22 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C64775E4B;
        Thu, 14 Apr 2022 03:56:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A59F21F746;
        Thu, 14 Apr 2022 10:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1649933816; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qHwXlFiPhb+8uq3WbY4A9X/xnSchmkHO2lazKJa/1C0=;
        b=xTC5BJvI3EIrrso3wUf3g1Nr7SOacNh0j7iO37GlzhLh9dS93gEQUQ7+pC7UTv3Yxp9HHo
        7a95Me/ooKHX3mLKAkBbwlwnRM4Z11xTG3FPMqFZy85xh1nplyN07tFTpohWc1Q3zZHx3G
        SZ6KliHB8WrlgfICPUQ5iTNTJ5bMMH8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1649933816;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qHwXlFiPhb+8uq3WbY4A9X/xnSchmkHO2lazKJa/1C0=;
        b=HSr8JiCOgkenIg7wB2Xon9FwkRKUvHaA6puuu4B3JMM3Ug4KlPFkmiOeosnWoqQEzSxbJN
        ziYtJKRIz8IMNDDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8533E132C0;
        Thu, 14 Apr 2022 10:56:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NbhsIPj9V2JxCQAAMHmgww
        (envelope-from <iivanov@suse.de>); Thu, 14 Apr 2022 10:56:56 +0000
Date:   Thu, 14 Apr 2022 13:56:56 +0300
From:   "Ivan T. Ivanov" <iivanov@suse.de>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Phil Elwell <phil@raspberrypi.org>,
        kernel test robot <lkp@intel.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-clk@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2] clk: bcm2835: Round UART input clock up
Message-ID: <20220414105656.qt52zmr5vjmjdcxc@suse>
References: <20220404125113.80239-1-iivanov@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220404125113.80239-1-iivanov@suse.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

Please, could you take a look into following patch?

Thanks!
Ivan

On 04-04 15:51, Ivan T. Ivanov wrote:
> Subject: [PATCH v2] clk: bcm2835: Round UART input clock up
> Message-Id: <20220404125113.80239-1-iivanov@suse.de>
> 
> The UART clock is initialised to be as close to the requested
> frequency as possible without exceeding it. Now that there is a
> clock manager that returns the actual frequencies, an expected
> 48MHz clock is reported as 47999625. If the requested baudrate
> == requested clock/16, there is no headroom and the slight
> reduction in actual clock rate results in failure.
> 
> If increasing a clock by less than 0.1% changes it from ..999..
> to ..000.., round it up.
> 
> This is reworked version of a downstream fix:
> https://github.com/raspberrypi/linux/commit/ab3f1b39537f6d3825b8873006fbe2fc5ff057b7
> 
> Cc: Phil Elwell <phil@raspberrypi.org>
> Signed-off-by: Ivan T. Ivanov <iivanov@suse.de>
> ---
> Changes since v1
> Make bcm2835_clock_round() static to fix following warning
> when compiling for riscv:
> drivers/clk/bcm/clk-bcm2835.c:997:15: warning: no previous prototype for 'bcm2835_clock_round' [-Wmissing-prototypes]
> Reported-by: kernel test robot <lkp@intel.com>
> 
>  drivers/clk/bcm/clk-bcm2835.c | 30 ++++++++++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
> index 3ad20e75fd23..c29b643d1bf5 100644
> --- a/drivers/clk/bcm/clk-bcm2835.c
> +++ b/drivers/clk/bcm/clk-bcm2835.c
> @@ -502,6 +502,8 @@ struct bcm2835_clock_data {
>  	bool low_jitter;
>  
>  	u32 tcnt_mux;
> +
> +	bool round_up;
>  };
>  
>  struct bcm2835_gate_data {
> @@ -992,12 +994,30 @@ static long bcm2835_clock_rate_from_divisor(struct bcm2835_clock *clock,
>  	return temp;
>  }
>  
> +static unsigned long bcm2835_clock_round(unsigned long clk)
> +{
> +	unsigned long scaler;
> +
> +	/*
> +	 * If increasing a clock by less than 0.1% changes it
> +	 * from ..999.. to ..000.., round up.
> +	 */
> +	scaler = 1;
> +	while (scaler * 100000 < clk)
> +		scaler *= 10;
> +	if ((clk + scaler - 1) / scaler % 1000 == 0)
> +		clk = (clk / scaler + 1) * scaler;
> +
> +	return clk;
> +}
> +
>  static unsigned long bcm2835_clock_get_rate(struct clk_hw *hw,
>  					    unsigned long parent_rate)
>  {
>  	struct bcm2835_clock *clock = bcm2835_clock_from_hw(hw);
>  	struct bcm2835_cprman *cprman = clock->cprman;
>  	const struct bcm2835_clock_data *data = clock->data;
> +	unsigned long rate;
>  	u32 div;
>  
>  	if (data->int_bits == 0 && data->frac_bits == 0)
> @@ -1005,7 +1025,12 @@ static unsigned long bcm2835_clock_get_rate(struct clk_hw *hw,
>  
>  	div = cprman_read(cprman, data->div_reg);
>  
> -	return bcm2835_clock_rate_from_divisor(clock, parent_rate, div);
> +	rate = bcm2835_clock_rate_from_divisor(clock, parent_rate, div);
> +
> +	if (data->round_up)
> +		rate = bcm2835_clock_round(rate);
> +
> +	return rate;
>  }
>  
>  static void bcm2835_clock_wait_busy(struct bcm2835_clock *clock)
> @@ -2142,7 +2167,8 @@ static const struct bcm2835_clk_desc clk_desc_array[] = {
>  		.div_reg = CM_UARTDIV,
>  		.int_bits = 10,
>  		.frac_bits = 12,
> -		.tcnt_mux = 28),
> +		.tcnt_mux = 28,
> +		.round_up = true),
>  
>  	/* TV encoder clock.  Only operating frequency is 108Mhz.  */
>  	[BCM2835_CLOCK_VEC]	= REGISTER_PER_CLK(
> -- 
> 2.26.2
