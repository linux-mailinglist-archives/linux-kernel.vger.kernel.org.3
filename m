Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77DE5580E0E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 09:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238093AbiGZHkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 03:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238519AbiGZHiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 03:38:46 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CAD2BFB
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 00:38:30 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-31edbd801b5so52732567b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 00:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=xrCZ3JDmoRPruDDfTE2MIoljy3aPp6Mt1Jsyf41HvKw=;
        b=m6IsAPXeraH4sveiwup4g2zagtiCTkNBAzqv8fgM0IoJl7hrB2JzWnIspy1lIY7osA
         NzAq3F6sO2d8uqWMdVFrS63sBkmLaYviVNj7S5bFoNxZW4aM3kSxz16b2fsJs1wHVodj
         XYTsyXv2EdLxUTOBL2TRNlpw2hv5izPXRxd/Z8NCB05ZO1KoHvjIeAKzQ/wCMrPfIjkF
         CwDZjSNE4xTOp8O6+44f6VUzoPj0PPtSHzUMylIR6Z8gIUsJG12CccrP3jvNWY5L6ovS
         GpZRrij++WgXDPzUdF+AuJ2mJkEU3GESYnoDG1tN06qjgOizHU6Q+SpIz3jEcMDcit9j
         EyAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=xrCZ3JDmoRPruDDfTE2MIoljy3aPp6Mt1Jsyf41HvKw=;
        b=aLNH8UUCOISk3FmHUe6k/rb17CJUL77cN87X6iVW+bwg2OmagS3va1V/KnDqyGcyVl
         JWePsdw7S6gjqm3ssfxQe5euB1Uhcy0o7tLL/ef96A64rrlscbXbbC9fgr94lxJ0M+Hg
         WF3AQLM3aCvaUr0FJj8unFxJmMUCbQ/iYbX0HkYKKA/LCAHCmIswk0kyvV5d7BbRG78/
         7hcNP8PxCx+jXkkHiSof7NAujAUdbfzrrSWYG1LLnGpfyjdR7IayOWf4kw3WdcIU0I4L
         R12Vke82NgTnp25qhe6Jsdo98I9RZHxnQQQfVQp/g6X2ycz3rD0EyOqtMAgAwN4ROJB/
         shIg==
X-Gm-Message-State: AJIora8zYGmeNzXHb4pVG/u7RdFDJI7Hc3pbZ8HS0ucdDegGBMP/Vz7p
        ZwCgkFecxqJnOHnGvCnXyRO6gTNUpATWpP/N0g==
X-Google-Smtp-Source: AGRyM1tNxOOKtnk6pZWo0eI8iYyyinuUNbf8mMV5eXM2bUjJGrThxUTbi7FD+57/XnORNw3Rkfp420sRl8CYsBg42g==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:4f77:3b64:736a:394e])
 (user=kaleshsingh job=sendgmr) by 2002:a05:6902:1542:b0:66e:e116:95b8 with
 SMTP id r2-20020a056902154200b0066ee11695b8mr12799119ybu.218.1658821109572;
 Tue, 26 Jul 2022 00:38:29 -0700 (PDT)
Date:   Tue, 26 Jul 2022 00:37:47 -0700
In-Reply-To: <20220726073750.3219117-1-kaleshsingh@google.com>
Message-Id: <20220726073750.3219117-15-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220726073750.3219117-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v6 14/17] KVM: arm64: Stub implementation of pKVM HYP stack unwinder
From:   Kalesh Singh <kaleshsingh@google.com>
To:     maz@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        madvenka@linux.microsoft.com, tabba@google.com,
        oliver.upton@linux.dev
Cc:     will@kernel.org, qperret@google.com, kaleshsingh@google.com,
        james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com,
        andreyknvl@gmail.com, vincenzo.frascino@arm.com,
        mhiramat@kernel.org, ast@kernel.org, wangkefeng.wang@huawei.com,
        elver@google.com, keirf@google.com, yuzenghui@huawei.com,
        ardb@kernel.org, oupton@google.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, android-mm@google.com,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add some stub implementations of protected nVHE stack unwinder, for
building. These are implemented later in this series.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
Reviewed-by: Fuad Tabba <tabba@google.com>
Tested-by: Fuad Tabba <tabba@google.com>
---

Changes in v6:
  - Add Fuad=E2=80=99s Reviewed-by and Tested-by tags

Changes in v5:
  - Mark unwind_next() as inline, per Marc

 arch/arm64/include/asm/stacktrace/nvhe.h | 35 ++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/stacktrace/nvhe.h b/arch/arm64/include/=
asm/stacktrace/nvhe.h
index 170fe7459f7c..2ce59c058806 100644
--- a/arch/arm64/include/asm/stacktrace/nvhe.h
+++ b/arch/arm64/include/asm/stacktrace/nvhe.h
@@ -9,6 +9,10 @@
  *      to allocate shared buffers for the host to read the unwinded
  *      stacktrace.
  *
+ *   2) pKVM (protected nVHE) mode - the host cannot directly access
+ *      the HYP memory. The stack is unwinded in EL2 and dumped to a share=
d
+ *      buffer where the host can read and print the stacktrace.
+ *
  * Copyright (C) 2022 Google LLC
  */
 #ifndef __ASM_STACKTRACE_NVHE_H
@@ -49,7 +53,34 @@ static inline bool on_accessible_stack(const struct task=
_struct *tsk,
 	return false;
 }
=20
-#ifndef __KVM_NVHE_HYPERVISOR__
+#ifdef __KVM_NVHE_HYPERVISOR__
+/*
+ * Protected nVHE HYP stack unwinder
+ *
+ * In protected mode, the unwinding is done by the hypervisor in EL2.
+ */
+
+#ifdef CONFIG_PROTECTED_NVHE_STACKTRACE
+static inline bool on_overflow_stack(unsigned long sp, unsigned long size,
+				     struct stack_info *info)
+{
+	return false;
+}
+
+static inline bool on_hyp_stack(unsigned long sp, unsigned long size,
+				struct stack_info *info)
+{
+	return false;
+}
+
+static inline int notrace unwind_next(struct unwind_state *state)
+{
+	return 0;
+}
+NOKPROBE_SYMBOL(unwind_next);
+#endif	/* CONFIG_PROTECTED_NVHE_STACKTRACE */
+
+#else	/* !__KVM_NVHE_HYPERVISOR__ */
 /*
  * Conventional (non-protected) nVHE HYP stack unwinder
  *
@@ -132,5 +163,5 @@ static inline int notrace unwind_next(struct unwind_sta=
te *state)
 }
 NOKPROBE_SYMBOL(unwind_next);
=20
-#endif	/* !__KVM_NVHE_HYPERVISOR__ */
+#endif	/* __KVM_NVHE_HYPERVISOR__ */
 #endif	/* __ASM_STACKTRACE_NVHE_H */
--=20
2.37.1.359.gd136c6c3e2-goog

