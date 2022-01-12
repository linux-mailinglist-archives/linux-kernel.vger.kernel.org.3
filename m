Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3716548CD0E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 21:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357620AbiALUXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 15:23:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357605AbiALUXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 15:23:02 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7176C061748
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 12:23:01 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id a1-20020a17090a688100b001b3fd52338eso6095093pjd.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 12:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kyeO5jAOJdChlXYzuArHFJYM20XwVYT6ewBuU6tSnEk=;
        b=iU/HPNlmqwZKQb1EGerVoy9HMT4JRzhQA58pLUj1JB2yD/8TPMS1TcZad/aGIyHZ/I
         peueVi6maGSvxJY/JMUl3CDVK5GVntK6yC9YNxZAzoMbsutxp+cSQww8TI42dbu2ejOP
         nCaka1sP3E6c3TFAKS2RQ6jU7DOnBpUFUE2Vw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kyeO5jAOJdChlXYzuArHFJYM20XwVYT6ewBuU6tSnEk=;
        b=sfAmBQ4NW6TH1zcU1nb8VGbFtOOUh5F/JR36Y46rPzwSxAUBclFbDdglt0wotBL3xW
         z6EKZIttx+RxbO9XGV1xGyCsdt+CVHLjQLL4gLWPTwiArsMjO2EFd5yVn+l79xBtM45i
         V5pFsuMCg6YAldDSZVY+0fUFp4Exp5LVmyyd4zH7PPmrlcTPMsDXdb3KZR7xL/lmq91u
         Sz3a3QiWAZxwSkyPlMisHBX1JO6Oe2nVtgZhIfIGby0VwtHT/UYI58CZEKCeLRrZge/g
         cE/aUz48yttH48U/gHE1RZELPGdzLYn64YqVgAf9TXkD4i1VhjsxLK3qFTE8ZkIuyNry
         KN+w==
X-Gm-Message-State: AOAM5337+jI4v5g3yAW4RXARArstwzNCsvhHlL5HZ8rUHZzB5SOhdQbk
        ntAvXg2/tYOHdt0x0QPsteBrZw==
X-Google-Smtp-Source: ABdhPJyZjdTV0zXe3g3zFlkAMX8/LEfO88nLyAZVfDyT0b2SaHPprLA/iniwsIk7PogBpr+ZJLJaPw==
X-Received: by 2002:aa7:8394:0:b0:4be:ab79:fcfa with SMTP id u20-20020aa78394000000b004beab79fcfamr964541pfm.3.1642018981496;
        Wed, 12 Jan 2022 12:23:01 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p32sm431337pgb.49.2022.01.12.12.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 12:23:01 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v2] arm64: atomics: lse: Dereference matching size
Date:   Wed, 12 Jan 2022 12:22:59 -0800
Message-Id: <20220112202259.3950286-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3442; h=from:subject; bh=oOwW4jx5gA/RGKQRqzif6SbAYCT+soAWNmUjugUOT3Q=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBh3zii9PBOaz2aBemP1Fh4uV3xUdnNVoe/fhkMFASn 7GenXEqJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYd84ogAKCRCJcvTf3G3AJjf0D/ 0ak4X2+4espIyHP4TJxhJvqzKcmq0KaWjrbazHS1CEMseM7st+naGnUA5rL8Nac5xpRu1H4775aW+4 L5cNTC60OQjRw2jtaPqDT1KmnXkowS/M9IHCiysyo7wwraZ3nuFBu04NS9ml6zmQFYIRAi45E9K5MX WJyXuLK9vIJ7p2okyrTFRrVZqWx0J/6jAKD8wmRtvfOKI7rdAX7gVo1Mz6Vn1r8NjRTYOK9eCSNnyq U9OwPBjtwAZ3GGHoLrvgYzq4rHia/ieeIVXtIhwFisEx7FA8EPMFw+S+xG0tE55U0UboLSxrX1CKjA WrYnD3oLHycHNUNeU4vJpW38iPz1sgjdp7tNna26b5aj7BHxfj74+0Pnzh/bI7wS17Ajg1xOlj+ClF 88J9t6a3B9OLPfrpt2/pULrnIVd6ljldIs81LX1uUo1tScnRL7dwRMcUfHvZ1xpbLSgTP5V4lQPpcA GvdlszxX57MWWpclWmJYM9l4PnbPiQGqavWY/CtzCiAUPIEnqtiALBKcEVg0zgfh21YXHdWQGL0VpT octk58wMrCEweFPCqc+CGllKr1h2YdEi9FJ/mbcZEpujNmiUKzhSAVzD8i96GZ3YK6tbuO+KzMGLXj CzfhgWnxJr9/jsT9YIgwof8zQF2flazZyuSOrhLuMlZ2LSrz6a1vwmQZ2BKw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with -Warray-bounds, the following warning is generated:

