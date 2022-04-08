Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45BA94F9207
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 11:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbiDHJaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 05:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbiDHJaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 05:30:04 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3DE95
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 02:28:01 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id bn33so10671320ljb.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 02:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HgPZP8og8WpumzGAAXJPVekArW+Xl/SXdvcjF73+2JQ=;
        b=gHyFWpI6t8tOI4tUOMMz7p3TQeEQDqT5UxoSqnTR71xyC+cPoQ8GFnBWCqBCSal1Gv
         orGbjTEbs5Qdnhj10PvndYzcZh0UVMaZe+wmduTGqUGHG0YhB4FCbUz4xzREn/6OgvIB
         RRzUbSssHiOya74amEZ+zJSMXm76gERDIhfe/FfCjCz0voIT39bcAsz6U5Myuv+Ajg70
         hApiOhfPlKHR8ZQArArd+uZwWAwxZky61FDeKAfW6fAnpeth1S1BUNBM0FSSyp8gaye0
         tpljYIPZAu814zQ9RtpevYuib5m+XkmRBK0Fj4nTCGordvFiVlbZiXNHMPSH0pclk/wL
         p6Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HgPZP8og8WpumzGAAXJPVekArW+Xl/SXdvcjF73+2JQ=;
        b=aeL9R/RosZ29u7DgPjcm/+I5y6OhybJtiEzAEFeleIN+91ePPsDWiQHLnXH5gfJ7s9
         c5ihmqeCB/Ov+aiA8/Yr59g+vnr83F/C339AL/P3EG7ENTq8Z8B7R45cqAQkQWWUVft8
         0m403Xiv4Fu86ihtNAfqhha8wznyuZ/CDUxTXFfA23uAdZ48uxWhFT/PxnbE7WNANz6V
         92uWgPUtO7RPmIPo3mtLjiHgzL4zVX39F2yczCl6oXEqWaPy+SQnIzQc3IFFyE+B1pDB
         lvFXE4ZrY0nXiTdyDfQhKtWpHpcKGhfJoPGzuqrBGKbucqcbX3JypfmuLsdrfqY83HNF
         nr/g==
X-Gm-Message-State: AOAM532x/ZEZhRedHW6Qwd2wazltDGrY3lkzivS3RpZftGemIcHeHpDt
        bykyK0pJZRQ9myb0xbQtMzA=
X-Google-Smtp-Source: ABdhPJzDmYvPgxNYX0/xkMPy8fJo6IwLGDldkvZtGq5F1xWFOwxo8a5LnYST9iSx1XiFSCkTg6ybbA==
X-Received: by 2002:a05:651c:996:b0:24a:f361:1d9 with SMTP id b22-20020a05651c099600b0024af36101d9mr10971985ljq.346.1649410079474;
        Fri, 08 Apr 2022 02:27:59 -0700 (PDT)
Received: from noname.. ([2a02:2698:8c2a:149d:6d9:f5ff:fecb:a8ab])
        by smtp.googlemail.com with ESMTPSA id u12-20020a056512128c00b00446499f855dsm2412451lfs.78.2022.04.08.02.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 02:27:59 -0700 (PDT)
From:   Grigory Vasilyev <h0tc0d3@gmail.com>
To:     Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Melissa Wen <mwen@igalia.com>
Cc:     Grigory Vasilyev <h0tc0d3@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <mdaenzer@redhat.com>,
        Simon Ser <contact@emersion.fr>, Evan Quan <evan.quan@amd.com>,
        Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        Sean Paul <seanpaul@chromium.org>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu: Fix NULL pointer dereference
Date:   Fri,  8 Apr 2022 12:28:02 +0300
Message-Id: <20220408092803.3188-1-h0tc0d3@gmail.com>
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

The code below check for NULL, but is no check at this place, which is
potentially dangerous.

Signed-off-by: Grigory Vasilyev <h0tc0d3@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index d26810e7311d..c773a92dd4e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -1017,8 +1017,10 @@ static int amdgpu_display_get_fb_info(const struct amdgpu_framebuffer *amdgpu_fb
 	int r;
 
 	if (!amdgpu_fb) {
-		*tiling_flags = 0;
-		*tmz_surface = false;
+		if (tiling_flags)
+			*tiling_flags = 0;
+		if (tmz_surface)
+			*tmz_surface = false;
 		return 0;
 	}
 
-- 
2.35.1

