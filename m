Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF55157D369
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 20:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbiGUShF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 14:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiGUShD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 14:37:03 -0400
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDC989E8E
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 11:37:02 -0700 (PDT)
Received: from fews2.riseup.net (fews2-pn.riseup.net [10.0.1.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx0.riseup.net (Postfix) with ESMTPS id 4LphB51kN7z9sQp;
        Thu, 21 Jul 2022 18:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1658428621; bh=SlBuZhDJB9+8W3IMnRwcvTJ0NQOsqi/7W7IwX02VvnI=;
        h=From:To:Cc:Subject:Date:From;
        b=qOCgfVCOS9j72zMfAAasXpqCdscD40pV1N0McBCdwVfHvUgApn8NVAS+piIIMERDP
         L43wfZl1iN/mQa9rEa8f+T2xozPHJyr76GtsaR8EVvBBDiMstTSgRLAHxkTr6WKA/t
         JD0M8tsQaclfBHY9lRxVqNk/zwvn5XyFwEhKEYqE=
X-Riseup-User-ID: 92B8EB9B4086F3AC5D160D429D66F13261B8290F571CB429AFFD5B486E813FA3
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews2.riseup.net (Postfix) with ESMTPSA id 4Lph9z2l4lz1xph;
        Thu, 21 Jul 2022 18:36:55 +0000 (UTC)
From:   =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        christian.koenig@amd.com, Xinhui.Pan@amd.com,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc:     amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        mwen@igalia.com, andrealmeid@riseup.net,
        Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
Subject: [PATCH v2 1/4] drm/amd/display: Drop dm_sw_gfx7_2d_thin_l_vp and dm_sw_gfx7_2d_thin_gl
Date:   Thu, 21 Jul 2022 15:36:30 -0300
Message-Id: <20220721183633.1004611-1-mairacanal@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the enum entries dm_sw_gfx7_2d_thin_gl and dm_sw_gfx7_2d_thin_l_vp
are not used on the codebase, drop those entries from enum
dm_swizzle_mode.

Signed-off-by: Maíra Canal <mairacanal@riseup.net>
---
v1 -> v2:
- Replace "enum" to "enum entries" (André Almeida).
- Describe changes in imperative mood (André Almeida).
---
 .../dc/dml/dcn20/display_mode_vba_20.c        | 26 +++++-------------
 .../dc/dml/dcn20/display_mode_vba_20v2.c      | 26 +++++-------------
 .../dc/dml/dcn21/display_mode_vba_21.c        | 27 +++++--------------
 .../amd/display/dc/dml/display_mode_enums.h   |  2 --
 .../display/dc/dml/dml_wrapper_translation.c  |  9 -------
 5 files changed, 19 insertions(+), 71 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
index d3b5b6fedf04..4e4cb0927057 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
@@ -938,7 +938,7 @@ static unsigned int CalculateVMAndRowBytes(
 		*MetaRowByte = 0;
 	}
 
-	if (SurfaceTiling == dm_sw_linear || SurfaceTiling == dm_sw_gfx7_2d_thin_gl || SurfaceTiling == dm_sw_gfx7_2d_thin_l_vp) {
+	if (SurfaceTiling == dm_sw_linear) {
 		MacroTileSizeBytes = 256;
 		MacroTileHeight = BlockHeight256Bytes;
 	} else if (SurfaceTiling == dm_sw_4kb_s || SurfaceTiling == dm_sw_4kb_s_x
@@ -3347,26 +3347,12 @@ void dml20_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 										== dm_420_8
 								|| mode_lib->vba.SourcePixelFormat[k]
 										== dm_420_10))
-				|| (((mode_lib->vba.SurfaceTiling[k] == dm_sw_gfx7_2d_thin_gl
-						|| mode_lib->vba.SurfaceTiling[k]
-								== dm_sw_gfx7_2d_thin_l_vp)
-						&& !((mode_lib->vba.SourcePixelFormat[k]
-								== dm_444_64
+				|| (mode_lib->vba.DCCEnable[k] == true
+						&& (mode_lib->vba.SurfaceTiling[k] == dm_sw_linear
 								|| mode_lib->vba.SourcePixelFormat[k]
-										== dm_444_32)
-								&& mode_lib->vba.SourceScan[k]
-										== dm_horz
-								&& mode_lib->vba.SupportGFX7CompatibleTilingIn32bppAnd64bpp
-										== true
-								&& mode_lib->vba.DCCEnable[k]
-										== false))
-						|| (mode_lib->vba.DCCEnable[k] == true
-								&& (mode_lib->vba.SurfaceTiling[k]
-										== dm_sw_linear
-										|| mode_lib->vba.SourcePixelFormat[k]
-												== dm_420_8
-										|| mode_lib->vba.SourcePixelFormat[k]
-												== dm_420_10)))) {
+										== dm_420_8
+								|| mode_lib->vba.SourcePixelFormat[k]
+										== dm_420_10))) {
 			mode_lib->vba.SourceFormatPixelAndScanSupport = false;
 		}
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
index 63bbdf8b8678..eaa0cdb599ba 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
@@ -998,7 +998,7 @@ static unsigned int CalculateVMAndRowBytes(
 		*MetaRowByte = 0;
 	}
 
-	if (SurfaceTiling == dm_sw_linear || SurfaceTiling == dm_sw_gfx7_2d_thin_gl || SurfaceTiling == dm_sw_gfx7_2d_thin_l_vp) {
+	if (SurfaceTiling == dm_sw_linear) {
 		MacroTileSizeBytes = 256;
 		MacroTileHeight = BlockHeight256Bytes;
 	} else if (SurfaceTiling == dm_sw_4kb_s || SurfaceTiling == dm_sw_4kb_s_x
@@ -3454,26 +3454,12 @@ void dml20v2_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode
 										== dm_420_8
 								|| mode_lib->vba.SourcePixelFormat[k]
 										== dm_420_10))
-				|| (((mode_lib->vba.SurfaceTiling[k] == dm_sw_gfx7_2d_thin_gl
-						|| mode_lib->vba.SurfaceTiling[k]
-								== dm_sw_gfx7_2d_thin_l_vp)
-						&& !((mode_lib->vba.SourcePixelFormat[k]
-								== dm_444_64
+				|| (mode_lib->vba.DCCEnable[k] == true
+						&& (mode_lib->vba.SurfaceTiling[k] == dm_sw_linear
 								|| mode_lib->vba.SourcePixelFormat[k]
-										== dm_444_32)
-								&& mode_lib->vba.SourceScan[k]
-										== dm_horz
-								&& mode_lib->vba.SupportGFX7CompatibleTilingIn32bppAnd64bpp
-										== true
-								&& mode_lib->vba.DCCEnable[k]
-										== false))
-						|| (mode_lib->vba.DCCEnable[k] == true
-								&& (mode_lib->vba.SurfaceTiling[k]
-										== dm_sw_linear
-										|| mode_lib->vba.SourcePixelFormat[k]
-												== dm_420_8
-										|| mode_lib->vba.SourcePixelFormat[k]
-												== dm_420_10)))) {
+										== dm_420_8
+								|| mode_lib->vba.SourcePixelFormat[k]
+										== dm_420_10))) {
 			mode_lib->vba.SourceFormatPixelAndScanSupport = false;
 		}
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
index 8a7485e21d53..198d81861ac5 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
@@ -1342,7 +1342,7 @@ static unsigned int CalculateVMAndRowBytes(
 		*MetaRowByte = 0;
 	}
 
