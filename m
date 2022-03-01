Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 992E54C9834
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 23:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237420AbiCAWPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 17:15:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbiCAWPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 17:15:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE893F33B
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 14:14:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 98CBAB81E64
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 22:14:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7327C340EF;
        Tue,  1 Mar 2022 22:14:30 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="IK9JRuUj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1646172869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=602NM2Gyd3H/qEINInMY72uMMsFmmO/PYVoztZoz+ps=;
        b=IK9JRuUjNdxdFA6WCIO0+R3aefeCnCyyiJo2HTS7GhGtmLIxwU9DO7H/YwOsAdpKeL6+OO
        WAarYzERb7tTf7jKIFACAeXWyYifRgG1rhhxB/pwg4K+nFqEFMsdqphjR4IHHQks7OoIKq
        WQ/225cgZTniX0N97IeeTXrKmI9Qj1E=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b06919f5 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 1 Mar 2022 22:14:28 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH v2] random: do not export add_vmfork_randomness() unless needed
Date:   Tue,  1 Mar 2022 23:14:25 +0100
Message-Id: <20220301221425.411217-1-Jason@zx2c4.com>
In-Reply-To: <CAHmME9rdm0gQ0ZA4-7tTvNwd5a+TYRaPjWbcO3Rm5VoyLZbNnw@mail.gmail.com>
References: <CAHmME9rdm0gQ0ZA4-7tTvNwd5a+TYRaPjWbcO3Rm5VoyLZbNnw@mail.gmail.com>
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
crng_reseed(true), which means the compiler can constant propagate the
false, removing branches from crng_reseed() and its descendants.

Additionally, we don't even need the symbol to be exported if
CONFIG_VMGENID is not a module, so conditionalize that too.

Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
Changes v1->v2:
- [Ted] Do not export symbol if we're a built-in.

 drivers/char/random.c  | 4 ++++
 include/linux/random.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 99cf9e829d1e..fe477a12c1ad 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1169,6 +1169,7 @@ void add_bootloader_randomness(const void *buf, size_t size)
 }
 EXPORT_SYMBOL_GPL(add_bootloader_randomness);
 
+#if IS_ENABLED(CONFIG_VMGENID)
 /*
  * Handle a new unique VM ID, which is unique, not secret, so we
  * don't credit it, but we do immediately force a reseed after so
@@ -1182,7 +1183,10 @@ void add_vmfork_randomness(const void *unique_vm_id, size_t size)
 		pr_notice("crng reseeded due to virtual machine fork\n");
 	}
 }
+#if IS_MODULE(CONFIG_VMGENID)
 EXPORT_SYMBOL_GPL(add_vmfork_randomness);
+#endif
+#endif
 
 struct fast_pool {
 	union {
diff --git a/include/linux/random.h b/include/linux/random.h
index 117468f3a92e..f209f1a78899 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -34,7 +34,9 @@ extern void add_input_randomness(unsigned int type, unsigned int code,
 extern void add_interrupt_randomness(int irq) __latent_entropy;
 extern void add_hwgenerator_randomness(const void *buffer, size_t count,
 				       size_t entropy);
+#if IS_ENABLED(CONFIG_VMGENID)
 extern void add_vmfork_randomness(const void *unique_vm_id, size_t size);
+#endif
 
 extern void get_random_bytes(void *buf, size_t nbytes);
 extern int wait_for_random_bytes(void);
-- 
2.35.1

