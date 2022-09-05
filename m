Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17AA45AD639
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 17:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238807AbiIEPWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 11:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235786AbiIEPV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 11:21:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942FB6069E
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 08:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662391246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hPqOotGSruHudwMIkA2GhgTM0KbwtUxu9NgLFadghJM=;
        b=Lomw6ZOgTddlTppNJQnp0mt5Mn4BobbNf66Lr8jEIb9hTaXvCxLvdBkh22Uozo5Exm35XK
        IPQME5HSgOl26qXa30e9KRivCWvn8lnCFWoKl5hTvcpclkAHsWgWPel1hS7CpHdddtwQwp
        XFkA7ImU+C0AABHWEBdSy/S5vSRvrPE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-100-VN21vfbpOv28qnwc5LUICw-1; Mon, 05 Sep 2022 11:20:45 -0400
X-MC-Unique: VN21vfbpOv28qnwc5LUICw-1
Received: by mail-wm1-f70.google.com with SMTP id v67-20020a1cac46000000b003a615c4893dso5493117wme.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 08:20:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=hPqOotGSruHudwMIkA2GhgTM0KbwtUxu9NgLFadghJM=;
        b=8LUwwI97LwhtD9yOqkz0QEogFCnaNr2eCdRWtKAv4OHQo0PFOS9psInMdd3cIi0GpH
         QNYDPkLKdJ87utLWOGDqS7Dr6jrFCYGgIgtNiWaemDqDZyzso5oYFK2WgYAsIzMjcy7U
         Wu5asZ5wXKVqoFh3K/K4PbzdbEervSGc49gvu4nlp7ODMKGJqKMrvzooBoZ35pvn9I05
         Ij+NJgsqgW7WOhXD4Al7G19U76vZPxwE6O7NUIuX97VsTbF+4WcoVhcTLwUEoMqTtgwG
         Hfinz7eKhOn7Uq05xiyvdhGvn4BHy1WNxVjH4vSRfheFiORUNd0s9acQcDEI6Tr5jrLP
         Y+SA==
X-Gm-Message-State: ACgBeo2cu977nq2tvM/doZORXE3mpNEgcXxpbfb/kP/7EpnJcukTnrku
        QKoVNscEj7/2Q6VXsQQOkf1rNsb9btl8twQ0+F+k0e4K4yVIZQjxDs1883WLvlQw7Y//zYm9eYX
        bTK+CDBWJmD3MYEF22ZozJsvu
X-Received: by 2002:a05:600c:1c0f:b0:3a5:4d6b:a883 with SMTP id j15-20020a05600c1c0f00b003a54d6ba883mr11252457wms.45.1662391244721;
        Mon, 05 Sep 2022 08:20:44 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7nVSVriafKyRymiV7fyQtuEeLvMSSb3JbyLOA78o+7ULCvGCL0DCvbENDPzt7s804RJJ3wAg==
X-Received: by 2002:a05:600c:1c0f:b0:3a5:4d6b:a883 with SMTP id j15-20020a05600c1c0f00b003a54d6ba883mr11252445wms.45.1662391244580;
        Mon, 05 Sep 2022 08:20:44 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id m5-20020adff385000000b00228c792aaaasm1383446wro.100.2022.09.05.08.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 08:20:44 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, liviu.dudau@arm.com, brian.starkey@arm.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH RESEND drm-misc-next 8/8] drm/arm/malidp: drv: protect device resources after removal
Date:   Mon,  5 Sep 2022 17:20:41 +0200
Message-Id: <20220905152041.98451-2-dakr@redhat.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220905151910.98279-1-dakr@redhat.com>
References: <20220905151910.98279-1-dakr@redhat.com>
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

