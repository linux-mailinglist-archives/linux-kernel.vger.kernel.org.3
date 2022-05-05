Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0CE451B5B7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 04:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237828AbiEECUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 22:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237772AbiEECUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 22:20:11 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9EF48391
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 19:16:33 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id iq10so2912633pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 19:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AMR76WMtkLn5xSTes1b8YF480Y1GgwkYWQvKagsQ23c=;
        b=lTqzT44oMY16d9Q4twuk0c0lXMC5F1xGFPRg3Jj6HEiH9TFF5H5koNJD4eQaKzttfT
         sgENSGElIa9Kc2LHBThuTXr1+dZu5MQ9GfCUZ+xUCz8q0oiodddN/HVWSo8jCQNUvMCd
         L/jCPyb4yi3eBul5ETs67tUyMVoT7bKKMqigyVENPd6F4kpeyLWQ9LID0FmwI0gdxlRR
         tlHHo5+pPO48zF2MEm2PBFZ+wPisDzIXv47T9XYbd6r80ZUyXA6RU1BgFyh7d1gNsOkJ
         A689XeiQsLctldVKncIBEWcO5uRx1CCqGym47SHYrwqQMZyesvIRBUsj3G8nqFAJDWM5
         mLGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AMR76WMtkLn5xSTes1b8YF480Y1GgwkYWQvKagsQ23c=;
        b=AaU9GKrSfWynSsEqHFqjTgJUIY9hMVMSV8o/28UbcfIWd6Ff3o3CLFlS+Nf7eTlVwA
         tatCbag+XtT85cXFXSBicSiFwkcj8KGadcvdbM3GFr2i/yAMmEacW0a/61U+PSY7Xjnc
         cDcHcyaE8cpTC9Ye1ahmIHH59aW+FsADKA7KmNnVz2cPB/B0nn/mc3AVFWM3a2dIwQrv
         u7NMsY1fGv9d7wbn0xtlR2v7kHFZMgouwXxacGvMYS7aRUIWMcIfgUfuvSRRmYSR0NJM
         daI5/Yb45VDzgSae5en01DC7AHTOOs2puWhQiLro0FxRA/LYvYGe8rQomf4jNSssSLY5
         qqgw==
X-Gm-Message-State: AOAM533EiUs2YC7W/Ug7hKT5DY+u5ostExxJkWcsasCyIKABmFn54v9/
        F1BLiplko6d0lefT+XI+DXU=
X-Google-Smtp-Source: ABdhPJxCSy4KhWQzFFnnhYGswJBl+qB4knx8GwmMjyTM7dpflZx+m1LM67r/kdwz69coX7XkvQl5/A==
X-Received: by 2002:a17:902:9a4c:b0:158:b6f0:4aa2 with SMTP id x12-20020a1709029a4c00b00158b6f04aa2mr24890390plv.163.1651716992863;
        Wed, 04 May 2022 19:16:32 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id v17-20020a170902ca9100b0015e8d4eb265sm174733pld.175.2022.05.04.19.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 19:16:32 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     jani.nikula@linux.intel.com
Cc:     joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        tvrtko.ursulin@linux.intel.com, airlied@linux.ie,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] drm/i915: simplify the return expression of i915_driver_open()
Date:   Thu,  5 May 2022 02:16:25 +0000
Message-Id: <20220505021625.54146-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

From: Minghao Chi <chi.minghao@zte.com.cn>

Simplify the return expression.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/gpu/drm/i915/i915_driver.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_driver.c b/drivers/gpu/drm/i915/i915_driver.c
index 09de45d3e274..d11a7445909a 100644
--- a/drivers/gpu/drm/i915/i915_driver.c
+++ b/drivers/gpu/drm/i915/i915_driver.c
@@ -977,13 +977,8 @@ static void i915_driver_release(struct drm_device *dev)
 static int i915_driver_open(struct drm_device *dev, struct drm_file *file)
 {
 	struct drm_i915_private *i915 = to_i915(dev);
-	int ret;
 
-	ret = i915_gem_open(i915, file);
-	if (ret)
-		return ret;
-
-	return 0;
+	return i915_gem_open(i915, file);
 }
 
 /**
-- 
2.25.1


