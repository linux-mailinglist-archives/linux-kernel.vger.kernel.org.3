Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25A15037DE
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 20:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232766AbiDPSud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 14:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232746AbiDPSu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 14:50:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 030621D33A
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 11:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650134875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=eDG0LbiekBUt1CwA8qllwbLEqsP+ta9IQOnbKNS09Qs=;
        b=bHJEkW5ZUrva2RJHHNYH2udQUuRijAxPhTbhK0S7YvbBJ7u4pt1bTDK5w1009weyjwrq7D
        fpnjGmoY3eiCqFhCiXwHfnoxm9m69uwDJwgvvkOpRISaPzIMb710lQuKmkT60NIUmvnGev
        psuarI31Ma2EAKVbFbAlshnr4n/6rjU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-557-YDDnSu-7Mbq4xdX4bzpVRw-1; Sat, 16 Apr 2022 14:47:53 -0400
X-MC-Unique: YDDnSu-7Mbq4xdX4bzpVRw-1
Received: by mail-qt1-f197.google.com with SMTP id o17-20020ac872d1000000b002edcca4ce06so6877269qtp.7
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 11:47:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eDG0LbiekBUt1CwA8qllwbLEqsP+ta9IQOnbKNS09Qs=;
        b=cZHXtw9Q6q+LwW1wBWZk4YsQulnqffGeW137JHCKQCdy7S+Aa5HJi8O/3CCehDh9iw
         FGxpcGcKHJDOY5DZk0CEBdV+UUReogh3tTus6I0j2Ob7d04/71Vz3mw+q8qePJNXZ98J
         XWboeBUMdLEf47biBHw+9dxYIJVoIfyhyjuqt9rfW0elsLuWXuEUMz9W6DfsnQJhxryX
         wA6ZmsdK9I32XqNNV1tRr/O+nBwXncu02I1p2fuiTWp/WS4tdRnJX1VASk5MPrffC9Ck
         Z9GpQj4o8MKGKKdsvBRt2SWzgrbde0FDaCT0bkYLmB7TuK2VM2pYsfWa4yJzjV6wtQfG
         hlBA==
X-Gm-Message-State: AOAM531c1p4s1IhyO4+9HeWutiKV5P3USc1/MZk3+CkbmMWoI1VepcPO
        om2xuLNi5XmTpGI0UzWZ/QamZQrAOfJouud7RhcKHSoE9iWAF8oxUFUio0IRekdZcTRR3lpN8nn
        zGHFghFwd0bmiFrrjEWaU7FHe
X-Received: by 2002:a37:b484:0:b0:69b:db47:69a8 with SMTP id d126-20020a37b484000000b0069bdb4769a8mr2712851qkf.460.1650134872510;
        Sat, 16 Apr 2022 11:47:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx6MpGAtoVZVPZBV4qU5UoHsxOacJe1twA5aTSkMqhKACIkIF321aDa1BHooK2hcBCKSl4NYA==
X-Received: by 2002:a37:b484:0:b0:69b:db47:69a8 with SMTP id d126-20020a37b484000000b0069bdb4769a8mr2712835qkf.460.1650134872211;
        Sat, 16 Apr 2022 11:47:52 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id n9-20020a05622a11c900b002f14c97b3f7sm4827785qtk.47.2022.04.16.11.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Apr 2022 11:47:51 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/radeon/kms: change evergreen_default_state table from global to static
Date:   Sat, 16 Apr 2022 14:47:36 -0400
Message-Id: <20220416184736.2560013-1-trix@redhat.com>
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

evergreen_default_state and evergreen_default_size are only
used in evergreen.c.  Single file symbols should be static.
So move their definitions to evergreen_blit_shaders.h
and change their storage-class-specifier to static.

Remove unneeded evergreen_blit_shader.c

evergreen_ps/vs definitions were removed with
commit 4f8629675800 ("drm/radeon/kms: remove r6xx+ blit copy routines")
So their declarations in evergreen_blit_shader.h
are not needed, so remove them.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/radeon/Makefile               |   2 +-
 .../gpu/drm/radeon/evergreen_blit_shaders.c   | 303 ------------------
 .../gpu/drm/radeon/evergreen_blit_shaders.h   | 278 +++++++++++++++-
 3 files changed, 274 insertions(+), 309 deletions(-)
 delete mode 100644 drivers/gpu/drm/radeon/evergreen_blit_shaders.c

