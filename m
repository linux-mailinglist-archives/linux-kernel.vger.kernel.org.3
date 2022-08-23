Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A8E59EA53
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 19:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbiHWRyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 13:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233268AbiHWRxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:53:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C55AE9F6;
        Tue, 23 Aug 2022 08:55:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 29731B81E61;
        Tue, 23 Aug 2022 15:55:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE600C433C1;
        Tue, 23 Aug 2022 15:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661270148;
        bh=PQ8g+OexITZDvNf0mANT0okRPm24gjLqY5p5/aLxiXs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BX6SN9IBU9MaQhwVWV7yk5m0ow01De+4MUnHu7bMNVddxS60RC+h1AdkVJTKZLPJu
         YIFWHvPX45VnoOTjaEjXWDxoKV9aDIs4ei5IfXS94BAnBB+TSGVLzdtZnvj4D1fCc3
         G6otO+Y9Bx9dzc/Li3DcvAh+ke7EN5E7pyBJBzSy9nwMyvoitwaoGaSw5MaaJZUf71
         6WnsOC1X6JZZwwG5cKul/Hkk7T8vmCVOFe1m6Ur0D26+PR8COsi/gHnnyVXNPIC3yL
         Q5AnInFB5E2JiSrGSLY72iEI1GrxpuT4AAhjGR9Af4CqpmBxkAccSHciGHc30c0XC3
         PfxpyKpjPu0Lg==
Date:   Tue, 23 Aug 2022 17:55:41 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: pci-bridge-emul: Set position of PCI
 capabilities to real HW value
Message-ID: <YwT4fRJ4dF2JflwF@lpieralisi>
References: <20220703104627.27058-1-pali@kernel.org>
 <20220823101439.24525-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220823101439.24525-1-pali@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 12:14:39PM +0200, Pali Roh�r wrote:
