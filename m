Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C16B94732B5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 18:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240499AbhLMRKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 12:10:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbhLMRKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 12:10:32 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A242DC061574;
        Mon, 13 Dec 2021 09:10:32 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 9200841982;
        Mon, 13 Dec 2021 17:10:28 +0000 (UTC)
To:     Mark Brown <broonie@kernel.org>
Cc:     Sven Peter <sven@svenpeter.dev>, Rob Herring <robh+dt@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211212034726.26306-1-marcan@marcan.st>
 <20211212034726.26306-4-marcan@marcan.st> <YbaIwa/9utI9SD1u@sirena.org.uk>
 <d566c897-ee7d-f32f-1548-57f037c69c89@marcan.st>
 <YbdtLFSrwjYcz/zz@sirena.org.uk>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH 3/3] spi: apple: Add driver for Apple SPI controller
Message-ID: <d87ae109-4b58-7465-b16e-3bf7c9d60f1f@marcan.st>
Date:   Tue, 14 Dec 2021 02:10:26 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YbdtLFSrwjYcz/zz@sirena.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/12/2021 00.56, Mark Brown wrote:
> On Mon, Dec 13, 2021 at 12:50:49PM +0900, Hector Martin wrote:
>> On 13/12/2021 08.41, Mark Brown wrote:
>>> On Sun, Dec 12, 2021 at 12:47:26PM +0900, Hector Martin wrote:
> 
>>>> @@ -0,0 +1,566 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +/*
>>>> + * Apple SoC SPI device driver
>>>> + *
> 
>>> Please keep the entire comment a C++ one so things look more
>>> intentional.
> 
>> I thought this pattern was pretty much the standard style.
> 
> It's common, especially given all the automated conversions, but ugly.

Sure, I'll change it if you insist :)

>>> Some brackets or an intermediate variable wouldn't hurt here, especially
>>> given the line length.
> 
>> How about this?
> 
>> return (200000 * t->bits_per_word * APPLE_SPI_FIFO_DEPTH / 2) <= t->speed_hz;
> 
> That's better but it's still a very long line which is half the issue.

I think it's quite readable at this point (especially with the comment 
above explaining it anyway). Note that these days a lot of people 
consider lines up to 100 chars okay in the kernel, and checkpatch uses 
that limit. Do you have a specific change in mind?

>>>> +static const struct of_device_id apple_spi_of_match[] = {
>>>> +	{ .compatible = "apple,spi", },
>>>> +	{}
>>>> +};
>>>> +MODULE_DEVICE_TABLE(of, apple_spi_of_match);
> 
>>> This is an awfully generic compatible.  It's common to use the SoC name
>>> for the IP compatibles when they're not otherwise identified?
> 
>> Apple like to keep blocks compatible across SoC generations - I think this
>> one dates, at least to some extent, to the original iPhone or thereabouts.
>> We do use per-SoC compatibles in the DTs in case we need to throw in per-SoC
>> quirks in the future ("apple,t8103-spi", "apple,spi"), but for drivers like
>> this we prefer to use generic compatibles as long as backwards compatibility
>> doesn't break. If Apple do something totally incompatible (like they did
>> with AIC2 in the latest chips), we'll bump to something like apple,spi2.
>> This happens quite rarely, so it makes sense to just keep things generic
>> except for these instances. That way old kernels will happily bind to the
>> block in newer SoCs if it is compatible.
> 
> There's currently a bit of a fashion for people with very old SPI blocks
> to make incompatible new versions recently, a lot of it seems to be
> driven by things like flash engine support.  Sometimes these things end
> up getting instantiated together as they have different purposes and the
> incompatibilties make the IPs larger.

I think if they haven't changed it by now they probably won't; e.g. they 
tacked on DMA using a coprocessor instead of changing the block itself. 
I don't think Apple uses SPI for anything performance-critical. They 
don't even bother with QSPI for the NOR flash (which is mostly only used 
for bootloaders and variable storage).

>> If we had a detailed lineage of what SoCs used what blocks and when things
>> changed we could try something else, like using the first SoC where the
>> specific block version was introduced, but we don't... so I think it makes
>> sense to just go with generic ones where we don't think things have changed
>> much since the dark ages. FWIW, Apple calls this one spi-1,spimc and claims
>> "spi-version = 1" and the driver has Samsung in the name... so the history
>> of this block definitely goes back quite a ways :-)
> 
> Have you done a contrast and compare with the Samsung driver?  Given
> both this and your comments above about this dating back to the original
> iPhone...

You mean the *two* Samsung drivers? :-)

It seems Samsung like to keep making up incompatible SPI blocks. This 
one shares a *few* bits in a *couple* registers with spi-s3c24xx driver, 
which point to a common lineage, but those registers aren't even at the 
same addresses. Not enough in common for it to make sense to try to use 
one driver for both (unlike with UART, where it was close enough to be 
added as a new Samsung UART variant, or I2C, where we could refactor the 
pasemi driver to add a platform backend alongside the existing PCI 
support and mostly use it as-is).

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
