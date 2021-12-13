Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B157947215B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 08:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbhLMHKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 02:10:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbhLMHKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 02:10:04 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5A9C06173F;
        Sun, 12 Dec 2021 23:10:04 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id u17so10502630plg.9;
        Sun, 12 Dec 2021 23:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yohP78D4atzOPK9Zw6Tkph8dapgndeH2XkAEwCLnI1U=;
        b=p9Em6pnsstx60gGKlIgJdxmMa5vXilRhxGQaNMhrOngb6Dil/sU8dopn08Q0cXY9de
         fPZy/d2r7CMR3JxaGPGM6WKWAelUjG2QGmIotEeqi4U0NFtc9ZoIWciRazflzBAulH3l
         O02IAD9bm8LtbwjSFnJGW3Gb1oM0bbuveWQlSUZKvY119vEE3L6rKTjJOnScMQa7STaJ
         Cu4wXXtJyOENNUAqQKcXQe+g5nC36YgHwWa1cx94KBDztnK/vFDXXPWwWgScgLyMIEl2
         u+l+N0z8U++/CwGY7n98XwQVv/79tkf0vtxa7N3AJhFP2tDSqtEWE3A32vjPKF1X1ML5
         ClfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yohP78D4atzOPK9Zw6Tkph8dapgndeH2XkAEwCLnI1U=;
        b=45smfwxLv785fLBObQ5X/NVvn4IQoiHvO7Pwn37S1l9MBSbB51wCeWhSt+Fp7KueVV
         fu0xwNf8r1BmAINmfgGv7W6mNR5aRCmLyHcZIis0jgzHKqdQNq9mO+cmXlfNEtlDxeG4
         MbwyD0VBF3IUb3+UiQjFnOfy8k+rT+Phlt8ou4KBJl0aOfqsTJz45SfsZ6vvxXZv40Im
         VayDwb1yaEfU2hZiBEBt4mMZsOZj+VILlIEULYWrj9i4x4hHXrCOsIbwHxDKALWhrWg9
         Sz9vPodtvbIsHRhYyavNct+5VxPw7QKtKAaHfynMlUyZGVadu6aTCiOmnJ0NaosMzuyq
         nFOA==
X-Gm-Message-State: AOAM532NELuaRoh78JEgQFJ+rVzgteHUTbTcmDwOu0nk3yWIbsBdutD7
        IkXxCzORsI9WWw6aW7JyoFk=
X-Google-Smtp-Source: ABdhPJwzH/0NYxOyiHQwoJ/QV7LDvG/vfPms2iwsyO6Hn6nlajNJfX3LAO7q3f7pFWzyTzlqeIW4hA==
X-Received: by 2002:a17:90b:4ace:: with SMTP id mh14mr42540020pjb.164.1639379403048;
        Sun, 12 Dec 2021 23:10:03 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id qe12sm6057681pjb.29.2021.12.12.23.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 23:10:02 -0800 (PST)
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
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf expr: Fix return value of ids__new
Date:   Mon, 13 Dec 2021 07:09:53 +0000
Message-Id: <20211213070956.15119-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <864ad02d-6afe-791c-f742-56582b633482@arm.com>
References: <864ad02d-6afe-791c-f742-56582b633482@arm.com>
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

callers of ids__new() function only do NULL checking for the return
value. ids__new() calles hashmap__new(), which may return
ERR_PTR(-ENOMEM). Instead of changing the checking one-by-one.
return NULL instead of ERR_PTR(-ENOMEM) to keep
consistent.

Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 tools/perf/util/expr.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index 1d532b9fed29..aabdc112300c 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -65,7 +65,13 @@ static bool key_equal(const void *key1, const void *key2,
 
 struct hashmap *ids__new(void)
 {
-	return hashmap__new(key_hash, key_equal, NULL);
+	struct hashmap *hash;
+
+	hash = hashmap__new(key_hash, key_equal, NULL);
+	if (IS_ERR(hash))
+		return NULL;
+	else
+		return hash;
 }
 
 void ids__free(struct hashmap *ids)
-- 
2.17.1

