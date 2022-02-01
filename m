Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59F204A5878
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 09:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235549AbiBAIYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 03:24:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235586AbiBAIYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 03:24:11 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D22C061741
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 00:24:11 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id k25so51273379ejp.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 00:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GHl1OHNEBsppykLL0FZwPbFOi9foYqykYD+EcFet6qM=;
        b=a7BBFEww46WyfPzbomNQG+Oqq2IlwS7J9fIC6wz4AdhnC7RyJpr/rJWZYYt2vAhObW
         iKEwMUG4feE/X4hSNAxQoRtiComrQv51VvEEYRla9+kWV86j1LQbU6kx+vhGqEd61/cy
         G2t3i2xZvnCqkVzIfZzQU2C62mnetTUKDAhzxiaYd34pcr2HvKXqAO0uOCOFqYacHePO
         vs923UsYq5I2ob+UgyHh5m1WF0yrD59QYadBvnneQAQcj857TlY7IXviNdvZDwFw7Noa
         sOmaqrashQAOt4ECeqnuo5hVWsTR85qX0g8Zx9Gh9fKZdbFMM1vrATkT2ORx5IRqOcsY
         mpJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GHl1OHNEBsppykLL0FZwPbFOi9foYqykYD+EcFet6qM=;
        b=qq4cUf09Htmo1laPCL3Pm5OiIGU5EubdRwOXPOM2K26nLV8Fl0V9bXEg2iY7RJjJb2
         U9wiG0W2w4b28Fd+F2ql1v4tNwHutJFp+AcVyNne8oL4oFgnx2hb3equbiHS/SIziUJQ
         T7QvJeoGYKz64yIVTP2r6HCcg/r/h49wDTUcAUJjhXxa9FoeoghTaRINcj8W1J0r0lz0
         /pz/w2gpJIvo2SyE8+KrEcz0s6yf1oqvcg9JC68ExQsOu9Thf4FO65nka502Fh4yJBPw
         MIJRMlK1d0LTKLTUN7bKQmvsQWcrG/RkvW+2t6pGR6n7wgaPTzIjT8claTdhiX/01+kR
         c+6A==
X-Gm-Message-State: AOAM532qZe2dzV2jz8pIXycsntMoqS6Teb2GJ0cI0T1aUS4MnnaBKRZc
        vccY5mvLXVR8F57u6JDOfn2A7Q==
X-Google-Smtp-Source: ABdhPJzCelwQYB0QuYOqiku+n7scTy7gUb/hHhHhs6GEaaroLB9AmfUKIaKTwSM1jvGPR/SYoABrkA==
X-Received: by 2002:a17:906:58c6:: with SMTP id e6mr19318243ejs.733.1643703849679;
        Tue, 01 Feb 2022 00:24:09 -0800 (PST)
Received: from localhost.localdomain ([122.179.76.38])
        by smtp.gmail.com with ESMTPSA id w8sm14312133ejq.220.2022.02.01.00.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 00:24:09 -0800 (PST)
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
Subject: [PATCH 6/6] RISC-V: KVM: Implement SBI HSM suspend call
Date:   Tue,  1 Feb 2022 13:52:27 +0530
Message-Id: <20220201082227.361967-7-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220201082227.361967-1-apatel@ventanamicro.com>
References: <20220201082227.361967-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SBI v0.3 specification extends SBI HSM extension by adding SBI HSM
suspend call and related HART states. This patch extends the KVM RISC-V
HSM implementation to provide KVM guest a minimal SBI HSM suspend call
which is equivalent to a WFI instruction.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/kvm/vcpu_sbi_hsm.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/riscv/kvm/vcpu_sbi_hsm.c b/arch/riscv/kvm/vcpu_sbi_hsm.c
index 1ac4b2e8e4ec..239dec0a628a 100644
--- a/arch/riscv/kvm/vcpu_sbi_hsm.c
+++ b/arch/riscv/kvm/vcpu_sbi_hsm.c
@@ -61,6 +61,8 @@ static int kvm_sbi_hsm_vcpu_get_status(struct kvm_vcpu *vcpu)
 		return -EINVAL;
 	if (!target_vcpu->arch.power_off)
 		return SBI_HSM_STATE_STARTED;
+	else if (vcpu->stat.generic.blocking)
+		return SBI_HSM_STATE_SUSPENDED;
 	else
 		return SBI_HSM_STATE_STOPPED;
 }
@@ -91,6 +93,18 @@ static int kvm_sbi_ext_hsm_handler(struct kvm_vcpu *vcpu, struct kvm_run *run,
 			ret = 0;
 		}
 		break;
+	case SBI_EXT_HSM_HART_SUSPEND:
+		switch (cp->a0) {
+		case SBI_HSM_SUSPEND_RET_DEFAULT:
+			kvm_riscv_vcpu_wfi(vcpu);
+			break;
+		case SBI_HSM_SUSPEND_NON_RET_DEFAULT:
+			ret = -EOPNOTSUPP;
+			break;
+		default:
+			ret = -EINVAL;
+		}
+		break;
 	default:
 		ret = -EOPNOTSUPP;
 	}
-- 
2.25.1

