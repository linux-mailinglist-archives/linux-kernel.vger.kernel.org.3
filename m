Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A112C4A41F8
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 12:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358961AbiAaLHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 06:07:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359040AbiAaLEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 06:04:16 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F73AC061762
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 03:03:25 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id m4so41919149ejb.9
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 03:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sK8JR4wpkvls27MNU4s8AnmC/+c6q6h3rMPNEZP9Prw=;
        b=kV2WIOTc9oeQLWaV5sGXLC5+V2MEcy/nFB1aBE7UYHZknUJxEqn2H0ruaImw1LSudd
         YBNzrjQWd/WX2Hwg40tGHGWkbqDBoouxh0A/Ayeb9CepJhcdoHJDOuEDKwUofDr3YDeM
         hypgPlPu6mQinAPkGCyMdCsKQFU1fjATndvTJhEYqTY98McJfIDfjY9+HkzOqsVitBdG
         Xqq2dS+6YDzqE1kx/SWP4oOd8ZWxeaWizxmD8bzbtJrPZjZL0RU+y2OTYfMbjmhvmp3z
         8k476frHL7MmRK5tcQZCY+9vUWimfJMI8mN1upj5vNfqM0LhYOiHXz53dPIBVr83Q+i+
         5dZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sK8JR4wpkvls27MNU4s8AnmC/+c6q6h3rMPNEZP9Prw=;
        b=3AV2Wdtt14W0dOwQ0/6nBg3mw8vnKcVIUcjzrgl0jG+uKqw4iffA+qUH8KubBd9oQA
         fxFCT8r1mTBWGNEUX/zp8XifTMH4RnSuVvffwpYpk4qg2pMW5h6gYfu42Stoj6xo5Lfi
         936FpijiHtkIx6BuZ+66pTeZX8EAIyYICktRgOTkxl5j+9i8s/7CE1iFlq2kapNsOq09
         qRpdCuGdoMWff0lnrbcU47eMmb/GCY0FMOKUQQhjQ392Fd3Fd1EJo6a5lMMpD77AmSXm
         mqJfvziOpxKXkEiwLhrGVGuHlf92yhfh0Uor/pyndU1hI0Au+xeQm8ERHI2bQNmieFJn
         yPXA==
X-Gm-Message-State: AOAM532WZIKlUdtw4pAD173cmTiXQmjrhV/+0wMoRdwLSlvbrMi4cJoW
        k47Z8RvffGgi8JocMdWFIGe1CA==
X-Google-Smtp-Source: ABdhPJwJd++NGD5qapxySFts1jFknGVNB3DUXPDIe+XtkytAhXK38pCvvhgrbKuKdHAxqBOBaLUB0w==
X-Received: by 2002:a17:907:1b0f:: with SMTP id mp15mr16717542ejc.493.1643627003918;
        Mon, 31 Jan 2022 03:03:23 -0800 (PST)
Received: from platform-PowerEdge-T440.dc1.ventanamicro.com ([117.248.109.221])
        by smtp.gmail.com with ESMTPSA id b7sm14338971edv.58.2022.01.31.03.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 03:03:23 -0800 (PST)
From:   Mayuresh Chitale <mchitale@ventanamicro.com>
To:     anup@brainfault.org
Cc:     atishp@atishpatra.org, palmer@dabbelt.com,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Mayuresh Chitale <mchitale@ventanamicro.com>
Subject: [PATCH] RISC-V: KVM: make CY, TM, and IR counters accessible in VU mode
Date:   Mon, 31 Jan 2022 16:33:07 +0530
Message-Id: <20220131110307.1684739-1-mchitale@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Those applications that run in VU mode and access the time CSR cause
a virtual instruction trap as Guest kernel currently does not
initialize the scounteren CSR.
 
To fix this, we should make CY, TM, and IR counters accessibile
by default in VU mode (similar to OpenSBI).

Fixes: a33c72faf2d73 ("RISC-V: KVM: Implement VCPU create, init and
destroy functions")
Cc:stable@vger.kernel.org
Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
---
 arch/riscv/kvm/vcpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
index 0c5239e05721..caaf824347b9 100644
--- a/arch/riscv/kvm/vcpu.c
+++ b/arch/riscv/kvm/vcpu.c
@@ -90,6 +90,7 @@ int kvm_arch_vcpu_precreate(struct kvm *kvm, unsigned int id)
 int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 {
 	struct kvm_cpu_context *cntx;
+	struct kvm_vcpu_csr *reset_csr = &vcpu->arch.guest_reset_csr;
 
 	/* Mark this VCPU never ran */
 	vcpu->arch.ran_atleast_once = false;
@@ -106,6 +107,9 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 	cntx->hstatus |= HSTATUS_SPVP;
 	cntx->hstatus |= HSTATUS_SPV;
 
+	/* By default, make CY, TM, and IR counters accessible in VU mode */
+	reset_csr->scounteren=0x7;
+
 	/* Setup VCPU timer */
 	kvm_riscv_vcpu_timer_init(vcpu);
 
-- 
2.25.1

