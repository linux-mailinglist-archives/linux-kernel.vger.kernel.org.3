Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9278E5A70A7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 00:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbiH3WVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 18:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbiH3WVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 18:21:08 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A9B61D80
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 15:20:26 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id y21-20020a056a001c9500b0053817f57e8dso3317204pfw.6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 15:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=DuyfC69i2OMiSbHTPcw/27B1qgcnYyIWftYisyD6nW0=;
        b=dtazo0Jod0alN8kOX/Wvf4oqimm+UjA9lpCOaevAhUcab0kjuhjNKNvP/PcgFpAp7R
         POn5YpMjv+n4Tg9a6bXeEm297lTYF2PoEjG7xBzS9qHB5DnR/gY8oO3+FGmJF/4dJJUN
         MtL/CpKNS5OTm66QU16pFanQDbguYR4TlknvcVAvWVuENScXV4RH784UXWkqoPHFUEMW
         hPLLKTAaF6Qm/Em1LBJIECpQkvyloywGf9eFsDcjMaTF1QRBQUk9YxWJ/4UjlGZ3ViEe
         spVsVb5BOhpDOOfBvvP2ou3Ynoyovelels5MaTc5eGNWNFnGKk8BxAahixARrespjyNl
         kMtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=DuyfC69i2OMiSbHTPcw/27B1qgcnYyIWftYisyD6nW0=;
        b=AMoOKkoHJDVo0L/DgLgjyrKMZZggyMOwXWRMmjPIE6V2qusv6AVLk/UfF0wme9BA96
         xO4pRbOaIrIE4VbahPecCJW3wCRjESpif742qqrZdodimyhBgl4GbELoyxuFz/En2jpD
         cBOLx71Pjsx9LM2f90284cKUllEz7tSqMLwqPcA4+EFyeOnOoA/QKWG6Z1Y/jPyEuQUV
         fp0n5n46wKzf5j6J1jTBfjvBrw4VqVfoTrgOanh+fdhHxGvSfmXIXs+/JgmeBOaZTxIJ
         7SE2T2dxHNzMDMwcRnb++EGyUaDaWo1+T6/DpKP07OUYXGcXLjgvhrWN/i9Rvapmf/TJ
         3Jwg==
X-Gm-Message-State: ACgBeo24arS6rWTPVWIrA/HcGcHOYeJpNay0AUw1QwPWoXPlqEyvTduf
        p0DcrhnpGjcmWrBTu2MJ2gVTVfS44w==
X-Google-Smtp-Source: AA6agR5Cvo6pmJ9dCM7qTMudSGq7bZQddkeaa+H5ytT2CwJ8GCWxD9HIqhxgpXFTE/KP+c8Lsl01EWbR3A==
X-Received: from sagi.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:241b])
 (user=sagis job=sendgmr) by 2002:a05:6a00:1309:b0:535:d421:1347 with SMTP id
 j9-20020a056a00130900b00535d4211347mr23761516pfu.5.1661898025004; Tue, 30 Aug
 2022 15:20:25 -0700 (PDT)
Date:   Tue, 30 Aug 2022 22:19:54 +0000
In-Reply-To: <20220830222000.709028-1-sagis@google.com>
Mime-Version: 1.0
References: <20220830222000.709028-1-sagis@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220830222000.709028-12-sagis@google.com>
Subject: [RFC PATCH v2 11/17] KVM: selftest: TDX: Add TDX HLT exit test
From:   Sagi Shahar <sagis@google.com>
To:     linux-kselftest@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Sagi Shahar <sagis@google.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Ryan Afranji <afranji@google.com>,
        Roger Wang <runanwang@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        Marc Zyngier <maz@kernel.org>, Ben Gardon <bgardon@google.com>,
        Jim Mattson <jmattson@google.com>,
        David Matlack <dmatlack@google.com>,
        Peter Xu <peterx@redhat.com>, Oliver Upton <oupton@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Yang Zhong <yang.zhong@intel.com>,
        Wei Wang <wei.w.wang@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Peter Gonda <pgonda@google.com>, Marc Orr <marcorr@google.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Eric Auger <eric.auger@redhat.com>,
        Yanan Wang <wangyanan55@huawei.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Peter Shier <pshier@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Zhenzhong Duan <zhenzhong.duan@intel.com>,
        "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>,
        Like Xu <like.xu@linux.intel.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The test verifies that the guest runs TDVMCALL<INSTRUCTION.HLT> and the
guest vCPU enters to the halted state.

Signed-off-by: Erdem Aktas <erdemaktas@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
---
 tools/testing/selftests/kvm/lib/x86_64/tdx.h  | 16 ++++
 .../selftests/kvm/x86_64/tdx_vm_tests.c       | 88 +++++++++++++++++++
 2 files changed, 104 insertions(+)

diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx.h b/tools/testing/selftests/kvm/lib/x86_64/tdx.h
index 263834979727..b11200028546 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/tdx.h
+++ b/tools/testing/selftests/kvm/lib/x86_64/tdx.h
@@ -56,6 +56,7 @@
 
 #define TDX_GET_TD_VM_CALL_INFO 0x10000
 #define TDX_REPORT_FATAL_ERROR 0x10003
+#define TDX_INSTRUCTION_HLT 12
 #define TDX_INSTRUCTION_IO 30
 #define TDX_INSTRUCTION_RDMSR 31
 #define TDX_INSTRUCTION_WRMSR 32
@@ -292,6 +293,21 @@ static inline uint64_t tdvmcall_wrmsr(uint64_t index, uint64_t value)
 	return regs.r10;
 }
 
+/*
+ * Execute HLT instruction.
+ */
+static inline uint64_t tdvmcall_hlt(uint64_t interrupt_blocked_flag)
+{
+	struct kvm_regs regs;
+
+	memset(&regs, 0, sizeof(regs));
+	regs.r11 = TDX_INSTRUCTION_HLT;
+	regs.r12 = interrupt_blocked_flag;
+	regs.rcx = 0x1C00;
+	tdcall(&regs);
+	return regs.r10;
+}
+
 /*
  * Reports a 32 bit value from the guest to user space using a TDVM IO call.
  * Data is reported on port TDX_DATA_REPORT_PORT.
diff --git a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
index fb3b8de7e5cd..39604aac54bd 100644
--- a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
+++ b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
@@ -883,6 +883,93 @@ void verify_guest_msr_writes(void)
 	printf("\t ... PASSED\n");
 }
 
+/*
+ * Verifies HLT functionality.
+ */
+TDX_GUEST_FUNCTION(guest_hlt)
+{
+	uint64_t ret;
+	uint64_t interrupt_blocked_flag;
+
+	interrupt_blocked_flag = 0;
+	ret = tdvmcall_hlt(interrupt_blocked_flag);
+	if (ret)
+		tdvmcall_fatal(ret);
+
+	tdvmcall_success();
+}
+
+void _verify_guest_hlt(int signum);
+
+void wake_me(int interval)
+{
+	struct sigaction action;
+
+	action.sa_handler = _verify_guest_hlt;
+	sigemptyset(&action.sa_mask);
+	action.sa_flags = 0;
+
+	TEST_ASSERT(sigaction(SIGALRM, &action, NULL) == 0,
+		    "Could not set the alarm handler!");
+
+	alarm(interval);
+}
+
+void _verify_guest_hlt(int signum)
+{
+	static struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+
+	/*
+	 * This function will also be called by SIGALRM handler to check the
+	 * vCPU MP State. If vm has been initialized, then we are in the signal
+	 * handler. Check the MP state and let the guest run again.
+	 */
+	if (vcpu != NULL) {
+		struct kvm_mp_state mp_state;
+
+		vcpu_mp_state_get(vcpu, &mp_state);
+		ASSERT_EQ(mp_state.mp_state, KVM_MP_STATE_HALTED);
+
+		/* Let the guest to run and finish the test.*/
+		mp_state.mp_state = KVM_MP_STATE_RUNNABLE;
+		vcpu_mp_state_set(vcpu, &mp_state);
+		return;
+	}
+
+	printf("Verifying HLT:\n");
+
+	/* Create a TD VM with no memory.*/
+	vm = vm_create_tdx();
+
+	/* Allocate TD guest memory and initialize the TD.*/
+	initialize_td(vm);
+
+	/* Initialize the TD vcpu and copy the test code to the guest memory.*/
+	vcpu = vm_vcpu_add_tdx(vm, 0);
+
+	/* Setup and initialize VM memory */
+	prepare_source_image(vm, guest_hlt,
+			     TDX_FUNCTION_SIZE(guest_hlt), 0);
+	finalize_td_memory(vm);
+
+	printf("\t ... Running guest\n");
+
+	/* Wait 1 second for guest to execute HLT */
+	wake_me(1);
+	vcpu_run(vcpu);
+
+	CHECK_GUEST_COMPLETION(vcpu);
+
+	kvm_vm_free(vm);
+	printf("\t ... PASSED\n");
+}
+
+void verify_guest_hlt(void)
+{
+	_verify_guest_hlt(0);
+}
+
 int main(int argc, char **argv)
 {
 	if (!is_tdx_enabled()) {
@@ -899,6 +986,7 @@ int main(int argc, char **argv)
 	run_in_new_process(&verify_guest_reads);
 	run_in_new_process(&verify_guest_msr_reads);
 	run_in_new_process(&verify_guest_msr_writes);
+	run_in_new_process(&verify_guest_hlt);
 
 	return 0;
 }
-- 
2.37.2.789.g6183377224-goog

