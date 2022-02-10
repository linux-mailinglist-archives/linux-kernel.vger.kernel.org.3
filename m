Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 947EF4B125D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 17:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244030AbiBJQJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 11:09:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244023AbiBJQJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 11:09:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC21C30
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 08:09:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5F830B82654
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 16:09:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CA86C004E1;
        Thu, 10 Feb 2022 16:09:36 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="QgM6gCJh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644509375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zpqY/Mn2vcIljnoiofyjjpZnDgag2vvr8ReZa3aKGBs=;
        b=QgM6gCJhdBI4WnrrR04b6ZAXLyZZF/pD9pC3R2JSZs2Q2nSTB8avTnq7v+gMVm5XTOag0v
        GR2ESaof2CzFOh3VH04kZT1UBXmwwzmoqKRnjd6q+i8e/2RF/LjussL7jrggUQExe9riuD
        z0zkcPN1v5JpAKZYT7vPvqXgnVmJuaU=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 407fb4d0 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 10 Feb 2022 16:09:34 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux@dominikbrodowski.net, linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH 1/2] random: move fast_pool/fast_mix definitions to site of use
Date:   Thu, 10 Feb 2022 17:09:24 +0100
Message-Id: <20220210160925.156697-2-Jason@zx2c4.com>
In-Reply-To: <20220210160925.156697-1-Jason@zx2c4.com>
References: <20220210160925.156697-1-Jason@zx2c4.com>
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

No actual code changes, just code position changes. Having to scroll up
and down by several hundred lines every time is confusing and hard to
follow. Instead cluster these together. Later when we're redocumenting
the file, it'll mean a smaller delta.

Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 101 +++++++++++++++++++++---------------------
 1 file changed, 51 insertions(+), 50 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 77131f7b0f06..923a8f861437 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -281,45 +281,6 @@ static void mix_pool_bytes(const void *in, size_t nbytes)
 	spin_unlock_irqrestore(&input_pool.lock, flags);
 }
 
-struct fast_pool {
-	struct work_struct mix;
-	unsigned long last;
-	u32 pool[4];
-	unsigned int count;
-	u16 reg_idx;
-};
-#define FAST_POOL_MIX_INFLIGHT (1U << 31)
-
-/*
- * This is a fast mixing routine used by the interrupt randomness
- * collector.  It's hardcoded for an 128 bit pool and assumes that any
- * locks that might be needed are taken by the caller.
- */
-static void fast_mix(struct fast_pool *f)
-{
-	u32 a = f->pool[0],	b = f->pool[1];
-	u32 c = f->pool[2],	d = f->pool[3];
-
-	a += b;			c += d;
-	b = rol32(b, 6);	d = rol32(d, 27);
-	d ^= a;			b ^= c;
-
-	a += b;			c += d;
-	b = rol32(b, 16);	d = rol32(d, 14);
-	d ^= a;			b ^= c;
-
-	a += b;			c += d;
-	b = rol32(b, 6);	d = rol32(d, 27);
-	d ^= a;			b ^= c;
-
-	a += b;			c += d;
-	b = rol32(b, 16);	d = rol32(d, 14);
-	d ^= a;			b ^= c;
-
-	f->pool[0] = a;  f->pool[1] = b;
-	f->pool[2] = c;  f->pool[3] = d;
-}
-
 static void process_random_ready_list(void)
 {
 	unsigned long flags;
@@ -758,6 +719,57 @@ void add_input_randomness(unsigned int type, unsigned int code,
 }
 EXPORT_SYMBOL_GPL(add_input_randomness);
 
+#ifdef CONFIG_BLOCK
+void add_disk_randomness(struct gendisk *disk)
+{
+	if (!disk || !disk->random)
+		return;
+	/* first major is 1, so we get >= 0x200 here */
+	add_timer_randomness(disk->random, 0x100 + disk_devt(disk));
+}
+EXPORT_SYMBOL_GPL(add_disk_randomness);
+#endif
+
+struct fast_pool {
+	struct work_struct mix;
+	unsigned long last;
+	u32 pool[4];
+	unsigned int count;
+	u16 reg_idx;
+};
+#define FAST_POOL_MIX_INFLIGHT (1U << 31)
+
+/*
+ * This is a fast mixing routine used by the interrupt randomness
+ * collector. It's hardcoded for an 128 bit pool and assumes that any
+ * locks that might be needed are taken by the caller.
+ */
+static void fast_mix(struct fast_pool *f)
+{
+	u32 a = f->pool[0],	b = f->pool[1];
+	u32 c = f->pool[2],	d = f->pool[3];
+
+	a += b;			c += d;
+	b = rol32(b, 6);	d = rol32(d, 27);
+	d ^= a;			b ^= c;
+
+	a += b;			c += d;
+	b = rol32(b, 16);	d = rol32(d, 14);
+	d ^= a;			b ^= c;
+
+	a += b;			c += d;
+	b = rol32(b, 6);	d = rol32(d, 27);
+	d ^= a;			b ^= c;
+
+	a += b;			c += d;
+	b = rol32(b, 16);	d = rol32(d, 14);
+	d ^= a;			b ^= c;
+
+	f->pool[0] = a;  f->pool[1] = b;
+	f->pool[2] = c;  f->pool[3] = d;
+}
+
+
 static DEFINE_PER_CPU(struct fast_pool, irq_randomness);
 
 static u32 get_reg(struct fast_pool *f, struct pt_regs *regs)
@@ -849,17 +861,6 @@ void add_interrupt_randomness(int irq)
 }
 EXPORT_SYMBOL_GPL(add_interrupt_randomness);
 
-#ifdef CONFIG_BLOCK
-void add_disk_randomness(struct gendisk *disk)
-{
-	if (!disk || !disk->random)
-		return;
-	/* first major is 1, so we get >= 0x200 here */
-	add_timer_randomness(disk->random, 0x100 + disk_devt(disk));
-}
-EXPORT_SYMBOL_GPL(add_disk_randomness);
-#endif
-
 /*********************************************************************
  *
  * Entropy extraction routines
-- 
2.35.0

