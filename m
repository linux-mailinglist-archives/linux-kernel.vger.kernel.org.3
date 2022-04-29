Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 610FE514207
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 07:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354293AbiD2FxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 01:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354289AbiD2FxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 01:53:13 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA47B18AB
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 22:49:55 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id iy15so4701590qvb.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 22:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=endm34N778Y0yPQpBj2UP5snb4XdIvtKjFf8w3OhWl8=;
        b=LLeap5fbMQ7b+CBIddQvpBa4S02DmgF9iWKlwwlY7N/Ft27Cf49xhkkH0FUBnoepSd
         yg2kvR+WLjB1EXt1DIp5XFbBMTOMYuts6P64qmU+fN3/kRke/u3r77g+atqGw9Ne6b3X
         f+HWlYDHVmhXMoKop4bbdBqyL+UgbHod2Y5HuaLbnx0AXMg23T6jwfHUYi6hfxZY+d6c
         P4e5BsNc6sozibBpMFDVLvCdij+x3IFCtgHc0seTmei1OZxmy2i3fq/5RoD/tIazF/7z
         nmyqLRu2GeTAwFVCYr+bLOiLCvNxB7J3ygB07QJ5YoDBBBo9i6ptDB7l2Yro46eMvRNa
         0fRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=endm34N778Y0yPQpBj2UP5snb4XdIvtKjFf8w3OhWl8=;
        b=Qy4MYKam2Q6LmKbyqZSoSbsSPy1uCYojOqlXabzkE8JOnsr8zjCa2Xd8YkwWrUSkA3
         E7J6KUcg1pCHhZc5fc6y7A77F2bfefD1yLXkl2FCG8eFy17XsAbskCy2eCKtshfZJcaT
         CUJ5/hEyJWS+FOmptxAzhJaFrPE4WkJVabQCD2XP/lmHXgz5KoGshDP/F1FCwxa89ZY9
         OddHc7b+atfVKsZrKKVTLH/kZF6W9Nwhoxx9+/lIEamZ9e6z+LF8xJuUofMezlO/MwE9
         jM5NyjK03NISoP9My6Zc89I38kTsL5lhVqYRM+b0MwIDFlbCClDI8fpCfE1PYAJ5VoO1
         xazw==
X-Gm-Message-State: AOAM530Imvr6OcEOFNauvQGd/QMekhn5UlbdRQrGZY4Q4Ln/VIAMTjYn
        D/a7tNP2BJyZ/MRJzeu1HQo=
X-Google-Smtp-Source: ABdhPJwBF67M3QN/ElCsgdd6o9uNM8BS8M4Da5QnAkLxYu3P+S576fZbIGm6W9QO+sY2j1Q+QAT6cg==
X-Received: by 2002:ad4:576a:0:b0:456:54f0:824f with SMTP id r10-20020ad4576a000000b0045654f0824fmr6965315qvx.31.1651211394421;
        Thu, 28 Apr 2022 22:49:54 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id h23-20020ac85697000000b002f387e4000dsm1146595qta.11.2022.04.28.22.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 22:49:54 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     emma@anholt.net
Cc:     mripard@kernel.org, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] drm/vc4: simplify the return expression of vc4_prepare_fb()
Date:   Fri, 29 Apr 2022 05:49:45 +0000
Message-Id: <20220429054945.3852039-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/gpu/drm/vc4/vc4_plane.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_plane.c b/drivers/gpu/drm/vc4/vc4_plane.c
index 920a9eefe426..b3438f4a81ce 100644
--- a/drivers/gpu/drm/vc4/vc4_plane.c
+++ b/drivers/gpu/drm/vc4/vc4_plane.c
@@ -1350,7 +1350,6 @@ static int vc4_prepare_fb(struct drm_plane *plane,
 			  struct drm_plane_state *state)
 {
 	struct vc4_bo *bo;
-	int ret;
 
 	if (!state->fb)
 		return 0;
@@ -1362,11 +1361,7 @@ static int vc4_prepare_fb(struct drm_plane *plane,
 	if (plane->state->fb == state->fb)
 		return 0;
 
-	ret = vc4_bo_inc_usecnt(bo);
-	if (ret)
-		return ret;
-
-	return 0;
+	return vc4_bo_inc_usecnt(bo);
 }
 
 static void vc4_cleanup_fb(struct drm_plane *plane,
-- 
2.25.1


