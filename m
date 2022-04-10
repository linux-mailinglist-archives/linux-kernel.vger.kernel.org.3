Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3512C4FAE83
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 17:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237547AbiDJPgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 11:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234321AbiDJPgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 11:36:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943EC1AD87;
        Sun, 10 Apr 2022 08:34:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E49FE61037;
        Sun, 10 Apr 2022 15:34:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1B22C385A4;
        Sun, 10 Apr 2022 15:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649604873;
        bh=d+uM01OuUwblALd9OyCvHdPPxufQXqZfuues3P7KTDM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=B00rtpP0u4b2KzNKUMCqfDpgY7ahSZRpPreurrorsmjwWt0HaK2DQe5fWmrUufmU8
         RAZO+7FZbm6m3JnDL9R11U4aBRSNT3tRfJ3O6fCVVxJnjyirrAX210jvbXe+N88SYL
         UrWxtb22kGhq3vJN83pG99oBtWlFHTAFjkLSgnfevg51MUajLLBB2RX9w2kAS+JGVj
         4WraZLEqMffPGUGrbWQcKxpDx7PFFpoPlpUNjMJjoUC8qTtBJ6k/TRKzVEB1vmeFJv
         DdKJSE8sKwHXgbQUBSZwC3HLs0N7HNslP6qXzGa68SbfMjUUzirIeQQZf+aiG1dQBX
         ozvrK+e0gm91A==
Date:   Sun, 10 Apr 2022 16:42:24 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Hegbeli, Ciprian" <Ciprian.Hegbeli@analog.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] iio: meter: add ADE9078 driver
Message-ID: <20220410164224.6f25b063@jic23-huawei>
In-Reply-To: <BYAPR03MB4647634E63550B530FD063DB97E69@BYAPR03MB4647.namprd03.prod.outlook.com>
References: <20220217135140.5658-1-ciprian.hegbeli@analog.com>
        <20220217135140.5658-4-ciprian.hegbeli@analog.com>
        <20220217183333.000047fa@Huawei.com>
        <BYAPR03MB4647634E63550B530FD063DB97E69@BYAPR03MB4647.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Apr 2022 12:56:47 +0000
"Hegbeli, Ciprian" <Ciprian.Hegbeli@analog.com> wrote:

> > Hi Ciprian
> > 
> > I took a very quick end of day look so probably missed some stuff I'll
> > pick up on in v2.  Biggest issue is new ABI without docs. Various
> > other comments inline. Plus as already observed, please use full name
> > in from and SoB as they form part of the Developer Certificate of Origin.
> > 
> > Thanks,
> > 
> > Jonathan  
> 
> Hi Jonathan,
> 
> Thank you for the review. I wanted to answer the regmap related
> questions and maybe ask for some advice regarding them. There
> are some details in the messages below; the short versions is that
> it's doable but I will have to give up on some of the regmap 
> functionality and mask some of the basic regmap functions in driver 
> specific functions. These changes might make the code less
> readable.  
> 
> > > +static const struct reg_sequence ade9078_reg_sequence[] = {
> > > +	{ ADE9078_REG_PGA_GAIN, ADE9078_PGA_GAIN },
> > > +	{ ADE9078_REG_CONFIG0, ADE9078_CONFIG0 },
> > > +	{ ADE9078_REG_CONFIG1, ADE9078_CONFIG1 },
> > > +	{ ADE9078_REG_CONFIG2, ADE9078_CONFIG2 },
> > > +	{ ADE9078_REG_CONFIG3, ADE9078_CONFIG3 },
> > > +	{ ADE9078_REG_ACCMODE, ADE9078_ACCMODE },
> > > +	{ ADE9078_REG_ZX_LP_SEL, ADE9078_ZX_LP_SEL },
> > > +	{ ADE9078_REG_MASK0, ADE9078_MASK0 },
> > > +	{ ADE9078_REG_MASK1, ADE9078_MASK1 },
> > > +	{ ADE9078_REG_EVENT_MASK, ADE9078_EVENT_MASK },
> > > +	{ ADE9078_REG_WFB_CFG, ADE9078_WFB_CFG },
> > > +	{ ADE9078_REG_VLEVEL, ADE9078_VLEVEL },
> > > +	{ ADE9078_REG_DICOEFF, ADE9078_DICOEFF },
> > > +	{ ADE9078_REG_EGY_TIME, ADE9078_EGY_TIME },
> > > +	{ ADE9078_REG_EP_CFG, ADE9078_EP_CFG },
> > > +	{ ADE9078_REG_RUN, ADE9078_RUN_ON }
> > > +};  
> 
> CONFIG0, MASK0, MASK1, EVENT_MASK, VLEVEL, DICOEFF are 
> 32bit registers. 

