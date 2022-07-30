Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA7F585A67
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 14:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234531AbiG3MXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 08:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbiG3MXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 08:23:46 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F9913F9A;
        Sat, 30 Jul 2022 05:23:45 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id a11so3705168wmq.3;
        Sat, 30 Jul 2022 05:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7n8cZxwCZn/Qw/quWKlWrtEv2JQBFb0Bs9/SBswkjjY=;
        b=kNlJPZ4C4juqjPRrEkoxhK2y+7GMOURfI+mffO0a1obz+7dg2pk7FvJd5E7p+qnGei
         hmkZbHIwnKxfK2Xf+KfHSlvlm+FP8xCUIyQmIQwuaP6fEg4Qu1Ad0ypc8lut/r5VnOmL
         c7wi3e0r3X+UZtcIScKBr+vF1x7L7kZbYY/i2k/78JMcH29Z82lKo0XuMB6u219uB0YW
         yR18wc8ySnNVF0CyIB76DdGv+ir9eYhpBUhDwJqcZaf1nEbucBRIgDTK1zVV/9APRNeL
         M4jZz5zFj4/8LTpHpu99pthjS8zxEoityxtdJJovfD+ebA+s1vPaeJsJ4YCnGSwecl06
         nsbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7n8cZxwCZn/Qw/quWKlWrtEv2JQBFb0Bs9/SBswkjjY=;
        b=e6YaRmpN9fPJnFg6CdPG2I05DQKWh80offPwzjYq8oOfH3cmAoOoMi2QhEjuak6vod
         L1Py10oGRq5MeFHPNeg2/h8OaDZR36/6v4cccaWVQT/AZV1rNCF9uiH24EWp2cdqWLvk
         4I9dIEoklWtBS95twRLMJdQqlrn0aLpCVh8yt0ZJZYOQqL1nDDuKOng5ekxizjrjyUHU
         x64OPANJpfVASlBiTIko3AIuoC1H1F2Mi7n83p3sE+NcBBvRUQ4KyMsfr8kS5SB3kZVr
         MoEKkuZelVD0TLjfuIvXMV0NOhxuxSaA+1/jVGtM8z45TQFEfGPvr4yN8SS+OGU2HmrG
         ymhQ==
X-Gm-Message-State: AJIora9eZwSTe3RTN4SgRL7l5TmdD1DgXNPPArOimoSV5+gSG1bBSgtl
        L3ZfYrPpXUPh+aMKoVrwkUdjPzM7ouTgOQ==
X-Google-Smtp-Source: AGRyM1vl7vLOjBRgfGQHvyC5ORaV/PWltLK0HQ9/OQugol//U+WpHbNX1iiBt9i49ReIbryqQFgRSg==
X-Received: by 2002:a1c:f001:0:b0:3a3:7de3:1de8 with SMTP id a1-20020a1cf001000000b003a37de31de8mr5712393wmb.119.1659183824148;
        Sat, 30 Jul 2022 05:23:44 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id bp20-20020a5d5a94000000b002205a6aec0asm1132032wrb.86.2022.07.30.05.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jul 2022 05:23:43 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/i915/userptr: remove redundation assignment to variable ret
Date:   Sat, 30 Jul 2022 13:23:42 +0100
Message-Id: <20220730122342.146475-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Variable ret is assigned a value that is never read; it is either
being re-assigned during the following while-loop or after the loop.
The assignmnt is redundant and can be removed.

Cleans up clang scan build warning:
drivers/gpu/drm/i915/gem/i915_gem_userptr.c:295:11: warning: Although
the value stored to 'ret' is used in the enclosing expression, the
value is never actually read from 'ret' [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_userptr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_userptr.c b/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
index 8423df021b71..075aef875a07 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
@@ -292,7 +292,7 @@ int i915_gem_object_userptr_submit_init(struct drm_i915_gem_object *obj)
 	if (!i915_gem_object_is_readonly(obj))
 		gup_flags |= FOLL_WRITE;
 
-	pinned = ret = 0;
+	pinned = 0;
 	while (pinned < num_pages) {
 		ret = pin_user_pages_fast(obj->userptr.ptr + pinned * PAGE_SIZE,
 					  num_pages - pinned, gup_flags,
-- 
2.35.3

