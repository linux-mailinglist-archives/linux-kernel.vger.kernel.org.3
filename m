Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E329557EAE7
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 02:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237039AbiGWAy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 20:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237037AbiGWAxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 20:53:22 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19948C1DF8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 17:52:32 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id l6-20020a25bf86000000b00668c915a3f2so4768143ybk.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 17:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=iNidL5t3APu7KPx6x2AfmNcK6Gvmn9B++/Fwc0Sb5RU=;
        b=CpXe5BAYVMXS27JFgFQwxTrHUZ25kMD88IWo8FWkEHN1dllaPHhyYki1UJIVV/A43U
         NZPe5Ag886po3sZTKm35rsu8ILeZRiWvA80b3SS3R5S/vUCmGfQ1IuJSnAgJTSYw2VgU
         QjydX7sOS6kAd3TULu6wTWluz2ZOrx19/A1onVREHk//+UHeJOpzfn7B5CBQHWBgsqYF
         4qirmGgP+bK8oO6ZfQ8bzzIF3KeHFnIBqdJ85i3CR/R0QYizLFj4p/bGGZp68vlBIssM
         xldRiQF9z8lx2IlHHsLz0XWJH/QudIm2GWn/RztEt68uaOGSgijPFSLTXr1vU52VfR/j
         npbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=iNidL5t3APu7KPx6x2AfmNcK6Gvmn9B++/Fwc0Sb5RU=;
        b=KFBZmLvKWw7jmQ4cAR0cIjkncLHHxJTxVHflf09ZA22mj9Ov0JMeOxAKzoSXLNWTBX
         3emJpwWoJOZn2hugZAsAdAeVvAoI2bDbidM73oA5tXT6zQyy/OFmnkoxsaYPAry2yxov
         Fa0BqMG3iIC1/ipiWr5Gx58xVynbrrUJzD70npE4RyK0TBlQ1isXRZVa7QpRAKZ2scbz
         jR7kU6R5i/edFM31EGAzGCoifMwcoXC7TWIjXcpjnI6cHO33C+pVd2N46yOEheDWOjUH
         dB4yMkfAoP9d8Lj/EKQtPhoCe3MbztZouRk0yAXexZ1K1hAHfF82sS+mCGV3ndW3gZF8
         Ydwg==
X-Gm-Message-State: AJIora/yJfTqkM4GXKA9TlG+gT87pGBw4NPbeX/IaDeB7OCBypTBhTel
        1kkYnKLf+YhlNrvKz1yogH4Eik1RKDk=
X-Google-Smtp-Source: AGRyM1vySDwE6Gvlodkq7FF1qcIENLkcMWrn40MsXgK66bhooD5J8AhouK2hcmn3uEoFR1HA3LtGtxEeE74=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:69c3:0:b0:31e:8481:21f5 with SMTP id
 e186-20020a8169c3000000b0031e848121f5mr2088956ywc.63.1658537538665; Fri, 22
 Jul 2022 17:52:18 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Sat, 23 Jul 2022 00:51:36 +0000
In-Reply-To: <20220723005137.1649592-1-seanjc@google.com>
Message-Id: <20220723005137.1649592-24-seanjc@google.com>
Mime-Version: 1.0
References: <20220723005137.1649592-1-seanjc@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v4 23/24] KVM: selftests: Use uapi header to get VMX and SVM
 exit reasons/codes
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Oliver Upton <oupton@google.com>,
        Peter Shier <pshier@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include the vmx.h and svm.h uapi headers that KVM so kindly provides
instead of manually defining all the same exit reasons/code.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 .../selftests/kvm/include/x86_64/svm_util.h   |  7 +--
 .../selftests/kvm/include/x86_64/vmx.h        | 51 +------------------
 2 files changed, 4 insertions(+), 54 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/svm_util.h b/tools/testing/selftests/kvm/include/x86_64/svm_util.h
index a339b537a575..7aee6244ab6a 100644
--- a/tools/testing/selftests/kvm/include/x86_64/svm_util.h
+++ b/tools/testing/selftests/kvm/include/x86_64/svm_util.h
@@ -9,15 +9,12 @@
 #ifndef SELFTEST_KVM_SVM_UTILS_H
 #define SELFTEST_KVM_SVM_UTILS_H
 
