Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34F24C8D9E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 15:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235235AbiCAO0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 09:26:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbiCAO0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 09:26:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3386B0BF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 06:25:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55919614B5
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 14:25:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C7C7C340EE;
        Tue,  1 Mar 2022 14:25:36 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="aUiJBE2P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1646144734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=gkM5iHhxynbNhKrPibaH6Olh8PkRIzYLh5eU8djjz7s=;
        b=aUiJBE2PsPyY7LoGKedLpKFxa8Q0DzNm5AYmhXbjdiPuMF9zy/X+2txrQGyXW+gzd7ddRc
        Luu9f7+cYxGtcnYhK7Mj9dbeFdty9xxPTBgnJn3saDivcqTaoKzBlxnucCoErUT4u51DhX
        yPXrgQrglnL4Cq3fktFalpEhS1cC6mA=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id a6a3dd8f (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 1 Mar 2022 14:25:34 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH] random: do not export add_vmfork_randomness() unless needed
Date:   Tue,  1 Mar 2022 15:25:28 +0100
Message-Id: <20220301142528.243059-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since add_vmfork_randomness() is only called from vmgenid.o, we can
guard it in CONFIG_VMGENID, similarly to how we do with
add_disk_randomness() and CONFIG_BLOCK. If we ever have multiple things
calling into add_vmfork_randomness(), we can add another shared Kconfig
symbol for that, but for now, this is good enough. Even though
add_vmfork_randomess() is a pretty small function, removing it means
that there are only calls to crng_reseed(false) and none to
crng_reseed(true), which means the compiler can constant propagate it
and simply crng_reseed().

Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c  | 2 ++
 include/linux/random.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 99cf9e829d1e..662b7edb3b7a 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1169,6 +1169,7 @@ void add_bootloader_randomness(const void *buf, size_t size)
 }
 EXPORT_SYMBOL_GPL(add_bootloader_randomness);
 
+#ifdef CONFIG_VMGENID
 /*
  * Handle a new unique VM ID, which is unique, not secret, so we
  * don't credit it, but we do immediately force a reseed after so
@@ -1183,6 +1184,7 @@ void add_vmfork_randomness(const void *unique_vm_id, size_t size)
 	}
 }
 EXPORT_SYMBOL_GPL(add_vmfork_randomness);
+#endif
 
 struct fast_pool {
 	union {
diff --git a/include/linux/random.h b/include/linux/random.h
index 117468f3a92e..e6225ac98572 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -34,7 +34,9 @@ extern void add_input_randomness(unsigned int type, unsigned int code,
 extern void add_interrupt_randomness(int irq) __latent_entropy;
 extern void add_hwgenerator_randomness(const void *buffer, size_t count,
 				       size_t entropy);
+#ifdef CONFIG_VMGENID
 extern void add_vmfork_randomness(const void *unique_vm_id, size_t size);
+#endif
 
 extern void get_random_bytes(void *buf, size_t nbytes);
 extern int wait_for_random_bytes(void);
-- 
2.35.1

