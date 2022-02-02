Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 387424A6C1B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 08:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233654AbiBBHIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 02:08:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbiBBHIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 02:08:36 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98888C061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 23:08:36 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id k17so17509279plk.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 23:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9t7iEOUj9IyscO6Mfw9DqFCGsAJD5/8QafkYWmvy0h8=;
        b=hJRPa+N5tj4CLTB31qJhRznz2dktoYa5z33nyM0IiW/aPzkD0ZjayBNl+gtuvfSTCa
         NBc+CN/o6P9DhbbpMg+LJ3qqZWYA/ga9OLPwGl6AAKVJ7gjEGw0WtYpKMFjk3Hyy18QY
         nx06P2EpD5Tk/I094uwtoXWjZKYbWe8Z65fwrMFUqm6SlEbsXj5yU7secu7AZA5Mggd/
         1Q88gHgzAPNd8YVjxedOiZaIVPJIkxfc3FeXLDvAp62f/tqcuQU85i7ut6bhjBUom63m
         ZpaBnMBGeDtFTMdmxl3SvEKsy35wxCv6l/1fZR2fw7FvrPuvRqPWo8GeULDaGRxhpIQt
         pTZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=9t7iEOUj9IyscO6Mfw9DqFCGsAJD5/8QafkYWmvy0h8=;
        b=UhcV8XWmlzp80WI4ePHAfhWNi4lrURuYRVR8mvupc50oABF9FPbhFomhH6TEh5PcTt
         gNPEI1pFr/ILP4qlnFtI4ViG2sC5LB1btlZUmCeRP3xmqc5FddWCuSVG3GCC7cdPNWVZ
         w86G6lcel/Nfa9bpEgld4soY1A0kCKehJKE/OFKLgNXtTj7wfB2rFD33zkBW/5LN+nee
         L7UjlwWVUda/LU4oq2C/QTMXtBz6DSdVYsOnHZHPQotdKfrko5/TJx1WG+bOrUZwiPAl
         fO9tzcXLyMVKmlct7FPnbcRdAYKJttb8B5+uZvmQ1Eupw5pa+Wch1AelkDvA8bb8DWUo
         HM0A==
X-Gm-Message-State: AOAM532n8Za0d5cMz8iztS1Xpjcd0lZ5p+/fanK8aGuGZxhgSlI/6Tg1
        6UueT96GOsIGw2ptte1vXE4=
X-Google-Smtp-Source: ABdhPJxKC8gRPijHI+uVxcjWkaM59FKxj6SfHUty0BFB+3DLLBDw99XU4PT8nF7ebfbgBGFrnQ5hNQ==
X-Received: by 2002:a17:903:32c2:: with SMTP id i2mr29075994plr.55.1643785716127;
        Tue, 01 Feb 2022 23:08:36 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:c6f0:9c9f:e426:5704:d42b])
        by smtp.gmail.com with ESMTPSA id e15sm4936879pjd.52.2022.02.01.23.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 23:08:35 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH 4/4] perf annotate: Try chroot filename for objdump
Date:   Tue,  1 Feb 2022 23:08:28 -0800
Message-Id: <20220202070828.143303-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
In-Reply-To: <20220202070828.143303-1-namhyung@kernel.org>
References: <20220202070828.143303-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Likewise, it should use a proper name in case the task runs under
chroot.

Acked-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 8190a124b99d..e4c641b240df 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -33,6 +33,7 @@
 #include "string2.h"
 #include "util/event.h"
 #include "arch/common.h"
+#include "namespaces.h"
 #include <regex.h>
 #include <pthread.h>
 #include <linux/bitops.h>
@@ -1696,6 +1697,15 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
 		 * DSO is the same as when 'perf record' ran.
 		 */
 		__symbol__join_symfs(filename, filename_size, dso->long_name);
+
+		if (access(filename, R_OK) && errno == ENOENT && dso->nsinfo) {
+			char *new_name = filename_with_chroot(dso->nsinfo->pid,
+							      filename);
+			if (new_name) {
+				strlcpy(filename, new_name, filename_size);
+				free(new_name);
+			}
+		}
 	}
 
 	free(build_id_path);
-- 
2.35.0.rc2.247.g8bbb082509-goog

