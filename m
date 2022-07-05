Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D053E5679F0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 00:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbiGEWIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 18:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232039AbiGEWIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 18:08:04 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699CD1A04D;
        Tue,  5 Jul 2022 15:08:02 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id m18so4423171lfg.10;
        Tue, 05 Jul 2022 15:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=C4nM8dFqgRKoBkMSKdZmMo1Q9W7KBkM8pGXDOp4xFU4=;
        b=UfzfmS2TeLb1BcSD8f2Sk31OLRBg0W0lSQ3irheeWgh8akCSWPPjZOAnK1YV/RqjN7
         BIBMqzd2Khzo1lir4ACJs2b52SqjgjNwmmvK2aVJl1X9Kek5e0OcR1Gd5Nfn4dXGNlrP
         L/B6LhEFFh7hP14ZjzSKBQFWhbSEKYXXRAJ6lt+DKoXo28SDPxsp+4dEFXI84CcedJXn
         D1kf+Qbco5/kc/RwsU12vT2+9K6D7v8t+OiPw0Y6NnJkY1P5H+Pds0wFO2/baG/w4Ebi
         K/L339W5mu+qlQ5YGDtQEpSu4kVef9uXLRFgWwFBuVE5v2VJrU/NKGnjMXrIG5gm80I3
         nDNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C4nM8dFqgRKoBkMSKdZmMo1Q9W7KBkM8pGXDOp4xFU4=;
        b=YO4LGtjxpTkJBiTfYwyFG/7Er4WjjnaAbqtxPrZTyxNIZnquldld7XNs0p3J7NEu/7
         E6Ofm20V0jHRrebzDWnAOPb6QhwpxcnHX+QaUvxVKUJ3M0rC8E4RnA2/K072xe/Rhfsa
         v68ZE+kySd8Z1ihIunKe5VfRvB9u1mLSSbwLtkSqXymyio8EHcPSoVHKwtCxl8QzmcN8
         5YhZhDplPdre9vHGns+rYrCSBw3FjLBBJXyEIc3KbujkTNMiMHtABviPss9d8uWDsPZ5
         GC0NCAzcVX3aurotHPPd7xB4bgdyZAm008a7dzjif8auy9mJHOhyf2VvdTUB0w89n6Wv
         uZGA==
X-Gm-Message-State: AJIora/vHikWa1eySEME5gnO4Cq7g7lAgd8/1YI7EUxuMqhIYbqtvX4q
        MtK7+s7oh4+5IBc4JiT7rpw=
X-Google-Smtp-Source: AGRyM1uDQCSciT/a4nvKUv3rba8jCUpZIGNyaLZn1+dU4jYqNRcWb3sqx95TyMSiexttwcJpKhPi8g==
X-Received: by 2002:ac2:44a1:0:b0:484:1bbb:3d04 with SMTP id c1-20020ac244a1000000b004841bbb3d04mr2969580lfm.557.1657058880428;
        Tue, 05 Jul 2022 15:08:00 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id v23-20020a056512349700b0048600adb5d9sm18885lfr.10.2022.07.05.15.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 15:07:59 -0700 (PDT)
Date:   Wed, 6 Jul 2022 01:07:57 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-clk@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v5 6/8] clk: baikal-t1: Move reset-controls code
 into a dedicated module
Message-ID: <20220705220757.dwzmrx34t2nsxfzl@mobilestation>
References: <20220624141853.7417-1-Sergey.Semin@baikalelectronics.ru>
 <20220624141853.7417-7-Sergey.Semin@baikalelectronics.ru>
 <e0869ae1b10ec19eaf87dc5fa53498f82e7deaac.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0869ae1b10ec19eaf87dc5fa53498f82e7deaac.camel@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,

First of all thank you very much for your comments. I've been trying
to merge this series in for more than four months now. So lately I've
almost completely despaired to get it done any time soon. Getting your
comments gives me a hope to finally finish my work.

