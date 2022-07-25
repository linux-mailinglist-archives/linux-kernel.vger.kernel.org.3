Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3FBA57FB79
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 10:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234001AbiGYIjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 04:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbiGYIja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 04:39:30 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0083D13FBB
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 01:39:28 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id gn24so9742884pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 01:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Amwcf3EAj1ZxcGutEEAzUz751/Dy5KvsTcGRq8AfA0Q=;
        b=jo8T+MgUl15kH1BqxkbwiWY/qbgoEYehBHZY0ciEJqcTGxiQvzgqHT3qYG64kZB09L
         Ldp30ym3utCxsNXD0V4cE/IQTpTcr9nRvBMD8Q7YAAWg3nuvXaPW8p0T+Ss6vm0Y/Yz2
         c3ItMQi8wGERX8KSJ2K/S66Eusd/msC+By5V0onbSOZucoh+78CE4Quq8eUB9G/ZjX/r
         VAcg/FmLu8rR5LtaIHTj5E1hEJjbErtRfjTCu/r8mUSjd3FlSVr66dNJmqOnSGXCzka7
         O4gm4SAldX1ww5OQz2FoSYCoBaXaUHuiE0sTeH4IAX89RZRT44a1VE2hEWrb87YYQU1t
         vaKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Amwcf3EAj1ZxcGutEEAzUz751/Dy5KvsTcGRq8AfA0Q=;
        b=Eaa6Wu+wjhLbdIkbjtyGlPpXG0mULUSJf6yU1ukLSfBRMeEhsB5GxpSDwVyiVrdHXs
         yiW/FBHI9kcLJqJV/m7hvmQvNcbetwuXj78sPPV2OLyGTbOs9M5/W+nZ3fS87n51bAcL
         kVzzjLMN4TclMc8hz55Xl7iapjXM7mn4rR7tP97C+kWi6rqvDSCTgAsFugUHZUorI2GN
         XQDAxkFqtCCg7FCEEdxA2cjTC9kFhOGzBPS4Y807uT5A8sV6yo/Bj1K0J4ywLSOPb6Fl
         GJPXcIWK2u9ubvnSdnM4huR+PCNhjVt4sl4AvcMmKLBLDiDgsxBs4WU2MJCH+NbhIfWL
         xVow==
X-Gm-Message-State: AJIora/NKGvodlOILxF1njSelFyE1Sd3DbT73/o42IcpwIVDBUw/VD/z
        Y9vrzH2KAhchBCOWqea211RV+A==
X-Google-Smtp-Source: AGRyM1vA3xEsnyiCOvmZ0T36BbcmH6gcseRwQ4GKU8Ef92TFiEimRCNdKBzLgFPlKmAJbKNRVTAXbw==
X-Received: by 2002:a17:90a:c907:b0:1ef:7655:98d7 with SMTP id v7-20020a17090ac90700b001ef765598d7mr12871560pjt.117.1658738368493;
        Mon, 25 Jul 2022 01:39:28 -0700 (PDT)
Received: from C02FG34NMD6R.bytedance.net ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id 128-20020a621886000000b0052abc2438f1sm8893479pfy.55.2022.07.25.01.39.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jul 2022 01:39:28 -0700 (PDT)
From:   Albert Huang <huangjie.albert@bytedance.com>
Cc:     "huangjie.albert" <huangjie.albert@bytedance.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sean Christopherson <seanjc@google.com>,
        Joerg Roedel <jroedel@suse.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-kbuild@vger.kernel.org
Subject: [PATCH 0/4] faster kexec reboot
Date:   Mon, 25 Jul 2022 16:38:52 +0800
Message-Id: <20220725083904.56552-1-huangjie.albert@bytedance.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "huangjie.albert" <huangjie.albert@bytedance.com>

In many time-sensitive scenarios, we need a shorter time to restart 
the kernel. However, in the current kexec fast restart code, there 
are many places in the memory copy operation, verification operation 
and decompression operation, which take more time than 500ms. Through 
the following patch series. machine_kexec-->start_kernel only takes 15ms

How to measure time:

c code:
uint64_t current_cycles(void)
{
    uint32_t low, high;
    asm volatile("rdtsc" : "=a"(low), "=d"(high));
    return ((uint64_t)low) | ((uint64_t)high << 32);
}
assembly code:
       pushq %rax
       pushq %rdx
       rdtsc
       mov   %eax,%eax
       shl   $0x20,%rdx
       or    %rax,%rdx
       movq  %rdx,0x840(%r14)
       popq  %rdx
       popq  %rax
the timestamp may store in boot_params or kexec control page, so we can
get the all timestamp after kernel boot up.

huangjie.albert (4):
  kexec: reuse crash kernel reserved memory for normal kexec
  kexec: add CONFING_KEXEC_PURGATORY_SKIP_SIG
  x86: Support the uncompressed kernel to speed up booting
  x86: boot: avoid memory copy if kernel is uncompressed

 arch/x86/Kconfig                   | 10 +++++++++
 arch/x86/boot/compressed/Makefile  |  5 ++++-
 arch/x86/boot/compressed/head_64.S |  8 +++++--
 arch/x86/boot/compressed/misc.c    | 35 +++++++++++++++++++++++++-----
 arch/x86/purgatory/purgatory.c     |  7 ++++++
 include/linux/kexec.h              |  9 ++++----
 include/uapi/linux/kexec.h         |  2 ++
 kernel/kexec.c                     | 19 +++++++++++++++-
 kernel/kexec_core.c                | 16 ++++++++------
 kernel/kexec_file.c                | 20 +++++++++++++++--
 scripts/Makefile.lib               |  5 +++++
 11 files changed, 114 insertions(+), 22 deletions(-)

-- 
2.31.1

