Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F4C50CD9C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 23:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237129AbiDWVaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 17:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237116AbiDWVaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 17:30:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DA11D320;
        Sat, 23 Apr 2022 14:27:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC47C60FD6;
        Sat, 23 Apr 2022 21:27:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA9DDC385B1;
        Sat, 23 Apr 2022 21:27:09 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="neZM7woj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1650749225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aLnH9LfNsXw8wnO3OV8d9NzfRRH/27wi66m+Mfcg6bE=;
        b=neZM7wojbPocSxxW9ePwx+8ckM3cZBd2kXkC75pofXty4huWgO6u1+GvhmZZpdD1+4WSi/
        xJwd76y+kiSznfLfnQWBxkEzKCT9t7vmKX7ZcGPsk66ob1Er5AYwAfnAOlSHmbhv0Mq18w
        Wx7NwYsLLtAHXkYtdm+k4R1kb4tr1QY=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d56cf015 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sat, 23 Apr 2022 21:27:05 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        tglx@linutronix.de, arnd@arndb.de
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH v6 01/17] ia64: define get_cycles macro for arch-override
Date:   Sat, 23 Apr 2022 23:26:07 +0200
Message-Id: <20220423212623.1957011-2-Jason@zx2c4.com>
In-Reply-To: <20220423212623.1957011-1-Jason@zx2c4.com>
References: <20220423212623.1957011-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Itanium defines a get_cycles() function, but it forgot to do the usual
`#define get_cycles get_cycles` dance, making it impossible for generic
code to see if an arch-specific function was defined.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 arch/ia64/include/asm/timex.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/ia64/include/asm/timex.h b/arch/ia64/include/asm/timex.h
index 869a3ac6bf23..7ccc077a60be 100644
--- a/arch/ia64/include/asm/timex.h
+++ b/arch/ia64/include/asm/timex.h
@@ -39,6 +39,7 @@ get_cycles (void)
 	ret = ia64_getreg(_IA64_REG_AR_ITC);
 	return ret;
 }
+#define get_cycles get_cycles
 
 extern void ia64_cpu_local_tick (void);
 extern unsigned long long ia64_native_sched_clock (void);
-- 
2.35.1

