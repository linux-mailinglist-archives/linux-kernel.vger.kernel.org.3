Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71B8B49E1F5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 13:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236315AbiA0MFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 07:05:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236300AbiA0MFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 07:05:45 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03ACDC061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 04:05:45 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id n8so4912396lfq.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 04:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8vm1E71F2uByMj2KZTvDJ3fTHLhMzGhMUgIxJrXZsp4=;
        b=A4Z0B38tFCdnTnwmo8i7Pii7TfHPDvY+ASacGfyJebTmdFyPbtTWc+TpMGoyHjYvOM
         pHt00wStZDe/K6oskhDPJycAlhmb4U6c6XSYxGVdKDe2bu1ITOmRFTpWGIB3U1iUM7mZ
         DDqGZs/pjopDoq7baQ59r268Rxy5Qz9dy0UMc6xEo/05ggqDuhxyO0vRTaUgnKwuvvS4
         8ibZEQDXpAjFxl//Elyku32Q5ngWSLtNOwCDgzBerRo50xP5owCkQ1nTBDzFgUlZgFq+
         dbRYuZ7/Up4sIV0oHItvscaO5Jm2rMhD7w7spbguMTYXY6d6JCosnWwuq2a/AsHmkutj
         bkAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8vm1E71F2uByMj2KZTvDJ3fTHLhMzGhMUgIxJrXZsp4=;
        b=LFJq1cPkrkhEyRaGqXyZLYE970qwfOEZVBg6vKJSaGlaqC2mTGMe3EfwLCjPlaHoBW
         6j/V4Ym6p6q6uM+Y1a7EFZJ2vzxA5KBnXF+AunQs0kNJOxzlLyk2r11u+SOXkxwj+aTV
         HgSVrKkkWmBjcOqCxflWobU7DPGyk2uFlyK21aZTFmlBCaiTfM6m/sV0VSzPTwjAH+us
         3HvYEDs3wEv/kKRMC5y85PMspIVQ5fxSckDLWyLn55VQd7AIkwxORkXU7GJODyn0O9KV
         bxFKBdDINzYJawJQw+B7WCwZtr3A5VSAhmxImyC2JfJ2FQ3AVCO1903eVSjAxoSd3/PO
         hEMA==
X-Gm-Message-State: AOAM530/nT+d7cW3cT+gsvU8A0/36SoLjfl1pZDH7cMVp3WNytM2eVCy
        AjCFYUmnL9+hzhCzdUWbpII=
X-Google-Smtp-Source: ABdhPJwbTzq36KRvgCw0o66FybiSoiVYrW1RKwASrCpIjf0iKTu325bNkBLndiiz42Xc62AHOU4Feg==
X-Received: by 2002:a19:700b:: with SMTP id h11mr2571510lfc.377.1643285143412;
        Thu, 27 Jan 2022 04:05:43 -0800 (PST)
Received: from inno-pc.lan (88-115-161-74.elisa-laajakaista.fi. [88.115.161.74])
        by smtp.gmail.com with ESMTPSA id b5sm1418722ljk.123.2022.01.27.04.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 04:05:43 -0800 (PST)
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
Subject: [PATCH 3/3] i915/gvt: Use the initial HW state snapshot saved in i915
Date:   Thu, 27 Jan 2022 07:05:08 -0500
Message-Id: <20220127120508.11330-3-zhi.a.wang@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220127120508.11330-1-zhi.a.wang@intel.com>
References: <20220127120508.11330-1-zhi.a.wang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code of saving initial HW state snapshot has been moved into i915.
Let the GVT-g core logic use that snapshot.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Vivi Rodrigo <rodrigo.vivi@intel.com>
Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
Cc: Zhi Wang <zhi.a.wang@intel.com>
Signed-off-by: Zhi Wang <zhi.a.wang@intel.com>
---
 drivers/gpu/drm/i915/gvt/firmware.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/firmware.c b/drivers/gpu/drm/i915/gvt/firmware.c
index 1a8274a3f4b1..1d55920bfd42 100644
--- a/drivers/gpu/drm/i915/gvt/firmware.c
+++ b/drivers/gpu/drm/i915/gvt/firmware.c
@@ -66,22 +66,16 @@ static struct bin_attribute firmware_attr = {
 	.mmap = NULL,
 };
 
-static int mmio_snapshot_handler(struct intel_gvt *gvt, u32 offset, void *data)
-{
-	*(u32 *)(data + offset) = intel_uncore_read_notrace(gvt->gt->uncore,
-							    _MMIO(offset));
-	return 0;
-}
-
 static int expose_firmware_sysfs(struct intel_gvt *gvt)
 {
 	struct intel_gvt_device_info *info = &gvt->device_info;
-	struct pci_dev *pdev = to_pci_dev(gvt->gt->i915->drm.dev);
+	struct drm_i915_private *i915 = gvt->gt->i915;
+	struct pci_dev *pdev = to_pci_dev(i915->drm.dev);
 	struct gvt_firmware_header *h;
 	void *firmware;
 	void *p;
 	unsigned long size, crc32_start;
-	int i, ret;
+	int ret;
 
 	size = sizeof(*h) + info->mmio_size + info->cfg_space_size;
 	firmware = vzalloc(size);
@@ -99,17 +93,16 @@ static int expose_firmware_sysfs(struct intel_gvt *gvt)
 
 	p = firmware + h->cfg_space_offset;
 
-	for (i = 0; i < h->cfg_space_size; i += 4)
-		pci_read_config_dword(pdev, i, p + i);
-
-	memcpy(gvt->firmware.cfg_space, p, info->cfg_space_size);
+	memcpy(gvt->firmware.cfg_space, i915->vgpu.initial_cfg_space,
+			info->cfg_space_size);
+	memcpy(p, gvt->firmware.cfg_space, info->cfg_space_size);
 
 	p = firmware + h->mmio_offset;
 
-	/* Take a snapshot of hw mmio registers. */
-	intel_gvt_for_each_tracked_mmio(gvt, mmio_snapshot_handler, p);
+	memcpy(gvt->firmware.mmio, i915->vgpu.initial_mmio,
+			info->mmio_size);
 
-	memcpy(gvt->firmware.mmio, p, info->mmio_size);
+	memcpy(p, gvt->firmware.mmio, info->mmio_size);
 
 	crc32_start = offsetof(struct gvt_firmware_header, crc32) + 4;
 	h->crc32 = crc32_le(0, firmware + crc32_start, size - crc32_start);
-- 
2.25.1

