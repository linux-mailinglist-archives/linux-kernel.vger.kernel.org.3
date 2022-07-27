Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F669582554
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 13:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbiG0LUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 07:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbiG0LUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 07:20:39 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17EC27FF9;
        Wed, 27 Jul 2022 04:20:38 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id f11so15657068pgj.7;
        Wed, 27 Jul 2022 04:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vaW0CjGRWeMlCnYPCexhc/++ZUBhWYLTf54XQqCGOJQ=;
        b=XIS0KIfT8Ibbk2G6pLqZ/ER+4oM1xR+rHwgrpst1nQryMBE3uGri5g4y2t6xGvFrSz
         f6nEjjGH3ygCdw/fFHjY2eytKwRPT3HAerGtXf8kUUlHq4DghwKm5ovXXA68BosA/wlG
         KGmfdy9PB0RYe2lW3VAjX6ySY+cJgKPy7NUaTIYxjDfylIOsaaQcpEgKOYyBa577R2TN
         oh7vawh3M7GC2TX4o9RqHfnRXM7yhttzekkSx3NJf7+LcLbqBuvbSXtnBdBwY4VDCSPl
         VIXebTvDVqK3i5qUmJngJF1t6RSNbj9Cph6yubAE69xJr4CCn233Pn1sZg1Xu6BW83dY
         A+bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vaW0CjGRWeMlCnYPCexhc/++ZUBhWYLTf54XQqCGOJQ=;
        b=eDbI1v9iAREKfIGT3l3jJsQt3yAU0CJIp6d86JhzXSY1cSdDsxVEEw/PBVyKxLJC+E
         /hMM3IFQ0Z8eYOUMVk0BimMpvVaHC+CWkOpGpCVDZ2JjR+h03hkPBsP58RBGrht0m11E
         hlEc4ZBOfw5JG0hz+3CzqlG1xbbGGPDSJAaB6GbOMnb5jEqtr0MJf+P6MnIvKzh3nazo
         Adnox9hFc7p1kMepA9BFAX0W9NwcpTMB4mywdR3S9R61oRZMiaYec5HUt/A8TSqIg8fN
         /gnqUqlmuGE2RAsuMV4gPdgP0dtgWxhm870hb0jToUX9j/PtEknppXGAoVrietfhLlUV
         xpQw==
X-Gm-Message-State: AJIora+ZlMqeXiP4KYpaqiq/KWL/DJbO/HpQqozoRaCnGhmf9k7nARSx
        X17nGHiIi2HDzXF+YVAvKD8=
X-Google-Smtp-Source: AGRyM1tN6WWobEEgl5ShsjL8Ld5rWr2WvwEZxbTwegEnQlaSsRfsWT0b1OB5X75ofBXgEXxOwNhBuQ==
X-Received: by 2002:a05:6a00:1a8c:b0:52b:3eed:13d8 with SMTP id e12-20020a056a001a8c00b0052b3eed13d8mr21884252pfv.74.1658920838340;
        Wed, 27 Jul 2022 04:20:38 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:e014:b9a7:c341:50d6:ad89:e8ac])
        by smtp.gmail.com with ESMTPSA id w1-20020a170902e88100b0016c433f7c12sm13640212plg.271.2022.07.27.04.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 04:20:38 -0700 (PDT)
From:   gpavithrasha@gmail.com
To:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, namhyung@kernel.org,
        irogers@google.com
Cc:     gpavithrasha@gmail.com
Subject: [PATCH v1 3/4] perf mutex and cond: Updated files mutex.h & mutex.c
Date:   Wed, 27 Jul 2022 16:49:53 +0530
Message-Id: <20220727111954.105118-3-gpavithrasha@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220727111954.105118-1-gpavithrasha@gmail.com>
References: <20220727111954.105118-1-gpavithrasha@gmail.com>
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

From: pavithra <gpavithrasha@gmail.com>

Added new struct and corresponding
functions to wrap usage of pthread_cond_t.
Added a new function for mutex_trylock-similar to
mutex_lock.