+#include <asm/svm.h>
+
 #include <stdint.h>
 #include "svm.h"
 #include "processor.h"
 
-#define SVM_EXIT_EXCP_BASE	0x040
-#define SVM_EXIT_HLT		0x078
-#define SVM_EXIT_MSR		0x07c
-#define SVM_EXIT_VMMCALL	0x081
-
 struct svm_test_data {
 	/* VMCB */
 	struct vmcb *vmcb; /* gva */
diff --git a/tools/testing/selftests/kvm/include/x86_64/vmx.h b/tools/testing/selftests/kvm/include/x86_64/vmx.h
index 99fa1410964c..e4206f69b716 100644
--- a/tools/testing/selftests/kvm/include/x86_64/vmx.h
+++ b/tools/testing/selftests/kvm/include/x86_64/vmx.h
@@ -8,6 +8,8 @@
 #ifndef SELFTEST_KVM_VMX_H
 #define SELFTEST_KVM_VMX_H
 
+#include <asm/vmx.h>
+
 #include <stdint.h>
 #include "processor.h"
 #include "apic.h"
@@ -100,55 +102,6 @@
 #define VMX_EPT_VPID_CAP_AD_BITS		0x00200000
 
 #define EXIT_REASON_FAILED_VMENTRY	0x80000000
-#define EXIT_REASON_EXCEPTION_NMI	0
-#define EXIT_REASON_EXTERNAL_INTERRUPT	1
-#define EXIT_REASON_TRIPLE_FAULT	2
-#define EXIT_REASON_INTERRUPT_WINDOW	7
-#define EXIT_REASON_NMI_WINDOW		8
-#define EXIT_REASON_TASK_SWITCH		9
-#define EXIT_REASON_CPUID		10
-#define EXIT_REASON_HLT			12
-#define EXIT_REASON_INVD		13
-#define EXIT_REASON_INVLPG		14
-#define EXIT_REASON_RDPMC		15
-#define EXIT_REASON_RDTSC		16
-#define EXIT_REASON_VMCALL		18
-#define EXIT_REASON_VMCLEAR		19
-#define EXIT_REASON_VMLAUNCH		20
-#define EXIT_REASON_VMPTRLD		21
-#define EXIT_REASON_VMPTRST		22
-#define EXIT_REASON_VMREAD		23
-#define EXIT_REASON_VMRESUME		24
-#define EXIT_REASON_VMWRITE		25
-#define EXIT_REASON_VMOFF		26
-#define EXIT_REASON_VMON		27
-#define EXIT_REASON_CR_ACCESS		28
-#define EXIT_REASON_DR_ACCESS		29
-#define EXIT_REASON_IO_INSTRUCTION	30
-#define EXIT_REASON_MSR_READ		31
-#define EXIT_REASON_MSR_WRITE		32
-#define EXIT_REASON_INVALID_STATE	33
-#define EXIT_REASON_MWAIT_INSTRUCTION	36
-#define EXIT_REASON_MONITOR_INSTRUCTION 39
-#define EXIT_REASON_PAUSE_INSTRUCTION	40
-#define EXIT_REASON_MCE_DURING_VMENTRY	41
-#define EXIT_REASON_TPR_BELOW_THRESHOLD 43
-#define EXIT_REASON_APIC_ACCESS		44
-#define EXIT_REASON_EOI_INDUCED		45
-#define EXIT_REASON_EPT_VIOLATION	48
-#define EXIT_REASON_EPT_MISCONFIG	49
-#define EXIT_REASON_INVEPT		50
-#define EXIT_REASON_RDTSCP		51
-#define EXIT_REASON_PREEMPTION_TIMER	52
-#define EXIT_REASON_INVVPID		53
-#define EXIT_REASON_WBINVD		54
-#define EXIT_REASON_XSETBV		55
-#define EXIT_REASON_APIC_WRITE		56
-#define EXIT_REASON_INVPCID		58
-#define EXIT_REASON_PML_FULL		62
-#define EXIT_REASON_XSAVES		63
-#define EXIT_REASON_XRSTORS		64
-#define LAST_EXIT_REASON		64
 
 enum vmcs_field {
 	VIRTUAL_PROCESSOR_ID		= 0x00000000,
-- 
2.37.1.359.gd136c6c3e2-goog

