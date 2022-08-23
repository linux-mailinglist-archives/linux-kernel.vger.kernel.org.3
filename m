Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B376C59E1D0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 14:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350222AbiHWLdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 07:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358264AbiHWL1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 07:27:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9399BC4833;
        Tue, 23 Aug 2022 02:25:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 662F4B81C65;
        Tue, 23 Aug 2022 09:25:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8875C433D7;
        Tue, 23 Aug 2022 09:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661246715;
        bh=P5WYwbCMtY3VccArkx5/28ZRjGDM+TbQEY7NyV9Q9uk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cTenMwVaHgkkg1MWmT4MfJDOgSxC08zu8/2+JbZ+0ZywUTKjFR+J/1UcJmL39xHE2
         eqJJsOwrxTRRwIVdDSwmZ5eOlyOcdZkZrhPuMBCmDU+s5xCPk+omP/T92ckR5Zv/46
         DvK8TAQjQ0mQm9dT4iIYsfSRJEzHuzXGnDuJ28VfadBeLnPPMXITTFyATgpShR+I8/
         cuxR9vTdtQnYM+CXQ4AqSaT/Vu6uaUZ+J+ZvVnXSn8+Ow3L6dvLBdqbD+9e9jeELDp
         +ldTvLuLLBMg9jkq7oVVfSnTEQ0zrGQBKhS3u4oKY8w2jFYN23xDWWpWYNialCeaSH
         HxHclhat489hA==
Received: by pali.im (Postfix)
        id 0C0E9621; Tue, 23 Aug 2022 11:25:11 +0200 (CEST)
Date:   Tue, 23 Aug 2022 11:25:11 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: pci-bridge-emul: Set position of PCI capabilities
 to real HW value
Message-ID: <20220823092511.lgyg3q5m55etumcz@pali>
References: <20220703104627.27058-1-pali@kernel.org>
 <YwSYjmJrTDW0T7nf@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YwSYjmJrTDW0T7nf@lpieralisi>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 23 August 2022 11:06:22 Lorenzo Pieralisi wrote:
> On Sun, Jul 03, 2022 at 12:46:27PM +0200, Pali Rohár wrote:
> > mvebu and aardvark HW have PCIe capabilities on different offset in PCI
> > config space. Extend pci-bridge-emul.c code to allow setting custom driver
> > custom value where PCIe capabilities starts.
> > 
> > With this change PCIe capabilities of both drivers are reported at the same
> > location as where they are reported by U-Boot - in their real HW offset.
> > 
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > ---
> >  drivers/pci/controller/pci-aardvark.c |  1 +
> >  drivers/pci/controller/pci-mvebu.c    |  1 +
> >  drivers/pci/pci-bridge-emul.c         | 46 +++++++++++++++++----------
> >  drivers/pci/pci-bridge-emul.h         |  2 ++
> >  4 files changed, 33 insertions(+), 17 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> > index ffec82c8a523..32f97e71e0ca 100644
> > --- a/drivers/pci/controller/pci-aardvark.c
> > +++ b/drivers/pci/controller/pci-aardvark.c
> > @@ -984,6 +984,7 @@ static int advk_sw_pci_bridge_init(struct advk_pcie *pcie)
> >  	bridge->pcie_conf.rootcap = cpu_to_le16(PCI_EXP_RTCAP_CRSVIS);
> >  
> >  	bridge->has_pcie = true;
> > +	bridge->pcie_start = PCIE_CORE_PCIEXP_CAP;
> >  	bridge->data = pcie;
> >  	bridge->ops = &advk_pci_bridge_emul_ops;
> >  
> > diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
> > index c1ffdb06c971..cb7cf3f4802f 100644
> > --- a/drivers/pci/controller/pci-mvebu.c
> > +++ b/drivers/pci/controller/pci-mvebu.c
> > @@ -946,6 +946,7 @@ static int mvebu_pci_bridge_emul_init(struct mvebu_pcie_port *port)
> >  	bridge->subsystem_vendor_id = ssdev_id & 0xffff;
> >  	bridge->subsystem_id = ssdev_id >> 16;
> >  	bridge->has_pcie = true;
> > +	bridge->pcie_start = PCIE_CAP_PCIEXP_OFF;
> 
> Is this patch to be applied against v6.0-rc1 ? Just asking, can't
> find this define.

