Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B305753E7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 19:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237786AbiGNRUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 13:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239145AbiGNRUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 13:20:20 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5985D51A35
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 10:20:19 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id o3-20020a17090a744300b001ef8f7f3dddso3740932pjk.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 10:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XpvW2ymzKXrv9XdhdhAGUH37nh1CVQaUik8iOsE6ihA=;
        b=UI6MGQ4G5BE3kZOHCs8ik/cARdpZ+m9DWrnLAGlLv9AzJBwC++gC7pnVoUVhYyovdi
         WlaIYyfG9oY7mQ63OyBUcggDJ1HoCZOROzzLmBdDUMpF0mPszh1hIBXXDrG88yELjyyz
         D3PVlrhmjWiauNM7dtYMf6IjpLYjozuYDSWE1Z/FJl0x8vpbkQlAAAHauf9GQK52PvO+
         ARkdKx76cWFX4j/WlELzcW33vm5YqPeCIpHMjygc0NzPqGzRjphGPh52fsczayfVYLdv
         z83dwsQRdDOFaSS8sXGFaBR635b0ySalqg+8foaetBd3r+5jqnR1qpKTh4qAmML+c59M
         Ii0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XpvW2ymzKXrv9XdhdhAGUH37nh1CVQaUik8iOsE6ihA=;
        b=AW9b1oqJnUavqfEF/Gp++OyiQKR08GO4/kx3/vgF2rK+qJ9Un0aQkD+6ADLawME3MY
         +piGiv1TruNVvbxmGCA6DmFSlNX0oQWaLXJcgbfXGA3ZHGEimkfZmULY9IxCMFLF3Pj5
         cv5l3hzIl9CRifRpyE2u5SjLXQJyz1675A1cJC8eQoWRTBBE3IxsoX4OTDXtd230KYHm
         CI8zIp0APIVDTGbReMaj36s8Dm68mc8efbJTOrSTgQL+oAPn5KDPX9ghoZ73SzHsugGo
         3JTdiMldSh4FbSGzqocOHSQ2fqXV9vPm3FJx5zLjqeJ4gcGoc39zVrl8m65WAuyd4wIm
         2DuA==
X-Gm-Message-State: AJIora9wNRmAXorxaTcmPmGvXgbclB8av3hwJFaPrxfk+wWbH7NQ42/b
        YCOIhYwEM++I9bqZd8gdqP/IjA==
X-Google-Smtp-Source: AGRyM1sjp2lb8DE8ew2b/8kii0iT9GYepkUaYLGAKZZPIrfv5+bpbeDS8xY2ZHT6emfP3InrWwgFpA==
X-Received: by 2002:a17:90a:d252:b0:1f0:c1f4:24eb with SMTP id o18-20020a17090ad25200b001f0c1f424ebmr3988375pjw.172.1657819218733;
        Thu, 14 Jul 2022 10:20:18 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id q25-20020a635059000000b0040c644e82efsm1637766pgl.43.2022.07.14.10.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 10:20:17 -0700 (PDT)
Date:   Thu, 14 Jul 2022 11:20:15 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Puranjay Mohan <p-mohan@ti.com>
Cc:     linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        nm@ti.com, ssantosh@kernel.org, s-anna@ti.com,
        linux-arm-kernel@lists.infradead.org, rogerq@kernel.org,
        grygorii.strashko@ti.com, vigneshr@ti.com, kishon@ti.com,
        robh@kernel.org
Subject: Re: [PATCH v5 2/6] remoteproc: pru: Add APIs to get and put the PRU
 cores
Message-ID: <20220714172015.GA3106020@p14s>
References: <20220607045650.4999-1-p-mohan@ti.com>
 <20220607045650.4999-3-p-mohan@ti.com>
 <20220712175949.GB2945984@p14s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712175949.GB2945984@p14s>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 11:59:49AM -0600, Mathieu Poirier wrote:
