Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1B5477A07
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 18:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239950AbhLPRKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 12:10:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235904AbhLPRKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 12:10:21 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D12C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 09:10:20 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id j140-20020a1c2392000000b003399ae48f58so2226592wmj.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 09:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/875UjIeI/WJ8vJETC0FE0YD/vlu8AvDtauH40Y2gWE=;
        b=csjFl4i8BgqLJ6vlmytOL5VCujMEkqZNZj36sscCD18vuWsyVxWvMjokPjes9slSh3
         ZyaTE3U0f/e3NkKCvueAgEv7lARIYj6+ASipSy3lkt5UndutsAMsL+dOU5TYkIRwOP0j
         yDodkrZ2UIDnL+oDG+ELW21SrhVF1ZL0cUQRL1AcF8P+o3tDHHe35CQOP4hAsTpPJbSt
         7INU0Lx/o3U/M9js0v5Oe1V9BnJfuNVItL/kUlWLf72Ip2ZIndtQOBMSXdb+lU2J5QmS
         XtExVQxpsLKj6abUuEtV+Jt7kDDiHZoVAHswLoVH4BHb+Jl4+qGzl9NDmv0KGuWOApHu
         GxOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/875UjIeI/WJ8vJETC0FE0YD/vlu8AvDtauH40Y2gWE=;
        b=llETjU+gbpdwj2gKy2J3IXni1NZmKTDW9TV3a2QTz5G7JiSrRpFlEh1r6FrluEwlk1
         /sszElf+0NqdrxLoMDTmlwCCgFk+4SgvM5FRcq+VTHq56yR9pvqRYOiVSaADVXzs7oef
         gkD2njeln1jHU3E8wptLyQDTmniN/iSm7jvzt9nKuDIR4GQkKr/xPOL8HbIIrBc9k3hi
         MU1XRIR0/x4uB7SU/KsmbimUQ5r4kF55syfPN5zHMGNHAjCV1GqDHHRgRr9AqL1SWr9D
         fZ+3rNW0T3dZ9KJyvkEEGPgzxK4C5kT5bmwY6CtH3IgZqOpw0d+RiHwTW4JsPKgXYCVE
         EiLg==
X-Gm-Message-State: AOAM5316Jn2BU1t+yuYW7PYf+OAHxquxPje3A5gkY9RRpN6ucPjXE6+1
        1Ff7fsBYXAmGoVo9DdQ8M9Fn7A==
X-Google-Smtp-Source: ABdhPJxjxNIeJB6nYaZJ8T7V31trycXob0pijctG1UTk/tVAxm08sBb0CYmIcG8LFq7+Y/4oikmC6Q==
X-Received: by 2002:a05:600c:a06:: with SMTP id z6mr5902582wmp.9.1639674619142;
        Thu, 16 Dec 2021 09:10:19 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id e12sm6808415wrq.20.2021.12.16.09.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 09:10:18 -0800 (PST)
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/cma-helper: Describe what a "contiguous chunk" actually means
Date:   Thu, 16 Dec 2021 17:10:04 +0000
Message-Id: <20211216171004.18166-1-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since it's inception in 2012 it has been understood that the DRM GEM CMA
helpers do not depend on CMA as the backend allocator. In fact the first
bug fix to ensure the cma-helpers work correctly with an IOMMU backend
appeared in 2014. However currently the documentation for
drm_gem_cma_create() talks about "a contiguous chunk of memory" without
making clear which address space it will be a contiguous part of.
Additionally the CMA introduction is actively misleading because it only
contemplates the CMA backend.

This matters because when the device accesses the bus through an IOMMU
(and don't use the CMA backend) then the allocated memory is contiguous
only in the IOVA space. This is a significant difference compared to the
CMA bankend and the behaviour can be a surprise even to someone who does
a reasonable level of code browsing (but doesn't find all the relevant
function pointers ;-) ).

Improve the kernel doc comments accordingly.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 drivers/gpu/drm/drm_gem_cma_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_cma_helper.c b/drivers/gpu/drm/drm_gem_cma_helper.c
index 8467783e92f3..81d7181deebd 100644
--- a/drivers/gpu/drm/drm_gem_cma_helper.c
+++ b/drivers/gpu/drm/drm_gem_cma_helper.c
@@ -32,10 +32,10 @@
  *
  * For devices the access the memory bus through an (external) IOMMU then
  * the buffer objects can be scattered in physical memory but linearized
- * in the IOVA space by the MMU.
+ * in the IOVA space by the IOMMU.
  *
  * For other devices we must rely on the Contiguous Memory Allocator to
- * reserve a pool of memory at early boot that is used to service requests
+ * reserve a pool of memory at early boot. This is then used to service requests
  * for large blocks of physically contiguous memory.
  */


base-commit: 2585cf9dfaaddf00b069673f27bb3f8530e2039c
prerequisite-patch-id: bfcd9122d2546ec77e0bd987663777192002bc91
--
2.34.1

