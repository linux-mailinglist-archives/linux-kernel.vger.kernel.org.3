Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9336A5846BB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 22:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbiG1UFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 16:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiG1UFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 16:05:54 -0400
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE437538D
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 13:05:52 -0700 (PDT)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx0.riseup.net (Postfix) with ESMTPS id 4Lv1qN0QFMz9s1T;
        Thu, 28 Jul 2022 20:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1659038752; bh=hY9tLjRJisjEGHexS8jMj36ynAywqNeh/J5xjFnaB/8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cCjoji+kug6GZ18JcCehH1oidPD9yXpWyngkN0aT8xyM23+L1SlTJfWRofCp3pccE
         vq+1wkmemHYovRXOl+g45EvRcqU4skpLYQ7oUpR3DzO/EUzUEXoQao0MpTcTcE3/Ua
         N4zSfa0tik3YCRNmNkDY6lzB6oLpPQxsLSUAVbrk=
X-Riseup-User-ID: 1A67485038E92336708BDF54891D187F9EE70119AFF35AA0041712BD7B59DCC4
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4Lv1qH02kbz5vW1;
        Thu, 28 Jul 2022 20:05:46 +0000 (UTC)
From:   =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        christian.koenig@amd.com, Xinhui.Pan@amd.com,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     magalilemes00@gmail.com, tales.aparecida@gmail.com,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        mwen@igalia.com, andrealmeid@riseup.net,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
Subject: [PATCH 15/16] drm/amd/display: Remove only mencioned once VBA variables
Date:   Thu, 28 Jul 2022 17:05:41 -0300
Message-Id: <20220728200541.506842-1-mairacanal@riseup.net>
In-Reply-To: <20220728182047.264825-1-mairacanal@riseup.net>
References: <20220728182047.264825-1-mairacanal@riseup.net>
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

The variables PercentOfIdealDRAMBWReceivedAfterUrgLatencySTROBE,
RefreshRate, FECEnable, ScalerRecoutWidth, MaxNumDP2p0Streams, and
MaxNumDP2p0Outputs are only used on assignments, so there values are not
used on code. So, remove the variables entries from the struct
vba_vars_st.

Signed-off-by: Maíra Canal <mairacanal@riseup.net>
---
 .../amd/display/dc/dml/dcn32/display_mode_vba_32.c  |  1 -
 .../gpu/drm/amd/display/dc/dml/display_mode_vba.c   | 13 ++-----------
 .../gpu/drm/amd/display/dc/dml/display_mode_vba.h   |  6 ------
 3 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
index 3c044549c95f..e9c6cc45bfc3 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
@@ -3715,7 +3715,6 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 		}
 
 		mode_lib->vba.DSCEnabled[k] = mode_lib->vba.RequiresDSC[mode_lib->vba.VoltageLevel][k];
-		mode_lib->vba.FECEnable[k] = mode_lib->vba.RequiresFEC[mode_lib->vba.VoltageLevel][k];
 		mode_lib->vba.OutputBpp[k] = mode_lib->vba.OutputBppPerState[mode_lib->vba.VoltageLevel][k];
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
index 7a4a013f195a..1176a73813aa 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
@@ -340,7 +340,6 @@ static void fetch_socbb_params(struct display_mode_lib *mode_lib)
 	mode_lib->vba.SMNLatency = soc->smn_latency_us;
 	mode_lib->vba.MALLAllocatedForDCNFinal = soc->mall_allocated_for_dcn_mbytes;
 
-	mode_lib->vba.PercentOfIdealDRAMBWReceivedAfterUrgLatencySTROBE = soc->pct_ideal_dram_bw_after_urgent_strobe;
 	mode_lib->vba.MaxAveragePercentOfIdealFabricBWDisplayCanUseInNormalSystemOperation =
 			soc->max_avg_fabric_bw_use_normal_percent;
 	mode_lib->vba.MaxAveragePercentOfIdealDRAMBWDisplayCanUseInNormalSystemOperationSTROBE =
