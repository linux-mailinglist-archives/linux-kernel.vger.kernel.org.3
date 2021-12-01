Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 884FF465383
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 18:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351676AbhLARHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 12:07:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238178AbhLARHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 12:07:38 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DE6C061574
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 09:04:14 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id h7-20020adfaa87000000b001885269a937so4483203wrc.17
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 09:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=P0eoA0nXrvSw+mWn0Ku1VtemJtowvKfJvB6oV4i5/hM=;
        b=Xl37A5npQxuw9iiyYsc4FHymns/CW0PmG++NQLPuDeVsi4MmWz/bMPvvp4mEsPVUj0
         T0jk2qTSFZhs5wn6WsNHgExPEDxnS3PFMt0xMVVfjX6xVZ6zNvFLL/D9ezCdbQEeLeQ4
         iphGPGU87rab27S/flnkUEKsapS1ZvK6BWoUZB8yB+OU+yrxbo+XLBFZc9dT3q/kaigZ
         tsiewXdcXd+CvHl/gELBfFBSdy8pF/zUDCyH2fW+3ss38xN1TLPrqeP4TpgNNGn4ii4E
         sLtTwube/pL8RqZ17DEUDza6tDL3ZxyExPjvLMo5O8P+nB4spC7CGhTvv8sUGWFSHB9g
         a3mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=P0eoA0nXrvSw+mWn0Ku1VtemJtowvKfJvB6oV4i5/hM=;
        b=GC/ijVOJYDeJw11K7kPuropdtYOmldXq0uOYLZItOrV/Jo0TCWz2j0+rR0T5mqwP4/
         JCFEpd7KBoyaXNSOJKehHy63dTfyzysdBJsc1nK3kONKUeBx1wzPQo36gG0bt9n0dMbx
         XQuCJ7Fzb1MhF1Tjo/fdDmCBQTeYY3oYu7YQ7dw4u2tYQ3GKXhNOCtW3vwQVOvQ8n7+N
         bjHxtw4RhVe53I7OmlvjYyxOkiNRa83nz3k+C+taCy0hnKFaqj52HUuojcWa79qn/nOy
         5jNa91mNxLiMVJmeXrWvxHNzrdPvQA2o2EScQLfRZAhz+/q3C2YKW7EfZZMFnGF/JJQl
         vbnQ==
X-Gm-Message-State: AOAM5308q3V3psNuSsTG2eTwt+mEZgHQD7TNSoESYKDuXkNyVK+M5DQg
        QH822FZfL1bAK6vAt3hGfqkWeg07cW29
X-Google-Smtp-Source: ABdhPJztEwjdKWN8+cpw0aKB6OPpL4Crx4EBMVVRzlRSso7hTLSF84evAIJ4EJbP5/t3h2pgTg90YOQYsg6U
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:1cab:1a20:2ef1:ddde])
 (user=qperret job=sendgmr) by 2002:a05:600c:154f:: with SMTP id
 f15mr8485753wmg.86.1638378253327; Wed, 01 Dec 2021 09:04:13 -0800 (PST)
Date:   Wed,  1 Dec 2021 17:03:54 +0000
Message-Id: <20211201170411.1561936-1-qperret@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v3 00/15] KVM: arm64: Introduce kvm_share_hyp()
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is v3 of the series previously posted here:

  https://lore.kernel.org/kvmarm/20211019121304.2732332-1-qperret@google.com/

This series implements an unshare hypercall at EL2 in nVHE protected
mode, and makes use of it to unmmap guest-specific data-structures from
EL2 stage-1 during guest tear-down. Crucially, the implementation of the
share and unshare routines use page refcounts in the host kernel to
avoid accidentally unmapping data-structures that overlap a common page.

This series has two main benefits. Firstly it allows EL2 to track the
state of shared pages cleanly, as they can now transition from SHARED
back to OWNED. This will simplify permission checks once e.g. pkvm
implements a donation hcall to provide memory to protected guests, as
there should then be no reason for the host to donate a page that is
currently marked shared. And secondly, it avoids having dangling
mappings in the hypervisor's stage-1, which should be a good idea from
a security perspective as the hypervisor is obviously running with
elevated privileges. And perhaps worth noting is that this also
refactors the EL2 page-tracking checks in a more scalable way, which
should allow to implement other memory transitions (host donating memory
to a guest, a guest sharing back with the host, ...) much more easily in
the future.

Changes since v2:

 - Added a check in kvm_share_hyp() to prevent sharing vmalloc pages;

 - Rebased on kvmarm/next, which contains Marc's rework of FPSIMD/SVE
   tracking [1].

Thanks!
Quentin

[1] https://lore.kernel.org/kvmarm/20211201120436.389756-1-maz@kernel.org/

Quentin Perret (7):
  KVM: arm64: Check if running in VHE from kvm_host_owns_hyp_mappings()
  KVM: arm64: Provide {get,put}_page() stubs for early hyp allocator
  KVM: arm64: Refcount hyp stage-1 pgtable pages
  KVM: arm64: Fixup hyp stage-1 refcount
  KVM: arm64: Introduce kvm_share_hyp()
  KVM: arm64: pkvm: Refcount the pages shared with EL2
  KVM: arm64: pkvm: Unshare guest structs during teardown

Will Deacon (8):
  KVM: arm64: Hook up ->page_count() for hypervisor stage-1 page-table
  KVM: arm64: Implement kvm_pgtable_hyp_unmap() at EL2
  KVM: arm64: Extend pkvm_page_state enumeration to handle absent pages
  KVM: arm64: Introduce wrappers for host and hyp spin lock accessors
  KVM: arm64: Implement do_share() helper for sharing memory
  KVM: arm64: Implement __pkvm_host_share_hyp() using do_share()
  KVM: arm64: Implement do_unshare() helper for unsharing memory
  KVM: arm64: Expose unshare hypercall to the host

 arch/arm64/include/asm/kvm_asm.h              |   1 +
 arch/arm64/include/asm/kvm_host.h             |   2 +
 arch/arm64/include/asm/kvm_mmu.h              |   2 +
 arch/arm64/include/asm/kvm_pgtable.h          |  21 +
 arch/arm64/kvm/arm.c                          |   6 +-
 arch/arm64/kvm/fpsimd.c                       |  36 +-
 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |   6 +
 arch/arm64/kvm/hyp/nvhe/early_alloc.c         |   5 +
 arch/arm64/kvm/hyp/nvhe/hyp-main.c            |   8 +
 arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 500 +++++++++++++++---
 arch/arm64/kvm/hyp/nvhe/setup.c               |  22 +-
 arch/arm64/kvm/hyp/pgtable.c                  |  80 ++-
 arch/arm64/kvm/mmu.c                          | 140 ++++-
 arch/arm64/kvm/reset.c                        |  10 +-
 14 files changed, 737 insertions(+), 102 deletions(-)

-- 
2.34.0.rc2.393.gf8c9666880-goog

