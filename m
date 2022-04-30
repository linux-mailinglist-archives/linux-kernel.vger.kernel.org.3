Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF4805160D4
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 00:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233928AbiD3WqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 18:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiD3WqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 18:46:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060CF43EFD;
        Sat, 30 Apr 2022 15:42:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1DC1661142;
        Sat, 30 Apr 2022 22:42:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11BC6C385AA;
        Sat, 30 Apr 2022 22:42:44 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="LfZnTRHj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1651358563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aDcxIFbtY1JJMfSvV/JygJMQbDBb6C5R9pMDQBmuC0Q=;
        b=LfZnTRHjVJYWeGWGXRaQmJ91JVdTwQUg+2GGkL+CtIMnxu3F5totH7E1UQTMPUsf7sVPu2
        7xs6ABX4fKEJ6sgE0HqZcQacVxYw7n9+Pgi5HQXxin8AICsVMxg/rKozBkiZ3fa3vgH6Y/
        jpbzmsLknh3YiqlBtez3inRV73uZ8QQ=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 4f9b3ca1 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sat, 30 Apr 2022 22:42:42 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        openrisc@lists.librecores.org, Stafford Horne <shorne@gmail.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH v9 06/21] openrisc: start CPU timer early in boot
Date:   Sun,  1 May 2022 00:42:40 +0200
Message-Id: <20220430224240.3157636-1-Jason@zx2c4.com>
In-Reply-To: <CAHmME9r-=ShRomP=Nrcz-GjP4kv4e9wKHvNdAMiRui7_FSbH-A@mail.gmail.com>
References: <CAHmME9r-=ShRomP=Nrcz-GjP4kv4e9wKHvNdAMiRui7_FSbH-A@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to measure the boot process, the timer should be switched on as
early in boot as possible. This is necessary so that by the time the
setup code reaches random_init(), get_cycles() (by way of
random_get_entropy()) returns non-zero, indicating that it is actually
capable of counting. So this commit enables the timer immediately upon
booting up. As well, the commit define the get_cycles macro, like the
previous patches in this series, so that generic code is aware that it's
implemented by the platform, as is done on other archs.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Jonas Bonn <jonas@southpole.se>
Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Acked-by: Stafford Horne <shorne@gmail.com>
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
Changes v8->v9:
- Use Stafford's suggested assembly in head.S instead of doing this
  later on in C, so that the cycle counter starts very early and thus
  "measures" boot.

 arch/openrisc/include/asm/timex.h | 1 +
 arch/openrisc/kernel/head.S       | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/arch/openrisc/include/asm/timex.h b/arch/openrisc/include/asm/timex.h
index d52b4e536e3f..5487fa93dd9b 100644
--- a/arch/openrisc/include/asm/timex.h
+++ b/arch/openrisc/include/asm/timex.h
@@ -23,6 +23,7 @@ static inline cycles_t get_cycles(void)
 {
 	return mfspr(SPR_TTCR);
 }
+#define get_cycles get_cycles
 
 /* This isn't really used any more */
 #define CLOCK_TICK_RATE 1000
diff --git a/arch/openrisc/kernel/head.S b/arch/openrisc/kernel/head.S
index 15f1b38dfe03..871f4c858859 100644
--- a/arch/openrisc/kernel/head.S
+++ b/arch/openrisc/kernel/head.S
@@ -521,6 +521,15 @@ _start:
 	l.ori	r3,r0,0x1
 	l.mtspr	r0,r3,SPR_SR
 
+	/*
+	 * Start the TTCR as early as possible, so that the RNG can make use of
+	 * measurements of boot time from the earliest opportunity. Especially
+	 * important is that the TTCR does not return zero by the time we reach
+	 * rand_initialize().
+	 */
+	l.movhi r3,hi(SPR_TTMR_CR)
+	l.mtspr r0,r3,SPR_TTMR
+
 	CLEAR_GPR(r1)
 	CLEAR_GPR(r2)
 	CLEAR_GPR(r3)
-- 
2.35.1

