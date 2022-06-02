Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDBDA53BF8A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 22:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237886AbiFBUSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 16:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238051AbiFBUST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 16:18:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 21E18EB1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 13:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654201097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AeiolL2bTO529ilMOcovMOAtIExzOmMLAEaBQmNVSso=;
        b=buILzPW4tuECVMzuhoxvx2ARTLHt7/r/Rur4oZuBz1LWPoJIBjoWXzhb8lAdFco5I41vFe
        jiHkWNpWaD5iabbo4dQsHKMKhzs+4wcPB1XfrbnaDQfIsee1xEVnzmGMIisPByKJugybtD
        Uz4WZEVj8NNejBRrh23L5Df2iIsOGHY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-278-c_gSzuF1NuGdLjrjELcKoQ-1; Thu, 02 Jun 2022 16:18:14 -0400
X-MC-Unique: c_gSzuF1NuGdLjrjELcKoQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E1E6610726B8;
        Thu,  2 Jun 2022 20:18:09 +0000 (UTC)
Received: from emerald.redhat.com (unknown [10.22.34.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BD6BC414A7E7;
        Thu,  2 Jun 2022 20:18:08 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Wayne Lin <Wayne.Lin@amd.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Rajkumar Subbiah <rsubbia@codeaurora.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/3] drm/display/dp_mst: Don't validate port refs in drm_dp_check_and_send_link_address()
Date:   Thu,  2 Jun 2022 16:17:55 -0400
Message-Id: <20220602201757.30431-2-lyude@redhat.com>
In-Reply-To: <20220602201757.30431-1-lyude@redhat.com>
References: <20220602201757.30431-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drive-by cleanup, we don't need to validate the port references here as we
already previously went through the effort of refactoring things such that
we're guaranteed to be able to access ->mstb and ->port safely from
drm_dp_check_and_send_link_address(), since the only two places in the
codebase that drop an MST reference in such a way that it would remove it
from the topology are both protected under probe_lock.

Thanks for that, past Lyude!

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/display/drm_dp_mst_topology.c | 22 +++++--------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
index 67b3b9697da7..d84673b3294b 100644
--- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
@@ -2666,24 +2666,14 @@ static int drm_dp_check_and_send_link_address(struct drm_dp_mst_topology_mgr *mg
 	}
 
 	list_for_each_entry(port, &mstb->ports, next) {
-		struct drm_dp_mst_branch *mstb_child = NULL;
-
-		if (port->input || !port->ddps)
+		if (port->input || !port->ddps || !port->mstb)
 			continue;
 
-		if (port->mstb)
-			mstb_child = drm_dp_mst_topology_get_mstb_validated(
-			    mgr, port->mstb);
-
-		if (mstb_child) {
-			ret = drm_dp_check_and_send_link_address(mgr,
-								 mstb_child);
-			drm_dp_mst_topology_put_mstb(mstb_child);
-			if (ret == 1)
-				changed = true;
-			else if (ret < 0)
-				return ret;
-		}
+		ret = drm_dp_check_and_send_link_address(mgr, port->mstb);
+		if (ret == 1)
+			changed = true;
+		else if (ret < 0)
+			return ret;
 	}
 
 	return changed;
-- 
2.35.3

