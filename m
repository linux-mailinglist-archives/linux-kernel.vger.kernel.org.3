Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63123599AB1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 13:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348621AbiHSLHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 07:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348628AbiHSLH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 07:07:26 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BBF3FAC5C;
        Fri, 19 Aug 2022 04:07:24 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R651e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VMfyY1O_1660907223;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VMfyY1O_1660907223)
          by smtp.aliyun-inc.com;
          Fri, 19 Aug 2022 19:07:21 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     benh@kernel.crashing.org
Cc:     deller@gmx.de, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] video: fbdev: radeon: Clean up some inconsistent indenting
Date:   Fri, 19 Aug 2022 19:06:59 +0800
Message-Id: <20220819110659.110384-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional modification involved.

drivers/video/fbdev/aty/radeon_base.c:2107 radeon_identify_vram() warn: inconsistent indenting.

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=1932
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/video/fbdev/aty/radeon_base.c | 46 +++++++++++++--------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/video/fbdev/aty/radeon_base.c b/drivers/video/fbdev/aty/radeon_base.c
index 0a8199985d52..1e6ac7ef3e73 100644
--- a/drivers/video/fbdev/aty/radeon_base.c
+++ b/drivers/video/fbdev/aty/radeon_base.c
@@ -2095,34 +2095,34 @@ static void radeon_identify_vram(struct radeonfb_info *rinfo)
 	u32 tmp;
 
 	/* framebuffer size */
-        if ((rinfo->family == CHIP_FAMILY_RS100) ||
+	if ((rinfo->family == CHIP_FAMILY_RS100) ||
             (rinfo->family == CHIP_FAMILY_RS200) ||
             (rinfo->family == CHIP_FAMILY_RS300) ||
             (rinfo->family == CHIP_FAMILY_RC410) ||
             (rinfo->family == CHIP_FAMILY_RS400) ||
 	    (rinfo->family == CHIP_FAMILY_RS480) ) {
-          u32 tom = INREG(NB_TOM);
-          tmp = ((((tom >> 16) - (tom & 0xffff) + 1) << 6) * 1024);
-
- 		radeon_fifo_wait(6);
-          OUTREG(MC_FB_LOCATION, tom);
-          OUTREG(DISPLAY_BASE_ADDR, (tom & 0xffff) << 16);
-          OUTREG(CRTC2_DISPLAY_BASE_ADDR, (tom & 0xffff) << 16);
-          OUTREG(OV0_BASE_ADDR, (tom & 0xffff) << 16);
-
-          /* This is supposed to fix the crtc2 noise problem. */
-          OUTREG(GRPH2_BUFFER_CNTL, INREG(GRPH2_BUFFER_CNTL) & ~0x7f0000);
-
-          if ((rinfo->family == CHIP_FAMILY_RS100) ||
-              (rinfo->family == CHIP_FAMILY_RS200)) {
-             /* This is to workaround the asic bug for RMX, some versions
-                of BIOS doesn't have this register initialized correctly.
-             */
-             OUTREGP(CRTC_MORE_CNTL, CRTC_H_CUTOFF_ACTIVE_EN,
-                     ~CRTC_H_CUTOFF_ACTIVE_EN);
-          }
-        } else {
-          tmp = INREG(CNFG_MEMSIZE);
+		u32 tom = INREG(NB_TOM);
+
+		tmp = ((((tom >> 16) - (tom & 0xffff) + 1) << 6) * 1024);
+		radeon_fifo_wait(6);
+		OUTREG(MC_FB_LOCATION, tom);
+		OUTREG(DISPLAY_BASE_ADDR, (tom & 0xffff) << 16);
+		OUTREG(CRTC2_DISPLAY_BASE_ADDR, (tom & 0xffff) << 16);
+		OUTREG(OV0_BASE_ADDR, (tom & 0xffff) << 16);
+
+		/* This is supposed to fix the crtc2 noise problem. */
+		OUTREG(GRPH2_BUFFER_CNTL, INREG(GRPH2_BUFFER_CNTL) & ~0x7f0000);
+
+		if ((rinfo->family == CHIP_FAMILY_RS100) ||
+		    (rinfo->family == CHIP_FAMILY_RS200)) {
+			/* This is to workaround the asic bug for RMX, some versions
+			 * of BIOS doesn't have this register initialized correctly.
+			 */
+			OUTREGP(CRTC_MORE_CNTL, CRTC_H_CUTOFF_ACTIVE_EN,
+				~CRTC_H_CUTOFF_ACTIVE_EN);
+		}
+	} else {
+		tmp = INREG(CNFG_MEMSIZE);
         }
 
 	/* mem size is bits [28:0], mask off the rest */
-- 
2.20.1.7.g153144c

