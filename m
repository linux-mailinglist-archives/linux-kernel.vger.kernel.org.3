Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4524C282C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 10:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbiBXJdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 04:33:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbiBXJds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 04:33:48 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7114279912
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 01:33:17 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id e13so1193994plh.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 01:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OMIZP6Tn3aNghkB6sgI2t3mcM1DU0EefBNvEwhIXg7s=;
        b=bnEy6oVHEjlP6py1RGQ0IRdAQo4si4xNGKMak2bDSmFVhT/YCK1CEGuYOIbwi++MOH
         HDVaq2kou8+Etgm4eE/ZDBKxbttvjPsu3aTYLgzyNZAFVHDcvAazo+iwf54kNC1GSYLf
         gS786hKTlL+//CkSxzrqDxFb42sSpgLOzMgklp0O0843cj4ehroSkJtkOaWNL4A7UmEa
         7WrLdrx2ezjrLjOeQl1w1gkJtWGrvjlsCBgFpPLHFOj2B5PcYe9P6DwwFj0ZrxhvA9DR
         pFLdmbdzkvH3IXjpKjQrSNn5L7+QtMLWFd4L8C4/ezw4UZV+enXIQB3h03U8ww+o34hx
         H87w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OMIZP6Tn3aNghkB6sgI2t3mcM1DU0EefBNvEwhIXg7s=;
        b=kLJUaMIQhFSNaWn1dncIJu8oEuhHRAgl3Y+hPJS/6M7ciOfQsswIJ3nhX6FhhSV+iK
         T1G8rz9ozy/FZDeVrfUL8V0Olsyndj/P9zKzEpgamkfIxcVB+iswsLx9fBLk8oqWYe81
         Li13uNn6UvAFKSQg+WnWKw48FG/HY5DhaZ9kS3wz/xlldvlTK78otNXFD3NlMZicagLv
         CG8qbwX2/ZndmWc3bfEbJg8q7E4irGPc7ymIH9I85/ePPtrtQ871awEBfcNrWFp2KVPU
         6/40ELIs3wYNVEy+P3y4HhhTmegbQ0/gfhnoN6835RoU+MPogmznMgBFThZ3hw92lyOC
         wXJA==
X-Gm-Message-State: AOAM532y8yEoohEW79RgU+bv5hF+AwtguIjoHHOpr0UbHU+jCMr1llLm
        50h26NmP1+4CpbKRYZKYcJAJqA==
X-Google-Smtp-Source: ABdhPJxS5+gNrTAaOlz3Mv8zDTadsNwcTzdsmY8lcyo257Y5g5dxXtYn+i5IXdMYEZsOgTaSV9MuYA==
X-Received: by 2002:a17:902:bc82:b0:14f:2b9c:4aa with SMTP id bb2-20020a170902bc8200b0014f2b9c04aamr1623688plb.145.1645695197232;
        Thu, 24 Feb 2022 01:33:17 -0800 (PST)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id 13sm2530988pfx.122.2022.02.24.01.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 01:33:16 -0800 (PST)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     rostedt@goodmis.org, mark.rutland@arm.com, mingo@redhat.com,
        tglx@linutronix.de, catalin.marinas@arm.com, will@kernel.org,
        dave.hansen@linux.intel.com, broonie@kernel.org
Cc:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        qirui.001@bytedance.com,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v3 1/3] ftrace: cleanup ftrace_graph_caller enable and disable
Date:   Thu, 24 Feb 2022 17:32:49 +0800
Message-Id: <20220224093251.49971-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ftrace_enable_ftrace_graph_caller() and
ftrace_disable_ftrace_graph_caller() are used to do special
hooks for graph tracer, which are not needed on some ARCHs
that use graph_ops:func function to install return_hooker.

So introduce the weak version in Ftrace core code to prepare
for cleanup.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 kernel/trace/ftrace.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

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

