Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD7C55B405
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 22:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbiFZUSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 16:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbiFZUSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 16:18:03 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECCA328A
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 13:18:01 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id cw10so15039587ejb.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 13:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j4NnptTI930RCrNBLRbKJCj3ThziKrmfM9Za5JGu2/4=;
        b=K/44PZx/8zO9Q6BGtmjJGZRS6Bu3hE8WNRr2NbhJam0AACKXOb/hDVs9XOPmDCeTu5
         neuwp543fBpISe3JxPHhx8V+EWuW8GF/ICpfKkQVb01DhwmPms16o7+v5bIo7K48nd5s
         rN4Q4OLlaG5kWt0/CTjQIQXHPqqQjzgs8hemWFJOjcGXb7sIZKFhViWS1rLnoRwSVolO
         BPCretlTH75p40c6cZ7w8OZ0mSSr5WJtjNvU7C2WD+CVMdNy4TfuGjJNPiSrt76NMSwz
         jpy24K17tBcytparTDSM7ia10V4wuqr8VrwrxfuBXBelwPreXSscH9lAls/ozyaQZxEk
         VdDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j4NnptTI930RCrNBLRbKJCj3ThziKrmfM9Za5JGu2/4=;
        b=qO0hT3BE6rmXrN0DBN8ub61xzVikYZrlykd/MUXdEjHUNokMXC/oUrYxhr2t9W1Cic
         mfAvqKq1+msK0ZwwlogZPtTejPqul2qSHjiLkdS465HagPMWgDezMDCY7jNbELzsHN68
         QkRw9zdBf6X9PKrjvtTzbmHdUZOvEnsU6ZVci9Uk+8Hy7OXVAurFjZTS7rs5IpfMA0zc
         RhTdAVrcoMal5xBnFONuPYD10bCwUIDhboW47cHLuTGFfHiFfmxHTJwVgAbEVPgxu5dI
         wCUFwlfOhkxfASpDdfkbVxj2Mwn3FZOBUpyT4/i05H77+v+mHAjQ/Kwnt4zjegM2zEoJ
         NKKA==
X-Gm-Message-State: AJIora9D5iCLdT3pZ3FUclakJbnk43iZ/ge30Tmxytw6E5LLb8Fu3MNd
        ApRlfrI7icINNDCss8BMK2gTQBn4y8VZiQ==
X-Google-Smtp-Source: AGRyM1tWX0962QV0y6FBnM4leSdQTz1PJWZDKSALFBxfE7oIuzVFYRLeXuNCuiqc0nEOT8mciqMVuA==
X-Received: by 2002:a17:906:3f94:b0:722:fb52:5a24 with SMTP id b20-20020a1709063f9400b00722fb525a24mr9296447ejj.604.1656274680453;
        Sun, 26 Jun 2022 13:18:00 -0700 (PDT)
Received: from localhost.localdomain (93-103-18-160.static.t-2.net. [93.103.18.160])
        by smtp.gmail.com with ESMTPSA id n18-20020aa7c792000000b00435c7cf30casm6394493eds.3.2022.06.26.13.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jun 2022 13:18:00 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 RESEND] locking/lockref/x86: Enable ARCH_USE_CMPXCHG_LOCKREF for X86_CMPXCHG64
Date:   Sun, 26 Jun 2022 22:17:12 +0200
Message-Id: <20220626201712.18064-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.35.3
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

Commit bc08b449ee14ace4d869adaa1bb35a44ce68d775 enabled lockless
reference count updates using cmpxchg() only for x86_64 and
left x86_32 behind due to inability to detect support for
cmpxchg8b instruction. Nowadays, we can use CONFIG_X86_CMPXCHG64
for this purpose. Also, by using try_cmpxchg64() instead of cmpxchg64()
in CMPXCHG_LOOP macro, the compiler actually produces sane code,
improving lockref_get_or_lock main loop from:

 2a5:	8d 48 01             	lea    0x1(%eax),%ecx
 2a8:	85 c0                	test   %eax,%eax
 2aa:	7e 3c                	jle    2e8 <lockref_get_or_lock+0x78>
 2ac:	8b 44 24 08          	mov    0x8(%esp),%eax
 2b0:	8b 54 24 0c          	mov    0xc(%esp),%edx
 2b4:	8b 74 24 04          	mov    0x4(%esp),%esi
 2b8:	f0 0f c7 0e          	lock cmpxchg8b (%esi)
 2bc:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
 2c0:	89 c3                	mov    %eax,%ebx
 2c2:	89 d0                	mov    %edx,%eax
 2c4:	8b 74 24 08          	mov    0x8(%esp),%esi
 2c8:	31 ca                	xor    %ecx,%edx
 2ca:	31 de                	xor    %ebx,%esi
 2cc:	09 f2                	or     %esi,%edx
 2ce:	75 40                	jne    310 <lockref_get_or_lock+0xa0>

to:

  2d:	8d 4f 01             	lea    0x1(%edi),%ecx
  30:	85 ff                	test   %edi,%edi
  32:	7e 1c                	jle    50 <lockref_get_or_lock+0x50>
  34:	f0 0f c7 0e          	lock cmpxchg8b (%esi)
  38:	75 36                	jne    70 <lockref_get_or_lock+0x70>

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
v2:
 - select ARCH_USE_CMPXCHG_LOCKREF for CONFIG_X86_CMPXCHG which
   is unconditionally defined for X86_64
---
 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index be0b95e51df6..22555e0c894d 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -27,7 +27,6 @@ config X86_64
 	# Options that are inherently 64-bit kernel only:
 	select ARCH_HAS_GIGANTIC_PAGE
 	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
-	select ARCH_USE_CMPXCHG_LOCKREF
 	select HAVE_ARCH_SOFT_DIRTY
 	select MODULES_USE_ELF_RELA
 	select NEED_DMA_MAP_STATE
@@ -111,6 +110,7 @@ config X86
 	select ARCH_SUPPORTS_LTO_CLANG
 	select ARCH_SUPPORTS_LTO_CLANG_THIN
 	select ARCH_USE_BUILTIN_BSWAP
+	select ARCH_USE_CMPXCHG_LOCKREF		if X86_CMPXCHG64
 	select ARCH_USE_MEMTEST
 	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_USE_QUEUED_SPINLOCKS
-- 
2.35.3