On Wed, Jun 29, 2022 at 05:12:25PM +0200, Philipp Zabel wrote:
> Hi Serge,
> 
> On Fr, 2022-06-24 at 17:18 +0300, Serge Semin wrote:
> > Before adding the directly controlled resets support it's reasonable to
> > move the existing resets control functionality into a dedicated object for
> > the sake of the CCU dividers clock driver simplification. After the new
> > functionality was added clk-ccu-div.c would have got to a mixture of the
> > weakly dependent clocks and resets methods. Splitting the methods up into
> > the two objects will make the code easier to read and maintain. It shall
> > also improve the code scalability (though hopefully we won't need this
> > part that much in the future).
> > 
> > As it was done for the CCU PLLs and Dividers the reset control
> > functionality in its turn has been split up into two sub-modules:
> > hw-interface and generic reset device description. This commit doesn't
> > provide any change in the CCU reset module semantics. As before it
> > supports the trigger-like CCU resets only, which are responsible for the
> > AXI-bus, APB-bus and SATA-ref blocks reset. The assert/de-assert-capable
> > reset controls support will be added in the next commit.
> > 
> > Note the CCU Clock dividers and resets functionality split up was possible
> > due to not having any side-effects (at least we didn't found ones) of the
> > regmap-based concurrent access of the common CCU dividers/reset CSRs.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > 
> > ---
> > 
> > Changelog v4:
> > - Completely split CCU Dividers and Resets functionality. (@Stephen)
> > ---
> >  drivers/clk/baikal-t1/Kconfig       |  12 +-
> >  drivers/clk/baikal-t1/Makefile      |   1 +
> >  drivers/clk/baikal-t1/ccu-div.c     |  19 ---
> >  drivers/clk/baikal-t1/ccu-div.h     |   4 +-
> >  drivers/clk/baikal-t1/ccu-rst.c     |  43 +++++
> >  drivers/clk/baikal-t1/ccu-rst.h     |  67 ++++++++
> >  drivers/clk/baikal-t1/clk-ccu-div.c | 101 +++---------
> >  drivers/clk/baikal-t1/clk-ccu-rst.c | 236 ++++++++++++++++++++++++++++
> 

> What is the reason for separating ccu-rst.c and clk-ccu-rst.c?
> 
> I expect implementing the reset ops and registering the reset
> controller in the same compilation unit would be easier.

From the very beginning of the Baikal-T1 driver live the Clock/Reset functionality
has been split up into two parts:
1. ccu-{div,pll}.c - Clock/Reset operations implementation.
2. clk-ccu-{div,pll}.c - Clock/Reset kernel interface implementation.
At least for the clk-part it has made the driver much easier to read.
Code in 1. provides the interface methods like
ccu_{div,pll}_hw_register() to register a clock provider corresponding
to the CCU divider/PLL of the particular type. Code in 2. uses these
methods to create the CCU Dividers/PLL clock descriptors and register
the of-based clocks in the system. The reset functionality was
redistributed in the same manner in the framework of the ccu-div.c and
clk-ccu-div.c modules.

A similar approach I was trying to utilize in the framework of the
separate CCU Resets implementation. Although it turned out to be not as
handy as it was for the clock-part due to the different clock and
reset subsystems API (clock subsystem provides a single clock
source based API, while the reset subsystem expects to have the whole
resets controller described). Anyway I've decided to preserve as much
similarities as possible for the sake of the code unification and
better readability/maintainability. Thus the reset lines control
methods have been placed in the ccu-rst.c object file, while the reset
control registration has been implemented in the clk-ccu-rst.c module.

Anyway if you insist on dropping the independent CCU reset IDs and
reset index functionality, then splitting the reset control driver
up will be even less justified since the reset_control_ops callbacks
implementation will shrink further down. So let's settle that part
first. If we get to agree to drop that functionality then indeed there
won't be much need in splitting the code up too.

> 
> > diff --git a/drivers/clk/baikal-t1/ccu-rst.c b/drivers/clk/baikal-t1/ccu-rst.c
> > new file mode 100644
> > index 000000000000..b355bf0b399a
> > --- /dev/null
> > +++ b/drivers/clk/baikal-t1/ccu-rst.c
> > @@ -0,0 +1,43 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (C) 2021 BAIKAL ELECTRONICS, JSC
> > + *
> > + * Authors:
> > + *   Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > + *
> > + * Baikal-T1 CCU Resets interface driver
> > + */
> > +
> > +#define pr_fmt(fmt) "bt1-ccu-rst: " fmt
> > +
> > +#include <linux/delay.h>
> > +#include <linux/kernel.h>
> > +#include <linux/printk.h>
> > +#include <linux/regmap.h>
> > +#include <linux/reset-controller.h>
> > +
> > +#include "ccu-rst.h"
> > +
> > +#define CCU_RST_DELAY_US		1
> > +
> > +static int ccu_rst_reset(struct reset_controller_dev *rcdev, unsigned long idx)
> > +{
> > +	struct ccu_rst *rst;
> > +
> > +	rst = ccu_rst_get_desc(rcdev, idx);
> > +	if (IS_ERR(rst)) {
> > +		pr_err("Invalid reset index %lu specified\n", idx);
> > +		return PTR_ERR(rst);
> > +	}
> 

> I don't think this is necessary, see my comments below. Since the reset
> ids are contiguous, just setting nr_resets and using the default
> .of_xlate should be enough to make sure this is never called with an
> invalid id.

Using non-contiguous !Clock! IDs turned to be unexpectedly handy. Due to
that design I was able to add the internal clock providers hidden from
the DTS users but still visible in the clocks hierarchy. It has made the
clocks implementation as detailed as possible and protected from the
improper clocks usage. It also simplified a new clock providers adding
in future (though there won't be clock sources left undefined in the
SoC after this patchset is applied).

All of that made me thinking that the same approach can be useful in
the framework of the CCU reset controls implementation too at the very
least for the code unification. Although after the next patch in the
series is applied there won't be resets left undefined in the
Baikal-T1 SoC. So from another side you might be partly right on
suggesting to drop the independent reset IDs/descriptors design and
just assume the IDs contiguousness.

So could you please confirm that you still insists on dropping it?

> 
> > +
> > +	regmap_update_bits(rst->sys_regs, rst->reg_ctl, rst->mask, rst->mask);
> 

> I would expect this to get sys_regs from data, which can be obtained
> from rcdev via container_of. The reg_ctl and mask could then be
> obtained from the ccu_rst_info array, data->rsts_info[idx].

Right. As long as we agreed to drop the independent reset
IDs/descriptor index functionality. Please see my comment above.

> 
> > +
> > +	/* The next delay must be enough to cover all the resets. */
> > +	udelay(CCU_RST_DELAY_US);
> > +
> > +	return 0;
> > +}
> [...]
> > +
> > +const struct reset_control_ops ccu_rst_ops = {
> 

> With ops and controller registration in the same .c file this could be
> static.

Can't argue with that. But please see my second comment.

> 
> > +	.reset = ccu_rst_reset,
> > +};
> > diff --git a/drivers/clk/baikal-t1/ccu-rst.h b/drivers/clk/baikal-t1/ccu-rst.h
> > new file mode 100644
> > index 000000000000..d03bae4b7a05
> > --- /dev/null
> > +++ b/drivers/clk/baikal-t1/ccu-rst.h
> > @@ -0,0 +1,67 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Copyright (C) 2021 BAIKAL ELECTRONICS, JSC
> > + *
> > + * Baikal-T1 CCU Resets interface driver
> > + */
> > +#ifndef __CLK_BT1_CCU_RST_H__
> > +#define __CLK_BT1_CCU_RST_H__
> > +
> > +#include <linux/of.h>
> > +#include <linux/regmap.h>
> > +
> > +struct ccu_rst_data;
> > +
> > +/*
> > + * struct ccu_rst_init_data - CCU Resets initialization data
> > + * @sys_regs: Baikal-T1 System Controller registers map.
> > + * @np: Pointer to the node with the System CCU block.
> > + */
> > +struct ccu_rst_init_data {
> > +	struct regmap *sys_regs;
> > +	struct device_node *np;
> > +};
> > +
> > +/*
> > + * struct ccu_rst - CCU Reset descriptor
> > + * @id: Reset identifier.
> > + * @reg_ctl: Reset control register base address.
> > + * @sys_regs: Baikal-T1 System Controller registers map.
> > + * @mask: Reset bitmask (normally it's just a single bit flag).
> > + */
> > +struct ccu_rst {
> > +	unsigned int id;
> 

> I'm not convinced this structure is necessary.
> It is just a copy of struct ccu_rst_info, but with an added regmap
> pointer per entry, which seems excessive since the regmap is the same
> for all resets.

Right. If we agree to drop the independent IDs/index functionality,
then this descriptor just won't be needed. So please
give me your answer to my question in the third comment first.

> 
> [...]
> > diff --git a/drivers/clk/baikal-t1/clk-ccu-rst.c b/drivers/clk/baikal-t1/clk-ccu-rst.c
> > new file mode 100644
> > index 000000000000..b10857f48b8b
> > --- /dev/null
> > +++ b/drivers/clk/baikal-t1/clk-ccu-rst.c
> > @@ -0,0 +1,236 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (C) 2021 BAIKAL ELECTRONICS, JSC
> > + *
> > + * Authors:
> > + *   Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > + *
> > + * Baikal-T1 CCU Resets domain driver
> > + */
> > +#define pr_fmt(fmt) "bt1-ccu-rst: " fmt
> > +
> > +#include <linux/bits.h>
> > +#include <linux/kernel.h>
> > +#include <linux/of.h>
> > +#include <linux/printk.h>
> > +#include <linux/regmap.h>
> > +#include <linux/reset-controller.h>
> > +#include <linux/slab.h>
> > +
> > +#include <dt-bindings/reset/bt1-ccu.h>
> > +
> > +#include "ccu-rst.h"
> > +
> > +#define CCU_AXI_MAIN_BASE		0x030
> > +#define CCU_AXI_DDR_BASE		0x034
> > +#define CCU_AXI_SATA_BASE		0x038
> > +#define CCU_AXI_GMAC0_BASE		0x03C
> > +#define CCU_AXI_GMAC1_BASE		0x040
> > +#define CCU_AXI_XGMAC_BASE		0x044
> > +#define CCU_AXI_PCIE_M_BASE		0x048
> > +#define CCU_AXI_PCIE_S_BASE		0x04C
> > +#define CCU_AXI_USB_BASE		0x050
> > +#define CCU_AXI_HWA_BASE		0x054
> > +#define CCU_AXI_SRAM_BASE		0x058
> > +
> > +#define CCU_SYS_SATA_REF_BASE		0x060
> > +#define CCU_SYS_APB_BASE		0x064
> > +
> > +#define CCU_RST_TRIG(_id, _base, _ofs)		\
> > +	{					\
> > +		.id = _id,			\
> 

> I think the _id parameter and id field could be dropped.

ditto

> 
> > +		.base = _base,			\
> > +		.mask = BIT(_ofs),		\
> > +	}
> > +
> > +struct ccu_rst_info {
> > +	unsigned int id;
> 

> This could be dropped.

ditto

> 
> > +	unsigned int base;
> > +	unsigned int mask;
> 

> Are there actually resets that require setting/clearing multiple bits,
> or is this theoretical?

The next patch in this series adds the reset controls implemented in
the framework of the same CSRs. So the base and mask fields are
required in the info array.

> 
> > +};
> > +
> > +struct ccu_rst_data {
> > +	struct device_node *np;
> 

> This is already in rcdev.of_node, no need to carry a copy.

Ok.

> 
> > +	struct regmap *sys_regs;
> > +
> > +	unsigned int rsts_num;
> 

> Same as above, this is already in rcdev.nr_resets.

Ok.

> 
> > +	const struct ccu_rst_info *rsts_info;
> > +	struct ccu_rst *rsts;
> 

> This is not neccessary if you use sys_regs and rsts_info in the reset
> ops.

Right. rsts can be dropped if the contiguous IDs are implied.

> 
> > +
> > +	struct reset_controller_dev rcdev;
> > +};
> > +#define to_ccu_rst_data(_rcdev) container_of(_rcdev, struct ccu_rst_data, rcdev)
> > +
> > +/*
> > + * Each AXI-bus clock divider is equipped with the corresponding clock-consumer
> > + * domain reset (it's self-deasserted reset control).
> > + */
> > +static const struct ccu_rst_info axi_rst_info[] = {
> > +	CCU_RST_TRIG(CCU_AXI_MAIN_RST, CCU_AXI_MAIN_BASE, 1),
> 

> This could be:
> 
> 	[CCU_AXI_MAIN_RST] = CCU_RST_TRIG(CCU_AXI_MAIN_BASE, 1),

Can't argue with that if we get to agree to drop the independent
reset IDs and reset descriptors index functionality. Please see my
third comment in this email.

> 
> > +	CCU_RST_TRIG(CCU_AXI_DDR_RST, CCU_AXI_DDR_BASE, 1),
> > +	CCU_RST_TRIG(CCU_AXI_SATA_RST, CCU_AXI_SATA_BASE, 1),
> > +	CCU_RST_TRIG(CCU_AXI_GMAC0_RST, CCU_AXI_GMAC0_BASE, 1),
> > +	CCU_RST_TRIG(CCU_AXI_GMAC1_RST, CCU_AXI_GMAC1_BASE, 1),
> > +	CCU_RST_TRIG(CCU_AXI_XGMAC_RST, CCU_AXI_XGMAC_BASE, 1),
> > +	CCU_RST_TRIG(CCU_AXI_PCIE_M_RST, CCU_AXI_PCIE_M_BASE, 1),
> > +	CCU_RST_TRIG(CCU_AXI_PCIE_S_RST, CCU_AXI_PCIE_S_BASE, 1),
> > +	CCU_RST_TRIG(CCU_AXI_USB_RST, CCU_AXI_USB_BASE, 1),
> > +	CCU_RST_TRIG(CCU_AXI_HWA_RST, CCU_AXI_HWA_BASE, 1),
> > +	CCU_RST_TRIG(CCU_AXI_SRAM_RST, CCU_AXI_SRAM_BASE, 1),
> > +};
> > +
> > +/*
> > + * SATA reference clock domain and APB-bus domain are connected with the
> > + * sefl-deasserted reset control, which can be activated via the corresponding
> > + * clock divider register. DDR and PCIe sub-domains can be reset with directly
> > + * controlled reset signals. Resetting the DDR controller though won't end up
> > + * well while the Linux kernel is working.
> > + */
> > +static const struct ccu_rst_info sys_rst_info[] = {
> > +	CCU_RST_TRIG(CCU_SYS_SATA_REF_RST, CCU_SYS_SATA_REF_BASE, 1),
> 

> Same as above.

ditto

> 
> > +	CCU_RST_TRIG(CCU_SYS_APB_RST, CCU_SYS_APB_BASE, 1),
> > +};
> > +
> > +struct ccu_rst *ccu_rst_get_desc(struct reset_controller_dev *rcdev, unsigned long idx)
> > +{
> > +	struct ccu_rst_data *data = to_ccu_rst_data(rcdev);
> > +
> > +	if (idx >= data->rsts_num)
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	return &data->rsts[idx];
> > +}
> 

> This is not necessary if you just use the reset id as an index into the
> ccu_rst_info array.

Right. ditto

> 
> > +
> > +static int ccu_rst_of_idx_get(struct reset_controller_dev *rcdev,
> > +			      const struct of_phandle_args *rstspec)
> > +{
> > +	struct ccu_rst_data *data = to_ccu_rst_data(rcdev);
> > +	unsigned int id, idx;
> > +
> > +	id = rstspec->args[0];
> > +	for (idx = 0; idx < data->rsts_num; ++idx) {
> > +		if (data->rsts[idx].id == id)
> > +			break;
> > +	}
> > +	if (idx == data->rsts_num) {
> > +		pr_err("Invalid reset ID %u specified\n", id);
> > +		return -EINVAL;
> > +	}
> > +
> > +	return idx;
> > +}
> 

> Unless I'm mistaken, id == idx for all resets, and this is not
> necessary at all. You should be able to use the default .of_xlate.

You aren't mistake, but please see my third comment in this email.

> 
> > +
> > +static struct ccu_rst_data *ccu_rst_create_data(const struct ccu_rst_init_data *rst_init)
> > +{
> > +	struct ccu_rst_data *data;
> > +	int ret;
> > +
> > +	data = kzalloc(sizeof(*data), GFP_KERNEL);
> > +	if (!data)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	data->np = rst_init->np;
> 

> No reason to store data->np only to copy it to data->rcdev.of_node
> later.

Ok.

> 
> > +	data->sys_regs = rst_init->sys_regs;
> > +	if (of_device_is_compatible(data->np, "baikal,bt1-ccu-axi")) {
> > +		data->rsts_num = ARRAY_SIZE(axi_rst_info);
> 

> You could store the number of resets directly into
> data->rcdev.nr_resets.

Ok.

> 
> > +		data->rsts_info = axi_rst_info;
> > +	} else if (of_device_is_compatible(data->np, "baikal,bt1-ccu-sys")) {
> > +		data->rsts_num = ARRAY_SIZE(sys_rst_info);
> > +		data->rsts_info = sys_rst_info;
> > +	} else {
> > +		pr_err("Incompatible DT node '%s' specified\n",
> > +			of_node_full_name(data->np));
> > +		ret = -EINVAL;
> > +		goto err_kfree_data;
> > +	}
> > +
> > +	data->rsts = kcalloc(data->rsts_num, sizeof(*data->rsts), GFP_KERNEL);
> > +	if (!data->rsts) {
> > +		ret = -ENOMEM;
> > +		goto err_kfree_data;
> > +	}
> 

> I think data->rsts is not required.

Please see my third comment in this email.

> 
> > +
> > +	return data;
> > +
> > +err_kfree_data:
> > +	kfree(data);
> > +
> > +	return ERR_PTR(ret);
> > +}
> > +
> > +static void ccu_rst_free_data(struct ccu_rst_data *data)
> > +{
> > +	kfree(data->rsts);
> >

> Not necessary.

ditto

> 
> > +	kfree(data);
> > +}
> 

> I would fold this into ccu_rst_hw_unregister().

I disagree in this part. Splitting up the interface methods in a set
of the small coherent methods like protagonists and respective
antagonists makes the code much easier to read and maintain. So I
will insist on having the ccu_rst_free_data() method even if it is
left with only a single kfree() function invocation.

> 
> > +
> > +static void ccu_rst_init_desc(struct ccu_rst_data *data)
> > +{
> > +	struct ccu_rst *rst = data->rsts;
> > +	unsigned int idx;
> > +
> > +	for (idx = 0; idx < data->rsts_num; ++idx, ++rst) {
> > +		const struct ccu_rst_info *info = &data->rsts_info[idx];
> > +
> > +		rst->id = info->id;
> > +		rst->type = info->type;
> > +		rst->reg_ctl = info->base;
> > +		rst->sys_regs = data->sys_regs;
> > +		rst->mask = info->mask;
> > +	}
> > +}
> 

> Not necessary.

Right, but see my third comment in this email.

> 
> > +static int ccu_rst_dev_register(struct ccu_rst_data *data)
> > +{
> > +	int ret;
> > +
> > +	data->rcdev.ops = &ccu_rst_ops;
> > +	data->rcdev.of_node = data->np;
> > +	data->rcdev.nr_resets = data->rsts_num;
> > +	data->rcdev.of_reset_n_cells = 1;
> > +	data->rcdev.of_xlate = ccu_rst_of_idx_get;
> > +
> > +	ret = reset_controller_register(&data->rcdev);
> > +	if (ret) {
> > +		pr_err("Couldn't register '%s' reset controller\n",
> > +			of_node_full_name(data->np));
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static void ccu_rst_dev_unregister(struct ccu_rst_data *data)
> > +{
> > +	reset_controller_unregister(&data->rcdev);
> > +}
> 

> I would fold this into ccu_rst_hw_unregister().

I have to disagree for the same reason as I would preserve the
ccu_rst_free_data() method here. Please see my comment above.

> 
> > +struct ccu_rst_data *ccu_rst_hw_register(const struct ccu_rst_init_data *rst_init)
> > +{
> > +	struct ccu_rst_data *data;
> > +	int ret;
> > +
> > +	data = ccu_rst_create_data(rst_init);
> > +	if (IS_ERR(data))
> > +		return data;
> > +
> > +	ccu_rst_init_desc(data);
> 

> Not necessary.

Right, but see my question in the third comment of this email.

> 
> > +
> > +	ret = ccu_rst_dev_register(data);
> > +	if (ret)
> > +		goto err_free_data;
> > +
> > +	return data;
> > +
> > +err_free_data:
> > +	ccu_rst_free_data(data);
> > +
> > +	return ERR_PTR(ret);
> > +}
> > +
> > +void ccu_rst_hw_unregister(struct ccu_rst_data *data)
> > +{
> > +	ccu_rst_dev_unregister(data);
> > +
> > +	ccu_rst_free_data(data);
> > +}
> 

> To me it looks like you could avoid a few unnecessary complications and
> copied data if you merged ccu-rst.c and clk-ccu-rst.c and made use of
> the contiguous reset ids instead of the custom of_xlate and the copied
> ccu_rst descriptors.

I see your point. Please read my third comment in this email and
answer to my question there. If you still insist on dropping the
independent reset IDs and reset descriptor index functionality despite
of my reasoning there, I'll merge the modules and use the standard
of_xlate implementation.

-Sergey

> 
> regards
> Philipp
