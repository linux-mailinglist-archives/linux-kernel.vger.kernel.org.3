Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9F249AF12
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 10:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1454457AbiAYI7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 03:59:30 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:56956 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1453979AbiAYI47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 03:56:59 -0500
X-UUID: cb91789688a241969ef728b51114aef3-20220125
X-UUID: cb91789688a241969ef728b51114aef3-20220125
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 757348763; Tue, 25 Jan 2022 16:56:45 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 25 Jan 2022 16:56:44 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 25 Jan 2022 16:56:42 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>
CC:     Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Tomasz Figa <tfiga@chromium.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, <anan.sun@mediatek.com>,
        <xueqi.zhang@mediatek.com>, <yen-chang.chen@mediatek.com>,
        "AngeloGioacchino Del Regno" 
        <angelogioacchino.delregno@collabora.com>,
        <mingyuan.ma@mediatek.com>, <yf.wang@mediatek.com>,
        <libo.kang@mediatek.com>, <chengci.xu@mediatek.com>
Subject: [PATCH v4 00/35] MT8195 IOMMU SUPPORT
Date:   Tue, 25 Jan 2022 16:55:59 +0800
Message-ID: <20220125085634.17972-1-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds MT8195 iommu support.

MT8195 have 3 IOMMU HWs. 2 IOMMU HW is for multimedia, and 1 IOMMU HW is
for infra-master, like PCIe/USB.

About the 2 MM IOMMU HW, something like this:

        IOMMU(VDO)          IOMMU(VPP)
           |                   |
      SMI_COMMON(VDO)      SMI_COMMON(VPP)
      ---------------     ----------------
      |      |   ...      |      |     ...
    larb0 larb2  ...    larb1 larb3    ...

these two MM IOMMU HW share a pgtable.

About the INFRA IOMMU, it don't have larbs, the master connects the iommu
directly. It use a independent pgtable.

Also, mt8195 IOMMU bank supports. Normally the IOMMU register size only
is 0x1000. In this IOMMU HW, the register size is 5 * 0x1000. each 0x1000
is a bank. the banks' register look like this:
     ----------------------------------------
     |bank0  | bank1 | bank2 | bank3 | bank4|
     ----------------------------------------
     |global |
     |control|         null
     |regs   |
     -----------------------------------------
     |bank   |bank   |bank   |bank   |bank   |
     |regs   |regs   |regs   |regs   |regs   |
     |       |       |       |       |       |
     -----------------------------------------
All the banks share some global control registers, and each bank have its
special bank registers, like pgtable base register, tlb operation registers,
the fault status registers.
 
In mt8195, we enable this bank feature for infra iommu, We put PCIe in bank0
and USB in bank4. they have independent pgtable.

Change note:
v4:1) Base on v5.16-rc1
   2) Base on tlb logic 2, some patches in v3 has already gone through in that
   patchset.
   https://lore.kernel.org/linux-mediatek/20211208120744.2415-1-dafna.hirschfeld@collabora.com/  
   3) Due to the unreadable union for v1/v2(comment in 26/33 of v3), I
   separate mtk_iommu_data for v1 and v2 totally, then remove mtk_iommu.h.
   please see patch[26/35][27/35].
   4) add two mutex for the internal data. patch[6/35][7/35].
   5) add a new flag PM_CLK_AO.

v3: https://lore.kernel.org/linux-mediatek/20210923115840.17813-1-yong.wu@mediatek.com/
    1) base on v5.15-rc1
    2) Adjust devlink with smi-common, not use the property(sub-sommon).
    3) Adjust tlb_flush_all flow,
       a) Fix tlb_flush_all only is supported in bank0.
       b) add tlb-flush-all in the resume callback.
       c) remove the pm status checking in tlb-flush-all.
       The reason are showed in the commit message.
    4) Allow IOMMU_DOMAIN_UNMANAGED since PCIe VFIO use that.
    5) Fix a clk warning and a null abort when unbind the iommu driver.

v2: https://lore.kernel.org/linux-mediatek/20210813065324.29220-1-yong.wu@mediatek.com/
    1) Base on v5.14-rc1.
    2) Fix build fail for arm32.
    3) Fix dt-binding issue from Rob.
    4) Fix the bank issue when tlb flush. v1 always use bank->base.
    5) adjust devlink with smi-common since the node may be smi-sub-common.
    6) other changes: like reword some commit message(removing many
       "This patch..."); seperate serveral patches.

v1: https://lore.kernel.org/linux-mediatek/20210630023504.18177-1-yong.wu@mediatek.com/
    Base on v5.13-rc1

Yong Wu (35):
  dt-bindings: mediatek: mt8195: Add binding for MM IOMMU
  dt-bindings: mediatek: mt8195: Add binding for infra IOMMU
  iommu/mediatek: Fix 2 HW sharing pgtable issue
  iommu/mediatek: Add list_del in mtk_iommu_remove
  iommu/mediatek: Remove clk_disable in mtk_iommu_remove
  iommu/mediatek: Add mutex for m4u_group and m4u_dom in data
  iommu/mediatek: Add mutex for data in the mtk_iommu_domain
  iommu/mediatek: Use kmalloc for protect buffer
  iommu/mediatek: Adapt sharing and non-sharing pgtable case
  iommu/mediatek: Add 12G~16G support for multi domains
  iommu/mediatek: Add a flag DCM_DISABLE
  iommu/mediatek: Add a flag NON_STD_AXI
  iommu/mediatek: Remove the granule in the tlb flush
  iommu/mediatek: Always enable output PA over 32bits in isr
  iommu/mediatek: Add SUB_COMMON_3BITS flag
  iommu/mediatek: Add IOMMU_TYPE flag
  iommu/mediatek: Contain MM IOMMU flow with the MM TYPE
  iommu/mediatek: Adjust device link when it is sub-common
  iommu/mediatek: Allow IOMMU_DOMAIN_UNMANAGED for PCIe VFIO
  iommu/mediatek: Add a PM_CLK_AO flag for infra iommu
  iommu/mediatek: Add infra iommu support
  iommu/mediatek: Add PCIe support
  iommu/mediatek: Add mt8195 support
  iommu/mediatek: Only adjust code about register base
  iommu/mediatek: Just move code position in hw_init
  iommu/mediatek: Separate mtk_iommu_data for v1 and v2
  iommu/mediatek: Remove mtk_iommu.h
  iommu/mediatek-v1: Just rename mtk_iommu to mtk_iommu_v1
  iommu/mediatek: Add mtk_iommu_bank_data structure
  iommu/mediatek: Initialise bank HW for each a bank
  iommu/mediatek: Change the domid to iova_region_id
  iommu/mediatek: Get the proper bankid for multi banks
  iommu/mediatek: Initialise/Remove for multi bank dev
  iommu/mediatek: Backup/restore regsiters for multi banks
  iommu/mediatek: mt8195: Enable multi banks for infra iommu

 .../bindings/iommu/mediatek,iommu.yaml        |  20 +-
 drivers/iommu/mtk_iommu.c                     | 951 +++++++++++++-----
 drivers/iommu/mtk_iommu.h                     | 111 --
 drivers/iommu/mtk_iommu_v1.c                  | 243 +++--
 .../dt-bindings/memory/mt8195-memory-port.h   | 408 ++++++++
 include/dt-bindings/memory/mtk-memory-port.h  |   2 +
 6 files changed, 1255 insertions(+), 480 deletions(-)
 delete mode 100644 drivers/iommu/mtk_iommu.h
 create mode 100644 include/dt-bindings/memory/mt8195-memory-port.h

-- 
2.18.0