-	if (SurfaceTiling == dm_sw_linear || SurfaceTiling == dm_sw_gfx7_2d_thin_gl || SurfaceTiling == dm_sw_gfx7_2d_thin_l_vp) {
+	if (SurfaceTiling == dm_sw_linear) {
 		MacroTileSizeBytes = 256;
 		MacroTileHeight = BlockHeight256Bytes;
 	} else if (SurfaceTiling == dm_sw_4kb_s || SurfaceTiling == dm_sw_4kb_s_x
@@ -3579,26 +3579,13 @@ void dml21_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 										== dm_420_8
 								|| mode_lib->vba.SourcePixelFormat[k]
 										== dm_420_10))
-				|| (((mode_lib->vba.SurfaceTiling[k] == dm_sw_gfx7_2d_thin_gl
-						|| mode_lib->vba.SurfaceTiling[k]
-								== dm_sw_gfx7_2d_thin_l_vp)
-						&& !((mode_lib->vba.SourcePixelFormat[k]
-								== dm_444_64
+				|| (mode_lib->vba.DCCEnable[k] == true
+						&& (mode_lib->vba.SurfaceTiling[k]
+								== dm_sw_linear
 								|| mode_lib->vba.SourcePixelFormat[k]
-										== dm_444_32)
-								&& mode_lib->vba.SourceScan[k]
-										== dm_horz
-								&& mode_lib->vba.SupportGFX7CompatibleTilingIn32bppAnd64bpp
-										== true
-								&& mode_lib->vba.DCCEnable[k]
-										== false))
-						|| (mode_lib->vba.DCCEnable[k] == true
-								&& (mode_lib->vba.SurfaceTiling[k]
-										== dm_sw_linear
-										|| mode_lib->vba.SourcePixelFormat[k]
-												== dm_420_8
-										|| mode_lib->vba.SourcePixelFormat[k]
-												== dm_420_10)))) {
+										== dm_420_8
+								|| mode_lib->vba.SourcePixelFormat[k]
+										== dm_420_10))) {
 			mode_lib->vba.SourceFormatPixelAndScanSupport = false;
 		}
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_enums.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_enums.h
index f394b3f3922a..0e06727d40b3 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_enums.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_enums.h
@@ -89,8 +89,6 @@ enum dm_swizzle_mode {
 	dm_sw_var_s_x = 29,
 	dm_sw_var_d_x = 30,
 	dm_sw_var_r_x = 31,
-	dm_sw_gfx7_2d_thin_l_vp,
-	dm_sw_gfx7_2d_thin_gl,
 };
 enum lb_depth {
 	dm_lb_10 = 0, dm_lb_8 = 1, dm_lb_6 = 2, dm_lb_12 = 3, dm_lb_16 = 4,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dml_wrapper_translation.c b/drivers/gpu/drm/amd/display/dc/dml/dml_wrapper_translation.c
index 4ec5310a2962..9edcb6fc83c1 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dml_wrapper_translation.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dml_wrapper_translation.c
@@ -35,15 +35,6 @@ static void gfx10array_mode_to_dml_params(
 	case DC_ARRAY_LINEAR_GENERAL:
 		*sw_mode = dm_sw_linear;
 		break;
-	case DC_ARRAY_2D_TILED_THIN1:
-// DC_LEGACY_TILING_ADDR_GEN_ZERO - undefined as per current code hence removed
-#if 0
-		if (compat_level == DC_LEGACY_TILING_ADDR_GEN_ZERO)
-			*sw_mode = dm_sw_gfx7_2d_thin_l_vp;
-		else
-			*sw_mode = dm_sw_gfx7_2d_thin_gl;
-#endif
-		break;
 	default:
 		ASSERT(0); /* Not supported */
 		break;
-- 
2.36.1

