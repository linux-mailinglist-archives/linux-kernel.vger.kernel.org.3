Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE1A759A7AD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 23:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352496AbiHSVZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 17:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352509AbiHSVZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 17:25:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE6FE01F3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 14:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660944346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hPqOotGSruHudwMIkA2GhgTM0KbwtUxu9NgLFadghJM=;
        b=MK8In+sXMZ4Gh0dictTovY1JQKfrHOoIueKwswZqzt+kZCUda36NWT21hPU1NvW/6EyA1L
        Gdsz6MrRvuWpJ2xWMgz8cGWH6YP8WZ2oosFjb63yr7d2YOomxuesR+pKvi2HbZ1cN81x89
        cFJ17Rib80tYndToDi0YeiSZ1/8YSmQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-271-m3nZTMmGPtOg63VuGxxrQw-1; Fri, 19 Aug 2022 17:25:45 -0400
X-MC-Unique: m3nZTMmGPtOg63VuGxxrQw-1
Received: by mail-ed1-f69.google.com with SMTP id y16-20020a056402359000b0043db5186943so3351648edc.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 14:25:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=hPqOotGSruHudwMIkA2GhgTM0KbwtUxu9NgLFadghJM=;
        b=cusrC6vKx5Vby6hUz3tj0BIIBMJo6isbdU/ik2Uc7IptMh7jXTwVnREQEHxAx2bORH
         5IJlXWQSBcKj25yFdB/O7H4zTBGmOdFr/eQF/4CjLbLjlbFItiWRM9UTM4IBa3KBiHKf
         dTwNw2R4QZ5oj4ylJggiBaRxIztTIb0ahDtg9Th4b5b48SPCNeKyAFPOshybLMJ0pdBT
         xprEjDQSsEb6n+klHF8SaFAF8Tnui5mqxY3va55R8E+DwIf3P2OVO6Ct1nBtDyuZxjGU
         bZ336Q9jfYVJ7p9X2fOh5fEYZOMRDVwEtDppgRjWTkPkEiWHGQp696VaKn2wr6pI2R6y
         ynuA==
X-Gm-Message-State: ACgBeo0DSbwMnJNEFTqmwXWuK4LJOzLj9Z8Z2Ji14yz8lQQ8kflJDh65
        c7il5WljfV5+gYIm0h1JX0RGwIg63JGpJ6fuYuiqFnEULihNk9MM4pg6mFxIpn0m7FdNlHlQfrm
        P/elPJ0Iwbitk0WMG5gQ1Syma
X-Received: by 2002:a05:6402:415:b0:446:230d:2b82 with SMTP id q21-20020a056402041500b00446230d2b82mr5875891edv.200.1660944344405;
        Fri, 19 Aug 2022 14:25:44 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7HPGxg5GCr3oNRoWkMSOYoQXdCy3r5Rh15bVdNO88lO8+SW2gzGUe5OSb4mGaG4wbSWPX8tw==
X-Received: by 2002:a05:6402:415:b0:446:230d:2b82 with SMTP id q21-20020a056402041500b00446230d2b82mr5875877edv.200.1660944344223;
        Fri, 19 Aug 2022 14:25:44 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id ej19-20020a056402369300b00445f1fa531bsm3650681edb.25.2022.08.19.14.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 14:25:43 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, liviu.dudau@arm.com, brian.starkey@arm.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next 8/8] drm/arm/malidp: drv: protect device resources after removal
Date:   Fri, 19 Aug 2022 23:25:38 +0200
Message-Id: <20220819212538.559902-2-dakr@redhat.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220819212015.556220-1-dakr@redhat.com>
References: <20220819212015.556220-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Hardware) resources which are bound to the driver and device lifecycle
must not be accessed after the device and driver are unbound.

However, the DRM device isn't freed as long as the last user didn't
close it, hence userspace can still call into the driver.

Therefore protect the critical sections which are accessing those
resources with drm_dev_enter() and drm_dev_exit().

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/arm/malidp_drv.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
index aedd30f5f451..8bb8e8d14461 100644
--- a/drivers/gpu/drm/arm/malidp_drv.c
+++ b/drivers/gpu/drm/arm/malidp_drv.c
@@ -234,9 +234,12 @@ static void malidp_atomic_commit_tail(struct drm_atomic_state *state)
 	struct malidp_drm *malidp = drm_to_malidp(drm);
 	struct drm_crtc *crtc;
 	struct drm_crtc_state *old_crtc_state;
-	int i;
+	int i, idx;
 	bool fence_cookie = dma_fence_begin_signalling();
 
+	if (!drm_dev_enter(drm, &idx))
+		return;
+
 	pm_runtime_get_sync(drm->dev);
 
 	/*
@@ -267,6 +270,8 @@ static void malidp_atomic_commit_tail(struct drm_atomic_state *state)
 	pm_runtime_put(drm->dev);
 
 	drm_atomic_helper_cleanup_planes(drm, state);
+
+	drm_dev_exit(idx);
 }
 
 static const struct drm_mode_config_helper_funcs malidp_mode_config_helpers = {
-- 
2.37.2

