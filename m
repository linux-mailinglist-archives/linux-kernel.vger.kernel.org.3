Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8558A4C0EC8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 10:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239130AbiBWJCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 04:02:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237446AbiBWJC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 04:02:26 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B711A3D495
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 01:01:56 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id y11so14713144pfa.6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 01:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fwKCeIH2LJDOEHrJ3F/N+2CH9rq2X4JR/XFEekxpx90=;
        b=eaknSG0N68J1eDmEtghFazXyiST6ZOm4jjMgO0YXLNTInrEDV3zMU1iFF90mCjnlmE
         egnsRa8nkiZ/JCp7JFSYYuVhVSNDTFoTAzrelUQuFimgl0j660yFxKhHVyUDQeHRnDxc
         BvpXz3LSQGEUoY8X/c41ec4rAd083XHdeVs6E5T0iNlNTjwoE8p9HDZRXuX0MDdNl/Ud
         VTbvXylbym7BlFcjE8Dr5c3jwq1/YZCMvUfoGftobfUk5hpnBwlkst29J2OuLZVk+r0H
         I3LBCQOgnx8IKeo/msR1nc9jVdVgIxty6lemdt0cPkngScag7X58KKT6hRGGyAfVMTF4
         bxiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fwKCeIH2LJDOEHrJ3F/N+2CH9rq2X4JR/XFEekxpx90=;
        b=Zkjg0PWCBKFJhCKEOzgSBgQ3+Xl6cIDAgAGjXm6gDUJBONep/k5i5iDL46tSJR61Im
         g7XD8iyhGvvJ1bUfn/eUDSSZT6KPwuvddGuCykItVJk/zCvLMD8PwbnfvKSFApppAxf9
         PPChHMm2ExaFLmZieMRut4C0wo+PjLKuAhPX4TZxIfdmzP93A/9wAEjpKN1CSC0vWfQ+
         znkKpVNcwp1olIz9JuVGu50HJ2DMXCxU+KuqAwQB9vtquoiPqUfAVmd5DQU2N1sJ/92N
         BcXyHe0rtFCbvAZkuOVFyhL7rHfLff62ueFl7++VT86lOL0p2vubOK7Nf0XJupQPsV83
         P/mg==
X-Gm-Message-State: AOAM533+uLvwHYF3CzGzhhm3Q+kT7wuGRi9m0mcd06t1d4EDEVtBhIz0
        yrNUOeq6fkx/jPSCXSpmRXjZXQ==
X-Google-Smtp-Source: ABdhPJx5PxhwkYgSb1eT4c8XTA1Hu+wi7LzDy2KYbxZ0m4uId7pdG7tzSTR7VtMhqHS5ZCOKZeU2gg==
X-Received: by 2002:a63:8543:0:b0:35e:3bd9:3798 with SMTP id u64-20020a638543000000b0035e3bd93798mr23237871pgd.73.1645606916303;
        Wed, 23 Feb 2022 01:01:56 -0800 (PST)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id k9sm21458694pfc.157.2022.02.23.01.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 01:01:55 -0800 (PST)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     rostedt@goodmis.org, mingo@redhat.com, catalin.marinas@arm.com,
        will@kernel.org, broonie@kernel.org, mark.rutland@arm.com,
        tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com
Cc:     linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        qirui.001@bytedance.com,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v2 1/2] ftrace: cleanup ftrace_graph_caller enable and disable
Date:   Wed, 23 Feb 2022 17:01:31 +0800
Message-Id: <20220223090132.10114-1-zhouchengming@bytedance.com>
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

The ftrace_enable_ftrace_graph_caller() and
ftrace_disable_ftrace_graph_caller() are used to do special
hooks for graph tracer, which are not needed on some ARCHs
when DYNAMIC_FTRACE_WITH_[ARGS,REGS] enabled. So introduce
weak version in Ftrace core code to cleanup them.

And fix the incorrect comment in that two #endif, which should
match the previous #ifdef and #ifndef.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 arch/x86/kernel/ftrace.c | 14 ++------------
 kernel/trace/ftrace.c    | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 7cc540e6de0c..c119ef7a9295 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -615,18 +615,8 @@ int ftrace_disable_ftrace_graph_caller(void)
 
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
+#endif /* !CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS */
+#endif /* CONFIG_DYNAMIC_FTRACE */
 
 /*
  * Hook the return address and push it in the stack of return addrs
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index f9feb197b2da..60ae009e6684 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2704,6 +2704,26 @@ int __weak ftrace_arch_code_modify_post_process(void)
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

