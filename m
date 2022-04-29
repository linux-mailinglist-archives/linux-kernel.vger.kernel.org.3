Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE22451564C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 23:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381152AbiD2VDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 17:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381016AbiD2VDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 17:03:50 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49BCECC516
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 14:00:30 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id l6-20020a170903120600b0014f43ba55f3so4707522plh.11
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 14:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=S9Hhyn59IO86GpZlBshBCG2lnuskDfIzKfShTwaqKtk=;
        b=FmL1KdBJ1eNXy/M2dSfbP2ckDvEiCeSGy69zaHXh6nqGyY87xj7jM0NGPD/NkKEwAL
         OeDhUZ1o9FKtm2SIxNnkCg6yBmu5TT+i71Irl+W6YOLxERFf9C+i1Pn678XfmJKcGAEB
         HIi7eqoekSUU9i06+W9VVlziNgErLs2PUw2DWrnC1VdNgQB0BrRAS5ZelwOw4DbV5C5k
         9PyIetUD068p7YwRFLuj64iwNAzKZSiJmS5upsLgANiyjdxPBmlz0cfzDo0Jwl1baHd9
         2TcjVkRmgdeqS/wW0XztDYXkr0Vd/BKtZQ4zHrK5HIQH28U+0s33ysJW3mzZYMCWtTyN
         tf/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=S9Hhyn59IO86GpZlBshBCG2lnuskDfIzKfShTwaqKtk=;
        b=h0E7fetZtQ8N/He+nV8vYvECFXfnaBTx2Uz+LXKvDoxGUqBhACFt6RhX04kBTGrQWN
         9VY+xBXCMbq5fsGgRtHoD2Yh138cLEOWmn15zwrVypyBIjMTZQtYq6IDOtzHxBdXqdye
         ILxu85nOLyn7/VAJPcEuUKx+XhM5RCkKqEziMEkg3Czf+aTJmIq4CD26BL2F7HA3eFTs
         +ScmPC1sN3z6dAz1l5eN5ydPL7kaDekQLPxtgqYiuJgbBXZrmzIEOIRME4AD3HExXcCw
         bBTZjlsb0U1SrAVxNkuN/6MxzGjLjl+qyHhVjTwJXcRVJ8FTo/UOUIQE1wWZi/tpuSLY
         bZEw==
X-Gm-Message-State: AOAM533+eX9u41BO8PALt5jaH4legpVtA5QiVlqA4A3ZuH9Vj+F1k5J9
        ligjkOxdyRT2mqAJ6sMI1knJSjDdvCo=
X-Google-Smtp-Source: ABdhPJx7AaspHwOPgM5B9rhklbLy1+NmQDZ93Etm/y100tXAtQtRSiiF0FnG4bH4qF0cdvLRCr1B7sR12ck=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:850b:b0:158:27a2:66eb with SMTP id
 bj11-20020a170902850b00b0015827a266ebmr1209520plb.5.1651266029771; Fri, 29
 Apr 2022 14:00:29 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 29 Apr 2022 21:00:17 +0000
Message-Id: <20220429210025.3293691-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH v3 0/8] KVM: Fix mmu_notifier vs. pfncache vs. pfncache races
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Mingwei Zhang <mizhang@google.com>
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

Fix races between mmu_notifier invalidation and pfncache refresh, and
within the pfncache itself.

The first two patches are reverts of the patches sitting in kvm/queue,
trying to separate and fix the races independently is nigh impossible.
I assume/hope they can be ignored and the original patches dropped.

I've proven all the races, though I was never able to trigger an actual
error in the race with the mmu_notifier, just a WARN I added on the
hva=>pfn translation being invalid/not-present when accessing memory
via the khva.  Hitting the race also required a series of handoffs in the
kernel between the two tasks, i.e. I can't provide any upstream-worthy
test :-(

v3:
  - Split the refresh serialization to a separate patch.
  - Use a mutex to serialize refrehses. [Lai Jiangshan]
  - Add back Cc to stable@ (omitted in v2 because I was less confident
    that backporting the mess would be a good idea].

v2:
  - https://lore.kernel.org/all/20220427014004.1992589-1-seanjc@google.com
  - Map the pfn=>khva outside of gpc->lock. [Maxim]
  - Fix a page leak.
  - Fix more races.

v1:
  https://lore.kernel.org/all/20220420004859.3298837-1-seanjc@google.com

Sean Christopherson (8):
  Revert "KVM: Do not speculatively mark pfn cache valid to "fix" race"
  Revert "KVM: Fix race between mmu_notifier invalidation and pfncache
    refresh"
  KVM: Drop unused @gpa param from gfn=>pfn cache's __release_gpc()
    helper
  KVM: Put the extra pfn reference when reusing a pfn in the gpc cache
  KVM: Do not incorporate page offset into gfn=>pfn cache user address
  KVM: Fully serialize gfn=>pfn cache refresh via mutex
  KVM: Fix multiple races in gfn=>pfn cache refresh
  KVM: Do not pin pages tracked by gfn=>pfn caches

 include/linux/kvm_types.h |   2 +
 virt/kvm/pfncache.c       | 180 +++++++++++++++++++++++---------------
 2 files changed, 113 insertions(+), 69 deletions(-)


base-commit: 2a39d8b39bffdaf1a4223d0d22f07baee154c8f3
-- 
2.36.0.464.gb9c8b46e94-goog

