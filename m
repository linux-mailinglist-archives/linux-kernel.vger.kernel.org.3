Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5124A542287
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444526AbiFHBHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 21:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386532AbiFGWtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 18:49:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1E1A629FE57
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 12:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654630611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dSSRC0WIkS5IpQW5GfgCwEoSZKSvhgHutOeLQYQVc4o=;
        b=iBqVYlM+KXaYE3/XGOO4pjW9W/qjB5pmFtsNF/bdvfzKmrnOJKWUCObdLTOe5majJ99Uoz
        adjzI+KSQvZ2prAxJFEzZkgL7QgACRcT36D+FPco6DRbkI2fTSQxGEp/hZLU8cGHDcIN/C
        Rq9BfWvDTXXhYuxb7zQ3IT8lXe325vw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-615-rBYHaFOCOqOHB7s71ZIylw-1; Tue, 07 Jun 2022 15:36:47 -0400
X-MC-Unique: rBYHaFOCOqOHB7s71ZIylw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6C6FA2949BA5;
        Tue,  7 Jun 2022 19:35:36 +0000 (UTC)
Received: from emerald.redhat.com (unknown [10.22.9.252])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 51B852C05D49;
        Tue,  7 Jun 2022 19:35:10 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, Karol Herbst <kherbst@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sean Paul <seanpaul@chromium.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Fernando Ramos <greenfoo@u92.eu>,
        linux-kernel@vger.kernel.org (open list)
Subject: [RESEND RFC 12/18] drm/nouveau/kms: Pull mst state in for all modesets
Date:   Tue,  7 Jun 2022 15:29:27 -0400
Message-Id: <20220607192933.1333228-13-lyude@redhat.com>
In-Reply-To: <20220607192933.1333228-1-lyude@redhat.com>
References: <20220607192933.1333228-1-lyude@redhat.com>
MIME-Version: 1.0
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

Since we're going to be relying on atomic locking for payloads now (and the
MST mgr needs to track CRTCs), pull in the topology state for all modesets
in nv50_msto_atomic_check().

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index 461e5e3345f8..834a5c5b77d5 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -1054,7 +1054,7 @@ nv50_msto_atomic_check(struct drm_encoder *encoder,
 	if (ret)
 		return ret;
 
-	if (!crtc_state->mode_changed && !crtc_state->connectors_changed)
+	if (!drm_atomic_crtc_needs_modeset(crtc_state))
 		return 0;
 
 	/*
-- 
2.35.3

