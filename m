Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C20C058D0B8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 01:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244638AbiHHX4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 19:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244617AbiHHXzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 19:55:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E3A251CFCB
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 16:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660002897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p7A2r6sVUQJsBUTGew9D8eYmGw8KPaWXsOstYiwXz+Y=;
        b=gRcyGff6uvlMJlIPnhSWl1oWEnr29tg+mei7Se+vW0dZaWtS2CIpWCaeN65o11DAGDuYzm
        ryxN0MNtYDCGJVrS7C9U/2vmkEaAthrUFlMYSaMlVWllqhYmawOZz2yNkRtkI9S4hj/vxr
        e7DfNOzPbhS4E8ZkHTTP1cP0cqM1jLY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-450-OOBjcF9VNXOhnrPWyd45Zw-1; Mon, 08 Aug 2022 19:54:52 -0400
X-MC-Unique: OOBjcF9VNXOhnrPWyd45Zw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B8D71101A59F;
        Mon,  8 Aug 2022 23:54:51 +0000 (UTC)
Received: from emerald.lyude.net (unknown [10.22.17.154])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EB839C15BA1;
        Mon,  8 Aug 2022 23:54:50 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
Cc:     Jani Nikula <jani.nikula@intel.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sean Paul <seanpaul@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Fernando Ramos <greenfoo@u92.eu>,
        linux-kernel@vger.kernel.org (open list)
Subject: [RFC v2 12/18] drm/nouveau/kms: Pull mst state in for all modesets
Date:   Mon,  8 Aug 2022 19:51:57 -0400
Message-Id: <20220808235203.123892-13-lyude@redhat.com>
In-Reply-To: <20220808235203.123892-1-lyude@redhat.com>
References: <20220808235203.123892-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we're going to be relying on atomic locking for payloads now (and the
MST mgr needs to track CRTCs), pull in the topology state for all modesets
in nv50_msto_atomic_check().

Signed-off-by: Lyude Paul <lyude@redhat.com>
Acked-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index 5669c8d747d7..24807aa9da5f 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -1049,7 +1049,7 @@ nv50_msto_atomic_check(struct drm_encoder *encoder,
 	if (ret)
 		return ret;
 
-	if (!crtc_state->mode_changed && !crtc_state->connectors_changed)
+	if (!drm_atomic_crtc_needs_modeset(crtc_state))
 		return 0;
 
 	/*
-- 
2.37.1

