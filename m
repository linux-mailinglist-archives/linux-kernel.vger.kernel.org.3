Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC27537000
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 08:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbiE2G0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 02:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiE2G0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 02:26:43 -0400
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995ED655F
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 23:26:41 -0700 (PDT)
Received: by mail-pj1-f66.google.com with SMTP id v11-20020a17090a4ecb00b001e2c5b837ccso1457165pjl.3
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 23:26:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nAodg8IpCf1YlPCwEY/9oZB3Kk0d9gb9lVermXkWYgQ=;
        b=Z4WxoEZlCnEh/y1SI1t01qmuDfJ5QYethtvW6jZZjfTqVHfJm6p6pZd2t6GDTF6t7V
         hsAEgPrlO8rQttz8Gjrb1GST6pYYGoWWuvpFhEHR3/aqaIsSjyTCY5PK/d6r4TB1Rxkn
         Wfca8ev68s4UE1eXsEmm6M8vWT5iisX/J67NwiEYx9v5bCCrT6FZ21LuuvkY0/NEFug7
         GE8JXTQyisxLg7dXqhVRljTV+dqlro1ytpWERCnZXqMQV4B/pgr+sufMMI7MxvW+IAP1
         S6XCz06QDfK3dNgtH1HQHg1Q7igdmz+MXTUpjvSxJ5wz1TTTGvu7rJYRsr5Xmep8B/PD
         LxzQ==
X-Gm-Message-State: AOAM532rSKYNMvGDJlsp/RwkQHlfqXoYmteZxMSa0HdfP0REhXIEkWqV
        FlD/o3FV42sMyfHstY24gw==
X-Google-Smtp-Source: ABdhPJzlemj8sWhGGFITlnMkOA8aFFrOc3HF39ff43T9ebwbkrJKKloZRH00669Xb65j2g2+PtbrOg==
X-Received: by 2002:a17:903:2c7:b0:158:2f26:6016 with SMTP id s7-20020a17090302c700b001582f266016mr50903382plk.154.1653805601094;
        Sat, 28 May 2022 23:26:41 -0700 (PDT)
Received: from localhost.localdomain (ns1003916.ip-51-81-154.us. [51.81.154.37])
        by smtp.gmail.com with ESMTPSA id x12-20020a170902ec8c00b00161955fe0d5sm6761554plg.274.2022.05.28.23.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 May 2022 23:26:40 -0700 (PDT)
From:   sunliming <sunliming@kylinos.cn>
To:     alexander.deucher@amd.com, hristian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        Hawking.Zhang@amd.com, mike@fireburn.co.uk, Xiaojian.Du@amd.com,
        evan.quan@amd.com
Cc:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, sunliming@kylinos.cn,
        kelulanainsley@gmail.com, kernel test robot <lkp@intel.com>
Subject: [PATCH] drm/amdgpu: make gfx_v11_0_rlc_stop static
Date:   Sun, 29 May 2022 14:26:31 +0800
Message-Id: <20220529062631.304316-1-sunliming@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This symbol is not used outside of gfx_v11_0.c, so marks it static.

Fixes the following w1 warning:

drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:1945:6: warning: no previous
prototype for function 'gfx_v11_0_rlc_stop' [-Wmissing-prototypes].

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: sunliming <sunliming@kylinos.cn>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 8c0a3fc7aaa6..cb581cfc7464 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1983,7 +1983,7 @@ static int gfx_v11_0_init_csb(struct amdgpu_device *adev)
 	return 0;
 }
 
-void gfx_v11_0_rlc_stop(struct amdgpu_device *adev)
+static void gfx_v11_0_rlc_stop(struct amdgpu_device *adev)
 {
 	u32 tmp = RREG32_SOC15(GC, 0, regRLC_CNTL);
 
-- 
2.25.1