> mvebu and aardvark HW have PCIe capabilities on different offset in PCI
> config space. Extend pci-bridge-emul.c code to allow setting custom driver
> custom value where PCIe capabilities starts.
> 
> With this change PCIe capabilities of both drivers are reported at the same
> location as where they are reported by U-Boot - in their real HW offset.
> 
> Signed-off-by: Pali Roh�r <pali@kernel.org>
> ---
> Changes in v2:
> * Rebase on top of v6.0-rc1, fix usage of PCIE_CAP_PCIEXP
> ---
>  drivers/pci/controller/pci-aardvark.c |  1 +
>  drivers/pci/controller/pci-mvebu.c    |  1 +
>  drivers/pci/pci-bridge-emul.c         | 46 +++++++++++++++++----------
>  drivers/pci/pci-bridge-emul.h         |  2 ++
>  4 files changed, 33 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> index 966c8b48bd96..4834198cc86b 100644
> --- a/drivers/pci/controller/pci-aardvark.c
> +++ b/drivers/pci/controller/pci-aardvark.c
> @@ -1078,6 +1078,7 @@ static int advk_sw_pci_bridge_init(struct advk_pcie *pcie)
>  	bridge->pcie_conf.rootcap = cpu_to_le16(PCI_EXP_RTCAP_CRSVIS);
>  
>  	bridge->has_pcie = true;
> +	bridge->pcie_start = PCIE_CORE_PCIEXP_CAP;
>  	bridge->data = pcie;
>  	bridge->ops = &advk_pci_bridge_emul_ops;
>  
> diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
> index af915c951f06..0fdbb5585fec 100644
> --- a/drivers/pci/controller/pci-mvebu.c
> +++ b/drivers/pci/controller/pci-mvebu.c
> @@ -946,6 +946,7 @@ static int mvebu_pci_bridge_emul_init(struct mvebu_pcie_port *port)
>  	bridge->subsystem_vendor_id = ssdev_id & 0xffff;
>  	bridge->subsystem_id = ssdev_id >> 16;
>  	bridge->has_pcie = true;
> +	bridge->pcie_start = PCIE_CAP_PCIEXP;
>  	bridge->data = port;
>  	bridge->ops = &mvebu_pci_bridge_emul_ops;
>  
> diff --git a/drivers/pci/pci-bridge-emul.c b/drivers/pci/pci-bridge-emul.c
> index 9c2ca28e3ecf..dfbbe43ef518 100644
> --- a/drivers/pci/pci-bridge-emul.c
> +++ b/drivers/pci/pci-bridge-emul.c
> @@ -22,11 +22,7 @@
>  
>  #define PCI_BRIDGE_CONF_END	PCI_STD_HEADER_SIZEOF
>  #define PCI_CAP_SSID_SIZEOF	(PCI_SSVID_DEVICE_ID + 2)
> -#define PCI_CAP_SSID_START	PCI_BRIDGE_CONF_END
> -#define PCI_CAP_SSID_END	(PCI_CAP_SSID_START + PCI_CAP_SSID_SIZEOF)
>  #define PCI_CAP_PCIE_SIZEOF	(PCI_EXP_SLTSTA2 + 2)
> -#define PCI_CAP_PCIE_START	PCI_CAP_SSID_END
> -#define PCI_CAP_PCIE_END	(PCI_CAP_PCIE_START + PCI_CAP_PCIE_SIZEOF)
>  
>  /**
>   * struct pci_bridge_reg_behavior - register bits behaviors
> @@ -324,7 +320,7 @@ pci_bridge_emul_read_ssid(struct pci_bridge_emul *bridge, int reg, u32 *value)
>  	switch (reg) {
>  	case PCI_CAP_LIST_ID:
>  		*value = PCI_CAP_ID_SSVID |
> -			(bridge->has_pcie ? (PCI_CAP_PCIE_START << 8) : 0);
> +			((bridge->pcie_start > bridge->ssid_start) ? (bridge->pcie_start << 8) : 0);
>  		return PCI_BRIDGE_EMUL_HANDLED;
>  
>  	case PCI_SSVID_VENDOR_ID:
> @@ -365,12 +361,25 @@ int pci_bridge_emul_init(struct pci_bridge_emul *bridge,
>  	if (!bridge->pci_regs_behavior)
>  		return -ENOMEM;
>  
> -	if (bridge->subsystem_vendor_id)
> -		bridge->conf.capabilities_pointer = PCI_CAP_SSID_START;
> -	else if (bridge->has_pcie)
> -		bridge->conf.capabilities_pointer = PCI_CAP_PCIE_START;
> -	else
> -		bridge->conf.capabilities_pointer = 0;
> +	/* If ssid_start and pcie_start were not specified then choose the lowest possible value. */
> +	if (!bridge->ssid_start && !bridge->pcie_start) {
> +		if (bridge->subsystem_vendor_id)
> +			bridge->ssid_start = PCI_BRIDGE_CONF_END;
> +		if (bridge->has_pcie)
> +			bridge->pcie_start = bridge->ssid_start + PCI_CAP_SSID_SIZEOF;
> +	} else if (!bridge->ssid_start && bridge->subsystem_vendor_id) {
> +		if (bridge->pcie_start - PCI_BRIDGE_CONF_END >= PCI_CAP_SSID_SIZEOF)
> +			bridge->ssid_start = PCI_BRIDGE_CONF_END;
> +		else
> +			bridge->ssid_start = bridge->pcie_start + PCI_CAP_PCIE_SIZEOF;
> +	} else if (!bridge->pcie_start && bridge->has_pcie) {
> +		if (bridge->ssid_start - PCI_BRIDGE_CONF_END >= PCI_CAP_PCIE_SIZEOF)
> +			bridge->pcie_start = PCI_BRIDGE_CONF_END;

Right. So here the PCI express capability should be made to point to
subsystem ID vendor capability but I don't see anything in the code
that makes it happen. I am just trying to understand what this patch
is changing and AFAICS this code path is not triggered with current
code but it may well be in the future.

In other words: what if PCI express capability is lower in the address
space (config) than the subsystem ID vendor capability ?

I am just trying to understand the patch, so forgive me if the question
is already addressed in the code.

Thanks,
Lorenzo

> +		else
> +			bridge->pcie_start = bridge->ssid_start + PCI_CAP_SSID_SIZEOF;
> +	}
> +
> +	bridge->conf.capabilities_pointer = min(bridge->ssid_start, bridge->pcie_start);
>  
>  	if (bridge->conf.capabilities_pointer)
>  		bridge->conf.status |= cpu_to_le16(PCI_STATUS_CAP_LIST);
> @@ -459,15 +468,17 @@ int pci_bridge_emul_conf_read(struct pci_bridge_emul *bridge, int where,
>  		read_op = bridge->ops->read_base;
>  		cfgspace = (__le32 *) &bridge->conf;
>  		behavior = bridge->pci_regs_behavior;
> -	} else if (reg >= PCI_CAP_SSID_START && reg < PCI_CAP_SSID_END && bridge->subsystem_vendor_id) {
> +	} else if (reg >= bridge->ssid_start && reg < bridge->ssid_start + PCI_CAP_SSID_SIZEOF &&
> +		   bridge->subsystem_vendor_id) {
>  		/* Emulated PCI Bridge Subsystem Vendor ID capability */
> -		reg -= PCI_CAP_SSID_START;
> +		reg -= bridge->ssid_start;
>  		read_op = pci_bridge_emul_read_ssid;
>  		cfgspace = NULL;
>  		behavior = NULL;
> -	} else if (reg >= PCI_CAP_PCIE_START && reg < PCI_CAP_PCIE_END && bridge->has_pcie) {
> +	} else if (reg >= bridge->pcie_start && reg < bridge->pcie_start + PCI_CAP_PCIE_SIZEOF &&
> +		   bridge->has_pcie) {
>  		/* Our emulated PCIe capability */
> -		reg -= PCI_CAP_PCIE_START;
> +		reg -= bridge->pcie_start;
>  		read_op = bridge->ops->read_pcie;
>  		cfgspace = (__le32 *) &bridge->pcie_conf;
>  		behavior = bridge->pcie_cap_regs_behavior;
> @@ -538,9 +549,10 @@ int pci_bridge_emul_conf_write(struct pci_bridge_emul *bridge, int where,
>  		write_op = bridge->ops->write_base;
>  		cfgspace = (__le32 *) &bridge->conf;
>  		behavior = bridge->pci_regs_behavior;
> -	} else if (reg >= PCI_CAP_PCIE_START && reg < PCI_CAP_PCIE_END && bridge->has_pcie) {
> +	} else if (reg >= bridge->pcie_start && reg < bridge->pcie_start + PCI_CAP_PCIE_SIZEOF &&
> +		   bridge->has_pcie) {
>  		/* Our emulated PCIe capability */
> -		reg -= PCI_CAP_PCIE_START;
> +		reg -= bridge->pcie_start;
>  		write_op = bridge->ops->write_pcie;
>  		cfgspace = (__le32 *) &bridge->pcie_conf;
>  		behavior = bridge->pcie_cap_regs_behavior;
> diff --git a/drivers/pci/pci-bridge-emul.h b/drivers/pci/pci-bridge-emul.h
> index 71392b67471d..2a0e59c7f0d9 100644
> --- a/drivers/pci/pci-bridge-emul.h
> +++ b/drivers/pci/pci-bridge-emul.h
> @@ -131,6 +131,8 @@ struct pci_bridge_emul {
>  	struct pci_bridge_reg_behavior *pci_regs_behavior;
>  	struct pci_bridge_reg_behavior *pcie_cap_regs_behavior;
>  	void *data;
> +	u8 pcie_start;
> +	u8 ssid_start;
>  	bool has_pcie;
>  	u16 subsystem_vendor_id;
>  	u16 subsystem_id;
> -- 
> 2.20.1
> 
