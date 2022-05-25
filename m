Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBFAE534598
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 23:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345033AbiEYVEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 17:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238559AbiEYVEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 17:04:51 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFA5BA573
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 14:04:51 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id z21-20020aa79595000000b00518157fadaeso9774551pfj.14
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 14:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=QomCG97xArSjBeEKWzBOAokkYzU04yNWeTK5y9/ZMlw=;
        b=XU3Id7VYyglpjdYcRKpTkcNiV28q88bUG4DHvqX3DKxcrzLx/JG3pnxd5yVWwuz76b
         yFmPjJnIWWpri5WIFFTtRQkP/kuswjmF9Nj4u5DkV5aXjFrzw7FqDuixi1Vigu9wXNoI
         vV6NAWrr0uYZhUybWxSJdEb7WK8EcL/zoznOmFAaxRv6DRzx4gthNIndeCuKIbgh++AX
         GPh3LN58r93aLQCOu1q27RiDoFcgygEdeCJo8HI0UXqhW2cCP+DceBMg4k/SGTipQFwI
         yvI1wtppMnR3da/Y7/O7EFAUhrcbDiJShnrgL3TvY9vUbMhyLvpPn0mPUzAhTcHK5qQH
         3MlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=QomCG97xArSjBeEKWzBOAokkYzU04yNWeTK5y9/ZMlw=;
        b=3a56SUKiR+gZrJ7AANlo5+sOUnLh4PGA7XCnRcDBrm8ESKtCa/lg5G2cHVcPlKB4wP
         95q+xX+jBIUUSdQSAjIXxtKBsp9VKGCSZaxBR9FLYMMxjF64ZFz3oEtxd33GguRhhnSx
         majmNKtJkxKHHIcNo7ixBxevmy8b6g7ZlEdyswhaR6uUh2rk8S6gZ6KxjrJH8ORA2b6g
         2O/4uBYyCBZnQvdlbyAxQKyJGujlyEe6fcw9pxg11jO2RiQnJHeqBZfDNWxMQdFSYL4a
         bWBEvSuQpnWOfm+tjf2JQTFshX1h4WX5KjYlwASQU+izHRvN7miO02Ow332nEWL1R5YX
         cP0g==
X-Gm-Message-State: AOAM531+Cb8YSZzcwx2CXlBEUwdwmI+R+KywD7k7BaM2ky58Fj8N+wIc
        0pEw4mkmuxdEUqHxVFQ9fWtmm70Th98=
X-Google-Smtp-Source: ABdhPJyEODHAGPHiUxSQ5qZmumgYwlMCmweGBOQLGEvxMThAVVfXJiKrgwS1trRnBIorXWNEk5L9EIQF2GE=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:d4d2:b0:163:5376:b4d7 with SMTP id
 o18-20020a170902d4d200b001635376b4d7mr5805189plg.66.1653512690712; Wed, 25
 May 2022 14:04:50 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 25 May 2022 21:04:45 +0000
Message-Id: <20220525210447.2758436-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
Subject: [PATCH 0/2] KVM: VMX: Sanitize VM-Entry/VM-Exit pairs during setup
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chenyi Qiang <chenyi.qiang@intel.com>,
        Lei Wang <lei4.wang@intel.com>
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

Sanitize the VM-Entry/VM-Exit load+load and load+clear pairs when kvm_intel
is loaded instead of checking both controls at runtime.  Not sanitizing
means KVM ends up setting non-dynamic bits in the VMCS.

Add an opt-in knob to force kvm_intel to bail if an inconsistent pair is
detected instead of using a degraded and/or potentially broken setup.

Arguably patch 01 is stable material, but my mental coin flip came up
negative and I didn't Cc: stable.

And for patch 02, I'd definitely be favor of making it opt-out instead of
opt-in, but there's a non-zero chance that someone out there is running
KVM in a misconfigured VM...

Sean Christopherson (2):
  KVM: VMX: Sanitize VM-Entry/VM-Exit control pairs at kvm_intel load
    time
  KVM: VMX: Add knob to allow rejecting kvm_intel on inconsistent VMCS
    config

 arch/x86/kvm/vmx/capabilities.h | 13 +++-----
 arch/x86/kvm/vmx/vmx.c          | 55 +++++++++++++++++++++++++++++++--
 2 files changed, 56 insertions(+), 12 deletions(-)


base-commit: 90bde5bea810d766e7046bf5884f2ccf76dd78e9
-- 
2.36.1.124.g0e6072fb45-goog

