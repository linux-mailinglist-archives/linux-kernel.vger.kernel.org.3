Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7A495221C0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 18:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347703AbiEJQ4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 12:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237279AbiEJQ4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 12:56:20 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D7D27D003;
        Tue, 10 May 2022 09:52:20 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id x18so17261454plg.6;
        Tue, 10 May 2022 09:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GlbUvuuWywK7r9IASaNCIAQVNurd9YpTqewxFeLD4Rs=;
        b=eAksJ5ZwCS6JUF2s47IELsBUbuSOqioFvb6MBBDzupqY9v71HGtPALLBQdHly+Q4Fh
         DShJbrjkSQIb7jykbW/iyKoL2t8zf5ENw/mG8nt94ygLj8ongvXhTPpdzRtPsoY7kJ6V
         mX8KaQXsxzDiE18YMgbJgBvw2Ctwrd9I2WbpQuIXTFnvUoJjYPAxdkyBUVboE9ts76AJ
         FacBL5YkyyFO+PSjs0yjsiTjP3Yz0NIQJOhkouL8zuRxNzedFRafbtFdMgOYXfkGGFRo
         77GAI3ARWhvuQ0JxQ/XQ4G3SyOR3ZyVLzm6N19EwoHIHz9egltmUj6Up+YZTV8ukpIE1
         nVhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GlbUvuuWywK7r9IASaNCIAQVNurd9YpTqewxFeLD4Rs=;
        b=InKB3fd/DCWATGkVdlJF+j/WznoAxG1QtVeQa+eGvDqFYYa3W6F6um59DVTCGUF3cP
         4GyqmWt3NmKR7YBM0mbx6rCE2sYT078MZDOEyLkOUFIWoZR8fzwWadNs6003kOTRR5TQ
         yRbx01ojNkynHncnkXmWNrdbHZL6fI2x79ZKizfaC3V1sLJkRdh4wM9n28FJI1VQsIQC
         Gc+t7hMVWBb1TtuO33zxVaySypjCzWg26Kkcd06B6+oD/VuGy7zI/Qyy8Bq4IYtzKkkc
         wiWzJ8uXdjlUxQhi5jgf+Zo3cPwq7YuUNpnBj4mJnmnFhd74EIQ0d1/eJ851gaWUqfCh
         VD0A==
X-Gm-Message-State: AOAM531l9agauWbZ0DjwTkFZYsSPNQbQKI9Fd+8qEzFD1djtWudlisPW
        O1Wdw0sI3b89vURxNB28jPQ=
X-Google-Smtp-Source: ABdhPJwmOOWFZJFiV5ZPMNAWyXasCIh2GiEs5APeA0AQgt/pqcBNlctje9oW1aHg3VNdud72TsDotQ==
X-Received: by 2002:a17:902:d4ce:b0:15e:90f8:216c with SMTP id o14-20020a170902d4ce00b0015e90f8216cmr22171600plg.65.1652201539771;
        Tue, 10 May 2022 09:52:19 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id n10-20020a170903110a00b0015e8d4eb20fsm2296636plh.89.2022.05.10.09.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 09:52:18 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/msm: Fix fb plane offset calculation
Date:   Tue, 10 May 2022 09:52:16 -0700
Message-Id: <20220510165216.3577068-1-robdclark@gmail.com>
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

The offset got dropped by accident.

Fixes: d413e6f97134 ("drm/msm: Drop msm_gem_iova()")
Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_fb.c b/drivers/gpu/drm/msm/msm_fb.c
index 362775ae50af..4269da268a4a 100644
--- a/drivers/gpu/drm/msm/msm_fb.c
+++ b/drivers/gpu/drm/msm/msm_fb.c
@@ -118,7 +118,7 @@ uint32_t msm_framebuffer_iova(struct drm_framebuffer *fb,
 		struct msm_gem_address_space *aspace, int plane)
 {
 	struct msm_framebuffer *msm_fb = to_msm_framebuffer(fb);
-	return msm_fb->iova[plane];
+	return msm_fb->iova[plane] + fb->offsets[plane];
 }
 
 struct drm_gem_object *msm_framebuffer_bo(struct drm_framebuffer *fb, int plane)
-- 
2.35.1

