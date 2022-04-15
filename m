Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB50502EA9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 20:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245198AbiDOSXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 14:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbiDOSXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 14:23:46 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE3A8CDB1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 11:21:17 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id o20-20020a9d7194000000b005cb20cf4f1bso5791314otj.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 11:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sm8DSCIeMC6YuTy9deusE25jUiKvOwY3HtepIUMUjaA=;
        b=AeojTpXTTI3PAeqfCB4sVmZ3FJX9rlQ35P3Z6A2SPsBqrYuL6mStUlK1jmTtDzeUDg
         GoMR/UihMx51mH539Ivg9EYwYrzZJFXOvA5S/OzTXlS4f6vak4yvV6lLLMJaIOpRIvIN
         MBl1B8F5FHW3NJZKU2IzkhFxEqYID733KgeR79Rvv+BpD/FESAwBbMV67/I8AyIYOPwc
         q3ayexTCyEeakVugv04xej536AD9mRpX+eMmG1S4yiX5bboRnlMLkrjrJiOH8SnP109m
         2iKy/jQFJQZ0/6xQgxjmACDTsXJo7DG+isNphpKOfQIVpEhUfVL72lyAwRPpneI90iOu
         l3Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sm8DSCIeMC6YuTy9deusE25jUiKvOwY3HtepIUMUjaA=;
        b=fVANkDO4zmhEjXOfk1hq13kxgtB4a54jFMQaA2oRqHSXayEnEg/SwQes7jjuCCvmFp
         cdFDGzarjGyU53QNcTGB/C9hgwODkuDURSX93nPfW8vh3XN0Fno7EOiAb7kogWYDqkQs
         4yEb0RyXL0fsFwsnoVxAKXUTjuCoVXWIgTV2QdBxiqPzzjedwX5L0El+iWK5RfSU3xDp
         QCEXqNyyl/lw5RFNGSZrWi3wvR+qRKiucn1TY58rB74GcHPpWl/R6nfdwpXv1HvnS1D7
         Zx6OhTUNlH4GZIKKxLB+sdBKSI4RXauVGU6bKd6yft0PFCu0mvOXx8b672Z4/6TZLj7u
         gyGQ==
X-Gm-Message-State: AOAM53175XQ5iu8Dqi1nhY5VNAZ6z5Sya3addBM1XDreJ52YDCsUdpNF
        qT/aHfxhIB+28AjGhyYaiJM=
X-Google-Smtp-Source: ABdhPJwo0WGvkFrC84zXYCfOA6ncaJO1ft/Yn11zS61rS4Jw3IoXDc+bU0rl6jIQu+nRBg3s43kmUA==
X-Received: by 2002:a9d:58c3:0:b0:5e6:d8f7:c18c with SMTP id s3-20020a9d58c3000000b005e6d8f7c18cmr151853oth.364.1650046877063;
        Fri, 15 Apr 2022 11:21:17 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:4c2:8a9b:dcc3:45ee:2581:b4cb])
        by smtp.gmail.com with ESMTPSA id t22-20020a4a8256000000b003332a0402f5sm1367127oog.23.2022.04.15.11.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 11:21:16 -0700 (PDT)
From:   Tales Lelo da Aparecida <tales.aparecida@gmail.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        andrealmeid@riseup.net
Cc:     Tales Lelo da Aparecida <tales.aparecida@gmail.com>
Subject: [PATCH] drm/amd/display: make hubp1_wait_pipe_read_start() static
Date:   Fri, 15 Apr 2022 15:20:14 -0300
Message-Id: <20220415182014.278652-1-tales.aparecida@gmail.com>
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

It's a local function, let's make it static.

Signed-off-by: Tales Lelo da Aparecida <tales.aparecida@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c
index fbff6beb78be..3a7f76e2c598 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c
@@ -1316,7 +1316,7 @@ void hubp1_set_flip_int(struct hubp *hubp)
  *
  * @hubp: hubp struct reference.
  */
-void hubp1_wait_pipe_read_start(struct hubp *hubp)
+static void hubp1_wait_pipe_read_start(struct hubp *hubp)
 {
 	struct dcn10_hubp *hubp1 = TO_DCN10_HUBP(hubp);
 
-- 
2.35.1

