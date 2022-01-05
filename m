Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5EAC485060
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 10:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239083AbiAEJwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 04:52:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239073AbiAEJwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 04:52:06 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22AB9C061761;
        Wed,  5 Jan 2022 01:52:06 -0800 (PST)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 1FCD01F44273;
        Wed,  5 Jan 2022 09:52:04 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641376324;
        bh=YOlZt4wlWDPgzl3ELAotsQoHSGbdiyMS1ERP5Zojv2w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HKDb9+W/5fgRZqr8su3iW5HhgJtmgHqUTGr2z6th03Wq99Z81PfsYztZKiC0UCzzM
         yGdjoUci7xc/pKwwMIsdaViofCFzkWbnxFIyADfjvfT9LrbtFr2Nu6qVhXOZmZVNE4
         YyT2XDAf8DHrBkJnZXT+7cuSIHkBFkYLx3ae37VAGU2WWBR5Ki3C/AdjpgN19QS0E8
         U68T+FyE1dDVvhbCpCNJpEIGs9IFitVgdNNDFYcHaGiw2Lw3ogWtRqBgbSY4S/f9pO
         YqONNzVL31SyK+F8G3c37n7t/zwpLhF4MvQN5cZEpABKc1XgmZLOhduvTGbdT1PwZM
         uonWeT/drGRGg==
Date:   Wed, 5 Jan 2022 10:52:00 +0100
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
Subject: Re: [PATCH v3 09/17] mtd: spinand: Add change_mode() in
 manufacturer_ops
Message-ID: <20220105105200.67037833@collabora.com>
In-Reply-To: <20220101074250.14443-10-a-nandan@ti.com>
References: <20220101074250.14443-1-a-nandan@ti.com>
        <20220101074250.14443-10-a-nandan@ti.com>
Organization: Collabora
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Jan 2022 13:12:42 +0530
Apurva Nandan <a-nandan@ti.com> wrote:

> Introduce change_mode() manufacturer_op to let the vendor provide the
> implementation of switching of SPI IO modes.
> 
> The method to switch to different SPI IO mode may vary across
> manufacturers. For example, for Winbond, Octal DTR is enabled by
> writing values to the volatile configuration register. So, let the
> manufacturer's code have their own implementation for switching to
> any given SPI IO mode. Manufacturer's code need to take care, if
> the requested protocol change is allowed/needed and how to apply
> it.
> 
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> ---
>  include/linux/mtd/spinand.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
> index 5dae0649f2fb..ad924271a248 100644
> --- a/include/linux/mtd/spinand.h
> +++ b/include/linux/mtd/spinand.h
> @@ -298,6 +298,7 @@ struct spinand_devid {
>  /**
>   * struct manufacurer_ops - SPI NAND manufacturer specific operations
>   * @init: initialize a SPI NAND device
> + * @change_mode: switch the SPI NAND flash to a specific SPI protocol
>   * @cleanup: cleanup a SPI NAND device
>   *
>   * Each SPI NAND manufacturer driver should implement this interface so that
> @@ -305,6 +306,8 @@ struct spinand_devid {
>   */
>  struct spinand_manufacturer_ops {
>  	int (*init)(struct spinand_device *spinand);
> +	int (*change_mode)(struct spinand_device *spinand,
> +			   const enum spinand_protocol protocol);

Protocol or mode? Pick one and stick to it. Given you already use
protocol elsewhere, maybe s/select_mode/select_protocol/.

>  	void (*cleanup)(struct spinand_device *spinand);
>  };
>  

