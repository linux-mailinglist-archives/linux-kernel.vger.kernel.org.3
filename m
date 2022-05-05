Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AECFF51B5A7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 04:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237412AbiEECOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 22:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbiEECOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 22:14:42 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9A347399
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 19:11:04 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id j6so2515104pfe.13
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 19:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2JXqprHTSEwVqmxQ6E6dnaH9uepTywYAN4NcxLuZd6g=;
        b=BahfpvWfsZ5f932IPUJ2jABGavlcF1WDZZRQ1xqDVsDdv6eSrvo3aDFJKKKlW991/A
         QHBtOcY3VCtoHQTideoAXZigBBTPmmLNCh7gj8PPuqDL7getPhkiOxQGMhoh8AAwWVb7
         /0d8S/e63i68BJcrSa8koua2Reqb17gA1yKlM6KjVXnTSxhhHgUw0oqAxwcDpFBWXqiq
         Nac/PyrdR/EP3o+qf8AgOKKxmvu5rOYC/9a6f1+Yl4Kri1iPyhccktjHa/tWEJMGsM/a
         VxFKKBS6Ok7j25IFXwbIP70FzDCEXatGVpfFK/n7+uspR+zc7G0qTV1EeEgI+ifo4lyZ
         DyHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2JXqprHTSEwVqmxQ6E6dnaH9uepTywYAN4NcxLuZd6g=;
        b=nYBJzsJDwz2kmOXUQuKjgOUqPNZJBOOaBgjLB/zha7O9ptcSLuWgPeZrny55AOcfYO
         YI19hr7JhBwUsxgrhhAzvR+47pDxxaY+RLozKEgFGzWd8K8fB9G0XZpUT5ZbcDqXe3P/
         iTknPuvXnLqf2TOkLzv/j+VEghDLR2zfg0n0hlxBrFmQNpVU3dJjdDLNWl6cXrbKz6h3
         zaxrNCubuRajKidMWOOgexoqNa9N+AVP8p2LTJ+0LkCIAQ8l0hNgJQXd1dLvz80Cnqdg
         OauGRkw3X9nn77expJ4jc20S0seBlyhwEcYoh5I6ecEeNwg9wT4ihrKRGmzxnW71G+pE
         PNNw==
X-Gm-Message-State: AOAM531xBXLgsmdW/z2FZBjaZ7EERtIUUWsaSozWoi9fkHEUoN1MxSO7
        Rhetqivw75VyRzA/Co63zb6ySlI4tw4=
X-Google-Smtp-Source: ABdhPJxAiLJ63+QLwKXUbnFKKWPgiJBSXZs2RaHbatNjT2OEkLNBoKx5qJaZbbQSUW6AwyU4PsilqA==
X-Received: by 2002:a63:e60b:0:b0:3c2:2450:135a with SMTP id g11-20020a63e60b000000b003c22450135amr14174847pgh.8.1651716664263;
        Wed, 04 May 2022 19:11:04 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id p13-20020a170902a40d00b0015e8d4eb200sm186977plq.74.2022.05.04.19.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 19:11:02 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     alexander.deucher@amd.com
Cc:     christian.koenig@amd.com, Xinhui.Pan@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] drm/amdgpu: simplify the return expression
Date:   Thu,  5 May 2022 02:10:57 +0000
Message-Id: <20220505021057.54044-1-chi.minghao@zte.com.cn>
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

From: Minghao Chi <chi.minghao@zte.com.cn>

Simplify the return expression.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 54446162db8b..3d8093bf1679 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4688,7 +4688,6 @@ static void gfx_v10_0_gpu_early_init(struct amdgpu_device *adev)
 static int gfx_v10_0_gfx_ring_init(struct amdgpu_device *adev, int ring_id,
 				   int me, int pipe, int queue)
 {
-	int r;
 	struct amdgpu_ring *ring;
 	unsigned int irq_type;
 
@@ -4708,17 +4707,13 @@ static int gfx_v10_0_gfx_ring_init(struct amdgpu_device *adev, int ring_id,
 	sprintf(ring->name, "gfx_%d.%d.%d", ring->me, ring->pipe, ring->queue);
 
 	irq_type = AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP + ring->pipe;
-	r = amdgpu_ring_init(adev, ring, 1024, &adev->gfx.eop_irq, irq_type,
+	return amdgpu_ring_init(adev, ring, 1024, &adev->gfx.eop_irq, irq_type,
 			     AMDGPU_RING_PRIO_DEFAULT, NULL);
-	if (r)
-		return r;
-	return 0;
 }
 
 static int gfx_v10_0_compute_ring_init(struct amdgpu_device *adev, int ring_id,
 				       int mec, int pipe, int queue)
 {
-	int r;
 	unsigned irq_type;
 	struct amdgpu_ring *ring;
 	unsigned int hw_prio;
@@ -4743,12 +4738,8 @@ static int gfx_v10_0_compute_ring_init(struct amdgpu_device *adev, int ring_id,
 	hw_prio = amdgpu_gfx_is_high_priority_compute_queue(adev, ring) ?
 			AMDGPU_RING_PRIO_2 : AMDGPU_RING_PRIO_DEFAULT;
 	/* type-2 packets are deprecated on MEC, use type-3 instead */
-	r = amdgpu_ring_init(adev, ring, 1024, &adev->gfx.eop_irq, irq_type,
+	return amdgpu_ring_init(adev, ring, 1024, &adev->gfx.eop_irq, irq_type,
 			     hw_prio, NULL);
-	if (r)
-		return r;
-
-	return 0;
 }
 
 static int gfx_v10_0_sw_init(void *handle)
-- 
2.25.1


