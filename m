Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B335424BA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386005AbiFHB0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 21:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387222AbiFGWuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 18:50:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7309D2AA9BB
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 12:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654630718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hsx3oAqr1YyiMu9WVK+sac9BkEiiKmmsbAsRI+A9Kzg=;
        b=FPUJ0/jbcmj/ke3ZmqcT6w7z8BfTj37xgLZulmWs1p1YE+wWTlwdsEDXbMoWa71N1mJAlP
        n3fJLRuXw/aDaX7JdzrgtDYGge0W/f/96JT98Z25CViJL/qOcTfP9Bo20dL0PL/iNj93DB
        /PVieyrevXgxfTWQLoPpLH973kif1TU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-609-CvDC0OMKN9ywaW1RYumngA-1; Tue, 07 Jun 2022 15:38:34 -0400
X-MC-Unique: CvDC0OMKN9ywaW1RYumngA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DC6A7857A82;
        Tue,  7 Jun 2022 19:37:07 +0000 (UTC)
Received: from emerald.redhat.com (unknown [10.22.9.252])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9D7BB2D15284;
        Tue,  7 Jun 2022 19:36:38 +0000 (UTC)
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
Subject: [RESEND RFC 15/18] drm/display/dp_mst: Skip releasing payloads if last connected port isn't connected
Date:   Tue,  7 Jun 2022 15:29:30 -0400
Message-Id: <20220607192933.1333228-16-lyude@redhat.com>
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

In the past, we've ran into strange issues regarding errors in response to
trying to destroy payloads after a port has been unplugged. We fixed this
back in:

This is intended to replace the workaround that was added here:

commit 3769e4c0af5b ("drm/dp_mst: Avoid to mess up payload table by ports in stale topology")

which was intended fix to some of the payload leaks that were observed
before, where we would attempt to determine if the port was still connected
to the topology before updating payloads using
drm_dp_mst_port_downstream_of_branch. This wasn't a particularly good
solution, since one of the points of still having port and mstb validation
is to avoid sending messages to newly disconnected branches wherever
possible - thus the required use of drm_dp_mst_port_downstream_of_branch
would indicate something may be wrong with said validation.

It seems like it may have just been races and luck that made
drm_dp_mst_port_downstream_of_branch work however, as while I was trying to
figure out the true cause of this issue when removing the legacy MST code -
I discovered an important excerpt in section 2.14.2.3.3.6 of the DP 2.0
specs:

"BAD_PARAM - This reply is transmitted when a Message Transaction parameter
is in error; for example, the next port number is invalid or /no device is
connected/ to the port associated with the port number."

Sure enough - removing the calls to drm_dp_mst_port_downstream_of_branch()
and instead checking the ->ddps field of the parent port to see whether we
should release a given payload or not seems to totally fix the issue. This
does actually make sense to me, as it seems the implication is that given a
topology where an MSTB is removed, the payload for the MST parent's port
will be released automatically if that port is also marked as disconnected.
However, if there's another parent in the chain after that which is
connected - payloads must be released there with an ALLOCATE_PAYLOAD
message.

So, let's do that!

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Wayne Lin <Wayne.Lin@amd.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Fangzhi Zuo <Jerry.Zuo@amd.com>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: Imre Deak <imre.deak@intel.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Sean Paul <sean@poorly.run>
---
 drivers/gpu/drm/display/drm_dp_mst_topology.c | 51 +++++++------------
 1 file changed, 17 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
