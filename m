Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C401E4A5870
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 09:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235450AbiBAIXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 03:23:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235084AbiBAIXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 03:23:49 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452D3C061741
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 00:23:49 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id c24so32819421edy.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 00:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sWXOnh6V8JfeAKPCTBsP63fO+aHlS1gzo9x3i/6GE6E=;
        b=ALK239EPhhbKnBQAarVre2qSAgyqxLhsur30HkoKRHTo2K0etUwzSjub/fA46wqZ3v
         sffzujqr51nXRa0RVA/w900IKQe/5K2nW2xeUvbM3z5HVB5Mww8SVdM9ksqaIsHamZ4F
         DxgZjgkJQCPX8kyilf7tT711OgwoPLhiSVk70Dcjegj9YfCfMh5+JLK84AHcj/z+mk94
         Q0Hg4lUV4uGHlNIDmfMxJXAFgtaX3aHORO9Ip6O6ajm47HWzYDDWL2+FO8poRRpKctLj
         zc3YsSLYUvtQSpoVIGfsG/Au+zCgQDvl5B09DcBGKkJVMPlAooidYwHY9OA4Affd9kMD
         TlyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sWXOnh6V8JfeAKPCTBsP63fO+aHlS1gzo9x3i/6GE6E=;
        b=cRGysEqHfHSV3W9Eoh2VYTwd9hzlAosxJU/mYH3P/T4GzeMAT/Ud9ih63qza5L048r
         0TRS5cDDYU4Lid32R0PFXxCW1xQVkH4WCFBqH9JcvFopQ2nID7K0a+m/5FFD3UjT60a4
         jqGxODJvLFpiSUGEYkZShUDQaflBvO4/1BFq0WlAeX+qZRCB4fRcGWQJI6QdXB4LQNsb
         J6MsKzJfxsp30S0pDASK7F+Kd7n/N99sFketaEE3hFsiNIuLvM/ToVtj+1oz4gxhjWvo
         frm7ji7OO7QrKSNKNip1fHYK+DhioAAGWw6+/vAbnF82QBiDqkzL5EonC3UcB5ePvrYo
         77yg==
X-Gm-Message-State: AOAM530JTS57UONWtNaWl2NcStvNcRb1hM49BuOytDet381nkQ7Zgi8H
        zMdbxV901cd7pLB/Qee3Zx1J1A==
X-Google-Smtp-Source: ABdhPJzTHSniruOqGDVxhjoRjtvl1bsig8Zp56bbyZf9II8QjmoSPgsxbdftBMPgMX53XpxqtcWBeQ==
X-Received: by 2002:aa7:d553:: with SMTP id u19mr24595529edr.298.1643703827873;
        Tue, 01 Feb 2022 00:23:47 -0800 (PST)
Received: from localhost.localdomain ([122.179.76.38])
        by smtp.gmail.com with ESMTPSA id w8sm14312133ejq.220.2022.02.01.00.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 00:23:47 -0800 (PST)
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
Subject: [PATCH 2/6] RISC-V: KVM: Add common kvm_riscv_vcpu_sbi_system_reset() function
Date:   Tue,  1 Feb 2022 13:52:23 +0530
Message-Id: <20220201082227.361967-3-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220201082227.361967-1-apatel@ventanamicro.com>
References: <20220201082227.361967-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We rename kvm_sbi_system_shutdown() to kvm_riscv_vcpu_sbi_system_reset()
and move it to vcpu_sbi.c so that it can be shared by SBI v0.1 shutdown
and SBI v0.3 SRST extension.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/include/asm/kvm_vcpu_sbi.h |  3 +++
 arch/riscv/kvm/vcpu_sbi.c             | 17 +++++++++++++++++
 arch/riscv/kvm/vcpu_sbi_v01.c         | 18 ++----------------
 3 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/arch/riscv/include/asm/kvm_vcpu_sbi.h b/arch/riscv/include/asm/kvm_vcpu_sbi.h
