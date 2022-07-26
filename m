Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A029580DFF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 09:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238042AbiGZHjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 03:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238441AbiGZHin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 03:38:43 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B38E2BCA
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 00:38:15 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2eb7d137101so105390847b3.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 00:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=i3lgJjiT46mrfMrlOUzdDB8/4iw1XwFuVsxnh7Km3KU=;
        b=WOkwBJsq6ZjTSMovFjTZSwD8sMa0HEZuNKHEgdh0voOyB5tJv9hkeQ+fZDL1k9LQcl
         HdmKNrGKCbOT5bEqpnEt7rwEAZDZ+0zTSWbaLPiU0AqMqsipdiozcfCUa9u6bPIBOatS
         vWPrP5aG+wSpIvX8sr/94a4xqITU92dSLf2AYfmTEoqKskq1JhQN2gcbTTrtvANOu5eO
         1vVBWRdSsgYX2zoljGCoDswSlE7tA3EoGUGyC5jpvxoGAWjlU43CU5+5obQRNcLBOQGL
         H7NE9oMLvMbY89vNyCOO9gqAaCApSjv9H1wQVr4qEtQwGbYboXkRvHJugniaI+3iDPfl
         O31w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=i3lgJjiT46mrfMrlOUzdDB8/4iw1XwFuVsxnh7Km3KU=;
        b=KUhdoj47cKaSyQqtW2nhKWzdC9q0bzR2kwjznR3iNkWfislBTFkg6KZEn3e5/gHznf
         ODr/SLYIJRvK9ju1xzBVrybUUF1GafdfqdzyoRtpwob9Xybfdj84daoYbdwnqXY5ZBNJ
         UoNY1LMiXDIM9pzfyrWmfauFa/7kyQOD86zxPB89IrS5c4tXJ0Ztq2xgQFLjmk+r7rxm
         qIHTD6+m5zPgTmWAf/EHGDHwsnG7/Bo/p/eBRjAg4zTtuKYkt+T5DDiY/wCUjclEhfNT
         b7WKqpBkVeOXGIE7zytxOLlG/ALCnbtaO+B678EKcS7u2PcR5tHg2inXtRThv/FarNhD
         I3dg==
X-Gm-Message-State: AJIora8yc5QUBO3KoV8gYV3ahqZ/S6SWkcPwb+MCoU1LmHDnLFGPVEFT
        7EnJwxpCIoTZzKZgZXDgzN1ppk8bnlwNoZbfIg==
X-Google-Smtp-Source: AGRyM1uSyW7sYTMSgC+uaW3gfAmuo2IndnCXRVAcmDi9a0epcfogUXoXeu1EIc1/i1iJusQo8hJnHjXzlwV/bKaYCw==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:4f77:3b64:736a:394e])
 (user=kaleshsingh job=sendgmr) by 2002:a25:9e92:0:b0:66e:c03e:c632 with SMTP
 id p18-20020a259e92000000b0066ec03ec632mr12231031ybq.279.1658821094784; Tue,
 26 Jul 2022 00:38:14 -0700 (PDT)
Date:   Tue, 26 Jul 2022 00:37:41 -0700
In-Reply-To: <20220726073750.3219117-1-kaleshsingh@google.com>
Message-Id: <20220726073750.3219117-9-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220726073750.3219117-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v6 08/17] KVM: arm64: Stub implementation of non-protected
 nVHE HYP stack unwinder
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

Add stub implementations of non-protected nVHE stack unwinder, for
building. These are implemented later in this series.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
Reviewed-by: Fuad Tabba <tabba@google.com>
Tested-by: Fuad Tabba <tabba@google.com>
---

Changes in v6:
  - Add Fuad=E2=80=99s Reviewed-by and Tested-by tags

Changes in v5:
  - Mark unwind_next() as inline, per Marc
  - Comment !__KVM_NVHE_HYPERVISOR__ unwinder path, per Marc

 arch/arm64/include/asm/stacktrace/nvhe.h | 47 ++++++++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 arch/arm64/include/asm/stacktrace/nvhe.h

diff --git a/arch/arm64/include/asm/stacktrace/nvhe.h b/arch/arm64/include/=
asm/stacktrace/nvhe.h
new file mode 100644
index 000000000000..1192ae0f80c1
--- /dev/null
+++ b/arch/arm64/include/asm/stacktrace/nvhe.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * KVM nVHE hypervisor stack tracing support.
+ *
+ * The unwinder implementation depends on the nVHE mode:
+ *
+ *   1) Non-protected nVHE mode - the host can directly access the
+ *      HYP stack pages and unwind the HYP stack in EL1. This saves having
+ *      to allocate shared buffers for the host to read the unwinded
+ *      stacktrace.
+ *
+ * Copyright (C) 2022 Google LLC
+ */
+#ifndef __ASM_STACKTRACE_NVHE_H
+#define __ASM_STACKTRACE_NVHE_H
+
+#include <asm/stacktrace/common.h>
+
+static inline bool on_accessible_stack(const struct task_struct *tsk,
+				       unsigned long sp, unsigned long size,
+				       struct stack_info *info)
+{
+	return false;
+}
+
+#ifndef __KVM_NVHE_HYPERVISOR__
+/*
+ * Conventional (non-protected) nVHE HYP stack unwinder
+ *
+ * In non-protected mode, the unwinding is done from kernel proper context
+ * (by the host in EL1).
+ */
+
+static inline bool on_overflow_stack(unsigned long sp, unsigned long size,
+				     struct stack_info *info)
+{
+	return false;
+}
+
+static inline int notrace unwind_next(struct unwind_state *state)
+{
+	return 0;
+}
+NOKPROBE_SYMBOL(unwind_next);
+
+#endif	/* !__KVM_NVHE_HYPERVISOR__ */
+#endif	/* __ASM_STACKTRACE_NVHE_H */
--=20
2.37.1.359.gd136c6c3e2-goog

