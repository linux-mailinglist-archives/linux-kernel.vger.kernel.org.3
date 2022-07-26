Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1029580E0D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 09:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238355AbiGZHkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 03:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238550AbiGZHiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 03:38:46 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3C56467
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 00:38:37 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-31e60b8bb07so105105217b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 00:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jqHv3wNh5seyZnCSMu1rVV5xcStpMLXUKBtcU3Y1j6g=;
        b=ocN5AR1zWFMJEdlfQYlUgBVvqdAFbwAuvDwmF8/WQF7flrQZy/d2lABpWZ90I1DGwj
         uBDOTwVB3d0mowFCuMBvFItzze3IgDYvVeY7MF+0YCht4BAY9N6Rvg3LgAdPwNAO7Zqa
         UWsoXpemhN+pJ+qvZZlKIlMkVeXNiyHkkrkksywHf4jDn9qkfULtI3MYl337w8Z1pIi0
         hGesxH4lpG5OYmornCWfc/StZhbhdxa0VAvVvGMJ8tJ7mP8FUQKCMgedSz5c27wL4aN1
         Y/7E4OfVr6mEd/aTfmMEtKFSKRG5k/Q6b/oS8yrnS7U3v1pA8SbmNiuNjfXvoeXZ3KFi
         sMjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jqHv3wNh5seyZnCSMu1rVV5xcStpMLXUKBtcU3Y1j6g=;
        b=GpRILJeTQtkk1U5astqHp6tGArkRwlU3WaAF8F3Y0HUhQCyHvZpJGBLPBU68kUSpXZ
         6AvypuDW3rH6AUUXGaQK0P4/X/4zmgunXv15TVUbMuJy9cA3yG22mshRHEVSBjqS+CV4
         bT4IDs/Mo0d0fWepUrg0gFVnIkfgEAqC0QuTJCS9aDFGXbBaDxpNyD52VgeIAB/Fhc48
         l98Y2yJ0yW6Htv+XykmOPTJXf5WhgUI+BuHEU34yicRPPjCiA041GSEGyPlMyKyv9ov1
         u/BepvJZxHFIZzUAVO4358un/Fvo8zi/fH3MSfmxIiUSoyDWKY+odrd6E3o+wVPem77n
         OWKg==
X-Gm-Message-State: AJIora97RyzQEcJRCBZwiSktzgFF8k6Hqhu3im8PH7iAYIUOSc8XK9zI
        jkVaSoyLfeBkFbH0lAxCzb4NlOAijnSqL2hDAQ==
X-Google-Smtp-Source: AGRyM1topRzJUtRGNFO9xj3XVL9vGf78Qw66LXXmx8qTxzqFbDxaG+0vvCO+D0Dnu6p0fFCleQQnl3iTvjkdyPhgxw==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:4f77:3b64:736a:394e])
 (user=kaleshsingh job=sendgmr) by 2002:a25:640a:0:b0:671:3386:f860 with SMTP
 id y10-20020a25640a000000b006713386f860mr6983680ybb.423.1658821116945; Tue,
 26 Jul 2022 00:38:36 -0700 (PDT)
Date:   Tue, 26 Jul 2022 00:37:50 -0700
In-Reply-To: <20220726073750.3219117-1-kaleshsingh@google.com>
Message-Id: <20220726073750.3219117-18-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220726073750.3219117-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v6 17/17] KVM: arm64: Introduce pkvm_dump_backtrace()
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
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dumps the pKVM hypervisor backtrace from EL1 by reading the unwinded
addresses from the shared stacktrace buffer.

The nVHE hyp backtrace is dumped on hyp_panic(), before panicking the
host.

