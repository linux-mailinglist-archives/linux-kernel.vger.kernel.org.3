Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED60850C665
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 04:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbiDWCRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 22:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiDWCRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 22:17:12 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A768521743B
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 19:14:13 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id bj12-20020a056a02018c00b003a9eebaad34so5962574pgb.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 19:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=lga5SX9wwlH6iXTjGCkZNdU+mF1h6VNNYWdofZefQoQ=;
        b=Ar3nvOusu1xUjBNKJIWHoWfKpkQ2DC1j+vfsZeV0pbFFe0w2Ca6Ud8UP4nDBggrM/Q
         AJ05xtF4ELmvZSZmgLSsdV+btP+AGGD2wKpYcGXXSpilmmO+mfvCnNAZAOO3++/Q2IK2
         r+qIfTBMjBXJZ8Gfvw2XNAuW36T+fz6/b2yj05+eYMgSwBU2G+VEnrtQkYB8QEuW99TW
         O21GStphUZ6h5RN2W33qj4CEOI72+7WkgkeF1xZT20MT/q1m2Sc6Pg3U91Z5IypxWO6A
         kWCee/7RW9pFDShHMhqIiMHSrBbb+md4cgglCV/mgrn5MtPZs9m6V9kxgkgoV5NT03pt
         Y8VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=lga5SX9wwlH6iXTjGCkZNdU+mF1h6VNNYWdofZefQoQ=;
        b=ZcUCTQ8En5Itnz8Vj17JiqXT9lCQtu/MB6q1eNerrqSqMC846VdeuApreFHJwJ9P2I
         6uYG5+bgAij/HxWLNGVQcT6xTBETl0+Q/daNkZTGRQ61/mG6Cj0/Fb4UTFufjVOn5uLa
         w7lvK5p/9e2aCk6KEIU3XtzPgADlWQ+UUfQc7q7BGKiMro3E6/hf5E3zuSYRR+EQCrK+
         A6KW+ZGZYqL0BeY3fzNAuv7YH3xa6SH9V1bE3mpNKhLXJ4hPbkFXLsOd88Zftu7RHlLu
         goMbyZuWZrIvbQ0ubiPukX+tuv4h81r5HQ1gFSUOr0YH+nNmeWJm5OpX+mjprygJ7Z44
         cI4Q==
X-Gm-Message-State: AOAM532hG7WoPs0nz1RH5gan60A5aLCsUk1py7wwwP1px+PFffyiF+QM
        hrCvTiijYLDciQdm0WsyhjNGcbSp348=
X-Google-Smtp-Source: ABdhPJwQ8/aUQUtuzGWmLPl2e/WfDGGRnhWAfqh2zS2aUVfBmyCyAtTXTmNErdui41AYXdJwTWazT4BksvY=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90a:c781:b0:1d0:c23e:5842 with SMTP id
 gn1-20020a17090ac78100b001d0c23e5842mr19434228pjb.182.1650680053199; Fri, 22
 Apr 2022 19:14:13 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Sat, 23 Apr 2022 02:14:00 +0000
Message-Id: <20220423021411.784383-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH v2 00/11] KVM: SVM: Fix soft int/ex re-injection
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>,
        "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix soft interrupt/exception reinjection on SVM.

The underlying issue is that SVM simply retries INT* instructions instead
of reinjecting the soft interupt/exception if an exception VM-Exit occurred
during vectoring.  Lack of reinjection breaks nested virtualization if
the injected event came from L1 and the VM-Exit is not forwarded to L1,
as there is no instruction to retry.  More fundamentally, retrying the
instruction is wrong as it can produce side effects that shouldn't occur,
e.g. code #DBs.

VMX has been fixed since commit 66fd3f7f901f ("KVM: Do not re-execute
INTn instruction."), but SVM was left behind.  Probably because fixing
SVM is a mess due to NRIPS not being supported on all architectures, and
due to it being poorly implemented (with respect to soft events) when it
is supported.

Opportunistically clean up related tracepoints to make debugging related
issues less painful in the future.

The last patch is not-signed-off-by as I think it needs broader review
and feedback before KVM drops support for CPUs that are old, but not
thaaaaat old.

The tracepoint output looks like:

    kvm_inj_exception: #GP (0x0) 
    kvm_inj_exception: #UD       
    kvm_inj_exception: #DE       
    kvm_inj_exception: #DE [reinjected]
    kvm_inj_exception: #BP [reinjected]
    kvm_inj_exception: #NP (0x18) [reinjected]

and for "irqs":

    kvm_inj_virq: Soft/INTn 0x20 [reinjected]
    kvm_inj_virq: Soft/INTn 0x19 [reinjected]
    kvm_inj_virq: IRQ 0x20
    kvm_inj_virq: IRQ 0xf1

v2:
  - Collect reviews. [Maxim]
  - Drop a stale comment midway through. [Paolo]
  - Correctly handle (at least as correctly as SVM allows) the scenario
    where an injected soft interrupt/exception has no backing insn. [Maxim]
  - Tag reinjected exceptions in the tracepoint. [Maxim]
  - Use the correct L2 RIP (hopefully) in svm_set_nested_state. [Maciej]
  - Fix a BUG that can be triggered by userspace.
  - Fix the error code FIXME in the exception tracepoint.
  - Differentiate soft vs. hard "IRQ" injection in tracepoint.
  - Assert that the first soft int is injected on the correct RIP in
    the selftest.

v1:
  https://lore.kernel.org/all/20220402010903.727604-1-seanjc@google.com

Maciej's original series:
  https://lore.kernel.org/all/cover.1646944472.git.maciej.szmigiero@oracle.com

Maciej S. Szmigiero (3):
  KVM: nSVM: Sync next_rip field from vmcb12 to vmcb02
  KVM: SVM: Don't BUG if userspace injects a soft interrupt with GIF=0
  KVM: selftests: nSVM: Add svm_nested_soft_inject_test

Sean Christopherson (8):
  KVM: SVM: Unwind "speculative" RIP advancement if INTn injection
    "fails"
  KVM: SVM: Stuff next_rip on emulated INT3 injection if NRIPS is
    supported
  KVM: SVM: Re-inject INT3/INTO instead of retrying the instruction
  KVM: SVM: Re-inject INTn instead of retrying the insn on "failure"
  KVM: x86: Trace re-injected exceptions
  KVM: x86: Print error code in exception injection tracepoint iff valid
  KVM: x86: Differentiate Soft vs. Hard IRQs vs. reinjected in
    tracepoint
  KVM: SVM: Drop support for CPUs without NRIPS (NextRIP Save) support

 arch/x86/include/asm/kvm_host.h               |   2 +-
 arch/x86/kvm/svm/nested.c                     |  46 ++++-
 arch/x86/kvm/svm/svm.c                        | 169 ++++++++++++------
 arch/x86/kvm/svm/svm.h                        |   7 +-
 arch/x86/kvm/trace.h                          |  31 ++--
 arch/x86/kvm/vmx/vmx.c                        |   4 +-
 arch/x86/kvm/x86.c                            |  20 ++-
 tools/testing/selftests/kvm/.gitignore        |   3 +-
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/include/x86_64/svm_util.h   |   2 +
 .../kvm/x86_64/svm_nested_soft_inject_test.c  | 149 +++++++++++++++
 11 files changed, 351 insertions(+), 83 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86_64/svm_nested_soft_inject_test.c


base-commit: 2a39d8b39bffdaf1a4223d0d22f07baee154c8f3
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

