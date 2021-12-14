Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D23C473A0E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 02:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241373AbhLNBKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 20:10:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232173AbhLNBKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 20:10:37 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE04C061574;
        Mon, 13 Dec 2021 17:10:36 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id x5so16558574pfr.0;
        Mon, 13 Dec 2021 17:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=lUu+bu7URw0KVLywB7Idrn3tSFU11ChSitfBhMfHIN0=;
        b=KfscuHmPEC8q4PlFz/F9HD61zflzlTiWXSmCGDhiLMZtTDaDcwodhIIv1vtHE1LCG2
         MnFcyGYArCmyWAN3r8Lg8TdMRwbN7f6k+obC49ovFNr3Y9lZwfJdvT22wKqMWEPmXaNo
         MsULv2boPgZN3f67xV+UWCFqkWcUUqVkgdKQRoHL5UH70rFvuo2yUHNqc9Yt0g+X6mKc
         JyU5uIuGOupTBUr68QVI3qM25dyzYH36NtnEB4hZXLwIrpp9DD095zvl9OPOxZwv/KEM
         3jOZEz9Ej5wPRLRLuCDyV8pC0TZo/IvkXuKxHBQXjD5Uics/XZ/J42oZ60FFqs3f4YBD
         giJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lUu+bu7URw0KVLywB7Idrn3tSFU11ChSitfBhMfHIN0=;
        b=Cca0ZQWE/tWDG3FcVamw+50nLPZRqd2UvgWBmEmGcJ/EYbOFLm6oN9qs5k44ECAXh2
         142Rgb+uR+BBQaGanNDRsCq4eAwhf1wDUDacn4RxU0CaitVvTjW1oBXg4ytfguGdXRyk
         YDBueKSkHigdVfsDvXQ131zJhSB0uQ/5lLu5L86+3GO5tVdVHxF6ht9syJSFODoRLgYy
         kmqzuVOKVWW/PcRMRc22dww2Xvkuyzwl4ZJLQ6kC5D2b/imcUwMw3sW/85eMKpcBQOtX
         XOJTazxMA8OHg0bMkodlYPguBaldyrRGj0lXg1Ck4BJl/4xNLyQm/t23/WGh7M463dnM
         ZF+A==
X-Gm-Message-State: AOAM533d9wI7nd2GItCrrssHaLWoEJ0eNb+Jv2l4KoanvPHt2GA62RRQ
        Nh3p05hMesK+T+YTf1aeX58=
X-Google-Smtp-Source: ABdhPJyI2d8ywYcmXhtLZ30IKHr7+IqYvjctMql6cLXNogZzELWmqL2BUimg/gFE4FRVucPbNxfRYQ==
X-Received: by 2002:a63:175c:: with SMTP id 28mr1575950pgx.66.1639444236411;
        Mon, 13 Dec 2021 17:10:36 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id d23sm5968461pgm.37.2021.12.13.17.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 17:10:36 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
Cc:     linmq006@gmail.com, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] perf expr: Fix return value of ids__new
Date:   Tue, 14 Dec 2021 01:10:27 +0000
Message-Id: <20211214011030.20200-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

callers of ids__new() function only do NULL checking for the return
value. ids__new() calles hashmap__new(), which may return
ERR_PTR(-ENOMEM). Instead of changing the checking one-by-one.
return NULL instead of ERR_PTR(-ENOMEM) to keep
consistent.

---
Changes in v3:
fix compilation error and add tags.
---
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
Tested-by: German Gomez <german.gomez@arm.com>
Reviewed-by: German Gomez <german.gomez@arm.com>
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

