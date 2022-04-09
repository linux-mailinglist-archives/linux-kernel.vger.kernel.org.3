Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1FC04FA94D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 17:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242508AbiDIPic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 11:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242503AbiDIPi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 11:38:27 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5021A15714
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 08:36:19 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id s14-20020a17090a880e00b001caaf6d3dd1so14417274pjn.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Apr 2022 08:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8MqG/9eNugQ5tJ/Rtq+PYRLEoeHJFnYsCD3SnMQn4kg=;
        b=eDw0XX8vEuIxsKGozNNZkOhGWPGtwsuAkFfLzUQ+yypbCh/xcMJygJI7OS56r3htJO
         qQLLMDEH6AMQzz3W8+BQ5uQrRXlBQiXB+Je8D2lOlWyWmcGYiG3wKApKfwg1/Bvuqs7t
         WswxkWDQhddfR2XZuRzKm249vKm0mRxrImRJJhK87V2IfrCYKhqZkNYH1JwhDawj4Ydl
         imBXDNCEglXTrDLtnosUSHCjnPB9xEe+O3gR/0We8a0bA5gzYn6/18W6Fx2a+RzskD6k
         ZSCjTTJ8mEN5okEbgx8Cno+N466acr7GAAsyBQu7iSmDs9tcZE94ijqsdriVqkx6gjmq
         Nc2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8MqG/9eNugQ5tJ/Rtq+PYRLEoeHJFnYsCD3SnMQn4kg=;
        b=UIvbAdQhW0Msj09syEez0IN2oO0UagDibMly03n4ooqXphKLjPj7A9RPXr/mCjfIAJ
         vboprwwOJoyDyArrx2gBOZt/GGYBoGwGU7PUWuZ5fGm7JiX1HtzlOyGxrnwUTcHtgCUx
         I+caCeG5JmI6YY1snzq3k2t68Zpg/BqWCpV5hazzzuH3ktuOPCJkXTO27Uubr/NXIs2m
         V0B5DHPpd/iWzQM2CKrLs8Gf1+52BM+1F1Q5t7ue341DUR5v2h8VQlWNlvRgKeWU/s4G
         qI53OH8Wiv5A0rOtIi0vlXr8p5PW3oIDVTlYPODLGeLb2p7pt7XNO5qpnpJYWKDVoQb+
         FpKQ==
X-Gm-Message-State: AOAM530szMQKQzEIwHgGq7law+V+MTwT9feBpDx4GP8q8HHf3Z+9FE4T
        WQR+LBy/rM6tyOMXsJPRytNDdA==
X-Google-Smtp-Source: ABdhPJxJ6Bo6jodPi4S/LMUoloiu+LpPOAAl/jt9H56UlC5++ydCyKVu/ohLCA79/QKaaxG4oyUNBA==
X-Received: by 2002:a17:90a:8a85:b0:1ca:9d13:9f61 with SMTP id x5-20020a17090a8a8500b001ca9d139f61mr27887356pjn.35.1649518578706;
        Sat, 09 Apr 2022 08:36:18 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a28:e6c:f010:e956:3be0:d6a3:f6ba])
        by smtp.gmail.com with ESMTPSA id m1-20020a17090ade0100b001cb3feaddfcsm4810546pjv.2.2022.04.09.08.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Apr 2022 08:36:18 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     rostedt@goodmis.org, mingo@redhat.com, catalin.marinas@arm.com,
        will@kernel.org, tglx@linutronix.de, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        broonie@kernel.org, mark.rutland@arm.com, ardb@kernel.org,
        zhouchengming@bytedance.com, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        songmuchun@bytedance.com
Subject: [PATCH v4 1/2] ftrace: cleanup ftrace_graph_caller enable and disable
Date:   Sat,  9 Apr 2022 23:35:53 +0800
Message-Id: <20220409153554.14470-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
2.35.1