diff --git a/drivers/gpu/drm/radeon/Makefile b/drivers/gpu/drm/radeon/Makefile
index 4deedaacd655..1045d2c46a76 100644
--- a/drivers/gpu/drm/radeon/Makefile
+++ b/drivers/gpu/drm/radeon/Makefile
@@ -41,7 +41,7 @@ radeon-y += radeon_device.o radeon_asic.o radeon_kms.o \
 	rs400.o rs600.o rs690.o rv515.o r520.o r600.o rv770.o radeon_test.o \
 	r200.o radeon_legacy_tv.o r600_cs.o \
 	radeon_pm.o atombios_dp.o r600_hdmi.o dce3_1_afmt.o \
-	evergreen.o evergreen_cs.o evergreen_blit_shaders.o \
+	evergreen.o evergreen_cs.o \
 	evergreen_hdmi.o radeon_trace_points.o ni.o \
 	atombios_encoders.o radeon_semaphore.o radeon_sa.o atombios_i2c.o si.o \
 	radeon_prime.o cik.o cik_blit_shaders.o \
diff --git a/drivers/gpu/drm/radeon/evergreen_blit_shaders.c b/drivers/gpu/drm/radeon/evergreen_blit_shaders.c
deleted file mode 100644
index 1a96ddb3e5ed..000000000000
--- a/drivers/gpu/drm/radeon/evergreen_blit_shaders.c
+++ /dev/null
@@ -1,303 +0,0 @@
-/*
- * Copyright 2010 Advanced Micro Devices, Inc.
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
- * evergreen cards need to use the 3D engine to blit data which requires
- * quite a bit of hw state setup.  Rather than pull the whole 3D driver
- * (which normally generates the 3D state) into the DRM, we opt to use
- * statically generated state tables.  The register state and shaders
- * were hand generated to support blitting functionality.  See the 3D
- * driver or documentation for descriptions of the registers and
- * shader instructions.
- */
-
-const u32 evergreen_default_state[] =
-{
-	0xc0016900,
-	0x0000023b,
-	0x00000000, /* SQ_LDS_ALLOC_PS */
-
-	0xc0066900,
-	0x00000240,
-	0x00000000, /* SQ_ESGS_RING_ITEMSIZE */
-	0x00000000,
-	0x00000000,
-	0x00000000,
-	0x00000000,
-	0x00000000,
-
-	0xc0046900,
-	0x00000247,
-	0x00000000, /* SQ_GS_VERT_ITEMSIZE */
-	0x00000000,
-	0x00000000,
-	0x00000000,
-
-	0xc0026900,
-	0x00000010,
-	0x00000000, /* DB_Z_INFO */
-	0x00000000, /* DB_STENCIL_INFO */
-
-	0xc0016900,
-	0x00000200,
-	0x00000000, /* DB_DEPTH_CONTROL */
-
-	0xc0066900,
-	0x00000000,
-	0x00000060, /* DB_RENDER_CONTROL */
-	0x00000000, /* DB_COUNT_CONTROL */
-	0x00000000, /* DB_DEPTH_VIEW */
-	0x0000002a, /* DB_RENDER_OVERRIDE */
-	0x00000000, /* DB_RENDER_OVERRIDE2 */
-	0x00000000, /* DB_HTILE_DATA_BASE */
-
-	0xc0026900,
-	0x0000000a,
-	0x00000000, /* DB_STENCIL_CLEAR */
-	0x00000000, /* DB_DEPTH_CLEAR */
-
-	0xc0016900,
-	0x000002dc,
-	0x0000aa00, /* DB_ALPHA_TO_MASK */
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
-	0xc0016900,
-	0x000000d4,
-	0x00000000, /* SX_MISC */
-
-	0xc0026900,
-	0x00000292,
-	0x00000000, /* PA_SC_MODE_CNTL_0 */
-	0x00000000, /* PA_SC_MODE_CNTL_1 */
-
-	0xc0106900,
-	0x00000300,
-	0x00000000, /* PA_SC_LINE_CNTL */
-	0x00000000, /* PA_SC_AA_CONFIG */
-	0x00000005, /* PA_SU_VTX_CNTL */
-	0x3f800000, /* PA_CL_GB_VERT_CLIP_ADJ */
-	0x3f800000, /* PA_CL_GB_VERT_DISC_ADJ */
-	0x3f800000, /* PA_CL_GB_HORZ_CLIP_ADJ */
-	0x3f800000, /* PA_CL_GB_HORZ_DISC_ADJ */
-	0x00000000, /* PA_SC_AA_SAMPLE_LOCS_0 */
-	0x00000000, /*  */
-	0x00000000, /*  */
-	0x00000000, /*  */
-	0x00000000, /*  */
-	0x00000000, /*  */
-	0x00000000, /*  */
-	0x00000000, /* PA_SC_AA_SAMPLE_LOCS_7 */
-	0xffffffff, /* PA_SC_AA_MASK */
-
-	0xc00d6900,
-	0x00000202,
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
-	0x00000000, /* SQ_DYN_GPR_RESOURCE_LIMIT_1 */
-
-	0xc0066900,
-	0x000002de,
-	0x00000000, /* PA_SU_POLY_OFFSET_DB_FMT_CNTL */
-	0x00000000, /*  */
-	0x00000000, /*  */
-	0x00000000, /*  */
-	0x00000000, /*  */
-	0x00000000, /*  */
-
-	0xc0016900,
-	0x00000229,
-	0x00000000, /* SQ_PGM_START_FS */
-
-	0xc0016900,
-	0x0000022a,
-	0x00000000, /* SQ_PGM_RESOURCES_FS */
-
-	0xc0096900,
-	0x00000100,
-	0x00ffffff, /* VGT_MAX_VTX_INDX */
-	0x00000000, /*  */
-	0x00000000, /*  */
-	0x00000000, /*  */
-	0x00000000, /* SX_ALPHA_TEST_CONTROL */
-	0x00000000, /* CB_BLEND_RED */
-	0x00000000, /* CB_BLEND_GREEN */
-	0x00000000, /* CB_BLEND_BLUE */
-	0x00000000, /* CB_BLEND_ALPHA */
-
-	0xc0026900,
-	0x000002a8,
-	0x00000000, /* VGT_INSTANCE_STEP_RATE_0 */
-	0x00000000, /*  */
-
-	0xc0026900,
-	0x000002ad,
-	0x00000000, /* VGT_REUSE_OFF */
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
-	0x00000000, /*  */
-	0x00000000, /*  */
-	0x00000000, /*  */
-	0x00000000, /*  */
-	0x00000000, /*  */
-	0x00000000, /*  */
-	0x00000000, /*  */
-	0x00000000, /*  */
-	0x00000000, /*  */
-	0x00000000, /*  */
-	0x00000000, /* VGT_GS_MODE */
-
-	0xc0016900,
-	0x000002a1,
-	0x00000000, /* VGT_PRIMITIVEID_EN */
-
-	0xc0016900,
-	0x000002a5,
-	0x00000000, /* VGT_MULTI_PRIM_IB_RESET_EN */
-
-	0xc0016900,
-	0x000002d5,
-	0x00000000, /* VGT_SHADER_STAGES_EN */
-
-	0xc0026900,
-	0x000002e5,
-	0x00000000, /* VGT_STRMOUT_CONFIG */
-	0x00000000, /*  */
-
-	0xc0016900,
-	0x000001e0,
-	0x00000000, /* CB_BLEND0_CONTROL */
-
-	0xc0016900,
-	0x000001b1,
-	0x00000000, /* SPI_VS_OUT_CONFIG */
-
-	0xc0016900,
-	0x00000187,
-	0x00000000, /* SPI_VS_OUT_ID_0 */
-
-	0xc0016900,
-	0x00000191,
-	0x00000100, /* SPI_PS_INPUT_CNTL_0 */
-
-	0xc00b6900,
-	0x000001b3,
-	0x20000001, /* SPI_PS_IN_CONTROL_0 */
-	0x00000000, /* SPI_PS_IN_CONTROL_1 */
-	0x00000000, /* SPI_INTERP_CONTROL_0 */
-	0x00000000, /* SPI_INPUT_Z */
-	0x00000000, /* SPI_FOG_CNTL */
-	0x00100000, /* SPI_BARYC_CNTL */
-	0x00000000, /* SPI_PS_IN_CONTROL_2 */
-	0x00000000, /*  */
-	0x00000000, /*  */
-	0x00000000, /*  */
-	0x00000000, /*  */
-
-	0xc0026900,
-	0x00000316,
-	0x0000000e, /* VGT_VERTEX_REUSE_BLOCK_CNTL */
-	0x00000010, /*  */
-};
-
-const u32 evergreen_default_size = ARRAY_SIZE(evergreen_default_state);
diff --git a/drivers/gpu/drm/radeon/evergreen_blit_shaders.h b/drivers/gpu/drm/radeon/evergreen_blit_shaders.h
index bb8d6c751595..4492524ee1df 100644
--- a/drivers/gpu/drm/radeon/evergreen_blit_shaders.h
+++ b/drivers/gpu/drm/radeon/evergreen_blit_shaders.h
@@ -20,16 +20,284 @@
  * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
  * DEALINGS IN THE SOFTWARE.
  *
