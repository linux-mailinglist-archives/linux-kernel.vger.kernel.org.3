Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17E5349BD67
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 21:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbiAYUqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 15:46:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232499AbiAYUqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 15:46:18 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0B2C061748
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 12:46:18 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id a4-20020a5b0ec4000000b00615dc8c1623so6259022ybs.17
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 12:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Krzq0l2cuCvov6m4mTyGKggqBY2ioOeKFOBwv0ymBmQ=;
        b=tM+76O8WxuPtMZ+BsXvTTLDSQUzg3CE0Zl5nKI/b3BitnA8Lv9Jz62IIh4xsUgIad1
         +ba7WV47ICrcGzuV/05z8ez6depcz9wHYLcp/3ixYB+ta0crHl9olLTwBKkVNaQXGkR4
         stXMbLE7CbU12NDMiV4N2+4LAWDZL2fEsyYrdQVm/T7vggileAojt3V9jpj32qamj9TB
         PuYp2506wTTcF8fe996h5kz3hkY1H/qJdlwC0NXsrUk8vazI6zYllG5vrdedREydznBM
         VvTsk60d8yDStDwOWnMD7AHArxXh1IdcsnB1S6rAJkZ6V7Jv/WkM42kjdWnnQCfiD0vl
         8sHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Krzq0l2cuCvov6m4mTyGKggqBY2ioOeKFOBwv0ymBmQ=;
        b=dVNgUL6i2i1WUFbGxdTokRZa1Aak5UdGJm2U8ZhFjbsiCmVkjUM2S/oketJbpUU6RE
         QKUw/vT8EZ4IaOmNmBCWxC8f4xFDVpgKrp90548TTEcbpeOhhM4c/7S3Tel6C8ivaetI
         lRapAw36+LSAO1tmKb99cXuu4vqAVcvcY+dXqKxD9PoL8IMQ4EyTBcgw5XX4iNJl+yZ0
         3kD2Sdx5kuAe3jALG7nQJ9HbaTQ686n+XRm4pz2ztfRPr+124arfMZq4HyNL93f+1AyO
         4W+s8YwhOHkWqooZOciCi1+74DFQ7CK92r84aCOUkNGwV3+WKMEDl7z6I8V147sInKKw
         +wqw==
X-Gm-Message-State: AOAM531E6TTQcE32VKbR0txXezOJGLrp0AY5EkHJIwtfWWb+yHVyNTqa
        IqOqqKk91q9FgOleiA3QO9Etx1VSSgBM
X-Google-Smtp-Source: ABdhPJzOYkUsznrcF1fdWmKRRvWJ0yFtI9yedtEBzGE2Dt/5pAMC8O5oR+Fhy/mso+2l2DB68WeMa5ZFO9Mo
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:1a99:924a:8878:c44a])
 (user=irogers job=sendgmr) by 2002:a05:6902:1243:: with SMTP id
 t3mr20862509ybu.304.1643143577536; Tue, 25 Jan 2022 12:46:17 -0800 (PST)
Date:   Tue, 25 Jan 2022 12:46:02 -0800
In-Reply-To: <20220125204602.4137477-1-irogers@google.com>
Message-Id: <20220125204602.4137477-5-irogers@google.com>
Mime-Version: 1.0
References: <20220125204602.4137477-1-irogers@google.com>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
Subject: [PATCH v2 4/4] perf namespaces: Add reference count checking
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@collabora.com>,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Song Liu <song@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miaoqian Lin <linmq006@gmail.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add reference count checking controlled by REFCNT_CHECKING ifdef. The
reference count checking interposes an allocated pointer between the
reference counted struct on a get and frees the pointer on a put.
Accesses after a put cause faults and use after free, missed puts are
caughts as leaks and double puts are double frees.

