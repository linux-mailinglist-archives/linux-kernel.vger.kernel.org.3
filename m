Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9354FA0B8
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 02:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240157AbiDIAlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 20:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbiDIAk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 20:40:56 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803F6C6ECA
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 17:38:51 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id m8-20020a17090aab0800b001cb1320ef6eso4001290pjq.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 17:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=+FLStwqc0EB6Nrq1GDs2STlsOQEhH3v01q3i9z/GwiI=;
        b=Oicgj+FC03CsEb0kBsXEJdz6dJDKhV4oPHMjAbP2cTVf3H96O9iVKXYnIL3Wsedms8
         KHBI1/LnFFVlKzxHoxWUpREZaCO32dtyPcbB1HvjEmWE/kjr9Acdr9jUBeLkrb+QC3P/
         Ni6KCdJVGhh90SGYxSwY8A2Qmimlbr50sn3kt0brlUax+UIVYhesuykuHpIzxZv79Xk1
         ZddH7864DMSaa24dwgai+TFzUG+6Odg9W4c8LahutIVyWs4uuZg7OgP52PYY8NwB5apM
         osUJYWjc/z2zTM3lihv1ygygccash12ecVtoDQqtqcqBe/Ag1qBOuXjYdd7bhgJVbnc5
         31Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=+FLStwqc0EB6Nrq1GDs2STlsOQEhH3v01q3i9z/GwiI=;
        b=X6MvkKS0K8N+g05kx6/kONUnZITmCCeFGHN0zSv4+XFuMI3ay91BBXaHyuYPMC+LN2
         YWjl1EIPJQVQwOh16MGdxrib8KqdEGyE7svBo1WkNPRv/cSv8ZgKjYzN3vXAOaqiFpfJ
         w15y2w0rUS5tXSk3B3AEOLkWdEnKzcF53lLsN4UUxdiDPvFNVR/qwMsG2Ga5489SCzMV
         YvHWbvHKefSq0rqcRmeiJZiV7bx41pv/+P/RueM2LjHiiopfVhNYHJyI1lBsW/wCgFoj
         xsINGdJGq6CFUoiQKXkWamjuU+xlVgNVeuy1WkOdZtgoFdnEVOzNzIHrVZJS978yV7Gn
         8Cww==
X-Gm-Message-State: AOAM530e3nLEG+9NQaoYyWoCeUPeLiLL8gdx80m+ht1d6Elwd7rruPaU
        /HArL1lq3FC7qTKko5Qtezdm5d9b6GU=
X-Google-Smtp-Source: ABdhPJwHi0jlkBdxIpUXSUA58+A2u7zL4XTqsv9DbFDRLl1ZBcdVzeB2A5Mpqj+aqwKTphWMb/vEJyyeNfY=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a65:4682:0:b0:39d:18c2:3d8c with SMTP id
 h2-20020a654682000000b0039d18c23d8cmr1212346pgr.224.1649464730948; Fri, 08
 Apr 2022 17:38:50 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Sat,  9 Apr 2022 00:38:41 +0000
Message-Id: <20220409003847.819686-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
Subject: [PATCH 0/6] KVM: x86: Apply NX mitigation more precisely
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>
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

This is just the kernel (NX) side of Mingwei's series "Verify dirty
logging works properly with page stats".  Relatively to v3 of Mingwei's
series[*], this fixes accounting (and tracking in the nonpaging case)
of disallowed NX huge pages.

I left off the selftests because I disagree with the "Dump stats" change,
and this has snowballed enough.

https://lore.kernel.org/all/20220401063636.2414200-1-mizhang@google.com

Mingwei Zhang (1):
  KVM: x86/mmu: explicitly check nx_hugepage in
    disallowed_hugepage_adjust()

Sean Christopherson (5):
  KVM: x86/mmu: Tag disallowed NX huge pages even if they're not tracked
  KVM: x86/mmu: Properly account NX huge page workaround for nonpaging
    MMUs
  KVM: x86/mmu: Set disallowed_nx_huge_page in TDP MMU before setting
    SPTE
  KVM: x86/mmu: Track the number of TDP MMU pages, but not the actual
    pages
  KVM: x86/mmu: Add helper to convert SPTE value to its shadow page

 arch/x86/include/asm/kvm_host.h |  17 ++----
 arch/x86/kvm/mmu.h              |   9 +++
 arch/x86/kvm/mmu/mmu.c          | 104 ++++++++++++++++++++++----------
 arch/x86/kvm/mmu/mmu_internal.h |  33 +++++-----
 arch/x86/kvm/mmu/paging_tmpl.h  |   6 +-
 arch/x86/kvm/mmu/spte.c         |  11 ++++
 arch/x86/kvm/mmu/spte.h         |  17 ++++++
 arch/x86/kvm/mmu/tdp_mmu.c      |  49 +++++++++------
 arch/x86/kvm/mmu/tdp_mmu.h      |   2 +
 9 files changed, 167 insertions(+), 81 deletions(-)


base-commit: 6521e072010d10380eca3d8a2203990e61e16ae0
-- 
2.35.1.1178.g4f1659d476-goog

