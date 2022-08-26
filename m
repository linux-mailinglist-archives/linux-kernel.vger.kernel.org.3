Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73CC15A21B8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 09:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245250AbiHZHYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 03:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245018AbiHZHYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 03:24:37 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0981AD2EB9
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 00:24:37 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id u22so867701plq.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 00:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=YlkUnf3+W4a/WjCpnPyFQgyVY7X5ih8bJPCrzi0qPuo=;
        b=CIW0pGf/u/t99gjOXibOein6cCbSDOUW3AZ6CUaNlRXFkxOg/YJmkgdE6hqISHloQQ
         BAfXaQ/4GGoDH5jUlfb2pB5gCRSePQBZ4jbH4v3djEPpbcgRzwtbVXrXzs6TkKuBxWzl
         N71OqSLmZjNSjNbo+RusFj/7skLKORw8skk1kLDr850IX2oHuy3hPWmYpN5ZteSvfSFx
         +QMgWbJMM1ZFYf8I6yvmsrAjvTqpDaIFTFfHtuXMf0S7mHiWMW9+lOwIGD4f9JRZ0RyP
         +f9LjmSxQMmGKdAshFmwsq8ev5tZcXY36rr+b8f2rcqQ+KOyFatXJnwz5l+sUbKCuKYs
         0KXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=YlkUnf3+W4a/WjCpnPyFQgyVY7X5ih8bJPCrzi0qPuo=;
        b=HX9KqVpYVq4u4lEhzE22VGynZt5A/53WnqtjuiYzrqGsA34qNactlGurlmHRqrpMCr
         6xtpVer6/sTVzbH+C5BlbIs71uFhUvI1gdUaZHlei3Cr61d6I5hSy4IqjDBEOJhmIVFG
         14qDNW7A39Ey6zAKxqVpHUzQEYVx8KcjgJOmX79H/nbt5W23A/vZbV7jE9RavvggTvWv
         kSQ2u0e7RqLohmMqSytgqPaHdLHoWyjl/fJLFBb+FqZLhzTe3/mfUUzVuABC2t8zPCqV
         qGG0CDJbvyY7vDZNzceQHRtJMTdaALpuLgh0UbSU+mejj81JEgMFeGYhErRBJ6z5NvC7
         LlqQ==
X-Gm-Message-State: ACgBeo1sIw0PwhaxsOd/zFrgTvh0ZywlPKn6HAxJg3kTSJ7ATgj4GFNF
        6W94BHkU7ZJJ+fgbVtPVQvE=
X-Google-Smtp-Source: AA6agR5HyqBo0oZgQZZq5UC/wOzHLibv7ZVIrS6bRpCelNOCiG5Rg5WRYYINvIpRdM12ePAv0ZNXOQ==
X-Received: by 2002:a17:90a:5988:b0:1fd:6a33:abf with SMTP id l8-20020a17090a598800b001fd6a330abfmr715935pji.69.1661498676588;
        Fri, 26 Aug 2022 00:24:36 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id o186-20020a62cdc3000000b005289a50e4c2sm930463pfg.23.2022.08.26.00.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 00:24:36 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     alexander.deucher@amd.com
Cc:     christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, Hawking.Zhang@amd.com, Jack.Xiao@amd.com,
        guchun.chen@amd.com, Prike.Liang@amd.com, ricetons@gmail.com,
        Bokun.Zhang@amd.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] drm/amdgpu: Remove the unneeded result variable
Date:   Fri, 26 Aug 2022 07:23:57 +0000
Message-Id: <20220826072357.252676-1-ye.xingchen@zte.com.cn>
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

From: ye xingchen <ye.xingchen@zte.com.cn>

Return the value sdma_v5_2_start() directly instead of storing it in
another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 83c6ccaaa9e4..95689ef4be10 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1413,12 +1413,9 @@ static int sdma_v5_2_sw_fini(void *handle)
 
 static int sdma_v5_2_hw_init(void *handle)
 {
-	int r;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	r = sdma_v5_2_start(adev);
-
-	return r;
+	return sdma_v5_2_start(adev);
 }
 
 static int sdma_v5_2_hw_fini(void *handle)
-- 
2.25.1
