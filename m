Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75C0548351A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 17:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbiACQuF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 3 Jan 2022 11:50:05 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:60049 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234917AbiACQt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 11:49:59 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 7F7CE240005;
        Mon,  3 Jan 2022 16:49:54 +0000 (UTC)
Date:   Mon, 3 Jan 2022 17:49:53 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-mtd@lists.infradead.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Cai Huoqing <caihuoqing@baidu.com>,
        Colin Ian King <colin.king@intel.com>,
        linux-kernel@vger.kernel.org (open list),
        linux-wireless@vger.kernel.org (open list:BROADCOM SPECIFIC AMBA DRIVER
        (BCMA)),
        bcm-kernel-feedback-list@broadcom.com (open list:BROADCOM STB NAND
        FLASH DRIVER)
Subject: Re: [PATCH 1/9] mtd: rawnand: brcmnand: Allow SoC to provide I/O
 operations
Message-ID: <20220103174953.40d7fa52@xps13>
In-Reply-To: <20211223002225.3738385-2-f.fainelli@gmail.com>
References: <20211223002225.3738385-1-f.fainelli@gmail.com>
        <20211223002225.3738385-2-f.fainelli@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

f.fainelli@gmail.com wrote on Wed, 22 Dec 2021 16:22:17 -0800:

> Allow a brcmnand_soc instance to provide a custom set of I/O operations
> which we will require when using this driver on a BCMA bus which is not
> directly memory mapped I/O. Update the nand_{read,write}_reg accordingly
> to use the SoC operations if provided.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c | 14 ++++++++++++--
>  drivers/mtd/nand/raw/brcmnand/brcmnand.h | 23 +++++++++++++++++++++++
>  2 files changed, 35 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> index f75929783b94..7a1673b1b1af 100644
> --- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> +++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> @@ -594,13 +594,18 @@ enum {
>  
>  static inline u32 nand_readreg(struct brcmnand_controller *ctrl, u32 offs)
>  {
> +	if (brcmnand_soc_has_ops(ctrl->soc))
> +		return brcmnand_soc_read(ctrl->soc, offs);
>  	return brcmnand_readl(ctrl->nand_base + offs);
>  }
>  
>  static inline void nand_writereg(struct brcmnand_controller *ctrl, u32 offs,
>  				 u32 val)
>  {
> -	brcmnand_writel(val, ctrl->nand_base + offs);
> +	if (brcmnand_soc_has_ops(ctrl->soc))
> +		brcmnand_soc_write(ctrl->soc, val, offs);
> +	else
> +		brcmnand_writel(val, ctrl->nand_base + offs);
>  }
>  
>  static int brcmnand_revision_init(struct brcmnand_controller *ctrl)
> @@ -766,13 +771,18 @@ static inline void brcmnand_rmw_reg(struct brcmnand_controller *ctrl,
>  
>  static inline u32 brcmnand_read_fc(struct brcmnand_controller *ctrl, int word)
>  {
> +	if (brcmnand_soc_has_ops(ctrl->soc))
> +		return brcmnand_soc_read(ctrl->soc, ~0);
>  	return __raw_readl(ctrl->nand_fc + word * 4);
>  }
>  
>  static inline void brcmnand_write_fc(struct brcmnand_controller *ctrl,
>  				     int word, u32 val)
>  {
> -	__raw_writel(val, ctrl->nand_fc + word * 4);
> +	if (brcmnand_soc_has_ops(ctrl->soc))
> +		brcmnand_soc_write(ctrl->soc, val, ~0);
> +	else
> +		__raw_writel(val, ctrl->nand_fc + word * 4);
>  }
>  
>  static inline void edu_writel(struct brcmnand_controller *ctrl,
> diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.h b/drivers/mtd/nand/raw/brcmnand/brcmnand.h
> index eb498fbe505e..a3f2ad5f6572 100644
> --- a/drivers/mtd/nand/raw/brcmnand/brcmnand.h
> +++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.h
> @@ -11,12 +11,19 @@
>  
>  struct platform_device;
>  struct dev_pm_ops;
> +struct brcmnand_io_ops;
>  
>  struct brcmnand_soc {
>  	bool (*ctlrdy_ack)(struct brcmnand_soc *soc);
>  	void (*ctlrdy_set_enabled)(struct brcmnand_soc *soc, bool en);
>  	void (*prepare_data_bus)(struct brcmnand_soc *soc, bool prepare,
>  				 bool is_param);
> +	const struct brcmnand_io_ops *ops;
> +};
> +
> +struct brcmnand_io_ops {
> +	u32 (*read_reg)(struct brcmnand_soc *soc, u32 offset);
> +	void (*write_reg)(struct brcmnand_soc *soc, u32 val, u32 offset);
>  };
>  
>  static inline void brcmnand_soc_data_bus_prepare(struct brcmnand_soc *soc,
> @@ -58,6 +65,22 @@ static inline void brcmnand_writel(u32 val, void __iomem *addr)
>  		writel_relaxed(val, addr);
>  }
>  
> +static inline bool brcmnand_soc_has_ops(struct brcmnand_soc *soc)
> +{
> +	return soc && soc->ops && soc->ops->read_reg && soc->ops->write_reg;
> +}
> +
> +static inline u32 brcmnand_soc_read(struct brcmnand_soc *soc, u32 offset)
> +{
> +	return soc->ops->read_reg(soc, offset);
> +}
> +
> +static inline void brcmnand_soc_write(struct brcmnand_soc *soc, u32 val,
> +				      u32 offset)
> +{
> +	soc->ops->write_reg(soc, val, offset);
> +}
> +

It might be worth looking into more optimized ways to do these checks,
in particular the read/write_reg ones because you're checking against
some static data which cannot be optimized out by the compiler but
won't change in the lifetime of the kernel.

Thanks,
Miquèl
