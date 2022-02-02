Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEAA4A6C18
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 08:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbiBBHIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 02:08:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbiBBHIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 02:08:34 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B1F1C061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 23:08:34 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id y5-20020a17090aca8500b001b8127e3d3aso5126281pjt.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 23:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MV8O8CJsQqYhluLSIAE5EBtANtsg2uFNQiqm9GdY+xw=;
        b=RTpFyNrvnzH0p1PgIOkxHqhsetwx2FAo4V3xbl+gpI+Isi3fZ45JjEcOWTQxPfm2Bs
         zUoRU4Q6jyonbJl3KesIwyYV1W6Suagm8/oq9ImbQcMB+sp8lm/sU/XhVi0uV5fliYwA
         qp9w14uQB9hcEonrVhU9KlFlUayz1oB+Pd+suSth/9xprkPXHCh8V5Qlqz+aStObgSBQ
         cE9sR9DnqHVZ8kWTdPiLW8GwkqPn3fbQYKRPpd4At10vV2CpiMhYcXI12sctgBIjr2RV
         iGfW0QKE1t7toETcETyC+/kpew+IFKdET/wiQpvE80UpmTsGM/Yff7IMRUAjM5TSOhPu
         c5tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=MV8O8CJsQqYhluLSIAE5EBtANtsg2uFNQiqm9GdY+xw=;
        b=7g6+CriW1XFXb3CGSkN+J65qmuKiIQ+/psVU8nHj/qptq5bCiluxZNbh1pATq9FYMQ
         KepV15urUUHoiUQqTFSfwgCjSqT7lU0xsh9qwyJZQRDdbsfCaYlaJxX3NudrdxSoXyQ4
         AILyq/IEty3S4l9u51DW1i+pjJ12u6G9JlKl5yFO2nK6jKe/VpFX/ZaFHFnrF20v8UAt
         m72QA3kAJnxrZXztYhtL1Ruckz1RCEqL2DeOyA4qvbLL6H3QsqoIMlfHzVPpv4xON44c
         5Mbk7yxutVKwjeqDc4KOOIZInSx7e3uw1J9/oK/WB8DIq8zWD4VGdA6idwRN7mZvH07s
         nwUw==
X-Gm-Message-State: AOAM5322hfl+fpAM9iLHFEkeHgBDPfHvo+pUsV6ICzafqYEagbBTip3v
        UD6WaYjMpJuaff2QVN+Uank=
X-Google-Smtp-Source: ABdhPJwtYGMzAM+SS51DxjD9tdBoqxJPgNwZmcMMhwowY51nHYcAbP4gbQ0rBdd61Wd/43Nknqem6Q==
X-Received: by 2002:a17:902:7848:: with SMTP id e8mr29415164pln.90.1643785713573;
        Tue, 01 Feb 2022 23:08:33 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:c6f0:9c9f:e426:5704:d42b])
        by smtp.gmail.com with ESMTPSA id e15sm4936879pjd.52.2022.02.01.23.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 23:08:33 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH 2/4] perf tools: Try chroot'ed filename when opening dso/symbol
Date:   Tue,  1 Feb 2022 23:08:26 -0800
Message-Id: <20220202070828.143303-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
In-Reply-To: <20220202070828.143303-1-namhyung@kernel.org>
References: <20220202070828.143303-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently it doesn't handle tasks in chroot properly.  As filenames in
MMAP records base on their root directory, it's different than what
perf tool can see from outside.

Add filename_with_chroot() helper to deal with those cases.  The
function returns a new filename only if it's in a different root
directory.  Since it needs to access /proc for the process, it only
works until the task exits.

With this change, I can see symbols in my program like below.

  # perf record -o- chroot myroot myprog 3 | perf report -i-
  ...
  #
  # Overhead  Command  Shared Object      Symbol
  # ........  .......  .................  .............................
  #
      99.83%  myprog   myprog             [.] loop
       0.04%  chroot   [kernel.kallsyms]  [k] fxregs_fixup
       0.04%  chroot   [kernel.kallsyms]  [k] rsm_load_seg_32
  ...

Acked-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/dso.c    | 15 +++++++++++++--
 tools/perf/util/dsos.c   | 13 +++++++++++++
 tools/perf/util/symbol.c | 10 ++++++++++
 tools/perf/util/util.c   | 31 +++++++++++++++++++++++++++++++
 tools/perf/util/util.h   |  2 ++
 5 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 9cc8a1772b4b..5ac13958d1bd 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -508,8 +508,19 @@ static int __open_dso(struct dso *dso, struct machine *machine)
 					    root_dir, name, PATH_MAX))
 		goto out;
 
