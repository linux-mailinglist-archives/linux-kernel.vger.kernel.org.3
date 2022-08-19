Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE47F59A7A7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 23:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352514AbiHSVZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 17:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352472AbiHSVY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 17:24:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE0FE97E4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 14:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660944296;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xSUtWAzK0ahA+zp/L7/UclMHTS5yPU+3r+RqIP2CU10=;
        b=IuKXgDWG3hDFsxzgrgkI+ypdX9aJ2S/a4v6wg4Lh+P0D8ZA8j+NaOJs4/qPw5kaOnx6YRx
        piIoV/Gqv+pJMVYt2WB40cGf+Ts05L2GaFChVVnIuPWM+lyvWkpjhIUtwQivS2gXao+HSf
        Z4UIRVy3xWLB8cpE4D4U1DdqC66ERRU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-145-IymWYWntOhiZUO8xK9caNQ-1; Fri, 19 Aug 2022 17:24:54 -0400
X-MC-Unique: IymWYWntOhiZUO8xK9caNQ-1
Received: by mail-ed1-f72.google.com with SMTP id b6-20020a056402278600b0043e686058feso3347590ede.10
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 14:24:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=xSUtWAzK0ahA+zp/L7/UclMHTS5yPU+3r+RqIP2CU10=;
        b=oO0QzOrh/N/pS1jEANevYkFA8Iu3lpsF/gZ7i33IgpV8FMk899yziv5KcXna4QMMG/
         LeNkleEt+irNWB2ofTCIGnVJ7MDcPHj44JI2h4ZHEAPcqmLw4jhTsnHnIAK57r4EtJhv
         cAoGoJZT2wCKpTF8l20DOpzGRh+mTwxnxXn1g8g0bM8y1wGvjwNfAB6QpBRrrJ+bSbwy
         64b7wE1ozafE+xLQD00FjldoFNNVXkCquFrrm7G5KZztsoqEIO+LMN1zsNyanFyfpxB1
         zgF4TOzEtIGV2hbKtxSlQdBEew0l88S6sxVJHI50AgTtf1kME3bOnqRhqTOotvysSIOH
         zvLg==
X-Gm-Message-State: ACgBeo3ZdsoVXDIshA29KTc1OgPyDIZx8p/vgzNiQ6PqvB5jm8HHqlp5
        CLlXJSOyJ5DA5g2/CRx6VAN+qrkgTpsCKoQf5hcuBpJLn+a6pxrE+RucxuvUlzCmBzGGX7hT7FG
        F3+1NWuAHyU9PqT55EV4ON1DS
X-Received: by 2002:a17:907:2c64:b0:730:defe:a419 with SMTP id ib4-20020a1709072c6400b00730defea419mr5801923ejc.680.1660944292904;
        Fri, 19 Aug 2022 14:24:52 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6oYyJVdeZhoxUxsoyFexqgp6rNALbs/+7bSlswTqyu+9Ql2HoaivzZUuTjOC23Kgx1o/fEZg==
X-Received: by 2002:a17:907:2c64:b0:730:defe:a419 with SMTP id ib4-20020a1709072c6400b00730defea419mr5801915ejc.680.1660944292766;
        Fri, 19 Aug 2022 14:24:52 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id k21-20020a170906579500b0072fa24c2ecbsm2842999ejq.94.2022.08.19.14.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 14:24:52 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, liviu.dudau@arm.com, brian.starkey@arm.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next 6/8] drm/arm/malidp: plane: protect device resources after removal
Date:   Fri, 19 Aug 2022 23:24:43 +0200
Message-Id: <20220819212445.559790-4-dakr@redhat.com>
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

