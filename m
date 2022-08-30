Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B115A7193
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 01:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbiH3XRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 19:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbiH3XRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 19:17:04 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58ADC9E127
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 16:16:25 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id b9-20020a170902d50900b0016f0342a417so8878784plg.21
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 16:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc;
        bh=oyW7O7dkTIafWDUZOYrTaY9ovl5H6kG4zyO9ErNBcPI=;
        b=hwErrU1ofUzrYXdyH0PkH68mxDp8A9BaOVU+rzLX5I4bY2Z5eqvshEjY4dJhn+a2aD
         Gvhl8y3skY8RsUeN+iq6ql/3LQKpiGlMYg0gCdif2IaOgdIDz6bcwgiSdRxE3HdA5xNd
         w3PONsSumD+65Ksda4OOHNgOzhsmF6C3e82m+rzYXPYruvp1QVhuZI5HeGbh+L0VfQpk
         X2Lr0I/RKwaFoeOo169mfJ+f+5A8kftH9M27MVeCsF//iO5eMJCUGIN0jJAWMN0PDR1Q
         oxO4xAupt6PcgQEiOIIh7jdYdlq97TurBpC4HHP29dYI7qS+G+XmqL7VZx5Cpznj6zkF
         0oJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc;
        bh=oyW7O7dkTIafWDUZOYrTaY9ovl5H6kG4zyO9ErNBcPI=;
        b=ojyQrqcf/4yr3d+mFGqWRU2ytsoUj+xdcuJmsgIWNYeRPrGoqUE4GdPEIPri6tAP2E
         EHZPL7OQj7Q3MQRojeG/N2u/KzGVEQdkY7pxKAdQqTn7iqZ8JViesj2PuE50HX96Z8JL
         z9y11683ur1Vax7rbmC3+DfFUCVLaXGW/3xz5QJ2neg7wo2ztexLUHCshLfV/dsCElHw
         9I7gptVuq7O7f+W87uD3cBvdUldqhsy2qTs4yEn24eynPw7wBKWtCKg4qOJGEpCt6SSj
         xFsi0zoip7VZKypCVKtDrz6rTcufiUyBewKYsKXvL29KJqk4pObck3BWivgO2RFk1Iwv
         o6GA==
X-Gm-Message-State: ACgBeo0RRvV/5QrBiI+UX6GW5HO+7dWi6329eXUzhQboyopUiaiRDxzk
        Q1QZzYc8GTy9NyNm9GWsdzna3AC9HSA=
X-Google-Smtp-Source: AA6agR7eQvqhd8VBnSv0zbkGPCB4IhAa75nWv7zObskXK/ex2k3GyizECsiOOHH/Isvxfi5+eU9jJws7lqo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:8248:0:b0:42b:b607:f74f with SMTP id
 w69-20020a638248000000b0042bb607f74fmr13880045pgd.70.1661901383579; Tue, 30
 Aug 2022 16:16:23 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 30 Aug 2022 23:15:51 +0000
In-Reply-To: <20220830231614.3580124-1-seanjc@google.com>
Mime-Version: 1.0
References: <20220830231614.3580124-1-seanjc@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220830231614.3580124-5-seanjc@google.com>
Subject: [PATCH v5 04/27] KVM: x86: Allow clearing RFLAGS.RF on forced
 emulation to test code #DBs
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Oliver Upton <oupton@google.com>,
        Peter Shier <pshier@google.com>
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

Extend force_emulation_prefix to an 'int' and use bit 1 as a flag to
indicate that KVM should clear RFLAGS.RF before emulating, e.g. to allow
tests to force emulation of code breakpoints in conjunction with MOV/POP
SS blocking, which is impossible without KVM intervention as VMX
unconditionally sets RFLAGS.RF on intercepted #UD.

Make the behavior controllable so that tests can also test RFLAGS.RF=1
(again in conjunction with code #DBs).

Note, clearing RFLAGS.RF won't create an infinite #DB loop as the guest's
IRET from the #DB handler will return to the instruction and not the
prefix, i.e. the restart won't force emulation.

Opportunistically convert the permissions to the preferred octal format.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index fead0e8cd3e3..7403221c868e 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -173,8 +173,13 @@ bool __read_mostly enable_vmware_backdoor = false;
 module_param(enable_vmware_backdoor, bool, S_IRUGO);
 EXPORT_SYMBOL_GPL(enable_vmware_backdoor);
 
-static bool __read_mostly force_emulation_prefix = false;
-module_param(force_emulation_prefix, bool, S_IRUGO);
+/*
+ * Flags to manipulate forced emulation behavior (any non-zero value will
+ * enable forced emulation).
+ */
+#define KVM_FEP_CLEAR_RFLAGS_RF	BIT(1)
+static int __read_mostly force_emulation_prefix;
+module_param(force_emulation_prefix, int, 0444);
 
 int __read_mostly pi_inject_timer = -1;
 module_param(pi_inject_timer, bint, S_IRUGO | S_IWUSR);
@@ -7255,6 +7260,8 @@ int handle_ud(struct kvm_vcpu *vcpu)
 	    kvm_read_guest_virt(vcpu, kvm_get_linear_rip(vcpu),
 				sig, sizeof(sig), &e) == 0 &&
 	    memcmp(sig, kvm_emulate_prefix, sizeof(sig)) == 0) {
+		if (force_emulation_prefix & KVM_FEP_CLEAR_RFLAGS_RF)
+			kvm_set_rflags(vcpu, kvm_get_rflags(vcpu) & ~X86_EFLAGS_RF);
 		kvm_rip_write(vcpu, kvm_rip_read(vcpu) + sizeof(sig));
 		emul_type = EMULTYPE_TRAP_UD_FORCED;
 	}
-- 
2.37.2.672.g94769d06f0-goog

