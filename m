Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7D9F497704
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 02:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240765AbiAXByY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 20:54:24 -0500
Received: from mga06.intel.com ([134.134.136.31]:20501 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240737AbiAXByN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 20:54:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642989253; x=1674525253;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RJ38NFsCxCGkkXpWENl1lI1EVp6t2oKoNxmZY3ee8wg=;
  b=Jyy15f8dPYdyowpJf5mEcuDa4aem/Cvj9/Ifm9eHgtls8O4djsNiA80A
   CP2wvU5EgAedrp99DI3OnPEqZ1lN9gzNnP0PRuNBcCQoJuhR0b0+TkW+T
   wY2Hg6HWPGw18252jDSZU7DgEZTdwiVvSKwVDtlKvtpa70Gntk90y+vSc
   gszToOs/Tv7oahNeFqKZsGfu9iJDCdF81G/sd4QyvGSGE8cRYVoTXxrE7
   CBY8Re/g+XqmFF0LB/KkC0dnWIBa4bCbs+ZhSy5coA0Ef2rxMxf3+X5jY
   BipM40bBEjrknGRLB1mThr86MJUzYLW25ZgYsz99HAgY6Uwln1mgJqcIM
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="306658408"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="306658408"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 17:54:13 -0800
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="627320389"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 17:54:13 -0800
From:   ira.weiny@intel.com
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>
Cc:     Ira Weiny <ira.weiny@intel.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH V2 2/7] drm/amd: Replace kmap() with kmap_local_page()
Date:   Sun, 23 Jan 2022 17:54:04 -0800
Message-Id: <20220124015409.807587-3-ira.weiny@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220124015409.807587-1-ira.weiny@intel.com>
References: <20220124015409.807587-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

kmap() is being deprecated.  These maps are thread local and can be
replaced with kmap_local_page().

Replace kmap() with kmap_local_page()

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 5c3f24069f2a..54973824f8f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2272,9 +2272,9 @@ static ssize_t amdgpu_iomem_read(struct file *f, char __user *buf,
 		if (p->mapping != adev->mman.bdev.dev_mapping)
 			return -EPERM;
 
-		ptr = kmap(p);
+		ptr = kmap_local_page(p);
 		r = copy_to_user(buf, ptr + off, bytes);
-		kunmap(p);
+		kunmap_local(ptr);
 		if (r)
 			return -EFAULT;
 
@@ -2323,9 +2323,9 @@ static ssize_t amdgpu_iomem_write(struct file *f, const char __user *buf,
 		if (p->mapping != adev->mman.bdev.dev_mapping)
 			return -EPERM;
 
-		ptr = kmap(p);
+		ptr = kmap_local_page(p);
 		r = copy_from_user(ptr + off, buf, bytes);
-		kunmap(p);
+		kunmap_local(ptr);
 		if (r)
 			return -EFAULT;
 
-- 
2.31.1

