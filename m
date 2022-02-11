Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB17C4B2334
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 11:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349090AbiBKKf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 05:35:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348100AbiBKKfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 05:35:22 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9880FF0A
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 02:35:11 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id b187-20020a251bc4000000b0061e15c5024fso17726590ybb.4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 02:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zyq69l/QVAkxXrxXDog9O8gGEjbc6SWZFCZOP5MHjmE=;
        b=nS7Eb2pXZ+ByX3nm9gjhVzC0gTTDAANWrPg5S3lXDlqlm32x02fVCrRZdIs39DzmP8
         q1w9sLalMakyPZUblaz/SChaht4TC8IiMZYVy+fvCSf9fojd65aUmfnTK3uSqNQAw3oY
         YVYf2ly3OreNvru8XjuRIUPrhcgFkeabLeZk3h5UAQzuVrpznKq83GS0q4/1DQ09EJJy
         RzagEScoYmXozaiwy2p5WZ50kwpjbtIqhPu9z4YbMtDHX3SeqkClkB6XmSI4fHcQ+rwu
         DHhC3cRhan178Qr+ErZeXET/52OChFNtKML1az0etQLz7HxAQ6yM9+ncVi1K3thhK/10
         igxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zyq69l/QVAkxXrxXDog9O8gGEjbc6SWZFCZOP5MHjmE=;
        b=5Vd39QMpG2V7464A4UlT9jFJ6B83qP5mwUx07nxpNG0MXiEHncLaB1hYEx2XD3dXlI
         5QOqb0q1WcCHMUfg07EdWHknNqe/ch+WotWdgfgL+N00Ybm+MN+Vk8QM8Qpmjv6wi5vy
         EEYptU7/lRLPd1DU7Apb+H0XTVLitLMkRn9LvcILokidGcdpeLxfXwCe49bNy9oJvEK6
         MnHhY0s/yZ9VV8XMKh79DYKNSqSsJsVSeJZCWwzBIDr3sJn7zfBTxvMd6s2mnRNw47SG
         RChjCTkVeoP3SOnon4kvoyLDuB6HEUKTSnDVIKR2Je76gbHGkrSgpnzsz48seeoSsKw/
         rrEw==
X-Gm-Message-State: AOAM531CABLnWrG1dAXzJR5YiIg7o4JtaSjb3NpU9mk+PY+NG+dNVd2T
        w/k1DQarZigcQJWXAxMwz1q7hY3zijuh
X-Google-Smtp-Source: ABdhPJwkCXA3fH2BvEatWT+xS82zXFSx39XwsP47ZQw4Zuz7Z73JI56eq7DF9PbWtZO5TmVGyVYq3pRx70Rx
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:2d98:3ad9:1d8a:fb9b])
 (user=irogers job=sendgmr) by 2002:a81:ae45:: with SMTP id
 g5mr952439ywk.90.1644575710554; Fri, 11 Feb 2022 02:35:10 -0800 (PST)
Date:   Fri, 11 Feb 2022 02:34:13 -0800
In-Reply-To: <20220211103415.2737789-1-irogers@google.com>
Message-Id: <20220211103415.2737789-21-irogers@google.com>
Mime-Version: 1.0
References: <20220211103415.2737789-1-irogers@google.com>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH v3 20/22] perf namespaces: Add reference count checking
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
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
        Dmitry Vyukov <dvyukov@google.com>, Hao Luo <haoluo@google.com>
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
 tools/perf/util/namespaces.c | 132 ++++++++++++++++++++---------------
 tools/perf/util/namespaces.h |   3 +-
 2 files changed, 78 insertions(+), 57 deletions(-)

diff --git a/tools/perf/util/namespaces.c b/tools/perf/util/namespaces.c
index dd536220cdb9..8a3b7bd27b19 100644
--- a/tools/perf/util/namespaces.c
+++ b/tools/perf/util/namespaces.c
@@ -60,7 +60,7 @@ void namespaces__free(struct namespaces *namespaces)
 	free(namespaces);
 }
 