In file included from ./arch/arm64/include/asm/lse.h:16,
                 from ./arch/arm64/include/asm/cmpxchg.h:14,
                 from ./arch/arm64/include/asm/atomic.h:16,
                 from ./include/linux/atomic.h:7,
                 from ./include/asm-generic/bitops/atomic.h:5,
                 from ./arch/arm64/include/asm/bitops.h:25,
                 from ./include/linux/bitops.h:33,
                 from ./include/linux/kernel.h:22,
                 from kernel/printk/printk.c:22:
./arch/arm64/include/asm/atomic_lse.h:247:9: warning: array subscript 'long unsigned int[0]' is partly outside array bounds of 'atomic_t[1]' [-Warray-bounds]
  247 |         asm volatile(                                                   \
      |         ^~~
./arch/arm64/include/asm/atomic_lse.h:266:1: note: in expansion of macro '__CMPXCHG_CASE'
  266 | __CMPXCHG_CASE(w,  , acq_, 32,  a, "memory")
      | ^~~~~~~~~~~~~~
kernel/printk/printk.c:3606:17: note: while referencing 'printk_cpulock_owner'
 3606 | static atomic_t printk_cpulock_owner = ATOMIC_INIT(-1);
      |                 ^~~~~~~~~~~~~~~~~~~~

This is due to the compiler seeing an unsigned long * cast against
something (atomic_t) that is int sized. Replace the cast with the
matching size cast. This results in no change in binary output.

Note that __ll_sc__cmpxchg_case_##name##sz already uses the same
constraint:

	[v] "+Q" (*(u##sz *)ptr

Which is why only the LSE form needs updating and not the
LL/SC form, so this change is unlikely to be problematic.

Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v1: https://lore.kernel.org/linux-hardening/20220107232746.1540130-1-keescook@chromium.org/
v2:
 - add Acks
 - note the existing LL/SC form
---
 arch/arm64/include/asm/atomic_lse.h | 2 +-
 arch/arm64/include/asm/cmpxchg.h    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/atomic_lse.h b/arch/arm64/include/asm/atomic_lse.h
index d955ade5df7c..5d460f6b7675 100644
--- a/arch/arm64/include/asm/atomic_lse.h
+++ b/arch/arm64/include/asm/atomic_lse.h
@@ -249,7 +249,7 @@ __lse__cmpxchg_case_##name##sz(volatile void *ptr,			\
 	"	mov	%" #w "[tmp], %" #w "[old]\n"			\
 	"	cas" #mb #sfx "\t%" #w "[tmp], %" #w "[new], %[v]\n"	\
 	"	mov	%" #w "[ret], %" #w "[tmp]"			\
-	: [ret] "+r" (x0), [v] "+Q" (*(unsigned long *)ptr),		\
+	: [ret] "+r" (x0), [v] "+Q" (*(u##sz *)ptr),			\
 	  [tmp] "=&r" (tmp)						\
 	: [old] "r" (x1), [new] "r" (x2)				\
 	: cl);								\
diff --git a/arch/arm64/include/asm/cmpxchg.h b/arch/arm64/include/asm/cmpxchg.h
index f9bef42c1411..497acf134d99 100644
--- a/arch/arm64/include/asm/cmpxchg.h
+++ b/arch/arm64/include/asm/cmpxchg.h
@@ -243,7 +243,7 @@ static inline void __cmpwait_case_##sz(volatile void *ptr,		\
 	"	cbnz	%" #w "[tmp], 1f\n"				\
 	"	wfe\n"							\
 	"1:"								\
-	: [tmp] "=&r" (tmp), [v] "+Q" (*(unsigned long *)ptr)		\
+	: [tmp] "=&r" (tmp), [v] "+Q" (*(u##sz *)ptr)			\
 	: [val] "r" (val));						\
 }
 
-- 
2.30.2

