Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 356665A844E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 19:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbiHaRZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 13:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbiHaRZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 13:25:13 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD69222B9
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 10:25:10 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id k9so19217941wri.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 10:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=j/4NmJqDbu56RZTur3QY16Eac2cEYz1FtNauBSCWCWQ=;
        b=Gctht5Adjh+JJvvaLgnzQD96KymRBCoBtTYden65aDTuXUNcFIftMzaaVSVgOk89Pt
         22s4yl//k+NA19/+1YDYlCoHsrexoj1YEfPZX0DeRQJbWRmmQBfNDg4hVwxfbLK6hcgJ
         OMHE+huBXyktCnI7fGjm509OYEZDKqxtmo17IC57fGzapx6OZiXEgXGy6kYCF/wgwhjE
         X+4VF0eHw9NiCuB/uXmrZl5t7qvakCQ1wABEikeyRBVGOBzMrLCzm2JN2b/VfUaFTQLn
         J+4Ncgj/w3zBgGdeSz9X9/gMCZulUlCXxryClGDTzn8UGmGxeS767ad2OuaUw0j1ByLu
         Ms5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=j/4NmJqDbu56RZTur3QY16Eac2cEYz1FtNauBSCWCWQ=;
        b=HJuKrLUW1cTIPJig8YvBefIqewwjw9olLt3ImPgAm7PZ8NV+dkcGzSYYs/By42dDAN
         3/rnWn29G9xbgwL0dzsGj+Hdbep42R15gNpjq9K95RAtipmxOjTlXbkTqachW8ooJDRJ
         XZiXwQn9PmvqpqiK1sBazS7TMr2VcpK6l7SbOqMSXzFOG5iLNqqJP6RuDEOvWxxdRrfG
         /6qTv4rjXqTBjPVN6z9cs+PyXOf7AAi1yhyAbXW0U0+m5G/YLPBj1MT1K7bLAVhzTWuP
         GV80aQuB4L/5m8nSk734NBRMwXdTcTVZRfMQ7pIbo8sU9bEG9vnQYLs2DBXWo4OIEieR
         kypw==
X-Gm-Message-State: ACgBeo1SNbeXENoAER+X2VV+89lYuaDLraJ43RnyshN2egG+i4SDo1Dy
        yM01A4x6m3jRMQO1zD4JUS9r1w==
X-Google-Smtp-Source: AA6agR6cPZwhir1oSL4FH+tlBFkccGiF2un2JQUTMvARQ3UEhDSAxmKc+ttgXP2sV/U7RLNiu1ekrg==
X-Received: by 2002:a5d:5941:0:b0:225:3fc3:d923 with SMTP id e1-20020a5d5941000000b002253fc3d923mr12309606wri.522.1661966708622;
        Wed, 31 Aug 2022 10:25:08 -0700 (PDT)
Received: from localhost (cst2-173-67.cust.vodafone.cz. [31.30.173.67])
        by smtp.gmail.com with ESMTPSA id ay21-20020a05600c1e1500b003a536d5aa2esm2838222wmb.11.2022.08.31.10.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 10:25:08 -0700 (PDT)
From:   Andrew Jones <ajones@ventanamicro.com>
To:     linux-riscv@lists.infradead.org, kvm-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, anup@brainfault.org,
        mchitale@ventanamicro.com, heiko@sntech.de
Subject: [PATCH v2 4/4] riscv: KVM: Apply insn-def to hlv encodings
Date:   Wed, 31 Aug 2022 19:25:00 +0200
Message-Id: <20220831172500.752195-5-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220831172500.752195-1-ajones@ventanamicro.com>
References: <20220831172500.752195-1-ajones@ventanamicro.com>
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
Reviewed-by: Anup Patel <anup@brainfault.org>
---
 arch/riscv/include/asm/insn-def.h | 17 +++++++++++++++++
 arch/riscv/kvm/vcpu_exit.c        | 29 +++++------------------------
 2 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/arch/riscv/include/asm/insn-def.h b/arch/riscv/include/asm/insn-def.h
index 86c1f602413b..8fe9036efb68 100644
--- a/arch/riscv/include/asm/insn-def.h
+++ b/arch/riscv/include/asm/insn-def.h
@@ -93,4 +93,21 @@
 	INSN_R(OPCODE_SYSTEM, FUNC3(0), FUNC7(49),		\
 	       __RD(0), RS1(gaddr), RS2(vmid))
 
+#define HLVX_HU(dest, addr)					\
+	INSN_R(OPCODE_SYSTEM, FUNC3(4), FUNC7(50),		\
+	       RD(dest), RS1(addr), __RS2(3))
+
+#define HLV_W(dest, addr)					\
+	INSN_R(OPCODE_SYSTEM, FUNC3(4), FUNC7(52),		\
+	       RD(dest), RS1(addr), __RS2(0))
+
+#ifdef CONFIG_64BIT
+#define HLV_D(dest, addr)					\
+	INSN_R(OPCODE_SYSTEM, FUNC3(4), FUNC7(54),		\
+	       RD(dest), RS1(addr), __RS2(0))
+#else
+#define HLV_D(dest, addr)	\
+	__ASM_STR(.error "hlv.d requires 64-bit support")
+#endif
+
 #endif /* __ASM_INSN_DEF_H */
diff --git a/arch/riscv/kvm/vcpu_exit.c b/arch/riscv/kvm/vcpu_exit.c
index d5c36386878a..da793f113a72 100644
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
+			HLVX_HU(%[val], %[addr])
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
+			HLVX_HU(%[tmp], %[addr])
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
+			HLV_D(%[val], %[addr])
 #else
-			/*
-			 * HLV.W %[val], (%[addr])
-			 * HLV.W t0, (t2)
-			 * 0110100 00000 00111 100 00101 1110011
-			 */
-			".word 0x6803c2f3\n"
+			HLV_W(%[val], %[addr])
 #endif
 			".option pop"
 		: [val] "=&r" (val),
-- 
2.37.2

