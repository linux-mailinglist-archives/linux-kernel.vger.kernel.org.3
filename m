Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A46580DB7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 09:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238421AbiGZHb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 03:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238406AbiGZHbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 03:31:19 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48552E9C3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 00:27:38 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R981e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VKUPgkw_1658820420;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VKUPgkw_1658820420)
          by smtp.aliyun-inc.com;
          Tue, 26 Jul 2022 15:27:03 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     alexander.deucher@amd.com
Cc:     christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH 10/20] drm/amd/display: Clean up some inconsistent indenting
Date:   Tue, 26 Jul 2022 15:25:45 +0800
Message-Id: <20220726072555.91323-10-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
In-Reply-To: <20220726072555.91323-1-jiapeng.chong@linux.alibaba.com>
References: <20220726072555.91323-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional modification involved.

smatch warnings:

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_mpc.c:116 mpc3_get_ogam_current() warn: inconsistent indenting.
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_mpc.c:445 mpc3_get_shaper_current() warn: inconsistent indenting.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 .../gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c  | 70 +++++++++----------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c
index 1981a71b961b..ad1c1b703874 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c
@@ -109,32 +109,32 @@ enum dc_lut_mode mpc3_get_ogam_current(struct mpc *mpc, int mpcc_id)
 	uint32_t state_ram_lut_in_use;
 	struct dcn30_mpc *mpc30 = TO_DCN30_MPC(mpc);
 
-	REG_GET_2(MPCC_OGAM_CONTROL[mpcc_id],
-			MPCC_OGAM_MODE_CURRENT, &state_mode,
-			MPCC_OGAM_SELECT_CURRENT, &state_ram_lut_in_use);
+	REG_GET_2(MPCC_OGAM_CONTROL[mpcc_id], MPCC_OGAM_MODE_CURRENT, &state_mode,
+		  MPCC_OGAM_SELECT_CURRENT, &state_ram_lut_in_use);
 
-		switch (state_mode) {
+	switch (state_mode) {
+	case 0:
+		mode = LUT_BYPASS;
+		break;
+	case 2:
+		switch (state_ram_lut_in_use) {
 		case 0:
-			mode = LUT_BYPASS;
+			mode = LUT_RAM_A;
 			break;
-		case 2:
-			switch (state_ram_lut_in_use) {
-			case 0:
-				mode = LUT_RAM_A;
-				break;
-			case 1:
-				mode = LUT_RAM_B;
-				break;
-			default:
-				mode = LUT_BYPASS;
-				break;
-			}
+		case 1:
+			mode = LUT_RAM_B;
 			break;
 		default:
 			mode = LUT_BYPASS;
 			break;
 		}
-		return mode;
+		break;
+	default:
+		mode = LUT_BYPASS;
+		break;
+	}
+
+	return mode;
 }
 
 void mpc3_power_on_ogam_lut(
@@ -439,24 +439,24 @@ static enum dc_lut_mode mpc3_get_shaper_current(struct mpc *mpc, uint32_t rmu_id
 	uint32_t state_mode;
 	struct dcn30_mpc *mpc30 = TO_DCN30_MPC(mpc);
 
-	REG_GET(SHAPER_CONTROL[rmu_idx],
-			MPC_RMU_SHAPER_LUT_MODE_CURRENT, &state_mode);
+	REG_GET(SHAPER_CONTROL[rmu_idx], MPC_RMU_SHAPER_LUT_MODE_CURRENT, &state_mode);
 
-		switch (state_mode) {
-		case 0:
-			mode = LUT_BYPASS;
-			break;
-		case 1:
-			mode = LUT_RAM_A;
-			break;
-		case 2:
-			mode = LUT_RAM_B;
-			break;
-		default:
-			mode = LUT_BYPASS;
-			break;
-		}
-		return mode;
+	switch (state_mode) {
+	case 0:
+		mode = LUT_BYPASS;
+		break;
+	case 1:
+		mode = LUT_RAM_A;
+		break;
+	case 2:
+		mode = LUT_RAM_B;
+		break;
+	default:
+		mode = LUT_BYPASS;
+		break;
+	}
+
+	return mode;
 }
 
 static void mpc3_configure_shaper_lut(
-- 
2.20.1.7.g153144c

