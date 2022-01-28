Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4569749F564
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 09:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243102AbiA1Igm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 03:36:42 -0500
Received: from mga17.intel.com ([192.55.52.151]:52654 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347381AbiA1IgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 03:36:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643358982; x=1674894982;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Z9ZeS5oFhGbrJNOTI/GRzNzkULBALELRHaczOGrNmEk=;
  b=YM7PlpC5nj50IV54bLeK4XVTXt0JkZwQD/yPmHADy6K9akYvRYCSxpeY
   XfFzjPMAcOSaPKT31493TJbxMp8jz+9jxoxqd+3LvxyBXWleaL4nzDQC9
   7K9AYE1BjvS5YPkUFNOQdGjVR/1EoYZpo6bebHGXfa7/BE7/UgaR5yi7H
   Jex36GKVS9oFzf963UmOflDcGnNQfvI2ZwktxhFMJIP6vNGXD+S/TWNWP
   u30F7Vi7NOwLyIUPjtsI78KAC8DHQCUXgl2UbVj9FzkTJJtU/QdA8ZMee
   KFiPpaYH0YT1ZBzDhf3vpIs6mqjtBkkPysUg9OVR5JaJ0zw4TGVqY432t
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10240"; a="227749375"
X-IronPort-AV: E=Sophos;i="5.88,323,1635231600"; 
   d="scan'208";a="227749375"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 00:36:17 -0800
X-IronPort-AV: E=Sophos;i="5.88,323,1635231600"; 
   d="scan'208";a="581788761"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.202])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 00:36:16 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     srinivas.kandagatla@linaro.org, gregkh@linuxfoundation.org,
        sumit.semwal@linaro.org, christian.koenig@amd.com,
        daniel.vetter@ffwll.ch, airlied@linux.ie, lyude@redhat.com,
        tzimmermann@suse.de, linux-media@vger.kernel.org,
        nouveau@lists.freedesktop.org
Subject: [PATCH 11/14] drm/radeon: Replace dma-buf-map with iosys-map
Date:   Fri, 28 Jan 2022 00:36:23 -0800
Message-Id: <20220128083626.3012259-12-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220128083626.3012259-1-lucas.demarchi@intel.com>
References: <20220128083626.3012259-1-lucas.demarchi@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

iosys-map is the new name for dma-buf-map and will gain new
capabitilities. Replace with the new API in radeon.

Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/radeon/radeon_gem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/radeon/radeon_gem.c b/drivers/gpu/drm/radeon/radeon_gem.c
index a36a4f2c76b0..f563284a7fac 100644
--- a/drivers/gpu/drm/radeon/radeon_gem.c
+++ b/drivers/gpu/drm/radeon/radeon_gem.c
@@ -26,6 +26,7 @@
  *          Jerome Glisse
  */
 
+#include <linux/iosys-map.h>
 #include <linux/pci.h>
 
 #include <drm/drm_device.h>
-- 
2.35.0

