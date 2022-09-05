Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 094C25AD687
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 17:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238949AbiIEP3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 11:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239086AbiIEP2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 11:28:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7FC6110C
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 08:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662391659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NEM+8qA1l934tBlwuTsd8qBaVhltlHSYDFpUMi13koI=;
        b=Sdu0AI2ZPEnUxMf0qEd0W0v4j+AGad5fDn+f+kQzdIVy/CIEwR5KPSHLBpXLI4QRw65jE6
        wT7DHAj/hi/kiFDalM5/YMChj+vHq9OjuP+LVBWQzHVF2TmRht17NYSLAaADr92N9SciyV
        zF4kwpTtEetijJu3mA6tBgoAckWn+r4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-102-SbW19XPZOMG95s3oE04ZMA-1; Mon, 05 Sep 2022 11:27:37 -0400
X-MC-Unique: SbW19XPZOMG95s3oE04ZMA-1
Received: by mail-ej1-f72.google.com with SMTP id qb39-20020a1709077ea700b0073ddc845586so2455681ejc.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 08:27:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=NEM+8qA1l934tBlwuTsd8qBaVhltlHSYDFpUMi13koI=;
        b=cch9gFQLGxDhD0kxV12R94IQVgRc66+b2z4sinFwl0XkfmBggXRUBCzR1h1Us8/hW8
         ItF/O5xWuZ9PbXQI6EF6EeJOD8fCAr/B5Cfz73Qk9RnZE3YNIO2hOOGFB4abGIqI4R6H
         pYCT7ma7npk8QmXubQ72O2oDTk2U/tm2aC7qSX+arPHdvy+EldOyd5IHLsT8nIk5D1K4
         frtudV+cMxq4WIKBsnYjziL39/6lT4tLpRSrHraDEzVhvp+Z90rQ3WeDr7ZvHq9UheMN
         RfFC4aMO4Sabi0wXT9/Kk2jKWHuvuMmbMm/OKCM+G9f8yBrr+dKom1fOwfsGkk8RePMZ
         kltQ==
X-Gm-Message-State: ACgBeo01KR7yuarQavxNZPl3PZ9T/74KEO2LDGx9FkQmrau+VAO/3ZTz
        MubcPT/u4A3KfzwvqkFuroifamHyv/v/6ZA0h4c6y+fakPyeldEf6/AYFYNeNxkKh4EFuXRkMo7
        wT+sj1G+tZX+QBjRADVPwKx8N
X-Received: by 2002:a17:907:2bce:b0:73d:dd00:9ced with SMTP id gv14-20020a1709072bce00b0073ddd009cedmr33121656ejc.739.1662391656690;
        Mon, 05 Sep 2022 08:27:36 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7ZkK+8F2F9/wkZzegh9qRMurglKs44lIEA7p306fDAZ+htrVC8A6RHorF7fdbKZuptgiaRlA==
X-Received: by 2002:a17:907:2bce:b0:73d:dd00:9ced with SMTP id gv14-20020a1709072bce00b0073ddd009cedmr33121642ejc.739.1662391656544;
        Mon, 05 Sep 2022 08:27:36 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id kw19-20020a170907771300b0073c5192cba6sm5175398ejc.114.2022.09.05.08.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 08:27:36 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, liviu.dudau@arm.com, brian.starkey@arm.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH RESEND drm-misc-next 4/7] drm/arm/hdlcd: plane: use drm managed resources
Date:   Mon,  5 Sep 2022 17:27:16 +0200
Message-Id: <20220905152719.128539-5-dakr@redhat.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220905152719.128539-1-dakr@redhat.com>
References: <20220905152719.128539-1-dakr@redhat.com>
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

Use drm managed resource allocation (drmm_universal_plane_alloc()) in
order to get rid of the explicit destroy hook in struct drm_plane_funcs.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/arm/hdlcd_crtc.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/arm/hdlcd_crtc.c b/drivers/gpu/drm/arm/hdlcd_crtc.c
index c0a5ca7f578a..17d3ccf12245 100644
--- a/drivers/gpu/drm/arm/hdlcd_crtc.c
+++ b/drivers/gpu/drm/arm/hdlcd_crtc.c
@@ -289,7 +289,6 @@ static const struct drm_plane_helper_funcs hdlcd_plane_helper_funcs = {
 static const struct drm_plane_funcs hdlcd_plane_funcs = {
 	.update_plane		= drm_atomic_helper_update_plane,
 	.disable_plane		= drm_atomic_helper_disable_plane,
-	.destroy		= drm_plane_cleanup,
 	.reset			= drm_atomic_helper_plane_reset,
 	.atomic_duplicate_state = drm_atomic_helper_plane_duplicate_state,
 	.atomic_destroy_state	= drm_atomic_helper_plane_destroy_state,
@@ -297,24 +296,19 @@ static const struct drm_plane_funcs hdlcd_plane_funcs = {
 
 static struct drm_plane *hdlcd_plane_init(struct drm_device *drm)
 {
-	struct hdlcd_drm_private *hdlcd = drm->dev_private;
+	struct hdlcd_drm_private *hdlcd = drm_to_hdlcd_priv(drm);
 	struct drm_plane *plane = NULL;
 	u32 formats[ARRAY_SIZE(supported_formats)], i;
-	int ret;
-
-	plane = devm_kzalloc(drm->dev, sizeof(*plane), GFP_KERNEL);
-	if (!plane)
-		return ERR_PTR(-ENOMEM);
 
 	for (i = 0; i < ARRAY_SIZE(supported_formats); i++)
 		formats[i] = supported_formats[i].fourcc;
 
-	ret = drm_universal_plane_init(drm, plane, 0xff, &hdlcd_plane_funcs,
-				       formats, ARRAY_SIZE(formats),
-				       NULL,
-				       DRM_PLANE_TYPE_PRIMARY, NULL);
-	if (ret)
-		return ERR_PTR(ret);
+	plane = drmm_universal_plane_alloc(drm, struct drm_plane, dev, 0xff,
+					   &hdlcd_plane_funcs,
+					   formats, ARRAY_SIZE(formats),
+					   NULL, DRM_PLANE_TYPE_PRIMARY, NULL);
+	if (IS_ERR(plane))
+		return plane;
 
 	drm_plane_helper_add(plane, &hdlcd_plane_helper_funcs);
 	hdlcd->plane = plane;
-- 
2.37.2

