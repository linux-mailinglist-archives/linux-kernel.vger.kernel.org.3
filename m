Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0FC54ECFE3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 01:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351742AbiC3XE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 19:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233874AbiC3XE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 19:04:26 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A40424A2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 16:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=k76sQjYdwH9GEGR78t+YtjIIfK9JL2ghgf5N0o/++m8=; b=eF5BVQSbeOClgHQ9ke1fW6aWc4
        Da3BcIzGSX+bMYaXm9LhEMGTRFAfhYlRl58JNIsrNZ0i91sWJdp29MgVerHGq7AhV3bH2r5wNwKoN
        nZaW4PJ/QIGDcmWSGuQ5TbAbya278OPBJYCMLHKmMQuLXwGvKtPvQyN2M1e9MvwfHftRLzgig50rP
        4bCYXA/NSHJ0FWT3cUwzGK+4tmLR5WHccGyOevdy7eM5kMgkLvMBUO0NPj4qJzVGACnkMHRAlbT+e
        AfG+BUt1IXR+0ys0IgsnluIQLVBvwrl1qNUB5oCyf13B5/ZqYTutir5XE8Q+kTfD+b1afWEfHzsb9
        AMKwyx5Q==;
Received: from [165.90.126.25] (helo=killbill.home)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1nZhKf-0003nF-42; Thu, 31 Mar 2022 01:02:29 +0200
From:   Melissa Wen <mwen@igalia.com>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Jasdeep Dhillon <jdhillon@amd.com>,
        chandan.vurdigerenataraj@amd.com, Melissa Wen <mwen@igalia.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: protect remaining FPU-code calls on dcn3.1.x
Date:   Wed, 30 Mar 2022 22:02:04 -0100
Message-Id: <20220330230204.2473636-1-mwen@igalia.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From [1], I realized two other calls to dcn30 code are associated with
FPU operations and are not protected by DC_FP_* macros:
* dcn30_populate_dml_writeback_from_context()
* dcn30_set_mcif_arb_params()

So, since FPU-associated code is not fully isolated in dcn30, and
dcn3.1.x reuses them, let's wrap their calls properly.

Note: this patch complements the fix from [1].

[1] https://lore.kernel.org/amd-gfx/20220329082957.1662655-1-chandan.vurdigerenataraj@amd.com/

Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 .../drm/amd/display/dc/dcn31/dcn31_resource.c | 25 +++++++++++++++++--
 .../drm/amd/display/dc/dcn31/dcn31_resource.h |  9 +++++++
 .../amd/display/dc/dcn315/dcn315_resource.c   |  4 +--
 .../amd/display/dc/dcn316/dcn316_resource.c   |  4 +--
 4 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index bf130b2435ab..afdfec74ed08 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -1735,6 +1735,27 @@ void dcn31_calculate_wm_and_dlg(
 	DC_FP_END();
 }
 
+void
+dcn31_populate_dml_writeback_from_context(struct dc *dc,
+					  struct resource_context *res_ctx,
+					  display_e2e_pipe_params_st *pipes)
+{
+	DC_FP_START();
+	dcn30_populate_dml_writeback_from_context(dc, res_ctx, pipes);
+	DC_FP_END();
+}
+
+void
+dcn31_set_mcif_arb_params(struct dc *dc,
+			  struct dc_state *context,
+			  display_e2e_pipe_params_st *pipes,
+			  int pipe_cnt)
+{
+	DC_FP_START();
+	dcn30_set_mcif_arb_params(dc, context, pipes, pipe_cnt);
+	DC_FP_END();
+}
+
 bool dcn31_validate_bandwidth(struct dc *dc,
 		struct dc_state *context,
 		bool fast_validate)
@@ -1806,8 +1827,8 @@ static struct resource_funcs dcn31_res_pool_funcs = {
 	.add_stream_to_ctx = dcn30_add_stream_to_ctx,
 	.add_dsc_to_stream_resource = dcn20_add_dsc_to_stream_resource,
 	.remove_stream_from_ctx = dcn20_remove_stream_from_ctx,
-	.populate_dml_writeback_from_context = dcn30_populate_dml_writeback_from_context,
-	.set_mcif_arb_params = dcn30_set_mcif_arb_params,
+	.populate_dml_writeback_from_context = dcn31_populate_dml_writeback_from_context,
+	.set_mcif_arb_params = dcn31_set_mcif_arb_params,
 	.find_first_free_match_stream_enc_for_link = dcn10_find_first_free_match_stream_enc_for_link,
 	.acquire_post_bldn_3dlut = dcn30_acquire_post_bldn_3dlut,
 	.release_post_bldn_3dlut = dcn30_release_post_bldn_3dlut,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.h b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.h
index 1ce6509c1ed1..393458015d6a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.h
@@ -50,6 +50,15 @@ int dcn31_populate_dml_pipes_from_context(
 	struct dc *dc, struct dc_state *context,
 	display_e2e_pipe_params_st *pipes,
 	bool fast_validate);
+void
+dcn31_populate_dml_writeback_from_context(struct dc *dc,
+					  struct resource_context *res_ctx,
+					  display_e2e_pipe_params_st *pipes);
+void
+dcn31_set_mcif_arb_params(struct dc *dc,
+			  struct dc_state *context,
+			  display_e2e_pipe_params_st *pipes,
+			  int pipe_cnt);
 void dcn31_update_soc_for_wm_a(struct dc *dc, struct dc_state *context);
 
 struct resource_pool *dcn31_create_resource_pool(
diff --git a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
index fadb89326999..06dd064e5997 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
@@ -1726,8 +1726,8 @@ static struct resource_funcs dcn315_res_pool_funcs = {
 	.add_stream_to_ctx = dcn30_add_stream_to_ctx,
 	.add_dsc_to_stream_resource = dcn20_add_dsc_to_stream_resource,
 	.remove_stream_from_ctx = dcn20_remove_stream_from_ctx,
-	.populate_dml_writeback_from_context = dcn30_populate_dml_writeback_from_context,
-	.set_mcif_arb_params = dcn30_set_mcif_arb_params,
+	.populate_dml_writeback_from_context = dcn31_populate_dml_writeback_from_context,
+	.set_mcif_arb_params = dcn31_set_mcif_arb_params,
 	.find_first_free_match_stream_enc_for_link = dcn10_find_first_free_match_stream_enc_for_link,
 	.acquire_post_bldn_3dlut = dcn30_acquire_post_bldn_3dlut,
 	.release_post_bldn_3dlut = dcn30_release_post_bldn_3dlut,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c b/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
index d73145dab173..5db96ab38dd2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
@@ -1728,8 +1728,8 @@ static struct resource_funcs dcn316_res_pool_funcs = {
 	.add_stream_to_ctx = dcn30_add_stream_to_ctx,
 	.add_dsc_to_stream_resource = dcn20_add_dsc_to_stream_resource,
 	.remove_stream_from_ctx = dcn20_remove_stream_from_ctx,
-	.populate_dml_writeback_from_context = dcn30_populate_dml_writeback_from_context,
-	.set_mcif_arb_params = dcn30_set_mcif_arb_params,
+	.populate_dml_writeback_from_context = dcn31_populate_dml_writeback_from_context,
+	.set_mcif_arb_params = dcn31_set_mcif_arb_params,
 	.find_first_free_match_stream_enc_for_link = dcn10_find_first_free_match_stream_enc_for_link,
 	.acquire_post_bldn_3dlut = dcn30_acquire_post_bldn_3dlut,
 	.release_post_bldn_3dlut = dcn30_release_post_bldn_3dlut,
-- 
2.35.1

