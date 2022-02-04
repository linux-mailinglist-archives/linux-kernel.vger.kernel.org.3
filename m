Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587474AA285
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 22:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346365AbiBDVnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 16:43:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244978AbiBDVmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 16:42:44 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BAF0C061765
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 13:42:26 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id ga20-20020a17090b039400b001b536800e04so4271860pjb.7
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 13:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=CNC4ms+cmGbCyYnugISdjsnBp4L8PCWiPQCO+rJ8ats=;
        b=lS3jTYUvoTOdh0kacXbHYLTKwLAMYvImBiKGwdA72qjKXtccFtq/QE9MDhA7oatrr/
         FQfKJZud2+d7Kgofpz3um7gTp1dZeJBdVZb+BBJyXtVDX6zmKM5BpypjkbTAew8V9tfV
         SxcqgvceQ+xjGzA1Oy9PzPaRkXo6YaLbsK2/sxIVkH7z0z47f0GizSL1YpaOoVOqlkcF
         j/U9SPIOeXJ6FHYAQhJfvK0h2uZehgHIrn0O8rzfF5SzMKpFu3vqxbmuKoBEDJAeDU5S
         UpWhaEo4GamyVEa+j0Fd/vasz4b8LQQrhmLHIL0LfwSHmpB8ch4tWVsZGHdsFLh3OLtl
         Ak7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=CNC4ms+cmGbCyYnugISdjsnBp4L8PCWiPQCO+rJ8ats=;
        b=JmoSes/+8beQbEnxhzzRX8rXtJiT+JpjJqe8hA9CvWRc1OBmcC3UdDYCgXkFgfQeen
         wjPoCtEHbpmYXNh/yZMrz+Xv2d20GYUDsj2shwKCmAqlQWTH7dqqwxxJhI64slR8FN+A
         8SywaOlFk+S7SnZC1rcyREo400VOQrMXizYpUofWx2CgWPYr+e9TUyKpqOyAgkAR5/kY
         KBAaKO5Xjdsaimm1x9rSqTw82vs/MofZTdTugxwhHlFBplCkUMEX8hWXuIYymTsvDxS/
         ZKEvABoYpFO2KUBzXbZxRv5eyLLq2ysO4HxfALdNGjW7HoFs4jRebYtMDI27d/e5Vgi8
         mwew==
X-Gm-Message-State: AOAM5310XfAOGyVKTjX9ky8pomIQDyhcP+xFPV/LEy6fpeKsgo2D9ytx
        jXaePe1eLzjr98g/ro0K8i3FUnSejUk=
X-Google-Smtp-Source: ABdhPJz28TUeCeBQDBB1pRTl6JKXzKJZkG+pqg5UukGC5LkjDPArPbqcgCoS5+2cnNYt4XjkBSpSSGu5Fqk=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:903:28c:: with SMTP id
 j12mr5025482plr.149.1644010945750; Fri, 04 Feb 2022 13:42:25 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  4 Feb 2022 21:42:05 +0000
In-Reply-To: <20220204214205.3306634-1-seanjc@google.com>
Message-Id: <20220204214205.3306634-12-seanjc@google.com>
Mime-Version: 1.0
References: <20220204214205.3306634-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH 11/11] KVM: selftests: Add test to verify KVM handles x2APIC
 ICR=>ICR2 dance
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zeng Guang <guang.zeng@intel.com>,
        Chao Gao <chao.gao@intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a selftest to verify that KVM copies x2APIC's ICR[63:32] to/from
ICR2 when userspace accesses the vAPIC page via KVM_{G,S}ET_LAPIC.  KVM
previously split x2APIC ICR to ICR+ICR2 at the time of write (from the
guest), and so KVM must preserve that behavior for backwards
compatibility between different versions of KVM.

Opportunsitically test other invariants, e.g. that KVM clears the BUSY
flag on ICR writes, that the reserved bits in ICR2 are dropped on writes
from the guest, etc...

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/.gitignore        |   1 +
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/include/x86_64/apic.h       |   1 +
 .../selftests/kvm/x86_64/xapic_state_test.c   | 150 ++++++++++++++++++
 4 files changed, 153 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86_64/xapic_state_test.c

diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
index dce7de7755e6..2b0e47f420b3 100644
--- a/tools/testing/selftests/kvm/.gitignore
+++ b/tools/testing/selftests/kvm/.gitignore
@@ -45,6 +45,7 @@
 /x86_64/vmx_tsc_adjust_test
 /x86_64/vmx_nested_tsc_scaling_test
 /x86_64/xapic_ipi_test
+/x86_64/xapic_state_test
 /x86_64/xen_shinfo_test
 /x86_64/xen_vmcall_test
 /x86_64/xss_msr_test
diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 0e4926bc9a58..4b5211afc6dc 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -76,6 +76,7 @@ TEST_GEN_PROGS_x86_64 += x86_64/vmx_set_nested_state_test
 TEST_GEN_PROGS_x86_64 += x86_64/vmx_tsc_adjust_test
 TEST_GEN_PROGS_x86_64 += x86_64/vmx_nested_tsc_scaling_test
 TEST_GEN_PROGS_x86_64 += x86_64/xapic_ipi_test
+TEST_GEN_PROGS_x86_64 += x86_64/xapic_state_test
 TEST_GEN_PROGS_x86_64 += x86_64/xss_msr_test
 TEST_GEN_PROGS_x86_64 += x86_64/debug_regs
 TEST_GEN_PROGS_x86_64 += x86_64/tsc_msrs_test
diff --git a/tools/testing/selftests/kvm/include/x86_64/apic.h b/tools/testing/selftests/kvm/include/x86_64/apic.h
index 0be4757f1f20..ac88557dcc9a 100644
--- a/tools/testing/selftests/kvm/include/x86_64/apic.h
+++ b/tools/testing/selftests/kvm/include/x86_64/apic.h
@@ -33,6 +33,7 @@
 #define	APIC_SPIV	0xF0
 #define		APIC_SPIV_FOCUS_DISABLED	(1 << 9)
 #define		APIC_SPIV_APIC_ENABLED		(1 << 8)
+#define APIC_IRR	0x200
 #define	APIC_ICR	0x300
 #define		APIC_DEST_SELF		0x40000
 #define		APIC_DEST_ALLINC	0x80000
