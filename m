Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84510501FB6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 02:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348106AbiDOAqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 20:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245477AbiDOAqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 20:46:14 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A21296832
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 17:43:47 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id z88-20020a17090a6d6100b001cb89a1969fso3642282pjj.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 17:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=7OMi2RIEzFlzmxnmlN9xX+Hiuvy0euETloS8ByI5IaE=;
        b=MeCa2hpH2EDOFAv86dWfFxEDhUCoVgtYtspWsZspfLv8qId3NORSe7rf03wn86oylz
         +XJ0GcdqQRybf6xncuTBeePmfFN4InpFQ41P9BSR3Syo01zZHvGZ9zQr4T4EE1WEIloe
         reG4s0K2VYD7FLIjoouyOUE3otCfnre0GNbLyJfTBPWb2DV4bee0Kn/uLaXDFLxrNX/x
         UbZV6ELm90R1ITrDKiVMDDPojI8aJ036Iusf7S6xFX02aeLgG7OCHcrKOwsYwLbInWX3
         PegPDslVaW429FO+Y+K2OsH/9FIvKxrhlxBKuaQed7QGbk7x/m+I+YhWAP5nEspT3bi9
         F2eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=7OMi2RIEzFlzmxnmlN9xX+Hiuvy0euETloS8ByI5IaE=;
        b=KH2AFudW1IwrjFZqoPYdiwZPCQ+lm3W8qbUXU/K0Ku5L8HsAdbc8xUdv83pu6ltTlv
         M/vvIk7Y+DcP6wxQxJ3pYfYXnuZOC4ZBI15FmdAxWu149i1Fruoqh9K//7z9fRRescRz
         UhMoCWL2bqtxoEecRmP0A6H1U4y3yhC0EjHI3wIGdS4SqQlAocRCT6Albqry+GPAVKrJ
         o3f3KQjrvsoyMGQoAe7K2LwI9wSqYXC0iitrREBcAO7T1fy11eh5nWmscmnJgYP9oy7J
         gVJiYAjrMaajP98jhQMv8Q06pLmG2PI+9DmXyD/8AuGiOJJYpaRGBRaSNTgLr0rDlBOG
         tNVQ==
X-Gm-Message-State: AOAM533vA6GOWEjSel8nSPqNvS8G2eXhpl3s5togZFukD7axk1qCFgsb
        BLQdo4USep2IoPgnf6JZkR1gH787dOI=
X-Google-Smtp-Source: ABdhPJx6JOuyqIVZMdQQ1Mawo8G7YZO4giLYHAwOTFBDw/d0CTLHvznAoZ7hbCtCNcCnHHDws4949mgI1FE=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:1490:b0:4fb:1544:bc60 with SMTP id
 v16-20020a056a00149000b004fb1544bc60mr17317476pfu.73.1649983426720; Thu, 14
 Apr 2022 17:43:46 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 15 Apr 2022 00:43:40 +0000
Message-Id: <20220415004343.2203171-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
Subject: [PATCH 0/3] KVM: x86 SRCU bug fix and SRCU hardening
From:   Sean Christopherson <seanjc@google.com>
To:     Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Atish Patra <atishp@atishpatra.org>,
        David Hildenbrand <david@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
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

Fix an x86 bug where KVM overwrites vcpu->srcu_idx and can leak an SRCU
lock due to unlocking the wrong index, ultimately causing a hang if/when
KVM attempts to synchronize.

Switch RISC-V to the generic vcpu->srcu_idx, for reasons unknown it has
its own copy and ignores the generic one.

Add helpers with rudimentary detection of illegal vcpu->srcu_idx usage,
the x86 bug would have been incredibly painful to debug had I not known
what to look for (found by a selftest with very specific behavior...
that we recently modified with respect to SRCU).

Non-x86 changes are compile tested only.

Sean Christopherson (3):
  KVM: x86: Don't re-acquire SRCU lock in complete_emulated_io()
  KVM: RISC-V: Use kvm_vcpu.srcu_idx, drop RISC-V's unnecessary copy
  KVM: Add helpers to wrap vcpu->srcu_idx and yell if it's abused

 arch/powerpc/kvm/book3s_64_mmu_radix.c |  9 ++++---
 arch/powerpc/kvm/book3s_hv_nested.c    | 16 ++++++------
 arch/powerpc/kvm/book3s_rtas.c         |  4 +--
 arch/powerpc/kvm/powerpc.c             |  4 +--
 arch/riscv/include/asm/kvm_host.h      |  3 ---
 arch/riscv/kvm/vcpu.c                  | 16 ++++++------
 arch/riscv/kvm/vcpu_exit.c             |  4 +--
 arch/s390/kvm/interrupt.c              |  4 +--
 arch/s390/kvm/kvm-s390.c               |  8 +++---
 arch/s390/kvm/vsie.c                   |  4 +--
 arch/x86/kvm/x86.c                     | 35 +++++++++++---------------
 include/linux/kvm_host.h               | 24 +++++++++++++++++-
 12 files changed, 72 insertions(+), 59 deletions(-)


base-commit: 150866cd0ec871c765181d145aa0912628289c8a
-- 
2.36.0.rc0.470.gd361397f0d-goog

