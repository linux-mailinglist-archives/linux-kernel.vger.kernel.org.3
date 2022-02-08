Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E0E4ADAD1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 15:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377899AbiBHOHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 09:07:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377838AbiBHOHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 09:07:37 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABEF9C03FED5;
        Tue,  8 Feb 2022 06:07:35 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id b35so13729960qkp.6;
        Tue, 08 Feb 2022 06:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7NOld3X9Ifjr+IPHR43nts/BXMdtDVpsAlMMQRyrsDY=;
        b=QcGYEKuqQGGZldI77/0tJtoWU8mlZUJzo8IjOV9MhrvRf1zJpdpOw6qIGelvBvQuLf
         jgKvTDBFFqVFp3mKdyX+VBfhEFl1BgyneS/BlXmQMCe0pZUfLt4uzG32pAnIxdA/MMAt
         JQ0aiaLhsnL2cOwyM7sWHJ8NEbxeM8WQSoNxah/unmKRAHCQGCV8AhjqlMMdlHnYxiyT
         5X+O/4wGgiGvyQBZEPUChqZJoHyzKmrWrt/sE6BHk6EEiOWp/ZB+4E9XCGOFJXGVJ9NK
         7W070dnmwolWS7hFdSNqBM/9UYfj1TQm9ddFRdO2KLibq2eWT2qcFlmpApaD3Ujq3nDq
         Xtlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7NOld3X9Ifjr+IPHR43nts/BXMdtDVpsAlMMQRyrsDY=;
        b=1fMFrpwY72b8copm6sg4Gngaf+2QT8sWOTEJJyw4JlwJ8QHbllRtt98LKja/b4VfVT
         EMCiVyta7HTxpgvNeukzhQ6VT4uTOcIL/GcMLPUbYS8d5JgypCMzabE9MkEhAIB78fy5
         qVf+EiGG4mLZhlzqXWk9voqE6sqdNwjOTDrj7ZUv0lesb/jJPRK/lYjms1ZfGU3s2G3q
         kP+ztnk5iqZ1nG8/CRzFZou+KV+iuV+3O5E+s6sbIO5FA0UFOaXDZDCZcvpIXuW7hQuN
         YyJU9Q6QdK9/aQFoUAg0YVeMM0adPbv9JetGQ6Oas20D39sxUqmeO9RfbwyK5hMhy2B2
         wvpQ==
X-Gm-Message-State: AOAM5305Le/wpFLCK56OnkjlZcUrllFpZvxOntui9PziESt2/B2BXSN6
        yvnEJLUvStqJ5F/NebxG27Q=
X-Google-Smtp-Source: ABdhPJw+6b/6xAHHkddYJemTBAsDlR7kfo/s9kNa3jYcZfwIFk7Uf541MbQctesR3DzZJqqvrg77+g==
X-Received: by 2002:a37:acd:: with SMTP id 196mr2606726qkk.89.1644329254403;
        Tue, 08 Feb 2022 06:07:34 -0800 (PST)
Received: from WRT-WX9.. ([207.246.89.135])
        by smtp.gmail.com with ESMTPSA id x18sm7688593qtw.93.2022.02.08.06.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 06:07:34 -0800 (PST)
From:   Changbin Du <changbin.du@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH] perf trace: Avoid early exit due SIGCHLD from non-workload processes
Date:   Tue,  8 Feb 2022 22:07:25 +0800
Message-Id: <20220208140725.3947-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.32.0
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

The function trace__symbols_init() runs "perf-read-vdso32" and that ends up
with a SIGCHLD delivered to 'perf'. And this SIGCHLD make perf exit early.

'perf trace' should exit only if the SIGCHLD is from our workload process.
So let's use sigaction() instead of signal() to match such condition.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 tools/perf/builtin-trace.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 32844d8a0ea5..d03556c14b0a 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1536,13 +1536,20 @@ static size_t trace__fprintf_tstamp(struct trace *trace, u64 tstamp, FILE *fp)
 	return fprintf(fp, "         ? ");
 }
 
+static pid_t workload_pid = -1;
 static bool done = false;
 static bool interrupted = false;
 
-static void sig_handler(int sig)
+static void sighandler_interrupt(int sig __maybe_unused)
 {
-	done = true;
-	interrupted = sig == SIGINT;
+	done = interrupted = true;
+}
+
+static void sighandler_chld(int sig __maybe_unused, siginfo_t *info,
+			    void *context __maybe_unused)
+{
+	if (info->si_pid == workload_pid)
+		done = true;
 }
 
 static size_t trace__fprintf_comm_tid(struct trace *trace, struct thread *thread, FILE *fp)
@@ -3938,7 +3945,6 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 	bool draining = false;
 
 	trace->live = true;
-	signal(SIGCHLD, sig_handler);
 
 	if (!trace->raw_augmented_syscalls) {
 		if (trace->trace_syscalls && trace__add_syscall_newtp(trace))
@@ -4018,6 +4024,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 			fprintf(trace->output, "Couldn't run the workload!\n");
 			goto out_delete_evlist;
 		}
+		workload_pid = evlist->workload.pid;
 	}
 
 	err = evlist__open(evlist);
@@ -4887,10 +4894,14 @@ int cmd_trace(int argc, const char **argv)
 	const char * const trace_subcommands[] = { "record", NULL };
 	int err = -1;
 	char bf[BUFSIZ];
+	struct sigaction sigchld_act = { 0 };
 
 	signal(SIGSEGV, sighandler_dump_stack);
 	signal(SIGFPE, sighandler_dump_stack);
-	signal(SIGINT, sig_handler);
+	signal(SIGINT, sighandler_interrupt);
+	sigchld_act.sa_flags = SA_SIGINFO;
+	sigchld_act.sa_sigaction = sighandler_chld;
+	sigaction(SIGCHLD, &sigchld_act, NULL);
 
 	trace.evlist = evlist__new();
 	trace.sctbl = syscalltbl__new();
-- 
2.25.1

