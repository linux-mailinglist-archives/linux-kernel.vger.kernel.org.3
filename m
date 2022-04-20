Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93CA6508CB1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 18:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355374AbiDTQDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 12:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351205AbiDTQDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 12:03:18 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE647648
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 09:00:31 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id 12so2144393pll.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 09:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T2e4gNzW9WvbaYYhRQN8RA/sJzl40ME+FaDXHpo4ThY=;
        b=TRx6k6nQBr/yZAp6R3CZ9o6VwyHajsNXSIktFiSElT+CKFQKR8a4aqIWqZKKeq4E/L
         PLh6brBiSPL4DXEUy4POTH9XEhqGqEtHSrVeKMH9m7rwg0b1KQ1wlhfi4k3OfTBJXCdm
         Ky9s3OR+3DHDNM3GnnciwZw4XF3kqZFWShliy/tmiSZ2aYisFxlTqGbV+HQnv5xu9Qun
         AxEOHCqSQWKBH21vAqWA2Z9kbzeyQZQje9iLUaCjfVTUHQiE05eBGm3apJ7FEwxj5UaX
         wO4Ec6HFu+QdTlrHA9nYTfXlfNyC7JPK2JrSmTDfMasSLrLfpbaSKzbITrMMrGlP9TRA
         p2gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T2e4gNzW9WvbaYYhRQN8RA/sJzl40ME+FaDXHpo4ThY=;
        b=c3czSx2531S5jcsMHOqAA2CyyezNIipOe5orcqoNf49GZkbc4silTEO6lr3FLT+PCc
         Kp/HFsZ2HiT6WAPTCUrnovb+Be+8LDmOOl6ueIiKLxroCwS7nQAZ/didR6sK11YEXjQi
         ne8p0dWzdV1uaVxJ6q4MaPejB9MdMMMg3WcAho5gox+nTq8G5Lh6LTfpyR7lHzrrAQ8s
         UyjTRXSKwcYCLlfFnAoiL4aop8MQJXynqIojj2Yix/WAGL6h/Fr0PpYTtxHTZHsPfh8D
         9EshKC83FXpJ0z3JyGzH14cppFSuiYayw+cjCFH5hiU4Ype3F8u+oEsGOQf8nz1ezAw5
         6qPw==
X-Gm-Message-State: AOAM531pU4LBwivWzOPi6aPnHoIS8EHkHalUIUY29Cfi9z74vxFPNKxj
        FdGNBqLrW5FV02qHZUbxIVck3NQyHnTqvA==
X-Google-Smtp-Source: ABdhPJwtFoPpijOIMdaju6Yi0fGgtpz+tkg/dgMTSfHbX0Bgl4+8n48gKLhDpJGbHjbufO+Jd/r+Iw==
X-Received: by 2002:a17:902:f143:b0:158:f8f3:73ca with SMTP id d3-20020a170902f14300b00158f8f373camr16108854plb.123.1650470431338;
        Wed, 20 Apr 2022 09:00:31 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a28:e66:6380:7568:1633:647:d3a2])
        by smtp.gmail.com with ESMTPSA id h18-20020a63c012000000b0039cc3c323f7sm20198676pgg.33.2022.04.20.09.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 09:00:30 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     rostedt@goodmis.org, mark.rutland@arm.com, mingo@redhat.com,
        catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        dave.hansen@linux.intel.com, broonie@kernel.org, ardb@kernel.org
Cc:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        songmuchun@bytedance.com, zhengqi.arch@bytedance.com,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v5 1/2] ftrace: cleanup ftrace_graph_caller enable and disable
Date:   Thu, 21 Apr 2022 00:00:05 +0800
Message-Id: <20220420160006.17880-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ftrace_[enable,disable]_ftrace_graph_caller() are used to do
special hooks for graph tracer, which are not needed on some ARCHs
that use graph_ops:func function to install return_hooker.

So introduce the weak version in ftrace core code to cleanup
in x86.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
v4:
 - put weak ftrace_enable,disable_ftrace_graph_caller() in
   fgraph.c instead of ftrace.c as suggested by Steve.

v3:
 - consolidate two #if into a single #if, suggested by Steve. Thanks.
---
 arch/x86/kernel/ftrace.c | 17 ++---------------
 kernel/trace/fgraph.c    | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 1e31c7d21597..b09d73c2ba89 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -579,9 +579,7 @@ void arch_ftrace_trampoline_free(struct ftrace_ops *ops)
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 
-#ifdef CONFIG_DYNAMIC_FTRACE
-
-#ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
+#if defined(CONFIG_DYNAMIC_FTRACE) && !defined(CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS)
 extern void ftrace_graph_call(void);
 static const char *ftrace_jmp_replace(unsigned long ip, unsigned long addr)
 {
@@ -610,18 +608,7 @@ int ftrace_disable_ftrace_graph_caller(void)
 
 	return ftrace_mod_jmp(ip, &ftrace_stub);
 }
-#else /* !CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS */
-int ftrace_enable_ftrace_graph_caller(void)
-{
-	return 0;
-}
-
-int ftrace_disable_ftrace_graph_caller(void)
-{
-	return 0;
-}
-#endif /* CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS */
-#endif /* !CONFIG_DYNAMIC_FTRACE */
+#endif /* CONFIG_DYNAMIC_FTRACE && !CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS */
 
 /*
  * Hook the return address and push it in the stack of return addrs
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 8f4fb328133a..289311680c29 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -30,6 +30,24 @@ int ftrace_graph_active;
 /* Both enabled by default (can be cleared by function_graph tracer flags */
 static bool fgraph_sleep_time = true;
 
+/*
+ * archs can override this function if they must do something
+ * to enable hook for graph tracer.
+ */
+int __weak ftrace_enable_ftrace_graph_caller(void)
+{
+	return 0;
+}
+
+/*
+ * archs can override this function if they must do something
+ * to disable hook for graph tracer.
+ */
+int __weak ftrace_disable_ftrace_graph_caller(void)
+{
+	return 0;
+}
+
 /**
  * ftrace_graph_stop - set to permanently disable function graph tracing
  *
-- 
2.35.2

