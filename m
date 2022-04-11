Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2684FBEC7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 16:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347006AbiDKOQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 10:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347010AbiDKOQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 10:16:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F170DF43
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 07:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=8OYx4seoHq/uZrBVwrvX6yW2Bbn/uSdMOig6gae5ag8=; b=L7lngRvpRKfshJTi8RSourK9Ts
        CAX/tp6vp0H2p5j5SdCJ2zNRBwj51w0hpG6UdPDIBo+LzjZM9ObNwXPYk2QLmBqcYk7JTA6RpwcJI
        ALfFo1hc3NhTn7q3UOYFvG0GkuKvBvT5Dbk3vac7CK9lJD84ANy+aWya0dk2oogMj1vz78QaQLlf7
        kZ53VR7942Q0C5e3uRw86bwOBoKgSzuh1jcDQI7YaGRlAWPQx7htDpVANtAwZ41icHu+7vnfelnlL
        4jDQFF04iCmk+tqbi9rQgL8hBQbXNBXB1PWmNNxi/c4Ti4GcQ25N0RdqNjaFopOw3yFPph+dL8bzm
        87Mfl3Vw==;
Received: from [2001:4bb8:18e:76f5:3747:ef85:d03d:53e4] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nduo2-009KIb-Ga; Mon, 11 Apr 2022 14:14:14 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/34] drm/i915/gvt: remove enum hypervisor_type
Date:   Mon, 11 Apr 2022 16:13:31 +0200
Message-Id: <20220411141403.86980-3-hch@lst.de>
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

The only supported hypervisor is KVM, so don't bother with dead code
enumerating hypervisors.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/i915/gvt/gvt.c       |  17 +--
 drivers/gpu/drm/i915/gvt/gvt.h       |   1 -
 drivers/gpu/drm/i915/gvt/hypercall.h |   6 --
 drivers/gpu/drm/i915/gvt/kvmgt.c     |   1 -
 drivers/gpu/drm/i915/gvt/opregion.c  | 150 ++++++---------------------
 5 files changed, 34 insertions(+), 141 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/gvt.c b/drivers/gpu/drm/i915/gvt/gvt.c
index 623424766c359..b4b13e4a94e34 100644
--- a/drivers/gpu/drm/i915/gvt/gvt.c
+++ b/drivers/gpu/drm/i915/gvt/gvt.c
@@ -41,11 +41,6 @@
 
 struct intel_gvt_host intel_gvt_host;
 
