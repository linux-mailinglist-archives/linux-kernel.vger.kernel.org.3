Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22E73533F60
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 16:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243425AbiEYOkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 10:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242155AbiEYOke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 10:40:34 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C4233342
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 07:40:33 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id q21so21928642ejm.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 07:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tR7OctJbspMbqbUoEA7O4BS4I4/S30kEE1/hmftOpxw=;
        b=RZoplJJ0rcL7jIhuAS3OczoyLDETz8NpWSyFEJfaDebAgMx4KBobCHuvtbGamUy5H1
         2pq/bwDu4PyMCFl50HHBaDo5Jhn+whzqrgm0KUTAFJqI1EFXXk04Jy1cYJvgU10Aiq8m
         TbQLvvpltnL5y6H4Iy18yFG54qPvN4a+t80mnCuggbuFHsuIP803d64P2N0C9aLaZ7tJ
         N7N+9yKzN2yDlQ8/40R2vj5ngNh2EnCuCUuApjyGCoMo7bYEUmXVxUnmHq4HzqdlckFF
         QJYAN8Ec8bY4zT1mCh37DEMMOmr6CPb4RoHDx5Q7lAx+fKi9X/+aeOVEuzyB7SAMPY12
         VH6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tR7OctJbspMbqbUoEA7O4BS4I4/S30kEE1/hmftOpxw=;
        b=BCOsBchtV1LZ6a93dLEDDzIvcrfmTc5LolIzTgktKVtA5SZM7IbOFSxpR/a2jn1VB9
         IA4Yo+QGnf4zxjNoWCuKnkeLlSDNK5+OefhJt/GTAEpGJIn8hl80dnchgeB+UP9YP/zq
         RfzlaN3YL+X+7MGZ51lQgr+cYRiMJR1O8GECpAcRO44DOhChZn5x4d44MdJ0rAMzrvvK
         vDtFLXGcGTNBBiuQCgfrPBTCvdnQxu8xfRYNZCZm0VXQ/WaqZZpRzHNBM/L9fGFFxpYA
         E2CXJSEqbxKxEwSsDXrbbfSfdc2qNxtiVCTTm5v2crWmdRByyo5oee5k3bHQYJKk1iEY
         7/VQ==
X-Gm-Message-State: AOAM531BPjnmKi4lkmmb6C2ygVoNsOvHwlaOjUL2phxCSGixsRzpbsoV
        NVAmsgfumCqAL6+1iw5ccvw=
X-Google-Smtp-Source: ABdhPJw96I+UOUQX69+tAG0FsXoVK05GiSIDimSLmEKUHQ+2XTGoJEbTjEHBTCbLrLx6FcdkE7j6zg==
X-Received: by 2002:a17:907:72c4:b0:6f4:ad52:b9fd with SMTP id du4-20020a17090772c400b006f4ad52b9fdmr29432993ejc.128.1653489632353;
        Wed, 25 May 2022 07:40:32 -0700 (PDT)
Received: from localhost.localdomain (93-103-18-160.static.t-2.net. [93.103.18.160])
        by smtp.gmail.com with ESMTPSA id 4-20020a170906224400b006f3ef214da7sm8288262ejr.13.2022.05.25.07.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 07:40:31 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, Waiman.Long@hp.com,
        paulmck@linux.vnet.ibm.com
Subject: [PATCH 2/2] locking/lockref/x86: Enable ARCH_USE_CMPXCHG_LOCKREF for X86_32 && X86_CMPXCHG64
Date:   Wed, 25 May 2022 16:40:13 +0200
Message-Id: <20220525144013.6481-3-ubizjak@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220525144013.6481-1-ubizjak@gmail.com>
References: <20220525144013.6481-1-ubizjak@gmail.com>
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
for this purpose. Also, by using try_cmpxchg64() instead of cmpxchg()
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
Cc: Waiman.Long@hp.com
Cc: paulmck@linux.vnet.ibm.com
---
 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 762a0b6ab8b6..326cfdc4f136 100644
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
+	select ARCH_USE_CMPXCHG_LOCKREF	if X86_64 || (X86_32 && X86_CMPXCHG64)
 	select ARCH_USE_MEMTEST
 	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_USE_QUEUED_SPINLOCKS
-- 
2.35.3

