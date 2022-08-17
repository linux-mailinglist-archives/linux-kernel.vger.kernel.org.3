Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6649A59770A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 21:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241276AbiHQTle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 15:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241615AbiHQTk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 15:40:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17EEA61C2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 12:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660765224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nAMc4JfLKYfg0/w7KMNfHryoYc6iVSVzopF6Uhg7wgM=;
        b=KUS7IXxmaKDCdnwbEa25tGXPodYac8n+pGrUorzAygyJII8AfBGFf2oQK8SvMbpNZwcfDa
        YI5db47kvc3t4obE5RTa6wRcuS1WLT83hUtTXyGo8jgEDpNfSEGK3W6xImcef+4KOZl1/K
        3UVz0tTlMXpza2h8xty1EgEs90INHGo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-31-fOfUeP-xOVqxVcJC9KYM2w-1; Wed, 17 Aug 2022 15:40:18 -0400
X-MC-Unique: fOfUeP-xOVqxVcJC9KYM2w-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 916A880231E;
        Wed, 17 Aug 2022 19:40:17 +0000 (UTC)
Received: from emerald.redhat.com (unknown [10.22.18.168])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2B4A5492C3B;
        Wed, 17 Aug 2022 19:40:17 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
Cc:     Jani Nikula <jani.nikula@intel.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [RFC v4 11/17] drm/nouveau/kms: Cache DP encoders in nouveau_connector
Date:   Wed, 17 Aug 2022 15:38:40 -0400
Message-Id: <20220817193847.557945-12-lyude@redhat.com>
In-Reply-To: <20220817193847.557945-1-lyude@redhat.com>
References: <20220817193847.557945-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Post-NV50, the only kind of encoder you'll find for DP connectors on Nvidia
GPUs are SORs (serial output resources). Because SORs have fixed
associations with their connectors, we can correctly assume that any DP
connector on a nvidia GPU will have exactly one SOR encoder routed to it
for DisplayPort.

Since we're going to need to be able to retrieve this fixed SOR DP encoder
much more often as a result of hooking up MST helpers for tracking
SST<->MST transitions in atomic states, let's simply cache this encoder in
nouveau_connector for any DP connectors on the system to avoid looking it
up each time. This isn't safe for NV50 since PIORs then come into play,
however there's no code pre-NV50 that would need to look this up anyhow -
so it's not really an issue.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Acked-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/gpu/drm/nouveau/nouveau_connector.c | 4 +++-
 drivers/gpu/drm/nouveau/nouveau_connector.h | 3 +++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
index 8100c75ee731..b8ee2173ca8f 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -1368,7 +1368,7 @@ nouveau_connector_create(struct drm_device *dev,
 			return ERR_PTR(-ENOMEM);
 		}
 		drm_dp_aux_init(&nv_connector->aux);
-		fallthrough;
+		break;
 	default:
 		funcs = &nouveau_connector_funcs;
 		break;
@@ -1431,6 +1431,8 @@ nouveau_connector_create(struct drm_device *dev,
 
 	switch (type) {
 	case DRM_MODE_CONNECTOR_DisplayPort:
+		nv_connector->dp_encoder = find_encoder(&nv_connector->base, DCB_OUTPUT_DP);
+		fallthrough;
 	case DRM_MODE_CONNECTOR_eDP:
 		drm_dp_cec_register_connector(&nv_connector->aux, connector);
 		break;
diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.h b/drivers/gpu/drm/nouveau/nouveau_connector.h
index 4bf0c703eee7..f4e17ff68bf9 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.h
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.h
@@ -128,6 +128,9 @@ struct nouveau_connector {
 
 	struct drm_dp_aux aux;
 
+	/* The fixed DP encoder for this connector, if there is one */
+	struct nouveau_encoder *dp_encoder;
+
 	int dithering_mode;
 	int scaling_mode;
 
-- 
2.37.1

