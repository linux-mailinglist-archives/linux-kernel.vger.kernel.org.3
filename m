Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05FC74A5875
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 09:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235503AbiBAIYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 03:24:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235487AbiBAIYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 03:24:00 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC42C06173D
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 00:24:00 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id d10so51624236eje.10
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 00:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zwd/8cqd/uyZjzuw2VQObQyskOR01to1ElscGOXTIT4=;
        b=eC4DiGIz7XiaA9N2mXQL7I9xjW9v59lcMo3xOM1zS2qqTt/VkyB+tuaweSHrA5kejn
         5RU1BDgKui2WEL+B2hxVm1uW7QYKdSwgtNyoXUAMRjAKUd4dZ40F+QJQOFFybxqyq8vj
         2dg4BMMDM9vVVSpON2vnjF6NN/QnuJg/Bh2JYpa+cF1HLxl2nRkF8ylog15N/wqvvMGt
         EjvaWUF7iui9SmZVdHL4VFa3LeHay3Y2Fk7rHK8a9nTLxvSQ4pOhVSvOMms4Y6JcCHNr
         T+15e7UQ3Usi38CmXaVnBjrFS4wbDNAAZzku4LCT7OLl7seLooxbJWmh7HSVGaUkWiuq
         uxgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zwd/8cqd/uyZjzuw2VQObQyskOR01to1ElscGOXTIT4=;
        b=WaxLCznKjXhIejNKzN8aenHRZJLy/PwEMhJDXyP8y1Gtm0zGH45fMSlDEO+9DtrmQa
         R495EIDEXqgXljw9q4T/F8KwN+qB2HulztnVQxF4ikyi/ZHPgqIZgXyoTO5nqQAXw+Ga
         N/Eftn4jqUPIPZinR4t/jkaGfDwQWdZCX0yFZ+M4ye+m+8xIYa06llBEjYXaElFR7i7k
         ZZ/9WZ20Ai0/9VOXUUFFP8lBzQfs46HcK9l5MP67gPhh/LftBcXMwyszCuHnNMZytyfc
         /TBD/4Yn/X+G/XU7kuf6UlBj06KG3Pb+6eGdDQ54N70rQFbSd2qw3ClDmhIaB26PQw+9
         29wQ==
X-Gm-Message-State: AOAM530J2qKlTWuV97DKU2hfs3PMpi6hVNeuOVEcCU/mJD9Cjr51hYHc
        7pKku2XTpxZSmLQ6kyqjMHuh9Q==
X-Google-Smtp-Source: ABdhPJy31giTDwE4wqN8u2biPEhaGB3Em2a9I6VCEGluXT0OlIBYWCHXDm+THh+U/KZhqQ92c9Ew+Q==
X-Received: by 2002:a17:907:6ea0:: with SMTP id sh32mr21034992ejc.460.1643703838800;
        Tue, 01 Feb 2022 00:23:58 -0800 (PST)
Received: from localhost.localdomain ([122.179.76.38])
        by smtp.gmail.com with ESMTPSA id w8sm14312133ejq.220.2022.02.01.00.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 00:23:58 -0800 (PST)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 4/6] RISC-V: Add SBI HSM suspend related defines
Date:   Tue,  1 Feb 2022 13:52:25 +0530
Message-Id: <20220201082227.361967-5-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220201082227.361967-1-apatel@ventanamicro.com>
References: <20220201082227.361967-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We add defines related to SBI HSM suspend call and also update HSM states
naming as-per the latest SBI specification.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/include/asm/sbi.h    | 27 ++++++++++++++++++++++-----
 arch/riscv/kernel/cpu_ops_sbi.c |  2 +-
 arch/riscv/kvm/vcpu_sbi_hsm.c   |  4 ++--
 3 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index d1c37479d828..06133b4f8e20 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -71,15 +71,32 @@ enum sbi_ext_hsm_fid {
 	SBI_EXT_HSM_HART_START = 0,
 	SBI_EXT_HSM_HART_STOP,
 	SBI_EXT_HSM_HART_STATUS,
+	SBI_EXT_HSM_HART_SUSPEND,
 };
 
