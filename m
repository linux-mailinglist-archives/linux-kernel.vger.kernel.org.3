Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 962024AD76C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349891AbiBHLeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:34:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245371AbiBHLME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 06:12:04 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D448BC03FEC6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 03:12:02 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id e17so23903247ljk.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 03:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IYg4fF82TqldaTKh+wvFHU/Pm9VH0/HNJEVIn7SmcZA=;
        b=ULyJi7vlcuUm3UxFTk+EU+vyELQ52olCKW21A88P4t/7L7ApAdDIRLkm9yKeIpyZlB
         7bOe89rgpQkfq4+TS82wBctMnz9JuzPBLJRmqHBtg11IegldDnMXnVNN38HwZQDbpnUB
         4SD8jBmjzHVBlLm8tfg+/nGCuF7iowKI7Km+or/2MLKKGGkbnYBvVlnaXqTmWT7tSEsA
         6pO7iFxMFkre0ZrXt892X+dn0EGxqcSqrhlTJSGeKE7ZipXsPsHkCHU+RlAGUkZNZ1ts
         jMIjAwinBk1CwJYhJKSt7xfWVBH1nIJGXVumNdqYytnOGCPzqH94QeKp89lJCAxq75xI
         rw1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IYg4fF82TqldaTKh+wvFHU/Pm9VH0/HNJEVIn7SmcZA=;
        b=WggkLcG7X2OS3MCy73iGVLHIQC1sLIU2O3SuEgX/kcaAAboBd05aWib9vf9Ue5m0sZ
         wCCXE3UUo4xT9ws4s9QRLfQrKHywCA98SJzJ/7YfuaMDBYAXQosTPj/NJQVbCM2dLKKE
         oECgpzsZ6NKaoGLJTiIWLK74OMadpMi4N4JgbgMuI7dRdy5kjMoqrDFHOojPZ34khjy4
         57Y3rQXo722FvLTy4Ipo5n89NafZEdCitnfFRR8uFddCz4LIZbnvanjT4WuRsT5ULF7l
         d8thhrknnmZ9mYZmXKnzc99CM3A175t6mgg77iG9OVFhzAeKyc1O09If22gooegNEJvF
         dcYg==
X-Gm-Message-State: AOAM532buwFZzr1K0Q1+O0/SrlI6NyLg462UtLW/rRP5qoSZk07bdV4H
        kDktDF4L/wTauOIn9wgasaY=
X-Google-Smtp-Source: ABdhPJxHeItkLS/PGpyVuGpkIIYboI4f1+7XvHQNussyzApZbNzgfArHsxupAEDdhNm4vIxbWcAJpw==
X-Received: by 2002:a2e:7219:: with SMTP id n25mr2380480ljc.204.1644318721250;
        Tue, 08 Feb 2022 03:12:01 -0800 (PST)
Received: from inno-pc.lan (88-115-161-74.elisa-laajakaista.fi. [88.115.161.74])
        by smtp.gmail.com with ESMTPSA id j20sm1878093lfg.232.2022.02.08.03.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 03:12:00 -0800 (PST)
From:   Zhi Wang <zhi.wang.linux@gmail.com>
X-Google-Original-From: Zhi Wang <zhi.a.wang@intel.com>
To:     hch@lst.de, jgg@nvidia.com, jani.nikula@linux.intel.com
Cc:     intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Zhi Wang <zhi.a.wang@intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Vivi Rodrigo <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: [PATCH v6 2/3] i915/gvt: Save the initial HW state snapshot in i915
Date:   Tue,  8 Feb 2022 06:11:50 -0500
Message-Id: <20220208111151.13115-2-zhi.a.wang@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220208111151.13115-1-zhi.a.wang@intel.com>
References: <20220208111151.13115-1-zhi.a.wang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Save the initial HW state snapshot in i915 so that the rest code of GVT-g
can be moved into a dedicated module while it can still get a clean
initial HW state saved at the correct time during the initialization of
i915. The futhrer vGPU created by GVT-g will use this HW state as the
initial HW state.

v6:

- Remove the reference of intel_gvt_device_info.(Christoph)
- Refine the save_mmio() function. (Christoph)

Cc: Christoph Hellwig <hch@lst.de>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Vivi Rodrigo <rodrigo.vivi@intel.com>
Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
Cc: Zhi Wang <zhi.a.wang@intel.com>
Signed-off-by: Zhi Wang <zhi.a.wang@intel.com>
---
 drivers/gpu/drm/i915/i915_drv.h  |  2 +
 drivers/gpu/drm/i915/intel_gvt.c | 92 +++++++++++++++++++++++++++++++-
 2 files changed, 92 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_drv.h
