Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4673576A9D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 01:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbiGOXVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 19:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbiGOXVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 19:21:18 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8D8936AB
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 16:21:17 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id o10-20020a655bca000000b00412787983b3so3386427pgr.12
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 16:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=Gm/0I1+T32HiDACucIVWpxGQ1jktv79snrS7GRo/K1s=;
        b=AoKRujIk2kfCrBAADBgWJNrhbBLYrqc9+T6UYemN6kjvloos9C1+APFaUJZDghTYoK
         /gl5cf9LBxTnHKhFZihttuUm2Uw8gxHirDUmfoOBef0mS2z12msrFebej17FU4GFuxYc
         Jc6FLU3SMuhlLrgd91eBSLAv8SNc2g6ZHtFYmIgR0Zd1z6H+d04deiwFm6sR0O5j1oqP
         xrkV8tVUqiuGUTu9hZoHGz3v+FjoF16oG3R0to+BKmD7r2pdRWKzqSXZeTFEFBvBLOp7
         06dK7Fq/kNzH0ebilO4dVQPsqEhGUZtn5dHy5uG3jXdG4uhiRvKzRBePbz3VVABSpJJX
         XKAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=Gm/0I1+T32HiDACucIVWpxGQ1jktv79snrS7GRo/K1s=;
        b=iLbEHud4IYgCLmeZWdEmN9S7JQyMmCx0bd470FUoGP1b00UbMzGeeC1AAqi6Qa1Bbu
         N6mUgLDdOv5AgkTCcBoQIJEQ2YYyDqF87aslu9hlz8lonB1+t7QcWHVw+3HJYUu76GuY
         YIimM5YN2iKLI6PaNsYXDlTYmIMrBnQrEeamhIy1iQksW/otuqA4RWt5a+VvTmN2o3OF
         dzQcS6SkWswlINmFsmCab/Cqp2A0NU3czstYh7kcqgbTmTogJ/TXOS4jiqlQ6Qh30UPf
         rKSkvM5Qep3Xl+9ENF3Ks1yjKbX70s3Sgk7+wYvGyPSKgTFj/trVretUFhcxbLWH67Ww
         MZxQ==
X-Gm-Message-State: AJIora886xqsElqmoG7lNTKKjgKPNNNqX17AnLJDqaWs9i06XO1O9+YT
        8DGM5Cl7OSu7X8chulDbw6uByPVvcbc=
X-Google-Smtp-Source: AGRyM1sMGARc3J88SzpEf/kmJghkGEoGICMquk6J2DXH7vDBKPf1zVie0uMCNACtGtbHCAHC2vYQvaygYd0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:cb:0:b0:40c:a2b4:4890 with SMTP id
 194-20020a6300cb000000b0040ca2b44890mr14137493pga.304.1657927276873; Fri, 15
 Jul 2022 16:21:16 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 15 Jul 2022 23:21:07 +0000
In-Reply-To: <20220715232107.3775620-1-seanjc@google.com>
Message-Id: <20220715232107.3775620-5-seanjc@google.com>
Mime-Version: 1.0
References: <20220715232107.3775620-1-seanjc@google.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH 4/4] KVM: selftests: Add an option to run vCPUs while
 disabling dirty logging
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mingwei Zhang <mizhang@google.com>
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

Add a command line option to dirty_log_perf_test to run vCPUs for the
entire duration of disabling dirty logging.  By default, the test stops
running runs vCPUs before disabling dirty logging, which is faster but
less interesting as it doesn't stress KVM's handling of contention
between page faults and the zapping of collapsible SPTEs.  Enabling the
flag also lets the user verify that KVM is indeed rebuilding zapped SPTEs
as huge pages by checking KVM's pages_{1g,2m,4k} stats.  Without vCPUs to
fault in the zapped SPTEs, the stats will show that KVM is zapping pages,
but they never show whether or not KVM actually allows huge pages to be
recreated.