Macro is without _OFF suffix. I will fix it in v2.

> >  	bridge->data = port;
> >  	bridge->ops = &mvebu_pci_bridge_emul_ops;
> >  
> > diff --git a/drivers/pci/pci-bridge-emul.c b/drivers/pci/pci-bridge-emul.c
> > index 9c2ca28e3ecf..dfbbe43ef518 100644
> > --- a/drivers/pci/pci-bridge-emul.c
> > +++ b/drivers/pci/pci-bridge-emul.c
> > @@ -22,11 +22,7 @@
> >  
> >  #define PCI_BRIDGE_CONF_END	PCI_STD_HEADER_SIZEOF
> >  #define PCI_CAP_SSID_SIZEOF	(PCI_SSVID_DEVICE_ID + 2)
> > -#define PCI_CAP_SSID_START	PCI_BRIDGE_CONF_END
> > -#define PCI_CAP_SSID_END	(PCI_CAP_SSID_START + PCI_CAP_SSID_SIZEOF)
> >  #define PCI_CAP_PCIE_SIZEOF	(PCI_EXP_SLTSTA2 + 2)
> > -#define PCI_CAP_PCIE_START	PCI_CAP_SSID_END
> > -#define PCI_CAP_PCIE_END	(PCI_CAP_PCIE_START + PCI_CAP_PCIE_SIZEOF)
> >  
> >  /**
> >   * struct pci_bridge_reg_behavior - register bits behaviors
> > @@ -324,7 +320,7 @@ pci_bridge_emul_read_ssid(struct pci_bridge_emul *bridge, int reg, u32 *value)
> >  	switch (reg) {
> >  	case PCI_CAP_LIST_ID:
> >  		*value = PCI_CAP_ID_SSVID |
> > -			(bridge->has_pcie ? (PCI_CAP_PCIE_START << 8) : 0);
> > +			((bridge->pcie_start > bridge->ssid_start) ? (bridge->pcie_start << 8) : 0);
> >  		return PCI_BRIDGE_EMUL_HANDLED;
> >  
> >  	case PCI_SSVID_VENDOR_ID:
> > @@ -365,12 +361,25 @@ int pci_bridge_emul_init(struct pci_bridge_emul *bridge,
> >  	if (!bridge->pci_regs_behavior)
> >  		return -ENOMEM;
> >  
> > -	if (bridge->subsystem_vendor_id)
> > -		bridge->conf.capabilities_pointer = PCI_CAP_SSID_START;
> > -	else if (bridge->has_pcie)
> > -		bridge->conf.capabilities_pointer = PCI_CAP_PCIE_START;
> > -	else
> > -		bridge->conf.capabilities_pointer = 0;
> > +	/* If ssid_start and pcie_start were not specified then choose the lowest possible value. */
> 
> Is this an assumption ? I don't see why this logic belongs in the
> generic bridge emulation, I'd say that ssid_start, pcie_start and
> the capabilities pointer should be set in the respective host
> controller drivers, I don't think this belong in generic bridge
> emulation code.
> 
> Thoughts ?

The point is that it is this bridge emulation code which construct
linked list of PCI capabilities, it has full control over placement of
registers and host controller drivers just implement callbacks for
particular capability. Callbacks use register offset relative to the
start of capability, so bridge can put pcie_start and ssid_start to any
position in config space which does not conflict with other things.

And usage of lowest possible value is just some canonical choice where
to put it. It was also before this change. Now host controller drivers
can say that they want to put those capabilities at specific location
and not at location chosen by bridge emulation code.

