Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 517FC5A4C6C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 14:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbiH2Mvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 08:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiH2MvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 08:51:13 -0400
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9758A388
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 05:38:40 -0700 (PDT)
X-QQ-mid: bizesmtp72t1661776623taqf4by8
Received: from localhost.localdomain ( [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 29 Aug 2022 20:36:57 +0800 (CST)
X-QQ-SSF: 01400000002000C0K000B00A0000000
X-QQ-FEAT: ao4JQgu0M3/UgU+YkHy4njb4NNdIn11x9nwLEL07GbnOzmiQXUMUeaKluCk/G
        GWneyTH3RyNn9YPtOJX1r+pKTbLJAZhBaG5JtqljRhiFnkjCKIpMm+e8eEFqNW7yFXElM1C
        WB03tfyjp6jCR+lkhukBGnL03JVi/SR/FIqx8P5xwhzmJVVnrNCIvXMy++KKF7MqaR2nlKn
        2LaoSuWZ+zTN9Xhw2lf20BOUaKM1ja3TWaoOk8FN3FWXMzrdTQxjecE1+G5nqRyigBrJCxS
        n0+2Nsd6dgwKEh38a3k40Al1j4ifoGaBhTNQXEkj4SGIStP4/9TrNFrhVEqhhAkVNEqBMNB
        APZy4G1SPFqke7zO+yRC0eA0zvssfSH1dg76/RBQ08YUX+i+UGj7Y0p4PKjfA==
X-QQ-GoodBg: 2
From:   Zhen Ni <nizhen@uniontech.com>
To:     airlied@linux.ie, daniel@ffwll.ch, evan.quan@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Zhen Ni <nizhen@uniontech.com>
Subject: [PATCH] drm/amd/amdgpu: Add modeset module parameter support
Date:   Mon, 29 Aug 2022 20:36:54 +0800
Message-Id: <20220829123654.4333-1-nizhen@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvr:qybglogicsvr5
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nomodeset kernel parameter is for all graphics cards. Amdgpu cannot
be set separately in some scenarios, such as hybrid graphics(i + a).
Add modeset module parameter for amdgpu to set kernel mode separately.

Signed-off-by: Zhen Ni <nizhen@uniontech.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 429fcdf28836..856a70370e3c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -107,6 +107,7 @@
 #define KMS_DRIVER_MINOR	48
 #define KMS_DRIVER_PATCHLEVEL	0
 
+int amdgpu_modeset = -1;
 int amdgpu_vram_limit;
 int amdgpu_vis_vram_limit;
 int amdgpu_gart_size = -1; /* auto */
@@ -199,6 +200,13 @@ struct amdgpu_watchdog_timer amdgpu_watchdog_timer = {
 	.period = 0x0, /* default to 0x0 (timeout disable) */
 };
 
+/**
+ * DOC: modeset (int)
+ * Disable/Enable kernel modesetting (1 = enable, 0 = disable, -1 = auto (default)).
+ */
+MODULE_PARM_DESC(modeset, "Disable/Enable kernel modesetting");
+module_param_named(modeset, amdgpu_modeset, int, 0400);
+
 /**
  * DOC: vramlimit (int)
  * Restrict the total amount of VRAM in MiB for testing.  The default is 0 (Use full VRAM).
@@ -2753,7 +2761,10 @@ static int __init amdgpu_init(void)
 {
 	int r;
 
-	if (drm_firmware_drivers_only())
+	if (drm_firmware_drivers_only() && amdgpu_modeset == -1)
+		amdgpu_modeset = 0;
+
+	if (amdgpu_modeset == 0)
 		return -EINVAL;
 
 	r = amdgpu_sync_init();
-- 
2.20.1

