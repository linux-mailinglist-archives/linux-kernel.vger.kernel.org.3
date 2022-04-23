Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8E2950CDA8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 23:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237189AbiDWVah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 17:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237153AbiDWVaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 17:30:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41201DA55;
        Sat, 23 Apr 2022 14:27:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3CBDA61035;
        Sat, 23 Apr 2022 21:27:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8C27C385A5;
        Sat, 23 Apr 2022 21:27:14 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="jP703dOn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1650749234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u7QmOUZ1kJbKR+FRT2pxe6Id1kdU7TX+V1BEZer3FMo=;
        b=jP703dOnMmaynOnHQSg2YaabK3vJeNhZS2jao7g2VJkHCL3kTeNDzVsZdYcIvKsc3/DphE
        QXYIlUERXJPfsRGx1Zewmqd/MkrjAul+YHWvCintyz2J/uVQ6AVR4kUxhRqINLBA9NEIYL
        aeluwLJhy5mr0Dhkr3MdDZtHb/9RGaY=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ddde6552 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sat, 23 Apr 2022 21:27:14 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        tglx@linutronix.de, arnd@arndb.de
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>
Subject: [PATCH v6 04/17] alpha: define get_cycles macro for arch-override
Date:   Sat, 23 Apr 2022 23:26:10 +0200
Message-Id: <20220423212623.1957011-5-Jason@zx2c4.com>
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

Alpha defines a get_cycles() function, but it forgot to do the usual
`#define get_cycles get_cycles` dance, making it impossible for generic
code to see if an arch-specific function was defined.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 arch/alpha/include/asm/timex.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/alpha/include/asm/timex.h b/arch/alpha/include/asm/timex.h
index b565cc6f408e..f89798da8a14 100644
--- a/arch/alpha/include/asm/timex.h
+++ b/arch/alpha/include/asm/timex.h
@@ -28,5 +28,6 @@ static inline cycles_t get_cycles (void)
 	__asm__ __volatile__ ("rpcc %0" : "=r"(ret));
 	return ret;
 }
+#define get_cycles get_cycles
 
 #endif
-- 
2.35.1

