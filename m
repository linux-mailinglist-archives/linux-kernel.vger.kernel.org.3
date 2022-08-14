Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC2059201D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 16:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239935AbiHNOVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 10:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239901AbiHNOVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 10:21:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE1FBE02;
        Sun, 14 Aug 2022 07:21:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 32855B80AEF;
        Sun, 14 Aug 2022 14:21:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B37D1C433D6;
        Sun, 14 Aug 2022 14:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660486888;
        bh=En3+VuMkA87sn2bRF2hyGdrJ4D418NzIDZAtlEGnp58=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=C+uK5dlBzLDq3i4IO4JuwnH47qUeo840PkcxnAS4TeCbLHyYQreJxEc5uLB96Jk21
         /mt7rLtkxgnlvMOML+I7IMOsmby2YfOQeYJbOzI6IvPaYXh9Hx12UfiiuvhkDMCBxn
         d+2WuRaewJC3rPZCdjBeLsth6hDv1qcoTWeplUazWw+vQP7NZWpstlm+nmb1+wWwVt
         xYaA3EvpOHdKrdSUCAZ5ceBHDQC5DRq5wsYAqoBgwWiGPWrc+csfwlLIDKPVhjKEMJ
         7S8j9xjwiTFavdAKONJahK7Xja5hlcQCALTGKCwIIUz0MozTWiHnDm1TYVOLrrGbex
         +IOBtsHHqAWyQ==
Date:   Sun, 14 Aug 2022 15:31:57 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Kent Gustavsson <kent@minoris.se>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/9] iio: adc: mcp3911: add support for buffers
Message-ID: <20220814153157.5e26ebd8@jic23-huawei>
In-Reply-To: <20220809073648.167821-6-marcus.folkesson@gmail.com>
References: <20220809073648.167821-1-marcus.folkesson@gmail.com>
        <20220809073648.167821-6-marcus.folkesson@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Tue,  9 Aug 2022 09:36:44 +0200
Marcus Folkesson <marcus.folkesson@gmail.com> wrote:

> Add support for buffers to make the driver fit for more usecases.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

One really trivial comment from me below if you are respinning anyway.

> +static irqreturn_t mcp3911_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct mcp3911 *adc = iio_priv(indio_dev);
> +	struct spi_transfer xfer[] = {
> +		{
> +			.tx_buf = &adc->tx_buf,
> +			.len = 1,
> +		}, {
> +			.rx_buf = adc->rx_buf,
> +			.len = sizeof(adc->rx_buf),
> +		},
> +	};
> +
> +	int scan_index;
> +	int i = 0;
> +	int ret;
> +
> +	mutex_lock(&adc->lock);
> +	adc->tx_buf = MCP3911_REG_READ(MCP3911_CHANNEL(0), adc->dev_addr);
> +	ret = spi_sync_transfer(adc->spi, xfer, ARRAY_SIZE(xfer));
> +	if (ret < 0) {
> +		dev_warn(&adc->spi->dev,
> +				"failed to get conversion data\n");
> +		goto out;
> +	}
> +
> +	for_each_set_bit(scan_index, indio_dev->active_scan_mask,
> +			indio_dev->masklength) {
> +		const struct iio_chan_spec *scan_chan = &indio_dev->channels[scan_index];
> +
> +		adc->scan.channels[i] = get_unaligned_be24(&adc->rx_buf[scan_chan->channel * 3]);
> +		i++;
> +	}
> +	iio_push_to_buffers_with_timestamp(indio_dev, &adc->scan,
> +			iio_get_time_ns(indio_dev));
					   iio_get_time_ns(indio_dev));

trivial: align with opening bracket unless the resulting line length is going to be very high as
a result.  I could be wrong but I thought checkpatch warned on this...

> +out:
> +	mutex_unlock(&adc->lock);
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
