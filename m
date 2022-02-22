Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6E844BF8AD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 14:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbiBVNB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 08:01:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiBVNBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 08:01:24 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E422AA2FC
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 05:00:59 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 195so16952978pgc.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 05:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nUt0EmZnAjWhiw3ria3c4mQpo/dgjgtowmwpyAc1Cbo=;
        b=IP8F2yfh8d9HOTDVcoFaajwYozjX6JSyXP3lHDNGD3uvbAQVChed6Pz/o8d3z4BNRs
         MQK37Phm7nbNzeUZ+cXLmxGBsiQ72zVhnyAWEqSe2D2o9aVHg9eUXvIykPldJaOHOmfd
         CjE2cQMjYIqPRckAM3+o+BGDt25/XhJsKE4CnwE6adTKuZoU/GiMBSde94S1m+bSN7Qf
         CZtgSdF5JIC7t6i4xns3a4pzTam5nUyPhwg/QGgzpx/CLBrm07+bT06ZHdz4Hc+YpLWa
         KuXk8qhaTBWulKv1AHGOjWNnadxF/sUbuP9lebmDv2CkFBjxUDQVNeCiohTE2WhHnVa6
         zflQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nUt0EmZnAjWhiw3ria3c4mQpo/dgjgtowmwpyAc1Cbo=;
        b=Rk3uQkJC1JBacOKztp26KQo53DLSk636895O/Wd9d2E9OHCuc6uqLzesbLsLTFy1sg
         /+16CSM0hrnvy7H4eziIPr5oTUj4Iy09KgJngRDLxABXJLiJJ6y7qeECSEHAZanVnApp
         72ydqzNYz034h6z9F6oouCNGXN5bqPeBmpWgcp1u1dCFRYYlXRWcL01ysyloLIhktHUw
         IgJlv4lx2wocI9M1L7/qhpBuTydeOF9mibxSsla4lEw8/i6/5oghx/EYuld8EuN1X+XW
         /boNhy08drqy5tR/+EERRjG9hgFTvAXCaqqk+O9HkFHsoQBw6CrfhsDBU8zZMrf76EyT
         ghnQ==
X-Gm-Message-State: AOAM532jCx2t5OCYZEmnC38BNlrvTCxYlk8oqkxGsC+Knot9ImNprzK9
        v+r4m1xfxk1OUyK8dg6G851NZg==
X-Google-Smtp-Source: ABdhPJzCf/hDKsVXtxWWr8kywPLuoA+ON50H4nU4G+0ivdzrlLu+RLrQDET6/Rcu1f60yUg8oVBCpQ==
X-Received: by 2002:aa7:9f5b:0:b0:4cc:964c:99dd with SMTP id h27-20020aa79f5b000000b004cc964c99ddmr24960894pfr.42.1645534858709;
        Tue, 22 Feb 2022 05:00:58 -0800 (PST)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.236])
        by smtp.gmail.com with ESMTPSA id j15sm18125567pfj.102.2022.02.22.05.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 05:00:58 -0800 (PST)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     rostedt@goodmis.org, mingo@redhat.com, catalin.marinas@arm.com,
        will@kernel.org, mark.rutland@arm.com, broonie@kernel.org
Cc:     songmuchun@bytedance.com, qirui.001@bytedance.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH] arm64/ftrace: Make function graph use ftrace directly
Date:   Tue, 22 Feb 2022 21:00:49 +0800
Message-Id: <20220222130049.81284-1-zhouchengming@bytedance.com>
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

As we do in commit 0c0593b45c9b ("x86/ftrace: Make function graph
use ftrace directly"), we don't need special hook for graph tracer,
but instead we use graph_ops:func function to install return_hooker.

Since commit 3b23e4991fb6 ("arm64: implement ftrace with regs") add
implementation for FTRACE_WITH_REGS on arm64, we can easily adopt
the same optimization on arm64.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 arch/arm64/include/asm/ftrace.h  |  7 +++++++
 arch/arm64/kernel/entry-ftrace.S |  6 ------
 arch/arm64/kernel/ftrace.c       | 21 +++++++++++++++++++++
 3 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
index 1494cfa8639b..dbc45a4157fa 100644
--- a/arch/arm64/include/asm/ftrace.h
+++ b/arch/arm64/include/asm/ftrace.h
@@ -80,8 +80,15 @@ static inline unsigned long ftrace_call_adjust(unsigned long addr)
 
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
 struct dyn_ftrace;
+struct ftrace_ops;
+struct ftrace_regs;
+
 int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec);
 #define ftrace_init_nop ftrace_init_nop
+
+void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
+		       struct ftrace_ops *op, struct ftrace_regs *fregs);
+#define ftrace_graph_func ftrace_graph_func
 #endif
 
 #define ftrace_return_address(n) return_address(n)
diff --git a/arch/arm64/kernel/entry-ftrace.S b/arch/arm64/kernel/entry-ftrace.S
index e535480a4069..eb4a69b1f84d 100644
--- a/arch/arm64/kernel/entry-ftrace.S
+++ b/arch/arm64/kernel/entry-ftrace.S
@@ -97,12 +97,6 @@ SYM_CODE_START(ftrace_common)
 SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBAL)
 	bl	ftrace_stub
 
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
-SYM_INNER_LABEL(ftrace_graph_call, SYM_L_GLOBAL) // ftrace_graph_caller();
-	nop				// If enabled, this will be replaced
-					// "b ftrace_graph_caller"
-#endif
-
 /*
  * At the callsite x0-x8 and x19-x30 were live. Any C code will have preserved
  * x19-x29 per the AAPCS, and we created frame records upon entry, so we need
diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
index 4506c4a90ac1..1b5da231b1de 100644
--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -268,6 +268,26 @@ void prepare_ftrace_return(unsigned long self_addr, unsigned long *parent,
 }
 
 #ifdef CONFIG_DYNAMIC_FTRACE
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+int ftrace_enable_ftrace_graph_caller(void)
+{
+	return 0;
+}
+
+int ftrace_disable_ftrace_graph_caller(void)
+{
+	return 0;
+}
+
+void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
+		       struct ftrace_ops *op, struct ftrace_regs *fregs)
+{
+	struct pt_regs *regs = arch_ftrace_get_regs(fregs);
+	unsigned long *parent = (unsigned long *)&procedure_link_pointer(regs);
+
+	prepare_ftrace_return(ip, parent, frame_pointer(regs));
+}
+#else
 /*
  * Turn on/off the call to ftrace_graph_caller() in ftrace_caller()
  * depending on @enable.
@@ -297,5 +317,6 @@ int ftrace_disable_ftrace_graph_caller(void)
 {
 	return ftrace_modify_graph_caller(false);
 }
+#endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
 #endif /* CONFIG_DYNAMIC_FTRACE */
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
-- 
2.20.1

