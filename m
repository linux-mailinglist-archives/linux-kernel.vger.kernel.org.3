Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C628471733
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 23:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbhLKWhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 17:37:18 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55920 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbhLKWhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 17:37:17 -0500
Date:   Sat, 11 Dec 2021 22:37:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639262235;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zaPE4ANCH7FWqn4qy0ahNiG+vNb6aYB3vSzNw38++7c=;
        b=ipLaf5w+E18UCzfLYEHtKAdM62w86YksNbOgddd7j1N82OIfS7q5SBj98oOzMYR0C9F7vU
        9BqaJaD2nh7Lp22XDsoF8Sp+kXOj+TqoG/Q8G/UsVBxkd08jrWcNPDjE+g79K9YeyPn4Rj
        zgQcZhTv9fG/0zES/YzkhE9aJPm15EtYKJvBHa9Wzn2LXshPWdLLPpI4+P3rNgdRtcs2pw
        Ye3E9ruh3ag3OlXjAFcW8SluDUEn3hQeuojNKc+DVXDR6RdhCDrTTHjtAdwylrQWhCCATs
        NswTBS+XPlg0QK7wpsOwdxQFyrumrqdWN9NUXsws7kMTJltsu1RO7gC6oAdivQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639262235;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zaPE4ANCH7FWqn4qy0ahNiG+vNb6aYB3vSzNw38++7c=;
        b=Nyy8jC6JMd9jqMKSm0R1lKGqydnJByjKmsProo5El/GVIX+nJNAIOLsVwi9eJ14fCBnJ8j
        H9BJcD/xqRgcyVDA==
From:   "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] futex: Fix additional regressions
Cc:     Linux Kernel Functional Testing <lkft@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211203080823.2938839-1-arnd@kernel.org>
References: <20211203080823.2938839-1-arnd@kernel.org>
MIME-Version: 1.0
Message-ID: <163926223448.23020.4149362435419457461.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     0f09c274698590d508c43f924d9dffc7130b782d
Gitweb:        https://git.kernel.org/tip/0f09c274698590d508c43f924d9dffc7130b782d
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Fri, 03 Dec 2021 09:07:56 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 11 Dec 2021 23:31:51 +01:00

futex: Fix additional regressions

Naresh reported another architecture that was broken by the same typo that
was already fixed for three architectures: mips also refers to the
futex_atomic_op_inuser_local() function by the wrong name and runs into a
missing closing '}' as well.

Going through the source tree the same typo was found in the documentation
as well as in the xtensa code, both of which ended up escaping the
regression testing so far. In the case of xtensa, it appears that the
broken code path is only used when building for platforms that are not
supported by the default gcc configuration, so they are impossible to test
for with default setups.

After going through these more carefully and fixing up the typos, all
architectures have been build-tested again to ensure that this is now
complete.

Fixes: 4e0d84634445 ("futex: Fix sparc32/m68k/nds32 build regression")
Fixes: 3f2bedabb62c ("futex: Ensure futex_atomic_cmpxchg_inatomic() is present")
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20211203080823.2938839-1-arnd@kernel.org
---
 arch/mips/include/asm/futex.h   | 6 +++---
 arch/xtensa/include/asm/futex.h | 2 +-
 include/asm-generic/futex.h     | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/mips/include/asm/futex.h b/arch/mips/include/asm/futex.h
index 9287110..8612a7e 100644
--- a/arch/mips/include/asm/futex.h
+++ b/arch/mips/include/asm/futex.h
@@ -86,9 +86,9 @@
 		: "memory");						\
 	} else {							\
 		/* fallback for non-SMP */				\
-		ret = arch_futex_atomic_op_inuser_local(op, oparg, oval,\
-							uaddr);	\
-	}
+		ret = futex_atomic_op_inuser_local(op, oparg, oval, uaddr);	\
+	}								\
+}
 
 static inline int
 arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
diff --git a/arch/xtensa/include/asm/futex.h b/arch/xtensa/include/asm/futex.h
index fe8f315..a6f7d7a 100644
--- a/arch/xtensa/include/asm/futex.h
+++ b/arch/xtensa/include/asm/futex.h
@@ -109,7 +109,7 @@ static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
 
 	return ret;
 #else
-	return arch_futex_atomic_op_inuser_local(op, oparg, oval, uaddr);
+	return futex_atomic_op_inuser_local(op, oparg, oval, uaddr);
 #endif
 }
 
diff --git a/include/asm-generic/futex.h b/include/asm-generic/futex.h
index 66d6843..2a19215 100644
--- a/include/asm-generic/futex.h
+++ b/include/asm-generic/futex.h
@@ -21,7 +21,7 @@
 #endif
 
 /**
- * arch_futex_atomic_op_inuser_local() - Atomic arithmetic operation with constant
+ * futex_atomic_op_inuser_local() - Atomic arithmetic operation with constant
  *			  argument and comparison of the previous
  *			  futex value with another constant.
  *
