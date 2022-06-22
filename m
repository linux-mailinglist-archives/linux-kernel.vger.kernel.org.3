Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA2DD556DE0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 23:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236323AbiFVVh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 17:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233713AbiFVVhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 17:37:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5A62F36308
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 14:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655933832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+Bc6oiDMKyczPP3MnRg+YG2Ibpmu1/F27D1fgoc2Uo0=;
        b=elRe8AFG2Ryml0dZVEwN/7ZYwX/L6A49SBv3pr55f6mL00BamfE+01/fIBPDP63ahCMVW4
        4Mx6qkSDZLJE1rWSouzrmAIkatKK+aPuKktqNHyZVKEqRHvUvN/5/wEHDX15Dsg/eAEXR9
        4WnRNLwjVZf6oAkqxqlBdCJM9zRX8jQ=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-599-Y822-L91OI2pCns4Cl3yjQ-1; Wed, 22 Jun 2022 17:37:11 -0400
X-MC-Unique: Y822-L91OI2pCns4Cl3yjQ-1
Received: by mail-io1-f69.google.com with SMTP id e195-20020a6bb5cc000000b0066cc9ece80fso9867419iof.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 14:37:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Bc6oiDMKyczPP3MnRg+YG2Ibpmu1/F27D1fgoc2Uo0=;
        b=VxZugiYUTfoIAX85wk5vc+W+mxZcqaM937xuIPu4l7cPQSZt6/9XnmFpPrLbpLcBFY
         5iYjS06JajXVBzOriEOemgb+zINdbJXCZOxbRpUeFI8JcSlD3ydf/55JMEM5EtrvROsD
         jsb5HBmTRzP3mgxZqnm3WywWNHQ9UXuRiwacdNqaLZQnJHvx1v5Sal3lAI4wPKGMFodZ
         0ILnlpbAF8W63V2/83GsUXfy87IkWPFhjjMo69AeW/sdc+2augXEf0BM/ivWjlEjWlrr
         r+4isnpjSMKaAXSI1HNwTo82o39nQYKSon0hEqLEdbFE2/YJjvyJwft2IBm4IL0+ztGQ
         i5HQ==
X-Gm-Message-State: AJIora9VnzYmyzR0CP+TtlDARAHG6+krcWNfHQm0zhK2o58PPoGfso+b
        xGGxx6RAEefuGmAuUi20NunpyopuZcbbG+TPpnkE4fqybRrpGPcqeIt7xxxHbJrOsmNSDVgs5UB
        6KuuE5C2iGieCx6qTBfHaO8E7
X-Received: by 2002:a05:6638:3043:b0:314:7ce2:4a6e with SMTP id u3-20020a056638304300b003147ce24a6emr3407084jak.258.1655933830725;
        Wed, 22 Jun 2022 14:37:10 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tXYF1gATLPxilQ8J8azYs80FKmrYKCExwZSpp2Y52+zhUd9Cgm+xA8CMppEVs8Il5ycEHTqA==
X-Received: by 2002:a05:6638:3043:b0:314:7ce2:4a6e with SMTP id u3-20020a056638304300b003147ce24a6emr3407077jak.258.1655933830514;
        Wed, 22 Jun 2022 14:37:10 -0700 (PDT)
Received: from localhost.localdomain (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id g7-20020a0566380c4700b00339d892cc89sm1510446jal.83.2022.06.22.14.37.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 22 Jun 2022 14:37:09 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linux MM Mailing List <linux-mm@kvack.org>,
        Sean Christopherson <seanjc@google.com>
Subject: [PATCH 4/4] kvm/x86: Allow to respond to generic signals during slow page faults
Date:   Wed, 22 Jun 2022 17:36:56 -0400
Message-Id: <20220622213656.81546-5-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220622213656.81546-1-peterx@redhat.com>
References: <20220622213656.81546-1-peterx@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the facilities should be ready for this, what we need to do is to add a
new KVM_GTP_INTERRUPTIBLE flag showing that we're willing to be interrupted
by common signals during the __gfn_to_pfn_memslot() request, and wire it up
with a FOLL_INTERRUPTIBLE flag that we've just introduced.

Note that only x86 slow page fault routine will set this new bit.  The new
bit is not used in non-x86 arch or on other gup paths even for x86.
However it can actually be used elsewhere too but not yet covered.

When we see the PFN fetching was interrupted, do early exit to userspace
with an KVM_EXIT_INTR exit reason.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c   | 9 +++++++++
 include/linux/kvm_host.h | 1 +
 virt/kvm/kvm_main.c      | 4 ++++
 3 files changed, 14 insertions(+)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index e92f1ab63d6a..b39acb7cb16d 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3012,6 +3012,13 @@ static int kvm_handle_bad_page(struct kvm_vcpu *vcpu, gfn_t gfn, kvm_pfn_t pfn)
 static int handle_abnormal_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault,
 			       unsigned int access)
 {
+	/* NOTE: not all error pfn is fatal; handle intr before the other ones */
+	if (unlikely(is_intr_pfn(fault->pfn))) {
+		vcpu->run->exit_reason = KVM_EXIT_INTR;
+		++vcpu->stat.signal_exits;
+		return -EINTR;
+	}
+
 	/* The pfn is invalid, report the error! */
 	if (unlikely(is_error_pfn(fault->pfn)))
 		return kvm_handle_bad_page(vcpu, fault->gfn, fault->pfn);
@@ -4017,6 +4024,8 @@ static int kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 		}
 	}
 
+	/* Allow to respond to generic signals in slow page faults */
+	flags |= KVM_GTP_INTERRUPTIBLE;
 	fault->pfn = __gfn_to_pfn_memslot(slot, fault->gfn, flags, NULL,
 					  &fault->map_writable, &fault->hva);
 	return RET_PF_CONTINUE;
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 4f84a442f67f..c8d98e435537 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1163,6 +1163,7 @@ typedef unsigned int __bitwise kvm_gtp_flag_t;
 
 #define  KVM_GTP_WRITE          ((__force kvm_gtp_flag_t) BIT(0))
 #define  KVM_GTP_ATOMIC         ((__force kvm_gtp_flag_t) BIT(1))
+#define  KVM_GTP_INTERRUPTIBLE  ((__force kvm_gtp_flag_t) BIT(2))
 
 kvm_pfn_t __gfn_to_pfn_memslot(const struct kvm_memory_slot *slot, gfn_t gfn,
 			       kvm_gtp_flag_t gtp_flags, bool *async,
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 952400b42ee9..b3873cac5672 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2462,6 +2462,8 @@ static int hva_to_pfn_slow(unsigned long addr, bool *async,
 		flags |= FOLL_WRITE;
 	if (async)
 		flags |= FOLL_NOWAIT;
+	if (gtp_flags & KVM_GTP_INTERRUPTIBLE)
+		flags |= FOLL_INTERRUPTIBLE;
 
 	npages = get_user_pages_unlocked(addr, 1, &page, flags);
 	if (npages != 1)
@@ -2599,6 +2601,8 @@ kvm_pfn_t hva_to_pfn(unsigned long addr, kvm_gtp_flag_t gtp_flags, bool *async,
 	npages = hva_to_pfn_slow(addr, async, gtp_flags, writable, &pfn);
 	if (npages == 1)
 		return pfn;
+	if (npages == -EINTR)
+		return KVM_PFN_ERR_INTR;
 
 	mmap_read_lock(current->mm);
 	if (npages == -EHWPOISON ||
-- 
2.32.0

