Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7BCF53466F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 00:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345426AbiEYW0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 18:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344944AbiEYW0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 18:26:10 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F93AA
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 15:26:08 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id c14-20020a170903234e00b0016374194948so319270plh.19
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 15:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=k1BthjPgV7bQ6cNfFTK+8rBrGBtp639pLinxXU1m8Ho=;
        b=Lejy4SDHGOTx73pYIreEYpHBRj1zlEZ7dvsywLDPdUJ5zzZEumvyp3uLGgex5dHGEk
         vjEYzYudLsWug+4MQc8jfCHJ1+P+E7tHOGFTR8q/Yk2Lo7LaxhBAIEdcAal9nr+nqY3l
         9JS8D9tFUfoS2J68w03A4N6+5dSXXG3DVvMBFQ01L9fCiwXmBJRK67Tl3fw6GO0YVBF6
         5D5b0uSPPM/c3duxVeOz8+MjJy7NxRr0Cwdll5cKMbnPRwIgM0FkXcdwkfmL1w1iu41j
         3p4wMo9wSOXPT4ceYsFLuVqrFhY+EVLAFWXhpRZRBfyrtiMWNnESRwB1u0hkKFE+O63+
         PlYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=k1BthjPgV7bQ6cNfFTK+8rBrGBtp639pLinxXU1m8Ho=;
        b=HNXWUw2LwG89rn0VqkIgtUN1f64rG2ghfMmfrxOAw5MUphlLAZmE/CYMd1+7tdRIYi
         FBerXM0YN6xApr86/AW7wNWuAiBqAIrkbej5qS38L9EGifVtcap9NYWct1aGfB9aCD9b
         EtGaZjdJOTnUbluV3JWi9WcO8NwJaUESjJUC8PjP0BoPKyvaoMM52ntgRAfbNXjmjHnl
         GUY+aD8TnU96CfyAXnfdmrBsJTdosyM0xdwTZqp+MKThksuhbCH0mY06nG30cMlMTJTk
         Fitkve5gED2KtqBb25ZfuPkDZDtzkJt9Mztc1thRq0UWdwaK4E8YcBR/uiTL7aHf94hs
         XnUg==
X-Gm-Message-State: AOAM530xLRhh3+WBUJ3cKnX5fNfSAorVtAKjLGsnjA3CYxdkLoZlg6rL
        Vugr0qU7iybZzL3qaRuJVFVFbHjnVz8=
X-Google-Smtp-Source: ABdhPJzpK80n4XXnmnAuMG6yeiR7ZWEUUH/froE6+s05Poen8FWFQfnGnzxvOExtdBw3LmjaHO0EqiwCxkM=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90a:6487:b0:1df:7e0f:c93e with SMTP id
 h7-20020a17090a648700b001df7e0fc93emr12833136pjj.77.1653517567858; Wed, 25
 May 2022 15:26:07 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 25 May 2022 22:26:00 +0000
Message-Id: <20220525222604.2810054-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
Subject: [PATCH 0/4] KVM: x86: Emulator _regs fixes and cleanups
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robert Dinse <nanook@eskimo.com>,
        Kees Cook <keescook@chromium.org>
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
by Kees and Robert where GCC-12 flags an out-of-bounds _regs access.  I'm
99% certain GCC-12 is wrong and is generating a false positive, but just in
case...

I didn't tag patch 2 with Fixes or Cc: stable@; if it turns out to "fix"
the GCC-12 compilation error, it's probably worth sending to v5.18 stable
tree (KVM hasn't changed, but the warning=>error was "introdued in v5.18
by commit e6148767825c ("Makefile: Enable -Warray-bounds")).

Sean Christopherson (4):
  KVM: x86: Grab regs_dirty in local 'unsigned long'
  KVM: x86: Harden _regs accesses to guard against buggy input
  KVM: x86: Omit VCPU_REGS_RIP from emulator's _regs array
  KVM: x86: Use 16-bit fields to track dirty/valid emulator GPRs

 arch/x86/kvm/emulate.c     | 14 ++++++++++++--
 arch/x86/kvm/kvm_emulate.h | 14 +++++++++++---
 2 files changed, 23 insertions(+), 5 deletions(-)


base-commit: 90bde5bea810d766e7046bf5884f2ccf76dd78e9
-- 
2.36.1.124.g0e6072fb45-goog

