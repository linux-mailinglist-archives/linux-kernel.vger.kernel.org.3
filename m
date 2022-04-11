Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFD2A4FBED2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 16:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347020AbiDKORJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 10:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347046AbiDKOQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 10:16:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81607E08E
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 07:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=INRIvMwo11KtgAa+SwQOYbNtpPBlU91CJ19G0u46jJ0=; b=raPWPpF+Xm+yIyVADQbxeomslD
        akChkvXZX7wzb+Z9HhvxdQsuIqhciCt+h4D1HBsCAuv3+4OFjXW7jy6uV6yMdGdY+is0kaKeP/7FW
        B3x7FAholSOejd5uN7gjC8zzzhLxTPiWkcuTWw1myIemQyB8xJS3frSnLSQiQqefdjkqyPHijNeif
        VZuOC/35ZrbJ+E/bd+twf3+Khn+CY9mn25JWWelTA04t8mooD3bSwhHlDuIQR25b1hcuIkuwQF7K4
        GdVBQj+i+0MblIEmilfQ8cgp8/yyQnGCcgXPceIfbSxdBy0zhlebqG6fFESIcgg7fHYE+Ef+b+cnx
        HsJp8drA==;
Received: from [2001:4bb8:18e:76f5:3747:ef85:d03d:53e4] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nduoK-009KQE-JA; Mon, 11 Apr 2022 14:14:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/34] drm/i915/gvt: remove the map_gfn_to_mfn and set_trap_area ops
Date:   Mon, 11 Apr 2022 16:13:37 +0200
Message-Id: <20220411141403.86980-9-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220411141403.86980-1-hch@lst.de>
References: <20220411141403.86980-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The map_gfn_to_mfn and set_trap_area ops are never defined, so remove
them and clean up code that depends on them in the callers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/i915/gvt/cfg_space.c | 89 ++++++----------------------
 drivers/gpu/drm/i915/gvt/hypercall.h |  4 --
 drivers/gpu/drm/i915/gvt/mpt.h       | 44 --------------
 3 files changed, 17 insertions(+), 120 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/cfg_space.c b/drivers/gpu/drm/i915/gvt/cfg_space.c
index b490e3db2e382..dad3a60543354 100644
--- a/drivers/gpu/drm/i915/gvt/cfg_space.c
+++ b/drivers/gpu/drm/i915/gvt/cfg_space.c
@@ -129,60 +129,16 @@ int intel_vgpu_emulate_cfg_read(struct intel_vgpu *vgpu, unsigned int offset,
 	return 0;
 }
 
-static int map_aperture(struct intel_vgpu *vgpu, bool map)
+static void map_aperture(struct intel_vgpu *vgpu, bool map)
 {
-	phys_addr_t aperture_pa = vgpu_aperture_pa_base(vgpu);
-	unsigned long aperture_sz = vgpu_aperture_sz(vgpu);
-	u64 first_gfn;
-	u64 val;
-	int ret;
-
-	if (map == vgpu->cfg_space.bar[INTEL_GVT_PCI_BAR_APERTURE].tracked)
-		return 0;
-
-	val = vgpu_cfg_space(vgpu)[PCI_BASE_ADDRESS_2];
-	if (val & PCI_BASE_ADDRESS_MEM_TYPE_64)
-		val = *(u64 *)(vgpu_cfg_space(vgpu) + PCI_BASE_ADDRESS_2);
-	else
-		val = *(u32 *)(vgpu_cfg_space(vgpu) + PCI_BASE_ADDRESS_2);
-
-	first_gfn = (val + vgpu_aperture_offset(vgpu)) >> PAGE_SHIFT;
-
-	ret = intel_gvt_hypervisor_map_gfn_to_mfn(vgpu, first_gfn,
-						  aperture_pa >> PAGE_SHIFT,
-						  aperture_sz >> PAGE_SHIFT,
-						  map);
-	if (ret)
-		return ret;
-
-	vgpu->cfg_space.bar[INTEL_GVT_PCI_BAR_APERTURE].tracked = map;
-	return 0;
+	if (map != vgpu->cfg_space.bar[INTEL_GVT_PCI_BAR_APERTURE].tracked)
+		vgpu->cfg_space.bar[INTEL_GVT_PCI_BAR_APERTURE].tracked = map;
 }
 
