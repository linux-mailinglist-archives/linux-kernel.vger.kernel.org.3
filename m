Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB7225535A6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 17:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352514AbiFUPOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 11:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352707AbiFUPN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 11:13:27 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF762AE3E
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 08:12:22 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 73-20020a17090a0fcf00b001eaee69f600so13703927pjz.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 08:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=OmNePCR5l0D6yhtyhalpysxE1x2cPrZSQisFtuy9SS4=;
        b=ZqpvfHu8vpBcIY70GaBqUIIbhg0MYLnkqBGTNo87BKBqizbRzAqJlkEo31fIPmZ8S5
         CMs+RG9Nz28IKhmzHqiglg3AoTEip6EkhOLQcehBE6GfX2V7ALUyz4uCjlcmFbEb3QbR
         ZrGDhyxxxX9vMFD0pvqXp0iP07UC9DBvFYUWXo60Nm4va+3hL0VwiJdXG1RaCJjc9NPO
         hgQT4Tx4vRXvvrWlPjY/eqRdILrdhzMk7K7DLLCr0pPmZEKw2EedAOFBTg/YbpulL/sF
         xMRDgv7sfoZecKkyis+97n7ASyuBYr/4mmdyowISrYxlTiCPfOkLPV7cQzqQVcDF/BZL
         xOwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=OmNePCR5l0D6yhtyhalpysxE1x2cPrZSQisFtuy9SS4=;
        b=Tv636BnBDZDEHi5GCmFLPVc2U1zGYhDK7rWrd72p2kZI3YQElRnVz0rEk4crzRHGz1
         edMsRwnZFYHgwnHfcXa2ulbz0SyU9b7JRv61Z+VL6eQfexw3cmEuec905SF+bBF3IXVr
         BrALqxNiXA9aueGiF2GbbRBEPT5Z7zXXtCPVfyrCY4Oep6itIkq+iF+7zzw0Pi0SzCcg
         ATUDNPuOQ/0J87O987KmoQ81oH7G7ccAnhQdHRvj7dv6zMxhz7MMR0hgp1uWkSXslBVK
         2bs6wlPXuxVWqtdqlV14ukc/D3BDCZ4ajMO/7JHf8XcAX6vhiasge5vh0OUET1Q1XU08
         OoaQ==
X-Gm-Message-State: AJIora9DxWYxkley0+M1ZJpo5KB6cDRr3qUP7N9r4aYMods29WPYIPfw
        YKW0rKCN3uDpo4mNqUxCZoxJqG0hy786
X-Google-Smtp-Source: AGRyM1uDqfclGTSJzuew4bdC/Y6di2Wzht8n8gfkOWWwxO3g/JWDyQP85lECbhgyusIhM/khR8CdYg==
X-Received: by 2002:a17:903:1206:b0:168:e5af:469d with SMTP id l6-20020a170903120600b00168e5af469dmr29754220plh.55.1655824341022;
        Tue, 21 Jun 2022 08:12:21 -0700 (PDT)
Received: from thinkpad ([117.193.212.116])
        by smtp.gmail.com with ESMTPSA id w22-20020a1709026f1600b001676f87473fsm10823245plk.302.2022.06.21.08.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 08:12:20 -0700 (PDT)
Date:   Tue, 21 Jun 2022 20:42:11 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Lizhi Hou <lizhi.hou@xilinx.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        robh@kernel.org, yilun.xu@intel.com, maxz@xilinx.com,
        sonal.santan@xilinx.com, yliu@xilinx.com, michal.simek@xilinx.com,
        stefanos@xilinx.com, trix@redhat.com, mdf@kernel.org,
        dwmw2@infradead.org, linux-kernel@vger.kernel.org,
        Max Zhen <max.zhen@xilinx.com>
Subject: Re: [PATCH V1 RESEND 1/4] pci: add interface to create pci-ep device
 tree node
Message-ID: <20220621151211.GB28880@thinkpad>
References: <20220305052304.726050-1-lizhi.hou@xilinx.com>
 <20220305052304.726050-2-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220305052304.726050-2-lizhi.hou@xilinx.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 09:23:01PM -0800, Lizhi Hou wrote:
