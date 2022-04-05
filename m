Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1414F4FD5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1839590AbiDFBFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 21:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573649AbiDETal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 15:30:41 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C178DDF47;
        Tue,  5 Apr 2022 12:28:41 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 235JRwNC034240;
        Tue, 5 Apr 2022 14:27:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1649186878;
        bh=ryPzySi+sY1PGhJYHg8EDNmmr6lLqwb9RbsI5qhyyH0=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=aaRdE5nnYIrJf5T+fvuEYm5nR9xQxzxlSRRn/11310CZYxzxNFRWA3N/1ujm2T/TD
         iQut+m7fr7M0lJZSODgNTzU3SajLEUSGBv+SS5169QFUIrTVCzmMAtYMs4uXO5c/Ao
         KSacvEvmH13gp+mUPEcdV2goz9m+jWLuc4CEsZn8=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 235JRw2p027239
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 5 Apr 2022 14:27:58 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 5
 Apr 2022 14:27:58 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 5 Apr 2022 14:27:58 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 235JRvNp005681;
        Tue, 5 Apr 2022 14:27:58 -0500
Date:   Wed, 6 Apr 2022 00:57:57 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
CC:     <linux-spi@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        Mark Brown <broonie@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-aspeed@lists.ozlabs.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Tao Ren <rentao.bupt@gmail.com>
Subject: Re: [PATCH v4 04/11] spi: aspeed: Add support for direct mapping
Message-ID: <20220405192757.v356zx2u4mpgpnlq@ti.com>
References: <20220325100849.2019209-1-clg@kaod.org>
 <20220325100849.2019209-5-clg@kaod.org>
 <20220330194548.zldbkaoctlhgwcl2@ti.com>
 <3e5ea70d-805a-ff30-663b-e802d9116a49@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3e5ea70d-805a-ff30-663b-e802d9116a49@kaod.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/04/22 09:11AM, Cédric Le Goater wrote:
