Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECB94F04DF
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 18:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358075AbiDBQaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 12:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358073AbiDBQaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 12:30:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D50C2158DB2
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 09:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648916892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=pXy4fnmtooyYVf5A6KbSvbNqDAUSLjz48k7mBSbcKpo=;
        b=TCs2t/mFxN/PcPNJkTt3C/aGjPo6UdhVDqCKBn4U7UU8MuHxANaMsDo/AqwhtqkOjhH6uY
        gv1BCGtBSs3Hoznc4N3oTJgfDDVb9vIIvsZpmep2oSSg5JtB9Gb+Oevj+xXRuduHM0C9CS
        KVcz8nwf45GeK4NPZMNt2CFHmaHW83U=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-257-TihNJJ8qO3GIoFwHvIl_eQ-1; Sat, 02 Apr 2022 12:28:11 -0400
X-MC-Unique: TihNJJ8qO3GIoFwHvIl_eQ-1
Received: by mail-pf1-f198.google.com with SMTP id y26-20020aa793da000000b004fb7c6f5d10so3353813pff.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 09:28:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pXy4fnmtooyYVf5A6KbSvbNqDAUSLjz48k7mBSbcKpo=;
        b=rP9fMU+5gRMlv46KWv0/ScoGWXbmdOjmJLBtlhNaifbXOtODrll+bBxjL44jzpOjrR
         4wuTxAm5FtxxO5gugjk1wPRdR+D6U9NzmT4QqANVMF6SxvtDR4GWz5UtVkSiY5OZNIlC
         Si6xnfIZ9Y4CGabheyUrN32f8+9j6RxHNE+B9CDlcKdUC/FbuoN8Y4eSh8CvIhW66Xbc
         ZtoAGCFPoMrZATRP3TL8E7o/FDzmmRgS6yYN3VSh6wlWtN0FLHuXc3po6BGl4AA10V2v
         +w8yNDrOxbXvQKyKTbnVM2vhST+PC4qv+HDiYZRTVr36aftHjIfNbnGAPAwEgZ/7fhRy
         Hmvg==
X-Gm-Message-State: AOAM5314r+jEVo2j79Ns4DXD3zsJxTEsdMIIBjiqa8qwJm++VNDATdI5
        UO/fWHjQ4Ca6PRonYJW5ix5NxupUwo7cfGlUCD2D6o8suLLR4ztVZVmzA/L7PAlD82tOAkjXh8O
        /NMN/uCfk1eRAFlq1viSUbapY
X-Received: by 2002:a62:1cd8:0:b0:4fa:702f:821b with SMTP id c207-20020a621cd8000000b004fa702f821bmr16387406pfc.58.1648916890198;
        Sat, 02 Apr 2022 09:28:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyjBNyNq71EDK+pHaVQO+b1cv2oKr6hee+9G4lye5tc7Jsyw1NQqtHDy7Dc92Kfn9KKxp4EKg==
X-Received: by 2002:a62:1cd8:0:b0:4fa:702f:821b with SMTP id c207-20020a621cd8000000b004fa702f821bmr16387386pfc.58.1648916889779;
        Sat, 02 Apr 2022 09:28:09 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id x38-20020a056a0018a600b004fafd05ac3fsm6995121pfh.37.2022.04.02.09.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 09:28:09 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/radeon: change si_default_state table from global to static
Date:   Sat,  2 Apr 2022 12:27:50 -0400
Message-Id: <20220402162750.2805433-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch reports these issues
si_blit_shaders.c:31:11: warning: symbol 'si_default_state'
  was not declared. Should it be static?
si_blit_shaders.c:253:11: warning: symbol 'si_default_size'
  was not declared. Should it be static?

Both symbols are only used in si.c.  Single file symbols
should be static.  So move the si_default_state and
si_default_size to si.c and change their
storage-class-specifier to static.

Remove unneeded si_blit_shaders.[c|h]

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/radeon/Makefile          |   2 +-
 drivers/gpu/drm/radeon/si.c              | 224 +++++++++++++++++++-
 drivers/gpu/drm/radeon/si_blit_shaders.c | 253 -----------------------
 drivers/gpu/drm/radeon/si_blit_shaders.h |  32 ---
 4 files changed, 224 insertions(+), 287 deletions(-)
 delete mode 100644 drivers/gpu/drm/radeon/si_blit_shaders.c
 delete mode 100644 drivers/gpu/drm/radeon/si_blit_shaders.h

