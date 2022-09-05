Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB7FB5AD62A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 17:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238517AbiIEPU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 11:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238529AbiIEPTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 11:19:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A652193
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 08:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662391173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xSUtWAzK0ahA+zp/L7/UclMHTS5yPU+3r+RqIP2CU10=;
        b=K5aLxJMuO4y/sUuu0BwZ9zBbSIus3AzJouwQKK/PKICreIbvu5DtslVwFndxNBx6YJ20I6
        OXVSb8O1MVHqDLdwk9lMh3VKSsJhJgwE8UKt4mhgk9Pd8H8nmLVH/a8igZtkcZph1X/qmz
        BTfXFCtieF1MdIlWBjYyhlSmVLTPtJk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-43-8WeDU3NcMCC0ITryCgiASw-1; Mon, 05 Sep 2022 11:19:32 -0400
X-MC-Unique: 8WeDU3NcMCC0ITryCgiASw-1
Received: by mail-wm1-f70.google.com with SMTP id h133-20020a1c218b000000b003a5fa79008bso7568870wmh.5
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 08:19:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=xSUtWAzK0ahA+zp/L7/UclMHTS5yPU+3r+RqIP2CU10=;
        b=k+Bn7fzfP4CxGD6XjX0kgy8nSRAp83QAeO9ZAO6IYTCt+Xs4dyf5J0dyGn3Fdbw8Rs
         7eUoqLaj9sFP4vSB65/PaS/iVE7f8XlEJtNhZJtPcTs1N1WGaHKeiVdZDI+VP0wDxHwU
         keU9ndyeHDWAcYejjq0EsoOyoOCRBd9eXbN8FGGV708QCFbGUbTQ8gTUzYR2Wm4KsgMx
         a60Y67n1ingTZuubK/00Pc1HqlAgACKEjPgEI7agaZ1TJOuV30ETXLsgZUB0zanVe7la
         6rRVSpDSv4G/ibeiLEeuoMc73o4+90MUQVobwA3/kSNb/s3h0N2oayotZOXRKepYr96O
         dWaQ==
X-Gm-Message-State: ACgBeo2Yl7tOOPqU6MqRkOQONzgw/MRjnNvua3YMRgQaak4DPvMwVUQP
        tNuKwkp0H/1l2VMW7kfOkswakRHoXwiXyVOdh1KVU9bRBD12vKumQ1+8ncAZdXmrizyGNoarvVI
        48ACrgwKXPVAahfdSFLCYV0w5
X-Received: by 2002:a5d:48c7:0:b0:228:62d5:2818 with SMTP id p7-20020a5d48c7000000b0022862d52818mr5341883wrs.13.1662391171541;
        Mon, 05 Sep 2022 08:19:31 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6KG28G6zxF6nBeebEbFNRpsDbrJRMcxpQj5CeuggUPfErxOJ+G3x3zAgSIgPxcSWg6+XzDqQ==
X-Received: by 2002:a5d:48c7:0:b0:228:62d5:2818 with SMTP id p7-20020a5d48c7000000b0022862d52818mr5341871wrs.13.1662391171390;
        Mon, 05 Sep 2022 08:19:31 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id j18-20020a5d4532000000b00220592005edsm9227024wra.85.2022.09.05.08.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 08:19:31 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, liviu.dudau@arm.com, brian.starkey@arm.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH RESEND drm-misc-next 6/8] drm/arm/malidp: plane: protect device resources after removal
Date:   Mon,  5 Sep 2022 17:19:08 +0200
Message-Id: <20220905151910.98279-7-dakr@redhat.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220905151910.98279-1-dakr@redhat.com>
References: <20220905151910.98279-1-dakr@redhat.com>
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
 drivers/gpu/drm/arm/malidp_planes.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/arm/malidp_planes.c b/drivers/gpu/drm/arm/malidp_planes.c
index 34547edf1ee3..d2ea60549454 100644
--- a/drivers/gpu/drm/arm/malidp_planes.c
+++ b/drivers/gpu/drm/arm/malidp_planes.c
@@ -790,9 +790,12 @@ static void malidp_de_plane_update(struct drm_plane *plane,
 	u16 pixel_alpha = new_state->pixel_blend_mode;
 	u8 plane_alpha = new_state->alpha >> 8;
 	u32 src_w, src_h, dest_w, dest_h, val;
-	int i;
+	int i, idx;
 	struct drm_framebuffer *fb = plane->state->fb;
 
+	if (!drm_dev_enter(plane->dev, &idx))
+		return;
+
 	mp = to_malidp_plane(plane);
 
 	/*
@@ -897,16 +900,24 @@ static void malidp_de_plane_update(struct drm_plane *plane,
 
 	malidp_hw_write(mp->hwdev, val,
 			mp->layer->base + MALIDP_LAYER_CONTROL);
+
+	drm_dev_exit(idx);
 }
 
 static void malidp_de_plane_disable(struct drm_plane *plane,
 				    struct drm_atomic_state *state)
 {
 	struct malidp_plane *mp = to_malidp_plane(plane);
+	int idx;
+
+	if (!drm_dev_enter(plane->dev, &idx))
+		return;
 
 	malidp_hw_clearbits(mp->hwdev,
 			    LAYER_ENABLE | LAYER_FLOWCFG(LAYER_FLOWCFG_MASK),
 			    mp->layer->base + MALIDP_LAYER_CONTROL);
+
+	drm_dev_exit(idx);
 }
 
 static const struct drm_plane_helper_funcs malidp_de_plane_helper_funcs = {
-- 
2.37.2

