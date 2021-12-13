Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 894D4471FAF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 04:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbhLMDuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 22:50:55 -0500
Received: from marcansoft.com ([212.63.210.85]:60178 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229724AbhLMDuz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 22:50:55 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 896F34258C;
        Mon, 13 Dec 2021 03:50:50 +0000 (UTC)
To:     Mark Brown <broonie@kernel.org>
Cc:     Sven Peter <sven@svenpeter.dev>, Rob Herring <robh+dt@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211212034726.26306-1-marcan@marcan.st>
 <20211212034726.26306-4-marcan@marcan.st> <YbaIwa/9utI9SD1u@sirena.org.uk>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH 3/3] spi: apple: Add driver for Apple SPI controller
Message-ID: <d566c897-ee7d-f32f-1548-57f037c69c89@marcan.st>
Date:   Mon, 13 Dec 2021 12:50:49 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YbaIwa/9utI9SD1u@sirena.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review!

On 13/12/2021 08.41, Mark Brown wrote:
> On Sun, Dec 12, 2021 at 12:47:26PM +0900, Hector Martin wrote:
> 
> This looks pretty good - one small issue and several stylistic nits
> below.
> 
>> @@ -0,0 +1,566 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Apple SoC SPI device driver
>> + *
> 
> Please keep the entire comment a C++ one so things look more
> intentional.

I thought this pattern was pretty much the standard style.

$ grep -r -A1 "// SPDX" | grep '/\*' | wc -l
13512

$ grep -r -A1 "// SPDX" | grep -v SPDX | grep '//' | wc -l
705

>> +#define APPLE_SPI_DRIVER_NAME           "apple_spi"
> 
> This is referenced exactly once, just inline it.
Done. Also changed to "apple-spi" since all the other apple drivers use 
the dash convention.

> 
>> +	/* We will want to poll if the time we need to wait is
>> +	 * less than the context switching time.
>> +	 * Let's call that threshold 5us. The operation will take:
>> +	 *    bits_per_word * fifo_threshold / hz <= 5 * 10^-6
>> +	 *    200000 * bits_per_word * fifo_threshold <= hz
>> +	 */
>> +	return 200000 * t->bits_per_word * APPLE_SPI_FIFO_DEPTH / 2 <= t->speed_hz;
> 
> Some brackets or an intermediate variable wouldn't hurt here, especially
> given the line length.

How about this?

return (200000 * t->bits_per_word * APPLE_SPI_FIFO_DEPTH / 2) <= 
t->speed_hz;

>> +	struct apple_spi *spi = spi_controller_get_devdata(ctlr);
>> +	bool poll = apple_spi_prep_transfer(spi, t);
>> +	const void *tx_ptr = t->tx_buf;
>> +	void *rx_ptr = t->rx_buf;
>> +	unsigned int bytes_per_word = t->bits_per_word > 16 ? 4 : t->bits_per_word > 8 ? 2 : 1;
> 
> Please don't abuse the ternery operator like this - just write normal
> conditional statements, they're much easier to read.  In general the
> driver is a bit too enthusiastic about them and this one is next level.

Ack, I switched it to an if chain. That does mean I had to move the 
subsequent initializers out of the declarations section, so it's overall 
a bit more verbose.

	if (t->bits_per_word > 16)
		bytes_per_word = 4;
	else if (t->bits_per_word > 8)
		bytes_per_word = 2;
	else
		bytes_per_word = 1;

	words = t->len / bytes_per_word;
	remaining_tx = tx_ptr ? words : 0;
	remaining_rx = rx_ptr ? words : 0;

>> +static int apple_spi_remove(struct platform_device *pdev)
>> +{
>> +	struct spi_controller *ctlr = platform_get_drvdata(pdev);
>> +	struct apple_spi *spi = spi_controller_get_devdata(ctlr);
>> +
>> +	pm_runtime_disable(&pdev->dev);
>> +
>> +	/* Disable all the interrupts just in case */
>> +	reg_write(spi, APPLE_SPI_IE_FIFO, 0);
>> +	reg_write(spi, APPLE_SPI_IE_XFER, 0);
> 
> Since the driver registers with the SPI subsystem using devm and
> remove() gets run before devm gets unwound we still potentially have
> transfers running when the driver gets removed and this probably isn't
> going to cause them to go well - obviously it's an edge case and it's
> unclear when someone would be removing the driver but we still shouldn't
> do this.

With the other devm changes Sven suggested we don't need a remove 
function at all, so I've just gotten rid of it wholesale.

>> +static const struct of_device_id apple_spi_of_match[] = {
>> +	{ .compatible = "apple,spi", },
>> +	{}
>> +};
>> +MODULE_DEVICE_TABLE(of, apple_spi_of_match);
> 
> This is an awfully generic compatible.  It's common to use the SoC name
> for the IP compatibles when they're not otherwise identified?

Apple like to keep blocks compatible across SoC generations - I think 
this one dates, at least to some extent, to the original iPhone or 
thereabouts. We do use per-SoC compatibles in the DTs in case we need to 
throw in per-SoC quirks in the future ("apple,t8103-spi", "apple,spi"), 
but for drivers like this we prefer to use generic compatibles as long 
as backwards compatibility doesn't break. If Apple do something totally 
incompatible (like they did with AIC2 in the latest chips), we'll bump 
to something like apple,spi2. This happens quite rarely, so it makes 
sense to just keep things generic except for these instances. That way 
old kernels will happily bind to the block in newer SoCs if it is 
compatible.

If we had a detailed lineage of what SoCs used what blocks and when 
things changed we could try something else, like using the first SoC 
where the specific block version was introduced, but we don't... so I 
think it makes sense to just go with generic ones where we don't think 
things have changed much since the dark ages. FWIW, Apple calls this one 
spi-1,spimc and claims "spi-version = 1" and the driver has Samsung in 
the name... so the history of this block definitely goes back quite a 
ways :-)

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