diff --git a/drivers/gpu/drm/radeon/Makefile b/drivers/gpu/drm/radeon/Makefile
index 11c97edde54d..664381f4eb07 100644
--- a/drivers/gpu/drm/radeon/Makefile
+++ b/drivers/gpu/drm/radeon/Makefile
@@ -44,7 +44,7 @@ radeon-y += radeon_device.o radeon_asic.o radeon_kms.o \
 	evergreen.o evergreen_cs.o evergreen_blit_shaders.o \
 	evergreen_hdmi.o radeon_trace_points.o ni.o cayman_blit_shaders.o \
 	atombios_encoders.o radeon_semaphore.o radeon_sa.o atombios_i2c.o si.o \
-	si_blit_shaders.o radeon_prime.o cik.o cik_blit_shaders.o \
+	radeon_prime.o cik.o cik_blit_shaders.o \
 	r600_dpm.o rs780_dpm.o rv6xx_dpm.o rv770_dpm.o rv730_dpm.o rv740_dpm.o \
 	rv770_smc.o cypress_dpm.o btc_dpm.o sumo_dpm.o sumo_smc.o trinity_dpm.o \
 	trinity_smc.o ni_dpm.o si_smc.o si_dpm.o kv_smc.o kv_dpm.o ci_smc.o \
diff --git a/drivers/gpu/drm/radeon/si.c b/drivers/gpu/drm/radeon/si.c
index 8d5e4b25609d..a4032702e302 100644
--- a/drivers/gpu/drm/radeon/si.c
+++ b/drivers/gpu/drm/radeon/si.c
@@ -38,7 +38,6 @@
 #include "radeon_asic.h"
 #include "radeon_audio.h"
 #include "radeon_ucode.h"
-#include "si_blit_shaders.h"
 #include "si.h"
 #include "sid.h"
 
@@ -3553,6 +3552,229 @@ static int si_cp_load_microcode(struct radeon_device *rdev)
 	return 0;
 }
 
