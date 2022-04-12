Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3629D4FD449
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380419AbiDLIV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 04:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353908AbiDLHZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 03:25:57 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8902D11C1B
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 00:05:11 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id a42so10161630pfx.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 00:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=MD2PafPOZxiALVxRANZJtJfxFryFkWiYa4P1WpagSvo=;
        b=ZoOMT2yrxzYBvfqKLstICxEU5NbOmIO81l0gvJWERON+OxWRK9IFg6/vpoIDfHAmJ6
         da4UtAu84n6WCPrn+3LyAlAG0NQpdiYQ/ZFWe0Mkr8XAUamFWjfPlLZXXOH7CNFHLSce
         HdTeQ/7o4hGeRPtNWJicF3vceIB245SwJfEbiHvo7jCiS/tdmWQctHtuWoPU2aiTWoQs
         kLfgB7c+Ov+MCQob3dYAwrmLFhxkyEIX1WBG9+aNyDcqQE0BPqgKQk7xj9t88gPlLqYY
         h4Sbw4WnxiVcPdlWg1emSanSfT8WyjqvAh701hPQqAQR+GLqZGU+hJ9oYwKMbM25KNGo
         PqCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MD2PafPOZxiALVxRANZJtJfxFryFkWiYa4P1WpagSvo=;
        b=ycyLi3mI3cvVEs5IEsiuUO8Xgl3NmbaZ0QrXAQVJtHsOC0NLrqEqMenpdqMB9xHjuu
         uR8l9jkmMcDy13mWoqjnSYFj3s4Zgg03gxwR67demRo8VBN5OQmIi/NLgzIJ94DKe2vx
         2lGrcKUBn2ZnMwVOO1PHybH0Mx1LliAPwQddUHUwpqF/pBRJ/CgCQFxukGU4N3r4zMCM
         kgpnSQor7FErq07JY1i6bFaGdKovtEGbpRpLLyq/UmgNXgNCdw2FGX7X5QF/S6pHgfhx
         DzPLx2xsdMz+Rak1wI9fgz8Jio7km4hZEmo+dn1cdopAAiye2ihB2FXTtc0WVnztPCmk
         /PDw==
X-Gm-Message-State: AOAM5327FxPCZZN1edZSb1bI40rVsX6ApATgwuA98mORMjr3e3IFxjC4
        bmrTiqHbGmEjOH7bQiLsdjI=
X-Google-Smtp-Source: ABdhPJycADu1O3trds1gUcEXHablNZlIDVa1C9T6c102ZVWQucGUgPEoS5U0EZJPhuOsxr9sEPWpgw==
X-Received: by 2002:a65:6956:0:b0:399:1f0e:6172 with SMTP id w22-20020a656956000000b003991f0e6172mr29157318pgq.286.1649747110823;
        Tue, 12 Apr 2022 00:05:10 -0700 (PDT)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id g15-20020a056a000b8f00b004fa9dbf27desm38059686pfj.55.2022.04.12.00.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 00:05:10 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Emma Anholt <emma@anholt.net>, Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Eric Anholt <eric@anholt.net>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] drm/vc4: Fix pm_runtime_get_sync() error checking
Date:   Tue, 12 Apr 2022 07:04:57 +0000
Message-Id: <20220412070458.21819-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
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

Fixes: 4078f5757144 ("drm/vc4: Add DSI driver")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/gpu/drm/vc4/vc4_dsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_dsi.c b/drivers/gpu/drm/vc4/vc4_dsi.c
index 752f921735c6..26aa7d1fa421 100644
--- a/drivers/gpu/drm/vc4/vc4_dsi.c
+++ b/drivers/gpu/drm/vc4/vc4_dsi.c
@@ -847,7 +847,7 @@ static void vc4_dsi_encoder_enable(struct drm_encoder *encoder)
 	int ret;
 
 	ret = pm_runtime_get_sync(dev);
-	if (ret) {
+	if (ret < 0) {
 		DRM_ERROR("Failed to runtime PM enable on DSI%d\n", dsi->variant->port);
 		return;
 	}
-- 
2.17.1