+ * Authors:
+ *     Alex Deucher <alexander.deucher@amd.com>
  */
 
 #ifndef EVERGREEN_BLIT_SHADERS_H
 #define EVERGREEN_BLIT_SHADERS_H
 
-extern const u32 evergreen_ps[];
-extern const u32 evergreen_vs[];
-extern const u32 evergreen_default_state[];
+/*
+ * evergreen cards need to use the 3D engine to blit data which requires
+ * quite a bit of hw state setup.  Rather than pull the whole 3D driver
+ * (which normally generates the 3D state) into the DRM, we opt to use
+ * statically generated state tables.  The register state and shaders
+ * were hand generated to support blitting functionality.  See the 3D
+ * driver or documentation for descriptions of the registers and
+ * shader instructions.
+ */
+
+static const u32 evergreen_default_state[] = {
+	0xc0016900,
+	0x0000023b,
+	0x00000000, /* SQ_LDS_ALLOC_PS */
+
+	0xc0066900,
+	0x00000240,
+	0x00000000, /* SQ_ESGS_RING_ITEMSIZE */
+	0x00000000,
+	0x00000000,
+	0x00000000,
+	0x00000000,
+	0x00000000,
+
+	0xc0046900,
+	0x00000247,
+	0x00000000, /* SQ_GS_VERT_ITEMSIZE */
+	0x00000000,
+	0x00000000,
+	0x00000000,
+
+	0xc0026900,
+	0x00000010,
+	0x00000000, /* DB_Z_INFO */
+	0x00000000, /* DB_STENCIL_INFO */
+
+	0xc0016900,
+	0x00000200,
+	0x00000000, /* DB_DEPTH_CONTROL */
+
+	0xc0066900,
+	0x00000000,
+	0x00000060, /* DB_RENDER_CONTROL */
+	0x00000000, /* DB_COUNT_CONTROL */
+	0x00000000, /* DB_DEPTH_VIEW */
+	0x0000002a, /* DB_RENDER_OVERRIDE */
+	0x00000000, /* DB_RENDER_OVERRIDE2 */
+	0x00000000, /* DB_HTILE_DATA_BASE */
+
+	0xc0026900,
+	0x0000000a,
+	0x00000000, /* DB_STENCIL_CLEAR */
+	0x00000000, /* DB_DEPTH_CLEAR */
+
+	0xc0016900,
+	0x000002dc,
+	0x0000aa00, /* DB_ALPHA_TO_MASK */
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
+	0xc0016900,
+	0x000000d4,
+	0x00000000, /* SX_MISC */
+
+	0xc0026900,
+	0x00000292,
+	0x00000000, /* PA_SC_MODE_CNTL_0 */
+	0x00000000, /* PA_SC_MODE_CNTL_1 */
+
+	0xc0106900,
+	0x00000300,
+	0x00000000, /* PA_SC_LINE_CNTL */
+	0x00000000, /* PA_SC_AA_CONFIG */
+	0x00000005, /* PA_SU_VTX_CNTL */
+	0x3f800000, /* PA_CL_GB_VERT_CLIP_ADJ */
+	0x3f800000, /* PA_CL_GB_VERT_DISC_ADJ */
+	0x3f800000, /* PA_CL_GB_HORZ_CLIP_ADJ */
+	0x3f800000, /* PA_CL_GB_HORZ_DISC_ADJ */
+	0x00000000, /* PA_SC_AA_SAMPLE_LOCS_0 */
+	0x00000000, /*  */
+	0x00000000, /*  */
+	0x00000000, /*  */
+	0x00000000, /*  */
+	0x00000000, /*  */
+	0x00000000, /*  */
+	0x00000000, /* PA_SC_AA_SAMPLE_LOCS_7 */
+	0xffffffff, /* PA_SC_AA_MASK */
+
+	0xc00d6900,
+	0x00000202,
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
+	0x00000000, /* SQ_DYN_GPR_RESOURCE_LIMIT_1 */
+
+	0xc0066900,
+	0x000002de,
+	0x00000000, /* PA_SU_POLY_OFFSET_DB_FMT_CNTL */
+	0x00000000, /*  */
+	0x00000000, /*  */
+	0x00000000, /*  */
+	0x00000000, /*  */
+	0x00000000, /*  */
+
+	0xc0016900,
+	0x00000229,
+	0x00000000, /* SQ_PGM_START_FS */
+
+	0xc0016900,
+	0x0000022a,
+	0x00000000, /* SQ_PGM_RESOURCES_FS */
+
+	0xc0096900,
+	0x00000100,
+	0x00ffffff, /* VGT_MAX_VTX_INDX */
+	0x00000000, /*  */
+	0x00000000, /*  */
+	0x00000000, /*  */
+	0x00000000, /* SX_ALPHA_TEST_CONTROL */
+	0x00000000, /* CB_BLEND_RED */
+	0x00000000, /* CB_BLEND_GREEN */
+	0x00000000, /* CB_BLEND_BLUE */
+	0x00000000, /* CB_BLEND_ALPHA */
+
+	0xc0026900,
+	0x000002a8,
+	0x00000000, /* VGT_INSTANCE_STEP_RATE_0 */
+	0x00000000, /*  */
+
+	0xc0026900,
+	0x000002ad,
+	0x00000000, /* VGT_REUSE_OFF */
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
+	0x00000000, /*  */
+	0x00000000, /*  */
+	0x00000000, /*  */
+	0x00000000, /*  */
+	0x00000000, /*  */
+	0x00000000, /*  */
+	0x00000000, /*  */
+	0x00000000, /*  */
+	0x00000000, /*  */
+	0x00000000, /*  */
+	0x00000000, /* VGT_GS_MODE */
+
+	0xc0016900,
+	0x000002a1,
+	0x00000000, /* VGT_PRIMITIVEID_EN */
+
+	0xc0016900,
+	0x000002a5,
+	0x00000000, /* VGT_MULTI_PRIM_IB_RESET_EN */
+
+	0xc0016900,
+	0x000002d5,
+	0x00000000, /* VGT_SHADER_STAGES_EN */
+
+	0xc0026900,
+	0x000002e5,
+	0x00000000, /* VGT_STRMOUT_CONFIG */
+	0x00000000, /*  */
+
+	0xc0016900,
+	0x000001e0,
+	0x00000000, /* CB_BLEND0_CONTROL */
+
+	0xc0016900,
+	0x000001b1,
+	0x00000000, /* SPI_VS_OUT_CONFIG */
+
+	0xc0016900,
+	0x00000187,
+	0x00000000, /* SPI_VS_OUT_ID_0 */
+
+	0xc0016900,
+	0x00000191,
+	0x00000100, /* SPI_PS_INPUT_CNTL_0 */
+
+	0xc00b6900,
+	0x000001b3,
+	0x20000001, /* SPI_PS_IN_CONTROL_0 */
+	0x00000000, /* SPI_PS_IN_CONTROL_1 */
+	0x00000000, /* SPI_INTERP_CONTROL_0 */
+	0x00000000, /* SPI_INPUT_Z */
+	0x00000000, /* SPI_FOG_CNTL */
+	0x00100000, /* SPI_BARYC_CNTL */
+	0x00000000, /* SPI_PS_IN_CONTROL_2 */
+	0x00000000, /*  */
+	0x00000000, /*  */
+	0x00000000, /*  */
+	0x00000000, /*  */
+
+	0xc0026900,
+	0x00000316,
+	0x0000000e, /* VGT_VERTEX_REUSE_BLOCK_CNTL */
+	0x00000010, /*  */
+};
 
-extern const u32 evergreen_ps_size, evergreen_vs_size;
-extern const u32 evergreen_default_size;
+static const u32 evergreen_default_size = ARRAY_SIZE(evergreen_default_state);
 
 #endif
-- 
2.27.0

