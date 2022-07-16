Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC736577146
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 21:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiGPTwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 15:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiGPTwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 15:52:33 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A457117073
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 12:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=6ppoxgdipskmmbW5jBQLibvHxWKVt7t/b+tu2ackF68=; b=JojGInDTU8Kz2yjwVlXOw9Vk/v
        Yig/L9s04sffB8MI0oyjtD+QmyeKUehMumRKeAg4P1zYD3kEbBCQdB7IPKCpsB5FYnhmwkvYb3YbQ
        0d9lnytUjUC8FxlpjQlDRs5wr9Ny1g459ncScbi9pCa5L/CNnxGRWFlAeuy/ACqr3vVZbPM6+tGAm
        KiXJglgq75FjYuvSTx0DtZj9zAwSvOydUKlRSOsIinvGr5kU1PObtkapIjeqmm83TvheIVMBHV+SA
        YRusFDvkAhP8lZ6A8l2x6Vlq6Oog22J4dBqqTRV+eDsVLAMsND73XjxF7lgml2MEL0QxNfAGt16pI
        dFDfnBjg==;
Received: from [165.90.126.25] (helo=killbill.home)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1oCnpt-001zN4-32; Sat, 16 Jul 2022 21:52:21 +0200
From:   Melissa Wen <mwen@igalia.com>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     kernel-dev@igalia.com, Melissa Wen <mwen@igalia.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: move dcn31_update_soc_for_wm_a func to dml fpu folder
Date:   Sat, 16 Jul 2022 18:51:44 -0100
Message-Id: <20220716195144.342960-1-mwen@igalia.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although dcn31_update_soc_for_wm_a() is only called in dml/dcn31/dcn31_fpu by
dc->res_pool->funcs->update_soc_for_wm_a(dc, context), it's declared in
dcn31_resource that is not FPU protected. Move this function to dcn31_fpu
file as part of the work to isolate FPU code.

Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c | 9 ---------
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.h | 1 -
 drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c  | 9 +++++++++
 drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.h  | 2 ++
 4 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index 16bbccc69fdc..17c776e88514 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -1716,15 +1716,6 @@ int dcn31_populate_dml_pipes_from_context(
 	return pipe_cnt;
 }
 
-void dcn31_update_soc_for_wm_a(struct dc *dc, struct dc_state *context)
-{
-	if (dc->clk_mgr->bw_params->wm_table.entries[WM_A].valid) {
-		context->bw_ctx.dml.soc.dram_clock_change_latency_us = dc->clk_mgr->bw_params->wm_table.entries[WM_A].pstate_latency_us;
-		context->bw_ctx.dml.soc.sr_enter_plus_exit_time_us = dc->clk_mgr->bw_params->wm_table.entries[WM_A].sr_enter_plus_exit_time_us;
-		context->bw_ctx.dml.soc.sr_exit_time_us = dc->clk_mgr->bw_params->wm_table.entries[WM_A].sr_exit_time_us;
-	}
-}
-
 void dcn31_calculate_wm_and_dlg(
 		struct dc *dc, struct dc_state *context,
 		display_e2e_pipe_params_st *pipes,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.h b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.h
index 393458015d6a..41f8ec99da6b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.h
@@ -59,7 +59,6 @@ dcn31_set_mcif_arb_params(struct dc *dc,
 			  struct dc_state *context,
 			  display_e2e_pipe_params_st *pipes,
 			  int pipe_cnt);
-void dcn31_update_soc_for_wm_a(struct dc *dc, struct dc_state *context);
 
 struct resource_pool *dcn31_create_resource_pool(
 		const struct dc_init_data *init_data,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
index 7be3476989ce..facac3daeaca 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
@@ -435,6 +435,15 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_16_soc = {
 	.urgent_latency_adjustment_fabric_clock_reference_mhz = 0,
 };
 
+void dcn31_update_soc_for_wm_a(struct dc *dc, struct dc_state *context)
+{
+	if (dc->clk_mgr->bw_params->wm_table.entries[WM_A].valid) {
+		context->bw_ctx.dml.soc.dram_clock_change_latency_us = dc->clk_mgr->bw_params->wm_table.entries[WM_A].pstate_latency_us;
+		context->bw_ctx.dml.soc.sr_enter_plus_exit_time_us = dc->clk_mgr->bw_params->wm_table.entries[WM_A].sr_enter_plus_exit_time_us;
+		context->bw_ctx.dml.soc.sr_exit_time_us = dc->clk_mgr->bw_params->wm_table.entries[WM_A].sr_exit_time_us;
+	}
+}
+
 void dcn31_calculate_wm_and_dlg_fp(
 		struct dc *dc, struct dc_state *context,
 		display_e2e_pipe_params_st *pipes,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.h b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.h
index 24ac19c83687..0a10de80c1a4 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.h
@@ -31,6 +31,8 @@
 #define DCN3_15_MIN_COMPBUF_SIZE_KB 128
 #define DCN3_16_DEFAULT_DET_SIZE 192
 
+void dcn31_update_soc_for_wm_a(struct dc *dc, struct dc_state *context);
+
 void dcn31_calculate_wm_and_dlg_fp(
 		struct dc *dc, struct dc_state *context,
 		display_e2e_pipe_params_st *pipes,
-- 
2.35.1

