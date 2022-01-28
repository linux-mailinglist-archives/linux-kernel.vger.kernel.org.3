Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E270A4A022F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 21:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241008AbiA1Uk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 15:40:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351300AbiA1Ujz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 15:39:55 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC2FC061755
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 12:39:54 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id s61-20020a17090a69c300b001b4d0427ea2so11902342pjj.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 12:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BY01qBOdjhAiiWa9uW1+iF389ifyWGwXOZ9xdr+rmug=;
        b=BH/szD6siBQk1860WgLRHuVgS9NK22OdxswVJJSSTpe4HGziKWTdpaIJx2LVb/rXDX
         Ci7DSCWo9dO/0/lrBOGIjG8c91iIHAkf7bklmi6IebAztyL+f+mU5XUK5a9MQRmzna1J
         9iZHv0qjHuWX0P95440lpoQztT6kcHiy2IzZF3xdvwF0dlcqffD5I/UdoR9rId1ym/Fv
         YI4tItrur8C2GtNOMImHO3sIfYj/QxEniOoDCvkVKTw02gZftVhDU8SsKrjpK5AQEf4K
         6rdkbgppGu5tQZtnJb4va+BQVV6vNFkykMUlT8AY61N8bz+tjhn0LeICGHEH9o21lZoR
         tz7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=BY01qBOdjhAiiWa9uW1+iF389ifyWGwXOZ9xdr+rmug=;
        b=kCv6D8+mrpA7Gon0m16j0acHVnS47EELWkZcMNKRG5ql7RW1cT85ktAlblGJG8CqUf
         wRdUVfKZqNZ8JA5gl1mWRHFMizYFoUvHcsSUxfDKlwWHKL9cUbaNBP5lbYP4sfD9eOvU
         GtNNcGlm+dA2ZF2KFHsGNnfMjVNBm8jV7wH9ir0pacLJ7Lk/YVQF38O1Y+dC7RUUHDDe
         xM70RF9dCJ0WEKM5+godSlZKJ0NKuZ3aWV0zsEIBtVlCLS8h6uVeUeQOv714RlFMjkVR
         BCAIDxhUAN4+OH24MD7wh1qbQL0m8EtOCJTU30Cxog8BsXtviydAwIpjEsZJOCPNK/gb
         kk9Q==
X-Gm-Message-State: AOAM530pM4NccuUVglv51jUT2u0ShqJCctFKmqG6cqXWNDopp6bbQrEz
        +1Ib+yZVaQTHJShJhHFmrsg=
X-Google-Smtp-Source: ABdhPJwgr6KUeRY0eaPfaew+ad43L7zs2q+PVU48ZWEnOX3MI42QJTTibPPW9E1dIOHVxRrzeFyZKw==
X-Received: by 2002:a17:90b:4a8e:: with SMTP id lp14mr21643443pjb.75.1643402394057;
        Fri, 28 Jan 2022 12:39:54 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:c6f0:f13b:bc2c:fac:4a86])
        by smtp.gmail.com with ESMTPSA id k3sm11235428pfu.180.2022.01.28.12.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 12:39:53 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH 1/3] perf tools: Try chroot'ed filename when opening dso/symbol
Date:   Fri, 28 Jan 2022 12:39:48 -0800
Message-Id: <20220128203950.3371061-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
In-Reply-To: <20220128203950.3371061-1-namhyung@kernel.org>
References: <20220128203950.3371061-1-namhyung@kernel.org>
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

