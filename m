Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0DE5ABBA9
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 02:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbiICAXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 20:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiICAXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 20:23:00 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC9CF63D7
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 17:22:59 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id a9-20020a17090a8c0900b001fff9a99c0fso1525836pjo.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 17:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date;
        bh=0j7MSpIXd0q2GhPEJ3BS0PsB62uO0eOMnRwnKzDz08g=;
        b=s4lyhcm5HaQP8/H13vmtetQuSvCpB2maDrfqBSZsBiTH6sJUfC42q5kV1dTH9e8QwT
         ZD2QNBWOPUr9YvJyZnMw+TxaRFcuebzVNGMt8i3dueX+aY8pTVQ9ikBnvGQKSajZKhZc
         iD/4u1XxRGiC0N4EAImOTWox95ZTQGH+slLWLR4LsG4SE6N8owAJmMlY191yHf9eJv5O
         1ogUo+RQp/D9wsTYtOf/4w8IuQ126wqhI6qvMxBvaLiq+UqXdC/9MzhA3xMjnRevYiY9
         VbHA0Cvj+Mqu8Fb4nWeFXiF5E6fJ0RceIKJjvDqpnoxJs4VEayibp7zJi0vrBYNUCS73
         sWzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date;
        bh=0j7MSpIXd0q2GhPEJ3BS0PsB62uO0eOMnRwnKzDz08g=;
        b=cSjJr3wBIKpXZQhXb9K5PDdafbwSMKpMoorkkh/Bf/qd6suiLuiazptFg8rr/Qsx0P
         7HavLBeWGO401c08f0379DiOwRDdU8i4L1Boys/WhOQTYfpmEllW4dDvpXdTqMOBhZNH
         uEZ0F8q3EQ9/YUCzUAo986bYeTx8OeUxuEaykn6823le+2YZ2wHcaimrMuFW8zUvglSH
         8VR2ZtXETsK4HeLocS0THTXdemF/stGAb9HdOf4iRG1ij30hMHI0prt9VgD31+70WOJK
         5Km7tiLoE5vPA1QUjnV82jznoDF42bdsQY374jQ0yBEksW/qi3ZCOWiVKn4cas9J7r0s
         swGw==
X-Gm-Message-State: ACgBeo0uGQ4un+nxM1uNkUEh1rwF9USsGBrcxR7e7EwTDCa4W+K8XDMe
        x3Q9k09IcWme+ymBsAeRK7P/Oga32KY=
X-Google-Smtp-Source: AA6agR4QXzjexqiug2t1VU1SaYqlM3t8Px+9ZriS3I+E0zHBH7sqCcNoooCRRS3XElkbS4jYv5ApSn/86kU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:aa7:8551:0:b0:538:22ec:d965 with SMTP id
 y17-20020aa78551000000b0053822ecd965mr28942077pfn.16.1662164578867; Fri, 02
 Sep 2022 17:22:58 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Sat,  3 Sep 2022 00:22:31 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220903002254.2411750-1-seanjc@google.com>
Subject: [PATCH v2 00/23] KVM: x86: AVIC and local APIC fixes+cleanups
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Li RongQing <lirongqing@baidu.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bugs for everyone!  Two new notable bug fixes:

  - Purge vCPU's "highest ISR" cache when toggling APICv
  - Flush TLB when activating AVIC

TL;DR: KVM's AVIC and optimized APIC map code doesn't correctly handle
various edge cases that are architecturally legal(ish), but are unlikely
to occur in most real world scenarios.

I have tested this heavily with KUT, but I haven't booted Windows and
don't have access to x2AVIC, so additional testing would be much
appreciated.

v2:
  - Collect reviews. [Li, Maxim]
  - Disable only MMIO access when x2APIC is enabled (instead of disabling
    all of AVIC). [Maxim]
  - Inhibit AVIC when logical IDs are aliased. [Maxim]
  - Tweak name of set_virtual_apic_mode() hook. [Maxim]
  - Straight up revert logical ID fastpath mess. [Maxim]
  - Reword changelog about skipping vCPU during logical setup. [Maxim]
  - Fix LDR updates on AVIC. [Maxim?]
  - Fix a nasty ISR caching bug.
  - Flush TLB when activating AVIC.

v1: https://lore.kernel.org/all/20220831003506.4117148-1-seanjc@google.com

Sean Christopherson (22):
  KVM: x86: Purge "highest ISR" cache when updating APICv state
  KVM: SVM: Flush the "current" TLB when activating AVIC
  KVM: SVM: Process ICR on AVIC IPI delivery failure due to invalid
    target
  KVM: x86: Inhibit AVIC SPTEs if any vCPU enables x2APIC
  KVM: SVM: Don't put/load AVIC when setting virtual APIC mode
  KVM: SVM: Replace "avic_mode" enum with "x2avic_enabled" boolean
  KVM: SVM: Compute dest based on sender's x2APIC status for AVIC kick
  Revert "KVM: SVM: Use target APIC ID to complete x2AVIC IRQs when
    possible"
  KVM: SVM: Document that vCPU ID == APIC ID in AVIC kick fastpatch
  KVM: SVM: Add helper to perform final AVIC "kick" of single vCPU
  KVM: x86: Disable APIC logical map if logical ID covers multiple MDAs
  KVM: x86: Disable APIC logical map if vCPUs are aliased in logical
    mode
  KVM: x86: Honor architectural behavior for aliased 8-bit APIC IDs
  KVM: x86: Explicitly skip adding vCPU to optimized logical map if
    LDR==0
  KVM: x86: Explicitly track all possibilities for APIC map's logical
    modes
  KVM: SVM: Inhibit AVIC if vCPUs are aliased in logical mode
  KVM: SVM: Always update local APIC on writes to logical dest register
  KVM: SVM: Update svm->ldr_reg cache even if LDR is "bad"
  KVM: SVM: Require logical ID to be power-of-2 for AVIC entry
  KVM: SVM: Handle multiple logical targets in AVIC kick fastpath
  KVM: SVM: Ignore writes to Remote Read Data on AVIC write traps
  Revert "KVM: SVM: Do not throw warning when calling avic_vcpu_load on
    a running vcpu"

Suravee Suthikulpanit (1):
  KVM: SVM: Fix x2APIC Logical ID calculation for
    avic_kick_target_vcpus_fast

 Documentation/virt/kvm/x86/errata.rst |  11 +
 arch/x86/include/asm/kvm_host.h       |  37 ++-
 arch/x86/kvm/lapic.c                  | 112 +++++++--
 arch/x86/kvm/mmu/mmu.c                |   2 +-
 arch/x86/kvm/svm/avic.c               | 321 +++++++++++++-------------
 arch/x86/kvm/svm/svm.c                |   4 +-
 arch/x86/kvm/svm/svm.h                |  11 +-
 arch/x86/kvm/x86.c                    |  35 ++-
 8 files changed, 329 insertions(+), 204 deletions(-)


base-commit: 372d07084593dc7a399bf9bee815711b1fb1bcf2
-- 
2.37.2.789.g6183377224-goog

