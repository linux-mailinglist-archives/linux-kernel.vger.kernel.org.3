Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE1524FA617
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 10:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235222AbiDII5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 04:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiDII5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 04:57:32 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39E421244
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 01:55:25 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id md4so2415652pjb.4
        for <linux-kernel@vger.kernel.org>; Sat, 09 Apr 2022 01:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7HV1je4u5Ps2cjIZaWTRdZP2wZij+4hAKWpeqsFhAYA=;
        b=bcxFfwZMolC4nUg0WowB0NHBwGnR5c3yV2aW2R/N9dCtkb6t35Wd0tC7Pq7ArzSk4e
         fBYz6wcSdqSA1NyJP8DcFFwgHiJYuHKIbq+ieNf3gVCkYYdEBLbvcyK2GXuJzHoppAFP
         C5JVsKbKOSYmE/f7USfgc+GVR4giVMD2nmr0kzOqcxqSQocxKOIsXukfEGQtKXANx2+M
         EEgnL0XNrnvIOyz5s1RQD7ONMMsb/A5qzNi1Uo2H+4MVC8RnS6sUHL1EgcXzYw0JRk4g
         lUejvKgvTP2LjcWdim/+bndMLyV53A0MW/89XWVPEcqjVvFQYW5ZoBJOB6gsfbno41YH
         3aGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7HV1je4u5Ps2cjIZaWTRdZP2wZij+4hAKWpeqsFhAYA=;
        b=63KsWGhvolX4YrhI4MfRhoVQltckMchrXmVtNdHCVi5uz8pZR/kjiWF/ZNoBybkNXo
         pqcWbmVDzxJscS5KEB+LfUIzgUYw4S5NjNHxCYwR2m/xmbmVxnRDT7EoAVOtUcsYrwqv
         /fy0VKcEF87i9TVIZuFuIUTmHdIwYpl7RpviToID+33/LxLO5Plf9Umo5644vrnPpxXE
         qsC1QH8GvwTDqF+4gmAoxK/4tMBP/F9anBNMg1S1PViyW9+ZZwer/BPTfvjTmTcd6gUx
         Xi7uOoZLAyKU24L66QubINDr4KAw2BUExXJ+Wj9146PCVJka3USIZ0v/rqUhsUnDx8gI
         4C3g==
X-Gm-Message-State: AOAM533Y5Tay9gskoz+/P/LPcVjbmkymAlfPl7UiLyJ5CvXK73aOu5Eg
        ENuAblx1zQ2sdsANafWr/m5F9g==
X-Google-Smtp-Source: ABdhPJw/1U1aSHZo/9aCtqEnmz2T1/PqhEfq3BRGeyZsXATl15zYpTaJzxxbAs1pvsCt15Z7SVhYRA==
X-Received: by 2002:a17:902:db0e:b0:154:8682:c1db with SMTP id m14-20020a170902db0e00b001548682c1dbmr23053611plx.128.1649494524777;
        Sat, 09 Apr 2022 01:55:24 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a28:e6c:f010:3c21:7dc2:3a08:b6bc])
        by smtp.gmail.com with ESMTPSA id f192-20020a636ac9000000b0039836edcf42sm24460806pgc.85.2022.04.09.01.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Apr 2022 01:55:23 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     rostedt@goodmis.org, mingo@redhat.com, catalin.marinas@arm.com,
        will@kernel.org, tglx@linutronix.de, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        broonie@kernel.org, mark.rutland@arm.com, ardb@kernel.org,
        zhouchengming@bytedance.com, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        songmuchun@bytedance.com
Subject: [PATCH RESEND v3 1/2] ftrace: cleanup ftrace_graph_caller enable and disable
Date:   Sat,  9 Apr 2022 16:54:59 +0800
Message-Id: <20220409085500.4549-1-zhouchengming@bytedance.com>
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
v3:
 - consolidate two #if into a single #if, suggested by Steve. Thanks.
---
 arch/x86/kernel/ftrace.c | 17 ++---------------
 kernel/trace/ftrace.c    | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+), 15 deletions(-)

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
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 4f1d2f5e7263..30622c755c77 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2721,6 +2721,26 @@ int __weak ftrace_arch_code_modify_post_process(void)
 	return 0;
 }
 
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
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
+#endif
+
 void ftrace_modify_all_code(int command)
 {
 	int update = command & FTRACE_UPDATE_TRACE_FUNC;
-- 
2.20.1

