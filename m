Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28779599D51
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 16:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349411AbiHSODL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 10:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349098AbiHSOC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 10:02:59 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E22100F14
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 07:02:58 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id x21so5797905edd.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 07:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=LcgnJW6ojeblPsIc6aD4dBYb9kEDQlJtOgpSlsoKicM=;
        b=F80xmYw+kiDUqtNmrzbNRu3AMt+mM4KWjQ42y9dE39l2VAObAeVzJz7WOy3CaH+xqJ
         HjQFKbjRP8H95Cvp1amKY4+bgkO+Q8ezZA+n36ktinonyBVDGWqseyAiMkVn3ZjlVSRU
         OP2ZTa5gEjM4qkWsbUpzVjW7WPsIyZVoo3CpxIG5oJTwBzb5T6HbH9MiPSERJmZ4gJc7
         nGydDtHDyOQLS8xuX35EzecVSa5Ps8oRsWygtCnzFyt08+Zft1JWq+rS+91NapwOe8Cb
         mw+eaxgcOx7tSnsIWtEuxjnhXC+7Mm7R7XTz9ra9Cq/hWcYlAy/buYnqh9byFUMouQ9T
         a3kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=LcgnJW6ojeblPsIc6aD4dBYb9kEDQlJtOgpSlsoKicM=;
        b=RxyELB+v1EcWOaMVdGuQsY7vaX5j6wCW4kOTqx4BgyMmdZoE//Vjzmg5LaPwP2Xkmd
         UDN+ptBbd7fnRqtmm7xJko+wcmaOvRjAEqU3mmboe0KJbTSHrbI2+9SIKxr2yUzXGcGt
         rxBjHajmKMZvjMGVziSdX+rcXishEbJFKkuOD2PKs/g89DyaYxGXJywkInkxlY923VWW
         Hmljuu5mn3SvbYh9Y4+8v+NGR77Luh5ZRkQByqP+1i8mwmcsuq2TM0Ygzbc1fQvLODC2
         zXZGDn+8re4ffl7LB8wBr6Ek4NsMv6Ve4z5HPIkYa6LFjKvEwAYlwWcQxSSyucH20UNg
         girg==
X-Gm-Message-State: ACgBeo1KDRuE0BHIMYfkzyQGsDhs+cK0XB8iX2FyN2xLI2eRq+j6DCyA
        tyQLvvo78clKf5TDv3ZJmFJCHA==
X-Google-Smtp-Source: AA6agR4EFqr57fc4jUDyesvyg8veXZkmFiKZWBlvKiMpyMHLIIftipgiufj4xlvJJhTBKrr1NYctcg==
X-Received: by 2002:aa7:d513:0:b0:43d:5c81:4f71 with SMTP id y19-20020aa7d513000000b0043d5c814f71mr6235776edq.308.1660917778037;
        Fri, 19 Aug 2022 07:02:58 -0700 (PDT)
Received: from localhost (cst2-173-67.cust.vodafone.cz. [31.30.173.67])
        by smtp.gmail.com with ESMTPSA id p4-20020a17090653c400b0073bdb2f6f28sm2271393ejo.217.2022.08.19.07.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 07:02:57 -0700 (PDT)
From:   Andrew Jones <ajones@ventanamicro.com>
To:     linux-riscv@lists.infradead.org, kvm-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, anup@brainfault.org,
        mchitale@ventanamicro.com, heiko@sntech.de
Subject: [PATCH 4/4] riscv: KVM: Apply insn-def to hlv encodings
Date:   Fri, 19 Aug 2022 16:02:50 +0200
Message-Id: <20220819140250.3892995-5-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220819140250.3892995-1-ajones@ventanamicro.com>
References: <20220819140250.3892995-1-ajones@ventanamicro.com>
MIME-Version: 1.0
Content-type: text/plain
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

Introduce hlv instruction encodings and apply them to KVM's use.
We're careful not to introduce hlv.d to 32-bit builds. Indeed,
we ensure the build fails if someone tries to use it.

Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/include/asm/insn-def.h | 14 ++++++++++++++
 arch/riscv/kvm/vcpu_exit.c        | 29 +++++------------------------
 2 files changed, 19 insertions(+), 24 deletions(-)

