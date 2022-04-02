Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1234EFD9B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 03:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353570AbiDBBLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 21:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiDBBK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 21:10:57 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1BE6D94B
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 18:09:06 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id s16-20020a170902ea1000b00156547b6480so2249653plg.6
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 18:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=/1wxMj6jCJrsK/pQsyLWuXEZU/vcrnhmetMutoLaFvY=;
        b=CvNjCgpZkc+ER6pdWcmdyEtG+rzW/ZolNjH6uaIxWBctfKYnNBLzWoGvpRrRjLxPxL
         bgDYWN8WTGeRM1F3zmDjFRByRmX74vFkCJUuhvPxm+D5dmEkWDzYJTnsw4dhh/qoKFrt
         Ry8T0Dfrm30U3tXSDHEcVSNJA7U/usImovQ1uz2yKF5wm5U719ZMAlim7qSTjLvXHdcy
         PTGgqbXkFuQVMdouyWIOMEhHrjeefioCyj5dCSaaKKzlmgm75bgl0qlKFoxNfRLyjSUP
         mMC7t4R+TPMp3xFwtgGbas9vCvaj91hhm9wVUa69qQ8HsaR2Iekw2Vlg3YY7qqrA6nNa
         fgOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=/1wxMj6jCJrsK/pQsyLWuXEZU/vcrnhmetMutoLaFvY=;
        b=O/Bj/20G7p0LwcCABX0dzfP08H4gXdC/oCVvnKMcCr3Dg2O6sQTsiMc1QgHV7G2Pp8
         8P3Z6xhHaC9F8/MDYC/S5jpFrvzdzqB2vy1bEMFNMPzmt2ZM9E6GUrl4y8xGkGrcNJtY
         tA1pTwof5SaalNf5ZGaqAjaqiD+8aGV2x8WcR6DLbQOEScPAfSSAsyF/f+nNaOSwmJzk
         P9IWwWYBCncsNTx2mAzfSMqfxTL6qt2Rv//UuFMQe1ovVSomr6hADA2BWNZLlX9pdmNr
         Pg+ixClynr7Q6CD13JoCDPGiAgB6KvuOeRy9vsvwjcB0Nf4cK54iQoqsV0cOI/N4udr2
         GRfQ==
X-Gm-Message-State: AOAM5328SntXJDVSjmgFzX6RRnOBPsozkILlzZ0OCD6NhsOAgko+4/cp
        ovLpIUEPvxicKGT9I49YLjV364MPcqw=
X-Google-Smtp-Source: ABdhPJxNbjj3Vl+VEt342h9Nhha05W09e+MKtMj/sK89bcHH0ZUQfiIceLYmQ/ZSb7UqAC2YYU6m1MkpKU8=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a62:1ad3:0:b0:4fa:9adc:7680 with SMTP id
 a202-20020a621ad3000000b004fa9adc7680mr13639453pfa.25.1648861745619; Fri, 01
 Apr 2022 18:09:05 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Sat,  2 Apr 2022 01:08:55 +0000
Message-Id: <20220402010903.727604-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1094.g7c7d902a7c-goog
Subject: [PATCH 0/8] KVM: SVM: Fix soft int/ex re-injection
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>
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

This is a continuation/alternative of Maciej's series[*] to fix soft
interrupt/exception reinjection.  The core difference is that this version
fixes the underlying issue of not doing proper reinjection, which
manifests most readily as the nested virtualization bugs Maciej's series
addressed.

The underlying issue is that SVM simply retries INT* instructions instead
of reinjecting the soft interupt/exception if an exception VM-Exit occurred
during vectoring.  Lack of reinjection breaks nested virtualization if
the injected event came from L1 and the VM-Exit is not forwarded to L1,
as there is no instruction to retry.  More fundamentally, retrying the
instruction is wrong as it can produce side effects that shouldn't occur,
e.g. code #DBs.

VMX has been fixed since commit 66fd3f7f901f ("KVM: Do not re-execute
INTn instruction."), but SVM was left behind.  Probably because fixing
SVM is a mess due to NRIPS not being supported on all architectures, and
due to it being poorly implemented (with respect to soft events) when it
is supported.

[*] https://lore.kernel.org/all/cover.1646944472.git.maciej.szmigiero@oracle.com

Maciej S. Szmigiero (3):
  KVM: nSVM: Sync next_rip field from vmcb12 to vmcb02
  KVM: SVM: Downgrade BUG_ON() to WARN_ON() in svm_inject_irq()
  KVM: selftests: nSVM: Add svm_nested_soft_inject_test

Sean Christopherson (5):
  KVM: SVM: Unwind "speculative" RIP advancement if INTn injection
    "fails"
  KVM: SVM: Stuff next_rip on emualted INT3 injection if NRIPS is
    supported
  KVM: SVM: Re-inject INT3/INTO instead of retrying the instruction
  KVM: SVM: Re-inject INTn instead of retrying the insn on "failure"
  KVM: x86: Trace re-injected exceptions

 arch/x86/kvm/svm/nested.c                     |  22 ++-
 arch/x86/kvm/svm/svm.c                        | 135 ++++++++++++----
 arch/x86/kvm/svm/svm.h                        |   5 +-
 arch/x86/kvm/x86.c                            |   8 +-
 tools/testing/selftests/kvm/.gitignore        |   1 +
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/include/x86_64/svm_util.h   |   2 +
 .../kvm/x86_64/svm_nested_soft_inject_test.c  | 147 ++++++++++++++++++
 8 files changed, 279 insertions(+), 42 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86_64/svm_nested_soft_inject_test.c


base-commit: 81d50efcff6cf4310aaf6a19806416ffeccf1cdb
-- 
2.35.1.1094.g7c7d902a7c-goog

