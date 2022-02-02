Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDFA74A6C1A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 08:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbiBBHIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 02:08:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbiBBHIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 02:08:35 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725E1C06173D
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 23:08:35 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id v74so18036776pfc.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 23:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3MSKSo23lNPnEGbFeaL8KRRCjFplgMZmOT/lkGw3FKw=;
        b=mAJpszf7+XKG37QX4BtDPLfljFZzeRnfsfcy2T2Rlq9oeSD4nxsXa2ypZlDZ7E1nlR
         WNnRC1yjJrrlRkTO8fWJsMO/d9CCmKy/QsoeabYTtAS07ctVN0gWdOvp3kiVH7Gy1f5M
         /OJG07GshXhol6k08m9ob25Ng7+DkKMHxYaOau7Mk2REH0TG2EFu+vK/tYeET4OBdsnt
         pTF5cX4yRkBwEv93T+sGuxSvhDEX/KanxC7lnNpetCX8O/uGvntb7sy5GVaVbeLiucxb
         pOo3lowk9xAd7AnklUjknkX0xqpxfq/nCiZ47FGRX4ixNhZZLY2MzNoSj47MVf1VZN8K
         Nhsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=3MSKSo23lNPnEGbFeaL8KRRCjFplgMZmOT/lkGw3FKw=;
        b=RdtYkjzqMVyIXLAInGdNs30BOee/qqdp/Rx2lW4GdnO8Jrc+maM5ZkDxVGzrqaotyu
         A3pUQ5DrgOQ8mwcIA9dM8zPC+PFkmthGk8KS2OaTyl1mkut+LdqGopPj4a/mNpWT3rtY
         BaRo6VpENarwT4VY0FGexjBfn3niKMMfFyNIbGa22w1m19NQBUKbsKQwbs/T10l8ftu0
         c7j4yhRtquSm8DielkCHkKPeObsy/oUOeb7HS5UjsSfN5Om6Mrj4f7VTPxoW30N7njZ3
         xL3b74Akc//XtAN4w0JzAd/XIhoCcPQBlxG/HrOt5bpOCPvc509W6R3SWQM9Mz0kGN0Z
         pbug==
X-Gm-Message-State: AOAM5311RNQUQylhl9s5k17fLcP+2ttwJ5ZPsS1yvIWVTsKjIU9mq6UC
        spMExmfmm3ON6Zr6ZJXnJEmPUaSwPuU=
X-Google-Smtp-Source: ABdhPJxGIp818I59LSE/n7T7jmVLXaGJ0AxZZ+iOTGzr3oENLQsElmeZLZl6JonzFtdQ52LE+8TRVg==
X-Received: by 2002:a05:6a00:1992:: with SMTP id d18mr27947480pfl.85.1643785714993;
        Tue, 01 Feb 2022 23:08:34 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:c6f0:9c9f:e426:5704:d42b])
        by smtp.gmail.com with ESMTPSA id e15sm4936879pjd.52.2022.02.01.23.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 23:08:34 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH 3/4] perf inject: Try chroot directory when reading build-id
Date:   Tue,  1 Feb 2022 23:08:27 -0800
Message-Id: <20220202070828.143303-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
In-Reply-To: <20220202070828.143303-1-namhyung@kernel.org>
References: <20220202070828.143303-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When reading build-id from a DSO, it should consider if it's from a
chroot task.  In that case, the path is different so it needs to
prepend the root directory to access the file correctly.

Acked-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-inject.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index fbf43a454cba..3be581abbdb6 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -25,6 +25,7 @@
 #include "util/synthetic-events.h"
 #include "util/thread.h"
 #include "util/namespaces.h"
+#include "util/util.h"
 
 #include <linux/err.h>
 #include <subcmd/parse-options.h>
@@ -550,6 +551,15 @@ static int dso__read_build_id(struct dso *dso)
 	nsinfo__mountns_enter(dso->nsinfo, &nsc);
 	if (filename__read_build_id(dso->long_name, &dso->bid) > 0)
 		dso->has_build_id = true;
+	else if (dso->nsinfo) {
+		char *new_name;
+
+		new_name = filename_with_chroot(dso->nsinfo->pid,
+						dso->long_name);
+		if (new_name && filename__read_build_id(new_name, &dso->bid) > 0)
+			dso->has_build_id = true;
+		free(new_name);
+	}
 	nsinfo__mountns_exit(&nsc);
 
 	return dso->has_build_id ? 0 : -1;
-- 
2.35.0.rc2.247.g8bbb082509-goog

