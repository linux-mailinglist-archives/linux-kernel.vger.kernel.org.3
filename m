Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFB959A91D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 01:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243739AbiHSXL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 19:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243553AbiHSXLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 19:11:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2E9B9586
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 16:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660950671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7wDtbQGLiE39PVFtlUhXuYz+XJ8dWxVCvJywCPPxRNQ=;
        b=TvTySDGvF1dE6UogjvpNOPDjZW4g1uOAqs9FlKlYSAqz+M3IlPMPdM9J1Xg0Vyus4Iue9G
        ORz8fgwRZOiLcMmLfdaVArJlrrf0qdBQFjfpNG9aICUk+t5dId9qWb0Zxx1gx1RkKl3U4w
        9hev4+yY5NiQof8nQS6hgVsoQ9AZ4yY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-526-CuKz5kdjO9qFZMxxHkzoSA-1; Fri, 19 Aug 2022 19:11:09 -0400
X-MC-Unique: CuKz5kdjO9qFZMxxHkzoSA-1
Received: by mail-ed1-f71.google.com with SMTP id j19-20020a05640211d300b0043ddce5c23aso3448984edw.14
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 16:11:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=7wDtbQGLiE39PVFtlUhXuYz+XJ8dWxVCvJywCPPxRNQ=;
        b=K+CZKjKZ3i2qAwA/YTTgUPLggi95Dx6wIzD1EFG8xccMuS/As9ixCCcWHft+hpdf6f
         4ZNvboUr9WN4RmBmPcW3+epqYDiQpZHBkHvBbb+cT84fWCUfkah+Ew6axo7QqD5VSbuo
         tXDiMitI1PyNZOUzQjnbq0eu7ACVhvnUADV41WI/3A1ZzwH5RvMTyJF6DfZPXUXi5ciU
         b7O1zbauvulogQtogR9VAGZXfPxyoN+gURW3rGMw/eqwPSNytWUBEWa5Fye9eWCHS8VQ
         RSN4fTppxh7Ho+EBTSL/Qbg/okttJzQCU5QySeb8IHuAESK39szOf70BhEvmTWjvf/b5
         ZAHw==
X-Gm-Message-State: ACgBeo0krs3YEov63o2SKtZ2VWf7nhS6MoReArGp7CedO7jhcKu4nFNK
        Ldi2l79YGjfeQXUfANMaftrYFb99dKyWQZHfQwMGJErGlAfwK8vmMhYiP+AWEYu+eMqNyru9hU2
        7h2wZLXqWVHzcBow7gGMbQL+E
X-Received: by 2002:a05:6402:d57:b0:445:fba7:422d with SMTP id ec23-20020a0564020d5700b00445fba7422dmr7839122edb.138.1660950668523;
        Fri, 19 Aug 2022 16:11:08 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5ZHmzoVrJtKFNxyLeq3xlHQ8rgV2AX90b7fLIXFYEYTM65oS0HV/TmNv1//+V+iUNwTnHqfA==
X-Received: by 2002:a05:6402:d57:b0:445:fba7:422d with SMTP id ec23-20020a0564020d5700b00445fba7422dmr7839114edb.138.1660950668409;
        Fri, 19 Aug 2022 16:11:08 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id w20-20020a1709060a1400b007303fe58eb2sm2844636ejf.154.2022.08.19.16.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 16:11:07 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, liviu.dudau@arm.com, brian.starkey@arm.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next 3/7] drm/arm/hdlcd: crtc: use drmm_crtc_init_with_planes()
Date:   Sat, 20 Aug 2022 01:10:54 +0200
Message-Id: <20220819231058.647658-4-dakr@redhat.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220819231058.647658-1-dakr@redhat.com>
References: <20220819231058.647658-1-dakr@redhat.com>
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
to get rid of the explicit drm_crtc_cleanup() call.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/arm/hdlcd_crtc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/arm/hdlcd_crtc.c b/drivers/gpu/drm/arm/hdlcd_crtc.c
index 4a8959d0b2a6..c0a5ca7f578a 100644
--- a/drivers/gpu/drm/arm/hdlcd_crtc.c
+++ b/drivers/gpu/drm/arm/hdlcd_crtc.c
@@ -42,7 +42,6 @@ static void hdlcd_crtc_cleanup(struct drm_crtc *crtc)
 
 	/* stop the controller on cleanup */
 	hdlcd_write(hdlcd, HDLCD_REG_COMMAND, 0);
-	drm_crtc_cleanup(crtc);
 }
 
 static int hdlcd_crtc_enable_vblank(struct drm_crtc *crtc)
@@ -333,8 +332,8 @@ int hdlcd_setup_crtc(struct drm_device *drm)
 	if (IS_ERR(primary))
 		return PTR_ERR(primary);
 
-	ret = drm_crtc_init_with_planes(drm, &hdlcd->crtc, primary, NULL,
-					&hdlcd_crtc_funcs, NULL);
+	ret = drmm_crtc_init_with_planes(drm, &hdlcd->crtc, primary, NULL,
+					 &hdlcd_crtc_funcs, NULL);
 	if (ret)
 		return ret;
 
-- 
2.37.2

