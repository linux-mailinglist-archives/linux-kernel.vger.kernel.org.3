Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E1C4AA281
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 22:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245012AbiBDVmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 16:42:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245281AbiBDVmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 16:42:35 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607B7C061757
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 13:42:21 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id u24-20020a656718000000b0035e911d79edso3563398pgf.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 13:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=sgsbkKdz2qv2FXG09nA4Dyprdi3Gq/6g5DB7ZBRJjpY=;
        b=LfJecY8bfswe0Obq/0ADWYxzAWtAa9m1H+L4CGphGRDFk/50SlEGXI3AgyIkX6GBYu
         KoVBhn6tjZNXpvuIYwT1UBV4gJXKb4Y6rgqDclKUZd9f56ygrbhZMYwppETmePaNONkd
         q429IvbPrJc6MXWFRoO2t5hioFu/qm+dzNcXQXyGIaxi4aOkh11eH6giARfwxAr1NyoR
         2+lCTFHBy3El6OmRqjP3xMnBSTuMJFSq1Ebm/33SG04kLI/XPe+SMeDsnqikLX8Yu7a4
         ht/TwwYyKTn4wqMEQjWs2zL1oSWAx0VE9CvtJ5WsrslrbqsqalSQvwdVRB//tiDOntjK
         vS2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=sgsbkKdz2qv2FXG09nA4Dyprdi3Gq/6g5DB7ZBRJjpY=;
        b=DZkiPnycdvCO1mO0UpfmuGF2LR+2uV+m/I5BxSJp/hhl5yFv+CDrSwUtYSKZB3NvGb
         BKvwtkFkfX/HVrRwQACWiY58M6pKf54IHtW+/zEP1qVEF0Jeq1b6waBMMwlMLRqoNcM/
         NkpYWYee405o1CfmkcaVo/d8YSsMw6Cd+7SPX6TiDmVwbIwamQLHTK2u1Iy+eYl8OPKy
         fwiA6WcS39Q8QROi5/UF/QRTsH4sTMzMpHR7rJc98eQxpeesICZVbi9WofCxekY7houe
         w159ZflbuGAO/tXDNfTbQQBeitWKhqrPnzRxHR4HrByhT2Ks10XS7Bn9YeJLSpqrJCpi
         L1yA==
X-Gm-Message-State: AOAM5306R+Ka6w8yg4coRD1kG57K/HItbuUy8oq/2O5SPfRSozmpsz/0
        uftRzpYBhAnE8KB8LB6NZ2jJ6kFrEPs=
X-Google-Smtp-Source: ABdhPJy7FJuqPcLbQKNHEQRuKC9U+zfC0HEdCChADyHE9+q8023qCbOXEFmL4tY7gGtspBZ4TwRkiNVHARw=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90b:1009:: with SMTP id
 gm9mr1010663pjb.223.1644010937744; Fri, 04 Feb 2022 13:42:17 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  4 Feb 2022 21:42:00 +0000
In-Reply-To: <20220204214205.3306634-1-seanjc@google.com>
Message-Id: <20220204214205.3306634-7-seanjc@google.com>
Mime-Version: 1.0
References: <20220204214205.3306634-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH 06/11] KVM: x86: WARN if KVM emulates an IPI without clearing
 the BUSY flag
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

WARN if KVM emulates an IPI without clearing the BUSY flag, failure to do
so could hang the guest if it waits for the IPI be sent.

Opportunistically use APIC_ICR_BUSY macro instead of open coding the
magic number, and add a comment to clarify why kvm_recalculate_apic_map()
is unconditionally invoked (it's really, really confusing for IPIs due to
the existence of fast paths that don't trigger a potential recalc).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/lapic.c | 10 +++++++++-
 arch/x86/kvm/x86.c   |  9 ++++-----
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 6e1f9e83eb68..4f57b6f5ebd4 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -1282,6 +1282,9 @@ void kvm_apic_send_ipi(struct kvm_lapic *apic, u32 icr_low, u32 icr_high)
 {
 	struct kvm_lapic_irq irq;
 
+	/* KVM has no delay and should always clear the BUSY/PENDING flag. */
+	WARN_ON_ONCE(icr_low & APIC_ICR_BUSY);
+
 	irq.vector = icr_low & APIC_VECTOR_MASK;
 	irq.delivery_mode = icr_low & APIC_MODE_MASK;
 	irq.dest_mode = icr_low & APIC_DEST_MASK;
@@ -2060,7 +2063,7 @@ int kvm_lapic_reg_write(struct kvm_lapic *apic, u32 reg, u32 val)
 	}
 	case APIC_ICR:
 		/* No delay here, so we always clear the pending bit */
-		val &= ~(1 << 12);
+		val &= ~APIC_ICR_BUSY;
 		kvm_apic_send_ipi(apic, val, kvm_lapic_get_reg(apic, APIC_ICR2));
 		kvm_lapic_set_reg(apic, APIC_ICR, val);
 		break;
@@ -2139,6 +2142,11 @@ int kvm_lapic_reg_write(struct kvm_lapic *apic, u32 reg, u32 val)
 		break;
 	}
 
+	/*
+	 * Recalculate APIC maps if necessary, e.g. if the software enable bit
+	 * was toggled, the APIC ID changed, etc...   The maps are marked dirty
+	 * on relevant changes, i.e. this is a nop for most writes.
+	 */
 	kvm_recalculate_apic_map(apic->vcpu->kvm);
 
 	return ret;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c25a6ef0ff06..9024e33c2add 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2012,11 +2012,10 @@ static int handle_fastpath_set_x2apic_icr_irqoff(struct kvm_vcpu *vcpu, u64 data
 		return 1;
 
 	if (((data & APIC_SHORT_MASK) == APIC_DEST_NOSHORT) &&
-		((data & APIC_DEST_MASK) == APIC_DEST_PHYSICAL) &&
-		((data & APIC_MODE_MASK) == APIC_DM_FIXED) &&
-		((u32)(data >> 32) != X2APIC_BROADCAST)) {
-
-		data &= ~(1 << 12);
+	    ((data & APIC_DEST_MASK) == APIC_DEST_PHYSICAL) &&
+	    ((data & APIC_MODE_MASK) == APIC_DM_FIXED) &&
+	    ((u32)(data >> 32) != X2APIC_BROADCAST)) {
+		data &= ~APIC_ICR_BUSY;
 		kvm_apic_send_ipi(vcpu->arch.apic, (u32)data, (u32)(data >> 32));
 		kvm_lapic_set_reg(vcpu->arch.apic, APIC_ICR2, (u32)(data >> 32));
 		kvm_lapic_set_reg(vcpu->arch.apic, APIC_ICR, (u32)data);
-- 
2.35.0.263.gb82422642f-goog