Note!  Enabling the flag can _significantly_ increase runtime, especially
if the thread that's disabling dirty logging doesn't have a dedicated
pCPU, e.g. if all pCPUs are used to run vCPUs.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/dirty_log_perf_test.c       | 30 +++++++++++++++++--
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/dirty_log_perf_test.c b/tools/testing/selftests/kvm/dirty_log_perf_test.c
index 808a36dbf0c0..f99e39a672d3 100644
--- a/tools/testing/selftests/kvm/dirty_log_perf_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_perf_test.c
@@ -59,6 +59,7 @@ static void arch_cleanup_vm(struct kvm_vm *vm)
 
 static int nr_vcpus = 1;
 static uint64_t guest_percpu_mem_size = DEFAULT_PER_VCPU_MEM_SIZE;
+static bool run_vcpus_while_disabling_dirty_logging;
 
 /* Host variables */
 static u64 dirty_log_manual_caps;
@@ -109,8 +110,13 @@ static void vcpu_worker(struct perf_test_vcpu_args *vcpu_args)
 				ts_diff.tv_nsec);
 		}
 
+		/*
+		 * Keep running the guest while dirty logging is being disabled
+		 * (iteration is negative) so that vCPUs are accessing memory
+		 * for the entire duration of zapping collapsible SPTEs.
+		 */
 		while (current_iteration == READ_ONCE(iteration) &&
-		       !READ_ONCE(host_quit)) {}
+		       READ_ONCE(iteration) >= 0 && !READ_ONCE(host_quit)) {}
 	}
 
 	avg = timespec_div(total, vcpu_last_completed_iteration[vcpu_idx]);
@@ -302,6 +308,14 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 		}
 	}
 
+	/*
+	 * Run vCPUs while dirty logging is being disabled to stress disabling
+	 * in terms of both performance and correctness.  Opt-in via command
+	 * line as this significantly increases time to disable dirty logging.
+	 */
+	if (run_vcpus_while_disabling_dirty_logging)
+		WRITE_ONCE(iteration, -1);
+
 	/* Disable dirty logging */
 	clock_gettime(CLOCK_MONOTONIC, &start);
 	disable_dirty_logging(vm, p->slots);
@@ -309,7 +323,11 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 	pr_info("Disabling dirty logging time: %ld.%.9lds\n",
 		ts_diff.tv_sec, ts_diff.tv_nsec);
 
-	/* Tell the vcpu thread to quit */
+	/*
+	 * Tell the vCPU threads to quit.  No need to manually check that vCPUs
+	 * have stopped running after disabling dirty logging, the join will
+	 * wait for them to exit.
+	 */
 	host_quit = true;
 	perf_test_join_vcpu_threads(nr_vcpus);
 
@@ -349,6 +367,9 @@ static void help(char *name)
 	       "     Warning: a low offset can conflict with the loaded test code.\n");
 	guest_modes_help();
 	printf(" -n: Run the vCPUs in nested mode (L2)\n");
+	printf(" -e: Run vCPUs while dirty logging is being disabled.  This\n"
+	       "     can significantly increase runtime, especially if there\n"
+	       "     isn't a dedicated pCPU for the main thread.\n");
 	printf(" -b: specify the size of the memory region which should be\n"
 	       "     dirtied by each vCPU. e.g. 10M or 3G.\n"
 	       "     (default: 1G)\n");
@@ -385,8 +406,11 @@ int main(int argc, char *argv[])
 
 	guest_modes_append_default();
 
-	while ((opt = getopt(argc, argv, "ghi:p:m:nb:f:v:os:x:")) != -1) {
+	while ((opt = getopt(argc, argv, "eghi:p:m:nb:f:v:os:x:")) != -1) {
 		switch (opt) {
+		case 'e':
+			/* 'e' is for evil. */
+			run_vcpus_while_disabling_dirty_logging = true;
 		case 'g':
 			dirty_log_manual_caps = 0;
 			break;
-- 
2.37.0.170.g444d1eabd0-goog

