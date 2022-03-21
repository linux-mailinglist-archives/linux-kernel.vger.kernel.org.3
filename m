Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576144E1E74
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 01:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343892AbiCUA2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 20:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234559AbiCUA2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 20:28:05 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5F0DE910
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 17:26:41 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id z10-20020a634c0a000000b0036c5eb39076so6619408pga.18
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 17:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=vksLZSJ/1XSsrv5+Q44yzVYsU90jJzgSeUJqyoBHB3k=;
        b=gSwfSIzdqD5scy88k1Ask13XrPPk0tjFpkIl+D/qDCh4rUVNM82SuDTRYhdU6aYvrv
         xtz+rBdoSrGFv2yFWdyQB33Uhb2WIK+kLFiN1toCSPE2yT8CCK7JrNY29nMvpz6xT3LJ
         AiMjx5FbnXVooaM53zgB5DAgGak5uuyMy6HH6XopU7hbPNVEiZWu7upyAqjmajQeUEdB
         8STDcUpcAKOXoU8Qhu/dMstGg2NPwAkT1DMsmHgnilrDL/mn95g2YdxLr5gBwQrBeP99
         UtM7aQ3xVNgjPXm67mAEmjZfb9utG4B3LJ7kL34i8AY/tBX/FIWgTQutidvArslq8Gvw
         gYFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=vksLZSJ/1XSsrv5+Q44yzVYsU90jJzgSeUJqyoBHB3k=;
        b=pjv4l7H+h1euKXSKDV66opSi2ysX8XQPQnOeDG0vUqL6n3O0tFhBsh9NhE7L5SEoqp
         Ogqyet/TaYd+kTX05ea5crEPX5iNlLNeEKtk4escH2OyTaVTX+x8U/6WMDI+0BRlmUNC
         tlh9a4nxEWw+kZMzUJMlS766suP1mApJ88ouZAJ9GXhjiUHEMXcXQ3faQLGtX1fJxgYA
         hklyElkwQ14NblHQ+izxxme0aA0wL45ZD38Vddp2AQwve3xsg65t0QgfKFuNzsoUxGCD
         cBrAzT21srZaS5WUk1Iyz+gEGNZLLMOELrjbUOPrZL5xpyVn/Jx9Vt7HihnT+c82VGd2
         Sy2A==
X-Gm-Message-State: AOAM530EFabJnKQV+E2v5RH8Uyr2Q/GLNiYCSQRy6kw6eljfOuct91hV
        AuSlLXDyz7uqWLZW/ZXuU43QS5JSUNV8
X-Google-Smtp-Source: ABdhPJw4cNpBAihFupLLJmA3rASvy2aFHNimtbkLxURoSjoyJy9KyK20TBvmXKdqAJHIt2bGqyp8Lf2ehl8/
X-Received: from mizhang-super.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1071])
 (user=mizhang job=sendgmr) by 2002:a05:6a00:1248:b0:4f7:db0:4204 with SMTP id
 u8-20020a056a00124800b004f70db04204mr21033266pfi.27.1647822400512; Sun, 20
 Mar 2022 17:26:40 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date:   Mon, 21 Mar 2022 00:26:34 +0000
Message-Id: <20220321002638.379672-1-mizhang@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
Subject: [PATCH 0/4] Verify dirty logging works properly with page stats
From:   Mingwei Zhang <mizhang@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>,
        Mingwei Zhang <mizhang@google.com>,
        David Matlack <dmatlack@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        Peter Xu <peterx@redhat.com>, Ben Gardon <bgorden@google.com>
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

This patchset is to verify if dirty logging works properly by checking page
stats from the per-VM interface. We discovered one performance bug in
disallowed_hugepage_adjust() which prevents KVM from recovering large pages
for the guest. The selftest logic added later could help validate the
problem.

The patchset borrowes two patches come from Ben's series: "[PATCH 00/13]
KVM: x86: Add a cap to disable NX hugepages on a VM" [1], which completes the
selftest library functions to use the stats interface.

[1] https://lore.kernel.org/all/20220310164532.1821490-2-bgardon@google.com/T/

Ben Gardon (2):
  selftests: KVM: Dump VM stats in binary stats test
  selftests: KVM: Test reading a single stat

Mingwei Zhang (2):
  KVM: x86/mmu: explicitly check nx_hugepage in
    disallowed_hugepage_adjust()
  selftests: KVM: use dirty logging to check if page stats work
    correctly

 arch/x86/kvm/mmu/mmu.c                        |  14 +-
 .../selftests/kvm/dirty_log_perf_test.c       |  52 +++++
 .../selftests/kvm/include/kvm_util_base.h     |   2 +
 .../selftests/kvm/kvm_binary_stats_test.c     |   6 +
 tools/testing/selftests/kvm/lib/kvm_util.c    | 196 ++++++++++++++++++
 5 files changed, 268 insertions(+), 2 deletions(-)

-- 
2.35.1.894.gb6a874cedc-goog

