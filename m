Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3496F5691D7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 20:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234503AbiGFS3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 14:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234526AbiGFS3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 14:29:44 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B841A12AD7
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 11:29:43 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-31cbcba2f28so45138007b3.19
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 11:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=WFIqq+Ih1CphrUsWAZ/TbaFgC8wSAo6D8gk6Qgq5hnE=;
        b=KKDpFirza47Orl3k+eu59zksxZJfyAAZGEmAozAnCJw/8ycZWnOjOjZ66rNx63/vff
         CZsDzYCXha5g6Bz4HHm0aZpHX2Q+dIfjkWlrcIgYR1xbw+R8rB36+ZJjZFQgvFOhao7b
         EyHykMj40N8gXOSwjRJ1zKW5UQbMYtNCBLwjmi45IOZbkBjBaeQeF2rLMpuKKOOXtkaf
         OH76PqHJAHOoZ/cm5sexyU6e5adhrjxjASPMEaG9zGkd7SZKHw0Fzt6PZhws365Afemg
         80iD5wE/Nh2Z6cosBcnbXu7i+/RD+2HazCOm0sc7hW/GObtZmHOeK0i4vX8PaJmUq5XJ
         4YUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=WFIqq+Ih1CphrUsWAZ/TbaFgC8wSAo6D8gk6Qgq5hnE=;
        b=7D0H8q95wctWPnAaUOw4voqhkM4qBGcTHZKWMXLvRDCGhRZnvIkCf52Q4SlddYAYQE
         Womn8Bgwx8C15Nboz+1G+tPqwcIyT07YM/Yu/oK37OVFqopc2rU++s6QPnfmr1bE79V7
         ZEGnsB0CX5SbbhSMzC6IQz6n7QElAlaNfy0ZLZ+Wv+48TdBtpFGPmy64k+ox9Q/2fL+9
         T+qwtmvNvRlxJ/Hrmqye2q7iNWvd61zt/h74Kk3bhul4VxkTRXKotgzC5h5kl7i/9KIY
         R6g+ve+sAG8SL4E55BkUeaQfgZgQqi7bPs40uw7UykfilnrkQBrC++OZi6F/Z9bt4OZv
         7kwg==
X-Gm-Message-State: AJIora9EFSH74C/XSfHj72Rlb5oVEANxs9KIgzKC+KbBFUJxoHUFERay
        ecK6h0qwaNntrU3O1vWL6hQaHS57vuDxw6A=
X-Google-Smtp-Source: AGRyM1s7dT6nr0ViJcQtDJEIuz8ngMKQXBvRBWAFFgqLK42PyV8aI8hdF86axENugYHnaXsYT6RhQn4SdgVZ/bk=
X-Received: from tj.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:53a])
 (user=tjmercier job=sendgmr) by 2002:a81:110:0:b0:317:a640:ad04 with SMTP id
 16-20020a810110000000b00317a640ad04mr49013482ywb.427.1657132182771; Wed, 06
 Jul 2022 11:29:42 -0700 (PDT)
Date:   Wed,  6 Jul 2022 18:29:24 +0000
Message-Id: <20220706182924.2563058-1-tjmercier@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH] drm/etnaviv: Remove duplicate call to drm_gem_free_mmap_offset
From:   "T.J. Mercier" <tjmercier@google.com>
To:     tjmercier@google.com, Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The docs explicitly say the drm_gem_object_release function already calls this,
and this does not appear to be a prerequisite for the call to
etnaviv_gem_ops.release.

Signed-off-by: T.J. Mercier <tjmercier@google.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_gem.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
index cc386f8a7116..ecb828e4e156 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
@@ -504,7 +504,6 @@ void etnaviv_gem_free_object(struct drm_gem_object *obj)
 		kfree(mapping);
 	}
 
-	drm_gem_free_mmap_offset(obj);
 	etnaviv_obj->ops->release(etnaviv_obj);
 	drm_gem_object_release(obj);
 
-- 
2.37.0.rc0.161.g10f37bed90-goog

