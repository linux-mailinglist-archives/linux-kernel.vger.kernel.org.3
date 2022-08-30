Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42FB15A720A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 01:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbiH3Xzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 19:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiH3Xzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 19:55:41 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D392F00F
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 16:55:40 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id rj3-20020a17090b3e8300b001fae0be4dc4so11901410pjb.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 16:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc;
        bh=cNAoNO+6MPQXzIUTyfZPcKrAHIqJmjqzWZR1Z6VP+DA=;
        b=PwGnLTkwxgwRu42iuFpo2T4D/GwMmfwekg2VvlwAb7npHOMz+Hzh5o4WmTXr+TVSvH
         XBXar62/Wmxclu2ongTjIDAl2+XRg17op8Vn0rVEWX18pht0x5LQPX42NU+OvTdCNd69
         6A10iDWXkt+bqEwQT3+CSBAJvve1CKTXtvcI5zKso6GkcS5/uf4DWVSalVhkUuQvM7Kn
         MirfyTru0S2MNmHbKVwdV+80vqQBlB0RGwkyz9nSepmJR2JYYTicOdYwNsW9KXZ3CslK
         jW9izlI3P6SQ84UN8ktrK5kHQ34xi4xgqd8PzxJ62vHqO9fsjc9sIX1OAEACahiHUyeG
         xY0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc;
        bh=cNAoNO+6MPQXzIUTyfZPcKrAHIqJmjqzWZR1Z6VP+DA=;
        b=NVNRdDkEI6REPJdjjrF+sU+l7G3UmtbMsRXBR5wxO4U7pUekW7OXXxVpRYEflofL0p
         ClBBr7IsYi83jqy94KKxjMzX1BgYsU4i3T6Fw2T1b3S3BoV3R9LpZZwM+tMbUr4Z1pUZ
         CG1EYhyDaicPzlK6IkKTLTEVWYqTMtpcFvP4vdgEyKbBBfrBpl/k9x14R6+O5qcBmLoo
         9opRoXsIjMxY5M5YPunxZkZaIvYc5uOFAvyc3O7WCGf99+6zVxC7NYqUb3wobqeR6h8J
         ydaTA7VtjEv2l6KO3fCCVQGKklr8qSvVCcBgn7YfATajpTxR0M4S12FiksLXiXUjRNlP
         x7eA==
X-Gm-Message-State: ACgBeo1qgz2UUFOWnxBd7biH8yvrOCixZI40vTY0OlFI/2rawo76U3Nx
        G6n8pyhfmVepcZJbmISGFHF6HshFFE0=
X-Google-Smtp-Source: AA6agR7UmQaOToCi7P7gZZS6XCA6mVUek/X4135u5cDFfDSpwdCHGnPDTkW5mmZCl/pG/T7a3L2nqFTLu0k=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:92:b0:174:6796:e3d0 with SMTP id
 o18-20020a170903009200b001746796e3d0mr18176625pld.97.1661903739548; Tue, 30
 Aug 2022 16:55:39 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 30 Aug 2022 23:55:28 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220830235537.4004585-1-seanjc@google.com>
Subject: [PATCH v4 0/9] KVM: x86: Apply NX mitigation more precisely
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Matlack <dmatlack@google.com>,
        Mingwei Zhang <mizhang@google.com>,
        Yan Zhao <yan.y.zhao@intel.com>,
        Ben Gardon <bgardon@google.com>
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

Note, this applies on Yosry's stats series (there's a trivial-but-subtle
conflict in the TDP MMU shadow page accounting).
https://lore.kernel.org/all/20220823004639.2387269-1-yosryahmed@google.com

Precisely track (via kvm_mmu_page) if a non-huge page is being forced
and use that info to avoid unnecessarily forcing smaller page sizes in
disallowed_hugepage_adjust().

