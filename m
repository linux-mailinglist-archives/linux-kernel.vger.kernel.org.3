Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA274F988A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 16:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbiDHOst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 10:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbiDHOsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 10:48:45 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D74FC12E
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 07:46:39 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id x8-20020a9d6288000000b005b22c373759so6239688otk.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 07:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=nQma87vV/Spb3EZ0EqoG0KuNOfA00UbBpa4tPzu13w4=;
        b=zKXvr1U1vJ2BY4adOfDdjAJGxk2u66if55H7yv6F7ERih3Mo1tiNVTDguvb8L0AGqt
         SbshL1YV9SfW+AqHfYM0/890CJEQbhQJmeN0pNi3MB1yB4u3xC6d2xHWRiLLJHmpUcfI
         s+wkBvD46AjcAl9xhnxNQ72p7fj85AEx8g2Qe/PX3lquC/1NYed6S+TAVVTszij330MZ
         j5O0ZMMACctYrjKtvPO7uPPr2oqxdHnZCVNrKpmIrqIu6Rfnky+FT4zQxfVRDNAMhqtA
         OsqSppfbcjzCQGzbOKZDzEXfR+Su6V2WUxzq+2EkaEPhFwsKIqlfANbMPcgmvOR4jYh8
         FUbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=nQma87vV/Spb3EZ0EqoG0KuNOfA00UbBpa4tPzu13w4=;
        b=6q0zclmku2ppQFJSuNWdi/IzADVuD0BxGmY31KzSvGHHK6VHNyyev+lW0katZFV9Vm
         NIrXxtvjX3074tkVcwYqXNQNRsbbkkVnCB5LoAXw9S6TAAlwhGQDAuylrrQteGLqNbF/
         c7sdY4m3C+A2X4jifhr6Dt8/r2ZFLoLa0IAVNKgMWFMDczed5TqFmqW91jVEoC7qOIlQ
         q5kYNWiQWY5et98lvkfpa6hGXvBVjJkgEy6nt7rE++oR2Q6hxewlZ1NwrVF99gj4oJWR
         /7U3KHcL/CxzomgSaRAZEzx08xoJZHJkriy3JCPKBTRZIekGNfG/zU4Fx0ciEyNTErOU
         2vbQ==
X-Gm-Message-State: AOAM5318YEwwdFz6NbxHFLMmFC4k/bctwhrRSJJDPwInCGLteW5I4BI6
        /0xy+9aoq3yB3NcZziqQhSTIjWibDfHuDQFO
X-Google-Smtp-Source: ABdhPJy0DT+OtOqa+Z/SPqsxkKlELAYaxgVGZcL3+NgXfK/cboKKfEkv3MyaT0cTLrKwpHj0LXo/WA==
X-Received: by 2002:a9d:1729:0:b0:5b2:3828:c84c with SMTP id i41-20020a9d1729000000b005b23828c84cmr6922455ota.362.1649429198659;
        Fri, 08 Apr 2022 07:46:38 -0700 (PDT)
Received: from fedora ([2804:14d:8084:84c6:2e13:8e30:84f7:1597])
        by smtp.gmail.com with ESMTPSA id r3-20020aca4403000000b002ecf4d70c83sm8620617oia.27.2022.04.08.07.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 07:46:38 -0700 (PDT)
Date:   Fri, 8 Apr 2022 11:46:32 -0300
From:   =?iso-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     l.stach@pengutronix.de, hongxing.zhu@nxp.com, robh@kernel.org,
        bhelgaas@google.com, helgaas@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI: imx6: Replace legacy gpio interface for gpiod
 interface
Message-ID: <YlBKyBtbxMpvauLv@fedora>
References: <YYCOTx68LXu1Tn1i@fedora>
 <YlBFa46v5NtWxGLt@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YlBFa46v5NtWxGLt@lpieralisi>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2022 at 03:23:39PM +0100, Lorenzo Pieralisi wrote:
> On Mon, Nov 01, 2021 at 10:03:11PM -0300, Ma�ra Canal wrote:
> > Considering the current transition of the GPIO subsystem, remove all
> > dependencies of the legacy GPIO interface (linux/gpio.h and linux
> > /of_gpio.h) and replace it with the descriptor-based GPIO approach.
> > 
> > Signed-off-by: Ma�ra Canal <maira.canal@usp.br>
> > ---
> > V1 -> V2: Rewrite commit log and subject line to match PCI subsystem standard
> > V2 -> v3: Change gpiod_set_value_cansleep for gpiod_set_raw_value_cansleep
> > ---
> >  drivers/pci/controller/dwc/pci-imx6.c | 30 +++++++++------------------
> >  1 file changed, 10 insertions(+), 20 deletions(-)
> 
> Maira, Lucas,
> 
> what's this patch status ? Please let me know.