-static const char * const supported_hypervisors[] = {
-	[INTEL_GVT_HYPERVISOR_XEN] = "XEN",
-	[INTEL_GVT_HYPERVISOR_KVM] = "KVM",
-};
-
 static const struct intel_gvt_ops intel_gvt_ops = {
 	.emulate_cfg_read = intel_vgpu_emulate_cfg_read,
 	.emulate_cfg_write = intel_vgpu_emulate_cfg_write,
@@ -304,23 +299,13 @@ intel_gvt_register_hypervisor(const struct intel_gvt_mpt *m)
 	if (!intel_gvt_host.initialized)
 		return -ENODEV;
 
-	if (m->type != INTEL_GVT_HYPERVISOR_KVM &&
-	    m->type != INTEL_GVT_HYPERVISOR_XEN)
-		return -EINVAL;
-
 	intel_gvt_host.mpt = m;
-	intel_gvt_host.hypervisor_type = m->type;
 	gvt = (void *)kdev_to_i915(intel_gvt_host.dev)->gvt;
 
 	ret = intel_gvt_hypervisor_host_init(intel_gvt_host.dev, gvt,
 					     &intel_gvt_ops);
-	if (ret < 0) {
-		gvt_err("Failed to init %s hypervisor module\n",
-			supported_hypervisors[intel_gvt_host.hypervisor_type]);
+	if (ret < 0)
 		return -ENODEV;
-	}
-	gvt_dbg_core("Running with hypervisor %s in host mode\n",
-		     supported_hypervisors[intel_gvt_host.hypervisor_type]);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(intel_gvt_register_hypervisor);
diff --git a/drivers/gpu/drm/i915/gvt/gvt.h b/drivers/gpu/drm/i915/gvt/gvt.h
index bfe07c69cfd26..554baf26cab35 100644
--- a/drivers/gpu/drm/i915/gvt/gvt.h
+++ b/drivers/gpu/drm/i915/gvt/gvt.h
@@ -60,7 +60,6 @@
 struct intel_gvt_host {
 	struct device *dev;
 	bool initialized;
-	int hypervisor_type;
 	const struct intel_gvt_mpt *mpt;
 };
 
diff --git a/drivers/gpu/drm/i915/gvt/hypercall.h b/drivers/gpu/drm/i915/gvt/hypercall.h
index f33e3cbd0439d..3179831536458 100644
--- a/drivers/gpu/drm/i915/gvt/hypercall.h
+++ b/drivers/gpu/drm/i915/gvt/hypercall.h
@@ -37,17 +37,11 @@
 
 struct device;
 
-enum hypervisor_type {
-	INTEL_GVT_HYPERVISOR_XEN = 0,
-	INTEL_GVT_HYPERVISOR_KVM,
-};
-
 /*
  * Specific GVT-g MPT modules function collections. Currently GVT-g supports
  * both Xen and KVM by providing dedicated hypervisor-related MPT modules.
  */
 struct intel_gvt_mpt {
-	enum hypervisor_type type;
 	int (*host_init)(struct device *dev, void *gvt, const void *ops);
 	void (*host_exit)(struct device *dev, void *gvt);
 	int (*attach_vgpu)(void *vgpu, unsigned long *handle);
diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt/kvmgt.c
index 057ec44901045..5231ce8084b36 100644
--- a/drivers/gpu/drm/i915/gvt/kvmgt.c
+++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
@@ -2221,7 +2221,6 @@ static bool kvmgt_is_valid_gfn(unsigned long handle, unsigned long gfn)
 }
 
 static const struct intel_gvt_mpt kvmgt_mpt = {
-	.type = INTEL_GVT_HYPERVISOR_KVM,
 	.host_init = kvmgt_host_init,
 	.host_exit = kvmgt_host_exit,
 	.attach_vgpu = kvmgt_attach_vgpu,
diff --git a/drivers/gpu/drm/i915/gvt/opregion.c b/drivers/gpu/drm/i915/gvt/opregion.c
index 33569b910ed5b..286ac6d7c6ced 100644
--- a/drivers/gpu/drm/i915/gvt/opregion.c
+++ b/drivers/gpu/drm/i915/gvt/opregion.c
@@ -255,33 +255,6 @@ int intel_vgpu_init_opregion(struct intel_vgpu *vgpu)
 	return 0;
 }
 
-static int map_vgpu_opregion(struct intel_vgpu *vgpu, bool map)
-{
-	u64 mfn;
-	int i, ret;
-
-	for (i = 0; i < INTEL_GVT_OPREGION_PAGES; i++) {
-		mfn = intel_gvt_hypervisor_virt_to_mfn(vgpu_opregion(vgpu)->va
-			+ i * PAGE_SIZE);
-		if (mfn == INTEL_GVT_INVALID_ADDR) {
-			gvt_vgpu_err("fail to get MFN from VA\n");
-			return -EINVAL;
-		}
-		ret = intel_gvt_hypervisor_map_gfn_to_mfn(vgpu,
-				vgpu_opregion(vgpu)->gfn[i],
-				mfn, 1, map);
-		if (ret) {
-			gvt_vgpu_err("fail to map GFN to MFN, errno: %d\n",
-				ret);
-			return ret;
-		}
-	}
-
-	vgpu_opregion(vgpu)->mapped = map;
-
-	return 0;
-}
-
 /**
  * intel_vgpu_opregion_base_write_handler - Opregion base register write handler
  *
@@ -294,34 +267,13 @@ static int map_vgpu_opregion(struct intel_vgpu *vgpu, bool map)
 int intel_vgpu_opregion_base_write_handler(struct intel_vgpu *vgpu, u32 gpa)
 {
 
-	int i, ret = 0;
+	int i;
 
 	gvt_dbg_core("emulate opregion from kernel\n");
 
-	switch (intel_gvt_host.hypervisor_type) {
-	case INTEL_GVT_HYPERVISOR_KVM:
-		for (i = 0; i < INTEL_GVT_OPREGION_PAGES; i++)
-			vgpu_opregion(vgpu)->gfn[i] = (gpa >> PAGE_SHIFT) + i;
-		break;
-	case INTEL_GVT_HYPERVISOR_XEN:
-		/**
-		 * Wins guest on Xengt will write this register twice: xen
-		 * hvmloader and windows graphic driver.
-		 */
-		if (vgpu_opregion(vgpu)->mapped)
-			map_vgpu_opregion(vgpu, false);
-
-		for (i = 0; i < INTEL_GVT_OPREGION_PAGES; i++)
-			vgpu_opregion(vgpu)->gfn[i] = (gpa >> PAGE_SHIFT) + i;
-
-		ret = map_vgpu_opregion(vgpu, true);
-		break;
-	default:
-		ret = -EINVAL;
-		gvt_vgpu_err("not supported hypervisor\n");
-	}
-
-	return ret;
+	for (i = 0; i < INTEL_GVT_OPREGION_PAGES; i++)
+		vgpu_opregion(vgpu)->gfn[i] = (gpa >> PAGE_SHIFT) + i;
+	return 0;
 }
 
 /**
@@ -336,12 +288,7 @@ void intel_vgpu_clean_opregion(struct intel_vgpu *vgpu)
 	if (!vgpu_opregion(vgpu)->va)
 		return;
 
-	if (intel_gvt_host.hypervisor_type == INTEL_GVT_HYPERVISOR_XEN) {
-		if (vgpu_opregion(vgpu)->mapped)
-			map_vgpu_opregion(vgpu, false);
-	} else if (intel_gvt_host.hypervisor_type == INTEL_GVT_HYPERVISOR_KVM) {
-		/* Guest opregion is released by VFIO */
-	}
+	/* Guest opregion is released by VFIO */
 	free_pages((unsigned long)vgpu_opregion(vgpu)->va,
 		   get_order(INTEL_GVT_OPREGION_SIZE));
 
