Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8305547319E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 17:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbhLMQYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 11:24:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbhLMQYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 11:24:16 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A389AC061574;
        Mon, 13 Dec 2021 08:24:16 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id nh10-20020a17090b364a00b001a69adad5ebso13769616pjb.2;
        Mon, 13 Dec 2021 08:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=yohP78D4atzOPK9Zw6Tkph8dapgndeH2XkAEwCLnI1U=;
        b=Xll60V/m0S95rYuhVfojo9Nw7jbki/iv4FSXFFhY5VEgcQ9m72peACREIzDKbSbqVP
         ywzeprVpIQrwcNSgxI7EN/ZPZN8SoNkMmrcn406bCmkJS1s/XWpLaP0K3NA47/f+meA1
         FUHYw5pNqJoIMwVnOwILlU5gkVZt8y9/D62lKQuJYXGZSBZgXy1tCVDbM38Fvcs9K9xP
         KJLpkP9ewa6wHdLZuUzs4Mo614BYipy2etpApuVHuIdusyYsvBfFqw4E2Y0cgDUUIBmu
         aPnfnyZ9K9aBWD/UNPFMbtblp8qX3a7e7hMPVcLs3YBKCIqod3APWJ5vh9UrPYQOcTpp
         XrSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yohP78D4atzOPK9Zw6Tkph8dapgndeH2XkAEwCLnI1U=;
        b=oYIpeX+GDWGUqNlR/6vZQOPRGx9PvwvaHjILGEyp6r1u+xeUUZeZi97rj3MzV46gpq
         rndJ3puHtYi1fKw8VtZ0/JZPClchgK7aH7jCZruIXgEs14ZBMFjo6qoR/x/065wrmoZr
         mPWDADkn7fMouiZZGRoKaCxuNR3hQXHy0/EwcEVJixd5WdI+mYZRn+X/ni7afK3B8Q6B
         KIdiKlWjtS5eHoonioUyUpMU0d7ZbXWkWAcKcwuuhOpbKb0I64NY6OBvOGvWWZIWjPBU
         Eu/PNDXzBJHexEYpeZavNQuBqe412e6sbi862ZqpULSHrnZBwsRBa6bHjHZ5jdQ28Nx2
         FXXg==
X-Gm-Message-State: AOAM532xNlBH6dLzZ8EgNzWNQ+nSEZwa40ObtDnZe5AObrf5KrpRXaI6
        BoeoADwgfK68IG2xh+4dzHw=
X-Google-Smtp-Source: ABdhPJz1NtidICjKTR7YYbrVG7R82YdUQIJkchkYd22sLpaFVtbilpYb8BG/hYKGXyWfJ7EKgMnXCA==
X-Received: by 2002:a17:90b:11c1:: with SMTP id gv1mr45294855pjb.208.1639412656189;
        Mon, 13 Dec 2021 08:24:16 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id fs21sm6043868pjb.1.2021.12.13.08.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 08:24:15 -0800 (PST)
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
Subject: [PATCH v2] perf expr: Fix return value of ids__new
Date:   Mon, 13 Dec 2021 16:24:00 +0000
Message-Id: <20211213162403.10970-1-linmq006@gmail.com>
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

