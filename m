Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26A7E475CA8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 17:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244404AbhLOQES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 11:04:18 -0500
Received: from foss.arm.com ([217.140.110.172]:55958 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234539AbhLOQER (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 11:04:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49CAA1474;
        Wed, 15 Dec 2021 08:04:17 -0800 (PST)
Received: from e126387.extremechicken.org (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 283BA3F5A1;
        Wed, 15 Dec 2021 08:04:16 -0800 (PST)
From:   carsten.haitzler@foss.arm.com
To:     linux-kernel@vger.kernel.org
Cc:     coresight@lists.linaro.org, suzuki.poulose@arm.com,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org, inux-perf-users@vger.kernel.org,
        acme@kernel.org
Subject: [PATCH 02/12] perf test: Shell - only run .sh shell files to skip other files
Date:   Wed, 15 Dec 2021 16:03:53 +0000
Message-Id: <20211215160403.69264-2-carsten.haitzler@foss.arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211215160403.69264-1-carsten.haitzler@foss.arm.com>
References: <20211215160403.69264-1-carsten.haitzler@foss.arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 tools/perf/tests/builtin-test.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index ece272b55587..849737ead9fd 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -297,7 +297,20 @@ static const char *shell_test__description(char *description, size_t size,
 	for (int __i = 0; __i < nr && (ent = entlist[__i]); __i++)	\
 		if (!is_directory(base, ent) && \
 			is_executable_file(base, ent) && \
-			ent->d_name[0] != '.')
+			ent->d_name[0] != '.' && \
+			(shell_file_is_sh(ent->d_name) == 0))
+
+static int shell_file_is_sh(const char *file)
+{
+	const char *ext;
+
+	ext = strchr(file, '.');
+	if (!ext)
+		return -1;
+	if (!strcmp(ext, ".sh"))
+		return 0;
+	return -1;
+}
 
 static const char *shell_tests__dir(char *path, size_t size)
 {
-- 
2.32.0

