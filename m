Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36B4C482FD2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 11:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbiACKRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 05:17:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbiACKRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 05:17:30 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E73C061761;
        Mon,  3 Jan 2022 02:17:30 -0800 (PST)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id AEA5D1F41D7C;
        Mon,  3 Jan 2022 10:17:28 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641205049;
        bh=ocbIJznQCqUQhCxdWJ6da5NCU1wQ2RLHpXKaimR61ok=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ApL3RROiIA61nFmL87rahNxhTzVwNJ0DT2FR1qj219bj/7tUqjnvi7LTQNmYKm27e
         ip+v5Kpugmu5RNIK6uE9z4AzqdPDB4KBnZXRLRuMujtYnX1kjtE0OkmTmy2izNwc9x
         iA0v+RDrLuJgZNSrPrUFabblu77dqk5ByeWjaqyyTUMxM22lmTKyw7gUCrakLiNfUH
         625aeY9ymm4Ovq50bhv7FzgpuO7M1m9AoC/zn7AkI+SNe3HdYGpOI1MVWLhy++dxo/
         fBkA+A17Q8sDytk0CIDZCg6nK4bUmXhFb4tB6uaMxpY/OnLMTDBfQHxATiwAo+Fg/K
         aYq/0PsjiDMiw==
Date:   Mon, 3 Jan 2022 11:17:25 +0100
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
Subject: Re: [PATCH v3 12/17] mtd: spinand: Add mtd_suspend() to disable
 Octal DTR mode at suspend
Message-ID: <20220103111725.3e3ce291@collabora.com>
In-Reply-To: <20220101074250.14443-13-a-nandan@ti.com>
References: <20220101074250.14443-1-a-nandan@ti.com>
        <20220101074250.14443-13-a-nandan@ti.com>
Organization: Collabora
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Jan 2022 13:12:45 +0530
Apurva Nandan <a-nandan@ti.com> wrote:

> The flash might or might not have gone a power-down during sleep.
> Hence, its SPI IO mode is unpredictable for the core at the time of
> resume. To ensure proper reinitialization during resume, disable the
> Octal DTR SPI IO mode and bring the flash to 1S-1S-1S mode when
> performing suspend using mtd_suspend().
> 
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> ---
>  drivers/mtd/nand/spi/core.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> index 2fd08085db6f..9d1c72634e5a 100644
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -1307,6 +1307,16 @@ static void spinand_mtd_resume(struct mtd_info *mtd)
>  	spinand_ecc_enable(spinand, false);
>  }
>  
> +static int spinand_mtd_suspend(struct mtd_info *mtd)
> +{
> +	struct spinand_device *spinand = mtd_to_spinand(mtd);
> +
> +	if (spinand->ctrl_ops->protocol == SPINAND_8D_8D_8D)
> +		return spinand_init_octal_dtr_disable(spinand);

Ok, so you're calling it here. I'd re-order commmits so that DTR
support is added after the suspend hook is defined, even if this hook
does nothing at first. This way you don't have an unused warning in the
previous commit, and most importantly, you don't enter 8DTR before
you're sure things will be set back to 1S when entering suspend.

> +
> +	return 0;
> +}
> +
>  static int spinand_init(struct spinand_device *spinand)
>  {
>  	struct device *dev = &spinand->spimem->spi->dev;
> @@ -1381,6 +1391,7 @@ static int spinand_init(struct spinand_device *spinand)
>  	mtd->_erase = spinand_mtd_erase;
>  	mtd->_max_bad_blocks = nanddev_mtd_max_bad_blocks;
>  	mtd->_resume = spinand_mtd_resume;
> +	mtd->_suspend = spinand_mtd_suspend;
>  
>  	if (nand->ecc.engine) {
>  		ret = mtd_ooblayout_count_freebytes(mtd);

