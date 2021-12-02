Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E780646683B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 17:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237563AbhLBQb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 11:31:29 -0500
Received: from foss.arm.com ([217.140.110.172]:37486 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1359591AbhLBQan (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 11:30:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 57689150C;
        Thu,  2 Dec 2021 08:27:20 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 858893F73B;
        Thu,  2 Dec 2021 08:27:19 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     cyphar@cyphar.com, shuah@kernel.org,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH 3/3] selftests: openat2: Skip testcases that fail with EOPNOTSUPP
Date:   Thu,  2 Dec 2021 16:26:54 +0000
Message-Id: <20211202162654.29704-3-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211202162654.29704-1-cristian.marussi@arm.com>
References: <20211202162654.29704-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Skip testcases that fail since the requested valid flags combination is not
supported by the underlying filesystem.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 tools/testing/selftests/openat2/openat2_test.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/openat2/openat2_test.c b/tools/testing/selftests/openat2/openat2_test.c
index 1bddbe934204..7fb902099de4 100644
--- a/tools/testing/selftests/openat2/openat2_test.c
+++ b/tools/testing/selftests/openat2/openat2_test.c
@@ -259,6 +259,16 @@ void test_openat2_flags(void)
 		unlink(path);
 
 		fd = sys_openat2(AT_FDCWD, path, &test->how);
+		if (fd < 0 && fd == -EOPNOTSUPP) {
+			/*
+			 * Skip the testcase if it failed because not supported
+			 * by FS. (e.g. a valid O_TMPFILE combination on NFS)
+			 */
+			ksft_test_result_skip("openat2 with %s fails with %d (%s)\n",
+					      test->name, fd, strerror(-fd));
+			goto next;
+		}
+
 		if (test->err >= 0)
 			failed = (fd < 0);
 		else
@@ -303,7 +313,7 @@ void test_openat2_flags(void)
 		else
 			resultfn("openat2 with %s fails with %d (%s)\n",
 				 test->name, test->err, strerror(-test->err));
-
+next:
 		free(fdpath);
 		fflush(stdout);
 	}
-- 
2.17.1

