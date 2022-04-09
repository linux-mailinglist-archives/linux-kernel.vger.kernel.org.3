Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3F74FA9C6
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 19:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242800AbiDIRN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 13:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbiDIRN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 13:13:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 304B622294
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 10:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649524308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=5bsKkC5x9otwYWHiVTHS7Nov4wTBET6XicNPwItE6hQ=;
        b=Zr67rbt/9u1d7LI6kHJu5Hunmf9GPNV5cLtYjCUyuywY8Uj2Onrchp+915ezqu0dbPqZmx
        reAtM9b/SzRnc0D53sqBd0IHTNDptEZc6gcaAMnlVKBWaflEAWYut0Ix4DWWanoAhy1tXH
        LMXNXYBcCz1PNfLz2BKH62N2asP1qSw=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-424-TrXcFJqnOZOTam3fSija3g-1; Sat, 09 Apr 2022 13:11:45 -0400
X-MC-Unique: TrXcFJqnOZOTam3fSija3g-1
Received: by mail-qk1-f197.google.com with SMTP id h8-20020a05620a244800b00699fb28d5e4so5065676qkn.22
        for <linux-kernel@vger.kernel.org>; Sat, 09 Apr 2022 10:11:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5bsKkC5x9otwYWHiVTHS7Nov4wTBET6XicNPwItE6hQ=;
        b=5m14tgRdYahQI1QUuqIL3mklWKRMERRW4KmlsgHAcw6EWuPs5SR1ZuiSUlcyemzEMV
         RoChjjug1VpVlaAEeVxnJ9LovRLaVflo5C/BBxzbiyew/fpMPRhxfsy4W/wTQbYhkwnx
         XwOVmaDL7JnfuhT51ZstvXXWYIJb1eeG7TFE3rD7Bvy0jsq5mIrcfD/Z2RZ3/0JS/YZH
         CyLickKFr8lMYsJ5OXvPadbDchuGmwxi1HlEEqt5EH8pP3J+UE6PiQTPb9Fpo365Nin2
         bBXK1qx8cpDuAIfbsdBd0gFfs2i6zeh7yOZ7oxq19ll5nDj5Qp0ruSpHKQCpCigpYgoE
         9gAg==
X-Gm-Message-State: AOAM532ei2ebQQjLrLQfXZRQGO/L+szckKpsADij2ow/CBBey7c5WVmD
        Wr9tVve+BKzHAtbtuekPDuO8AvRWtYCfsijfe3jzUOVCO9ltawP/B4OMf/bkXJmEj4a3YsOO5j4
        tw2qDvXYBtNh2O0WkuuWy0uUn
X-Received: by 2002:a05:6214:e64:b0:441:7bd1:29ba with SMTP id jz4-20020a0562140e6400b004417bd129bamr20934392qvb.29.1649524304327;
        Sat, 09 Apr 2022 10:11:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy2qy2V+CDW6JQxpiguOgesFoRSbkHzNxY+hub+gVlctOJMheIjlOwGVGcI9OvkrFKHpZuUBA==
X-Received: by 2002:a05:6214:e64:b0:441:7bd1:29ba with SMTP id jz4-20020a0562140e6400b004417bd129bamr20934375qvb.29.1649524304017;
        Sat, 09 Apr 2022 10:11:44 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id g21-20020ac85815000000b002e06e2623a7sm19927734qtg.0.2022.04.09.10.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Apr 2022 10:11:43 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/radeon: remove r600_blit_shaders.[c|h]
Date:   Sat,  9 Apr 2022 13:11:31 -0400
Message-Id: <20220409171131.1599090-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only use of the global variables in r600_blit_shaders.c
were in the old drivers/gpu/drm/radeon/r600_blit.c
This file was removed in
commit 8333f607a631 ("drm/radeon: remove UMS support")

So remove the r600_blit_shaders.[c|h] files

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/radeon/Makefile            |   2 +-
 drivers/gpu/drm/radeon/r600_blit_shaders.c | 719 ---------------------
 drivers/gpu/drm/radeon/r600_blit_shaders.h |  38 --
 3 files changed, 1 insertion(+), 758 deletions(-)
 delete mode 100644 drivers/gpu/drm/radeon/r600_blit_shaders.c
 delete mode 100644 drivers/gpu/drm/radeon/r600_blit_shaders.h

