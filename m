Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9435AD625
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 17:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238897AbiIEPUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 11:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238831AbiIEPTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 11:19:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC220DEE5
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 08:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662391165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qabemuj06WeoMtZf9HrAveZ66zZ44DWBaH/ByyW71MM=;
        b=hBVDlmNpC62LAo/UGZNTFez+xee3rCki99QfQvPCng/C4wpcx8d0ZroJtosPaAu9Fwqyqv
        HYeooesV18v1HcUbm1YXfFmpp7N4133OIWftrfvBJARsBV3yoMPBCIL6XRLXdyyPZ/uKpy
        M8usNhRsChEV0JG51dKCN2qlow+0DQY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-649-M_TfqP4_NCW7U07hq3fpZQ-1; Mon, 05 Sep 2022 11:19:24 -0400
X-MC-Unique: M_TfqP4_NCW7U07hq3fpZQ-1
Received: by mail-ed1-f72.google.com with SMTP id c14-20020a05640227ce00b0043e5df12e2cso5980781ede.15
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 08:19:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=qabemuj06WeoMtZf9HrAveZ66zZ44DWBaH/ByyW71MM=;
        b=C8qiLgBn5XgLujMHwJLCOELRXUUkYWxjeaD4oY6t/Adp3L+rC03u3hbNxV9JyHV8FO
         w4JTJJMGKgTJuyAH/s0jrMNbqR+goP39grO7ie6xTQV33IIBxwL8M8vx8V1w6vkzvjq1
         qD7PCtsh+Alek9T2zv5EG+OVeFaeH/lF1eVW0RFkNDy1eFVCr9WH9PSXehQ41MSTsVKk
         74n2E3TLlk0Tqa9UXvKq50C6jx3+eqK726Qgvq0Y+V028+eM509uh2q00idd4LI2T907
         ha9ftdGPFkjSzrFlRcBeipL7eTu149Q2kKfSpwy9yz4dj0EllnhIbxrxeA66UyUFzs5N
         r2lQ==
X-Gm-Message-State: ACgBeo3ynomrnvMiz0YAH1YZLQSiWiV7L4qnFRSTgmzTrNKNpPwgO/U+
        55voayjRyXDyjhdYIzkxgt60kdS6c+oJzSizRl3RNcn0GKf0fu2RysskiJ9OOZP/quElFNofca1
        GFkylRkcjda5jIPjEuY+9QkH/
X-Received: by 2002:a05:6402:1514:b0:448:312:368 with SMTP id f20-20020a056402151400b0044803120368mr39817454edw.263.1662391163637;
        Mon, 05 Sep 2022 08:19:23 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7hAlooCdjVZ738aZDpf606K1bTFeilkcuJNs5qFARVCKKuEfZylLyTwJUVtjZG/kd1JMorOw==
X-Received: by 2002:a05:6402:1514:b0:448:312:368 with SMTP id f20-20020a056402151400b0044803120368mr39817438edw.263.1662391163491;
        Mon, 05 Sep 2022 08:19:23 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id c16-20020a170906925000b0073d9d887eddsm5177440ejx.56.2022.09.05.08.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 08:19:22 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, liviu.dudau@arm.com, brian.starkey@arm.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH RESEND drm-misc-next 3/8] drm/arm/malidp: crtc: use drmm_crtc_init_with_planes()
Date:   Mon,  5 Sep 2022 17:19:05 +0200
Message-Id: <20220905151910.98279-4-dakr@redhat.com>
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

