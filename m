Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF53B5910AC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 14:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238658AbiHLMQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 08:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238634AbiHLMQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 08:16:56 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B5D569F74B;
        Fri, 12 Aug 2022 05:16:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4DC08113E;
        Fri, 12 Aug 2022 05:16:55 -0700 (PDT)
Received: from e126387.arm.com (unknown [10.57.42.152])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 30C9C3F70D;
        Fri, 12 Aug 2022 05:16:53 -0700 (PDT)
From:   carsten.haitzler@foss.arm.com
To:     linux-kernel@vger.kernel.org
Cc:     coresight@lists.linaro.org, suzuki.poulose@arm.com,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Subject: [PATCH v7 01/14] perf test: Refactor shell tests allowing subdirs
Date:   Fri, 12 Aug 2022 13:16:28 +0100
Message-Id: <20220812121641.336465-2-carsten.haitzler@foss.arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220812121641.336465-1-carsten.haitzler@foss.arm.com>
References: <20220812121641.336465-1-carsten.haitzler@foss.arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Carsten Haitzler <carsten.haitzler@arm.com>

This is a prelude to adding more tests to shell tests and in order to
support putting those tests into subdirectories, I need to change the
test code that scans/finds and runs them.

To support subdirs I have to recurse so it's time to refactor the code to
allow this and centralize the shell script finding into one location and
only one single scan that builds a list of all the found tests in memory
instead of it being duplicated in 3 places.

This code also optimizes things like knowing the max width of desciption
strings (as we can do that while we scan instead of a whole new pass
of opening files). It also more cleanly filters scripts to see only
*.sh files thus skipping random other files in directories like *~
backup files, other random junk/data files that may appear and the
scripts must be executable to make the cut (this ensures the script
lib dir is not seen as scripts to run). This avoids perf test running
previous older versions of test scripts that are editor backup files
as well as skipping perf.data files that may appear and so on.

Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>
---
 tools/perf/tests/Build               |   1 +
 tools/perf/tests/builtin-test-list.c | 207 +++++++++++++++++++++++++++
 tools/perf/tests/builtin-test-list.h |  12 ++
 tools/perf/tests/builtin-test.c      | 152 +++-----------------
 4 files changed, 238 insertions(+), 134 deletions(-)
 create mode 100644 tools/perf/tests/builtin-test-list.c
 create mode 100644 tools/perf/tests/builtin-test-list.h

diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index af2b37ef7c70..2064a640facb 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 perf-y += builtin-test.o
+perf-y += builtin-test-list.o
 perf-y += parse-events.o
 perf-y += dso-data.o
 perf-y += attr.o
