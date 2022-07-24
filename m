Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226C057F505
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 14:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235519AbiGXM0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 08:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234380AbiGXM0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 08:26:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD846401;
        Sun, 24 Jul 2022 05:26:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 810FA61046;
        Sun, 24 Jul 2022 12:26:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97375C3411E;
        Sun, 24 Jul 2022 12:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658665560;
        bh=vUseJCTrNzPDWvyzTJrjmT0HoGBBMBVECney2Q8pItc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dorbQK6XNrwRIg7t7ZoDjG6m5vvSYrrtpTw/55yU3+AxsgATYr6Ri7MgdUm0zQPEE
         MRwIbvU4A56OjXeYzJPBdxKtsQTkSSZxmG9qUfwZRS/MtxORCW1sAU2t2CxkGHyv25
         Xw5w7w/gjSrNLssJt0P/TjtCHjgbnahPe1WF0ieK+nwI9sX+gUGf7DY98+YMnkzNwF
         0jpvst9alrmopa+NUG/KBAfJosWF1wllbjxu61lbDHxg4lBJnG0YXU6lR0xC5jTjtT
         ILdjeEFaDH156aqDSQY1gdfKlmpPhgSMtLHdTjxmAbbWeW720Y3zfZqJZgPi3Yrr+Z
         kOP7cJxaWXnyA==
From:   guoren@kernel.org
To:     palmer@rivosinc.com, heiko@sntech.de, hch@infradead.org,
        arnd@arndb.de, peterz@infradead.org, will@kernel.org,
        boqun.feng@gmail.com, longman@redhat.com, mingo@redhat.com,
        philipp.tomsich@vrull.eu, cmuellner@linux.com,
        linux-kernel@vger.kernel.org, David.Laight@ACULAB.COM
Cc:     linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>, Guo Ren <guoren@kernel.org>
Subject: [PATCH V8 05/10] riscv: Enable ARCH_INLINE_READ*/WRITE*/SPIN*
Date:   Sun, 24 Jul 2022 08:25:12 -0400
Message-Id: <20220724122517.1019187-6-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220724122517.1019187-1-guoren@kernel.org>
References: <20220724122517.1019187-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Enable ARCH_INLINE_READ*/WRITE*/SPIN* when !PREEMPTION, it is copied
from arch/arm64. It could reduce procedure calls and improves
performance.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/Kconfig | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index fcbb81feb7ad..bff04916a6c5 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -32,6 +32,32 @@ config RISCV
 	select ARCH_HAS_STRICT_MODULE_RWX if MMU && !XIP_KERNEL
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
+	select ARCH_INLINE_READ_LOCK if !PREEMPTION
+	select ARCH_INLINE_READ_LOCK_BH if !PREEMPTION
+	select ARCH_INLINE_READ_LOCK_IRQ if !PREEMPTION
+	select ARCH_INLINE_READ_LOCK_IRQSAVE if !PREEMPTION
+	select ARCH_INLINE_READ_UNLOCK if !PREEMPTION
+	select ARCH_INLINE_READ_UNLOCK_BH if !PREEMPTION
+	select ARCH_INLINE_READ_UNLOCK_IRQ if !PREEMPTION
+	select ARCH_INLINE_READ_UNLOCK_IRQRESTORE if !PREEMPTION
+	select ARCH_INLINE_WRITE_LOCK if !PREEMPTION
+	select ARCH_INLINE_WRITE_LOCK_BH if !PREEMPTION
+	select ARCH_INLINE_WRITE_LOCK_IRQ if !PREEMPTION
+	select ARCH_INLINE_WRITE_LOCK_IRQSAVE if !PREEMPTION
+	select ARCH_INLINE_WRITE_UNLOCK if !PREEMPTION
+	select ARCH_INLINE_WRITE_UNLOCK_BH if !PREEMPTION
+	select ARCH_INLINE_WRITE_UNLOCK_IRQ if !PREEMPTION
+	select ARCH_INLINE_WRITE_UNLOCK_IRQRESTORE if !PREEMPTION
+	select ARCH_INLINE_SPIN_TRYLOCK if !PREEMPTION
+	select ARCH_INLINE_SPIN_TRYLOCK_BH if !PREEMPTION
+	select ARCH_INLINE_SPIN_LOCK if !PREEMPTION
+	select ARCH_INLINE_SPIN_LOCK_BH if !PREEMPTION
+	select ARCH_INLINE_SPIN_LOCK_IRQ if !PREEMPTION
+	select ARCH_INLINE_SPIN_LOCK_IRQSAVE if !PREEMPTION
+	select ARCH_INLINE_SPIN_UNLOCK if !PREEMPTION
+	select ARCH_INLINE_SPIN_UNLOCK_BH if !PREEMPTION
+	select ARCH_INLINE_SPIN_UNLOCK_IRQ if !PREEMPTION
+	select ARCH_INLINE_SPIN_UNLOCK_IRQRESTORE if !PREEMPTION
 	select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
 	select ARCH_OPTIONAL_KERNEL_RWX_DEFAULT
 	select ARCH_STACKWALK
-- 
2.36.1

