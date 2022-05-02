Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58E55175C3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 19:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378055AbiEBRcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 13:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235761AbiEBRcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 13:32:47 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CE4A1A1;
        Mon,  2 May 2022 10:29:18 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id v10so12147840pgl.11;
        Mon, 02 May 2022 10:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oyJeFqHoGWWfsmN7ZUpT0hPaBi24D+V4aGuy1zcw08U=;
        b=gkB3nWHWQfhKPTtg6lYd+R/7QE9aVQPHgvJtP+ctJQ0SBARAm7Sc7BRdc6cdk3juc9
         ZJdHsXlMexuGv8fVXyAYNdbL/cNP1soLaojegZvIp/Awj7Dhg00wO+PQQf+HTXhpWFWX
         BzndP2dJuMu3QU8Y6BoKOlHozEp6gaKV1lw3z1bfaBfebkKOXlj5HP4RJe6UhiYNu+qs
         MMEwC3mX6ypQIuWLK1Sb966deUIyH3tr6ez3WGKHDXFNwUe3FH5Y5b+JZ2sfCfzm9yhJ
         v1Pq1TmVb6qarjhBSpK1euW2N1S6uD9l+AbLaWM12sudV1HwnJTQ/3xjJhXnxN3lX6bR
         FOXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oyJeFqHoGWWfsmN7ZUpT0hPaBi24D+V4aGuy1zcw08U=;
        b=0fYRCwmXX1AiBwJYQM/ACIEaTvQOisgZPbuLZpPF6Ej8kXT+6j2/Hi52bRiMkJ1Nd2
         YDVr64cTAoy67NEPrAT0gXmO4wZ4yJzICFmsbvEaJfcTyG2HZF0zZ4/E9vSEdmwS60o3
         mTCO6QQ6EY7P3t5C4OorWxBYFN0cPZBJQZFCFxC4g3e14x4W5vMpqAZX+ECd9SYKZKFX
         5r5fvviiLXlYm779A15vETvH4AusqWPfs2bBFH/COpRtgK2f8POjen25DDaIduUl0EBx
         x0MEZFXT2VEDq8vvtEgF3DEqhTGj9UV1irTHcbcknFyX+lA25h7hSIyVMj+Qt16A49yM
         Qwjg==
X-Gm-Message-State: AOAM530B3Mb0LFjOyzSSi5CnEF/l0aWyc4xn7UuQunoXKwqa4tomagCW
        ZNTtAdLq7/ZVB3U11t74sJU=
X-Google-Smtp-Source: ABdhPJyHf2OnaMoWX9/L1t52Z6eiweABLqlfrwiAvsNXVNVXwVpwyq5gx/jIDQrFotPphBbhdWbNHw==
X-Received: by 2002:a63:1c0d:0:b0:3ab:1a76:953f with SMTP id c13-20020a631c0d000000b003ab1a76953fmr10499701pgc.73.1651512557459;
        Mon, 02 May 2022 10:29:17 -0700 (PDT)
Received: from localhost ([172.19.27.22])
        by smtp.gmail.com with ESMTPSA id j14-20020aa7800e000000b0050dc762816bsm4942208pfi.69.2022.05.02.10.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 10:29:16 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/msm: Limit command submission when no IOMMU
Date:   Mon,  2 May 2022 10:29:08 -0700
Message-Id: <20220502172908.3569799-1-robdclark@gmail.com>
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

Running the GPU without an IOMMU is not really a supported (or sane)
configuration.  Yet it can be useful during SoC bringup (ie. if the
iommu driver doesn't work yet).

Lets limit it to users who already have /dev/mem access, to avoid the
chance that a user accidentially configures kernel without IOMMU
support.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_gem_submit.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
index 23b68bc945f6..9cd8c8708990 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -734,6 +734,11 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 	if (args->pad)
 		return -EINVAL;
 
+	if (unlikely(!ctx->aspace) && !capable(CAP_SYS_RAWIO)) {
+		DRM_ERROR_RATELIMITED("IOMMU support or CAP_SYS_RAWIO required!\n");
+		return -EPERM;
+	}
+
 	/* for now, we just have 3d pipe.. eventually this would need to
 	 * be more clever to dispatch to appropriate gpu module:
 	 */
-- 
2.35.1

