Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33B41547F5C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 08:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236567AbiFMGH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 02:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233955AbiFMGHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 02:07:43 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A225B7EA
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 23:07:37 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id d129so4666495pgc.9
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 23:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8rpGhRZe7OD9xjNF1m78RIAAcrJRhCm5pjhxYsieoHk=;
        b=qw13uZoq36bEli8mqrcMyU1ZDU0GLPkhc5EIb2TvM28HQOU6+Bp6//pg/xE2tf2Zmu
         C1ws5OPgHK2sMrWJuPCbrXbWfCzu+093uOcErbsEsJh5Hf1fPUiJ6O6eBFicsy/a0gZq
         BIN9IQXO73EoAsMeLhkWGivLl8jbP0BhRpvY0hneq8o6DtauPwc7S56XXZ8rao7JOx7E
         G4iPiLb1Jl5ZJeKVZlJsLDtl4KBHCH5elDbssGxKS0tLn6GwhBRxwSjlyBR1D6ksc6j9
         A462hq6nvtEGRaas8A0ujrFFNUjRWqqv1YnTlBVqlaI0+nrj+d6VUDg2sOm8PeBViazt
         DtPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8rpGhRZe7OD9xjNF1m78RIAAcrJRhCm5pjhxYsieoHk=;
        b=VyTdXlj9/rAveWIjlN+Eyk1og3yzLIv6YpjACGjxCFjzOtdIYfY8HvG1Ca3z4nbJo0
         5URhBHs2fQ2+mFMM2wsrkwGbAT/5KQ0OozAuzo3TVgrN6tqPyaKNqv1av2DJ/UBiszHT
         6QYgy4yXKa+nZtJ7CW7Acq5pdvfGNy+XEYuXKMqsYWV+joZClRt7E4UO/klJ0sYg4ogk
         b5hPLJVxLirHO3EpcjCiZkIq2UWA6WyrKLKoqSZ2id+PC822kAvdHjwxySXU4RXqO4Zi
         Q5/tQqpn9G0tMCVT9ciQqWcBl5mJyiMtRhpMr/BSwCosvON/0N0nUouZsLTNG05A1OM8
         wgRQ==
X-Gm-Message-State: AOAM530zVjpNkqVhpreYOHMtq7f5wjyWVVOHwzepaQAjMrXjKd10g6xW
        arRnCsOboI4pw4NW8K84muW7iZ/1iOI=
X-Google-Smtp-Source: ABdhPJzURWDFcCmiEHOvEVLTggU4LjThqJO7Ns08nOOCFi+M9IUze1MifDyWiOid4te/GU4fksqIGw==
X-Received: by 2002:a05:6a00:a16:b0:518:ffe0:7229 with SMTP id p22-20020a056a000a1600b00518ffe07229mr93599801pfh.49.1655100456409;
        Sun, 12 Jun 2022 23:07:36 -0700 (PDT)
Received: from laptop.hsd1.wa.comcast.net ([2601:600:8500:5f14:d627:c51e:516e:a105])
        by smtp.gmail.com with ESMTPSA id p5-20020a170903248500b0015e8d4eb1c8sm420157plw.18.2022.06.12.23.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jun 2022 23:07:35 -0700 (PDT)
From:   Andrei Vagin <avagin@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Christian Brauner <brauner@kernel.org>
Cc:     Florian Weimer <fweimer@redhat.com>, linux-mm@kvack.org,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Andrei Vagin <avagin@gmail.com>
Subject: [PATCH 2/2] testing/timens: add a test for vfork+exit
Date:   Sun, 12 Jun 2022 23:07:23 -0700
Message-Id: <20220613060723.197407-2-avagin@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220613060723.197407-1-avagin@gmail.com>
References: <20220613060723.197407-1-avagin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* check that a child process is in parent's time namespace after vfork.
* check that a child process is in the target namespace after exec.

Output on success:
$ ./vfork_exec
1..1
ok 1 exec

Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
 tools/testing/selftests/timens/Makefile     |  2 +-
 tools/testing/selftests/timens/vfork_exec.c | 90 +++++++++++++++++++++
 2 files changed, 91 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/timens/vfork_exec.c

diff --git a/tools/testing/selftests/timens/Makefile b/tools/testing/selftests/timens/Makefile
index 3a5936cc10ab..f0d51d4d2c87 100644
--- a/tools/testing/selftests/timens/Makefile
+++ b/tools/testing/selftests/timens/Makefile
@@ -1,4 +1,4 @@
-TEST_GEN_PROGS := timens timerfd timer clock_nanosleep procfs exec futex
+TEST_GEN_PROGS := timens timerfd timer clock_nanosleep procfs exec futex vfork_exec
 TEST_GEN_PROGS_EXTENDED := gettime_perf
 
 CFLAGS := -Wall -Werror -pthread
diff --git a/tools/testing/selftests/timens/vfork_exec.c b/tools/testing/selftests/timens/vfork_exec.c
new file mode 100644
index 000000000000..e6ccd900f30a
--- /dev/null
+++ b/tools/testing/selftests/timens/vfork_exec.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <sched.h>
+#include <stdio.h>
+#include <stdbool.h>
+#include <sys/stat.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <time.h>
+#include <unistd.h>
+#include <string.h>
+
+#include "log.h"
+#include "timens.h"
+
+#define OFFSET (36000)
+
+int main(int argc, char *argv[])
+{
+	struct timespec now, tst;
+	int status, i;
+	pid_t pid;
+
+	if (argc > 1) {
+		if (sscanf(argv[1], "%ld", &now.tv_sec) != 1)
+			return pr_perror("sscanf");
+
+		for (i = 0; i < 2; i++) {
+			_gettime(CLOCK_MONOTONIC, &tst, i);
+			if (abs(tst.tv_sec - now.tv_sec) > 5)
+				return pr_fail("%ld %ld\n", now.tv_sec, tst.tv_sec);
+		}
+		return 0;
+	}
+
+	nscheck();
+
+	ksft_set_plan(1);
+
+	clock_gettime(CLOCK_MONOTONIC, &now);
+
+	if (unshare_timens())
+		return 1;
+
+	if (_settime(CLOCK_MONOTONIC, OFFSET))
+		return 1;
+
+	for (i = 0; i < 2; i++) {
+		_gettime(CLOCK_MONOTONIC, &tst, i);
+		if (abs(tst.tv_sec - now.tv_sec) > 5)
+			return pr_fail("%ld %ld\n",
+					now.tv_sec, tst.tv_sec);
+	}
+
+	pid = vfork();
+	if (pid < 0)
+		return pr_perror("fork");
+
+	if (pid == 0) {
+		char now_str[64];
+		char *cargv[] = {"exec", now_str, NULL};
+		char *cenv[] = {NULL};
+
+		// Check that we are still in the source timens.
+		for (i = 0; i < 2; i++) {
+			_gettime(CLOCK_MONOTONIC, &tst, i);
+			if (abs(tst.tv_sec - now.tv_sec) > 5)
+				return pr_fail("%ld %ld\n",
+						now.tv_sec, tst.tv_sec);
+		}
+
+		/* Check for proper vvar offsets after execve. */
+		snprintf(now_str, sizeof(now_str), "%ld", now.tv_sec + OFFSET);
+		execve("/proc/self/exe", cargv, cenv);
+		return pr_perror("execve");
+	}
+
+	if (waitpid(pid, &status, 0) != pid)
+		return pr_perror("waitpid");
+
+	if (status)
+		ksft_exit_fail();
+
+	ksft_test_result_pass("exec\n");
+	ksft_exit_pass();
+	return 0;
+}
-- 
2.35.1

