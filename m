Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55EC7513F7A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 02:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353553AbiD2AU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 20:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351307AbiD2AUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 20:20:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9B627CF9;
        Thu, 28 Apr 2022 17:17:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A9E74B830A9;
        Fri, 29 Apr 2022 00:17:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCAC8C385AD;
        Fri, 29 Apr 2022 00:17:05 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="i1c9xOsU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1651191423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N6XdKUj5iYJ5RwXtCRVRiwXorABzoye1SBxh5BDCkro=;
        b=i1c9xOsUF+LWwlI4RpyMAD/JNy2GTZMlypd0y4aaVYhgqSJKA9SuCLEn5URQN03fYnXMCK
        kLQzgwp1QbQtPlr2xo7ZxFh1yv2O2PyDtLjpDEGR6XE4HnIJWQIkhTeH7M/gfkQfDcnwu1
        rl9j3RbM+5TxC1rvp1p8UiHyRPgwQhg=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 9e137a29 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 29 Apr 2022 00:17:02 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     Stafford Horne <shorne@gmail.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH v7 11/17] openrisc: account for 0 starting value in random_get_entropy()
Date:   Fri, 29 Apr 2022 02:16:48 +0200
Message-Id: <20220429001648.1671472-1-Jason@zx2c4.com>
In-Reply-To: <20220423212623.1957011-12-Jason@zx2c4.com>
References: <20220423212623.1957011-12-Jason@zx2c4.com>
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

As a sanity check, this series makes sure that during early boot, the
cycle counter isn't returning all zeros. However, OpenRISC's TTCR timer
can be rather slow and starts out as zero during stages of early boot.
We know it works, however. So just always add 1 to random_get_entropy()
so that it doesn't trigger these checks.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Jonas Bonn <jonas@southpole.se>
Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Acked-by: Stafford Horne <shorne@gmail.com>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
Changes v6->v7:
- Add 1 to cycle counter to account for functional but slow-to-begin
  counter on QEMU.

 arch/openrisc/include/asm/timex.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/openrisc/include/asm/timex.h b/arch/openrisc/include/asm/timex.h
index d52b4e536e3f..a78a5807c927 100644
--- a/arch/openrisc/include/asm/timex.h
+++ b/arch/openrisc/include/asm/timex.h
@@ -23,6 +23,9 @@ static inline cycles_t get_cycles(void)
 {
 	return mfspr(SPR_TTCR);
 }
+#define get_cycles get_cycles
+
+#define random_get_entropy() ((unsigned long)get_cycles() + 1)
 
 /* This isn't really used any more */
 #define CLOCK_TICK_RATE 1000
-- 
2.35.1

