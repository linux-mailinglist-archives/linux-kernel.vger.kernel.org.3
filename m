Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3A7524C8F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 14:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353608AbiELMUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 08:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350859AbiELMUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 08:20:07 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F316A2469FB;
        Thu, 12 May 2022 05:20:06 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id x8so1011920pgr.4;
        Thu, 12 May 2022 05:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gorQKMV8vjkGqwI8nCYg+SRESNs1085GlQg2z0ABeuo=;
        b=PCIAmCovw7OM0hTE2W4qOGNoxgxbBpg8KbeHu/5PSSdoArfiqGcBFNMc5XU5LAmjWl
         qLIwnwagkjm97pU8rRUANECE9AWjEczeWiXwd/Rz0Tf3/VBSH/XCoEDJ3IwW/QKn7ic5
         H3kqIR/LdW7GiKoqf42m6g4CZjkjoznsTNeAmqvmG2ii4RPHiOIGQyC8fBl80KFMX/5w
         3QQIscHoSk+TavN5oSPvjcQGUZBdku+hfWxg7zMq6KvwLXbS/3NDvs8fMCjXk/YFHkXy
         mDtEBzYVZjjmTd2kjXPOSixISXUdVkMvCpmohKU/wsipluSHe5eVaUzCL1t3krsloryb
         33+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gorQKMV8vjkGqwI8nCYg+SRESNs1085GlQg2z0ABeuo=;
        b=JyuURqTQqImG/fnWH78i+/L6brStlihytiIo/1Au4imHoXl/AKrxXze68vasUjTn+S
         hGV7j/9lq69sC/kObACG82KX1OE5IzotpfQWWvQ58WsXu6HfAMLkQ7sUSuhIJayXFx5m
         sbb2Gqtj5imfauvHTMFks2bLd2wSLHUzMztDU3aEaC2XP6s3JoAgwQBeAWLW1Uh0eZF6
         /kbhrMB22mlbGyHsjN+zMEY38FIptbF897tVfNC7KWjotNmLKZB5A4ZGLXsDHACIgQVN
         mqIQbtHvSBpOU3bHgfc7v/Wwl/DhLV3dyQowYJ2MNU3KTSqmGmxppQS2si/R8/ekGlzs
         8YTA==
X-Gm-Message-State: AOAM530aDheynXIPc1SQ3aUoG6jkMMmk8JY9XrZJdoin0XqUg/60vQgk
        JCKG/aK5pgQ4GLEStEmgUns=
X-Google-Smtp-Source: ABdhPJxcj5dr0kJUFfqBEgzEoTIC5s88xMRWYL6CzqRLX2g+WGsAVhfrdfc0KIlhh12QckmcT6X/pg==
X-Received: by 2002:a63:81c6:0:b0:3ab:6167:74b5 with SMTP id t189-20020a6381c6000000b003ab616774b5mr24640684pgd.527.1652358006556;
        Thu, 12 May 2022 05:20:06 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id i16-20020a6561b0000000b003c62fa02f08sm1778477pgv.43.2022.05.12.05.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 05:20:06 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] drm/msm/a6xx: Fix refcount leak in a6xx_gpu_init
Date:   Thu, 12 May 2022 16:19:50 +0400
Message-Id: <20220512121955.56937-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
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

of_parse_phandle() returns a node pointer with refcount
incremented, we should use of_node_put() on it when not need anymore.

a6xx_gmu_init() passes the node to of_find_device_by_node()
and of_dma_configure(), of_find_device_by_node() will takes its
reference, of_dma_configure() doesn't need the node after usage.

Add missing of_node_put() to avoid refcount leak.

Fixes: 4b565ca5a2cb ("drm/msm: Add A6XX device support")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index ccc4fcf7a630..a8f6d73197b1 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1919,6 +1919,7 @@ struct msm_gpu *a6xx_gpu_init(struct drm_device *dev)
 	BUG_ON(!node);
 
 	ret = a6xx_gmu_init(a6xx_gpu, node);
+	of_node_put(node);
 	if (ret) {
 		a6xx_destroy(&(a6xx_gpu->base.base));
 		return ERR_PTR(ret);
-- 
2.25.1

