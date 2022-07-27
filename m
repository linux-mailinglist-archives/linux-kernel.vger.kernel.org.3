Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E03658254E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 13:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbiG0LU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 07:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbiG0LUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 07:20:23 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F62101F0;
        Wed, 27 Jul 2022 04:20:22 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id f11so15656564pgj.7;
        Wed, 27 Jul 2022 04:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QnUkj2c8cSu2QcTThj3OD9Z8qxSTMpU+d9W2llKMGjA=;
        b=IKwJd4D0cwQT28M+c9RKdca6MP/JRNkmzpDHmDu9leWoplwI97YaUIzbWjtNxT2ReN
         LQuh7OMj5TBLzjknHDuIi+yxjOTcY6HHYH1VWyW4HUujQ+FJp/Br3OSPdb6fyp60X68Z
         YUMtsTLI16cnfO/tExzq0krCUX1AbXQ6NIBRb+GJzYLIqPNYE2hSi9+p7jRHGoV8omsb
         T/uwZn4KlDzHonnE2tbLc1Py9sTjkmr1QXPneJ3ePR3ubrAxQQRtHSayy1CkLdJaUlW1
         9an7usAvjjJkilQfn+Ypy+gAIf8WCr6zZC3FXIBMtW4ep50zAm09duUriBvV1IirHQnp
         jobQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QnUkj2c8cSu2QcTThj3OD9Z8qxSTMpU+d9W2llKMGjA=;
        b=BkvAj4Cji+hTqG+7Hb/Op4svTgZE9/Xd5boFChnHVbA//SXAEqxRKB3uV4O8Ceq79S
         5X1xziVNOSvBUxrfDG9BA1L3Tevg7GUO4gT1roZ81M4o00MdkPoOsMjXdhVl/rCYNNZk
         5yljfJ8DUlxM4WC0RS9DKBpGyOHcWtn4i3QpRdXQBG9P7JSukUGPoH+wmnPWHBahigCm
         eSoRVS9ikWws+4B7LxL6rk0rtlShqFkNA15ijMEHtcsEM5etrCYLbsz0sVIxjwCYJB/C
         rqvSl7Pdey8AZaPKDtSBhfr7g5Y6mDnQX/z9jPIqff8JrffvQkhA9hQUY9JbI5kN0ST9
         zL+w==
X-Gm-Message-State: AJIora85A2YabbRK1vt6YFVNdUp/SKb8lAhTa+HeK4qy9cx4JZwZHlMw
        SplqJvWjFeuBkYHDOLNhjC0=
X-Google-Smtp-Source: AGRyM1tJCKPJ1nWNA0FDCsIsB1qC4KpB5GqYiquZjpL5aw6V+LEC+mI86II5nOOl4HdGEz5R06mSdA==
X-Received: by 2002:a05:6a00:24c3:b0:52b:ee89:eca2 with SMTP id d3-20020a056a0024c300b0052bee89eca2mr17327669pfv.57.1658920821953;
        Wed, 27 Jul 2022 04:20:21 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:e014:b9a7:c341:50d6:ad89:e8ac])
        by smtp.gmail.com with ESMTPSA id w1-20020a170902e88100b0016c433f7c12sm13640212plg.271.2022.07.27.04.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 04:20:21 -0700 (PDT)
From:   gpavithrasha@gmail.com
To:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, namhyung@kernel.org,
        irogers@google.com
Cc:     gpavithrasha@gmail.com
Subject: [PATCH v1 1/4] perf mutex: Wrapped usage of pthread_mutex_t
Date:   Wed, 27 Jul 2022 16:49:51 +0530
Message-Id: <20220727111954.105118-1-gpavithrasha@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: pavithra <gpavithrasha@gmail.com>

Added a new header file mutex.h that wraps the
usage of pthread_mutex_t and updated lock in dso.h.

Signed-off-by: pavithra <gpavithrasha@gmail.com>
---
 tools/perf/util/Build    |  1 +
 tools/perf/util/dso.c    | 33 ++++++++++++++++-----------------
 tools/perf/util/dso.h    |  3 ++-
 tools/perf/util/mutex.c  | 32 ++++++++++++++++++++++++++++++++
 tools/perf/util/mutex.h  | 15 +++++++++++++++
 tools/perf/util/symbol.c |  4 ++--
 6 files changed, 68 insertions(+), 20 deletions(-)
 create mode 100644 tools/perf/util/mutex.c
 create mode 100644 tools/perf/util/mutex.h

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 8dcfca1a882f..559c20d94c36 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -120,6 +120,7 @@ perf-y += time-utils.o
 perf-y += expr-bison.o
 perf-y += branch.o
 perf-y += mem2node.o
