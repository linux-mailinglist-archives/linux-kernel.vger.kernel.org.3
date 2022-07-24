Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7655D57F511
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 14:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235796AbiGXM1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 08:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235778AbiGXM0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 08:26:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B842910573;
        Sun, 24 Jul 2022 05:26:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 65D31B80D6B;
        Sun, 24 Jul 2022 12:26:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C77F7C385A5;
        Sun, 24 Jul 2022 12:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658665590;
        bh=920mmnpEJPScVrA5dKwmyImPh9PCuH+GiFZjlE1o8zI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KOdKpq+E4B/EJi49xbzc27v1TLG7ZtjFILg8aSF7N9+lSnRnEpR7LjSRUSbqeMr5L
         ZQAzxLJ3xxcSfBXGnpPhlbsaOsZUgB2f5Coi0rleUrDhjTQsHtAntM9kz0YHpGH2/x
         8SDZPhVIT9NXdYQ+a5aF0lacSIH7mk/oI/Gs0GFgyQoz+d+WmU59fNUftUET9/CTFl
         07mv1i8TnX854bxdJzBN7waa7YDuL9WjQpSlYSBtjAgMzjl5qvUt7VBbsgSivTjMTs
         AceE9qPAzul9KUiQIBQbEamCnpi8hpkTsb7O7rriYH9Rwui3zWwu81lDWuthAzyX86
         qAB+XEfb3ayyA==
From:   guoren@kernel.org
To:     palmer@rivosinc.com, heiko@sntech.de, hch@infradead.org,
        arnd@arndb.de, peterz@infradead.org, will@kernel.org,
        boqun.feng@gmail.com, longman@redhat.com, mingo@redhat.com,
        philipp.tomsich@vrull.eu, cmuellner@linux.com,
        linux-kernel@vger.kernel.org, David.Laight@ACULAB.COM
Cc:     linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>, Guo Ren <guoren@kernel.org>
Subject: [PATCH V8 10/10] csky: Add qspinlock support
Date:   Sun, 24 Jul 2022 08:25:17 -0400
Message-Id: <20220724122517.1019187-11-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220724122517.1019187-1-guoren@kernel.org>
References: <20220724122517.1019187-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Enable qspinlock by the requirements mentioned in a8ad07e5240c9
("asm-generic: qspinlock: Indicate the use of mixed-size atomics").

C-SKY only has "ldex/stex" for all atomic operations. So csky give a
strong forward guarantee for "ldex/stex." That means when ldex grabbed
the cache line into $L1, it would block other cores from snooping the
address with several cycles.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/csky/Kconfig               | 16 ++++++++++++++++
 arch/csky/include/asm/Kbuild    |  2 ++
 arch/csky/include/asm/cmpxchg.h | 20 ++++++++++++++++++++
 3 files changed, 38 insertions(+)

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index dfdb436b6078..09f7d1f06bca 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -354,6 +354,22 @@ config HAVE_EFFICIENT_UNALIGNED_STRING_OPS
 	  Say Y here to enable EFFICIENT_UNALIGNED_STRING_OPS. Some CPU models could
 	  deal with unaligned access by hardware.
 
+choice
+	prompt "C-SKY spinlock type"
+	default CSKY_TICKET_SPINLOCKS
+
+config CSKY_TICKET_SPINLOCKS
+	bool "Using ticket spinlock"
+
+config CSKY_QUEUED_SPINLOCKS
+	bool "Using queued spinlock"
+	depends on SMP
+	select ARCH_USE_QUEUED_SPINLOCKS
+	help
+	  Make sure your micro arch LL/SC has a strong forward progress guarantee.
+	  Otherwise, stay at ticket-lock/combo-lock.
+endchoice
+
 endmenu
 
 source "arch/csky/Kconfig.platforms"
diff --git a/arch/csky/include/asm/Kbuild b/arch/csky/include/asm/Kbuild
index 103207a58f97..b70b14de904f 100644
--- a/arch/csky/include/asm/Kbuild
+++ b/arch/csky/include/asm/Kbuild
@@ -3,10 +3,12 @@ generic-y += asm-offsets.h
 generic-y += extable.h
 generic-y += gpio.h
 generic-y += kvm_para.h
+generic-y += mcs_spinlock.h
 generic-y += spinlock.h
 generic-y += spinlock_types.h
 generic-y += qrwlock.h
 generic-y += qrwlock_types.h
+generic-y += qspinlock.h
 generic-y += parport.h
 generic-y += user.h
 generic-y += vmlinux.lds.h
diff --git a/arch/csky/include/asm/cmpxchg.h b/arch/csky/include/asm/cmpxchg.h
index 5b8faccd65e4..5f693fadb56c 100644
--- a/arch/csky/include/asm/cmpxchg.h
+++ b/arch/csky/include/asm/cmpxchg.h
@@ -15,6 +15,26 @@ extern void __bad_xchg(void);
 	__typeof__(*(ptr)) __ret;				\
 	unsigned long tmp;					\
 	switch (size) {						\
+	case 2: {						\
+		u32 ret;					\
+		u32 shif = ((ulong)__ptr & 2) ? 16 : 0;		\
+		u32 mask = 0xffff << shif;			\
+		__ptr = (__typeof__(ptr))((ulong)__ptr & ~2);	\
+		__asm__ __volatile__ (				\
+			"1:	ldex.w %0, (%4)\n"		\
+			"	and    %1, %0, %2\n"		\
+			"	or     %1, %1, %3\n"		\
+			"	stex.w %1, (%4)\n"		\
+			"	bez    %1, 1b\n"		\
+			: "=&r" (ret), "=&r" (tmp)		\
+			: "r" (~mask),				\
+			  "r" ((u32)__new << shif),		\
+			  "r" (__ptr)				\
+			: "memory");				\
+		__ret = (__typeof__(*(ptr)))			\
+			((ret & mask) >> shif);			\
+		break;						\
+	}							\
 	case 4:							\
 		asm volatile (					\
 		"1:	ldex.w		%0, (%3) \n"		\
-- 
2.36.1