index 44c1f98144b4..2a230840cdfa 100644
--- a/drivers/gpu/drm/i915/i915_drv.h
+++ b/drivers/gpu/drm/i915/i915_drv.h
@@ -606,6 +606,8 @@ struct i915_virtual_gpu {
 	struct mutex lock; /* serialises sending of g2v_notify command pkts */
 	bool active;
 	u32 caps;
+	u32 *initial_mmio;
+	u8 *initial_cfg_space;
 };
 
 struct i915_selftest_stash {
diff --git a/drivers/gpu/drm/i915/intel_gvt.c b/drivers/gpu/drm/i915/intel_gvt.c
index 32aa6f111d6b..c5019173ac44 100644
--- a/drivers/gpu/drm/i915/intel_gvt.c
+++ b/drivers/gpu/drm/i915/intel_gvt.c
@@ -68,6 +68,85 @@ void intel_gvt_sanitize_options(struct drm_i915_private *dev_priv)
 	dev_priv->params.enable_gvt = 0;
 }
 
+static void free_initial_hw_state(struct drm_i915_private *dev_priv)
+{
+	struct i915_virtual_gpu *vgpu = &dev_priv->vgpu;
+
+	vfree(vgpu->initial_mmio);
+	vgpu->initial_mmio = NULL;
+
+	kfree(vgpu->initial_cfg_space);
+	vgpu->initial_cfg_space = NULL;
+}
+
+static void save_mmio(struct intel_gvt_mmio_table_iter *iter, u32 offset,
+		      u32 size)
+{
+	struct drm_i915_private *dev_priv = iter->i915;
+	u32 *mmio, i;
+
+	for (i = offset; i < offset + size; i += 4) {
+		mmio = iter->data + i;
+		*mmio = intel_uncore_read_notrace(to_gt(dev_priv)->uncore,
+						  _MMIO(i));
+	}
+}
+
+static int handle_mmio(struct intel_gvt_mmio_table_iter *iter,
+		       u32 offset, u32 device, u32 size)
+{
+	if (WARN_ON(!IS_ALIGNED(offset, 4)))
+		return -EINVAL;
+
+	save_mmio(iter, offset, size);
+	return 0;
+}
+
+static int save_initial_hw_state(struct drm_i915_private *dev_priv)
+{
+	struct pci_dev *pdev = to_pci_dev(dev_priv->drm.dev);
+	struct i915_virtual_gpu *vgpu = &dev_priv->vgpu;
+	struct intel_gvt_mmio_table_iter iter;
+	void *mem;
+	int i, ret;
+
+	mem = kzalloc(PCI_CFG_SPACE_EXP_SIZE, GFP_KERNEL);
+	if (!mem)
+		return -ENOMEM;
+
+	vgpu->initial_cfg_space = mem;
+
+	for (i = 0; i < PCI_CFG_SPACE_EXP_SIZE; i += 4)
+		pci_read_config_dword(pdev, i, mem + i);
+
+	mem = vzalloc(2 * SZ_1M);
+	if (!mem) {
+		ret = -ENOMEM;
+		goto err_mmio;
+	}
+
+	vgpu->initial_mmio = mem;
+
+	iter.i915 = dev_priv;
+	iter.data = vgpu->initial_mmio;
+	iter.handle_mmio_cb = handle_mmio;
+
+	ret = intel_gvt_iterate_mmio_table(&iter);
+	if (ret)
+		goto err_iterate;
+
+	return 0;
+
+err_iterate:
+	vfree(vgpu->initial_mmio);
+	vgpu->initial_mmio = NULL;
+err_mmio:
+	kfree(vgpu->initial_cfg_space);
+	vgpu->initial_cfg_space = NULL;
+
+	return ret;
+}
+
 /**
  * intel_gvt_init - initialize GVT components
  * @dev_priv: drm i915 private data
@@ -97,15 +176,23 @@ int intel_gvt_init(struct drm_i915_private *dev_priv)
 		return -EIO;
 	}
 
+	ret = save_initial_hw_state(dev_priv);
+	if (ret) {
+		drm_dbg(&dev_priv->drm, "Fail to save initial HW state\n");
+		goto err_save_hw_state;
+	}
+
 	ret = intel_gvt_init_device(dev_priv);
 	if (ret) {
 		drm_dbg(&dev_priv->drm, "Fail to init GVT device\n");
-		goto bail;
+		goto err_init_device;
 	}
 
 	return 0;
 
-bail:
+err_init_device:
+	free_initial_hw_state(dev_priv);
+err_save_hw_state:
 	dev_priv->params.enable_gvt = 0;
 	return 0;
 }
@@ -129,6 +216,7 @@ void intel_gvt_driver_remove(struct drm_i915_private *dev_priv)
 		return;
 
 	intel_gvt_clean_device(dev_priv);
+	free_initial_hw_state(dev_priv);
 }
 
 /**
-- 
2.25.1

