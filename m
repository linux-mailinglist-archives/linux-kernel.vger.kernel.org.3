Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C615C4BFE46
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 17:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233950AbiBVQQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 11:16:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233487AbiBVQQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 11:16:13 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3625B1662E2;
        Tue, 22 Feb 2022 08:15:47 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF79A1063;
        Tue, 22 Feb 2022 08:15:46 -0800 (PST)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A04133F70D;
        Tue, 22 Feb 2022 08:15:45 -0800 (PST)
Date:   Tue, 22 Feb 2022 16:15:39 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Russell King <rmk+kernel@armlinux.org.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: (subset) [PATCH v4 00/12] PCI: mvebu: subsystem ids, AER and INTx
Message-ID: <20220222161539.GA20114@lpieralisi>
References: <20220222155030.988-1-pali@kernel.org>
 <164554589988.5595.5091384618177225445.b4-ty@arm.com>
 <20220222161143.6ryghgtfmhnmhpmz@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220222161143.6ryghgtfmhnmhpmz@pali>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 05:11:43PM +0100, Pali Roh�r wrote:
> On Tuesday 22 February 2022 16:06:20 Lorenzo Pieralisi wrote:
> > On Tue, 22 Feb 2022 16:50:18 +0100, Pali Roh�r wrote:
> > > This patch series extends pci-bridge-emul.c driver to emulate PCI Subsystem
> > > Vendor ID capability and PCIe extended capabilities. And then implement
> > > in pci-mvebu.c driver support for PCI Subsystem Vendor IDs, PCIe AER
> > > registers, support for legacy INTx interrupts, configuration for X1/X4
> > > mode and usage of new PCI child_ops API.
> > > 
> > > Changes in v4:
> > > * rebased on c3bd7dc553eea5a3595ca3aa0adee9bf83622a1f
> > > 
> > > [...]
> > 
> > I can't apply dts changes, patch 12 should go via the arm-soc tree.
> 
> Gregory already wrote about this dts change:
> https://lore.kernel.org/linux-pci/87tud1jwpr.fsf@BL-laptop/
> "So the easier is to let merge it through the PCI subsystem with the
> other patches from this series."
> 
> Are there any issues with applying this dts change via pci tree?

I don't usually take dts changes through the PCI tree since they
can conflict with arm-soc, that's the issue - dts changes should
be managed by platform maintainers.

Thanks,
Lorenzo

> > Applied the others to pci/mvebu, thanks.
> > 
> > [01/12] PCI: pci-bridge-emul: Re-arrange register tests
> >         https://git.kernel.org/lpieralisi/pci/c/c453bf6f9b
> > [02/12] PCI: pci-bridge-emul: Add support for PCIe extended capabilities
> >         https://git.kernel.org/lpieralisi/pci/c/c0bd419732
> > [03/12] PCI: pci-bridge-emul: Add support for PCI Bridge Subsystem Vendor ID capability
> >         https://git.kernel.org/lpieralisi/pci/c/3767a90242
> > [04/12] dt-bindings: PCI: mvebu: Add num-lanes property
> >         https://git.kernel.org/lpieralisi/pci/c/26b982ca83
> > [05/12] PCI: mvebu: Correctly configure x1/x4 mode
> >         https://git.kernel.org/lpieralisi/pci/c/2a81dd9fd9
> > [06/12] PCI: mvebu: Add support for PCI Bridge Subsystem Vendor ID on emulated bridge
> >         https://git.kernel.org/lpieralisi/pci/c/e3e13c9135
> > [07/12] PCI: mvebu: Add support for Advanced Error Reporting registers on emulated bridge
> >         https://git.kernel.org/lpieralisi/pci/c/2b6ee04c0a
> > [08/12] PCI: mvebu: Use child_ops API
> >         https://git.kernel.org/lpieralisi/pci/c/c099c2a761
> > [09/12] dt-bindings: PCI: mvebu: Update information about intx interrupts
> >         https://git.kernel.org/lpieralisi/pci/c/0124989220
> > [10/12] PCI: mvebu: Fix macro names and comments about legacy interrupts
> >         https://git.kernel.org/lpieralisi/pci/c/d00ea94e62
> > [11/12] PCI: mvebu: Implement support for legacy INTx interrupts
> >         https://git.kernel.org/lpieralisi/pci/c/ec07526264
> > 
> > Thanks,
> > Lorenzo