+perf-y += mutex.o
 
 perf-$(CONFIG_LIBBPF) += bpf-loader.o
 perf-$(CONFIG_LIBBPF) += bpf_map.o
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index e11ddf86f2b3..605c31585d48 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -426,7 +426,7 @@ void dso__set_module_info(struct dso *dso, struct kmod_path *m,
  */
 static LIST_HEAD(dso__data_open);
 static long dso__data_open_cnt;
-static pthread_mutex_t dso__data_open_lock = PTHREAD_MUTEX_INITIALIZER;
+static struct mutex dso__data_open_lock = PTHREAD_MUTEX_INITIALIZER;
 
 static void dso__list_add(struct dso *dso)
 {
@@ -633,9 +633,9 @@ static void check_data_close(void)
  */
 void dso__data_close(struct dso *dso)
 {
-	pthread_mutex_lock(&dso__data_open_lock);
+	mutex_lock(&dso__data_open_lock);
 	close_dso(dso);
-	pthread_mutex_unlock(&dso__data_open_lock);
+	mutex_unlock(&dso__data_open_lock);
 }
 
 static void try_to_open_dso(struct dso *dso, struct machine *machine)
@@ -684,20 +684,19 @@ int dso__data_get_fd(struct dso *dso, struct machine *machine)
 	if (dso->data.status == DSO_DATA_STATUS_ERROR)
 		return -1;
 
-	if (pthread_mutex_lock(&dso__data_open_lock) < 0)
-		return -1;
+	mutex_lock(&dso__data_open_lock);
 
 	try_to_open_dso(dso, machine);
 
 	if (dso->data.fd < 0)
-		pthread_mutex_unlock(&dso__data_open_lock);
+		mutex_unlock(&dso__data_open_lock);
 
 	return dso->data.fd;
 }
 
 void dso__data_put_fd(struct dso *dso __maybe_unused)
 {
-	pthread_mutex_unlock(&dso__data_open_lock);
+	mutex_unlock(&dso__data_open_lock);
 }
 
 bool dso__data_status_seen(struct dso *dso, enum dso_data_status_seen by)
@@ -756,7 +755,7 @@ dso_cache__free(struct dso *dso)
 	struct rb_root *root = &dso->data.cache;
 	struct rb_node *next = rb_first(root);
 
-	pthread_mutex_lock(&dso->lock);
+	mutex_lock(&dso->lock);
 	while (next) {
 		struct dso_cache *cache;
 
@@ -765,7 +764,7 @@ dso_cache__free(struct dso *dso)
 		rb_erase(&cache->rb_node, root);
 		free(cache);
 	}
-	pthread_mutex_unlock(&dso->lock);
+	mutex_unlock(&dso->lock);
 }
 
 static struct dso_cache *dso_cache__find(struct dso *dso, u64 offset)
@@ -802,7 +801,7 @@ dso_cache__insert(struct dso *dso, struct dso_cache *new)
 	struct dso_cache *cache;
 	u64 offset = new->offset;
 
-	pthread_mutex_lock(&dso->lock);
+	mutex_lock(&dso->lock);
 	while (*p != NULL) {
 		u64 end;
 
@@ -823,7 +822,7 @@ dso_cache__insert(struct dso *dso, struct dso_cache *new)
 
 	cache = NULL;
 out:
-	pthread_mutex_unlock(&dso->lock);
+	mutex_unlock(&dso->lock);
 	return cache;
 }
 
