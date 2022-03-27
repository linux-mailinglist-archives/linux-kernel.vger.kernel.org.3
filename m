Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1D54E85DB
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 07:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234645AbiC0FLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 01:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234486AbiC0FLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 01:11:32 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32F8326D1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 22:09:54 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id o3-20020a17090a3d4300b001c6bc749227so12446117pjf.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 22:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=Z5EKWPKNzm8cvte72SjRtTGquUZgoqCpRIcSt/1/Umc=;
        b=FnYg8OIV24UEG074PlR98g0sAQBcYruqIeBvx2BeyUoc80DP9s3Fh6wm7+IBoxFkrN
         fs5u0bIRN/SKumQOTvt1Pnoo/ijLoT2zs0elPLbCbNZ+Yx9fn+SZBo9JusCnaKCHIL8d
         HfNBXzm2aDM+wvR2hCCqYd5mznYqibR3UAcS+/63FWs5er3Y65rMh9q56sEC7CCx6wPp
         nyak+en+A7F08K3YevlNm11d9Q11D4dE+0uOCM4cVcjdD1Iz2lbJFm66aALvPvBFlljO
         MZ16hBGVD6nY2XPl4JXIC1/KhAljDDi2FgW0rBWPtKxTNKz5aNdz+fkKqiEQt76fblEZ
         UgLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Z5EKWPKNzm8cvte72SjRtTGquUZgoqCpRIcSt/1/Umc=;
        b=bX3nbVgnxEyv6qc4pIrzsbAYZDgJ1FnDt5IU6cgkAI0k/tBg1krFIKY1zrqcDBVk9a
         OvnFKuSiHNIRdXFFJwk+Rj/OZrhzBX6zMXA/u8LwJ94qUBP38Fvcq3kAJY6W6pd59LlJ
         zMuCYiXT8RFEmyCrY0/+c27SC1eqqHM1P//nTU/rw3n4eE1DfPLrv0UlpyODPELcddrP
         kY9IyjPK+MA3XgYeyAUuq1kE6kdY3+KXD72+DW0R0uVrFTChCfvNUll5buQPn97hwmLH
         YIgHadF45Wu/c+nV41FCXkQimV3OgBPGClx4xWqGGE0lO7t7zGh7QAFFdIOIK2XoTO2O
         BREQ==
X-Gm-Message-State: AOAM533a/QF65Wbhy9t/WxoRYjWBUVIMQMdojkSBeduhTQsb/JsHHyOu
        OfpVZQze7EyU+hItW5Yw9RUCQIT4bS7beQ==
X-Google-Smtp-Source: ABdhPJzZI5uxOvxHFTaIAz9af0GpXXF0sc7MoA1wfxo+9D+L4evJjKE+DpgwZgK80tVBlHrlLpW6Bg==
X-Received: by 2002:a17:90a:a58e:b0:1bd:4752:90cf with SMTP id b14-20020a17090aa58e00b001bd475290cfmr22038142pjq.54.1648357794360;
        Sat, 26 Mar 2022 22:09:54 -0700 (PDT)
Received: from localhost.localdomain ([115.220.243.108])
        by smtp.googlemail.com with ESMTPSA id e19-20020a637453000000b003821bdb8103sm9561015pgn.83.2022.03.26.22.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Mar 2022 22:09:53 -0700 (PDT)
From:   Xiaomeng Tong <xiam0nd.tong@gmail.com>
To:     airlied@linux.ie
Cc:     kraxel@redhat.com, gurchetansingh@chromium.org, olvaffe@gmail.com,
        daniel@ffwll.ch, airlied@redhat.com,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Xiaomeng Tong <xiam0nd.tong@gmail.com>
Subject: [PATCH] virtio-gpu: fix a missing check to avoid NULL dereference
Date:   Sun, 27 Mar 2022 13:09:45 +0800
Message-Id: <20220327050945.1614-1-xiam0nd.tong@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'cache_ent' could be set NULL inside virtio_gpu_cmd_get_capset()
and it will lead to a NULL dereference by a lately use of it
(i.e., ptr = cache_ent->caps_cache). Fix it with a NULL check.

Fixes: 62fb7a5e10962 ("virtio-gpu: add 3d/virgl support")
Signed-off-by: Xiaomeng Tong <xiam0nd.tong@gmail.com>
---
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index c708bab555c6..b0f1c4d8fd23 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -579,8 +579,10 @@ static int virtio_gpu_get_caps_ioctl(struct drm_device *dev,
 	spin_unlock(&vgdev->display_info_lock);
 
 	/* not in cache - need to talk to hw */
-	virtio_gpu_cmd_get_capset(vgdev, found_valid, args->cap_set_ver,
+	ret = virtio_gpu_cmd_get_capset(vgdev, found_valid, args->cap_set_ver,
 				  &cache_ent);
+	if (ret)
+		return ret;
 	virtio_gpu_notify(vgdev);
 
 copy_exit:

base-commit: f443e374ae131c168a065ea1748feac6b2e76613
-- 
2.17.1