Signed-off-by: pavithra <gpavithrasha@gmail.com>
---
 tools/perf/util/mutex.c | 37 ++++++++++++++++++++++++++++++++-----
 tools/perf/util/mutex.h | 13 +++++++++++--
 2 files changed, 43 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/mutex.c b/tools/perf/util/mutex.c
index b7264a1438c4..9dc37a3f374f 100644
--- a/tools/perf/util/mutex.c
+++ b/tools/perf/util/mutex.c
@@ -1,8 +1,8 @@
 #include <mutex.h>
 #include <pthread.h>
 
-//to avoid the warning : implicit declaration of BUG_ON,
-//we add the following 2 headers.
+/*to avoid the warning : implicit declaration of BUG_ON*/
+/*we add the following 2 headers*/
 #include <linux/compiler.h>
 #include <linux/kernel.h>
 
@@ -11,14 +11,15 @@ void mutex_init(struct mutex *mtx)
 pthread_mutexattr_t lock_attr;
 pthread_mutexattr_init(&lock_attr);
 pthread_mutexattr_settype(&lock_attr, PTHREAD_MUTEX_ERRORCHECK);
-BUG_ON(pthread_mutex_init(&mtx->lock, &lock_attr));
-//on success, returns 0.
+/*pthread_mutex_init:on success, returns 0*/
+BUG_ON(pthread_mutex_init(&mtx->lock, &lock_attr));  
 pthread_mutexattr_destroy(&lock_attr);
 }
 
 void mutex_destroy(struct mutex *mtx)
 {
-BUG_ON(pthread_mutex_destroy(&mtx->lock));     //on success, returns 0.
+/*pthread_mutex_destroy:on success, returns 0*/
+BUG_ON(pthread_mutex_destroy(&mtx->lock));     
 }
 
 void mutex_lock(struct mutex *mtx)
@@ -30,3 +31,29 @@ void mutex_unlock(struct mutex *mtx)
 {
 BUG_ON(pthread_mutex_unlock(&mtx->lock) != 0);
 }
+
+bool mutex_trylock(struct mutex *mtx)
+{
+return pthread_mutex_trylock(&mtx->lock)!=0;
+}
+
+void cond_wait(struct cond *cnd, struct mutex *mtx)
+{
+BUG_ON(pthread_cond_wait(&cnd->cond, &mtx->lock) != 0);
+}
+
+void cond_signal(struct cond *cnd)
+{
+BUG_ON(pthread_cond_signal(&cnd->cond) != 0);
+}
+
+void cond_init(struct cond *cnd)
+{
+pthread_condattr_t attr;
+
+pthread_condattr_init(&attr);
+
+/*pthread_cond_init:on success, returns 0*/
+BUG_ON(pthread_cond_init(&cnd->cond, &attr));
+pthread_condattr_destroy(&attr);
+}
diff --git a/tools/perf/util/mutex.h b/tools/perf/util/mutex.h
index ab2ebb98b24a..f1b4aaa151be 100644
--- a/tools/perf/util/mutex.h
+++ b/tools/perf/util/mutex.h
@@ -1,15 +1,24 @@
 #ifndef __PERF_MUTEX_H
-#define _PERF_MUTEX_H
+#define __PERF_MUTEX_H
 
 #include <pthread.h>
+#include <stdbool.h>
 
 struct mutex {
 pthread_mutex_t lock;
 };
 
+struct cond {
+pthread_cond_t cond;
+};
+
 void mutex_lock(struct mutex *mtx);
 void mutex_unlock(struct mutex *mtx);
+bool mutex_trylock(struct mutex *mtx);
 void mutex_init(struct mutex *mtx);
 void mutex_destroy(struct mutex *mtx);
 
-#endif /* _PERF_MUTEX_H */
+void cond_wait(struct cond *cnd, struct mutex *mtx);
+void cond_signal(struct cond *cnd);
+void cond_init(struct cond *cnd);
+#endif /* __PERF_MUTEX_H */
-- 
2.25.1

