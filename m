Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0CC558D0BB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 01:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244665AbiHHX4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 19:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244511AbiHHXzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 19:55:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E3A681CFCC
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 16:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660002897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yFuI9l5h91DZudC/kp5qPp1NJKZ67KzBNjAbMhUbReQ=;
        b=RtuGqa6+wEmtVPKDSgPUYztndXXkCZiFVac8CBCVs99pS8Yqzyt8gsYlOtJ+7QmgA9OJIJ
        /e9GYAcnjsIUvF3EegMEx/zjV3L6GUFB4R4UbJgo+94ywGBZaGiQ00fPeU5VzoYnFSAdBe
        l1Gobh27PHaAtx05XPPEU7thQbmdf4o=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-517-jO9EHuizMSGdFeXprMRd3A-1; Mon, 08 Aug 2022 19:54:50 -0400
X-MC-Unique: jO9EHuizMSGdFeXprMRd3A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 92E901C05AA3;
        Mon,  8 Aug 2022 23:54:49 +0000 (UTC)
Received: from emerald.lyude.net (unknown [10.22.17.154])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F0B5CC15BA1;
        Mon,  8 Aug 2022 23:54:48 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
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
        linux-kernel@vger.kernel.org (open list)
Subject: [RFC v2 10/18] drm/display/dp_mst: Fix modeset tracking in drm_dp_atomic_release_vcpi_slots()
Date:   Mon,  8 Aug 2022 19:51:55 -0400
Message-Id: <20220808235203.123892-11-lyude@redhat.com>
In-Reply-To: <20220808235203.123892-1-lyude@redhat.com>
References: <20220808235203.123892-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently with the MST helpers we avoid releasing payloads _and_ avoid
pulling in the MST state if there aren't any actual payload changes. While
we want to keep the first step, we need to now make sure that we're always
pulling in the MST state on all modesets that can modify payloads - even if
the resulting payloads in the atomic state are identical to the previous
ones.

This is mainly to make it so that if a CRTC is still assigned to a
connector but is set to DPMS off, the CRTC still holds it's payload
allocation in the atomic state and still appropriately pulls in the MST
state for commit tracking. Otherwise, we'll occasionally forget to update
MST payloads from changes caused by non-atomic DPMS changes. Doing this
also allows us to track bandwidth limitations in a state correctly even
between DPMS changes, so that there's no chance of a simple ->active change
being rejected by the atomic check.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Wayne Lin <Wayne.Lin@amd.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Fangzhi Zuo <Jerry.Zuo@amd.com>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: Imre Deak <imre.deak@intel.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Sean Paul <sean@poorly.run>
Acked-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/gpu/drm/display/drm_dp_mst_topology.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
index aa6dcd9ff6a5..2f7c43f88d74 100644
--- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
@@ -4474,6 +4474,7 @@ int drm_dp_atomic_release_time_slots(struct drm_atomic_state *state,
 	struct drm_dp_mst_topology_state *topology_state;
 	struct drm_dp_mst_atomic_payload *payload;
 	struct drm_connector_state *old_conn_state, *new_conn_state;
+	bool update_payload = true;
 
 	old_conn_state = drm_atomic_get_old_connector_state(state, port->connector);
 	if (!old_conn_state->crtc)
@@ -4485,10 +4486,12 @@ int drm_dp_atomic_release_time_slots(struct drm_atomic_state *state,
 		struct drm_crtc_state *crtc_state =
 			drm_atomic_get_new_crtc_state(state, new_conn_state->crtc);
 
-		if (!crtc_state ||
-		    !drm_atomic_crtc_needs_modeset(crtc_state) ||
-		    crtc_state->enable)
+		/* No modeset means no payload changes, so it's safe to not pull in the MST state */
+		if (!crtc_state || !drm_atomic_crtc_needs_modeset(crtc_state))
 			return 0;
+
+		if (!crtc_state->mode_changed && !crtc_state->connectors_changed)
+			update_payload = false;
 	}
 
 	topology_state = drm_atomic_get_mst_topology_state(state, mgr);
@@ -4496,6 +4499,8 @@ int drm_dp_atomic_release_time_slots(struct drm_atomic_state *state,
 		return PTR_ERR(topology_state);
 
 	topology_state->pending_crtc_mask |= drm_crtc_mask(old_conn_state->crtc);
+	if (!update_payload)
+		return 0;
 
 	payload = drm_atomic_get_mst_payload_state(topology_state, port);
 	if (WARN_ON(!payload)) {
-- 
2.37.1

