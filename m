Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5801D5845BD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 20:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiG1SW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 14:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232976AbiG1SWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 14:22:36 -0400
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634E774E0B
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 11:22:34 -0700 (PDT)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4LtzX94vkSzDryt;
        Thu, 28 Jul 2022 18:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1659032553; bh=zE+o6ufPkkpuK2HCBtOVfWw99bIfiN4ZlL3ielUoD0o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ur3f9RtzAko6ST0qePBuaZMGUYhXFfNn9015p/5+EdOfGscQf5OKHaGqMnZ+aAAPS
         OntM82BJd0GVWEXgJ+iWe800uwvVBykfj3+BQunX2AwIL5H5b8Fs9lM++BccE9OiVq
         64cz7aYD9EpJdKwkggu7XpLUjpQWKMwfpoPEPR0o=
X-Riseup-User-ID: 0D1B0215170A3491065454787D6596993FB14755A662347E4A01025C16C63E5C
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4LtzX46bQJz5vMX;
        Thu, 28 Jul 2022 18:22:28 +0000 (UTC)
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
Subject: [PATCH 08/16] drm/amd/display: Remove some XFC variables from VBA
Date:   Thu, 28 Jul 2022 15:20:40 -0300
Message-Id: <20220728182047.264825-9-mairacanal@riseup.net>
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

The variables XFCSupported, XFCTSlvVupdateOffset, XFCSlaveVupdateWidth,
XFCSlaveVReadyOffset, XFCTransferDelay, XFCPrechargeDelay,
XFCRemoteSurfaceFlipLatency and XFCPrefetchMargin are are only
used on assignments, so their values are not used on code. So, remove
the variables entries from the struct vba_vars_st.

Signed-off-by: Maíra Canal <mairacanal@riseup.net>
---
 .../dc/dml/dcn20/display_mode_vba_20.c        | 38 -------------------
 .../dc/dml/dcn20/display_mode_vba_20v2.c      | 38 -------------------
 .../dc/dml/dcn21/display_mode_vba_21.c        | 38 -------------------
 .../drm/amd/display/dc/dml/display_mode_vba.c |  1 -
 .../drm/amd/display/dc/dml/display_mode_vba.h |  8 ----
 5 files changed, 123 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
