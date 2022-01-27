Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2871F49E1F4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 13:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240607AbiA0MFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 07:05:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236367AbiA0MFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 07:05:43 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5522C061747
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 04:05:42 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id t14so3956397ljh.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 04:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PD8tG4uBUkcfc+ygEPwPwH4Q/3Yqv2G5LtNythjO6r8=;
        b=IEn0v+nEk4s7ATLA40gu/51VvwmLnZ5+EDjqDSNZjXn9oAdZkoAZEUnYo8iUzmLjfJ
         3xpxL8x02+qJviHJkBAzrd0ma8lg4omZ5x/3APDGy8KtdIcTIP7Fl+C0rgwHyh1JyoIZ
         5cgWNHNqFCfO/3dEfBysAE5MwtihTIwCcL1GjbIdAxNhXXYD+0pqtVWsU00DRH3orXYC
         5hPDgcO+SlcRY4nnmRF40FiFUB0/deMeK0kfxXPIdZ8VcgqVCAUGcdQySOGAm5/rOP3W
         uU4PX7uuXK2QsHdm5J3flUI2nZdD3IZ20vw+qFrUMa4/rtUs0hRuoc3ic4/3jbITLiAe
         ejQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PD8tG4uBUkcfc+ygEPwPwH4Q/3Yqv2G5LtNythjO6r8=;
        b=JGli6vrWQzs553OZNQeqYfCQ+ZlU1m+Dqlsv2ZpZnzT2TkrZhry/gLZDkkSxuBuGBc
         Akn4WHA7H6n7Qt3OwpChsAN70NKkoDXZZKLU6GZMnifo45fzbfes16EaaHlogJLPiqaE
         o+UCBgXp/mh6nzdYim6r9rWQ38x3xH+Tbd8yH2MoBo3EICaj6j8kzRlldSHFZCOXs+BQ
         R1Z6GFGnNOqBTlA8wfA/ZmfvlIz5+sjtPSsi2ArWlef8ClJuJ8bdQw2yu1hu731eNntG
         TatY4U4SI/fdAbDZr+iJ9UE+JuSdX9fts+SzvuFWcPehFxH1M/X/DTCyhgNBQi0yrJjc
         Fbpg==
X-Gm-Message-State: AOAM530DByf8tvy865DrlvI1fBdIzlg+Bcc0VkZhYIIxdSHq6wRqghvq
        UQzFUsnrNKXD33g7P4CaVxXOe+LxQUI=
X-Google-Smtp-Source: ABdhPJxxeI5fs45mqHhhgEeX1Spuc5wCJ1pLLSnlirJAwcgZEVPpVO2NQu3ytU+zS3CsOvhUr4lFow==
X-Received: by 2002:a2e:50c:: with SMTP id 12mr2555635ljf.461.1643285141251;
        Thu, 27 Jan 2022 04:05:41 -0800 (PST)
Received: from inno-pc.lan (88-115-161-74.elisa-laajakaista.fi. [88.115.161.74])
        by smtp.gmail.com with ESMTPSA id b5sm1418722ljk.123.2022.01.27.04.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 04:05:40 -0800 (PST)
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
Subject: [PATCH 2/3] i915/gvt: save the initial HW state snapshot in i915.
Date:   Thu, 27 Jan 2022 07:05:07 -0500
Message-Id: <20220127120508.11330-2-zhi.a.wang@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220127120508.11330-1-zhi.a.wang@intel.com>
References: <20220127120508.11330-1-zhi.a.wang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Save the inital HW state snapshot in i915 so that the rest code of GVT-g
can be moved into a dedicated module while it can still get a clean
initial HW state saved at the correct time during the initialization of
i915. The futhrer vGPU created by GVT-g will use this HW state as the
initial HW state.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Vivi Rodrigo <rodrigo.vivi@intel.com>
Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
Cc: Zhi Wang <zhi.a.wang@intel.com>
Signed-off-by: Zhi Wang <zhi.a.wang@intel.com>
---
 drivers/gpu/drm/i915/i915_drv.h  |   2 +
 drivers/gpu/drm/i915/intel_gvt.c | 110 ++++++++++++++++++++++++++++++-
 2 files changed, 110 insertions(+), 2 deletions(-)

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
index cf6e98962d82..a3d8bdb24d3f 100644
--- a/drivers/gpu/drm/i915/intel_gvt.c
+++ b/drivers/gpu/drm/i915/intel_gvt.c
@@ -86,6 +86,103 @@ void intel_gvt_sanitize_options(struct drm_i915_private *dev_priv)
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
+	void *mmio = iter->data;
+	u32 start, end, i;
+
+	start = offset;
+	end = offset + size;
+
+	for (i = start; i < end; i += 4) {
+		*(u32 *)(mmio + i) = intel_uncore_read_notrace(
+				to_gt(dev_priv)->uncore, _MMIO(offset));
+	}
+}
+
+static int do_mmio(u32 offset, u16 flags, u32 size, u32 addr_mask,
+		   u32 ro_mask, u32 device,
+		   struct intel_gvt_mmio_table_iter *iter)
+{
+	if (WARN_ON(!IS_ALIGNED(offset, 4)))
+		return -EINVAL;
+
+	save_mmio(iter, offset, size);
+	return 0;
+}
+
+static int do_mmio_block(u32 offset, u32 size, u32 device,
+			 struct intel_gvt_mmio_table_iter *iter)
+{
+	if (WARN_ON(!IS_ALIGNED(offset, 4)))
+		return -EINVAL;
+
+	save_mmio(iter, offset, size);
+	return 0;
+}
+
+static int save_inital_hw_state(struct drm_i915_private *dev_priv)
+{
+	struct pci_dev *pdev = to_pci_dev(dev_priv->drm.dev);
+	struct intel_gvt_device_info info;
+	struct i915_virtual_gpu *vgpu = &dev_priv->vgpu;
+	struct intel_gvt_mmio_table_iter iter;
+	void *mem;
+	int i, ret;
+
+	intel_gvt_init_device_info(dev_priv, &info);
+
+	mem = kzalloc(info.cfg_space_size, GFP_KERNEL);
+	if (!mem)
+		return -ENOMEM;
+
+	vgpu->initial_cfg_space = mem;
+
+	for (i = 0; i < PCI_CFG_SPACE_EXP_SIZE; i += 4)
+		pci_read_config_dword(pdev, i, mem + i);
+
+	mem = vzalloc(info.mmio_size);
+	if (!mem) {
+		ret = -ENOMEM;
+		goto err_mmio;
+	}
+
+	vgpu->initial_mmio = mem;
+
+	iter.i915 = dev_priv;
+	iter.data = vgpu->initial_mmio;
+	iter.do_mmio = do_mmio;
+	iter.do_mmio_block = do_mmio_block;
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
@@ -115,15 +212,23 @@ int intel_gvt_init(struct drm_i915_private *dev_priv)
 		return -EIO;
 	}
 
+	ret = save_inital_hw_state(dev_priv);
+	if (ret) {
+		drm_dbg(&dev_priv->drm, "Fail to save inital HW state\n");
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
@@ -147,6 +252,7 @@ void intel_gvt_driver_remove(struct drm_i915_private *dev_priv)
 		return;
 
 	intel_gvt_clean_device(dev_priv);
+	free_initial_hw_state(dev_priv);
 }
 
 /**
-- 
2.25.1

