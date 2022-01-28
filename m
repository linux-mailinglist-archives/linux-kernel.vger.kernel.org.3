Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED4849F562
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 09:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347457AbiA1Igh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 03:36:37 -0500
Received: from mga17.intel.com ([192.55.52.151]:52651 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347423AbiA1IgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 03:36:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643358981; x=1674894981;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iO+haOX/HriPY5mGFnFrVkJP9AcE1VrjEmXI0QRiNEQ=;
  b=H/GSIaJKM1Fmx0Krhy5joPXlgrqfVhzRW0MzPPvK3s7F9W9eudYYDey6
   CcjrRnfQTX+EWDBm5tK6hOPhBdN0Zwj2pr5BEh5ZjLS4VZvHE2RROuS9F
   E3yNQp8uv1Eu3fb4IiZxTsty78eHc+fyBp2bN20pC8VUARjfwq0lGhuMd
   OyzCNLzDKtduOPjIO7woBHkyzNnngcHKCwHXP59NDKa3o705g3a5F81m7
   G8GNOy5vbvp39iGKkf6NBonS7+SAioZ1/scLeBrwzY2fsKWW8eCHv4CVM
   h4jXrAvOci0dZrvty2wUZV02nC/4o9+X2CC6TINgodARe+BQlcvxQ+KJc
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10240"; a="227749370"
X-IronPort-AV: E=Sophos;i="5.88,323,1635231600"; 
   d="scan'208";a="227749370"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 00:36:16 -0800
X-IronPort-AV: E=Sophos;i="5.88,323,1635231600"; 
   d="scan'208";a="581788754"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.202])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 00:36:16 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     srinivas.kandagatla@linaro.org, gregkh@linuxfoundation.org,
        sumit.semwal@linaro.org, christian.koenig@amd.com,
        daniel.vetter@ffwll.ch, airlied@linux.ie, lyude@redhat.com,
        tzimmermann@suse.de, linux-media@vger.kernel.org,
        nouveau@lists.freedesktop.org
Subject: [PATCH 09/14] drm/nouveau: Replace dma-buf-map with iosys-map
Date:   Fri, 28 Jan 2022 00:36:21 -0800
Message-Id: <20220128083626.3012259-10-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220128083626.3012259-1-lucas.demarchi@intel.com>
References: <20220128083626.3012259-1-lucas.demarchi@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

iosys-map is the new name for dma-buf-map and will gain new
capabitilities. Replace with the new API in nouveau.

Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/nouveau/nouveau_gem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_gem.c b/drivers/gpu/drm/nouveau/nouveau_gem.c
index 9416bee92141..ad0527bdaadf 100644
--- a/drivers/gpu/drm/nouveau/nouveau_gem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_gem.c
@@ -24,6 +24,8 @@
  *
  */
 
+#include <linux/iosys-map.h>
+
 #include <drm/drm_gem_ttm_helper.h>
 
 #include "nouveau_drv.h"
-- 
2.35.0

