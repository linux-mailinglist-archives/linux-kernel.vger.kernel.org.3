Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4CC4CDE6C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 21:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbiCDUYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 15:24:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiCDUYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 15:24:33 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0840865D2C;
        Fri,  4 Mar 2022 12:23:45 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id e2so8731167pls.10;
        Fri, 04 Mar 2022 12:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8wKHEFGcZJBFIGWvjsg6haK45B9roDuA9AnfN8zp1WU=;
        b=ETWLRUK8yvHGuySP/W1rFb7Qb46SgJOyrSMqvh3x9ieihQRpFgCK7TpkX3tFbdj+1o
         r9PoYh52D6yeG7ICY9uLrDEhgt7GrHAg02pctMcCBo11wOwPXW0b045ZxsxKFnkNnBLn
         usz94gEodH/yeqCiJj4sFprFltydit0ZjqWxTFlfl/uHJdi+05I1jwzP6+U4MzBgNcCI
         5/PSFD294Eq7S8naVXEmzsIR2++qyA/gZxh3VUiy3LTPhLiBkJ6wOzTE0LOVZsQ7xQ+f
         aaoABdIE63QZuwxePV+qwgZsxbNr0B/m2X68QAD3B41/VVe5GD5HvTvnAmDAK6y61W/T
         CDZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8wKHEFGcZJBFIGWvjsg6haK45B9roDuA9AnfN8zp1WU=;
        b=49wTgiMqhNEhnFxUEKficUlrWOCIyQ6bjeaeLTb2RkPnjFeQ8o8rtaz3lrmvlvYUEM
         7ucOW6cKV9H1GG5yC3OdngqTpw7nfMxpxpbluNPWEgnJyYndn2SaM7R6xVwVt3o7RlvQ
         PLBPj3dlxj+L2qnrTWc7TFvK3HZD/01ACVdC80Wcwe6frXJBFpUjgFOmrbzAWP26F6ok
         KDESXY/mO8q1g/rNXK6zObwJLcyV9L1ZWE5h1UavB4tCtXRlSuAQKMBxXyQbokYCmHHg
         2kkm102E323jPhJlM8VzIjjLtSUKkfZ/gkovBX+U7NvRT9ibhKexzFqdIVrQi9vqsyB6
         D58Q==
X-Gm-Message-State: AOAM530LjMdNCMW64oPVj9RL94tCKLOE9gOxF6EZcPbz6Ql59WW2tGSd
        0uBPFYo02HVGVQF1hdhgkEk=
X-Google-Smtp-Source: ABdhPJyF5prUtDablbt4ZQd5sCQzEG+vhe0XmdWzoKh+68RJqCblDwYUbDyjr4r0BzAIUDZHG80yUg==
X-Received: by 2002:a17:902:d505:b0:151:9e65:b844 with SMTP id b5-20020a170902d50500b001519e65b844mr165351plg.49.1646425424419;
        Fri, 04 Mar 2022 12:23:44 -0800 (PST)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
        by smtp.gmail.com with ESMTPSA id y8-20020a17090a390800b001bf37d6b433sm452572pjb.43.2022.03.04.12.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 12:23:43 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
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
Subject: [PATCH] drm/msm/a6xx: Fix missing ARRAY_SIZE() check
Date:   Fri,  4 Mar 2022 12:24:04 -0800
Message-Id: <20220304202406.846485-1-robdclark@gmail.com>
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

Fixes: f6d62d091cfd ("drm/msm/a6xx: add support for Adreno 660 GPU")
Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 02b47977b5c3..6406d8c3411a 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -687,6 +687,7 @@ static void a6xx_set_cp_protect(struct msm_gpu *gpu)
 
 	BUILD_BUG_ON(ARRAY_SIZE(a6xx_protect) > 32);
 	BUILD_BUG_ON(ARRAY_SIZE(a650_protect) > 48);
+	BUILD_BUG_ON(ARRAY_SIZE(a660_protect) > 48);
 
 	if (adreno_is_a650(adreno_gpu)) {
 		regs = a650_protect;
-- 
2.35.1

