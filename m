Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1895A47D46B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 16:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343766AbhLVPzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 10:55:12 -0500
Received: from mail1.kuutio.org ([54.37.79.207]:43228 "EHLO mail1.kuutio.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241570AbhLVPzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 10:55:09 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail1.kuutio.org (Postfix) with ESMTP id 948BB1FDDB;
        Wed, 22 Dec 2021 16:55:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lemmela.net; h=
        content-language:content-transfer-encoding:content-type
        :content-type:in-reply-to:mime-version:user-agent:date:date
        :message-id:from:from:references:subject:subject:received
        :received; s=dkim; t=1640188505; x=1642780506; bh=t0tWYi1nQeiXbz
        jKOmHhA4b83kQIAoUejvQ9det/JvU=; b=kLRNOgVkSHKdFrlXAT0+KV4/+uyfS8
        AP46SkDuPVTSnH/WvJs75hYdZdk4lBuU7MkvZdZ4ixGfoLBBjPcOVeGmvuRGDCof
        zm/lSfENYuH7eZHi1tkkBpyNcawofBCau35fRjoeoLOhdz5OpLeeJ6ucxKkss53V
        +EI9z6Ww9YIPXifa3TthUNutIef3xs5MNI8AkXJT0oH2o9xT7izfbruVDtIwg8cr
        ixFbkQwSM4ARcDKAeRaaPVNX7R17K0B+Z+zRNT/+Mx3YuZ/pu7F9pYq4iG8t3ckH
        fghH6dyV5jptquY5HX6R3Wt9WdiTvD9KotCd27nVyExxhZjpuEYUAzxi6KYllK+q
        ENAU/JSJ7aLMn7Xma7sUYEJp81uevXUdLG4oa2QF13qr4pRFlatBh0Pdh/b3gxKX
        CSYjVC2abAbCS5zR5FLbKtyw7Hzt58PDQYD3l6wTDGpdaMg7/IAoxVHQnh3AX7mV
        ZUxrO/iA0L9Ksd6c6H+x13Pb12RMg+SqEgDCOB3glLMLKoHImrg2o0/8IaPVYxFT
        cppHlK0S6p23u7s+sDUE2RncIUeUVcXBiFs7bt3dw6Jv9FwxH4eKr1xGwEIkSqqW
        Q8NSk4X7ZpizkgaPlFaDcz1iaZCR/QiB0rq2M4oOiE2I5Kng24DwJis71xlQUnTV
        /8wlZCRCwjxMw=
X-Virus-Scanned: amavisd-new at kuutio.org
Received: from mail1.kuutio.org ([127.0.0.1])
        by localhost (mail1.kuutio.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id CmN2dwW8F8dw; Wed, 22 Dec 2021 16:55:05 +0100 (CET)
Received: from [IPv6:2001:998:13:e1::beee] (unknown [IPv6:2001:998:13:e1::beee])
        by mail1.kuutio.org (Postfix) with ESMTPSA id 8A8221FBFE;
        Wed, 22 Dec 2021 16:55:05 +0100 (CET)
Subject: Re: [PATCH 1/2] spi: ar934x: fix transfer size
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211222055958.1383233-1-oskari@lemmela.net>
 <20211222055958.1383233-2-oskari@lemmela.net>
 <YcMa1TIg3x3oBKBl@sirena.org.uk>
 <98a574a2-45c3-5d7c-6405-0cd279a81816@lemmela.net>
 <YcM9Ug3JhaxynLt0@sirena.org.uk>
From:   =?UTF-8?Q?Oskari_Lemmel=c3=a4?= <oskari@lemmela.net>
Message-ID: <6079952b-edef-4a3b-ff7d-16acee5821b8@lemmela.net>
Date:   Wed, 22 Dec 2021 17:55:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YcM9Ug3JhaxynLt0@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.12.2021 16.59, Mark Brown wrote:
> On Wed, Dec 22, 2021 at 04:27:36PM +0200, Oskari Lemmelä wrote:
>> On 22.12.2021 14.32, Mark Brown wrote:
>>> Does this actually materially affect what the hardware does?  How much
>>> data is transferred in an internal loop in the driver is completely
>>> immaterial, bits per word only matters for formatting of the transferred
>>> data.
>> I don't have logic analyzator to verify what hardware actual does.
>> I tested this with transferring 32bits to ATSAMD20J15 slave.
>> Running loop in 8bits or 16bits, transfer is done correctly without
>> any errors. When running loop in 24bits or 32bits directly I got
>> error from spi_sync_transfer.
> This doesn't inspire confidence TBH.  Given the lack of any change in
> the interaction with the hardware it doesn't seem likely that the word
> length is being changed at any point.  Possibly there's a bug somewhere
> that needs fixing but it's been misdiagnosed.
I did find datasheet for AR9344 and hardware supports shifting bits.

8.25.6 SPI Content to Shift Out or In (SPI_SHIFT_CNT_ADDR)
Address: 0x1FFF0014
Access: Read/Write
Reset: 0x0
-------------------------------------------
Bit  | Bit Name     | Desc
31   | SHIFT_EN     | Enables shifting data out
30   | SHIFT_CHNL   | If set to 1, enables chip select 2
29   |              | If set to 1, enables chip select 1
28   |              | If set to 1, enables chip select 0
27   | SHIFT_CLKOUT | Initial value of the clock signal
26   | TERMINATE    | When set to 1, deassert the chip select
25:7 | RES          | Reserved
6:0  | SHIFT_COUNT  | The number of bits to be shifted out or shifted in
on the data line

This is currently implemented in defines
#define AR934X_SPI_REG_SHIFT_CTRL       0x14
#define AR934X_SPI_SHIFT_EN             BIT(31)
#define AR934X_SPI_SHIFT_CS(n)          BIT(28 + (n))
#define AR934X_SPI_SHIFT_TERM           26
#define AR934X_SPI_SHIFT_VAL(cs, term, count)                   \
        (AR934X_SPI_SHIFT_EN | AR934X_SPI_SHIFT_CS(cs) |        \
        (term) << AR934X_SPI_SHIFT_TERM | (count))

In the transfer loop count value is set to number of bits per word.

reg = AR934X_SPI_SHIFT_VAL(spi->chip_select, term, trx_cur * 8);
iowrite32(reg, sp->base + AR934X_SPI_REG_SHIFT_CTRL);

So actually hardware support any word size between 1-32bits.
> Note also that the commit log is not good here, now I look at the code
> the driver only supports 8 bits per word at the minute and the change
> adds support for higher word lengths.  If you are seeing an issue that
> might point towards what it is.
Should I split this in two commits? First one fixing SPI_BPW_MASK(32) typo.
Then second commit which implements 8bits, 16bits and 24bits word sizes?
Or should driver implement support for any word size between 1-32bits?

Oskari
