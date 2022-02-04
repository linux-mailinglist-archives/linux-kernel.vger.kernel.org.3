Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F98A4AA288
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 22:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244616AbiBDVm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 16:42:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245257AbiBDVmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 16:42:35 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1224DC061756
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 13:42:20 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id e1-20020a17090ada0100b001b83a55e809so4589955pjv.7
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 13:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=k5UFgI2I9MLs2H4ssnRT873l7YLngEbdEt/P0KNnq10=;
        b=rf3nxdHlYTt9yk9qc8xQwkwU37D+FTjmdYyFbOS1P0CJyzITmO2YxxakNBUTAi09Z7
         VmbnBDoG1r+DcWx23X9OgAgLLX/SgwPlURVbet91RkY4W2w9BP85AiNHD1Mx6SSY6CTv
         9D18qtAH/LlN4V5MAErzYlF2ZG8mDMM6ifQWpdJCwZzELTkUgbIC4jLNcxOe2sGuc+K4
         MZFIYupxHpxirfJNXPedybQj95fb0rldAC7e9pnl+DVVjXliTXlI8CVNyjbyHDTZ0Mpm
         Un+iqGqPLs15nsCoGBbabN0OC7IT5R/hf5v3NLvZNIA1JeuBmNk5PIuQwZpIRXjCNYRa
         okkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=k5UFgI2I9MLs2H4ssnRT873l7YLngEbdEt/P0KNnq10=;
        b=DVF5I4XyZi4GOcspsdWs5jKP21frgkPRUz750PlLzwqcpCQfYDhypbZMqTLzlpHfvy
         Y5cfuQtsRMTMKXbwY0EvBZlrasLXCBoRrMXAyhN92xe0QQ1ip3yRsW1aGeZ+qz/p6hYh
         S56ne3NVkMrR+cvyBQuqoeGjZk96GuOLVFcs2tCAkwJKfxru0XGQz0GaJ2jNW1rWTulQ
         TTGXejsPQediQ5vOIl/6mcKKdt4KMPs48Yn2+q9Il99jh12seFq/8QkgCtATMOhs+9aM
         INqFyldV3rKfRiLeJjv5HA/0oNbSQkX59Od9kknRDl2FRHVpior4GgTcjKUn/mHwPKFi
         oS7Q==
X-Gm-Message-State: AOAM532SwFeH6+7rzXr2qu1tygBSsDHX6pYj75vCEMSCKUTZS0188nO9
        kaKvQandT5UrlEuFtjpzHTTGsjqzl7k=
X-Google-Smtp-Source: ABdhPJzobXBMkjgYQ5hcgjZNpX3NLiZ6BOhpRK4BZiHqfM7NniGi2ow+0kFIDeKTi+Z0wVXRqNfwwbQXHks=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90a:c68c:: with SMTP id
 n12mr1024171pjt.219.1644010939400; Fri, 04 Feb 2022 13:42:19 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  4 Feb 2022 21:42:01 +0000
In-Reply-To: <20220204214205.3306634-1-seanjc@google.com>
Message-Id: <20220204214205.3306634-8-seanjc@google.com>
Mime-Version: 1.0
References: <20220204214205.3306634-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH 07/11] KVM: x86: Make kvm_lapic_reg_{read,write}() static
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zeng Guang <guang.zeng@intel.com>,
        Chao Gao <chao.gao@intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the low level read/write lapic helpers static, any accesses to the
local APIC from vendor code or non-APIC code should be routed through
proper helpers.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/lapic.c | 8 +++-----
 arch/x86/kvm/lapic.h | 3 ---
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 4f57b6f5ebd4..deac73ce2de5 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -1385,8 +1385,8 @@ static inline struct kvm_lapic *to_lapic(struct kvm_io_device *dev)
 #define APIC_REGS_MASK(first, count) \
 	(APIC_REG_MASK(first) * ((1ull << (count)) - 1))
 
-int kvm_lapic_reg_read(struct kvm_lapic *apic, u32 offset, int len,
-		void *data)
+static int kvm_lapic_reg_read(struct kvm_lapic *apic, u32 offset, int len,
+			      void *data)
 {
 	unsigned char alignment = offset & 0xf;
 	u32 result;
@@ -1442,7 +1442,6 @@ int kvm_lapic_reg_read(struct kvm_lapic *apic, u32 offset, int len,
 	}
 	return 0;
 }
-EXPORT_SYMBOL_GPL(kvm_lapic_reg_read);
 
 static int apic_mmio_in_range(struct kvm_lapic *apic, gpa_t addr)
 {
@@ -2003,7 +2002,7 @@ static void apic_manage_nmi_watchdog(struct kvm_lapic *apic, u32 lvt0_val)
 	}
 }
 
-int kvm_lapic_reg_write(struct kvm_lapic *apic, u32 reg, u32 val)
+static int kvm_lapic_reg_write(struct kvm_lapic *apic, u32 reg, u32 val)
 {
 	int ret = 0;
 
@@ -2151,7 +2150,6 @@ int kvm_lapic_reg_write(struct kvm_lapic *apic, u32 reg, u32 val)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(kvm_lapic_reg_write);
 
 static int apic_mmio_write(struct kvm_vcpu *vcpu, struct kvm_io_device *this,
 			    gpa_t address, int len, const void *data)
diff --git a/arch/x86/kvm/lapic.h b/arch/x86/kvm/lapic.h
index 2b44e533fc8d..ab76896a8c3f 100644
--- a/arch/x86/kvm/lapic.h
+++ b/arch/x86/kvm/lapic.h
@@ -85,9 +85,6 @@ void kvm_lapic_set_base(struct kvm_vcpu *vcpu, u64 value);
 u64 kvm_lapic_get_base(struct kvm_vcpu *vcpu);
 void kvm_recalculate_apic_map(struct kvm *kvm);
 void kvm_apic_set_version(struct kvm_vcpu *vcpu);
-int kvm_lapic_reg_write(struct kvm_lapic *apic, u32 reg, u32 val);
-int kvm_lapic_reg_read(struct kvm_lapic *apic, u32 offset, int len,
-		       void *data);
 bool kvm_apic_match_dest(struct kvm_vcpu *vcpu, struct kvm_lapic *source,
 			   int shorthand, unsigned int dest, int dest_mode);
 int kvm_apic_compare_prio(struct kvm_vcpu *vcpu1, struct kvm_vcpu *vcpu2);
-- 
2.35.0.263.gb82422642f-goog