KVM incorrectly assumes that the NX huge page mitigation is the only
scenario where KVM will create a non-leaf page instead of a huge page.
As a result, if the original source of huge page incompatibility goes
away, the NX mitigation is enabled, and KVM encounters an present shadow
page when attempting to install a huge page, KVM will force a smaller page
regardless of whether or not a smaller page is actually necessary to
satisfy the NX huge page mitigation.

Unnecessarily forcing small pages can result in degraded guest performance,
especially on larger VMs.  The bug was originally discovered when testing
dirty log performance, as KVM would leave small pages lying around when
zapping collapsible SPTEs.  That case was indadvertantly fixed by commit
5ba7c4c6d1c7 ("KVM: x86/MMU: Zap non-leaf SPTEs when disabling dirty
logging"), but other scenarios are still affected, e.g. KVM will not
rebuild a huge page if the mmu_notifier zaps a range of PTEs because the
primary MMU is creating a huge page.

v4:
 - Collect reviews. [Mingwei]
 - Add comment to document possible_nx_huge_pages. [Mingwei]
 - Drop extra memory barriers. [Paolo]
 - Document ordering providing by TDP SPTE helpers. [Paolo]

v3:
 - https://lore.kernel.org/all/20220805230513.148869-1-seanjc@google.com
 - Bug the VM if KVM attempts to double account a shadow page that
   disallows a NX huge page. [David]
 - Split the rename to separate patch. [Paolo]
 - Rename more NX huge page variables/functions. [David]
 - Combine and tweak the comments about enforcing the NX huge page
   mitigation for non-paging MMUs. [Paolo, David]
 - Call out that the shadow MMU holds mmu_lock for write and doesn't need
   to manual handle memory ordering when accounting NX huge pages. [David]
 - Add a smp_rmb() when unlinking shadow pages in the TDP MMU.
 - Rename spte_to_sp() to spte_to_child_sp(). [David]
 - Collect reviews. [David]
 - Tweak the changelog for the final patch to call out that precise
   accounting addresses real world performance bugs. [Paolo]
 - Reword the changelog for the patch to (almost) always tag disallowed
   NX huge pages, and call out that it doesn't fix the TDP MMU. [David]

v2: Rebase, tweak a changelog accordingly.

v1: https://lore.kernel.org/all/20220409003847.819686-1-seanjc@google.com

Mingwei Zhang (1):
  KVM: x86/mmu: explicitly check nx_hugepage in
    disallowed_hugepage_adjust()

Sean Christopherson (8):
  KVM: x86/mmu: Bug the VM if KVM attempts to double count an NX huge
    page
  KVM: x86/mmu: Tag disallowed NX huge pages even if they're not tracked
  KVM: x86/mmu: Rename NX huge pages fields/functions for consistency
  KVM: x86/mmu: Properly account NX huge page workaround for nonpaging
    MMUs
  KVM: x86/mmu: Document implicit barriers/ordering in TDP MMU shared
    mode
  KVM: x86/mmu: Set disallowed_nx_huge_page in TDP MMU before setting
    SPTE
  KVM: x86/mmu: Track the number of TDP MMU pages, but not the actual
    pages
  KVM: x86/mmu: Add helper to convert SPTE value to its shadow page

 arch/x86/include/asm/kvm_host.h |  30 +++++----
 arch/x86/kvm/mmu/mmu.c          | 115 ++++++++++++++++++++------------
 arch/x86/kvm/mmu/mmu_internal.h |  33 ++++-----
 arch/x86/kvm/mmu/paging_tmpl.h  |   6 +-
 arch/x86/kvm/mmu/spte.c         |  12 ++++
 arch/x86/kvm/mmu/spte.h         |  17 +++++
 arch/x86/kvm/mmu/tdp_iter.h     |   6 ++
 arch/x86/kvm/mmu/tdp_mmu.c      |  48 +++++++------
 arch/x86/kvm/mmu/tdp_mmu.h      |   2 +
 9 files changed, 176 insertions(+), 93 deletions(-)


base-commit: 6f87cacaf4fe95288ac4cbe01a2fadc5d2b8b936
-- 
2.37.2.672.g94769d06f0-goog

