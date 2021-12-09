Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACADC46E08F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 02:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbhLICCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 21:02:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbhLICCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 21:02:01 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6FAC061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 17:58:29 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id y7so2839326plp.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 17:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ERNdknSdRVKl939EP+EZZR/PoW0Nj1vOL+LFqLPaFaE=;
        b=VnKZQdzGR1KwvVlbMhJ9w4yN5SAgf36Tsu/EQkyNyyDawfgQ9W+WbDf1o1BNf73lum
         LNDL0ZsH9/EqlAIF4Fno0CGooNpVWAJnpiEx/h4Ps2yE9uCrxI9wfG/Lk9U0XHtDZbSs
         7lpV5zElgJ16wRwhg6Bx9McSbWutm+HQ/EV7H2OlaVe8d0FJv51Mtvtylcg/gy6cq5EZ
         UCrvSfnuFJ23q+ZlJUbDbXF6sJGXVJTDI+jt4mkVgjJUvV9Rz9GXZ3+7dhS5vZXqbAaX
         4C/iBOy85IGRN/mtQhSfYjy4y1x5WLzd60NZGpmQDiFfHv1Kf4Qm0tDulOeOFurPk/Kg
         Eazw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ERNdknSdRVKl939EP+EZZR/PoW0Nj1vOL+LFqLPaFaE=;
        b=B+GkGqiJRRzl6DW/98l4JfUJsA4nHg98iZy5bnaafXmVmCYBpx5RpQ3yqHuWFu9KXt
         y+y3K2YMivecFxFJMRCY2Navz+Zw8yXy7PWRS89IlCCzL5y6gT0LVkWQMwrmyV39+zS5
         Zbk8hpa8bLReReDxcR2uKZr4b3h28YEiCPUGFTFYXB4Oxs44tiwtNnzCrZ6CJ1UQBhqE
         pSROXoCmeQu77tgNZtEosLai9YmanfRatJ9T0UNwUoY2D61VP1SqAGN0Jby1y3HtUWgp
         3qgs1ywq1fY46myY/rDzEamUr4IUqg3ubfE9hbn5Z9wLMvzl9+uow7YLqEXwPQ5VjjLw
         qQxw==
X-Gm-Message-State: AOAM533x19plxUq6+F4EgjblCCQcu+mQy5ZCwUEw8YSgz1hn3H/xMW+5
        F1fdeE2QQLItQHho4A1hSlQ=
X-Google-Smtp-Source: ABdhPJxALjGW3u4AEFGEvQxsHH3WOQo5kRwErZMyqNAPO4fMR36Pgv0iMSHN7+mt1Z/nZUz0vkYO5A==
X-Received: by 2002:a17:902:6a8a:b0:143:905f:aec7 with SMTP id n10-20020a1709026a8a00b00143905faec7mr64773494plk.8.1639015108752;
        Wed, 08 Dec 2021 17:58:28 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id m10sm3619593pgv.75.2021.12.08.17.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 17:58:28 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     alexander.deucher@amd.com
Cc:     christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, chi.minghao@zte.com.cn, Hawking.Zhang@amd.com,
        john.clements@amd.com, Oak.Zeng@amd.com, rajneesh.bhardwaj@amd.com,
        Likun.Gao@amd.com, alex.sierra@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cm>
Subject: [PATCH] drm:amdgpu:remove unneeded variable
Date:   Thu,  9 Dec 2021 01:58:23 +0000
Message-Id: <20211209015823.409947-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: chiminghao <chi.minghao@zte.com.cn>

return value form directly instead of
taking this in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cm>
Signed-off-by: chiminghao <chi.minghao@zte.com.cn>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ioc32.c | 5 +----
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c     | 6 ++----
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ioc32.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ioc32.c
index 5cf142e849bb..fb92f827eeb7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ioc32.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ioc32.c
@@ -37,12 +37,9 @@
 long amdgpu_kms_compat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	unsigned int nr = DRM_IOCTL_NR(cmd);
-	int ret;
 
 	if (nr < DRM_COMMAND_BASE)
 		return drm_compat_ioctl(filp, cmd, arg);
 
-	ret = amdgpu_drm_ioctl(filp, cmd, arg);
-
-	return ret;
+	return amdgpu_drm_ioctl(filp, cmd, arg);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index cb82404df534..269a7b04b7e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1742,7 +1742,7 @@ static int gmc_v9_0_hw_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	bool value;
-	int r, i;
+	int i;
 
 	/* The sequence of these two function calls matters.*/
 	gmc_v9_0_init_golden_registers(adev);
@@ -1777,9 +1777,7 @@ static int gmc_v9_0_hw_init(void *handle)
 	if (adev->umc.funcs && adev->umc.funcs->init_registers)
 		adev->umc.funcs->init_registers(adev);
 
-	r = gmc_v9_0_gart_enable(adev);
-
-	return r;
+	return gmc_v9_0_gart_enable(adev);
 }
 
 /**
-- 
2.25.1