diff --git a/tools/perf/tests/builtin-test-list.c b/tools/perf/tests/builtin-test-list.c
new file mode 100644
index 000000000000..74f1dcce978f
--- /dev/null
+++ b/tools/perf/tests/builtin-test-list.c
@@ -0,0 +1,207 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <dirent.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <linux/ctype.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/zalloc.h>
+#include <string.h>
+#include <stdlib.h>
+#include <sys/types.h>
+#include <unistd.h>
+#include <subcmd/exec-cmd.h>
+#include <subcmd/parse-options.h>
+#include <sys/wait.h>
+#include <sys/stat.h>
+#include "builtin.h"
+#include "builtin-test-list.h"
+#include "color.h"
+#include "debug.h"
+#include "hist.h"
+#include "intlist.h"
+#include "string2.h"
+#include "symbol.h"
+#include "tests.h"
+#include "util/rlimit.h"
+
+
+/* 
+ * As this is a singleton built once for the run of the process, there is
+ * no value in trying to free it and just let it stay around until process
+ * exits when it's cleaned up.
+ */
+static size_t files_num = 0;
+static struct script_file *files = NULL;
+static int files_max_width = 0;
+
+static const char *shell_tests__dir(char *path, size_t size)
+{
+	const char *devel_dirs[] = { "./tools/perf/tests", "./tests", };
+	char *exec_path;
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(devel_dirs); ++i) {
+		struct stat st;
+
+		if (!lstat(devel_dirs[i], &st)) {
+			scnprintf(path, size, "%s/shell", devel_dirs[i]);
+			if (!lstat(devel_dirs[i], &st))
+				return path;
+		}
+	}
+
+	/* Then installed path. */
+	exec_path = get_argv_exec_path();
+	scnprintf(path, size, "%s/tests/shell", exec_path);
+	free(exec_path);
+	return path;
+}
+
+static const char *shell_test__description(char *description, size_t size,
+                                           const char *path, const char *name)
+{
+	FILE *fp;
+	char filename[PATH_MAX];
+	int ch;
+
+	path__join(filename, sizeof(filename), path, name);
+	fp = fopen(filename, "r");
+	if (!fp)
+		return NULL;
+
+	/* Skip first line - should be #!/bin/sh Shebang */
+	do {
+		ch = fgetc(fp);
+	} while (ch != EOF && ch != '\n');
+
+	description = fgets(description, size, fp);
+	fclose(fp);
+
+	/* Assume first char on line is omment everything after that desc */
+	return description ? strim(description + 1) : NULL;
+}
+
+/* Is this full file path a shell script */
+static bool is_shell_script(const char *path)
+{
+	const char *ext;
+
+	ext = strrchr(path, '.');
+	if (!ext)
+		return false;
+	if (!strcmp(ext, ".sh")) { /* Has .sh extension */
+		if (access(path, R_OK | X_OK) == 0) /* Is executable */
+			return true;
+	}
+	return false;
+}
+
+/* Is this file in this dir a shell script (for test purposes) */
+static bool is_test_script(const char *path, const char *name)
+{
+	char filename[PATH_MAX];
+
+	path__join(filename, sizeof(filename), path, name);
+	if (!is_shell_script(filename)) return false;
+	return true;
+}
+
+/* Duplicate a string and fall over and die if we run out of memory */
+static char *strdup_check(const char *str)
+{
+	char *newstr;
+
+	newstr = strdup(str);
+	if (!newstr) {
+		pr_err("Out of memory while duplicating test script string\n");
+		abort();
+	}
+	return newstr;
+}
+
+static void append_script(const char *dir, const char *file, const char *desc)
+{
+	struct script_file *files_tmp;
+	size_t files_num_tmp;
+	int width;
+
+	files_num_tmp = files_num + 1;
+	if (files_num_tmp >= SIZE_MAX) {
+		pr_err("Too many script files\n");
+		abort();
+	}
+	/* Realloc is good enough, though we could realloc by chunks, not that
+	 * anyone will ever measure performance here */
+	files_tmp = realloc(files,
+			    (files_num_tmp + 1) * sizeof(struct script_file));
+	if (files_tmp == NULL) {
+		pr_err("Out of memory while building test list\n");
+		abort();
+	}
+	/* Add file to end and NULL terminate the struct array */
+	files = files_tmp;
+	files_num = files_num_tmp;
+	files[files_num - 1].dir = strdup_check(dir);
+	files[files_num - 1].file = strdup_check(file);
+	files[files_num - 1].desc = strdup_check(desc);
+	files[files_num].dir = NULL;
+	files[files_num].file = NULL;
+	files[files_num].desc = NULL;
+
+	width = strlen(desc); /* Track max width of desc */
+	if (width > files_max_width)
+		files_max_width = width;
+}
+
+static void append_scripts_in_dir(const char *path)
+{
+	struct dirent **entlist;
+	struct dirent *ent;
+	int n_dirs, i;
+	char filename[PATH_MAX];
+
+	/* List files, sorted by alpha */
+	n_dirs = scandir(path, &entlist, NULL, alphasort);
+	if (n_dirs == -1)
+		return;
+	for (i = 0; i < n_dirs && (ent = entlist[i]); i++) {
+		if (ent->d_name[0] == '.')
+			continue; /* Skip hidden files */
+		if (is_test_script(path, ent->d_name)) { /* It's a test */
+			char bf[256];
+			const char *desc = shell_test__description
+				(bf, sizeof(bf), path, ent->d_name);
+
+			if (desc) /* It has a desc line - valid script */
+				append_script(path, ent->d_name, desc);
+		} else if (is_directory(path, ent)) { /* Scan the subdir */
+			path__join(filename, sizeof(filename),
+				   path, ent->d_name);
+			append_scripts_in_dir(filename);
+		}
+	}
+	for (i = 0; i < n_dirs; i++) /* Clean up */
+		zfree(&entlist[i]);
+	free(entlist);
+}
+
+const struct script_file *list_script_files(void)
+{
+	char path_dir[PATH_MAX];
+	const char *path;
+
+	if (files)
+		return files; /* Singleton - we already know our list */
+
+	path = shell_tests__dir(path_dir, sizeof(path_dir)); /* Walk  dir */
+	append_scripts_in_dir(path);
+
+	return files;
+}
+
+int list_script_max_width(void)
+{
+	list_script_files(); /* Ensure we have scanned all scripts */
+	return files_max_width;
+}
diff --git a/tools/perf/tests/builtin-test-list.h b/tools/perf/tests/builtin-test-list.h
new file mode 100644
index 000000000000..eb81f3aa6683
--- /dev/null
+++ b/tools/perf/tests/builtin-test-list.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+struct script_file {
+	char *dir;
+	char *file;
+	char *desc;
+};
+
+/* List available script tests to run - singleton - never freed */
+const struct script_file *list_script_files(void);
+/* Get maximum width of description string */
+int list_script_max_width(void);
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 81cf241cd109..7122eae1d98d 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -28,6 +28,8 @@
 #include <subcmd/exec-cmd.h>
 #include <linux/zalloc.h>
 
