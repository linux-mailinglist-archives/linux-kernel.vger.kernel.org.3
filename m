Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4435845C9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 20:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232915AbiG1SXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 14:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233147AbiG1SXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 14:23:16 -0400
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A327274E2F
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 11:23:15 -0700 (PDT)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4LtzXz0ZxHzDryt;
        Thu, 28 Jul 2022 18:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1659032595; bh=LnmnWVBXfBBsa2YvNeh9AU/iih0ZnFjpv0bMrh0FAP8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IS7cW3mLiujda2mpl99ObsGOY+1kSIgWAD/8u6Qgq0S1oFjc5wAo66z70gfuQNzvy
         g2S72l5sDJzJqNxv5sqk9QOnm/NIwQ/oReT0q6npdG2QcIwtp2U/++8yYxnfOrxXs6
         7eBlpJnjgFS27rKZwoeSnyKzhdrVwgHZIfDOx8bs=
X-Riseup-User-ID: 785C277BFA268284350BCCF64E44C393D806A14C85E7B44A5EF3FAAAE016287F
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4LtzXt2rL8z5vMX;
        Thu, 28 Jul 2022 18:23:10 +0000 (UTC)
From:   =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        christian.koenig@amd.com, Xinhui.Pan@amd.com,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        mwen@igalia.com, andrealmeid@riseup.net,
        Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
Subject: [PATCH 14/16] drm/amd/display: Remove MaximumDCCCompressionYSurface VBA variable
Date:   Thu, 28 Jul 2022 15:20:46 -0300
Message-Id: <20220728182047.264825-15-mairacanal@riseup.net>
In-Reply-To: <20220728182047.264825-1-mairacanal@riseup.net>
References: <20220728182047.264825-1-mairacanal@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MaximumDCCCompressionYSurface variable from the struct vba_vars_st is
only used on assignments, so its value is not used on code. So,
remove the MaximumDCCCompressionYSurface entry from the struct vba_vars_st.

Signed-off-by: Maíra Canal <mairacanal@riseup.net>
---
 .../amd/display/dc/dml/dcn21/display_mode_vba_21.c  | 13 +++----------
 .../gpu/drm/amd/display/dc/dml/display_mode_vba.h   |  1 -
 2 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
index bc8cc21cf3f6..7007b6e16e7d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
@@ -143,7 +143,7 @@ static bool CalculatePrefetchSchedule(
 		double *VReadyOffsetPix);
 static double RoundToDFSGranularityUp(double Clock, double VCOSpeed);
 static double RoundToDFSGranularityDown(double Clock, double VCOSpeed);
-static double CalculateDCCConfiguration(
+static void CalculateDCCConfiguration(
 		bool                 DCCEnabled,
 		bool                 DCCProgrammingAssumesScanDirectionUnknown,
 		unsigned int         ViewportWidth,
@@ -1072,7 +1072,7 @@ static double RoundToDFSGranularityDown(double Clock, double VCOSpeed)
 	return VCOSpeed * 4 / dml_ceil(VCOSpeed * 4 / Clock, 1);
 }
 
-static double CalculateDCCConfiguration(
+static void CalculateDCCConfiguration(
 		bool DCCEnabled,
 		bool DCCProgrammingAssumesScanDirectionUnknown,
 		unsigned int ViewportWidth,
@@ -1087,7 +1087,6 @@ static double CalculateDCCConfiguration(
 		unsigned int *MaxCompressedBlock,
 		unsigned int *Independent64ByteBlock)
 {
-	double MaximumDCCCompressionSurface = 0.0;
 	enum {
 		REQ_256Bytes,
 		REQ_128BytesNonContiguous,
@@ -1185,25 +1184,19 @@ static double CalculateDCCConfiguration(
 		*MaxUncompressedBlock = 256;
 		*MaxCompressedBlock = 256;
 		*Independent64ByteBlock = false;
-		MaximumDCCCompressionSurface = 4.0;
 	} else if (Request == REQ_128BytesContiguous) {
 		*MaxUncompressedBlock = 128;
 		*MaxCompressedBlock = 128;
 		*Independent64ByteBlock = false;
-		MaximumDCCCompressionSurface = 2.0;
 	} else if (Request == REQ_128BytesNonContiguous) {
 		*MaxUncompressedBlock = 256;
 		*MaxCompressedBlock = 64;
 		*Independent64ByteBlock = true;
-		MaximumDCCCompressionSurface = 4.0;
 	} else {
 		*MaxUncompressedBlock = 0;
 		*MaxCompressedBlock = 0;
 		*Independent64ByteBlock = 0;
-		MaximumDCCCompressionSurface = 0.0;
 	}
-
-	return MaximumDCCCompressionSurface;
 }
 
 static double CalculatePrefetchSourceLines(
@@ -2568,7 +2561,7 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 	// DCC Configuration
 	mode_lib->vba.ActiveDPPs = 0;
 	for (k = 0; k < mode_lib->vba.NumberOfActivePlanes; ++k) {
-		locals->MaximumDCCCompressionYSurface[k] = CalculateDCCConfiguration(
+		CalculateDCCConfiguration(
 			mode_lib->vba.DCCEnable[k],
 			false, // We should always know the direction DCCProgrammingAssumesScanDirectionUnknown,
 			mode_lib->vba.ViewportWidth[k],
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
index 46e69f941bff..a07e97035dd1 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
@@ -1032,7 +1032,6 @@ struct vba_vars_st {
 	unsigned int DCCYMaxUncompressedBlock[DC__NUM_DPP__MAX];
 	unsigned int DCCYMaxCompressedBlock[DC__NUM_DPP__MAX];
 	unsigned int DCCYIndependent64ByteBlock[DC__NUM_DPP__MAX];
-	double MaximumDCCCompressionYSurface[DC__NUM_DPP__MAX];
 	unsigned int BlockHeight256BytesY[DC__NUM_DPP__MAX];
 	unsigned int BlockHeight256BytesC[DC__NUM_DPP__MAX];
 	unsigned int BlockWidth256BytesY[DC__NUM_DPP__MAX];
-- 
2.37.1