+static const u32 si_default_state[] = {
+	0xc0066900,
+	0x00000000,
+	0x00000060, /* DB_RENDER_CONTROL */
+	0x00000000, /* DB_COUNT_CONTROL */
+	0x00000000, /* DB_DEPTH_VIEW */
+	0x0000002a, /* DB_RENDER_OVERRIDE */
+	0x00000000, /* DB_RENDER_OVERRIDE2 */
+	0x00000000, /* DB_HTILE_DATA_BASE */
+
+	0xc0046900,
+	0x00000008,
+	0x00000000, /* DB_DEPTH_BOUNDS_MIN */
+	0x00000000, /* DB_DEPTH_BOUNDS_MAX */
+	0x00000000, /* DB_STENCIL_CLEAR */
+	0x00000000, /* DB_DEPTH_CLEAR */
+
+	0xc0036900,
+	0x0000000f,
+	0x00000000, /* DB_DEPTH_INFO */
+	0x00000000, /* DB_Z_INFO */
+	0x00000000, /* DB_STENCIL_INFO */
+
+	0xc0016900,
+	0x00000080,
+	0x00000000, /* PA_SC_WINDOW_OFFSET */
+
+	0xc00d6900,
+	0x00000083,
+	0x0000ffff, /* PA_SC_CLIPRECT_RULE */
+	0x00000000, /* PA_SC_CLIPRECT_0_TL */
+	0x20002000, /* PA_SC_CLIPRECT_0_BR */
+	0x00000000,
+	0x20002000,
+	0x00000000,
+	0x20002000,
+	0x00000000,
+	0x20002000,
+	0xaaaaaaaa, /* PA_SC_EDGERULE */
+	0x00000000, /* PA_SU_HARDWARE_SCREEN_OFFSET */
+	0x0000000f, /* CB_TARGET_MASK */
+	0x0000000f, /* CB_SHADER_MASK */
+
+	0xc0226900,
+	0x00000094,
+	0x80000000, /* PA_SC_VPORT_SCISSOR_0_TL */
+	0x20002000, /* PA_SC_VPORT_SCISSOR_0_BR */
+	0x80000000,
+	0x20002000,
+	0x80000000,
+	0x20002000,
+	0x80000000,
+	0x20002000,
+	0x80000000,
+	0x20002000,
+	0x80000000,
+	0x20002000,
+	0x80000000,
+	0x20002000,
+	0x80000000,
+	0x20002000,
+	0x80000000,
+	0x20002000,
+	0x80000000,
+	0x20002000,
+	0x80000000,
+	0x20002000,
+	0x80000000,
+	0x20002000,
+	0x80000000,
+	0x20002000,
+	0x80000000,
+	0x20002000,
+	0x80000000,
+	0x20002000,
+	0x80000000,
+	0x20002000,
+	0x00000000, /* PA_SC_VPORT_ZMIN_0 */
+	0x3f800000, /* PA_SC_VPORT_ZMAX_0 */
+
+	0xc0026900,
+	0x000000d9,
+	0x00000000, /* CP_RINGID */
+	0x00000000, /* CP_VMID */
+
+	0xc0046900,
+	0x00000100,
+	0xffffffff, /* VGT_MAX_VTX_INDX */
+	0x00000000, /* VGT_MIN_VTX_INDX */
+	0x00000000, /* VGT_INDX_OFFSET */
+	0x00000000, /* VGT_MULTI_PRIM_IB_RESET_INDX */
+
+	0xc0046900,
+	0x00000105,
+	0x00000000, /* CB_BLEND_RED */
+	0x00000000, /* CB_BLEND_GREEN */
+	0x00000000, /* CB_BLEND_BLUE */
+	0x00000000, /* CB_BLEND_ALPHA */
+
+	0xc0016900,
+	0x000001e0,
+	0x00000000, /* CB_BLEND0_CONTROL */
+
+	0xc00e6900,
+	0x00000200,
+	0x00000000, /* DB_DEPTH_CONTROL */
+	0x00000000, /* DB_EQAA */
+	0x00cc0010, /* CB_COLOR_CONTROL */
+	0x00000210, /* DB_SHADER_CONTROL */
+	0x00010000, /* PA_CL_CLIP_CNTL */
+	0x00000004, /* PA_SU_SC_MODE_CNTL */
+	0x00000100, /* PA_CL_VTE_CNTL */
+	0x00000000, /* PA_CL_VS_OUT_CNTL */
+	0x00000000, /* PA_CL_NANINF_CNTL */
+	0x00000000, /* PA_SU_LINE_STIPPLE_CNTL */
+	0x00000000, /* PA_SU_LINE_STIPPLE_SCALE */
+	0x00000000, /* PA_SU_PRIM_FILTER_CNTL */
+	0x00000000, /*  */
+	0x00000000, /*  */
+
+	0xc0116900,
+	0x00000280,
+	0x00000000, /* PA_SU_POINT_SIZE */
+	0x00000000, /* PA_SU_POINT_MINMAX */
+	0x00000008, /* PA_SU_LINE_CNTL */
+	0x00000000, /* PA_SC_LINE_STIPPLE */
+	0x00000000, /* VGT_OUTPUT_PATH_CNTL */
+	0x00000000, /* VGT_HOS_CNTL */
+	0x00000000,
+	0x00000000,
+	0x00000000,
+	0x00000000,
+	0x00000000,
+	0x00000000,
+	0x00000000,
+	0x00000000,
+	0x00000000,
+	0x00000000,
+	0x00000000, /* VGT_GS_MODE */
+
+	0xc0026900,
+	0x00000292,
+	0x00000000, /* PA_SC_MODE_CNTL_0 */
+	0x00000000, /* PA_SC_MODE_CNTL_1 */
+
+	0xc0016900,
+	0x000002a1,
+	0x00000000, /* VGT_PRIMITIVEID_EN */
+
+	0xc0016900,
+	0x000002a5,
+	0x00000000, /* VGT_MULTI_PRIM_IB_RESET_EN */
+
+	0xc0026900,
+	0x000002a8,
+	0x00000000, /* VGT_INSTANCE_STEP_RATE_0 */
+	0x00000000,
+
+	0xc0026900,
+	0x000002ad,
+	0x00000000, /* VGT_REUSE_OFF */
+	0x00000000,
+
+	0xc0016900,
+	0x000002d5,
+	0x00000000, /* VGT_SHADER_STAGES_EN */
+
+	0xc0016900,
+	0x000002dc,
+	0x0000aa00, /* DB_ALPHA_TO_MASK */
+
+	0xc0066900,
+	0x000002de,
+	0x00000000, /* PA_SU_POLY_OFFSET_DB_FMT_CNTL */
+	0x00000000,
+	0x00000000,
+	0x00000000,
+	0x00000000,
+	0x00000000,
+
+	0xc0026900,
+	0x000002e5,
+	0x00000000, /* VGT_STRMOUT_CONFIG */
+	0x00000000,
+
+	0xc01b6900,
+	0x000002f5,
+	0x76543210, /* PA_SC_CENTROID_PRIORITY_0 */
+	0xfedcba98, /* PA_SC_CENTROID_PRIORITY_1 */
+	0x00000000, /* PA_SC_LINE_CNTL */
+	0x00000000, /* PA_SC_AA_CONFIG */
+	0x00000005, /* PA_SU_VTX_CNTL */
+	0x3f800000, /* PA_CL_GB_VERT_CLIP_ADJ */
+	0x3f800000, /* PA_CL_GB_VERT_DISC_ADJ */
+	0x3f800000, /* PA_CL_GB_HORZ_CLIP_ADJ */
+	0x3f800000, /* PA_CL_GB_HORZ_DISC_ADJ */
+	0x00000000, /* PA_SC_AA_SAMPLE_LOCS_PIXEL_X0Y0_0 */
+	0x00000000,
+	0x00000000,
+	0x00000000,
+	0x00000000,
+	0x00000000,
+	0x00000000,
+	0x00000000,
+	0x00000000,
+	0x00000000,
+	0x00000000,
+	0x00000000,
+	0x00000000,
+	0x00000000,
+	0x00000000,
+	0x00000000,
+	0xffffffff, /* PA_SC_AA_MASK_X0Y0_X1Y0 */
+	0xffffffff,
+
+	0xc0026900,
+	0x00000316,
+	0x0000000e, /* VGT_VERTEX_REUSE_BLOCK_CNTL */
+	0x00000010, /*  */
+};
+
+static const u32 si_default_size = ARRAY_SIZE(si_default_state);
+
 static int si_cp_start(struct radeon_device *rdev)
 {
 	struct radeon_ring *ring = &rdev->ring[RADEON_RING_TYPE_GFX_INDEX];
diff --git a/drivers/gpu/drm/radeon/si_blit_shaders.c b/drivers/gpu/drm/radeon/si_blit_shaders.c
deleted file mode 100644
index ec415e7dfa4b..000000000000
--- a/drivers/gpu/drm/radeon/si_blit_shaders.c
+++ /dev/null
@@ -1,253 +0,0 @@
-/*
- * Copyright 2011 Advanced Micro Devices, Inc.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice (including the next
- * paragraph) shall be included in all copies or substantial portions of the
- * Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * THE COPYRIGHT HOLDER(S) AND/OR ITS SUPPLIERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
- * DEALINGS IN THE SOFTWARE.
- *
- * Authors:
- *     Alex Deucher <alexander.deucher@amd.com>
- */
-
-#include <linux/types.h>
-#include <linux/bug.h>
-#include <linux/kernel.h>
-
-const u32 si_default_state[] =
-{
-	0xc0066900,
-	0x00000000,
-	0x00000060, /* DB_RENDER_CONTROL */
-	0x00000000, /* DB_COUNT_CONTROL */
-	0x00000000, /* DB_DEPTH_VIEW */
-	0x0000002a, /* DB_RENDER_OVERRIDE */
-	0x00000000, /* DB_RENDER_OVERRIDE2 */
-	0x00000000, /* DB_HTILE_DATA_BASE */
-
-	0xc0046900,
-	0x00000008,
-	0x00000000, /* DB_DEPTH_BOUNDS_MIN */
-	0x00000000, /* DB_DEPTH_BOUNDS_MAX */
-	0x00000000, /* DB_STENCIL_CLEAR */
-	0x00000000, /* DB_DEPTH_CLEAR */
-
-	0xc0036900,
-	0x0000000f,
-	0x00000000, /* DB_DEPTH_INFO */
-	0x00000000, /* DB_Z_INFO */
-	0x00000000, /* DB_STENCIL_INFO */
-
-	0xc0016900,
-	0x00000080,
-	0x00000000, /* PA_SC_WINDOW_OFFSET */
-
-	0xc00d6900,
-	0x00000083,
-	0x0000ffff, /* PA_SC_CLIPRECT_RULE */
-	0x00000000, /* PA_SC_CLIPRECT_0_TL */
-	0x20002000, /* PA_SC_CLIPRECT_0_BR */
-	0x00000000,
-	0x20002000,
-	0x00000000,
-	0x20002000,
-	0x00000000,
-	0x20002000,
-	0xaaaaaaaa, /* PA_SC_EDGERULE */
-	0x00000000, /* PA_SU_HARDWARE_SCREEN_OFFSET */
-	0x0000000f, /* CB_TARGET_MASK */
-	0x0000000f, /* CB_SHADER_MASK */
-
-	0xc0226900,
-	0x00000094,
-	0x80000000, /* PA_SC_VPORT_SCISSOR_0_TL */
-	0x20002000, /* PA_SC_VPORT_SCISSOR_0_BR */
-	0x80000000,
-	0x20002000,
-	0x80000000,
-	0x20002000,
-	0x80000000,
-	0x20002000,
-	0x80000000,
-	0x20002000,
-	0x80000000,
-	0x20002000,
-	0x80000000,
-	0x20002000,
-	0x80000000,
-	0x20002000,
-	0x80000000,
-	0x20002000,
-	0x80000000,
-	0x20002000,
-	0x80000000,
-	0x20002000,
-	0x80000000,
-	0x20002000,
-	0x80000000,
-	0x20002000,
-	0x80000000,
-	0x20002000,
-	0x80000000,
-	0x20002000,
-	0x80000000,
-	0x20002000,
-	0x00000000, /* PA_SC_VPORT_ZMIN_0 */
-	0x3f800000, /* PA_SC_VPORT_ZMAX_0 */
-
-	0xc0026900,
-	0x000000d9,
-	0x00000000, /* CP_RINGID */
-	0x00000000, /* CP_VMID */
-
-	0xc0046900,
-	0x00000100,
-	0xffffffff, /* VGT_MAX_VTX_INDX */
-	0x00000000, /* VGT_MIN_VTX_INDX */
-	0x00000000, /* VGT_INDX_OFFSET */
-	0x00000000, /* VGT_MULTI_PRIM_IB_RESET_INDX */
-
-	0xc0046900,
-	0x00000105,
-	0x00000000, /* CB_BLEND_RED */
-	0x00000000, /* CB_BLEND_GREEN */
-	0x00000000, /* CB_BLEND_BLUE */
-	0x00000000, /* CB_BLEND_ALPHA */
-
-	0xc0016900,
-	0x000001e0,
-	0x00000000, /* CB_BLEND0_CONTROL */
-
-	0xc00e6900,
-	0x00000200,
-	0x00000000, /* DB_DEPTH_CONTROL */
-	0x00000000, /* DB_EQAA */
-	0x00cc0010, /* CB_COLOR_CONTROL */
-	0x00000210, /* DB_SHADER_CONTROL */
-	0x00010000, /* PA_CL_CLIP_CNTL */
-	0x00000004, /* PA_SU_SC_MODE_CNTL */
-	0x00000100, /* PA_CL_VTE_CNTL */
-	0x00000000, /* PA_CL_VS_OUT_CNTL */
-	0x00000000, /* PA_CL_NANINF_CNTL */
-	0x00000000, /* PA_SU_LINE_STIPPLE_CNTL */
-	0x00000000, /* PA_SU_LINE_STIPPLE_SCALE */
-	0x00000000, /* PA_SU_PRIM_FILTER_CNTL */
-	0x00000000, /*  */
-	0x00000000, /*  */
-
-	0xc0116900,
-	0x00000280,
-	0x00000000, /* PA_SU_POINT_SIZE */
-	0x00000000, /* PA_SU_POINT_MINMAX */
-	0x00000008, /* PA_SU_LINE_CNTL */
-	0x00000000, /* PA_SC_LINE_STIPPLE */
-	0x00000000, /* VGT_OUTPUT_PATH_CNTL */
-	0x00000000, /* VGT_HOS_CNTL */
-	0x00000000,
-	0x00000000,
-	0x00000000,
-	0x00000000,
-	0x00000000,
-	0x00000000,
-	0x00000000,
-	0x00000000,
-	0x00000000,
-	0x00000000,
-	0x00000000, /* VGT_GS_MODE */
-
-	0xc0026900,
-	0x00000292,
-	0x00000000, /* PA_SC_MODE_CNTL_0 */
-	0x00000000, /* PA_SC_MODE_CNTL_1 */
-
-	0xc0016900,
-	0x000002a1,
-	0x00000000, /* VGT_PRIMITIVEID_EN */
-
-	0xc0016900,
-	0x000002a5,
-	0x00000000, /* VGT_MULTI_PRIM_IB_RESET_EN */
-
-	0xc0026900,
-	0x000002a8,
-	0x00000000, /* VGT_INSTANCE_STEP_RATE_0 */
-	0x00000000,
-
-	0xc0026900,
-	0x000002ad,
-	0x00000000, /* VGT_REUSE_OFF */
-	0x00000000,
-
-	0xc0016900,
-	0x000002d5,
-	0x00000000, /* VGT_SHADER_STAGES_EN */
-
-	0xc0016900,
-	0x000002dc,
-	0x0000aa00, /* DB_ALPHA_TO_MASK */
-
-	0xc0066900,
-	0x000002de,
-	0x00000000, /* PA_SU_POLY_OFFSET_DB_FMT_CNTL */
-	0x00000000,
-	0x00000000,
-	0x00000000,
-	0x00000000,
-	0x00000000,
-
-	0xc0026900,
-	0x000002e5,
-	0x00000000, /* VGT_STRMOUT_CONFIG */
-	0x00000000,
-
-	0xc01b6900,
-	0x000002f5,
-	0x76543210, /* PA_SC_CENTROID_PRIORITY_0 */
-	0xfedcba98, /* PA_SC_CENTROID_PRIORITY_1 */
-	0x00000000, /* PA_SC_LINE_CNTL */
-	0x00000000, /* PA_SC_AA_CONFIG */
-	0x00000005, /* PA_SU_VTX_CNTL */
-	0x3f800000, /* PA_CL_GB_VERT_CLIP_ADJ */
-	0x3f800000, /* PA_CL_GB_VERT_DISC_ADJ */
-	0x3f800000, /* PA_CL_GB_HORZ_CLIP_ADJ */
-	0x3f800000, /* PA_CL_GB_HORZ_DISC_ADJ */
-	0x00000000, /* PA_SC_AA_SAMPLE_LOCS_PIXEL_X0Y0_0 */
-	0x00000000,
-	0x00000000,
-	0x00000000,
-	0x00000000,
-	0x00000000,
-	0x00000000,
-	0x00000000,
-	0x00000000,
-	0x00000000,
-	0x00000000,
-	0x00000000,
-	0x00000000,
-	0x00000000,
-	0x00000000,
-	0x00000000,
-	0xffffffff, /* PA_SC_AA_MASK_X0Y0_X1Y0 */
-	0xffffffff,
-
-	0xc0026900,
-	0x00000316,
-	0x0000000e, /* VGT_VERTEX_REUSE_BLOCK_CNTL */
-	0x00000010, /*  */
-};
-
-const u32 si_default_size = ARRAY_SIZE(si_default_state);
diff --git a/drivers/gpu/drm/radeon/si_blit_shaders.h b/drivers/gpu/drm/radeon/si_blit_shaders.h
deleted file mode 100644
index c739e51e3961..000000000000
--- a/drivers/gpu/drm/radeon/si_blit_shaders.h
+++ /dev/null
@@ -1,32 +0,0 @@
-/*
- * Copyright 2011 Advanced Micro Devices, Inc.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice (including the next
- * paragraph) shall be included in all copies or substantial portions of the
- * Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * THE COPYRIGHT HOLDER(S) AND/OR ITS SUPPLIERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
- * DEALINGS IN THE SOFTWARE.
- *
- */
-
-#ifndef SI_BLIT_SHADERS_H
-#define SI_BLIT_SHADERS_H
-
-extern const u32 si_default_state[];
-
-extern const u32 si_default_size;
-
-#endif
-- 
2.27.0

