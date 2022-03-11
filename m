Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F404D5B48
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 07:09:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346684AbiCKGAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 01:00:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346755AbiCKFzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:55:07 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E921DFDF90
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:53:36 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id 9-20020a630509000000b0037c8607d296so4215923pgf.22
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=fTRgciqd2oM8e2A4aufW48NTHgVD8bRTOiK4pDiyJUo=;
        b=m5bsNEazzsuwHW0xRT8haw7lzZuXLgZtmFN8xzebFO9bXazVKcIHIoMhymRPrAqpzc
         j63SRbaasMrPd17YcBx+/PJApTGKMTAKG/kDECofUmvTGUdsY3QHpFgt3HsaI+Ys4UqN
         AHDKFKEIQgQoBLPHqTh6BpD05E4HaT3EOIEGp5lvnrzEoYvypQW/TBTNhUoEYwyIkYqN
         JBP2HkuZMcFmAlKOLffXqk5sysRmpqn1dXiUatOGc8drmUnMKMaN24VpgxM1zGOVq/jn
         baTl9RtY0hJsz1jsU+sgIZwc5tL1z2SU6DqUtvCaqg+QwQDMTBs8MV2LoT/fi6WxI/n3
         gzGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=fTRgciqd2oM8e2A4aufW48NTHgVD8bRTOiK4pDiyJUo=;
        b=ctONNLreUPoEOICc9BrbvMX2uAcmiEA0eIY/8eHruiewGJ1VPZ+XShOzVuPUSjY0Bo
         Y1Gnx1H2AHCMZIqNWDff2GBGrgfukcvE7Jx2RJFcLQufUSBp8MzFpj9kxQjQAo+75HRB
         HDpzaIqk7Rf35G7c/8pdeh5xerJBEAP/iGPuoB+rplFsFUunHB34WOwGxCQ1HJvObwSz
         dqpR3uVBxcCbUWH5qXvJ3qWeEvBoSnzD4ldDvScbTBfjqZxsoqbdl8eCiUnNMZRyTgko
         GXTiPs2AUPOmjkdcfqnfTUm74nFFspepGO4xek33NPHNIyh7fv46RaBBMs9iqnpXFZEJ
         5mPQ==
X-Gm-Message-State: AOAM532kgctOCwD25mbXlFEPPDq4u3gvkJSYTt4kOOIc2S0JXihIq5hK
        8ov1TfhYm47PuMRkdC2qc+YSiufv5DqJNOxIp35iU4TTSqvJ/KvHzhTvJYeOwJ3YVb5W+JTr8Ln
        FJAs8TmP+gbnijW0XC0/5TScn7SbjxekTOjm64+uJWmQykzQYSqNNavq+ACq/lrZBqkfuYg==
X-Google-Smtp-Source: ABdhPJy6g9iYQAPZVUkq+vp5vislrXjLxDopYT4xNw13R0aEyl1eIeiW0c4oQdnjEZaYB+vz8vpfK+LH+QA=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:a8b:b0:4cd:6030:4df3 with SMTP id
 b11-20020a056a000a8b00b004cd60304df3mr8461343pfl.40.1646978016360; Thu, 10
 Mar 2022 21:53:36 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:50:40 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-90-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 089/105] KVM: selftests: Convert xapic_ipi_test away from *_VCPU_ID
From:   Sean Christopherson <seanjc@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/x86_64/xapic_ipi_test.c     | 48 ++++++++-----------
 1 file changed, 20 insertions(+), 28 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/xapic_ipi_test.c b/tools/testing/selftests/kvm/x86_64/xapic_ipi_test.c
index 8b366652be31..4484ee563b18 100644
--- a/tools/testing/selftests/kvm/x86_64/xapic_ipi_test.c
+++ b/tools/testing/selftests/kvm/x86_64/xapic_ipi_test.c
@@ -39,9 +39,6 @@
 /* Default delay between migrate_pages calls (microseconds) */
 #define DEFAULT_DELAY_USECS 500000
 
-#define HALTER_VCPU_ID 0
-#define SENDER_VCPU_ID 1
-
 /*
  * Vector for IPI from sender vCPU to halting vCPU.
  * Value is arbitrary and was chosen for the alternating bit pattern. Any
@@ -79,8 +76,7 @@ struct test_data_page {
 
 struct thread_params {
 	struct test_data_page *data;
-	struct kvm_vm *vm;
-	uint32_t vcpu_id;
+	struct kvm_vcpu *vcpu;
 	uint64_t *pipis_rcvd; /* host address of ipis_rcvd global */
 };
 
@@ -198,6 +194,7 @@ static void sender_guest_code(struct test_data_page *data)
 static void *vcpu_thread(void *arg)
 {
 	struct thread_params *params = (struct thread_params *)arg;
+	struct kvm_vcpu *vcpu = params->vcpu;
 	struct ucall uc;
 	int old;
 	int r;
@@ -206,17 +203,17 @@ static void *vcpu_thread(void *arg)
 	r = pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &old);
 	TEST_ASSERT(r == 0,
 		    "pthread_setcanceltype failed on vcpu_id=%u with errno=%d",
-		    params->vcpu_id, r);
+		    vcpu->id, r);
 
-	fprintf(stderr, "vCPU thread running vCPU %u\n", params->vcpu_id);
-	vcpu_run(params->vm, params->vcpu_id);
-	exit_reason = vcpu_state(params->vm, params->vcpu_id)->exit_reason;
+	fprintf(stderr, "vCPU thread running vCPU %u\n", vcpu->id);
+	vcpu_run(vcpu->vm, vcpu->id);
+	exit_reason = vcpu->run->exit_reason;
 
 	TEST_ASSERT(exit_reason == KVM_EXIT_IO,
 		    "vCPU %u exited with unexpected exit reason %u-%s, expected KVM_EXIT_IO",
-		    params->vcpu_id, exit_reason, exit_reason_str(exit_reason));
+		    vcpu->id, exit_reason, exit_reason_str(exit_reason));
 
