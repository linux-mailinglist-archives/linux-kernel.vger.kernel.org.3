Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4551A4F9008
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 09:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbiDHIAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 04:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbiDHIAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 04:00:24 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B42101F19
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 00:58:20 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id j9so5598623lfe.9
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 00:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LDg0VuOdkCKm0C8uZKp3vKpTf/VpsO8U9ed6vcjhQTo=;
        b=TAfmtGR4a9a3jgYPSlQ7/KHOY55cHJ2ZPH+9tvKC7XSRQzemgPxT5uuo5NqPmlMrYb
         g7/2IJN9Xzw2TASKcNKcaffTQV8aDR6Vbb4hDIMyK0Mdujx5V4YWTFmXzhnZvDk2UlIi
         tgWzh1dy3QsKgBEpmqFUlP9Bmrxw6qzurk0R1TofqqHib2TrmWnkKE2A/1xWbAcemmnw
         Lbuk3qPIMCx7WSAaZSshBYhR7x+Rhla24TRiM++omihK0V4+pxuPlvFwQyA3OKBaaoKd
         c3z1qXih8x1kjR1ndEVUZej/p/Cne/Zo0XrpIJQLX+9KhYKPnvy4amdrAX6U/aqAnFD6
         9oCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LDg0VuOdkCKm0C8uZKp3vKpTf/VpsO8U9ed6vcjhQTo=;
        b=3JZMCNIt+i0fb3tslGLDPCUp6XOUfinxZE+XfMlXzvIWfX3pq385JGvJ0k57GrG3Px
         y+lNuV62wYuJX0hhYAn/t6dVzkS/HHkuyKqtxXEnZbs3cCns4CAbx9+6yA9WP3Um/wzB
         SmxPwJB7os3/kWn7j5rcVCfIxQyG0lZC7htKnIVNQN6FFPkld0kB3Zodt+OXAw2xY+WY
         nakXuCv4lSRexTJ74hMqJZPXhjcAslbf0G12HFGeE0AoTiv0asWMb1Wn/b2MNQUeRQ1d
         pU2h07vMf1UdDgeJec8ZL5Iansf/guRo7nvdCGrPTa8u4qsMcG8L1Y+3RJ/BMwndE0UE
         Ac7g==
X-Gm-Message-State: AOAM530sOhLLH6PxapOHG56y3F7k9QqdZOORc+8aPtotJCZx0Y4ABCUB
        nj/+pvaEKEfctP76NsxevzQ=
X-Google-Smtp-Source: ABdhPJyYta5aydqTXUvGMWiC0TCQ8PlSIHqgPbTB0TDQ6KifZ6JROMRtolpO3so0hsiB92awnmsKrg==
X-Received: by 2002:a19:f00f:0:b0:443:ae5c:47d0 with SMTP id p15-20020a19f00f000000b00443ae5c47d0mr12061146lfc.332.1649404698181;
        Fri, 08 Apr 2022 00:58:18 -0700 (PDT)
Received: from noname.. ([2a02:2698:8c2a:149d:6d9:f5ff:fecb:a8ab])
        by smtp.googlemail.com with ESMTPSA id g9-20020a2e9cc9000000b0024afe85d0c8sm2170520ljj.121.2022.04.08.00.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 00:58:17 -0700 (PDT)
From:   Grigory Vasilyev <h0tc0d3@gmail.com>
To:     Rodrigo.Siqueira@amd.com, Melissa Wen <mwen@igalia.com>
Cc:     Grigory Vasilyev <h0tc0d3@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Tao Zhou <tao.zhou1@amd.com>, Huang Rui <ray.huang@amd.com>,
        Peng Ju Zhou <PengJu.Zhou@amd.com>,
        Evan Quan <evan.quan@amd.com>,
        Chengming Gui <Jack.Gui@amd.com>,
        Yifan Zhang <yifan1.zhang@amd.com>,
        Guchun Chen <guchun.chen@amd.com>,
        Joseph Greathouse <Joseph.Greathouse@amd.com>,
        yipechai <YiPeng.Chai@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
        Victor Skvortsov <victor.skvortsov@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu: Fix incorrect enum type
Date:   Fri,  8 Apr 2022 10:58:17 +0300
Message-Id: <20220408075820.10396-1-h0tc0d3@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of the 'amdgpu_ring_priority_level' type,
the 'amdgpu_gfx_pipe_priority' type was used,
which is an error when setting ring priority.
This is a minor error, but may cause problems in the future.

Instead of AMDGPU_RING_PRIO_2 = 2, we can use AMDGPU_RING_PRIO_MAX = 3,
but AMDGPU_RING_PRIO_2 = 2 is used for compatibility with
AMDGPU_GFX_PIPE_PRIO_HIGH = 2, and not change the behavior of the
code.

Signed-off-by: Grigory Vasilyev <h0tc0d3@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index b3081c28db0a..1d9120a4b3f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4745,7 +4745,7 @@ static int gfx_v10_0_compute_ring_init(struct amdgpu_device *adev, int ring_id,
 		+ ((ring->me - 1) * adev->gfx.mec.num_pipe_per_mec)
 		+ ring->pipe;
 	hw_prio = amdgpu_gfx_is_high_priority_compute_queue(adev, ring) ?
-			AMDGPU_GFX_PIPE_PRIO_HIGH : AMDGPU_GFX_PIPE_PRIO_NORMAL;
+			AMDGPU_RING_PRIO_2 : AMDGPU_RING_PRIO_DEFAULT;
 	/* type-2 packets are deprecated on MEC, use type-3 instead */
 	r = amdgpu_ring_init(adev, ring, 1024, &adev->gfx.eop_irq, irq_type,
 			     hw_prio, NULL);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 5554084ec1f1..9bc26395f833 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -1929,7 +1929,7 @@ static int gfx_v8_0_compute_ring_init(struct amdgpu_device *adev, int ring_id,
 		+ ring->pipe;
 
 	hw_prio = amdgpu_gfx_is_high_priority_compute_queue(adev, ring) ?
-			AMDGPU_GFX_PIPE_PRIO_HIGH : AMDGPU_RING_PRIO_DEFAULT;
+			AMDGPU_RING_PRIO_2 : AMDGPU_RING_PRIO_DEFAULT;
 	/* type-2 packets are deprecated on MEC, use type-3 instead */
 	r = amdgpu_ring_init(adev, ring, 1024, &adev->gfx.eop_irq, irq_type,
 			     hw_prio, NULL);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 71cf025a2bbd..029c97c92463 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2278,7 +2278,7 @@ static int gfx_v9_0_compute_ring_init(struct amdgpu_device *adev, int ring_id,
 		+ ((ring->me - 1) * adev->gfx.mec.num_pipe_per_mec)
 		+ ring->pipe;
 	hw_prio = amdgpu_gfx_is_high_priority_compute_queue(adev, ring) ?
-			AMDGPU_GFX_PIPE_PRIO_HIGH : AMDGPU_GFX_PIPE_PRIO_NORMAL;
+			AMDGPU_RING_PRIO_2 : AMDGPU_RING_PRIO_DEFAULT;
 	/* type-2 packets are deprecated on MEC, use type-3 instead */
 	return amdgpu_ring_init(adev, ring, 1024, &adev->gfx.eop_irq, irq_type,
 				hw_prio, NULL);
-- 
2.35.1

