Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE83E46F6A3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 23:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233506AbhLIWTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 17:19:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233502AbhLIWTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 17:19:44 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69FECC061A72
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 14:16:10 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id h5-20020a255f45000000b005ffd939127bso12869445ybm.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 14:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7s8lEM7vxE9oaPCZlcOUwoJ7eBiwu3eQIZufuhM0E/I=;
        b=ksiw6rsrwZIql9RdnW0zggcto4PhW/OFyE3GwNIVspYOeSFVcU4OkzOgvF2gkZxccX
         bAnBjk2/2N5TBjb6PPhpPTI5e3DYoUJD5tZwq0N5PSC/VkLZazfhOdl6845mojjGoYbF
         Buzlq6livqIu8JOBvfszFn7XyWPq/2p4YBpY951LGKJItM1FxAOT1mmHT1j27pWh888j
         dld8HWIzS5VL+QI7m+LZ0U0gM8P7ddbKo4Pvn11v8jO49iN2xZKt8n8dIF/5j87eios1
         QnYYtIRfkgsBGqFgPTs8F95xXML5xU2T5M8ABRFTtl9jAyzWCGpszQkfWUK+FFOLIxSC
         MMcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7s8lEM7vxE9oaPCZlcOUwoJ7eBiwu3eQIZufuhM0E/I=;
        b=KYLgLSHaD8kAXWoZdsCRyA+eDSGIHWAQaBFciRRIPEKPGlBLv3ibfhiALfDvhRTw15
         RsntcYGBqhV70VIuldlMaKu9ABnaCC4iquvwSTsWle3AtQe05S0Z0Z/HeIld157pkqTq
         Ut+4AaU6zfvCZKUlRXKh9DJlKFOMSubgo/C63APMRXpVZ0d2wzgR9t2PGk0NHoJtnunY
         SyFYydY8b9Iw0eyWJc03BMbTYd8KdXAhgXzIRj+SQ5k+gTSFyWapxP1LxX1JX6s3cwB7
         VlRtGwiVySh7+/3BF6DHL3YZWhzPzjXsjBXsi7fQmxT2ptjvib3dLYfwz0CDduX8RnoR
         X99A==
X-Gm-Message-State: AOAM531S/AuvrcciXgFD4m4AjoYeyHDxKQfvHFmaBnpH3Whl0q8ORnNn
        sDc1/Hyrb1WnJRh1lpvNj37bPUM=
X-Google-Smtp-Source: ABdhPJx6SHlSTXft/4uwAkd2t2Qz2vUlOSahwEB+bAnZk0choINS/4CYmxqXe6LtfY7i28pAboGp1Qc=
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:200:f233:e324:8aa0:f65c])
 (user=pcc job=sendgmr) by 2002:a05:6902:1107:: with SMTP id
 o7mr9802261ybu.120.1639088169471; Thu, 09 Dec 2021 14:16:09 -0800 (PST)
Date:   Thu,  9 Dec 2021 14:15:44 -0800
In-Reply-To: <20211209221545.2333249-1-pcc@google.com>
Message-Id: <20211209221545.2333249-8-pcc@google.com>
Mime-Version: 1.0
References: <20211209221545.2333249-1-pcc@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v4 7/7] selftests: test uaccess logging
From:   Peter Collingbourne <pcc@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Mark Rutland <mark.rutland@arm.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Peter Collingbourne <pcc@google.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        David Hildenbrand <david@redhat.com>,
        Xiaofeng Cao <caoxiaofeng@yulong.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Thomas Cedeno <thomascedeno@google.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Evgenii Stepanov <eugenis@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a kselftest for the uaccess logging feature.

Link: https://linux-review.googlesource.com/id/I39e1707fb8aef53747c42bd55b46ecaa67205199
Signed-off-by: Peter Collingbourne <pcc@google.com>
---
 tools/testing/selftests/Makefile              |   1 +
 .../testing/selftests/uaccess_buffer/Makefile |   4 +
 .../uaccess_buffer/uaccess_buffer_test.c      | 126 ++++++++++++++++++
 3 files changed, 131 insertions(+)
 create mode 100644 tools/testing/selftests/uaccess_buffer/Makefile
 create mode 100644 tools/testing/selftests/uaccess_buffer/uaccess_buffer_test.c

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index c852eb40c4f7..291b62430557 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -71,6 +71,7 @@ TARGETS += timers
 endif
 TARGETS += tmpfs
 TARGETS += tpm2
+TARGETS += uaccess_buffer
 TARGETS += user
 TARGETS += vDSO
 TARGETS += vm