index dd314586bac3..70adb8db4335 100644
--- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
@@ -3137,7 +3137,7 @@ static struct drm_dp_mst_port *drm_dp_get_last_connected_port_to_mstb(struct drm
 static struct drm_dp_mst_branch *
 drm_dp_get_last_connected_port_and_mstb(struct drm_dp_mst_topology_mgr *mgr,
 					struct drm_dp_mst_branch *mstb,
-					int *port_num)
+					struct drm_dp_mst_port **last_port)
 {
 	struct drm_dp_mst_branch *rmstb = NULL;
 	struct drm_dp_mst_port *found_port;
@@ -3153,7 +3153,8 @@ drm_dp_get_last_connected_port_and_mstb(struct drm_dp_mst_topology_mgr *mgr,
 
 		if (drm_dp_mst_topology_try_get_mstb(found_port->parent)) {
 			rmstb = found_port->parent;
-			*port_num = found_port->port_num;
+			*last_port = found_port;
+			drm_dp_mst_get_port_malloc(found_port);
 		} else {
 			/* Search again, starting from this parent */
 			mstb = found_port->parent;
@@ -3170,7 +3171,7 @@ static int drm_dp_payload_send_msg(struct drm_dp_mst_topology_mgr *mgr,
 				   int pbn)
 {
 	struct drm_dp_sideband_msg_tx *txmsg;
-	struct drm_dp_mst_branch *mstb;
+	struct drm_dp_mst_branch *mstb = NULL;
 	int ret, port_num;
 	u8 sinks[DRM_DP_MAX_SDP_STREAMS];
 	int i;
@@ -3178,12 +3179,22 @@ static int drm_dp_payload_send_msg(struct drm_dp_mst_topology_mgr *mgr,
 	port_num = port->port_num;
 	mstb = drm_dp_mst_topology_get_mstb_validated(mgr, port->parent);
 	if (!mstb) {
-		mstb = drm_dp_get_last_connected_port_and_mstb(mgr,
-							       port->parent,
-							       &port_num);
+		struct drm_dp_mst_port *rport = NULL;
+		bool ddps;
 
+		mstb = drm_dp_get_last_connected_port_and_mstb(mgr, port->parent, &rport);
 		if (!mstb)
 			return -EINVAL;
+
+		ddps = rport->ddps;
+		port_num = rport->port_num;
+		drm_dp_mst_put_port_malloc(rport);
+
+		/* If the port is currently marked as disconnected, don't send a payload message */
+		if (!ddps) {
+			ret = -EINVAL;
+			goto fail_put;
+		}
 	}
 
 	txmsg = kzalloc(sizeof(*txmsg), GFP_KERNEL);
@@ -3384,7 +3395,6 @@ int drm_dp_update_payload_part1(struct drm_dp_mst_topology_mgr *mgr, int start_s
 	struct drm_dp_mst_port *port;
 	int i, j;
 	int cur_slots = start_slot;
-	bool skip;
 
 	mutex_lock(&mgr->payload_lock);
 	for (i = 0; i < mgr->max_payloads; i++) {
@@ -3399,16 +3409,6 @@ int drm_dp_update_payload_part1(struct drm_dp_mst_topology_mgr *mgr, int start_s
 			port = container_of(vcpi, struct drm_dp_mst_port,
 					    vcpi);
 
-			mutex_lock(&mgr->lock);
-			skip = !drm_dp_mst_port_downstream_of_branch(port, mgr->mst_primary);
-			mutex_unlock(&mgr->lock);
-
-			if (skip) {
-				drm_dbg_kms(mgr->dev,
-					    "Virtual channel %d is not in current topology\n",
-					    i);
-				continue;
-			}
 			/* Validated ports don't matter if we're releasing
 			 * VCPI
 			 */
@@ -3509,7 +3509,6 @@ int drm_dp_update_payload_part2(struct drm_dp_mst_topology_mgr *mgr)
 	struct drm_dp_mst_port *port;
 	int i;
 	int ret = 0;
-	bool skip;
 
 	mutex_lock(&mgr->payload_lock);
 	for (i = 0; i < mgr->max_payloads; i++) {
@@ -3519,13 +3518,6 @@ int drm_dp_update_payload_part2(struct drm_dp_mst_topology_mgr *mgr)
 
 		port = container_of(mgr->proposed_vcpis[i], struct drm_dp_mst_port, vcpi);
 
-		mutex_lock(&mgr->lock);
-		skip = !drm_dp_mst_port_downstream_of_branch(port, mgr->mst_primary);
-		mutex_unlock(&mgr->lock);
-
-		if (skip)
-			continue;
-
 		drm_dbg_kms(mgr->dev, "payload %d %d\n", i, mgr->payloads[i].payload_state);
 		if (mgr->payloads[i].payload_state == DP_PAYLOAD_LOCAL) {
 			ret = drm_dp_create_payload_step2(mgr, port, mgr->proposed_vcpis[i]->vcpi, &mgr->payloads[i]);
@@ -4780,18 +4772,9 @@ EXPORT_SYMBOL(drm_dp_mst_reset_vcpi_slots);
 void drm_dp_mst_deallocate_vcpi(struct drm_dp_mst_topology_mgr *mgr,
 				struct drm_dp_mst_port *port)
 {
-	bool skip;
-
 	if (!port->vcpi.vcpi)
 		return;
 
-	mutex_lock(&mgr->lock);
-	skip = !drm_dp_mst_port_downstream_of_branch(port, mgr->mst_primary);
-	mutex_unlock(&mgr->lock);
-
-	if (skip)
-		return;
-
 	drm_dp_mst_put_payload_id(mgr, port->vcpi.vcpi);
 	port->vcpi.num_slots = 0;
 	port->vcpi.pbn = 0;
-- 
2.35.3