[  111.623091] kvm [367]: nVHE call trace:
[  111.623215] kvm [367]:  [<ffff8000090a6570>] __kvm_nvhe_hyp_panic+0xac/0xf8
[  111.623448] kvm [367]:  [<ffff8000090a65cc>] __kvm_nvhe_hyp_panic_bad_stack+0x10/0x10
[  111.623642] kvm [367]:  [<ffff8000090a61e4>] __kvm_nvhe_recursive_death+0x24/0x34
. . .
[  111.640366] kvm [367]:  [<ffff8000090a61e4>] __kvm_nvhe_recursive_death+0x24/0x34
[  111.640467] kvm [367]:  [<ffff8000090a61e4>] __kvm_nvhe_recursive_death+0x24/0x34
[  111.640574] kvm [367]:  [<ffff8000090a5de4>] __kvm_nvhe___kvm_vcpu_run+0x30/0x40c
[  111.640676] kvm [367]:  [<ffff8000090a8b64>] __kvm_nvhe_handle___kvm_vcpu_run+0x30/0x48
[  111.640778] kvm [367]:  [<ffff8000090a88b8>] __kvm_nvhe_handle_trap+0xc4/0x128
[  111.640880] kvm [367]:  [<ffff8000090a7864>] __kvm_nvhe___host_exit+0x64/0x64
[  111.640996] kvm [367]: ---[ end nVHE call trace ]---

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---

Changes in v6:
  - And range check when dumping pkvm stacktrace, per Oliver
  - Use consistent nVHE call trace delimiters between protected and
    non-protected mode, per Oliver
  - Fix typo in comment, per Fuad

Changes in v5:
  - Move code out from nvhe.h header to handle_exit.c, per Marc
  - Fix stacktrace symbolization when CONFIG_RAMDOMIZE_BASE is enabled,
    per Fuad
  - Use regular comments instead of doc comments, per Fuad

 arch/arm64/kvm/handle_exit.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
index e83e6f735100..c14fc4ba4422 100644
--- a/arch/arm64/kvm/handle_exit.c
+++ b/arch/arm64/kvm/handle_exit.c
@@ -371,6 +371,39 @@ static void hyp_dump_backtrace(unsigned long hyp_offset)
 	kvm_nvhe_dump_backtrace_end();
 }
 
+#ifdef CONFIG_PROTECTED_NVHE_STACKTRACE
+DECLARE_KVM_NVHE_PER_CPU(unsigned long [NVHE_STACKTRACE_SIZE/sizeof(long)],
+			 pkvm_stacktrace);
+
+/*
+ * pkvm_dump_backtrace - Dump the protected nVHE HYP backtrace.
+ *
+ * @hyp_offset: hypervisor offset, used for address translation.
+ *
+ * Dumping of the pKVM HYP backtrace is done by reading the
+ * stack addresses from the shared stacktrace buffer, since the
+ * host cannot directly access hypervisor memory in protected
+ * mode.
+ */
+static void pkvm_dump_backtrace(unsigned long hyp_offset)
+{
+	unsigned long *stacktrace
+		= (unsigned long *) this_cpu_ptr_nvhe_sym(pkvm_stacktrace);
+	int i, size = NVHE_STACKTRACE_SIZE / sizeof(long);
+
+	kvm_nvhe_dump_backtrace_start();
+	/* The saved stacktrace is terminated by a null entry */
+	for (i = 0; i < size && stacktrace[i]; i++)
+		kvm_nvhe_dump_backtrace_entry((void *)hyp_offset, stacktrace[i]);
+	kvm_nvhe_dump_backtrace_end();
+}
+#else	/* !CONFIG_PROTECTED_NVHE_STACKTRACE */
+static void pkvm_dump_backtrace(unsigned long hyp_offset)
+{
+	kvm_err("Cannot dump pKVM nVHE stacktrace: !CONFIG_PROTECTED_NVHE_STACKTRACE\n");
+}
+#endif /* CONFIG_PROTECTED_NVHE_STACKTRACE */
+
 /*
  * kvm_nvhe_dump_backtrace - Dump KVM nVHE hypervisor backtrace.
  *
@@ -379,7 +412,7 @@ static void hyp_dump_backtrace(unsigned long hyp_offset)
 static void kvm_nvhe_dump_backtrace(unsigned long hyp_offset)
 {
 	if (is_protected_kvm_enabled())
-		return;
+		pkvm_dump_backtrace(hyp_offset);
 	else
 		hyp_dump_backtrace(hyp_offset);
 }
-- 
2.37.1.359.gd136c6c3e2-goog

