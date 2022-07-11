Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D594E56A8BB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 18:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235987AbiGGQ6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 12:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235516AbiGGQ6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 12:58:00 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6A52A71C
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 09:57:57 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id x184so7206396pfx.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 09:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=6e4OTRxEV04Z38y0F7XHfLGeG6C9+MuIYDxl0tOmG4g=;
        b=GuGky0naV9AiDjdUSvQdjF6az5y4pwgBEqlxdQaDk2z8YM7ObOW/iUB7czvaalcSPL
         /wAdDr7e2gNxKXJrgyOClMWjUw6q8VrCzIAySds4bHY0cvDXrze8XSRg7pa3hrUK2sfm
         PnmBZCz/r6sZXwRhlY9O+kdk9fNzAunZRTyxxDGdTKegzclhMshrVeJCJdGabdgvmlbk
         Leu+B4rnq1sTIWGy0geHly5fvfezSC4+h5meiHnBDz6Ubc9cq0v4ytLqWfG2ik9yJXVP
         Qwr81Udk8ZAKrQ71t45y64ccKa03c6HFIxZ1+mCe1D+l5K+FMdk31JDBcUSCxfFZHGuN
         tTQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6e4OTRxEV04Z38y0F7XHfLGeG6C9+MuIYDxl0tOmG4g=;
        b=nxAVEwh4aM/QwXxiIvla0R3RTy1/QnyC82gNHB0RhTNKxfZ3dlacf5AV0Twr1NMgN9
         JP0f7egZ85PsumaRzXBg28mLBA8RLCPd5WXNJQqbh7PqhdPMFhmY1PfsucbDPbLb71t4
         qXCL7fyZcd3d/Uot8ADyGYq2xY/RMY5pI5pd1hSbnrd8JLZgSucFjM6qYtePgUTYh493
         Lcy1GAPh9NANDti06O+qUNtkt6xqmgmiAGoYhRrf8DgYwwdrKGcanXRJrpVWHz5p0t4Y
         Khq0rlXtL2b6v/iv5jSQSZ97LYepFMysq4tblQOimtGFo0KQfkxTRvFdTgkKZgIdsaGm
         FPrw==
X-Gm-Message-State: AJIora+/zPZrARWMu5fA9yEJJ/9dtxlEKt/VGIe9vj0MYb3nJ2TtELT1
        TrjRAbvZwHDdW3MXKo8jAUQ0
X-Google-Smtp-Source: AGRyM1t1Zsl0VjujzDihTbJPAq6XPKRhFguS2SPXuW5D7JLP+jWDJ+mfKB6YWrDJTi9x1sphF4nm6A==
X-Received: by 2002:a65:5aca:0:b0:412:3c69:cf51 with SMTP id d10-20020a655aca000000b004123c69cf51mr19963198pgt.260.1657213077398;
        Thu, 07 Jul 2022 09:57:57 -0700 (PDT)
Received: from thinkpad ([117.207.26.37])
        by smtp.gmail.com with ESMTPSA id x5-20020aa79565000000b0051b9ac5a377sm1701256pfq.213.2022.07.07.09.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 09:57:56 -0700 (PDT)
Date:   Thu, 7 Jul 2022 22:27:51 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     kishon@ti.com, bhelgaas@google.com, robh@kernel.org,
        lorenzo.pieralisi@arm.com
Cc:     kw@linux.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Om Prakash Singh <omp@nvidia.com>,
        Vidya Sagar <vidyas@nvidia.com>
Subject: Re: [PATCH] PCI: designware-ep: Move DBI access to init_complete if
 notifier is used
Message-ID: <20220707165751.GB5458@thinkpad>
References: <20220330060515.22328-1-manivannan.sadhasivam@linaro.org>
 <20220427101820.GC2536@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220427101820.GC2536@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 03:48:26PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Mar 30, 2022 at 11:35:15AM +0530, Manivannan Sadhasivam wrote:
> > For controllers supporting the CORE_INIT notifier, the resources are
> > supposed to be enabled in the init_complete function. Currently,
> > these controllers are enabling the resources during probe time due to
> > the DBI access happens in dw_pcie_ep_init().
> > 
> > This creates the dependency with the host PCIe controller since the
> > resource enablement like PHY depends on host PCIe to be up. For the
> > standalone endpoint usecase, this would never work. So let's move all DBI
> > access to init_complete function if CORE_INIT notifier is used. For the
> > controllers those doesn't support this notifier, this change is a NO-OP.
> > 
> > Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> > Cc: Om Prakash Singh <omp@nvidia.com>
> > Cc: Vidya Sagar <vidyas@nvidia.com>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> A gentle ping on this patch!
> 