> On 3/30/22 21:45, Pratyush Yadav wrote:
> > On 25/03/22 11:08AM, Cédric Le Goater wrote:
> > > Use direct mapping to read the flash device contents. This operation
> > > mode is called "Command mode" on Aspeed SoC SMC controllers. It uses a
> > > Control Register for the settings to apply when a memory operation is
> > > performed on the flash device mapping window.
> > > 
> > > If the window is not big enough, fall back to the "User mode" to
> > > perform the read.
> > > 
> > > Since direct mapping now handles all reads of the flash device
> > > contents, also use memcpy_fromio for other address spaces, such as
> > > SFDP.
> > > 
> > > Direct mapping for writes will come later when validated.
> > > 
> > > Reviewed-by: Joel Stanley <joel@jms.id.au>
> > > Tested-by: Joel Stanley <joel@jms.id.au>
> > > Tested-by: Tao Ren <rentao.bupt@gmail.com>
> > > Signed-off-by: Cédric Le Goater <clg@kaod.org>
> > > ---
> > >   drivers/spi/spi-aspeed-smc.c | 67 ++++++++++++++++++++++++++++++++++--
> > >   1 file changed, 65 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
> > > index 997ec2e45118..0951766baef4 100644
> > > --- a/drivers/spi/spi-aspeed-smc.c
> > > +++ b/drivers/spi/spi-aspeed-smc.c
> > > @@ -322,8 +322,8 @@ static int do_aspeed_spi_exec_op(struct spi_mem *mem, const struct spi_mem_op *o
> > >   		if (!op->addr.nbytes)
> > >   			ret = aspeed_spi_read_reg(chip, op);
> > >   		else
> > > -			ret = aspeed_spi_read_user(chip, op, op->addr.val,
> > > -						   op->data.nbytes, op->data.buf.in);
> > > +			memcpy_fromio(op->data.buf.in, chip->ahb_base + op->addr.val,
> > > +				      op->data.nbytes);
> > 
> > I think I commented on this earlier too, though I failed to respond to
> > your reply. Let me bring the topic back up. I think this can cause an
> > invalid memory address to be accessed. Not all SPI MEM consumers will
> > use dirmap APIs, and they won't use them all the time. For example, SPI
> > NOR can perform some operations to reset the flash before shutting down.
> > For example, SPI NOR turns off 4byte address mode during shutdown. This
> > will be a register read/write operation, which usually has a different
> > opcode.
> 
> It's only a small optimization for startup when the SFDP probing is done.
> There are quite a few reads which are large :
> 
>   spi-aspeed-smc 1e630000.spi: CE0 read OP 0x5a mode:1.1.1.1 naddr:0x3 ndummies:0x1 len:0x10
>   spi-aspeed-smc 1e630000.spi: CE0 read OP 0x5a mode:1.1.1.1 naddr:0x3 ndummies:0x1 len:0x10
>   spi-aspeed-smc 1e630000.spi: CE0 read OP 0x5a mode:1.1.1.1 naddr:0x3 ndummies:0x1 len:0x120
>   spi-aspeed-smc 1e630000.spi: CE0 read OP 0x5a mode:1.1.1.1 naddr:0x3 ndummies:0x1 len:0x40
>   spi-aspeed-smc 1e630000.spi: CE0 read OP 0x5a mode:1.1.1.1 naddr:0x3 ndummies:0x1 len:0x8

Is the overhead large enough to cause any significant delays? This would 
only happen once, it is not on a hot path.

Anyway, I had not noticed earlier that you set opcode, dummy, etc. in 
do_aspeed_spi_exec_op() so I was thinking you would always end up using 
the "main" read operation for this.

I am fine with this as long as you add range checks to make sure there 
are no overflows.

> 
> > 
> > So I think you should keep dirmap and exec_op() independent of each
> > other.
> 
> OK. I understand. It's not a problem as it works either way.
> 
> Thanks,
> 
> C.
> 
> 
> > >   	} else {
> > >   		if (!op->addr.nbytes)
> > >   			ret = aspeed_spi_write_reg(chip, op);
> > > @@ -403,10 +403,73 @@ static int aspeed_spi_chip_set_default_window(struct aspeed_spi_chip *chip)
> > >   	return chip->ahb_window_size ? 0 : -1;
> > >   }
> > > +static int aspeed_spi_dirmap_create(struct spi_mem_dirmap_desc *desc)
> > > +{
> > > +	struct aspeed_spi *aspi = spi_controller_get_devdata(desc->mem->spi->master);
> > > +	struct aspeed_spi_chip *chip = &aspi->chips[desc->mem->spi->chip_select];
> > > +	struct spi_mem_op *op = &desc->info.op_tmpl;
> > > +	u32 ctl_val;
> > > +	int ret = 0;
> > > +
> > > +	chip->clk_freq = desc->mem->spi->max_speed_hz;
> > > +
> > > +	/* Only for reads */
> > > +	if (op->data.dir != SPI_MEM_DATA_IN)
> > > +		return -EOPNOTSUPP;
> > > +
> > > +	if (desc->info.length > chip->ahb_window_size)
> > > +		dev_warn(aspi->dev, "CE%d window (%dMB) too small for mapping",
> > > +			 chip->cs, chip->ahb_window_size >> 20);
> > > +
> > > +	/* Define the default IO read settings */
> > > +	ctl_val = readl(chip->ctl) & ~CTRL_IO_CMD_MASK;
> > > +	ctl_val |= aspeed_spi_get_io_mode(op) |
> > > +		op->cmd.opcode << CTRL_COMMAND_SHIFT |
> > > +		CTRL_IO_DUMMY_SET(op->dummy.nbytes / op->dummy.buswidth) |
> > > +		CTRL_IO_MODE_READ;
> > > +
> > > +	/* Tune 4BYTE address mode */
> > > +	if (op->addr.nbytes) {
> > > +		u32 addr_mode = readl(aspi->regs + CE_CTRL_REG);
> > > +
> > > +		if (op->addr.nbytes == 4)
> > > +			addr_mode |= (0x11 << chip->cs);
> > > +		else
> > > +			addr_mode &= ~(0x11 << chip->cs);
> > > +		writel(addr_mode, aspi->regs + CE_CTRL_REG);
> > > +	}
> > > +
> > > +	/* READ mode is the controller default setting */
> > > +	chip->ctl_val[ASPEED_SPI_READ] = ctl_val;
> > > +	writel(chip->ctl_val[ASPEED_SPI_READ], chip->ctl);
> > > +
> > > +	dev_info(aspi->dev, "CE%d read buswidth:%d [0x%08x]\n",
> > > +		 chip->cs, op->data.buswidth, chip->ctl_val[ASPEED_SPI_READ]);
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +static ssize_t aspeed_spi_dirmap_read(struct spi_mem_dirmap_desc *desc,
> > > +				      u64 offset, size_t len, void *buf)
> > > +{
> > > +	struct aspeed_spi *aspi = spi_controller_get_devdata(desc->mem->spi->master);
> > > +	struct aspeed_spi_chip *chip = &aspi->chips[desc->mem->spi->chip_select];
> > > +
> > > +	/* Switch to USER command mode if mapping window is too small */
> > > +	if (chip->ahb_window_size < offset + len)
> > > +		aspeed_spi_read_user(chip, &desc->info.op_tmpl, offset, len, buf);
> > > +	else
> > > +		memcpy_fromio(buf, chip->ahb_base + offset, len);
> > > +
> > > +	return len;
> > > +}
> > > +
> > >   static const struct spi_controller_mem_ops aspeed_spi_mem_ops = {
> > >   	.supports_op = aspeed_spi_supports_op,
> > >   	.exec_op = aspeed_spi_exec_op,
> > >   	.get_name = aspeed_spi_get_name,
> > > +	.dirmap_create = aspeed_spi_dirmap_create,
> > > +	.dirmap_read = aspeed_spi_dirmap_read,
> > >   };
> > >   static void aspeed_spi_chip_set_type(struct aspeed_spi *aspi, unsigned int cs, int type)
> > > -- 
> > > 2.34.1
> > > 
> > 
> 

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
