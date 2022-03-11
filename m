Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13BFC4D5B4F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 07:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346792AbiCKGBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 01:01:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346681AbiCKFzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:55:13 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C1F10612C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:53:59 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id lp2-20020a17090b4a8200b001bc449ecbceso7263839pjb.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=d9N99i+QpGyC5SnNdmZZfNM/fJE6Xn0g3WkRGRvLwsU=;
        b=fAZNZTYGrO/Fa9d2l/9Sp9pVcLj/TuKJyynO9X3/NCGgO22NaY4AMXfgeab3qhvbzA
         Nzj9fsDnDT/XJooHuuqneqw7zDGzuNZNj5IGn/coVzuoOYNfNnRFKGcQjImOYJvS3IUm
         oMikvbsPHtxITRCcxsbtzHySG8IDyDg/qRLmj+5cBqMYxNHIFJ/AOPxqzzkgM1s29Jek
         gb7xdNwuGOuiveye1PjGTmQDQQSIvImMjGlQ6I5edby9JLCKooSqL2CvbTf9Wc8Ots/5
         tWLHNhtyIyOKbLwM5TDUojIs/qvVUgOtuaoKce8zk+tXVg20EjahbpgZU8L3JZFLIDcj
         tCVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=d9N99i+QpGyC5SnNdmZZfNM/fJE6Xn0g3WkRGRvLwsU=;
        b=bssmR1K2z4wFDOyNWxY+/qMJ/f+DQlHFISUAa3IPTWZUXUJut8jy+JBhFt2W5ksyko
         9mjpIPDQw10aS9YwoOGrt9FUtdA14pWOmyhe515FZBGiRHuUQTfDIsgBFCfciZ8LI8HR
         QT/+A+M/KeowP1BXIr+nMPnS/AUqZQL7ItcRreIofrRzjH8tMTPo7ho719NB3ALlItIj
         INMIMRa/+z5Km0G0cbxtjZdhGv0yMrqK7mYzQDANpgqGIhkGtH+G//aPKFnWPGYscqyQ
         9wmcpYQapwsQKqPg6I1XX7JEGsxWNk7P+a40/UzKk8gbuLknwzMZ72JUF6FzOoxZLxCa
         UKww==
X-Gm-Message-State: AOAM531MXXCKWUp8ROinY31nmkoUHSOWQFMyMRc43f/wOgOYfi51MubB
        aLt75yZWtGWS0+vhFq5cYU7DVSFmLo4vJXWileZt739iC2qcYMqgh3nzOy66zw1XU/NIdmPF8cw
        x4B5dK1Cbk2gKSQtJeWH903mlcVJ68PWeZXvqM7Aj6hMbkuZWOIpckxiv5sRIxiswIH5Cbw==
X-Google-Smtp-Source: ABdhPJxeU4vxUmktStnJAKuNMGxU0n1Gn6A68XktF4tGG8J66xIl2Du8JtFIo3xZRJB0g2GXuiyXtRln2wo=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a63:28d:0:b0:365:8e16:5c19 with SMTP id
 135-20020a63028d000000b003658e165c19mr7174704pgc.579.1646978038904; Thu, 10
 Mar 2022 21:53:58 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:50:54 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-104-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 103/105] KVM: selftests: Drop vcpu_get(), rename
 vcpu_find() => vcpu_exists()
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
 .../selftests/kvm/include/kvm_util_base.h     |  2 --
 tools/testing/selftests/kvm/lib/kvm_util.c    | 34 +++++++------------
 2 files changed, 13 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index c0873a5ca3c3..6d46261432cb 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -93,8 +93,6 @@ struct kvm_vm {
 			continue;			\
 		else
 
-struct kvm_vcpu *vcpu_get(struct kvm_vm *vm, uint32_t vcpu_id);
-
 struct userspace_mem_region *
 memslot2region(struct kvm_vm *vm, uint32_t memslot);
 
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index b6faffcdcf39..b86c8b0883ad 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -475,26 +475,6 @@ kvm_userspace_memory_region_find(struct kvm_vm *vm, uint64_t start,
 	return &region->region;
 }
 
-static struct kvm_vcpu *vcpu_find(struct kvm_vm *vm, uint32_t vcpu_id)
-{
-	struct kvm_vcpu *vcpu;
-
-	list_for_each_entry(vcpu, &vm->vcpus, list) {
-		if (vcpu->id == vcpu_id)
-			return vcpu;
-	}
-
-	return NULL;
-}
-
-struct kvm_vcpu *vcpu_get(struct kvm_vm *vm, uint32_t vcpu_id)
-{
-	struct kvm_vcpu *vcpu = vcpu_find(vm, vcpu_id);
-
-	TEST_ASSERT(vcpu, "vCPU %d does not exist", vcpu_id);
-	return vcpu;
-}
-
 /*
  * VM VCPU Remove
  *
@@ -1044,6 +1024,18 @@ static int vcpu_mmap_sz(void)
 	return ret;
 }
 
+static bool vcpu_exists(struct kvm_vm *vm, uint32_t vcpu_id)
+{
+	struct kvm_vcpu *vcpu;
+
+	list_for_each_entry(vcpu, &vm->vcpus, list) {
+		if (vcpu->id == vcpu_id)
+			return true;
+	}
+
+	return false;
+}
+
 /*
  * Adds a virtual CPU to the VM specified by vm with the ID given by vcpu_id.
  * No additional vCPU setup is done.  Returns the vCPU.
@@ -1053,7 +1045,7 @@ struct kvm_vcpu *__vm_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id)
 	struct kvm_vcpu *vcpu;
 
 	/* Confirm a vcpu with the specified id doesn't already exist. */
-	TEST_ASSERT(!vcpu_find(vm, vcpu_id), "vCPU%d already exists\n", vcpu_id);
+	TEST_ASSERT(!vcpu_exists(vm, vcpu_id), "vCPU%d already exists\n", vcpu_id);
 
 	/* Allocate and initialize new vcpu structure. */
 	vcpu = calloc(1, sizeof(*vcpu));
-- 
2.35.1.723.g4982287a31-goog