Lorenzo,

Thank you for the feedback. Since I sent v3, I didn't get any feedback from the community.

If you have any feedback, I would gladly work on it.

Thanks,
Ma�ra Canal

> 
> Thanks,
> Lorenzo
> 
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> > index 80fc98acf097..f08865ac0b40 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > @@ -11,13 +11,12 @@
> >  #include <linux/bitfield.h>
> >  #include <linux/clk.h>
> >  #include <linux/delay.h>
> > -#include <linux/gpio.h>
> > +#include <linux/gpio/consumer.h>
> >  #include <linux/kernel.h>
> >  #include <linux/mfd/syscon.h>
> >  #include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
> >  #include <linux/mfd/syscon/imx7-iomuxc-gpr.h>
> >  #include <linux/module.h>
> > -#include <linux/of_gpio.h>
> >  #include <linux/of_device.h>
> >  #include <linux/of_address.h>
> >  #include <linux/pci.h>
> > @@ -63,7 +62,7 @@ struct imx6_pcie_drvdata {
> >  
> >  struct imx6_pcie {
> >  	struct dw_pcie		*pci;
> > -	int			reset_gpio;
> > +	struct gpio_desc	*reset_gpio;
> >  	bool			gpio_active_high;
> >  	struct clk		*pcie_bus;
> >  	struct clk		*pcie_phy;
> > @@ -526,11 +525,11 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
> >  	usleep_range(200, 500);
> >  
> >  	/* Some boards don't have PCIe reset GPIO. */
> > -	if (gpio_is_valid(imx6_pcie->reset_gpio)) {
> > -		gpio_set_value_cansleep(imx6_pcie->reset_gpio,
> > +	if (imx6_pcie->reset_gpio) {
> > +		gpiod_set_raw_value_cansleep(imx6_pcie->reset_gpio,
> >  					imx6_pcie->gpio_active_high);
> >  		msleep(100);
> > -		gpio_set_value_cansleep(imx6_pcie->reset_gpio,
> > +		gpiod_set_raw_value_cansleep(imx6_pcie->reset_gpio,
> >  					!imx6_pcie->gpio_active_high);
> >  	}
> >  
> > @@ -1025,22 +1024,13 @@ static int imx6_pcie_probe(struct platform_device *pdev)
> >  		return PTR_ERR(pci->dbi_base);
> >  
> >  	/* Fetch GPIOs */
> > -	imx6_pcie->reset_gpio = of_get_named_gpio(node, "reset-gpio", 0);
> >  	imx6_pcie->gpio_active_high = of_property_read_bool(node,
> >  						"reset-gpio-active-high");
> > -	if (gpio_is_valid(imx6_pcie->reset_gpio)) {
> > -		ret = devm_gpio_request_one(dev, imx6_pcie->reset_gpio,
> > -				imx6_pcie->gpio_active_high ?
> > -					GPIOF_OUT_INIT_HIGH :
> > -					GPIOF_OUT_INIT_LOW,
> > -				"PCIe reset");
> > -		if (ret) {
> > -			dev_err(dev, "unable to get reset gpio\n");
> > -			return ret;
> > -		}
> > -	} else if (imx6_pcie->reset_gpio == -EPROBE_DEFER) {
> > -		return imx6_pcie->reset_gpio;
> > -	}
> > +	imx6_pcie->reset_gpio = devm_gpiod_get_optional(dev, "reset",
> > +			imx6_pcie->gpio_active_high ?  GPIOD_OUT_HIGH : GPIOD_OUT_LOW);
> > +	if (IS_ERR(imx6_pcie->reset_gpio))
> > +		return dev_err_probe(dev, PTR_ERR(imx6_pcie->reset_gpio),
> > +				"unable to get reset gpio\n");
> >  
> >  	/* Fetch clocks */
> >  	imx6_pcie->pcie_phy = devm_clk_get(dev, "pcie_phy");
> > -- 
> > 2.31.1
> > 
