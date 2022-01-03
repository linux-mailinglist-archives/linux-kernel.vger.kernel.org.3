Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0C4482FC0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 11:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbiACKF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 05:05:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiACKF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 05:05:27 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3A4C061761;
        Mon,  3 Jan 2022 02:05:27 -0800 (PST)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 574FE1F4202F;
        Mon,  3 Jan 2022 10:05:25 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641204325;
        bh=hntGeXyWsiKe+xbghtUjPiIlp26k8TkBB3PhDBV5vno=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZRdBI3CFXyyzoojXOtCsMSQGlX1rntSNsz4C0Kg7mxyUtp7ExCSjSRvt2VO/dsQ/b
         BLs+3PXLwrQj/0ADWrH0nLzmzu7+5L1vrcCBPPtUYbjPPcgPQBOoTcPdHckuDotKe0
         71M5lgaFPDMHVne249GHoQq9b4/RL0UNRynsIxiyx4KwHvIoMREvEEGoCbDWHhsdD3
         AB5jSZgQVSoARx3RkCNKK77HOI/3IKbHH9WgCZbcxruaBwsmGtZ7z0omRcGzAc7vwn
         mr0+w1iwMQ9Pi/Nb9564kJp2qsE2djOmTtSaHm9nMSqJuBK8L/+o64IBaTs4JDM4dP
         WwuGw+rGaTcRg==
Date:   Mon, 3 Jan 2022 11:05:21 +0100
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
Subject: Re: [PATCH v3 03/17] mtd: spinand: Add enum spinand_protocol to
 indicate current SPI IO mode
Message-ID: <20220103110521.72532e21@collabora.com>
In-Reply-To: <20220101074250.14443-4-a-nandan@ti.com>
References: <20220101074250.14443-1-a-nandan@ti.com>
        <20220101074250.14443-4-a-nandan@ti.com>
Organization: Collabora
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Jan 2022 13:12:36 +0530
Apurva Nandan <a-nandan@ti.com> wrote:

> diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
> index 69e06e741717..77927afcea0f 100644
> --- a/include/linux/mtd/spinand.h
> +++ b/include/linux/mtd/spinand.h
> @@ -194,6 +194,18 @@
>  		   SPI_MEM_OP_NO_DUMMY,					\
>  		   SPI_MEM_OP_DATA_OUT_DTR(len, buf, 8))
>  
> +/**
> + * enum spinand_protocol - List of SPI protocols to denote the op protocol and
> + *			   SPI NAND flash IO modes.
> + */
> +enum spinand_protocol {
> +	SPINAND_1S_1S_1S,
> +	SPINAND_2S_2S_2S,
> +	SPINAND_4S_4S_4S,
> +	SPINAND_8S_8S_8S,
> +	SPINAND_8D_8D_8D,

I'd just name those SPINAND_PROTO_<width><S or D> since what really
matters is the command cycle.
