Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 034A247CC18
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 05:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242380AbhLVE0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 23:26:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242328AbhLVEZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 23:25:58 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016C2C061574;
        Tue, 21 Dec 2021 20:25:57 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id m24so901901pls.10;
        Tue, 21 Dec 2021 20:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cwaFCWcWFdyBnD73ZnB6E87tfdGmS+vFyGgdXBUbUJM=;
        b=X3pr4swJr3dZN1csqWdYUIpF/JzvcCpaUbVf8sCmBD/yZ1OqWXX0jMHVHVIKRv4FFP
         l5hWB9IighbpUhuRkYCrDkW07kqRGsozPBR2fOT5czYOMLhROaegAmkPgcu9qTYWzOiz
         Gjw5EGID7GICcKQ4+1TkFvVmqFrx2C8CzoIfdGk6CyNBjpQks//ZfswsTIWK4fx38YUE
         BV7JPn2ABlf5+4CaJpu1AVxvcofP2UTZ5mCqx5oyYSA6Hvl9ZVbeW8A6VjLe83Fhhwx7
         f9suguWixsFy5ujYZatAtiHMYmOhkRY9XgyAZege2RPDY+kL/6xppJOoO/d5oHljJaUk
         D21w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cwaFCWcWFdyBnD73ZnB6E87tfdGmS+vFyGgdXBUbUJM=;
        b=DJs/QgcvnBe1qETTtz4rF+dgkyeGQ/trZjsndOh1IPs6/wXFdzUGsS90DyilQGDCBh
         rQul5rmIlOInMHCJLwAHwk6+hnay0FOnJQZJxcCXAcDVJuc56qpUExle5E7OX+aSo4aI
         ngTHjb4lWV35C2QqC9oVotlKVs54DKheWTfbZ/Qo+GG1akuYOeoBIhW2eExfjKmTHLxu
         FgZv0k2v9ykdgKXIfk5jLltt8SnQdTF22mSGx7WAUz4OHcZdfiKtUE7+ZoLIGTVCt1Qn
         T9qJ2jtizv+w4J8MlFjIrRL7flm9LGfSkqqDdHl5H62jO10Q1HWhSJij28cHdnlPx4JF
         zubQ==
X-Gm-Message-State: AOAM532+T9CeYSlHfahN6L1zX6RUISNScggNIXfTDIa1OQRv934bQCE/
        PjjzZjGmZ7KdXIaeV2ILXus=
X-Google-Smtp-Source: ABdhPJyE6PKPifVAkMPp1/9e3UYwKPr4ocE+wCM+foFyE40yj1+uUhbUnrqiSUdSQ2rCbARyGN6QgA==
X-Received: by 2002:a17:90b:1b52:: with SMTP id nv18mr1753237pjb.43.1640147157550;
        Tue, 21 Dec 2021 20:25:57 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id f14sm629228pfv.215.2021.12.21.20.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 20:25:57 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     acme@kernel.org
Cc:     ak@linux.intel.com, alexander.shishkin@linux.intel.com,
        german.gomez@arm.com, irogers@google.com, jolsa@redhat.com,
        linmq006@gmail.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
        mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org
Subject: [PATCH v4] perf expr: Fix return value of ids__new
Date:   Wed, 22 Dec 2021 04:25:46 +0000
Message-Id: <20211222042546.6750-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <YcHii0u6dusZFt6E@kernel.org>
References: <YcHii0u6dusZFt6E@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

callers of ids__new() function only do NULL checking for the return
value. ids__new() calles hashmap__new(), which may return
ERR_PTR(-ENOMEM). Instead of changing the checking one-by-one.
return NULL instead of ERR_PTR(-ENOMEM) to keep
consistent.

Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
Tested-by: German Gomez <german.gomez@arm.com>
Reviewed-by: German Gomez <german.gomez@arm.com>
---
Changes in v4:
fix the separator in commit message.
---
 tools/perf/util/expr.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index 1d532b9fed29..f225247acc01 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -12,6 +12,7 @@
 #include "expr-bison.h"
 #include "expr-flex.h"
 #include "smt.h"
+#include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/zalloc.h>
 #include <ctype.h>
@@ -65,7 +66,12 @@ static bool key_equal(const void *key1, const void *key2,
 
 struct hashmap *ids__new(void)
 {
-	return hashmap__new(key_hash, key_equal, NULL);
+	struct hashmap *hash;
+
+	hash = hashmap__new(key_hash, key_equal, NULL);
+	if (IS_ERR(hash))
+		return NULL;
+	return hash;
 }
 
 void ids__free(struct hashmap *ids)
-- 
2.17.1

