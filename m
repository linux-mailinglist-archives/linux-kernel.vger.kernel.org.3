Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3389475D10
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 17:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244575AbhLOQMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 11:12:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbhLOQMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 11:12:37 -0500
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A62C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 08:12:37 -0800 (PST)
Received: by mail-ed1-x54a.google.com with SMTP id bx28-20020a0564020b5c00b003e7c42443dbso20501413edb.15
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 08:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=gh8KjSqD+Gc0lGrXKkXUwKXftGOINm+/3g+rQSFyxWY=;
        b=mvUV2rLW2bE/wMqFxQtQBTjqGeZL/2uRbbFno2rXvMcXnzTvVpAKEfDbisv5+ZeOiY
         kE8zK+LLhzCFdANCSEB7/UD3rZ9RO0tU66W3TU4HaIJy8jia2/Fi7gM1Az93Krq1mhyO
         8Y48sl/9UYQqxMV6MOUp4/NCWjGVrsclvr4WijEQ7cx6rGv8JTN0N2BreDS4dDjJeJuO
         JOiz3glrxDgStiMnH7WXzesQ9y7TSmtP2BdYUQX/+jjIQeGkw3ivlvsYgzFwMZz/FBWs
         jF7Npo+Pxy20rY3QZPbsXmEfotJMR+MEv+yElm0xtNa/usgNqzA1ufNqd8L87i3v9ohM
         LbJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=gh8KjSqD+Gc0lGrXKkXUwKXftGOINm+/3g+rQSFyxWY=;
        b=6Ot4sDfxmKgxnFor/U8N0FuDngolY8AF+NhsyV/5nj2qJGNDFOayMns9/ZOMhygbiA
         McE2rvcvjoRc/L3onYI2A/oLY8zFNaot3raSCgrvd5fgdf4dCgLIc8B7FUToTuRC/lsS
         00EiNbS5nudkjPgL/+0PtJ9yBKabLzkPGzkOaPsaewjaocnj61qKzZd+a0XwReRDeKlt
         t2LaV0NJ6akAKjh1+jPpKGwcaupwynGrBRTFIme8fZayLmwuvyX+ekCelBJTRojg+5Er
         gNklIp/ZpC2Ie84XqcgYyik4r7u793MCu+M50RsW6rouKV/1mZPcN/FaWEmAsF8thp96
         JU0g==
X-Gm-Message-State: AOAM530MypyHrGEYFjeJRzrJ5JHwaSfZg43LDWXaaLAU7i3OORs7v+3w
        2Zr/PKlmPvvbLUwHVJbdm+PgHu1JoA33
X-Google-Smtp-Source: ABdhPJycFMZbkSRIWU7DZP+pHUTh7fzng+TT819dNHf7jxannLR27sBg7Xk9IbC9vypPO2DBRS4BDmj9lWWe
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:fc03:4f5b:4e9b:3ec1])
 (user=qperret job=sendgmr) by 2002:a17:906:2a44:: with SMTP id
 k4mr11733665eje.629.1639584755202; Wed, 15 Dec 2021 08:12:35 -0800 (PST)
Date:   Wed, 15 Dec 2021 16:12:17 +0000
Message-Id: <20211215161232.1480836-1-qperret@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v4 00/14] KVM: arm64: Introduce kvm_{un}share_hyp()
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     qperret@google.com, qwandor@google.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is v4 of the series previously posted here:

  https://lore.kernel.org/kvmarm/20211201170411.1561936-1-qperret@google.com/

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

Changes since v3:
 - fixed refcount of hyp stage-1 page-table pages when only changing SW
   bits (Will)
 - misc minor cleanups (Will, Andrew)
 - rebased on kvmarm/next

Quentin Perret (6):
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
 arch/arm64/kvm/hyp/pgtable.c                  | 102 +++-
 arch/arm64/kvm/mmu.c                          | 137 ++++-
 arch/arm64/kvm/reset.c                        |  10 +-
 14 files changed, 739 insertions(+), 119 deletions(-)

-- 
2.34.1.173.g76aa8bc2d0-goog

