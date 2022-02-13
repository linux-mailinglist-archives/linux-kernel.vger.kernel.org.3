Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A064B3CC4
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 19:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235857AbiBMSLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 13:11:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbiBMSLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 13:11:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76E4112;
        Sun, 13 Feb 2022 10:11:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6BF99B80B59;
        Sun, 13 Feb 2022 18:11:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 782C4C004E1;
        Sun, 13 Feb 2022 18:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644775884;
        bh=RhzS4TyIJobSkSb/B7mFTwIDZOdt7aPYZTOXJ00X+OQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YIK94Vh2eNUoX3KWJCCrg+DT+eXajBH/h2Af20XKZsXlvRybC2/qytKSEM+z+gH0X
         1zl5aVq7zJ82cXW1pub+9bdrE3WvOJAPDnuer9eUKHkkVvOtOm88eH9rdNRUw3vLRX
         x77B0aoOrxG84Qk6pjH/Rgz+SmODQWR8oRvC+Cpau7XTZorAUxi9HgWTq3xE+7+H1+
         CKFWYxLHQrkSL7RE4a/BjNH/usyN96XLixPkrE5fRjk611meGhNZrofQpndwhSUlXK
         y3fUQIOOf/NWHh7GoE0YzVr6G/18UUBuS3mT9lKdI3SC4+Ntij95eo0cQGcARoRe98
         Q3e9bE/hUhwQw==
Date:   Sun, 13 Feb 2022 11:11:19 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Lh Kuo =?utf-8?B?6YOt5Yqb6LGq?= <lh.Kuo@sunplus.com>
Cc:     Tom Rix <trix@redhat.com>, Mark Brown <broonie@kernel.org>,
        Li-hao Kuo <lhjeff911@gmail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Wells Lu =?utf-8?B?5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>
Subject: Re: [PATCH] spi: Fix warning for Clang build
Message-ID: <YglJx3kgSFUH7nqX@dev-arch.archlinux-ax161>
References: <691d52b72f978f562136c587319852f5c65f08fe.1644460444.git.lhjeff911@gmail.com>
 <YgT0LMcDpCEYHFYg@sirena.org.uk>
 <99ab624e2af4414bb2a785f64f35bd95@sphcmbx02.sunplus.com.tw>
 <aaaefa2b-e043-2bf8-28aa-d89deb3fbc2a@redhat.com>
 <0b71842ec1b946729e74d73cbd354162@sphcmbx02.sunplus.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0b71842ec1b946729e74d73cbd354162@sphcmbx02.sunplus.com.tw>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2022 at 04:59:00AM +0000, Lh Kuo 郭力豪 wrote:
> Yes. I think the function can be simplified as follows
> 
> static int sp7021_spi_slave_transfer_one(struct spi_controller *ctlr, struct spi_device *spi,
> 				       struct spi_transfer *xfer)
> {
> 	struct sp7021_spi_ctlr *pspim = spi_master_get_devdata(ctlr);
> 	struct device *dev = pspim->dev;
> 	int ret;
> 
> 	mode = SP7021_SPI_IDLE;
> 	if (xfer->tx_buf && xfer->rx_buf) {
> 		dev_dbg(&ctlr->dev, "%s() wrong command\n", __func__);
> 		return -EINVAL;
> 	} else if (xfer->tx_buf) {
> 		xfer->tx_dma = dma_map_single(dev, (void *)xfer->tx_buf,
> 					      xfer->len, DMA_TO_DEVICE);
> 		if (dma_mapping_error(dev, xfer->tx_dma))
> 			return -ENOMEM;
> 		ret = sp7021_spi_slave_tx(spi, xfer);
> 	} else if (xfer->rx_buf) {
> 		xfer->rx_dma = dma_map_single(dev, xfer->rx_buf, xfer->len,
> 					      DMA_FROM_DEVICE);
> 		if (dma_mapping_error(dev, xfer->rx_dma))
> 			return -ENOMEM;
> 		ret = sp7021_spi_slave_rx(spi, xfer);
> 	}
> 
> 	if (xfer->tx_buf)
> 		dma_unmap_single(dev, xfer->tx_dma, xfer->len, DMA_TO_DEVICE);
> 	if (xfer->rx_buf)
> 		dma_unmap_single(dev, xfer->rx_dma, xfer->len, DMA_FROM_DEVICE);
> 
> 	spi_finalize_current_transfer(ctlr);
> 	return ret;
> }

Clang will still warn that ret is uninitialized when the else if
branches are not taken.

How about something like:

static int sp7021_spi_slave_transfer_one(struct spi_controller *ctlr, struct spi_device *spi,
				       struct spi_transfer *xfer)
{
	struct sp7021_spi_ctlr *pspim = spi_master_get_devdata(ctlr);
	struct device *dev = pspim->dev;
	int ret;

	if (xfer->tx_buf && !xfer->rx_buf) {
		xfer->tx_dma = dma_map_single(dev, (void *)xfer->tx_buf,
					      xfer->len, DMA_TO_DEVICE);
		if (dma_mapping_error(dev, xfer->tx_dma))
			return -ENOMEM;
		ret = sp7021_spi_slave_tx(spi, xfer);
		dma_unmap_single(dev, xfer->tx_dma, xfer->len, DMA_TO_DEVICE);
	} else if (xfer->rx_buf && !xfer->tx_buf) {
		xfer->rx_dma = dma_map_single(dev, xfer->rx_buf, xfer->len,
					      DMA_FROM_DEVICE);
		if (dma_mapping_error(dev, xfer->rx_dma))
			return -ENOMEM;
		ret = sp7021_spi_slave_rx(spi, xfer);
		dma_unmap_single(dev, xfer->rx_dma, xfer->len, DMA_FROM_DEVICE);
	} else {
		dev_dbg(&ctlr->dev, "%s() wrong command\n", __func__);
		return -EINVAL;
	}

	spi_finalize_current_transfer(ctlr);
	return ret;
}