diff --git a/drivers/gpu/drm/radeon/Makefile b/drivers/gpu/drm/radeon/Makefile
index 2425a3612d6c..4deedaacd655 100644
--- a/drivers/gpu/drm/radeon/Makefile
+++ b/drivers/gpu/drm/radeon/Makefile
@@ -39,7 +39,7 @@ radeon-y += radeon_device.o radeon_asic.o radeon_kms.o \
 	radeon_clocks.o radeon_fb.o radeon_gem.o radeon_ring.o radeon_irq_kms.o \
 	radeon_cs.o radeon_bios.o radeon_benchmark.o r100.o r300.o r420.o \
 	rs400.o rs600.o rs690.o rv515.o r520.o r600.o rv770.o radeon_test.o \
-	r200.o radeon_legacy_tv.o r600_cs.o r600_blit_shaders.o \
+	r200.o radeon_legacy_tv.o r600_cs.o \
 	radeon_pm.o atombios_dp.o r600_hdmi.o dce3_1_afmt.o \
 	evergreen.o evergreen_cs.o evergreen_blit_shaders.o \
 	evergreen_hdmi.o radeon_trace_points.o ni.o \
diff --git a/drivers/gpu/drm/radeon/r600_blit_shaders.c b/drivers/gpu/drm/radeon/r600_blit_shaders.c
deleted file mode 100644
index 443cbe59b274..000000000000
--- a/drivers/gpu/drm/radeon/r600_blit_shaders.c
+++ /dev/null
@@ -1,719 +0,0 @@
-/*
- * Copyright 2009 Advanced Micro Devices, Inc.
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
-#include <linux/bug.h>
-#include <linux/types.h>
-#include <linux/kernel.h>
-
-/*
- * R6xx+ cards need to use the 3D engine to blit data which requires
- * quite a bit of hw state setup.  Rather than pull the whole 3D driver
- * (which normally generates the 3D state) into the DRM, we opt to use
- * statically generated state tables.  The register state and shaders
- * were hand generated to support blitting functionality.  See the 3D
- * driver or documentation for descriptions of the registers and
- * shader instructions.
- */
-
-const u32 r6xx_default_state[] =
-{
-	0xc0002400, /* START_3D_CMDBUF */
-	0x00000000,
-
-	0xc0012800, /* CONTEXT_CONTROL */
-	0x80000000,
-	0x80000000,
-
-	0xc0016800,
-	0x00000010,
-	0x00008000, /* WAIT_UNTIL */
-
-	0xc0016800,
-	0x00000542,
-	0x07000003, /* TA_CNTL_AUX */
-
-	0xc0016800,
-	0x000005c5,
-	0x00000000, /* VC_ENHANCE */
-
-	0xc0016800,
-	0x00000363,
-	0x00000000, /* SQ_DYN_GPR_CNTL_PS_FLUSH_REQ */
-
-	0xc0016800,
-	0x0000060c,
-	0x82000000, /* DB_DEBUG */
-
-	0xc0016800,
-	0x0000060e,
-	0x01020204, /* DB_WATERMARKS */
-
-	0xc0026f00,
-	0x00000000,
-	0x00000000, /* SQ_VTX_BASE_VTX_LOC */
-	0x00000000, /* SQ_VTX_START_INST_LOC */
-
-	0xc0096900,
-	0x0000022a,
-	0x00000000, /* SQ_ESGS_RING_ITEMSIZE */
-	0x00000000,
-	0x00000000,
-	0x00000000,
-	0x00000000,
-	0x00000000,
-	0x00000000,
-	0x00000000,
-	0x00000000,
-
-	0xc0016900,
-	0x00000004,
-	0x00000000, /* DB_DEPTH_INFO */
-
-	0xc0026900,
-	0x0000000a,
-	0x00000000, /* DB_STENCIL_CLEAR */
-	0x00000000, /* DB_DEPTH_CLEAR */
-
-	0xc0016900,
-	0x00000200,
-	0x00000000, /* DB_DEPTH_CONTROL */
-
-	0xc0026900,
-	0x00000343,
-	0x00000060, /* DB_RENDER_CONTROL */
-	0x00000040, /* DB_RENDER_OVERRIDE */
-
-	0xc0016900,
-	0x00000351,
-	0x0000aa00, /* DB_ALPHA_TO_MASK */
-
-	0xc00f6900,
-	0x00000100,
-	0x00000800, /* VGT_MAX_VTX_INDX */
-	0x00000000, /* VGT_MIN_VTX_INDX */
-	0x00000000, /* VGT_INDX_OFFSET */
-	0x00000000, /* VGT_MULTI_PRIM_IB_RESET_INDX */
-	0x00000000, /* SX_ALPHA_TEST_CONTROL */
-	0x00000000, /* CB_BLEND_RED */
-	0x00000000,
-	0x00000000,
-	0x00000000,
-	0x00000000, /* CB_FOG_RED */
-	0x00000000,
-	0x00000000,
-	0x00000000, /* DB_STENCILREFMASK */
-	0x00000000, /* DB_STENCILREFMASK_BF */
-	0x00000000, /* SX_ALPHA_REF */
-
-	0xc0046900,
-	0x0000030c,
-	0x01000000, /* CB_CLRCMP_CNTL */
-	0x00000000,
-	0x00000000,
-	0x00000000,
-
-	0xc0046900,
-	0x00000048,
-	0x3f800000, /* CB_CLEAR_RED */
-	0x00000000,
-	0x3f800000,
-	0x3f800000,
-
-	0xc0016900,
-	0x00000080,
-	0x00000000, /* PA_SC_WINDOW_OFFSET */
-
-	0xc00a6900,
-	0x00000083,
-	0x0000ffff, /* PA_SC_CLIP_RECT_RULE */
-	0x00000000, /* PA_SC_CLIPRECT_0_TL */
-	0x20002000,
-	0x00000000,
-	0x20002000,
-	0x00000000,
-	0x20002000,
-	0x00000000,
-	0x20002000,
-	0x00000000, /* PA_SC_EDGERULE */
-
-	0xc0406900,
-	0x00000094,
-	0x80000000, /* PA_SC_VPORT_SCISSOR_0_TL */
-	0x20002000, /* PA_SC_VPORT_SCISSOR_0_BR */
-	0x80000000, /* PA_SC_VPORT_SCISSOR_1_TL */
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
-	0x3f800000,
-	0x00000000,
-	0x3f800000,
-	0x00000000,
-	0x3f800000,
-	0x00000000,
-	0x3f800000,
-	0x00000000,
-	0x3f800000,
-	0x00000000,
-	0x3f800000,
-	0x00000000,
-	0x3f800000,
-	0x00000000,
-	0x3f800000,
-	0x00000000,
-	0x3f800000,
-	0x00000000,
-	0x3f800000,
-	0x00000000,
-	0x3f800000,
-	0x00000000,
-	0x3f800000,
-	0x00000000,
-	0x3f800000,
-	0x00000000,
-	0x3f800000,
-	0x00000000,
-	0x3f800000,
-	0x00000000,
-	0x3f800000,
-
-	0xc0026900,
-	0x00000292,
-	0x00000000, /* PA_SC_MPASS_PS_CNTL */
-	0x00004010, /* PA_SC_MODE_CNTL */
-
-	0xc0096900,
-	0x00000300,
-	0x00000000, /* PA_SC_LINE_CNTL */
-	0x00000000, /* PA_SC_AA_CONFIG */
-	0x0000002d, /* PA_SU_VTX_CNTL */
-	0x3f800000, /* PA_CL_GB_VERT_CLIP_ADJ */
-	0x3f800000,
-	0x3f800000,
-	0x3f800000,
-	0x00000000, /* PA_SC_SAMPLE_LOCS_MCTX */
-	0x00000000,
-
-	0xc0016900,
-	0x00000312,
-	0xffffffff, /* PA_SC_AA_MASK */
-
-	0xc0066900,
-	0x0000037e,
-	0x00000000, /* PA_SU_POLY_OFFSET_DB_FMT_CNTL */
-	0x00000000, /* PA_SU_POLY_OFFSET_CLAMP */
-	0x00000000, /* PA_SU_POLY_OFFSET_FRONT_SCALE */
-	0x00000000, /* PA_SU_POLY_OFFSET_FRONT_OFFSET */
-	0x00000000, /* PA_SU_POLY_OFFSET_BACK_SCALE */
-	0x00000000, /* PA_SU_POLY_OFFSET_BACK_OFFSET */
-
-	0xc0046900,
-	0x000001b6,
-	0x00000000, /* SPI_INPUT_Z */
-	0x00000000, /* SPI_FOG_CNTL */
-	0x00000000, /* SPI_FOG_FUNC_SCALE */
-	0x00000000, /* SPI_FOG_FUNC_BIAS */
-
-	0xc0016900,
-	0x00000225,
-	0x00000000, /* SQ_PGM_START_FS */
-
-	0xc0016900,
-	0x00000229,
-	0x00000000, /* SQ_PGM_RESOURCES_FS */
-
-	0xc0016900,
-	0x00000237,
-	0x00000000, /* SQ_PGM_CF_OFFSET_FS */
-
-	0xc0026900,
-	0x000002a8,
-	0x00000000, /* VGT_INSTANCE_STEP_RATE_0 */
-	0x00000000, /* VGT_INSTANCE_STEP_RATE_1 */
-
-	0xc0116900,
-	0x00000280,
-	0x00000000, /* PA_SU_POINT_SIZE */
-	0x00000000, /* PA_SU_POINT_MINMAX */
-	0x00000008, /* PA_SU_LINE_CNTL */
-	0x00000000, /* PA_SC_LINE_STIPPLE */
-	0x00000000, /* VGT_OUTPUT_PATH_CNTL */
-	0x00000000, /* VGT_HOS_CNTL */
-	0x00000000, /* VGT_HOS_MAX_TESS_LEVEL */
-	0x00000000, /* VGT_HOS_MIN_TESS_LEVEL */
-	0x00000000, /* VGT_HOS_REUSE_DEPTH */
-	0x00000000, /* VGT_GROUP_PRIM_TYPE */
-	0x00000000, /* VGT_GROUP_FIRST_DECR */
-	0x00000000, /* VGT_GROUP_DECR */
-	0x00000000, /* VGT_GROUP_VECT_0_CNTL */
-	0x00000000, /* VGT_GROUP_VECT_1_CNTL */
-	0x00000000, /* VGT_GROUP_VECT_0_FMT_CNTL */
-	0x00000000, /* VGT_GROUP_VECT_1_FMT_CNTL */
-	0x00000000, /* VGT_GS_MODE */
-
-	0xc0016900,
-	0x000002a1,
-	0x00000000, /* VGT_PRIMITIVEID_EN */
-
-	0xc0016900,
-	0x000002a5,
-	0x00000000, /* VGT_MULTI_PRIM_ID_RESET_EN */
-
-	0xc0036900,
-	0x000002ac,
-	0x00000000, /* VGT_STRMOUT_EN */
-	0x00000000, /* VGT_REUSE_OFF */
-	0x00000000, /* VGT_VTX_CNT_EN */
-
-	0xc0016900,
-	0x000000d4,
-	0x00000000, /* SX_MISC */
-
-	0xc0016900,
-	0x000002c8,
-	0x00000000, /* VGT_STRMOUT_BUFFER_EN */
-
-	0xc0076900,
-	0x00000202,
-	0x00cc0000, /* CB_COLOR_CONTROL */
-	0x00000210, /* DB_SHADER_CNTL */
-	0x00010000, /* PA_CL_CLIP_CNTL */
-	0x00000244, /* PA_SU_SC_MODE_CNTL */
-	0x00000100, /* PA_CL_VTE_CNTL */
-	0x00000000, /* PA_CL_VS_OUT_CNTL */
-	0x00000000, /* PA_CL_NANINF_CNTL */
-
-	0xc0026900,
-	0x0000008e,
-	0x0000000f, /* CB_TARGET_MASK */
-	0x0000000f, /* CB_SHADER_MASK */
-
-	0xc0016900,
-	0x000001e8,
-	0x00000001, /* CB_SHADER_CONTROL */
-
-	0xc0016900,
-	0x00000185,
-	0x00000000, /* SPI_VS_OUT_ID_0 */
-
-	0xc0016900,
-	0x00000191,
-	0x00000b00, /* SPI_PS_INPUT_CNTL_0 */
-
-	0xc0056900,
-	0x000001b1,
-	0x00000000, /* SPI_VS_OUT_CONFIG */
-	0x00000000, /* SPI_THREAD_GROUPING */
-	0x00000001, /* SPI_PS_IN_CONTROL_0 */
-	0x00000000, /* SPI_PS_IN_CONTROL_1 */
-	0x00000000, /* SPI_INTERP_CONTROL_0 */
-
-	0xc0036e00, /* SET_SAMPLER */
-	0x00000000,
-	0x00000012,
-	0x00000000,
-	0x00000000,
-};
-
-const u32 r7xx_default_state[] =
-{
-	0xc0012800, /* CONTEXT_CONTROL */
-	0x80000000,
-	0x80000000,
-
-	0xc0016800,
-	0x00000010,
-	0x00008000, /* WAIT_UNTIL */
-
-	0xc0016800,
-	0x00000542,
-	0x07000002, /* TA_CNTL_AUX */
-
-	0xc0016800,
-	0x000005c5,
-	0x00000000, /* VC_ENHANCE */
-
-	0xc0016800,
-	0x00000363,
-	0x00004000, /* SQ_DYN_GPR_CNTL_PS_FLUSH_REQ */
-
-	0xc0016800,
-	0x0000060c,
-	0x00000000, /* DB_DEBUG */
-
-	0xc0016800,
-	0x0000060e,
-	0x00420204, /* DB_WATERMARKS */
-
-	0xc0026f00,
-	0x00000000,
-	0x00000000, /* SQ_VTX_BASE_VTX_LOC */
-	0x00000000, /* SQ_VTX_START_INST_LOC */
-
-	0xc0096900,
-	0x0000022a,
-	0x00000000, /* SQ_ESGS_RING_ITEMSIZE */
-	0x00000000,
-	0x00000000,
-	0x00000000,
-	0x00000000,
-	0x00000000,
-	0x00000000,
-	0x00000000,
-	0x00000000,
-
-	0xc0016900,
-	0x00000004,
-	0x00000000, /* DB_DEPTH_INFO */
-
-	0xc0026900,
-	0x0000000a,
-	0x00000000, /* DB_STENCIL_CLEAR */
-	0x00000000, /* DB_DEPTH_CLEAR */
-
-	0xc0016900,
-	0x00000200,
-	0x00000000, /* DB_DEPTH_CONTROL */
-
-	0xc0026900,
-	0x00000343,
-	0x00000060, /* DB_RENDER_CONTROL */
-	0x00000000, /* DB_RENDER_OVERRIDE */
-
-	0xc0016900,
-	0x00000351,
-	0x0000aa00, /* DB_ALPHA_TO_MASK */
-
-	0xc0096900,
-	0x00000100,
-	0x00000800, /* VGT_MAX_VTX_INDX */
-	0x00000000, /* VGT_MIN_VTX_INDX */
-	0x00000000, /* VGT_INDX_OFFSET */
-	0x00000000, /* VGT_MULTI_PRIM_IB_RESET_INDX */
-	0x00000000, /* SX_ALPHA_TEST_CONTROL */
-	0x00000000, /* CB_BLEND_RED */
-	0x00000000,
-	0x00000000,
-	0x00000000,
-
-	0xc0036900,
-	0x0000010c,
-	0x00000000, /* DB_STENCILREFMASK */
-	0x00000000, /* DB_STENCILREFMASK_BF */
-	0x00000000, /* SX_ALPHA_REF */
-
-	0xc0046900,
-	0x0000030c, /* CB_CLRCMP_CNTL */
-	0x01000000,
-	0x00000000,
-	0x00000000,
-	0x00000000,
-
-	0xc0016900,
-	0x00000080,
-	0x00000000, /* PA_SC_WINDOW_OFFSET */
-
-	0xc00a6900,
-	0x00000083,
-	0x0000ffff, /* PA_SC_CLIP_RECT_RULE */
-	0x00000000, /* PA_SC_CLIPRECT_0_TL */
-	0x20002000,
-	0x00000000,
-	0x20002000,
-	0x00000000,
-	0x20002000,
-	0x00000000,
-	0x20002000,
-	0xaaaaaaaa, /* PA_SC_EDGERULE */
-
-	0xc0406900,
-	0x00000094,
-	0x80000000, /* PA_SC_VPORT_SCISSOR_0_TL */
-	0x20002000, /* PA_SC_VPORT_SCISSOR_0_BR */
-	0x80000000, /* PA_SC_VPORT_SCISSOR_1_TL */
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
-	0x3f800000,
-	0x00000000,
-	0x3f800000,
-	0x00000000,
-	0x3f800000,
-	0x00000000,
-	0x3f800000,
-	0x00000000,
-	0x3f800000,
-	0x00000000,
-	0x3f800000,
-	0x00000000,
-	0x3f800000,
-	0x00000000,
-	0x3f800000,
-	0x00000000,
-	0x3f800000,
-	0x00000000,
-	0x3f800000,
-	0x00000000,
-	0x3f800000,
-	0x00000000,
-	0x3f800000,
-	0x00000000,
-	0x3f800000,
-	0x00000000,
-	0x3f800000,
-	0x00000000,
-	0x3f800000,
-	0x00000000,
-	0x3f800000,
-
-	0xc0026900,
-	0x00000292,
-	0x00000000, /* PA_SC_MPASS_PS_CNTL */
-	0x00514000, /* PA_SC_MODE_CNTL */
-
-	0xc0096900,
-	0x00000300,
-	0x00000000, /* PA_SC_LINE_CNTL */
-	0x00000000, /* PA_SC_AA_CONFIG */
-	0x0000002d, /* PA_SU_VTX_CNTL */
-	0x3f800000, /* PA_CL_GB_VERT_CLIP_ADJ */
-	0x3f800000,
-	0x3f800000,
-	0x3f800000,
-	0x00000000, /* PA_SC_SAMPLE_LOCS_MCTX */
-	0x00000000,
-
-	0xc0016900,
-	0x00000312,
-	0xffffffff, /* PA_SC_AA_MASK */
-
-	0xc0066900,
-	0x0000037e,
-	0x00000000, /* PA_SU_POLY_OFFSET_DB_FMT_CNTL */
-	0x00000000, /* PA_SU_POLY_OFFSET_CLAMP */
-	0x00000000, /* PA_SU_POLY_OFFSET_FRONT_SCALE */
-	0x00000000, /* PA_SU_POLY_OFFSET_FRONT_OFFSET */
-	0x00000000, /* PA_SU_POLY_OFFSET_BACK_SCALE */
-	0x00000000, /* PA_SU_POLY_OFFSET_BACK_OFFSET */
-
-	0xc0046900,
-	0x000001b6,
-	0x00000000, /* SPI_INPUT_Z */
-	0x00000000, /* SPI_FOG_CNTL */
-	0x00000000, /* SPI_FOG_FUNC_SCALE */
-	0x00000000, /* SPI_FOG_FUNC_BIAS */
-
-	0xc0016900,
-	0x00000225,
-	0x00000000, /* SQ_PGM_START_FS */
-
-	0xc0016900,
-	0x00000229,
-	0x00000000, /* SQ_PGM_RESOURCES_FS */
-
-	0xc0016900,
-	0x00000237,
-	0x00000000, /* SQ_PGM_CF_OFFSET_FS */
-
-	0xc0026900,
-	0x000002a8,
-	0x00000000, /* VGT_INSTANCE_STEP_RATE_0 */
-	0x00000000, /* VGT_INSTANCE_STEP_RATE_1 */
-
-	0xc0116900,
-	0x00000280,
-	0x00000000, /* PA_SU_POINT_SIZE */
-	0x00000000, /* PA_SU_POINT_MINMAX */
-	0x00000008, /* PA_SU_LINE_CNTL */
-	0x00000000, /* PA_SC_LINE_STIPPLE */
-	0x00000000, /* VGT_OUTPUT_PATH_CNTL */
-	0x00000000, /* VGT_HOS_CNTL */
-	0x00000000, /* VGT_HOS_MAX_TESS_LEVEL */
-	0x00000000, /* VGT_HOS_MIN_TESS_LEVEL */
-	0x00000000, /* VGT_HOS_REUSE_DEPTH */
-	0x00000000, /* VGT_GROUP_PRIM_TYPE */
-	0x00000000, /* VGT_GROUP_FIRST_DECR */
-	0x00000000, /* VGT_GROUP_DECR */
-	0x00000000, /* VGT_GROUP_VECT_0_CNTL */
-	0x00000000, /* VGT_GROUP_VECT_1_CNTL */
-	0x00000000, /* VGT_GROUP_VECT_0_FMT_CNTL */
-	0x00000000, /* VGT_GROUP_VECT_1_FMT_CNTL */
-	0x00000000, /* VGT_GS_MODE */
-
-	0xc0016900,
-	0x000002a1,
-	0x00000000, /* VGT_PRIMITIVEID_EN */
-
-	0xc0016900,
-	0x000002a5,
-	0x00000000, /* VGT_MULTI_PRIM_ID_RESET_EN */
-
-	0xc0036900,
-	0x000002ac,
-	0x00000000, /* VGT_STRMOUT_EN */
-	0x00000000, /* VGT_REUSE_OFF */
-	0x00000000, /* VGT_VTX_CNT_EN */
-
-	0xc0016900,
-	0x000000d4,
-	0x00000000, /* SX_MISC */
-
-	0xc0016900,
-	0x000002c8,
-	0x00000000, /* VGT_STRMOUT_BUFFER_EN */
-
-	0xc0076900,
-	0x00000202,
-	0x00cc0000, /* CB_COLOR_CONTROL */
-	0x00000210, /* DB_SHADER_CNTL */
-	0x00010000, /* PA_CL_CLIP_CNTL */
-	0x00000244, /* PA_SU_SC_MODE_CNTL */
-	0x00000100, /* PA_CL_VTE_CNTL */
-	0x00000000, /* PA_CL_VS_OUT_CNTL */
-	0x00000000, /* PA_CL_NANINF_CNTL */
-
-	0xc0026900,
-	0x0000008e,
-	0x0000000f, /* CB_TARGET_MASK */
-	0x0000000f, /* CB_SHADER_MASK */
-
-	0xc0016900,
-	0x000001e8,
-	0x00000001, /* CB_SHADER_CONTROL */
-
-	0xc0016900,
-	0x00000185,
-	0x00000000, /* SPI_VS_OUT_ID_0 */
-
-	0xc0016900,
-	0x00000191,
-	0x00000b00, /* SPI_PS_INPUT_CNTL_0 */
-
-	0xc0056900,
-	0x000001b1,
-	0x00000000, /* SPI_VS_OUT_CONFIG */
-	0x00000001, /* SPI_THREAD_GROUPING */
-	0x00000001, /* SPI_PS_IN_CONTROL_0 */
-	0x00000000, /* SPI_PS_IN_CONTROL_1 */
-	0x00000000, /* SPI_INTERP_CONTROL_0 */
-
-	0xc0036e00, /* SET_SAMPLER */
-	0x00000000,
-	0x00000012,
-	0x00000000,
-	0x00000000,
-};
-
-/* same for r6xx/r7xx */
-const u32 r6xx_vs[] =
-{
-	0x00000004,
-	0x81000000,
-	0x0000203c,
-	0x94000b08,
-	0x00004000,
-	0x14200b1a,
-	0x00000000,
-	0x00000000,
-	0x3c000000,
-	0x68cd1000,
-#ifdef __BIG_ENDIAN
-	0x000a0000,
-#else
-	0x00080000,
-#endif
-	0x00000000,
-};
-
-const u32 r6xx_ps[] =
-{
-	0x00000002,
-	0x80800000,
-	0x00000000,
-	0x94200688,
-	0x00000010,
-	0x000d1000,
-	0xb0800000,
-	0x00000000,
-};
-
-const u32 r6xx_ps_size = ARRAY_SIZE(r6xx_ps);
-const u32 r6xx_vs_size = ARRAY_SIZE(r6xx_vs);
-const u32 r6xx_default_size = ARRAY_SIZE(r6xx_default_state);
-const u32 r7xx_default_size = ARRAY_SIZE(r7xx_default_state);
diff --git a/drivers/gpu/drm/radeon/r600_blit_shaders.h b/drivers/gpu/drm/radeon/r600_blit_shaders.h
deleted file mode 100644
index f437d36dd98c..000000000000
--- a/drivers/gpu/drm/radeon/r600_blit_shaders.h
+++ /dev/null
@@ -1,38 +0,0 @@
-/*
- * Copyright 2009 Advanced Micro Devices, Inc.
- * Copyright 2009 Red Hat Inc.
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
-#ifndef R600_BLIT_SHADERS_H
-#define R600_BLIT_SHADERS_H
-
-extern const u32 r6xx_ps[];
-extern const u32 r6xx_vs[];
-extern const u32 r7xx_default_state[];
-extern const u32 r6xx_default_state[];
-
-
-extern const u32 r6xx_ps_size, r6xx_vs_size;
-extern const u32 r6xx_default_size, r7xx_default_size;
-
-#endif
-- 
2.27.0

