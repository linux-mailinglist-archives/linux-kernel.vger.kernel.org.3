Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5EFF588EF6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 16:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236029AbiHCOzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 10:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233526AbiHCOzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 10:55:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 910CB193D7
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 07:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659538528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=btnKjqAfvrYASatlMv3xFFZePE1Rwy613UtGW6tgQSI=;
        b=N6XRE1Z10sUH+8dMnCC3dRj9WpYbyytVXQUABcVt/GHo0kOMbN5eK34WcKFVBI4hDrcb7q
        Xuo6x4U3p0sYwLeHYn0aQdYZJxrItSRUblUkxn3NdZTUQ5UPHaW1qUt5RRBK3Zb8BOJfZN
        Z/5lrXLYIeRjKSHNJXI0mpUU5OjUdHA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-657-YrP8f1IEM3SCj8NkH9Y3Xg-1; Wed, 03 Aug 2022 10:55:25 -0400
X-MC-Unique: YrP8f1IEM3SCj8NkH9Y3Xg-1
Received: by mail-ed1-f69.google.com with SMTP id b13-20020a056402350d00b0043dfc84c533so3215589edd.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 07:55:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=btnKjqAfvrYASatlMv3xFFZePE1Rwy613UtGW6tgQSI=;
        b=HkG+TzOrP+oj1Zdp2D5dFTkoIh4KWAlrjFJQlfDWL1nQZE4La7OC5mYXJ5ak4fHHc3
         gcQQTP2ANFqyZd12WIUWk7fa3cxYCaqf83Dpi9ANF1LlD/uxl1S8FkPsS9tU+RFPZkxr
         rFdyOXdnwBL+1yau53tJwp3gpWMZiOeQrf4hI3SL8NF3ZXkC1yixCcuXwqmK8lOoIPW/
         jJxmBMYBTePeNriSLakACGHLMiN4YuWC/L0/WYwfXcnv0PqfZoLwmfQAoaqgxck7UpEe
         JPLKH7zpyDcACTlY9qGiVT3bYL0p2quAVBsJg/hNyaAH/q0Jxi1UnigO1Yln7jW4IHe6
         ZuLw==
X-Gm-Message-State: ACgBeo01+FW907p2pGV1dNbWl884KhM0K++saD/8QFPDVbSavvrz2SJf
        Nh0Pk1I+e7V2pWrO34o0U/0wIHSfjMoA7F76VN+QpA9I93veWNe9i5RpN+ar2/PGp1qje02p3pV
        3AT6zdyaRp1tx39NA+OH3sXpo
X-Received: by 2002:a05:6402:5190:b0:43d:da02:566a with SMTP id q16-20020a056402519000b0043dda02566amr11104234edd.187.1659538523937;
        Wed, 03 Aug 2022 07:55:23 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5s4zMhUjmOaivVKJvZlnxd4uVknAmV6FyDAlsR9bf/U30Fy3lBijhaCbHZBP38GENWJOfkYg==
X-Received: by 2002:a05:6402:5190:b0:43d:da02:566a with SMTP id q16-20020a056402519000b0043dda02566amr11104217edd.187.1659538523722;
        Wed, 03 Aug 2022 07:55:23 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id ee24-20020a056402291800b0043b7917b1a4sm9698411edb.43.2022.08.03.07.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 07:55:23 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     airlied@linux.ie, daniel@ffwll.ch, kraxel@redhat.com,
        sam@ravnborg.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH] drm/virtio: remove drm_plane_cleanup() destroy hook
Date:   Wed,  3 Aug 2022 16:55:20 +0200
Message-Id: <20220803145520.1143208-1-dakr@redhat.com>
X-Mailer: git-send-email 2.37.1
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

drmm_universal_plane_alloc() already registers drm_plane_cleanup() as
managed release action via drmm_add_action_or_reset(). Hence,
drm_plane_cleanup() should not be set as drm_plane_funcs.destroy hook.

Fixes: 7847628862a8 ("drm/virtio: plane: use drm managed resources")
Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_plane.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index c599c99f228e..4c09e313bebc 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -69,7 +69,6 @@ uint32_t virtio_gpu_translate_format(uint32_t drm_fourcc)
 static const struct drm_plane_funcs virtio_gpu_plane_funcs = {
 	.update_plane		= drm_atomic_helper_update_plane,
 	.disable_plane		= drm_atomic_helper_disable_plane,
-	.destroy		= drm_plane_cleanup,
 	.reset			= drm_atomic_helper_plane_reset,
 	.atomic_duplicate_state = drm_atomic_helper_plane_duplicate_state,
 	.atomic_destroy_state	= drm_atomic_helper_plane_destroy_state,
-- 
2.37.1

