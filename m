Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB405ABC16
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 03:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbiICB3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 21:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbiICB3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 21:29:19 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AEBCF1B70
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 18:29:15 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id a12-20020a65604c000000b0042a8c1cc701so1925472pgp.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 18:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=teDA7lGmoh5ixtO1NHeYP4kVc2vZyPO8AkBAu7ZO0Ps=;
        b=JKHM/wfVctrjsVDcn9GGSM6sSinU/9EkvOzfbFABoU5H+Ndr+yR5W898Ez5TKp2qZi
         2Nn2olRLWUqzsiXFkydQdzlXNkaGdezZ6rnmWe8SVIYzTMARXq/gpK9MgKgwZ43HvIuL
         s4+wZZhMr96lFweFLbJ3tQVNLI0RkibcbwiHaaZo8hNW9LiVKrj6VJX7YpNMk0/fX5lK
         tF3vXyFZDe+CDsPIBPymv/Vu8sbwXw0rOiJ6IyPvD0xWvBVDwKPjSs2hQ34/qNgdzHnu
         9txyaIa+qQ9U7Cl2PUguzFDatpu1/GiMkO+atn40POnGkl1Pe6abovQGd1pHfoTculu9
         +J2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=teDA7lGmoh5ixtO1NHeYP4kVc2vZyPO8AkBAu7ZO0Ps=;
        b=3MH2ejqyjQzepTyyhwuJm/RfE/SERZFtase0Iw2wgJBjlg3iEFcCADIV4bYktdm8s9
         h9qogLsNNk3Dg6wFZ/Uhz0V5DsJ/dEyEuagInka7RBEzviY1RkwV4qFRW+E70/Llf+29
         p+RBDQ3dQs/GqBNhKLu0E5O6KIzdtnfdAEa6kTJ7Cbv7xxxDAv9ChLFlpZgTvEWaiH5B
         CyK4MdqWipW4AecNgffLDASjmfj3Bi51jF8tuEaW2gjmmK7HO2ahZkKHKvL22HgguYig
         0veguusTDdED+NsRKB2Bg5huwU3ZFvOdGRzrhpV05GS3t3YM8yETNU8Fnh7mj3h7vt8d
         +cJQ==
X-Gm-Message-State: ACgBeo0q04kl2tVbMPQvC4ScqqG7s7egclr6SmsXnp5NoZprT4AaEcqb
        K9+OY5kpdapENBswZysP0aMtuaZO+TpbT4w5
X-Google-Smtp-Source: AA6agR5OP4cddrGvdjIlCSaj4v3VTkWYDqTHducGChauEZb0wxQ8Vk7yf9i5X98W6XfWJ5R0M4EhvGt+r3An4vu4
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:41f8])
 (user=vannapurve job=sendgmr) by 2002:aa7:88c4:0:b0:538:4308:fe99 with SMTP
 id k4-20020aa788c4000000b005384308fe99mr27015150pff.74.1662168554704; Fri, 02
 Sep 2022 18:29:14 -0700 (PDT)
Date:   Sat,  3 Sep 2022 01:28:47 +0000
In-Reply-To: <20220903012849.938069-1-vannapurve@google.com>
Mime-Version: 1.0
References: <20220903012849.938069-1-vannapurve@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220903012849.938069-4-vannapurve@google.com>
Subject: [V1 PATCH 3/5] selftests: kvm: x86: Execute vmcall/vmmcall according
 to CPU type
From:   Vishal Annapurve <vannapurve@google.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, shuah@kernel.org, bgardon@google.com,
        seanjc@google.com, oupton@google.com, peterx@redhat.com,
        vkuznets@redhat.com, drjones@redhat.com, dmatlack@google.com,
        Vishal Annapurve <vannapurve@google.com>
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

Modify following APIs for x86 implementation:
1) kvm_arch_main : Query the cpu vendor and cache the value in advance.
2) kvm_arch_post_vm_load: Populate cpu type in the guest memory so that
	guest doesn't need to execute cpuid instruction again.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 .../testing/selftests/kvm/lib/x86_64/processor.c  | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index e22cfc4bf284..ac104653ab43 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -19,6 +19,7 @@
 #define MAX_NR_CPUID_ENTRIES 100
 
 vm_vaddr_t exception_handlers;
+static int is_cpu_amd = -1;
 
 static void regs_dump(FILE *stream, struct kvm_regs *regs, uint8_t indent)
 {
@@ -1019,7 +1020,7 @@ static bool cpu_vendor_string_is(const char *vendor)
 
 bool is_intel_cpu(void)
 {
-	return cpu_vendor_string_is("GenuineIntel");
+	return (is_cpu_amd == 0);
 }
 
 /*
@@ -1027,7 +1028,7 @@ bool is_intel_cpu(void)
  */
 bool is_amd_cpu(void)
 {
-	return cpu_vendor_string_is("AuthenticAMD");
+	return (is_cpu_amd == 1);
 }
 
 void kvm_get_cpu_address_width(unsigned int *pa_bits, unsigned int *va_bits)
@@ -1182,9 +1183,15 @@ uint64_t kvm_hypercall(uint64_t nr, uint64_t a0, uint64_t a1, uint64_t a2,
 {
 	uint64_t r;
 
-	asm volatile("vmcall"
+	if (is_amd_cpu())
+		asm volatile("vmmcall"
 		     : "=a"(r)
 		     : "a"(nr), "b"(a0), "c"(a1), "d"(a2), "S"(a3));
+	else
+		asm volatile("vmcall"
+		     : "=a"(r)
+		     : "a"(nr), "b"(a0), "c"(a1), "d"(a2), "S"(a3));
+
 	return r;
 }
 
@@ -1314,8 +1321,10 @@ bool vm_is_unrestricted_guest(struct kvm_vm *vm)
 
 void kvm_arch_main(void)
 {
+	is_cpu_amd = cpu_vendor_string_is("AuthenticAMD") ? 1 : 0;
 }
 
 void kvm_arch_post_vm_load(struct kvm_vm *vm)
 {
+	sync_global_to_guest(vm, is_cpu_amd);
 }
-- 
2.37.2.789.g6183377224-goog

