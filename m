Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3521F4FBEE2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 16:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347170AbiDKOTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 10:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347384AbiDKORt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 10:17:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5836613FAB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 07:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=YdF+b0FcxXABBH0432BDS4U/GzIT9oJAPxM5jGvQJLI=; b=yvL86zIOdJH6ZL21DdkLA8w7t0
        jCaCNmGKQLPXh0PKhuFJ7bPaVx/G/MmWr5wCG++jDq4HLuL/pGj3a4mueFyCve8IeScFbNHYbZM2+
        vLRnEIaOetPZLNX6N5s9dR25NDd7iPHPBkwGoRjjWfTCmfl6p5FI/cGLd6eqHZs3owNsX/+Qu63qt
        +u9v6kx55nvY/nttHboL52IaBq4fy2/70Y+OY0s9a8SZ7qf0xa5E3M5pBnv2Ad2Mt5AbAFW0DBQkB
        L8F24Z0sDK6e9H//4HTmhO3WWCtTdcONGad8IiJ9SHxPna70OrStPR78YH9q0MhB2XIQBhr5OpfOY
        sdfnsCTA==;
Received: from [2001:4bb8:18e:76f5:3747:ef85:d03d:53e4] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ndupB-009Ktr-PF; Mon, 11 Apr 2022 14:15:26 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 26/34] drm/i915/gvt: pass a struct intel_vgpu to the vfio read/write helpers
Date:   Mon, 11 Apr 2022 16:13:55 +0200
Message-Id: <20220411141403.86980-27-hch@lst.de>
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

Pass the structure we actually care about instead of deriving it from
the mdev_device in the lower level code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/i915/gvt/kvmgt.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt/kvmgt.c
index 11bce3a91a225..5db74b6fe5137 100644
--- a/drivers/gpu/drm/i915/gvt/kvmgt.c
+++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
@@ -1007,10 +1007,9 @@ static int intel_vgpu_aperture_rw(struct intel_vgpu *vgpu, u64 off,
 	return 0;
 }
 
