Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0B6D4A6953
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 01:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243214AbiBBAuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 19:50:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238381AbiBBAt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 19:49:59 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498CDC06173B
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 16:49:59 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id o194-20020a62cdcb000000b004c9d2b4bfd8so9919990pfg.7
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 16:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=g6pUKH4WYbWgbDwKBU0IMA28eYRiLDk9vkLPEbdpMnw=;
        b=i6JiUALu1FJfRzDuhQAUfNtgTJ+zakIybzPqhobpinojJGET1wdn+8w02g/1G8c/H0
         7QiDU6eahxRSKVG3t2E+6wnV4blltOS12NFn0qEn3cTBzKBdZm4FSw4t5yT52CSuQX8E
         lXLrFH9oXa6Pki+a22egJUg8qRAHrTul1SgjAb1wUYTyEoE6HBAZtD+0GTr0+5gYVt7U
         5nzJewN75+ggCxUb7KSEUmXMOAQ/ZiJrnlrWyWJ+napeTa7EiMoh1Gim19or+92uhDWW
         AUMctQKhwgDXukqrxVdGb9WjcJc7tJSeTUJou6BVURmtfUUhsX9NY7opH+tSveXGbRIp
         wMJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=g6pUKH4WYbWgbDwKBU0IMA28eYRiLDk9vkLPEbdpMnw=;
        b=SwqcIHioEvdDDFXOM8BSwp+q8LZO/g5UzTp2RzpYsJRhL8SlMJ9KvmLtpjT1w5xMN+
         MJVoYnvi7kUDCJwQ74hcsUhKCWN6uabxl+PcT2jDt7VccTN3Aavygg5ymspJc6jcitwg
         qL4wExE6jMrWQUV3pYCeCL8ZBH7DIlf0/j04f/X00Na6rdhsPCQOQeR9gBB7gHc8Nk1S
         qhOliWP4l+iOq0GhIWFdbNZk3sqsRC5lR2zhvWWGWDIL+tvTRBasd192ICLUby+1+fZl
         hkl/oYZr9SoV+uWHFkHD3PC2FaVAcmtJNGmu9uk8HNOsQDgJCgRtlrheqbunrfEdOymZ
         n9QA==
X-Gm-Message-State: AOAM531TFCA3ZbbtM6uLr5lwffnt+/MrFVJJIMojwjbbqzuQQPNn0mPV
        G9nCl4CRiD5p/HXeFALa3E+0K9C+cMg=
X-Google-Smtp-Source: ABdhPJwlOwN/0H3aP3IPT+BMUXP+/p+nmyTa05iEyOcuehJZ4qfPcXwrDRkyY7xiTPbyi6tBdy0W4Scx52c=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:ecc5:: with SMTP id
 a5mr29153463plh.54.1643762998560; Tue, 01 Feb 2022 16:49:58 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  2 Feb 2022 00:49:40 +0000
Message-Id: <20220202004945.2540433-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
Subject: [PATCH v2 0/5] x86: uaccess CMPXCHG + KVM bug fixes
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Tadeusz Struk <tadeusz.struk@linaro.org>,
        syzbot+6cde2282daa792c49ab8@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter, please take a look at unsafe_try_cmpxchg_user() to make sure it
(a) still looks right and (b) works for your use case.  I added explicit
casts to play nice with clang and sparse, as well as a __chk_user_ptr()
given the use of __force.


Add uaccess macros for doing CMPXCHG on userspace addresses and use the
macros to fix KVM bugs by replacing flawed code that maps memory into the
kernel address space without proper mmu_notifier protection (or with
broken pfn calculations in one case).

Add yet another Kconfig for guarding asm_volatile_goto() to workaround a
clang-13 bug.  I've verified the test passes on gcc versions of arm64,
PPC, RISC-V, and s390x that also pass the CC_HAS_ASM_GOTO_OUTPUT test.

Patches 1-4 are tagged for stable@ as patches 3 and 4 (mostly 3) need a
backportable fix, and doing CMPXCHG on the userspace address is the
simplest fix from a KVM perspective.

v2:
  - Explicitly cast with (__force u<size> *) to fix clang+i386
    compilation woes and sparse warnings. [kernel test robot]
  - Rework i386's CMPXCHG8B to force use of ECX for the error path so that
    clang doesn't run out of input/output GPRs...
  - Document that gcc also has/had troubles, and note the clang and gcc
    versions that (should) work with tied outputs. [Nick]
  - Collect tags [Nick, Tadeusz]

v1: https://lore.kernel.org/all/20220201010838.1494405-1-seanjc@google.com

Peter Zijlstra (1):
  x86/uaccess: Implement macros for CMPXCHG on user addresses

Sean Christopherson (4):
  Kconfig: Add option for asm goto w/ tied outputs to workaround
    clang-13 bug
  KVM: x86: Use __try_cmpxchg_user() to update guest PTE A/D bits
  KVM: x86: Use __try_cmpxchg_user() to emulate atomic accesses
  KVM: x86: Bail to userspace if emulation of atomic user access faults

 arch/x86/include/asm/uaccess.h | 142 +++++++++++++++++++++++++++++++++
 arch/x86/kvm/mmu/paging_tmpl.h |  45 +----------
 arch/x86/kvm/x86.c             |  35 ++++----
 init/Kconfig                   |   5 ++
 4 files changed, 162 insertions(+), 65 deletions(-)


base-commit: 26291c54e111ff6ba87a164d85d4a4e134b7315c
-- 
2.35.0.rc2.247.g8bbb082509-goog