Ping again!

Thanks,
Mani

> Thanks,
> Mani
> 
> > ---
> >  .../pci/controller/dwc/pcie-designware-ep.c   | 138 ++++++++++++------
> >  drivers/pci/controller/dwc/pcie-designware.h  |   1 +
> >  2 files changed, 94 insertions(+), 45 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > index 0eda8236c125..fb2bf4bf5ba0 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > @@ -636,6 +636,63 @@ static unsigned int dw_pcie_ep_find_ext_capability(struct dw_pcie *pci, int cap)
> >  	return 0;
> >  }
> >  
> > +static int dw_pcie_iatu_config(struct dw_pcie_ep *ep)
> > +{
> > +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> > +	struct device *dev = pci->dev;
> > +	void *addr;
> > +
> > +	dw_pcie_iatu_detect(pci);
> > +
> > +	ep->ib_window_map = devm_kcalloc(dev,
> > +					 BITS_TO_LONGS(pci->num_ib_windows),
> > +					 sizeof(long),
> > +					 GFP_KERNEL);
> > +	if (!ep->ib_window_map)
> > +		return -ENOMEM;
> > +
> > +	ep->ob_window_map = devm_kcalloc(dev,
> > +					 BITS_TO_LONGS(pci->num_ob_windows),
> > +					 sizeof(long),
> > +					 GFP_KERNEL);
> > +	if (!ep->ob_window_map)
> > +		return -ENOMEM;
> > +
> > +	addr = devm_kcalloc(dev, pci->num_ob_windows, sizeof(phys_addr_t),
> > +			    GFP_KERNEL);
> > +	if (!addr)
> > +		return -ENOMEM;
> > +
> > +	ep->outbound_addr = addr;
> > +
> > +	return 0;
> > +}
> > +
> > +static int dw_pcie_ep_func_init(struct dw_pcie_ep *ep)
> > +{
> > +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> > +	struct dw_pcie_ep_func *ep_func;
> > +	struct pci_epc *epc = ep->epc;
> > +	struct device *dev = pci->dev;
> > +	u8 func_no;
> > +
> > +	for (func_no = 0; func_no < epc->max_functions; func_no++) {
> > +		ep_func = devm_kzalloc(dev, sizeof(*ep_func), GFP_KERNEL);
> > +		if (!ep_func)
> > +			return -ENOMEM;
> > +
> > +		ep_func->func_no = func_no;
> > +		ep_func->msi_cap = dw_pcie_ep_find_capability(ep, func_no,
> > +							      PCI_CAP_ID_MSI);
> > +		ep_func->msix_cap = dw_pcie_ep_find_capability(ep, func_no,
> > +							       PCI_CAP_ID_MSIX);
> > +
> > +		list_add_tail(&ep_func->list, &ep->func_list);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
> >  {
> >  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> > @@ -643,7 +700,22 @@ int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
> >  	unsigned int nbars;
> >  	u8 hdr_type;
> >  	u32 reg;
> > -	int i;
> > +	int ret, i;
> > +
> > +	if (ep->core_init_notifier) {
> > +		ret = dw_pcie_iatu_config(ep);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	if (ep->core_init_notifier) {
> > +		ret = dw_pcie_ep_func_init(ep);
> > +		if (ret)
> > +			return ret;
> > +
> > +		if (ep->ops->ep_init)
> > +			ep->ops->ep_init(ep);
> > +	}
> >  
> >  	hdr_type = dw_pcie_readb_dbi(pci, PCI_HEADER_TYPE) &
> >  		   PCI_HEADER_TYPE_MASK;
> > @@ -677,8 +749,6 @@ EXPORT_SYMBOL_GPL(dw_pcie_ep_init_complete);
> >  int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> >  {
> >  	int ret;
> > -	void *addr;
> > -	u8 func_no;
> >  	struct resource *res;
> >  	struct pci_epc *epc;
> >  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> > @@ -686,7 +756,12 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> >  	struct platform_device *pdev = to_platform_device(dev);
> >  	struct device_node *np = dev->of_node;
> >  	const struct pci_epc_features *epc_features;
> > -	struct dw_pcie_ep_func *ep_func;
> > +
> > +	if (ep->ops->get_features) {
> > +		epc_features = ep->ops->get_features(ep);
> > +		if (epc_features->core_init_notifier)
> > +			ep->core_init_notifier = true;
> > +	}
> >  
> >  	INIT_LIST_HEAD(&ep->func_list);
> >  
> > @@ -708,7 +783,11 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> >  		}
> >  	}
> >  
> > -	dw_pcie_iatu_detect(pci);
> > +	if (!ep->core_init_notifier) {
> > +		ret = dw_pcie_iatu_config(ep);
> > +		if (ret)
> > +			return ret;
> > +	}
> >  
> >  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "addr_space");
> >  	if (!res)
> > @@ -717,26 +796,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> >  	ep->phys_base = res->start;
> >  	ep->addr_size = resource_size(res);
> >  
> > -	ep->ib_window_map = devm_kcalloc(dev,
> > -					 BITS_TO_LONGS(pci->num_ib_windows),
> > -					 sizeof(long),
> > -					 GFP_KERNEL);
> > -	if (!ep->ib_window_map)
> > -		return -ENOMEM;
> > -
> > -	ep->ob_window_map = devm_kcalloc(dev,
> > -					 BITS_TO_LONGS(pci->num_ob_windows),
> > -					 sizeof(long),
> > -					 GFP_KERNEL);
> > -	if (!ep->ob_window_map)
> > -		return -ENOMEM;
> > -
> > -	addr = devm_kcalloc(dev, pci->num_ob_windows, sizeof(phys_addr_t),
> > -			    GFP_KERNEL);
> > -	if (!addr)
> > -		return -ENOMEM;
> > -	ep->outbound_addr = addr;
> > -
> >  	if (pci->link_gen < 1)
> >  		pci->link_gen = of_pci_get_max_link_speed(np);
> >  
> > @@ -753,23 +812,15 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> >  	if (ret < 0)
> >  		epc->max_functions = 1;
> >  
> > -	for (func_no = 0; func_no < epc->max_functions; func_no++) {
> > -		ep_func = devm_kzalloc(dev, sizeof(*ep_func), GFP_KERNEL);
> > -		if (!ep_func)
> > -			return -ENOMEM;
> > -
> > -		ep_func->func_no = func_no;
> > -		ep_func->msi_cap = dw_pcie_ep_find_capability(ep, func_no,
> > -							      PCI_CAP_ID_MSI);
> > -		ep_func->msix_cap = dw_pcie_ep_find_capability(ep, func_no,
> > -							       PCI_CAP_ID_MSIX);
> > +	if (!ep->core_init_notifier) {
> > +		ret = dw_pcie_ep_func_init(ep);
> > +		if (ret)
> > +			return ret;
> >  
> > -		list_add_tail(&ep_func->list, &ep->func_list);
> > +		if (ep->ops->ep_init)
> > +			ep->ops->ep_init(ep);
> >  	}
> >  
> > -	if (ep->ops->ep_init)
> > -		ep->ops->ep_init(ep);
> > -
> >  	ret = pci_epc_mem_init(epc, ep->phys_base, ep->addr_size,
> >  			       ep->page_size);
> >  	if (ret < 0) {
> > @@ -784,12 +835,9 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> >  		return -ENOMEM;
> >  	}
> >  
> > -	if (ep->ops->get_features) {
> > -		epc_features = ep->ops->get_features(ep);
> > -		if (epc_features->core_init_notifier)
> > -			return 0;
> > -	}
> > +	if (!ep->core_init_notifier)
> > +		return dw_pcie_ep_init_complete(ep);
> >  
> > -	return dw_pcie_ep_init_complete(ep);
> > +	return 0;
> >  }
> >  EXPORT_SYMBOL_GPL(dw_pcie_ep_init);
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > index 7d6e9b7576be..aadb14159df7 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > @@ -242,6 +242,7 @@ struct dw_pcie_ep {
> >  	void __iomem		*msi_mem;
> >  	phys_addr_t		msi_mem_phys;
> >  	struct pci_epf_bar	*epf_bar[PCI_STD_NUM_BARS];
> > +	bool			core_init_notifier;
> >  };
> >  
> >  struct dw_pcie_ops {
> > -- 
> > 2.25.1
> > 

-- 
மணிவண்ணன் சதாசிவம்
