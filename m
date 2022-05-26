Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 764255353A5
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 20:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348535AbiEZSzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 14:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348652AbiEZSzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 14:55:35 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43019DE307
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 11:55:30 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id t5so2882367edc.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 11:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RRDgXcTy3sRijo/6Cj3EIWOrdOUTZxQ9iUE40zIwF5Y=;
        b=myskOeeYUV5tH0W3pTOS182i92Rz6Mea2Rx0Y1TC+14z4SyW2S4zaH9uLwvpi+C7GS
         p+UfOEYmmeerBnPBR+bgtxK076YTjyMIEo3zAcVYfkPYKplsykdCQb+EaGGD7BSFETW8
         GSPd+8EHTKpLkJXlrEOwVUjfN/dMs/SnbT1mHZUo4mBa++kdpcNr5w57Rw8SDSpnSkeZ
         7Gd6Yqz8+ZbmGJkUf4RSI4GhmhK/WirSgPm2JBS1QSVZdDmXPcQpL6LkieeU6y7LNFVC
         h5VKbIRmq2vKaTvsh7NsFnFxil4+oahmD+nS0QTGwip+cc72oPsYdXhu/oVyR0wYPFvJ
         0V9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RRDgXcTy3sRijo/6Cj3EIWOrdOUTZxQ9iUE40zIwF5Y=;
        b=fU2RqAghgTl3mZNIY3UUv14H1MkPpq8h5lxrrmd9CmS/lhy31rGyGQA51cBRN1+zJJ
         xyv4H8bJp3Ty6OPjy+lS0suhH0YY3heWJqoVytJCwxaUe4ut981cIbJaW2SSAIcB++Ff
         Nc9SCNgoDhS+oZa3cFdjH7vkjtKu0X5REKtT5bi513+UYHqE5CSil45x6KhgYIw/fiqh
         ZejD3fIP9IPqLOQFaeUdvfndgCgiLVBTFxQTHpUmnFx4gdssOtDFU95Tu6l1gMdYw7gl
         K97+tGca3UeAUxCmE7iLqxqRqkfhmYhOqo4E1ee0teYcs+2Hbt45D46dy8N15lj51zuk
         NbNw==
X-Gm-Message-State: AOAM5322k1kOEA09L5fkvDNoVIK7ByjnoZQlYllgnDrCsapoXHquS73a
        UhbYEO9YtibAlZafHq5YzyI=
X-Google-Smtp-Source: ABdhPJwq/m8oGHmbY30OQtqpIZBDBVA8dWCs7Tw0XNUvUWVcTv1u/C1hOnihtN2+BXyeluIyeDhxHg==
X-Received: by 2002:a05:6402:3594:b0:42b:65dd:489 with SMTP id y20-20020a056402359400b0042b65dd0489mr23698268edc.222.1653591328713;
        Thu, 26 May 2022 11:55:28 -0700 (PDT)
Received: from localhost.localdomain (93-103-18-160.static.t-2.net. [93.103.18.160])
        by smtp.gmail.com with ESMTPSA id yr16-20020a170907335000b006f3ef214e42sm733860ejb.168.2022.05.26.11.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 11:55:27 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2] locking/lockref/x86: Enable ARCH_USE_CMPXCHG_LOCKREF for X86_CMPXCHG64
Date:   Thu, 26 May 2022 20:54:30 +0200
Message-Id: <20220526185430.59120-1-ubizjak@gmail.com>
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
---
v2:
 - select ARCH_USE_CMPXCHG_LOCKREF for CONFIG_X86_CMPXCHG which
   is unconditionally defined for X86_64
---
 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 6f59517c4356..cfc42f370419 100644
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

