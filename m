Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD6B04B54AE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 16:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354111AbiBNPXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 10:23:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351745AbiBNPXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 10:23:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3876D5FF3A;
        Mon, 14 Feb 2022 07:23:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DF595B81128;
        Mon, 14 Feb 2022 15:23:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15DB6C340E9;
        Mon, 14 Feb 2022 15:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644852188;
        bh=3JMGKBYxjkkG0LTrAck6ppMgEqfjxVZfvq6OMBpO98k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oafNM6xAgMlR5WohDsa8ouONMtU7R1+t4LtpR/F4KegzeJVIb+afKAVpXEK4K1YTI
         mUKDDvbFFR990noFbhEb6KW0opJ0VeUKqBiDm0xBOLjCIZYVw/zqeTp+mBBLdxcqP/
         0kg5AbLYPsxHRl2BIlQ6nCyYbyuOmgcYmteR8ye0rhg68taPEsfif9fpKOAZR8Q5MD
         jR9ClW+YNL2uVnu3DuFaIRx/lu7wSdLB2Npz54WTbqw7gbM3UI3fSFd3DCZo/T65Wa
         VXbHkCVEqzfJ0rsG2YA5cakP3+sqX8V7qlvzMRp9Yhvy/xnKUYHSKofdpSj0hyDDwU
         1M/UmkQRuXhgw==
Date:   Mon, 14 Feb 2022 08:23:04 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Li-hao Kuo <lhjeff911@gmail.com>
Cc:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, wells.lu@sunplus.com,
        lh.kuo@sunplus.com, trix@redhat.com
Subject: Re: [PATCH] spi: Fix warning for Clang build and simplify code
Message-ID: <Ygpz2M9sH+vAKqNL@dev-arch.archlinux-ax161>
References: <7d91e6ce29f9a8df2c53a47b4b977664020e237a.1644805060.git.lhjeff911@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d91e6ce29f9a8df2c53a47b4b977664020e237a.1644805060.git.lhjeff911@gmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 10:20:11AM +0800, Li-hao Kuo wrote:
> Clang build fails with
> spi-sunplus-sp7021.c:405:2: error: variable 'ret' is used
>   uninitialized whenever switch default is taken
>         default:
> 
> simplify code
> 
> Restore initializing ret. and add return error at default

This part of the commit message does not really match what the change
does anymore and I think that the "simplify code" part of the message
could be flushed out a little bit more, maybe something like:

"Hoist the calls to sp7021_spi_slave_tx() and sp7021_spi_slave_rx() into
the if statments and rewrite the if statements to explicitly allow only
unidirectional transfers."

?

> Fixes: 47e8fe57a66f ("spi: Modify irq request position and modify parameters")
> Reported-by: Tom Rix <trix@redhat.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Reported-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Li-hao Kuo <lhjeff911@gmail.com>

Regardless, the actual change itself looks fine. Feel free to carry
this tag on future revisions:

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  drivers/spi/spi-sunplus-sp7021.c | 38 +++++++++-----------------------------
>  1 file changed, 9 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/spi/spi-sunplus-sp7021.c b/drivers/spi/spi-sunplus-sp7021.c
> index ba5ed9f..ade7a0f 100644
> --- a/drivers/spi/spi-sunplus-sp7021.c
> +++ b/drivers/spi/spi-sunplus-sp7021.c
> @@ -69,12 +69,6 @@
>  #define SP7021_SPI_DATA_SIZE		(255)
>  #define SP7021_FIFO_DATA_LEN		(16)
>  
> -enum SP_SPI_MODE {
> -	SP7021_SLAVE_READ = 0,
> -	SP7021_SLAVE_WRITE = 1,
> -	SP7021_SPI_IDLE = 2,
> -};
> -
>  enum {
>  	SP7021_MASTER_MODE = 0,
>  	SP7021_SLAVE_MODE = 1,
> @@ -375,40 +369,26 @@ static int sp7021_spi_slave_transfer_one(struct spi_controller *ctlr, struct spi
>  {
>  	struct sp7021_spi_ctlr *pspim = spi_master_get_devdata(ctlr);
>  	struct device *dev = pspim->dev;
> -	int mode, ret;
> +	int ret;
>  
> -	mode = SP7021_SPI_IDLE;
> -	if (xfer->tx_buf && xfer->rx_buf) {
> -		dev_dbg(&ctlr->dev, "%s() wrong command\n", __func__);
> -		return -EINVAL;
> -	} else if (xfer->tx_buf) {
> +	if (xfer->tx_buf && !xfer->rx_buf) {
>  		xfer->tx_dma = dma_map_single(dev, (void *)xfer->tx_buf,
>  					      xfer->len, DMA_TO_DEVICE);
>  		if (dma_mapping_error(dev, xfer->tx_dma))
>  			return -ENOMEM;
> -		mode = SP7021_SLAVE_WRITE;
> -	} else if (xfer->rx_buf) {
> +		 ret = sp7021_spi_slave_tx(spi, xfer);
> +		 dma_unmap_single(dev, xfer->tx_dma, xfer->len, DMA_TO_DEVICE);
> +	} else if (xfer->rx_buf && !xfer->tx_buf) {
>  		xfer->rx_dma = dma_map_single(dev, xfer->rx_buf, xfer->len,
>  					      DMA_FROM_DEVICE);
>  		if (dma_mapping_error(dev, xfer->rx_dma))
>  			return -ENOMEM;
> -		mode = SP7021_SLAVE_READ;
> -	}
> -
> -	switch (mode) {
> -	case SP7021_SLAVE_WRITE:
> -		ret = sp7021_spi_slave_tx(spi, xfer);
> -		break;
> -	case SP7021_SLAVE_READ:
>  		ret = sp7021_spi_slave_rx(spi, xfer);
> -		break;
> -	default:
> -		break;
> -	}
> -	if (xfer->tx_buf)
> -		dma_unmap_single(dev, xfer->tx_dma, xfer->len, DMA_TO_DEVICE);
> -	if (xfer->rx_buf)
>  		dma_unmap_single(dev, xfer->rx_dma, xfer->len, DMA_FROM_DEVICE);
> +	} else {
> +		dev_dbg(&ctlr->dev, "%s() wrong command\n", __func__);
> +		return -EINVAL;
> +	}
>  
>  	spi_finalize_current_transfer(ctlr);
>  	return ret;
> -- 
> 2.7.4
> 
