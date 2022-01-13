Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD8048D91F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 14:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235406AbiAMNhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 08:37:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:53974 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235357AbiAMNhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 08:37:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642081055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LOPDO9W1hQ4FhracZf+K1hP3MQZdQtyL8+btjyUNhB4=;
        b=c2HPCBK9wG1zZWHQEkG4DrTXDEoCB21JnfgMgug6bmCwZzipJati6VXAy5BrHyfreAb54n
        NB5ts8BaHeM3RrSTPDW3uoFCRf5umQcgQ+bsJU18rqCYYHXhlaJNyKMvYfoEVAOMPMo/Rg
        J49jfinMYgcC5bulhJXqW4c1Qb15ttY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-483-DoGkH1OXPpeA0eOM3UpJCw-1; Thu, 13 Jan 2022 08:37:32 -0500
X-MC-Unique: DoGkH1OXPpeA0eOM3UpJCw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 47C351017983;
        Thu, 13 Jan 2022 13:37:29 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.40.194.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0173884A22;
        Thu, 13 Jan 2022 13:37:26 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Igor Mammedov <imammedo@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] KVM: selftests: Rename 'get_cpuid_test' to 'cpuid_test'
Date:   Thu, 13 Jan 2022 14:37:02 +0100
Message-Id: <20220113133703.1976665-5-vkuznets@redhat.com>
In-Reply-To: <20220113133703.1976665-1-vkuznets@redhat.com>
References: <20220113133703.1976665-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to reusing the existing 'get_cpuid_test' for testing
"KVM_SET_CPUID{,2} after KVM_RUN" rename it to 'cpuid_test' to avoid
the confusion.

No functional change intended.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 tools/testing/selftests/kvm/.gitignore                       | 2 +-
 tools/testing/selftests/kvm/Makefile                         | 5 +++--
 .../selftests/kvm/x86_64/{get_cpuid_test.c => cpuid_test.c}  | 0
 3 files changed, 4 insertions(+), 3 deletions(-)
 rename tools/testing/selftests/kvm/x86_64/{get_cpuid_test.c => cpuid_test.c} (100%)

diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
index 3cb5ac5da087..289d4cc32d2f 100644
--- a/tools/testing/selftests/kvm/.gitignore
+++ b/tools/testing/selftests/kvm/.gitignore
@@ -7,11 +7,11 @@
 /s390x/memop
 /s390x/resets
 /s390x/sync_regs_test
+/x86_64/cpuid_test
 /x86_64/cr4_cpuid_sync_test
 /x86_64/debug_regs
 /x86_64/evmcs_test
 /x86_64/emulator_error_test
-/x86_64/get_cpuid_test
 /x86_64/get_msr_index_features
 /x86_64/kvm_clock_test
 /x86_64/kvm_pv_test
diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 17342b575e85..0ac99fa29dce 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -38,11 +38,12 @@ LIBKVM_x86_64 = lib/x86_64/apic.c lib/x86_64/processor.c lib/x86_64/vmx.c lib/x8
 LIBKVM_aarch64 = lib/aarch64/processor.c lib/aarch64/ucall.c lib/aarch64/handlers.S lib/aarch64/spinlock.c lib/aarch64/gic.c lib/aarch64/gic_v3.c lib/aarch64/vgic.c
 LIBKVM_s390x = lib/s390x/processor.c lib/s390x/ucall.c lib/s390x/diag318_test_handler.c
 
-TEST_GEN_PROGS_x86_64 = x86_64/cr4_cpuid_sync_test
+TEST_GEN_PROGS_x86_64 = x86_64/cpuid_test
+TEST_GEN_PROGS_x86_64 += x86_64/cr4_cpuid_sync_test
 TEST_GEN_PROGS_x86_64 += x86_64/get_msr_index_features
 TEST_GEN_PROGS_x86_64 += x86_64/evmcs_test
 TEST_GEN_PROGS_x86_64 += x86_64/emulator_error_test
-TEST_GEN_PROGS_x86_64 += x86_64/get_cpuid_test
+TEST_GEN_PROGS_x86_64 += x86_64/cpuid_test
 TEST_GEN_PROGS_x86_64 += x86_64/hyperv_clock
 TEST_GEN_PROGS_x86_64 += x86_64/hyperv_cpuid
 TEST_GEN_PROGS_x86_64 += x86_64/hyperv_features
diff --git a/tools/testing/selftests/kvm/x86_64/get_cpuid_test.c b/tools/testing/selftests/kvm/x86_64/cpuid_test.c
similarity index 100%
rename from tools/testing/selftests/kvm/x86_64/get_cpuid_test.c
rename to tools/testing/selftests/kvm/x86_64/cpuid_test.c
-- 
2.34.1