This checking helped resolve a memory leak and use after free:
https://lore.kernel.org/linux-perf-users/CAP-5=fWZH20L4kv-BwVtGLwR=Em3AOOT+Q4QGivvQuYn5AsPRg@mail.gmail.com/

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-inject.c  |   2 +-
 tools/perf/builtin-probe.c   |   2 +-
 tools/perf/util/build-id.c   |   4 +-
 tools/perf/util/jitdump.c    |  10 +-
 tools/perf/util/map.c        |   4 +-
 tools/perf/util/namespaces.c | 187 +++++++++++++++++++++++++----------
 tools/perf/util/namespaces.h |  23 ++++-
 tools/perf/util/symbol.c     |   8 +-
 8 files changed, 168 insertions(+), 72 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index bede332bf0e2..f7917c390e96 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -354,7 +354,7 @@ static struct dso *findnew_dso(int pid, int tid, const char *filename,
 		nnsi = nsinfo__copy(nsi);
 		if (nnsi) {
 			nsinfo__put(nsi);
-			nnsi->need_setns = false;
+			nsinfo__clear_need_setns(nnsi);
 			nsi = nnsi;
 		}
 		dso = machine__findnew_vdso(machine, thread);
diff --git a/tools/perf/builtin-probe.c b/tools/perf/builtin-probe.c
index c31627af75d4..f62298f5db3b 100644
--- a/tools/perf/builtin-probe.c
+++ b/tools/perf/builtin-probe.c
@@ -217,7 +217,7 @@ static int opt_set_target_ns(const struct option *opt __maybe_unused,
 			return ret;
 		}
 		nsip = nsinfo__new(ns_pid);
-		if (nsip && nsip->need_setns)
+		if (nsip && nsinfo__need_setns(nsip))
 			params.nsi = nsinfo__get(nsip);
 		nsinfo__put(nsip);
 
diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index e32e8f2ff3bd..7a5821c87f94 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -706,7 +706,7 @@ build_id_cache__add(const char *sbuild_id, const char *name, const char *realnam
 		if (is_kallsyms) {
 			if (copyfile("/proc/kallsyms", filename))
 				goto out_free;
-		} else if (nsi && nsi->need_setns) {
+		} else if (nsi && nsinfo__need_setns(nsi)) {
 			if (copyfile_ns(name, filename, nsi))
 				goto out_free;
 		} else if (link(realname, filename) && errno != EEXIST &&
@@ -730,7 +730,7 @@ build_id_cache__add(const char *sbuild_id, const char *name, const char *realnam
 				goto out_free;
 			}
 			if (access(filename, F_OK)) {
-				if (nsi && nsi->need_setns) {
+				if (nsi && nsinfo__need_setns(nsi)) {
 					if (copyfile_ns(debugfile, filename,
 							nsi))
 						goto out_free;
diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index 917a9c707371..a23255773c60 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -382,15 +382,15 @@ jit_inject_event(struct jit_buf_desc *jd, union perf_event *event)
 
 static pid_t jr_entry_pid(struct jit_buf_desc *jd, union jr_entry *jr)
 {
-	if (jd->nsi && jd->nsi->in_pidns)
-		return jd->nsi->tgid;
+	if (jd->nsi && nsinfo__in_pidns(jd->nsi))
+		return nsinfo__tgid(jd->nsi);
 	return jr->load.pid;
 }
 
 static pid_t jr_entry_tid(struct jit_buf_desc *jd, union jr_entry *jr)
 {
-	if (jd->nsi && jd->nsi->in_pidns)
-		return jd->nsi->pid;
+	if (jd->nsi && nsinfo__in_pidns(jd->nsi))
+		return nsinfo__pid(jd->nsi);
 	return jr->load.tid;
 }
 
@@ -779,7 +779,7 @@ jit_detect(char *mmap_name, pid_t pid, struct nsinfo *nsi)
 	 * pid does not match mmap pid
 	 * pid==0 in system-wide mode (synthesized)
 	 */
-	if (pid && pid2 != nsi->nstgid)
+	if (pid && pid2 != nsinfo__nstgid(nsi))
 		return -1;
 	/*
 	 * validate suffix
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index ae99b52502d5..5b93a91bb0f9 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -151,7 +151,7 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
 
 		if ((anon || no_dso) && nsi && (prot & PROT_EXEC)) {
 			snprintf(newfilename, sizeof(newfilename),
-				 "/tmp/perf-%d.map", nsi->pid);
+				 "/tmp/perf-%d.map", nsinfo__pid(nsi));
 			filename = newfilename;
 		}
 
@@ -168,7 +168,7 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
 			nnsi = nsinfo__copy(nsi);
 			if (nnsi) {
 				nsinfo__put(nsi);
-				nnsi->need_setns = false;
+				nsinfo__clear_need_setns(nnsi);
 				nsi = nnsi;
 			}
 			pgoff = 0;
diff --git a/tools/perf/util/namespaces.c b/tools/perf/util/namespaces.c
index 48aa3217300b..4187179107ec 100644
--- a/tools/perf/util/namespaces.c
+++ b/tools/perf/util/namespaces.c
@@ -30,6 +30,12 @@ static const char *perf_ns__names[] = {
 	[CGROUP_NS_INDEX]	= "cgroup",
 };
 
+#ifndef REFCNT_CHECKING
+#define UNWRAP_NSI(x) x
+#else
+#define UNWRAP_NSI(x) x->orig
+#endif
+
 const char *perf_ns__name(unsigned int id)
 {
 	if (id >= ARRAY_SIZE(perf_ns__names))
@@ -60,7 +66,7 @@ void namespaces__free(struct namespaces *namespaces)
 	free(namespaces);
 }
 
-static int nsinfo__get_nspid(struct nsinfo *nsi, const char *path)
+static int nsinfo__get_nspid(pid_t *tgid, pid_t *nstgid, bool *in_pidns, const char *path)
 {
 	FILE *f = NULL;
 	char *statln = NULL;
@@ -74,19 +80,18 @@ static int nsinfo__get_nspid(struct nsinfo *nsi, const char *path)
 	while (getline(&statln, &linesz, f) != -1) {
 		/* Use tgid if CONFIG_PID_NS is not defined. */
 		if (strstr(statln, "Tgid:") != NULL) {
-			nsi->tgid = (pid_t)strtol(strrchr(statln, '\t'),
-						     NULL, 10);
-			nsi->nstgid = nsi->tgid;
+			*tgid = (pid_t)strtol(strrchr(statln, '\t'), NULL, 10);
+			*nstgid = *tgid;
 		}
 
 		if (strstr(statln, "NStgid:") != NULL) {
 			nspid = strrchr(statln, '\t');
-			nsi->nstgid = (pid_t)strtol(nspid, NULL, 10);
+			*nstgid = (pid_t)strtol(nspid, NULL, 10);
 			/*
 			 * If innermost tgid is not the first, process is in a different
 			 * PID namespace.
 			 */
-			nsi->in_pidns = (statln + sizeof("NStgid:") - 1) != nspid;
+			*in_pidns = (statln + sizeof("NStgid:") - 1) != nspid;
 			break;
 		}
 	}
@@ -108,7 +113,7 @@ int nsinfo__init(struct nsinfo *nsi)
 	if (snprintf(oldns, PATH_MAX, "/proc/self/ns/mnt") >= PATH_MAX)
 		return rv;
 
-	if (asprintf(&newns, "/proc/%d/ns/mnt", nsi->pid) == -1)
+	if (asprintf(&newns, "/proc/%d/ns/mnt", UNWRAP_NSI(nsi)->pid) == -1)
 		return rv;
 
 	if (stat(oldns, &old_stat) < 0)
@@ -121,24 +126,47 @@ int nsinfo__init(struct nsinfo *nsi)
 	 * want to switch as part of looking up dso/map data.
 	 */
 	if (old_stat.st_ino != new_stat.st_ino) {
-		nsi->need_setns = true;
-		nsi->mntns_path = newns;
+		UNWRAP_NSI(nsi)->need_setns = true;
+		UNWRAP_NSI(nsi)->mntns_path = newns;
 		newns = NULL;
 	}
 
 	/* If we're dealing with a process that is in a different PID namespace,
 	 * attempt to work out the innermost tgid for the process.
 	 */
-	if (snprintf(spath, PATH_MAX, "/proc/%d/status", nsi->pid) >= PATH_MAX)
+	if (snprintf(spath, PATH_MAX, "/proc/%d/status", UNWRAP_NSI(nsi)->pid) >= PATH_MAX)
 		goto out;
 
-	rv = nsinfo__get_nspid(nsi, spath);
+	rv = nsinfo__get_nspid(&UNWRAP_NSI(nsi)->tgid, &UNWRAP_NSI(nsi)->nstgid,
+			       &UNWRAP_NSI(nsi)->in_pidns, spath);
 
 out:
 	free(newns);
 	return rv;
 }
 
+static struct nsinfo *nsinfo__alloc(void)
+{
+	struct nsinfo *res;
+#ifdef REFCNT_CHECKING
+	res = malloc(sizeof(*res));
+	if (!res)
+		return NULL;
+
+	res->orig = calloc(1, sizeof(struct original_nsinfo));
+	if (!res->orig) {
+		free(res);
+		res = NULL;
+	} else
+		refcount_set(&res->orig->refcnt, 1);
+#else
+	res = calloc(1, sizeof(*res));
+	if (res)
+		refcount_set(&res->refcnt, 1);
+#endif
+	return res;
+}
+
 struct nsinfo *nsinfo__new(pid_t pid)
 {
 	struct nsinfo *nsi;
@@ -146,70 +174,121 @@ struct nsinfo *nsinfo__new(pid_t pid)
 	if (pid == 0)
 		return NULL;
 
-	nsi = calloc(1, sizeof(*nsi));
-	if (nsi != NULL) {
-		nsi->pid = pid;
-		nsi->tgid = pid;
-		nsi->nstgid = pid;
-		nsi->need_setns = false;
-		nsi->in_pidns = false;
-		/* Init may fail if the process exits while we're trying to look
-		 * at its proc information.  In that case, save the pid but
-		 * don't try to enter the namespace.
-		 */
-		if (nsinfo__init(nsi) == -1)
-			nsi->need_setns = false;
-
-		refcount_set(&nsi->refcnt, 1);
-	}
+	nsi = nsinfo__alloc();
+	if (!nsi)
+		return NULL;
+
+	UNWRAP_NSI(nsi)->pid = pid;
+	UNWRAP_NSI(nsi)->tgid = pid;
+	UNWRAP_NSI(nsi)->nstgid = pid;
+	UNWRAP_NSI(nsi)->need_setns = false;
+	UNWRAP_NSI(nsi)->in_pidns = false;
+	/* Init may fail if the process exits while we're trying to look at its
+	 * proc information. In that case, save the pid but don't try to enter
+	 * the namespace.
+	 */
+	if (nsinfo__init(nsi) == -1)
+		UNWRAP_NSI(nsi)->need_setns = false;
 
 	return nsi;
 }
 
-struct nsinfo *nsinfo__copy(struct nsinfo *nsi)
+struct nsinfo *nsinfo__copy(const struct nsinfo *nsi)
 {
 	struct nsinfo *nnsi;
 
 	if (nsi == NULL)
 		return NULL;
 
-	nnsi = calloc(1, sizeof(*nnsi));
-	if (nnsi != NULL) {
-		nnsi->pid = nsi->pid;
-		nnsi->tgid = nsi->tgid;
-		nnsi->nstgid = nsi->nstgid;
-		nnsi->need_setns = nsi->need_setns;
-		nnsi->in_pidns = nsi->in_pidns;
-		if (nsi->mntns_path) {
-			nnsi->mntns_path = strdup(nsi->mntns_path);
-			if (!nnsi->mntns_path) {
-				free(nnsi);
-				return NULL;
-			}
+	nnsi = nsinfo__alloc();
+	if (!nnsi)
+		return NULL;
+
+	UNWRAP_NSI(nnsi)->pid = UNWRAP_NSI(nsi)->pid;
+	UNWRAP_NSI(nnsi)->tgid = UNWRAP_NSI(nsi)->tgid;
+	UNWRAP_NSI(nnsi)->nstgid = UNWRAP_NSI(nsi)->nstgid;
+	UNWRAP_NSI(nnsi)->need_setns = UNWRAP_NSI(nsi)->need_setns;
+	UNWRAP_NSI(nnsi)->in_pidns = UNWRAP_NSI(nsi)->in_pidns;
+	if (UNWRAP_NSI(nsi)->mntns_path) {
+		UNWRAP_NSI(nnsi)->mntns_path = strdup(UNWRAP_NSI(nsi)->mntns_path);
+		if (!UNWRAP_NSI(nnsi)->mntns_path) {
+			nsinfo__put(nnsi);
+			return NULL;
 		}
-		refcount_set(&nnsi->refcnt, 1);
 	}
 
 	return nnsi;
 }
 
-void nsinfo__delete(struct nsinfo *nsi)
+static void nsinfo__delete(struct nsinfo *nsi)
 {
-	zfree(&nsi->mntns_path);
-	free(nsi);
+	if (nsi) {
+		WARN_ONCE(refcount_read(&UNWRAP_NSI(nsi)->refcnt) != 0,
+			"nsinfo refcnt unbalanced\n");
+		zfree(&UNWRAP_NSI(nsi)->mntns_path);
+#ifdef REFCNT_CHECKING
+		zfree(&nsi->orig);
+#endif
+		free(nsi);
+	}
 }
 
 struct nsinfo *nsinfo__get(struct nsinfo *nsi)
 {
-	if (nsi)
-		refcount_inc(&nsi->refcnt);
+	if (nsi) {
+#ifdef REFCNT_CHECKING
+		struct nsinfo *new_wrapper;
+#endif
+		refcount_inc(&UNWRAP_NSI(nsi)->refcnt);
+#ifdef REFCNT_CHECKING
+		new_wrapper = malloc(sizeof(*new_wrapper));
+		new_wrapper->orig = nsi->orig;
+		nsi = new_wrapper;
+#endif
+	}
 	return nsi;
 }
 
 void nsinfo__put(struct nsinfo *nsi)
 {
-	if (nsi && refcount_dec_and_test(&nsi->refcnt))
+	if (nsi && refcount_dec_and_test(&UNWRAP_NSI(nsi)->refcnt))
 		nsinfo__delete(nsi);
+#ifdef REFCNT_CHECKING
+	else if (nsi) {
+		nsi->orig = NULL;
+		free(nsi);
+	}
+#endif
+}
+
+bool nsinfo__need_setns(const struct nsinfo *nsi)
+{
+	return UNWRAP_NSI(nsi)->need_setns;
+}
+
+void nsinfo__clear_need_setns(struct nsinfo *nsi)
+{
+	UNWRAP_NSI(nsi)->need_setns = false;
+}
+
+pid_t nsinfo__tgid(const struct nsinfo  *nsi)
+{
+	return UNWRAP_NSI(nsi)->tgid;
+}
+
+pid_t nsinfo__nstgid(const struct nsinfo  *nsi)
+{
+	return UNWRAP_NSI(nsi)->nstgid;
+}
+
+pid_t nsinfo__pid(const struct nsinfo  *nsi)
+{
+	return UNWRAP_NSI(nsi)->pid;
+}
+
+pid_t nsinfo__in_pidns(const struct nsinfo  *nsi)
+{
+	return UNWRAP_NSI(nsi)->in_pidns;
 }
 
 void nsinfo__mountns_enter(struct nsinfo *nsi,
@@ -226,7 +305,7 @@ void nsinfo__mountns_enter(struct nsinfo *nsi,
 	nc->oldns = -1;
 	nc->newns = -1;
 
-	if (!nsi || !nsi->need_setns)
+	if (!nsi || !UNWRAP_NSI(nsi)->need_setns)
 		return;
 
 	if (snprintf(curpath, PATH_MAX, "/proc/self/ns/mnt") >= PATH_MAX)
@@ -240,7 +319,7 @@ void nsinfo__mountns_enter(struct nsinfo *nsi,
 	if (oldns < 0)
 		goto errout;
 
-	newns = open(nsi->mntns_path, O_RDONLY);
+	newns = open(UNWRAP_NSI(nsi)->mntns_path, O_RDONLY);
 	if (newns < 0)
 		goto errout;
 
@@ -309,9 +388,9 @@ int nsinfo__stat(const char *filename, struct stat *st, struct nsinfo *nsi)
 
 bool nsinfo__is_in_root_namespace(void)
 {
-	struct nsinfo nsi;
+	pid_t tgid = 0, nstgid = 0;
+	bool in_pidns = false;
 
-	memset(&nsi, 0x0, sizeof(nsi));
-	nsinfo__get_nspid(&nsi, "/proc/self/status");
-	return !nsi.in_pidns;
+	nsinfo__get_nspid(&tgid, &nstgid, &in_pidns, "/proc/self/status");
+	return !in_pidns;
 }
diff --git a/tools/perf/util/namespaces.h b/tools/perf/util/namespaces.h
index 9ceea9643507..673c7bcdb9b0 100644
--- a/tools/perf/util/namespaces.h
+++ b/tools/perf/util/namespaces.h
@@ -29,7 +29,12 @@ struct namespaces {
 struct namespaces *namespaces__new(struct perf_record_namespaces *event);
 void namespaces__free(struct namespaces *namespaces);
 
-struct nsinfo {
+#ifndef REFCNT_CHECKING
+struct nsinfo
+#else
+struct original_nsinfo
+#endif
+{
 	pid_t			pid;
 	pid_t			tgid;
 	pid_t			nstgid;
@@ -39,6 +44,12 @@ struct nsinfo {
 	refcount_t		refcnt;
 };
 
+#ifdef REFCNT_CHECKING
+struct nsinfo {
+	struct original_nsinfo *orig;
+};
+#endif
+
 struct nscookie {
 	int			oldns;
 	int			newns;
@@ -47,12 +58,18 @@ struct nscookie {
 
 int nsinfo__init(struct nsinfo *nsi);
 struct nsinfo *nsinfo__new(pid_t pid);
-struct nsinfo *nsinfo__copy(struct nsinfo *nsi);
-void nsinfo__delete(struct nsinfo *nsi);
+struct nsinfo *nsinfo__copy(const struct nsinfo *nsi);
 
 struct nsinfo *nsinfo__get(struct nsinfo *nsi);
 void nsinfo__put(struct nsinfo *nsi);
 
+bool nsinfo__need_setns(const struct nsinfo *nsi);
+void nsinfo__clear_need_setns(struct nsinfo *nsi);
+pid_t nsinfo__tgid(const struct nsinfo  *nsi);
+pid_t nsinfo__nstgid(const struct nsinfo  *nsi);
+pid_t nsinfo__pid(const struct nsinfo  *nsi);
+pid_t nsinfo__in_pidns(const struct nsinfo  *nsi);
+
 void nsinfo__mountns_enter(struct nsinfo *nsi, struct nscookie *nc);
 void nsinfo__mountns_exit(struct nscookie *nc);
 
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index a504346feb05..40477f4d16fa 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1735,8 +1735,8 @@ static int dso__find_perf_map(char *filebuf, size_t bufsz,
 
 	nsi = *nsip;
 
-	if (nsi->need_setns) {
-		snprintf(filebuf, bufsz, "/tmp/perf-%d.map", nsi->nstgid);
+	if (nsinfo__need_setns(nsi)) {
+		snprintf(filebuf, bufsz, "/tmp/perf-%d.map", nsinfo__nstgid(nsi));
 		nsinfo__mountns_enter(nsi, &nsc);
 		rc = access(filebuf, R_OK);
 		nsinfo__mountns_exit(&nsc);
@@ -1748,8 +1748,8 @@ static int dso__find_perf_map(char *filebuf, size_t bufsz,
 	if (nnsi) {
 		nsinfo__put(nsi);
 
-		nnsi->need_setns = false;
-		snprintf(filebuf, bufsz, "/tmp/perf-%d.map", nnsi->tgid);
+		nsinfo__clear_need_setns(nnsi);
+		snprintf(filebuf, bufsz, "/tmp/perf-%d.map", nsinfo__tgid(nnsi));
 		*nsip = nnsi;
 		rc = 0;
 	}
-- 
2.35.0.rc0.227.g00780c9af4-goog

