Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC7853C2E0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 04:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241773AbiFCBBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 21:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241051AbiFCAuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 20:50:22 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C622D1CA
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 17:47:32 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id j15-20020a17090a738f00b001e345e429d2so3542767pjg.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 17:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=83uHdjveTV9JqF8Qzu1gLbAMw/PFt6x8USvDY99Vle0=;
        b=aJnxC0JYG1QHPuRXcIx9kJd3MMrm58q4iVFryuMfGAsmCOv3S+3IGtZiDhb/6HYrBY
         0zAUzbOWd0MSVHNMaz/mrja/yWNHaMKD+l92I4bGaTv+CIcDA0Ew/SH1t1CevhcCzdc0
         BTRLW3dYgjIIV/OtMZ+ARhyI+VFG3/NqdvCHTjvEhSKh0Mtl/uu1eY0H6gUtfL5x5Uly
         hGFNxK36VBMczD58Qwy3e9nhi3VofST5QmtG94eD7VQiffzsPqYeX8tCKY64YqFGiKfx
         kCU2XIfLf1yU9od7mc8oTh03uOO+7xU0p6ySJlrdQmijN2dQkyouB972L0UsXqjizFIO
         2Qvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=83uHdjveTV9JqF8Qzu1gLbAMw/PFt6x8USvDY99Vle0=;
        b=kxP2ZqTzi+z16vFGxZYCfmOO4/hnHlK9iRBtbNHJyxbARaETtsOCHG1RV7KvNUoGef
         2I9j0Xd+H1ZCZNmpCmB2I9tqioKJRcKD8iKv5g++fjxGS0AJOdusf2A+nS0CCLN0ApRr
         yjZEKDvqRG67QX+p8YYlKzqNTzrg8gfsBMd2kcEojHnzGu5w8LXlUlh1t6SO+kqjl1gW
         +ZZDQVlmFRIuz/P0H9jVShXerCXU3DvlFU+nvRHcCCpxph0hrsilYVq99RPWj3txADOj
         hCfKlYftagl/T0DKYv4Q0GvXDhAjRdZmWBY5E0kskRDluyHLuD6/LnBrqsaXxE0Fln4B
         31dw==
X-Gm-Message-State: AOAM530ZQFwfWAQsLtOcn61ltPLtDUH8QDReL+hMuaHQMQgKkryR4sYW
        z0zISboKvAyVY9A+I2tjyrQjdIQIvdk=
X-Google-Smtp-Source: ABdhPJwTS6GnZOGxbbEaHTJrMcq3BHfSnkzCF+mGK6UPUtc0wNgiNnwgyfPyzlu5P2+u5T3RiztlsdgAuiM=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:e54e:b0:162:4b8b:f2be with SMTP id
 n14-20020a170902e54e00b001624b8bf2bemr7673424plf.5.1654217251570; Thu, 02 Jun
 2022 17:47:31 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  3 Jun 2022 00:43:17 +0000
In-Reply-To: <20220603004331.1523888-1-seanjc@google.com>
Message-Id: <20220603004331.1523888-131-seanjc@google.com>
Mime-Version: 1.0
References: <20220603004331.1523888-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH v2 130/144] KVM: selftests: Remove vcpu_get() usage from dirty_log_test
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>,
        Oliver Upton <oupton@google.com>, linux-kernel@vger.kernel.org
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

Grab the vCPU from vm_vcpu_add() directly instead of doing vcpu_get()
after the fact.  This will allow removing vcpu_get() entirely.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/dirty_log_test.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index 1a5c01c65044..5db56140a995 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -665,7 +665,7 @@ static void vm_dirty_log_verify(enum vm_guest_mode mode, unsigned long *bmap)
 	}
 }
 
-static struct kvm_vm *create_vm(enum vm_guest_mode mode, uint32_t vcpuid,
+static struct kvm_vm *create_vm(enum vm_guest_mode mode, struct kvm_vcpu **vcpu,
 				uint64_t extra_mem_pages, void *guest_code)
 {
 	struct kvm_vm *vm;
@@ -676,7 +676,7 @@ static struct kvm_vm *create_vm(enum vm_guest_mode mode, uint32_t vcpuid,
 	vm = __vm_create(mode, DEFAULT_GUEST_PHY_PAGES + extra_pg_pages);
 
 	log_mode_create_vm_done(vm);
-	vm_vcpu_add(vm, vcpuid, guest_code);
+	*vcpu = vm_vcpu_add(vm, 0, guest_code);
 	return vm;
 }
 
@@ -710,10 +710,8 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 	 * (e.g., 64K page size guest will need even less memory for
 	 * page tables).
 	 */
-	vm = create_vm(mode, 0,
-		       2ul << (DIRTY_MEM_BITS - PAGE_SHIFT_4K),
-		       guest_code);
-	vcpu = vcpu_get(vm, 0);
+	vm = create_vm(mode, &vcpu,
+		       2ul << (DIRTY_MEM_BITS - PAGE_SHIFT_4K), guest_code);
 
 	guest_page_size = vm_get_page_size(vm);
 	/*
-- 
2.36.1.255.ge46751e96f-goog

