Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5AE55A3281
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 01:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbiHZXTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 19:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345227AbiHZXT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 19:19:29 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E7BE9A95;
        Fri, 26 Aug 2022 16:19:28 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id m5so3835185lfj.4;
        Fri, 26 Aug 2022 16:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=cuhcfpneE0iqUirTacYqWVnOAjrXs1Oi/XMfPrLa4Cc=;
        b=IhItt1sKQ1Rf3A4YMzt3fUbMifY8Vpl/L2kD8xlXTB72Okyxr013Utr1Bm7/5OWa1y
         W534j4ToouEeEnATiHaVYGxw9RbZG/244h0qye8tK569LI6rOTYb/xpFzXcnZMquQmBQ
         ZQ96SKxPKJ5zxdw/fWOj9AS2ObW9zBfJpur5uoNx1KUpDQJRLeIAl1f9gw84Ff6GaLCZ
         NzmJZoWUOWAdN64pExNTBIbcFZKg26FXUGqjA8XVCb0Q/WAuMMFvzLx1UvrzlUoI0jpS
         htJ/5JiSpoHct1L/FwC6YL2DRkNZXPR39GMuXZi3dfzlE9O0dhxNgdejDVWDoJqBBnxH
         O+YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=cuhcfpneE0iqUirTacYqWVnOAjrXs1Oi/XMfPrLa4Cc=;
        b=Z8bSz4SAjiQ/LW9T4SK++MonDVLDnZw11pCIwqvvb8xSr3ygnhHpwHWIi3/UXGZPC1
         im1wTHUR1+DorsQw8agCBtiA0XFMSR5bCZuagrk1x/y5kgK6FmgQSj2/Tlup688Yokiq
         AlyjEswbKSoBcNLtlnY57vYI4jC0WMLZiyxO8Jng9jqQF12pRUdqB7tOSZOkUBu0p9xg
         WzpvV5yg15jstPenD+9kltLuPIIjPLOeVs5cWW7G5kbh8aMsKotLd4S9yEYyKIBm9QAi
         h+2+v0YJcOB2zKF0L3NG8F5EpfZ62UnL/bhe0qdqD0xbthTF48JBleqXZkIflo4S9BPP
         OqzQ==
X-Gm-Message-State: ACgBeo3ZeRR7Yk0iyVaYnShO9rLbFOhrAOb7AYDC/DKV/xjKz/Hv8MWA
        wIM5oOALtdC2H+X2hAeWhoc=
X-Google-Smtp-Source: AA6agR5J4bz507tp7VEMT73Vc7nuKMHqc74gxzsvpv3lifpUTvH+PVkd+7E+wn5ybcK3SHkUM6eh2g==
X-Received: by 2002:a05:6512:20c5:b0:494:603c:1994 with SMTP id u5-20020a05651220c500b00494603c1994mr86973lfr.637.1661555966373;
        Fri, 26 Aug 2022 16:19:26 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id s9-20020ac24649000000b00492d108777dsm500442lfo.136.2022.08.26.16.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 16:19:25 -0700 (PDT)
Date:   Sat, 27 Aug 2022 02:19:22 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Sudip Mukherjee <sudip.mukherjee@sifive.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        greentime.hu@sifive.com, jude.onyenegecha@sifive.com,
        william.salmon@sifive.com, adnan.chowdhury@sifive.com,
        ben.dooks@sifive.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jeegar.lakhani@sifive.com
Subject: Re: [PATCH 09/11] spi: dw: prepare the transfer routine for enhanced
 mode
Message-ID: <20220826231922.4jr73tzpt3vwpxyd@mobilestation>
References: <20220802175755.6530-1-sudip.mukherjee@sifive.com>
 <20220802175755.6530-10-sudip.mukherjee@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802175755.6530-10-sudip.mukherjee@sifive.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022 at 06:57:53PM +0100, Sudip Mukherjee wrote:
> The transfer routine of dual/quad/octal is similar to standard SPI mode
> except that we do not need to worry about CS being de-asserted and we
> will be writing the address to a single FIFO location.

Please redesign this patch to having the IRQ-based transfers. For
instance you can just create a new dw_spi_enh_write_then_read() method
which would initialize the IRQs, set up a custom
dw_spi_enh_transfer_handler() method as transfer_handler (or perhaps
re-use the already available dw_spi_transfer_handler() method?) and
initiate the transfer by writing the command and address data to the
Tx FIFO.

Feel free to create some preparation patches if it's needed to reach the
goal.

-Sergey

