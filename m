Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8BC4576A47
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 01:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbiGOXAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 19:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiGOXAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 19:00:21 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F88649B42
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 16:00:20 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id v19-20020a17090abb9300b001ef7bbd5a28so5923797pjr.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 16:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=6Y/afV6LO1OFaPYNu+1/fuV9HTTuiaJGLoIh2l0gw2o=;
        b=Gi1oX+4dZf54md8glp3WgVFNNmYbUShLb5ozePI+yZQSVbLMKvBtFJb8E7WELN2sEm
         CdbJbJX3+KlmNTtc1IOuGsReDJQ/gXB0ynCguYRf2SXIiSxTuh+zWN0q9XlGc02pYdRj
         lCnDSihZCe9hIZVXzYHXqr++48PGmy6z4DxFRrEXiv+QuSX5W8thycI6FcnvSeMqGFEo
         TONyxKFwCZSobkIkV4i8yvtWr9d3qF00Ks7N9ayTzQyberqxscjkjiWKpVaQYg8mMlFy
         /6Ol0tRgVuSTLwBRULyv969DELQjiSADfWF/nmI3lsEmCViPRrzNtAltIrs6cmHsWgPq
         MDqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=6Y/afV6LO1OFaPYNu+1/fuV9HTTuiaJGLoIh2l0gw2o=;
        b=NEdyS3NRGTkZ7Cd2PzoOTMciA978LxjV+I998lXprPfU0iArQd/QnEW6x90/zlPr2p
         pNvF35b+VMD1GJA9Tal0Nw+PYKdbmyNHamcPYU/Kcwz+NfGA3mJzB2BcB7LztxkJkDpZ
         kMvJodCbrvhlkHw11bG3RfU27J4XzLXkPVvnLtETN6seuaYX5UnHE7b71UiEMRdNxbem
         10fEKrP/iNBSzDgHzSJ3KJ1aYrNFKQDxs83PU64BIDd1wD7fZ9RUfYk56XEMB8DwRnEr
         SQzk3MSKH7YuGuhdPJPy/1LUKbr1ikU/DmuezXOK9GyIPHbz5rLRHwdsVC8dPA+hG7rH
         0u2Q==
X-Gm-Message-State: AJIora9EHHS33bpOgnCFO9YhE4vWusjG7M1tohHNabnxdrPnHYxReqjo
        cGkFKpdS3uaOqnUU40/fEhuLfEGBIYQ=
X-Google-Smtp-Source: AGRyM1s3vRplP0W43wMYpeeKQzDJJzvyo8RRNGjV0S5pJm1tXkCrBdtsKd9bop0kleExU2DjPuMD6W/cn10=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:249:b0:1e0:a8a3:3c6c with SMTP id
 t9-20020a17090a024900b001e0a8a33c6cmr912755pje.0.1657926019471; Fri, 15 Jul
 2022 16:00:19 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 15 Jul 2022 23:00:12 +0000
Message-Id: <20220715230016.3762909-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH 0/4] KVM: x86/mmu: Memtype related cleanups
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
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

Minor cleanups for KVM's handling of the memtype that's shoved into SPTEs.

Patch 1 enforces that entry '0' of the host's IA32_PAT is configured for WB
memtype.  KVM subtle relies on this behavior (silently shoves '0' into the
SPTE PAT field).  Check this at KVM load time so that if that doesn't hold
true, KVM will refuse to load instead of running the guest with weird and
potentially dangerous memtypes.

Patch 2 is a pure code cleanup (ordered after patch 1 in case someone wants
to backport the PAT check).

Patch 3 add a mask to track whether or not KVM may use a non-zero memtype
value in SPTEs.  Essentially, it's a "is EPT enabled" flag without being an
explicit "is EPT enabled" flag.  This avoid some minor work when not using
EPT, e.g. technically KVM could drop the RET0 implemention that's used for
SVM's get_mt_mask(), but IMO that's an unnecessary risk.

Patch 4 modifies the TDP page fault path to restrict the mapping level
based on guest MTRRs if and only if KVM might actually consume them.  The
guest MTRRs are purely software constructs (not directly consumed by
hardware), and KVM only honors them when EPT is enabled (host MTRRs are
overridden by EPT) and the guest has non-coherent DMA.  I doubt this will
move the needed on whether or not KVM can create huge pages, but it does
save having to do MTRR lookups on every page fault for guests without
a non-coherent DMA device attached.

Sean Christopherson (4):
  KVM: x86: Reject loading KVM if host.PAT[0] != WB
  KVM: x86: Drop unnecessary goto+label in kvm_arch_init()
  KVM: x86/mmu: Add shadow mask for effective host MTRR memtype
  KVM: x86/mmu: Restrict mapping level based on guest MTRR iff they're
    used

 arch/x86/kvm/mmu/mmu.c  | 26 +++++++++++++++++++-------
 arch/x86/kvm/mmu/spte.c | 21 ++++++++++++++++++---
 arch/x86/kvm/mmu/spte.h |  1 +
 arch/x86/kvm/x86.c      | 33 ++++++++++++++++++++-------------
 4 files changed, 58 insertions(+), 23 deletions(-)


base-commit: 8031d87aa9953ddeb047a5356ebd0b240c30f233
-- 
2.37.0.170.g444d1eabd0-goog