-static int nsinfo__get_nspid(struct nsinfo *nsi, const char *path)
+static int nsinfo__get_nspid(pid_t *tgid, pid_t *nstgid, bool *in_pidns, const char *path)
 {
 	FILE *f = NULL;
 	char *statln = NULL;
@@ -74,19 +74,18 @@ static int nsinfo__get_nspid(struct nsinfo *nsi, const char *path)
 	while (getline(&statln, &linesz, f) != -1) {
 		/* Use tgid if CONFIG_PID_NS is not defined. */
 		if (strstr(statln, "Tgid:") != NULL) {
-			nsi->tgid = (pid_t)strtol(strrchr(statln, '\t'),
-						     NULL, 10);
-			nsi->nstgid = nsinfo__tgid(nsi);
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
@@ -121,8 +120,8 @@ int nsinfo__init(struct nsinfo *nsi)
 	 * want to switch as part of looking up dso/map data.
 	 */
 	if (old_stat.st_ino != new_stat.st_ino) {
-		nsi->need_setns = true;
-		nsi->mntns_path = newns;
+		RC_CHK_ACCESS(nsi)->need_setns = true;
+		RC_CHK_ACCESS(nsi)->mntns_path = newns;
 		newns = NULL;
 	}
 
@@ -132,13 +131,26 @@ int nsinfo__init(struct nsinfo *nsi)
 	if (snprintf(spath, PATH_MAX, "/proc/%d/status", nsinfo__pid(nsi)) >= PATH_MAX)
 		goto out;
 
-	rv = nsinfo__get_nspid(nsi, spath);
+	rv = nsinfo__get_nspid(&RC_CHK_ACCESS(nsi)->tgid, &RC_CHK_ACCESS(nsi)->nstgid,
+			       &RC_CHK_ACCESS(nsi)->in_pidns, spath);
 
 out:
 	free(newns);
 	return rv;
 }
 
+static struct nsinfo *nsinfo__alloc(void)
+{
+	struct nsinfo *res;
+	RC_STRUCT(nsinfo) *nsi;
+
+	nsi = calloc(1, sizeof(*nsi));
+	if (ADD_RC_CHK(res, nsi))
+		refcount_set(&nsi->refcnt, 1);
+
+	return res;
+}
+
 struct nsinfo *nsinfo__new(pid_t pid)
 {
 	struct nsinfo *nsi;
@@ -146,22 +158,21 @@ struct nsinfo *nsinfo__new(pid_t pid)
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
+	nsi = nsinfo__alloc();
+	if (!nsi)
+		return NULL;
 
-		refcount_set(&nsi->refcnt, 1);
-	}
+	RC_CHK_ACCESS(nsi)->pid = pid;
+	RC_CHK_ACCESS(nsi)->tgid = pid;
+	RC_CHK_ACCESS(nsi)->nstgid = pid;
+	RC_CHK_ACCESS(nsi)->need_setns = false;
+	RC_CHK_ACCESS(nsi)->in_pidns = false;
+	/* Init may fail if the process exits while we're trying to look at its
+	 * proc information. In that case, save the pid but don't try to enter
+	 * the namespace.
+	 */
+	if (nsinfo__init(nsi) == -1)
+		RC_CHK_ACCESS(nsi)->need_setns = false;
 
 	return nsi;
 }
@@ -173,21 +184,21 @@ struct nsinfo *nsinfo__copy(const struct nsinfo *nsi)
 	if (nsi == NULL)
 		return NULL;
 
-	nnsi = calloc(1, sizeof(*nnsi));
-	if (nnsi != NULL) {
-		nnsi->pid = nsinfo__pid(nsi);
-		nnsi->tgid = nsinfo__tgid(nsi);
-		nnsi->nstgid = nsinfo__nstgid(nsi);
-		nnsi->need_setns = nsinfo__need_setns(nsi);
-		nnsi->in_pidns = nsinfo__in_pidns(nsi);
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
+	RC_CHK_ACCESS(nnsi)->pid = nsinfo__pid(nsi);
+	RC_CHK_ACCESS(nnsi)->tgid = nsinfo__tgid(nsi);
+	RC_CHK_ACCESS(nnsi)->nstgid = nsinfo__nstgid(nsi);
+	RC_CHK_ACCESS(nnsi)->need_setns = nsinfo__need_setns(nsi);
+	RC_CHK_ACCESS(nnsi)->in_pidns = nsinfo__in_pidns(nsi);
+	if (RC_CHK_ACCESS(nsi)->mntns_path) {
+		RC_CHK_ACCESS(nnsi)->mntns_path = strdup(RC_CHK_ACCESS(nsi)->mntns_path);
+		if (!RC_CHK_ACCESS(nnsi)->mntns_path) {
+			nsinfo__put(nnsi);
+			return NULL;
 		}
-		refcount_set(&nnsi->refcnt, 1);
 	}
 
 	return nnsi;
@@ -195,51 +206,60 @@ struct nsinfo *nsinfo__copy(const struct nsinfo *nsi)
 
 static void nsinfo__delete(struct nsinfo *nsi)
 {
-	zfree(&nsi->mntns_path);
-	free(nsi);
+	if (nsi) {
+		WARN_ONCE(refcount_read(&RC_CHK_ACCESS(nsi)->refcnt) != 0,
+			"nsinfo refcnt unbalanced\n");
+		zfree(&RC_CHK_ACCESS(nsi)->mntns_path);
+		RC_CHK_FREE(nsi);
+	}
 }
 
 struct nsinfo *nsinfo__get(struct nsinfo *nsi)
 {
-	if (nsi)
-		refcount_inc(&nsi->refcnt);
-	return nsi;
+	struct nsinfo *result;
+
+	if (RC_CHK_GET(result, nsi))
+		refcount_inc(&RC_CHK_ACCESS(nsi)->refcnt);
+
+	return result;
 }
 
 void nsinfo__put(struct nsinfo *nsi)
 {
-	if (nsi && refcount_dec_and_test(&nsi->refcnt))
+	if (nsi && refcount_dec_and_test(&RC_CHK_ACCESS(nsi)->refcnt))
 		nsinfo__delete(nsi);
+	else
+		RC_CHK_PUT(nsi);
 }
 
 bool nsinfo__need_setns(const struct nsinfo *nsi)
 {
-        return nsi->need_setns;
+	return RC_CHK_ACCESS(nsi)->need_setns;
 }
 
 void nsinfo__clear_need_setns(struct nsinfo *nsi)
 {
-        nsi->need_setns = false;
+	RC_CHK_ACCESS(nsi)->need_setns = false;
 }
 
 pid_t nsinfo__tgid(const struct nsinfo  *nsi)
 {
-        return nsi->tgid;
+	return RC_CHK_ACCESS(nsi)->tgid;
 }
 
 pid_t nsinfo__nstgid(const struct nsinfo  *nsi)
 {
-        return nsi->nstgid;
+	return RC_CHK_ACCESS(nsi)->nstgid;
 }
 
 pid_t nsinfo__pid(const struct nsinfo  *nsi)
 {
-        return nsi->pid;
+	return RC_CHK_ACCESS(nsi)->pid;
 }
 
 pid_t nsinfo__in_pidns(const struct nsinfo  *nsi)
 {
-        return nsi->in_pidns;
+	return RC_CHK_ACCESS(nsi)->in_pidns;
 }
 
 void nsinfo__mountns_enter(struct nsinfo *nsi,
@@ -256,7 +276,7 @@ void nsinfo__mountns_enter(struct nsinfo *nsi,
 	nc->oldns = -1;
 	nc->newns = -1;
 
-	if (!nsi || !nsi->need_setns)
+	if (!nsi || !RC_CHK_ACCESS(nsi)->need_setns)
 		return;
 
 	if (snprintf(curpath, PATH_MAX, "/proc/self/ns/mnt") >= PATH_MAX)
@@ -270,7 +290,7 @@ void nsinfo__mountns_enter(struct nsinfo *nsi,
 	if (oldns < 0)
 		goto errout;
 
-	newns = open(nsi->mntns_path, O_RDONLY);
+	newns = open(RC_CHK_ACCESS(nsi)->mntns_path, O_RDONLY);
 	if (newns < 0)
 		goto errout;
 
@@ -339,9 +359,9 @@ int nsinfo__stat(const char *filename, struct stat *st, struct nsinfo *nsi)
 
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
index 567829262c42..8c0731c6cbb7 100644
--- a/tools/perf/util/namespaces.h
+++ b/tools/perf/util/namespaces.h
@@ -13,6 +13,7 @@
 #include <linux/perf_event.h>
 #include <linux/refcount.h>
 #include <linux/types.h>
+#include <internal/rc_check.h>
 
 #ifndef HAVE_SETNS_SUPPORT
 int setns(int fd, int nstype);
@@ -29,7 +30,7 @@ struct namespaces {
 struct namespaces *namespaces__new(struct perf_record_namespaces *event);
 void namespaces__free(struct namespaces *namespaces);
 
-struct nsinfo {
+DECLARE_RC_STRUCT(nsinfo) {
 	pid_t			pid;
 	pid_t			tgid;
 	pid_t			nstgid;
-- 
2.35.1.265.g69c8d7142f-goog

