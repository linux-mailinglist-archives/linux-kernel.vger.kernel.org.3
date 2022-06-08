Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A664B543F60
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 00:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236837AbiFHWp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 18:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236760AbiFHWpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 18:45:22 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DFE22504CB
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 15:45:20 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id h10-20020a170902f54a00b00166449db7f8so9875308plf.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 15:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=yCbEbo+df7vgbLKbjDx0RQYKHwie9yOVPcwB1toB8f8=;
        b=k5LfhIpAsUDz3vvRH2NBDxbNy06eyXZ+a6OkBBULxoOAC3HXgui7IfK0/8RG/XmhNh
         tG3A435WsMxzlUJO/+hIE9NZ9Vib8jN9JQ+dVUnZbkOe2cBh9bJiHypwxqjiGq3EqU3M
         Ub/yymlxK8EYeTrHwRAmd0KdRXhAR41Sj2lvOpeeJwoEV6pBTKtD272p5yWvOM3UndUD
         0/0uwvLCAgnIwK3nFLFgF6AS/ldpYm4Xc2TJW0bqT9RxEzgrAXGk304OPcN2WJatxXc8
         GYEgb4Z0xQ1CmwDZ1DRAbBZq8Zgqv3vEGen+tY72pwtLZFYW+z0G3EhdL/4qo0zdMg3X
         P1Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=yCbEbo+df7vgbLKbjDx0RQYKHwie9yOVPcwB1toB8f8=;
        b=UoopqZhIvGihvh4AiqqBhE1XwsdEbecOrm830B94lLFeoukh54NZ0L+KTP78w/3nO3
         rL+Uxw9zXCPAygV13ouhIRnlv0rGcU6+rA7IpFi5mEgHbiQvcF7hHgz7XQn44dBhhmB9
         NPZLSToLICbq0Wfq/WE0Rcg/FD27RAKGRwZLbhSD+21l3PLWVJLuAu8TWg97w1NcMK+0
         nfmpWX4ofN/FiCxMovnyjxeZpkHypglju58mVOR0HwI/KeQk3RdEyNygx1paKa/1wlhJ
         Sach/aU9WP8DVXp0Sb9O+xE7P/wQsOOifMsT9O6RzAxoEEv4IEngeG63y2IgWLKGjTGT
         w9XA==
X-Gm-Message-State: AOAM531WabsRO7k/tDe6X/sZCwNkomu47PX5UYfmaS8+pwbAfUbovyr5
        fC8Z0K7PU9a97SECgHyE83QJo6jc2Tc=
X-Google-Smtp-Source: ABdhPJxm3hT8if9YTa6TKsTS36qYZCqd0YSIH4rJVjnEN23pwM1xXA3Hc5TyBkY4ZNKCuPEGYYIcuqyBvKE=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a63:9752:0:b0:3c6:5a7a:5bd6 with SMTP id
 d18-20020a639752000000b003c65a7a5bd6mr32399629pgo.390.1654728319367; Wed, 08
 Jun 2022 15:45:19 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  8 Jun 2022 22:45:11 +0000
Message-Id: <20220608224516.3788274-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH 0/5] KVM: x86: Quirk "MWAIT never faults" behavior
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

Add a quirk to let userspace opt into correctly emulating MONITOR/MWAIT
when they are disabled in CPUID instead of unconditionally treating them
as NOPs.

The selftest changes are based on the CPUID overhaul[*], the KVM patch
should apply cleanly on kvm/queue, commit 55371f1d0c01 ("...").

Note!  Patch 3 is a fix for a bug in the Hyper-V Features test that I
encountered when verifying the exception fixup works as expected.  The
"bug", which is in reality a rather large set of bugs, basically turns
the test into a giant nop.  The patch really should be "backported" all
the way across the selftests overhaul, but I don't care enough about
Hyper-V to spend yet more time on selftests at this point.

[*] https://lore.kernel.org/all/20220604012058.1972195-1-seanjc@google.com

Sean Christopherson (5):
  KVM: x86: Add a quirk for KVM's "MONITOR/MWAIT are NOPs!" behavior
  KVM: selftests: Add x86-64 support for exception fixup
  KVM: selftests: Mostly fix comically broken Hyper-V Features test
  KVM: selftests: Use exception fixup for #UD/#GP Hyper-V MSR/hcall
    tests
  KVM: selftests: Add MONITOR/MWAIT quirk test

 Documentation/virt/kvm/api.rst                |  13 +
 arch/x86/include/asm/kvm_host.h               |   3 +-
 arch/x86/include/uapi/asm/kvm.h               |   1 +
 arch/x86/kvm/x86.c                            |  26 +-
 tools/testing/selftests/kvm/.gitignore        |   1 +
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/include/x86_64/processor.h  |  74 ++++++
 .../selftests/kvm/lib/x86_64/processor.c      |  17 ++
 .../selftests/kvm/x86_64/hyperv_features.c    | 239 ++++++++----------
 .../selftests/kvm/x86_64/kvm_pv_test.c        |  82 ++----
 .../selftests/kvm/x86_64/monitor_mwait_test.c | 127 ++++++++++
 11 files changed, 375 insertions(+), 209 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86_64/monitor_mwait_test.c


base-commit: 081ad4bbae8d503c79fae45f463766d28b2f3241
-- 
2.36.1.255.ge46751e96f-goog

