Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC0850CDA9
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 23:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237154AbiDWVaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 17:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235494AbiDWVaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 17:30:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA131C931;
        Sat, 23 Apr 2022 14:27:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F35660FFE;
        Sat, 23 Apr 2022 21:27:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7B30C385AB;
        Sat, 23 Apr 2022 21:27:11 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="K4W2tv6i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1650749231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P/YWtrWSKlFYrGP8/ZboFqiFpzBykXNGvMW0a6jPb3Y=;
        b=K4W2tv6iAyL3YHleQy/nkadUrF9oOcZU9gUrIUIUddMMFtFhZOE+5uv7Pkq0kYLfXlq6pI
        OAkD7Po6L3OVtg2M07O+eId42md72YCYS6Jb9humDTpUtvJpUhRPRBr2aymVW2BcRkUSTN
        A2oJYKyKtm5CWrUPOG0wUrGpY3n4lHs=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id cf8eb529 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sat, 23 Apr 2022 21:27:11 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        tglx@linutronix.de, arnd@arndb.de
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Helge Deller <deller@gmx.de>
Subject: [PATCH v6 03/17] parisc: define get_cycles macro for arch-override
Date:   Sat, 23 Apr 2022 23:26:09 +0200
Message-Id: <20220423212623.1957011-4-Jason@zx2c4.com>
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

PA-RISC defines a get_cycles() function, but it forgot to do the usual
`#define get_cycles get_cycles` dance, making it impossible for generic
code to see if an arch-specific function was defined.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Helge Deller <deller@gmx.de>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 arch/parisc/include/asm/timex.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/parisc/include/asm/timex.h b/arch/parisc/include/asm/timex.h
index 06b510f8172e..b4622cb06a75 100644
--- a/arch/parisc/include/asm/timex.h
+++ b/arch/parisc/include/asm/timex.h
@@ -13,9 +13,10 @@
 
 typedef unsigned long cycles_t;
 
-static inline cycles_t get_cycles (void)
+static inline cycles_t get_cycles(void)
 {
 	return mfctl(16);
 }
+#define get_cycles get_cycles
 
 #endif
-- 
2.35.1

