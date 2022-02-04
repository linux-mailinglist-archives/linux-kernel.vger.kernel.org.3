Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8454AA276
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 22:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243847AbiBDVmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 16:42:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243601AbiBDVmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 16:42:14 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D84C061744
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 13:42:13 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id y14-20020a17090ad70e00b001b4fc2943b3so9380638pju.8
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 13:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=TdH95enMzJJtQ2GBUCNs/cXCeWPtOzD0p9PqnB4JpY4=;
        b=e8F5y4+zCpfLkf3ITn/fKXeG/MnU2wzed6XAI/1vnBN0IyKDVi5Ur8Ka4lIs/xw+Ye
         SnJaBqh1ZIvsiZmW4iiyI5f60WVpXtXiGl8RFEw/NdrsIj4zI/Xt6XcZjMEZW5VyBseI
         gQOASiGWEF0K1EyygeBP6iNRzZnIiLQCS3q3Tmr6pnvjXMcIYL1oCRqC5C0bZCAG5hG5
         fWBwYjCZmB84El+8G5WCIFep5LB8G8/Oy78fc/WRDo94hH4J2TyH+8dtk+TeETM3DpBo
         GeDjejtXeSg3ohWAFymxUlnXCwZhWTGVZrl9+nThlTWNpcsljofJJ47WYF2v0yZ5CxFd
         AQmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=TdH95enMzJJtQ2GBUCNs/cXCeWPtOzD0p9PqnB4JpY4=;
        b=uDgkXWuFR3jrUdFoCNLDljT4O1brmRLL1ctdAYNzg68pzNWO1CSKklq2TsTMJt4sjV
         3QT4We8GPwXMwjheDVmZYcaT1Z4s//Rx6pKLfVWf7SRXrp59J0HUrwnxvWWtDlxJNaib
         rDpyeFIc0azJo5pWhxeSUMS5DOAWbSqSxoFMUHWyh806UxL3JY5KoanA/JS+A7fk9vB4
         0oNM/Ren/jTa22nOAUSU5xHi0qKIQOzNqqfiK9QXCZEQaNEqE8ss8PMK14JiC9iUs8vh
         vfZhnCycms64X32DOGafnD9Xzc7cD/bDPQpqhAl+A64JFQrQ/5tB6oIBfb76ZkwVkH5b
         quyg==
X-Gm-Message-State: AOAM533+DwM0MKSKh+ESBiSLd+aM2cenhrBkPTaRvdf8T1VohyBpwvrX
        x3WnNUcfGpdIzRXxIKC4k4b2O65iKtk=
X-Google-Smtp-Source: ABdhPJwnnfJh8326UurBNxqNtN00zf9kHpWCIxoTekltxMVnjj1SgV8TA0ZRNUkuLuhzB8/J+H0x7OkaQ00=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:6f10:: with SMTP id
 w16mr5054914plk.142.1644010932639; Fri, 04 Feb 2022 13:42:12 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  4 Feb 2022 21:41:57 +0000
In-Reply-To: <20220204214205.3306634-1-seanjc@google.com>
Message-Id: <20220204214205.3306634-4-seanjc@google.com>
Mime-Version: 1.0
References: <20220204214205.3306634-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH 03/11] KVM: x86: Use "raw" APIC register read for handling
 APIC-write VM-Exit
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the "raw" helper to read the vAPIC register after an APIC-write trap
VM-Exit.  Hardware is responsible for vetting the write, and the caller
is responsible for sanitizing the offset.  This is a functional change,
as it means KVM will consume whatever happens to be in the vAPIC page if
the write was dropped by hardware.  But, unless userspace deliberately
wrote garbage into the vAPIC page via KVM_SET_LAPIC, the value should be
zero since it's not writable by the guest.

This aligns common x86 with SVM's AVIC logic, i.e. paves the way for
using the nodecode path to handle APIC-write traps when AVIC is enabled.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/lapic.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index fbce455a9d17..2c88815657a9 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2186,9 +2186,7 @@ EXPORT_SYMBOL_GPL(kvm_lapic_set_eoi);
 /* emulate APIC access in a trap manner */
 void kvm_apic_write_nodecode(struct kvm_vcpu *vcpu, u32 offset)
 {
-	u32 val = 0;
-
-	kvm_lapic_reg_read(vcpu->arch.apic, offset, 4, &val);
+	u32 val = kvm_lapic_get_reg(vcpu->arch.apic, offset);
 
 	/* TODO: optimize to just emulate side effect w/o one more write */
 	kvm_lapic_reg_write(vcpu->arch.apic, offset, val);
-- 
2.35.0.263.gb82422642f-goog

