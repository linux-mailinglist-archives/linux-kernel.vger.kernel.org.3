Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B95566745
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 12:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbiGEKCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 06:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbiGEKCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 06:02:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F36E713F14
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 03:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657015358;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=G6JwN6kDh1no423YdXFobnm9id4clHpuSWy/fs9OcOQ=;
        b=G7ztEvmBX/gfAJ6JkPFFBW7/pDjuEOdAvyfZvbqVeVExT2nlOWQdx8uqScT9X75vXhEylR
        oPl0VnQFY2Nj/E9QS75OCQpj8kFKwDPjuHk/x+Twyr/lkHPQr+EJaBn34JbAI5YqdQIl4U
        Hby1ACsahTCwcv6JWc1GAvqjiQk+hBU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-374-vPkl0omkP6Kt3mJNKc2yIw-1; Tue, 05 Jul 2022 06:02:36 -0400
X-MC-Unique: vPkl0omkP6Kt3mJNKc2yIw-1
Received: by mail-wm1-f69.google.com with SMTP id r128-20020a1c4486000000b003a2b44d876aso1829295wma.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 03:02:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G6JwN6kDh1no423YdXFobnm9id4clHpuSWy/fs9OcOQ=;
        b=OBjmYiZlxzqg5v3HrLPgSKvCxOs3+jXBYwu8xOCS7Pw9AD18j62tmJR2693/gSg1Wr
         e8ftbbe7sx/XT5gtncWM/fGeTOO1g6HEfzuxkNzPmMq0ina9CV9wH9MTvvqVjQahB9Qn
         axtf05a17ylz+JFfr1qL9drXHfWg7yZ90qVR7oPJgj+liKUJesDkdJ2PRSDm+wjrxGIL
         TFcMePI9desw0QwJw4/sY/woaYVC2XC8UpijrqaI6EnfyQnp175fxuzxjOgprHNkuy70
         P0QeUxmEBfSJUasFgHMvVIOo614FanWsk7LOaUGzZdho3Kh8SWy/IfTgnaaKURO1vqps
         1F3A==
X-Gm-Message-State: AJIora/Fop002P5s6EZEq/JgF+OiWf1KfA++RVfn3Fh0yYJQJ51Zob8f
        68taqmXxAbY1vN69JKb4KNoHPyQRMFQQGjyKDzsif5BzDXj3LGktLSXyMiy+0euZq6b2GbT6XHr
        EKTxVpwd3i9cZzdKcsf1XWFEhJC0n0i//lctXHvAeeHKK+yJoahs0B5m7HZKeSwHP5lu4eVjKgZ
        0=
X-Received: by 2002:a05:600c:b46:b0:3a0:4a51:bb1d with SMTP id k6-20020a05600c0b4600b003a04a51bb1dmr35510726wmr.168.1657015355229;
        Tue, 05 Jul 2022 03:02:35 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1s4/g0sBLSbisYhUn+RXPZDCB5AgKAg4Q6dmtoJohq3UxfdprzXO1/tSDYsherbyMS9/qjKLw==
X-Received: by 2002:a05:600c:b46:b0:3a0:4a51:bb1d with SMTP id k6-20020a05600c0b4600b003a04a51bb1dmr35510693wmr.168.1657015354905;
        Tue, 05 Jul 2022 03:02:34 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f7-20020a0560001b0700b0021d68e1fd42sm6255192wrz.89.2022.07.05.03.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 03:02:34 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2 0/2] drm: A couple of fixes for drm_copy_field() helper function
Date:   Tue,  5 Jul 2022 12:02:12 +0200
Message-Id: <20220705100215.572498-1-javierm@redhat.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Peter Robinson reported me a kernel bug in one of his aarch64 test boards
and even though I was not able to reproduce it, I think that figured out
what the problem was. It seems the cause is that a DRM driver doesn't set
some of the struct drm fields copied to userspace via DRM_IOCTL_VERSION.

Even though this is a driver bug, we can make drm_copy_field() more robust
and warn about it instead of leading to an attempt to copy a NULL pointer.

While looking at this, I also found that a variable in drm_copy_field() is
not using the correct type. So I included that change in the patch-set too.

Best regards,
Javier

Changes in v2:
- Add Peter Robinson Tested-by and Thomas Zimmermann Reviewed-by tags.
- Just warn if a value isn't set and report it as a string of length 0.
  (Thomas Zimmermann).

Javier Martinez Canillas (2):
  drm: Use size_t type for len variable in drm_copy_field()
  drm: Prevent drm_copy_field() to attempt copying a NULL pointer

 drivers/gpu/drm/drm_ioctl.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

-- 
2.36.1