-enum sbi_hsm_hart_status {
-	SBI_HSM_HART_STATUS_STARTED = 0,
-	SBI_HSM_HART_STATUS_STOPPED,
-	SBI_HSM_HART_STATUS_START_PENDING,
-	SBI_HSM_HART_STATUS_STOP_PENDING,
+enum sbi_hsm_hart_state {
+	SBI_HSM_STATE_STARTED = 0,
+	SBI_HSM_STATE_STOPPED,
+	SBI_HSM_STATE_START_PENDING,
+	SBI_HSM_STATE_STOP_PENDING,
+	SBI_HSM_STATE_SUSPENDED,
+	SBI_HSM_STATE_SUSPEND_PENDING,
+	SBI_HSM_STATE_RESUME_PENDING,
 };
 
+#define SBI_HSM_SUSP_BASE_MASK			0x7fffffff
+#define SBI_HSM_SUSP_NON_RET_BIT		0x80000000
+#define SBI_HSM_SUSP_PLAT_BASE			0x10000000
+
+#define SBI_HSM_SUSPEND_RET_DEFAULT		0x00000000
+#define SBI_HSM_SUSPEND_RET_PLATFORM		SBI_HSM_SUSP_PLAT_BASE
+#define SBI_HSM_SUSPEND_RET_LAST		SBI_HSM_SUSP_BASE_MASK
+#define SBI_HSM_SUSPEND_NON_RET_DEFAULT		SBI_HSM_SUSP_NON_RET_BIT
+#define SBI_HSM_SUSPEND_NON_RET_PLATFORM	(SBI_HSM_SUSP_NON_RET_BIT | \
+						 SBI_HSM_SUSP_PLAT_BASE)
+#define SBI_HSM_SUSPEND_NON_RET_LAST		(SBI_HSM_SUSP_NON_RET_BIT | \
+						 SBI_HSM_SUSP_BASE_MASK)
+
 enum sbi_ext_srst_fid {
 	SBI_EXT_SRST_RESET = 0,
 };
diff --git a/arch/riscv/kernel/cpu_ops_sbi.c b/arch/riscv/kernel/cpu_ops_sbi.c
index dae29cbfe550..2e16f6732cdf 100644
--- a/arch/riscv/kernel/cpu_ops_sbi.c
+++ b/arch/riscv/kernel/cpu_ops_sbi.c
@@ -111,7 +111,7 @@ static int sbi_cpu_is_stopped(unsigned int cpuid)
 
 	rc = sbi_hsm_hart_get_status(hartid);
 
-	if (rc == SBI_HSM_HART_STATUS_STOPPED)
+	if (rc == SBI_HSM_STATE_STOPPED)
 		return 0;
 	return rc;
 }
diff --git a/arch/riscv/kvm/vcpu_sbi_hsm.c b/arch/riscv/kvm/vcpu_sbi_hsm.c
index 2e383687fa48..1ac4b2e8e4ec 100644
--- a/arch/riscv/kvm/vcpu_sbi_hsm.c
+++ b/arch/riscv/kvm/vcpu_sbi_hsm.c
@@ -60,9 +60,9 @@ static int kvm_sbi_hsm_vcpu_get_status(struct kvm_vcpu *vcpu)
 	if (!target_vcpu)
 		return -EINVAL;
 	if (!target_vcpu->arch.power_off)
-		return SBI_HSM_HART_STATUS_STARTED;
+		return SBI_HSM_STATE_STARTED;
 	else
-		return SBI_HSM_HART_STATUS_STOPPED;
+		return SBI_HSM_STATE_STOPPED;
 }
 
 static int kvm_sbi_ext_hsm_handler(struct kvm_vcpu *vcpu, struct kvm_run *run,
-- 
2.25.1