@@ -470,39 +417,22 @@ int intel_vgpu_emulate_opregion_request(struct intel_vgpu *vgpu, u32 swsci)
 	u64 scic_pa = 0, parm_pa = 0;
 	int ret;
 
-	switch (intel_gvt_host.hypervisor_type) {
-	case INTEL_GVT_HYPERVISOR_XEN:
-		scic = *((u32 *)vgpu_opregion(vgpu)->va +
-					INTEL_GVT_OPREGION_SCIC);
-		parm = *((u32 *)vgpu_opregion(vgpu)->va +
-					INTEL_GVT_OPREGION_PARM);
-		break;
-	case INTEL_GVT_HYPERVISOR_KVM:
-		scic_pa = (vgpu_opregion(vgpu)->gfn[0] << PAGE_SHIFT) +
-					INTEL_GVT_OPREGION_SCIC;
-		parm_pa = (vgpu_opregion(vgpu)->gfn[0] << PAGE_SHIFT) +
-					INTEL_GVT_OPREGION_PARM;
-
-		ret = intel_gvt_hypervisor_read_gpa(vgpu, scic_pa,
-						    &scic, sizeof(scic));
-		if (ret) {
-			gvt_vgpu_err("guest opregion read error %d, gpa 0x%llx, len %lu\n",
-				ret, scic_pa, sizeof(scic));
-			return ret;
-		}
-
-		ret = intel_gvt_hypervisor_read_gpa(vgpu, parm_pa,
-						    &parm, sizeof(parm));
-		if (ret) {
-			gvt_vgpu_err("guest opregion read error %d, gpa 0x%llx, len %lu\n",
-				ret, scic_pa, sizeof(scic));
-			return ret;
-		}
+	scic_pa = (vgpu_opregion(vgpu)->gfn[0] << PAGE_SHIFT) +
+				INTEL_GVT_OPREGION_SCIC;
+	parm_pa = (vgpu_opregion(vgpu)->gfn[0] << PAGE_SHIFT) +
+				INTEL_GVT_OPREGION_PARM;
+	ret = intel_gvt_hypervisor_read_gpa(vgpu, scic_pa, &scic, sizeof(scic));
+	if (ret) {
+		gvt_vgpu_err("guest opregion read error %d, gpa 0x%llx, len %lu\n",
+			ret, scic_pa, sizeof(scic));
+		return ret;
+	}
 
-		break;
-	default:
-		gvt_vgpu_err("not supported hypervisor\n");
-		return -EINVAL;
+	ret = intel_gvt_hypervisor_read_gpa(vgpu, parm_pa, &parm, sizeof(parm));
+	if (ret) {
+		gvt_vgpu_err("guest opregion read error %d, gpa 0x%llx, len %lu\n",
+			ret, scic_pa, sizeof(scic));
+		return ret;
 	}
 
 	if (!(swsci & SWSCI_SCI_SELECT)) {
@@ -535,34 +465,20 @@ int intel_vgpu_emulate_opregion_request(struct intel_vgpu *vgpu, u32 swsci)
 	parm = 0;
 
 out:
-	switch (intel_gvt_host.hypervisor_type) {
-	case INTEL_GVT_HYPERVISOR_XEN:
-		*((u32 *)vgpu_opregion(vgpu)->va +
-					INTEL_GVT_OPREGION_SCIC) = scic;
-		*((u32 *)vgpu_opregion(vgpu)->va +
-					INTEL_GVT_OPREGION_PARM) = parm;
-		break;
-	case INTEL_GVT_HYPERVISOR_KVM:
-		ret = intel_gvt_hypervisor_write_gpa(vgpu, scic_pa,
-						    &scic, sizeof(scic));
-		if (ret) {
-			gvt_vgpu_err("guest opregion write error %d, gpa 0x%llx, len %lu\n",
-				ret, scic_pa, sizeof(scic));
-			return ret;
-		}
-
-		ret = intel_gvt_hypervisor_write_gpa(vgpu, parm_pa,
-						    &parm, sizeof(parm));
-		if (ret) {
-			gvt_vgpu_err("guest opregion write error %d, gpa 0x%llx, len %lu\n",
-				ret, scic_pa, sizeof(scic));
-			return ret;
-		}
+	ret = intel_gvt_hypervisor_write_gpa(vgpu, scic_pa, &scic,
+					     sizeof(scic));
+	if (ret) {
+		gvt_vgpu_err("guest opregion write error %d, gpa 0x%llx, len %lu\n",
+			ret, scic_pa, sizeof(scic));
+		return ret;
+	}
 
-		break;
-	default:
-		gvt_vgpu_err("not supported hypervisor\n");
-		return -EINVAL;
+	ret = intel_gvt_hypervisor_write_gpa(vgpu, parm_pa, &parm,
+					     sizeof(parm));
+	if (ret) {
+		gvt_vgpu_err("guest opregion write error %d, gpa 0x%llx, len %lu\n",
+			ret, scic_pa, sizeof(scic));
+		return ret;
 	}
 
 	return 0;
-- 
2.30.2

