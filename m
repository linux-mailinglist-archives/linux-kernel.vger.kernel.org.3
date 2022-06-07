Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B71F5421BC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391660AbiFHAmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 20:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387316AbiFGWuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 18:50:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0B4B82ACB70
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 12:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654630744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J6UCoAjTBIhFULpI3th29L45PAQqa/yX0JAym4+DcxE=;
        b=B8wcz0m7DmpFiP6DYDwYvmccLlkfZdaB4QQQ7yAbIf3Hh7p7H1xvZoT4o+JKusmjDpo8Ya
        HY5bFqn9ojA9kFhTX+xO/hYFtX+doyRiYyVdyXgRv0Cqe8+Them+nwykVjYzil+QigbCBi
        +ay0R0uRzEXl5qEHHdFNaRqUBN+qCKI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-299-en72QhIkMI6WKokoHAimKg-1; Tue, 07 Jun 2022 15:38:59 -0400
X-MC-Unique: en72QhIkMI6WKokoHAimKg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D5269800D91;
        Tue,  7 Jun 2022 19:37:32 +0000 (UTC)
Received: from emerald.redhat.com (unknown [10.22.9.252])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C3AC82C0D502;
        Tue,  7 Jun 2022 19:37:03 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org
Cc:     Wayne Lin <Wayne.Lin@amd.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, Fangzhi Zuo <Jerry.Zuo@amd.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Imre Deak <imre.deak@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [RESEND RFC 16/18] drm/display/dp_mst: Maintain time slot allocations when deleting payloads
Date:   Tue,  7 Jun 2022 15:29:31 -0400
Message-Id: <20220607192933.1333228-17-lyude@redhat.com>
In-Reply-To: <20220607192933.1333228-1-lyude@redhat.com>
References: <20220607192933.1333228-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, we set drm_dp_atomic_payload->time_slots to 0 in order to
indicate that we're about to delete a payload in the current atomic state.
Since we're going to be dropping all of the legacy code for handling the
payload table however, we need to be able to ensure that we still keep
track of the current time slot allocations for each payload so we can reuse
this info when asking the root MST hub to delete payloads. We'll also be
using it to recalculate the start slots of each VC.

So, let's keep track of the intent of a payload in drm_dp_atomic_payload by
adding ->delete, which we set whenever we're planning on deleting a payload
during the current atomic commit.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Wayne Lin <Wayne.Lin@amd.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Fangzhi Zuo <Jerry.Zuo@amd.com>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: Imre Deak <imre.deak@intel.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Sean Paul <sean@poorly.run>
---
 drivers/gpu/drm/display/drm_dp_mst_topology.c | 14 +++++++-------
 include/drm/display/drm_dp_mst_helper.h       |  5 ++++-
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
index 70adb8db4335..10d26a7e028c 100644
--- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
@@ -4410,7 +4410,7 @@ int drm_dp_atomic_find_time_slots(struct drm_atomic_state *state,
 		 * releasing and allocating the same timeslot allocation,
 		 * which is an error
 		 */
-		if (WARN_ON(!prev_slots)) {
+		if (drm_WARN_ON(mgr->dev, payload->delete)) {
 			drm_err(mgr->dev,
 				"cannot allocate and release time slots on [MST PORT:%p] in the same state\n",
 				port);
@@ -4515,10 +4515,10 @@ int drm_dp_atomic_release_time_slots(struct drm_atomic_state *state,
 	}
 
 	drm_dbg_atomic(mgr->dev, "[MST PORT:%p] TU %d -> 0\n", port, payload->time_slots);
-	if (payload->time_slots) {
+	if (!payload->delete) {
 		drm_dp_mst_put_port_malloc(port);
-		payload->time_slots = 0;
 		payload->pbn = 0;
+		payload->delete = true;
 	}
 
 	return 0;
@@ -5234,7 +5234,7 @@ drm_dp_mst_duplicate_state(struct drm_private_obj *obj)
 
 	list_for_each_entry(pos, &old_state->payloads, next) {
 		/* Prune leftover freed timeslot allocations */
-		if (!pos->time_slots)
+		if (pos->delete)
 			continue;
 
 		payload = kmemdup(pos, sizeof(*payload), GFP_KERNEL);
@@ -5266,8 +5266,8 @@ static void drm_dp_mst_destroy_state(struct drm_private_obj *obj,
 	int i;
 
 	list_for_each_entry_safe(pos, tmp, &mst_state->payloads, next) {
-		/* We only keep references to ports with non-zero VCPIs */
-		if (pos->time_slots)
+		/* We only keep references to ports with active payloads */
+		if (!pos->delete)
 			drm_dp_mst_put_port_malloc(pos->port);
 		kfree(pos);
 	}
@@ -5395,7 +5395,7 @@ drm_dp_mst_atomic_check_payload_alloc_limits(struct drm_dp_mst_topology_mgr *mgr
 
 	list_for_each_entry(payload, &mst_state->payloads, next) {
 		/* Releasing payloads is always OK-even if the port is gone */
-		if (!payload->time_slots) {
+		if (payload->delete) {
 			drm_dbg_atomic(mgr->dev, "[MST PORT:%p] releases all time slots\n",
 				       payload->port);
 			continue;
diff --git a/include/drm/display/drm_dp_mst_helper.h b/include/drm/display/drm_dp_mst_helper.h
index 690ebcabb51f..ecd130028337 100644
--- a/include/drm/display/drm_dp_mst_helper.h
+++ b/include/drm/display/drm_dp_mst_helper.h
@@ -555,8 +555,11 @@ struct drm_dp_mst_atomic_payload {
 	int time_slots;
 	/** @pbn: The payload bandwidth for this payload */
 	int pbn;
+
+	/** @delete: Whether or not we intend to delete this payload during this atomic commit */
+	bool delete : 1;
 	/** @dsc_enabled: Whether or not this payload has DSC enabled */
-	bool dsc_enabled;
+	bool dsc_enabled : 1;
 
 	/** @next: The list node for this payload */
 	struct list_head next;
-- 
2.35.3

