Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A06507DCC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 02:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358073AbiDTAxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 20:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358694AbiDTAwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 20:52:47 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D810A12AD9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 17:50:01 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id o5so437341pjr.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 17:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VKB6HDvcGAs5pP/g1gah8asLi98FXqiU4ymyeK//1h0=;
        b=Kc4ESBSPia/cNIoVMdlNZe1ccp6hY3K/p02oivOtUnMa/PJ9yg41l9GioIdxTakreR
         +wmlte8o0cfatZAOXedJ7iy5ogeA5Lz5cqDveiI/FXX1FUzEMTbW1gFR+/ea0bkhFtnq
         YMCWDvNoHvGfBV3C7t+ZUYTKa6O7Ta05PbKSSqegDhBCtkTVog8xzzSDspzo5UOtZTtG
         o9qp2Uzv0q1fUBvwdPTl0rZQU9vuH91vgXOwN4n/sCXkAgX9+Xq780RLLa22djGuHKbE
         1+HF+lAsKqL/Nhp9tJqxpcoVuB4n0o9SLqrEQQ9zsSrHeBjk2hpB1f2E7wrTiE1+NSzf
         6X6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VKB6HDvcGAs5pP/g1gah8asLi98FXqiU4ymyeK//1h0=;
        b=NYV1jWGxW9MwKTZm+ix74xU1LWMy0Ti2yE+lHmhEqu8ZOmTGrxCFTCgMVhbEMnePHN
         z8f5h+4qnHWC96fRvk08pEiCrkesoZ64tinqc5/sCMQuAQGpulsJeS2wU6/HHsvaoktJ
         U68IN7zy7QcVfupUi9ftOJhf2DO0zQcouw0QufJlrXSk/dl5uIX14Jo0yT+Gk1MSDGY8
         cL0evCwjGWYZzbCGRWBSaVfXsCZodJAGAhX41byQB7x1BHo76xBLk43ZwR5kdVYusf3H
         BnL6hw4nzTAXwojowWxiq05H1T+bEWAEZkFtcwCCEH6uArHee1F0sBWC0vpOBJ5qB2gh
         FTHw==
X-Gm-Message-State: AOAM530AA6CXPgyr/esXJlBxKKEA78qJXPLJlnY0BPQbu3RqeSPCADLA
        JYvZe0NaqKNIZnkRy1m57Oc=
X-Google-Smtp-Source: ABdhPJz7D14J/CfXouEAadIMNltoG/iR5HKaWc0oBtRmB2SXvliv58bUSMnmAl+D9vQGbbf/VT7OdA==
X-Received: by 2002:a17:90b:4b01:b0:1d2:abf5:c83f with SMTP id lx1-20020a17090b4b0100b001d2abf5c83fmr1407149pjb.93.1650415801316;
        Tue, 19 Apr 2022 17:50:01 -0700 (PDT)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id g8-20020a17090a290800b001d2dcb75a0fsm4015500pjd.0.2022.04.19.17.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 17:50:01 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Emma Anholt <emma@anholt.net>, Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Eric Anholt <eric@anholt.net>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH v2] drm/vc4: Fix pm_runtime_get_sync() usage
Date:   Wed, 20 Apr 2022 00:49:48 +0000
Message-Id: <20220420004949.20508-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220419124407.ugzl7hknsytbhrmr@houat>
References: <20220419124407.ugzl7hknsytbhrmr@houat>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the device is already in a runtime PM enabled state
pm_runtime_get_sync() will return 1, so a test for negative
value should be used to check for errors.

Also, we need to call pm_runtime_put_noidle() when pm_runtime_get_sync()
fails, so use pm_runtime_resume_and_get() instead. this function
will handle this.

Fixes: 4078f5757144 ("drm/vc4: Add DSI driver")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
change in v2:
- switch to pm_runtime_resume_and_get() to fix refcount leak.
---
 drivers/gpu/drm/vc4/vc4_dsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_dsi.c b/drivers/gpu/drm/vc4/vc4_dsi.c
index 752f921735c6..9d7ffaf6bc70 100644
--- a/drivers/gpu/drm/vc4/vc4_dsi.c
+++ b/drivers/gpu/drm/vc4/vc4_dsi.c
@@ -846,8 +846,8 @@ static void vc4_dsi_encoder_enable(struct drm_encoder *encoder)
 	unsigned long phy_clock;
 	int ret;
 
-	ret = pm_runtime_get_sync(dev);
-	if (ret) {
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0) {
 		DRM_ERROR("Failed to runtime PM enable on DSI%d\n", dsi->variant->port);
 		return;
 	}
-- 
2.17.1