-static int trap_gttmmio(struct intel_vgpu *vgpu, bool trap)
+static void trap_gttmmio(struct intel_vgpu *vgpu, bool trap)
 {
-	u64 start, end;
-	u64 val;
-	int ret;
-
-	if (trap == vgpu->cfg_space.bar[INTEL_GVT_PCI_BAR_GTTMMIO].tracked)
-		return 0;
-
-	val = vgpu_cfg_space(vgpu)[PCI_BASE_ADDRESS_0];
-	if (val & PCI_BASE_ADDRESS_MEM_TYPE_64)
-		start = *(u64 *)(vgpu_cfg_space(vgpu) + PCI_BASE_ADDRESS_0);
-	else
-		start = *(u32 *)(vgpu_cfg_space(vgpu) + PCI_BASE_ADDRESS_0);
-
-	start &= ~GENMASK(3, 0);
-	end = start + vgpu->cfg_space.bar[INTEL_GVT_PCI_BAR_GTTMMIO].size - 1;
-
-	ret = intel_gvt_hypervisor_set_trap_area(vgpu, start, end, trap);
-	if (ret)
-		return ret;
-
-	vgpu->cfg_space.bar[INTEL_GVT_PCI_BAR_GTTMMIO].tracked = trap;
-	return 0;
+	if (trap != vgpu->cfg_space.bar[INTEL_GVT_PCI_BAR_GTTMMIO].tracked)
+		vgpu->cfg_space.bar[INTEL_GVT_PCI_BAR_GTTMMIO].tracked = trap;
 }
 
 static int emulate_pci_command_write(struct intel_vgpu *vgpu,
@@ -191,26 +147,17 @@ static int emulate_pci_command_write(struct intel_vgpu *vgpu,
 	u8 old = vgpu_cfg_space(vgpu)[offset];
 	u8 new = *(u8 *)p_data;
 	u8 changed = old ^ new;
-	int ret;
 
 	vgpu_pci_cfg_mem_write(vgpu, offset, p_data, bytes);
 	if (!(changed & PCI_COMMAND_MEMORY))
 		return 0;
 
 	if (old & PCI_COMMAND_MEMORY) {
-		ret = trap_gttmmio(vgpu, false);
-		if (ret)
-			return ret;
-		ret = map_aperture(vgpu, false);
-		if (ret)
-			return ret;
+		trap_gttmmio(vgpu, false);
+		map_aperture(vgpu, false);
 	} else {
-		ret = trap_gttmmio(vgpu, true);
-		if (ret)
-			return ret;
-		ret = map_aperture(vgpu, true);
-		if (ret)
-			return ret;
+		trap_gttmmio(vgpu, true);
+		map_aperture(vgpu, true);
 	}
 
 	return 0;
@@ -230,13 +177,12 @@ static int emulate_pci_rom_bar_write(struct intel_vgpu *vgpu,
 	return 0;
 }
 
-static int emulate_pci_bar_write(struct intel_vgpu *vgpu, unsigned int offset,
+static void emulate_pci_bar_write(struct intel_vgpu *vgpu, unsigned int offset,
 	void *p_data, unsigned int bytes)
 {
 	u32 new = *(u32 *)(p_data);
 	bool lo = IS_ALIGNED(offset, 8);
 	u64 size;
-	int ret = 0;
 	bool mmio_enabled =
 		vgpu_cfg_space(vgpu)[PCI_COMMAND] & PCI_COMMAND_MEMORY;
 	struct intel_vgpu_pci_bar *bars = vgpu->cfg_space.bar;
@@ -259,14 +205,14 @@ static int emulate_pci_bar_write(struct intel_vgpu *vgpu, unsigned int offset,
 			 * Untrap the BAR, since guest hasn't configured a
 			 * valid GPA
 			 */
-			ret = trap_gttmmio(vgpu, false);
+			trap_gttmmio(vgpu, false);
 			break;
 		case PCI_BASE_ADDRESS_2:
 		case PCI_BASE_ADDRESS_3:
 			size = ~(bars[INTEL_GVT_PCI_BAR_APERTURE].size -1);
 			intel_vgpu_write_pci_bar(vgpu, offset,
 						size >> (lo ? 0 : 32), lo);
-			ret = map_aperture(vgpu, false);
+			map_aperture(vgpu, false);
 			break;
 		default:
 			/* Unimplemented BARs */
@@ -282,19 +228,18 @@ static int emulate_pci_bar_write(struct intel_vgpu *vgpu, unsigned int offset,
 			 */
 			trap_gttmmio(vgpu, false);
 			intel_vgpu_write_pci_bar(vgpu, offset, new, lo);
-			ret = trap_gttmmio(vgpu, mmio_enabled);
+			trap_gttmmio(vgpu, mmio_enabled);
 			break;
 		case PCI_BASE_ADDRESS_2:
 		case PCI_BASE_ADDRESS_3:
 			map_aperture(vgpu, false);
 			intel_vgpu_write_pci_bar(vgpu, offset, new, lo);
-			ret = map_aperture(vgpu, mmio_enabled);
+			map_aperture(vgpu, mmio_enabled);
 			break;
 		default:
 			intel_vgpu_write_pci_bar(vgpu, offset, new, lo);
 		}
 	}
-	return ret;
 }
 
 /**
@@ -336,8 +281,8 @@ int intel_vgpu_emulate_cfg_write(struct intel_vgpu *vgpu, unsigned int offset,
 	case PCI_BASE_ADDRESS_0 ... PCI_BASE_ADDRESS_5:
 		if (drm_WARN_ON(&i915->drm, !IS_ALIGNED(offset, 4)))
 			return -EINVAL;
-		return emulate_pci_bar_write(vgpu, offset, p_data, bytes);
-
+		emulate_pci_bar_write(vgpu, offset, p_data, bytes);
+		break;
 	case INTEL_GVT_PCI_SWSCI:
 		if (drm_WARN_ON(&i915->drm, !IS_ALIGNED(offset, 4)))
 			return -EINVAL;
diff --git a/drivers/gpu/drm/i915/gvt/hypercall.h b/drivers/gpu/drm/i915/gvt/hypercall.h
index 395bce9633faa..f1a4926f6f1be 100644
--- a/drivers/gpu/drm/i915/gvt/hypercall.h
+++ b/drivers/gpu/drm/i915/gvt/hypercall.h
@@ -62,10 +62,6 @@ struct intel_gvt_mpt {
 
 	int (*dma_pin_guest_page)(unsigned long handle, dma_addr_t dma_addr);
 
-	int (*map_gfn_to_mfn)(unsigned long handle, unsigned long gfn,
-			      unsigned long mfn, unsigned int nr, bool map);
-	int (*set_trap_area)(unsigned long handle, u64 start, u64 end,
-			     bool map);
 	int (*set_opregion)(void *vgpu);
 	int (*set_edid)(void *vgpu, int port_num);
 	int (*get_vfio_device)(void *vgpu);
diff --git a/drivers/gpu/drm/i915/gvt/mpt.h b/drivers/gpu/drm/i915/gvt/mpt.h
index 0e3966e1fec8b..bb0e9e71d13e2 100644
--- a/drivers/gpu/drm/i915/gvt/mpt.h
+++ b/drivers/gpu/drm/i915/gvt/mpt.h
@@ -270,50 +270,6 @@ intel_gvt_hypervisor_dma_pin_guest_page(struct intel_vgpu *vgpu,
 	return intel_gvt_host.mpt->dma_pin_guest_page(vgpu->handle, dma_addr);
 }
 
-/**
- * intel_gvt_hypervisor_map_gfn_to_mfn - map a GFN region to MFN
- * @vgpu: a vGPU
- * @gfn: guest PFN
- * @mfn: host PFN
- * @nr: amount of PFNs
- * @map: map or unmap
- *
- * Returns:
- * Zero on success, negative error code if failed.
- */
-static inline int intel_gvt_hypervisor_map_gfn_to_mfn(
-		struct intel_vgpu *vgpu, unsigned long gfn,
-		unsigned long mfn, unsigned int nr,
-		bool map)
-{
-	/* a MPT implementation could have MMIO mapped elsewhere */
-	if (!intel_gvt_host.mpt->map_gfn_to_mfn)
-		return 0;
-
-	return intel_gvt_host.mpt->map_gfn_to_mfn(vgpu->handle, gfn, mfn, nr,
-						  map);
-}
-
-/**
- * intel_gvt_hypervisor_set_trap_area - Trap a guest PA region
- * @vgpu: a vGPU
- * @start: the beginning of the guest physical address region
- * @end: the end of the guest physical address region
- * @map: map or unmap
- *
- * Returns:
- * Zero on success, negative error code if failed.
- */
-static inline int intel_gvt_hypervisor_set_trap_area(
-		struct intel_vgpu *vgpu, u64 start, u64 end, bool map)
-{
-	/* a MPT implementation could have MMIO trapped elsewhere */
-	if (!intel_gvt_host.mpt->set_trap_area)
-		return 0;
-
-	return intel_gvt_host.mpt->set_trap_area(vgpu->handle, start, end, map);
-}
-
 /**
  * intel_gvt_hypervisor_set_opregion - Set opregion for guest
  * @vgpu: a vGPU
-- 
2.30.2

