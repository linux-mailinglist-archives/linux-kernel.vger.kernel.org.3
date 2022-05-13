Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B628526624
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 17:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382034AbiEMPap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 11:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382030AbiEMPan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 11:30:43 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42CCE712EA
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 08:30:40 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id m20so16912353ejj.10
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 08:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xUEx3I1KmFe3f6G843l1z1typATuOG9N5rznDstW+IY=;
        b=DXrxqokqK+54f9Ji68ilMMfcM7aFJUWE6psdxLkIo31532aCNysVak89gid1u1PF7e
         24ho1xC/C0AcCvQOnFUwtrrbV3Wdf4dmZ6MPxkwBjSSNxvK5DvmSV0tKDg7BN/yPVejv
         YQFj86XjuVRCjuey1SCW1btso8VcezMaLE9yjlQrjYVJDhgMckgRDcOiZhxhIkwvuQl2
         g3y3Dm6nLHBOV316HYVMv4gCPFehTr8zw/wisTSebB7hPKiMs7InwYqmWxF8W6zYrxUD
         S/EzpYK3gbrT60Can7p0soYjFoCvPtMg7y1fhtACz5hzFhhiAU2DgGFkjS+ZYaOIVWWD
         R1wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xUEx3I1KmFe3f6G843l1z1typATuOG9N5rznDstW+IY=;
        b=o4spj+GT0jhH9YMlTUY4i7CjIF1QNvVsX6bphMhPACVxGNCl7vtLtLPqekxBGYs38e
         +b5zDzhwwoCLsqOb1SF+6dKJ6CnebRw1FQAP+FauYQGytSBf8n7XuJZGhUP+LpW7INfF
         Ho1xuH3DGIudgJEAtP4CkA3SEjFOAnlaGwje2QgnJha8tbbNdmFJhyiaqiitRQGpzcYe
         4qoqc98bXBEIAthtkCm+jKMB1yHPp0hB3QM3LaqqRf1BnORJ/ypJHTDu7ZQ8jdYzAXlh
         4Sat3qMK4+GkGe57R/x9BQD/5a+pSseTAobXztWZ6nLSayfImyLLzm8Jlzu7eo0r2gpV
         rkGQ==
X-Gm-Message-State: AOAM530QP6vT+IvK60681DF1aaJgO2ixNJU1O5ahxK0vBeWnr0EfdOhm
        2dJJpjEL+RQoVO290WQx76Y=
X-Google-Smtp-Source: ABdhPJxNy4KQCcWO7HXR3Ji2GilqqqzZkhzDqV9TLJ0HaKOaBu6uU1ddyqOmxWaN2CuThL3mcFljIQ==
X-Received: by 2002:a17:907:9712:b0:6f4:ab87:5723 with SMTP id jg18-20020a170907971200b006f4ab875723mr4803587ejc.430.1652455838690;
        Fri, 13 May 2022 08:30:38 -0700 (PDT)
Received: from localhost.localdomain (93-103-18-160.static.t-2.net. [93.103.18.160])
        by smtp.gmail.com with ESMTPSA id h9-20020a50cdc9000000b0042617ba63d5sm1075706edj.95.2022.05.13.08.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 08:30:38 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Marco Elver <elver@google.com>
Subject: [PATCH v2 0/2] locking/atomic/x86: Introduce arch_try_cmpxchg64
Date:   Fri, 13 May 2022 17:30:07 +0200
Message-Id: <20220513153009.228282-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The followign patchset introduces generic support for try_cmpxchg64
and introduces arch_try_cmpxchg64 for 64-bit and 32-bit targets.
On 64-bit targets, the generated assembly improves from:

  ab:	89 c8                	mov    %ecx,%eax
  ad:	48 89 4c 24 60       	mov    %rcx,0x60(%rsp)
  b2:	83 e0 fd             	and    $0xfffffffd,%eax
  b5:	89 54 24 64          	mov    %edx,0x64(%rsp)
  b9:	88 44 24 60          	mov    %al,0x60(%rsp)
  bd:	48 89 c8             	mov    %rcx,%rax
  c0:	c6 44 24 62 f2       	movb   $0xf2,0x62(%rsp)
  c5:	48 8b 74 24 60       	mov    0x60(%rsp),%rsi
  ca:	f0 49 0f b1 34 24    	lock cmpxchg %rsi,(%r12)
  d0:	48 39 c1             	cmp    %rax,%rcx
  d3:	75 cf                	jne    a4 <t+0xa4>

to:

  b3:	89 c2                	mov    %eax,%edx
  b5:	48 89 44 24 60       	mov    %rax,0x60(%rsp)
  ba:	83 e2 fd             	and    $0xfffffffd,%edx
  bd:	89 4c 24 64          	mov    %ecx,0x64(%rsp)
  c1:	88 54 24 60          	mov    %dl,0x60(%rsp)
  c5:	c6 44 24 62 f2       	movb   $0xf2,0x62(%rsp)
  ca:	48 8b 54 24 60       	mov    0x60(%rsp),%rdx
  cf:	f0 48 0f b1 13       	lock cmpxchg %rdx,(%rbx)
  d4:	75 d5                	jne    ab <t+0xab>

where a move and a compare after cmpxchg is saved.  The improvements
for 32-bit targets are even more noticeable, because dual-word compare
after cmpxchg8b gets eliminated.

Changes since v1:
 * Implement full support for try_cmpxchg64{,_acquire,_release,_relaxed}
and their falbacks involving cmpxchg64.
 * Split patch to generic and target-dependant part.
 * Modernize __try_cmpxchg64 asm template with symbolic operand name.
 * Use generic fallback when arch_try_cmpxchg64 is not defined.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Marco Elver <elver@google.com>

Uros Bizjak (2):
  locking/atomic: Add generic try_cmpxchg64 support
  locking/atomic/x86: Introduce arch_try_cmpxchg64

 arch/x86/include/asm/cmpxchg_32.h           | 21 ++++++
 arch/x86/include/asm/cmpxchg_64.h           |  6 ++
 include/linux/atomic/atomic-arch-fallback.h | 72 ++++++++++++++++++++-
 include/linux/atomic/atomic-instrumented.h  | 40 +++++++++++-
 scripts/atomic/gen-atomic-fallback.sh       | 31 +++++----
 scripts/atomic/gen-atomic-instrumented.sh   |  2 +-
 6 files changed, 156 insertions(+), 16 deletions(-)

-- 
2.35.1