diff --git a/tools/testing/selftests/uaccess_buffer/Makefile b/tools/testing/selftests/uaccess_buffer/Makefile
new file mode 100644
index 000000000000..e6e5fb43ce29
--- /dev/null
+++ b/tools/testing/selftests/uaccess_buffer/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+TEST_GEN_PROGS := uaccess_buffer_test
+
+include ../lib.mk
diff --git a/tools/testing/selftests/uaccess_buffer/uaccess_buffer_test.c b/tools/testing/selftests/uaccess_buffer/uaccess_buffer_test.c
new file mode 100644
index 000000000000..051062e4fbf9
--- /dev/null
+++ b/tools/testing/selftests/uaccess_buffer/uaccess_buffer_test.c
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "../kselftest_harness.h"
+
+#include <linux/uaccess-buffer.h>
+#include <sys/prctl.h>
+#include <sys/utsname.h>
+
+FIXTURE(uaccess_buffer)
+{
+	uint64_t addr;
+};
+
+FIXTURE_SETUP(uaccess_buffer)
+{
+	ASSERT_EQ(0, prctl(PR_SET_UACCESS_DESCRIPTOR_ADDR_ADDR, &self->addr, 0,
+			   0, 0));
+}
+
+FIXTURE_TEARDOWN(uaccess_buffer)
+{
+	ASSERT_EQ(0, prctl(PR_SET_UACCESS_DESCRIPTOR_ADDR_ADDR, 0, 0, 0, 0));
+}
+
+TEST_F(uaccess_buffer, uname)
+{
+	struct uaccess_descriptor desc;
+	struct uaccess_buffer_entry entries[64];
+	struct utsname un;
+
+	desc.addr = (uint64_t)(unsigned long)entries;
+	desc.size = 64;
+	self->addr = (uint64_t)(unsigned long)&desc;
+	ASSERT_EQ(0, uname(&un));
+	ASSERT_EQ(0, self->addr);
+
+	if (desc.size == 63) {
+		ASSERT_EQ((uint64_t)(unsigned long)(entries + 1), desc.addr);
+
+		ASSERT_EQ((uint64_t)(unsigned long)&un, entries[0].addr);
+		ASSERT_EQ(sizeof(struct utsname), entries[0].size);
+		ASSERT_EQ(UACCESS_BUFFER_FLAG_WRITE, entries[0].flags);
+	} else {
+		/* See override_architecture in kernel/sys.c */
+		ASSERT_EQ(62, desc.size);
+		ASSERT_EQ((uint64_t)(unsigned long)(entries + 2), desc.addr);
+
+		ASSERT_EQ((uint64_t)(unsigned long)&un, entries[0].addr);
+		ASSERT_EQ(sizeof(struct utsname), entries[0].size);
+		ASSERT_EQ(UACCESS_BUFFER_FLAG_WRITE, entries[0].flags);
+
+		ASSERT_EQ((uint64_t)(unsigned long)&un.machine,
+			  entries[1].addr);
+		ASSERT_EQ(UACCESS_BUFFER_FLAG_WRITE, entries[1].flags);
+	}
+}
+
+static bool handled;
+
+static void usr1_handler(int signo)
+{
+	handled = true;
+}
+
+TEST_F(uaccess_buffer, blocked_signals)
+{
+	struct uaccess_descriptor desc;
+	struct shared_buf {
+		bool ready;
+		bool killed;
+	} volatile *shared = mmap(NULL, getpagesize(), PROT_READ | PROT_WRITE,
+				  MAP_ANON | MAP_SHARED, -1, 0);
+	struct sigaction act = {}, oldact;
+	int pid;
+
+	handled = false;
+	act.sa_handler = usr1_handler;
+	sigaction(SIGUSR1, &act, &oldact);
+
+	pid = fork();
+	if (pid == 0) {
+		/*
+		 * Busy loop to synchronize instead of issuing syscalls because
+		 * we need to test the behavior in the case where no syscall is
+		 * issued by the parent process.
+		 */
+		while (!shared->ready)
+			;
+		kill(getppid(), SIGUSR1);
+		shared->killed = true;
+		_exit(0);
+	} else {
+		int i;
+
+		desc.addr = 0;
+		desc.size = 0;
+		self->addr = (uint64_t)(unsigned long)&desc;
+
+		shared->ready = true;
+		while (!shared->killed)
+			;
+
+		/*
+		 * The kernel should have IPI'd us by now, but let's wait a bit
+		 * longer just in case.
+		 */
+		for (i = 0; i != 1000000; ++i)
+			;
+
+		ASSERT_FALSE(handled);
+
+		/*
+		 * Returning from the waitpid syscall should trigger the signal
+		 * handler. The signal itself may also interrupt waitpid, so
+		 * make sure to handle EINTR.
+		 */
+		while (waitpid(pid, NULL, 0) == -1)
+			ASSERT_EQ(EINTR, errno);
+		ASSERT_TRUE(handled);
+	}
+
+	munmap((void *)shared, getpagesize());
+	sigaction(SIGUSR1, &oldact, NULL);
+}
+
+TEST_HARNESS_MAIN
-- 
2.34.1.173.g76aa8bc2d0-goog

