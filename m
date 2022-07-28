Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32DC5841D8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 16:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbiG1Oh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 10:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbiG1OfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 10:35:20 -0400
Received: from mail.baikalelectronics.com (unknown [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BD65F4D82B;
        Thu, 28 Jul 2022 07:34:45 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 8E51C16D6;
        Thu, 28 Jul 2022 17:37:09 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 8E51C16D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1659019029;
        bh=k8cqCIZ1UKDayziIYbpjw+xAAOPDcYeeuHLMd+JNEjE=;
        h=From:To:CC:Subject:Date:From;
        b=jDmGE//Awzyh+2BOgapYJYAyd0ZSEtgn5dEXZTO4Z8svyMcvnM9gKTNE6KFlUjiVu
         XE/V3bRuLnO92MbBS4yJjDBkJE0HlvheFdQUpkFbqC9voxIx3RYtP/JZxl04eHF8ND
         5ZyJeyLNtgYdVF/nBtyG3eiB7bCE9UmYKXgojDYM=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 28 Jul 2022 17:34:44 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 00/17] PCI: dwc: Add generic resources and Baikal-T1 support
Date:   Thu, 28 Jul 2022 17:34:10 +0300
Message-ID: <20220728143427.13617-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,T_SPF_PERMERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is a third one in the series created in the framework of
my Baikal-T1 PCIe/eDMA-related work:

[1: Done v5] PCI: dwc: Various fixes and cleanups
Link: https://lore.kernel.org/linux-pci/20220624143428.8334-1-Sergey.Semin@baikalelectronics.ru/
Link: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/?h=pci/ctrl/dwc-fixes
[2: Done v4] PCI: dwc: Add hw version and dma-ranges support
Link: https://lore.kernel.org/linux-pci/20220624143947.8991-1-Sergey.Semin@baikalelectronics.ru
[3: In-review v4] PCI: dwc: Add generic resources and Baikal-T1 support
Link: ---you are looking at it---
[4: Done v4] dmaengine: dw-edma: Add RP/EP local DMA support
Link: https://lore.kernel.org/linux-pci/20220728142841.12305-1-Sergey.Semin@baikalelectronics.ru/

Note it is very recommended to merge the patchsets in the same order as
they are listed in the set above in order to have them applied smoothly.
Nothing prevents them from being reviewed synchronously though.

@Bjorn, as we agreed here:
Link: https://lore.kernel.org/linux-pci/20220616163533.GA1094478@bhelgaas
could you please merge this series into the 'pci/edma' branch of your repo:
Link: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/log/?h=pci/edma
Thanks.

Originally the patches submitted in this patchset were a part of the series:
Link: https://lore.kernel.org/linux-pci/20220503214638.1895-1-Sergey.Semin@baikalelectronics.ru/
but due to the reviewers requests the series was expanded to about 30
patches which made it too bulky for a comfortable review. So I decided to
split it up into two patchsets: 2. and 3. in the table above.

Regarding the series content. This patchset is mainly about adding new DW
PCIe platform support - Baikal-T1 PCIe of DW PCIe v4.60a IP-core. But a
set of feature-reach preparations are done first. It starts from
converting the currently available DT-schema into a more flexible schemas
hierarchy with separately defined regs, clocks, resets and interrupts
properties. As a result the common schema can be easily re-used by all the
currently available platforms while the named properties above can be
either re-defined or used as is if the platforms support they. In the
framework of that modification we also suggest to add a set of generic
regs, clocks, resets and interrupts resource names in accordance with what
the DW PCIe hardware reference manual describes and what the DW PCIe core
driver already expects to be specified. Thus the new platform driver will
be able to re-use the common resources infrastructure.

Link: https://lore.kernel.org/linux-pci/20220324013734.18234-1-Sergey.Semin@baikalelectronics.ru/
Changelog v2:
- Rename 'syscon' property to 'baikal,bt1-syscon'. (@Rob)
- Move the iATU region selection procedure into a helper function (@Rob).
- Rebase from kernel v5.17 onto v5.18-rc3 since the later kernel has
  already DT bindings converted. (@Rob)
- Use 'definitions' property instead of the '$defs' one. It fixes the
  dt-validate error: 'X is not of type array.'
- Drop 'interrupts' and 'interrupt-names' property from being required
  for the native DW PCIe host.
- Evaluate the 'snps,dw-pcie-common.yaml' schema in the
  'socionext,uniphier-pcie-ep.yaml' DT-bindings since the later has
  platform-specific names defined.

Link: https://lore.kernel.org/linux-pci/20220503225104.12108-1-Sergey.Semin@baikalelectronics.ru
Changelog v3:
- Split up the patch "dt-bindings: PCI: dwc: Define common and native DT
  bindings" into a series of modifications. (@Rob)
- Detach this series of the patches into a dedicated patchset.
- Add a new feature patch: "PCI: dwc: Introduce generic controller
  capabilities interface".
- Add a new feature patch: "PCI: dwc: Introduce generic resources getter".
- Add a new cleanup patch: "PCI: dwc: Combine iATU detection procedures".
- Add a method to at least request the generic clocks and resets. (@Rob)
- Add GPIO-based PERST# signal support to the core module.
- Redefine Baikal-T1 PCIe host bridge config space accessors with the
  pci_generic_config_read32() and pci_generic_config_write32() methods.
  (@Rob)
- Drop synonymous from the names list in the common DT-schema since the
  device sub-schemas create their own enumerations anyway.
- Rebase onto kernel v5.18.

Link: https://lore.kernel.org/linux-pci/20220610085706.15741-1-Sergey.Semin@baikalelectronics.ru/
Changelog v4:
- Drop PCIBIOS_* macros usage. (@Rob)
- Add "static const" to the dw_pcie_ops and dw_pcie_host_ops structure
  instances. (@Bjorn)
- Rename bt1_pcie_dw_ops to bt1_pcie_ops. (@Bjorn)
- Rename bt1_pcie_ops to bt1_pci_ops. (@Bjorn)
- Use start_link/stop_link suffixes in the Baikal-T1 PCIe
  start/stop link callbacks. (@Bjorn)
- Change the get_res() method suffix to being get_resources(). (@Bjorn)
- Change *_{add,del}_dw_port() method to *_{add,del}_port(). (@Bjorn)
- Drop dma_coerce_mask_and_coherent() applied to the PCI host bridge
  kernel device instance. (@Bjorn)
- Add the comment above the dma_set_mask_and_coherent() method usage
  regarding the controller eDMA feature. (@Bjorn)
- Fix the comment above the core reset controls assertion. (@Bjorn)
- Replace delays and timeout numeric literals with macros. (@Bjorn)
- Convert the method name from dw_pcie_get_res() to
  dw_pcie_get_resources(). (@Bjorn)
- Rebase onto the kernel v5.19-rcX.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
Cc: "Krzysztof Wilczyński" <kw@linux.com>
Cc: Frank Li <Frank.Li@nxp.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-pci@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Serge Semin (17):
  dt-bindings: PCI: dwc: Detach common RP/EP DT bindings
  dt-bindings: PCI: dwc: Remove bus node from the examples
  dt-bindings: PCI: dwc: Add phys/phy-names common properties
  dt-bindings: PCI: dwc: Add max-link-speed common property
  dt-bindings: PCI: dwc: Stop selecting generic bindings by default
  dt-bindings: PCI: dwc: Add max-functions EP property
  dt-bindings: PCI: dwc: Add interrupts/interrupt-names common
    properties
  dt-bindings: PCI: dwc: Add reg/reg-names common properties
  dt-bindings: PCI: dwc: Add clocks/resets common properties
  dt-bindings: PCI: dwc: Add dma-coherent property
  dt-bindings: PCI: dwc: Apply common schema to Rockchip DW PCIe nodes
  dt-bindings: PCI: dwc: Add Baikal-T1 PCIe Root Port bindings
  PCI: dwc: Introduce generic controller capabilities interface
  PCI: dwc: Introduce generic resources getter
  PCI: dwc: Combine iATU detection procedures
  PCI: dwc: Introduce generic platform clocks and resets
  PCI: dwc: Add Baikal-T1 PCIe controller support

 .../bindings/pci/baikal,bt1-pcie.yaml         | 154 +++++
 .../bindings/pci/fsl,imx6q-pcie.yaml          |   3 +-
 .../bindings/pci/hisilicon,kirin-pcie.yaml    |   3 +-
 .../bindings/pci/rockchip-dw-pcie.yaml        |   3 +-
 .../bindings/pci/samsung,exynos-pcie.yaml     |   3 +-
 .../bindings/pci/sifive,fu740-pcie.yaml       |   3 +-
 .../bindings/pci/snps,dw-pcie-common.yaml     | 323 +++++++++
 .../bindings/pci/snps,dw-pcie-ep.yaml         | 155 +++--
 .../devicetree/bindings/pci/snps,dw-pcie.yaml | 208 ++++--
 .../pci/socionext,uniphier-pcie-ep.yaml       |  12 +-
 .../bindings/pci/toshiba,visconti-pcie.yaml   |   3 +-
 drivers/pci/controller/dwc/Kconfig            |   9 +
 drivers/pci/controller/dwc/Makefile           |   1 +
 drivers/pci/controller/dwc/pcie-bt1.c         | 653 ++++++++++++++++++
 .../pci/controller/dwc/pcie-designware-ep.c   |  26 +-
 .../pci/controller/dwc/pcie-designware-host.c |  15 +-
 drivers/pci/controller/dwc/pcie-designware.c  | 206 ++++--
 drivers/pci/controller/dwc/pcie-designware.h  |  57 +-
 18 files changed, 1628 insertions(+), 209 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/baikal,bt1-pcie.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-bt1.c

-- 
2.35.1

