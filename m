Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEDFA4A488F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 14:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378653AbiAaNsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 08:48:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358762AbiAaNsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 08:48:18 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6892BC061714;
        Mon, 31 Jan 2022 05:48:17 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id AF11E60015;
        Mon, 31 Jan 2022 13:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1643636895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=scmOkaI+TyjdmDOiGryj2VGEm54oTCgShwxEMvffMbI=;
        b=TYR4x20jM7rkpL42uk3v6X38JHHvKdvx9xC0tvx3KK0ckg4lL/O/Cr785l+KJ8gPTcmDNV
        RdHs/8edUCO2UoaQ93qfep88JSepBsPZJSDjpab2Af5XtasM0dBX+320Jvw2BCp5bEiski
        cYI3KvEeMeayMlwrVh5EX7UDpLVY7BicXCSxXeRwQILRQ/fZw1qWQUxJzraUz1qH81R1m5
        OE2L4GOEJnI7Ej2mc4Zab/u+y/cFTxuOHvyMw4Bo5ObXF2KYS3H1AfOC9w2ILPCGzDDLt3
        RmnQdcDcfTIWlMEHkwHj5S85oPbqjwa9J1qwDJZFg/Te9NSQXWgXBjSQu2aI4A==
Date:   Mon, 31 Jan 2022 14:48:13 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Takahiro Kuwano <tkuw584924@gmail.com>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] spi: spi-mem: check if data buffers are on stack
Message-ID: <20220131144813.725f0736@xps13>
In-Reply-To: <20220131114508.1028306-1-p.yadav@ti.com>
References: <20220131114508.1028306-1-p.yadav@ti.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pratyush,

p.yadav@ti.com wrote on Mon, 31 Jan 2022 17:15:08 +0530:

> The buffers passed in the data phase must be DMA-able. Programmers often
> don't realise this requirement and pass in buffers that reside on the
> stack. This can be hard to spot when reviewing code. Reject ops if their
> data buffer is on the stack to avoid this.
>=20
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> ---
>  drivers/spi/spi-mem.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
> index 37f4443ce9a0..b3793a2979ee 100644
> --- a/drivers/spi/spi-mem.c
> +++ b/drivers/spi/spi-mem.c
> @@ -207,6 +207,15 @@ static int spi_mem_check_op(const struct spi_mem_op =
*op)
>  	    !spi_mem_buswidth_is_valid(op->data.buswidth))
>  		return -EINVAL;
> =20
> +	/* Buffers must be DMA-able. */
> +	if (op->data.dir =3D=3D SPI_MEM_DATA_IN &&
> +	    object_is_on_stack(op->data.buf.in))
> +		return -EINVAL;
> +
> +	if (op->data.dir =3D=3D SPI_MEM_DATA_OUT &&
> +	    object_is_on_stack(op->data.buf.out))
> +		return -EINVAL;

Definitely a good idea.

This change will depend on the spi-mem-ecc series. I will soon merge
this branch into mtd/next so that any change that depends on it can be
merged in mtd/next directly, if nobody disagrees.

Thanks,
Miqu=C3=A8l