-	if (!is_regular_file(name))
-		goto out;
+	if (!is_regular_file(name)) {
+		char *new_name;
+
+		if (errno != ENOENT || dso->nsinfo == NULL)
+			goto out;
+
+		new_name = filename_with_chroot(dso->nsinfo->pid, name);
+		if (!new_name)
+			goto out;
+
+		free(name);
+		name = new_name;
+	}
 
 	if (dso__needs_decompress(dso)) {
 		char newpath[KMOD_DECOMP_LEN];
diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index 183a81d5b2f9..b97366f77bbf 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -2,12 +2,15 @@
 #include "debug.h"
 #include "dsos.h"
 #include "dso.h"
+#include "util.h"
 #include "vdso.h"
 #include "namespaces.h"
+#include <errno.h>
 #include <libgen.h>
 #include <stdlib.h>
 #include <string.h>
 #include <symbol.h> // filename__read_build_id
+#include <unistd.h>
 
 static int __dso_id__cmp(struct dso_id *a, struct dso_id *b)
 {
@@ -76,6 +79,16 @@ bool __dsos__read_build_ids(struct list_head *head, bool with_hits)
 		if (filename__read_build_id(pos->long_name, &pos->bid) > 0) {
 			have_build_id	  = true;
 			pos->has_build_id = true;
+		} else if (errno == ENOENT && pos->nsinfo) {
+			char *new_name = filename_with_chroot(pos->nsinfo->pid,
+							      pos->long_name);
+
+			if (new_name && filename__read_build_id(new_name,
+								&pos->bid) > 0) {
+				have_build_id = true;
+				pos->has_build_id = true;
+			}
+			free(new_name);
 		}
 		nsinfo__mountns_exit(&nsc);
 	}
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index b2ed3140a1fa..34302c61d36b 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1864,6 +1864,16 @@ int dso__load(struct dso *dso, struct map *map)
 			nsinfo__mountns_exit(&nsc);
 
 		is_reg = is_regular_file(name);
+		if (!is_reg && errno == ENOENT && dso->nsinfo) {
+			char *new_name = filename_with_chroot(dso->nsinfo->pid,
+							      name);
+			if (new_name) {
+				is_reg = is_regular_file(new_name);
+				strlcpy(name, new_name, PATH_MAX);
+				free(new_name);
+			}
+		}
+
 #ifdef HAVE_LIBBFD_SUPPORT
 		if (is_reg)
 			bfdrc = dso__load_bfd_symbols(dso, name);
diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index fb4f6616b5fa..f8571a66d063 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -431,3 +431,34 @@ void perf_debuginfod_setup(struct perf_debuginfod *di)
 
 	pr_debug("DEBUGINFOD_URLS=%s\n", getenv("DEBUGINFOD_URLS"));
 }
+
+/*
+ * Return a new filename prepended with task's root directory if it's in
+ * a chroot.  Callers should free the returned string.
+ */
+char *filename_with_chroot(int pid, const char *filename)
+{
+	char buf[PATH_MAX];
+	char proc_root[32];
+	char *new_name = NULL;
+	int ret;
+
+	scnprintf(proc_root, sizeof(proc_root), "/proc/%d/root", pid);
+	ret = readlink(proc_root, buf, sizeof(buf) - 1);
+	if (ret <= 0)
+		return NULL;
+
+	/* readlink(2) does not append a null byte to buf */
+	buf[ret] = '\0';
+
+	if (!strcmp(buf, "/"))
+		return NULL;
+
+	if (strstr(buf, "(deleted)"))
+		return NULL;
+
+	if (asprintf(&new_name, "%s/%s", buf, filename) < 0)
+		return NULL;
+
+	return new_name;
+}
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index 7b625cbd2dd8..0f78f1e7782d 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -77,4 +77,6 @@ struct perf_debuginfod {
 	bool		 set;
 };
 void perf_debuginfod_setup(struct perf_debuginfod *di);
+
+char *filename_with_chroot(int pid, const char *filename);
 #endif /* GIT_COMPAT_UTIL_H */
-- 
2.35.0.rc2.247.g8bbb082509-goog

