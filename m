Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 675C14F846F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 17:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345553AbiDGQAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 12:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345286AbiDGQAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 12:00:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C2A7ED598C
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 08:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649347091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=126nTNRXhHFrXixY2xtOW/3ENn+8ieWmJUoTJhv6R28=;
        b=SUtjhqPLXNLbdnAw+s5jP/tz+mLrtppsTOPaghLiFn78k1q6dukiBSM1o85JWvtzigDQp0
        Pvl51VZpePgrzuxWUV2AGqckVAaRgpPiw3NSaOwcwhWTutIEBNB7NoXxRW9z5w+OA7wTky
        Or1sE1HgGr4+Bl/5moT8ORV2u/HYM50=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-423-TzbyqX8ZMu-4qEp7NddPgw-1; Thu, 07 Apr 2022 11:58:06 -0400
X-MC-Unique: TzbyqX8ZMu-4qEp7NddPgw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DB14F8037A4;
        Thu,  7 Apr 2022 15:58:04 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.40.192.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 32776428EE1;
        Thu,  7 Apr 2022 15:58:01 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 27/31] KVM: selftests: nSVM: Allocate Hyper-V partition assist and VP assist pages
Date:   Thu,  7 Apr 2022 17:56:41 +0200
Message-Id: <20220407155645.940890-28-vkuznets@redhat.com>
In-Reply-To: <20220407155645.940890-1-vkuznets@redhat.com>
References: <20220407155645.940890-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to testing Hyper-V Direct TLB flush hypercalls,
allocate VP assist and Partition assist pages and link them to 'struct
svm_test_data'.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 tools/testing/selftests/kvm/include/x86_64/svm_util.h | 10 ++++++++++
 tools/testing/selftests/kvm/lib/x86_64/svm.c          | 10 ++++++++++
 2 files changed, 20 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86_64/svm_util.h b/tools/testing/selftests/kvm/include/x86_64/svm_util.h
index a25aabd8f5e7..640859b58fd6 100644
--- a/tools/testing/selftests/kvm/include/x86_64/svm_util.h
+++ b/tools/testing/selftests/kvm/include/x86_64/svm_util.h
@@ -34,6 +34,16 @@ struct svm_test_data {
 	void *msr; /* gva */
 	void *msr_hva;
 	uint64_t msr_gpa;
+
+	/* Hyper-V VP assist page */
+	void *vp_assist; /* gva */
+	void *vp_assist_hva;
+	uint64_t vp_assist_gpa;
+
+	/* Hyper-V Partition assist page */
+	void *partition_assist; /* gva */
+	void *partition_assist_hva;
+	uint64_t partition_assist_gpa;
 };
 
 struct svm_test_data *vcpu_alloc_svm(struct kvm_vm *vm, vm_vaddr_t *p_svm_gva);
diff --git a/tools/testing/selftests/kvm/lib/x86_64/svm.c b/tools/testing/selftests/kvm/lib/x86_64/svm.c
index 736ee4a23df6..c284e8f87f5c 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/svm.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/svm.c
@@ -48,6 +48,16 @@ vcpu_alloc_svm(struct kvm_vm *vm, vm_vaddr_t *p_svm_gva)
 	svm->msr_gpa = addr_gva2gpa(vm, (uintptr_t)svm->msr);
 	memset(svm->msr_hva, 0, getpagesize());
 
+	svm->vp_assist = (void *)vm_vaddr_alloc_page(vm);
+	svm->vp_assist_hva = addr_gva2hva(vm, (uintptr_t)svm->vp_assist);
+	svm->vp_assist_gpa = addr_gva2gpa(vm, (uintptr_t)svm->vp_assist);
+	memset(svm->vp_assist_hva, 0, getpagesize());
+
+	svm->partition_assist = (void *)vm_vaddr_alloc_page(vm);
+	svm->partition_assist_hva = addr_gva2hva(vm, (uintptr_t)svm->partition_assist);
+	svm->partition_assist_gpa = addr_gva2gpa(vm, (uintptr_t)svm->partition_assist);
+	memset(svm->partition_assist_hva, 0, getpagesize());
+
 	*p_svm_gva = svm_gva;
 	return svm;
 }
-- 
2.35.1

