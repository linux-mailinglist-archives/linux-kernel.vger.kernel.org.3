Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED7B5A7C04
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 13:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbiHaLNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 07:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiHaLM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 07:12:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7B0CEB34
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 04:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661944375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=USB8h2BMQ0I24TO04KeG3lsFoMe632Y1I1xHU109ulU=;
        b=Is+2FgW26NqjN67OmnLksd2BlKIHqf7cgOE4KFxc695myGjktavLbNrb0QoBFM5GakyPdu
        E45sGUv+EOViXgeDuAVvUk9xtgUfpvBVLd29KSvGE0zPz/m6mSn+JJxxPIzKMfroCcBmIA
        riJj5xPJwKAHfO5KfNKv3UbgDv2KP34=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-622-LVLC7euSNaebfBAg9G8_ag-1; Wed, 31 Aug 2022 07:12:54 -0400
X-MC-Unique: LVLC7euSNaebfBAg9G8_ag-1
Received: by mail-wm1-f69.google.com with SMTP id 203-20020a1c02d4000000b003a5f5bce876so11567901wmc.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 04:12:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=USB8h2BMQ0I24TO04KeG3lsFoMe632Y1I1xHU109ulU=;
        b=wXLGgfRe3MaU+9RJn7IEkELTm/fMHa6E2ExAB9odlMFYQy10YalyQ8yYs9egoig6QE
         iSS1peR2W5BripNLmF4A0SXUQsrKOfaZpjNsCBFFGIVDMgqe//4YZH9GBvEMz2BFDQ8G
         5WQTk7m/mJ0mvTz/GLuJE+P1XDUWislqkckbqQ+TxfZTKqLpcl2fX9oXvqo02W3Wz1yk
         S4WhoAYiqH4LQJSEpTojOtx1PCxRPHnySYaw4984mP3DF+aDObYsdWa+oxdTIWAbk86V
         kUQ9OV/IRrePX4aRMwIBQf37vSRzFlYcbZgmpKyoKrXZSXNmWZP8gAaXnvhBMw4HU4W3
         GENw==
X-Gm-Message-State: ACgBeo3TBhHOy/bhET1FaRy4hSJGgiYeHNy6FlmE+TZHHz7wHNt7Nqgj
        zK7t7lhZrJpwXep+3qkmLbDP4mzKeY4t+s/MrqCWT4bQZyIryUSCxsjd7ZLtCZXcPa07xhX+2HE
        x/gw6opdw5PnGVkIVrCWGWF3Ywfbh2g7DL6UlJsTQXyTpuA6nHQqHrtMIiadr0zSELCYE1DwXmx
        k=
X-Received: by 2002:a05:6000:1e18:b0:226:e095:a98c with SMTP id bj24-20020a0560001e1800b00226e095a98cmr5123175wrb.235.1661944372492;
        Wed, 31 Aug 2022 04:12:52 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7MLzM43BMadh9MDmVHhKCnDr9/uiKXZwJnIT9SD0vG1W6oIuYqjfK3qOR+cK45WBdZ15aCwg==
X-Received: by 2002:a05:6000:1e18:b0:226:e095:a98c with SMTP id bj24-20020a0560001e1800b00226e095a98cmr5123155wrb.235.1661944372208;
        Wed, 31 Aug 2022 04:12:52 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id ay19-20020a05600c1e1300b003a682354f63sm2054876wmb.11.2022.08.31.04.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 04:12:51 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/simpledrm: Drop superfluous primary plane .atomic_check return logic
Date:   Wed, 31 Aug 2022 13:12:43 +0200
Message-Id: <20220831111243.1530620-1-javierm@redhat.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The simpledrm_primary_plane_helper_atomic_check() function is more complex
than needed. It first checks drm_atomic_helper_check_plane_state() returns
value to decide whether to return this or zero.

But it could just return that function return value directly. It also does
a check if new_plane_state->visible isn't set, but returns zero regardless.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/gpu/drm/tiny/simpledrm.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/tiny/simpledrm.c b/drivers/gpu/drm/tiny/simpledrm.c
index a81f91814595..0be47f40247a 100644
--- a/drivers/gpu/drm/tiny/simpledrm.c
+++ b/drivers/gpu/drm/tiny/simpledrm.c
@@ -485,21 +485,14 @@ static int simpledrm_primary_plane_helper_atomic_check(struct drm_plane *plane,
 	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(new_state, plane);
 	struct drm_crtc *new_crtc = new_plane_state->crtc;
 	struct drm_crtc_state *new_crtc_state = NULL;
-	int ret;
 
 	if (new_crtc)
 		new_crtc_state = drm_atomic_get_new_crtc_state(new_state, new_crtc);
 
-	ret = drm_atomic_helper_check_plane_state(new_plane_state, new_crtc_state,
-						  DRM_PLANE_NO_SCALING,
-						  DRM_PLANE_NO_SCALING,
-						  false, false);
-	if (ret)
-		return ret;
-	else if (!new_plane_state->visible)
-		return 0;
-
-	return 0;
+	return drm_atomic_helper_check_plane_state(new_plane_state, new_crtc_state,
+						   DRM_PLANE_NO_SCALING,
+						   DRM_PLANE_NO_SCALING,
+						   false, false);
 }
 
 static void simpledrm_primary_plane_helper_atomic_update(struct drm_plane *plane,
-- 
2.37.1

