Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4A244FDE3F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344536AbiDLL1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 07:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352819AbiDLLZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 07:25:42 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89CF2B1BE
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 03:08:35 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id o5-20020a17090ad20500b001ca8a1dc47aso2327379pju.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 03:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TPHPVEhymfv8oSdQwn6KZ7VGPONNXumfRuRVQxny474=;
        b=ZjcjKgTMmHHkgO/IqeBOUs/4V91uJO5cAnoFfwZcqQBWRdM1x4KzQIdkPWTuz8bEsK
         feTlunsl4JYlrvlr23mjh2z18M9kwNNH3XhmPEiqJZeP8LyDDqgGtMBuzvLuwFxX28gL
         xDFlsfpaL5UvYRq+zvzdmGLNmKF+bJVW2e/evZmzoH0Wxuu4QLKaJUzR/51eZF5Juny+
         M5la1s5esTCj0/GiWzDL5wIqLF4WVQ94Q7+t4Dr/m2wjxYFX31MQjO3eKpwFn5dmzO91
         Gi+X+HH4ABfSdlvOr1Kyq+tDAqsq/FuYVw3piPy1cdn4sjluJjkX22igFUSYX6qoCIxT
         tZ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TPHPVEhymfv8oSdQwn6KZ7VGPONNXumfRuRVQxny474=;
        b=BAKSsbygZ8K6KAkQDvE3qzFiT/NhY2ZjBOTwgx+lruuWdEfK6sRhbpwyCQOVogVrpX
         94eb/RNbsDPsCj6kR1iH0j+pxydpZZR/rdmLrrTuBBpFGRYwSetkR0ZMfsS5exjT8ztq
         44v9VEzmJsqadsg5LZhc6fc3x9nAWYebel6+9DIGL75iaaxlXTotDDqN6EuUtkEnh1Ai
         GxsI7CU6QR4oJZ4W4qe8rQyoc0MjVkPzjoQ8sMt/76ozv0yV3fuOZyepqVFSuLWvugLh
         5FYpfwyjq/IFTc1C4LCCpu4SKaS/fYkTep4WuyAtYJkW67Lwq9+jUIF77hwpZ2GGeF1v
         Wy5w==
X-Gm-Message-State: AOAM53205uVuk9Eg4O8zsDDKoXklhA75AF0ePXExP46EnVYjRhC5ndMK
        QDzAGX2MBMrWqvlJ6OWpWtfWyw==
X-Google-Smtp-Source: ABdhPJySjcKVeXxfT2LuJJZ9/EQNv5DqP9lc+SlW7FJiaLZVmsog51C0vqN5X/FzN69RtBMGMMpdFQ==
X-Received: by 2002:a17:90b:2790:b0:1cb:5cb5:f8ab with SMTP id pw16-20020a17090b279000b001cb5cb5f8abmr4132834pjb.190.1649758115322;
        Tue, 12 Apr 2022 03:08:35 -0700 (PDT)
Received: from localhost.localdomain ([122.182.197.47])
        by smtp.gmail.com with ESMTPSA id j9-20020a056a00130900b004f73df40914sm37515088pfu.82.2022.04.12.03.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 03:08:34 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 2/6] RISC-V: KVM: Add Sv57x4 mode support for G-stage
Date:   Tue, 12 Apr 2022 15:37:09 +0530
Message-Id: <20220412100713.1415094-3-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220412100713.1415094-1-apatel@ventanamicro.com>
References: <20220412100713.1415094-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Latest QEMU supports G-stage Sv57x4 mode so this patch extends KVM
RISC-V G-stage handling to detect and use Sv57x4 mode when available.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/include/asm/csr.h |  1 +
 arch/riscv/kvm/main.c        |  3 +++
 arch/riscv/kvm/mmu.c         | 11 ++++++++++-
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index e935f27b10fd..cc40521e438b 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -117,6 +117,7 @@
 #define HGATP_MODE_SV32X4	_AC(1, UL)
 #define HGATP_MODE_SV39X4	_AC(8, UL)
 #define HGATP_MODE_SV48X4	_AC(9, UL)
+#define HGATP_MODE_SV57X4	_AC(10, UL)
 
 #define HGATP32_MODE_SHIFT	31
 #define HGATP32_VMID_SHIFT	22
diff --git a/arch/riscv/kvm/main.c b/arch/riscv/kvm/main.c
index c374dad82eee..1549205fe5fe 100644
--- a/arch/riscv/kvm/main.c
+++ b/arch/riscv/kvm/main.c
@@ -105,6 +105,9 @@ int kvm_arch_init(void *opaque)
 	case HGATP_MODE_SV48X4:
 		str = "Sv48x4";
 		break;
+	case HGATP_MODE_SV57X4:
+		str = "Sv57x4";
+		break;
 	default:
 		return -ENODEV;
 	}
diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
index dc0520792e31..8823eb32dcde 100644
--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -751,14 +751,23 @@ void kvm_riscv_gstage_update_hgatp(struct kvm_vcpu *vcpu)
 void kvm_riscv_gstage_mode_detect(void)
 {
 #ifdef CONFIG_64BIT
+	/* Try Sv57x4 G-stage mode */
+	csr_write(CSR_HGATP, HGATP_MODE_SV57X4 << HGATP_MODE_SHIFT);
+	if ((csr_read(CSR_HGATP) >> HGATP_MODE_SHIFT) == HGATP_MODE_SV57X4) {
+		gstage_mode = (HGATP_MODE_SV57X4 << HGATP_MODE_SHIFT);
+		gstage_pgd_levels = 5;
+		goto skip_sv48x4_test;
+	}
+
 	/* Try Sv48x4 G-stage mode */
 	csr_write(CSR_HGATP, HGATP_MODE_SV48X4 << HGATP_MODE_SHIFT);
 	if ((csr_read(CSR_HGATP) >> HGATP_MODE_SHIFT) == HGATP_MODE_SV48X4) {
 		gstage_mode = (HGATP_MODE_SV48X4 << HGATP_MODE_SHIFT);
 		gstage_pgd_levels = 4;
 	}
-	csr_write(CSR_HGATP, 0);
+skip_sv48x4_test:
 
+	csr_write(CSR_HGATP, 0);
 	__kvm_riscv_hfence_gvma_all();
 #endif
 }
-- 
2.25.1

