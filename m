Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB874E842F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 21:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235262AbiCZU1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 16:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbiCZU1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 16:27:19 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED052127B
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 13:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=d/86E55HMKhsVqOnAQ00yoI1G5UmX3XveaQwPYykNqw=; b=AJ7hxU04sgKC6xecbXApi8iLuZ
        zJedZnUc2FEo2vZCgG5CmZxlZgv6+AM4LdxKmj7LYYFCcvAvHeGJ+aB1dLvZ3XpZ3B5dOKyfiYzAM
        /DCQRJ9QwNFjwLP4lGzhULd8hwisJpx+mC5FbzFiA8eYtg5lQXePK98Qdq/SWmA81L4yGyoDWZYyK
        Jkgm5N9pb/l+fWZfwGrXRkjbEzzoID2AN3Ooz7lHDotgWuPSoNAQyd9HptPPe8Xh1FEt6OEnHtBuE
        9ZBxdi8Pg8NXrxpdKsVc6SBI/aMrUl6QCcYNCpW8+illvMZ6EQ0vy69etWG8o5uWWRdQ+53bTuW/2
        6M89N6qQ==;
Received: from [165.90.126.25] (helo=killbill.home)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1nYCyf-0007e9-56; Sat, 26 Mar 2022 21:25:37 +0100
From:   Melissa Wen <mwen@igalia.com>
To:     amd-gfx@lists.freedesktop.org, harry.wentland@amd.com,
        sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Jasdeep Dhillon <jdhillon@amd.com>,
        Melissa Wen <mwen@igalia.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drm/amd/display: remove DC_FP_* wrapper from dml folder
Date:   Sat, 26 Mar 2022 19:24:48 -0100
Message-Id: <20220326202448.2046077-3-mwen@igalia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220326202448.2046077-1-mwen@igalia.com>
References: <20220326202448.2046077-1-mwen@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URI_NOVOWEL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FPU documentation states that developers must not use DC_FP_START/END
inside dml files, but use this macro to wrap calls to FPU functions in
dc folder (outside dml folder). Therefore, this patch removes DC_FP_*
wrappers from dml folder and wraps calls for these FPU operations
outside dml, as required.

Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c  | 10 ++++++++--
 .../gpu/drm/amd/display/dc/dcn10/dcn10_resource.c  |  2 ++
 .../gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c   | 14 --------------
 .../gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c   |  2 --
 4 files changed, 10 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index c3e141c19a77..6b4d9917933b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -2979,8 +2979,11 @@ void dcn10_prepare_bandwidth(
 			true);
 	dcn10_stereo_hw_frame_pack_wa(dc, context);
 
-	if (dc->debug.pplib_wm_report_mode == WM_REPORT_OVERRIDE)
+	if (dc->debug.pplib_wm_report_mode == WM_REPORT_OVERRIDE) {
+		DC_FP_START();
 		dcn_bw_notify_pplib_of_wm_ranges(dc);
+		DC_FP_END();
+	}
 
 	if (dc->debug.sanity_checks)
 		hws->funcs.verify_allow_pstate_change_high(dc);
