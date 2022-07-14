Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C57D575360
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 18:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237182AbiGNQt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 12:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbiGNQtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 12:49:22 -0400
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6AB709A0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 09:46:43 -0700 (PDT)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx0.riseup.net (Postfix) with ESMTPS id 4LkL401Cf9z9sP3;
        Thu, 14 Jul 2022 16:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1657817200; bh=jin3QB7Bpp0xi9guZgDlYpL866Yplg7ACCxAJbwkV34=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V3t0FM49v4jrgNvcu8jRRwqUQyxfo9GyYVBSzwTDiVxsuE9qSc2XN/kXT4dUmKeEv
         veMuwOZv53sHNmAPtuGS+kYH3+XZibkgtv1Isow7VzoMgO9NR/Oivo1XW0wdJzCJtm
         lHyACxWzbO1/T0kct7wbKhy/wqWE3Ky0Y3Gw/yfk=
X-Riseup-User-ID: 9B2B27D3C04C46256B8CE270712AA333E5927D810A2D99C6DE7589A8C9C171AD
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4LkL3t1FMKz5vW1;
        Thu, 14 Jul 2022 16:46:33 +0000 (UTC)
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
Subject: [PATCH 10/12] drm/amd/display: Remove parameters from dml30_CalculateWriteBackDISPCLK
Date:   Thu, 14 Jul 2022 13:45:05 -0300
Message-Id: <20220714164507.561751-10-mairacanal@riseup.net>
In-Reply-To: <20220714164507.561751-1-mairacanal@riseup.net>
References: <20220714164507.561751-1-mairacanal@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The parameters WritebackPixelFormat and WritebackVRatio are removed as
they are not used on the function dml30_CalculateWriteBackDISPCLK.

Signed-off-by: Maíra Canal <mairacanal@riseup.net>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c        | 2 --
 .../gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c  | 6 ------
 .../gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.h  | 2 --
 3 files changed, 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
index a8db1306750e..746bb93ade6c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
@@ -322,10 +322,8 @@ void dcn30_fpu_populate_dml_writeback_from_context(
 				 * parameters per pipe
 				 */
 				writeback_dispclk = dml30_CalculateWriteBackDISPCLK(
-						dout_wb.wb_pixel_format,
 						pipes[pipe_cnt].pipe.dest.pixel_rate_mhz,
 						dout_wb.wb_hratio,
-						dout_wb.wb_vratio,
 						dout_wb.wb_htaps_luma,
 						dout_wb.wb_vtaps_luma,
 						dout_wb.wb_src_width,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
index 876b321b30ca..37049daaab4c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
@@ -1938,10 +1938,8 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 		if (v->WritebackEnable[k]) {
 			v->WritebackDISPCLK = dml_max(v->WritebackDISPCLK,
 				dml30_CalculateWriteBackDISPCLK(
-						v->WritebackPixelFormat[k],
 						v->PixelClock[k],
 						v->WritebackHRatio[k],
-						v->WritebackVRatio[k],
 						v->WritebackHTaps[k],
 						v->WritebackVTaps[k],
 						v->WritebackSourceWidth[k],
@@ -3284,10 +3282,8 @@ static double CalculateTWait(
 }
 
 double dml30_CalculateWriteBackDISPCLK(
-		enum source_format_class WritebackPixelFormat,
 		double PixelClock,
 		double WritebackHRatio,
-		double WritebackVRatio,
 		unsigned int WritebackHTaps,
 		unsigned int WritebackVTaps,
 		long   WritebackSourceWidth,
@@ -3794,10 +3790,8 @@ void dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 		if (v->WritebackEnable[k] == true) {
 			v->WritebackRequiredDISPCLK = dml_max(v->WritebackRequiredDISPCLK,
 					dml30_CalculateWriteBackDISPCLK(
-							v->WritebackPixelFormat[k],
 							v->PixelClock[k],
 							v->WritebackHRatio[k],
-							v->WritebackVRatio[k],
 							v->WritebackHTaps[k],
 							v->WritebackVTaps[k],
 							v->WritebackSourceWidth[k],
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.h b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.h
index daaf0883b84d..12c070434eee 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.h
@@ -29,10 +29,8 @@
 void dml30_recalculate(struct display_mode_lib *mode_lib);
 void dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_lib);
 double dml30_CalculateWriteBackDISPCLK(
-		enum source_format_class WritebackPixelFormat,
 		double PixelClock,
 		double WritebackHRatio,
-		double WritebackVRatio,
 		unsigned int WritebackHTaps,
 		unsigned int WritebackVTaps,
 		long   WritebackSourceWidth,
-- 
2.36.1

