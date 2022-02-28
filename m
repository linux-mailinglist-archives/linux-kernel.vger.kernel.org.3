Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC0624C65DE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 10:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234444AbiB1Jnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 04:43:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234427AbiB1Jne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 04:43:34 -0500
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42368BF6E
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 01:42:50 -0800 (PST)
Received: by mail-oo1-xc2e.google.com with SMTP id j7-20020a4ad6c7000000b0031c690e4123so18150077oot.11
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 01:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OFx1LkRnyPSZoRPt++yRCZ/X7QAcbDXb7DbJRNFpb9w=;
        b=E/WAf0za9GRV++42YJoQEmv1RWq2LbVhjKreactOPjFdu6G631daU/9dPqnPLVnznt
         bCPt1pXZMtrMRJIMbxTHeVyRydO7cNrFhuYktKG/FE9DMUiPVA12wYyRxQ++M6on2BoY
         DteC19AIVn6jX9jfv5nHAPQmgPq5N+QIDpFqbxK0wczRdEZd0XLuxYwP9Ko1mO88TsA5
         ZuDp+MRF0MLr4nb9P9dxN0lqLo+B6ZqrWGNfvweHqem44F6PsgKg0XkVMcr5gstVSY6q
         cFwCu8x2HfVezTQ6JqnF0weCzK0oytliORDfkuUHSK/fN+sRqUbkpVDfbYiQd4X/ZykY
         lYwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OFx1LkRnyPSZoRPt++yRCZ/X7QAcbDXb7DbJRNFpb9w=;
        b=3pOqhDp9jMqnJKJWmZsUAwU+XWai8VStHrepY2BXwcTqiXsuGRAma11VMrDsnH5jC2
         887ynbv4mmHV3iIORRhsyxhyu8m2f49a5wdBCubU6/L1azbmWyaIUIiAi07TwmMP8UeD
         8wEjqrBuXtxZAxpYtlZtMZel6Z51C39JZoVTVin80CyHOUVrxbp8IwFJwQ4zeWgBNZj8
         SgxcjvM2n7BfYa3tdIgjzWIFTagD5bwYQBjYIJvDTaU3ZATzajKiDJnyTLpEp/5U5MHi
         l7dmmoh/6C0FYeZJGspDj0/+pfIERwSEEHZqPtjm7FAC0g8CAqDzTrTWLhIp+Gw5tjIL
         co7Q==
X-Gm-Message-State: AOAM530dW4qZGSvMavnrnZTWDcImmkOOG0MNUdgBrVXuVL5IzxSSlY+i
        aZYfyiIGAFN+lhwbI0Nfdo/BhqsbMwpe1w==
X-Google-Smtp-Source: ABdhPJzhIKtfZEIAafRI4JUqKJcTAu7eH4KpEJ6cvcqwvvcRPwCt5Hxo74efVrqx/IfP4dRTJdimiw==
X-Received: by 2002:a05:6870:b7b4:b0:d6:e56e:b85c with SMTP id ed52-20020a056870b7b400b000d6e56eb85cmr7507039oab.327.1646041369323;
        Mon, 28 Feb 2022 01:42:49 -0800 (PST)
Received: from rivos-atish.. (adsl-70-228-75-190.dsl.akrnoh.ameritech.net. [70.228.75.190])
        by smtp.gmail.com with ESMTPSA id bx10-20020a0568081b0a00b002d70da1ac54sm5936852oib.19.2022.02.28.01.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 01:42:48 -0800 (PST)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atishp@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        kvm-riscv@lists.infradead.org, Anup Patel <anup@brainfault.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        devicetree@vger.kernel.org, Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [RFC PATCH 4/6] RISC-V: Restrict the isa field in config register to base extensions
Date:   Mon, 28 Feb 2022 01:42:31 -0800
Message-Id: <20220228094234.3773153-5-atishp@rivosinc.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220228094234.3773153-1-atishp@rivosinc.com>
References: <20220228094234.3773153-1-atishp@rivosinc.com>
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

The isa field in config register is meant only for single letter base ISA
extensions. Multi-letter extensions can not be encoded here as it will
exceed the size of ULONG easily in future.

Only allow single letter extensions (0-25) to be encoded in that field.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/uapi/asm/kvm.h | 1 +
 arch/riscv/kvm/vcpu.c             | 6 ++++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
index f808ad1ce500..aa9f5a5c57d8 100644
--- a/arch/riscv/include/uapi/asm/kvm.h
+++ b/arch/riscv/include/uapi/asm/kvm.h
@@ -47,6 +47,7 @@ struct kvm_sregs {
 
 /* CONFIG registers for KVM_GET_ONE_REG and KVM_SET_ONE_REG */
 struct kvm_riscv_config {
+	/* This is a bitmap of all the single letter base ISA extensions */
 	unsigned long isa;
 };
 
diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
index 624166004e36..7a07dba504f8 100644
--- a/arch/riscv/kvm/vcpu.c
+++ b/arch/riscv/kvm/vcpu.c
@@ -182,13 +182,14 @@ static int kvm_riscv_vcpu_get_reg_config(struct kvm_vcpu *vcpu,
 					    KVM_REG_SIZE_MASK |
 					    KVM_REG_RISCV_CONFIG);
 	unsigned long reg_val;
+	unsigned long isa_mask = GENMASK(25, 0);
 
 	if (KVM_REG_SIZE(reg->id) != sizeof(unsigned long))
 		return -EINVAL;
 
 	switch (reg_num) {
 	case KVM_REG_RISCV_CONFIG_REG(isa):
-		reg_val = vcpu->arch.isa;
+		reg_val = vcpu->arch.isa & isa_mask;
 		break;
 	default:
 		return -EINVAL;
@@ -209,6 +210,7 @@ static int kvm_riscv_vcpu_set_reg_config(struct kvm_vcpu *vcpu,
 					    KVM_REG_SIZE_MASK |
 					    KVM_REG_RISCV_CONFIG);
 	unsigned long reg_val;
+	unsigned long isa_mask = GENMASK(25, 0);
 
 	if (KVM_REG_SIZE(reg->id) != sizeof(unsigned long))
 		return -EINVAL;
@@ -219,7 +221,7 @@ static int kvm_riscv_vcpu_set_reg_config(struct kvm_vcpu *vcpu,
 	switch (reg_num) {
 	case KVM_REG_RISCV_CONFIG_REG(isa):
 		if (!vcpu->arch.ran_atleast_once) {
-			vcpu->arch.isa = reg_val;
+			vcpu->arch.isa = reg_val & isa_mask;
 			vcpu->arch.isa &= riscv_isa_extension_base(NULL);
 			vcpu->arch.isa &= KVM_RISCV_ISA_ALLOWED;
 			kvm_riscv_vcpu_fp_reset(vcpu);
-- 
2.30.2

