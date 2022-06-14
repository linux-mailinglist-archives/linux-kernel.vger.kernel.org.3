Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD25354BD22
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 23:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242023AbiFNV6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 17:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354762AbiFNV6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 17:58:37 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5A01D322
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 14:58:34 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id bo24-20020a17090b091800b001ea9a916bb7so4002526pjb.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 14:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=0mmsgcPAIZJfYehAVs0Zfdox5FsqJk2L7a9PvpXjF6E=;
        b=sQ/pbXychTmfvMgUvUaXmvMGjTtuVHoxQSK/DnCff8MVhk4D2Sjj3qlvtZ7v5R859S
         i43rSTaPupW3CkU4c+HN1vHFdC6keEdcn/xwn1Iqy7vR4U6sVZUtvZayLLLS+tLIVcHc
         IGFDQOjrOjsu9gLK3bDrHGnrXheePfpzhgDm0M2wxHqL+dch1AKJ2bG/fZ4c6QHnSGFQ
         +40TNB3dyMvYbyEMti6mZfmByZWllAoFSVYSLE1Od3KDqttyA6p7wc4zQAnugm9P3EIN
         jykMAuVgaXc6UkYaGQjoZV5C7Ahq8/7WT0QOgWFP57fOio5PuKiUzLEa+bpTUdwP3Fr9
         BRYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=0mmsgcPAIZJfYehAVs0Zfdox5FsqJk2L7a9PvpXjF6E=;
        b=p+7SWX5VVDPfKhiqvx9b5827SoJXkbCf3RJGICrXetLPQdb84BC6JIqKSz2ChOCyjM
         zpvgZWY/7ogGoI81oK1JHvt5/cluNlLFxhSFzIz/OfdKYkHcbWU3VibTmdu5hhQnK8bd
         Kbyh9AbCf2x9XgZT91rHswLGaRBNzlR+IvuoRbt8dQ8ed4QA2BRc8fKgdCFIo+vFWuVa
         y2U+5o9lmHaua0LzJDHw21lCk3+uBhID652KLJ5Dw1c00GLWn7/j+3Uz5L6/+zBWiiMQ
         mnKOdDb6R+usZYzx2Z3aLFGcKhLj/xcab/fvK1qKO6wYdq5mu5fDFHrTOYVYT/29fKBr
         dI9A==
X-Gm-Message-State: AOAM533D6KdJ7Bw8w+2m8YRdDjegnsfU+/21f7N9fw+OAambh3ZsquGZ
        v4P9LlIBKSKxZtsCgUoloWQwdRvknDI=
X-Google-Smtp-Source: ABdhPJy/7VewsNVEFx2GcjypGNbbVRWI6qtdNm2Xn24L0W/qrnva2ba4fGKXFDiaV8TZ6SwN/oYuOJhCdyU=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a62:a50c:0:b0:510:6b52:cd87 with SMTP id
 v12-20020a62a50c000000b005106b52cd87mr6757272pfm.30.1655243914388; Tue, 14
 Jun 2022 14:58:34 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 14 Jun 2022 21:58:26 +0000
Message-Id: <20220614215831.3762138-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [PATCH 0/5] KVM: nVMX: Support loading MSRs before nested state
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lei Wang <lei4.wang@intel.com>
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

Fix two edge cases in nested VM-Enter where KVM loads garbage into
BNDCFGS and/or DEBUGCTL when migrating a vCPU with L2 active.  If userspace
restores MSRs before nested state, userspace expects KVM to propagate L2's
values to vmcs02.  KVM already mostly handles this scenario, so even though
I personally think it's rather ridiculous, it's easy for KVM to support,
and given that our VMM does KVM_SET_MSRS before KVM_SET_NESTED_STATE...

Patches 4 and 5 are minor optimizations to handle BNDCFGS more like
DEBUGCTL and/or the PKS MSR.

Sean Christopherson (5):
  KVM: nVMX: Snapshot pre-VM-Enter BNDCFGS for !nested_run_pending case
  KVM: nVMX: Snapshot pre-VM-Enter DEBUGCTL for !nested_run_pending case
  KVM: nVMX: Rename nested.vmcs01_* fields to nested.pre_vmenter_*
  KVM: nVMX: Save BNDCFGS to vmcs12 iff relevant controls are exposed to
    L1
  KVM: nVMX: Update vmcs12 on BNDCFGS write, not at vmcs02=>vmcs12 sync

 arch/x86/kvm/vmx/nested.c | 16 ++++++++--------
 arch/x86/kvm/vmx/vmx.c    | 13 +++++++++++++
 arch/x86/kvm/vmx/vmx.h    | 15 ++++++++++++---
 3 files changed, 33 insertions(+), 11 deletions(-)


base-commit: 8baacf67c76c560fed954ac972b63e6e59a6fba0
-- 
2.36.1.476.g0c4daa206d-goog

