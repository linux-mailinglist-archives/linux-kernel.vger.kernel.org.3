Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 469B94D5AE9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346776AbiCKFzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:55:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346650AbiCKFxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:53:03 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF8EF70D1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:52:00 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id d4-20020a170902f14400b001518350e5c7so4000776plb.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=F/d/u+IWfPL42R/UWR3F2wSA+hyx4NiZRdMIs7NAVo8=;
        b=e/XObfqJW6x3eoqpQyPxaThYzqAN9xOEmXg6lRLwKOUDNzhwdu7Mgd/YeHmlY9q1tE
         91JfDzZ1J262ZHeRT1toRUApHnk1zFgOYptqEYMgPd6HmETeTLmghtQK9Cy41ckFh0yu
         tGVvBKbK4T+ckLnXJ0h5HSbOK/2+dQmlTFxpu0O5cb6mlNifI84gZwqGu9+6L+yaVmFi
         l5jJMm7rIKYw59YW7O360drb2CLtGTNcsAmKvQ+PdIPtjRkLd1fbIn16i/q03nj0vwYG
         dTjZhhD02w3pvHz92sFhwikLAFbOYvy9aX4MJpshLujRd0Udlranpivouy1c3ReFl72T
         zUqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=F/d/u+IWfPL42R/UWR3F2wSA+hyx4NiZRdMIs7NAVo8=;
        b=aeoEhJpJReP/dF84lcNSVpefw0vG4HUJ8BberMKwrHfivyR3rpdo2OkDmytWUsX2oV
         jvPN37h/9Xcpy63pAnevH+9en9KPKieREnC4SxyIYlVC93DNjYjTEkfWEofoK0qqhBDU
         2M7Wem3Ozt2cswt2eufZRQyR6lOSYQKxILIa8z2sKa51+mJRa+KYSkCUEWpM8Yvvs8np
         qDLP5Oql01mBv4ReNiCQoVO9NTR152RcS2ATCnYJNeomjJXH3yux9I85obENKDlKsGp7
         q/t8JTSgNPUWJBar4P+0/TtC1SOnJbZBai2dXMkscoW0itIRiZngT4VQVRgSMu+ciaaJ
         BO2A==
X-Gm-Message-State: AOAM530UB1RZB4moTQ66FzRnEOeriCa2rtrOn1sKEzmyO94SH5SnkjBA
        lrw5Z2khvGU8WMczxHTkhn6wozp5xeC4tSs06aGQTRIMqlqhxHvjXYxB5XceOSzEthk12OohLak
        ahUxmfVaFiHN7A338Tw2pQuhkfcsBVm/qBRqk/AXnSNeMTLeSikGAxw2BTtG6ask1qmnZHw==
X-Google-Smtp-Source: ABdhPJyLJZLGldmByI6sEqm2zRO2zAtZzzKUoLwrx9JmNUVODzj7t7sWPoi6I4NOOsJDvPRmxFlYs/8L6hQ=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:1d28:b0:4f7:7b02:fad7 with SMTP id
 a40-20020a056a001d2800b004f77b02fad7mr5610935pfx.33.1646977920224; Thu, 10
 Mar 2022 21:52:00 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:49:43 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-33-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 032/105] KVM: selftests: Convert rseq_test away from VCPU_ID
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
2.35.1.723.g4982287a31-goog

