Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD0EF535564
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 23:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348863AbiEZVYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 17:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237337AbiEZVYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 17:24:18 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A624C7AA
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 14:24:17 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id om5-20020a17090b3a8500b001df42f1cbaaso3885217pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 14:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=mOpI/+KYEZdbicuZlQkRSCxZ1y9mz9g1l8prxAxeWBQ=;
        b=WsfHkiW/udderPR0r7wqNd2MXukeGBYWW7b/3FjGwLvQvLB7HuDmwuCi+T2GLYkgo/
         GwZxyWANLG5Teqq7jC1OKUr7S0Ag/hjj4osE7NLbe4dWfKwRXSbQXrmohE5C73XYwLbk
         r27+HcOalBxWxQ0rTHQYScxcIRyAP3wxbZr5OV+XZAIjpawDTjyCdormq0QKaDHlKJ7d
         bkEnd4QmrejzO3Eu5lJZ3YA9Yxs3eeGJX5hloedjrj1i7MtekfY2AW7/aQ2n7vybUmxN
         6UoYnaKeehZN5gYCwKskPn1sN//Fh4x7SunC79xIjeHSvcwZe+fKYzcByy91G2RXum7X
         chEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=mOpI/+KYEZdbicuZlQkRSCxZ1y9mz9g1l8prxAxeWBQ=;
        b=IYinTUOnydTkFryDHPTodKoHZq3RlVIFXSFRa6FtEBQok8Rpwa7WaXZ6C8AsjHMYBA
         ky3zxoi5Pk8BudT6pzFU4rG7KmdpVuMc0PWDxFh2l6/GcQJvMj0GA/IJnmCjoycXWMqV
         GvsfBBpS4Vp6gS8dyWqApmtRLViEFmMujCCEDKRXmNHroCCa4mdWdOFCV9zHnZymJz7X
         uz6Br0H86PQcZRXPsfZrDoCxq/EakogEBABRt3LXrPIlB6Hf6CES89A2mcstdtPMeEdx
         Vh8tAeRasxQdLmpvniYKfeZo1BXlb03izSvkccEdQOI2Oam3U35XSwDsfoidTC4Slkpr
         zp2w==
X-Gm-Message-State: AOAM531Hljmn89KWcq66RYVm/iRk/9SZEL6XE/kWuOtryCDX+PKmwaGV
        dmMDMpWOqyu/zknR9y9DSjEEDRPXVwQ=
X-Google-Smtp-Source: ABdhPJxzk5JajMO4kk7EeMLmpp0YUvfoHhz1BHLMWcZFnj442UGh2Ej356Klhh6wHL6kvWZRRscH1w1jr+U=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:170e:b0:519:3571:903e with SMTP id
 h14-20020a056a00170e00b005193571903emr581498pfc.30.1653600257340; Thu, 26 May
 2022 14:24:17 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 26 May 2022 21:08:09 +0000
Message-Id: <20220526210817.3428868-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH v2 0/8] KVM: x86: Emulator _regs fixes and cleanups
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Robert Dinse <nanook@eskimo.com>
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

Clean up and harden the use of the x86_emulate_ctxt._regs, which is
surrounded by a fair bit of magic.  This series was prompted by bug reports
by Kees and Robert where GCC-12 flags an out-of-bounds _regs access.  The
warning is a false positive due to a now-known GCC bug, but it's cheap and
easy to harden the _regs usage, and doing so minimizing the risk of more
precisely handling 32-bit vs. 64-bit GPRs.

I didn't tag patch 2 with Fixes or Cc: stable@.  It does remedy the
GCC-12 warning, but AIUI the GCC-12 bug affects other KVM paths that
already have explicit guardrails, i.e. fixing this one case doesn't
guarantee happiness when building with CONFIG_KVM_WERROR=y, let alone
CONFIG_WERROR=y.  That said, it might be worth sending to the v5.18 stable
tree[*] as it does appear to make some configs/setups happy.

[*] KVM hasn't changed, but the warning=>error was introduced in v5.18 by
   commit e6148767825c ("Makefile: Enable -Warray-bounds").

v2:
  - Collect reviews and tests. [Vitaly, Kees, Robert]
  - Tweak patch 1's changelog to explicitly call out that dirty_regs is a
    4 byte field. [Vitaly]
  - Add Reported-by for Kees and Robert since this does technically fix a
    build breakage.
  - Use a raw literal for NR_EMULATOR_GPRS instead of VCPU_REGS_R15+1 to
    play nice with 32-bit builds. [kernel test robot]
  - Reduce the number of emulated GPRs to 8 for 32-bit builds.
  - Add and use KVM_EMULATOR_BUG_ON() to bug/kill the VM when an emulator
    bug is detected.  [Vitaly]

v1: https://lore.kernel.org/all/20220525222604.2810054-1-seanjc@google.com

Sean Christopherson (8):
  KVM: x86: Grab regs_dirty in local 'unsigned long'
  KVM: x86: Harden _regs accesses to guard against buggy input
  KVM: x86: Omit VCPU_REGS_RIP from emulator's _regs array
  KVM: x86: Use 16-bit fields to track dirty/valid emulator GPRs
  KVM: x86: Reduce the number of emulator GPRs to '8' for 32-bit KVM
  KVM: x86: Bug the VM if the emulator accesses a non-existent GPR
  KVM: x86: Bug the VM if the emulator generates a bogus exception
    vector
  KVM: x86: Bug the VM on an out-of-bounds data read

 arch/x86/kvm/emulate.c     | 26 ++++++++++++++++++++------
 arch/x86/kvm/kvm_emulate.h | 28 +++++++++++++++++++++++++---
 arch/x86/kvm/x86.c         |  9 +++++++++
 3 files changed, 54 insertions(+), 9 deletions(-)


base-commit: 90bde5bea810d766e7046bf5884f2ccf76dd78e9
-- 
2.36.1.255.ge46751e96f-goog

