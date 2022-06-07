Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA7E5422C6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384244AbiFHBZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 21:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383312AbiFGVxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 17:53:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DB0E512D0B
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 12:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654629083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x0L+WDYL2ErSdyIk/wXgdKER6Al4H5aQXP9OvHKSvcc=;
        b=LbRAcuDgiR/rJ+OIch5svrx3+k+kXmuGSEPInkZz75kEFhsgvLX0U407dTcRxqdBvqWHJo
        UOHdAogO4TBqRgg3jHsa5mrNeC0xuRTQ179ut2ppDfJ8dxXJGsOeDSQTKCyUV36c+tVsZG
        uv9H7PM12QnIs9Nlwf3yPbyCZsx8bhk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-616-MIxpZrunMi6TN_cVveYaAQ-1; Tue, 07 Jun 2022 15:11:16 -0400
X-MC-Unique: MIxpZrunMi6TN_cVveYaAQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AE1183816860;
        Tue,  7 Jun 2022 19:08:34 +0000 (UTC)
Received: from emerald.redhat.com (unknown [10.22.9.252])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 870224126336;
        Tue,  7 Jun 2022 19:07:48 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org
Cc:     Wayne Lin <Wayne.Lin@amd.com>, Fangzhi Zuo <Jerry.Zuo@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Claudio Suarez <cssk@net-c.es>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Roman Li <Roman.Li@amd.com>, Ian Chen <ian.chen@amd.com>,
        Colin Ian King <colin.king@intel.com>,
        Wenjing Liu <wenjing.liu@amd.com>, Jun Lei <Jun.Lei@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Jimmy Kizito <Jimmy.Kizito@amd.com>,
        Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>,
        jinzh <jinzh@github.amd.com>, Alex Hung <alex.hung@amd.com>,
        Eric Yang <Eric.Yang2@amd.com>,
        Michael Strauss <michael.strauss@amd.com>,
        "Shen, George" <George.Shen@amd.com>,
        "Leo (Hanghong) Ma" <hanghong.ma@amd.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [RFC 01/18] drm/amdgpu/dc/mst: Rename dp_mst_stream_allocation(_table)
Date:   Tue,  7 Jun 2022 15:06:58 -0400
Message-Id: <20220607190715.1331124-2-lyude@redhat.com>
In-Reply-To: <20220607190715.1331124-1-lyude@redhat.com>
References: <20220607190715.1331124-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just to make this more clear to outside contributors that these are
DC-specific structs, as this also threw me into a loop a number of times
before I figured out the purpose of this.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Wayne Lin <Wayne.Lin@amd.com>
Cc: Fangzhi Zuo <Jerry.Zuo@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  9 ++++-----
 drivers/gpu/drm/amd/display/dc/core/dc_link.c         | 10 +++++-----
 drivers/gpu/drm/amd/display/dc/dm_helpers.h           |  4 ++--
 .../gpu/drm/amd/display/include/link_service_types.h  | 11 ++++++++---
 4 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 7c799ddc1d27..1bd70d306c22 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -153,9 +153,8 @@ enum dc_edid_status dm_helpers_parse_edid_caps(
 	return result;
 }
 
