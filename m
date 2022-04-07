Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27FE4F896B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 00:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbiDGUmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 16:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbiDGUln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 16:41:43 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5773A35FB55;
        Thu,  7 Apr 2022 13:27:40 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id n9so6055019plc.4;
        Thu, 07 Apr 2022 13:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kJceoc9W0NY6WQcLWDMIjUqaSV6YiSwG7eotLlprMMg=;
        b=QJu7DvN0eWTomcuK6UZ/vOM3RvOr+ZoXAeWbsasj4HCWNICOkIgYYpSkqlbswtVm1z
         Acy1HWO3rk9a983uxCW0/xcfkEMMp8FFtfk79qp5tMrrmH9JsBsy9n4c6fEVVnFw+K3/
         n1JFF8CE6pHhcISKrcAohYImmD3QcJSmYFRQRHje790xtHkylQiO8spF6Pgdl48Ve7aN
         psUslbw8LIksxjefWNb3VVI23vM0UpeObvySgkOFDDRBbnGq5zrH72S1PBN6L1xpg3Vl
         jtYEkc9P6l1InTcglroX/L7LL24Fpsxw6KQzm8sRSl3QYGOOmbhosKRWgQtuyy8i6BSD
         eogw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kJceoc9W0NY6WQcLWDMIjUqaSV6YiSwG7eotLlprMMg=;
        b=RQYTgNbL7b8lArSE5+dBT61ESMfJ6Z+3vNCTPiTOtnROXGnLUROeFODdEvpPVK/f0b
         BqxJA+Ne54GVpbAcrhM/NFexFllJioicMvpljXGIuWSg0V3SKLmweo6jnrjYPI3U2Ij/
         Xuj59rGHDH5gkC5oLQlsEZgAXEpf8RlH8/YeNWwoMDYNPLiewA5Smrt3unugdmFKCNlG
         0uhV5yshXUKVbTSYkYbeOsNWqw8/sWGGjemAQ7sH7F3fNUlWKe/D6JE4tRg6g2Br8eyB
         BR5WtI9eBZfyziZAIoIlg6u+SMX7M0FenTODEEKGsRppi6wrq897XPGX5piWEvTEkk5O
         OkJw==
X-Gm-Message-State: AOAM530IRODXjMSSqa3r4W0XlkI+vqZrBWzkkhc6A7Xqglny11+xpTyB
        yvB19Inct+EqiWgSLbBqIss=
X-Google-Smtp-Source: ABdhPJxZXljtWG1ZL15O/6dRhB5QKE8O289YejrO4KoHkde3SlpynJRKXjvUmXAJbl+CD0L7QvChaQ==
X-Received: by 2002:a17:902:8b88:b0:156:2b14:cb6e with SMTP id ay8-20020a1709028b8800b001562b14cb6emr15911211plb.14.1649363259814;
        Thu, 07 Apr 2022 13:27:39 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id ng17-20020a17090b1a9100b001c9f79927bfsm10251800pjb.25.2022.04.07.13.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 13:27:38 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/msm: Fix range size vs end confusion
Date:   Thu,  7 Apr 2022 13:28:33 -0700
Message-Id: <20220407202836.1211268-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.35.1
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

From: Rob Clark <robdclark@chromium.org>

The fourth param is size, rather than range_end.

Note that we could increase the address space size if we had a way to
prevent buffers from spanning a 4G split, mostly just to avoid fw bugs
with 64b math.

Fixes: 84c31ee16f90 ("drm/msm/a6xx: Add support for per-instance pagetables")
Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 17de46fc4bf2..80d57608b34a 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1742,7 +1742,7 @@ a6xx_create_private_address_space(struct msm_gpu *gpu)
 		return ERR_CAST(mmu);
 
 	return msm_gem_address_space_create(mmu,
-		"gpu", 0x100000000ULL, 0x1ffffffffULL);
+		"gpu", 0x100000000ULL, SZ_4G);
 }
 
 static uint32_t a6xx_get_rptr(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
-- 
2.35.1

