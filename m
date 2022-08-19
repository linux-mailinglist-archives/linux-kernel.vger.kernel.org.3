Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4DF759A927
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 01:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239452AbiHSXLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 19:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243577AbiHSXLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 19:11:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6055EB8A67
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 16:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660950674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NEM+8qA1l934tBlwuTsd8qBaVhltlHSYDFpUMi13koI=;
        b=jRhQP8MIlNrqtvpwe2H8yi81qxMtEwli4hFvnsJ3zAQKe6mlOqwHHjuK0OOSyxptpfmSeS
        knoV336f92nHEZMbDZVn3hMecTf9h3ST3uKsGxry6qCoPlEMZzkUUy+gJfOFnSlPYQGbfi
        2YwQllBwPv3kW69cUI6cueAGhFbbFAw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-537-Y6hVcIzuPEGAAZzdBH-f-w-1; Fri, 19 Aug 2022 19:11:13 -0400
X-MC-Unique: Y6hVcIzuPEGAAZzdBH-f-w-1
Received: by mail-ed1-f70.google.com with SMTP id x20-20020a05640226d400b0043d50aadf3fso3500505edd.23
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 16:11:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=NEM+8qA1l934tBlwuTsd8qBaVhltlHSYDFpUMi13koI=;
        b=3XjzYcMCd1kMWOUmKBVQPSmTspTNyZ1+mEzskfLMYjP85lHzSEDHj560bdbgFUbnjq
         JYesS/MsxKdccNLOzPCBPE76EiYoKf0mAc1wbpUSoLy1gv8ER6bMuHKLKjfS2twSBs31
         giOCmLlXzNeNPiFqUj3pHJgWEbY/ie7ii9hDTz/ACZxebSiOS/n0bHW0SJGjTj40AOoP
         wr9ttBnHv7sBuz7VhIkeHfOaZzF5oLvhAuHnvDXzl0Ip6L4QsZsh7TOiZPUQe2qNVhrd
         8fM/EHMBTRcWum84NgMkaKiKipeoPC127K0tBArVtd3A/lUXW+kKCOXyoplbwgH4M+/K
         XFtA==
X-Gm-Message-State: ACgBeo0/EKu0qxNAiaZKBatgAR9M7ovJV/x4pquKmjkpFYXg1CAM+zZM
        RpqJuELgWerS8VTbuU1OCu14haTIPllUqawjLVtm2exfgk618/p4VLnnhFY3p5H1RGh0CBrzLoS
        3wIHJ/fDs7cblRYuD0DNPfEmD
X-Received: by 2002:a17:907:2cc8:b0:731:53a3:4a33 with SMTP id hg8-20020a1709072cc800b0073153a34a33mr6108582ejc.319.1660950672267;
        Fri, 19 Aug 2022 16:11:12 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6GbQdWDrH/DBv3IsFTvk98vTg0mBEa1EE3Vrq8PDQzt77Aq61RsfVlf+iGoDPMkaLpdChNgg==
X-Received: by 2002:a17:907:2cc8:b0:731:53a3:4a33 with SMTP id hg8-20020a1709072cc800b0073153a34a33mr6108579ejc.319.1660950672150;
        Fri, 19 Aug 2022 16:11:12 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id da7-20020a056402176700b0043a61f6c389sm3761651edb.4.2022.08.19.16.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 16:11:11 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, liviu.dudau@arm.com, brian.starkey@arm.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next 4/7] drm/arm/hdlcd: plane: use drm managed resources
Date:   Sat, 20 Aug 2022 01:10:55 +0200
Message-Id: <20220819231058.647658-5-dakr@redhat.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220819231058.647658-1-dakr@redhat.com>
References: <20220819231058.647658-1-dakr@redhat.com>
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