@@ -843,7 +842,7 @@ static ssize_t file_read(struct dso *dso, struct machine *machine,
 {
 	ssize_t ret;
 
-	pthread_mutex_lock(&dso__data_open_lock);
+	mutex_lock(&dso__data_open_lock);
 
 	/*
 	 * dso->data.fd might be closed if other thread opened another
@@ -859,7 +858,7 @@ static ssize_t file_read(struct dso *dso, struct machine *machine,
 
 	ret = pread(dso->data.fd, data, DSO__DATA_CACHE_SIZE, offset);
 out:
-	pthread_mutex_unlock(&dso__data_open_lock);
+	mutex_unlock(&dso__data_open_lock);
 	return ret;
 }
 
@@ -953,7 +952,7 @@ static int file_size(struct dso *dso, struct machine *machine)
 	struct stat st;
 	char sbuf[STRERR_BUFSIZE];
 
-	pthread_mutex_lock(&dso__data_open_lock);
+	mutex_lock(&dso__data_open_lock);
 
 	/*
 	 * dso->data.fd might be closed if other thread opened another
@@ -977,7 +976,7 @@ static int file_size(struct dso *dso, struct machine *machine)
 	dso->data.file_size = st.st_size;
 
 out:
-	pthread_mutex_unlock(&dso__data_open_lock);
+	mutex_unlock(&dso__data_open_lock);
 	return ret;
 }
 
@@ -1192,7 +1191,7 @@ struct dso *dso__new(const char *name)
 		dso->root = NULL;
 		INIT_LIST_HEAD(&dso->node);
 		INIT_LIST_HEAD(&dso->data.open_entry);
-		pthread_mutex_init(&dso->lock, NULL);
+		mutex_init(&dso->lock);
 		refcount_set(&dso->refcnt, 1);
 	}
 
@@ -1226,7 +1225,7 @@ void dso__delete(struct dso *dso)
 	dso__free_a2l(dso);
 	zfree(&dso->symsrc_filename);
 	nsinfo__zput(dso->nsinfo);
-	pthread_mutex_destroy(&dso->lock);
+	mutex_destroy(&dso->lock);
 	free(dso);
 }
 
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index e4dddb76770d..e08b2ab48314 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -11,6 +11,7 @@
 #include <stdio.h>
 #include <linux/bitops.h>
 #include "build-id.h"
+#include "mutex.h"
 
 struct machine;
 struct map;
@@ -132,7 +133,7 @@ struct dso_cache {
 struct auxtrace_cache;
 
 struct dso {
-	pthread_mutex_t	 lock;
+	struct mutex lock;
 	struct list_head node;
 	struct rb_node	 rb_node;	/* rbtree node sorted by long name */
 	struct rb_root	 *root;		/* root of rbtree that rb_node is in */
diff --git a/tools/perf/util/mutex.c b/tools/perf/util/mutex.c
new file mode 100644
index 000000000000..b7264a1438c4
--- /dev/null
+++ b/tools/perf/util/mutex.c
@@ -0,0 +1,32 @@
+#include <mutex.h>
+#include <pthread.h>
+
+//to avoid the warning : implicit declaration of BUG_ON,
+//we add the following 2 headers.
+#include <linux/compiler.h>
+#include <linux/kernel.h>
+
+void mutex_init(struct mutex *mtx)
+{
+pthread_mutexattr_t lock_attr;
+pthread_mutexattr_init(&lock_attr);
+pthread_mutexattr_settype(&lock_attr, PTHREAD_MUTEX_ERRORCHECK);
+BUG_ON(pthread_mutex_init(&mtx->lock, &lock_attr));
+//on success, returns 0.
+pthread_mutexattr_destroy(&lock_attr);
+}
+
+void mutex_destroy(struct mutex *mtx)
+{
+BUG_ON(pthread_mutex_destroy(&mtx->lock));     //on success, returns 0.
+}
+
+void mutex_lock(struct mutex *mtx)
+{
+BUG_ON(pthread_mutex_lock(&mtx->lock) != 0);
+}
+
+void mutex_unlock(struct mutex *mtx)
+{
+BUG_ON(pthread_mutex_unlock(&mtx->lock) != 0);
+}
diff --git a/tools/perf/util/mutex.h b/tools/perf/util/mutex.h
new file mode 100644
index 000000000000..ab2ebb98b24a
--- /dev/null
+++ b/tools/perf/util/mutex.h
@@ -0,0 +1,15 @@
+#ifndef __PERF_MUTEX_H
+#define _PERF_MUTEX_H
+
+#include <pthread.h>
+
+struct mutex {
+pthread_mutex_t lock;
+};
+
+void mutex_lock(struct mutex *mtx);
+void mutex_unlock(struct mutex *mtx);
+void mutex_init(struct mutex *mtx);
+void mutex_destroy(struct mutex *mtx);
+
+#endif /* _PERF_MUTEX_H */
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index a8f80e427674..342be12cfa1e 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1629,7 +1629,7 @@ int dso__load(struct dso *dso, struct map *map)
 	}
 
 	nsinfo__mountns_enter(dso->nsinfo, &nsc);
-	pthread_mutex_lock(&dso->lock);
+	mutex_lock(&dso->lock);
 
 	/* check again under the dso->lock */
 	if (dso__loaded(dso)) {
@@ -1778,7 +1778,7 @@ int dso__load(struct dso *dso, struct map *map)
 		ret = 0;
 out:
 	dso__set_loaded(dso);
-	pthread_mutex_unlock(&dso->lock);
+	mutex_unlock(&dso->lock);
 	nsinfo__mountns_exit(&nsc);
 
 	return ret;
-- 
2.25.1