> Lorenzo
> 
> > +	if (!bridge->ssid_start && !bridge->pcie_start) {
> > +		if (bridge->subsystem_vendor_id)
> > +			bridge->ssid_start = PCI_BRIDGE_CONF_END;
> > +		if (bridge->has_pcie)
> > +			bridge->pcie_start = bridge->ssid_start + PCI_CAP_SSID_SIZEOF;
> > +	} else if (!bridge->ssid_start && bridge->subsystem_vendor_id) {
> > +		if (bridge->pcie_start - PCI_BRIDGE_CONF_END >= PCI_CAP_SSID_SIZEOF)
> > +			bridge->ssid_start = PCI_BRIDGE_CONF_END;
> > +		else
> > +			bridge->ssid_start = bridge->pcie_start + PCI_CAP_PCIE_SIZEOF;
> > +	} else if (!bridge->pcie_start && bridge->has_pcie) {
> > +		if (bridge->ssid_start - PCI_BRIDGE_CONF_END >= PCI_CAP_PCIE_SIZEOF)
> > +			bridge->pcie_start = PCI_BRIDGE_CONF_END;
> > +		else
> > +			bridge->pcie_start = bridge->ssid_start + PCI_CAP_SSID_SIZEOF;
> > +	}
> > +
> > +	bridge->conf.capabilities_pointer = min(bridge->ssid_start, bridge->pcie_start);
> 
> >  
> >  	if (bridge->conf.capabilities_pointer)
> >  		bridge->conf.status |= cpu_to_le16(PCI_STATUS_CAP_LIST);
> > @@ -459,15 +468,17 @@ int pci_bridge_emul_conf_read(struct pci_bridge_emul *bridge, int where,
> >  		read_op = bridge->ops->read_base;
> >  		cfgspace = (__le32 *) &bridge->conf;
> >  		behavior = bridge->pci_regs_behavior;
> > -	} else if (reg >= PCI_CAP_SSID_START && reg < PCI_CAP_SSID_END && bridge->subsystem_vendor_id) {
> > +	} else if (reg >= bridge->ssid_start && reg < bridge->ssid_start + PCI_CAP_SSID_SIZEOF &&
> > +		   bridge->subsystem_vendor_id) {
> >  		/* Emulated PCI Bridge Subsystem Vendor ID capability */
> > -		reg -= PCI_CAP_SSID_START;
> > +		reg -= bridge->ssid_start;
> >  		read_op = pci_bridge_emul_read_ssid;
> >  		cfgspace = NULL;
> >  		behavior = NULL;
> > -	} else if (reg >= PCI_CAP_PCIE_START && reg < PCI_CAP_PCIE_END && bridge->has_pcie) {
> > +	} else if (reg >= bridge->pcie_start && reg < bridge->pcie_start + PCI_CAP_PCIE_SIZEOF &&
> > +		   bridge->has_pcie) {
> >  		/* Our emulated PCIe capability */
> > -		reg -= PCI_CAP_PCIE_START;
> > +		reg -= bridge->pcie_start;
> >  		read_op = bridge->ops->read_pcie;
> >  		cfgspace = (__le32 *) &bridge->pcie_conf;
> >  		behavior = bridge->pcie_cap_regs_behavior;
> > @@ -538,9 +549,10 @@ int pci_bridge_emul_conf_write(struct pci_bridge_emul *bridge, int where,
> >  		write_op = bridge->ops->write_base;
> >  		cfgspace = (__le32 *) &bridge->conf;
> >  		behavior = bridge->pci_regs_behavior;
> > -	} else if (reg >= PCI_CAP_PCIE_START && reg < PCI_CAP_PCIE_END && bridge->has_pcie) {
> > +	} else if (reg >= bridge->pcie_start && reg < bridge->pcie_start + PCI_CAP_PCIE_SIZEOF &&
> > +		   bridge->has_pcie) {
> >  		/* Our emulated PCIe capability */
> > -		reg -= PCI_CAP_PCIE_START;
> > +		reg -= bridge->pcie_start;
> >  		write_op = bridge->ops->write_pcie;
> >  		cfgspace = (__le32 *) &bridge->pcie_conf;
> >  		behavior = bridge->pcie_cap_regs_behavior;
> > diff --git a/drivers/pci/pci-bridge-emul.h b/drivers/pci/pci-bridge-emul.h
> > index 71392b67471d..2a0e59c7f0d9 100644
> > --- a/drivers/pci/pci-bridge-emul.h
> > +++ b/drivers/pci/pci-bridge-emul.h
> > @@ -131,6 +131,8 @@ struct pci_bridge_emul {
> >  	struct pci_bridge_reg_behavior *pci_regs_behavior;
> >  	struct pci_bridge_reg_behavior *pcie_cap_regs_behavior;
> >  	void *data;
> > +	u8 pcie_start;
> > +	u8 ssid_start;
> >  	bool has_pcie;
> >  	u16 subsystem_vendor_id;
> >  	u16 subsystem_id;
> > -- 
> > 2.20.1
> > 