@@ -441,11 +440,9 @@ static void fetch_ip_params(struct display_mode_lib *mode_lib)
 	mode_lib->vba.CompbufReservedSpaceZs = ip->compbuf_reserved_space_zs;
 	mode_lib->vba.CompressedBufferSegmentSizeInkByteFinal = ip->compressed_buffer_segment_size_in_kbytes;
 	mode_lib->vba.LineBufferSizeFinal = ip->line_buffer_size_bits;
-	mode_lib->vba.AlphaPixelChunkSizeInKByte = ip->alpha_pixel_chunk_size_kbytes; // not ysed
-	mode_lib->vba.MinPixelChunkSizeBytes = ip->min_pixel_chunk_size_bytes; // not used
+	mode_lib->vba.AlphaPixelChunkSizeInKByte = ip->alpha_pixel_chunk_size_kbytes;
+	mode_lib->vba.MinPixelChunkSizeBytes = ip->min_pixel_chunk_size_bytes;
 	mode_lib->vba.MaximumPixelsPerLinePerDSCUnit = ip->maximum_pixels_per_line_per_dsc_unit;
-	mode_lib->vba.MaxNumDP2p0Outputs = ip->max_num_dp2p0_outputs;
-	mode_lib->vba.MaxNumDP2p0Streams = ip->max_num_dp2p0_streams;
 	mode_lib->vba.DCCMetaBufferSizeBytes = ip->dcc_meta_buffer_size_bytes;
 
 	mode_lib->vba.PixelChunkSizeInKByte = ip->pixel_chunk_size_kbytes;
@@ -560,7 +557,6 @@ static void fetch_pipe_params(struct display_mode_lib *mode_lib)
 		mode_lib->vba.UsesMALLForPStateChange[mode_lib->vba.NumberOfActivePlanes] = src->use_mall_for_pstate_change;
 		mode_lib->vba.UseMALLForStaticScreen[mode_lib->vba.NumberOfActivePlanes] = src->use_mall_for_static_screen;
 		mode_lib->vba.GPUVMMinPageSizeKBytes[mode_lib->vba.NumberOfActivePlanes] = src->gpuvm_min_page_size_kbytes;
-		mode_lib->vba.RefreshRate[mode_lib->vba.NumberOfActivePlanes] = dst->refresh_rate; //todo remove this
 		mode_lib->vba.OutputLinkDPRate[mode_lib->vba.NumberOfActivePlanes] = dout->dp_rate;
 		mode_lib->vba.ODMUse[mode_lib->vba.NumberOfActivePlanes] = dst->odm_combine_policy;
 		mode_lib->vba.DETSizeOverride[mode_lib->vba.NumberOfActivePlanes] = src->det_size_override;
@@ -606,8 +602,6 @@ static void fetch_pipe_params(struct display_mode_lib *mode_lib)
 		mode_lib->vba.VActive[mode_lib->vba.NumberOfActivePlanes] = dst->vactive;
 		mode_lib->vba.SurfaceTiling[mode_lib->vba.NumberOfActivePlanes] =
 				(enum dm_swizzle_mode) (src->sw_mode);
-		mode_lib->vba.ScalerRecoutWidth[mode_lib->vba.NumberOfActivePlanes] =
-				dst->recout_width; // TODO: or should this be full_recout_width???...maybe only when in hsplit mode?
 		mode_lib->vba.ODMCombineEnabled[mode_lib->vba.NumberOfActivePlanes] =
 				dst->odm_combine;
 		mode_lib->vba.OutputFormat[mode_lib->vba.NumberOfActivePlanes] =