-static void get_payload_table(
-		struct amdgpu_dm_connector *aconnector,
-		struct dp_mst_stream_allocation_table *proposed_table)
+static void get_payload_table(struct amdgpu_dm_connector *aconnector,
+			      struct dc_dp_mst_stream_allocation_table *proposed_table)
 {
 	int i;
 	struct drm_dp_mst_topology_mgr *mst_mgr =
@@ -177,7 +176,7 @@ static void get_payload_table(
 			mst_mgr->payloads[i].payload_state ==
 					DP_PAYLOAD_REMOTE) {
 
-			struct dp_mst_stream_allocation *sa =
+			struct dc_dp_mst_stream_allocation *sa =
 					&proposed_table->stream_allocations[
 						proposed_table->stream_count];
 
@@ -201,7 +200,7 @@ void dm_helpers_dp_update_branch_info(
 bool dm_helpers_dp_mst_write_payload_allocation_table(
 		struct dc_context *ctx,
 		const struct dc_stream_state *stream,
-		struct dp_mst_stream_allocation_table *proposed_table,
+		struct dc_dp_mst_stream_allocation_table *proposed_table,
 		bool enable)
 {
 	struct amdgpu_dm_connector *aconnector;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index a789ea8af27f..db0f5158a0c2 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3424,7 +3424,7 @@ static void update_mst_stream_alloc_table(
 	struct dc_link *link,
 	struct stream_encoder *stream_enc,
 	struct hpo_dp_stream_encoder *hpo_dp_stream_enc, // TODO: Rename stream_enc to dio_stream_enc?
-	const struct dp_mst_stream_allocation_table *proposed_table)
+	const struct dc_dp_mst_stream_allocation_table *proposed_table)
 {
 	struct link_mst_stream_allocation work_table[MAX_CONTROLLER_NUM] = { 0 };
 	struct link_mst_stream_allocation *dc_alloc;
@@ -3586,7 +3586,7 @@ enum dc_status dc_link_allocate_mst_payload(struct pipe_ctx *pipe_ctx)
 {
 	struct dc_stream_state *stream = pipe_ctx->stream;
 	struct dc_link *link = stream->link;
-	struct dp_mst_stream_allocation_table proposed_table = {0};
+	struct dc_dp_mst_stream_allocation_table proposed_table = {0};
 	struct fixed31_32 avg_time_slots_per_mtp;
 	struct fixed31_32 pbn;
 	struct fixed31_32 pbn_per_slot;
@@ -3691,7 +3691,7 @@ enum dc_status dc_link_reduce_mst_payload(struct pipe_ctx *pipe_ctx, uint32_t bw
 	struct fixed31_32 avg_time_slots_per_mtp;
 	struct fixed31_32 pbn;
 	struct fixed31_32 pbn_per_slot;
-	struct dp_mst_stream_allocation_table proposed_table = {0};
+	struct dc_dp_mst_stream_allocation_table proposed_table = {0};
 	uint8_t i;
 	enum act_return_status ret;
 	const struct link_hwss *link_hwss = get_link_hwss(link, &pipe_ctx->link_res);
@@ -3779,7 +3779,7 @@ enum dc_status dc_link_increase_mst_payload(struct pipe_ctx *pipe_ctx, uint32_t
 	struct fixed31_32 pbn;
 	struct fixed31_32 pbn_per_slot;
 	struct link_encoder *link_encoder = link->link_enc;
-	struct dp_mst_stream_allocation_table proposed_table = {0};
+	struct dc_dp_mst_stream_allocation_table proposed_table = {0};
 	uint8_t i;
 	enum act_return_status ret;
 	const struct link_hwss *link_hwss = get_link_hwss(link, &pipe_ctx->link_res);
@@ -3855,7 +3855,7 @@ static enum dc_status deallocate_mst_payload(struct pipe_ctx *pipe_ctx)
 {
 	struct dc_stream_state *stream = pipe_ctx->stream;
 	struct dc_link *link = stream->link;
-	struct dp_mst_stream_allocation_table proposed_table = {0};
+	struct dc_dp_mst_stream_allocation_table proposed_table = {0};
 	struct fixed31_32 avg_time_slots_per_mtp = dc_fixpt_from_int(0);
 	int i;
 	bool mst_mode = (link->type == dc_connection_mst_branch);
diff --git a/drivers/gpu/drm/amd/display/dc/dm_helpers.h b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
index fb6a2d7b6470..8173f4b80424 100644
--- a/drivers/gpu/drm/amd/display/dc/dm_helpers.h
+++ b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
@@ -33,7 +33,7 @@
 #include "dc_types.h"
 #include "dc.h"
 
-struct dp_mst_stream_allocation_table;
+struct dc_dp_mst_stream_allocation_table;
 struct aux_payload;
 enum aux_return_code_type;
 
@@ -77,7 +77,7 @@ void dm_helpers_dp_update_branch_info(
 bool dm_helpers_dp_mst_write_payload_allocation_table(
 		struct dc_context *ctx,
 		const struct dc_stream_state *stream,
-		struct dp_mst_stream_allocation_table *proposed_table,
+		struct dc_dp_mst_stream_allocation_table *proposed_table,
 		bool enable);
 
 /*
diff --git a/drivers/gpu/drm/amd/display/include/link_service_types.h b/drivers/gpu/drm/amd/display/include/link_service_types.h
index 447a56286dd0..91bffc5bf52c 100644
--- a/drivers/gpu/drm/amd/display/include/link_service_types.h
+++ b/drivers/gpu/drm/amd/display/include/link_service_types.h
@@ -245,8 +245,13 @@ union dpcd_training_lane_set {
 };
 
 
+/* AMD's copy of various payload data for MST. We have two copies of the payload table (one in DRM,
+ * one in DC) since DRM's MST helpers can't be accessed here. This stream allocation table should
+ * _ONLY_ be filled out from DM and then passed to DC, do NOT use these for _any_ kind of atomic
+ * state calculations in DM, or you will break something.
+ */
 /* DP MST stream allocation (payload bandwidth number) */
-struct dp_mst_stream_allocation {
+struct dc_dp_mst_stream_allocation {
 	uint8_t vcp_id;
 	/* number of slots required for the DP stream in
 	 * transport packet */
@@ -254,11 +259,11 @@ struct dp_mst_stream_allocation {
 };
 
 /* DP MST stream allocation table */
-struct dp_mst_stream_allocation_table {
+struct dc_dp_mst_stream_allocation_table {
 	/* number of DP video streams */
 	int stream_count;
 	/* array of stream allocations */
-	struct dp_mst_stream_allocation stream_allocations[MAX_CONTROLLER_NUM];
+	struct dc_dp_mst_stream_allocation stream_allocations[MAX_CONTROLLER_NUM];
 };
 
 #endif /*__DAL_LINK_SERVICE_TYPES_H__*/
-- 
2.35.3