> Hi Puranjay,
> 
> On Tue, Jun 07, 2022 at 10:26:46AM +0530, Puranjay Mohan wrote:
> > From: Tero Kristo <t-kristo@ti.com>
> > 
> > Add two new APIs, pru_rproc_get() and pru_rproc_put(), to the PRU
> > driver to allow client drivers to acquire and release the remoteproc
> > device associated with a PRU core. The PRU cores are treated as
> > resources with only one client owning it at a time.
> > 
> > The pru_rproc_get() function returns the rproc handle corresponding
> > to a PRU core identified by the device tree "ti,prus" property under
> > the client node. The pru_rproc_put() is the complementary function
> > to pru_rproc_get().
> > 
> > Co-developed-by: Suman Anna <s-anna@ti.com>
> > Signed-off-by: Suman Anna <s-anna@ti.com>
> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
> > Co-developed-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
> > Signed-off-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
> > Co-developed-by: Puranjay Mohan <p-mohan@ti.com>
> > Signed-off-by: Puranjay Mohan <p-mohan@ti.com>
> > ---
> >  drivers/remoteproc/pru_rproc.c | 138 +++++++++++++++++++++++++++++++--
> >  include/linux/pruss.h          |  56 +++++++++++++
> >  2 files changed, 189 insertions(+), 5 deletions(-)
> >  create mode 100644 include/linux/pruss.h
> > 
> > diff --git a/drivers/remoteproc/pru_rproc.c b/drivers/remoteproc/pru_rproc.c
> > index 1777a01fa84e..7a35b400287a 100644
> > --- a/drivers/remoteproc/pru_rproc.c
> > +++ b/drivers/remoteproc/pru_rproc.c
> > @@ -2,12 +2,13 @@
> >  /*
> >   * PRU-ICSS remoteproc driver for various TI SoCs
> >   *
> > - * Copyright (C) 2014-2020 Texas Instruments Incorporated - https://www.ti.com/
> > + * Copyright (C) 2014-2022 Texas Instruments Incorporated - https://www.ti.com/
> >   *
> >   * Author(s):
> >   *	Suman Anna <s-anna@ti.com>
> >   *	Andrew F. Davis <afd@ti.com>
> >   *	Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org> for Texas Instruments
> > + *	Puranjay Mohan <p-mohan@ti.com>
> >   */
> >  
> >  #include <linux/bitops.h>
> > @@ -16,6 +17,7 @@
> >  #include <linux/module.h>
> >  #include <linux/of_device.h>
> >  #include <linux/of_irq.h>
> > +#include <linux/pruss.h>
> >  #include <linux/pruss_driver.h>
> >  #include <linux/remoteproc.h>
> >  
> > @@ -111,6 +113,8 @@ struct pru_private_data {
> >   * @rproc: remoteproc pointer for this PRU core
> >   * @data: PRU core specific data
> >   * @mem_regions: data for each of the PRU memory regions
> > + * @client_np: client device node
> > + * @lock: mutex to protect client usage
> >   * @fw_name: name of firmware image used during loading
> >   * @mapped_irq: virtual interrupt numbers of created fw specific mapping
> >   * @pru_interrupt_map: pointer to interrupt mapping description (firmware)
> > @@ -126,6 +130,8 @@ struct pru_rproc {
> >  	struct rproc *rproc;
> >  	const struct pru_private_data *data;
> >  	struct pruss_mem_region mem_regions[PRU_IOMEM_MAX];
> > +	struct device_node *client_np;
> > +	struct mutex lock; /* client access lock */
> >  	const char *fw_name;
> >  	unsigned int *mapped_irq;
> >  	struct pru_irq_rsc *pru_interrupt_map;
> > @@ -146,6 +152,125 @@ void pru_control_write_reg(struct pru_rproc *pru, unsigned int reg, u32 val)
> >  	writel_relaxed(val, pru->mem_regions[PRU_IOMEM_CTRL].va + reg);
> >  }
> >  
> > +static struct rproc *__pru_rproc_get(struct device_node *np, int index)
> > +{
> > +	struct device_node *rproc_np = NULL;
> > +	struct platform_device *pdev;
> > +	struct rproc *rproc;
> > +
> > +	rproc_np = of_parse_phandle(np, "ti,prus", index);
> > +	if (!rproc_np || !of_device_is_available(rproc_np))
> > +		return ERR_PTR(-ENODEV);
> > +
> > +	pdev = of_find_device_by_node(rproc_np);
> > +	of_node_put(rproc_np);
> > +
> > +	if (!pdev || !(&pdev->dev) || !((&pdev->dev)->driver))
> > +		/* probably PRU not yet probed */
> > +		return ERR_PTR(-EPROBE_DEFER);
> > +
> > +	/* make sure it is PRU rproc */
> > +	if (!is_pru_rproc(&pdev->dev)) {
> > +		put_device(&pdev->dev);
> > +		return ERR_PTR(-ENODEV);
> > +	}
> > +
> > +	rproc = platform_get_drvdata(pdev);
> > +	put_device(&pdev->dev);
> > +	if (!rproc)
> > +		return ERR_PTR(-EPROBE_DEFER);
> > +
> > +	get_device(&rproc->dev);
> > +
> > +	return rproc;
> > +}
> > +
> > +/**
> > + * pru_rproc_get() - get the PRU rproc instance from a device node
> > + * @np: the user/client device node
> > + * @index: index to use for the ti,prus property
> > + * @pru_id: optional pointer to return the PRU remoteproc processor id
> > + *
> > + * This function looks through a client device node's "ti,prus" property at
> > + * index @index and returns the rproc handle for a valid PRU remote processor if
> > + * found. The function allows only one user to own the PRU rproc resource at a
> > + * time. Caller must call pru_rproc_put() when done with using the rproc, not
> > + * required if the function returns a failure.
> > + *
> > + * When optional @pru_id pointer is passed the PRU remoteproc processor id is
> > + * returned.
> > + *
> > + * Return: rproc handle on success, and an ERR_PTR on failure using one
> > + * of the following error values
> > + *    -ENODEV if device is not found
> > + *    -EBUSY if PRU is already acquired by anyone
> > + *    -EPROBE_DEFER is PRU device is not probed yet
> > + */
> > +struct rproc *pru_rproc_get(struct device_node *np, int index,
> > +			    enum pruss_pru_id *pru_id)
> > +{
> > +	struct rproc *rproc;
> > +	struct pru_rproc *pru;
> > +	struct device *dev;
> > +
> > +	try_module_get(THIS_MODULE);
> 
> There should be a module_put() in pru_rproc_put()...

... and in the error path of this function.

> 
> More comments to come tomorrow.  I'm especially worried about this API racing
> with a remote processor being removed or detached.
>

Looking at what is done in wkup_m3_ipc_probe(), it should be possible to call
rproc_get_by_handle() here and that would make sure the remote processor doesn't
go away before the end of the function.

More comments to come...


> Thanks,
> Mathieu
> 
> > +
> > +	rproc = __pru_rproc_get(np, index);
> > +	if (IS_ERR(rproc))
> > +		return rproc;
> > +
> > +	pru = rproc->priv;
> > +	dev = &rproc->dev;
> > +
> > +	mutex_lock(&pru->lock);
> > +
> > +	if (pru->client_np) {
> > +		mutex_unlock(&pru->lock);
> > +		put_device(dev);
> > +		return ERR_PTR(-EBUSY);
> > +	}
> > +
> > +	pru->client_np = np;
> > +
> > +	mutex_unlock(&pru->lock);
> > +
> > +	if (pru_id)
> > +		*pru_id = pru->id;
> > +
> > +	return rproc;
> > +}
> > +EXPORT_SYMBOL_GPL(pru_rproc_get);
> > +
> > +/**
> > + * pru_rproc_put() - release the PRU rproc resource
> > + * @rproc: the rproc resource to release
> > + *
> > + * Releases the PRU rproc resource and makes it available to other
> > + * users.
> > + */
> > +void pru_rproc_put(struct rproc *rproc)
> > +{
> > +	struct pru_rproc *pru;
> > +
> > +	if (IS_ERR_OR_NULL(rproc) || !is_pru_rproc(rproc->dev.parent))
> > +		return;
> > +
> > +	pru = rproc->priv;
> > +
> > +	mutex_lock(&pru->lock);
> > +
> > +	if (!pru->client_np) {
> > +		mutex_unlock(&pru->lock);
> > +		return;
> > +	}
> > +
> > +	pru->client_np = NULL;
> > +	mutex_unlock(&pru->lock);
> > +
> > +	put_device(&rproc->dev);
> > +}
> > +EXPORT_SYMBOL_GPL(pru_rproc_put);
> > +
> >  static inline u32 pru_debug_read_reg(struct pru_rproc *pru, unsigned int reg)
> >  {
> >  	return readl_relaxed(pru->mem_regions[PRU_IOMEM_DEBUG].va + reg);
> > @@ -438,7 +563,7 @@ static void *pru_d_da_to_va(struct pru_rproc *pru, u32 da, size_t len)
> >  	dram0 = pruss->mem_regions[PRUSS_MEM_DRAM0];
> >  	dram1 = pruss->mem_regions[PRUSS_MEM_DRAM1];
> >  	/* PRU1 has its local RAM addresses reversed */
> > -	if (pru->id == 1)
> > +	if (pru->id == PRUSS_PRU1)
> >  		swap(dram0, dram1);
> >  	shrd_ram = pruss->mem_regions[PRUSS_MEM_SHRD_RAM2];
> >  
> > @@ -747,14 +872,14 @@ static int pru_rproc_set_id(struct pru_rproc *pru)
> >  	case RTU0_IRAM_ADDR_MASK:
> >  		fallthrough;
> >  	case PRU0_IRAM_ADDR_MASK:
> > -		pru->id = 0;
> > +		pru->id = PRUSS_PRU0;
> >  		break;
> >  	case TX_PRU1_IRAM_ADDR_MASK:
> >  		fallthrough;
> >  	case RTU1_IRAM_ADDR_MASK:
> >  		fallthrough;
> >  	case PRU1_IRAM_ADDR_MASK:
> > -		pru->id = 1;
> > +		pru->id = PRUSS_PRU1;
> >  		break;
> >  	default:
> >  		ret = -EINVAL;
> > @@ -816,6 +941,8 @@ static int pru_rproc_probe(struct platform_device *pdev)
> >  	pru->pruss = platform_get_drvdata(ppdev);
> >  	pru->rproc = rproc;
> >  	pru->fw_name = fw_name;
> > +	pru->client_np = NULL;
> > +	mutex_init(&pru->lock);
> >  
> >  	for (i = 0; i < ARRAY_SIZE(mem_names); i++) {
> >  		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> > @@ -903,7 +1030,7 @@ MODULE_DEVICE_TABLE(of, pru_rproc_match);
> >  
> >  static struct platform_driver pru_rproc_driver = {
> >  	.driver = {
> > -		.name   = "pru-rproc",
> > +		.name   = PRU_RPROC_DRVNAME,
> >  		.of_match_table = pru_rproc_match,
> >  		.suppress_bind_attrs = true,
> >  	},
> > @@ -915,5 +1042,6 @@ module_platform_driver(pru_rproc_driver);
> >  MODULE_AUTHOR("Suman Anna <s-anna@ti.com>");
> >  MODULE_AUTHOR("Andrew F. Davis <afd@ti.com>");
> >  MODULE_AUTHOR("Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>");
> > +MODULE_AUTHOR("Puranjay Mohan <p-mohan@ti.com>");
> >  MODULE_DESCRIPTION("PRU-ICSS Remote Processor Driver");
> >  MODULE_LICENSE("GPL v2");
> > diff --git a/include/linux/pruss.h b/include/linux/pruss.h
> > new file mode 100644
> > index 000000000000..fdc719b43db0
> > --- /dev/null
> > +++ b/include/linux/pruss.h
> > @@ -0,0 +1,56 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/**
> > + * PRU-ICSS Subsystem user interfaces
> > + *
> > + * Copyright (C) 2015-2022 Texas Instruments Incorporated - http://www.ti.com
> > + *	Suman Anna <s-anna@ti.com>
> > + */
> > +
> > +#ifndef __LINUX_PRUSS_H
> > +#define __LINUX_PRUSS_H
> > +
> > +#include <linux/device.h>
> > +#include <linux/types.h>
> > +
> > +#define PRU_RPROC_DRVNAME "pru-rproc"
> > +
> > +/*
> > + * enum pruss_pru_id - PRU core identifiers
> > + */
> > +enum pruss_pru_id {
> > +	PRUSS_PRU0 = 0,
> > +	PRUSS_PRU1,
> > +	PRUSS_NUM_PRUS,
> > +};
> > +
> > +struct device_node;
> > +
> > +#if IS_ENABLED(CONFIG_PRU_REMOTEPROC)
> > +
> > +struct rproc *pru_rproc_get(struct device_node *np, int index,
> > +			    enum pruss_pru_id *pru_id);
> > +void pru_rproc_put(struct rproc *rproc);
> > +
> > +#else
> > +
> > +static inline struct rproc *
> > +pru_rproc_get(struct device_node *np, int index, enum pruss_pru_id *pru_id)
> > +{
> > +	return ERR_PTR(-EOPNOTSUPP);
> > +}
> > +
> > +static inline void pru_rproc_put(struct rproc *rproc) { }
> > +
> > +#endif /* CONFIG_PRU_REMOTEPROC */
> > +
> > +static inline bool is_pru_rproc(struct device *dev)
> > +{
> > +	const char *drv_name = dev_driver_string(dev);
> > +
> > +	if (strncmp(drv_name, PRU_RPROC_DRVNAME, sizeof(PRU_RPROC_DRVNAME)))
> > +		return false;
> > +
> > +	return true;
> > +}
> > +
> > +#endif /* __LINUX_PRUSS_H */
> > -- 
> > 2.17.1
> > 
