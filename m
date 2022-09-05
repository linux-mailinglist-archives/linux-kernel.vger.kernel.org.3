Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9399C5AD69D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 17:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238999AbiIEP3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 11:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239118AbiIEP2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 11:28:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83FFA61D89
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 08:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662391655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7wDtbQGLiE39PVFtlUhXuYz+XJ8dWxVCvJywCPPxRNQ=;
        b=iRaJz16E8j+6QPrLPiZ4u88W4rqWko7tfJuxm03QOrjX032Cn8EsnQGnlMvtmgQRgx1uBQ
        pHJVUtKMXTU2Vs8jqbxY7gUY7bo7cD+rV5H+tG82eAS472aurJQKtvE5J4mDv1LgToCq4m
        MWlv4gSslbXcVi8nWamDP+rql5EFKzM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-374-jtoWBuq4NW2Un3oDXg5aqA-1; Mon, 05 Sep 2022 11:27:34 -0400
X-MC-Unique: jtoWBuq4NW2Un3oDXg5aqA-1
Received: by mail-ej1-f70.google.com with SMTP id qw34-20020a1709066a2200b00730ca5a94bfso2458976ejc.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 08:27:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=7wDtbQGLiE39PVFtlUhXuYz+XJ8dWxVCvJywCPPxRNQ=;
        b=NhaVbYu060tWAtiLDiV9aAP3Nc90qH3YqL0CjyMtZ1nfi7zBn25tsbZs+hvQirNYoo
         YcP4+1wbAH4Dc6IFb81j/tNnhsiVabsskgDVI7upwXJY/XLr6xxLOsIXmZFGOn8bKwtu
         YR7dM+wze7dGgOfI0BxPKaKMwx9tS4MHb68iVqTmyxdf1p/FHvgIm2D7SUvnDgkjgHlM
         ETkN4mIWsXu55jxjiZ0zVBb5AyazESp/3L2dK2qzRTGYEQ01jbzeaaF6Dka4GyYQ51DT
         DAALHlsideHq4Aqs1nIxnl132agxzL6isUF+itfWw2TPC4FYJZ69QImMWbUot72njdGX
         kn9A==
X-Gm-Message-State: ACgBeo14qTwE7o4ijl7rF3DBLbbLZK5m9cmCcdvpKy3tyN86QNCzASez
        tq2p5Zt7Nf32TcNPF6VmJKff/2dZyuX38Iw4Xfk/3uydhh2vEut7k9AAkuAAxQ4yrd2E0y7e689
        ZB+npPPYV21YaVix6eTejBNNg
X-Received: by 2002:a17:907:a427:b0:761:2bd0:3e72 with SMTP id sg39-20020a170907a42700b007612bd03e72mr6872888ejc.346.1662391653234;
        Mon, 05 Sep 2022 08:27:33 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5+7yZe7QTs81r9HK652dKS4RqWWeQcqNFOZjjgqfsu9vjr6GJZS80WRbgfEaB3pVKfT3aG+A==
X-Received: by 2002:a17:907:a427:b0:761:2bd0:3e72 with SMTP id sg39-20020a170907a42700b007612bd03e72mr6872882ejc.346.1662391653085;
        Mon, 05 Sep 2022 08:27:33 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id i23-20020aa7c9d7000000b0044e7d69091asm2418412edt.85.2022.09.05.08.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 08:27:32 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, liviu.dudau@arm.com, brian.starkey@arm.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH RESEND drm-misc-next 3/7] drm/arm/hdlcd: crtc: use drmm_crtc_init_with_planes()
Date:   Mon,  5 Sep 2022 17:27:15 +0200
Message-Id: <20220905152719.128539-4-dakr@redhat.com>
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

