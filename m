Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D58151B35F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 01:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379011AbiEDW5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 18:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379536AbiEDWyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 18:54:24 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8403E4AE38
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 15:50:46 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d6-20020aa78e46000000b0050cfcce2fefso816847pfr.18
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 15:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=I70dsz4lXhruyCGWKJHDQVXM4bOs2OXTBNWCoVTLtu4=;
        b=gJMd+qSgUMP2fNtviqeq61J1UXjHROcATc2p2kBsajvUGU25w/b5dpLryu083CwI3/
         AdFQkR8HF46BFheZsie3s5i7KMzyxlxnzLo5WOABbh24n43AuJzVJuw1BOI2tbKGFsDD
         uzVsoq6Y2N4SaEK6fgSTHoFgkHCUSDilTHpfLpw+8kMj81Fhn58Wk6SyyajqyVNAjrwI
         NeWEj9QUullZY4gZPxpMl3pCq6NI9TmgExHWE9iyxLdTsPjTgFJtPmqc9G76TuAvrcd2
         x0I7NdilEtyM4iku3BX6Blejt7yrLEXt40/aSQ2yCRsKkioW9ZwKGoCPz9bdUONFXkQk
         RdXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=I70dsz4lXhruyCGWKJHDQVXM4bOs2OXTBNWCoVTLtu4=;
        b=mfs3vLGcSDp06cjZBRb2xF6stoyylIIb5vam/9abuKnecWiQwap3Iz4JD5eG1YOxtw
         7UtycgfXyK7sXLbc0aSTqAj1rVrbBiTOuf1nBO7piSQdHEfThs/7GZ7PwLvyYwvcitYl
         gC0oQFQX60CHQVfjYwwnmD/KNfzqVylghbj4f0poKxCYk1h+ZDzgOO+AoipMD4JNRkEo
         kd49JkKsUFO+TF665HoatVAUr/FgoGoXOWkdQztJT+lOqjm/by2Gvb3dhqXA61GOhMhF
         qwnzHV+Wq/8Kv2YsvWtYq4W21Y+egnjL1isYlvVGcDiovM0ILjcIxdyg458dWRk5ck/m
         YUeg==
X-Gm-Message-State: AOAM532l2r0rDLEcfxbWQlEOvEPq0SlEnWPQcbIPGY6kn3hHj1o4xr/8
        j2Jk8yTM3af20sdTtPbNBCKYbBjLvgo=
X-Google-Smtp-Source: ABdhPJwDKoIN/l0wxQjqDQmmvLfZOGpdqa7hWMU5ZE40qii7kfzsm3HAu/xBBdhV9On+AO6BtaX7e/8hTm4=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:1a49:b0:505:7ab3:e5c7 with SMTP id
 h9-20020a056a001a4900b005057ab3e5c7mr22791383pfv.62.1651704646014; Wed, 04
 May 2022 15:50:46 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  4 May 2022 22:47:49 +0000
In-Reply-To: <20220504224914.1654036-1-seanjc@google.com>
Message-Id: <20220504224914.1654036-44-seanjc@google.com>
Mime-Version: 1.0
References: <20220504224914.1654036-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH 043/128] KVM: selftests: Convert rseq_test away from VCPU_ID
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>,
        Oliver Upton <oupton@google.com>,
        Sean Christopherson <seanjc@google.com>
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

Convert rseq_test to use vm_create_with_one_vcpu() and pass around a
'struct kvm_vcpu' object instead of using a global VCPU_ID.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/rseq_test.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/rseq_test.c b/tools/testing/selftests/kvm/rseq_test.c
index 4158da0da2bb..fd754de0b74c 100644
--- a/tools/testing/selftests/kvm/rseq_test.c
+++ b/tools/testing/selftests/kvm/rseq_test.c
@@ -20,8 +20,6 @@
 #include "processor.h"
 #include "test_util.h"
 
-#define VCPU_ID 0
-
 static __thread volatile struct rseq __rseq = {
 	.cpu_id = RSEQ_CPU_ID_UNINITIALIZED,
 };
@@ -207,6 +205,7 @@ int main(int argc, char *argv[])
 {
 	int r, i, snapshot;
 	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
 	u32 cpu, rseq_cpu;
 
 	/* Tell stdout not to buffer its content */
@@ -228,14 +227,14 @@ int main(int argc, char *argv[])
 	 * GUEST_SYNC, while concurrently migrating the process by setting its
 	 * CPU affinity.
 	 */
-	vm = vm_create_default(VCPU_ID, 0, guest_code);
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
 	ucall_init(vm, NULL);
 
 	pthread_create(&migration_thread, NULL, migration_worker, 0);
 
 	for (i = 0; !done; i++) {
-		vcpu_run(vm, VCPU_ID);
-		TEST_ASSERT(get_ucall(vm, VCPU_ID, NULL) == UCALL_SYNC,
+		vcpu_run(vm, vcpu->id);
+		TEST_ASSERT(get_ucall(vm, vcpu->id, NULL) == UCALL_SYNC,
 			    "Guest failed?");
 
 		/*
-- 
2.36.0.464.gb9c8b46e94-goog