> This patch enables PCIe device to uses flattened device tree to describe
> apertures in its PCIe BARs. The aperture address consists of PCIe BAR index
> and offset.
> 
> For this kind of device, the driver probe routine calls the new added
> interface to create a device tree node. This device tree node is attached
> under system device tree root. Then the driver may load the flatten device
> tree overlay and attach it under this node. And the node also contains
> 'ranges' property which is used to translate aperture address(BAR index
> and offset) to CPU address.
> 

This is the devicetree support for the PCI endpoint subsystem. Hence, the
code should live under drivers/pci/endpoint/.

But let's first settle on the structure of the devicetree binding first.

Thanks,
Mani

> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
> ---
>  drivers/pci/of.c       | 180 +++++++++++++++++++++++++++++++++++++++++
>  include/linux/of_pci.h |  15 ++++
>  2 files changed, 195 insertions(+)
> 
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index cb2e8351c2cc..198f08351070 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -605,6 +605,186 @@ int devm_of_pci_bridge_init(struct device *dev, struct pci_host_bridge *bridge)
>  	return pci_parse_request_of_pci_ranges(dev, bridge);
>  }
>  
> +#if IS_ENABLED(CONFIG_OF_DYNAMIC)
> +
> +static void devm_of_pci_destroy_bus_endpoint(struct device *dev, void *res)
> +{
> +	struct device_node *node = res;
> +
> +	of_detach_node(node);
> +}
> +
> +static int of_ep_add_property(struct device *dev, struct property **proplist, const char *name,
> +			      const int length, void *value)
> +{
> +	struct property *new;
> +
> +	new = devm_kzalloc(dev, sizeof(*new), GFP_KERNEL);
> +	if (!new)
> +		return -ENOMEM;
> +
> +	new->name = devm_kstrdup(dev, name, GFP_KERNEL);
> +	if (!new->name)
> +		return -ENOMEM;
> +
> +	new->value = devm_kmalloc(dev, length, GFP_KERNEL);
> +	if (!new->value)
> +		return -ENOMEM;
> +
> +	memcpy(new->value, value, length);
> +	new->length = length;
> +	new->next = *proplist;
> +	*proplist = new;
> +
> +	return 0;
> +}
> +
> +static struct device_node *of_ep_alloc_node(struct pci_dev *pdev, const char *name)
> +{
> +	struct device_node *node;
> +	char *full_name;
> +
> +	node = devres_alloc(devm_of_pci_destroy_bus_endpoint, sizeof(*node), GFP_KERNEL);
> +	if (!node)
> +		return NULL;
> +
> +	full_name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "/%s@%llx", name,
> +				   (u64)pci_resource_start(pdev, 0));
> +	if (!full_name)
> +		return NULL;
> +
> +	node->parent = of_root;
> +	node->full_name = full_name;
> +	of_node_set_flag(node, OF_DYNAMIC);
> +	of_node_init(node);
> +
> +	return node;
> +}
> +
> +/**
> + * devm_of_pci_create_bus_endpoint - Create a device node for the given pci device.
> + * @pdev: PCI device pointer.
> + *
> + * For PCI device which uses flattened device tree to describe apertures in its BARs,
> + * a device node for the given pci device is required. Then the flattened device tree
> + * overlay from the device can be applied to the base tree.
> + * The device node is under root node and act like bus node. It contains a "ranges"
> + * property which is used for address translation of its children. Each child node
> + * corresponds an aperture and use BAR index and offset as its address.
> +
> + * Returns 0 on success or a negative error-code on failure.
> + */
> +int devm_of_pci_create_bus_endpoint(struct pci_dev *pdev)
> +{
> +	struct property *proplist = NULL;
> +	struct device *dev = &pdev->dev;
> +	int range_ncells, addr_ncells;
> +	struct device_node *node;
> +	void *prop = NULL;
> +	u32 *range_cell;
> +	__be32 val;
> +	int i, ret;
> +
> +	node = of_ep_alloc_node(pdev, "pci-ep-bus");
> +	if (!node)
> +		return -ENOMEM;
> +
> +	/* the endpoint node works as 'simple-bus' to translate aperture addresses. */
> +	prop = "simple-bus";
> +	ret = of_ep_add_property(dev, &proplist, "compatible", strlen(prop) + 1, prop);
> +	if (ret)
> +		goto cleanup;
> +
> +	/* The address and size cells of nodes underneath are 2 */
> +	val = cpu_to_be32(2);
> +	ret = of_ep_add_property(dev, &proplist, "#address-cells", sizeof(u32), &val);
> +	if (ret)
> +		goto cleanup;
> +
> +	ret = of_ep_add_property(dev, &proplist, "#size-cells", sizeof(u32), &val);
> +	if (ret)
> +		goto cleanup;
> +
> +	/* child address format: 0xIooooooo oooooooo, I = bar index, o = offset on bar */
> +	addr_ncells = of_n_addr_cells(node);
> +	if (addr_ncells > 2) {
> +		/* does not support number of address cells greater than 2 */
> +		ret = -EINVAL;
> +		goto cleanup;
> +	}
> +
> +	/* range cells include <node addr cells> <child addr cells> <child size cells> */
> +	range_ncells = addr_ncells + 4;
> +	prop = kzalloc(range_ncells * sizeof(u32) * PCI_STD_NUM_BARS, GFP_KERNEL);
> +	if (!prop) {
> +		ret = -ENOMEM;
> +		goto cleanup;
> +	}
> +
> +	range_cell = prop;
> +	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
> +		if (!pci_resource_len(pdev, i))
> +			continue;
> +		/* highest 4 bits of address are bar index */
> +		*(__be64 *)range_cell = cpu_to_be64((u64)i << 60);
> +		range_cell += 2;
> +		if (addr_ncells == 2)
> +			*(__be64 *)range_cell = cpu_to_be64((u64)pci_resource_start(pdev, i));
> +		else
> +			*(__be32 *)range_cell = cpu_to_be32((u32)pci_resource_start(pdev, i));
> +
> +		range_cell += addr_ncells;
> +		*(__be64 *)range_cell = cpu_to_be64((u64)pci_resource_len(pdev, i));
> +		range_cell += 2;
> +	}
> +
> +	/* error out if there is not PCI BAR been found */
> +	if ((void *)range_cell == prop) {
> +		ret = -EINVAL;
> +		goto cleanup;
> +	}
> +
> +	ret = of_ep_add_property(dev, &proplist, "ranges", (void *)range_cell - prop, prop);
> +	kfree(prop);
> +	if (ret)
> +		goto cleanup;
> +
> +	node->properties = proplist;
> +	ret = of_attach_node(node);
> +	if (ret)
> +		goto cleanup;
> +
> +	devres_add(dev, node);
> +
> +	return 0;
> +
> +cleanup:
> +	kfree(prop);
> +	if (node)
> +		devres_free(node);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(devm_of_pci_create_bus_endpoint);
> +
> +struct device_node *of_pci_find_bus_endpoint(struct pci_dev *pdev)
> +{
> +	struct device_node *dn;
> +	char *path;
> +
> +	path = kasprintf(GFP_KERNEL, "/pci-ep-bus@%llx",
> +			 (u64)pci_resource_start(pdev, 0));
> +	if (!path)
> +		return NULL;
> +
> +	dn = of_find_node_by_path(path);
> +	kfree(path);
> +
> +	return dn;
> +}
> +EXPORT_SYMBOL_GPL(of_pci_find_bus_endpoint);
> +#endif /* CONFIG_OF_DYNAMIC */
> +
>  #endif /* CONFIG_PCI */
>  
>  /**
> diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
> index 29658c0ee71f..c1d86be321b2 100644
> --- a/include/linux/of_pci.h
> +++ b/include/linux/of_pci.h
> @@ -38,4 +38,19 @@ of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8 pin)
>  }
>  #endif
>  
> +#if IS_ENABLED(CONFIG_OF_DYNAMIC) && IS_ENABLED(CONFIG_PCI)
> +int devm_of_pci_create_bus_endpoint(struct pci_dev *pdev);
> +struct device_node *of_pci_find_bus_endpoint(struct pci_dev *pdev);
> +#else
> +static inline int devm_of_pci_create_bus_endpoint(struct pci_dev *pdev)
> +{
> +	return -EINVAL;
> +}
> +
> +static inline struct device_node *of_pci_find_bus_endpoint(struct pci_dev *pdev)
> +{
> +	return NULL;
> +}
> +#endif
> +
>  #endif
> -- 
> 2.27.0
> 

-- 
மணிவண்ணன் சதாசிவம்