-	if (get_ucall(params->vm, params->vcpu_id, &uc) == UCALL_ABORT) {
+	if (get_ucall(vcpu->vm, vcpu->id, &uc) == UCALL_ABORT) {
 		TEST_ASSERT(false,
 			    "vCPU %u exited with error: %s.\n"
 			    "Sending vCPU sent %lu IPIs to halting vCPU\n"
@@ -224,7 +221,7 @@ static void *vcpu_thread(void *arg)
 			    "Halter TPR=%#x PPR=%#x LVR=%#x\n"
 			    "Migrations attempted: %lu\n"
 			    "Migrations completed: %lu\n",
-			    params->vcpu_id, (const char *)uc.args[0],
+			    vcpu->id, (const char *)uc.args[0],
 			    params->data->ipis_sent, params->data->hlt_count,
 			    params->data->wake_count,
 			    *params->pipis_rcvd, params->data->halter_tpr,
@@ -236,7 +233,7 @@ static void *vcpu_thread(void *arg)
 	return NULL;
 }
 
-static void cancel_join_vcpu_thread(pthread_t thread, uint32_t vcpu_id)
+static void cancel_join_vcpu_thread(pthread_t thread, struct kvm_vcpu *vcpu)
 {
 	void *retval;
 	int r;
@@ -244,12 +241,12 @@ static void cancel_join_vcpu_thread(pthread_t thread, uint32_t vcpu_id)
 	r = pthread_cancel(thread);
 	TEST_ASSERT(r == 0,
 		    "pthread_cancel on vcpu_id=%d failed with errno=%d",
-		    vcpu_id, r);
+		    vcpu->id, r);
 
 	r = pthread_join(thread, &retval);
 	TEST_ASSERT(r == 0,
 		    "pthread_join on vcpu_id=%d failed with errno=%d",
-		    vcpu_id, r);
+		    vcpu->id, r);
 	TEST_ASSERT(retval == PTHREAD_CANCELED,
 		    "expected retval=%p, got %p", PTHREAD_CANCELED,
 		    retval);
@@ -415,34 +412,30 @@ int main(int argc, char *argv[])
 	if (delay_usecs <= 0)
 		delay_usecs = DEFAULT_DELAY_USECS;
 
-	vm = vm_create_default(HALTER_VCPU_ID, 0, halter_guest_code);
-	params[0].vm = vm;
-	params[1].vm = vm;
+	vm = vm_create_with_one_vcpu(&params[0].vcpu, halter_guest_code);
 
 	vm_init_descriptor_tables(vm);
-	vcpu_init_descriptor_tables(vm, HALTER_VCPU_ID);
+	vcpu_init_descriptor_tables(vm, params[0].vcpu->id);
 	vm_install_exception_handler(vm, IPI_VECTOR, guest_ipi_handler);
 
 	virt_pg_map(vm, APIC_DEFAULT_GPA, APIC_DEFAULT_GPA);
 
-	vm_vcpu_add(vm, SENDER_VCPU_ID, sender_guest_code);
+	params[1].vcpu = vm_vcpu_add(vm, 1, sender_guest_code);
 
 	test_data_page_vaddr = vm_vaddr_alloc_page(vm);
-	data =
-	   (struct test_data_page *)addr_gva2hva(vm, test_data_page_vaddr);
+	data = addr_gva2hva(vm, test_data_page_vaddr);
 	memset(data, 0, sizeof(*data));
 	params[0].data = data;
 	params[1].data = data;
 
-	vcpu_args_set(vm, HALTER_VCPU_ID, 1, test_data_page_vaddr);
-	vcpu_args_set(vm, SENDER_VCPU_ID, 1, test_data_page_vaddr);
+	vcpu_args_set(vm, params[0].vcpu->id, 1, test_data_page_vaddr);
+	vcpu_args_set(vm, params[1].vcpu->id, 1, test_data_page_vaddr);
 
 	pipis_rcvd = (uint64_t *)addr_gva2hva(vm, (uint64_t)&ipis_rcvd);
 	params[0].pipis_rcvd = pipis_rcvd;
 	params[1].pipis_rcvd = pipis_rcvd;
 
 	/* Start halter vCPU thread and wait for it to execute first HLT. */
-	params[0].vcpu_id = HALTER_VCPU_ID;
 	r = pthread_create(&threads[0], NULL, vcpu_thread, &params[0]);
 	TEST_ASSERT(r == 0,
 		    "pthread_create halter failed errno=%d", errno);
@@ -462,7 +455,6 @@ int main(int argc, char *argv[])
 		"Halter vCPU thread reported its APIC ID: %u after %d seconds.\n",
 		data->halter_apic_id, wait_secs);
 
-	params[1].vcpu_id = SENDER_VCPU_ID;
 	r = pthread_create(&threads[1], NULL, vcpu_thread, &params[1]);
 	TEST_ASSERT(r == 0, "pthread_create sender failed errno=%d", errno);
 
@@ -478,8 +470,8 @@ int main(int argc, char *argv[])
 	/*
 	 * Cancel threads and wait for them to stop.
 	 */
-	cancel_join_vcpu_thread(threads[0], HALTER_VCPU_ID);
-	cancel_join_vcpu_thread(threads[1], SENDER_VCPU_ID);
+	cancel_join_vcpu_thread(threads[0], params[0].vcpu);
+	cancel_join_vcpu_thread(threads[1], params[1].vcpu);
 
 	fprintf(stderr,
 		"Test successful after running for %d seconds.\n"
-- 
2.35.1.723.g4982287a31-goog

