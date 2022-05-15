Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4018F527931
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 20:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238381AbiEOSmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 14:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236850AbiEOSm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 14:42:26 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C529DE7
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 11:42:24 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id j6so24841179ejc.13
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 11:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XyHLOKOVQbDpT7eahnROR3m4U53LPSqe6ZPVDJA+AE8=;
        b=JNYkq5EcWWSWYB4B3v514DHG8EMVEqmr6E5cLyvmNEv3kcSa5l/GmIaJOPki2W1vae
         R2x9MrhyOd0p2JC2fk20WnPSyN0093UElSysa3FHDoHXpjmCyOMAZwIgQQg0FUTWfDEo
         +TrmR+VrXXiL4qdSIlVOXpVKZOpowhniQHtV1SRpO5GFj1xn+N50bawcpGlbtKodxT8l
         ofkBd3JM+ZqR0c2laA5Ic1bYBttGtozbVNHsQC2A+9VpTPhYVbSHRwBsBVNYuMDIy3tm
         810Ogsx4fBqpkqQ2xxAD1QsAK+sWvjD+KUYY+gudLx6NuRK+eyYjDg6BS9s1VAG8xPTW
         lcvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XyHLOKOVQbDpT7eahnROR3m4U53LPSqe6ZPVDJA+AE8=;
        b=wkWsTk9dO+X1FmsrG1NIGdctcFfvj0Qj5hu7kCX/AdBl1TJd2uRyGdY0H/54DeUDol
         pTPO1GYG7RDgk1KSBF9cpKA5lNt7VSvtqAE3NeNTB4zxz8WbD6Uv1jLB9Ex/gE2+IhIS
         rHg2cq2VqHYLqx4BtBtV/B3Fmvu1nqBoz0cp2sYuFzg7MHC8LL5qlBRyWSyHBOcD9DKc
         TmPnN+U6dJ3kTt/S7b4LGTQYoA6wFIMPgzcmFkXAqpAeKTsK6kHHLBUP6TsOAKdcVguT
         tilNxNFHB8YXc/dll/x5/MrNlHSWehAJKqbHMPFypkz6igyBdXLy7ogzbV0VLMmsmY3y
         NEcA==
X-Gm-Message-State: AOAM5300hDUIUSPPeBTEUNFFvLN24Y4Rxx4AbYROJ/X7JktAcRtrKtV+
        i1FTT08dsbHcxO/49qh/TUU=
X-Google-Smtp-Source: ABdhPJx7NkxJxjqUCw4Z7EV8zMWHMcWBTuqs4H4hT1/ANgNLTRD+Yp8GczDIaSCoGCpqo5jWToNc4w==
X-Received: by 2002:a17:907:86a5:b0:6f9:aa0f:a838 with SMTP id qa37-20020a17090786a500b006f9aa0fa838mr12179163ejc.340.1652640142963;
        Sun, 15 May 2022 11:42:22 -0700 (PDT)
Received: from localhost.localdomain (93-103-18-160.static.t-2.net. [93.103.18.160])
        by smtp.gmail.com with ESMTPSA id hv7-20020a17090760c700b006f3ef214e62sm2861898ejc.200.2022.05.15.11.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 May 2022 11:42:22 -0700 (PDT)
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
Subject: [PATCH v3 0/2] locking/atomic/x86: Introduce arch_try_cmpxchg64
Date:   Sun, 15 May 2022 20:42:02 +0200
Message-Id: <20220515184205.103089-1-ubizjak@gmail.com>
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

Changes since v2:
 * Remove invalid and unnecessary cast from 32-bit arch_try_cmpxchg64.
 
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