Ah. I'd missed that.  Indeed changes the whole discussion.

> 
> > > +/*  
> > 
> > As mentioned below, I don't immediately understand why this can't
> > be done with appropriate standard regmap.  Perhaps you could give
> > more details of what is missing.  I'd like to see that added to
> > regmap if possible.
> >   
> 
> I started implementing the driver with a standard SPI and using 
> bulk read/write for the 32 bit registers. This however renders some 
> of the standard features of the regmap unusable (as far as I know).
> For example I can't use regmap_update_bits for 32 bit registers,
> which happens a few times, which I have marked in the code below.
> I could implement a substitute function in my driver for this, but that
> would complicate the code (in my opinion).   

Agreed - regmap doesn't fit well in my opinion when there are a mixture
of register sizes.  This may just be a case where you indeed should
just not use regmap at all.  It's challenging to make it work
and sometimes it's not sensible to bother.


> 
> > > + * ade9078_spi_write_reg() - ade9078 write register over SPI
> > > + * the data format for communicating with the ade9078 over SPI
> > > + * is very specific and can access both 32bit and 16bit registers
> > > + * @context:	void pointer to the SPI device
> > > + * @reg:	address of the of desired register
> > > + * @val:	value to be written to the ade9078
> > > + */
> > > +static int ade9078_spi_write_reg(void *context,
> > > +				 unsigned int reg,
> > > +				 unsigned int val)
> > > +{
> > > +	struct device *dev = context;
> > > +	struct spi_device *spi = to_spi_device(dev);
> > > +	struct ade9078_state *st = spi_get_drvdata(spi);  
> >   
> > > +
> > > +	u16 addr;
> > > +	int ret = 0;
> > > +	struct spi_transfer xfer[] = {
> > > +		{
> > > +			.tx_buf = st->tx,
> > > +		},
> > > +	};
> > > +
> > > +	addr = FIELD_PREP(ADE9078_REG_ADDR_MASK, reg);
> > > +
> > > +	put_unaligned_be16(addr, st->tx);
> > > +	put_unaligned_be32(val, &st->tx[2]);
> > > +
> > > +	if (reg > ADE9078_REG_RUN && reg < ADE9078_REG_VERSION) {
> > > +		put_unaligned_be16(val, &st->tx[2]);
> > > +		xfer[0].len = 4;
> > > +	} else {
> > > +		xfer[0].len = 6;
> > > +	}
> > > +
> > > +	ret = spi_sync_transfer(st->spi, xfer, ARRAY_SIZE(xfer));
> > > +	if (ret) {
> > > +		dev_err(&st->spi->dev, "problem when writing register  
> > 0x%x",  
> > > +			reg);
> > > +	}
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +/*
> > > + * ade9078_spi_write_reg() - ade9078 read register over SPI
> > > + * the data format for communicating with the ade9078 over SPI
> > > + * is very specific and can access both 32bit and 16bit registers
> > > + * @context:	void pointer to the SPI device
> > > + * @reg:	address of the of desired register
> > > + * @val:	value to be read to the ade9078
> > > + */
> > > +static int ade9078_spi_read_reg(void *context,
> > > +				unsigned int reg,
> > > +				unsigned int *val)
> > > +{
> > > +	struct device *dev = context;
> > > +	struct spi_device *spi = to_spi_device(dev);
> > > +	struct ade9078_state *st = spi_get_drvdata(spi);
> > > +
> > > +	u16 addr;
> > > +	int ret = 0;
> > > +	struct spi_transfer xfer[] = {
> > > +		{
> > > +			.tx_buf = st->tx,
> > > +			.len = 2,
> > > +		},
> > > +		{
> > > +			.rx_buf = st->rx,
> > > +		},
> > > +	};
> > > +
> > > +	addr = FIELD_PREP(ADE9078_REG_ADDR_MASK, reg) |
> > > +	       ADE9078_REG_READ_BIT_MASK;
> > > +
> > > +	put_unaligned_be16(addr, st->tx);
> > > +
> > > +	if (reg > ADE9078_REG_RUN && reg < ADE9078_REG_VERSION)
> > > +		xfer[1].len = 4;
> > > +	else
> > > +		xfer[1].len = 6;  
> > 
> > This doesn't look like a fixed length register which is expected
> > for regmap...  Also that len should just be the rx register which
> > you treat below as 16 bit and 32 bit (so 2 and 4, not 4 and 6).
> > 
> > Can the larger registers be treated as bulk reads of pairs of smaller ones?
> >   
> 
> It could, but I would still need an if or a type of "decoder" to determine
> if it is a 16 bit or 32 bit register, which means I still need a form of 
> ade9078_read_reg which selects between a regmap_read function
> or regmap_bulk_read. This goes for write as well. 

My assumption (wrong :) was that this was the normal 'large register' case
where we were actually looking at 2 registers that had to always be
read as a pair to make up the large register.  That isn't true here.

> 
> > > +
> > > +	ret = spi_sync_transfer(st->spi, xfer, ARRAY_SIZE(xfer));
> > > +	if (ret) {
> > > +		dev_err(&st->spi->dev, "problem when reading register  
> > 0x%x",  
> > > +			reg);
> > > +		goto err_ret;
> > > +	}
> > > +
> > > +	//registers which are 16 bits
> > > +	if (reg > 0x480 && reg < 0x4FE)
> > > +		*val = get_unaligned_be16(st->rx);
> > > +	else
> > > +		*val = get_unaligned_be32(st->rx);
> > > +
> > > +err_ret:
> > > +	return ret;
> > > +}
> > > +
> > > +/*
> > > + * ade9078_is_volatile_reg() - list of ade9078 registers which should use
> > > + * caching
> > > + * @dev:	device data
> > > + * @reg:	address of the of desired register
> > > + */
> > > +static bool ade9078_is_volatile_reg(struct device *dev, unsigned int reg)
> > > +{
> > > +	switch (reg) {
> > > +	case ADE9078_REG_STATUS0:
> > > +	case ADE9078_REG_STATUS1:
> > > +	case ADE9078_REG_MASK0:
> > > +	case ADE9078_REG_MASK1:
> > > +		return true;
> > > +	default:
> > > +		return false;
> > > +	}
> > > +}
> > > +  
> 
> I left this part in for context.
> 
> > > +/*
> > > + * ade9078_write_event_config() - IIO event configure to enable zero-  
> > crossing
> > 
> > All these function description comments should be valid kernel-doc.
> >   
> > > + * and zero-crossing timeout on voltage and current for each phases.  
> > These  
> > > + * events will also influence the trigger conditions for the buffer capture.
> > > + */
> > > +static int ade9078_write_event_config(struct iio_dev *indio_dev,
> > > +				      const struct iio_chan_spec *chan,
> > > +				      enum iio_event_type type,
> > > +				      enum iio_event_direction dir,
> > > +				      int state)
> > > +{
> > > +	struct ade9078_state *st = iio_priv(indio_dev);
> > > +	u32 interrupts;
> > > +	u32 number;
> > > +	int ret;
> > > +
> > > +	number = chan->channel;
> > > +
> > > +	switch (number) {
> > > +	case ADE9078_PHASE_A_NR:  
> > 
> > I would use a lookup on the phase into an array of structures.
> > The structure would then have fields for which bit to set etc
> > for a voltage channel and for a current channel.
> > 
> > That way this all becomes one bit of code and some const data
> > rather that 3 sets of near identical code. If you can make
> > this sort of thing data rather than code that is almost always
> > the best choice.
> >   
> > > +		if (chan->type == IIO_VOLTAGE) {
> > > +			if (state) {
> > > +				interrupts |= ADE9078_ST1_ZXVA_BIT;
> > > +				interrupts |= ADE9078_ST1_ZXTOVA_BIT;
> > > +				st->wfb_trg |=  
> > ADE9078_WFB_TRG_ZXVA_BIT;  
> > > +			} else {
> > > +				interrupts &= ~ADE9078_ST1_ZXVA_BIT;
> > > +				interrupts &= ~ADE9078_ST1_ZXTOVA_BIT;
> > > +				st->wfb_trg &=  
> > ~ADE9078_WFB_TRG_ZXVA_BIT;  
> > > +			}
> > > +		} else if (chan->type == IIO_CURRENT) {
> > > +			if (state) {
> > > +				interrupts |= ADE9078_ST1_ZXIA_BIT;
> > > +				st->wfb_trg |=  
> > ADE9078_WFB_TRG_ZXIA_BIT;  
> > > +			} else {
> > > +				interrupts &= ~ADE9078_ST1_ZXIA_BIT;
> > > +				st->wfb_trg &=  
> > ~ADE9078_WFB_TRG_ZXIA_BIT;  
> > > +			}
> > > +		}
> > > +		break;
> > > +	case ADE9078_PHASE_B_NR:
> > > +		if (chan->type == IIO_VOLTAGE) {
> > > +			if (state) {
> > > +				interrupts |= ADE9078_ST1_ZXVB_BIT;
> > > +				interrupts |= ADE9078_ST1_ZXTOVB_BIT;
> > > +				st->wfb_trg |=  
> > ADE9078_WFB_TRG_ZXVB_BIT;  
> > > +			} else {
> > > +				interrupts &= ~ADE9078_ST1_ZXVB_BIT;
> > > +				interrupts &= ~ADE9078_ST1_ZXTOVB_BIT;
> > > +				st->wfb_trg &=  
> > ~ADE9078_WFB_TRG_ZXVB_BIT;  
> > > +			}
> > > +		} else if (chan->type == IIO_CURRENT) {
> > > +			if (state) {
> > > +				interrupts |= ADE9078_ST1_ZXIB_BIT;
> > > +				st->wfb_trg |=  
> > ADE9078_WFB_TRG_ZXIB_BIT;  
> > > +			} else {
> > > +				interrupts &= ~ADE9078_ST1_ZXIB_BIT;
> > > +				st->wfb_trg &=  
> > ~ADE9078_WFB_TRG_ZXIB_BIT;  
> > > +			}
> > > +		}
> > > +		break;
> > > +	case ADE9078_PHASE_C_NR:
> > > +		if (chan->type == IIO_VOLTAGE) {
> > > +			if (state) {
> > > +				interrupts |= ADE9078_ST1_ZXVC_BIT;
> > > +				interrupts |= ADE9078_ST1_ZXTOVC_BIT;
> > > +				st->wfb_trg |=  
> > ADE9078_WFB_TRG_ZXVC_BIT;  
> > > +			} else {
> > > +				interrupts &= ~ADE9078_ST1_ZXVC_BIT;
> > > +				interrupts &= ~ADE9078_ST1_ZXTOVC_BIT;
> > > +				st->wfb_trg &=  
> > ~ADE9078_WFB_TRG_ZXVC_BIT;  
> > > +			}
> > > +		} else if (chan->type == IIO_CURRENT) {
> > > +			if (state) {
> > > +				interrupts |= ADE9078_ST1_ZXIC_BIT;
> > > +				st->wfb_trg |=  
> > ADE9078_WFB_TRG_ZXIC_BIT;  
> > > +			} else {
> > > +				interrupts &= ~ADE9078_ST1_ZXIC_BIT;
> > > +				st->wfb_trg &=  
> > ~ADE9078_WFB_TRG_ZXIC_BIT;  
> > > +			}
> > > +		}
> > > +		break;
> > > +	default:
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	ret = regmap_write(st->regmap, ADE9078_REG_STATUS1,  
> > GENMASK(31, 0));  
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	return regmap_update_bits(st->regmap, ADE9078_REG_MASK1,  
> > interrupts,  
> > > +				  interrupts);
> > > +}  
> 
> MASK1 is a 32 bit registers.
> 
> > > +/*
> > > + * ade9078_wfb_interrupt_setup() - Configures the wave form buffer  
> > interrupt  
> > > + * according to modes
> > > + * @st:		ade9078 device data
> > > + * @mode:	modes according to datasheet; values [0-2]
> > > + *
> > > + * This sets the interrupt register and other registers related to the
> > > + * interrupts according to mode [0-2] from the datasheet
> > > + */
> > > +static int ade9078_wfb_interrupt_setup(struct ade9078_state *st, u8  
> > mode)  
> > > +{
> > > +	int ret;
> > > +
> > > +	ret = regmap_write(st->regmap, ADE9078_REG_WFB_TRG_CFG, 0x0);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	if (mode == ADE9078_WFB_FULL_MODE || mode ==  
> > ADE9078_WFB_EN_TRIG_MODE) {
> > 
> > A switch statement would be cleaner here.
> >   
> > > +		ret = regmap_write(st->regmap,  
> > ADE9078_REG_WFB_PG_IRQEN,  
> > > +				   ADE9078_MODE_0_1_PAGE_BIT);
> > > +		if (ret)
> > > +			return ret;
> > > +	} else if (mode == ADE9078_WFB_C_EN_TRIG_MODE) {
> > > +		ret = regmap_write(st->regmap,  
> > ADE9078_REG_WFB_PG_IRQEN,  
> > > +				   ADE9078_MODE_2_PAGE_BIT);
> > > +		if (ret)
> > > +			return ret;
> > > +	}
> > > +
> > > +	ret = regmap_write(st->regmap, ADE9078_REG_STATUS0,  
> > GENMASK(31, 0));  
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	return regmap_update_bits(st->regmap, ADE9078_REG_MASK0,
> > > +				  ADE9078_ST0_PAGE_FULL_BIT,
> > > +				  ADE9078_ST0_PAGE_FULL_BIT);
> > > +	if (ret)  
> > 
> > Unreachable code...
> >   
> > > +		return ret;
> > > +
> > > +	return 0;
> > > +}  
> 
> MASK0 is a 32 bit registers.
> 
> > > +/*
> > > + * ade9078_buffer_postdisable() - after the iio is disable
> > > + * this will disable the ade9078 internal buffer for acquisition
> > > + * @indio_dev:	the IIO device
> > > + */
> > > +static int ade9078_buffer_postdisable(struct iio_dev *indio_dev)
> > > +{
> > > +	struct ade9078_state *st = iio_priv(indio_dev);
> > > +	u32 interrupts = 0;
> > > +	int ret;
> > > +
> > > +	ret = ade9078_en_wfb(st, false);
> > > +	if (ret) {
> > > +		dev_err(&st->spi->dev, "Post-disable wfb disable fail");
> > > +		return ret;
> > > +	}
> > > +
> > > +	ret = regmap_write(st->regmap, ADE9078_REG_WFB_TRG_CFG, 0x0);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	interrupts |= ADE9078_ST0_WFB_TRIG_BIT;
> > > +	interrupts |= ADE9078_ST0_PAGE_FULL_BIT;
> > > +
> > > +	return regmap_update_bits(st->regmap, ADE9078_REG_MASK0,  
> > interrupts, 0);  
> > > +	if (ret) {
> > > +		dev_err(&st->spi->dev, "Post-disable update maks0 fail");
> > > +		return ret;
> > > +	}
> > > +
> > > +	ret = regmap_write(st->regmap, ADE9078_REG_STATUS0,  
> > GENMASK(31, 0));  
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	return 0;  
> > 
> > return regmap_write()...
> >   
> > > +}  
> 
> MASK0 is updated again.
> 
> > > +/*
> > > + * ade9078_setup() - initial register setup of the ade9078
> > > + * @st:		ade9078 device data
> > > + */
> > > +static int ade9078_setup(struct ade9078_state *st)
> > > +{
> > > +	int ret = 0;  
> > The value here is never used.
> > 
> > Make sure you run a bunch of build tests including setting W=1 and ensuring
> > it
> > is clean + run at very least sparse.  Some of those tests would warn about
> > this.
> >   
> > > +
> > > +	ret = regmap_multi_reg_write(st->regmap, ade9078_reg_sequence,
> > > +				     ARRAY_SIZE(ade9078_reg_sequence));
> > > +	if (ret)
> > > +		return ret;
> > > +  
> 
> regmap_multi_reg_write is another function I don't think I could use at its 
> full extent if I switch to standard regmap with bulk transfers, because I 
> configure both 16 bit and 32 bit registres. The 32 bit registers configured
> in this set are listed above, near the begging of the e-mail.
> 
> > > +	msleep_interruptible(2);
> > > +
> > > +	ret = regmap_write(st->regmap, ADE9078_REG_STATUS0,  
> > GENMASK(31, 0));  
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret = regmap_write(st->regmap, ADE9078_REG_STATUS1,  
> > GENMASK(31, 0));
> > 
> > return regmap_write()
> >   
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	return ret;
> > > +}
> > > +  
> 
> I left this part in for context.
> 
> > > +/*
> > > + * Regmap configuration
> > > + * The register access of the ade9078 requires a 16 bit address
> > > + * with the read flag on bit 3. This is not supported by default
> > > + * regmap functionality, thus reg_read and reg_write have been
> > > + * replaced with custom functions  
> > 
> > How big would the changes needed to support this in the regmap
> > core be?   Superficially I can't immediately see why it won't work.
> > regmap appears to support setting flags in any of the address bytes
> > as it uses regmap_set_work_buf_flag_mask() internally and
> > that will set bits in any of the reg_bits/8 bytes.
> >   
> > > + */
> > > +static const struct regmap_config ade9078_regmap_config = {
> > > +	.reg_bits = 16,
> > > +	.val_bits = 32,
> > > +	.zero_flag_mask = true,
> > > +	.cache_type = REGCACHE_RBTREE,
> > > +	.reg_read = ade9078_spi_read_reg,
> > > +	.reg_write = ade9078_spi_write_reg,
> > > +	.volatile_reg = ade9078_is_volatile_reg,
> > > +};  
> 
> It dose work but as mentioned above it comes with an additional set
> of driver specific functions which will ultimately mask the underlying 
> regmap functions in the best case scenario.
> 
> All in all, I could implement the changes for V2 but given the fact that
> this would mean replacing some regmap functions, I decide to ask for your 
> opinion and some guidance first.

I'd just drop regmap and do things the old fashions (and more flexible)
way.  Whilst the device is register based - mixed sized registers are
a horrible hardware quirk so it doesn't map (afaik) to regmap.

Jonathan

> 
> - Ciprian