@@ -3013,8 +3016,11 @@ void dcn10_optimize_bandwidth(
 
 	dcn10_stereo_hw_frame_pack_wa(dc, context);
 
-	if (dc->debug.pplib_wm_report_mode == WM_REPORT_OVERRIDE)
+	if (dc->debug.pplib_wm_report_mode == WM_REPORT_OVERRIDE) {
+		DC_FP_START();
 		dcn_bw_notify_pplib_of_wm_ranges(dc);
+		DC_FP_END();
+	}
 
 	if (dc->debug.sanity_checks)
 		hws->funcs.verify_allow_pstate_change_high(dc);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
index 1587a060b55a..bca049b2f867 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
@@ -1506,6 +1506,7 @@ static bool dcn10_resource_construct(
 			&& pool->base.pp_smu->rv_funcs.set_pme_wa_enable != NULL)
 		dc->debug.az_endpoint_mute_only = false;
 
+	DC_FP_START();
 	if (!dc->debug.disable_pplib_clock_request)
 		dcn_bw_update_from_pplib(dc);
 	dcn_bw_sync_calcs_and_dml(dc);
@@ -1513,6 +1514,7 @@ static bool dcn10_resource_construct(
 		dc->res_pool = &pool->base;
 		dcn_bw_notify_pplib_of_wm_ranges(dc);
 	}
+	DC_FP_END();
 
 	{
 		struct irq_service_init_data init_data;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c
index c25023f7d604..db3b16b77034 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c
@@ -639,7 +639,6 @@ static bool dcn_bw_apply_registry_override(struct dc *dc)
 {
 	bool updated = false;
 
-	DC_FP_START();
 	if ((int)(dc->dcn_soc->sr_exit_time * 1000) != dc->debug.sr_exit_time_ns
 			&& dc->debug.sr_exit_time_ns) {
 		updated = true;
@@ -675,7 +674,6 @@ static bool dcn_bw_apply_registry_override(struct dc *dc)
 		dc->dcn_soc->dram_clock_change_latency =
 				dc->debug.dram_clock_change_latency_ns / 1000.0;
 	}
-	DC_FP_END();
 
 	return updated;
 }
@@ -1492,8 +1490,6 @@ void dcn_bw_update_from_pplib(struct dc *dc)
 	res = dm_pp_get_clock_levels_by_type_with_voltage(
 			ctx, DM_PP_CLOCK_TYPE_FCLK, &fclks);
 
-	DC_FP_START();
-
 	if (res)
 		res = verify_clock_values(&fclks);
 
@@ -1523,13 +1519,9 @@ void dcn_bw_update_from_pplib(struct dc *dc)
 	} else
 		BREAK_TO_DEBUGGER();
 
-	DC_FP_END();
-
 	res = dm_pp_get_clock_levels_by_type_with_voltage(
 			ctx, DM_PP_CLOCK_TYPE_DCFCLK, &dcfclks);
 
-	DC_FP_START();
-
 	if (res)
 		res = verify_clock_values(&dcfclks);
 
@@ -1540,8 +1532,6 @@ void dcn_bw_update_from_pplib(struct dc *dc)
 		dc->dcn_soc->dcfclkv_max0p9 = dcfclks.data[dcfclks.num_levels - 1].clocks_in_khz / 1000.0;
 	} else
 		BREAK_TO_DEBUGGER();
-
-	DC_FP_END();
 }
 
 void dcn_bw_notify_pplib_of_wm_ranges(struct dc *dc)
@@ -1556,11 +1546,9 @@ void dcn_bw_notify_pplib_of_wm_ranges(struct dc *dc)
 	if (!pp || !pp->set_wm_ranges)
 		return;
 
-	DC_FP_START();
 	min_fclk_khz = dc->dcn_soc->fabric_and_dram_bandwidth_vmin0p65 * 1000000 / 32;
 	min_dcfclk_khz = dc->dcn_soc->dcfclkv_min0p65 * 1000;
 	socclk_khz = dc->dcn_soc->socclk * 1000;
-	DC_FP_END();
 
 	/* Now notify PPLib/SMU about which Watermarks sets they should select
 	 * depending on DPM state they are in. And update BW MGR GFX Engine and
@@ -1611,7 +1599,6 @@ void dcn_bw_notify_pplib_of_wm_ranges(struct dc *dc)
 
 void dcn_bw_sync_calcs_and_dml(struct dc *dc)
 {
-	DC_FP_START();
 	DC_LOG_BANDWIDTH_CALCS("sr_exit_time: %f ns\n"
 			"sr_enter_plus_exit_time: %f ns\n"
 			"urgent_latency: %f ns\n"
@@ -1800,5 +1787,4 @@ void dcn_bw_sync_calcs_and_dml(struct dc *dc)
 	dc->dml.ip.bug_forcing_LC_req_same_size_fixed =
 		dc->dcn_ip->bug_forcing_luma_and_chroma_request_to_same_size_fixed == dcn_bw_yes;
 	dc->dml.ip.dcfclk_cstate_latency = dc->dcn_ip->dcfclk_cstate_latency;
-	DC_FP_END();
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
index 2f6122153bdb..36b12a350bbd 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
@@ -1290,9 +1290,7 @@ int dcn20_populate_dml_pipes_from_context(
 	}
 
 	/* populate writeback information */
-	DC_FP_START();
 	dc->res_pool->funcs->populate_dml_writeback_from_context(dc, res_ctx, pipes);
-	DC_FP_END();
 
 	return pipe_cnt;
 }
-- 
2.35.1

