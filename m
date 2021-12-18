Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 683DA479898
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 05:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbhLREfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 23:35:38 -0500
Received: from marcansoft.com ([212.63.210.85]:49502 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230053AbhLREff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 23:35:35 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 3A62441E2F;
        Sat, 18 Dec 2021 04:35:30 +0000 (UTC)
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Sven Peter <sven@svenpeter.dev>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20211212034726.26306-1-marcan@marcan.st>
 <20211212034726.26306-4-marcan@marcan.st>
 <CAHp75Vc17tOFTyMT2698BkENC23ocbX9QEc8-rj5=n3Lz5Pn=g@mail.gmail.com>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH 3/3] spi: apple: Add driver for Apple SPI controller
Message-ID: <d4c5a1ef-1904-b464-5abd-1f983fe417eb@marcan.st>
Date:   Sat, 18 Dec 2021 13:35:28 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vc17tOFTyMT2698BkENC23ocbX9QEc8-rj5=n3Lz5Pn=g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/12/2021 08.42, Andy Shevchenko wrote:
> On Sunday, December 12, 2021, Hector Martin <marcan@marcan.st
> <mailto:marcan@marcan.st>> wrote:
> 
>     This SPI controller is present in Apple SoCs such as the M1 (t8103) and
>     M1 Pro/Max (t600x). It is a relatively straightforward design with two
>     16-entry FIFOs, arbitrary transfer sizes (up to 2**32 - 1) and fully
>     configurable word size up to 32 bits. It supports one hardware CS line
>     which can also be driven via the pinctrl/GPIO driver instead, if
>     desired. TX and RX can be independently enabled.
> 
>     There are a surprising number of knobs for tweaking details of the
>     transfer, most of which we do not use right now. Hardware CS control
>     is available, but we haven't found a way to make it stay low across
>     multiple logical transfers, so we just use software CS control for now.
> 
> 
> So, AFAIU there is no limitation to the software CS lines (you actually
> meant GPIO, right?). 

No, this is software control over a single built-in CS line that is part
of the SPI peripheral. You can of course use the GPIO mechanism too,
which has no limit on the number of CS lines. That said, I don't think
Apple uses more than one CS per controller on any current machine, so we
just use internal CS.

>     +struct apple_spi {
>     +       void __iomem      *regs;        /* MMIO register address */
>     +       struct clk        *clk;         /* bus clock */
>     +       struct completion done;         /* wake-up from interrupt */
> 
> 
> Making it first member may save a few cycles on pointer arithmetic 

The completion? The IRQ handler has to access regs more often than the
completion, so it sounds like the current order should be faster.

>     +static int apple_spi_wait(struct apple_spi *spi, u32 fifo_bit, u32
>     xfer_bit, int poll)
>     +{
>     +       int ret = 0;
>     +
>     +       if (poll) {
>     +               u32 fifo, xfer;
>     +               unsigned long timeout = jiffies +
>     APPLE_SPI_TIMEOUT_MS * HZ / 1000;
>     +
>     +               do {
>     +                       fifo = reg_read(spi, APPLE_SPI_IF_FIFO);
>     +                       xfer = reg_read(spi, APPLE_SPI_IF_XFER);
>     +                       if (time_after(jiffies, timeout)) {
>     +                               ret = -ETIMEDOUT;
>     +                               break;
>     +                       }
>     +               } while (!((fifo & fifo_bit) || (xfer & xfer_bit)));
> 
> 
> You may use read_poll_timeout() with a specific _read() function, but it
> ma be not worth doing that, just compare and choose the best.

Probably not worth it; I could have a function read both registers and
stuff it into a u64, but I think it'd end up being about the same amount
of code in the end with the extra scaffolding.

>     +       case 4: {
>     +               const u32 *p = *tx_ptr;
>     +
>     +               while (words--)
>     +                       reg_write(spi, APPLE_SPI_TXDATA, *p++);
>     +               break;
>     +       }
>     +       default:
>     +               WARN_ON(1);
>     +       }
>     +
>     +       *tx_ptr = ((u8 *)*tx_ptr) + bytes_per_word * wrote;
> 
> 
> Not sure if it’s good written code from endianness / alignment handling
> perspective (while it may still work), perhaps rewrite it a bit?

I'm not entirely sure what the alignment guarantees for SPI buffers are.
Some drivers use unaligned accessors (e.g. spi-uniphier.c), while others
don't (e.g. spi-xilinx.c). That makes me think they're aligned in the
general case (and they usually would be if drivers intend to use them in
16-bit or 32-bit mode; hopefully they're allocated as arrays of those
units in that case).

spi.h has this to say:

 * In-memory data values are always in native CPU byte order, translated
 * from the wire byte order (big-endian except with SPI_LSB_FIRST).  So
 * for example when bits_per_word is sixteen, buffers are 2N bytes long
 * (@len = 2N) and hold N sixteen bit words in CPU byte order.

So endianness should be correct, at least for power of two word sizes. I
also believe it should work for non-POT word sizes, and assuming packing
doesn't change in SPI_LSB_FIRST, also for that case. It's kind of hard
to properly validate this without a real device that uses these modes,
so I think at this point we can just go with the current logic and if we
run into a problem in the future, we can fix it then :)

>     +       ctlr = spi_alloc_master(&pdev->dev, sizeof(struct apple_spi));
>     +       if (!ctlr) {
>     +               dev_err(&pdev->dev, "out of memory\n");
>     +               return -ENOMEM;
> 
> 
> It’s fine to use dev_err_probe() here as well

Yeah, I switched everything to dev_err_probe()

>     +       pm_runtime_set_active(&pdev->dev);
>     +       pm_runtime_enable(&pdev->dev);
>     +
>     +       pdev->dev.dma_mask = NULL;
> 
> 
> Why do you need this? It won’t work anyway in SPI case.

This was cargo-culted from spi-sifive and I noticed it actually causes a
warning to be printed on rebinding the driver to the same device;
already got rid of it :)

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
