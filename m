Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4C0C5670E8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 16:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbiGEOXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 10:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232954AbiGEOX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 10:23:27 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396ADD42
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 07:23:25 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id f13-20020a0564021e8d00b00437a2acb543so9403129edf.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 07:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=2zQlYc9U3hxiIn86A5QE2kEqLA+X+YH+JZD8cteagW8=;
        b=fqCtfyiWnz/sDbhBL26vUNigBrQZ7zc1r3SbimUnoBkTZIKAL796jt+N0l7Ug0wnn+
         75Cal62Cu7Fahm0ZR6w8DSiM6GATiDJdvNIUqzFzHnrMR78YCmguqNM6frxwfTRTggqK
         sOFFIN06fK9vVqaLxRvQB9VGFNhHVu7o5octaE1JxZu4S2GtzqeaFhfSyul1iRTL5MG8
         MCbDUtMAqnfI9JBgZFh2FWoQ1tnV/HCzi1nrsw/5xcM4Hyq9wsjtUBZVYlXWrzHhos98
         FHC99aEQ8ZprYBhSGhJGV6WuD9HIzFbbIx+2xsPs8lgThNEgd35vSvR0UwfkaTd0+bxq
         9sYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=2zQlYc9U3hxiIn86A5QE2kEqLA+X+YH+JZD8cteagW8=;
        b=E6BCoaC6sHnC9ajaQXwbL3yEIYxeOh1cVSb/zvIa1LKi52tpm+wkjDuo0m1USqIF24
         6seedXTT3mPB1tT7juyx0ctHGAblew+aVskhtwnLQNsHFz/AuZzLSkDT4gZhN0aThSVM
         mAK8u5Ej+idg9oJ8ynJUPqZyywCwSY3iS7CzCji0EJyc12kRWPpB6PJDiTC3jmBrm6X6
         eHYrdZa+qy3XHQ2bKRVrm2QfBwBcdwVZKBLaQEHk4Mdcs4FE7WaWk+pWlPJap12j7lBx
         ZXK62N3rYhMuRu3aCnONGBMmWGh3928tayFMcwA0aughJyKZGdFah1KocCkl0sugI63P
         NzMA==
X-Gm-Message-State: AJIora9TWpvxj3CfizmEKAoKz+4HZd2yuiAH8hM0CUPnh2o+uVXKIig2
        JiRO9TomNmqufX4gHbVSBPIwyzUlfCw9
X-Google-Smtp-Source: AGRyM1tNS+g/vNh5/iHJY0oJdpY+ypTBmtMZDDMx1nXevSQ85XuXevbZFlKhTyDeX1hSIW57PP5R15KNfRy1
X-Received: from big-boi.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:129])
 (user=qperret job=sendgmr) by 2002:a17:906:7790:b0:722:e6cf:126 with SMTP id
 s16-20020a170906779000b00722e6cf0126mr33544579ejm.244.1657031003645; Tue, 05
 Jul 2022 07:23:23 -0700 (PDT)
Date:   Tue,  5 Jul 2022 14:23:10 +0000
Message-Id: <20220705142310.3847918-1-qperret@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH] KVM: arm64: Don't return from void function
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, qperret@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although harmless, the return statement in kvm_unexpected_el2_exception
is rather confusing as the function itself has a void return type. The
C standard is also pretty clear that "A return statement with an
expression shall not appear in a function whose return type is void".
Given that this return statement does not seem to add any actual value,
let's not pointlessly violate the standard.

Build-tested with GCC 10 and CLANG 13 for good measure, the disassembled
code is identical with or without the return statement.

Fixes: e9ee186bb735 ("KVM: arm64: Add kvm_extable for vaxorcism code")
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/nvhe/switch.c | 2 +-
 arch/arm64/kvm/hyp/vhe/switch.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
index 6db801db8f27..925b34b7708d 100644
--- a/arch/arm64/kvm/hyp/nvhe/switch.c
+++ b/arch/arm64/kvm/hyp/nvhe/switch.c
@@ -386,5 +386,5 @@ asmlinkage void __noreturn hyp_panic_bad_stack(void)
 
 asmlinkage void kvm_unexpected_el2_exception(void)
 {
-	return __kvm_unexpected_el2_exception();
+	__kvm_unexpected_el2_exception();
 }
diff --git a/arch/arm64/kvm/hyp/vhe/switch.c b/arch/arm64/kvm/hyp/vhe/switch.c
index 969f20daf97a..390af1a6a9b4 100644
--- a/arch/arm64/kvm/hyp/vhe/switch.c
+++ b/arch/arm64/kvm/hyp/vhe/switch.c
@@ -249,5 +249,5 @@ void __noreturn hyp_panic(void)
 
 asmlinkage void kvm_unexpected_el2_exception(void)
 {
-	return __kvm_unexpected_el2_exception();
+	__kvm_unexpected_el2_exception();
 }
-- 
2.37.0.rc0.161.g10f37bed90-goog

