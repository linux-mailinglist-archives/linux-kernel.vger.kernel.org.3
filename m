Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 293284A0235
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 21:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351479AbiA1UlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 15:41:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351343AbiA1Uj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 15:39:58 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A77C061749
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 12:39:57 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id z14-20020a17090ab10e00b001b6175d4040so6172865pjq.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 12:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X5ESwBG6b6i8YhyGmxv/0fv/Q3LnACC0URr3jF91X2A=;
        b=iYmzpNKUB+T1KgiTlY8iN4WQBCiTqcfAWm+z84/sPor3C7bmf7+mUMiaTRG/oND6FB
         BDR9JWd1CbK3BIi2W55gBn584SnlQSJy2RO1H4MST8WWIaipkIGxlqG12dkujRdNcFxZ
         KVtEiHX0S4w+LiE/IkqQyXDa75IuUyBFuFfGpy0rTWjOXJT0/dAmGDtXBelwtdxRgoRg
         5JNre7akcL5OT7jdA0/I2j63+hAqG6fS1fV5BZyRjHdTjqrM2wd7UWq8HYgRP/cGazty
         JevFy+nRYeGvx7wTj72M+ONS+LxyMbXR9EqvmxGlEgYTxUi/uHG0Hj4QAuIMUTqNjWkx
         uzwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=X5ESwBG6b6i8YhyGmxv/0fv/Q3LnACC0URr3jF91X2A=;
        b=b859edkUltVFbDc7pdbpx6ioX8z6OVMwsuF6J2JCOphkTSnlT0XPaMKX0aPC0Fl4aw
         QGhFmuD1wdJIOUmL6qmqP0MegIEollquvJrfrqVxJ8yfj1wo2rR+ua85kd3rpBnT3YgK
         zIYybIN7mU1keok5dAJb7/R6ULgk/Yz3A9SQx5gZX7wnkMgGVYWagHspBekvVtVAUfim
         z987eVImvMVlcjXvVCYyC8HbnJ0KIri4pz5C4KiFCJcjH/T3rouWIJE4dC4V3zWm1pa3
         NLXW84mKyPgnNpRlxMPCzTH3j6blsHJFiEfe2Le5FHJA+e5bDzBaY0b+sF6pVHGASclq
         zE9A==
X-Gm-Message-State: AOAM530/gs4cSh6HZppxLRKkHSEbAKb17YUMntQEcKroQMvo374RPH3g
        +A2V9SRSweRomDU/2A5mfyDpdBH+tG4=
X-Google-Smtp-Source: ABdhPJzAS2fSWsX/31YAia8UJG3e+/r/1gwfUk5/Kk1CegWUYeuwMBko3o1v5L4NS/lRYdlQSPgXzg==
X-Received: by 2002:a17:903:1042:: with SMTP id f2mr10635037plc.115.1643402396610;
        Fri, 28 Jan 2022 12:39:56 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:c6f0:f13b:bc2c:fac:4a86])
        by smtp.gmail.com with ESMTPSA id k3sm11235428pfu.180.2022.01.28.12.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 12:39:55 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH 3/3] perf annotate: Try chroot filename for objdump
Date:   Fri, 28 Jan 2022 12:39:50 -0800
Message-Id: <20220128203950.3371061-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
In-Reply-To: <20220128203950.3371061-1-namhyung@kernel.org>
References: <20220128203950.3371061-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Likewise, it should use a proper name in case the task runs under
chroot.  The child_process.err was needed to set to -1 to show error
messages properly in TUI.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 01900689dc00..e4c641b240df 100644
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
@@ -2036,6 +2046,7 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 	memset(&objdump_process, 0, sizeof(objdump_process));
 	objdump_process.argv = objdump_argv;
 	objdump_process.out = -1;
+	objdump_process.err = -1;
 	if (start_command(&objdump_process)) {
 		pr_err("Failure starting to run %s\n", command);
 		err = -1;
-- 
2.35.0.rc2.247.g8bbb082509-goog