diff --git a/tools/testing/selftests/kvm/x86_64/xapic_state_test.c b/tools/testing/selftests/kvm/x86_64/xapic_state_test.c
new file mode 100644
index 000000000000..0792334ba243
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86_64/xapic_state_test.c
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#define _GNU_SOURCE /* for program_invocation_short_name */
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+
+#include "apic.h"
+#include "kvm_util.h"
+#include "processor.h"
+#include "test_util.h"
+
+struct kvm_vcpu {
+	uint32_t id;
+	bool is_x2apic;
+};
+
+static void xapic_guest_code(void)
+{
+	asm volatile("cli");
+
+	xapic_enable();
+
+	while (1) {
+		uint64_t val = (u64)xapic_read_reg(APIC_IRR) |
+			       (u64)xapic_read_reg(APIC_IRR + 0x10) << 32;
+
+		xapic_write_reg(APIC_ICR2, val >> 32);
+		xapic_write_reg(APIC_ICR, val);
+		GUEST_SYNC(val);
+	}
+}
+
+static void x2apic_guest_code(void)
+{
+	asm volatile("cli");
+
+	x2apic_enable();
+
+	do {
+		uint64_t val = x2apic_read_reg(APIC_IRR) |
+			       x2apic_read_reg(APIC_IRR + 0x10) << 32;
+
+		x2apic_write_reg(APIC_ICR, val);
+		GUEST_SYNC(val);
+	} while (1);
+}
+
+static void ____test_icr(struct kvm_vm *vm, struct kvm_vcpu *vcpu, uint64_t val)
+{
+	struct kvm_lapic_state xapic;
+	struct ucall uc;
+	uint64_t icr;
+
+	/*
+	 * Tell the guest what ICR value to write.  Use the IRR to pass info,
+	 * all bits are valid and should not be modified by KVM (ignoring the
+	 * fact that vectors 0-15 are technically illegal).
+	 */
+	vcpu_ioctl(vm, vcpu->id, KVM_GET_LAPIC, &xapic);
+	*((u32 *)&xapic.regs[APIC_IRR]) = val;
+	*((u32 *)&xapic.regs[APIC_IRR + 0x10]) = val >> 32;
+	vcpu_ioctl(vm, vcpu->id, KVM_SET_LAPIC, &xapic);
+
+	vcpu_run(vm, vcpu->id);
+	ASSERT_EQ(get_ucall(vm, vcpu->id, &uc), UCALL_SYNC);
+	ASSERT_EQ(uc.args[1], val);
+
+	vcpu_ioctl(vm, vcpu->id, KVM_GET_LAPIC, &xapic);
+	icr = (u64)(*((u32 *)&xapic.regs[APIC_ICR])) |
+	      (u64)(*((u32 *)&xapic.regs[APIC_ICR2])) << 32;
+	if (!vcpu->is_x2apic)
+		val &= (-1u | (0xffull << (32 + 24)));
+	ASSERT_EQ(icr, val & ~APIC_ICR_BUSY);
+}
+
+static void __test_icr(struct kvm_vm *vm, struct kvm_vcpu *vcpu, uint64_t val)
+{
+	____test_icr(vm, vcpu, val | APIC_ICR_BUSY);
+	____test_icr(vm, vcpu, val & ~(u64)APIC_ICR_BUSY);
+}
+
+static void test_icr(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
+{
+	uint64_t icr, i, j;
+
+	icr = APIC_DEST_SELF | APIC_INT_ASSERT | APIC_DM_FIXED;
+	for (i = 0; i <= 0xff; i++)
+		__test_icr(vm, vcpu, icr | i);
+
+	icr = APIC_INT_ASSERT | APIC_DM_FIXED;
+	for (i = 0; i <= 0xff; i++)
+		__test_icr(vm, vcpu, icr | i);
+
+	/*
+	 * Send all flavors of IPIs to non-existent vCPUs.  TODO: use number of
+	 * vCPUs, not vcpu.id + 1.  Arbitrarily use vector 0xff.
+	 */
+	icr = APIC_INT_ASSERT | 0xff;
+	for (i = vcpu->id + 1; i < 0xff; i++) {
+		for (j = 0; j < 8; j++)
+			__test_icr(vm, vcpu, i << (32 + 24) | APIC_INT_ASSERT | (j << 8));
+	}
+
+	/* And again with a shorthand destination for all types of IPIs. */
+	icr = APIC_DEST_ALLBUT | APIC_INT_ASSERT;
+	for (i = 0; i < 8; i++)
+		__test_icr(vm, vcpu, icr | (i << 8));
+
+	/* And a few garbage value, just make sure it's an IRQ (blocked). */
+	__test_icr(vm, vcpu, 0xa5a5a5a5a5a5a5a5 & ~APIC_DM_FIXED_MASK);
+	__test_icr(vm, vcpu, 0x5a5a5a5a5a5a5a5a & ~APIC_DM_FIXED_MASK);
+	__test_icr(vm, vcpu, -1ull & ~APIC_DM_FIXED_MASK);
+}
+
+int main(int argc, char *argv[])
+{
+	struct kvm_vcpu vcpu = {
+		.id = 0,
+		.is_x2apic = true,
+	};
+	struct kvm_cpuid2 *cpuid;
+	struct kvm_vm *vm;
+	int i;
+
+	vm = vm_create_default(vcpu.id, 0, x2apic_guest_code);
+	test_icr(vm, &vcpu);
+	kvm_vm_free(vm);
+
+	/*
+	 * Use a second VM for the xAPIC test so that x2APIC can be hidden from
+	 * the guest in order to test AVIC.  KVM disallows changing CPUID after
+	 * KVM_RUN and AVIC is disabled if _any_ vCPU is allowed to use x2APIC.
+	 */
+	vm = vm_create_default(vcpu.id, 0, xapic_guest_code);
+	vcpu.is_x2apic = false;
+
+	cpuid = vcpu_get_cpuid(vm, vcpu.id);
+	for (i = 0; i < cpuid->nent; i++) {
+		if (cpuid->entries[i].function == 1)
+			break;
+	}
+	cpuid->entries[i].ecx &= ~BIT(21);
+	vcpu_set_cpuid(vm, vcpu.id, cpuid);
+
+	virt_pg_map(vm, APIC_DEFAULT_GPA, APIC_DEFAULT_GPA);
+	test_icr(vm, &vcpu);
+	kvm_vm_free(vm);
+}
-- 
2.35.0.263.gb82422642f-goog

