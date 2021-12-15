Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBD2B47551B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 10:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241156AbhLOJY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 04:24:26 -0500
Received: from mailgw.kylinos.cn ([123.150.8.42]:57517 "EHLO nksmu.kylinos.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236355AbhLOJYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 04:24:25 -0500
X-UUID: f7c97c1c2b8a479baf36adbbbce09b56-20211215
X-UUID: f7c97c1c2b8a479baf36adbbbce09b56-20211215
X-User: zhouzongmin@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by nksmu.kylinos.cn
        (envelope-from <zhouzongmin@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 1907932870; Wed, 15 Dec 2021 17:32:29 +0800
From:   Zongmin Zhou <zhouzongmin@kylinos.cn>
To:     airlied@linux.ie, daniel@ffwll.ch
Cc:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Zongmin Zhou <zhouzongmin@kylinos.cn>
Subject: [PATCH] drm/amdgpu: fixup bad vram size on gmc v8
Date:   Wed, 15 Dec 2021 17:23:37 +0800
Message-Id: <20211215092337.340266-1-zhouzongmin@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some boards(like RX550) seem to have garbage in the upper
16 bits of the vram size register.  Check for
this and clamp the size properly.  Fixes
boards reporting bogus amounts of vram.

after add this patch,the maximum GPU VRAM size is 64GB,
otherwise only 64GB vram size will be used.

Signed-off-by: Zongmin Zhou<zhouzongmin@kylinos.cn>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 492ebed2915b..63b890f1e8af 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -515,10 +515,10 @@ static void gmc_v8_0_mc_program(struct amdgpu_device *adev)
 static int gmc_v8_0_mc_init(struct amdgpu_device *adev)
 {
 	int r;
+	u32 tmp;
 
 	adev->gmc.vram_width = amdgpu_atombios_get_vram_width(adev);
 	if (!adev->gmc.vram_width) {
-		u32 tmp;
 		int chansize, numchan;
 
 		/* Get VRAM informations */
@@ -562,8 +562,15 @@ static int gmc_v8_0_mc_init(struct amdgpu_device *adev)
 		adev->gmc.vram_width = numchan * chansize;
 	}
 	/* size in MB on si */
-	adev->gmc.mc_vram_size = RREG32(mmCONFIG_MEMSIZE) * 1024ULL * 1024ULL;
-	adev->gmc.real_vram_size = RREG32(mmCONFIG_MEMSIZE) * 1024ULL * 1024ULL;
+	tmp = RREG32(mmCONFIG_MEMSIZE);
+	/* some boards may have garbage in the upper 16 bits */
+	if (tmp & 0xffff0000) {
+		DRM_INFO("Probable bad vram size: 0x%08x\n", tmp);
+		if (tmp & 0xffff)
+			tmp &= 0xffff;
+	}
+	adev->gmc.mc_vram_size = tmp * 1024ULL * 1024ULL;
+	adev->gmc.real_vram_size = adev->gmc.mc_vram_size;
 
 	if (!(adev->flags & AMD_IS_APU)) {
 		r = amdgpu_device_resize_fb_bar(adev);
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus
