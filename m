Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600BC4AD762
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349998AbiBHLeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:34:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356883AbiBHLMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 06:12:05 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE2AC03FEC7
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 03:12:03 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id bx31so23983498ljb.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 03:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g3YdE7NZj+L8Dg/chDHlwxEN35uclyYb0VXoHTgKIhw=;
        b=gfII+Nwx1VjIsaSP4LQmgh3hZb6JLQuWkaGJn7wixjuQfPv3QyvbHQ/oGIZUTtOcQM
         mdTJh8oLCCPtQBPynShSzCfuDC6PL9luMyQ8FuVwhEgLbAcXk+l4HjHY7J1Pui0v8+kO
         y0dth9sdtPDmKnSx2W51YS0t+oBg4vEAAeH1f45DHfcfF5Wde3kf09c/vt7JlIfYWDgV
         QSZnJ83AFJ4qKpDjxnTrsHSZ2PmZcv75+Jw7ZWA2GfEfikQkKTCC3RaM9zW7bKkaaegU
         JW6KpDFdIr/fOXa8boE1ifHKcs6pqU+Q/uM+ybWnB5CsmCmyU2Jf0nDgxOO4Me0afYUm
         SD2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g3YdE7NZj+L8Dg/chDHlwxEN35uclyYb0VXoHTgKIhw=;
        b=8Jgvld5UMyQoEaStec7wdmHcCNo3nmlgPCCZdpOOdewIK+DKnbY+YRuLefrviwz4PU
         H4zrg/9JytWtKCeICj1lYOmTwOjwXCgyLvAE/iPlRzjrwxG5hXiuIexbz0dHF01ZE3nJ
         G1WpYJk0Baym2CsrcRZLYynujYbJZZAowhvUuV0RGBzSWiukoxwZQPvLe0oYKPljt/+n
         b1JTEubQEQLQMUsmggCMBqLFYc60pRTnfbHXvj769jpRru7FiIaiObqa+lFwNfW98l34
         WF9zkM4nY0V37qeuXGBKOtqUpdO1hbl+Rfv9nUYoYrb45Uehm6EZ1Uwcp4qXPTzrG7OX
         YRxg==
X-Gm-Message-State: AOAM532WFF/9KMGrDNprGzKF2vTVEAadcJceUeJCts5lSTWMY2Dh6v34
        So1rCFlSywZAIm+GEHFUn9I=
X-Google-Smtp-Source: ABdhPJx0d8ixDSztvu9X8ZBCPCS4PpsRoyejigGduJK3j2wDoPXeKUcXiFPmXq+pnTua4nGk9wq1Lg==
X-Received: by 2002:a2e:502:: with SMTP id 2mr2416253ljf.445.1644318722046;
        Tue, 08 Feb 2022 03:12:02 -0800 (PST)
Received: from inno-pc.lan (88-115-161-74.elisa-laajakaista.fi. [88.115.161.74])
        by smtp.gmail.com with ESMTPSA id j20sm1878093lfg.232.2022.02.08.03.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 03:12:01 -0800 (PST)
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
Subject: [PATCH v6 3/3] i915/gvt: Use the initial HW state snapshot saved in i915
Date:   Tue,  8 Feb 2022 06:11:51 -0500
Message-Id: <20220208111151.13115-3-zhi.a.wang@intel.com>
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
index 1a8274a3f4b1..54fe442238c6 100644
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
+	       info->cfg_space_size);
+	memcpy(p, gvt->firmware.cfg_space, info->cfg_space_size);
 
 	p = firmware + h->mmio_offset;
 
-	/* Take a snapshot of hw mmio registers. */
-	intel_gvt_for_each_tracked_mmio(gvt, mmio_snapshot_handler, p);
+	memcpy(gvt->firmware.mmio, i915->vgpu.initial_mmio,
+	       info->mmio_size);
 
-	memcpy(gvt->firmware.mmio, p, info->mmio_size);
+	memcpy(p, gvt->firmware.mmio, info->mmio_size);
 
 	crc32_start = offsetof(struct gvt_firmware_header, crc32) + 4;
 	h->crc32 = crc32_le(0, firmware + crc32_start, size - crc32_start);
-- 
2.25.1

