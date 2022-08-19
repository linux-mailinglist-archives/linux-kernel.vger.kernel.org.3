Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E7159A7BF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 23:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352477AbiHSVZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 17:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352444AbiHSVYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 17:24:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FE0D2E8E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 14:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660944292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qabemuj06WeoMtZf9HrAveZ66zZ44DWBaH/ByyW71MM=;
        b=T9dzB60bVFvUBnKxcBQZaFD5HOPpwslEQE4cS+fSmrnoUhM9O1zKHIqzRt8kHKGJ6pHH55
        ngMl3D/vg3vPSN7MMDzihflmQISjlHNgdZyGGygvhIFL/8v8x11QGnXjnp2QnJ6Oi/8/5G
        XoFL0+pgk3JzdiuTBqVZB9Hvw0SkxXc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-586-bBFjS5fDPNunh1vOWumKiQ-1; Fri, 19 Aug 2022 17:24:49 -0400
X-MC-Unique: bBFjS5fDPNunh1vOWumKiQ-1
Received: by mail-ed1-f72.google.com with SMTP id o2-20020a056402438200b0043d552deb2aso3340891edc.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 14:24:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=qabemuj06WeoMtZf9HrAveZ66zZ44DWBaH/ByyW71MM=;
        b=OdzZGdLaX0Uar1uC0FCyQNDiW21QmHx1RvqDwuDBXIjEIl9ng7ekhM97lc8pYiYVZk
         8Ia8imwjzU6/TxjKC2CEWr/f+B01oEN+0m+9RXPQHx/nKgvkX0KfRkjLWcL/hCT/A17Y
         Eh4/gKyVduKIvy2kqPMI9Sa43WWfLJ2uMwi3tg/1KccMwBPQ2bgG/77YJtSI08L9oXA9
         YXyByDW3QZaahv9418rAREla1yNV9X7H+JA4nIHqRY5sPvBdts+RsdypwUZtP0dWMKQ+
         JkVRpa5/gXhOmGuJL+8+30MsxtLa+wG9v5Mf82+adC+N0+zhh7Hftp+lY7t31Bq77nf1
         U13Q==
X-Gm-Message-State: ACgBeo3/WJjBZDcsfP2hIfyjQjN6OOCppdFtv1VLytLlvsgcrvT+l7un
        jQSAX0hLVM+nQb4Gy3EQsvIFh1ptR7hj4cipDlApqWLOahOj+XVvQLZq7DT96WTmJ4hcGtozCJq
        rT45uvJPNti5324O4J4kZ9sEE
X-Received: by 2002:a17:907:72d1:b0:730:a0c4:2aaa with SMTP id du17-20020a17090772d100b00730a0c42aaamr5757438ejc.560.1660944288436;
        Fri, 19 Aug 2022 14:24:48 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5+OgT12yPU20ztpomqJKCst6cahhGUss/gNkPlFCza36i5yJPP9m5o6KfAuZAYV46c1N0Q1A==
X-Received: by 2002:a17:907:72d1:b0:730:a0c4:2aaa with SMTP id du17-20020a17090772d100b00730a0c42aaamr5757428ejc.560.1660944288245;
        Fri, 19 Aug 2022 14:24:48 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id k21-20020a170906579500b0072fa24c2ecbsm2842999ejq.94.2022.08.19.14.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 14:24:47 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, liviu.dudau@arm.com, brian.starkey@arm.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next 3/8] drm/arm/malidp: crtc: use drmm_crtc_init_with_planes()
Date:   Fri, 19 Aug 2022 23:24:40 +0200
Message-Id: <20220819212445.559790-1-dakr@redhat.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220819212015.556220-1-dakr@redhat.com>
References: <20220819212015.556220-1-dakr@redhat.com>
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

Use drmm_crtc_init_with_planes() instead of drm_crtc_init_with_planes()
to get rid of the explicit destroy hook in struct drm_plane_funcs.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/arm/malidp_crtc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/arm/malidp_crtc.c b/drivers/gpu/drm/arm/malidp_crtc.c
index 34ad7e1cd2b8..dc01c43f6193 100644
--- a/drivers/gpu/drm/arm/malidp_crtc.c
+++ b/drivers/gpu/drm/arm/malidp_crtc.c
@@ -514,7 +514,6 @@ static void malidp_crtc_disable_vblank(struct drm_crtc *crtc)
 }
 
 static const struct drm_crtc_funcs malidp_crtc_funcs = {
-	.destroy = drm_crtc_cleanup,
 	.set_config = drm_atomic_helper_set_config,
 	.page_flip = drm_atomic_helper_page_flip,
 	.reset = malidp_crtc_reset,
@@ -548,8 +547,8 @@ int malidp_crtc_init(struct drm_device *drm)
 		return -EINVAL;
 	}
 
-	ret = drm_crtc_init_with_planes(drm, &malidp->crtc, primary, NULL,
-					&malidp_crtc_funcs, NULL);
+	ret = drmm_crtc_init_with_planes(drm, &malidp->crtc, primary, NULL,
+					 &malidp_crtc_funcs, NULL);
 	if (ret)
 		return ret;
 
-- 
2.37.2

