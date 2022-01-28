Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9762F4A0236
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 21:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351618AbiA1UlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 15:41:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351329AbiA1Uj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 15:39:56 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008FCC061748
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 12:39:55 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id u130so7211002pfc.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 12:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jkp5lO4JPGuhfIXrwkaqpIbB4x+b/JAJMjSbaxdyHLA=;
        b=ROgivARGyotirjNWqZx+Ry0hCgKtR2sBEDfB6K2EMzKxcZgjUKhyDaUB/9ExOvcpfd
         MOZUSpHA1POiU/yjzZSTdPa9QZyFyaNEo0CD9MJ0i+q6RFpE1TeUmA1IfGs9OvH+dI2/
         eNTId9RUqhsDkcEj9KnfoGfXN3AthuaMdTWESbaUgvZzlyE4kt4P9p4RzAOV1o0aGwl1
         tSHUCsFxRIb1kzNazM5CTMT5aH/ohpfZACLsVCpGvnzYhE0VNYXQKaC+5B1jAPSIjYb3
         aUkMmT562876yqfchdmZe645R9LL2fqV3XyYgVszBMcmplXtBHLmZwmQMHXe0uevEJZX
         AVPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=jkp5lO4JPGuhfIXrwkaqpIbB4x+b/JAJMjSbaxdyHLA=;
        b=sl7mLuWJ7fftynUEEf1iFjQcV3I1ju+kS6eQ+UUByKQYyvexm9WeDxQ+hJFcxmiLbw
         S6LA8Dya2Bc3yDUeJsP/VA6bWFcHJ/yUVN/UmoMVhG0cAzcTT3eAsYyYNDOrV6aWAXFF
         qloilJHVGSrAn+Deid+GiGjcPhD2+8uhH0ZxTok1tBu5DUtf74z9isO+aHfKFNWFTMHm
         wvToC7gd/X/Lz83NW8ruhp1gXeRIlchVclDlTgB9DD/NMBPEjrRfyMpbtFUDbzN/A0p1
         Mhu0z/VYyB0SamLpo5kOi858vxPrGY4CusSdBhcALaNEBO3HCaMjsdJDl4MaiA9IcCic
         Io7Q==
X-Gm-Message-State: AOAM533uULKOfdDrBJrCZH5RpXXxSCDHc+q7l3m7wJ5f1jzd+xu78Sdw
        wurWEg0+Sc5pR0BlCrXhVno=
X-Google-Smtp-Source: ABdhPJxMrZoxUZMZkxs65ZEX6aRxbbQCYbNVZmKGPMHDJ0xezO2JSVryQ02nrKGGTBhXv/siM447cg==
X-Received: by 2002:a63:174c:: with SMTP id 12mr7737819pgx.425.1643402395197;
        Fri, 28 Jan 2022 12:39:55 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:c6f0:f13b:bc2c:fac:4a86])
        by smtp.gmail.com with ESMTPSA id k3sm11235428pfu.180.2022.01.28.12.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 12:39:54 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH 2/3] perf inject: Try chroot directory when reading build-id
Date:   Fri, 28 Jan 2022 12:39:49 -0800
Message-Id: <20220128203950.3371061-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
In-Reply-To: <20220128203950.3371061-1-namhyung@kernel.org>
References: <20220128203950.3371061-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When reading build-id from a DSO, it should consider if it's from a
chroot task.  In that case, the path is different so it needs to
prepend the root directory to access the file correctly.

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

