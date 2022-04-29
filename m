Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7AE514487
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 10:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355951AbiD2Iql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 04:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355906AbiD2Iqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 04:46:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0FE063879C
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 01:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651221792;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fRMcUIWA7sdzgB28q5eAL1IlJEzmKZ6fC0UlacasRt0=;
        b=UCplvL+EkJWURtHzbVLo9qYpdMdjmn6PKm2lOzklHdcTZQTwj2xzaZUHY54waC1dvTyaOi
        O5yyL66zLuEm37UWSBga5JfM/ujuMzOCdNQQtV7wMCg7NNAp3SuSQD/y3iKyn5QlEb8Zej
        H+11p7/OjJVR6Quf/+5GGKHTkEDxajM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-374-l-j7c1JYPxOJ7UXjlmp09w-1; Fri, 29 Apr 2022 04:43:10 -0400
X-MC-Unique: l-j7c1JYPxOJ7UXjlmp09w-1
Received: by mail-wr1-f71.google.com with SMTP id v13-20020adfc5cd000000b0020ad3580cd0so2808240wrg.10
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 01:43:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fRMcUIWA7sdzgB28q5eAL1IlJEzmKZ6fC0UlacasRt0=;
        b=LW5r0q4KO9ec3q06gbRIIgDmEjd/gHAY4yJP5J7dlC7DnnGsKbF4qyLRlnNE4yl7b3
         jLKe+8qis+zl4XqWLUK0s65te/U3ped6dtAfD3I0ofkcIBarCdxGK7xKIGUj8+t1WnX0
         X1iUVlABU0tpb+fOTIx3lr/m7sZHkStKdQLSMnBxRZH5y9NFqYTo33YheX5jPwgR007J
         U24NHoC0W8IjZKitL+dpWScwT8rjNZ+2lbWCneDRAWIy3Pr7iNPQzzwcsMZAgwMLZwhq
         acQKzs2P0xNQF6FMHhrZ0pQJQ1jb8DP2lUU+ev5eveS1X8p3W0V5+0IaqihmkZ9XWoCp
         7f2A==
X-Gm-Message-State: AOAM531ZQ4OFIGWt6LVfPffhdNkwKebi0N6CkNwA05eYjNCEpEi1Ooaf
        S0jOdbF0Gne/ahg7N2t4hGzf/5LAQRtg4mrkwSBdnx2HuuyWmifs1I1PHNh1HnwQSdeAn0ZXbqn
        oRsXjN8aE44l/MClY+Iw1cfHzmcmMQAMqIHCgqgxFZhfH17V6sVo4nEq8ugk8aN/OHtvYERXCtL
        Q=
X-Received: by 2002:adf:decb:0:b0:20a:c975:8eec with SMTP id i11-20020adfdecb000000b0020ac9758eecmr28945546wrn.438.1651221789496;
        Fri, 29 Apr 2022 01:43:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwtZEVR1B2SxYUlJMQTPPXV31wb/4bFJp+yeoC7Nu0Cucm9c+snWTdOciLZN/4zm1HB6AokFA==
X-Received: by 2002:adf:decb:0:b0:20a:c975:8eec with SMTP id i11-20020adfdecb000000b0020ac9758eecmr28945524wrn.438.1651221789280;
        Fri, 29 Apr 2022 01:43:09 -0700 (PDT)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f7-20020a05600c4e8700b00393f1393abfsm7199256wmq.41.2022.04.29.01.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 01:43:08 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>
Subject: [RFC PATCH v4 02/11] drm/fb-helper: Set FBINFO_MISC_FIRMWARE flag for DRIVER_FIRMWARE fb
Date:   Fri, 29 Apr 2022 10:42:44 +0200
Message-Id: <20220429084253.1085911-3-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429084253.1085911-1-javierm@redhat.com>
References: <20220429084253.1085911-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DRIVER_FIRMWARE flag denotes that a DRM driver uses a framebuffer
that was initialized and provided by the system firmware for scanout.

Indicate to the fbdev subsystem that the registered framebuffer is a
FBINFO_MISC_FIRMWARE, so that it can handle accordingly. For example,
wold hot-unplug the associated device if asked to remove conflicting
framebuffers.

Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

(no changes since v1)

 drivers/gpu/drm/drm_fb_helper.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index d265a73313c9..76dd11888621 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -1891,6 +1891,10 @@ __drm_fb_helper_initial_config_and_unlock(struct drm_fb_helper *fb_helper,
 		/* don't leak any physical addresses to userspace */
 		info->flags |= FBINFO_HIDE_SMEM_START;
 
+	/* Indicate that the framebuffer is provided by the firmware */
+	if (drm_core_check_feature(dev, DRIVER_FIRMWARE))
+		info->flags |= FBINFO_MISC_FIRMWARE;
+
 	/* Need to drop locks to avoid recursive deadlock in
 	 * register_framebuffer. This is ok because the only thing left to do is
 	 * register the fbdev emulation instance in kernel_fb_helper_list. */
-- 
2.35.1

