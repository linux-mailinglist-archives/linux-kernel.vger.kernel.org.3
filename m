Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C74245422C0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbiFHBKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 21:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387109AbiFGWt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 18:49:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 68FF92AA01B
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 12:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654630697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q9eWmoOn0yL2VJR9/laRBaD5nmIdVd5BpZuXu5q4cqg=;
        b=Q/+XQw98k6jVVvef9SKN5He6V+UhGJrKk3KaIhoUoFwPP/8GhgNgKl9YJSvVsxWJIN8MPs
        IPkeKJInp5Xa9N2hYZ39jB3HoBPxC7YybtmQGmTZ7FRz3BX5wUfhfR5UIJEkvyceCiYyyA
        aTEof1dedV5NlWtFj9zxgdczc6K+Jm0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-590-3ShpK352MveEqI_lMl0uVg-1; Tue, 07 Jun 2022 15:38:14 -0400
X-MC-Unique: 3ShpK352MveEqI_lMl0uVg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8130C81B549;
        Tue,  7 Jun 2022 19:36:48 +0000 (UTC)
Received: from emerald.redhat.com (unknown [10.22.9.252])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CA4192C0D161;
        Tue,  7 Jun 2022 19:36:19 +0000 (UTC)
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
        linux-kernel@vger.kernel.org (open list)
Subject: [RESEND RFC 14/18] drm/display/dp_mst: Drop all ports from topology on CSNs before queueing link address work
Date:   Tue,  7 Jun 2022 15:29:29 -0400
Message-Id: <20220607192933.1333228-15-lyude@redhat.com>
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

We want to start cutting down on all of the places that we use port
validation, so that ports may be removed from the topology as quickly as
possible to minimize the number of errors we run into as a result of being
out of sync with the current topology status. This isn't a very typical
scenario and I don't think I've ever even run into it - but since the next
commit is going to make some changes to payload updates depending on their
hotplug status I think it's a probably good idea to take precautions.

Let's do this with CSNs by moving some code around so that we only queue
link address probing work at the end of handling all CSNs - allowing us to
make sure we drop as many topology references as we can beforehand.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Wayne Lin <Wayne.Lin@amd.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Fangzhi Zuo <Jerry.Zuo@amd.com>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: Imre Deak <imre.deak@intel.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Sean Paul <sean@poorly.run>
---
 drivers/gpu/drm/display/drm_dp_mst_topology.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
index a775f9437868..dd314586bac3 100644
--- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
@@ -2508,7 +2508,7 @@ drm_dp_mst_handle_link_address_port(struct drm_dp_mst_branch *mstb,
 	return ret;
 }
 
-static void
+static int
 drm_dp_mst_handle_conn_stat(struct drm_dp_mst_branch *mstb,
 			    struct drm_dp_connection_status_notify *conn_stat)
 {
@@ -2521,7 +2521,7 @@ drm_dp_mst_handle_conn_stat(struct drm_dp_mst_branch *mstb,
 
 	port = drm_dp_get_port(mstb, conn_stat->port_number);
 	if (!port)
-		return;
+		return 0;
 
 	if (port->connector) {
 		if (!port->input && conn_stat->input_port) {
@@ -2574,8 +2574,7 @@ drm_dp_mst_handle_conn_stat(struct drm_dp_mst_branch *mstb,
 
 out:
 	drm_dp_mst_topology_put_port(port);
-	if (dowork)
-		queue_work(system_long_wq, &mstb->mgr->work);
+	return dowork;
 }
 
 static struct drm_dp_mst_branch *drm_dp_get_mst_branch_device(struct drm_dp_mst_topology_mgr *mgr,
@@ -4071,7 +4070,7 @@ drm_dp_mst_process_up_req(struct drm_dp_mst_topology_mgr *mgr,
 	struct drm_dp_mst_branch *mstb = NULL;
 	struct drm_dp_sideband_msg_req_body *msg = &up_req->msg;
 	struct drm_dp_sideband_msg_hdr *hdr = &up_req->hdr;
-	bool hotplug = false;
+	bool hotplug = false, dowork = false;
 
 	if (hdr->broadcast) {
 		const u8 *guid = NULL;
@@ -4094,11 +4093,14 @@ drm_dp_mst_process_up_req(struct drm_dp_mst_topology_mgr *mgr,
 
 	/* TODO: Add missing handler for DP_RESOURCE_STATUS_NOTIFY events */
 	if (msg->req_type == DP_CONNECTION_STATUS_NOTIFY) {
-		drm_dp_mst_handle_conn_stat(mstb, &msg->u.conn_stat);
+		dowork = drm_dp_mst_handle_conn_stat(mstb, &msg->u.conn_stat);
 		hotplug = true;
 	}
 
 	drm_dp_mst_topology_put_mstb(mstb);
+
+	if (dowork)
+		queue_work(system_long_wq, &mgr->work);
 	return hotplug;
 }
 
-- 
2.35.3