index 04cd81f2ab5b..83d6d4d2b1df 100644
--- a/arch/riscv/include/asm/kvm_vcpu_sbi.h
+++ b/arch/riscv/include/asm/kvm_vcpu_sbi.h
@@ -28,6 +28,9 @@ struct kvm_vcpu_sbi_extension {
 };
 
 void kvm_riscv_vcpu_sbi_forward(struct kvm_vcpu *vcpu, struct kvm_run *run);
+void kvm_riscv_vcpu_sbi_system_reset(struct kvm_vcpu *vcpu,
+				     struct kvm_run *run,
+				     u32 type, u64 flags);
 const struct kvm_vcpu_sbi_extension *kvm_vcpu_sbi_find_ext(unsigned long extid);
 
 #endif /* __RISCV_KVM_VCPU_SBI_H__ */
diff --git a/arch/riscv/kvm/vcpu_sbi.c b/arch/riscv/kvm/vcpu_sbi.c
index 78aa3db76225..11ae4f621f0d 100644
--- a/arch/riscv/kvm/vcpu_sbi.c
+++ b/arch/riscv/kvm/vcpu_sbi.c
@@ -79,6 +79,23 @@ void kvm_riscv_vcpu_sbi_forward(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	run->riscv_sbi.ret[1] = cp->a1;
 }
 
+void kvm_riscv_vcpu_sbi_system_reset(struct kvm_vcpu *vcpu,
+				     struct kvm_run *run,
+				     u32 type, u64 flags)
+{
+	unsigned long i;
+	struct kvm_vcpu *tmp;
+
+	kvm_for_each_vcpu(i, tmp, vcpu->kvm)
+		tmp->arch.power_off = true;
+	kvm_make_all_cpus_request(vcpu->kvm, KVM_REQ_SLEEP);
+
+	memset(&run->system_event, 0, sizeof(run->system_event));
+	run->system_event.type = type;
+	run->system_event.flags = flags;
+	run->exit_reason = KVM_EXIT_SYSTEM_EVENT;
+}
+
 int kvm_riscv_vcpu_sbi_return(struct kvm_vcpu *vcpu, struct kvm_run *run)
 {
 	struct kvm_cpu_context *cp = &vcpu->arch.guest_context;
diff --git a/arch/riscv/kvm/vcpu_sbi_v01.c b/arch/riscv/kvm/vcpu_sbi_v01.c
index 2ab52b6d9ed3..da4d6c99c2cf 100644
--- a/arch/riscv/kvm/vcpu_sbi_v01.c
+++ b/arch/riscv/kvm/vcpu_sbi_v01.c
@@ -14,21 +14,6 @@
 #include <asm/kvm_vcpu_timer.h>
 #include <asm/kvm_vcpu_sbi.h>
 
-static void kvm_sbi_system_shutdown(struct kvm_vcpu *vcpu,
-				    struct kvm_run *run, u32 type)
-{
-	unsigned long i;
-	struct kvm_vcpu *tmp;
-
-	kvm_for_each_vcpu(i, tmp, vcpu->kvm)
-		tmp->arch.power_off = true;
-	kvm_make_all_cpus_request(vcpu->kvm, KVM_REQ_SLEEP);
-
-	memset(&run->system_event, 0, sizeof(run->system_event));
-	run->system_event.type = type;
-	run->exit_reason = KVM_EXIT_SYSTEM_EVENT;
-}
-
 static int kvm_sbi_ext_v01_handler(struct kvm_vcpu *vcpu, struct kvm_run *run,
 				      unsigned long *out_val,
 				      struct kvm_cpu_trap *utrap,
@@ -80,7 +65,8 @@ static int kvm_sbi_ext_v01_handler(struct kvm_vcpu *vcpu, struct kvm_run *run,
 		}
 		break;
 	case SBI_EXT_0_1_SHUTDOWN:
-		kvm_sbi_system_shutdown(vcpu, run, KVM_SYSTEM_EVENT_SHUTDOWN);
+		kvm_riscv_vcpu_sbi_system_reset(vcpu, run,
+						KVM_SYSTEM_EVENT_SHUTDOWN, 0);
 		*exit = true;
 		break;
 	case SBI_EXT_0_1_REMOTE_FENCE_I:
-- 
2.25.1