-static ssize_t intel_vgpu_rw(struct mdev_device *mdev, char *buf,
+static ssize_t intel_vgpu_rw(struct intel_vgpu *vgpu, char *buf,
 			size_t count, loff_t *ppos, bool is_write)
 {
-	struct intel_vgpu *vgpu = mdev_get_drvdata(mdev);
 	unsigned int index = VFIO_PCI_OFFSET_TO_INDEX(*ppos);
 	u64 pos = *ppos & VFIO_PCI_OFFSET_MASK;
 	int ret = -EINVAL;
@@ -1056,9 +1055,8 @@ static ssize_t intel_vgpu_rw(struct mdev_device *mdev, char *buf,
 	return ret == 0 ? count : ret;
 }
 
-static bool gtt_entry(struct mdev_device *mdev, loff_t *ppos)
+static bool gtt_entry(struct intel_vgpu *vgpu, loff_t *ppos)
 {
-	struct intel_vgpu *vgpu = mdev_get_drvdata(mdev);
 	unsigned int index = VFIO_PCI_OFFSET_TO_INDEX(*ppos);
 	struct intel_gvt *gvt = vgpu->gvt;
 	int offset;
@@ -1078,6 +1076,7 @@ static bool gtt_entry(struct mdev_device *mdev, loff_t *ppos)
 static ssize_t intel_vgpu_read(struct mdev_device *mdev, char __user *buf,
 			size_t count, loff_t *ppos)
 {
+	struct intel_vgpu *vgpu = mdev_get_drvdata(mdev);
 	unsigned int done = 0;
 	int ret;
 
@@ -1086,10 +1085,10 @@ static ssize_t intel_vgpu_read(struct mdev_device *mdev, char __user *buf,
 
 		/* Only support GGTT entry 8 bytes read */
 		if (count >= 8 && !(*ppos % 8) &&
-			gtt_entry(mdev, ppos)) {
+			gtt_entry(vgpu, ppos)) {
 			u64 val;
 
-			ret = intel_vgpu_rw(mdev, (char *)&val, sizeof(val),
+			ret = intel_vgpu_rw(vgpu, (char *)&val, sizeof(val),
 					ppos, false);
 			if (ret <= 0)
 				goto read_err;
@@ -1101,7 +1100,7 @@ static ssize_t intel_vgpu_read(struct mdev_device *mdev, char __user *buf,
 		} else if (count >= 4 && !(*ppos % 4)) {
 			u32 val;
 
-			ret = intel_vgpu_rw(mdev, (char *)&val, sizeof(val),
+			ret = intel_vgpu_rw(vgpu, (char *)&val, sizeof(val),
 					ppos, false);
 			if (ret <= 0)
 				goto read_err;
@@ -1113,7 +1112,7 @@ static ssize_t intel_vgpu_read(struct mdev_device *mdev, char __user *buf,
 		} else if (count >= 2 && !(*ppos % 2)) {
 			u16 val;
 
-			ret = intel_vgpu_rw(mdev, (char *)&val, sizeof(val),
+			ret = intel_vgpu_rw(vgpu, (char *)&val, sizeof(val),
 					ppos, false);
 			if (ret <= 0)
 				goto read_err;
@@ -1125,7 +1124,7 @@ static ssize_t intel_vgpu_read(struct mdev_device *mdev, char __user *buf,
 		} else {
 			u8 val;
 
-			ret = intel_vgpu_rw(mdev, &val, sizeof(val), ppos,
+			ret = intel_vgpu_rw(vgpu, &val, sizeof(val), ppos,
 					false);
 			if (ret <= 0)
 				goto read_err;
@@ -1152,6 +1151,7 @@ static ssize_t intel_vgpu_write(struct mdev_device *mdev,
 				const char __user *buf,
 				size_t count, loff_t *ppos)
 {
+	struct intel_vgpu *vgpu = mdev_get_drvdata(mdev);
 	unsigned int done = 0;
 	int ret;
 
@@ -1160,13 +1160,13 @@ static ssize_t intel_vgpu_write(struct mdev_device *mdev,
 
 		/* Only support GGTT entry 8 bytes write */
 		if (count >= 8 && !(*ppos % 8) &&
-			gtt_entry(mdev, ppos)) {
+			gtt_entry(vgpu, ppos)) {
 			u64 val;
 
 			if (copy_from_user(&val, buf, sizeof(val)))
 				goto write_err;
 
-			ret = intel_vgpu_rw(mdev, (char *)&val, sizeof(val),
+			ret = intel_vgpu_rw(vgpu, (char *)&val, sizeof(val),
 					ppos, true);
 			if (ret <= 0)
 				goto write_err;
@@ -1178,7 +1178,7 @@ static ssize_t intel_vgpu_write(struct mdev_device *mdev,
 			if (copy_from_user(&val, buf, sizeof(val)))
 				goto write_err;
 
-			ret = intel_vgpu_rw(mdev, (char *)&val, sizeof(val),
+			ret = intel_vgpu_rw(vgpu, (char *)&val, sizeof(val),
 					ppos, true);
 			if (ret <= 0)
 				goto write_err;
@@ -1190,7 +1190,7 @@ static ssize_t intel_vgpu_write(struct mdev_device *mdev,
 			if (copy_from_user(&val, buf, sizeof(val)))
 				goto write_err;
 
-			ret = intel_vgpu_rw(mdev, (char *)&val,
+			ret = intel_vgpu_rw(vgpu, (char *)&val,
 					sizeof(val), ppos, true);
 			if (ret <= 0)
 				goto write_err;
@@ -1202,7 +1202,7 @@ static ssize_t intel_vgpu_write(struct mdev_device *mdev,
 			if (copy_from_user(&val, buf, sizeof(val)))
 				goto write_err;
 
-			ret = intel_vgpu_rw(mdev, &val, sizeof(val),
+			ret = intel_vgpu_rw(vgpu, &val, sizeof(val),
 					ppos, true);
 			if (ret <= 0)
 				goto write_err;
-- 
2.30.2

