Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A54955F0E4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 00:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbiF1WJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 18:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiF1WJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 18:09:45 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75D2340EC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 15:09:43 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id l6-20020a170902ec0600b0016a1fd93c28so7631941pld.17
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 15:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=j7vQtUkT6qRG3QKeX4UpMqnVZiZTqDS8DcvKPJ9fshM=;
        b=GzxwozEneycpYxfYkAxZnBbfe2kKbiWaUb3au/3inz+96+E7+zLStOmquVbMClhDJN
         mymnRTDsodttIg6bONJTV+Qf5sR0A/4Eufj9q5UkrnT+X4ZTX9KUSPZals5kueYPLHS3
         5ZKToqFOZmswpxTUHknfNDUsMGF7F/uaQqn/NEHMx2U6nUHbDS6x4NydE1vgoQf5Vtt0
         6DmHVpPjAhtY1SKXtzIeH1gmnX+GXgSguGwom5FHISPhcwC8dDainyvR7TPw7gTaHg5e
         aUNIUtPDYqw7Y7eMijqWWljoO7q9a0HYG+8ZpKEazP1QJOUU4M542v67wi7XPxaE8BoY
         dfHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=j7vQtUkT6qRG3QKeX4UpMqnVZiZTqDS8DcvKPJ9fshM=;
        b=fyXFTipOwZ8GWVShEk2QQDUQPAFwarubiec+Slxlwgtm0yXElMsQAtIAjlSuk4N7ct
         4hqFQ/1/9Pe6iuQwFNIcaeWaQ1Aj7iAyg3rer56ZKn5AYtV3cGuT2pM0NUgJ5fhzuGFy
         2HSdG+Nu5LRinGYsZ5O/WtFsK6k+D35o4CzjmmX3ZteVrWIG1R+PjPnCfcDtFp1nMafT
         iOWQFn+pBlx+K6X1joous0fzX764THCKRjoH8vUVg8nk/ub3dxxp/e6OF1D9z56dS4KL
         F8sUq1vJfZYMXycMWoiX2lpWxe+hSBnCYDrDVJRy/TtR5RnsCELA7znsTrjjDTSHkFiB
         zOJg==
X-Gm-Message-State: AJIora9OpQwomvQzrY0ZQt0ugiokyP1UtJJBxkSUB0L2wAuP7i3o2udR
        YVQAjfmCiKYT+QospqgLN4+lUPPZP7sE6iKx
X-Google-Smtp-Source: AGRyM1tAsY26pwu8BYVe36xK0WPC+OOzu0ciBh5fVZFr2DkYJV+K61VKlr8YtnVAaRLZuPtKG1T6lcJUgBOER+dp
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:902:d212:b0:16b:9cf9:6523 with SMTP
 id t18-20020a170902d21200b0016b9cf96523mr932471ply.33.1656454183407; Tue, 28
 Jun 2022 15:09:43 -0700 (PDT)
Date:   Tue, 28 Jun 2022 22:09:34 +0000
Message-Id: <20220628220938.3657876-1-yosryahmed@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v6 0/4] KVM: mm: count KVM mmu usage in memory stats
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Oliver Upton <oupton@google.com>
Cc:     Huang@google.com, Shaoqin <shaoqin.huang@intel.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        kvm@vger.kernel.org, linux-mm@kvack.org,
        Yosry Ahmed <yosryahmed@google.com>
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

Add NR_SECONDARY_PAGETABLE memory stat and use it to account KVM mmu
usage as the first type of accounted secondary page tables. This stat
can be later extended to account for other types of secondary pages
tables (e.g. iommu page tables).

Rationale behind why this is useful and link to extended discussion in
the first patch.

---

Changes in V6:
- Rebased on top of kvm/queue and fixed conflicts.
- Fixed docs spaces and tabs (Sean).
- More narrative commit logs (Sean and Oliver).
- Updated kvm_account_pgtable_pages() documentation to describe the
  rules of using it more clearly (Sean).
- Collected Acks and Reviewed-by's by Shakeel and Oliver (Thanks!)

Changes in V5:
- Updated cover letter to explain more the rationale behind the change
  (Thanks to contributions by Sean Christopherson).
- Removed extraneous + in arm64 patch (Oliver Upton, Marc Zyngier).
- Shortened secondary_pagetables to sec_pagetables (Shakeel Butt).
- Removed dependency on other patchsets (applies to queue branch).

Changes in V4:
- Changed accounting hooks in arm64 to only account s2 page tables and
  refactored them to a much cleaner form, based on recommendations from
  Oliver Upton and Marc Zyngier.
- Dropped patches for mips and riscv. I am not interested in those archs
  anyway and don't have the resources to test them. I posted them for
  completeness but it doesn't seem like anyone was interested.

Changes in V3:
- Added NR_SECONDARY_PAGETABLE instead of piggybacking on NR_PAGETABLE
  stats.

Changes in V2:
- Added accounting stats for other archs than x86.
- Changed locations in the code where x86 KVM page table stats were
  accounted based on suggestions from Sean Christopherson.

---

Yosry Ahmed (4):
  mm: add NR_SECONDARY_PAGETABLE to count secondary page table uses.
  KVM: mmu: add a helper to account memory used by KVM MMU.
  KVM: x86/mmu: count KVM mmu usage in secondary pagetable stats.
  KVM: arm64/mmu: count KVM s2 mmu usage in secondary pagetable stats

 Documentation/admin-guide/cgroup-v2.rst |  5 ++++
 Documentation/filesystems/proc.rst      |  4 +++
 arch/arm64/kvm/mmu.c                    | 36 ++++++++++++++++++++++---
 arch/x86/kvm/mmu/mmu.c                  | 16 +++++++++--
 arch/x86/kvm/mmu/tdp_mmu.c              | 12 +++++++++
 drivers/base/node.c                     |  2 ++
 fs/proc/meminfo.c                       |  2 ++
 include/linux/kvm_host.h                | 10 +++++++
 include/linux/mmzone.h                  |  1 +
 mm/memcontrol.c                         |  1 +
 mm/page_alloc.c                         |  6 ++++-
 mm/vmstat.c                             |  1 +
 12 files changed, 89 insertions(+), 7 deletions(-)

-- 
2.37.0.rc0.161.g10f37bed90-goog