> 
> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@sifive.com>
> ---
>  drivers/spi/spi-dw-core.c | 141 +++++++++++++++++++++++++++++++++-----
>  1 file changed, 125 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
> index 2564a2276572..d6afa75e7023 100644
> --- a/drivers/spi/spi-dw-core.c
> +++ b/drivers/spi/spi-dw-core.c
> @@ -712,6 +712,28 @@ static int dw_spi_wait_mem_op_done(struct dw_spi *dws)
>  	return 0;
>  }
>  
> +static void ext_transfer_delay(struct dw_spi *dws)
> +{
> +	struct spi_delay delay;
> +	unsigned long ns, us;
> +	u32 nents;
> +
> +	nents = dw_readl(dws, DW_SPI_TXFLR);
> +	ns = NSEC_PER_SEC / dws->current_freq * nents;
> +	ns *= dws->n_bytes * BITS_PER_BYTE;
> +	if (ns <= NSEC_PER_USEC) {
> +		delay.unit = SPI_DELAY_UNIT_NSECS;
> +		delay.value = ns;
> +	} else {
> +		us = DIV_ROUND_UP(ns, NSEC_PER_USEC);
> +		delay.unit = SPI_DELAY_UNIT_USECS;
> +		delay.value = clamp_val(us, 0, USHRT_MAX);
> +	}
> +	/* wait until there is some space in TX FIFO */
> +	while (!(dw_readl(dws, DW_SPI_SR) & DW_SPI_SR_TF_NOT_FULL))
> +		spi_delay_exec(&delay, NULL);
> +}
> +
>  static void dw_spi_stop_mem_op(struct dw_spi *dws, struct spi_device *spi)
>  {
>  	dw_spi_enable_chip(dws, 0);
> @@ -719,6 +741,82 @@ static void dw_spi_stop_mem_op(struct dw_spi *dws, struct spi_device *spi)
>  	dw_spi_enable_chip(dws, 1);
>  }
>  
> +static int enhanced_transfer(struct dw_spi *dws, struct spi_device *spi,
> +			     const struct spi_mem_op *op)
> +{
> +	u32 max, txw = 0, rxw;
> +	bool cs_done = false;
> +	void *buf = dws->tx;
> +	int ret;
> +
> +	/* Send cmd as 32 bit value */
> +	if (buf) {
> +		txw = *(u32 *)(buf);
> +		dw_write_io_reg(dws, DW_SPI_DR, txw);
> +		buf += 4;
> +		dws->tx_len--;
> +		if (op->addr.nbytes) {
> +			/*
> +			 * Send address as 32 bit value if address
> +			 * is present in the instruction.
> +			 */
> +			txw = *(u32 *)(buf);
> +			dw_write_io_reg(dws, DW_SPI_DR, txw);
> +			buf += 4;
> +			dws->tx_len--;
> +		}
> +	}
> +
> +	do {
> +		max = min_t(u32, dws->tx_len, dws->fifo_len -
> +			    dw_readl(dws, DW_SPI_TXFLR));
> +		while (max--) {
> +			if (buf) {
> +				txw = *(u8 *)(buf);
> +				buf += dws->n_bytes;
> +			}
> +			dw_write_io_reg(dws, DW_SPI_DR, txw);
> +			--dws->tx_len;
> +		}
> +		/* Enable CS after filling up FIFO */
> +		if (!cs_done) {
> +			dw_spi_set_cs(spi, false);
> +			cs_done = true;
> +		}
> +		ext_transfer_delay(dws);
> +		if (!dws->tx_len && !dws->rx_len) {
> +			/*
> +			 * We only need to wait for done if there is
> +			 * nothing to receive and there is nothing more
> +			 * to transmit. If we are receiving, then the
> +			 * wait cycles will make sure we wait.
> +			 */
> +			ret = dw_spi_wait_mem_op_done(dws);
> +			if (ret)
> +				return ret;
> +		}
> +	} while (dws->tx_len);
> +
> +	buf = dws->rx;
> +	while (dws->rx_len) {
> +		max = dw_spi_rx_max(dws);
> +
> +		while (max--) {
> +			rxw = dw_read_io_reg(dws, DW_SPI_DR);
> +			if (buf) {
> +				*(u8 *)(buf) = rxw;
> +				buf += dws->n_bytes;
> +			}
> +			--dws->rx_len;
> +		}
> +
> +		ret = dw_spi_check_status(dws, true);
> +		if (ret)
> +			return ret;
> +	}
> +	return 0;
> +}
> +
>  static void update_spi_ctrl0(struct dw_spi *dws, const struct spi_mem_op *op, bool enable)
>  {
>  	u32 spi_ctrlr0;
> @@ -846,25 +944,36 @@ static int dw_spi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
>  	 * manually restricting the SPI bus frequency using the
>  	 * dws->max_mem_freq parameter.
>  	 */
> -	local_irq_save(flags);
> -	preempt_disable();
> +	if (!enhanced_spi) {
> +		local_irq_save(flags);
> +		preempt_disable();
>  
> -	ret = dw_spi_write_then_read(dws, mem->spi);
> +		ret = dw_spi_write_then_read(dws, mem->spi);
>  
> -	local_irq_restore(flags);
> -	preempt_enable();
> +		local_irq_restore(flags);
> +		preempt_enable();
>  
> -	/*
> -	 * Wait for the operation being finished and check the controller
> -	 * status only if there hasn't been any run-time error detected. In the
> -	 * former case it's just pointless. In the later one to prevent an
> -	 * additional error message printing since any hw error flag being set
> -	 * would be due to an error detected on the data transfer.
> -	 */
> -	if (!ret) {
> -		ret = dw_spi_wait_mem_op_done(dws);
> -		if (!ret)
> -			ret = dw_spi_check_status(dws, true);
> +		/*
> +		 * Wait for the operation being finished and check the
> +		 * controller status only if there hasn't been any
> +		 * run-time error detected. In the former case it's
> +		 * just pointless. In the later one to prevent an
> +		 * additional error message printing since any hw error
> +		 * flag being set would be due to an error detected on
> +		 * the data transfer.
> +		 */
> +		if (!ret) {
> +			ret = dw_spi_wait_mem_op_done(dws);
> +			if (!ret)
> +				ret = dw_spi_check_status(dws, true);
> +		}
> +	} else {
> +		/*
> +		 * We donot need to disable IRQs as clock stretching will
> +		 * be enabled in enhanced mode which will prevent CS
> +		 * from being de-assert.
> +		 */
> +		ret = enhanced_transfer(dws, mem->spi, op);
>  	}
>  
>  	dw_spi_stop_mem_op(dws, mem->spi);
> -- 
> 2.30.2
> 
