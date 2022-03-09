Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526D34D2F16
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 13:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbiCIMcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 07:32:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232757AbiCIMcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 07:32:17 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9F0D51768E3;
        Wed,  9 Mar 2022 04:31:16 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 63BB91688;
        Wed,  9 Mar 2022 04:31:16 -0800 (PST)
Received: from e126387.arm.com (unknown [10.57.39.232])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 34BFA3FA4D;
        Wed,  9 Mar 2022 04:31:15 -0800 (PST)
From:   carsten.haitzler@foss.arm.com
To:     linux-kernel@vger.kernel.org
Cc:     coresight@lists.linaro.org, suzuki.poulose@arm.com,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Subject: [PATCH 2/3] perf test: Shell - only run .sh shell files to skip other files
Date:   Wed,  9 Mar 2022 12:28:58 +0000
Message-Id: <20220309122859.31487-2-carsten.haitzler@foss.arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220309122859.31487-1-carsten.haitzler@foss.arm.com>
References: <20220309122859.31487-1-carsten.haitzler@foss.arm.com>
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

You edit your scripts in the tests and end up with your usual shell
backup files with ~ or .bak or something else at the end, but then your
next perf test run wants to run the backups too. You might also have perf
.data files in the directory or something else undesireable as well. You end
up chasing which test is the one you edited and the backup and have to keep
removing all the backup files, so automatically skip any files that are
not plain *.sh scripts to limit the time wasted in chasing ghosts.

Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>
---
 tools/perf/tests/builtin-test.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 3c34cb766724..3a02ba7a7a89 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -296,9 +296,22 @@ static const char *shell_test__description(char *description, size_t size,
 
 #define for_each_shell_test(entlist, nr, base, ent)	                \
 	for (int __i = 0; __i < nr && (ent = entlist[__i]); __i++)	\
-		if (!is_directory(base, ent) && \
+		if (ent->d_name[0] != '.' && \
+			!is_directory(base, ent) && \
 			is_executable_file(base, ent) && \
-			ent->d_name[0] != '.')
+			is_shell_script(ent->d_name))
+
+static bool is_shell_script(const char *file)
+{
+	const char *ext;
+
+	ext = strrchr(file, '.');
+	if (!ext)
+		return false;
+	if (!strcmp(ext, ".sh"))
+		return true;
+	return false;
+}
 
 static const char *shell_tests__dir(char *path, size_t size)
 {
-- 
2.32.0

