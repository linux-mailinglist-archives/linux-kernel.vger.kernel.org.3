Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96704E7C3C
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiCYT2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 15:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiCYT1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 15:27:47 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881C118C0FC
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 12:01:08 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id b19so12034901wrh.11
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 12:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g3YdE7NZj+L8Dg/chDHlwxEN35uclyYb0VXoHTgKIhw=;
        b=MMT0HILFjBkL/NOsKp9IJ2Rcg0Ta+95vRvNWBYWrlOSIdSS/HBuue+mPjlkij71azQ
         0P5eB1ylgJXrA8wISBW3MIEOQq9V8kTIOutdu1YyPl/RMmywWucplv9XzAl5Sofyu2NZ
         lcwi7kD1rUgaG48Ae5QuxCsXmr7Z/uB140i8qGVBqcVUTHKyG7HKBkKYESJoaGwgzq68
         1s6A5DrtAJAdS2gEUk1lYvC1sZJlg1dpf8QKwCvEYFMZRf+w683AQkn6WnStAT09ta9A
         fhVdJsfPydEoaCh1FmvyfMkAS6pIKS5EA6lHAzFT+DWHuqKlMgrxCEXVqreNKQzRlsNV
         1RLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g3YdE7NZj+L8Dg/chDHlwxEN35uclyYb0VXoHTgKIhw=;
        b=Apc7tM77gFjks3tkK1ZXhvn6KxW6wbaNoNRO7rJQf/J5AC1PQIoRdtQh27ak8Grc70
         wi3Enwhsn/D3WraXmAEYrZwSNzhkwk18cE2yrGis4V9ARu24cvvZo+dFz6Ic802hYns8
         8dzBiEfr1u9WhVBkiZvzYFg+0Qjun8wsjLKwoe6KzdXN55tDKhtHViopoc56Tc8vj0Td
         SCvtm+R+gJI4KBoSNaRBGmQWBxguWdTotwjbXlEqSbwZT2Zvm2/yiC/r7h77AxwuYnZp
         JnsdubONDgMW/fFa3qyQdlu5j+iNw8OzEOdM5y3V5chpf6k27JdmFiAC/TH2u10pJV3S
         qPrw==
X-Gm-Message-State: AOAM531JyiNw0CEu+XtdSZ3V/Q+gDRJW8TQq55AoRpktiec9WEjiXG5/
        HkVYATSDormQglgt8A49DBZk0DV9mHY=
X-Google-Smtp-Source: ABdhPJxqowdRvF8TpUgcla2uBNcWJcEpAgGvAQuP7q304zfdYLSVQZkvDg8CUxZ2rV0DY8768r2NlQ==
X-Received: by 2002:ac2:4c8a:0:b0:44a:3271:dc3b with SMTP id d10-20020ac24c8a000000b0044a3271dc3bmr8382480lfl.83.1648230791199;
        Fri, 25 Mar 2022 10:53:11 -0700 (PDT)
Received: from inno-pc.lan (88-115-161-74.elisa-laajakaista.fi. [88.115.161.74])
        by smtp.gmail.com with ESMTPSA id z17-20020ac24191000000b004483a4d9a3esm775738lfh.152.2022.03.25.10.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 10:53:10 -0700 (PDT)
From:   Zhi Wang <zhi.wang.linux@gmail.com>
X-Google-Original-From: Zhi Wang <zhi.a.wang@intel.com>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org
Cc:     Zhi Wang <zhi.a.wang@intel.com>, Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Vivi Rodrigo <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: [PATCH v7 3/3] i915/gvt: Use the initial HW state snapshot saved in i915
Date:   Fri, 25 Mar 2022 13:52:51 -0400
Message-Id: <20220325175251.167164-3-zhi.a.wang@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220325175251.167164-1-zhi.a.wang@intel.com>
References: <20220325175251.167164-1-zhi.a.wang@intel.com>
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