@@ -770,7 +764,6 @@ static void fetch_pipe_params(struct display_mode_lib *mode_lib)
 		if (src->is_hsplit) {
 			for (k = j + 1; k < mode_lib->vba.cache_num_pipes; ++k) {
 				display_pipe_source_params_st *src_k = &pipes[k].pipe.src;
-				display_pipe_dest_params_st *dst_k = &pipes[k].pipe.dest;
 
 				if (src_k->is_hsplit && !visited[k]
 						&& src->hsplit_grp == src_k->hsplit_grp) {
@@ -783,8 +776,6 @@ static void fetch_pipe_params(struct display_mode_lib *mode_lib)
 								src_k->viewport_width;
 						mode_lib->vba.ViewportWidthChroma[mode_lib->vba.NumberOfActivePlanes] +=
 								src_k->viewport_width_c;
-						mode_lib->vba.ScalerRecoutWidth[mode_lib->vba.NumberOfActivePlanes] +=
-								dst_k->recout_width;
 					} else {
 						mode_lib->vba.ViewportHeight[mode_lib->vba.NumberOfActivePlanes] +=
 								src_k->viewport_height;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
index a07e97035dd1..5eaedc3bf2c8 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
@@ -437,7 +437,6 @@ struct vba_vars_st {
 	unsigned int MALLAllocatedForDCNFinal;
 	double MaxAveragePercentOfIdealFabricBWDisplayCanUseInNormalSystemOperation;
 	double MaxAveragePercentOfIdealDRAMBWDisplayCanUseInNormalSystemOperationSTROBE;
-	double PercentOfIdealDRAMBWReceivedAfterUrgLatencySTROBE;
 	double WritebackLatency;
 	double PercentOfIdealDRAMFabricAndSDPPortBWReceivedAfterUrgLatencyPixelDataOnly; // Mode Support
 	double PercentOfIdealDRAMFabricAndSDPPortBWReceivedAfterUrgLatencyPixelMixedWithVMData; // Mode Support
@@ -528,7 +527,6 @@ struct vba_vars_st {
 	unsigned int MinCompressedBufferSizeInKByte;
 	unsigned int NumberOfActiveSurfaces;
 	bool ViewportStationary[DC__NUM_DPP__MAX];
-	unsigned int RefreshRate[DC__NUM_DPP__MAX];
 	double       OutputBPP[DC__NUM_DPP__MAX];
 	unsigned int GPUVMMinPageSizeKBytes[DC__NUM_DPP__MAX];
 	bool SynchronizeTimingsFinal;
@@ -564,7 +562,6 @@ struct vba_vars_st {
 	double PixelClock[DC__NUM_DPP__MAX];
 	double PixelClockBackEnd[DC__NUM_DPP__MAX];
 	bool DCCEnable[DC__NUM_DPP__MAX];
-	bool FECEnable[DC__NUM_DPP__MAX];
 	unsigned int DCCMetaPitchY[DC__NUM_DPP__MAX];
 	unsigned int DCCMetaPitchC[DC__NUM_DPP__MAX];
 	enum scan_direction_class SourceScan[DC__NUM_DPP__MAX];
@@ -585,7 +582,6 @@ struct vba_vars_st {
 	unsigned int VActive[DC__NUM_DPP__MAX];
 	bool Interlace[DC__NUM_DPP__MAX];
 	enum dm_swizzle_mode SurfaceTiling[DC__NUM_DPP__MAX];
-	unsigned int ScalerRecoutWidth[DC__NUM_DPP__MAX];
 	bool DynamicMetadataEnable[DC__NUM_DPP__MAX];
 	int DynamicMetadataLinesBeforeActiveRequired[DC__NUM_DPP__MAX];
 	unsigned int DynamicMetadataTransmittedBytes[DC__NUM_DPP__MAX];
@@ -753,8 +749,6 @@ struct vba_vars_st {
 	bool DCCProgrammingAssumesScanDirectionUnknownFinal;
 	bool EnoughWritebackUnits;
 	bool ODMCombine2To1SupportCheckOK[DC__VOLTAGE_STATES];
-	unsigned int MaxNumDP2p0Streams;
-	unsigned int MaxNumDP2p0Outputs;
 	enum dm_output_type OutputTypePerState[DC__VOLTAGE_STATES][DC__NUM_DPP__MAX];
 	enum dm_output_rate OutputRatePerState[DC__VOLTAGE_STATES][DC__NUM_DPP__MAX];
 	double WritebackLineBufferLumaBufferSize;
-- 
2.37.1

