Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91AE94D2F11
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 13:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbiCIMcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 07:32:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232757AbiCIMcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 07:32:03 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2F60917587B;
        Wed,  9 Mar 2022 04:31:04 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1507168F;
        Wed,  9 Mar 2022 04:31:03 -0800 (PST)
Received: from e126387.arm.com (unknown [10.57.39.232])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C03C43FA4D;
        Wed,  9 Mar 2022 04:31:02 -0800 (PST)
From:   carsten.haitzler@foss.arm.com
To:     linux-kernel@vger.kernel.org
Cc:     coresight@lists.linaro.org, suzuki.poulose@arm.com,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Subject: [PATCH 1/3] perf test: Shell - Limit to only run executable scripts in tests
Date:   Wed,  9 Mar 2022 12:28:57 +0000
Message-Id: <20220309122859.31487-1-carsten.haitzler@foss.arm.com>
X-Mailer: git-send-email 2.25.1
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

Perf test's shell runner will just run everything in the tests
directory (as long as it's not another directory or does not begin
with a dot), but sometimes you find files in there that are not shell
scripts - perf.data output for example if you do some testing and then
the next time you run perf test it tries to run these. Check the files
are executable so they are actually intended to be test scripts and
not just some "random junk" files there.

Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>
---
 tools/perf/tests/builtin-test.c |  4 +++-
 tools/perf/util/path.c          | 14 +++++++++++++-
 tools/perf/util/path.h          |  1 +
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index fac3717d9ba1..3c34cb766724 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -296,7 +296,9 @@ static const char *shell_test__description(char *description, size_t size,
 
 #define for_each_shell_test(entlist, nr, base, ent)	                \
 	for (int __i = 0; __i < nr && (ent = entlist[__i]); __i++)	\
-		if (!is_directory(base, ent) && ent->d_name[0] != '.')
+		if (!is_directory(base, ent) && \
+			is_executable_file(base, ent) && \
+			ent->d_name[0] != '.')
 
 static const char *shell_tests__dir(char *path, size_t size)
 {
diff --git a/tools/perf/util/path.c b/tools/perf/util/path.c
index caed0336429f..ce80b79be103 100644
--- a/tools/perf/util/path.c
+++ b/tools/perf/util/path.c
@@ -86,9 +86,21 @@ bool is_directory(const char *base_path, const struct dirent *dent)
 	char path[PATH_MAX];
 	struct stat st;
 
-	sprintf(path, "%s/%s", base_path, dent->d_name);
+	snprintf(path, sizeof(path), "%s/%s", base_path, dent->d_name);
 	if (stat(path, &st))
 		return false;
 
 	return S_ISDIR(st.st_mode);
 }
+
+bool is_executable_file(const char *base_path, const struct dirent *dent)
+{
+	char path[PATH_MAX];
+	struct stat st;
+
+	snprintf(path, sizeof(path), "%s/%s", base_path, dent->d_name);
+	if (stat(path, &st))
+		return false;
+
+	return !S_ISDIR(st.st_mode) && (st.st_mode & S_IXUSR);
+}
diff --git a/tools/perf/util/path.h b/tools/perf/util/path.h
index 083429b7efa3..d94902c22222 100644
--- a/tools/perf/util/path.h
+++ b/tools/perf/util/path.h
@@ -12,5 +12,6 @@ int path__join3(char *bf, size_t size, const char *path1, const char *path2, con
 
 bool is_regular_file(const char *file);
 bool is_directory(const char *base_path, const struct dirent *dent);
+bool is_executable_file(const char *base_path, const struct dirent *dent);
 
 #endif /* _PERF_PATH_H */
-- 
2.32.0

