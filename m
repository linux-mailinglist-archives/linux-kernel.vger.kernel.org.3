Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 152EF4CDE8E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 21:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbiCDUQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 15:16:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbiCDUPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 15:15:35 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82C9323A63
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 12:11:27 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id v5so7345441qkj.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 12:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VGU3lDVBq59QqjYsyRxQH4/VHY2UtoMa8BpyGMZ/FLo=;
        b=ogou+8r1Nf1Cv1Sqo2avgI+ufHZcUQqdvKyABGfz/Jgc+M/SCWUFQ0E9dIfKtMXMSR
         2NCi9Iv5Kpn5fzA3h8CIk/bNHWE8Pd3sJFOVKnlj7MJz78TxbTRnE5g4Mcc+97U5oUKg
         YsSPgos3H5hG5PVLOeekfix7+oR8CaU/8TXW+4p6m9nrW0hwiLMccODAxdIO5ktxqlRZ
         bq+2ViShK8qFFgqxSRwbWKq9b342rrny35pRQuSHIYK6CthnEhj/yd246vKtmYptSbkn
         jGrrst+bhQetTjyhauFJIwklZA6Do1cl2pH1QzrR0SQexPffkJrEqVl0xMQN+lqPhZUb
         C3rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VGU3lDVBq59QqjYsyRxQH4/VHY2UtoMa8BpyGMZ/FLo=;
        b=IPO23NBjbsi8WFOJYQSPHIjuEjrmww+kfZ5PveNs5aGCtNg1c7T6uBjI/BOXe8D1MM
         gqlbLrnN5IwjNq4GAH64lDMYyVeUugfTLC+yhozXiyoq24ToJIqoIek/D1/wtp9nVAKe
         Ig6A7nQ8KKhMnU3OeXSyHZ9AF4JX7KopnFmZ1N8z+pV7wcmN5xxPIsAl/S7+a64A3Yxi
         knPbVo7Ez7A6F8LZ2Ou08y5kYV3oz/wpdeeuI2mSHi0F40o30jjBo3HlOrTsM+WbGiXl
         Fx3zVVcWsST/XCAMevXZZGFFtI4vqc3C51Z+NC6mx+JmW0lwYU+JuYQ8e1N7ASmVfx2w
         CYMQ==
X-Gm-Message-State: AOAM533ln9jggleQEtiIKVLM9bhLWhv+JcX6f0u2dIyJtqkYScryVi3r
        vTQEkIugfxHfqXw4OPvwX17HkRXkCedLHQ==
X-Google-Smtp-Source: ABdhPJziAT+GkcoKPwD8VK1mQG+Q81feZ7J2fFcV4cs55xPUicqo70tLtaLMRp0qMRbF9AiUkgGugw==
X-Received: by 2002:a37:c06:0:b0:49b:7a31:cd54 with SMTP id 6-20020a370c06000000b0049b7a31cd54mr230310qkm.358.1646424647390;
        Fri, 04 Mar 2022 12:10:47 -0800 (PST)
Received: from rivos-atish.. (adsl-70-228-75-190.dsl.akrnoh.ameritech.net. [70.228.75.190])
        by smtp.gmail.com with ESMTPSA id 20-20020ac84e94000000b002de8f564305sm4605481qtp.1.2022.03.04.12.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 12:10:46 -0800 (PST)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atishp@rivosinc.com>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        devicetree@vger.kernel.org, Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [RFC PATCH v2 5/7] RISC-V: KVM: Restrict the extensions that can be disabled
Date:   Fri,  4 Mar 2022 12:10:18 -0800
Message-Id: <20220304201020.810380-6-atishp@rivosinc.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220304201020.810380-1-atishp@rivosinc.com>
References: <20220304201020.810380-1-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the config reg register allows to disable all allowed
single letter ISA extensions. It shouldn't be the case as vmm
shouldn't be able disable base extensions (imac).
These extensions should always be enabled as long as they are enabled
in the host ISA.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/kvm/vcpu.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
index 3ae545e7b398..388e83857ced 100644
--- a/arch/riscv/kvm/vcpu.c
+++ b/arch/riscv/kvm/vcpu.c
@@ -38,12 +38,16 @@ const struct kvm_stats_header kvm_vcpu_stats_header = {
 		       sizeof(kvm_vcpu_stats_desc),
 };
 
-#define KVM_RISCV_ISA_ALLOWED	(riscv_isa_extension_mask(a) | \
-				 riscv_isa_extension_mask(c) | \
-				 riscv_isa_extension_mask(d) | \
-				 riscv_isa_extension_mask(f) | \
-				 riscv_isa_extension_mask(i) | \
-				 riscv_isa_extension_mask(m))
+#define KVM_RISCV_ISA_DISABLE_ALLOWED	(riscv_isa_extension_mask(d) | \
+					riscv_isa_extension_mask(f))
+
+#define KVM_RISCV_ISA_DISABLE_NOT_ALLOWED	(riscv_isa_extension_mask(a) | \
+						riscv_isa_extension_mask(c) | \
+						riscv_isa_extension_mask(i) | \
+						riscv_isa_extension_mask(m))
+
+#define KVM_RISCV_ISA_ALLOWED (KVM_RISCV_ISA_DISABLE_ALLOWED | \
+			       KVM_RISCV_ISA_DISABLE_NOT_ALLOWED)
 
 static void kvm_riscv_reset_vcpu(struct kvm_vcpu *vcpu)
 {
@@ -217,9 +221,10 @@ static int kvm_riscv_vcpu_set_reg_config(struct kvm_vcpu *vcpu,
 	switch (reg_num) {
 	case KVM_REG_RISCV_CONFIG_REG(isa):
 		if (!vcpu->arch.ran_atleast_once) {
-			vcpu->arch.isa = reg_val;
+			/* Ignore the disable request for these extensions */
+			vcpu->arch.isa = reg_val | KVM_RISCV_ISA_DISABLE_NOT_ALLOWED;
 			vcpu->arch.isa &= riscv_isa_extension_base(NULL);
-			vcpu->arch.isa &= KVM_RISCV_ISA_ALLOWED;
+			vcpu->arch.isa &= KVM_RISCV_ISA_DISABLE_ALLOWED;
 			kvm_riscv_vcpu_fp_reset(vcpu);
 		} else {
 			return -EOPNOTSUPP;
-- 
2.30.2