index 1424aa7a5018..7effe4be61b2 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
@@ -2580,9 +2580,6 @@ static void dml20_DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPer
 		if (mode_lib->vba.XFCEnabled[k] == true) {
 			double TWait;
 
-			mode_lib->vba.XFCSlaveVUpdateOffset[k] = mode_lib->vba.XFCTSlvVupdateOffset;
-			mode_lib->vba.XFCSlaveVupdateWidth[k] = mode_lib->vba.XFCTSlvVupdateWidth;
-			mode_lib->vba.XFCSlaveVReadyOffset[k] = mode_lib->vba.XFCTSlvVreadyOffset;
 			TWait = CalculateTWait(
 					mode_lib->vba.PrefetchMode[mode_lib->vba.VoltageLevel][mode_lib->vba.maxMpcComb],
 					mode_lib->vba.DRAMClockChangeLatency,
@@ -2606,26 +2603,6 @@ static void dml20_DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPer
 					&mode_lib->vba.SrcActiveDrainRate,
 					&mode_lib->vba.TInitXFill,
 					&mode_lib->vba.TslvChk);
-			mode_lib->vba.XFCRemoteSurfaceFlipLatency[k] =
-					dml_floor(
-							mode_lib->vba.XFCRemoteSurfaceFlipDelay
-									/ (mode_lib->vba.HTotal[k]
-											/ mode_lib->vba.PixelClock[k]),
-							1);
-			mode_lib->vba.XFCTransferDelay[k] =
-					dml_ceil(
-							mode_lib->vba.XFCBusTransportTime
-									/ (mode_lib->vba.HTotal[k]
-											/ mode_lib->vba.PixelClock[k]),
-							1);
-			mode_lib->vba.XFCPrechargeDelay[k] =
-					dml_ceil(
-							(mode_lib->vba.XFCBusTransportTime
-									+ mode_lib->vba.TInitXFill
-									+ mode_lib->vba.TslvChk)
-									/ (mode_lib->vba.HTotal[k]
-											/ mode_lib->vba.PixelClock[k]),
-							1);
 			mode_lib->vba.InitFillLevel = mode_lib->vba.XFCXBUFLatencyTolerance
 					* mode_lib->vba.SrcActiveDrainRate;
 			mode_lib->vba.FinalFillMargin =
@@ -2644,21 +2621,6 @@ static void dml20_DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPer
 			mode_lib->vba.TFinalxFill = mode_lib->vba.RemainingFillLevel
 					/ (mode_lib->vba.SrcActiveDrainRate
 							* mode_lib->vba.XFCFillBWOverhead / 100);
-			mode_lib->vba.XFCPrefetchMargin[k] =
-					mode_lib->vba.XFCRemoteSurfaceFlipDelay
-							+ mode_lib->vba.TFinalxFill
-							+ (mode_lib->vba.DestinationLinesToRequestVMInVBlank[k]
-									+ mode_lib->vba.DestinationLinesToRequestRowInVBlank[k])
-									* mode_lib->vba.HTotal[k]
-									/ mode_lib->vba.PixelClock[k];
-		} else {
-			mode_lib->vba.XFCSlaveVUpdateOffset[k] = 0;
-			mode_lib->vba.XFCSlaveVupdateWidth[k] = 0;
-			mode_lib->vba.XFCSlaveVReadyOffset[k] = 0;
-			mode_lib->vba.XFCRemoteSurfaceFlipLatency[k] = 0;
-			mode_lib->vba.XFCPrechargeDelay[k] = 0;
-			mode_lib->vba.XFCTransferDelay[k] = 0;
-			mode_lib->vba.XFCPrefetchMargin[k] = 0;
 		}
 	}
 	{
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
index 03613dbb3e61..a23b400f615b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
@@ -2653,9 +2653,6 @@ static void dml20v2_DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndP
 		if (mode_lib->vba.XFCEnabled[k] == true) {
 			double TWait;
 
-			mode_lib->vba.XFCSlaveVUpdateOffset[k] = mode_lib->vba.XFCTSlvVupdateOffset;
-			mode_lib->vba.XFCSlaveVupdateWidth[k] = mode_lib->vba.XFCTSlvVupdateWidth;
-			mode_lib->vba.XFCSlaveVReadyOffset[k] = mode_lib->vba.XFCTSlvVreadyOffset;
 			TWait = CalculateTWait(
 					mode_lib->vba.PrefetchMode[mode_lib->vba.VoltageLevel][mode_lib->vba.maxMpcComb],
 					mode_lib->vba.DRAMClockChangeLatency,
@@ -2679,26 +2676,6 @@ static void dml20v2_DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndP
 					&mode_lib->vba.SrcActiveDrainRate,
 					&mode_lib->vba.TInitXFill,
 					&mode_lib->vba.TslvChk);
-			mode_lib->vba.XFCRemoteSurfaceFlipLatency[k] =
-					dml_floor(
-							mode_lib->vba.XFCRemoteSurfaceFlipDelay
-									/ (mode_lib->vba.HTotal[k]
-											/ mode_lib->vba.PixelClock[k]),
-							1);
-			mode_lib->vba.XFCTransferDelay[k] =
-					dml_ceil(
-							mode_lib->vba.XFCBusTransportTime
-									/ (mode_lib->vba.HTotal[k]
-											/ mode_lib->vba.PixelClock[k]),
-							1);
-			mode_lib->vba.XFCPrechargeDelay[k] =
-					dml_ceil(
-							(mode_lib->vba.XFCBusTransportTime
-									+ mode_lib->vba.TInitXFill
-									+ mode_lib->vba.TslvChk)
-									/ (mode_lib->vba.HTotal[k]
-											/ mode_lib->vba.PixelClock[k]),
-							1);
 			mode_lib->vba.InitFillLevel = mode_lib->vba.XFCXBUFLatencyTolerance
 					* mode_lib->vba.SrcActiveDrainRate;
 			mode_lib->vba.FinalFillMargin =
@@ -2717,21 +2694,6 @@ static void dml20v2_DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndP
 			mode_lib->vba.TFinalxFill = mode_lib->vba.RemainingFillLevel
 					/ (mode_lib->vba.SrcActiveDrainRate
 							* mode_lib->vba.XFCFillBWOverhead / 100);
-			mode_lib->vba.XFCPrefetchMargin[k] =
-					mode_lib->vba.XFCRemoteSurfaceFlipDelay
-							+ mode_lib->vba.TFinalxFill
-							+ (mode_lib->vba.DestinationLinesToRequestVMInVBlank[k]
-									+ mode_lib->vba.DestinationLinesToRequestRowInVBlank[k])
-									* mode_lib->vba.HTotal[k]
-									/ mode_lib->vba.PixelClock[k];
-		} else {
-			mode_lib->vba.XFCSlaveVUpdateOffset[k] = 0;
-			mode_lib->vba.XFCSlaveVupdateWidth[k] = 0;
-			mode_lib->vba.XFCSlaveVReadyOffset[k] = 0;
-			mode_lib->vba.XFCRemoteSurfaceFlipLatency[k] = 0;
-			mode_lib->vba.XFCPrechargeDelay[k] = 0;
-			mode_lib->vba.XFCTransferDelay[k] = 0;
-			mode_lib->vba.XFCPrefetchMargin[k] = 0;
 		}
 	}
 	{
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
index ae03f1a3c9f0..4ba9fa17ea39 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
@@ -2589,9 +2589,6 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 		if (mode_lib->vba.XFCEnabled[k] == true) {
 			double TWait;
 
-			locals->XFCSlaveVUpdateOffset[k] = mode_lib->vba.XFCTSlvVupdateOffset;
-			locals->XFCSlaveVupdateWidth[k] = mode_lib->vba.XFCTSlvVupdateWidth;
-			locals->XFCSlaveVReadyOffset[k] = mode_lib->vba.XFCTSlvVreadyOffset;
 			TWait = CalculateTWait(
 					mode_lib->vba.PrefetchMode[mode_lib->vba.VoltageLevel][mode_lib->vba.maxMpcComb],
 					mode_lib->vba.DRAMClockChangeLatency,
@@ -2615,26 +2612,6 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 					&mode_lib->vba.SrcActiveDrainRate,
 					&mode_lib->vba.TInitXFill,
 					&mode_lib->vba.TslvChk);
-					locals->XFCRemoteSurfaceFlipLatency[k] =
-					dml_floor(
-							mode_lib->vba.XFCRemoteSurfaceFlipDelay
-									/ (mode_lib->vba.HTotal[k]
-											/ mode_lib->vba.PixelClock[k]),
-							1);
-			locals->XFCTransferDelay[k] =
-					dml_ceil(
-							mode_lib->vba.XFCBusTransportTime
-									/ (mode_lib->vba.HTotal[k]
-											/ mode_lib->vba.PixelClock[k]),
-							1);
-			locals->XFCPrechargeDelay[k] =
-					dml_ceil(
-							(mode_lib->vba.XFCBusTransportTime
-									+ mode_lib->vba.TInitXFill
-									+ mode_lib->vba.TslvChk)
-									/ (mode_lib->vba.HTotal[k]
-											/ mode_lib->vba.PixelClock[k]),
-							1);
 			mode_lib->vba.InitFillLevel = mode_lib->vba.XFCXBUFLatencyTolerance
 					* mode_lib->vba.SrcActiveDrainRate;
 			mode_lib->vba.FinalFillMargin =
@@ -2653,21 +2630,6 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 			mode_lib->vba.TFinalxFill = mode_lib->vba.RemainingFillLevel
 					/ (mode_lib->vba.SrcActiveDrainRate
 							* mode_lib->vba.XFCFillBWOverhead / 100);
-			locals->XFCPrefetchMargin[k] =
-					mode_lib->vba.XFCRemoteSurfaceFlipDelay
-							+ mode_lib->vba.TFinalxFill
-							+ (locals->DestinationLinesToRequestVMInVBlank[k]
-									+ locals->DestinationLinesToRequestRowInVBlank[k])
-									* mode_lib->vba.HTotal[k]
-									/ mode_lib->vba.PixelClock[k];
-		} else {
-			locals->XFCSlaveVUpdateOffset[k] = 0;
-			locals->XFCSlaveVupdateWidth[k] = 0;
-			locals->XFCSlaveVReadyOffset[k] = 0;
-			locals->XFCRemoteSurfaceFlipLatency[k] = 0;
-			locals->XFCPrechargeDelay[k] = 0;
-			locals->XFCTransferDelay[k] = 0;
-			locals->XFCPrefetchMargin[k] = 0;
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
index 316153ece160..7a4a013f195a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
@@ -489,7 +489,6 @@ static void fetch_ip_params(struct display_mode_lib *mode_lib)
 	mode_lib->vba.ODMCapability = ip->odm_capable;
 	mode_lib->vba.DISPCLKRampingMargin = ip->dispclk_ramp_margin_percent;
 
-	mode_lib->vba.XFCSupported = ip->xfc_supported;
 	mode_lib->vba.XFCFillBWOverhead = ip->xfc_fill_bw_overhead_percent;
 	mode_lib->vba.XFCFillConstant = ip->xfc_fill_constant_bytes;
 	mode_lib->vba.DPPCLKDelaySubtotal = ip->dppclk_delay_subtotal;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
index 518e599d74e2..91562c0d35f2 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
@@ -497,7 +497,6 @@ struct vba_vars_st {
 	unsigned int PTEBufferSizeInRequestsChroma;
 	double DISPCLKRampingMargin;
 	unsigned int MaxInterDCNTileRepeaters;
-	bool XFCSupported;
 	double XFCSlvChunkSize;
 	double XFCFillBWOverhead;
 	double XFCFillConstant;
@@ -1041,13 +1040,6 @@ struct vba_vars_st {
 	unsigned int BlockHeight256BytesC[DC__NUM_DPP__MAX];
 	unsigned int BlockWidth256BytesY[DC__NUM_DPP__MAX];
 	unsigned int BlockWidth256BytesC[DC__NUM_DPP__MAX];
-	double XFCSlaveVUpdateOffset[DC__NUM_DPP__MAX];
-	double XFCSlaveVupdateWidth[DC__NUM_DPP__MAX];
-	double XFCSlaveVReadyOffset[DC__NUM_DPP__MAX];
-	double XFCTransferDelay[DC__NUM_DPP__MAX];
-	double XFCPrechargeDelay[DC__NUM_DPP__MAX];
-	double XFCRemoteSurfaceFlipLatency[DC__NUM_DPP__MAX];
-	double XFCPrefetchMargin[DC__NUM_DPP__MAX];
 	unsigned int dpte_row_width_luma_ub[DC__NUM_DPP__MAX];
 	unsigned int dpte_row_width_chroma_ub[DC__NUM_DPP__MAX];
 	double FullDETBufferingTimeY[DC__NUM_DPP__MAX];                     // WM
-- 
2.37.1

