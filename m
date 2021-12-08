Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D589D46CA57
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 02:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243197AbhLHB6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 20:58:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234060AbhLHB6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 20:58:16 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B91DC061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 17:54:45 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id j3-20020a634a43000000b00325af3ab5f0so435633pgl.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 17:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=JPQ6j/8Xcv0ZDoVXkCoBftcZyNezl+x5YdkfDBVpnRI=;
        b=qAqDIWUEHqQyDYxwc0+4yVfPyvyNpDFCJVxAudjYg2EtOtdKAPSrzURp++VyziDdd4
         +sZTKUjhSYuPd8BT/jGf92EPsIMU5itBK3Mgwpr7S/TnW98GgL/OMOr1plBEbRiAibw8
         xcOVwxCb8wL+Aj4nGsObFCq7lkhljjtdfD3bDJTmAWWewZvJ3TFRNyvAdXFoVWVozYKV
         Wbk017UDqhXPuGbPPpUYMY7bRDsqCQYs57AZqbAsbhB39e4U7hm2IZecAv9nuLRPnF4o
         f5P3BfzEjv2BjzRG0vyhp9Z+O5hJU5RL0U+joxSgtorf336zBd+XOm1O1U3g5fu4mSg+
         WEYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=JPQ6j/8Xcv0ZDoVXkCoBftcZyNezl+x5YdkfDBVpnRI=;
        b=rtq7yu8IoswcnRpEB6Qz4oVM/FKmsGblQ/ydaQajxyA2aTCjzE0+Hg0j2H7bmwnO+l
         Pd2TR7wWDBrMxXRfKlLoIOUbdHSJGhU8APsQxK+YNr83nBncuTsYctEzq17ro+Tue4Jp
         r2b8f0UqRNDYWaQAtclJAvK/YKfng9BlINwMfOnDw8GEopAHesi+awmS9iIviU2nSjLc
         2J0/klijIzaIqM2zOSIagVbLg72VaAasQKaZr0+Wk0oKNyQsxhnA3YkR5YA0vkTYohu9
         Wf+M97vzrQLViPD9+uiEKgZ37Z6LytJGmOYCKWt1Xk363O7m+92Y3DzBd7x1bDs3j6er
         9yag==
X-Gm-Message-State: AOAM533sPKQik5VMCc5VIgdJ/mwIE/EsOZyCFLxqyElMJCcJBEfroBr8
        R6cfPEQkZ2NKx3K+nahWmom+sr0p6G4=
X-Google-Smtp-Source: ABdhPJzxCNWX1tuxOjc/ou63x3Jxba7eb96x4TWBltqYeCrNS7u7paGPYAYB4fpGzXGrtX5cewu2W8J1gUc=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90b:1b52:: with SMTP id
 nv18mr3632061pjb.43.1638928484575; Tue, 07 Dec 2021 17:54:44 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  8 Dec 2021 01:52:10 +0000
Message-Id: <20211208015236.1616697-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH v3 00/26] KVM: x86: Halt and APICv overhaul
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, Joerg Roedel <joro@8bytes.org>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        kvm@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Overhaul and cleanup APIC virtualization (Posted Interrupts on Intel VMX,
AVIC on AMD SVM) to streamline things as much as possible, remove a bunch
of cruft, and document the lurking gotchas along the way.

Patch 01 is a fix from Paolo that's already been merged but hasn't made
its way to kvm/queue.  It's included here to avoid a number of conflicts.

Based on kvm/queue, commit 1cf84614b04a ("KVM: x86: Exit to ...")

v3:
 - Rebase to kvm/queue (and drop non-x86 patches as they've been queued). 
 - Redo AVIC patches, sadly the vcpu_(un)blocking() hooks need to stay.
 - Add a patch to fix a missing (docuentation-only) barrier in nested
   posted interrupt delivery. [Paolo]
 - Collect reviews.

v2:
 - https://lore.kernel.org/all/20211009021236.4122790-1-seanjc@google.com/
 - Collect reviews. [Christian, David]
 - Add patch to move arm64 WFI functionality out of hooks. [Marc]
 - Add RISC-V to the fun.
 - Add all the APICv fun.

v1: https://lkml.kernel.org/r/20210925005528.1145584-1-seanjc@google.com

Paolo Bonzini (1):
  KVM: fix avic_set_running for preemptable kernels

Sean Christopherson (25):
  KVM: nVMX: Ensure vCPU honors event request if posting nested IRQ
    fails
  KVM: VMX: Clean up PI pre/post-block WARNs
  KVM: VMX: Handle PI wakeup shenanigans during vcpu_put/load
  KVM: Drop unused kvm_vcpu.pre_pcpu field
  KVM: Move x86 VMX's posted interrupt list_head to vcpu_vmx
  KVM: VMX: Move preemption timer <=> hrtimer dance to common x86
  KVM: x86: Unexport LAPIC's switch_to_{hv,sw}_timer() helpers
  KVM: x86: Remove defunct pre_block/post_block kvm_x86_ops hooks
  KVM: SVM: Signal AVIC doorbell iff vCPU is in guest mode
  KVM: SVM: Don't bother checking for "running" AVIC when kicking for
    IPIs
  KVM: SVM: Remove unnecessary APICv/AVIC update in vCPU unblocking path
  KVM: SVM: Use kvm_vcpu_is_blocking() in AVIC load to handle preemption
  KVM: SVM: Skip AVIC and IRTE updates when loading blocking vCPU
  iommu/amd: KVM: SVM: Use pCPU to infer IsRun state for IRTE
  KVM: VMX: Don't do full kick when triggering posted interrupt "fails"
  KVM: VMX: Wake vCPU when delivering posted IRQ even if vCPU == this
    vCPU
  KVM: VMX: Pass desired vector instead of bool for triggering posted
    IRQ
  KVM: VMX: Fold fallback path into triggering posted IRQ helper
  KVM: VMX: Don't do full kick when handling posted interrupt wakeup
  KVM: SVM: Drop AVIC's intermediate avic_set_running() helper
  KVM: SVM: Move svm_hardware_setup() and its helpers below svm_x86_ops
  KVM: SVM: Nullify vcpu_(un)blocking() hooks if AVIC is disabled
  KVM: x86: Skip APICv update if APICv is disable at the module level
  KVM: x86: Drop NULL check on kvm_x86_ops.check_apicv_inhibit_reasons
  KVM: x86: Unexport __kvm_request_apicv_update()

 arch/x86/include/asm/kvm-x86-ops.h |   2 -
 arch/x86/include/asm/kvm_host.h    |  12 -
 arch/x86/kvm/hyperv.c              |   3 +
 arch/x86/kvm/lapic.c               |   2 -
 arch/x86/kvm/svm/avic.c            | 116 ++++---
 arch/x86/kvm/svm/svm.c             | 479 ++++++++++++++---------------
 arch/x86/kvm/svm/svm.h             |  16 +-
 arch/x86/kvm/vmx/posted_intr.c     | 234 +++++++-------
 arch/x86/kvm/vmx/posted_intr.h     |   8 +-
 arch/x86/kvm/vmx/vmx.c             |  66 ++--
 arch/x86/kvm/vmx/vmx.h             |   3 +
 arch/x86/kvm/x86.c                 |  41 ++-
 drivers/iommu/amd/iommu.c          |   6 +-
 include/linux/amd-iommu.h          |   6 +-
 include/linux/kvm_host.h           |   3 -
 virt/kvm/kvm_main.c                |   3 -
 16 files changed, 510 insertions(+), 490 deletions(-)

-- 
2.34.1.400.ga245620fadb-goog

