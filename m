Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E80C4F2057
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 01:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiDDXoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 19:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiDDXoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 19:44:00 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6812366AFB
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 16:41:58 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id y189-20020a6264c6000000b004faecedcb81so6798710pfb.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 16:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=c548FhlQVCeLASWi2SW4ftOYWvDCDMWewdhtv6ZW6gY=;
        b=pZ5ptiPrn0E9ZV+xzv07J81V/0Zux8TrUyo6jMG4kpMMh0K7HX28tDLAThcepAu89X
         jpvZME1VMw6StSg5iiL/4rPgoHaOxfhzFjG6Snu6piKhp/k5UnX283JNxefdJX944xjq
         dNQfi90BLutn0DfEG7mlMm2Q+X1nCiE7OwmJnyx4JdCOIINKCLdZ/jPNWkqEpBocJEIh
         opdie5q3vplCxy3ps+0zsh181ABEsygF6O+I5ntyX2TeFYBAowthwCCfrcrvIyt4xUPT
         YzaaaPuGx7wC1EbgwXE/pGRx1wcfad8pnHtkgPcUufqXShC2RupXspVY6eHOUw0hoU4Q
         Aygw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=c548FhlQVCeLASWi2SW4ftOYWvDCDMWewdhtv6ZW6gY=;
        b=pRSUGywHSrm2ZZZvoDQqbMy348/QV11Bvr0/9uVLLeUfk1jsLPwtIKRAUBj5Bg7aGG
         v5YLYi+s0g9YGv+eidpVBoz1UPSclkwDBmaeMtcuRgFHQf9zwXTzaTjXyIOcDY1nHiSQ
         LlaqSNZbO+IgKNzhVxt0suuJYue5e1o9t5+XaidoTmpUcgsPTKqddoglVk4b9qSstl/Y
         JKfiMtegaz32DAB54eDNgNlBbJVIgChbr5f3WNUoduyugQz/BprTpMEs1HpcDOA1hxC4
         oKJCzWNA+HeKBXqGIz8NE53l3amuBkR28EKEynq0wqVviVLR6srEya++u4+a6oo9ByLh
         akaw==
X-Gm-Message-State: AOAM531AAPef6EIxsk1HiCB/39aZt/vUMavMJae2Vvj0ORgWF8SE/pOW
        /RDie4YfF5+QjGFCmggFF78i3KqF9mMvJe41
X-Google-Smtp-Source: ABdhPJzje5soq4C+73JHuqeLRvcYbRyyXekrcv2pJ3NUiCSG6xvCvoMeUjg8LbTBhyVFW5mEm2HJbc0MPJNQoep5
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:aa7:9019:0:b0:4fa:7532:9551 with SMTP
 id m25-20020aa79019000000b004fa75329551mr553545pfo.26.1649115717724; Mon, 04
 Apr 2022 16:41:57 -0700 (PDT)
Date:   Mon,  4 Apr 2022 23:41:49 +0000
Message-Id: <20220404234154.1251388-1-yosryahmed@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1094.g7c7d902a7c-goog
Subject: [PATCH v2 0/5] KVM: mm: count KVM page table pages in pagetable stats
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     mizhang@google.com, David Matlack <dmatlack@google.com>,
        kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>
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

We keep track of several kernel memory stats (total kernel memory, page
tables, stack, vmalloc, etc) on multiple levels (global, per-node,
per-memcg, etc). These stats give insights to users to how much memory
is used by the kernel and for what purposes.

Currently, memory used by kvm for its page tables is not accounted in
the pagetable stats. This patch series accounts the memory pages used by
KVM for page tables in those stats.

The riscv and mips patches are not tested properly due to lack of
resources. Feel free to test or drop them.

Yosry Ahmed (5):
  KVM: mm: add a helper to account page table pages used by KVM.
  KVM: x86: mm: count KVM page table pages in pagetable stats
  KVM: arm64: mm: count KVM page table pages in pagetable stats
  KVM: riscv: mm: count KVM page table pages in pagetable stats
  KVM: mips: mm: count KVM page table pages in pagetable stats

 arch/arm64/kernel/image-vars.h |  3 ++
 arch/arm64/kvm/hyp/pgtable.c   | 50 +++++++++++++++++++++-------------
 arch/mips/kvm/mips.c           |  1 +
 arch/mips/kvm/mmu.c            |  9 +++++-
 arch/riscv/kvm/mmu.c           | 26 +++++++++++++-----
 arch/x86/kvm/mmu/mmu.c         | 16 +++++++++--
 arch/x86/kvm/mmu/tdp_mmu.c     | 16 +++++++++--
 include/linux/kvm_host.h       |  9 ++++++
 8 files changed, 99 insertions(+), 31 deletions(-)

-- 
2.35.1.1094.g7c7d902a7c-goog

