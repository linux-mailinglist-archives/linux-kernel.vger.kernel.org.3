Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE82592D3B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242160AbiHOJuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 05:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233370AbiHOJuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 05:50:10 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643EB1CFE8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 02:50:09 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id b4so5350107wrn.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 02:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc;
        bh=MZ/bMdpJFFVNYzaH36dygwZuysvMHm8hU/UdQPnTP2g=;
        b=YgF165+JAha0f8kxCHLlygurT35yLqqvU603/kEL/cmQP+t4YBg4cn2e4pIk1Y6J/b
         xoZorGDIX43Rc5BHTOwippdjqpsTP5y7ScRiSGcDSEGnySahpKIEAHZQ5EsjfAOWZM2V
         fDj4ouhnxbPwOj23BjEcJJ1wj/EUKlxFCLa26NNYMQJ+xlws3jS5qjPDOYiOD1GQSN6E
         xf3MQ8tRr7j3L03VTU2CY60wNWSbtITlyZ7aeBRYIzJTRFIWNOkRAe8juvdCPBSd57Ni
         V9GU0XtIXAIY2fuYacW2A/3ugNbUiDyx3doJSH9uKYVIF0X2Iq6ZGnUQzHcap9HlL+vg
         X60w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=MZ/bMdpJFFVNYzaH36dygwZuysvMHm8hU/UdQPnTP2g=;
        b=Y/La4w58aBrcMdrueK+1raZQOkzyuYw8dwbGHvooJ9NKPyDRpesENJQImNtfYqE42v
         ORVEslvNBmQQ62GWLcsaoMCMT1wjiQxBXvAgkW1Yod+PSitDDCSNmJuBwcazO81D/19e
         I7mzgGFqqKBV0XZEH2jFvx+t3WWOQIIQskwhV9okeaVN2A1LK6TqdGgumjCRvyYYEIKd
         9B0p2U11JoAWlQgKyvIxAK82xYiuTZyWrNaahngvGfSZuqys+8yAj1tM6ZUirudG7W8h
         QW/w9g1+ATQVnzGQMbZDQR6SadwWA2E6t/SU0maEZfUdMI1a4e3G08wz8UK+qi9TbgYb
         dIBA==
X-Gm-Message-State: ACgBeo1Azy8hztGurX0cwkbrdvuaD/w6ATWLwqPFP/an5NGFkdJMNhsm
        WYADejxxw81vSNIZMT99G9QWQ65lyw==
X-Google-Smtp-Source: AA6agR4lwtCalLncOXmrbi2drmlsMUXpc3i49VHYmjl0Quw8pzrX6yb9XqJ6oPacm8SG0UVpuumA3w==
X-Received: by 2002:a5d:6411:0:b0:220:4df4:2065 with SMTP id z17-20020a5d6411000000b002204df42065mr8730499wru.292.1660557007783;
        Mon, 15 Aug 2022 02:50:07 -0700 (PDT)
Received: from localhost.localdomain ([46.53.253.85])
        by smtp.gmail.com with ESMTPSA id w10-20020a5d680a000000b0021e5bec14basm6976108wru.5.2022.08.15.02.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 02:50:07 -0700 (PDT)
Date:   Mon, 15 Aug 2022 12:50:04 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, bfoster@redhat.com
Subject: [PATCH] proc: save LOC in vsyscall test
Message-ID: <YvoWzAn5dlhF75xa@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brian Foster <bfoster@redhat.com>

Do one fork in vsyscall detection code and let SIGSEGV handler exit and
carry information to the parent saving LOC.

	[
		redo original patch,
		delete unnecessary variables,
		minimise code changes.
					--adobriyan
	]

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 tools/testing/selftests/proc/proc-pid-vm.c |   56 ++++++++---------------------
 1 file changed, 16 insertions(+), 40 deletions(-)

--- a/tools/testing/selftests/proc/proc-pid-vm.c
+++ b/tools/testing/selftests/proc/proc-pid-vm.c
@@ -213,22 +213,22 @@ static int make_exe(const uint8_t *payload, size_t len)
 
 /*
  * 0: vsyscall VMA doesn't exist	vsyscall=none
- * 1: vsyscall VMA is r-xp		vsyscall=emulate
- * 2: vsyscall VMA is --xp		vsyscall=xonly
+ * 1: vsyscall VMA is --xp		vsyscall=xonly
+ * 2: vsyscall VMA is r-xp		vsyscall=emulate
  */
-static int g_vsyscall;
+static volatile int g_vsyscall;
 static const char *str_vsyscall;
 
 static const char str_vsyscall_0[] = "";
 static const char str_vsyscall_1[] =
-"ffffffffff600000-ffffffffff601000 r-xp 00000000 00:00 0                  [vsyscall]\n";
-static const char str_vsyscall_2[] =
 "ffffffffff600000-ffffffffff601000 --xp 00000000 00:00 0                  [vsyscall]\n";
+static const char str_vsyscall_2[] =
+"ffffffffff600000-ffffffffff601000 r-xp 00000000 00:00 0                  [vsyscall]\n";
 
 #ifdef __x86_64__
 static void sigaction_SIGSEGV(int _, siginfo_t *__, void *___)
 {
-	_exit(1);
+	_exit(g_vsyscall);
 }
 
 /*
@@ -255,6 +255,7 @@ static void vsyscall(void)
 		act.sa_sigaction = sigaction_SIGSEGV;
 		(void)sigaction(SIGSEGV, &act, NULL);
 
+		g_vsyscall = 0;
 		/* gettimeofday(NULL, NULL); */
 		asm volatile (
 			"call %P0"
@@ -262,45 +263,20 @@ static void vsyscall(void)
 			: "i" (0xffffffffff600000), "D" (NULL), "S" (NULL)
 			: "rax", "rcx", "r11"
 		);
-		exit(0);
-	}
-	waitpid(pid, &wstatus, 0);
-	if (WIFEXITED(wstatus) && WEXITSTATUS(wstatus) == 0) {
-		/* vsyscall page exists and is executable. */
-	} else {
-		/* vsyscall page doesn't exist. */
-		g_vsyscall = 0;
-		return;
-	}
-
-	pid = fork();
-	if (pid < 0) {
-		fprintf(stderr, "fork, errno %d\n", errno);
-		exit(1);
-	}
-	if (pid == 0) {
-		struct rlimit rlim = {0, 0};
-		(void)setrlimit(RLIMIT_CORE, &rlim);
-
-		/* Hide "segfault at ffffffffff600000" messages. */
-		struct sigaction act;
-		memset(&act, 0, sizeof(struct sigaction));
-		act.sa_flags = SA_SIGINFO;
-		act.sa_sigaction = sigaction_SIGSEGV;
-		(void)sigaction(SIGSEGV, &act, NULL);
 
+		g_vsyscall = 1;
 		*(volatile int *)0xffffffffff600000UL;
-		exit(0);
+
+		g_vsyscall = 2;
+		exit(g_vsyscall);
 	}
 	waitpid(pid, &wstatus, 0);
-	if (WIFEXITED(wstatus) && WEXITSTATUS(wstatus) == 0) {
-		/* vsyscall page is readable and executable. */
-		g_vsyscall = 1;
-		return;
+	if (WIFEXITED(wstatus)) {
+		g_vsyscall = WEXITSTATUS(wstatus);
+	} else {
+		fprintf(stderr, "error: wstatus %08x\n", wstatus);
+		exit(1);
 	}
-
-	/* vsyscall page is executable but unreadable. */
-	g_vsyscall = 2;
 }
 
 int main(void)