+#include "builtin-test-list.h"
+
 static bool dont_fork;
 
 struct test_suite *__weak arch_tests[] = {
@@ -274,91 +276,6 @@ static int test_and_print(struct test_suite *t, int subtest)
 	return err;
 }
 
-static const char *shell_test__description(char *description, size_t size,
-					   const char *path, const char *name)
-{
-	FILE *fp;
-	char filename[PATH_MAX];
-	int ch;
-
-	path__join(filename, sizeof(filename), path, name);
-	fp = fopen(filename, "r");
-	if (!fp)
-		return NULL;
-
-	/* Skip shebang */
-	do {
-		ch = fgetc(fp);
-	} while (ch != EOF && ch != '\n');
-
-	description = fgets(description, size, fp);
-	fclose(fp);
-
-	return description ? strim(description + 1) : NULL;
-}
-
-#define for_each_shell_test(entlist, nr, base, ent)	                \
-	for (int __i = 0; __i < nr && (ent = entlist[__i]); __i++)	\
-		if (!is_directory(base, ent) && \
-			is_executable_file(base, ent) && \
-			ent->d_name[0] != '.')
-
-static const char *shell_tests__dir(char *path, size_t size)
-{
-	const char *devel_dirs[] = { "./tools/perf/tests", "./tests", };
-        char *exec_path;
-	unsigned int i;
-
-	for (i = 0; i < ARRAY_SIZE(devel_dirs); ++i) {
-		struct stat st;
-		if (!lstat(devel_dirs[i], &st)) {
-			scnprintf(path, size, "%s/shell", devel_dirs[i]);
-			if (!lstat(devel_dirs[i], &st))
-				return path;
-		}
-	}
-
-        /* Then installed path. */
-        exec_path = get_argv_exec_path();
-        scnprintf(path, size, "%s/tests/shell", exec_path);
-	free(exec_path);
-	return path;
-}
-
-static int shell_tests__max_desc_width(void)
-{
-	struct dirent **entlist;
-	struct dirent *ent;
-	int n_dirs, e;
-	char path_dir[PATH_MAX];
-	const char *path = shell_tests__dir(path_dir, sizeof(path_dir));
-	int width = 0;
-
-	if (path == NULL)
-		return -1;
-
-	n_dirs = scandir(path, &entlist, NULL, alphasort);
-	if (n_dirs == -1)
-		return -1;
-
-	for_each_shell_test(entlist, n_dirs, path, ent) {
-		char bf[256];
-		const char *desc = shell_test__description(bf, sizeof(bf), path, ent->d_name);
-
-		if (desc) {
-			int len = strlen(desc);
-
-			if (width < len)
-				width = len;
-		}
-	}
-
-	for (e = 0; e < n_dirs; e++)
-		zfree(&entlist[e]);
-	free(entlist);
-	return width;
-}
-
 struct shell_test {
 	const char *dir;
 	const char *file;
@@ -385,33 +302,17 @@ static int shell_test__run(struct test_suite *test, int subdir __maybe_unused)
 static int run_shell_tests(int argc, const char *argv[], int i, int width,
 				struct intlist *skiplist)
 {
-	struct dirent **entlist;
-	struct dirent *ent;
-	int n_dirs, e;
-	char path_dir[PATH_MAX];
-	struct shell_test st = {
-		.dir = shell_tests__dir(path_dir, sizeof(path_dir)),
-	};
-
-	if (st.dir == NULL)
-		return -1;
+	struct shell_test st;
+	const struct script_file *files, *file;
 
-	n_dirs = scandir(st.dir, &entlist, NULL, alphasort);
-	if (n_dirs == -1) {
-		pr_err("failed to open shell test directory: %s\n",
-			st.dir);
-		return -1;
-	}
-
-	for_each_shell_test(entlist, n_dirs, st.dir, ent) {
+	files = list_script_files();
+	if (!files)
+		return 0;
+	for (file = files; file->dir; file++) {
 		int curr = i++;
-		char desc[256];
 		struct test_case test_cases[] = {
 			{
-				.desc = shell_test__description(desc,
-								sizeof(desc),
-								st.dir,
-								ent->d_name),
+				.desc = file->desc,
 				.run_case = shell_test__run,
 			},
 			{ .name = NULL, }
@@ -421,12 +322,13 @@ static int run_shell_tests(int argc, const char *argv[], int i, int width,
 			.test_cases = test_cases,
 			.priv = &st,
 		};
+		st.dir = file->dir;
 
 		if (test_suite.desc == NULL ||
 		    !perf_test__matches(test_suite.desc, curr, argc, argv))
 			continue;
 
-		st.file = ent->d_name;
+		st.file = file->file;
 		pr_info("%3d: %-*s:", i, width, test_suite.desc);
 
 		if (intlist__find(skiplist, i)) {
@@ -436,10 +338,6 @@ static int run_shell_tests(int argc, const char *argv[], int i, int width,
 
 		test_and_print(&test_suite, 0);
 	}
-
-	for (e = 0; e < n_dirs; e++)
-		zfree(&entlist[e]);
-	free(entlist);
 	return 0;
 }
 
@@ -448,7 +346,7 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
 	struct test_suite *t;
 	unsigned int j, k;
 	int i = 0;
-	int width = shell_tests__max_desc_width();
+	int width = list_script_max_width();
 
 	for_each_test(j, k, t) {
 		int len = strlen(test_description(t, -1));
@@ -529,36 +427,22 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
 
 static int perf_test__list_shell(int argc, const char **argv, int i)
 {
-	struct dirent **entlist;
-	struct dirent *ent;
-	int n_dirs, e;
-	char path_dir[PATH_MAX];
-	const char *path = shell_tests__dir(path_dir, sizeof(path_dir));
-
-	if (path == NULL)
-		return -1;
+	const struct script_file *files, *file;
 
-	n_dirs = scandir(path, &entlist, NULL, alphasort);
-	if (n_dirs == -1)
-		return -1;
-
-	for_each_shell_test(entlist, n_dirs, path, ent) {
+	files = list_script_files();
+	if (!files)
+		return 0;
+	for (file = files; file->dir; file++) {
 		int curr = i++;
-		char bf[256];
 		struct test_suite t = {
-			.desc = shell_test__description(bf, sizeof(bf), path, ent->d_name),
+			.desc = file->desc
 		};
 
 		if (!perf_test__matches(t.desc, curr, argc, argv))
 			continue;
 
 		pr_info("%3d: %s\n", i, t.desc);
-
 	}
-
-	for (e = 0; e < n_dirs; e++)
-		zfree(&entlist[e]);
-	free(entlist);
 	return 0;
 }
 
-- 
2.32.0

