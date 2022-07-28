Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5C7F583B05
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 11:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235302AbiG1JOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 05:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233460AbiG1JN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 05:13:58 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C144655A6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 02:13:56 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id e132so1076838pgc.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 02:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=ifRf6yNz0UpoCdtj88m7UxYW0lnEYEGGWf6UZFMfb/E=;
        b=UMqibFaMrO5UXXc8EmGsrmHmsXBzZWIjYQFhNtKcGhReIxfLEjWuotzgbVuqFLKaKG
         oR41b2bJne+sypFSCzu1sNaRAkUjHOEX6c5s5yQpVHXvfiY8iAKr1Z8HCpE/KgA1kP/A
         Qm7NH7hwlT8hk/qQssIeurA63moDyca2WTF5fC+sy49l/fQhOFpq1rxM0+izAvXIhrls
         eL1GUmFU6aPvT2gGUeOiiuqve9QsYIGxWaKT0o3WRPZwDx9rkNI3uh4RvRb30zZ+dMtN
         P5akBKRCBKLAhdOv/WxJmvPrsI0B0seshkcQgsMy9fPZup4XS8zMuhmdVy3GUnuVajNw
         0Whg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ifRf6yNz0UpoCdtj88m7UxYW0lnEYEGGWf6UZFMfb/E=;
        b=2tsoot/8Dn0LBrUrAwzqf2nt0iOttwfV6rHFxU0zbu592HSB4F+/aIN/B0qUw9awTB
         4OXsZTq12E9DjBN85W6biOBlDIbsOEP4aTtM/7tvxyO94/YSmofP4Sq4WnESdV08EOY+
         QV/xngMLtAH1z2VdigA330Ed6VukbpKZHGFO/Yy6EOsHtuL4tpwU+zV++j9Jp2w0ivTY
         tzvYXcVATfi9SvfZxGiJdYloc3LpqF72HXFiM+uc/KJSteGeDWFSue3KW1Cw70HSjqnX
         4IdQDJngwpldmO+L2J2W8XtZ8P371X2ENtMtZBrOXwzwvN7JkyfXm8fVIEV3jqN56XIg
         sWhQ==
X-Gm-Message-State: AJIora+a4ZAVOxuvaSb2mlqB6nmRCAbRSeFlfXeM9Eehlp/MXd337sx5
        VuOoni/tpJ8cJ9JLPoTX3K4zkA==
X-Google-Smtp-Source: AGRyM1saXjIwDHTO2NzoOk4vH/43+tdtVnUn9lT05MVWU6gR2I3it/u7NGRbP5+s7pvSWimGAexQXg==
X-Received: by 2002:a05:6a00:2190:b0:52b:fe5f:5939 with SMTP id h16-20020a056a00219000b0052bfe5f5939mr16525576pfi.83.1658999636171;
        Thu, 28 Jul 2022 02:13:56 -0700 (PDT)
Received: from n131-251-112.byted.org ([121.30.179.115])
        by smtp.gmail.com with ESMTPSA id p9-20020a170902e74900b0016dc2366722sm681304plf.77.2022.07.28.02.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 02:13:51 -0700 (PDT)
From:   tujinjiang@bytedance.com
To:     mhocko@suse.com
Cc:     shy828301@gmail.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Jinjiang Tu <tujinjiang@bytedance.com>
Subject: [PATCH v2] vmscan: Do not free nr_deferred for memcg aware shrinkers
Date:   Thu, 28 Jul 2022 17:13:41 +0800
Message-Id: <20220728091341.20820-1-tujinjiang@bytedance.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jinjiang Tu <tujinjiang@bytedance.com>

When a memcg aware shrinker is registered by register_shrinker(),
shrinker->nr_deferred will not be initialized. But when the shrinker
is unregistered by unregister_shrinker(), shrinker->nr_deferred
will be freed.

Luckily, the memcg aware shrinkers in the current kernel are pre-zeroed.
But a new memcg aware shrinker may be added in the future, and we should
not assume the shrinker is pre-zeroed.

Another unregister API free_prealloced_shrinker() does not assume the
shrinker is pre-zered and free shrinker->nr_deferred only if it is
not memcg aware. So unregister_shrinker() should do like
free_prealloced_shrinker().

Signed-off-by: Jinjiang Tu <tujinjiang@bytedance.com>
---
 mm/vmscan.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index f7d9a683e3a7..f8a9a5349b6e 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -675,8 +675,11 @@ void unregister_shrinker(struct shrinker *shrinker)
 	down_write(&shrinker_rwsem);
 	list_del(&shrinker->list);
 	shrinker->flags &= ~SHRINKER_REGISTERED;
-	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
+	if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
 		unregister_memcg_shrinker(shrinker);
+		up_write(&shrinker_rwsem);
+		return;
+	}
 	up_write(&shrinker_rwsem);
 
 	kfree(shrinker->nr_deferred);
-- 
2.17.1

