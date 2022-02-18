Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70A174BBFF8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 19:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234604AbiBRSyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 13:54:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbiBRSyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 13:54:09 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9888D1F05DF
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 10:53:52 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id w20so7841687plq.12
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 10:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=McwjLSLaytCtK7tV2i/coh6cpneHZuWc7h/cZMMLVaQ=;
        b=qS5kgw9dlzff3cynK7hHxw9gR3U0R6hubv+YKcGJnsGj3VYm2oM+4O8weoW2p2sZyw
         c20WORhh8vLskTonGbwQkhF8S2qVv87wVcmcCnpfCuniNqBKPpM3SHHkZI1UBVKT3hdc
         /YYE0ThFOusvkuKpKTcnSmn257veUPiLnnl1YAaAZJfOWUdbvmQIunP9HnqoMI57Y1p3
         wrQfbe6PsnVJTG7l7cwGBJAlOs7W0U1A2yfEgqIt4vCTpNWdhS6rmjOn1/dRvj6lItI7
         5a4xFx3R6iXDH5namFQ8U8M1i30J62YRRSyRjFQ671TIwRe1D0dHHSvemmvCUID/eKhv
         rtrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=McwjLSLaytCtK7tV2i/coh6cpneHZuWc7h/cZMMLVaQ=;
        b=YTORiU7TjSP5qKK+TB31p463yeOZcMd5TiK7iQYR1qWeb97IvadA4GeJ4HTTrzyaMz
         /qkElveBIIMxCQZigsH++2+1eLOydMfatS9ymFkkq7zB2RBph3Igv8ZbFAr+CXP0Io6k
         njxWS9qhVxvfJ4aYAn5MZgBAciZ/7z6EQN0M8SbGv07TOmMLzjcTsw/eAgEzvZ4W6xq9
         55qs4joK60t2BYFnmFEFoLNksZcqHlqqkR7MHuKVyZZ+EZ7UpjoBiMjGF6WfpmsU9JKv
         4ZBi529DiVORRW4SaT9UgDd/5OtItMIsnM3sYruhfxgCu2LoBU8RdTrwBZcdWMyIkzZv
         v83w==
X-Gm-Message-State: AOAM531NZg8Q5rM1gSnrDLptSdov0OpgUS/Fts3ryJdQtEoE5dNKMAgm
        7VBVz6WGsQ7gV/Q2fQ7RrrM=
X-Google-Smtp-Source: ABdhPJzQQSZPxtLkIpcflnhLn+ubFoe7B07qM/ToZ1Aq0GEshzZY7TCT7UmLcClTvTCsiaUJa7UVgQ==
X-Received: by 2002:a17:902:da82:b0:14d:c6d8:822f with SMTP id j2-20020a170902da8200b0014dc6d8822fmr8509644plx.55.1645210432081;
        Fri, 18 Feb 2022 10:53:52 -0800 (PST)
Received: from localhost.localdomain ([2405:201:9005:88cd:7443:8052:dc37:e678])
        by smtp.gmail.com with ESMTPSA id p2sm125106pjo.38.2022.02.18.10.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 10:53:51 -0800 (PST)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        nathan@kernel.org, desaulniers@google.com, Felix.Kuehling@amd.com,
        Oak.Zeng@amd.com, nirmoy.das@amd.com, jonathan.kim@amd.com,
        kevin1.wang@amd.com, tzimmermann@suse.de, Philip.Yang@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        "Souptick Joarder (HPE)" <jrdr.linux@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] drm/amdgpu: Initialize value of r in amdgpu_fill_buffer()
Date:   Sat, 19 Feb 2022 00:23:12 +0530
Message-Id: <20220218185312.34464-1-jrdr.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Souptick Joarder (HPE)" <jrdr.linux@gmail.com>

Kernel test robot reported warning ->
drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2129:2: warning: Undefined
or garbage value returned to caller [clang-analyzer-core.
uninitialized.UndefReturn]

Initialize r inside amdgpu_fill_buffer().

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Souptick Joarder (HPE) <jrdr.linux@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 414a22dddc78..5fafb223177f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2089,7 +2089,7 @@ int amdgpu_fill_buffer(struct amdgpu_bo *bo,
 	struct amdgpu_ring *ring = adev->mman.buffer_funcs_ring;
 	struct dma_fence *fence = NULL;
 	struct amdgpu_res_cursor dst;
-	int r;
+	int r = 0;
 
 	if (!adev->mman.buffer_funcs_enabled) {
 		DRM_ERROR("Trying to clear memory with ring turned off.\n");
-- 
2.25.1

