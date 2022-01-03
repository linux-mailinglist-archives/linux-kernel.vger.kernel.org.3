Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E05EA482FE5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 11:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232592AbiACK1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 05:27:11 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46018 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbiACK1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 05:27:10 -0500
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id B56911F41E43;
        Mon,  3 Jan 2022 10:27:08 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641205629;
        bh=H68nuZ/N2vdplhQxlo9BuZ7az5CyApk7/FnMc7YI5gE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NA3qLUUuy65gMCeI8yM8y82ZuLycuKCi1Y14FHpnu82hL1GkXyl9yOWBxJRNa9POc
         CMLiCDjF22RLv2fPWP3RjOzYnQLE0q1WY1cfMMZg2g6E7UDTRRRHHFvJGdsPpX2oXI
         BZi7onjsBZVXnnOfdu03lmXqSjj6hvoGCJq3tBJXzUqTQDY9+IW7xQNYqrcCrbnhdt
         39+VqawxIMUwvUxIrc+ft5Ak1vqC4I3zNATExEQqFgzx7ez3dVmwxPKbbcA+6GFYi1
         /lh7Gvk11aMdwgTOWY8j4rLgh5k0Ghq2+9u6me2RPfQSydvKU7WW3zdi7q/vLXJ7Xl
         qKMK02jsZEWCQ==
Date:   Mon, 3 Jan 2022 11:27:05 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Apurva Nandan <a-nandan@ti.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Daniel Palmer <daniel@0x0f.com>,
        Alexander Lobakin <alobakin@pm.me>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <p.yadav@ti.com>
Subject: Re: [PATCH v3 15/17] mtd: spianand: winbond: Add change_mode()
 manufacturer_ops
Message-ID: <20220103112705.718c580c@collabora.com>
In-Reply-To: <20220101074250.14443-16-a-nandan@ti.com>
References: <20220101074250.14443-1-a-nandan@ti.com>
        <20220101074250.14443-16-a-nandan@ti.com>
Organization: Collabora
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Jan 2022 13:12:48 +0530
Apurva Nandan <a-nandan@ti.com> wrote:

> Add implementation of change_mode() for Winbond's manufacturer_ops,
> that executes octal_dtr_enable() and octal_dtr_disable() according
> to requested protocol.
> 
> Datasheet: https://www.winbond.com/export/sites/winbond/datasheet/W35N01JW_Datasheet_Brief.pdf
> 
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> ---
>  drivers/mtd/nand/spi/winbond.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
> index c7478faf6cee..d8eccb40c80f 100644
> --- a/drivers/mtd/nand/spi/winbond.c
> +++ b/drivers/mtd/nand/spi/winbond.c
> @@ -242,8 +242,33 @@ static int winbond_spinand_octal_dtr_disable(struct spinand_device *spinand)
>  	return 0;
>  }
>  
> +static int winbond_change_spi_mode(struct spinand_device *spinand,
> +				   const enum spinand_protocol protocol)
> +{
> +	if (spinand->protocol == protocol)
> +		return 0;
> +
> +	switch (spinand->protocol) {
> +	case SPINAND_1S_1S_1S:
> +		if (protocol == SPINAND_8D_8D_8D)
> +			return winbond_spinand_octal_dtr_enable(spinand);
> +		break;
> +
> +	case SPINAND_8D_8D_8D:
> +		if (protocol == SPINAND_1S_1S_1S)
> +			return winbond_spinand_octal_dtr_disable(spinand);
> +		break;
> +
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return -EOPNOTSUPP;

This version is slightly more concise:

	if (spinand->protocol == protocol)
		return 0;
	else if (spinand->protocol == SPINAND_1S && protocol ==	SPINAND_8D)
		return winbond_spinand_octal_dtr_enable(spinand);
	else if (spinand->protocol == SPINAND_8D && protocol ==	SPINAND_1S)
		return winbond_spinand_octal_dtr_disable(spinand);

	return -EOPNOTSUPP;

> +}
> +
>  static const struct spinand_manufacturer_ops winbond_spinand_manuf_ops = {
>  	.init = winbond_spinand_init,
> +	.change_mode = winbond_change_spi_mode,
>  };
>  
>  const struct spinand_manufacturer winbond_spinand_manufacturer = {