diff --git a/arch/riscv/include/asm/insn-def.h b/arch/riscv/include/asm/insn-def.h
index cd1c0d365f47..c66d5745c5b4 100644
--- a/arch/riscv/include/asm/insn-def.h
+++ b/arch/riscv/include/asm/insn-def.h
@@ -87,4 +87,18 @@
 #define HFENCE_GVMA(gaddr, vmid)	\
 	INSN_R(OPCODE_SYSTEM, FUNC3(0), FUNC7(49), RD(0), gaddr, vmid)
 
+#define HLVX_HU(dest, addr)	\
+	INSN_R(OPCODE_SYSTEM, FUNC3(4), FUNC7(50), dest, addr, RS2(3))
+
+#define HLV_W(dest, addr)	\
+	INSN_R(OPCODE_SYSTEM, FUNC3(4), FUNC7(52), dest, addr, RS2(0))
+
+#ifdef CONFIG_64BIT
+#define HLV_D(dest, addr)	\
+	INSN_R(OPCODE_SYSTEM, FUNC3(4), FUNC7(54), dest, addr, RS2(0))
+#else
+#define HLV_D(dest, addr)	\
+	__ASM_STR(.error "hlv.d requires 64-bit support")
+#endif
+
 #endif /* __ASM_INSN_DEF_H */
diff --git a/arch/riscv/kvm/vcpu_exit.c b/arch/riscv/kvm/vcpu_exit.c
index d5c36386878a..9cb075e72799 100644
--- a/arch/riscv/kvm/vcpu_exit.c
+++ b/arch/riscv/kvm/vcpu_exit.c
@@ -8,6 +8,7 @@
 
 #include <linux/kvm_host.h>
 #include <asm/csr.h>
+#include <asm/insn-def.h>
 
 static int gstage_page_fault(struct kvm_vcpu *vcpu, struct kvm_run *run,
 			     struct kvm_cpu_trap *trap)
@@ -82,22 +83,12 @@ unsigned long kvm_riscv_vcpu_unpriv_read(struct kvm_vcpu *vcpu,
 			".option push\n"
 			".option norvc\n"
 			"add %[ttmp], %[taddr], 0\n"
-			/*
-			 * HLVX.HU %[val], (%[addr])
-			 * HLVX.HU t0, (t2)
-			 * 0110010 00011 00111 100 00101 1110011
-			 */
-			".word 0x6433c2f3\n"
+			HLVX_HU("%[val]", "%[addr]")
 			"andi %[tmp], %[val], 3\n"
 			"addi %[tmp], %[tmp], -3\n"
 			"bne %[tmp], zero, 2f\n"
 			"addi %[addr], %[addr], 2\n"
-			/*
-			 * HLVX.HU %[tmp], (%[addr])
-			 * HLVX.HU t1, (t2)
-			 * 0110010 00011 00111 100 00110 1110011
-			 */
-			".word 0x6433c373\n"
+			HLVX_HU("%[tmp]", "%[addr]")
 			"sll %[tmp], %[tmp], 16\n"
 			"add %[val], %[val], %[tmp]\n"
 			"2:\n"
@@ -121,19 +112,9 @@ unsigned long kvm_riscv_vcpu_unpriv_read(struct kvm_vcpu *vcpu,
 			".option norvc\n"
 			"add %[ttmp], %[taddr], 0\n"
 #ifdef CONFIG_64BIT
-			/*
-			 * HLV.D %[val], (%[addr])
-			 * HLV.D t0, (t2)
-			 * 0110110 00000 00111 100 00101 1110011
-			 */
-			".word 0x6c03c2f3\n"
+			HLV_D("%[val]", "%[addr]")
 #else
-			/*
-			 * HLV.W %[val], (%[addr])
-			 * HLV.W t0, (t2)
-			 * 0110100 00000 00111 100 00101 1110011
-			 */
-			".word 0x6803c2f3\n"
+			HLV_W("%[val]", "%[addr]")
 #endif
 			".option pop"
 		: [val] "=&r" (val),
-- 
2.37.1

