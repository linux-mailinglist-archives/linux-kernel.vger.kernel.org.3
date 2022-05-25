Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D189953357E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 04:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243713AbiEYCwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 22:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243711AbiEYCwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 22:52:39 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCFA54F9B
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 19:52:38 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id y1so2033790pfr.6
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 19:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=s+X9BdhgymZkGEs6XYAhxZ8YaW7Mc7cLeWf6UbB+AxA=;
        b=Jq6B+pyNCb1mYvXzr6ps4NSWUHjieRp0VcM1SyMlkTa54elhAVDF8lwJw1FY/f2iIl
         aeebf0ks/bugs/UJw+z7FOYfrPi5DBSL0s0hQr+MaGdYKOlp6fxVYA29f0hkWqSbvvy4
         tu/WtWm6MHwNn2OJzsLFFersx37sTEy1vvGaPDtwvbqleIlAyY9gfpHWnSygy8ZgCd78
         FwB2ZSdU2LImi9bVilxOxs7Ox8zTPI5bf7ED+H/+O5BfJ1Ut5e2OqclwzDZ/r18DIfdQ
         RCfvG6j/PUJOfdP3lDx+/K8tpMlIcwnOt2WkDLoy474mY5aO+4CNfVOfNVHsj11Jki5R
         vFcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=s+X9BdhgymZkGEs6XYAhxZ8YaW7Mc7cLeWf6UbB+AxA=;
        b=R6O3OYN09U91amzNHEiU2IoNnZsDSkqSm5GvvnP4hjiHgBivNgjQkScLGc/ATnOD6W
         5Vjy0JgmtSTJduSOznuOdCfMZzsiYiYLscI2wmhnkhy0wZBPFrg6SM5ff4r44MtoBQxH
         KHrZhC2isLSbCkFm9gQ5yLZsJMS2lIqqe6CpxTfLgF5dm9QnLGgOlx74FAhwslX/xkjv
         XAna3BSQGdh5o5aQx1lgMFZlHj3TjxM0dELBq5CXHo92TwKWB7bFXJKyk7XtT/gCepZ9
         2uHktvNXG5eexycGETI/vaF33u+5mddjMvpqlwz5MjVDUjgEmMUgLzzp/i2j8VY4r2Ll
         Z+7A==
X-Gm-Message-State: AOAM530sos5pWdMnBI5YKZ66CMQZ0RbjBOasfqp8p77g1JoOIM9wGSvU
        dpXSdV6mqz7UGNaE3enCZS/jLhRvkVxx0w==
X-Google-Smtp-Source: ABdhPJylQwGVURZ5dFikU/QeR3oidQ8iU8T2RFJZ/zM89hqiKSc7wCyy+HaBTMct4RfleUW5FUSSQA==
X-Received: by 2002:a63:9044:0:b0:3fa:27bf:448c with SMTP id a65-20020a639044000000b003fa27bf448cmr13399959pge.131.1653447158046;
        Tue, 24 May 2022 19:52:38 -0700 (PDT)
Received: from localhost.localdomain ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id n9-20020a629709000000b0050df474e4d2sm9897374pfe.218.2022.05.24.19.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 19:52:37 -0700 (PDT)
From:   Yue Hu <zbestahu@gmail.com>
X-Google-Original-From: Yue Hu <huyue2@coolpad.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com
Cc:     linux-kernel@vger.kernel.org, huyue2@coolpad.com,
        zhangwen@coolpad.com
Subject: [PATCH] fscache: Introduce fscache_cookie_is_dropped()
Date:   Wed, 25 May 2022 10:51:50 +0800
Message-Id: <20220525025150.466-1-huyue2@coolpad.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FSCACHE_COOKIE_STATE_DROPPED will be read more than once, so let's add a
helper to avoid code duplication.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 fs/fscache/cookie.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/fscache/cookie.c b/fs/fscache/cookie.c
index 9d3cf0111709..575a5ba07c0d 100644
--- a/fs/fscache/cookie.c
+++ b/fs/fscache/cookie.c
@@ -372,17 +372,22 @@ static struct fscache_cookie *fscache_alloc_cookie(
 	return NULL;
 }
 
+static inline bool fscache_cookie_is_dropped(struct fscache_cookie *cookie)
+{
+	return READ_ONCE(cookie->state) == FSCACHE_COOKIE_STATE_DROPPED;
+}
+
 static void fscache_wait_on_collision(struct fscache_cookie *candidate,
 				      struct fscache_cookie *wait_for)
 {
 	enum fscache_cookie_state *statep = &wait_for->state;
 
-	wait_var_event_timeout(statep, READ_ONCE(*statep) == FSCACHE_COOKIE_STATE_DROPPED,
+	wait_var_event_timeout(statep, fscache_cookie_is_dropped(wait_for),
 			       20 * HZ);
-	if (READ_ONCE(*statep) != FSCACHE_COOKIE_STATE_DROPPED) {
+	if (!fscache_cookie_is_dropped(wait_for)) {
 		pr_notice("Potential collision c=%08x old: c=%08x",
 			  candidate->debug_id, wait_for->debug_id);
-		wait_var_event(statep, READ_ONCE(*statep) == FSCACHE_COOKIE_STATE_DROPPED);
+		wait_var_event(statep, fscache_cookie_is_dropped(wait_for));
 	}
 }
 
-- 
2.17.1

