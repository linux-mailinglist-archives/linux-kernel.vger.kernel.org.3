Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D397D49EFF9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 01:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344774AbiA1AxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 19:53:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344753AbiA1AxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 19:53:14 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916D0C061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 16:53:14 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id u133-20020a63798b000000b0034c0630b044so2395676pgc.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 16:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=F61j0F7c9zoKgby3PQl1mNL9ZrlLxor56/UJzaP+oiU=;
        b=CEqXBfrBZd79fyTbp0puUZP/DX5xUEbmTFg98TZPwU9bR0LE3VV/wlifZ2L6BOcLyF
         d8hBJk06qo84fmxQMNzVsV4yCCLovsiFjTge54eju+46uSveSM8vfoenGh/mBxhB1Iyp
         MxBir0niAx+VwqtFciM4MMO77q2SAYj0VliLbxXfAs79638xGPUwuaPPrQVddvKflWr4
         f21jn8j1pP5x/PiEz5giVePsELBVa2BNao7TXicb63D+B7T3tz+UiA5GFssy55uJL3tb
         uPhXVy4qqbYIFuM5iIQrXi6WpTy0vrFM2rQ3lQOOQRqmoGBflY+cNPiW2a0P0VN1g0uh
         H2nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=F61j0F7c9zoKgby3PQl1mNL9ZrlLxor56/UJzaP+oiU=;
        b=kbIG5nVKFj3lAoCgniht5A06t8lYDPomIqgSMoRLJVGNPsT3a51rFTiJnyHuvGECeF
         Kn4d6rzzP8CSXZDF9BDjFWpEJL0gIPyTYUF5iJ1mbeElB2VjLeUENPLR8W9hgQf8Ss8f
         eRwKluldtiFwo/7Hb85VDYFJXeoTcRRZHtXNj3oa3vMe1+u1jBiYuvokdYEdOQgY3+yX
         qeX3+McXxZGqUMJ+0TkDdaOamfVRto/eGtFGjcHObs3BNqGCrQDMjuAsI2ha580yo9qZ
         RvxKyzLtsBOv362i4eiIm3rPSjHk37hUQY7eKbhoY3w0Q8I6mHphlFVCoIFhP3R7MqAg
         6nnA==
X-Gm-Message-State: AOAM533rbdG3vQk+xaXFM9Mwwd8tL/lm/ADkKcWJq6FoDD4z/u2NOKrL
        Uml0dcHxWTvmJCvrgLURYO/Ceuxvbto=
X-Google-Smtp-Source: ABdhPJxKMzW9sJVgtEOECBfryqZAa4rBQSxux7XpGkq+Z6SfHqHwtDOqJKUEV8pkZ/VNpPSwcL61rA/o3ug=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90a:d494:: with SMTP id
 s20mr7010937pju.239.1643331194087; Thu, 27 Jan 2022 16:53:14 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 28 Jan 2022 00:51:46 +0000
Message-Id: <20220128005208.4008533-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
Subject: [PATCH 00/22] KVM: x86: Fill *_x86_ops via kvm-x86-ops.h
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Like Xu <like.xu.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kvm-x86-ops.h to fill vmx_x86_ops and svm_x86_ops, with a bunch of
cleanup along the way to make that happen.  Aside from removing a lot of
boilerplate code, the part I most like about fill via kvm-x86-ops.h is
that it provides enforcement that (a) new kvm_x86_ops hooks get added to
kvm-x86-ops.h and (b) vendor code has to implement _something_, even if
it's a redirect to NULL, which provides documentation of what's going on.

Patch 01 isn't exactly necessary for this series, my hope is that Maxim's
bug fix for the AVIC race can go on top without introducing too much
conflict for either of us.

Sean Christopherson (22):
  KVM: x86: Drop unnecessary and confusing KVM_X86_OP_NULL macro
  KVM: x86: Move delivery of non-APICv interrupt into vendor code
  KVM: x86: Drop export for .tlb_flush_current() static_call key
  KVM: x86: Rename kvm_x86_ops pointers to align w/ preferred vendor
    names
  KVM: x86: Use static_call() for .vcpu_deliver_sipi_vector()
  KVM: VMX: Call vmx_get_cpl() directly in handle_dr()
  KVM: xen: Use static_call() for invoking kvm_x86_ops hooks
  KVM: nVMX: Refactor PMU refresh to avoid referencing
    kvm_x86_ops.pmu_ops
  KVM: x86: Uninline and export hv_track_root_tdp()
  KVM: x86: Unexport kvm_x86_ops
  KVM: x86: Use static_call() for copy/move encryption context ioctls()
  KVM: x86: Allow different macros for APICv, CVM, and Hyper-V
    kvm_x86_ops
  KVM: VMX: Rename VMX functions to conform to kvm_x86_ops names
  KVM: VMX: Use kvm-x86-ops.h to fill vmx_x86_ops
  KVM: x86: Move get_cs_db_l_bits() helper to SVM
  KVM: SVM: Rename svm_flush_tlb() to svm_flush_tlb_current()
  KVM: SVM: Remove unused MAX_INST_SIZE #define
  KVM: SVM: Rename AVIC helpers to use "avic" prefix instead of "svm"
  KVM: x86: Use more verbose names for mem encrypt kvm_x86_ops hooks
  KVM: SVM: Rename SEV implemenations to conform to kvm_x86_ops hooks
  KVM: SVM: Rename hook implementations to conform to kvm_x86_ops' names
  KVM: SVM: Use kvm-x86-ops.h to fill svm_x86_ops

 arch/x86/include/asm/kvm-x86-ops.h | 131 ++++++++++--------
 arch/x86/include/asm/kvm_host.h    |  32 ++---
 arch/x86/kvm/kvm_onhyperv.c        |  14 ++
 arch/x86/kvm/kvm_onhyperv.h        |  14 +-
 arch/x86/kvm/lapic.c               |  12 +-
 arch/x86/kvm/mmu/mmu.c             |   6 +-
 arch/x86/kvm/svm/avic.c            |  28 ++--
 arch/x86/kvm/svm/sev.c             |  18 +--
 arch/x86/kvm/svm/svm.c             | 214 ++++++++++-------------------
 arch/x86/kvm/svm/svm.h             |  41 +++---
 arch/x86/kvm/vmx/nested.c          |   5 +-
 arch/x86/kvm/vmx/nested.h          |   3 +-
 arch/x86/kvm/vmx/pmu_intel.c       |   3 +-
 arch/x86/kvm/vmx/posted_intr.c     |   6 +-
 arch/x86/kvm/vmx/posted_intr.h     |   4 +-
 arch/x86/kvm/vmx/vmx.c             | 178 +++++++-----------------
 arch/x86/kvm/x86.c                 |  79 +++++------
 arch/x86/kvm/xen.c                 |   4 +-
 18 files changed, 324 insertions(+), 468 deletions(-)


base-commit: b029c138e8f090f5cb9ba77ef20509f903ef0004
-- 
2.35.0.rc0.227.g00780c9af4-goog

